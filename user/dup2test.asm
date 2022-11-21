
dup2test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(int argc, char* argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int fd;

  // Ejemplo de dup2 con un fd incorrecto
  if (dup2 (-1,8) >= 0)
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 08                	push   $0x8
  14:	6a ff                	push   $0xffffffff
  16:	e8 ea 03 00 00       	call   405 <dup2>
  1b:	83 c4 10             	add    $0x10,%esp
  1e:	85 c0                	test   %eax,%eax
  20:	0f 89 ed 01 00 00    	jns    213 <main+0x213>
    printf (2, "dup2 no funciona con fd incorrecto.\n");

  // Ejemplo de dup2 con un newfd incorrecto
  if (dup2 (1,-1) >= 0)
  26:	83 ec 08             	sub    $0x8,%esp
  29:	6a ff                	push   $0xffffffff
  2b:	6a 01                	push   $0x1
  2d:	e8 d3 03 00 00       	call   405 <dup2>
  32:	83 c4 10             	add    $0x10,%esp
  35:	85 c0                	test   %eax,%eax
  37:	0f 89 ed 01 00 00    	jns    22a <main+0x22a>
    printf (2, "dup2 no funciona con fd incorrecto (2).\n");

  // Ejemplo de dup2 con un fd no mapeado
  if (dup2 (6,8) >= 0)
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	6a 08                	push   $0x8
  42:	6a 06                	push   $0x6
  44:	e8 bc 03 00 00       	call   405 <dup2>
  49:	83 c4 10             	add    $0x10,%esp
  4c:	85 c0                	test   %eax,%eax
  4e:	0f 89 ed 01 00 00    	jns    241 <main+0x241>
    printf (2, "dup2 no funciona con fd no mapeado.\n");

  // Ejemplo de dup2 con un fd no mapeado (2)
  if (dup2 (8,1) >= 0)
  54:	83 ec 08             	sub    $0x8,%esp
  57:	6a 01                	push   $0x1
  59:	6a 08                	push   $0x8
  5b:	e8 a5 03 00 00       	call   405 <dup2>
  60:	83 c4 10             	add    $0x10,%esp
  63:	85 c0                	test   %eax,%eax
  65:	0f 89 ed 01 00 00    	jns    258 <main+0x258>
    printf (2, "dup2 no funciona con fd no mapeado (2).\n");

  if (dup2 (1,25) >= 0)
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	6a 19                	push   $0x19
  70:	6a 01                	push   $0x1
  72:	e8 8e 03 00 00       	call   405 <dup2>
  77:	83 c4 10             	add    $0x10,%esp
  7a:	85 c0                	test   %eax,%eax
  7c:	0f 89 ed 01 00 00    	jns    26f <main+0x26f>
    printf (2, "dup2 no funciona con fd superior a NOFILE.\n");

  // Ejemplo de dup2 con fd existente
  if (dup2 (1,4) != 4)
  82:	83 ec 08             	sub    $0x8,%esp
  85:	6a 04                	push   $0x4
  87:	6a 01                	push   $0x1
  89:	e8 77 03 00 00       	call   405 <dup2>
  8e:	83 c4 10             	add    $0x10,%esp
  91:	83 f8 04             	cmp    $0x4,%eax
  94:	0f 85 ec 01 00 00    	jne    286 <main+0x286>
    printf (2, "dup2 no funciona con fd existente.\n");

  printf (4, "Este mensaje debe salir por terminal.\n");
  9a:	83 ec 08             	sub    $0x8,%esp
  9d:	68 f8 06 00 00       	push   $0x6f8
  a2:	6a 04                	push   $0x4
  a4:	e8 f7 03 00 00       	call   4a0 <printf>

  if (dup2 (4,6) != 6)
  a9:	83 c4 08             	add    $0x8,%esp
  ac:	6a 06                	push   $0x6
  ae:	6a 04                	push   $0x4
  b0:	e8 50 03 00 00       	call   405 <dup2>
  b5:	83 c4 10             	add    $0x10,%esp
  b8:	83 f8 06             	cmp    $0x6,%eax
  bb:	0f 85 dc 01 00 00    	jne    29d <main+0x29d>
    printf (2, "dup2 no funciona con fd existente (2).\n");

  printf (6, "Este mensaje debe salir por terminal (2).\n");
  c1:	83 ec 08             	sub    $0x8,%esp
  c4:	68 48 07 00 00       	push   $0x748
  c9:	6a 06                	push   $0x6
  cb:	e8 d0 03 00 00       	call   4a0 <printf>

  if (close (4) != 0)
  d0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  d7:	e8 a9 02 00 00       	call   385 <close>
  dc:	83 c4 10             	add    $0x10,%esp
  df:	85 c0                	test   %eax,%eax
  e1:	0f 85 cd 01 00 00    	jne    2b4 <main+0x2b4>
    printf (2, "Error en close (4)\n");
  printf (6, "Este mensaje debe salir por terminal (3).\n");
  e7:	83 ec 08             	sub    $0x8,%esp
  ea:	68 74 07 00 00       	push   $0x774
  ef:	6a 06                	push   $0x6
  f1:	e8 aa 03 00 00       	call   4a0 <printf>
  if (close (6) != 0)
  f6:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
  fd:	e8 83 02 00 00       	call   385 <close>
 102:	83 c4 10             	add    $0x10,%esp
 105:	85 c0                	test   %eax,%eax
 107:	0f 85 be 01 00 00    	jne    2cb <main+0x2cb>
    printf (2, "Error en close (6)\n");
  if (close (6) == 0)
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	6a 06                	push   $0x6
 112:	e8 6e 02 00 00       	call   385 <close>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 84 c0 01 00 00    	je     2e2 <main+0x2e2>
    printf (2, "Error en close (6) (2)\n");

  fd = open ("fichero_salida.txt", O_CREATE|O_RDWR);
 122:	83 ec 08             	sub    $0x8,%esp
 125:	68 02 02 00 00       	push   $0x202
 12a:	68 54 08 00 00       	push   $0x854
 12f:	e8 69 02 00 00       	call   39d <open>
 134:	89 c3                	mov    %eax,%ebx
  printf (fd, "Salida a fichero\n");
 136:	83 c4 08             	add    $0x8,%esp
 139:	68 67 08 00 00       	push   $0x867
 13e:	50                   	push   %eax
 13f:	e8 5c 03 00 00       	call   4a0 <printf>

  if (dup2 (fd, 9) != 9)
 144:	83 c4 08             	add    $0x8,%esp
 147:	6a 09                	push   $0x9
 149:	53                   	push   %ebx
 14a:	e8 b6 02 00 00       	call   405 <dup2>
 14f:	83 c4 10             	add    $0x10,%esp
 152:	83 f8 09             	cmp    $0x9,%eax
 155:	0f 85 9e 01 00 00    	jne    2f9 <main+0x2f9>
    printf (2, "dup2 no funciona con fd existente (3).\n");

  printf (9, "Salida también a fichero.\n");
 15b:	83 ec 08             	sub    $0x8,%esp
 15e:	68 79 08 00 00       	push   $0x879
 163:	6a 09                	push   $0x9
 165:	e8 36 03 00 00       	call   4a0 <printf>

  if (dup2 (9, 9) != 9)
 16a:	83 c4 08             	add    $0x8,%esp
 16d:	6a 09                	push   $0x9
 16f:	6a 09                	push   $0x9
 171:	e8 8f 02 00 00       	call   405 <dup2>
 176:	83 c4 10             	add    $0x10,%esp
 179:	83 f8 09             	cmp    $0x9,%eax
 17c:	0f 85 8e 01 00 00    	jne    310 <main+0x310>
    printf (2, "dup2 no funciona con newfd=oldfd.\n");

  printf (9, "Salida también a fichero.\n");
 182:	83 ec 08             	sub    $0x8,%esp
 185:	68 79 08 00 00       	push   $0x879
 18a:	6a 09                	push   $0x9
 18c:	e8 0f 03 00 00       	call   4a0 <printf>

  close (9);
 191:	c7 04 24 09 00 00 00 	movl   $0x9,(%esp)
 198:	e8 e8 01 00 00       	call   385 <close>

  dup2 (1, 6);
 19d:	83 c4 08             	add    $0x8,%esp
 1a0:	6a 06                	push   $0x6
 1a2:	6a 01                	push   $0x1
 1a4:	e8 5c 02 00 00       	call   405 <dup2>

  if (dup2 (fd, 1) != 1)
 1a9:	83 c4 08             	add    $0x8,%esp
 1ac:	6a 01                	push   $0x1
 1ae:	53                   	push   %ebx
 1af:	e8 51 02 00 00       	call   405 <dup2>
 1b4:	83 c4 10             	add    $0x10,%esp
 1b7:	83 f8 01             	cmp    $0x1,%eax
 1ba:	0f 85 67 01 00 00    	jne    327 <main+0x327>
    printf (2, "dup2 no funciona con fd existente (4).\n");

  printf (1, "Cuarta salida a fichero.\n");
 1c0:	83 ec 08             	sub    $0x8,%esp
 1c3:	68 95 08 00 00       	push   $0x895
 1c8:	6a 01                	push   $0x1
 1ca:	e8 d1 02 00 00       	call   4a0 <printf>
  if (close (1) != 0)
 1cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1d6:	e8 aa 01 00 00       	call   385 <close>
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	85 c0                	test   %eax,%eax
 1e0:	0f 85 58 01 00 00    	jne    33e <main+0x33e>
    printf (2, "Error en close (1).\n");

  dup2 (6,fd);
 1e6:	83 ec 08             	sub    $0x8,%esp
 1e9:	53                   	push   %ebx
 1ea:	6a 06                	push   $0x6
 1ec:	e8 14 02 00 00       	call   405 <dup2>

  printf (fd, "Este mensaje debe salir por terminal.\n");
 1f1:	83 c4 08             	add    $0x8,%esp
 1f4:	68 f8 06 00 00       	push   $0x6f8
 1f9:	53                   	push   %ebx
 1fa:	e8 a1 02 00 00       	call   4a0 <printf>
  close (fd);
 1ff:	89 1c 24             	mov    %ebx,(%esp)
 202:	e8 7e 01 00 00       	call   385 <close>

  exit(0);
 207:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 20e:	e8 4a 01 00 00       	call   35d <exit>
    printf (2, "dup2 no funciona con fd incorrecto.\n");
 213:	83 ec 08             	sub    $0x8,%esp
 216:	68 00 06 00 00       	push   $0x600
 21b:	6a 02                	push   $0x2
 21d:	e8 7e 02 00 00       	call   4a0 <printf>
 222:	83 c4 10             	add    $0x10,%esp
 225:	e9 fc fd ff ff       	jmp    26 <main+0x26>
    printf (2, "dup2 no funciona con fd incorrecto (2).\n");
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	68 28 06 00 00       	push   $0x628
 232:	6a 02                	push   $0x2
 234:	e8 67 02 00 00       	call   4a0 <printf>
 239:	83 c4 10             	add    $0x10,%esp
 23c:	e9 fc fd ff ff       	jmp    3d <main+0x3d>
    printf (2, "dup2 no funciona con fd no mapeado.\n");
 241:	83 ec 08             	sub    $0x8,%esp
 244:	68 54 06 00 00       	push   $0x654
 249:	6a 02                	push   $0x2
 24b:	e8 50 02 00 00       	call   4a0 <printf>
 250:	83 c4 10             	add    $0x10,%esp
 253:	e9 fc fd ff ff       	jmp    54 <main+0x54>
    printf (2, "dup2 no funciona con fd no mapeado (2).\n");
 258:	83 ec 08             	sub    $0x8,%esp
 25b:	68 7c 06 00 00       	push   $0x67c
 260:	6a 02                	push   $0x2
 262:	e8 39 02 00 00       	call   4a0 <printf>
 267:	83 c4 10             	add    $0x10,%esp
 26a:	e9 fc fd ff ff       	jmp    6b <main+0x6b>
    printf (2, "dup2 no funciona con fd superior a NOFILE.\n");
 26f:	83 ec 08             	sub    $0x8,%esp
 272:	68 a8 06 00 00       	push   $0x6a8
 277:	6a 02                	push   $0x2
 279:	e8 22 02 00 00       	call   4a0 <printf>
 27e:	83 c4 10             	add    $0x10,%esp
 281:	e9 fc fd ff ff       	jmp    82 <main+0x82>
    printf (2, "dup2 no funciona con fd existente.\n");
 286:	83 ec 08             	sub    $0x8,%esp
 289:	68 d4 06 00 00       	push   $0x6d4
 28e:	6a 02                	push   $0x2
 290:	e8 0b 02 00 00       	call   4a0 <printf>
 295:	83 c4 10             	add    $0x10,%esp
 298:	e9 fd fd ff ff       	jmp    9a <main+0x9a>
    printf (2, "dup2 no funciona con fd existente (2).\n");
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	68 20 07 00 00       	push   $0x720
 2a5:	6a 02                	push   $0x2
 2a7:	e8 f4 01 00 00       	call   4a0 <printf>
 2ac:	83 c4 10             	add    $0x10,%esp
 2af:	e9 0d fe ff ff       	jmp    c1 <main+0xc1>
    printf (2, "Error en close (4)\n");
 2b4:	83 ec 08             	sub    $0x8,%esp
 2b7:	68 14 08 00 00       	push   $0x814
 2bc:	6a 02                	push   $0x2
 2be:	e8 dd 01 00 00       	call   4a0 <printf>
 2c3:	83 c4 10             	add    $0x10,%esp
 2c6:	e9 1c fe ff ff       	jmp    e7 <main+0xe7>
    printf (2, "Error en close (6)\n");
 2cb:	83 ec 08             	sub    $0x8,%esp
 2ce:	68 28 08 00 00       	push   $0x828
 2d3:	6a 02                	push   $0x2
 2d5:	e8 c6 01 00 00       	call   4a0 <printf>
 2da:	83 c4 10             	add    $0x10,%esp
 2dd:	e9 2b fe ff ff       	jmp    10d <main+0x10d>
    printf (2, "Error en close (6) (2)\n");
 2e2:	83 ec 08             	sub    $0x8,%esp
 2e5:	68 3c 08 00 00       	push   $0x83c
 2ea:	6a 02                	push   $0x2
 2ec:	e8 af 01 00 00       	call   4a0 <printf>
 2f1:	83 c4 10             	add    $0x10,%esp
 2f4:	e9 29 fe ff ff       	jmp    122 <main+0x122>
    printf (2, "dup2 no funciona con fd existente (3).\n");
 2f9:	83 ec 08             	sub    $0x8,%esp
 2fc:	68 a0 07 00 00       	push   $0x7a0
 301:	6a 02                	push   $0x2
 303:	e8 98 01 00 00       	call   4a0 <printf>
 308:	83 c4 10             	add    $0x10,%esp
 30b:	e9 4b fe ff ff       	jmp    15b <main+0x15b>
    printf (2, "dup2 no funciona con newfd=oldfd.\n");
 310:	83 ec 08             	sub    $0x8,%esp
 313:	68 c8 07 00 00       	push   $0x7c8
 318:	6a 02                	push   $0x2
 31a:	e8 81 01 00 00       	call   4a0 <printf>
 31f:	83 c4 10             	add    $0x10,%esp
 322:	e9 5b fe ff ff       	jmp    182 <main+0x182>
    printf (2, "dup2 no funciona con fd existente (4).\n");
 327:	83 ec 08             	sub    $0x8,%esp
 32a:	68 ec 07 00 00       	push   $0x7ec
 32f:	6a 02                	push   $0x2
 331:	e8 6a 01 00 00       	call   4a0 <printf>
 336:	83 c4 10             	add    $0x10,%esp
 339:	e9 82 fe ff ff       	jmp    1c0 <main+0x1c0>
    printf (2, "Error en close (1).\n");
 33e:	83 ec 08             	sub    $0x8,%esp
 341:	68 af 08 00 00       	push   $0x8af
 346:	6a 02                	push   $0x2
 348:	e8 53 01 00 00       	call   4a0 <printf>
 34d:	83 c4 10             	add    $0x10,%esp
 350:	e9 91 fe ff ff       	jmp    1e6 <main+0x1e6>

00000355 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 355:	b8 01 00 00 00       	mov    $0x1,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <exit>:
SYSCALL(exit)
 35d:	b8 02 00 00 00       	mov    $0x2,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <wait>:
SYSCALL(wait)
 365:	b8 03 00 00 00       	mov    $0x3,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <pipe>:
SYSCALL(pipe)
 36d:	b8 04 00 00 00       	mov    $0x4,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <read>:
SYSCALL(read)
 375:	b8 05 00 00 00       	mov    $0x5,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <write>:
SYSCALL(write)
 37d:	b8 10 00 00 00       	mov    $0x10,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <close>:
SYSCALL(close)
 385:	b8 15 00 00 00       	mov    $0x15,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <kill>:
SYSCALL(kill)
 38d:	b8 06 00 00 00       	mov    $0x6,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <exec>:
SYSCALL(exec)
 395:	b8 07 00 00 00       	mov    $0x7,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <open>:
SYSCALL(open)
 39d:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <mknod>:
SYSCALL(mknod)
 3a5:	b8 11 00 00 00       	mov    $0x11,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <unlink>:
SYSCALL(unlink)
 3ad:	b8 12 00 00 00       	mov    $0x12,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <fstat>:
SYSCALL(fstat)
 3b5:	b8 08 00 00 00       	mov    $0x8,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <link>:
SYSCALL(link)
 3bd:	b8 13 00 00 00       	mov    $0x13,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <mkdir>:
SYSCALL(mkdir)
 3c5:	b8 14 00 00 00       	mov    $0x14,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <chdir>:
SYSCALL(chdir)
 3cd:	b8 09 00 00 00       	mov    $0x9,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <dup>:
SYSCALL(dup)
 3d5:	b8 0a 00 00 00       	mov    $0xa,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <getpid>:
SYSCALL(getpid)
 3dd:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <sbrk>:
SYSCALL(sbrk)
 3e5:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <sleep>:
SYSCALL(sleep)
 3ed:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <uptime>:
SYSCALL(uptime)
 3f5:	b8 0e 00 00 00       	mov    $0xe,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <date>:
SYSCALL(date)
 3fd:	b8 16 00 00 00       	mov    $0x16,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <dup2>:
SYSCALL(dup2)
 405:	b8 17 00 00 00       	mov    $0x17,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40d:	55                   	push   %ebp
 40e:	89 e5                	mov    %esp,%ebp
 410:	83 ec 1c             	sub    $0x1c,%esp
 413:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 416:	6a 01                	push   $0x1
 418:	8d 55 f4             	lea    -0xc(%ebp),%edx
 41b:	52                   	push   %edx
 41c:	50                   	push   %eax
 41d:	e8 5b ff ff ff       	call   37d <write>
}
 422:	83 c4 10             	add    $0x10,%esp
 425:	c9                   	leave  
 426:	c3                   	ret    

