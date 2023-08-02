#include <iostream>

int main() {
    int arry[10] = {7, 3, 8, 1, 3, 2, 0, 5, 3, 4};
    int N = sizeof(arry) / sizeof(int);

    printf("before: ");
    for (int i = 0; i < N; ++i) {
        printf("%d\t", arry[i]);
    }

    for (int i = N - 1; i > 0; --i) {
        bool flag = false;
        for (int j = 1; j <= i; ++j) {
            if (arry[j] < arry[j - 1]) {
                int tmp = arry[j];
                arry[j] = arry[j - 1];
                arry[j - 1] = tmp;

                flag = true;
            }
        }
        if (!flag) {
            break;
        }
    }

    printf("\nafter: ");
    for (int i = 0; i < N; ++i) {
        printf("%d\t", arry[i]);
    }

    return 0;
}