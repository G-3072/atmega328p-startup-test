.global main


main:
  sbi   0x04, 5     ; Set PB5 as output
blink:
  sbi   0x03, 5     ; Toggle PINB
  ldi   r25, hi8(100)
  ldi   r24, lo8(100)
  rcall  delay_ms
  rjmp   blink

delay_ms:
  ; Delay about (r25:r24)*ms. Clobbers r30, and r31.
  ; One millisecond is about 16000 cycles at 16MHz.
  ; The inner loop takes 4 cycles, so we repeat it 3000 times
  ldi   r31, hi8(4000)
  ldi   r30, lo8(4000)
inner:
  sbiw    r30, 1
  brne    inner
  sbiw    r24, 1
  brne    delay_ms
  ret

; .section .data
; nop
; nop
; nop

; .section .bss
; nop
; nop
; nop
; .section .text
; main:
;   sbi 0x04, 5

;   .word _sdata
;   .word _edata
;   .word _sidata
;   .word _sbss
;   .word _ebss

;   ldi r16, hi8(_ebss)
;   ldi r17, lo8(_ebss)

;   ; cp r16, r17
;   cpi r17, 0x0C
;   ; cpi r16, 0x06

;   breq ledOn
;   ledOff:
;     cbi 0x05, 5
;     rjmp ledOff

;   ledOn:
;     sbi 0x05, 5
;     rjmp ledOn