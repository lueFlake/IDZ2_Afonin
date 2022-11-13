#include <stdio.h>
#include <time.h>
#include <stdlib.h>

extern void compute(int n, char* s);
extern void genString(int* n, char* s);

int main(int argc, char** argv) {
    srand(time(0));
    clock_t start, finish;
    char str[3010];
    int n = 0;

    FILE* ifs = stdin;
    FILE* ofs = stdout;
    if (argc == 3) {
        if (argv[1][0] != '%') {
            ifs = fopen(argv[1], "r");
        } else {
            ifs = NULL;
        }
        ofs = fopen(argv[2], "w");
    }

    if (ifs != NULL) {
        int ch = 0;
        do {
            ch = fgetc(ifs);
            str[n++] = ch;
        } while (ch != -1);
        str[--n] = '\0';
        start = clock();
        compute(n, str);
        finish = clock();
        fprintf(ofs, "%s\n", str);
        fprintf(ofs, "time: %ld ms\n", finish - start);
    } else {
        clock_t total = 0;
        for (int i = 0; i < 100000; ++i) {
            genString(&n, str);
            fprintf(ofs, "test no.%d:\n\n in: %s\n\n ", i, str);
            start = clock();
            compute(n, str);
            finish = clock();
            fprintf(ofs, "out: %s\n\n", str);
            total += finish - start;
        }
        fprintf(ofs, "total random testing time: %ld ms", total);
    }
    return 0;
}