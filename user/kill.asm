
kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 07                	jle    25 <main+0x25>
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	eb 32                	jmp    57 <main+0x57>
    printf(2, "usage: kill pid...\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	68 8c 04 00 00       	push   $0x48c
  2d:	6a 02                	push   $0x2
  2f:	e8 f6 02 00 00       	call   32a <printf>
    exit(0);
  34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3b:	e8 a7 01 00 00       	call   1e7 <exit>
    kill(atoi(argv[i]));
  40:	83 ec 0c             	sub    $0xc,%esp
  43:	ff 34 9f             	push   (%edi,%ebx,4)
  46:	e8 3e 01 00 00       	call   189 <atoi>
  4b:	89 04 24             	mov    %eax,(%esp)
  4e:	e8 c4 01 00 00       	call   217 <kill>
  for(i=1; i<argc; i++)
  53:	43                   	inc    %ebx
  54:	83 c4 10             	add    $0x10,%esp
  57:	39 f3                	cmp    %esi,%ebx
  59:	7c e5                	jl     40 <main+0x40>
  exit(0);
  5b:	83 ec 0c             	sub    $0xc,%esp
  5e:	6a 00                	push   $0x0
  60:	e8 82 01 00 00       	call   1e7 <exit>

00000065 <start>:

// Entry point of the library	
void
start()
{
}
  65:	c3                   	ret    

00000066 <strcpy>:

char*
strcpy(char *s, const char *t)
{
  66:	55                   	push   %ebp
  67:	89 e5                	mov    %esp,%ebp
  69:	56                   	push   %esi
  6a:	53                   	push   %ebx
  6b:	8b 45 08             	mov    0x8(%ebp),%eax
  6e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  71:	89 c2                	mov    %eax,%edx
  73:	89 cb                	mov    %ecx,%ebx
  75:	41                   	inc    %ecx
  76:	89 d6                	mov    %edx,%esi
  78:	42                   	inc    %edx
  79:	8a 1b                	mov    (%ebx),%bl
  7b:	88 1e                	mov    %bl,(%esi)
  7d:	84 db                	test   %bl,%bl
  7f:	75 f2                	jne    73 <strcpy+0xd>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5e                   	pop    %esi
  83:	5d                   	pop    %ebp
  84:	c3                   	ret    

00000085 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  85:	55                   	push   %ebp
  86:	89 e5                	mov    %esp,%ebp
  88:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  8e:	eb 02                	jmp    92 <strcmp+0xd>
    p++, q++;
  90:	41                   	inc    %ecx
  91:	42                   	inc    %edx
  while(*p && *p == *q)
  92:	8a 01                	mov    (%ecx),%al
  94:	84 c0                	test   %al,%al
  96:	74 04                	je     9c <strcmp+0x17>
  98:	3a 02                	cmp    (%edx),%al
  9a:	74 f4                	je     90 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  9c:	0f b6 c0             	movzbl %al,%eax
  9f:	0f b6 12             	movzbl (%edx),%edx
  a2:	29 d0                	sub    %edx,%eax
}
  a4:	5d                   	pop    %ebp
  a5:	c3                   	ret    

000000a6 <strlen>:

uint
strlen(const char *s)
{
  a6:	55                   	push   %ebp
  a7:	89 e5                	mov    %esp,%ebp
  a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ac:	b8 00 00 00 00       	mov    $0x0,%eax
  b1:	eb 01                	jmp    b4 <strlen+0xe>
  b3:	40                   	inc    %eax
  b4:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  b8:	75 f9                	jne    b3 <strlen+0xd>
    ;
  return n;
}
  ba:	5d                   	pop    %ebp
  bb:	c3                   	ret    

000000bc <memset>:

void*
memset(void *dst, int c, uint n)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c0:	8b 7d 08             	mov    0x8(%ebp),%edi
  c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  c9:	fc                   	cld    
  ca:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	8b 7d fc             	mov    -0x4(%ebp),%edi
  d2:	c9                   	leave  
  d3:	c3                   	ret    

000000d4 <strchr>:

char*
strchr(const char *s, char c)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  dd:	eb 01                	jmp    e0 <strchr+0xc>
  df:	40                   	inc    %eax
  e0:	8a 10                	mov    (%eax),%dl
  e2:	84 d2                	test   %dl,%dl
  e4:	74 06                	je     ec <strchr+0x18>
    if(*s == c)
  e6:	38 ca                	cmp    %cl,%dl
  e8:	75 f5                	jne    df <strchr+0xb>
  ea:	eb 05                	jmp    f1 <strchr+0x1d>
      return (char*)s;
  return 0;
  ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    

000000f3 <gets>:

char*
gets(char *buf, int max)
{
  f3:	55                   	push   %ebp
  f4:	89 e5                	mov    %esp,%ebp
  f6:	57                   	push   %edi
  f7:	56                   	push   %esi
  f8:	53                   	push   %ebx
  f9:	83 ec 1c             	sub    $0x1c,%esp
  fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  ff:	bb 00 00 00 00       	mov    $0x0,%ebx
 104:	89 de                	mov    %ebx,%esi
 106:	43                   	inc    %ebx
 107:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 10a:	7d 2b                	jge    137 <gets+0x44>
    cc = read(0, &c, 1);
 10c:	83 ec 04             	sub    $0x4,%esp
 10f:	6a 01                	push   $0x1
 111:	8d 45 e7             	lea    -0x19(%ebp),%eax
 114:	50                   	push   %eax
 115:	6a 00                	push   $0x0
 117:	e8 e3 00 00 00       	call   1ff <read>
    if(cc < 1)
 11c:	83 c4 10             	add    $0x10,%esp
 11f:	85 c0                	test   %eax,%eax
 121:	7e 14                	jle    137 <gets+0x44>
      break;
    buf[i++] = c;
 123:	8a 45 e7             	mov    -0x19(%ebp),%al
 126:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 129:	3c 0a                	cmp    $0xa,%al
 12b:	74 08                	je     135 <gets+0x42>
 12d:	3c 0d                	cmp    $0xd,%al
 12f:	75 d3                	jne    104 <gets+0x11>
    buf[i++] = c;
 131:	89 de                	mov    %ebx,%esi
 133:	eb 02                	jmp    137 <gets+0x44>
 135:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 137:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 13b:	89 f8                	mov    %edi,%eax
 13d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 140:	5b                   	pop    %ebx
 141:	5e                   	pop    %esi
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    

00000145 <stat>:

int
stat(const char *n, struct stat *st)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
 148:	56                   	push   %esi
 149:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 14a:	83 ec 08             	sub    $0x8,%esp
 14d:	6a 00                	push   $0x0
 14f:	ff 75 08             	push   0x8(%ebp)
 152:	e8 d0 00 00 00       	call   227 <open>
  if(fd < 0)
 157:	83 c4 10             	add    $0x10,%esp
 15a:	85 c0                	test   %eax,%eax
 15c:	78 24                	js     182 <stat+0x3d>
 15e:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 160:	83 ec 08             	sub    $0x8,%esp
 163:	ff 75 0c             	push   0xc(%ebp)
 166:	50                   	push   %eax
 167:	e8 d3 00 00 00       	call   23f <fstat>
 16c:	89 c6                	mov    %eax,%esi
  close(fd);
 16e:	89 1c 24             	mov    %ebx,(%esp)
 171:	e8 99 00 00 00       	call   20f <close>
  return r;
 176:	83 c4 10             	add    $0x10,%esp
}
 179:	89 f0                	mov    %esi,%eax
 17b:	8d 65 f8             	lea    -0x8(%ebp),%esp
 17e:	5b                   	pop    %ebx
 17f:	5e                   	pop    %esi
 180:	5d                   	pop    %ebp
 181:	c3                   	ret    
    return -1;
 182:	be ff ff ff ff       	mov    $0xffffffff,%esi
 187:	eb f0                	jmp    179 <stat+0x34>

00000189 <atoi>:

int
atoi(const char *s)
{
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
 18c:	53                   	push   %ebx
 18d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 190:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 195:	eb 0e                	jmp    1a5 <atoi+0x1c>
    n = n*10 + *s++ - '0';
 197:	8d 14 92             	lea    (%edx,%edx,4),%edx
 19a:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 19d:	41                   	inc    %ecx
 19e:	0f be c0             	movsbl %al,%eax
 1a1:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
  while('0' <= *s && *s <= '9')
 1a5:	8a 01                	mov    (%ecx),%al
 1a7:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1aa:	80 fb 09             	cmp    $0x9,%bl
 1ad:	76 e8                	jbe    197 <atoi+0xe>
  return n;
}
 1af:	89 d0                	mov    %edx,%eax
 1b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1b4:	c9                   	leave  
 1b5:	c3                   	ret    

000001b6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1b6:	55                   	push   %ebp
 1b7:	89 e5                	mov    %esp,%ebp
 1b9:	56                   	push   %esi
 1ba:	53                   	push   %ebx
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1c1:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 1c4:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 1c6:	eb 0c                	jmp    1d4 <memmove+0x1e>
    *dst++ = *src++;
 1c8:	8a 13                	mov    (%ebx),%dl
 1ca:	88 11                	mov    %dl,(%ecx)
 1cc:	8d 5b 01             	lea    0x1(%ebx),%ebx
 1cf:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 1d2:	89 f2                	mov    %esi,%edx
 1d4:	8d 72 ff             	lea    -0x1(%edx),%esi
 1d7:	85 d2                	test   %edx,%edx
 1d9:	7f ed                	jg     1c8 <memmove+0x12>
  return vdst;
}
 1db:	5b                   	pop    %ebx
 1dc:	5e                   	pop    %esi
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    

