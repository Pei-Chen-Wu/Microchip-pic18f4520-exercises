LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00	    ; Set the origin of program at 0x00
main:	
    MOVLW 0xc2	; WREG = 0xc2
    MOVWF TRISA	; TRISA = WREG
    RRCF TRISA		; Right shift TRISA 1 bit
end


