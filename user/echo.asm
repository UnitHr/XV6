
echo:     formato del fichero elf32-i386


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
  15:	83 ec 08             	sub    $0x8,%esp
  18:	8b 31                	mov    (%ecx),%esi
  1a:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
  1d:	b8 01 00 00 00       	mov    $0x1,%eax
  22:	eb 1a                	jmp    3e <main+0x3e>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  24:	ba f8 02 00 00       	mov    $0x2f8,%edx
  29:	52                   	push   %edx
  2a:	ff 34 87             	pushl  (%edi,%eax,4)
  2d:	68 fc 02 00 00       	push   $0x2fc
  32:	6a 01                	push   $0x1
  34:	e8 63 01 00 00       	call   19c <printf>
  39:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
  3c:	89 d8                	mov    %ebx,%eax
  3e:	39 f0                	cmp    %esi,%eax
  40:	7d 0e                	jge    50 <main+0x50>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  42:	8d 58 01             	lea    0x1(%eax),%ebx
  45:	39 f3                	cmp    %esi,%ebx
  47:	7d db                	jge    24 <main+0x24>
  49:	ba fa 02 00 00       	mov    $0x2fa,%edx
  4e:	eb d9                	jmp    29 <main+0x29>
  exit();
  50:	e8 08 00 00 00       	call   5d <exit>

00000055 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  55:	b8 01 00 00 00       	mov    $0x1,%eax
  5a:	cd 40                	int    $0x40
  5c:	c3                   	ret    

0000005d <exit>:
SYSCALL(exit)
  5d:	b8 02 00 00 00       	mov    $0x2,%eax
  62:	cd 40                	int    $0x40
  64:	c3                   	ret    

00000065 <wait>:
SYSCALL(wait)
  65:	b8 03 00 00 00       	mov    $0x3,%eax
  6a:	cd 40                	int    $0x40
  6c:	c3                   	ret    

0000006d <pipe>:
SYSCALL(pipe)
  6d:	b8 04 00 00 00       	mov    $0x4,%eax
  72:	cd 40                	int    $0x40
  74:	c3                   	ret    

00000075 <read>:
SYSCALL(read)
  75:	b8 05 00 00 00       	mov    $0x5,%eax
  7a:	cd 40                	int    $0x40
  7c:	c3                   	ret    

0000007d <write>:
SYSCALL(write)
  7d:	b8 10 00 00 00       	mov    $0x10,%eax
  82:	cd 40                	int    $0x40
  84:	c3                   	ret    

00000085 <close>:
SYSCALL(close)
  85:	b8 15 00 00 00       	mov    $0x15,%eax
  8a:	cd 40                	int    $0x40
  8c:	c3                   	ret    

0000008d <kill>:
SYSCALL(kill)
  8d:	b8 06 00 00 00       	mov    $0x6,%eax
  92:	cd 40                	int    $0x40
  94:	c3                   	ret    

00000095 <exec>:
SYSCALL(exec)
  95:	b8 07 00 00 00       	mov    $0x7,%eax
  9a:	cd 40                	int    $0x40
  9c:	c3                   	ret    

0000009d <open>:
SYSCALL(open)
  9d:	b8 0f 00 00 00       	mov    $0xf,%eax
  a2:	cd 40                	int    $0x40
  a4:	c3                   	ret    

000000a5 <mknod>:
SYSCALL(mknod)
  a5:	b8 11 00 00 00       	mov    $0x11,%eax
  aa:	cd 40                	int    $0x40
  ac:	c3                   	ret    

000000ad <unlink>:
SYSCALL(unlink)
  ad:	b8 12 00 00 00       	mov    $0x12,%eax
  b2:	cd 40                	int    $0x40
  b4:	c3                   	ret    

000000b5 <fstat>:
SYSCALL(fstat)
  b5:	b8 08 00 00 00       	mov    $0x8,%eax
  ba:	cd 40                	int    $0x40
  bc:	c3                   	ret    

000000bd <link>:
SYSCALL(link)
  bd:	b8 13 00 00 00       	mov    $0x13,%eax
  c2:	cd 40                	int    $0x40
  c4:	c3                   	ret    

000000c5 <mkdir>:
SYSCALL(mkdir)
  c5:	b8 14 00 00 00       	mov    $0x14,%eax
  ca:	cd 40                	int    $0x40
  cc:	c3                   	ret    

000000cd <chdir>:
SYSCALL(chdir)
  cd:	b8 09 00 00 00       	mov    $0x9,%eax
  d2:	cd 40                	int    $0x40
  d4:	c3                   	ret    

000000d5 <dup>:
SYSCALL(dup)
  d5:	b8 0a 00 00 00       	mov    $0xa,%eax
  da:	cd 40                	int    $0x40
  dc:	c3                   	ret    

