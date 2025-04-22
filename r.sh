#!/bin/bash

set -e  # Exit on error

echo "Assembling .asm files..."

nasm -f elf64 cvtt2n.asm -o cvtt2n.o
nasm -f elf64 input_array.asm -o input_array.o
nasm -f elf64 manager.asm -o manager.o
nasm -f elf64 read_clock.asm -o read_clock.o
nasm -f elf64 sum_array.asm -o sum_array.o
nasm -f elf64 isfloat.asm -o isfloat.o

echo "Compiling and linking with clock.cpp..."

g++ -no-pie clock.cpp cvtt2n.o input_array.o manager.o read_clock.o sum_array.o isfloat.o -o run

echo "Running program..."
./run