000001df <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1df:	b8 01 00 00 00       	mov    $0x1,%eax
 1e4:	cd 40                	int    $0x40
 1e6:	c3                   	ret    

000001e7 <exit>:
SYSCALL(exit)
 1e7:	b8 02 00 00 00       	mov    $0x2,%eax
 1ec:	cd 40                	int    $0x40
 1ee:	c3                   	ret    

000001ef <wait>:
SYSCALL(wait)
 1ef:	b8 03 00 00 00       	mov    $0x3,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret    

000001f7 <pipe>:
SYSCALL(pipe)
 1f7:	b8 04 00 00 00       	mov    $0x4,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <read>:
SYSCALL(read)
 1ff:	b8 05 00 00 00       	mov    $0x5,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <write>:
SYSCALL(write)
 207:	b8 10 00 00 00       	mov    $0x10,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <close>:
SYSCALL(close)
 20f:	b8 15 00 00 00       	mov    $0x15,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <kill>:
SYSCALL(kill)
 217:	b8 06 00 00 00       	mov    $0x6,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <exec>:
SYSCALL(exec)
 21f:	b8 07 00 00 00       	mov    $0x7,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <open>:
SYSCALL(open)
 227:	b8 0f 00 00 00       	mov    $0xf,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <mknod>:
