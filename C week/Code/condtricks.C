#include <stdio.h>

int main (void)
{
    int x = 0;
    if(x)
        printf("something happens\n"); // this wont execute as x !=T
        printf("something else happens\n"); // this will execute tho
}