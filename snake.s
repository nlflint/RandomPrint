.list
.code

MAIN:
JSR ENABLE_LOW_RES
JSR CLEAR_SCREEN
;JSR SHOW_TITLE
;JSR CLEAR_SCREEN
JSR DRAW_STATIC_GFX
;JSR START_GAME
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
 LDA #$20
 ORA #%10000000
 STA FILL_VALUE
 
 LDA #20
 STA FILL_ROW_NUMBER
 JSR FILL_ROW

 LDA #21
 STA FILL_ROW_NUMBER
 JSR FILL_ROW

 LDA #22
 STA FILL_ROW_NUMBER
 JSR FILL_ROW

 LDA #23
 STA FILL_ROW_NUMBER
 JSR FILL_ROW

 ;LDA  ;row 21
 ;JSR ClearTextRow
 ;LDX #21 ;row 22
 ;JSR ClearTextRow
 ;LDX #22 ;row 23
 ;JSR ClearTextRow
 ;LDX #23 ;row 24
 ;JSR ClearTextRow
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

 LDY #COLUMN_COUNT
FillTextRowLoop:
 STA (PixelPointer),Y
 DEY
 BPL FillTextRowLoop
 RTS

DRAW_STATIC_GFX:
 JSR DRAW_GAME_BOX
 ;JSR DRAW_SCORE_LABEL
 RTS

DRAW_GAME_BOX:
 LDA #$FF
 STA FILL_VALUE
 LDA #00
 STA FILL_ROW_NUMBER
 JSR FILL_ROW
 
 LDA #$DD
 STA FILL_VALUE
 LDA #19
 STA FILL_ROW_NUMBER
 JSR FILL_ROW
 RTS

COLUMN_COUNT = 39
FILL_ROW_NUMBER: .byte $00
FILL_VALUE: .byte $00
FILL_ROW:
 LDX FILL_ROW_NUMBER
 LDA LO,X
 STA PixelPointer
 LDA HI,X
 STA PixelPointer+1
 LDA FILL_VALUE
 LDY #COLUMN_COUNT
FILL_LOOP:
 STA (PixelPointer), Y
 DEY
 BPL FILL_LOOP
 RTS

 
 
TEXT_ADDR: .byte $00,$00
DESTINATION_ADDR: .byte $00,$00
COPY_TEXT_TO:
 RTS
 

Done:
JMP Done

START_GAME:
 ;

ScoreText: .byte "Score",0

; Low-res square row map
HI: .byte $04,$04,$05,$05,$06,$06,$07,$07
.byte $04,$04,$05,$05,$06,$06,$07,$07
.byte $04,$04,$05,$05,$06,$06,$07,$07

LO: .byte $00,$80,$00,$80,$00,$80,$00,$80
.byte $28,$A8,$28,$A8,$28,$A8,$28,$A8
.byte $50,$D0,$50,$D0,$50,$D0,$50,$D0