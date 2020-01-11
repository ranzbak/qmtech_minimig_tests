#!/usr/bin/env python3
# Test code for reading a file
"""
This module calls the functions that
* Initializes the SD card
* Configures the adv7511
* Communicate with the FPGA to exchange kickstart/floppy/HDD data
"""

# Set the home directory, so the imports work
#from uos import chdir
#chdir('/sd/apps/openaars')

# Import local modules
from . import adv7511drv
