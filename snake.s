.list
.code

MAIN:
JSR ENABLE_LOW_RES
JSR CLEAR_SCREEN
JMP Done


ENABLE_LOW_RES:
 STA $C050
 STA $C053
 STA $C055
 STA $C00C
 STA $C054
 RTS



;INITIALIZE VARIABLES
CLEAR_SCREEN:
PixelPointer = $06
 LDA #$00
 STA PixelPointer
 LDA #$04
 STA PixelPointer+1
 LDX #0
 ; Set color
 LDA #0

FillRow: LDY #119
FillLoop1: STA (PixelPointer),Y
 DEY
 BPL FillLoop1
 
 LDY #247
FillLoop2: STA (PixelPointer),Y
 DEY
 CPY #128
 BPL FillLoop2

 INC PixelPointer+1
 LDX PixelPointer+1
 CPX #8
 BNE FillRow

 ;clear last 4 lines of text
 LDX #20 ;row 21
 JSR ClearTextRow
 LDX #21 ;row 22
 JSR ClearTextRow
 LDX #22 ;row 23
 JSR ClearTextRow
 LDX #23 ;row 24
 JSR ClearTextRow
 RTS

ClearTextRow:
 LDA LO,X
 STA PixelPointer
 LDA HI,X
 STA PixelPointer+1
 LDX #0
 ; put blank char in A
 LDA #$20
 ORA #%10000000

 LDY #40
FillTextRowLoop:
 STA (PixelPointer),Y
 DEY
 BPL FillTextRowLoop
 RTS



Done:
JMP Done

ScoreText: .byte "Score"

; Low-res square row map
HI: .byte $04,$04,$05,$05,$06,$06,$07,$07
.byte $04,$04,$05,$05,$06,$06,$07,$07
.byte $04,$04,$05,$05,$06,$06,$07,$07

LO: .byte $00,$80,$00,$80,$00,$80,$00,$80
.byte $28,$A8,$28,$A8,$28,$A8,$28,$A8
.byte $50,$D0,$50,$D0,$50,$D0,$50,$D0