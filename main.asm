;-------------------------------------------------------------------------------
; ECE382 Lab1 - A Simple Calculator
;Chris Kiernan
;This program calculates values based on hard coded values in ROM
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
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

			mov		#0x____, r5
			mov		#0x0200, r6
			mov.b	@r5+, r8
start
			mov.b	@r5+, r9
			cmp		#0x22, r9
			jz		addingLoop
			jmp		trap

addingLoop
			mov.b	@r5+, r7
			add		r7, r8
			mov.b	r8, 0(r6)
			mov.b	@r5+, r7
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
