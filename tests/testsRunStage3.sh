#!/bin/sh
touch ./output1.txt
touch tmp
touch out

chmod +x ./output1.txt
../stage2/asm_work.exe ./test1.txt ./output1.txt

echo "=============================================================================\ntest1:" > tmp
cat tmp ./test1.txt ./output1.txt > output.txt

../stage3/asm_work.exe ./test2.txt ./output1.txt
echo "=============================================================================\ntest2:" > tmp
cat output.txt > out
cat out tmp ./test2.txt ./output1.txt > output.txt

../stage3/asm_work.exe ./test3.txt ./output1.txt
echo "=============================================================================\ntest3:" > tmp
cat ./output.txt > out
cat out tmp ./test3.txt ./output1.txt > output.txt

rm -f ./output1.txt
rm -f out
rm -f tmp