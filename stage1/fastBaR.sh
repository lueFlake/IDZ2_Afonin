#!/bin/sh
gcc compute.c -c -o compute.o
gcc genString.c -c -o genString.o
gcc main.c -c -o main.o
gcc ./compute.o ./main.o ./genString.o -o c_work.exe
rm -f ./output.txt
touch ./output.txt
chmod +x ./output.txt
./c_work.exe ./input.txt ./output.txt
cat ./output.txt