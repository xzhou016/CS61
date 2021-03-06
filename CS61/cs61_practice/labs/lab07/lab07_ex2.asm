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

LD R6, SUB_IS_A_PALINDROME
JSRR R6
ADD R4, R4, #0
BRz MSG
LEA R0, PASS_MSG
PUTS

BR END_OF_LINE
MSG
LEA R0, NOT_PASS_MSG
PUTS

END_OF_LINE

HALT
;==========
;x3000 DATA
;==========
GET_STRING		.FILL x3200
SUB_IS_A_PALINDROME	.FILL x3400
STRING_DATA_PTR		.FILL x6000
HEX_NEWLINE 		.STRINGZ "\n"
PASS_MSG		.STRINGZ "Your string is a palindrome\n"
NOT_PASS_MSG		.STRINGZ "Your string is not a palindrome\n"



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
AND R5, R5, #0

ADD R1, R0, #0

KEEP_READING
GETC
OUT
STR R0, R1, #0		;store character in r3 in R1

ADD R1, R1, #1		;increment pointer location by 1
ADD R5, R5, #1
ADD R0, R0, #-10
BRp KEEP_READING
ADD R1, R1, #-1

AND R0, R0, #0		;set last input as #0 for stringz
STR R0, R1, #0		;store it

ADD R5, R5, #-1

LD R7, R7_BACKUP_3200
RET
;==================
;x3200 DATA
;==================
R7_BACKUP_3200 			.BLKW #1 
;STRING_DATA_PTR_3200		.FILL x6000

;­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­===========================================================================
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
;    a palindrome or not returned a flag indicating such.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­===========================================================================
.ORIG x3400


ST R7, R7_BACKUP_3400
 LD R1, STRING_DATA_PTR_3400
 ADD R1, R1, R5		;FIND LAST LETTER
 ADD R1, R1, #-1

TESTING
  ADD R5, R5, #-1
  LDR R2, R0, #0
  LDR R3, R1, #0

  ADD R0, R0, #1
  ADD R1, R1, #-1

NOT R3, R3
ADD R3, R3, #1


ADD R2, R2, R3
BRz PALINDROME

NOT_PALINDROME
  AND R4, R4, #0 ;CLEAN
  BR DONE

PALINDROME
  AND R4, R4, #0 ; clean
  ADD R4, R4, #1 ; IF TEST PASSED, SET R4 TO 1

REDO_TEST
ADD R5, R5, #-1
BRzp TESTING

DONE 

LD R7, R7_BACKUP_3400

RET
;==================
;x3400 DATA
;==================
R7_BACKUP_3400 			.BLKW #1
STRING_DATA_PTR_3400		.FILL x6000



.ORIG x6000
STRING_DATA	.STRINGZ ""

.END
