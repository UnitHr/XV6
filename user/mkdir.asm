
mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  19:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 07                	jle    28 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
    exit(0);
  }

  for(i = 1; i < argc; i++){
  21:	bb 01 00 00 00       	mov    $0x1,%ebx
  26:	eb 1c                	jmp    44 <main+0x44>
    printf(2, "Usage: mkdir files...\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 28 03 00 00       	push   $0x328
  30:	6a 02                	push   $0x2
  32:	e8 8f 01 00 00       	call   1c6 <printf>
    exit(0);
  37:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3e:	e8 40 00 00 00       	call   83 <exit>
  for(i = 1; i < argc; i++){
  43:	43                   	inc    %ebx
  44:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  47:	7d 28                	jge    71 <main+0x71>
    if(mkdir(argv[i]) < 0){
  49:	8d 34 9f             	lea    (%edi,%ebx,4),%esi
  4c:	83 ec 0c             	sub    $0xc,%esp
  4f:	ff 36                	push   (%esi)
  51:	e8 95 00 00 00       	call   eb <mkdir>
  56:	83 c4 10             	add    $0x10,%esp
  59:	85 c0                	test   %eax,%eax
  5b:	79 e6                	jns    43 <main+0x43>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5d:	83 ec 04             	sub    $0x4,%esp
  60:	ff 36                	push   (%esi)
  62:	68 3f 03 00 00       	push   $0x33f
  67:	6a 02                	push   $0x2
  69:	e8 58 01 00 00       	call   1c6 <printf>
      break;
  6e:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit(0);
  71:	83 ec 0c             	sub    $0xc,%esp
  74:	6a 00                	push   $0x0
  76:	e8 08 00 00 00       	call   83 <exit>

0000007b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
  7b:	b8 01 00 00 00       	mov    $0x1,%eax
  80:	cd 40                	int    $0x40
  82:	c3                   	ret    

00000083 <exit>:
SYSCALL(exit)
  83:	b8 02 00 00 00       	mov    $0x2,%eax
  88:	cd 40                	int    $0x40
  8a:	c3                   	ret    

0000008b <wait>:
SYSCALL(wait)
  8b:	b8 03 00 00 00       	mov    $0x3,%eax
  90:	cd 40                	int    $0x40
  92:	c3                   	ret    

00000093 <pipe>:
SYSCALL(pipe)
  93:	b8 04 00 00 00       	mov    $0x4,%eax
  98:	cd 40                	int    $0x40
  9a:	c3                   	ret    

0000009b <read>:
SYSCALL(read)
  9b:	b8 05 00 00 00       	mov    $0x5,%eax
  a0:	cd 40                	int    $0x40
  a2:	c3                   	ret    

000000a3 <write>:
SYSCALL(write)
  a3:	b8 10 00 00 00       	mov    $0x10,%eax
  a8:	cd 40                	int    $0x40
  aa:	c3                   	ret    

000000ab <close>:
SYSCALL(close)
  ab:	b8 15 00 00 00       	mov    $0x15,%eax
  b0:	cd 40                	int    $0x40
  b2:	c3                   	ret    

000000b3 <kill>:
SYSCALL(kill)
  b3:	b8 06 00 00 00       	mov    $0x6,%eax
  b8:	cd 40                	int    $0x40
  ba:	c3                   	ret    

000000bb <exec>:
SYSCALL(exec)
  bb:	b8 07 00 00 00       	mov    $0x7,%eax
  c0:	cd 40                	int    $0x40
  c2:	c3                   	ret    

000000c3 <open>:
SYSCALL(open)
  c3:	b8 0f 00 00 00       	mov    $0xf,%eax
  c8:	cd 40                	int    $0x40
  ca:	c3                   	ret    

000000cb <mknod>:
SYSCALL(mknod)
  cb:	b8 11 00 00 00       	mov    $0x11,%eax
  d0:	cd 40                	int    $0x40
  d2:	c3                   	ret    

000000d3 <unlink>:
SYSCALL(unlink)
  d3:	b8 12 00 00 00       	mov    $0x12,%eax
  d8:	cd 40                	int    $0x40
  da:	c3                   	ret    

000000db <fstat>:
SYSCALL(fstat)
  db:	b8 08 00 00 00       	mov    $0x8,%eax
  e0:	cd 40                	int    $0x40
  e2:	c3                   	ret    

000000e3 <link>:
SYSCALL(link)
  e3:	b8 13 00 00 00       	mov    $0x13,%eax
  e8:	cd 40                	int    $0x40
  ea:	c3                   	ret    

000000eb <mkdir>:
SYSCALL(mkdir)
  eb:	b8 14 00 00 00       	mov    $0x14,%eax
  f0:	cd 40                	int    $0x40
  f2:	c3                   	ret    

000000f3 <chdir>:
SYSCALL(chdir)
  f3:	b8 09 00 00 00       	mov    $0x9,%eax
  f8:	cd 40                	int    $0x40
  fa:	c3                   	ret    

000000fb <dup>:
SYSCALL(dup)
  fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 100:	cd 40                	int    $0x40
 102:	c3                   	ret    

00000103 <getpid>:
SYSCALL(getpid)
 103:	b8 0b 00 00 00       	mov    $0xb,%eax
 108:	cd 40                	int    $0x40
 10a:	c3                   	ret    

0000010b <sbrk>:
SYSCALL(sbrk)
 10b:	b8 0c 00 00 00       	mov    $0xc,%eax
 110:	cd 40                	int    $0x40
 112:	c3                   	ret    

00000113 <sleep>:
SYSCALL(sleep)
 113:	b8 0d 00 00 00       	mov    $0xd,%eax
 118:	cd 40                	int    $0x40
 11a:	c3                   	ret    

0000011b <uptime>:
SYSCALL(uptime)
 11b:	b8 0e 00 00 00       	mov    $0xe,%eax
 120:	cd 40                	int    $0x40
 122:	c3                   	ret    

00000123 <date>:
SYSCALL(date)
 123:	b8 16 00 00 00       	mov    $0x16,%eax
 128:	cd 40                	int    $0x40
 12a:	c3                   	ret    

0000012b <dup2>:
SYSCALL(dup2)
 12b:	b8 17 00 00 00       	mov    $0x17,%eax
 130:	cd 40                	int    $0x40
 132:	c3                   	ret    

00000133 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 133:	55                   	push   %ebp
 134:	89 e5                	mov    %esp,%ebp
 136:	83 ec 1c             	sub    $0x1c,%esp
 139:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 13c:	6a 01                	push   $0x1
 13e:	8d 55 f4             	lea    -0xc(%ebp),%edx
 141:	52                   	push   %edx
 142:	50                   	push   %eax
 143:	e8 5b ff ff ff       	call   a3 <write>
}
 148:	83 c4 10             	add    $0x10,%esp
 14b:	c9                   	leave  
 14c:	c3                   	ret    

0000014d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 14d:	55                   	push   %ebp
 14e:	89 e5                	mov    %esp,%ebp
 150:	57                   	push   %edi
 151:	56                   	push   %esi
 152:	53                   	push   %ebx
 153:	83 ec 2c             	sub    $0x2c,%esp
 156:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 159:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 15b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 15f:	74 04                	je     165 <printint+0x18>
 161:	85 d2                	test   %edx,%edx
 163:	78 3c                	js     1a1 <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 165:	89 d1                	mov    %edx,%ecx
  neg = 0;
 167:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 16e:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 173:	89 c8                	mov    %ecx,%eax
 175:	ba 00 00 00 00       	mov    $0x0,%edx
 17a:	f7 f6                	div    %esi
 17c:	89 df                	mov    %ebx,%edi
 17e:	43                   	inc    %ebx
 17f:	8a 92 bc 03 00 00    	mov    0x3bc(%edx),%dl
 185:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 189:	89 ca                	mov    %ecx,%edx
 18b:	89 c1                	mov    %eax,%ecx
 18d:	39 d6                	cmp    %edx,%esi
 18f:	76 e2                	jbe    173 <printint+0x26>
  if(neg)
 191:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 195:	74 24                	je     1bb <printint+0x6e>
    buf[i++] = '-';
 197:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 19c:	8d 5f 02             	lea    0x2(%edi),%ebx
 19f:	eb 1a                	jmp    1bb <printint+0x6e>
    x = -xx;
 1a1:	89 d1                	mov    %edx,%ecx
 1a3:	f7 d9                	neg    %ecx
    neg = 1;
 1a5:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 1ac:	eb c0                	jmp    16e <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 1ae:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 1b3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1b6:	e8 78 ff ff ff       	call   133 <putc>
  while(--i >= 0)
 1bb:	4b                   	dec    %ebx
 1bc:	79 f0                	jns    1ae <printint+0x61>
}
 1be:	83 c4 2c             	add    $0x2c,%esp
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5f                   	pop    %edi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    

000001c6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 1c6:	55                   	push   %ebp
 1c7:	89 e5                	mov    %esp,%ebp
 1c9:	57                   	push   %edi
 1ca:	56                   	push   %esi
 1cb:	53                   	push   %ebx
 1cc:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 1cf:	8d 45 10             	lea    0x10(%ebp),%eax
 1d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 1d5:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 1da:	bb 00 00 00 00       	mov    $0x0,%ebx
 1df:	eb 12                	jmp    1f3 <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 1e1:	89 fa                	mov    %edi,%edx
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	e8 48 ff ff ff       	call   133 <putc>
 1eb:	eb 05                	jmp    1f2 <printf+0x2c>
      }
    } else if(state == '%'){
 1ed:	83 fe 25             	cmp    $0x25,%esi
 1f0:	74 22                	je     214 <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 1f2:	43                   	inc    %ebx
 1f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f6:	8a 04 18             	mov    (%eax,%ebx,1),%al
 1f9:	84 c0                	test   %al,%al
 1fb:	0f 84 1d 01 00 00    	je     31e <printf+0x158>
    c = fmt[i] & 0xff;
 201:	0f be f8             	movsbl %al,%edi
 204:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 207:	85 f6                	test   %esi,%esi
 209:	75 e2                	jne    1ed <printf+0x27>
      if(c == '%'){
 20b:	83 f8 25             	cmp    $0x25,%eax
 20e:	75 d1                	jne    1e1 <printf+0x1b>
        state = '%';
 210:	89 c6                	mov    %eax,%esi
 212:	eb de                	jmp    1f2 <printf+0x2c>
      if(c == 'd'){
 214:	83 f8 25             	cmp    $0x25,%eax
 217:	0f 84 cc 00 00 00    	je     2e9 <printf+0x123>
 21d:	0f 8c da 00 00 00    	jl     2fd <printf+0x137>
 223:	83 f8 78             	cmp    $0x78,%eax
 226:	0f 8f d1 00 00 00    	jg     2fd <printf+0x137>
 22c:	83 f8 63             	cmp    $0x63,%eax
 22f:	0f 8c c8 00 00 00    	jl     2fd <printf+0x137>
 235:	83 e8 63             	sub    $0x63,%eax
 238:	83 f8 15             	cmp    $0x15,%eax
 23b:	0f 87 bc 00 00 00    	ja     2fd <printf+0x137>
 241:	ff 24 85 64 03 00 00 	jmp    *0x364(,%eax,4)
        printint(fd, *ap, 10, 1);
 248:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 24b:	8b 17                	mov    (%edi),%edx
 24d:	83 ec 0c             	sub    $0xc,%esp
 250:	6a 01                	push   $0x1
 252:	b9 0a 00 00 00       	mov    $0xa,%ecx
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	e8 ee fe ff ff       	call   14d <printint>
        ap++;
 25f:	83 c7 04             	add    $0x4,%edi
 262:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 265:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 268:	be 00 00 00 00       	mov    $0x0,%esi
 26d:	eb 83                	jmp    1f2 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 26f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 272:	8b 17                	mov    (%edi),%edx
 274:	83 ec 0c             	sub    $0xc,%esp
 277:	6a 00                	push   $0x0
 279:	b9 10 00 00 00       	mov    $0x10,%ecx
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	e8 c7 fe ff ff       	call   14d <printint>
        ap++;
 286:	83 c7 04             	add    $0x4,%edi
 289:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 28c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 28f:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 294:	e9 59 ff ff ff       	jmp    1f2 <printf+0x2c>
        s = (char*)*ap;
 299:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 29c:	8b 30                	mov    (%eax),%esi
        ap++;
 29e:	83 c0 04             	add    $0x4,%eax
 2a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 2a4:	85 f6                	test   %esi,%esi
 2a6:	75 13                	jne    2bb <printf+0xf5>
          s = "(null)";
 2a8:	be 5b 03 00 00       	mov    $0x35b,%esi
 2ad:	eb 0c                	jmp    2bb <printf+0xf5>
          putc(fd, *s);
 2af:	0f be d2             	movsbl %dl,%edx
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
 2b5:	e8 79 fe ff ff       	call   133 <putc>
          s++;
 2ba:	46                   	inc    %esi
        while(*s != 0){
 2bb:	8a 16                	mov    (%esi),%dl
 2bd:	84 d2                	test   %dl,%dl
 2bf:	75 ee                	jne    2af <printf+0xe9>
      state = 0;
 2c1:	be 00 00 00 00       	mov    $0x0,%esi
 2c6:	e9 27 ff ff ff       	jmp    1f2 <printf+0x2c>
        putc(fd, *ap);
 2cb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2ce:	0f be 17             	movsbl (%edi),%edx
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	e8 5a fe ff ff       	call   133 <putc>
        ap++;
 2d9:	83 c7 04             	add    $0x4,%edi
 2dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 2df:	be 00 00 00 00       	mov    $0x0,%esi
 2e4:	e9 09 ff ff ff       	jmp    1f2 <printf+0x2c>
        putc(fd, c);
 2e9:	89 fa                	mov    %edi,%edx
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	e8 40 fe ff ff       	call   133 <putc>
      state = 0;
 2f3:	be 00 00 00 00       	mov    $0x0,%esi
 2f8:	e9 f5 fe ff ff       	jmp    1f2 <printf+0x2c>
        putc(fd, '%');
 2fd:	ba 25 00 00 00       	mov    $0x25,%edx
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	e8 29 fe ff ff       	call   133 <putc>
        putc(fd, c);
 30a:	89 fa                	mov    %edi,%edx
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	e8 1f fe ff ff       	call   133 <putc>
      state = 0;
 314:	be 00 00 00 00       	mov    $0x0,%esi
 319:	e9 d4 fe ff ff       	jmp    1f2 <printf+0x2c>
    }
  }
}
 31e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 321:	5b                   	pop    %ebx
 322:	5e                   	pop    %esi
 323:	5f                   	pop    %edi
 324:	5d                   	pop    %ebp
 325:	c3                   	ret    
