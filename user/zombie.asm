
zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 1d 00 00 00       	call   33 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7f 0a                	jg     24 <main+0x24>
    sleep(5);  // Let child exit before parent.
  exit(0);
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 00                	push   $0x0
  1f:	e8 17 00 00 00       	call   3b <exit>
    sleep(5);  // Let child exit before parent.
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	6a 05                	push   $0x5
  29:	e8 9d 00 00 00       	call   cb <sleep>
  2e:	83 c4 10             	add    $0x10,%esp
  31:	eb e7                	jmp    1a <main+0x1a>

00000033 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  33:	b8 01 00 00 00       	mov    $0x1,%eax
  38:	cd 40                	int    $0x40
  3a:	c3                   	ret    

0000003b <exit>:
SYSCALL(exit)
  3b:	b8 02 00 00 00       	mov    $0x2,%eax
  40:	cd 40                	int    $0x40
  42:	c3                   	ret    

00000043 <wait>:
SYSCALL(wait)
  43:	b8 03 00 00 00       	mov    $0x3,%eax
  48:	cd 40                	int    $0x40
  4a:	c3                   	ret    

0000004b <pipe>:
SYSCALL(pipe)
  4b:	b8 04 00 00 00       	mov    $0x4,%eax
  50:	cd 40                	int    $0x40
  52:	c3                   	ret    

00000053 <read>:
SYSCALL(read)
  53:	b8 05 00 00 00       	mov    $0x5,%eax
  58:	cd 40                	int    $0x40
  5a:	c3                   	ret    

0000005b <write>:
SYSCALL(write)
  5b:	b8 10 00 00 00       	mov    $0x10,%eax
  60:	cd 40                	int    $0x40
  62:	c3                   	ret    

00000063 <close>:
SYSCALL(close)
  63:	b8 15 00 00 00       	mov    $0x15,%eax
  68:	cd 40                	int    $0x40
  6a:	c3                   	ret    

0000006b <kill>:
SYSCALL(kill)
  6b:	b8 06 00 00 00       	mov    $0x6,%eax
  70:	cd 40                	int    $0x40
  72:	c3                   	ret    

00000073 <exec>:
SYSCALL(exec)
  73:	b8 07 00 00 00       	mov    $0x7,%eax
  78:	cd 40                	int    $0x40
  7a:	c3                   	ret    

0000007b <open>:
SYSCALL(open)
  7b:	b8 0f 00 00 00       	mov    $0xf,%eax
  80:	cd 40                	int    $0x40
  82:	c3                   	ret    

00000083 <mknod>:
SYSCALL(mknod)
  83:	b8 11 00 00 00       	mov    $0x11,%eax
  88:	cd 40                	int    $0x40
  8a:	c3                   	ret    

0000008b <unlink>:
SYSCALL(unlink)
  8b:	b8 12 00 00 00       	mov    $0x12,%eax
  90:	cd 40                	int    $0x40
  92:	c3                   	ret    

00000093 <fstat>:
SYSCALL(fstat)
  93:	b8 08 00 00 00       	mov    $0x8,%eax
  98:	cd 40                	int    $0x40
  9a:	c3                   	ret    

0000009b <link>:
SYSCALL(link)
  9b:	b8 13 00 00 00       	mov    $0x13,%eax
  a0:	cd 40                	int    $0x40
  a2:	c3                   	ret    

000000a3 <mkdir>:
SYSCALL(mkdir)
  a3:	b8 14 00 00 00       	mov    $0x14,%eax
  a8:	cd 40                	int    $0x40
  aa:	c3                   	ret    

000000ab <chdir>:
SYSCALL(chdir)
  ab:	b8 09 00 00 00       	mov    $0x9,%eax
  b0:	cd 40                	int    $0x40
  b2:	c3                   	ret    

000000b3 <dup>:
SYSCALL(dup)
  b3:	b8 0a 00 00 00       	mov    $0xa,%eax
  b8:	cd 40                	int    $0x40
  ba:	c3                   	ret    

000000bb <getpid>:
SYSCALL(getpid)
  bb:	b8 0b 00 00 00       	mov    $0xb,%eax
  c0:	cd 40                	int    $0x40
  c2:	c3                   	ret    

000000c3 <sbrk>:
SYSCALL(sbrk)
  c3:	b8 0c 00 00 00       	mov    $0xc,%eax
  c8:	cd 40                	int    $0x40
  ca:	c3                   	ret    

000000cb <sleep>:
SYSCALL(sleep)
  cb:	b8 0d 00 00 00       	mov    $0xd,%eax
  d0:	cd 40                	int    $0x40
  d2:	c3                   	ret    

000000d3 <uptime>:
SYSCALL(uptime)
  d3:	b8 0e 00 00 00       	mov    $0xe,%eax
  d8:	cd 40                	int    $0x40
  da:	c3                   	ret    

000000db <date>:
SYSCALL(date)
  db:	b8 16 00 00 00       	mov    $0x16,%eax
  e0:	cd 40                	int    $0x40
  e2:	c3                   	ret    

000000e3 <dup2>:
SYSCALL(dup2)
  e3:	b8 17 00 00 00       	mov    $0x17,%eax
  e8:	cd 40                	int    $0x40
  ea:	c3                   	ret    