000000dd <getpid>:
SYSCALL(getpid)
  dd:	b8 0b 00 00 00       	mov    $0xb,%eax
  e2:	cd 40                	int    $0x40
  e4:	c3                   	ret    

000000e5 <sbrk>:
SYSCALL(sbrk)
  e5:	b8 0c 00 00 00       	mov    $0xc,%eax
  ea:	cd 40                	int    $0x40
  ec:	c3                   	ret    

000000ed <sleep>:
SYSCALL(sleep)
  ed:	b8 0d 00 00 00       	mov    $0xd,%eax
  f2:	cd 40                	int    $0x40
  f4:	c3                   	ret    

000000f5 <uptime>:
SYSCALL(uptime)
  f5:	b8 0e 00 00 00       	mov    $0xe,%eax
  fa:	cd 40                	int    $0x40
  fc:	c3                   	ret    

000000fd <date>:
SYSCALL(date)
  fd:	b8 16 00 00 00       	mov    $0x16,%eax
 102:	cd 40                	int    $0x40
 104:	c3                   	ret    

00000105 <dup2>:
SYSCALL(dup2)
 105:	b8 17 00 00 00       	mov    $0x17,%eax
 10a:	cd 40                	int    $0x40
 10c:	c3                   	ret    

0000010d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
 110:	83 ec 1c             	sub    $0x1c,%esp
 113:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 116:	6a 01                	push   $0x1
 118:	8d 55 f4             	lea    -0xc(%ebp),%edx
 11b:	52                   	push   %edx
 11c:	50                   	push   %eax
 11d:	e8 5b ff ff ff       	call   7d <write>
}
 122:	83 c4 10             	add    $0x10,%esp
 125:	c9                   	leave  
 126:	c3                   	ret    

00000127 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	57                   	push   %edi
 12b:	56                   	push   %esi
 12c:	53                   	push   %ebx
 12d:	83 ec 2c             	sub    $0x2c,%esp
 130:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 133:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 135:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 139:	74 04                	je     13f <printint+0x18>
 13b:	85 d2                	test   %edx,%edx
 13d:	78 3a                	js     179 <printint+0x52>
  neg = 0;
 13f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 146:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 14b:	89 f0                	mov    %esi,%eax
 14d:	ba 00 00 00 00       	mov    $0x0,%edx
 152:	f7 f1                	div    %ecx
 154:	89 df                	mov    %ebx,%edi
 156:	43                   	inc    %ebx
 157:	8a 92 08 03 00 00    	mov    0x308(%edx),%dl
 15d:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 161:	89 f2                	mov    %esi,%edx
 163:	89 c6                	mov    %eax,%esi
 165:	39 d1                	cmp    %edx,%ecx
 167:	76 e2                	jbe    14b <printint+0x24>
  if(neg)
 169:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 16d:	74 22                	je     191 <printint+0x6a>
    buf[i++] = '-';
 16f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 174:	8d 5f 02             	lea    0x2(%edi),%ebx
 177:	eb 18                	jmp    191 <printint+0x6a>
    x = -xx;
 179:	f7 de                	neg    %esi
    neg = 1;
 17b:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 182:	eb c2                	jmp    146 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 184:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 189:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 18c:	e8 7c ff ff ff       	call   10d <putc>
  while(--i >= 0)
 191:	4b                   	dec    %ebx
 192:	79 f0                	jns    184 <printint+0x5d>
}
 194:	83 c4 2c             	add    $0x2c,%esp
 197:	5b                   	pop    %ebx
 198:	5e                   	pop    %esi
 199:	5f                   	pop    %edi
 19a:	5d                   	pop    %ebp
 19b:	c3                   	ret    

