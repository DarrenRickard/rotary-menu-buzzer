# Makefile for flashing LED program to Arduino Mega2560

# Configuration
MCU = atmega2560
F_CPU = 16000000UL
BAUD = 115200
PROGRAMMER = wiring
PORT = /dev/ttyACM0

# Tools
CC = avr-gcc
OBJCOPY = avr-objcopy
AVRDUDE = avrdude

# Files
TARGET = main 
SRC = $(TARGET).c
OBJ = $(TARGET).o
BIN = $(TARGET).bin
HEX = $(TARGET).hex

# Flags
CFLAGS = -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU)
LDFLAGS = -mmcu=$(MCU)
AVRDUDE_FLAGS = -v -c $(PROGRAMMER) -p $(MCU) -P $(PORT) -b $(BAUD) -D

# Default target
all: $(HEX)

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BIN): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $<

$(HEX): $(BIN)
	$(OBJCOPY) -O ihex -R .eeprom $< $@

flash: $(HEX)
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U flash:w:$(HEX):i

clean:
	rm -f *.o *.bin *.hex

.PHONY: all flash clean
