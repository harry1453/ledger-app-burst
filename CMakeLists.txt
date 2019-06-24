cmake_minimum_required(VERSION 3.12)
project(ledger_app_burst C)

set(CMAKE_C_STANDARD 11)

add_executable(ledger_app_burst
        src/main.c
        src/rs/rs_address.h
        src/rs/rs_address.c
        src/curve/curve25519_i64.c
        src/curve/curve25519_i64.h)

include_directories("C:/Users/Harry/Ubuntu/BOLOS_SDK/include")
