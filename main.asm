;-------------------------------------------------------------------------------
; ECE382 Lab1 - A Simple Calculator
;Chris Kiernan
;This program calculates values based on hard coded values in ROM
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
myProgram:	.byte	0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

											; My program uses the following registers:
											; r5=memory pointer (read)
											; r6=memory pointer (write)
											; r7=most recent value
											; r8=final value
											; r9=operation value
											; r10=errorCheck
			mov		#0xc000, r5				; Initializes memory pointers
			mov		#0x0200, r6
			mov.b	@r5+, r8
start										; Loads the operation code then decides which loop to jump to
			mov.b	@r5+, r9
			cmp		#0x11, r9
			jz		addingLoop
			cmp		#0x22, r9
			jz		subLoop
			cmp		#0x44, r9
			jz		clrLoop
			jmp		trap

addingLoop									; Loads the value after the operation code, then adds the 2 numbers together (final and temp) and stores the value
			mov.b	@r5+, r7
			add		r7, r8
			;mov.b	r8, 0(r6)
			;inc		r6						; inc by itself is already only a +1 code, if I use inc.b then it will clear my MSB, so instead I use inc.w
			jmp		errorCheck

subLoop										; Loads the value after the operation code, then subtracts the 2 values and stored the final value
			mov.b	@r5+, r7
			sub		r8, r7
			mov.b	r7, r8					; The reason for this move is to keep r8 consistently the final value
			;mov.b	r8, 0(r6)
			;inc		r6
			jmp		errorCheck

clrLoop
			mov.b	#0x00, r8				; This move keeps r8 consistent as the final value
			mov.b	r8, 0(r6)
			inc		r6
			inc		r5
			mov.b	@r5, r8					; This move is placed here because if the value is not 0x55 (halt) then it will be the new starting value
			cmp		#0x55, r8
			jz		trap
			jmp		start

errorCheck
			jc		tooHigh
			jn		tooLow
			mov.b	r8, 0(r6)
			inc		r6
			jmp		start
tooHigh
			mov.b	#0xFF, r8
			mov.b	r8, 0(r6)
			inc		r6
			jmp		start
tooLow
			mov.b	#0x00, r8
			mov.b	r8, 0(r6)
			inc		r6
			jmp		start

trap
			jmp		trap

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