0000019c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 19c:	f3 0f 1e fb          	endbr32 
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
 1a5:	53                   	push   %ebx
 1a6:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 1a9:	8d 45 10             	lea    0x10(%ebp),%eax
 1ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 1af:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 1b4:	bb 00 00 00 00       	mov    $0x0,%ebx
 1b9:	eb 12                	jmp    1cd <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 1bb:	89 fa                	mov    %edi,%edx
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	e8 48 ff ff ff       	call   10d <putc>
 1c5:	eb 05                	jmp    1cc <printf+0x30>
      }
    } else if(state == '%'){
 1c7:	83 fe 25             	cmp    $0x25,%esi
 1ca:	74 22                	je     1ee <printf+0x52>
  for(i = 0; fmt[i]; i++){
 1cc:	43                   	inc    %ebx
 1cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d0:	8a 04 18             	mov    (%eax,%ebx,1),%al
 1d3:	84 c0                	test   %al,%al
 1d5:	0f 84 13 01 00 00    	je     2ee <printf+0x152>
    c = fmt[i] & 0xff;
 1db:	0f be f8             	movsbl %al,%edi
 1de:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 1e1:	85 f6                	test   %esi,%esi
 1e3:	75 e2                	jne    1c7 <printf+0x2b>
      if(c == '%'){
 1e5:	83 f8 25             	cmp    $0x25,%eax
 1e8:	75 d1                	jne    1bb <printf+0x1f>
        state = '%';
 1ea:	89 c6                	mov    %eax,%esi
 1ec:	eb de                	jmp    1cc <printf+0x30>
      if(c == 'd'){
 1ee:	83 f8 64             	cmp    $0x64,%eax
 1f1:	74 43                	je     236 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 1f3:	83 f8 78             	cmp    $0x78,%eax
 1f6:	74 68                	je     260 <printf+0xc4>
 1f8:	83 f8 70             	cmp    $0x70,%eax
 1fb:	74 63                	je     260 <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 1fd:	83 f8 73             	cmp    $0x73,%eax
 200:	0f 84 84 00 00 00    	je     28a <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 206:	83 f8 63             	cmp    $0x63,%eax
 209:	0f 84 ad 00 00 00    	je     2bc <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 20f:	83 f8 25             	cmp    $0x25,%eax
 212:	0f 84 c2 00 00 00    	je     2da <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 218:	ba 25 00 00 00       	mov    $0x25,%edx
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
 220:	e8 e8 fe ff ff       	call   10d <putc>
        putc(fd, c);
 225:	89 fa                	mov    %edi,%edx
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	e8 de fe ff ff       	call   10d <putc>
      }
      state = 0;
 22f:	be 00 00 00 00       	mov    $0x0,%esi
 234:	eb 96                	jmp    1cc <printf+0x30>
        printint(fd, *ap, 10, 1);
 236:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 239:	8b 17                	mov    (%edi),%edx
 23b:	83 ec 0c             	sub    $0xc,%esp
 23e:	6a 01                	push   $0x1
 240:	b9 0a 00 00 00       	mov    $0xa,%ecx
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	e8 da fe ff ff       	call   127 <printint>
        ap++;
 24d:	83 c7 04             	add    $0x4,%edi
 250:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 253:	83 c4 10             	add    $0x10,%esp
      state = 0;
 256:	be 00 00 00 00       	mov    $0x0,%esi
 25b:	e9 6c ff ff ff       	jmp    1cc <printf+0x30>
        printint(fd, *ap, 16, 0);
 260:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 263:	8b 17                	mov    (%edi),%edx
 265:	83 ec 0c             	sub    $0xc,%esp
 268:	6a 00                	push   $0x0
 26a:	b9 10 00 00 00       	mov    $0x10,%ecx
 26f:	8b 45 08             	mov    0x8(%ebp),%eax
 272:	e8 b0 fe ff ff       	call   127 <printint>
        ap++;
 277:	83 c7 04             	add    $0x4,%edi
 27a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 27d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 280:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 285:	e9 42 ff ff ff       	jmp    1cc <printf+0x30>
        s = (char*)*ap;
 28a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 28d:	8b 30                	mov    (%eax),%esi
        ap++;
 28f:	83 c0 04             	add    $0x4,%eax
 292:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 295:	85 f6                	test   %esi,%esi
 297:	75 13                	jne    2ac <printf+0x110>
          s = "(null)";
 299:	be 01 03 00 00       	mov    $0x301,%esi
 29e:	eb 0c                	jmp    2ac <printf+0x110>
          putc(fd, *s);
 2a0:	0f be d2             	movsbl %dl,%edx
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	e8 62 fe ff ff       	call   10d <putc>
          s++;
 2ab:	46                   	inc    %esi
        while(*s != 0){
 2ac:	8a 16                	mov    (%esi),%dl
 2ae:	84 d2                	test   %dl,%dl
 2b0:	75 ee                	jne    2a0 <printf+0x104>
      state = 0;
 2b2:	be 00 00 00 00       	mov    $0x0,%esi
 2b7:	e9 10 ff ff ff       	jmp    1cc <printf+0x30>
        putc(fd, *ap);
 2bc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2bf:	0f be 17             	movsbl (%edi),%edx
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
 2c5:	e8 43 fe ff ff       	call   10d <putc>
        ap++;
 2ca:	83 c7 04             	add    $0x4,%edi
 2cd:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 2d0:	be 00 00 00 00       	mov    $0x0,%esi
 2d5:	e9 f2 fe ff ff       	jmp    1cc <printf+0x30>
        putc(fd, c);
 2da:	89 fa                	mov    %edi,%edx
 2dc:	8b 45 08             	mov    0x8(%ebp),%eax
 2df:	e8 29 fe ff ff       	call   10d <putc>
      state = 0;
 2e4:	be 00 00 00 00       	mov    $0x0,%esi
 2e9:	e9 de fe ff ff       	jmp    1cc <printf+0x30>
    }
  }
}
 2ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2f1:	5b                   	pop    %ebx
 2f2:	5e                   	pop    %esi
 2f3:	5f                   	pop    %edi
 2f4:	5d                   	pop    %ebp
 2f5:	c3                   	ret    
