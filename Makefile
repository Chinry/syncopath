all: gb.ihex
	cd build; hex2bin -l 8000 gb.ihex

gb.ihex: gb.elf
	avr-objcopy --output-target=ihex build/gb.elf build/gb.ihex

gb.elf: synth.o info.o
	avr-ld -o build/gb.elf build/gb.o

gb.o:
	avr-as -mmcu=attiny85 -o build/gb.o main.s

burn:
	sudo minipro -p "ATMEGA328P" -w build/synth.bin || sudo minipro -e -p "ATMEGA328P" -w build/synth.bin
	sudo minipro -e -c config -p "ATMEGA328P" -w fuse.txt

clean:
	rm build/gb.o
	rm build/gb.ihex
	rm build/gb.elf
	rm build/gb.bin
	rm build/gb.out
