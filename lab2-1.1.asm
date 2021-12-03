; export symbols
            XDEF Entry, _Startup    ; export 'Entry' symbol
            ABSENTRY Entry          ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

; code section
            ORG   $4000


Entry:
_Startup:
            LDAA #$FF             ; ACCA = $FF
            STAA DDRH             ; Config. Port H for output
            STAA PERT             ; Enab. pull-up res. of Port T
      Loop: LDAA PTT              ; Read Port T
            STAA PTH              ; Display SW1 on LED1 connected to Port H
            BRA  Loop             ; Loop

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            FDB   Entry
