LIST p = 18f4520  ;Microchip-pic18f4520 set
#include <p18f4520.inc>   ;include instruction set of Microchip-pic18f4520
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00		  ;set execution origin at 0x00

start:
    clrf WREG	; Clean the value of WREG
    clrf BSR	; Clean the value of BSR
    
step:
    movlw D'15'	; Move the Decimal value 10 into WREG
    addwf BSR,1	; BSR + WREG -> BSR
    clrf WREG	; Clean the value of WREG
loop:   
    addwf BSR,0 ; BSR + WREG -> WREG
    decfsz BSR,1 ; BSR = BSR - 1, if BSR = 0, undo next line  
    goto loop 
    
end