SYSCALL(mknod)
 22f:	b8 11 00 00 00       	mov    $0x11,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <unlink>:
SYSCALL(unlink)
 237:	b8 12 00 00 00       	mov    $0x12,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <fstat>:
SYSCALL(fstat)
 23f:	b8 08 00 00 00       	mov    $0x8,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <link>:
SYSCALL(link)
 247:	b8 13 00 00 00       	mov    $0x13,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <mkdir>:
SYSCALL(mkdir)
 24f:	b8 14 00 00 00       	mov    $0x14,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <chdir>:
SYSCALL(chdir)
 257:	b8 09 00 00 00       	mov    $0x9,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <dup>:
SYSCALL(dup)
 25f:	b8 0a 00 00 00       	mov    $0xa,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <getpid>:
SYSCALL(getpid)
 267:	b8 0b 00 00 00       	mov    $0xb,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <sbrk>:
SYSCALL(sbrk)
 26f:	b8 0c 00 00 00       	mov    $0xc,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <sleep>:
SYSCALL(sleep)
 277:	b8 0d 00 00 00       	mov    $0xd,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <uptime>:
SYSCALL(uptime)
 27f:	b8 0e 00 00 00       	mov    $0xe,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <date>:
SYSCALL(date)
 287:	b8 16 00 00 00       	mov    $0x16,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <dup2>:
SYSCALL(dup2)
 28f:	b8 17 00 00 00       	mov    $0x17,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 1c             	sub    $0x1c,%esp
 29d:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2a0:	6a 01                	push   $0x1
 2a2:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2a5:	52                   	push   %edx
 2a6:	50                   	push   %eax
 2a7:	e8 5b ff ff ff       	call   207 <write>
}
 2ac:	83 c4 10             	add    $0x10,%esp
 2af:	c9                   	leave  
 2b0:	c3                   	ret    

