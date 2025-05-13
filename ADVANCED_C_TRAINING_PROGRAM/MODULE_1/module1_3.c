#include <stdio.h>

#define n 100

int main() {
    int rows, cols;
    int matrix[n][n];

    printf("Enter number of rows and columns: ");
    scanf("%d %d", &rows, &cols);

    printf("Enter matrix elements (row-wise, sorted by row and column):\n");
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            scanf("%d", *(matrix + i) + j);
        }
    }

    int key;
    printf("Enter the key to search: ");
    scanf("%d", &key);

    int i = 0, j = cols - 1;
    int found = 0;

    while (i < rows && j >= 0) {
        int current = *(*(matrix + i) + j);

        if (current == key) {
            printf("Key %d found at position (%d, %d)\n", key, i, j);
            found = 1;
            break;
        } else if (current > key) {
            j--;
        } else {
            i++;
        }
    }

    if (!found) {
        printf("Key %d not found in the matrix.\n", key);
    }

    return 0;
}

