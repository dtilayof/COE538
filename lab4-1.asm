;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup                ; export 'Entry' symbol
            ABSENTRY Entry                      ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

;*******************************************************************
;* Motor Control                                                   *
;*******************************************************************

; Definitions                                

; Variable/data section
                ORG   $3850

; Code section
                ORG   $4000
Entry:
_Startup:
                BSET  DDRA, %00000011
                BSET  DDRT, %00110000
                JSR   STARFWD
                JSR   PORTFWD
                JSR   STARON
                JSR   PORTON
                JSR   STARREV
                JSR   PORTREV
                JSR   STAROFF
                JSR   PORTOFF
                BRA   *

;subroutine section
;*******************************************************************
;* Starboard (Right) Motor ON                                      *
;*******************************************************************
STARON          LDAA  PTT
                ORAA  #%00100000
                STAA  PTT
                RTS

;*******************************************************************
;* Starboard (Right) Motor OFF                                     *
;******************************************************************* 
STAROFF         LDAA  PTT
                ANDA  #%11011111
                STAA  PTT
                RTS

;*******************************************************************
;* Starboard (Right) Motor FWD                                     *
;*******************************************************************
STARFWD         LDAA  PORTA
                ANDA  #%11111101
                STAA  PORTA
                RTS

;*******************************************************************
;* Starboard (Right) Motor REV                                     *
;*******************************************************************
STARREV         LDAA  PORTA
                ORAA  #%00000010
                STAA  PORTA
                RTS

;*******************************************************************
;* Port (Left) Motor ON                                            *
;*******************************************************************
PORTON          LDAA  PTT
                ORAA  #%00010000
                STAA  PTT
                RTS

;*******************************************************************
;* Port (Left) Motor OFF                                           *
;*******************************************************************
PORTOFF         LDAA  PTT
                ANDA  #%11101111
                STAA  PTT
                RTS

;*******************************************************************
;* Port (Left) Motor FWD                                           *
;*******************************************************************
PORTFWD         LDAA  PORTA
                ANDA  #%11111110
                STAA  PORTA
                RTS

;*******************************************************************
;* Port (Left) Motor REV                                           *
;*******************************************************************
PORTREV         LDAA  PORTA
                ORAA  #%00000001
                STAA  PORTA
                RTS

;*******************************************************************
;*                 Interrupt Vectors                               *
;*******************************************************************
            ORG   $FFFE
            DC.W  Entry                         ; Reset Vector
