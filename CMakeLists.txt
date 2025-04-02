cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(arduino-startup-test VERSION 1.0 LANGUAGES ASM)

add_executable(${PROJECT_NAME})

message(STATUS ${CMAKE_VERSION})

include(cmake/avr-gcc.cmake)

target_sources(${PROJECT_NAME} PRIVATE
    src/main.s
    # src/atmega328p_startup.s
)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND avr-objcopy -O ihex $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.hex
    COMMENT "Generating HEX file"
)
