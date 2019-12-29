# Introduction

These Xilinx Vivado projects are test programs to verify the functioning of the different I/O functions of the Open AARS (Adaptive Amiga retro system) IO expansion board.
Because the board is designed from scratch both the design and fabrication of the board needs to be checked, with simple easy to debug programs.

# Open AARS board repository

The Open AARS board repository can be found at : [QMTech Minimig board repo](https://github.com/ranzbak/qmtech_minimig)

# Different tests

## hello_aars

A simple project that shows a binary counter on the I/O board, proving that at least something works.

## aars_floppy

Checking if the logical level shifters work correctly, this test supports input and output tests.
By pressing the 'SW2' switch on the core board, the test program can be switched from input to output mode.

### Input mode

**Be aware that on the floppy drive connector, a 12V pin is present, 12V will destroy the level shifter and possibly the FPGA, disable (JP1) the 12V supply before testing!**

The red LED D3 is lit on the I/O board.

When a pin on the connector is pulled to ground, one of the LED's on the I/O board light up.
Because there are more ports to the floppy drive interface than LED's, the last ports are all '&' together, so if one of them is pulled to ground, the last LED lights up.

## Output mode

The red LED D3 is not lit on the I/O board.

This mode blinks all the LEDS on the I/O board, all the I/O pins on the board are switched at the same time.

## aars_spi

Work in progress

## ds_sound

A pretty simple test program, that produces a audable tone on the headphone jack.
Load the program and test if a sound is audable.

## joystick_aars

This program tests the Joystick I/O ports, if all connections are okay, all LED's are lit when the joystick is centered.
When the joystick is moved, and switches are actuated, one LED for every action should go out.

## ps2_aars

This tests the PS2 interface for connecting keyboards, when a key is pressed the first 6 bits of the key code will light up on the I/O board.
Also the LED's will go out again when the key is released.
