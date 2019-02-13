#include <stdio.h>

int main (void)
{
    int x = 1;
    float y = 2.03;
    float z = 0;

    z = x + y; // produces an int of 3
    printf("The value of z: %f\n", z);

    return 0;
    
}
