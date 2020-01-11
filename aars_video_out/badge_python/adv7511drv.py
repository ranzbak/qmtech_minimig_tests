#!/usr/bin/env python
""" I2C communication with the ADV7511 test code """

import time
import i2c as badgeI2C
import machine

class Adv7511Drv():
    """Class to abstract communicating with the ADV7511 HDMI transmitter"""
    i2c = None

    # ADV7511 I2C BUS ADDRESSES
    ADDR_MAIN = 0x39        # Last bit missing, with bit added 0x72
    ADDR_EDID = 0x3f
    ADDR_PACKET = 0x38
    ADDR_CEC = 0x3c
    ADDR_UNKNOWN = 0x3e

    # Register names
    REG_MAIN_REVISION = 0x00
    REG_ADV_SAMP_FREQ = 0x04
    REG_ADV_POW_TX = 0x41
    REG_ADV_POW_STAT = 0x42
    REG_ADV_EDID_ADDR = 0x43
    REG_ADV_I2C_ADDR = 0x45

    # I2C bus
    def __init__(self,
                 sda=machine.Pin(badgeI2C.GPIO_SDA),
                 scl=machine.Pin(badgeI2C.GPIO_CLK),
                 freq=badgeI2C.SPEED
                 ):
        self.i2c = machine.I2C(sda=sda, scl=scl, freq=freq)

    def read(self, address, register):
        """Read from the ADV7511 registers"""
        self.i2c.start()
        self.i2c.write(bytes([(address << 1), register]))
        self.i2c.start()
        data = self.i2c.readfrom(address, 1)[0]
        self.i2c.stop()
        return data

    def write(self, address, register, value):
        """Write to ADV7511 registers"""
        self.i2c.start()
        self.i2c.write(bytes([(address << 1), register, value]))
        self.i2c.stop()

    def change_bits(self, address, register, mask, opr: str):
        """
        And or OR a register with the mask provided
        The opr argument must be either AND or OR
        """
        orig = self.read(address, register)
        if opr == "AND":
            out = orig & mask
        elif opr == "OR":
            out = orig | mask
        else:
            raise ValueError('Wrong operator string ' + opr)
        self.write(address, register, out)

    def set_bit(self, address, register, num: int):
        """ Set single byte in register, given offset [0-7] """
        self.change_bits(address, register, 0x01 << num, "OR")

    def clear_bit(self, address, register, num: int):
        """ Clear single bit in a register, given offset [0-7] """
        self.change_bits(address, register, (0x01 << num) ^ 0xFF, "AND")


# Test code
ADV = Adv7511Drv()

# Power state register 0x42
# -- Display connected --
# 7: 1 = Active high
# 6: 1 = HPD state HIGH
# 5: 1 = HDMI clock termitation detected
# 4: 1 = Fixed
# 3: 0 = I2S 32-bit mode detected
# 2: 0 = Fixed
# 1: 0 = ?
# 0: 0 = ?
# -- Display NOT connected --
# 7: 1 = Active high
# 6: 0 = HPD state LOW
# 5: 1 = HDMI clock termitation NOT detected
# 4: 1 = Fixed
# 3: 1 = I2S 32-bit mode detectedo
# 2: 0 = Fixed
# 1: 0 = ?
# 0: 0 = ?
##########

# Detect if ADV7511 is ready to power up
print("-- Initializing the ADV7511 --")
print("Found chip revision: " + hex(ADV.read(ADV.ADDR_MAIN, ADV.REG_MAIN_REVISION)))
print("Using I2C Address: " + hex(ADV.read(ADV.ADDR_MAIN, ADV.REG_ADV_I2C_ADDR)))

# Store registers before init
orig_reg = [0] * 0xFF
for addr in range(0x00, 0xFF):
    orig_reg[addr] = hex(ADV.read(ADV.ADDR_MAIN, addr))

# Detect the Hot Plug Detect pin (Monitor connected??)
print("-- Wait for Monitor --")
pow_st = 0
while (pow_st & 0x60) != 0x60:
    pow_st = ADV.read(ADV.ADDR_MAIN, 0x42)
    print("Device pow state 0x42: " + hex(pow_st))
    if pow_st != 0:
        print("-- Found Display --")
        break
    time.sleep(1)

# Power up the ADV7511
#ADV.set_bit(ADV.ADDR_MAIN, 0x41, 6)                 # Power down the device (reset)
#ADV.clear_bit(ADV.ADDR_MAIN, 0x41, 6)               # Enable power up
ADV.write(ADV.ADDR_MAIN, 0x41, 0x40)                # Power Down
ADV.write(ADV.ADDR_MAIN, 0x41, 0x10)                # Power up

# Disable monitor sensing for now
#ADV.set_bit(ADV.ADDR_MAIN, 0xA1, 6)                 # Disable monitor sensing