00000427 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 427:	55                   	push   %ebp
 428:	89 e5                	mov    %esp,%ebp
 42a:	57                   	push   %edi
 42b:	56                   	push   %esi
 42c:	53                   	push   %ebx
 42d:	83 ec 2c             	sub    $0x2c,%esp
 430:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 433:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 435:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 439:	74 04                	je     43f <printint+0x18>
 43b:	85 d2                	test   %edx,%edx
 43d:	78 3c                	js     47b <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 43f:	89 d1                	mov    %edx,%ecx
  neg = 0;
 441:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 448:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 44d:	89 c8                	mov    %ecx,%eax
 44f:	ba 00 00 00 00       	mov    $0x0,%edx
 454:	f7 f6                	div    %esi
 456:	89 df                	mov    %ebx,%edi
 458:	43                   	inc    %ebx
 459:	8a 92 24 09 00 00    	mov    0x924(%edx),%dl
 45f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 463:	89 ca                	mov    %ecx,%edx
 465:	89 c1                	mov    %eax,%ecx
 467:	39 d6                	cmp    %edx,%esi
 469:	76 e2                	jbe    44d <printint+0x26>
  if(neg)
 46b:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 46f:	74 24                	je     495 <printint+0x6e>
    buf[i++] = '-';
 471:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 476:	8d 5f 02             	lea    0x2(%edi),%ebx
 479:	eb 1a                	jmp    495 <printint+0x6e>
    x = -xx;
 47b:	89 d1                	mov    %edx,%ecx
 47d:	f7 d9                	neg    %ecx
    neg = 1;
 47f:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 486:	eb c0                	jmp    448 <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 488:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 48d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 490:	e8 78 ff ff ff       	call   40d <putc>
  while(--i >= 0)
 495:	4b                   	dec    %ebx
 496:	79 f0                	jns    488 <printint+0x61>
}
 498:	83 c4 2c             	add    $0x2c,%esp
 49b:	5b                   	pop    %ebx
 49c:	5e                   	pop    %esi
 49d:	5f                   	pop    %edi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4a9:	8d 45 10             	lea    0x10(%ebp),%eax
 4ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 4af:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 4b4:	bb 00 00 00 00       	mov    $0x0,%ebx
 4b9:	eb 12                	jmp    4cd <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4bb:	89 fa                	mov    %edi,%edx
 4bd:	8b 45 08             	mov    0x8(%ebp),%eax
 4c0:	e8 48 ff ff ff       	call   40d <putc>
 4c5:	eb 05                	jmp    4cc <printf+0x2c>
      }
    } else if(state == '%'){
 4c7:	83 fe 25             	cmp    $0x25,%esi
 4ca:	74 22                	je     4ee <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 4cc:	43                   	inc    %ebx
 4cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d0:	8a 04 18             	mov    (%eax,%ebx,1),%al
 4d3:	84 c0                	test   %al,%al
 4d5:	0f 84 1d 01 00 00    	je     5f8 <printf+0x158>
    c = fmt[i] & 0xff;
 4db:	0f be f8             	movsbl %al,%edi
 4de:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 4e1:	85 f6                	test   %esi,%esi
 4e3:	75 e2                	jne    4c7 <printf+0x27>
      if(c == '%'){
 4e5:	83 f8 25             	cmp    $0x25,%eax
 4e8:	75 d1                	jne    4bb <printf+0x1b>
        state = '%';
 4ea:	89 c6                	mov    %eax,%esi
 4ec:	eb de                	jmp    4cc <printf+0x2c>
      if(c == 'd'){
 4ee:	83 f8 25             	cmp    $0x25,%eax
 4f1:	0f 84 cc 00 00 00    	je     5c3 <printf+0x123>
 4f7:	0f 8c da 00 00 00    	jl     5d7 <printf+0x137>
 4fd:	83 f8 78             	cmp    $0x78,%eax
 500:	0f 8f d1 00 00 00    	jg     5d7 <printf+0x137>
 506:	83 f8 63             	cmp    $0x63,%eax
 509:	0f 8c c8 00 00 00    	jl     5d7 <printf+0x137>
 50f:	83 e8 63             	sub    $0x63,%eax
 512:	83 f8 15             	cmp    $0x15,%eax
 515:	0f 87 bc 00 00 00    	ja     5d7 <printf+0x137>
 51b:	ff 24 85 cc 08 00 00 	jmp    *0x8cc(,%eax,4)
        printint(fd, *ap, 10, 1);
 522:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 525:	8b 17                	mov    (%edi),%edx
 527:	83 ec 0c             	sub    $0xc,%esp
 52a:	6a 01                	push   $0x1
 52c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 531:	8b 45 08             	mov    0x8(%ebp),%eax
 534:	e8 ee fe ff ff       	call   427 <printint>
        ap++;
 539:	83 c7 04             	add    $0x4,%edi
 53c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 53f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 542:	be 00 00 00 00       	mov    $0x0,%esi
 547:	eb 83                	jmp    4cc <printf+0x2c>
        printint(fd, *ap, 16, 0);
 549:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 54c:	8b 17                	mov    (%edi),%edx
 54e:	83 ec 0c             	sub    $0xc,%esp
 551:	6a 00                	push   $0x0
 553:	b9 10 00 00 00       	mov    $0x10,%ecx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	e8 c7 fe ff ff       	call   427 <printint>
        ap++;
 560:	83 c7 04             	add    $0x4,%edi
 563:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 566:	83 c4 10             	add    $0x10,%esp
      state = 0;
 569:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 56e:	e9 59 ff ff ff       	jmp    4cc <printf+0x2c>
        s = (char*)*ap;
 573:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 576:	8b 30                	mov    (%eax),%esi
        ap++;
 578:	83 c0 04             	add    $0x4,%eax
 57b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 57e:	85 f6                	test   %esi,%esi
 580:	75 13                	jne    595 <printf+0xf5>
          s = "(null)";
 582:	be c4 08 00 00       	mov    $0x8c4,%esi
 587:	eb 0c                	jmp    595 <printf+0xf5>
          putc(fd, *s);
 589:	0f be d2             	movsbl %dl,%edx
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
 58f:	e8 79 fe ff ff       	call   40d <putc>
          s++;
 594:	46                   	inc    %esi
        while(*s != 0){
 595:	8a 16                	mov    (%esi),%dl
 597:	84 d2                	test   %dl,%dl
 599:	75 ee                	jne    589 <printf+0xe9>
      state = 0;
 59b:	be 00 00 00 00       	mov    $0x0,%esi
 5a0:	e9 27 ff ff ff       	jmp    4cc <printf+0x2c>
        putc(fd, *ap);
 5a5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5a8:	0f be 17             	movsbl (%edi),%edx
 5ab:	8b 45 08             	mov    0x8(%ebp),%eax
 5ae:	e8 5a fe ff ff       	call   40d <putc>
        ap++;
 5b3:	83 c7 04             	add    $0x4,%edi
 5b6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 5b9:	be 00 00 00 00       	mov    $0x0,%esi
 5be:	e9 09 ff ff ff       	jmp    4cc <printf+0x2c>
        putc(fd, c);
 5c3:	89 fa                	mov    %edi,%edx
 5c5:	8b 45 08             	mov    0x8(%ebp),%eax
 5c8:	e8 40 fe ff ff       	call   40d <putc>
      state = 0;
 5cd:	be 00 00 00 00       	mov    $0x0,%esi
 5d2:	e9 f5 fe ff ff       	jmp    4cc <printf+0x2c>
        putc(fd, '%');
 5d7:	ba 25 00 00 00       	mov    $0x25,%edx
 5dc:	8b 45 08             	mov    0x8(%ebp),%eax
 5df:	e8 29 fe ff ff       	call   40d <putc>
        putc(fd, c);
 5e4:	89 fa                	mov    %edi,%edx
 5e6:	8b 45 08             	mov    0x8(%ebp),%eax
 5e9:	e8 1f fe ff ff       	call   40d <putc>
      state = 0;
 5ee:	be 00 00 00 00       	mov    $0x0,%esi
 5f3:	e9 d4 fe ff ff       	jmp    4cc <printf+0x2c>
    }
  }
}
 5f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5fb:	5b                   	pop    %ebx
 5fc:	5e                   	pop    %esi
 5fd:	5f                   	pop    %edi
 5fe:	5d                   	pop    %ebp
 5ff:	c3                   	ret    
