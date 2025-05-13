#include <stdio.h>

void reorder(int* arr, int n) {
    int* end = arr + n;

    for (int* c = arr + 1; c < end; c++) {
        if (*c % 2 == 0) {
            int value = *c;
            int* p = c;

            while (p > arr && (*(p - 1) % 2 != 0)) {
                *p = *(p - 1);
                p--;
            }

            *p = value;
        }
    }
}


int main() {

    int n;
    printf("Enter the number of array elements : ");
    scanf("%d",&n);

    int arr[n];
    for(int i=0;i<n;i++){
        printf("Element %d: ",i+1);
        scanf("%d",&arr[i]);

    }
    reorder(arr, n);

    printf("Modified array:\n");
    for (int i = 0; i < n; i++) {
        printf("%d ", *(arr + i));
    }

    return 0;
}


