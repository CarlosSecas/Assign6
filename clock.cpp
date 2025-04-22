#include <stdio.h>

extern "C" double manager(); // Declaration of the assembly function

int main() {
    printf("Welcome to Time Measure programmed by Harry Winston.\n\n");

    double result = manager();  // This handles all I/O and computations

    printf("\nThe main function received %.1f and will keep it.\n", result);
    printf("Have a nice summer in 2025.\n");

    return 0;
}
