
dup2test:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(int argc, char* argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  int fd;

  // Ejemplo de dup2 con un fd incorrecto
  if (dup2 (-1,8) >= 0)
  13:	83 ec 08             	sub    $0x8,%esp
  16:	6a 08                	push   $0x8
  18:	6a ff                	push   $0xffffffff
  1a:	e8 e3 03 00 00       	call   402 <dup2>
  1f:	83 c4 10             	add    $0x10,%esp
  22:	85 c0                	test   %eax,%eax
  24:	0f 89 e6 01 00 00    	jns    210 <main+0x210>
    printf (2, "dup2 no funciona con fd incorrecto.\n");

  // Ejemplo de dup2 con un newfd incorrecto
  if (dup2 (1,-1) >= 0)
  2a:	83 ec 08             	sub    $0x8,%esp
  2d:	6a ff                	push   $0xffffffff
  2f:	6a 01                	push   $0x1
  31:	e8 cc 03 00 00       	call   402 <dup2>
  36:	83 c4 10             	add    $0x10,%esp
  39:	85 c0                	test   %eax,%eax
  3b:	0f 89 e6 01 00 00    	jns    227 <main+0x227>
    printf (2, "dup2 no funciona con fd incorrecto (2).\n");

  // Ejemplo de dup2 con un fd no mapeado
  if (dup2 (6,8) >= 0)
  41:	83 ec 08             	sub    $0x8,%esp
  44:	6a 08                	push   $0x8
  46:	6a 06                	push   $0x6
  48:	e8 b5 03 00 00       	call   402 <dup2>
  4d:	83 c4 10             	add    $0x10,%esp
  50:	85 c0                	test   %eax,%eax
  52:	0f 89 e6 01 00 00    	jns    23e <main+0x23e>
    printf (2, "dup2 no funciona con fd no mapeado.\n");

  // Ejemplo de dup2 con un fd no mapeado (2)
  if (dup2 (8,1) >= 0)
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	6a 01                	push   $0x1
  5d:	6a 08                	push   $0x8
  5f:	e8 9e 03 00 00       	call   402 <dup2>
  64:	83 c4 10             	add    $0x10,%esp
  67:	85 c0                	test   %eax,%eax
  69:	0f 89 e6 01 00 00    	jns    255 <main+0x255>
    printf (2, "dup2 no funciona con fd no mapeado (2).\n");

  if (dup2 (1,25) >= 0)
  6f:	83 ec 08             	sub    $0x8,%esp
  72:	6a 19                	push   $0x19
  74:	6a 01                	push   $0x1
  76:	e8 87 03 00 00       	call   402 <dup2>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	85 c0                	test   %eax,%eax
  80:	0f 89 e6 01 00 00    	jns    26c <main+0x26c>
    printf (2, "dup2 no funciona con fd superior a NOFILE.\n");

  // Ejemplo de dup2 con fd existente
  if (dup2 (1,4) != 4)
  86:	83 ec 08             	sub    $0x8,%esp
  89:	6a 04                	push   $0x4
  8b:	6a 01                	push   $0x1
  8d:	e8 70 03 00 00       	call   402 <dup2>
  92:	83 c4 10             	add    $0x10,%esp
  95:	83 f8 04             	cmp    $0x4,%eax
  98:	0f 85 e5 01 00 00    	jne    283 <main+0x283>
    printf (2, "dup2 no funciona con fd existente.\n");

  printf (4, "Este mensaje debe salir por terminal.\n");
  9e:	83 ec 08             	sub    $0x8,%esp
  a1:	68 ec 06 00 00       	push   $0x6ec
  a6:	6a 04                	push   $0x4
  a8:	e8 ec 03 00 00       	call   499 <printf>

  if (dup2 (4,6) != 6)
  ad:	83 c4 08             	add    $0x8,%esp
  b0:	6a 06                	push   $0x6
  b2:	6a 04                	push   $0x4
  b4:	e8 49 03 00 00       	call   402 <dup2>
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	83 f8 06             	cmp    $0x6,%eax
  bf:	0f 85 d5 01 00 00    	jne    29a <main+0x29a>
    printf (2, "dup2 no funciona con fd existente (2).\n");

  printf (6, "Este mensaje debe salir por terminal (2).\n");
  c5:	83 ec 08             	sub    $0x8,%esp
  c8:	68 3c 07 00 00       	push   $0x73c
  cd:	6a 06                	push   $0x6
  cf:	e8 c5 03 00 00       	call   499 <printf>

  if (close (4) != 0)
  d4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  db:	e8 a2 02 00 00       	call   382 <close>
  e0:	83 c4 10             	add    $0x10,%esp
  e3:	85 c0                	test   %eax,%eax
  e5:	0f 85 c6 01 00 00    	jne    2b1 <main+0x2b1>
    printf (2, "Error en close (4)\n");
  printf (6, "Este mensaje debe salir por terminal (3).\n");
  eb:	83 ec 08             	sub    $0x8,%esp
  ee:	68 68 07 00 00       	push   $0x768
  f3:	6a 06                	push   $0x6
  f5:	e8 9f 03 00 00       	call   499 <printf>
  if (close (6) != 0)
  fa:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
 101:	e8 7c 02 00 00       	call   382 <close>
 106:	83 c4 10             	add    $0x10,%esp
 109:	85 c0                	test   %eax,%eax
 10b:	0f 85 b7 01 00 00    	jne    2c8 <main+0x2c8>
    printf (2, "Error en close (6)\n");
  if (close (6) == 0)
 111:	83 ec 0c             	sub    $0xc,%esp
 114:	6a 06                	push   $0x6
 116:	e8 67 02 00 00       	call   382 <close>
 11b:	83 c4 10             	add    $0x10,%esp
 11e:	85 c0                	test   %eax,%eax
 120:	0f 84 b9 01 00 00    	je     2df <main+0x2df>
    printf (2, "Error en close (6) (2)\n");

  fd = open ("fichero_salida.txt", O_CREATE|O_RDWR);
 126:	83 ec 08             	sub    $0x8,%esp
 129:	68 02 02 00 00       	push   $0x202
 12e:	68 48 08 00 00       	push   $0x848
 133:	e8 62 02 00 00       	call   39a <open>
 138:	89 c3                	mov    %eax,%ebx
  printf (fd, "Salida a fichero\n");
 13a:	83 c4 08             	add    $0x8,%esp
 13d:	68 5b 08 00 00       	push   $0x85b
 142:	50                   	push   %eax
 143:	e8 51 03 00 00       	call   499 <printf>

  if (dup2 (fd, 9) != 9)
 148:	83 c4 08             	add    $0x8,%esp
 14b:	6a 09                	push   $0x9
 14d:	53                   	push   %ebx
 14e:	e8 af 02 00 00       	call   402 <dup2>
 153:	83 c4 10             	add    $0x10,%esp
 156:	83 f8 09             	cmp    $0x9,%eax
 159:	0f 85 97 01 00 00    	jne    2f6 <main+0x2f6>
    printf (2, "dup2 no funciona con fd existente (3).\n");

  printf (9, "Salida también a fichero.\n");
 15f:	83 ec 08             	sub    $0x8,%esp
 162:	68 6d 08 00 00       	push   $0x86d
 167:	6a 09                	push   $0x9
 169:	e8 2b 03 00 00       	call   499 <printf>

  if (dup2 (9, 9) != 9)
 16e:	83 c4 08             	add    $0x8,%esp
 171:	6a 09                	push   $0x9
 173:	6a 09                	push   $0x9
 175:	e8 88 02 00 00       	call   402 <dup2>
 17a:	83 c4 10             	add    $0x10,%esp
 17d:	83 f8 09             	cmp    $0x9,%eax
 180:	0f 85 87 01 00 00    	jne    30d <main+0x30d>
    printf (2, "dup2 no funciona con newfd=oldfd.\n");

  printf (9, "Salida también a fichero.\n");
 186:	83 ec 08             	sub    $0x8,%esp
 189:	68 6d 08 00 00       	push   $0x86d
 18e:	6a 09                	push   $0x9
 190:	e8 04 03 00 00       	call   499 <printf>

  close (9);
 195:	c7 04 24 09 00 00 00 	movl   $0x9,(%esp)
 19c:	e8 e1 01 00 00       	call   382 <close>

  dup2 (1, 6);
 1a1:	83 c4 08             	add    $0x8,%esp
 1a4:	6a 06                	push   $0x6
 1a6:	6a 01                	push   $0x1
 1a8:	e8 55 02 00 00       	call   402 <dup2>

  if (dup2 (fd, 1) != 1)
 1ad:	83 c4 08             	add    $0x8,%esp
 1b0:	6a 01                	push   $0x1
 1b2:	53                   	push   %ebx
 1b3:	e8 4a 02 00 00       	call   402 <dup2>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	83 f8 01             	cmp    $0x1,%eax
 1be:	0f 85 60 01 00 00    	jne    324 <main+0x324>
    printf (2, "dup2 no funciona con fd existente (4).\n");

  printf (1, "Cuarta salida a fichero.\n");
 1c4:	83 ec 08             	sub    $0x8,%esp
 1c7:	68 89 08 00 00       	push   $0x889
 1cc:	6a 01                	push   $0x1
 1ce:	e8 c6 02 00 00       	call   499 <printf>
  if (close (1) != 0)
 1d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1da:	e8 a3 01 00 00       	call   382 <close>
 1df:	83 c4 10             	add    $0x10,%esp
 1e2:	85 c0                	test   %eax,%eax
 1e4:	0f 85 51 01 00 00    	jne    33b <main+0x33b>
    printf (2, "Error en close (1).\n");

  dup2 (6,fd);
 1ea:	83 ec 08             	sub    $0x8,%esp
 1ed:	53                   	push   %ebx
 1ee:	6a 06                	push   $0x6
 1f0:	e8 0d 02 00 00       	call   402 <dup2>

  printf (fd, "Este mensaje debe salir por terminal.\n");
 1f5:	83 c4 08             	add    $0x8,%esp
 1f8:	68 ec 06 00 00       	push   $0x6ec
 1fd:	53                   	push   %ebx
 1fe:	e8 96 02 00 00       	call   499 <printf>
  close (fd);
 203:	89 1c 24             	mov    %ebx,(%esp)
 206:	e8 77 01 00 00       	call   382 <close>

  exit();
 20b:	e8 4a 01 00 00       	call   35a <exit>
    printf (2, "dup2 no funciona con fd incorrecto.\n");
 210:	83 ec 08             	sub    $0x8,%esp
 213:	68 f4 05 00 00       	push   $0x5f4
 218:	6a 02                	push   $0x2
 21a:	e8 7a 02 00 00       	call   499 <printf>
 21f:	83 c4 10             	add    $0x10,%esp
 222:	e9 03 fe ff ff       	jmp    2a <main+0x2a>
    printf (2, "dup2 no funciona con fd incorrecto (2).\n");
 227:	83 ec 08             	sub    $0x8,%esp
 22a:	68 1c 06 00 00       	push   $0x61c
 22f:	6a 02                	push   $0x2
 231:	e8 63 02 00 00       	call   499 <printf>
 236:	83 c4 10             	add    $0x10,%esp
 239:	e9 03 fe ff ff       	jmp    41 <main+0x41>
    printf (2, "dup2 no funciona con fd no mapeado.\n");
 23e:	83 ec 08             	sub    $0x8,%esp
 241:	68 48 06 00 00       	push   $0x648
 246:	6a 02                	push   $0x2
 248:	e8 4c 02 00 00       	call   499 <printf>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	e9 03 fe ff ff       	jmp    58 <main+0x58>
    printf (2, "dup2 no funciona con fd no mapeado (2).\n");
 255:	83 ec 08             	sub    $0x8,%esp
 258:	68 70 06 00 00       	push   $0x670
 25d:	6a 02                	push   $0x2
 25f:	e8 35 02 00 00       	call   499 <printf>
 264:	83 c4 10             	add    $0x10,%esp
 267:	e9 03 fe ff ff       	jmp    6f <main+0x6f>
    printf (2, "dup2 no funciona con fd superior a NOFILE.\n");
 26c:	83 ec 08             	sub    $0x8,%esp
 26f:	68 9c 06 00 00       	push   $0x69c
 274:	6a 02                	push   $0x2
 276:	e8 1e 02 00 00       	call   499 <printf>
 27b:	83 c4 10             	add    $0x10,%esp
 27e:	e9 03 fe ff ff       	jmp    86 <main+0x86>
    printf (2, "dup2 no funciona con fd existente.\n");
 283:	83 ec 08             	sub    $0x8,%esp
 286:	68 c8 06 00 00       	push   $0x6c8
 28b:	6a 02                	push   $0x2
 28d:	e8 07 02 00 00       	call   499 <printf>
 292:	83 c4 10             	add    $0x10,%esp
 295:	e9 04 fe ff ff       	jmp    9e <main+0x9e>
    printf (2, "dup2 no funciona con fd existente (2).\n");
 29a:	83 ec 08             	sub    $0x8,%esp
 29d:	68 14 07 00 00       	push   $0x714
 2a2:	6a 02                	push   $0x2
 2a4:	e8 f0 01 00 00       	call   499 <printf>
 2a9:	83 c4 10             	add    $0x10,%esp
 2ac:	e9 14 fe ff ff       	jmp    c5 <main+0xc5>
    printf (2, "Error en close (4)\n");
 2b1:	83 ec 08             	sub    $0x8,%esp
 2b4:	68 08 08 00 00       	push   $0x808
 2b9:	6a 02                	push   $0x2
 2bb:	e8 d9 01 00 00       	call   499 <printf>
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	e9 23 fe ff ff       	jmp    eb <main+0xeb>
    printf (2, "Error en close (6)\n");
 2c8:	83 ec 08             	sub    $0x8,%esp
 2cb:	68 1c 08 00 00       	push   $0x81c
 2d0:	6a 02                	push   $0x2
 2d2:	e8 c2 01 00 00       	call   499 <printf>
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	e9 32 fe ff ff       	jmp    111 <main+0x111>
    printf (2, "Error en close (6) (2)\n");
 2df:	83 ec 08             	sub    $0x8,%esp
 2e2:	68 30 08 00 00       	push   $0x830
 2e7:	6a 02                	push   $0x2
 2e9:	e8 ab 01 00 00       	call   499 <printf>
 2ee:	83 c4 10             	add    $0x10,%esp
 2f1:	e9 30 fe ff ff       	jmp    126 <main+0x126>
    printf (2, "dup2 no funciona con fd existente (3).\n");
 2f6:	83 ec 08             	sub    $0x8,%esp
 2f9:	68 94 07 00 00       	push   $0x794
 2fe:	6a 02                	push   $0x2
 300:	e8 94 01 00 00       	call   499 <printf>
 305:	83 c4 10             	add    $0x10,%esp
 308:	e9 52 fe ff ff       	jmp    15f <main+0x15f>
    printf (2, "dup2 no funciona con newfd=oldfd.\n");
 30d:	83 ec 08             	sub    $0x8,%esp
 310:	68 bc 07 00 00       	push   $0x7bc
 315:	6a 02                	push   $0x2
 317:	e8 7d 01 00 00       	call   499 <printf>
 31c:	83 c4 10             	add    $0x10,%esp
 31f:	e9 62 fe ff ff       	jmp    186 <main+0x186>
    printf (2, "dup2 no funciona con fd existente (4).\n");
 324:	83 ec 08             	sub    $0x8,%esp
 327:	68 e0 07 00 00       	push   $0x7e0
 32c:	6a 02                	push   $0x2
 32e:	e8 66 01 00 00       	call   499 <printf>
 333:	83 c4 10             	add    $0x10,%esp
 336:	e9 89 fe ff ff       	jmp    1c4 <main+0x1c4>
    printf (2, "Error en close (1).\n");
 33b:	83 ec 08             	sub    $0x8,%esp
 33e:	68 a3 08 00 00       	push   $0x8a3
 343:	6a 02                	push   $0x2
 345:	e8 4f 01 00 00       	call   499 <printf>
 34a:	83 c4 10             	add    $0x10,%esp
 34d:	e9 98 fe ff ff       	jmp    1ea <main+0x1ea>

00000352 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 352:	b8 01 00 00 00       	mov    $0x1,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <exit>:
SYSCALL(exit)
 35a:	b8 02 00 00 00       	mov    $0x2,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <wait>:
SYSCALL(wait)
 362:	b8 03 00 00 00       	mov    $0x3,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <pipe>:
SYSCALL(pipe)
 36a:	b8 04 00 00 00       	mov    $0x4,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <read>:
SYSCALL(read)
 372:	b8 05 00 00 00       	mov    $0x5,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <write>:
SYSCALL(write)
 37a:	b8 10 00 00 00       	mov    $0x10,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <close>:
SYSCALL(close)
 382:	b8 15 00 00 00       	mov    $0x15,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kill>:
SYSCALL(kill)
 38a:	b8 06 00 00 00       	mov    $0x6,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exec>:
SYSCALL(exec)
 392:	b8 07 00 00 00       	mov    $0x7,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <open>:
SYSCALL(open)
 39a:	b8 0f 00 00 00       	mov    $0xf,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <mknod>:
SYSCALL(mknod)
 3a2:	b8 11 00 00 00       	mov    $0x11,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <unlink>:
SYSCALL(unlink)
 3aa:	b8 12 00 00 00       	mov    $0x12,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <fstat>:
SYSCALL(fstat)
 3b2:	b8 08 00 00 00       	mov    $0x8,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <link>:
SYSCALL(link)
 3ba:	b8 13 00 00 00       	mov    $0x13,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <mkdir>:
SYSCALL(mkdir)
 3c2:	b8 14 00 00 00       	mov    $0x14,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <chdir>:
SYSCALL(chdir)
 3ca:	b8 09 00 00 00       	mov    $0x9,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <dup>:
SYSCALL(dup)
 3d2:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <getpid>:
SYSCALL(getpid)
 3da:	b8 0b 00 00 00       	mov    $0xb,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <sbrk>:
SYSCALL(sbrk)
 3e2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sleep>:
SYSCALL(sleep)
 3ea:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <uptime>:
SYSCALL(uptime)
 3f2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <date>:
SYSCALL(date)
 3fa:	b8 16 00 00 00       	mov    $0x16,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <dup2>:
SYSCALL(dup2)
 402:	b8 17 00 00 00       	mov    $0x17,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40a:	55                   	push   %ebp
 40b:	89 e5                	mov    %esp,%ebp
 40d:	83 ec 1c             	sub    $0x1c,%esp
 410:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 413:	6a 01                	push   $0x1
 415:	8d 55 f4             	lea    -0xc(%ebp),%edx
 418:	52                   	push   %edx
 419:	50                   	push   %eax
 41a:	e8 5b ff ff ff       	call   37a <write>
}
 41f:	83 c4 10             	add    $0x10,%esp
 422:	c9                   	leave  
 423:	c3                   	ret    

