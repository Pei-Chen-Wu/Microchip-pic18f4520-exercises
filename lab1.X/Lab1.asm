LIST p = 18f4520  ;??????
#include <p18f4520.inc>   ;?????
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00		  ;?0x00??

start:
    clrf WREG ;??WREG???
    clrf BSR
    
step:
    movlw D'15'
    addwf BSR,1 ;?BSR+WREG??BSR
    clrf WREG
loop:   
    addwf BSR,0 ;?BSR+WREG??WREG
    decfsz BSR,1 ;-1  
    goto loop
    
end

