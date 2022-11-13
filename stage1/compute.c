
void compute(int n, char* s) {
    for (int i = 0; i < n; ++i) {
        if ('a' <= s[i] && s[i] <= 'z') {
            s[i] = s[i] - 'a' + 'A';
        }
    }
}