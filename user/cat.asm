
cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   8:	83 ec 04             	sub    $0x4,%esp
   b:	68 00 02 00 00       	push   $0x200
  10:	68 60 05 00 00       	push   $0x560
  15:	56                   	push   %esi
  16:	e8 1c 01 00 00       	call   137 <read>
  1b:	89 c3                	mov    %eax,%ebx
  1d:	83 c4 10             	add    $0x10,%esp
  20:	85 c0                	test   %eax,%eax
  22:	7e 32                	jle    56 <cat+0x56>
    if (write(1, buf, n) != n) {
  24:	83 ec 04             	sub    $0x4,%esp
  27:	53                   	push   %ebx
  28:	68 60 05 00 00       	push   $0x560
  2d:	6a 01                	push   $0x1
  2f:	e8 0b 01 00 00       	call   13f <write>
  34:	83 c4 10             	add    $0x10,%esp
  37:	39 d8                	cmp    %ebx,%eax
  39:	74 cd                	je     8 <cat+0x8>
      printf(1, "cat: write error\n");
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	68 c4 03 00 00       	push   $0x3c4
  43:	6a 01                	push   $0x1
  45:	e8 18 02 00 00       	call   262 <printf>
      exit(0);
  4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  51:	e8 c9 00 00 00       	call   11f <exit>
    }
  }
  if(n < 0){
  56:	78 07                	js     5f <cat+0x5f>
    printf(1, "cat: read error\n");
    exit(0);
  }
}
  58:	8d 65 f8             	lea    -0x8(%ebp),%esp
  5b:	5b                   	pop    %ebx
  5c:	5e                   	pop    %esi
  5d:	5d                   	pop    %ebp
  5e:	c3                   	ret    
    printf(1, "cat: read error\n");
  5f:	83 ec 08             	sub    $0x8,%esp
  62:	68 d6 03 00 00       	push   $0x3d6
  67:	6a 01                	push   $0x1
  69:	e8 f4 01 00 00       	call   262 <printf>
    exit(0);
  6e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  75:	e8 a5 00 00 00       	call   11f <exit>

0000007a <main>:

