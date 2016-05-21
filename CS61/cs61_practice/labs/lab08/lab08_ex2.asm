;=================================================
; Name: Xiao Zhou
; Email:  xzhou016@ucr.edu
; 
; Lab: lab 8
; Lab section: 21
; TA: Gaurav Jhaveri
; 
;=================================================
.ORIG x3000

LD R6, SUB_PRINT_OPCODES
JSRR R6

HALT
;================
;.ORIG x3000 Data
;================
SUB_PRINT_OPCODES 		.fill x3200 

;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;           and corresponding opcode in the following format:
;           ADD = 0001
;           AND = 0101
;           BR = 0000
;           …
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3200
ST R7, R7_BACKUP_3200
LD R1, OPCODE_STR_PTR
LD R2, OPCODE_DEC_PTR

OPCODE_LOOP

;Loop through strings
STRING_LOOP
LDR R0, R1, #0
OUT
ADD R1, R1, #1	;increment address
ADD R0, R0, #0  ;check content of r0, if zero no more loop
BRp STRING_LOOP
ADD R0, R0, #0	;check content of t0, if -1 exit opcode loop
BRn LOOP_DONE

;COSMETICS
LEA R0, SPACE
PUTS


;Print Decimal Loop
DECIMAL_LOOP
LDR R4, R2, #0
LD R5, SKIP_LOOP_COUNTER
ADD R3, R3, #4 ;DEC_LOOP_COUNTER
;skip 12 binary---
SKIP_LOOP
ADD R4, R4, R4
ADD R5, R5, #-1
BRp SKIP_LOOP



PRINT_LOOP
  ADD R4, R4, #0
  BRn PRINT_ONE
  LD R0, ZERO
OUT
 
BR DONE
 
  PRINT_ONE
    LD R0, ONE
    OUT
    DONE
    ADD R4, R4, R4
    
    ADD R3, R3, #-1
  BRp PRINT_LOOP
 
  LEA R0, NEWLINE
  PUTS
  ADD R2, R2, #1
BR OPCODE_LOOP

LOOP_DONE

LD R7, R7_BACKUP_3200
RET
;==================
;Data at x3200
;==================
R7_BACKUP_3200 		.BLKW #1
OPCODE_DEC_PTR		.FILL x3400
OPCODE_STR_PTR		.FILL x3600
SPACE			.STRINGZ " = "
NEWLINE			.STRINGZ "\n"
ZERO			.FILL x30
ONE			.FILL x31
SKIP_LOOP_COUNTER	.FILL #12

.ORIG x3400
;====Opcode Decimal=======
DEC_ADD		.FILL #1
DEC_AND		.FILL #5
DEC_BR		.FILL #0
DEC_JMP		.FILL #12
DEC_JSR		.FILL #4
DEC_JSRR	.FILL #4
DEC_LD		.FILL #2
DEC_LDI		.FILL #10
DEC_LDR		.FILL #6
DEC_LEA		.FILL #13
DEC_NOT		.FILL #9
DEC_RET		.FILL #12
DEC_RTI		.FILL #8
DEC_ST		.FILL #3
DEC_STI		.FILL #11
DEC_STR		.FILL #7
DEC_TRAP	.FILL #15

.ORIG x3600
;====Opcode STRING=======
STRING_ADD	.STRINGZ "ADD"
STRING_AND	.STRINGZ "AND"
STRING_BR	.STRINGZ "BR"
STRING_JMP	.STRINGZ "JMP"
STRING_JSR	.STRINGZ "JSR"
STRING_JSRR	.STRINGZ "JSRR"
STRING_LD	.STRINGZ "LD"
STRING_LDI	.STRINGZ "LDI"
STRING_LDR	.STRINGZ "LDR"
STRING_LEA	.STRINGZ "LEA"
STRING_NOT	.STRINGZ "NOT"
STRING_RET	.STRINGZ "RET"
STRING_RTI	.STRINGZ "RTI"
STRING_ST	.STRINGZ "ST"
STRING_STI	.STRINGZ "STI"
STRING_STR	.STRINGZ "STR"
STRING_TRAP	.STRINGZ "TRAP"
END_STRING	.FILL #-1

.END