00000424 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	57                   	push   %edi
 428:	56                   	push   %esi
 429:	53                   	push   %ebx
 42a:	83 ec 2c             	sub    $0x2c,%esp
 42d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 430:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 432:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 436:	74 04                	je     43c <printint+0x18>
 438:	85 d2                	test   %edx,%edx
 43a:	78 3a                	js     476 <printint+0x52>
  neg = 0;
 43c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 443:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 448:	89 f0                	mov    %esi,%eax
 44a:	ba 00 00 00 00       	mov    $0x0,%edx
 44f:	f7 f1                	div    %ecx
 451:	89 df                	mov    %ebx,%edi
 453:	43                   	inc    %ebx
 454:	8a 92 c0 08 00 00    	mov    0x8c0(%edx),%dl
 45a:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 45e:	89 f2                	mov    %esi,%edx
 460:	89 c6                	mov    %eax,%esi
 462:	39 d1                	cmp    %edx,%ecx
 464:	76 e2                	jbe    448 <printint+0x24>
  if(neg)
 466:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 46a:	74 22                	je     48e <printint+0x6a>
    buf[i++] = '-';
 46c:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 471:	8d 5f 02             	lea    0x2(%edi),%ebx
 474:	eb 18                	jmp    48e <printint+0x6a>
    x = -xx;
 476:	f7 de                	neg    %esi
    neg = 1;
 478:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 47f:	eb c2                	jmp    443 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 481:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 486:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 489:	e8 7c ff ff ff       	call   40a <putc>
  while(--i >= 0)
 48e:	4b                   	dec    %ebx
 48f:	79 f0                	jns    481 <printint+0x5d>
}
 491:	83 c4 2c             	add    $0x2c,%esp
 494:	5b                   	pop    %ebx
 495:	5e                   	pop    %esi
 496:	5f                   	pop    %edi
 497:	5d                   	pop    %ebp
 498:	c3                   	ret    

