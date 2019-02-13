#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int index = 0;
    int* index_ptr = NULL;

    // assinging to pointer
    index_ptr = &index;

    printf("The value of index: %i\n", index);
    printf("The value of index by direction (through a pointer): %i\n", *index_ptr);

    *index_ptr = 71; // setting the value through direction

    
    printf("The value of index: %i\n", index);
    printf("The value of index by direction (through a pointer): %i\n", *index_ptr);


    return 0;
}