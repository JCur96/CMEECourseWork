#include <stdio.h>

int main (void)
{
    signed char c1 = -1;
    unsigned char c2 = 0b0111; /* this is how to write binary in unix C
    0b then number of bits you intend to do anything with. Requires you know the
    size of things on your system. This eg is setting three bits out of four 
    specified */

    c2 = c2 << 8;

    printf("c2 is now: %u\n", (unsigned int)c2);

    return 0;

}