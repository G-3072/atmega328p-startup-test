MEMORY
{
    RAM (rwx)   :   ORIGIN = 0x800000, LENGTH = 2K      /* RAM memory , 2KB Byte addressed --> 2048 * 8bit, offset = 0x800000,  */
    FLASH (rx)  :   ORIGIN = 0x000000, LENGTH = 32K     /* Flash memory, 32KB word addressed --> 16K * 16bit, offset = 0x0 */
    EEPROM (rw) :   ORIGIN = 0x810000, LENGTH = 1K      /* EEPROM memory, 1KB, (Byte addressed) , offset = 0x810000 */
}

SECTIONS
{
    .text :
    {
        *(.vectors)
        KEEP(*(.vectors))

        *(.text)
        . = ALIGN(2);
        *(.text.*)
        . = ALIGN(2);

    } > FLASH

    .data :
    {
        . = align 
    } >RAM AT> FLASH
}