
rm:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 18             	sub    $0x18,%esp
  18:	8b 01                	mov    (%ecx),%eax
  1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1d:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  20:	83 f8 01             	cmp    $0x1,%eax
  23:	7e 21                	jle    46 <main+0x46>
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  25:	bb 01 00 00 00       	mov    $0x1,%ebx
  2a:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  2d:	7d 3f                	jge    6e <main+0x6e>
    if(unlink(argv[i]) < 0){
  2f:	8d 34 9f             	lea    (%edi,%ebx,4),%esi
  32:	83 ec 0c             	sub    $0xc,%esp
  35:	ff 36                	pushl  (%esi)
  37:	e8 8f 00 00 00       	call   cb <unlink>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	78 17                	js     5a <main+0x5a>
  for(i = 1; i < argc; i++){
  43:	43                   	inc    %ebx
  44:	eb e4                	jmp    2a <main+0x2a>
    printf(2, "Usage: rm files...\n");
  46:	83 ec 08             	sub    $0x8,%esp
  49:	68 14 03 00 00       	push   $0x314
  4e:	6a 02                	push   $0x2
  50:	e8 65 01 00 00       	call   1ba <printf>
    exit();
  55:	e8 21 00 00 00       	call   7b <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	83 ec 04             	sub    $0x4,%esp
  5d:	ff 36                	pushl  (%esi)
  5f:	68 28 03 00 00       	push   $0x328
  64:	6a 02                	push   $0x2
  66:	e8 4f 01 00 00       	call   1ba <printf>
      break;
  6b:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit();
  6e:	e8 08 00 00 00       	call   7b <exit>

00000073 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  73:	b8 01 00 00 00       	mov    $0x1,%eax
  78:	cd 40                	int    $0x40
  7a:	c3                   	ret    

0000007b <exit>:
SYSCALL(exit)
  7b:	b8 02 00 00 00       	mov    $0x2,%eax
  80:	cd 40                	int    $0x40
  82:	c3                   	ret    

00000083 <wait>:
SYSCALL(wait)
  83:	b8 03 00 00 00       	mov    $0x3,%eax
  88:	cd 40                	int    $0x40
  8a:	c3                   	ret    

0000008b <pipe>:
SYSCALL(pipe)
  8b:	b8 04 00 00 00       	mov    $0x4,%eax
  90:	cd 40                	int    $0x40
  92:	c3                   	ret    

00000093 <read>:
SYSCALL(read)
  93:	b8 05 00 00 00       	mov    $0x5,%eax
  98:	cd 40                	int    $0x40
  9a:	c3                   	ret    

0000009b <write>:
SYSCALL(write)
  9b:	b8 10 00 00 00       	mov    $0x10,%eax
  a0:	cd 40                	int    $0x40
  a2:	c3                   	ret    

000000a3 <close>:
SYSCALL(close)
  a3:	b8 15 00 00 00       	mov    $0x15,%eax
  a8:	cd 40                	int    $0x40
  aa:	c3                   	ret    

000000ab <kill>:
SYSCALL(kill)
  ab:	b8 06 00 00 00       	mov    $0x6,%eax
  b0:	cd 40                	int    $0x40
  b2:	c3                   	ret    

000000b3 <exec>:
SYSCALL(exec)
  b3:	b8 07 00 00 00       	mov    $0x7,%eax
  b8:	cd 40                	int    $0x40
  ba:	c3                   	ret    

000000bb <open>:
SYSCALL(open)
  bb:	b8 0f 00 00 00       	mov    $0xf,%eax
  c0:	cd 40                	int    $0x40
  c2:	c3                   	ret    

000000c3 <mknod>:
SYSCALL(mknod)
  c3:	b8 11 00 00 00       	mov    $0x11,%eax
  c8:	cd 40                	int    $0x40
  ca:	c3                   	ret    

000000cb <unlink>:
SYSCALL(unlink)
  cb:	b8 12 00 00 00       	mov    $0x12,%eax
  d0:	cd 40                	int    $0x40
  d2:	c3                   	ret    

000000d3 <fstat>:
SYSCALL(fstat)
  d3:	b8 08 00 00 00       	mov    $0x8,%eax
  d8:	cd 40                	int    $0x40
  da:	c3                   	ret    

000000db <link>:
SYSCALL(link)
  db:	b8 13 00 00 00       	mov    $0x13,%eax
  e0:	cd 40                	int    $0x40
  e2:	c3                   	ret    

000000e3 <mkdir>:
SYSCALL(mkdir)
  e3:	b8 14 00 00 00       	mov    $0x14,%eax
  e8:	cd 40                	int    $0x40
  ea:	c3                   	ret    

000000eb <chdir>:
SYSCALL(chdir)
  eb:	b8 09 00 00 00       	mov    $0x9,%eax
  f0:	cd 40                	int    $0x40
  f2:	c3                   	ret    

000000f3 <dup>:
SYSCALL(dup)
  f3:	b8 0a 00 00 00       	mov    $0xa,%eax
  f8:	cd 40                	int    $0x40
  fa:	c3                   	ret    

000000fb <getpid>:
SYSCALL(getpid)
  fb:	b8 0b 00 00 00       	mov    $0xb,%eax
 100:	cd 40                	int    $0x40
 102:	c3                   	ret    

00000103 <sbrk>:
SYSCALL(sbrk)
 103:	b8 0c 00 00 00       	mov    $0xc,%eax
 108:	cd 40                	int    $0x40
 10a:	c3                   	ret    

0000010b <sleep>:
SYSCALL(sleep)
 10b:	b8 0d 00 00 00       	mov    $0xd,%eax
 110:	cd 40                	int    $0x40
 112:	c3                   	ret    

00000113 <uptime>:
SYSCALL(uptime)
 113:	b8 0e 00 00 00       	mov    $0xe,%eax
 118:	cd 40                	int    $0x40
 11a:	c3                   	ret    

0000011b <date>:
SYSCALL(date)
 11b:	b8 16 00 00 00       	mov    $0x16,%eax
 120:	cd 40                	int    $0x40
 122:	c3                   	ret    

00000123 <dup2>:
SYSCALL(dup2)
 123:	b8 17 00 00 00       	mov    $0x17,%eax
 128:	cd 40                	int    $0x40
 12a:	c3                   	ret    

0000012b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 12b:	55                   	push   %ebp
 12c:	89 e5                	mov    %esp,%ebp
 12e:	83 ec 1c             	sub    $0x1c,%esp
 131:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 134:	6a 01                	push   $0x1
 136:	8d 55 f4             	lea    -0xc(%ebp),%edx
 139:	52                   	push   %edx
 13a:	50                   	push   %eax
 13b:	e8 5b ff ff ff       	call   9b <write>
}
 140:	83 c4 10             	add    $0x10,%esp
 143:	c9                   	leave  
 144:	c3                   	ret    

00000145 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
 148:	57                   	push   %edi
 149:	56                   	push   %esi
 14a:	53                   	push   %ebx
 14b:	83 ec 2c             	sub    $0x2c,%esp
 14e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 151:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 153:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 157:	74 04                	je     15d <printint+0x18>
 159:	85 d2                	test   %edx,%edx
 15b:	78 3a                	js     197 <printint+0x52>
  neg = 0;
 15d:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 164:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 169:	89 f0                	mov    %esi,%eax
 16b:	ba 00 00 00 00       	mov    $0x0,%edx
 170:	f7 f1                	div    %ecx
 172:	89 df                	mov    %ebx,%edi
 174:	43                   	inc    %ebx
 175:	8a 92 48 03 00 00    	mov    0x348(%edx),%dl
 17b:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 17f:	89 f2                	mov    %esi,%edx
 181:	89 c6                	mov    %eax,%esi
 183:	39 d1                	cmp    %edx,%ecx
 185:	76 e2                	jbe    169 <printint+0x24>
  if(neg)
 187:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 18b:	74 22                	je     1af <printint+0x6a>
    buf[i++] = '-';
 18d:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 192:	8d 5f 02             	lea    0x2(%edi),%ebx
 195:	eb 18                	jmp    1af <printint+0x6a>
    x = -xx;
 197:	f7 de                	neg    %esi
    neg = 1;
 199:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 1a0:	eb c2                	jmp    164 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 1a2:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 1a7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1aa:	e8 7c ff ff ff       	call   12b <putc>
  while(--i >= 0)
 1af:	4b                   	dec    %ebx
 1b0:	79 f0                	jns    1a2 <printint+0x5d>
}
 1b2:	83 c4 2c             	add    $0x2c,%esp
 1b5:	5b                   	pop    %ebx
 1b6:	5e                   	pop    %esi
 1b7:	5f                   	pop    %edi
 1b8:	5d                   	pop    %ebp
 1b9:	c3                   	ret    

