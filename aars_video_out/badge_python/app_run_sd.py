#!/usr/bin/env python3
"""This script uploads files to the Open AARS boot application directory"""

# This program places the files in the project with the suffix '.py' onto the application SD card
# Also the complete subdirectories are coppied that have the __init__.py file in them

import os
import sys
import argparse
import time
import serial

# Parse the command line arguments
PARSER = argparse.ArgumentParser(description='Run Python code on the SHA badge.')

PARSER.add_argument('--tty',
                    type=str,
                    default='/dev/ttyUSB0', help='The TTY the badge is connected to')
PARSER.add_argument('--bps',
                    type=int,
                    default=115200,
                    help='The amount of bits per second')
PARSER.add_argument('--path',
                    type=str,
                    default='./',
                    nargs=1,
                    help='Python file to run')
PARSER.add_argument('--module',
                    type=str,
                    default='openaars',
                    help='The modele in /sd/apps/<module> to write to')
PARSER.add_argument('--del',
                    type=bool,
                    default=True,
                    help='Delete old module directory, before uploading new.')
PARSER.add_argument('--reboot',
                    type=bool,
                    default=False,
                    help='Use system.reboot() instead of system.home()')

ARGS = PARSER.parse_args()

# Defining defaults
MODULE_PATH = "/sd/apps/" + str(ARGS.module)

UPLOAD_SCRIPT = '''
import sys

def recv_file(file_name: str, import_size: int):
    try:
        uos.remove(file_name)
    except:
        print("New file: " + file_name)

    # Capture the input
    file_cont = sys.stdin.read(import_size)

    # Write out the uploaded script
    outFile = open(file_name, "wb")
    outFile.write(file_cont)
    outFile.flush()
    outFile.close()
'''

# Functions


# Get Python file
def get_python_files(path: str):
    """Get all the Python files in a given path."""
    out_list = []
    for name in os.listdir(path):
        if name.endswith('.py') and name != 'app_run_sd.py':
            out_list.append(name)
    return out_list


# Open the serial port
def open_serial(tty: str, bps: int, timeout: int):
    """Open the serial connection, and return a serial socket object."""
    try:
        tty = serial.Serial(tty, bps, timeout=timeout)
    except serial.SerialException as exp:
        print("Count not open serial port: " + tty)
        print(exp)
        sys.exit(1)
    return tty


# Upload a script to the volatile memory
def upload_to_mem(tty, cont: bytes):
    """Upload a script to the volatile memory"""
    # Write CTRL+E
    out = b'\x05'
    tty.write(out)

    # Make sure byte is sent before the source code is pushed
    tty.flush()

    # Send the file to the batch
    bytes_out = tty.write(str.encode(cont))

    # Write CTRL+D
    out = b'\x04'
    tty.write(out)

    # Flush the connection, to make sure all is sent
    tty.flush()

    return bytes_out


# Send Command
def send_command(tty, command: str):
    """Send a single line Python command to the esp32"""
    # Convert string to bytes
    com_bytes = bytes(command + "\r\n", encoding="ascii")

    # Invoke the script
    tty.write(com_bytes)
    tty.flush()


def upload_file(tty, src: str, dest: str):
    """Place a file on the esp32 filesystem (or the SD card)"""
    # Get the file size
    src_size = os.path.getsize(src)

    com_line = "recv_file(\"" + dest + "\", " + str(src_size) + ")"

    send_command(tty, com_line)

    # Push the file
    src_desc = open(src, "rb")
    src_cont = src_desc.read()
    out_num = tty.write(src_cont)
    tty.flush()
    src_desc.close()

    # return bytes pushed
    return out_num


def reboot(tty):
    """Reboot the esp32 uPython firmware"""
    # Reset
    command = "system.reboot()"
    send_command(tty, command)


def restart(tty):
    """Restart the bootsequence of the esp32"""
    # Restart the startup sequence
    command = "system.home()"
    send_command(tty, command)


# Make a directory on the esp32
def mk_dir(tty, path):
    """Make a directory on the esp32 device"""
    command = "uos.rmdir(\"" + path + "\")"
    send_command(tty, command)
    command = "uos.mkdir(\"" + path + "\")"
    send_command(tty, command)


# Main

# Open port
SER = open_serial(ARGS.tty, ARGS.bps, 5)

# Setup the upload script
upload_to_mem(SER, UPLOAD_SCRIPT)

# Create the module path
mk_dir(SER, MODULE_PATH)

# Get the python files, and upload them
SOURCES = get_python_files('.')
for source in SOURCES:
    src_path = source
    dest_path = MODULE_PATH + "/" + source
    print("Uploading: " + src_path + " to: " + dest_path)
    upload_file(SER, src_path, dest_path)
    time.sleep(1)

print("Rebooting!")
if ARGS.reboot:
    reboot(SER)
else:
    restart(SER)

print("done!")
