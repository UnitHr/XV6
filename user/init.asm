
init:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  13:	83 ec 08             	sub    $0x8,%esp
  16:	6a 02                	push   $0x2
  18:	68 84 03 00 00       	push   $0x384
  1d:	e8 07 01 00 00       	call   129 <open>
  22:	83 c4 10             	add    $0x10,%esp
  25:	85 c0                	test   %eax,%eax
  27:	78 59                	js     82 <main+0x82>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 2e 01 00 00       	call   161 <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 22 01 00 00       	call   161 <dup>
  3f:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  42:	83 ec 08             	sub    $0x8,%esp
  45:	68 8c 03 00 00       	push   $0x38c
  4a:	6a 01                	push   $0x1
  4c:	e8 d7 01 00 00       	call   228 <printf>
    pid = fork();
  51:	e8 8b 00 00 00       	call   e1 <fork>
  56:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  58:	83 c4 10             	add    $0x10,%esp
  5b:	85 c0                	test   %eax,%eax
  5d:	78 48                	js     a7 <main+0xa7>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  5f:	74 5a                	je     bb <main+0xbb>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  61:	e8 8b 00 00 00       	call   f1 <wait>
  66:	85 c0                	test   %eax,%eax
  68:	78 d8                	js     42 <main+0x42>
  6a:	39 c3                	cmp    %eax,%ebx
  6c:	74 d4                	je     42 <main+0x42>
      printf(1, "zombie!\n");
  6e:	83 ec 08             	sub    $0x8,%esp
  71:	68 cb 03 00 00       	push   $0x3cb
  76:	6a 01                	push   $0x1
  78:	e8 ab 01 00 00       	call   228 <printf>
  7d:	83 c4 10             	add    $0x10,%esp
  80:	eb df                	jmp    61 <main+0x61>
    mknod("console", 1, 1);
  82:	83 ec 04             	sub    $0x4,%esp
  85:	6a 01                	push   $0x1
  87:	6a 01                	push   $0x1
  89:	68 84 03 00 00       	push   $0x384
  8e:	e8 9e 00 00 00       	call   131 <mknod>
    open("console", O_RDWR);
  93:	83 c4 08             	add    $0x8,%esp
  96:	6a 02                	push   $0x2
  98:	68 84 03 00 00       	push   $0x384
  9d:	e8 87 00 00 00       	call   129 <open>
  a2:	83 c4 10             	add    $0x10,%esp
  a5:	eb 82                	jmp    29 <main+0x29>
      printf(1, "init: fork failed\n");
  a7:	83 ec 08             	sub    $0x8,%esp
  aa:	68 9f 03 00 00       	push   $0x39f
  af:	6a 01                	push   $0x1
  b1:	e8 72 01 00 00       	call   228 <printf>
      exit();
  b6:	e8 2e 00 00 00       	call   e9 <exit>
      exec("sh", argv);
  bb:	83 ec 08             	sub    $0x8,%esp
  be:	68 ac 04 00 00       	push   $0x4ac
  c3:	68 b2 03 00 00       	push   $0x3b2
  c8:	e8 54 00 00 00       	call   121 <exec>
      printf(1, "init: exec sh failed\n");
  cd:	83 c4 08             	add    $0x8,%esp
  d0:	68 b5 03 00 00       	push   $0x3b5
  d5:	6a 01                	push   $0x1
  d7:	e8 4c 01 00 00       	call   228 <printf>
      exit();
  dc:	e8 08 00 00 00       	call   e9 <exit>

000000e1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  e1:	b8 01 00 00 00       	mov    $0x1,%eax
  e6:	cd 40                	int    $0x40
  e8:	c3                   	ret    

000000e9 <exit>:
SYSCALL(exit)
  e9:	b8 02 00 00 00       	mov    $0x2,%eax
  ee:	cd 40                	int    $0x40
  f0:	c3                   	ret    

000000f1 <wait>:
SYSCALL(wait)
  f1:	b8 03 00 00 00       	mov    $0x3,%eax
  f6:	cd 40                	int    $0x40
  f8:	c3                   	ret    

000000f9 <pipe>:
SYSCALL(pipe)
  f9:	b8 04 00 00 00       	mov    $0x4,%eax
  fe:	cd 40                	int    $0x40
 100:	c3                   	ret    

