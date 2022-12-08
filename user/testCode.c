// Test that fork fails gracefully.
// Tiny executable so that the limit can be filling the proc table.

#include "types.h"
#include "stat.h"
#include "user.h"

#define N  1000


#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  srbk(-66000);
  /*int * n = malloc(sizeof(int));
  sbrk(-sizeof(int));
  *n = 4;*/

  exit(0);
}