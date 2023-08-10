#!/usr/bin/env python

import generators

# not the nicest way, possibly one of the faster i think
# some naming rules may allow to modify this function to less than 10 lines

def getGenerator(emulator):

    from generators.pcsx2minus.pcsx2minusGenerator import PCSX2MINUSGenerator  
    return PCSX2MINUSGenerator()

    raise Exception(f"no generator found for emulator {emulator}")
