LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00	    ; Set the origin of program at 0x00
initial:
    MOVLW   0x04    ; WREG = 0x04
    MOVWF   TRISA   ; TRISA = WREG = 0x04
    MOVLW   0x0D    ; WREG = 0x0D
    MOVWF   TRISB   ; TRISB = WREG = 0x0D
    RRNCF    TRISB   ; TRISB 
    MOVLW   0x06
    MOVWF   TRISC
    CLRF    WREG
    
mult:    
    RLNCF   TRISB
    BTFSC   TRISC, 0
    ADDWF   TRISB,0
    RRCF    TRISC
    DECFSZ  TRISA
    GOTO    mult
    
return_value:
    MOVWF   TRISA
end