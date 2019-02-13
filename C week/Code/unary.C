// unary.c

#include <stdio.h>

int main(void)
{
    int x = 0;
    x = x + 1;
    ++x; // evaluate x then add to it
    //x++; // add to and then evaluate x 
    printf("The value of x: %i and %i\n", x++, x);
    
    return 0;
}

/* -Wall is run with the compiler e.g. gcc -Wall ..Script.C
W all means all warnings I think */ 