00000101 <read>:
SYSCALL(read)
 101:	b8 05 00 00 00       	mov    $0x5,%eax
 106:	cd 40                	int    $0x40
 108:	c3                   	ret    

00000109 <write>:
SYSCALL(write)
 109:	b8 10 00 00 00       	mov    $0x10,%eax
 10e:	cd 40                	int    $0x40
 110:	c3                   	ret    

00000111 <close>:
SYSCALL(close)
 111:	b8 15 00 00 00       	mov    $0x15,%eax
 116:	cd 40                	int    $0x40
 118:	c3                   	ret    

00000119 <kill>:
SYSCALL(kill)
 119:	b8 06 00 00 00       	mov    $0x6,%eax
 11e:	cd 40                	int    $0x40
 120:	c3                   	ret    

00000121 <exec>:
SYSCALL(exec)
 121:	b8 07 00 00 00       	mov    $0x7,%eax
 126:	cd 40                	int    $0x40
 128:	c3                   	ret    

00000129 <open>:
SYSCALL(open)
 129:	b8 0f 00 00 00       	mov    $0xf,%eax
 12e:	cd 40                	int    $0x40
 130:	c3                   	ret    

00000131 <mknod>:
SYSCALL(mknod)
 131:	b8 11 00 00 00       	mov    $0x11,%eax
 136:	cd 40                	int    $0x40
 138:	c3                   	ret    

00000139 <unlink>:
SYSCALL(unlink)
 139:	b8 12 00 00 00       	mov    $0x12,%eax
 13e:	cd 40                	int    $0x40
 140:	c3                   	ret    

00000141 <fstat>:
SYSCALL(fstat)
 141:	b8 08 00 00 00       	mov    $0x8,%eax
 146:	cd 40                	int    $0x40
 148:	c3                   	ret    

00000149 <link>:
SYSCALL(link)
 149:	b8 13 00 00 00       	mov    $0x13,%eax
 14e:	cd 40                	int    $0x40
 150:	c3                   	ret    

00000151 <mkdir>:
SYSCALL(mkdir)
 151:	b8 14 00 00 00       	mov    $0x14,%eax
 156:	cd 40                	int    $0x40
 158:	c3                   	ret    

00000159 <chdir>:
SYSCALL(chdir)
 159:	b8 09 00 00 00       	mov    $0x9,%eax
 15e:	cd 40                	int    $0x40
 160:	c3                   	ret    

00000161 <dup>:
SYSCALL(dup)
 161:	b8 0a 00 00 00       	mov    $0xa,%eax
 166:	cd 40                	int    $0x40
 168:	c3                   	ret    

00000169 <getpid>:
SYSCALL(getpid)
 169:	b8 0b 00 00 00       	mov    $0xb,%eax
 16e:	cd 40                	int    $0x40
 170:	c3                   	ret    

00000171 <sbrk>:
SYSCALL(sbrk)
 171:	b8 0c 00 00 00       	mov    $0xc,%eax
 176:	cd 40                	int    $0x40
 178:	c3                   	ret    

00000179 <sleep>:
SYSCALL(sleep)
 179:	b8 0d 00 00 00       	mov    $0xd,%eax
 17e:	cd 40                	int    $0x40
 180:	c3                   	ret    

00000181 <uptime>:
SYSCALL(uptime)
 181:	b8 0e 00 00 00       	mov    $0xe,%eax
 186:	cd 40                	int    $0x40
 188:	c3                   	ret    

00000189 <date>:
SYSCALL(date)
 189:	b8 16 00 00 00       	mov    $0x16,%eax
 18e:	cd 40                	int    $0x40
 190:	c3                   	ret    

00000191 <dup2>:
SYSCALL(dup2)
 191:	b8 17 00 00 00       	mov    $0x17,%eax
 196:	cd 40                	int    $0x40
 198:	c3                   	ret    

00000199 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 1c             	sub    $0x1c,%esp
 19f:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 1a2:	6a 01                	push   $0x1
 1a4:	8d 55 f4             	lea    -0xc(%ebp),%edx
 1a7:	52                   	push   %edx
 1a8:	50                   	push   %eax
 1a9:	e8 5b ff ff ff       	call   109 <write>
}
 1ae:	83 c4 10             	add    $0x10,%esp
 1b1:	c9                   	leave  
 1b2:	c3                   	ret    