000001ba <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 1ba:	f3 0f 1e fb          	endbr32 
 1be:	55                   	push   %ebp
 1bf:	89 e5                	mov    %esp,%ebp
 1c1:	57                   	push   %edi
 1c2:	56                   	push   %esi
 1c3:	53                   	push   %ebx
 1c4:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 1c7:	8d 45 10             	lea    0x10(%ebp),%eax
 1ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 1cd:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 1d2:	bb 00 00 00 00       	mov    $0x0,%ebx
 1d7:	eb 12                	jmp    1eb <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 1d9:	89 fa                	mov    %edi,%edx
 1db:	8b 45 08             	mov    0x8(%ebp),%eax
 1de:	e8 48 ff ff ff       	call   12b <putc>
 1e3:	eb 05                	jmp    1ea <printf+0x30>
      }
    } else if(state == '%'){
 1e5:	83 fe 25             	cmp    $0x25,%esi
 1e8:	74 22                	je     20c <printf+0x52>
  for(i = 0; fmt[i]; i++){
 1ea:	43                   	inc    %ebx
 1eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ee:	8a 04 18             	mov    (%eax,%ebx,1),%al
 1f1:	84 c0                	test   %al,%al
 1f3:	0f 84 13 01 00 00    	je     30c <printf+0x152>
    c = fmt[i] & 0xff;
 1f9:	0f be f8             	movsbl %al,%edi
 1fc:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 1ff:	85 f6                	test   %esi,%esi
 201:	75 e2                	jne    1e5 <printf+0x2b>
      if(c == '%'){
 203:	83 f8 25             	cmp    $0x25,%eax
 206:	75 d1                	jne    1d9 <printf+0x1f>
        state = '%';
 208:	89 c6                	mov    %eax,%esi
 20a:	eb de                	jmp    1ea <printf+0x30>
      if(c == 'd'){
 20c:	83 f8 64             	cmp    $0x64,%eax
 20f:	74 43                	je     254 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 211:	83 f8 78             	cmp    $0x78,%eax
 214:	74 68                	je     27e <printf+0xc4>
 216:	83 f8 70             	cmp    $0x70,%eax
 219:	74 63                	je     27e <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 21b:	83 f8 73             	cmp    $0x73,%eax
 21e:	0f 84 84 00 00 00    	je     2a8 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 224:	83 f8 63             	cmp    $0x63,%eax
 227:	0f 84 ad 00 00 00    	je     2da <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 22d:	83 f8 25             	cmp    $0x25,%eax
 230:	0f 84 c2 00 00 00    	je     2f8 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 236:	ba 25 00 00 00       	mov    $0x25,%edx
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	e8 e8 fe ff ff       	call   12b <putc>
        putc(fd, c);
 243:	89 fa                	mov    %edi,%edx
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	e8 de fe ff ff       	call   12b <putc>
      }
      state = 0;
 24d:	be 00 00 00 00       	mov    $0x0,%esi
 252:	eb 96                	jmp    1ea <printf+0x30>
        printint(fd, *ap, 10, 1);
 254:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 257:	8b 17                	mov    (%edi),%edx
 259:	83 ec 0c             	sub    $0xc,%esp
 25c:	6a 01                	push   $0x1
 25e:	b9 0a 00 00 00       	mov    $0xa,%ecx
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	e8 da fe ff ff       	call   145 <printint>
        ap++;
 26b:	83 c7 04             	add    $0x4,%edi
 26e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 271:	83 c4 10             	add    $0x10,%esp
      state = 0;
 274:	be 00 00 00 00       	mov    $0x0,%esi
 279:	e9 6c ff ff ff       	jmp    1ea <printf+0x30>
        printint(fd, *ap, 16, 0);
 27e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 281:	8b 17                	mov    (%edi),%edx
 283:	83 ec 0c             	sub    $0xc,%esp
 286:	6a 00                	push   $0x0
 288:	b9 10 00 00 00       	mov    $0x10,%ecx
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
 290:	e8 b0 fe ff ff       	call   145 <printint>
        ap++;
 295:	83 c7 04             	add    $0x4,%edi
 298:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 29b:	83 c4 10             	add    $0x10,%esp
      state = 0;
 29e:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 2a3:	e9 42 ff ff ff       	jmp    1ea <printf+0x30>
        s = (char*)*ap;
 2a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2ab:	8b 30                	mov    (%eax),%esi
        ap++;
 2ad:	83 c0 04             	add    $0x4,%eax
 2b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 2b3:	85 f6                	test   %esi,%esi
 2b5:	75 13                	jne    2ca <printf+0x110>
          s = "(null)";
 2b7:	be 41 03 00 00       	mov    $0x341,%esi
 2bc:	eb 0c                	jmp    2ca <printf+0x110>
          putc(fd, *s);
 2be:	0f be d2             	movsbl %dl,%edx
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	e8 62 fe ff ff       	call   12b <putc>
          s++;
 2c9:	46                   	inc    %esi
        while(*s != 0){
 2ca:	8a 16                	mov    (%esi),%dl
 2cc:	84 d2                	test   %dl,%dl
 2ce:	75 ee                	jne    2be <printf+0x104>
      state = 0;
 2d0:	be 00 00 00 00       	mov    $0x0,%esi
 2d5:	e9 10 ff ff ff       	jmp    1ea <printf+0x30>
        putc(fd, *ap);
 2da:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2dd:	0f be 17             	movsbl (%edi),%edx
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	e8 43 fe ff ff       	call   12b <putc>
        ap++;
 2e8:	83 c7 04             	add    $0x4,%edi
 2eb:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 2ee:	be 00 00 00 00       	mov    $0x0,%esi
 2f3:	e9 f2 fe ff ff       	jmp    1ea <printf+0x30>
        putc(fd, c);
 2f8:	89 fa                	mov    %edi,%edx
 2fa:	8b 45 08             	mov    0x8(%ebp),%eax
 2fd:	e8 29 fe ff ff       	call   12b <putc>
      state = 0;
 302:	be 00 00 00 00       	mov    $0x0,%esi
 307:	e9 de fe ff ff       	jmp    1ea <printf+0x30>
    }
  }
}
 30c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30f:	5b                   	pop    %ebx
 310:	5e                   	pop    %esi
 311:	5f                   	pop    %edi
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
