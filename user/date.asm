
date:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "user.h"
#include "date.h"


int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 30             	sub    $0x30,%esp
    struct rtcdate r;
    if (date(&r)) {
  15:	8d 45 e0             	lea    -0x20(%ebp),%eax
  18:	50                   	push   %eax
  19:	e8 e9 00 00 00       	call   107 <date>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	74 14                	je     39 <main+0x39>
        printf(2, "date failed \n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	68 00 03 00 00       	push   $0x300
  2d:	6a 02                	push   $0x2
  2f:	e8 72 01 00 00       	call   1a6 <printf>
        exit();
  34:	e8 2e 00 00 00       	call   67 <exit>
    }


    printf(1, "%d-%d-%d %d:%d:%d \n", r.year, r.month, r.day, r.hour, r.minute, r.second);
  39:	ff 75 e0             	pushl  -0x20(%ebp)
  3c:	ff 75 e4             	pushl  -0x1c(%ebp)
  3f:	ff 75 e8             	pushl  -0x18(%ebp)
  42:	ff 75 ec             	pushl  -0x14(%ebp)
  45:	ff 75 f0             	pushl  -0x10(%ebp)
  48:	ff 75 f4             	pushl  -0xc(%ebp)
  4b:	68 0e 03 00 00       	push   $0x30e
  50:	6a 01                	push   $0x1
  52:	e8 4f 01 00 00       	call   1a6 <printf>


    exit();
  57:	83 c4 20             	add    $0x20,%esp
  5a:	e8 08 00 00 00       	call   67 <exit>

0000005f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  5f:	b8 01 00 00 00       	mov    $0x1,%eax
  64:	cd 40                	int    $0x40
  66:	c3                   	ret    

00000067 <exit>:
SYSCALL(exit)
  67:	b8 02 00 00 00       	mov    $0x2,%eax
  6c:	cd 40                	int    $0x40
  6e:	c3                   	ret    

0000006f <wait>:
SYSCALL(wait)
  6f:	b8 03 00 00 00       	mov    $0x3,%eax
  74:	cd 40                	int    $0x40
  76:	c3                   	ret    

00000077 <pipe>:
SYSCALL(pipe)
  77:	b8 04 00 00 00       	mov    $0x4,%eax
  7c:	cd 40                	int    $0x40
  7e:	c3                   	ret    

0000007f <read>:
SYSCALL(read)
  7f:	b8 05 00 00 00       	mov    $0x5,%eax
  84:	cd 40                	int    $0x40
  86:	c3                   	ret    

00000087 <write>:
SYSCALL(write)
  87:	b8 10 00 00 00       	mov    $0x10,%eax
  8c:	cd 40                	int    $0x40
  8e:	c3                   	ret    

0000008f <close>:
SYSCALL(close)
  8f:	b8 15 00 00 00       	mov    $0x15,%eax
  94:	cd 40                	int    $0x40
  96:	c3                   	ret    

00000097 <kill>:
SYSCALL(kill)
  97:	b8 06 00 00 00       	mov    $0x6,%eax
  9c:	cd 40                	int    $0x40
  9e:	c3                   	ret    

0000009f <exec>:
SYSCALL(exec)
  9f:	b8 07 00 00 00       	mov    $0x7,%eax
  a4:	cd 40                	int    $0x40
  a6:	c3                   	ret    

000000a7 <open>:
SYSCALL(open)
  a7:	b8 0f 00 00 00       	mov    $0xf,%eax
  ac:	cd 40                	int    $0x40
  ae:	c3                   	ret    

000000af <mknod>:
SYSCALL(mknod)
  af:	b8 11 00 00 00       	mov    $0x11,%eax
  b4:	cd 40                	int    $0x40
  b6:	c3                   	ret    

000000b7 <unlink>:
SYSCALL(unlink)
  b7:	b8 12 00 00 00       	mov    $0x12,%eax
  bc:	cd 40                	int    $0x40
  be:	c3                   	ret    

000000bf <fstat>:
SYSCALL(fstat)
  bf:	b8 08 00 00 00       	mov    $0x8,%eax
  c4:	cd 40                	int    $0x40
  c6:	c3                   	ret    

000000c7 <link>:
SYSCALL(link)
  c7:	b8 13 00 00 00       	mov    $0x13,%eax
  cc:	cd 40                	int    $0x40
  ce:	c3                   	ret    

000000cf <mkdir>:
SYSCALL(mkdir)
  cf:	b8 14 00 00 00       	mov    $0x14,%eax
  d4:	cd 40                	int    $0x40
  d6:	c3                   	ret    

000000d7 <chdir>:
SYSCALL(chdir)
  d7:	b8 09 00 00 00       	mov    $0x9,%eax
  dc:	cd 40                	int    $0x40
  de:	c3                   	ret    

000000df <dup>:
SYSCALL(dup)
  df:	b8 0a 00 00 00       	mov    $0xa,%eax
  e4:	cd 40                	int    $0x40
  e6:	c3                   	ret    

000000e7 <getpid>:
SYSCALL(getpid)
  e7:	b8 0b 00 00 00       	mov    $0xb,%eax
  ec:	cd 40                	int    $0x40
  ee:	c3                   	ret    

000000ef <sbrk>:
SYSCALL(sbrk)
  ef:	b8 0c 00 00 00       	mov    $0xc,%eax
  f4:	cd 40                	int    $0x40
  f6:	c3                   	ret    

000000f7 <sleep>:
SYSCALL(sleep)
  f7:	b8 0d 00 00 00       	mov    $0xd,%eax
  fc:	cd 40                	int    $0x40
  fe:	c3                   	ret    

000000ff <uptime>:
SYSCALL(uptime)
  ff:	b8 0e 00 00 00       	mov    $0xe,%eax
 104:	cd 40                	int    $0x40
 106:	c3                   	ret    

00000107 <date>:
SYSCALL(date)
 107:	b8 16 00 00 00       	mov    $0x16,%eax
 10c:	cd 40                	int    $0x40
 10e:	c3                   	ret    

0000010f <dup2>:
SYSCALL(dup2)
 10f:	b8 17 00 00 00       	mov    $0x17,%eax
 114:	cd 40                	int    $0x40
 116:	c3                   	ret    

00000117 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 117:	55                   	push   %ebp
 118:	89 e5                	mov    %esp,%ebp
 11a:	83 ec 1c             	sub    $0x1c,%esp
 11d:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 120:	6a 01                	push   $0x1
 122:	8d 55 f4             	lea    -0xc(%ebp),%edx
 125:	52                   	push   %edx
 126:	50                   	push   %eax
 127:	e8 5b ff ff ff       	call   87 <write>
}
 12c:	83 c4 10             	add    $0x10,%esp
 12f:	c9                   	leave  
 130:	c3                   	ret    

