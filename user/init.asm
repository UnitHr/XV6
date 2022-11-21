
init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 a0 03 00 00       	push   $0x3a0
  19:	e8 1d 01 00 00       	call   13b <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	78 1b                	js     40 <main+0x40>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  25:	83 ec 0c             	sub    $0xc,%esp
  28:	6a 00                	push   $0x0
  2a:	e8 44 01 00 00       	call   173 <dup>
  dup(0);  // stderr
  2f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  36:	e8 38 01 00 00       	call   173 <dup>
  3b:	83 c4 10             	add    $0x10,%esp
  3e:	eb 67                	jmp    a7 <main+0xa7>
    mknod("console", 1, 1);
  40:	83 ec 04             	sub    $0x4,%esp
  43:	6a 01                	push   $0x1
  45:	6a 01                	push   $0x1
  47:	68 a0 03 00 00       	push   $0x3a0
  4c:	e8 f2 00 00 00       	call   143 <mknod>
    open("console", O_RDWR);
  51:	83 c4 08             	add    $0x8,%esp
  54:	6a 02                	push   $0x2
  56:	68 a0 03 00 00       	push   $0x3a0
  5b:	e8 db 00 00 00       	call   13b <open>
  60:	83 c4 10             	add    $0x10,%esp
  63:	eb c0                	jmp    25 <main+0x25>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  65:	83 ec 08             	sub    $0x8,%esp
  68:	68 bb 03 00 00       	push   $0x3bb
  6d:	6a 01                	push   $0x1
  6f:	e8 ca 01 00 00       	call   23e <printf>
      exit(0);
  74:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7b:	e8 7b 00 00 00       	call   fb <exit>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(0);
    }
    while((wpid=wait(NULL)) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  80:	83 ec 08             	sub    $0x8,%esp
  83:	68 e7 03 00 00       	push   $0x3e7
  88:	6a 01                	push   $0x1
  8a:	e8 af 01 00 00       	call   23e <printf>
  8f:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait(NULL)) >= 0 && wpid != pid)
  92:	83 ec 0c             	sub    $0xc,%esp
  95:	6a 00                	push   $0x0
  97:	e8 67 00 00 00       	call   103 <wait>
  9c:	83 c4 10             	add    $0x10,%esp
  9f:	85 c0                	test   %eax,%eax
  a1:	78 04                	js     a7 <main+0xa7>
  a3:	39 c3                	cmp    %eax,%ebx
  a5:	75 d9                	jne    80 <main+0x80>
    printf(1, "init: starting sh\n");
  a7:	83 ec 08             	sub    $0x8,%esp
  aa:	68 a8 03 00 00       	push   $0x3a8
  af:	6a 01                	push   $0x1
  b1:	e8 88 01 00 00       	call   23e <printf>
    pid = fork();
  b6:	e8 38 00 00 00       	call   f3 <fork>
  bb:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  bd:	83 c4 10             	add    $0x10,%esp
  c0:	85 c0                	test   %eax,%eax
  c2:	78 a1                	js     65 <main+0x65>
    if(pid == 0){
  c4:	75 cc                	jne    92 <main+0x92>
      exec("sh", argv);
  c6:	83 ec 08             	sub    $0x8,%esp
  c9:	68 20 05 00 00       	push   $0x520
  ce:	68 ce 03 00 00       	push   $0x3ce
  d3:	e8 5b 00 00 00       	call   133 <exec>
      printf(1, "init: exec sh failed\n");
  d8:	83 c4 08             	add    $0x8,%esp
  db:	68 d1 03 00 00       	push   $0x3d1
  e0:	6a 01                	push   $0x1
  e2:	e8 57 01 00 00       	call   23e <printf>
      exit(0);
  e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ee:	e8 08 00 00 00       	call   fb <exit>

000000f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  f3:	b8 01 00 00 00       	mov    $0x1,%eax
  f8:	cd 40                	int    $0x40
  fa:	c3                   	ret    

000000fb <exit>:
SYSCALL(exit)
  fb:	b8 02 00 00 00       	mov    $0x2,%eax
 100:	cd 40                	int    $0x40
 102:	c3                   	ret    

00000103 <wait>:
SYSCALL(wait)
 103:	b8 03 00 00 00       	mov    $0x3,%eax
 108:	cd 40                	int    $0x40
 10a:	c3                   	ret    

0000010b <pipe>:
SYSCALL(pipe)
 10b:	b8 04 00 00 00       	mov    $0x4,%eax
 110:	cd 40                	int    $0x40
 112:	c3                   	ret    

00000113 <read>:
SYSCALL(read)
 113:	b8 05 00 00 00       	mov    $0x5,%eax
 118:	cd 40                	int    $0x40
 11a:	c3                   	ret    

0000011b <write>:
SYSCALL(write)
 11b:	b8 10 00 00 00       	mov    $0x10,%eax
 120:	cd 40                	int    $0x40
 122:	c3                   	ret    

00000123 <close>:
SYSCALL(close)
 123:	b8 15 00 00 00       	mov    $0x15,%eax
 128:	cd 40                	int    $0x40
 12a:	c3                   	ret    

0000012b <kill>:
SYSCALL(kill)
 12b:	b8 06 00 00 00       	mov    $0x6,%eax
 130:	cd 40                	int    $0x40
 132:	c3                   	ret    

00000133 <exec>:
SYSCALL(exec)
 133:	b8 07 00 00 00       	mov    $0x7,%eax
 138:	cd 40                	int    $0x40
 13a:	c3                   	ret    

0000013b <open>:
SYSCALL(open)
 13b:	b8 0f 00 00 00       	mov    $0xf,%eax
 140:	cd 40                	int    $0x40
 142:	c3                   	ret    

00000143 <mknod>:
SYSCALL(mknod)
 143:	b8 11 00 00 00       	mov    $0x11,%eax
 148:	cd 40                	int    $0x40
 14a:	c3                   	ret    

0000014b <unlink>:
SYSCALL(unlink)
 14b:	b8 12 00 00 00       	mov    $0x12,%eax
 150:	cd 40                	int    $0x40
 152:	c3                   	ret    

00000153 <fstat>:
SYSCALL(fstat)
 153:	b8 08 00 00 00       	mov    $0x8,%eax
 158:	cd 40                	int    $0x40
 15a:	c3                   	ret    

0000015b <link>:
SYSCALL(link)
 15b:	b8 13 00 00 00       	mov    $0x13,%eax
 160:	cd 40                	int    $0x40
 162:	c3                   	ret    

00000163 <mkdir>:
SYSCALL(mkdir)
 163:	b8 14 00 00 00       	mov    $0x14,%eax
 168:	cd 40                	int    $0x40
 16a:	c3                   	ret    

0000016b <chdir>:
SYSCALL(chdir)
 16b:	b8 09 00 00 00       	mov    $0x9,%eax
 170:	cd 40                	int    $0x40
 172:	c3                   	ret    

00000173 <dup>:
SYSCALL(dup)
 173:	b8 0a 00 00 00       	mov    $0xa,%eax
 178:	cd 40                	int    $0x40
 17a:	c3                   	ret    

0000017b <getpid>:
SYSCALL(getpid)
 17b:	b8 0b 00 00 00       	mov    $0xb,%eax
 180:	cd 40                	int    $0x40
 182:	c3                   	ret    

00000183 <sbrk>:
SYSCALL(sbrk)
 183:	b8 0c 00 00 00       	mov    $0xc,%eax
 188:	cd 40                	int    $0x40
 18a:	c3                   	ret    

0000018b <sleep>:
SYSCALL(sleep)
 18b:	b8 0d 00 00 00       	mov    $0xd,%eax
 190:	cd 40                	int    $0x40
 192:	c3                   	ret    

00000193 <uptime>:
SYSCALL(uptime)
 193:	b8 0e 00 00 00       	mov    $0xe,%eax
 198:	cd 40                	int    $0x40
 19a:	c3                   	ret    

0000019b <date>:
SYSCALL(date)
 19b:	b8 16 00 00 00       	mov    $0x16,%eax
 1a0:	cd 40                	int    $0x40
 1a2:	c3                   	ret    

000001a3 <dup2>:
SYSCALL(dup2)
 1a3:	b8 17 00 00 00       	mov    $0x17,%eax
 1a8:	cd 40                	int    $0x40
 1aa:	c3                   	ret    

000001ab <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 1ab:	55                   	push   %ebp
 1ac:	89 e5                	mov    %esp,%ebp
 1ae:	83 ec 1c             	sub    $0x1c,%esp
 1b1:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 1b4:	6a 01                	push   $0x1
 1b6:	8d 55 f4             	lea    -0xc(%ebp),%edx
 1b9:	52                   	push   %edx
 1ba:	50                   	push   %eax
 1bb:	e8 5b ff ff ff       	call   11b <write>
}
 1c0:	83 c4 10             	add    $0x10,%esp
 1c3:	c9                   	leave  
 1c4:	c3                   	ret    

