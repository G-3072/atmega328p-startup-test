set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  avr)

set(MCU     atmega328p)
set(F_CPU   16000000)
set(BAUD    9600)

set(CMAKE_C_COMPILER        avr-gcc)
set(CMAKE_ASM_COMPILER      ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER      avr-g++)
set(CMAKE_LINKER            avr-g++)
set(CMAKE_OBJCOPY           avr-objcopy)
set(CMAKE_SIZE              avr-size)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_FLAGS "-mmcu=${MCU} -Os -DF_CPU=${F_CPU}")

set(CMAKE_EXE_LINKER_FLAGS "-T ${CMAKE_SOURCE_DIR}/atmega328p.ld ") #-nostartfiles