int
main(int argc, char *argv[])
{
  7a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  7e:	83 e4 f0             	and    $0xfffffff0,%esp
  81:	ff 71 fc             	push   -0x4(%ecx)
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	57                   	push   %edi
  88:	56                   	push   %esi
  89:	53                   	push   %ebx
  8a:	51                   	push   %ecx
  8b:	83 ec 18             	sub    $0x18,%esp
  8e:	8b 01                	mov    (%ecx),%eax
  90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  93:	8b 51 04             	mov    0x4(%ecx),%edx
  96:	89 55 e0             	mov    %edx,-0x20(%ebp)
  int fd, i;

  if(argc <= 1){
  99:	83 f8 01             	cmp    $0x1,%eax
  9c:	7e 07                	jle    a5 <main+0x2b>
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  9e:	be 01 00 00 00       	mov    $0x1,%esi
  a3:	eb 2b                	jmp    d0 <main+0x56>
    cat(0);
  a5:	83 ec 0c             	sub    $0xc,%esp
  a8:	6a 00                	push   $0x0
  aa:	e8 51 ff ff ff       	call   0 <cat>
    exit(0);
  af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b6:	e8 64 00 00 00       	call   11f <exit>
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
  bb:	83 ec 0c             	sub    $0xc,%esp
  be:	50                   	push   %eax
  bf:	e8 3c ff ff ff       	call   0 <cat>
    close(fd);
  c4:	89 1c 24             	mov    %ebx,(%esp)
  c7:	e8 7b 00 00 00       	call   147 <close>
  for(i = 1; i < argc; i++){
  cc:	46                   	inc    %esi
  cd:	83 c4 10             	add    $0x10,%esp
  d0:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
  d3:	7d 38                	jge    10d <main+0x93>
    if((fd = open(argv[i], 0)) < 0){
  d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  d8:	8d 3c b0             	lea    (%eax,%esi,4),%edi
  db:	83 ec 08             	sub    $0x8,%esp
  de:	6a 00                	push   $0x0
  e0:	ff 37                	push   (%edi)
  e2:	e8 78 00 00 00       	call   15f <open>
  e7:	89 c3                	mov    %eax,%ebx
  e9:	83 c4 10             	add    $0x10,%esp
  ec:	85 c0                	test   %eax,%eax
  ee:	79 cb                	jns    bb <main+0x41>
      printf(1, "cat: cannot open %s\n", argv[i]);
  f0:	83 ec 04             	sub    $0x4,%esp
  f3:	ff 37                	push   (%edi)
  f5:	68 e7 03 00 00       	push   $0x3e7
  fa:	6a 01                	push   $0x1
  fc:	e8 61 01 00 00       	call   262 <printf>
      exit(0);
 101:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 108:	e8 12 00 00 00       	call   11f <exit>
  }
  exit(0);
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	6a 00                	push   $0x0
 112:	e8 08 00 00 00       	call   11f <exit>

00000117 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 117:	b8 01 00 00 00       	mov    $0x1,%eax
 11c:	cd 40                	int    $0x40
 11e:	c3                   	ret    

0000011f <exit>:
SYSCALL(exit)
 11f:	b8 02 00 00 00       	mov    $0x2,%eax
 124:	cd 40                	int    $0x40
 126:	c3                   	ret    

00000127 <wait>:
SYSCALL(wait)
 127:	b8 03 00 00 00       	mov    $0x3,%eax
 12c:	cd 40                	int    $0x40
 12e:	c3                   	ret    

0000012f <pipe>:
SYSCALL(pipe)
 12f:	b8 04 00 00 00       	mov    $0x4,%eax
 134:	cd 40                	int    $0x40
 136:	c3                   	ret    

00000137 <read>:
SYSCALL(read)
 137:	b8 05 00 00 00       	mov    $0x5,%eax
 13c:	cd 40                	int    $0x40
 13e:	c3                   	ret    

0000013f <write>:
SYSCALL(write)
 13f:	b8 10 00 00 00       	mov    $0x10,%eax
 144:	cd 40                	int    $0x40
 146:	c3                   	ret    

00000147 <close>:
SYSCALL(close)
 147:	b8 15 00 00 00       	mov    $0x15,%eax
 14c:	cd 40                	int    $0x40
 14e:	c3                   	ret    

0000014f <kill>:
SYSCALL(kill)
 14f:	b8 06 00 00 00       	mov    $0x6,%eax
 154:	cd 40                	int    $0x40
 156:	c3                   	ret    

00000157 <exec>:
SYSCALL(exec)
 157:	b8 07 00 00 00       	mov    $0x7,%eax
 15c:	cd 40                	int    $0x40
 15e:	c3                   	ret    

0000015f <open>:
SYSCALL(open)
 15f:	b8 0f 00 00 00       	mov    $0xf,%eax
 164:	cd 40                	int    $0x40
 166:	c3                   	ret    

00000167 <mknod>:
SYSCALL(mknod)
 167:	b8 11 00 00 00       	mov    $0x11,%eax
 16c:	cd 40                	int    $0x40
 16e:	c3                   	ret    

0000016f <unlink>:
SYSCALL(unlink)
 16f:	b8 12 00 00 00       	mov    $0x12,%eax
 174:	cd 40                	int    $0x40
 176:	c3                   	ret    

00000177 <fstat>:
SYSCALL(fstat)
 177:	b8 08 00 00 00       	mov    $0x8,%eax
 17c:	cd 40                	int    $0x40
 17e:	c3                   	ret    

0000017f <link>:
SYSCALL(link)
 17f:	b8 13 00 00 00       	mov    $0x13,%eax
 184:	cd 40                	int    $0x40
 186:	c3                   	ret    

00000187 <mkdir>:
SYSCALL(mkdir)
 187:	b8 14 00 00 00       	mov    $0x14,%eax
 18c:	cd 40                	int    $0x40
 18e:	c3                   	ret    

0000018f <chdir>:
SYSCALL(chdir)
 18f:	b8 09 00 00 00       	mov    $0x9,%eax
 194:	cd 40                	int    $0x40
 196:	c3                   	ret    

00000197 <dup>:
SYSCALL(dup)
 197:	b8 0a 00 00 00       	mov    $0xa,%eax
 19c:	cd 40                	int    $0x40
 19e:	c3                   	ret    

0000019f <getpid>:
SYSCALL(getpid)
 19f:	b8 0b 00 00 00       	mov    $0xb,%eax
 1a4:	cd 40                	int    $0x40
 1a6:	c3                   	ret    

000001a7 <sbrk>:
SYSCALL(sbrk)
 1a7:	b8 0c 00 00 00       	mov    $0xc,%eax
 1ac:	cd 40                	int    $0x40
 1ae:	c3                   	ret    

000001af <sleep>:
SYSCALL(sleep)
 1af:	b8 0d 00 00 00       	mov    $0xd,%eax
 1b4:	cd 40                	int    $0x40
 1b6:	c3                   	ret    

000001b7 <uptime>:
SYSCALL(uptime)
 1b7:	b8 0e 00 00 00       	mov    $0xe,%eax
 1bc:	cd 40                	int    $0x40
 1be:	c3                   	ret    

000001bf <date>:
SYSCALL(date)
 1bf:	b8 16 00 00 00       	mov    $0x16,%eax
 1c4:	cd 40                	int    $0x40
 1c6:	c3                   	ret    

000001c7 <dup2>:
SYSCALL(dup2)
 1c7:	b8 17 00 00 00       	mov    $0x17,%eax
 1cc:	cd 40                	int    $0x40
 1ce:	c3                   	ret    

000001cf <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 1c             	sub    $0x1c,%esp
 1d5:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 1d8:	6a 01                	push   $0x1
 1da:	8d 55 f4             	lea    -0xc(%ebp),%edx
 1dd:	52                   	push   %edx
 1de:	50                   	push   %eax
 1df:	e8 5b ff ff ff       	call   13f <write>
}
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	57                   	push   %edi
 1ed:	56                   	push   %esi
 1ee:	53                   	push   %ebx
 1ef:	83 ec 2c             	sub    $0x2c,%esp
 1f2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 1f5:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 1f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 1fb:	74 04                	je     201 <printint+0x18>
 1fd:	85 d2                	test   %edx,%edx
 1ff:	78 3c                	js     23d <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 201:	89 d1                	mov    %edx,%ecx
  neg = 0;
 203:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 20a:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 20f:	89 c8                	mov    %ecx,%eax
 211:	ba 00 00 00 00       	mov    $0x0,%edx
 216:	f7 f6                	div    %esi
 218:	89 df                	mov    %ebx,%edi
 21a:	43                   	inc    %ebx
 21b:	8a 92 5c 04 00 00    	mov    0x45c(%edx),%dl
 221:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 225:	89 ca                	mov    %ecx,%edx
 227:	89 c1                	mov    %eax,%ecx
 229:	39 d6                	cmp    %edx,%esi
 22b:	76 e2                	jbe    20f <printint+0x26>
  if(neg)
 22d:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 231:	74 24                	je     257 <printint+0x6e>
    buf[i++] = '-';
 233:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 238:	8d 5f 02             	lea    0x2(%edi),%ebx
 23b:	eb 1a                	jmp    257 <printint+0x6e>
    x = -xx;
 23d:	89 d1                	mov    %edx,%ecx
 23f:	f7 d9                	neg    %ecx
    neg = 1;
 241:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 248:	eb c0                	jmp    20a <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 24a:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 24f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 252:	e8 78 ff ff ff       	call   1cf <putc>
  while(--i >= 0)
 257:	4b                   	dec    %ebx
 258:	79 f0                	jns    24a <printint+0x61>
}
 25a:	83 c4 2c             	add    $0x2c,%esp
 25d:	5b                   	pop    %ebx
 25e:	5e                   	pop    %esi
 25f:	5f                   	pop    %edi
 260:	5d                   	pop    %ebp
 261:	c3                   	ret    

00000262 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 262:	55                   	push   %ebp
 263:	89 e5                	mov    %esp,%ebp
 265:	57                   	push   %edi
 266:	56                   	push   %esi
 267:	53                   	push   %ebx
 268:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 26b:	8d 45 10             	lea    0x10(%ebp),%eax
 26e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 271:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 276:	bb 00 00 00 00       	mov    $0x0,%ebx
 27b:	eb 12                	jmp    28f <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 27d:	89 fa                	mov    %edi,%edx
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
 282:	e8 48 ff ff ff       	call   1cf <putc>
 287:	eb 05                	jmp    28e <printf+0x2c>
      }
    } else if(state == '%'){
 289:	83 fe 25             	cmp    $0x25,%esi
 28c:	74 22                	je     2b0 <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 28e:	43                   	inc    %ebx
 28f:	8b 45 0c             	mov    0xc(%ebp),%eax
 292:	8a 04 18             	mov    (%eax,%ebx,1),%al
 295:	84 c0                	test   %al,%al
 297:	0f 84 1d 01 00 00    	je     3ba <printf+0x158>
    c = fmt[i] & 0xff;
 29d:	0f be f8             	movsbl %al,%edi
 2a0:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 2a3:	85 f6                	test   %esi,%esi
 2a5:	75 e2                	jne    289 <printf+0x27>
      if(c == '%'){
 2a7:	83 f8 25             	cmp    $0x25,%eax
 2aa:	75 d1                	jne    27d <printf+0x1b>
        state = '%';
 2ac:	89 c6                	mov    %eax,%esi
 2ae:	eb de                	jmp    28e <printf+0x2c>
      if(c == 'd'){
 2b0:	83 f8 25             	cmp    $0x25,%eax
 2b3:	0f 84 cc 00 00 00    	je     385 <printf+0x123>
 2b9:	0f 8c da 00 00 00    	jl     399 <printf+0x137>
 2bf:	83 f8 78             	cmp    $0x78,%eax
 2c2:	0f 8f d1 00 00 00    	jg     399 <printf+0x137>
 2c8:	83 f8 63             	cmp    $0x63,%eax
 2cb:	0f 8c c8 00 00 00    	jl     399 <printf+0x137>
 2d1:	83 e8 63             	sub    $0x63,%eax
 2d4:	83 f8 15             	cmp    $0x15,%eax
 2d7:	0f 87 bc 00 00 00    	ja     399 <printf+0x137>
 2dd:	ff 24 85 04 04 00 00 	jmp    *0x404(,%eax,4)
        printint(fd, *ap, 10, 1);
 2e4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2e7:	8b 17                	mov    (%edi),%edx
 2e9:	83 ec 0c             	sub    $0xc,%esp
 2ec:	6a 01                	push   $0x1
 2ee:	b9 0a 00 00 00       	mov    $0xa,%ecx
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	e8 ee fe ff ff       	call   1e9 <printint>
        ap++;
 2fb:	83 c7 04             	add    $0x4,%edi
 2fe:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 301:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 304:	be 00 00 00 00       	mov    $0x0,%esi
 309:	eb 83                	jmp    28e <printf+0x2c>
        printint(fd, *ap, 16, 0);
 30b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 30e:	8b 17                	mov    (%edi),%edx
 310:	83 ec 0c             	sub    $0xc,%esp
 313:	6a 00                	push   $0x0
 315:	b9 10 00 00 00       	mov    $0x10,%ecx
 31a:	8b 45 08             	mov    0x8(%ebp),%eax
 31d:	e8 c7 fe ff ff       	call   1e9 <printint>
        ap++;
 322:	83 c7 04             	add    $0x4,%edi
 325:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 328:	83 c4 10             	add    $0x10,%esp
      state = 0;
 32b:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 330:	e9 59 ff ff ff       	jmp    28e <printf+0x2c>
        s = (char*)*ap;
 335:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 338:	8b 30                	mov    (%eax),%esi
        ap++;
 33a:	83 c0 04             	add    $0x4,%eax
 33d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 340:	85 f6                	test   %esi,%esi
 342:	75 13                	jne    357 <printf+0xf5>
          s = "(null)";
 344:	be fc 03 00 00       	mov    $0x3fc,%esi
 349:	eb 0c                	jmp    357 <printf+0xf5>
          putc(fd, *s);
 34b:	0f be d2             	movsbl %dl,%edx
 34e:	8b 45 08             	mov    0x8(%ebp),%eax
 351:	e8 79 fe ff ff       	call   1cf <putc>
          s++;
 356:	46                   	inc    %esi
        while(*s != 0){
 357:	8a 16                	mov    (%esi),%dl
 359:	84 d2                	test   %dl,%dl
 35b:	75 ee                	jne    34b <printf+0xe9>
      state = 0;
 35d:	be 00 00 00 00       	mov    $0x0,%esi
 362:	e9 27 ff ff ff       	jmp    28e <printf+0x2c>
        putc(fd, *ap);
 367:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 36a:	0f be 17             	movsbl (%edi),%edx
 36d:	8b 45 08             	mov    0x8(%ebp),%eax
 370:	e8 5a fe ff ff       	call   1cf <putc>
        ap++;
 375:	83 c7 04             	add    $0x4,%edi
 378:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 37b:	be 00 00 00 00       	mov    $0x0,%esi
 380:	e9 09 ff ff ff       	jmp    28e <printf+0x2c>
        putc(fd, c);
 385:	89 fa                	mov    %edi,%edx
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	e8 40 fe ff ff       	call   1cf <putc>
      state = 0;
 38f:	be 00 00 00 00       	mov    $0x0,%esi
 394:	e9 f5 fe ff ff       	jmp    28e <printf+0x2c>
        putc(fd, '%');
 399:	ba 25 00 00 00       	mov    $0x25,%edx
 39e:	8b 45 08             	mov    0x8(%ebp),%eax
 3a1:	e8 29 fe ff ff       	call   1cf <putc>
        putc(fd, c);
 3a6:	89 fa                	mov    %edi,%edx
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	e8 1f fe ff ff       	call   1cf <putc>
      state = 0;
 3b0:	be 00 00 00 00       	mov    $0x0,%esi
 3b5:	e9 d4 fe ff ff       	jmp    28e <printf+0x2c>
    }
  }
}
 3ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bd:	5b                   	pop    %ebx
 3be:	5e                   	pop    %esi
 3bf:	5f                   	pop    %edi
 3c0:	5d                   	pop    %ebp
 3c1:	c3                   	ret    
