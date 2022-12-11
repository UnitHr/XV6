// Test that fork fails gracefully.
// Tiny executable so that the limit can be filling the proc table.

#include "types.h"
#include "stat.h"
#include "user.h"

#define N  1000


int
main(void)
{
  enum proc_prio prio = getprio(getpid());
  printf("%d %d", getpid(), prio);
  if(fork()) setprio(getpid(), HI_PRIO);
  enum proc_prio prio = getprio(getpid());
  exit(0);
}

 