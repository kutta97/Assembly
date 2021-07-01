#include <stdio.h>
int main(){
    int x = 1, y = 2, z = 3;
    printf("++x * z--		: %d\n", ++x * z--);
    printf("x || --y && z	: %d\n", x || --y && z);
    printf("z += x >> 2 + ++y	: %d\n", z += x >> 2 + ++y);
    printf("x = y = z = 5	: %d\n", x = y = z = 5);
    printf("(x = 1 + 2, 2 - 1)	: %d\n", (x = 1 + 2, 2 - 1));
    return 0;
}