000002b1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	57                   	push   %edi
 2b5:	56                   	push   %esi
 2b6:	53                   	push   %ebx
 2b7:	83 ec 2c             	sub    $0x2c,%esp
 2ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 2bd:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2c3:	74 04                	je     2c9 <printint+0x18>
 2c5:	85 d2                	test   %edx,%edx
 2c7:	78 3c                	js     305 <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 2c9:	89 d1                	mov    %edx,%ecx
  neg = 0;
 2cb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 2d2:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 2d7:	89 c8                	mov    %ecx,%eax
 2d9:	ba 00 00 00 00       	mov    $0x0,%edx
 2de:	f7 f6                	div    %esi
 2e0:	89 df                	mov    %ebx,%edi
 2e2:	43                   	inc    %ebx
 2e3:	8a 92 00 05 00 00    	mov    0x500(%edx),%dl
 2e9:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 2ed:	89 ca                	mov    %ecx,%edx
 2ef:	89 c1                	mov    %eax,%ecx
 2f1:	39 d6                	cmp    %edx,%esi
 2f3:	76 e2                	jbe    2d7 <printint+0x26>
  if(neg)
 2f5:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 2f9:	74 24                	je     31f <printint+0x6e>
    buf[i++] = '-';
 2fb:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 300:	8d 5f 02             	lea    0x2(%edi),%ebx
 303:	eb 1a                	jmp    31f <printint+0x6e>
    x = -xx;
 305:	89 d1                	mov    %edx,%ecx
 307:	f7 d9                	neg    %ecx
    neg = 1;
 309:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 310:	eb c0                	jmp    2d2 <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 312:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 317:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 31a:	e8 78 ff ff ff       	call   297 <putc>
  while(--i >= 0)
 31f:	4b                   	dec    %ebx
 320:	79 f0                	jns    312 <printint+0x61>
}
 322:	83 c4 2c             	add    $0x2c,%esp
 325:	5b                   	pop    %ebx
 326:	5e                   	pop    %esi
 327:	5f                   	pop    %edi
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    

