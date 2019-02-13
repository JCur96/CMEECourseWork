#include <stdio.h>
#include <stdbool.h>

int main (void)
{
    int i = 0;
    // while loop
    while(i < 10/*conditional statement*/){
        printf("loop iteration: %i\n", i);
        ++i;
    }
    i = 0
    do {
        printf("do-while loop iteration: %i\n", i);
        ++i;
    } while (i < 10);

    for(i = 0; i < 10 ; ++i){
        printf("for loop iteration: %i\n" ,i);
    }

    return 0;
}