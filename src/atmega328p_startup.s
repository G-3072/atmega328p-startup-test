

.section .vectors, "ax"

.global __vectors
.global Reset_Handler

__vectors:
.org 0x00
rjmp Reset_Handler    ; startup code
.org 0x02
rjmp INT0_isr   ; INT0 isr
.org 0x04
rjmp INT1_isr
.org 0x06
rjmp PCINT0_isr
.org 0x08
rjmp PCINT1_isr
.org 0x0A
rjmp PCINT2_isr
.org 0x0C
rjmp WDT_isr
.org 0x0E
rjmp TIM2_COMPA_isr
.org 0x10
rjmp TIM2_COMPB_isr
.org 0x12
rjmp TIM2_OVF_isr
.org 0x14
rjmp TIM1_CAPT_isr
.org 0x16
rjmp TIM1_COMPA_isr
.org 0x18
rjmp TIM1_COMPB_isr
.org 0x1A
rjmp TIM1_OVF_isr
.org 0x1C
rjmp TIM0_OVF_isr
.org 0x1E
rjmp TIM0_COMPA_isr
.org 0x20
rjmp TIM0_COMPB_isr
.org 0x22
rjmp SPI_STC_isr
.org 0x24
rjmp USART_RX_isr
.org 0x26
rjmp USART_UDRE_isr
.org 0x28
rjmp USART_TX_isr
.org 0x2A
rjmp ADC_isr
.org 0x2C
rjmp EE_READY_isr
.org 0x2E
rjmp AN_COMP_isr
.org 0x30
rjmp TWI_isr
.org 0x32
rjmp SPM_READY_isr


.section .text

.word _sdata
.word _edata
.word _sidata

.word _sbss
.word _ebss

.global main
.weak main

Reset_Handler:
    sbi 0x04, 5
    sbi 0x05, 5
    setStackPointer:        ; set the Stack Pointer to the top of RAM
    .equ SPH, 0x3E
    .equ SPL, 0x3D
    
    ldi r16, lo8(0x08FF)
    ldi r17, hi8(0x08FF)
    out SPL, r16            ; write low-byte of ram end to SPL reg (0x3D)
    out SPH, r17            ; write high byte of ram end to SPH reg (0x3E)

    copyDataSection:                ; copy the .data section from flash memory to ram
    ldi r30, lo8(_sidata)      ; store data load Memory Address in Z register (FLash address)
    ldi r31, hi8(_sidata)

    ldi r26, lo8(_sdata)        ; store data virtual memory address in X register (Ram Address)
    ldi r27, hi8(_sdata)

    ldi r28, lo8(_edata)        ; store data section end address (RAM) 
    ldi r29, hi8(_edata)

    copyDataLoop:
    cp r26, r28
    breq zeroBssSection

    cp r27, r29
    breq zeroBssSection

    lpm r16, Z+
    st X+, r16

    rjmp copyDataLoop

    zeroBssSection:             ; zero out the .bss section in Ram
    ldi r26, lo8(_sbss)         ; store bss start address in X register
    ldi r27, hi8(_sbss)

    ldi r28, lo8(_ebss)         ; store bss end address in Y register
    ldi r29, hi8(_ebss)

    ldi r16, 0x00

    ZeroBssLoop:
    cp r26, r28
    breq enableInterrupts

    cp r27, r29
    breq enableInterrupts

    st X+, r16

    rjmp ZeroBssLoop

    enableInterrupts:           ; set global interrupt bit in SREG
    sei
    ; cli
    
    clearSREG:                  ; clear the status register flags (bc seen in avr std startup code)
    .equ SREG, 0x3F
    ldi r16, 0x00
    out SREG, r16

    callMain:
    rcall main
    
    infiniteLoop:               ; infinite loop to catch program should it return from main
    rjmp infiniteLoop

.global default_handler
.weak default_handler
default_handler:
    
    rjmp default_handler    ; infinite loop to make sure program doesnt do upredictable stuff

.weak INT0_isr
INT0_isr:
    rjmp default_handler

.weak INT1_isr
INT1_isr:
    rjmp default_handler

.weak PCINT0_isr
PCINT0_isr:
    rjmp default_handler

.weak PCINT1_isr
PCINT1_isr:
    rjmp default_handler

.weak PCINT2_isr
PCINT2_isr:
    rjmp default_handler

.weak WDT_isr
WDT_isr:
    rjmp default_handler

.weak TIM2_COMPA_isr
TIM2_COMPA_isr:
    rjmp default_handler

.weak TIM2_COMPB_isr
TIM2_COMPB_isr:
    rjmp default_handler

.weak TIM2_OVF_isr
TIM2_OVF_isr:
    rjmp default_handler

.weak TIM1_CAPT_isr
TIM1_CAPT_isr:
    rjmp default_handler

.weak TIM1_COMPA_isr
TIM1_COMPA_isr:
    rjmp default_handler

.weak TIM1_COMPB_isr
TIM1_COMPB_isr:
    rjmp default_handler

.weak TIM1_OVF_isr
TIM1_OVF_isr:
    rjmp default_handler

.weak TIM0_COMPA_isr
TIM0_COMPA_isr:
    rjmp default_handler

.weak TIM2_COMPB_isr
TIM0_COMPB_isr:
    rjmp default_handler

.weak TIM2_OVF_isr
TIM0_OVF_isr:
    rjmp default_handler

.weak SPI_STC_isr
SPI_STC_isr:
    rjmp default_handler

.weak USART_RX_isr
USART_RX_isr:
    rjmp default_handler

.weak USART_UDRE_isr
USART_UDRE_isr:
    rjmp default_handler

.weak USART_TX_isr
USART_TX_isr:
    rjmp default_handler

.weak ADC_isr
ADC_isr:
    rjmp default_handler

.weak EE_READY_isr
EE_READY_isr:
    rjmp default_handler

.weak AN_COMP_isr
AN_COMP_isr:
    rjmp default_handler

.weak TWI_isr
TWI_isr:
    rjmp default_handler

.weak SPM_READY_isr
SPM_READY_isr:
    rjmp default_handler


delay_50ms:
    ldi r18, 200      ; Outer loop count
outer_loop:
    ldi r19, 250      ; Middle loop count
middle_loop:
    ldi r20, 250      ; Inner loop count
inner_loop:
    dec r20           ; Decrease inner loop counter
    brne inner_loop   ; Repeat until zero

    dec r19           ; Decrease middle loop counter
    brne middle_loop  ; Repeat until zero

    dec r18           ; Decrease outer loop counter
    brne outer_loop   ; Repeat until zero

    ret               ; Return from function