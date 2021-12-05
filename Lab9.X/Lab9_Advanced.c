#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67    // Oscillator Selection bits
#pragma config WDT = OFF        // Watchdog Timer Enable bit 
#pragma config PWRT = OFF       // Power-up Enable bit
#pragma config BOREN = ON       // Brown-out Reset Enable bit
#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
#pragma config LVP = OFF        // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF        // Data EEPROM　Memory Code Protection bit (Data EEPROM code protection off)

void __interrupt() Rotate(void)             // High priority interrupt
{
    while(1){
        // (4 * 4 + 60)*32 = 2432 
        // (4 * 4 + 0)*8*4 = 512
        CCPR1L = 0x04;                          // CCPRIL = 4
        CCP1CONbits.DC1B = 0b00;                // CCP1CON's DC1B = 0

        // go to 90 degree
        for(int i = 0; i < 16; i++){
            for(int j = 0; j < 4; j++){
                CCP1CONbits.DC1B++;             // (4 * 4 + 4 * 15)*8*4 = 512
                for(int k = 0; k < 50; k++);    // for loop is for delay
            }
            CCPR1L++;
            CCP1CONbits.DC1B = 0b00;
        }       
        // go to -90 degree
        for(int i = 0; i < 1000; i++){          // for loop is for delay
            CCPR1L = 0x4;
            CCP1CONbits.DC1B = 0b00;
        }
    }
    INTCONbits.INT0IF = 0;
}

void main(void) {
     
    T2CONbits.TMR2ON = 0b1;         // Timer2(for PWM only) -> On (1)
    T2CONbits.T2CKPS = 0b01;        // prescaler(PWM's period parameter) = 4
    
    // Internal Oscillator Frequency,because Tosc = 8 µs(requested) , Fosc = 125 kHz (1/8µ = 125k)
    OSCCONbits.IRCF = 0b001;
    // PWM mode, P1A, P1C active-high; P1B, P1D active-high
    CCP1CONbits.CCP1M = 0b1100;
    
    
    TRISC = 0;
    LATC = 0;
    // Set up PR2, CCP to decide PWM period and Duty Cycle
    /** 
     * PWM period
     * = (PR2 + 1) * 4 * Tosc * (TMR2 prescaler)
     * = (0x9b + 1) * 4 * 8µs * 4
     * = 0.019968s ~= 20ms
     */
    PR2 = 0x9b;
    
    RCONbits.IPEN = 1;          // Enable priority levels on interrupts
    INTCON = 0b11010000;
    INTCON2 = 0b01110001;
    
    /**
     * Duty cycle
     * = (CCPR1L:CCP1CON<5:4>) * (T of Osicillator) * (TMR2 prescaler)
     * = (0x04*4 + 0b00) * 8µs * 4
     * = 512 µs
     * Preset the location at -90 degree
     */
    CCPR1L = 0x04;
    CCP1CONbits.DC1B = 0b00;
    
    while(1);
    //return;
    
}