
date:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "date.h"


int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 30             	sub    $0x30,%esp
    struct rtcdate r;
    if (date(&r)) {
  11:	8d 45 e0             	lea    -0x20(%ebp),%eax
  14:	50                   	push   %eax
  15:	e8 f2 00 00 00       	call   10c <date>
  1a:	83 c4 10             	add    $0x10,%esp
  1d:	85 c0                	test   %eax,%eax
  1f:	74 1b                	je     3c <main+0x3c>
        printf(2, "date failed \n");
  21:	83 ec 08             	sub    $0x8,%esp
  24:	68 10 03 00 00       	push   $0x310
  29:	6a 02                	push   $0x2
  2b:	e8 7f 01 00 00       	call   1af <printf>
        exit(0);
  30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  37:	e8 30 00 00 00       	call   6c <exit>
    }


    printf(1, "%d-%d-%d %d:%d:%d \n", r.year, r.month, r.day, r.hour, r.minute, r.second);
  3c:	ff 75 e0             	push   -0x20(%ebp)
  3f:	ff 75 e4             	push   -0x1c(%ebp)
  42:	ff 75 e8             	push   -0x18(%ebp)
  45:	ff 75 ec             	push   -0x14(%ebp)
  48:	ff 75 f0             	push   -0x10(%ebp)
  4b:	ff 75 f4             	push   -0xc(%ebp)
  4e:	68 1e 03 00 00       	push   $0x31e
  53:	6a 01                	push   $0x1
  55:	e8 55 01 00 00       	call   1af <printf>


    exit(0);
  5a:	83 c4 14             	add    $0x14,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 08 00 00 00       	call   6c <exit>

00000064 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  64:	b8 01 00 00 00       	mov    $0x1,%eax
  69:	cd 40                	int    $0x40
  6b:	c3                   	ret    

0000006c <exit>:
SYSCALL(exit)
  6c:	b8 02 00 00 00       	mov    $0x2,%eax
  71:	cd 40                	int    $0x40
  73:	c3                   	ret    

00000074 <wait>:
SYSCALL(wait)
  74:	b8 03 00 00 00       	mov    $0x3,%eax
  79:	cd 40                	int    $0x40
  7b:	c3                   	ret    

0000007c <pipe>:
SYSCALL(pipe)
  7c:	b8 04 00 00 00       	mov    $0x4,%eax
  81:	cd 40                	int    $0x40
  83:	c3                   	ret    

00000084 <read>:
SYSCALL(read)
  84:	b8 05 00 00 00       	mov    $0x5,%eax
  89:	cd 40                	int    $0x40
  8b:	c3                   	ret    

0000008c <write>:
SYSCALL(write)
  8c:	b8 10 00 00 00       	mov    $0x10,%eax
  91:	cd 40                	int    $0x40
  93:	c3                   	ret    

00000094 <close>:
SYSCALL(close)
  94:	b8 15 00 00 00       	mov    $0x15,%eax
  99:	cd 40                	int    $0x40
  9b:	c3                   	ret    

0000009c <kill>:
SYSCALL(kill)
  9c:	b8 06 00 00 00       	mov    $0x6,%eax
  a1:	cd 40                	int    $0x40
  a3:	c3                   	ret    

000000a4 <exec>:
SYSCALL(exec)
  a4:	b8 07 00 00 00       	mov    $0x7,%eax
  a9:	cd 40                	int    $0x40
  ab:	c3                   	ret    

000000ac <open>:
SYSCALL(open)
  ac:	b8 0f 00 00 00       	mov    $0xf,%eax
  b1:	cd 40                	int    $0x40
  b3:	c3                   	ret    

000000b4 <mknod>:
SYSCALL(mknod)
  b4:	b8 11 00 00 00       	mov    $0x11,%eax
  b9:	cd 40                	int    $0x40
  bb:	c3                   	ret    

000000bc <unlink>:
SYSCALL(unlink)
  bc:	b8 12 00 00 00       	mov    $0x12,%eax
  c1:	cd 40                	int    $0x40
  c3:	c3                   	ret    

000000c4 <fstat>:
SYSCALL(fstat)
  c4:	b8 08 00 00 00       	mov    $0x8,%eax
  c9:	cd 40                	int    $0x40
  cb:	c3                   	ret    

000000cc <link>:
SYSCALL(link)
  cc:	b8 13 00 00 00       	mov    $0x13,%eax
  d1:	cd 40                	int    $0x40
  d3:	c3                   	ret    

000000d4 <mkdir>:
SYSCALL(mkdir)
  d4:	b8 14 00 00 00       	mov    $0x14,%eax
  d9:	cd 40                	int    $0x40
  db:	c3                   	ret    

000000dc <chdir>:
SYSCALL(chdir)
  dc:	b8 09 00 00 00       	mov    $0x9,%eax
  e1:	cd 40                	int    $0x40
  e3:	c3                   	ret    

