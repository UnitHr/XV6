#include "types.h"
#include "user.h"
#include "fcntl.h"

int main()
{
    // Test priority scheduling
    int pid = fork();
    switch (pid)
    {
    case -1:
        printf(1, "Error: fork failed");
        break;
    case 0:
        // Child
        // FORK
        int pid2 = fork();
        wait(NULL);
        int message = 1;
        if (pid2 == 0)
        {
            message++;
        }
        else
        {
            int priority = getprio(pid);
            printf(1, "Child Priority2: %d", priority);
        }
        return 0;
        break;
    }

    // Parent
    wait(NULL);
    setprio(pid, 1);
    int priority = getprio(pid);
    int myPriority = getprio(getpid());
    printf(1, "Parent Priority: %d", myPriority);
    printf(1, "Child Priority: %d", priority);
    return 0;
}