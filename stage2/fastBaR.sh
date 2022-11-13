#!/bin/sh
gcc compute.s -c -o compute.o
gcc genString.s -c -o genString.o
gcc main.s -c -o main.o
gcc ./compute.o ./main.o ./genString.o -o asm_work.exe
rm -f ./output.txt
touch ./output.txt
chmod +x ./output.txt
./asm_work.exe ./input.txt ./output.txt
cat ./output.txt