000000e4 <dup>:
SYSCALL(dup)
  e4:	b8 0a 00 00 00       	mov    $0xa,%eax
  e9:	cd 40                	int    $0x40
  eb:	c3                   	ret    

000000ec <getpid>:
SYSCALL(getpid)
  ec:	b8 0b 00 00 00       	mov    $0xb,%eax
  f1:	cd 40                	int    $0x40
  f3:	c3                   	ret    

000000f4 <sbrk>:
SYSCALL(sbrk)
  f4:	b8 0c 00 00 00       	mov    $0xc,%eax
  f9:	cd 40                	int    $0x40
  fb:	c3                   	ret    

000000fc <sleep>:
SYSCALL(sleep)
  fc:	b8 0d 00 00 00       	mov    $0xd,%eax
 101:	cd 40                	int    $0x40
 103:	c3                   	ret    

00000104 <uptime>:
SYSCALL(uptime)
 104:	b8 0e 00 00 00       	mov    $0xe,%eax
 109:	cd 40                	int    $0x40
 10b:	c3                   	ret    

0000010c <date>:
SYSCALL(date)
 10c:	b8 16 00 00 00       	mov    $0x16,%eax
 111:	cd 40                	int    $0x40
 113:	c3                   	ret    

00000114 <dup2>:
SYSCALL(dup2)
 114:	b8 17 00 00 00       	mov    $0x17,%eax
 119:	cd 40                	int    $0x40
 11b:	c3                   	ret    

0000011c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 11c:	55                   	push   %ebp
 11d:	89 e5                	mov    %esp,%ebp
 11f:	83 ec 1c             	sub    $0x1c,%esp
 122:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 125:	6a 01                	push   $0x1
 127:	8d 55 f4             	lea    -0xc(%ebp),%edx
 12a:	52                   	push   %edx
 12b:	50                   	push   %eax
 12c:	e8 5b ff ff ff       	call   8c <write>
}
 131:	83 c4 10             	add    $0x10,%esp
 134:	c9                   	leave  
 135:	c3                   	ret    

00000136 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
 139:	57                   	push   %edi
 13a:	56                   	push   %esi
 13b:	53                   	push   %ebx
 13c:	83 ec 2c             	sub    $0x2c,%esp
 13f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 142:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 144:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 148:	74 04                	je     14e <printint+0x18>
 14a:	85 d2                	test   %edx,%edx
 14c:	78 3c                	js     18a <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 14e:	89 d1                	mov    %edx,%ecx
  neg = 0;
 150:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 157:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 15c:	89 c8                	mov    %ecx,%eax
 15e:	ba 00 00 00 00       	mov    $0x0,%edx
 163:	f7 f6                	div    %esi
 165:	89 df                	mov    %ebx,%edi
 167:	43                   	inc    %ebx
 168:	8a 92 94 03 00 00    	mov    0x394(%edx),%dl
 16e:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 172:	89 ca                	mov    %ecx,%edx
 174:	89 c1                	mov    %eax,%ecx
 176:	39 d6                	cmp    %edx,%esi
 178:	76 e2                	jbe    15c <printint+0x26>
  if(neg)
 17a:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 17e:	74 24                	je     1a4 <printint+0x6e>
    buf[i++] = '-';
 180:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 185:	8d 5f 02             	lea    0x2(%edi),%ebx
 188:	eb 1a                	jmp    1a4 <printint+0x6e>
    x = -xx;
 18a:	89 d1                	mov    %edx,%ecx
 18c:	f7 d9                	neg    %ecx
    neg = 1;
 18e:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 195:	eb c0                	jmp    157 <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 197:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 19c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 19f:	e8 78 ff ff ff       	call   11c <putc>
  while(--i >= 0)
 1a4:	4b                   	dec    %ebx
 1a5:	79 f0                	jns    197 <printint+0x61>
}
 1a7:	83 c4 2c             	add    $0x2c,%esp
 1aa:	5b                   	pop    %ebx
 1ab:	5e                   	pop    %esi
 1ac:	5f                   	pop    %edi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    

