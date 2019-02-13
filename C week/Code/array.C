#include <stdio.h>

int main (void)
{
    int intarray[5];
    int implarray[] = {1,2,3,4,5,6,7,8,9,10}; /* implicit size, array of 
    nine elements */

    int i = 0;
    int x = 0;
    for(i = 0; i < 5; ++i){
        x = intarray[i];
        printf("value at intarray[%i] is: %i\n", i, x);
    }

    for(i = 0; i < 10; ++i){
        x = implarray[i];
        printf("value at intarray[%i] is: %i\n", i, x);
    }
    




    return 0;

}