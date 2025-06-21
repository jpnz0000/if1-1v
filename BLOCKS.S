;
;
;
;********************************************************
;*	  BLOCKS.S					*
;*	  15/2/83                                       *
;********************************************************
;
*LIST   ON
;
;	GLOBAL	DIS10,HEX,OPHEX,OP,DISMAP          
;
;	EXTERNAL	MRDCH,MWRCH			;HISOFT
;	EXTERNAL        DELBC						;DUMMY
;
;
OPHEX	PUSH	AF
	RRA
	RRA
	RRA
	RRA
	CALL	OPH
	POP	AF
OPH
	AND	0FH
	CP	10
	JR	C,OPH1
	ADD	A,'A'-'0'-10
OPH1	ADD	A,'0'
	CALL	OP
	RET
;
HEX	PUSH	AF
	CALL	OPHEX
	LD	A,' '
	CALL	OP
	POP	AF
	RET
;
OP	PUSH	HL
	PUSH	DE
	PUSH	BC
	PUSH	AF
	EXX
	PUSH	HL
	PUSH	DE
	PUSH	BC
	PUSH	AF
	LD	HL,(23633)
	PUSH	HL
	PUSH	AF
	LD	A,2
	OLDCAL	SELECT	
	POP	AF
	RST	CALBAS
	DEFW	16
	POP	HL
	LD 	(23633),HL
	POP	AF
	POP	BC
	POP	DE
	POP	HL
	EXX
	POP	AF
	POP	BC
	POP	DE
	POP	HL
	RET
;
;
; DIS10 DISPLAYS IN HEX THE 10 BYTES STARTING AT (HL)
;
DIS10
DISMAP
	PUSH	HL
	PUSH	BC
	PUSH	AF
	LD	B,10
DIS11
	LD	A,(HL)
	CALL	HEX
	INC	HL
	DJNZ	DIS11
	LD	A,0DH
	CALL	OP
	POP	AF
	POP	BC
	POP	HL
	RET
;
	END
