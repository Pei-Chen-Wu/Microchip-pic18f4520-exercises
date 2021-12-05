
LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
start:
    clrf WREG	; Clean the register WREG
    clrf H'000'	; Clean the register H'000' 
    
step:
    movlw D'1'		; WREG = 1
    addwf H'000', 1	; H'000' = H'000' + WREG = 0 + 1
    clrf WREG		; WREG = 0
    
loop:
    addwf H'000', 0	; WREG = H'000' + WREG
    rlcf  H'000', 1	; H'000' = H'000' * 2 (The value in H'000' left shift 1 bit)
    btfss  H'000', 7	; if BSR<7> = 1, quit the loop
    goto loop
end

