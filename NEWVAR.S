;
;***************************************************
;*	NEWVAR.S				   *
;*	 29/4/83				   *
;***************************************************
;
;**************************************************
;*     SYSTEM EQUATES				  *
;**************************************************
;
;
PORTC	EQU	0EFH				; UDRIVE CONTROL/STATUS PORT
PORTD	EQU	0E7H				; DATA PORT ADDRESS
;
SELD	EQU	0FEH				; DRIVE SELECT DATA
SELC	EQU	0FDH				; DRIVE SELECT CLOCK
WRITE	EQU	0FBH				; WRITE CURRENT ON
ERASE	EQU	0F7H				; ERASE CURRENT ON
CTS	EQU	0EFH				; CLEAR TO SEND OUTPUT
;
SYNC	EQU	2				; SYNC BYTE DETECTED SIGNAL
PROTECT	EQU	1				; WRITE PROTECT SIGNAL
GAP	EQU	4				; GAP SIGNAL
BUSY	EQU	10h
;
PLEN	EQU	12				; LENGTH OF PREAMBLE
HD_LEN	EQU	PLEN+14+1			; LENGTH OF HEADER BLOCK PLUS PREAMBLE
D_LEN	EQU	HD_LEN+512+1			; LENGTH OF DATA BLOCK
HD_MAX	EQU	255				; NUMBER OF BLOCK ON TAPE
TRYS	EQU	5				; NUMBER OF TRIPS ROUND TAPE
						; BEFORE GIVING UP
GAPT3	EQU	360				; THE DEC BC DELAY BETWEEN READING
						; A HEADER, CORRECTING IT, TESTING
						; IF FREE AND WRITING A DATA BLOCK
GAPT1	EQU	GAPT3+74			; THE DEC BC DELAY BETWEEN WRITING
						; A HEADER BLOCK AND WRITING A
						; DATA BLOCK
GAPT2	EQU	831				; THE DEC BC DELAY BETWEEN END OF
						; A DATA BLOCK AND BEGINNING OF
						; HEADER BLOCK
						; THE DEC BC DELAY IS 26 T-STATES
						; OR 7.4US
; THE ABOVE TIMINGS ARE HOPEFULLY
; FOR A HEADER OF LENGTH 840US, FOLLOWED BY A GAP OF 3.06MS, FOLLOWED
; BY THE DATA BLOCK LENGTH 21.3MS, FOLLOWED BY A GAP OF 6MS
;
ERROR	EQU	8				; ERROR HANDLING IN ROM
INSERT	EQU	1655H				; MAKE SPACE IN ROM
DELREC	EQU	19E8H				; DELETE SPACE IN ROM
CHANS	EQU	23631				; ADDRESS OF CHANNEL DATA
STKEND	EQU	23653				; ADDRESS OF START OF SPARE SPACE
STKBOT	EQU	23651
MEM	EQU	23656
SELECT	EQU	1601H				; CHANNEL SELECT SUB. IN OLD ROM
SENDTV	EQU	7F4H				; TV OUTPUT PROCEDURE
OUTCH	EQU	16				; CHANNEL OUTPUT ROUTINE
INCH	EQU	15E6H				; CHANNEL INPUT ROUTINE
;
;
;                       SHADOW ROM SYSTEM VARIABLES
;
;******************************************************************
;