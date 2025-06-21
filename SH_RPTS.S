;
;******************************************************************************
;
;				SHADOW ROM REPORT MODULE   - SH_RPTS.S
;
;******************************************************************************


;	GLOBAL SH_RPT
;	EXTERNAL RETBAS
;	EXTERNAL	DELTMP

SH_RPT			; DEAL WITH ERROR REPORTS IN RUN-TIME
			; THE ERROR NUMBER POINTER IS ON THE STACK
			; THE RANGE OF NUMBERS IS 00H - 1EH

	LD	(IY+FLAGS3-Y),00H		; CLEAR THE STATEMENT FLAG AS EXITING
	EI					; ENSURE INTERRUPT IS ON
	HALT

	CALL	DELTMP
	RES	5,(IY+FLAGS-Y)			; SIGNAL 'NO LAST KEY AS YET'
	BIT	1,(IY+FLAGS2-Y)
	JR	Z,SH_R1
	RST	CALBAS
	DEFW	0ECDH				; EMPTY THE PRINTER BUFFER IF NEEDED
SH_R1	POP	HL
	LD	A,(HL)				; FETCH ERROR NUMBER
	LD	(IY+ERR_NR-Y),A			; SAVE IT
	INC	A
	PUSH	AF
	LD	HL,0000H
	LD	(IY+FLAGX-Y),H			; CLEAR THESE
	LD	(IY+X_PTR+1-Y),H
	LD	(DEFADD),HL
	INC	L
	LD	(5C16H),HL			; RESET STREAM 0
	RST	CALBAS
	DEFW	16B0H				; CLEAR EDIT-LINE & STACK
	RES 	5,(IY+FLAGX-Y)			; SIGNAL INPUT MODE
	RST	CALBAS
	DEFW	0D6EH				; CLEAR THE LOWER SCREEN
	SET 	5,(IY+TV_FLAG-Y)		; SIGNAL 'CLEAR LOWER SCREEN AFTERWARDS'
	RES 	3,(IY+TV_FLAG-Y)		; CORRECT THE ERROR
	POP	AF				; COLLECT ERROR NUMBER
	LD	HL,BASRPT			; ERROR MESSAGE BASE
        LD	B,04H				; BC MUST EXCEED LENGTH OF MESSAGES
        CPIR					; FIND THE START OF THE MESSAGE REQUIRED
SH_R2   LD	A,(HL)				; FETCH EACH LETTER
        CP	20H				; EXIT AT END OF MESSAGE
        JR	C,SH_R3
        PUSH	HL
        RST	CALBAS
        DEFW	0010H
        POP	HL				; FETCH AND ADVANCE THE POINTER
        INC	HL
        JR	SH_R2
    
;
SH_R3	LD	SP,(ERR_SP)			; DROP THE MACHINE STACK
	INC	SP
	INC	SP
	LD	HL,1349H
	PUSH	HL
	RST	R_BASE				; EXIT


; THE ERROR MESSAGES

BASRPT	DEFB	0
	DEFM	'Program finished'
	DEFB	1
	DEFM	'Nonsense in BASIC'
	DEFB	2
	DEFM	'Invalid stream number'
	DEFB	3
	DEFM	'Invalid device expression'
	DEFB	4
	DEFM	'Invalid name'
	DEFB	5
	DEFM 	'Invalid drive number'
	DEFB	6
	DEFM	'Invalid station number'
	DEFB	7
	DEFM	'Missing name'
	DEFB	8
	DEFM	'Missing station number'
	DEFB	9
	DEFM	'Missing drive number'
	DEFB	0AH
	DEFM	'Missing baud rate'
	DEFB	0BH
	DEFM	'Header mismatch error'
	DEFB	0CH
	DEFM	'Stream already open'
	DEFB	0DH
	DEFM	'Writing to a '
	DEFB	027H
	DEFM	'read'
	DEFB	027H
	DEFM	' file'
	DEFB	0EH
	DEFM	'Reading a '
	DEFB	027H
	DEFM	'write'
	DEFB	027H
	DEFM	' file'
	DEFB	0FH
	DEFM	'Drive '
	DEFB	027H
	DEFM	'write'
	DEFB	027H
	DEFM	' protected'
	DEFB	10H
	DEFM	'Microdrive full'
	DEFB	11H
	DEFM	'Microdrive not present'
	DEFB	12H
	DEFM	'File not found'
	DEFB	13H
	DEFM	'Hook code error'
	DEFB	14H
	DEFM	'CODE'
	DEFM	' error'
	DEFB	15H
	DEFM	'MERGE'
	DEFM	' error'
	DEFB	16H
	DEFM	'Verification has failed'
	DEFB	17H
	DEFM	'Wrong file type'
	DEFB	18H
