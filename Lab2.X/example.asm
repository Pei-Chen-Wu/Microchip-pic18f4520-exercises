LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00	    ; Set the origin of program at 0x10
start:
    clrf WREG
step:
     nop	    ; Waste 1 clock cycle (Delay), PC = PC + 2
     nop
     nop
     nop
     nop
     
     movlw 0x99	    ; WREG = 0x99
     movlb 0x4	    ; BSR = 4
     movwf 0x010, 1; Use BSR select bank ; [0x410] = 0x99
end


