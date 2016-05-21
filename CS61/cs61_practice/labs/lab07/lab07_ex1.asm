;=================================================
; Name: Xiao Zhou
; Email:  xzhou016@ucr.edu
; 
; Lab: lab 7
; Lab section: 21
; TA: Gaurav Jhaveri
; 
;=================================================

.ORIG x3000

LD R0, STRING_DATA_PTR

LD R6, GET_STRING
JSRR R6

LD R0, STRING_DATA_PTR
PUTS
LD R0, HEX_NEWLINE
PUTS

HALT
;==========
;x3000 DATA
;==========
GET_STRING		.FILL x3200
STRING_DATA_PTR		.FILL x6000
HEX_NEWLINE 		.STRINGZ "\n"

;­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­======================================================================

; Subroutine: SUB_GET_STRING

; Parameter (R0): The address of where to start storing the string

; Postcondition: The subroutine has allowed the user to input a string,

;    terminated by the [ENTER] key, and has stored it in an array

;    that starts at (R0) and is NULL­terminated.

; Return Value: R5 The number of non­sentinel characters read from the user

;­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­=========================================================================
.ORIG x3200
ST R7, R7_BACKUP_3200	;backup R7
AND R1, R1, #0

ADD R1, R0, #0

KEEP_READING
GETC
STR R0, R1, #0		;store character in r3 in R1

ADD R1, R1, #1		;increment pointer location by 1
ADD R0, R0, #-10
BRp KEEP_READING
ADD R1, R1, #-1

AND R0, R0, #0		;set last input as #0 for stringz
STR R0, R1, #0		;store it

LD R5, STRING_DATA_PTR_3200

LD R7, R7_BACKUP_3200
RET
;==================
;x3200 DATA
;==================
R7_BACKUP_3200 			.BLKW #1 
STRING_DATA_PTR_3200		.FILL x6000



.ORIG x6000
STRING_DATA	.STRINGZ ""

.END