00000499 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 499:	f3 0f 1e fb          	endbr32 
 49d:	55                   	push   %ebp
 49e:	89 e5                	mov    %esp,%ebp
 4a0:	57                   	push   %edi
 4a1:	56                   	push   %esi
 4a2:	53                   	push   %ebx
 4a3:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4a6:	8d 45 10             	lea    0x10(%ebp),%eax
 4a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 4ac:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 4b1:	bb 00 00 00 00       	mov    $0x0,%ebx
 4b6:	eb 12                	jmp    4ca <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4b8:	89 fa                	mov    %edi,%edx
 4ba:	8b 45 08             	mov    0x8(%ebp),%eax
 4bd:	e8 48 ff ff ff       	call   40a <putc>
 4c2:	eb 05                	jmp    4c9 <printf+0x30>
      }
    } else if(state == '%'){
 4c4:	83 fe 25             	cmp    $0x25,%esi
 4c7:	74 22                	je     4eb <printf+0x52>
  for(i = 0; fmt[i]; i++){
 4c9:	43                   	inc    %ebx
 4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cd:	8a 04 18             	mov    (%eax,%ebx,1),%al
 4d0:	84 c0                	test   %al,%al
 4d2:	0f 84 13 01 00 00    	je     5eb <printf+0x152>
    c = fmt[i] & 0xff;
 4d8:	0f be f8             	movsbl %al,%edi
 4db:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 4de:	85 f6                	test   %esi,%esi
 4e0:	75 e2                	jne    4c4 <printf+0x2b>
      if(c == '%'){
 4e2:	83 f8 25             	cmp    $0x25,%eax
 4e5:	75 d1                	jne    4b8 <printf+0x1f>
        state = '%';
 4e7:	89 c6                	mov    %eax,%esi
 4e9:	eb de                	jmp    4c9 <printf+0x30>
      if(c == 'd'){
 4eb:	83 f8 64             	cmp    $0x64,%eax
 4ee:	74 43                	je     533 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4f0:	83 f8 78             	cmp    $0x78,%eax
 4f3:	74 68                	je     55d <printf+0xc4>
 4f5:	83 f8 70             	cmp    $0x70,%eax
 4f8:	74 63                	je     55d <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4fa:	83 f8 73             	cmp    $0x73,%eax
 4fd:	0f 84 84 00 00 00    	je     587 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 503:	83 f8 63             	cmp    $0x63,%eax
 506:	0f 84 ad 00 00 00    	je     5b9 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 50c:	83 f8 25             	cmp    $0x25,%eax
 50f:	0f 84 c2 00 00 00    	je     5d7 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 515:	ba 25 00 00 00       	mov    $0x25,%edx
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	e8 e8 fe ff ff       	call   40a <putc>
        putc(fd, c);
 522:	89 fa                	mov    %edi,%edx
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	e8 de fe ff ff       	call   40a <putc>
      }
      state = 0;
 52c:	be 00 00 00 00       	mov    $0x0,%esi
 531:	eb 96                	jmp    4c9 <printf+0x30>
        printint(fd, *ap, 10, 1);
 533:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 536:	8b 17                	mov    (%edi),%edx
 538:	83 ec 0c             	sub    $0xc,%esp
 53b:	6a 01                	push   $0x1
 53d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 542:	8b 45 08             	mov    0x8(%ebp),%eax
 545:	e8 da fe ff ff       	call   424 <printint>
        ap++;
 54a:	83 c7 04             	add    $0x4,%edi
 54d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 550:	83 c4 10             	add    $0x10,%esp
      state = 0;
 553:	be 00 00 00 00       	mov    $0x0,%esi
 558:	e9 6c ff ff ff       	jmp    4c9 <printf+0x30>
        printint(fd, *ap, 16, 0);
 55d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 560:	8b 17                	mov    (%edi),%edx
 562:	83 ec 0c             	sub    $0xc,%esp
 565:	6a 00                	push   $0x0
 567:	b9 10 00 00 00       	mov    $0x10,%ecx
 56c:	8b 45 08             	mov    0x8(%ebp),%eax
 56f:	e8 b0 fe ff ff       	call   424 <printint>
        ap++;
 574:	83 c7 04             	add    $0x4,%edi
 577:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 57a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 57d:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 582:	e9 42 ff ff ff       	jmp    4c9 <printf+0x30>
        s = (char*)*ap;
 587:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58a:	8b 30                	mov    (%eax),%esi
        ap++;
 58c:	83 c0 04             	add    $0x4,%eax
 58f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 592:	85 f6                	test   %esi,%esi
 594:	75 13                	jne    5a9 <printf+0x110>
          s = "(null)";
 596:	be b8 08 00 00       	mov    $0x8b8,%esi
 59b:	eb 0c                	jmp    5a9 <printf+0x110>
          putc(fd, *s);
 59d:	0f be d2             	movsbl %dl,%edx
 5a0:	8b 45 08             	mov    0x8(%ebp),%eax
 5a3:	e8 62 fe ff ff       	call   40a <putc>
          s++;
 5a8:	46                   	inc    %esi
        while(*s != 0){
 5a9:	8a 16                	mov    (%esi),%dl
 5ab:	84 d2                	test   %dl,%dl
 5ad:	75 ee                	jne    59d <printf+0x104>
      state = 0;
 5af:	be 00 00 00 00       	mov    $0x0,%esi
 5b4:	e9 10 ff ff ff       	jmp    4c9 <printf+0x30>
        putc(fd, *ap);
 5b9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5bc:	0f be 17             	movsbl (%edi),%edx
 5bf:	8b 45 08             	mov    0x8(%ebp),%eax
 5c2:	e8 43 fe ff ff       	call   40a <putc>
        ap++;
 5c7:	83 c7 04             	add    $0x4,%edi
 5ca:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 5cd:	be 00 00 00 00       	mov    $0x0,%esi
 5d2:	e9 f2 fe ff ff       	jmp    4c9 <printf+0x30>
        putc(fd, c);
 5d7:	89 fa                	mov    %edi,%edx
 5d9:	8b 45 08             	mov    0x8(%ebp),%eax
 5dc:	e8 29 fe ff ff       	call   40a <putc>
      state = 0;
 5e1:	be 00 00 00 00       	mov    $0x0,%esi
 5e6:	e9 de fe ff ff       	jmp    4c9 <printf+0x30>
    }
  }
}
 5eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ee:	5b                   	pop    %ebx
 5ef:	5e                   	pop    %esi
 5f0:	5f                   	pop    %edi
 5f1:	5d                   	pop    %ebp
 5f2:	c3                   	ret    
