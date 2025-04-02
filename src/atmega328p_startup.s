.section .vectors

.global __vectors
.global __start

.global INT0_isr, INT1_isr, PCINT0_isr, PCINT1_isr, PCINT2_isr
.global WDT_isr, TIM2_COMPA_isr, TIM2_COMPB_isr, TIM2_OVF_isr
.global TIM1_CAPT_isr, TIM1_COMPA_isr, TIM1_COMPB_isr, TIM1_OVF_isr
.global TIM0_OVF_isr, TIM0_COMPA_isr, TIM0_COMPB_isr
.global SPI_STC_isr, USART_RX_isr, USART_UDRE_isr, USART_TX_isr
.global ADC_isr, EE_READY_isr, AN_COMP_isr, TWI_isr, SPM_READY_isr

.weak INT0_isr, INT1_isr, PCINT0_isr, PCINT1_isr, PCINT2_isr
.weak WDT_isr, TIM2_COMPA_isr, TIM2_COMPB_isr, TIM2_OVF_isr
.weak TIM1_CAPT_isr, TIM1_COMPA_isr, TIM1_COMPB_isr, TIM1_OVF_isr
.weak TIM0_OVF_isr, TIM0_COMPA_isr, TIM0_COMPB_isr
.weak SPI_STC_isr, USART_RX_isr, USART_UDRE_isr, USART_TX_isr
.weak ADC_isr, EE_READY_isr, AN_COMP_isr, TWI_isr, SPM_READY_isr

__vectors:
    .org 0x00
    rjmp __start    ; startup code
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
.word _dataLMA

__start:
    ; no need to set SP set by Hardware

    ; copy data from flash to ram
    copyDataSection:
        ldi r30, lo8(_dataLMA)      ; store data load Memory Address in Z register (FLash address)
        ldi r31, hi8(_dataLMA)

        ldi r26, lo8(_sdata)        ; store data virtual memory address in X register (Ram Address)
        ldi r27, hi8(_sdata)

        ldi r28, lo9(_edata)        ; store data section end address (RAM) 
        ldi r29, hi8(_edata)

    copyDataLoop:
        