#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void genString(int* n, char* s) {
    *n = rand() % 3000 + 1;
    for (int i = 0; i < *n; ++i) {
        s[i] = rand() % 95 + 32;
    }
    s[*n] = '\0';
}
