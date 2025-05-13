#include <stdio.h>
#include <string.h>

typedef struct {
    char dayname[10];
    int task;
    char tasks[3][50];
} calendar;

int main() {
    calendar d[7];

    strcpy(d[0].dayname, "Monday");
    d[0].task = 0;
    strcpy(d[1].dayname, "Tuesday");
    d[1].task = 0;
    strcpy(d[2].dayname, "Wednesday");
    d[2].task = 0;
    strcpy(d[3].dayname, "Thursday");
    d[3].task = 0;
    strcpy(d[4].dayname, "Friday");
    d[4].task = 0;
    strcpy(d[5].dayname, "Saturday");
    d[5].task = 0;
    strcpy(d[6].dayname, "Sunday");
    d[6].task = 0;

    int c;

    while (1) {
        printf("\nMenu:\n1. Enter tasks\n2. Display tasks\n3. Exit\nChoose an option: ");
        scanf("%d", &c);

        if (c == 1) {
            char day[10];
            printf("Enter day: ");
            scanf("%s", day);

            int i = 0;
            while (i < 7 && strcmp(d[i].dayname, day) != 0) {
                i++;
            }

            if (i == 7) {
                printf("Invalid day entered!\n");
                continue;
            }

            printf("Till now %d tasks entered out of 3\n", d[i].task);
            printf("How many new tasks do you want to enter? ");
            int j = 0;
            scanf("%d", &j);

            if (j > 3 - d[i].task) {
                printf("Sorry! That exceeds the limit of 3 tasks per day. Try again.\n");
            } else {
                for (int k = d[i].task; k < j + d[i].task; k++) {
                    printf("Enter Task %d: ", k + 1);
                    scanf(" %[^\n]s", d[i].tasks[k]);
                }
                d[i].task += j;
            }
        }

        else if (c == 2) {
            char day[10];
            printf("Enter day to display tasks: ");
            scanf("%s", day);

            int i = 0;
            while (i < 7 && strcmp(d[i].dayname, day) != 0) {
                i++;
            }

            if (i == 7) {
                printf("Invalid day entered!\n");
                continue;
            }

            printf("\nDetails\nDay: %s\nNumber of tasks entered: %d\nTasks:\n", d[i].dayname, d[i].task);
            for (int k = 0; k < d[i].task; k++) {
                printf("- %s\n", d[i].tasks[k]);
            }
        }

        else if (c == 3) {
            printf("Exiting...\n");
            break;
        }

        else {
            printf("Invalid choice. Try again.\n");
        }
    }

    return 0;
}
