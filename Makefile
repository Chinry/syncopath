all: gb.ihex
	cd build; hex2bin -l 2000 gb.ihex

gb.ihex: gb.elf
	avr-objcopy --output-target=ihex build/gb.elf build/gb.ihex

gb.elf: gb.o
	avr-ld -o build/gb.elf build/gb.o

gb.o:
	avr-as -mmcu=attiny85 -o build/gb.o main.s

burn:
	sudo minipro -p "ATTINY85" -w build/gb.bin || sudo minipro -e -p "ATTINY85" -w build/gb.bin
	sudo minipro -e -c config -p "ATTINY85" -w fuse.txt

clean:
	rm build/*