000001c5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 1c5:	55                   	push   %ebp
 1c6:	89 e5                	mov    %esp,%ebp
 1c8:	57                   	push   %edi
 1c9:	56                   	push   %esi
 1ca:	53                   	push   %ebx
 1cb:	83 ec 2c             	sub    $0x2c,%esp
 1ce:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 1d1:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 1d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 1d7:	74 04                	je     1dd <printint+0x18>
 1d9:	85 d2                	test   %edx,%edx
 1db:	78 3c                	js     219 <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 1dd:	89 d1                	mov    %edx,%ecx
  neg = 0;
 1df:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 1e6:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 1eb:	89 c8                	mov    %ecx,%eax
 1ed:	ba 00 00 00 00       	mov    $0x0,%edx
 1f2:	f7 f6                	div    %esi
 1f4:	89 df                	mov    %ebx,%edi
 1f6:	43                   	inc    %ebx
 1f7:	8a 92 50 04 00 00    	mov    0x450(%edx),%dl
 1fd:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 201:	89 ca                	mov    %ecx,%edx
 203:	89 c1                	mov    %eax,%ecx
 205:	39 d6                	cmp    %edx,%esi
 207:	76 e2                	jbe    1eb <printint+0x26>
  if(neg)
 209:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 20d:	74 24                	je     233 <printint+0x6e>
    buf[i++] = '-';
 20f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 214:	8d 5f 02             	lea    0x2(%edi),%ebx
 217:	eb 1a                	jmp    233 <printint+0x6e>
    x = -xx;
 219:	89 d1                	mov    %edx,%ecx
 21b:	f7 d9                	neg    %ecx
    neg = 1;
 21d:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 224:	eb c0                	jmp    1e6 <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 226:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 22b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 22e:	e8 78 ff ff ff       	call   1ab <putc>
  while(--i >= 0)
 233:	4b                   	dec    %ebx
 234:	79 f0                	jns    226 <printint+0x61>
}
 236:	83 c4 2c             	add    $0x2c,%esp
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5f                   	pop    %edi
 23c:	5d                   	pop    %ebp
 23d:	c3                   	ret    