# Test to initialize the ADV7511
ADV.write(ADV.ADDR_MAIN, 0x98, 0x03)                #
ADV.write(ADV.ADDR_MAIN, 0x99, 0x02)                #
ADV.write(ADV.ADDR_MAIN, 0x9A, 0xE0)                #
ADV.write(ADV.ADDR_MAIN, 0x9C, 0x30)
ADV.write(ADV.ADDR_MAIN, 0x9D, 0x01)
ADV.write(ADV.ADDR_MAIN, 0xA2, 0xA4)
ADV.write(ADV.ADDR_MAIN, 0xA3, 0xA4)
ADV.write(ADV.ADDR_MAIN, 0xE0, 0xD0)
ADV.write(ADV.ADDR_MAIN, 0xF9, 0x00)   # Set to non-conflicting I2C address.
ADV.write(ADV.ADDR_MAIN, 0xD0, 0x00)   # Delay adjust for negative DDR capture = disabled

# Set video input mode
ADV.write(ADV.ADDR_MAIN, 0x15, 0x00)                # 44.1kHz audio Set RGB 4:4:4 24 bits
ADV.write(ADV.ADDR_MAIN, 0x16, 0x38)                # 4:4:4 ; 8-bit ; na ; rising edge
ADV.write(ADV.ADDR_MAIN, 0x17, 0x02)                # High polarity hsync/vsync, disable de generator
ADV.write(ADV.ADDR_MAIN, 0x18, 0x00)                #
ADV.write(ADV.ADDR_MAIN, 0x55, 0x00)                # Picture aspect ratio 16:9
ADV.write(ADV.ADDR_MAIN, 0x56, 0x28)                # Active Format Aspect Ratio (same as Picture)

# Set output mode
ADV.write(ADV.ADDR_MAIN, 0xAF, 0x04)                # HDMI mode
ADV.write(ADV.ADDR_MAIN, 0x40, 0x80)                # Enable General control packet
ADV.write(ADV.ADDR_MAIN, 0x4C, 0x04)                # Set output to 24bit/pixel

# Disable HDCP we are not using DRM
ADV.clear_bit(ADV.ADDR_MAIN, 0xAF, 0x07)               # Make sure HDCP is disabled
#ADV.clear_bit(ADV.ADDR_MAIN, 0x97, 0x06)               # Disable BKSV interrupt
#ADV.write(ADV.ADDR_MAIN, 0xAF, 0x06)

# # Tell the display the resolution
ADV.write(ADV.ADDR_MAIN, 0x3C, 0x04)

ADV.write(ADV.ADDR_MAIN, 0xD1, 0xFF)
ADV.write(ADV.ADDR_MAIN, 0xDE, 0x9C)

ADV.write(ADV.ADDR_MAIN, 0x96, 0x20)                # HPD interrupt clear
ADV.write(ADV.ADDR_MAIN, 0xFA, 0x00)                # Nbr of times to search for a good phase



# Sync Adjustment
# Datasheet table 34 Page 57 : 720p 60Hz
#ADV.write(ADV.ADDR_MAIN, 0xD7, 0x1B)
#ADV.write(ADV.ADDR_MAIN, 0xD8, 0x82)
#ADV.write(ADV.ADDR_MAIN, 0xD9, 0x80)
#ADV.write(ADV.ADDR_MAIN, 0xDA, 0x14)
#ADV.write(ADV.ADDR_MAIN, 0xDB, 0x05)


# # Audio setup
# ADV.write(ADV.ADDR_MAIN, 0x01, 0x00)                 # N value: 0x1770
# ADV.write(ADV.ADDR_MAIN, 0x02, 0x17)                 # 44.1MHz at 25.2 MHz display clock
# ADV.write(ADV.ADDR_MAIN, 0x03, 0x70)                 #
# ADV.write(ADV.ADDR_MAIN, 0x04, 0x00)                 # CTS value 0x6D60
# ADV.write(ADV.ADDR_MAIN, 0x05, 0x6D)                 #
# ADV.write(ADV.ADDR_MAIN, 0x06, 0x60)                 #
# # 0x0A = '0' = CTS auto, '000' = I2S', '**' meh, '01' MCLK default
# ADV.write(ADV.ADDR_MAIN, 0x0A, 0x80)                 # Select I2S, manual N/CTS values
# ADV.write(ADV.ADDR_MAIN, 0x0C, 0x3C)                 # I2S Enable
# # 0x73 = '00000' = HDMI spec, '001' = 2 channel audio
# ADV.write(ADV.ADDR_MAIN, 0x73, 0x01)
# # 0x0C = '0' I2S freq, '0' chan status I2S, '0001' only channel 0, '00' standard I2S mode
# ADV.write(ADV.ADDR_MAIN, 0x0C, 0x04)                 # I2S normal mode, I2S0 enable
# # Set the video clock delay
ADV.write(ADV.ADDR_MAIN, 0xBA, 0xB0)                 #
# #ADV.write(ADV.ADDR_MAIN, 0x14, 0x02)                 # I2S audio 16-bit word length

# Dump the whole content of the ADV7511 to screen
print("VIC detected: " + hex(ADV.read(ADV.ADDR_MAIN, 0x3E)))
for addr in range(0x00, 0xFF):
    if orig_reg[addr] != hex(ADV.read(ADV.ADDR_MAIN, addr)):
        print(hex(addr) + " orig: " + orig_reg[addr] + " new: " + hex(ADV.read(ADV.ADDR_MAIN, addr)))

