LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00	    ; Set the origin of program at 0x00
start:
    CLRF 0x0F0
    LFSR 0, 0x100	; FSR0 point to 0x100    
main:

set_value_loop:
    MOVWF POSTINC0	; ? WREG ???? FSR0 ??????FSR0 ?????? + 1
    INCF    WREG
    BTFSS   WREG, 3	; ?? 0x0F0 ? WREG ?????? 0x0F0 ???????????
    GOTO   set_value_loop
    MOVWF POSTINC0
    
    MOVLW 0x08	; Register WREG = 0x08
    LFSR 0, 0x108	; FSR0 point to 0x108
    LFSR 1, 0x110


set_value_loop_2:
    MOVFF POSTDEC0, POSTINC1	; ? FSR0 ???? FSR1 ?????
				; FSR0 ?????? - 1?FSR1 ?????? + 1
    DECFSZ WREG
    GOTO   set_value_loop_2
    
end