00000131 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
 134:	57                   	push   %edi
 135:	56                   	push   %esi
 136:	53                   	push   %ebx
 137:	83 ec 2c             	sub    $0x2c,%esp
 13a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 13d:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 13f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 143:	74 04                	je     149 <printint+0x18>
 145:	85 d2                	test   %edx,%edx
 147:	78 3a                	js     183 <printint+0x52>
  neg = 0;
 149:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 150:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 155:	89 f0                	mov    %esi,%eax
 157:	ba 00 00 00 00       	mov    $0x0,%edx
 15c:	f7 f1                	div    %ecx
 15e:	89 df                	mov    %ebx,%edi
 160:	43                   	inc    %ebx
 161:	8a 92 2c 03 00 00    	mov    0x32c(%edx),%dl
 167:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 16b:	89 f2                	mov    %esi,%edx
 16d:	89 c6                	mov    %eax,%esi
 16f:	39 d1                	cmp    %edx,%ecx
 171:	76 e2                	jbe    155 <printint+0x24>
  if(neg)
 173:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 177:	74 22                	je     19b <printint+0x6a>
    buf[i++] = '-';
 179:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 17e:	8d 5f 02             	lea    0x2(%edi),%ebx
 181:	eb 18                	jmp    19b <printint+0x6a>
    x = -xx;
 183:	f7 de                	neg    %esi
    neg = 1;
 185:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 18c:	eb c2                	jmp    150 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 18e:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 193:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 196:	e8 7c ff ff ff       	call   117 <putc>
  while(--i >= 0)
 19b:	4b                   	dec    %ebx
 19c:	79 f0                	jns    18e <printint+0x5d>
}
 19e:	83 c4 2c             	add    $0x2c,%esp
 1a1:	5b                   	pop    %ebx
 1a2:	5e                   	pop    %esi
 1a3:	5f                   	pop    %edi
 1a4:	5d                   	pop    %ebp
 1a5:	c3                   	ret    

