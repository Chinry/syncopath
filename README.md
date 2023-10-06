# |SYNCOPATH|

## About
MIDI to GameBoy link cable converter. This is the assembly source code for the ATTINY85 used in this project.

## What Is Implemented So Far
* Recognizes Midi Clock, Stop, and Start messages and sends clock to the GameBoy accordingly
* Filters out messages that are not these
  
## Building Source Code
Source code is assembled using the gnu-as assembler for avr. After creating a build directory, run _make_.