0000032a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 32a:	55                   	push   %ebp
 32b:	89 e5                	mov    %esp,%ebp
 32d:	57                   	push   %edi
 32e:	56                   	push   %esi
 32f:	53                   	push   %ebx
 330:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 333:	8d 45 10             	lea    0x10(%ebp),%eax
 336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 339:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 33e:	bb 00 00 00 00       	mov    $0x0,%ebx
 343:	eb 12                	jmp    357 <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 345:	89 fa                	mov    %edi,%edx
 347:	8b 45 08             	mov    0x8(%ebp),%eax
 34a:	e8 48 ff ff ff       	call   297 <putc>
 34f:	eb 05                	jmp    356 <printf+0x2c>
      }
    } else if(state == '%'){
 351:	83 fe 25             	cmp    $0x25,%esi
 354:	74 22                	je     378 <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 356:	43                   	inc    %ebx
 357:	8b 45 0c             	mov    0xc(%ebp),%eax
 35a:	8a 04 18             	mov    (%eax,%ebx,1),%al
 35d:	84 c0                	test   %al,%al
 35f:	0f 84 1d 01 00 00    	je     482 <printf+0x158>
    c = fmt[i] & 0xff;
 365:	0f be f8             	movsbl %al,%edi
 368:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 36b:	85 f6                	test   %esi,%esi
 36d:	75 e2                	jne    351 <printf+0x27>
      if(c == '%'){
 36f:	83 f8 25             	cmp    $0x25,%eax
 372:	75 d1                	jne    345 <printf+0x1b>
        state = '%';
 374:	89 c6                	mov    %eax,%esi
 376:	eb de                	jmp    356 <printf+0x2c>
      if(c == 'd'){
 378:	83 f8 25             	cmp    $0x25,%eax
 37b:	0f 84 cc 00 00 00    	je     44d <printf+0x123>
 381:	0f 8c da 00 00 00    	jl     461 <printf+0x137>
 387:	83 f8 78             	cmp    $0x78,%eax
 38a:	0f 8f d1 00 00 00    	jg     461 <printf+0x137>
 390:	83 f8 63             	cmp    $0x63,%eax
 393:	0f 8c c8 00 00 00    	jl     461 <printf+0x137>
 399:	83 e8 63             	sub    $0x63,%eax
 39c:	83 f8 15             	cmp    $0x15,%eax
 39f:	0f 87 bc 00 00 00    	ja     461 <printf+0x137>
 3a5:	ff 24 85 a8 04 00 00 	jmp    *0x4a8(,%eax,4)
        printint(fd, *ap, 10, 1);
 3ac:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3af:	8b 17                	mov    (%edi),%edx
 3b1:	83 ec 0c             	sub    $0xc,%esp
 3b4:	6a 01                	push   $0x1
 3b6:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	e8 ee fe ff ff       	call   2b1 <printint>
        ap++;
 3c3:	83 c7 04             	add    $0x4,%edi
 3c6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3c9:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3cc:	be 00 00 00 00       	mov    $0x0,%esi
 3d1:	eb 83                	jmp    356 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 3d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3d6:	8b 17                	mov    (%edi),%edx
 3d8:	83 ec 0c             	sub    $0xc,%esp
 3db:	6a 00                	push   $0x0
 3dd:	b9 10 00 00 00       	mov    $0x10,%ecx
 3e2:	8b 45 08             	mov    0x8(%ebp),%eax
 3e5:	e8 c7 fe ff ff       	call   2b1 <printint>
        ap++;
 3ea:	83 c7 04             	add    $0x4,%edi
 3ed:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3f0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3f3:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 3f8:	e9 59 ff ff ff       	jmp    356 <printf+0x2c>
        s = (char*)*ap;
 3fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 400:	8b 30                	mov    (%eax),%esi
        ap++;
 402:	83 c0 04             	add    $0x4,%eax
 405:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 408:	85 f6                	test   %esi,%esi
 40a:	75 13                	jne    41f <printf+0xf5>
          s = "(null)";
 40c:	be a0 04 00 00       	mov    $0x4a0,%esi
 411:	eb 0c                	jmp    41f <printf+0xf5>
          putc(fd, *s);
 413:	0f be d2             	movsbl %dl,%edx
 416:	8b 45 08             	mov    0x8(%ebp),%eax
 419:	e8 79 fe ff ff       	call   297 <putc>
          s++;
 41e:	46                   	inc    %esi
        while(*s != 0){
 41f:	8a 16                	mov    (%esi),%dl
 421:	84 d2                	test   %dl,%dl
 423:	75 ee                	jne    413 <printf+0xe9>
      state = 0;
 425:	be 00 00 00 00       	mov    $0x0,%esi
 42a:	e9 27 ff ff ff       	jmp    356 <printf+0x2c>
        putc(fd, *ap);
 42f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 432:	0f be 17             	movsbl (%edi),%edx
 435:	8b 45 08             	mov    0x8(%ebp),%eax
 438:	e8 5a fe ff ff       	call   297 <putc>
        ap++;
 43d:	83 c7 04             	add    $0x4,%edi
 440:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 443:	be 00 00 00 00       	mov    $0x0,%esi
 448:	e9 09 ff ff ff       	jmp    356 <printf+0x2c>
        putc(fd, c);
 44d:	89 fa                	mov    %edi,%edx
 44f:	8b 45 08             	mov    0x8(%ebp),%eax
 452:	e8 40 fe ff ff       	call   297 <putc>
      state = 0;
 457:	be 00 00 00 00       	mov    $0x0,%esi
 45c:	e9 f5 fe ff ff       	jmp    356 <printf+0x2c>
        putc(fd, '%');
 461:	ba 25 00 00 00       	mov    $0x25,%edx
 466:	8b 45 08             	mov    0x8(%ebp),%eax
 469:	e8 29 fe ff ff       	call   297 <putc>
        putc(fd, c);
 46e:	89 fa                	mov    %edi,%edx
 470:	8b 45 08             	mov    0x8(%ebp),%eax
 473:	e8 1f fe ff ff       	call   297 <putc>
      state = 0;
 478:	be 00 00 00 00       	mov    $0x0,%esi
 47d:	e9 d4 fe ff ff       	jmp    356 <printf+0x2c>
    }
  }
}
 482:	8d 65 f4             	lea    -0xc(%ebp),%esp
 485:	5b                   	pop    %ebx
 486:	5e                   	pop    %esi
 487:	5f                   	pop    %edi
 488:	5d                   	pop    %ebp
 489:	c3                   	ret    