000001a6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 1a6:	f3 0f 1e fb          	endbr32 
 1aa:	55                   	push   %ebp
 1ab:	89 e5                	mov    %esp,%ebp
 1ad:	57                   	push   %edi
 1ae:	56                   	push   %esi
 1af:	53                   	push   %ebx
 1b0:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 1b3:	8d 45 10             	lea    0x10(%ebp),%eax
 1b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 1b9:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 1be:	bb 00 00 00 00       	mov    $0x0,%ebx
 1c3:	eb 12                	jmp    1d7 <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 1c5:	89 fa                	mov    %edi,%edx
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	e8 48 ff ff ff       	call   117 <putc>
 1cf:	eb 05                	jmp    1d6 <printf+0x30>
      }
    } else if(state == '%'){
 1d1:	83 fe 25             	cmp    $0x25,%esi
 1d4:	74 22                	je     1f8 <printf+0x52>
  for(i = 0; fmt[i]; i++){
 1d6:	43                   	inc    %ebx
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	8a 04 18             	mov    (%eax,%ebx,1),%al
 1dd:	84 c0                	test   %al,%al
 1df:	0f 84 13 01 00 00    	je     2f8 <printf+0x152>
    c = fmt[i] & 0xff;
 1e5:	0f be f8             	movsbl %al,%edi
 1e8:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 1eb:	85 f6                	test   %esi,%esi
 1ed:	75 e2                	jne    1d1 <printf+0x2b>
      if(c == '%'){
 1ef:	83 f8 25             	cmp    $0x25,%eax
 1f2:	75 d1                	jne    1c5 <printf+0x1f>
        state = '%';
 1f4:	89 c6                	mov    %eax,%esi
 1f6:	eb de                	jmp    1d6 <printf+0x30>
      if(c == 'd'){
 1f8:	83 f8 64             	cmp    $0x64,%eax
 1fb:	74 43                	je     240 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 1fd:	83 f8 78             	cmp    $0x78,%eax
 200:	74 68                	je     26a <printf+0xc4>
 202:	83 f8 70             	cmp    $0x70,%eax
 205:	74 63                	je     26a <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 207:	83 f8 73             	cmp    $0x73,%eax
 20a:	0f 84 84 00 00 00    	je     294 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 210:	83 f8 63             	cmp    $0x63,%eax
 213:	0f 84 ad 00 00 00    	je     2c6 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 219:	83 f8 25             	cmp    $0x25,%eax
 21c:	0f 84 c2 00 00 00    	je     2e4 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 222:	ba 25 00 00 00       	mov    $0x25,%edx
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	e8 e8 fe ff ff       	call   117 <putc>
        putc(fd, c);
 22f:	89 fa                	mov    %edi,%edx
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	e8 de fe ff ff       	call   117 <putc>
      }
      state = 0;
 239:	be 00 00 00 00       	mov    $0x0,%esi
 23e:	eb 96                	jmp    1d6 <printf+0x30>
        printint(fd, *ap, 10, 1);
 240:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 243:	8b 17                	mov    (%edi),%edx
 245:	83 ec 0c             	sub    $0xc,%esp
 248:	6a 01                	push   $0x1
 24a:	b9 0a 00 00 00       	mov    $0xa,%ecx
 24f:	8b 45 08             	mov    0x8(%ebp),%eax
 252:	e8 da fe ff ff       	call   131 <printint>
        ap++;
 257:	83 c7 04             	add    $0x4,%edi
 25a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 25d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 260:	be 00 00 00 00       	mov    $0x0,%esi
 265:	e9 6c ff ff ff       	jmp    1d6 <printf+0x30>
        printint(fd, *ap, 16, 0);
 26a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 26d:	8b 17                	mov    (%edi),%edx
 26f:	83 ec 0c             	sub    $0xc,%esp
 272:	6a 00                	push   $0x0
 274:	b9 10 00 00 00       	mov    $0x10,%ecx
 279:	8b 45 08             	mov    0x8(%ebp),%eax
 27c:	e8 b0 fe ff ff       	call   131 <printint>
        ap++;
 281:	83 c7 04             	add    $0x4,%edi
 284:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 287:	83 c4 10             	add    $0x10,%esp
      state = 0;
 28a:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 28f:	e9 42 ff ff ff       	jmp    1d6 <printf+0x30>
        s = (char*)*ap;
 294:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 297:	8b 30                	mov    (%eax),%esi
        ap++;
 299:	83 c0 04             	add    $0x4,%eax
 29c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 29f:	85 f6                	test   %esi,%esi
 2a1:	75 13                	jne    2b6 <printf+0x110>
          s = "(null)";
 2a3:	be 22 03 00 00       	mov    $0x322,%esi
 2a8:	eb 0c                	jmp    2b6 <printf+0x110>
          putc(fd, *s);
 2aa:	0f be d2             	movsbl %dl,%edx
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	e8 62 fe ff ff       	call   117 <putc>
          s++;
 2b5:	46                   	inc    %esi
        while(*s != 0){
 2b6:	8a 16                	mov    (%esi),%dl
 2b8:	84 d2                	test   %dl,%dl
 2ba:	75 ee                	jne    2aa <printf+0x104>
      state = 0;
 2bc:	be 00 00 00 00       	mov    $0x0,%esi
 2c1:	e9 10 ff ff ff       	jmp    1d6 <printf+0x30>
        putc(fd, *ap);
 2c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2c9:	0f be 17             	movsbl (%edi),%edx
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	e8 43 fe ff ff       	call   117 <putc>
        ap++;
 2d4:	83 c7 04             	add    $0x4,%edi
 2d7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 2da:	be 00 00 00 00       	mov    $0x0,%esi
 2df:	e9 f2 fe ff ff       	jmp    1d6 <printf+0x30>
        putc(fd, c);
 2e4:	89 fa                	mov    %edi,%edx
 2e6:	8b 45 08             	mov    0x8(%ebp),%eax
 2e9:	e8 29 fe ff ff       	call   117 <putc>
      state = 0;
 2ee:	be 00 00 00 00       	mov    $0x0,%esi
 2f3:	e9 de fe ff ff       	jmp    1d6 <printf+0x30>
    }
  }
}
 2f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fb:	5b                   	pop    %ebx
 2fc:	5e                   	pop    %esi
 2fd:	5f                   	pop    %edi
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    