000001b3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	57                   	push   %edi
 1b7:	56                   	push   %esi
 1b8:	53                   	push   %ebx
 1b9:	83 ec 2c             	sub    $0x2c,%esp
 1bc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 1bf:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 1c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 1c5:	74 04                	je     1cb <printint+0x18>
 1c7:	85 d2                	test   %edx,%edx
 1c9:	78 3a                	js     205 <printint+0x52>
  neg = 0;
 1cb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 1d2:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 1d7:	89 f0                	mov    %esi,%eax
 1d9:	ba 00 00 00 00       	mov    $0x0,%edx
 1de:	f7 f1                	div    %ecx
 1e0:	89 df                	mov    %ebx,%edi
 1e2:	43                   	inc    %ebx
 1e3:	8a 92 dc 03 00 00    	mov    0x3dc(%edx),%dl
 1e9:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 1ed:	89 f2                	mov    %esi,%edx
 1ef:	89 c6                	mov    %eax,%esi
 1f1:	39 d1                	cmp    %edx,%ecx
 1f3:	76 e2                	jbe    1d7 <printint+0x24>
  if(neg)
 1f5:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 1f9:	74 22                	je     21d <printint+0x6a>
    buf[i++] = '-';
 1fb:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 200:	8d 5f 02             	lea    0x2(%edi),%ebx
 203:	eb 18                	jmp    21d <printint+0x6a>
    x = -xx;
 205:	f7 de                	neg    %esi
    neg = 1;
 207:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 20e:	eb c2                	jmp    1d2 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 210:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 215:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 218:	e8 7c ff ff ff       	call   199 <putc>
  while(--i >= 0)
 21d:	4b                   	dec    %ebx
 21e:	79 f0                	jns    210 <printint+0x5d>
}
 220:	83 c4 2c             	add    $0x2c,%esp
 223:	5b                   	pop    %ebx
 224:	5e                   	pop    %esi
 225:	5f                   	pop    %edi
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    

