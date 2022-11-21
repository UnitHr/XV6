
zombie:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  15:	e8 18 00 00 00       	call   32 <fork>
  1a:	85 c0                	test   %eax,%eax
  1c:	7f 05                	jg     23 <main+0x23>
    sleep(5);  // Let child exit before parent.
  exit();
  1e:	e8 17 00 00 00       	call   3a <exit>
    sleep(5);  // Let child exit before parent.
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	6a 05                	push   $0x5
  28:	e8 9d 00 00 00       	call   ca <sleep>
  2d:	83 c4 10             	add    $0x10,%esp
  30:	eb ec                	jmp    1e <main+0x1e>

00000032 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  32:	b8 01 00 00 00       	mov    $0x1,%eax
  37:	cd 40                	int    $0x40
  39:	c3                   	ret    

0000003a <exit>:
SYSCALL(exit)
  3a:	b8 02 00 00 00       	mov    $0x2,%eax
  3f:	cd 40                	int    $0x40
  41:	c3                   	ret    

00000042 <wait>:
SYSCALL(wait)
  42:	b8 03 00 00 00       	mov    $0x3,%eax
  47:	cd 40                	int    $0x40
  49:	c3                   	ret    

0000004a <pipe>:
SYSCALL(pipe)
  4a:	b8 04 00 00 00       	mov    $0x4,%eax
  4f:	cd 40                	int    $0x40
  51:	c3                   	ret    

00000052 <read>:
SYSCALL(read)
  52:	b8 05 00 00 00       	mov    $0x5,%eax
  57:	cd 40                	int    $0x40
  59:	c3                   	ret    

0000005a <write>:
SYSCALL(write)
  5a:	b8 10 00 00 00       	mov    $0x10,%eax
  5f:	cd 40                	int    $0x40
  61:	c3                   	ret    

00000062 <close>:
SYSCALL(close)
  62:	b8 15 00 00 00       	mov    $0x15,%eax
  67:	cd 40                	int    $0x40
  69:	c3                   	ret    

0000006a <kill>:
SYSCALL(kill)
  6a:	b8 06 00 00 00       	mov    $0x6,%eax
  6f:	cd 40                	int    $0x40
  71:	c3                   	ret    

00000072 <exec>:
SYSCALL(exec)
  72:	b8 07 00 00 00       	mov    $0x7,%eax
  77:	cd 40                	int    $0x40
  79:	c3                   	ret    

0000007a <open>:
SYSCALL(open)
  7a:	b8 0f 00 00 00       	mov    $0xf,%eax
  7f:	cd 40                	int    $0x40
  81:	c3                   	ret    

00000082 <mknod>:
SYSCALL(mknod)
  82:	b8 11 00 00 00       	mov    $0x11,%eax
  87:	cd 40                	int    $0x40
  89:	c3                   	ret    

0000008a <unlink>:
SYSCALL(unlink)
  8a:	b8 12 00 00 00       	mov    $0x12,%eax
  8f:	cd 40                	int    $0x40
  91:	c3                   	ret    

00000092 <fstat>:
SYSCALL(fstat)
  92:	b8 08 00 00 00       	mov    $0x8,%eax
  97:	cd 40                	int    $0x40
  99:	c3                   	ret    

0000009a <link>:
SYSCALL(link)
  9a:	b8 13 00 00 00       	mov    $0x13,%eax
  9f:	cd 40                	int    $0x40
  a1:	c3                   	ret    

000000a2 <mkdir>:
SYSCALL(mkdir)
  a2:	b8 14 00 00 00       	mov    $0x14,%eax
  a7:	cd 40                	int    $0x40
  a9:	c3                   	ret    

000000aa <chdir>:
SYSCALL(chdir)
  aa:	b8 09 00 00 00       	mov    $0x9,%eax
  af:	cd 40                	int    $0x40
  b1:	c3                   	ret    

000000b2 <dup>:
SYSCALL(dup)
  b2:	b8 0a 00 00 00       	mov    $0xa,%eax
  b7:	cd 40                	int    $0x40
  b9:	c3                   	ret    

000000ba <getpid>:
SYSCALL(getpid)
  ba:	b8 0b 00 00 00       	mov    $0xb,%eax
  bf:	cd 40                	int    $0x40
  c1:	c3                   	ret    

000000c2 <sbrk>:
SYSCALL(sbrk)
  c2:	b8 0c 00 00 00       	mov    $0xc,%eax
  c7:	cd 40                	int    $0x40
  c9:	c3                   	ret    

000000ca <sleep>:
SYSCALL(sleep)
  ca:	b8 0d 00 00 00       	mov    $0xd,%eax
  cf:	cd 40                	int    $0x40
  d1:	c3                   	ret    

000000d2 <uptime>:
SYSCALL(uptime)
  d2:	b8 0e 00 00 00       	mov    $0xe,%eax
  d7:	cd 40                	int    $0x40
  d9:	c3                   	ret    

000000da <date>:
SYSCALL(date)
  da:	b8 16 00 00 00       	mov    $0x16,%eax
  df:	cd 40                	int    $0x40
  e1:	c3                   	ret    

000000e2 <dup2>:
SYSCALL(dup2)
  e2:	b8 17 00 00 00       	mov    $0x17,%eax
  e7:	cd 40                	int    $0x40
  e9:	c3                   	ret    
