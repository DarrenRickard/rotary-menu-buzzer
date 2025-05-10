#include <avr/io.h>

#define RTSW PE4 // Rotary SW pin
#define RTDT PE5 // Rotary DT pin
#define RTCLK PG5 // Rotary CLK pin

int main(void) {
    // Set input pins 
    DDRE |= (1 << RTSW) | (1 << RTDT);
    DDRG |= (1 << RTCLK);
    // Enable pull-up
    PORTE |= (1 << RTSW); 

    while (;;){
        
    }

}

// ============================================================================