0000023e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 23e:	55                   	push   %ebp
 23f:	89 e5                	mov    %esp,%ebp
 241:	57                   	push   %edi
 242:	56                   	push   %esi
 243:	53                   	push   %ebx
 244:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 247:	8d 45 10             	lea    0x10(%ebp),%eax
 24a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 24d:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 252:	bb 00 00 00 00       	mov    $0x0,%ebx
 257:	eb 12                	jmp    26b <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 259:	89 fa                	mov    %edi,%edx
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	e8 48 ff ff ff       	call   1ab <putc>
 263:	eb 05                	jmp    26a <printf+0x2c>
      }
    } else if(state == '%'){
 265:	83 fe 25             	cmp    $0x25,%esi
 268:	74 22                	je     28c <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 26a:	43                   	inc    %ebx
 26b:	8b 45 0c             	mov    0xc(%ebp),%eax
 26e:	8a 04 18             	mov    (%eax,%ebx,1),%al
 271:	84 c0                	test   %al,%al
 273:	0f 84 1d 01 00 00    	je     396 <printf+0x158>
    c = fmt[i] & 0xff;
 279:	0f be f8             	movsbl %al,%edi
 27c:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 27f:	85 f6                	test   %esi,%esi
 281:	75 e2                	jne    265 <printf+0x27>
      if(c == '%'){
 283:	83 f8 25             	cmp    $0x25,%eax
 286:	75 d1                	jne    259 <printf+0x1b>
        state = '%';
 288:	89 c6                	mov    %eax,%esi
 28a:	eb de                	jmp    26a <printf+0x2c>
      if(c == 'd'){
 28c:	83 f8 25             	cmp    $0x25,%eax
 28f:	0f 84 cc 00 00 00    	je     361 <printf+0x123>
 295:	0f 8c da 00 00 00    	jl     375 <printf+0x137>
 29b:	83 f8 78             	cmp    $0x78,%eax
 29e:	0f 8f d1 00 00 00    	jg     375 <printf+0x137>
 2a4:	83 f8 63             	cmp    $0x63,%eax
 2a7:	0f 8c c8 00 00 00    	jl     375 <printf+0x137>
 2ad:	83 e8 63             	sub    $0x63,%eax
 2b0:	83 f8 15             	cmp    $0x15,%eax
 2b3:	0f 87 bc 00 00 00    	ja     375 <printf+0x137>
 2b9:	ff 24 85 f8 03 00 00 	jmp    *0x3f8(,%eax,4)
        printint(fd, *ap, 10, 1);
 2c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2c3:	8b 17                	mov    (%edi),%edx
 2c5:	83 ec 0c             	sub    $0xc,%esp
 2c8:	6a 01                	push   $0x1
 2ca:	b9 0a 00 00 00       	mov    $0xa,%ecx
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	e8 ee fe ff ff       	call   1c5 <printint>
        ap++;
 2d7:	83 c7 04             	add    $0x4,%edi
 2da:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 2dd:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 2e0:	be 00 00 00 00       	mov    $0x0,%esi
 2e5:	eb 83                	jmp    26a <printf+0x2c>
        printint(fd, *ap, 16, 0);
 2e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2ea:	8b 17                	mov    (%edi),%edx
 2ec:	83 ec 0c             	sub    $0xc,%esp
 2ef:	6a 00                	push   $0x0
 2f1:	b9 10 00 00 00       	mov    $0x10,%ecx
 2f6:	8b 45 08             	mov    0x8(%ebp),%eax
 2f9:	e8 c7 fe ff ff       	call   1c5 <printint>
        ap++;
 2fe:	83 c7 04             	add    $0x4,%edi
 301:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 304:	83 c4 10             	add    $0x10,%esp
      state = 0;
 307:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 30c:	e9 59 ff ff ff       	jmp    26a <printf+0x2c>
        s = (char*)*ap;
 311:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 314:	8b 30                	mov    (%eax),%esi
        ap++;
 316:	83 c0 04             	add    $0x4,%eax
 319:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 31c:	85 f6                	test   %esi,%esi
 31e:	75 13                	jne    333 <printf+0xf5>
          s = "(null)";
 320:	be f0 03 00 00       	mov    $0x3f0,%esi
 325:	eb 0c                	jmp    333 <printf+0xf5>
          putc(fd, *s);
 327:	0f be d2             	movsbl %dl,%edx
 32a:	8b 45 08             	mov    0x8(%ebp),%eax
 32d:	e8 79 fe ff ff       	call   1ab <putc>
          s++;
 332:	46                   	inc    %esi
        while(*s != 0){
 333:	8a 16                	mov    (%esi),%dl
 335:	84 d2                	test   %dl,%dl
 337:	75 ee                	jne    327 <printf+0xe9>
      state = 0;
 339:	be 00 00 00 00       	mov    $0x0,%esi
 33e:	e9 27 ff ff ff       	jmp    26a <printf+0x2c>
        putc(fd, *ap);
 343:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 346:	0f be 17             	movsbl (%edi),%edx
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	e8 5a fe ff ff       	call   1ab <putc>
        ap++;
 351:	83 c7 04             	add    $0x4,%edi
 354:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 357:	be 00 00 00 00       	mov    $0x0,%esi
 35c:	e9 09 ff ff ff       	jmp    26a <printf+0x2c>
        putc(fd, c);
 361:	89 fa                	mov    %edi,%edx
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	e8 40 fe ff ff       	call   1ab <putc>
      state = 0;
 36b:	be 00 00 00 00       	mov    $0x0,%esi
 370:	e9 f5 fe ff ff       	jmp    26a <printf+0x2c>
        putc(fd, '%');
 375:	ba 25 00 00 00       	mov    $0x25,%edx
 37a:	8b 45 08             	mov    0x8(%ebp),%eax
 37d:	e8 29 fe ff ff       	call   1ab <putc>
        putc(fd, c);
 382:	89 fa                	mov    %edi,%edx
 384:	8b 45 08             	mov    0x8(%ebp),%eax
 387:	e8 1f fe ff ff       	call   1ab <putc>
      state = 0;
 38c:	be 00 00 00 00       	mov    $0x0,%esi
 391:	e9 d4 fe ff ff       	jmp    26a <printf+0x2c>
    }
  }
}
 396:	8d 65 f4             	lea    -0xc(%ebp),%esp
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5f                   	pop    %edi
 39c:	5d                   	pop    %ebp
 39d:	c3                   	ret    