00000228 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 228:	f3 0f 1e fb          	endbr32 
 22c:	55                   	push   %ebp
 22d:	89 e5                	mov    %esp,%ebp
 22f:	57                   	push   %edi
 230:	56                   	push   %esi
 231:	53                   	push   %ebx
 232:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 235:	8d 45 10             	lea    0x10(%ebp),%eax
 238:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 23b:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 240:	bb 00 00 00 00       	mov    $0x0,%ebx
 245:	eb 12                	jmp    259 <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 247:	89 fa                	mov    %edi,%edx
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	e8 48 ff ff ff       	call   199 <putc>
 251:	eb 05                	jmp    258 <printf+0x30>
      }
    } else if(state == '%'){
 253:	83 fe 25             	cmp    $0x25,%esi
 256:	74 22                	je     27a <printf+0x52>
  for(i = 0; fmt[i]; i++){
 258:	43                   	inc    %ebx
 259:	8b 45 0c             	mov    0xc(%ebp),%eax
 25c:	8a 04 18             	mov    (%eax,%ebx,1),%al
 25f:	84 c0                	test   %al,%al
 261:	0f 84 13 01 00 00    	je     37a <printf+0x152>
    c = fmt[i] & 0xff;
 267:	0f be f8             	movsbl %al,%edi
 26a:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 26d:	85 f6                	test   %esi,%esi
 26f:	75 e2                	jne    253 <printf+0x2b>
      if(c == '%'){
 271:	83 f8 25             	cmp    $0x25,%eax
 274:	75 d1                	jne    247 <printf+0x1f>
        state = '%';
 276:	89 c6                	mov    %eax,%esi
 278:	eb de                	jmp    258 <printf+0x30>
      if(c == 'd'){
 27a:	83 f8 64             	cmp    $0x64,%eax
 27d:	74 43                	je     2c2 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 27f:	83 f8 78             	cmp    $0x78,%eax
 282:	74 68                	je     2ec <printf+0xc4>
 284:	83 f8 70             	cmp    $0x70,%eax
 287:	74 63                	je     2ec <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 289:	83 f8 73             	cmp    $0x73,%eax
 28c:	0f 84 84 00 00 00    	je     316 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 292:	83 f8 63             	cmp    $0x63,%eax
 295:	0f 84 ad 00 00 00    	je     348 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 29b:	83 f8 25             	cmp    $0x25,%eax
 29e:	0f 84 c2 00 00 00    	je     366 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 2a4:	ba 25 00 00 00       	mov    $0x25,%edx
 2a9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ac:	e8 e8 fe ff ff       	call   199 <putc>
        putc(fd, c);
 2b1:	89 fa                	mov    %edi,%edx
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	e8 de fe ff ff       	call   199 <putc>
      }
      state = 0;
 2bb:	be 00 00 00 00       	mov    $0x0,%esi
 2c0:	eb 96                	jmp    258 <printf+0x30>
        printint(fd, *ap, 10, 1);
 2c2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2c5:	8b 17                	mov    (%edi),%edx
 2c7:	83 ec 0c             	sub    $0xc,%esp
 2ca:	6a 01                	push   $0x1
 2cc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	e8 da fe ff ff       	call   1b3 <printint>
        ap++;
 2d9:	83 c7 04             	add    $0x4,%edi
 2dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 2df:	83 c4 10             	add    $0x10,%esp
      state = 0;
 2e2:	be 00 00 00 00       	mov    $0x0,%esi
 2e7:	e9 6c ff ff ff       	jmp    258 <printf+0x30>
        printint(fd, *ap, 16, 0);
 2ec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2ef:	8b 17                	mov    (%edi),%edx
 2f1:	83 ec 0c             	sub    $0xc,%esp
 2f4:	6a 00                	push   $0x0
 2f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
 2fe:	e8 b0 fe ff ff       	call   1b3 <printint>
        ap++;
 303:	83 c7 04             	add    $0x4,%edi
 306:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 309:	83 c4 10             	add    $0x10,%esp
      state = 0;
 30c:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 311:	e9 42 ff ff ff       	jmp    258 <printf+0x30>
        s = (char*)*ap;
 316:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 319:	8b 30                	mov    (%eax),%esi
        ap++;
 31b:	83 c0 04             	add    $0x4,%eax
 31e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 321:	85 f6                	test   %esi,%esi
 323:	75 13                	jne    338 <printf+0x110>
          s = "(null)";
 325:	be d4 03 00 00       	mov    $0x3d4,%esi
 32a:	eb 0c                	jmp    338 <printf+0x110>
          putc(fd, *s);
 32c:	0f be d2             	movsbl %dl,%edx
 32f:	8b 45 08             	mov    0x8(%ebp),%eax
 332:	e8 62 fe ff ff       	call   199 <putc>
          s++;
 337:	46                   	inc    %esi
        while(*s != 0){
 338:	8a 16                	mov    (%esi),%dl
 33a:	84 d2                	test   %dl,%dl
 33c:	75 ee                	jne    32c <printf+0x104>
      state = 0;
 33e:	be 00 00 00 00       	mov    $0x0,%esi
 343:	e9 10 ff ff ff       	jmp    258 <printf+0x30>
        putc(fd, *ap);
 348:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 34b:	0f be 17             	movsbl (%edi),%edx
 34e:	8b 45 08             	mov    0x8(%ebp),%eax
 351:	e8 43 fe ff ff       	call   199 <putc>
        ap++;
 356:	83 c7 04             	add    $0x4,%edi
 359:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 35c:	be 00 00 00 00       	mov    $0x0,%esi
 361:	e9 f2 fe ff ff       	jmp    258 <printf+0x30>
        putc(fd, c);
 366:	89 fa                	mov    %edi,%edx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	e8 29 fe ff ff       	call   199 <putc>
      state = 0;
 370:	be 00 00 00 00       	mov    $0x0,%esi
 375:	e9 de fe ff ff       	jmp    258 <printf+0x30>
    }
  }
}
 37a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37d:	5b                   	pop    %ebx
 37e:	5e                   	pop    %esi
 37f:	5f                   	pop    %edi
 380:	5d                   	pop    %ebp
 381:	c3                   	ret    
