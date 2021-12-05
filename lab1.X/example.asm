LIST p = 18f4520  ;??????
#include <p18f4520.inc>   ;?????
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00		  ;?0x00??
    
initial:
    
start:
    clrf WREG ;??WREG???
    clrf BSR
here:
    movlw 0x01 ; ?0x01??WREG = movlw D'1'    
    incf WREG ; f(????) + 1 -> f   
    addlw 0x01 ;??WREG??? + 0x01
    
    addwf BSR,1 ;?BSR+WREG??BSR
    addwf BSR,0 ;?BSR+WREG??WREG
    
    decfsz BSR,1 ;?BSR-1??BSR (BSR=2)
    decfsz BSR,0 ;?BSR-1??WREG (WREG=1)
    decfsz BSR,1 ;?BSR=1
    decfsz BSR,1 ;?BSR=0??????????????
    clrf WREG     ; ????? ??WREG???1
    
    btfss WREG,0 ;??'0'??1???????
    clrf WREG
    
    goto label

label:
    incf WREG
    
end


