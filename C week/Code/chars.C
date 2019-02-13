// chars.C

#include <stdio.h>
int main (void)
{
    char c1 = 'a';
    char c2 = 'c';
    char case_offset;

    case_offset = c2 - c1;

    printf("case_offset evaluates to: %i\n", (int)case_offset);

    return 0;

}