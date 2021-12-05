LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00	    ; Set the origin of program at 0x10
start:
    CLRF 0x0F0		; clear 0x0F0
    CLRF WREG		; clear WREG
    LFSR 0, 0x100	; FSR0 point to 0x100
set_value_loop:
    MOVWF POSTINC0	; Move the value of WREG to the position FSR0 is pointing to
			; POSTINC0 means the position of FSR0 + 1
    INCF    WREG	; WREG + 1 -> WREG
    BTFSS   WREG, 3	; compare WREG third bit is 1 or not?if true then jump out the loop 
    GOTO   set_value_loop
    MOVWF POSTINC0	; Need to run again
    
    MOVLW 0x08	; Register WREG = 0x08
    LFSR 0, 0x108	; FSR0 point to 0x108
    LFSR 1, 0x110	; FSR1 point to 0x110
set_value_loop_2:
    MOVFF POSTDEC0, POSTINC1	; move the value of position FSR0 pointing to to the position FSR1 is pointing to
				; POSTDEC0 means the position of FSR0 - 1
				; POSTINC1 means the position of FSR1 + 1
    DECFSZ WREG		; WREG - 1 -> WREG?if 0 then jump out the loop
    GOTO   set_value_loop_2
    
    MOVLW  0x09	; Register WREG = 0x09
    CLRF    0x0F0	; Register 0x0F0 = 0x00
    ADDWF  0x0F0, 1	; Register 0x0F0 = WREG = 0x08
    CLRF    WREG	; clear WREG
    LFSR 0, 0x100	; FSR0 point to 0x100
    LFSR 2, 0x120	; FSR2 point to 0x120
set_value_loop_3:
    ADDWF POSTINC0, 0	; WREG + the value of the position FSR0 is pointing to -> WREG
			; POSTINC0 means the position of FSR0 + 1
    MOVWF POSTINC2	; move WREG to the position FSR2 is pointing to
			; POSTINC2 means the position of FSR2 + 1
    DECFSZ 0x0F0	; 0x0F0 - 1 -> 0x0F0?if 0 jump out the loop
    GOTO   set_value_loop_3
end


