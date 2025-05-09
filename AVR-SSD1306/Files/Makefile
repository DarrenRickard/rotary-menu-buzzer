# MCU and Build Settings
MCU        = atmega2560
F_CPU      = 16000000UL
BAUD       = 115200
PROGRAMMER = wiring
PORT       = /dev/ttyACM0

# Tools
CC       = avr-gcc
OBJCOPY  = avr-objcopy
AVRDUDE  = avrdude

# Files and Paths
TARGET     = Demo
BUILD_DIR  = build
SRCS       = Demo.c SSD1306.c TWI.c
OBJS       = $(SRCS:%.c=$(BUILD_DIR)/%.o)
BIN        = $(BUILD_DIR)/$(TARGET).bin
HEX        = $(BUILD_DIR)/$(TARGET).hex

# Flags
CFLAGS        = -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU) -I.
LDFLAGS       = -mmcu=$(MCU)
AVRDUDE_FLAGS = -v -c $(PROGRAMMER) -p $(MCU) -P $(PORT) -b $(BAUD) -D

# Targets
all: $(HEX)

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

$(HEX): $(BIN)
	$(OBJCOPY) -O ihex -R .eeprom $< $@

flash: $(HEX)
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U flash:w:$<:i

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all flash clean