000001af <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
 1b2:	57                   	push   %edi
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 1b8:	8d 45 10             	lea    0x10(%ebp),%eax
 1bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 1be:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 1c3:	bb 00 00 00 00       	mov    $0x0,%ebx
 1c8:	eb 12                	jmp    1dc <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 1ca:	89 fa                	mov    %edi,%edx
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	e8 48 ff ff ff       	call   11c <putc>
 1d4:	eb 05                	jmp    1db <printf+0x2c>
      }
    } else if(state == '%'){
 1d6:	83 fe 25             	cmp    $0x25,%esi
 1d9:	74 22                	je     1fd <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 1db:	43                   	inc    %ebx
 1dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1df:	8a 04 18             	mov    (%eax,%ebx,1),%al
 1e2:	84 c0                	test   %al,%al
 1e4:	0f 84 1d 01 00 00    	je     307 <printf+0x158>
    c = fmt[i] & 0xff;
 1ea:	0f be f8             	movsbl %al,%edi
 1ed:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 1f0:	85 f6                	test   %esi,%esi
 1f2:	75 e2                	jne    1d6 <printf+0x27>
      if(c == '%'){
 1f4:	83 f8 25             	cmp    $0x25,%eax
 1f7:	75 d1                	jne    1ca <printf+0x1b>
        state = '%';
 1f9:	89 c6                	mov    %eax,%esi
 1fb:	eb de                	jmp    1db <printf+0x2c>
      if(c == 'd'){
 1fd:	83 f8 25             	cmp    $0x25,%eax
 200:	0f 84 cc 00 00 00    	je     2d2 <printf+0x123>
 206:	0f 8c da 00 00 00    	jl     2e6 <printf+0x137>
 20c:	83 f8 78             	cmp    $0x78,%eax
 20f:	0f 8f d1 00 00 00    	jg     2e6 <printf+0x137>
 215:	83 f8 63             	cmp    $0x63,%eax
 218:	0f 8c c8 00 00 00    	jl     2e6 <printf+0x137>
 21e:	83 e8 63             	sub    $0x63,%eax
 221:	83 f8 15             	cmp    $0x15,%eax
 224:	0f 87 bc 00 00 00    	ja     2e6 <printf+0x137>
 22a:	ff 24 85 3c 03 00 00 	jmp    *0x33c(,%eax,4)
        printint(fd, *ap, 10, 1);
 231:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 234:	8b 17                	mov    (%edi),%edx
 236:	83 ec 0c             	sub    $0xc,%esp
 239:	6a 01                	push   $0x1
 23b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	e8 ee fe ff ff       	call   136 <printint>
        ap++;
 248:	83 c7 04             	add    $0x4,%edi
 24b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 24e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 251:	be 00 00 00 00       	mov    $0x0,%esi
 256:	eb 83                	jmp    1db <printf+0x2c>
        printint(fd, *ap, 16, 0);
 258:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 25b:	8b 17                	mov    (%edi),%edx
 25d:	83 ec 0c             	sub    $0xc,%esp
 260:	6a 00                	push   $0x0
 262:	b9 10 00 00 00       	mov    $0x10,%ecx
 267:	8b 45 08             	mov    0x8(%ebp),%eax
 26a:	e8 c7 fe ff ff       	call   136 <printint>
        ap++;
 26f:	83 c7 04             	add    $0x4,%edi
 272:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 275:	83 c4 10             	add    $0x10,%esp
      state = 0;
 278:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 27d:	e9 59 ff ff ff       	jmp    1db <printf+0x2c>
        s = (char*)*ap;
 282:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 285:	8b 30                	mov    (%eax),%esi
        ap++;
 287:	83 c0 04             	add    $0x4,%eax
 28a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 28d:	85 f6                	test   %esi,%esi
 28f:	75 13                	jne    2a4 <printf+0xf5>
          s = "(null)";
 291:	be 32 03 00 00       	mov    $0x332,%esi
 296:	eb 0c                	jmp    2a4 <printf+0xf5>
          putc(fd, *s);
 298:	0f be d2             	movsbl %dl,%edx
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	e8 79 fe ff ff       	call   11c <putc>
          s++;
 2a3:	46                   	inc    %esi
        while(*s != 0){
 2a4:	8a 16                	mov    (%esi),%dl
 2a6:	84 d2                	test   %dl,%dl
 2a8:	75 ee                	jne    298 <printf+0xe9>
      state = 0;
 2aa:	be 00 00 00 00       	mov    $0x0,%esi
 2af:	e9 27 ff ff ff       	jmp    1db <printf+0x2c>
        putc(fd, *ap);
 2b4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2b7:	0f be 17             	movsbl (%edi),%edx
 2ba:	8b 45 08             	mov    0x8(%ebp),%eax
 2bd:	e8 5a fe ff ff       	call   11c <putc>
        ap++;
 2c2:	83 c7 04             	add    $0x4,%edi
 2c5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 2c8:	be 00 00 00 00       	mov    $0x0,%esi
 2cd:	e9 09 ff ff ff       	jmp    1db <printf+0x2c>
        putc(fd, c);
 2d2:	89 fa                	mov    %edi,%edx
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	e8 40 fe ff ff       	call   11c <putc>
      state = 0;
 2dc:	be 00 00 00 00       	mov    $0x0,%esi
 2e1:	e9 f5 fe ff ff       	jmp    1db <printf+0x2c>
        putc(fd, '%');
 2e6:	ba 25 00 00 00       	mov    $0x25,%edx
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	e8 29 fe ff ff       	call   11c <putc>
        putc(fd, c);
 2f3:	89 fa                	mov    %edi,%edx
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	e8 1f fe ff ff       	call   11c <putc>
      state = 0;
 2fd:	be 00 00 00 00       	mov    $0x0,%esi
 302:	e9 d4 fe ff ff       	jmp    1db <printf+0x2c>
    }
  }
}
 307:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30a:	5b                   	pop    %ebx
 30b:	5e                   	pop    %esi
 30c:	5f                   	pop    %edi
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
