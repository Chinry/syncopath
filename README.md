# |SYNCOPATH|

## About
MIDI to GameBoy link cable converter. This is the assembly source code for the ATTINY85 used in this project.

## What Is Implemented So Far
* Recognizes Midi Clock, Stop, and Start messages and sends clock to the GameBoy accordingly
* Filters out messages that are not these

## Circuit Schmematic
I will put this here after I finalize my board


## Building Source Code
Source code is assembled using the gnu-as assembler for avr. After creating a build directory, run _make_.

## Why does this exist?
Arduinoboy costs at least $30 just for the Arduino. The microcontroller used here is $0.50.

