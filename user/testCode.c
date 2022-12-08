// Test that fork fails gracefully.
// Tiny executable so that the limit can be filling the proc table.

#include "types.h"
#include "stat.h"
#include "user.h"

#define N  1000


int
main(void)
{
  int * pantalla =malloc(sizeof(int));
  *pantalla = 0;
  int pid = fork();
  int hijo = 0;
  if(pid == 0){
    hijo = 1;
    setprio(getpid(), 1);
    int ppid = fork();
    if(ppid == 0){
      hijo++;
    }
  } else {
    fork();
  }

  fork();
  fork();


  //FORCE WAIT 
  for(int i = 0; i < 10000000; i++){
    int a = 0;
    int c; 
    if(&a == &c) a = 1;
    if(a == 2) {
      printf(1, "a = 2\n");
    }
  }
  
  while(*pantalla){

  }
  *pantalla = 1;
  printf(1, "pid %d, prioridad %d hijo: %d\n", getpid(), hijo, getprio(getpid()));
  *pantalla = 0;
  int c;
  if(pantalla == &c){
    printf(1, "pantalla = 2\n");
  }
  exit(0);
}
