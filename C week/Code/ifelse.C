#include <stdio.h>
#include <stdbool.h>

int main (void)
{
    bool x = false;
    if(x == true /*some expression*/) {
       printf("x is non-zero\n"); /* code executes here */
    }
    else {
        printf("x is zero\n");
    }
    return 0;
}