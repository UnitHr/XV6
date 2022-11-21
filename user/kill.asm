
kill:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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

  if(argc < 2){
  1d:	83 fe 01             	cmp    $0x1,%esi
  20:	7e 07                	jle    29 <main+0x29>
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  22:	bb 01 00 00 00       	mov    $0x1,%ebx
  27:	eb 2b                	jmp    54 <main+0x54>
    printf(2, "usage: kill pid...\n");
  29:	83 ec 08             	sub    $0x8,%esp
  2c:	68 9c 04 00 00       	push   $0x49c
  31:	6a 02                	push   $0x2
  33:	e8 08 03 00 00       	call   340 <printf>
    exit();
  38:	e8 c4 01 00 00       	call   201 <exit>
    kill(atoi(argv[i]));
  3d:	83 ec 0c             	sub    $0xc,%esp
  40:	ff 34 9f             	pushl  (%edi,%ebx,4)
  43:	e8 55 01 00 00       	call   19d <atoi>
  48:	89 04 24             	mov    %eax,(%esp)
  4b:	e8 e1 01 00 00       	call   231 <kill>
  for(i=1; i<argc; i++)
  50:	43                   	inc    %ebx
  51:	83 c4 10             	add    $0x10,%esp
  54:	39 f3                	cmp    %esi,%ebx
  56:	7c e5                	jl     3d <main+0x3d>
  exit();
  58:	e8 a4 01 00 00       	call   201 <exit>

0000005d <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
  5d:	f3 0f 1e fb          	endbr32 
}
  61:	c3                   	ret    

00000062 <strcpy>:

char*
strcpy(char *s, const char *t)
{
  62:	f3 0f 1e fb          	endbr32 
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
  7f:	75 f2                	jne    73 <strcpy+0x11>
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
  85:	f3 0f 1e fb          	endbr32 
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  8c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  92:	8a 01                	mov    (%ecx),%al
  94:	84 c0                	test   %al,%al
  96:	74 08                	je     a0 <strcmp+0x1b>
  98:	3a 02                	cmp    (%edx),%al
  9a:	75 04                	jne    a0 <strcmp+0x1b>
    p++, q++;
  9c:	41                   	inc    %ecx
  9d:	42                   	inc    %edx
  9e:	eb f2                	jmp    92 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
  a0:	0f b6 c0             	movzbl %al,%eax
  a3:	0f b6 12             	movzbl (%edx),%edx
  a6:	29 d0                	sub    %edx,%eax
}
  a8:	5d                   	pop    %ebp
  a9:	c3                   	ret    

000000aa <strlen>:

uint
strlen(const char *s)
{
  aa:	f3 0f 1e fb          	endbr32 
  ae:	55                   	push   %ebp
  af:	89 e5                	mov    %esp,%ebp
  b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b4:	b8 00 00 00 00       	mov    $0x0,%eax
  b9:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  bd:	74 03                	je     c2 <strlen+0x18>
  bf:	40                   	inc    %eax
  c0:	eb f7                	jmp    b9 <strlen+0xf>
    ;
  return n;
}
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    

000000c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c4:	f3 0f 1e fb          	endbr32 
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  cc:	8b 7d 08             	mov    0x8(%ebp),%edi
  cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  d5:	fc                   	cld    
  d6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	5f                   	pop    %edi
  dc:	5d                   	pop    %ebp
  dd:	c3                   	ret    

000000de <strchr>:

char*
strchr(const char *s, char c)
{
  de:	f3 0f 1e fb          	endbr32 
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  e5:	8b 45 08             	mov    0x8(%ebp),%eax
  e8:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  eb:	8a 10                	mov    (%eax),%dl
  ed:	84 d2                	test   %dl,%dl
  ef:	74 07                	je     f8 <strchr+0x1a>
    if(*s == c)
  f1:	38 ca                	cmp    %cl,%dl
  f3:	74 08                	je     fd <strchr+0x1f>
  for(; *s; s++)
  f5:	40                   	inc    %eax
  f6:	eb f3                	jmp    eb <strchr+0xd>
      return (char*)s;
  return 0;
  f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    

000000ff <gets>:

char*
gets(char *buf, int max)
{
  ff:	f3 0f 1e fb          	endbr32 
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	57                   	push   %edi
 107:	56                   	push   %esi
 108:	53                   	push   %ebx
 109:	83 ec 1c             	sub    $0x1c,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 10f:	bb 00 00 00 00       	mov    $0x0,%ebx
 114:	89 de                	mov    %ebx,%esi
 116:	43                   	inc    %ebx
 117:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 11a:	7d 2b                	jge    147 <gets+0x48>
    cc = read(0, &c, 1);
 11c:	83 ec 04             	sub    $0x4,%esp
 11f:	6a 01                	push   $0x1
 121:	8d 45 e7             	lea    -0x19(%ebp),%eax
 124:	50                   	push   %eax
 125:	6a 00                	push   $0x0
 127:	e8 ed 00 00 00       	call   219 <read>
    if(cc < 1)
 12c:	83 c4 10             	add    $0x10,%esp
 12f:	85 c0                	test   %eax,%eax
 131:	7e 14                	jle    147 <gets+0x48>
      break;
    buf[i++] = c;
 133:	8a 45 e7             	mov    -0x19(%ebp),%al
 136:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 139:	3c 0a                	cmp    $0xa,%al
 13b:	74 08                	je     145 <gets+0x46>
 13d:	3c 0d                	cmp    $0xd,%al
 13f:	75 d3                	jne    114 <gets+0x15>
    buf[i++] = c;
 141:	89 de                	mov    %ebx,%esi
 143:	eb 02                	jmp    147 <gets+0x48>
 145:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 147:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 14b:	89 f8                	mov    %edi,%eax
 14d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    

00000155 <stat>:

int
stat(const char *n, struct stat *st)
{
 155:	f3 0f 1e fb          	endbr32 
 159:	55                   	push   %ebp
 15a:	89 e5                	mov    %esp,%ebp
 15c:	56                   	push   %esi
 15d:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 15e:	83 ec 08             	sub    $0x8,%esp
 161:	6a 00                	push   $0x0
 163:	ff 75 08             	pushl  0x8(%ebp)
 166:	e8 d6 00 00 00       	call   241 <open>
  if(fd < 0)
 16b:	83 c4 10             	add    $0x10,%esp
 16e:	85 c0                	test   %eax,%eax
 170:	78 24                	js     196 <stat+0x41>
 172:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 174:	83 ec 08             	sub    $0x8,%esp
 177:	ff 75 0c             	pushl  0xc(%ebp)
 17a:	50                   	push   %eax
 17b:	e8 d9 00 00 00       	call   259 <fstat>
 180:	89 c6                	mov    %eax,%esi
  close(fd);
 182:	89 1c 24             	mov    %ebx,(%esp)
 185:	e8 9f 00 00 00       	call   229 <close>
  return r;
 18a:	83 c4 10             	add    $0x10,%esp
}
 18d:	89 f0                	mov    %esi,%eax
 18f:	8d 65 f8             	lea    -0x8(%ebp),%esp
 192:	5b                   	pop    %ebx
 193:	5e                   	pop    %esi
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    
    return -1;
 196:	be ff ff ff ff       	mov    $0xffffffff,%esi
 19b:	eb f0                	jmp    18d <stat+0x38>

0000019d <atoi>:

int
atoi(const char *s)
{
 19d:	f3 0f 1e fb          	endbr32 
 1a1:	55                   	push   %ebp
 1a2:	89 e5                	mov    %esp,%ebp
 1a4:	53                   	push   %ebx
 1a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 1a8:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1ad:	8a 01                	mov    (%ecx),%al
 1af:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1b2:	80 fb 09             	cmp    $0x9,%bl
 1b5:	77 10                	ja     1c7 <atoi+0x2a>
    n = n*10 + *s++ - '0';
 1b7:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1ba:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 1bd:	41                   	inc    %ecx
 1be:	0f be c0             	movsbl %al,%eax
 1c1:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
 1c5:	eb e6                	jmp    1ad <atoi+0x10>
  return n;
}
 1c7:	89 d0                	mov    %edx,%eax
 1c9:	5b                   	pop    %ebx
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret    

000001cc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1cc:	f3 0f 1e fb          	endbr32 
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1db:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 1de:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 1e0:	8d 72 ff             	lea    -0x1(%edx),%esi
 1e3:	85 d2                	test   %edx,%edx
 1e5:	7e 0e                	jle    1f5 <memmove+0x29>
    *dst++ = *src++;
 1e7:	8a 13                	mov    (%ebx),%dl
 1e9:	88 11                	mov    %dl,(%ecx)
 1eb:	8d 5b 01             	lea    0x1(%ebx),%ebx
 1ee:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 1f1:	89 f2                	mov    %esi,%edx
 1f3:	eb eb                	jmp    1e0 <memmove+0x14>
  return vdst;
}
 1f5:	5b                   	pop    %ebx
 1f6:	5e                   	pop    %esi
 1f7:	5d                   	pop    %ebp
 1f8:	c3                   	ret    

000001f9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1f9:	b8 01 00 00 00       	mov    $0x1,%eax
 1fe:	cd 40                	int    $0x40
 200:	c3                   	ret    

00000201 <exit>:
SYSCALL(exit)
 201:	b8 02 00 00 00       	mov    $0x2,%eax
 206:	cd 40                	int    $0x40
 208:	c3                   	ret    

00000209 <wait>:
SYSCALL(wait)
 209:	b8 03 00 00 00       	mov    $0x3,%eax
 20e:	cd 40                	int    $0x40
 210:	c3                   	ret    

00000211 <pipe>:
SYSCALL(pipe)
 211:	b8 04 00 00 00       	mov    $0x4,%eax
 216:	cd 40                	int    $0x40
 218:	c3                   	ret    

00000219 <read>:
SYSCALL(read)
 219:	b8 05 00 00 00       	mov    $0x5,%eax
 21e:	cd 40                	int    $0x40
 220:	c3                   	ret    

00000221 <write>:
SYSCALL(write)
 221:	b8 10 00 00 00       	mov    $0x10,%eax
 226:	cd 40                	int    $0x40
 228:	c3                   	ret    

00000229 <close>:
SYSCALL(close)
 229:	b8 15 00 00 00       	mov    $0x15,%eax
 22e:	cd 40                	int    $0x40
 230:	c3                   	ret    

00000231 <kill>:
SYSCALL(kill)
 231:	b8 06 00 00 00       	mov    $0x6,%eax
 236:	cd 40                	int    $0x40
 238:	c3                   	ret    

00000239 <exec>:
SYSCALL(exec)
 239:	b8 07 00 00 00       	mov    $0x7,%eax
 23e:	cd 40                	int    $0x40
 240:	c3                   	ret    

00000241 <open>:
SYSCALL(open)
 241:	b8 0f 00 00 00       	mov    $0xf,%eax
 246:	cd 40                	int    $0x40
 248:	c3                   	ret    

00000249 <mknod>:
SYSCALL(mknod)
 249:	b8 11 00 00 00       	mov    $0x11,%eax
 24e:	cd 40                	int    $0x40
 250:	c3                   	ret    

00000251 <unlink>:
SYSCALL(unlink)
 251:	b8 12 00 00 00       	mov    $0x12,%eax
 256:	cd 40                	int    $0x40
 258:	c3                   	ret    

00000259 <fstat>:
SYSCALL(fstat)
 259:	b8 08 00 00 00       	mov    $0x8,%eax
 25e:	cd 40                	int    $0x40
 260:	c3                   	ret    

00000261 <link>:
SYSCALL(link)
 261:	b8 13 00 00 00       	mov    $0x13,%eax
 266:	cd 40                	int    $0x40
 268:	c3                   	ret    

00000269 <mkdir>:
SYSCALL(mkdir)
 269:	b8 14 00 00 00       	mov    $0x14,%eax
 26e:	cd 40                	int    $0x40
 270:	c3                   	ret    

00000271 <chdir>:
SYSCALL(chdir)
 271:	b8 09 00 00 00       	mov    $0x9,%eax
 276:	cd 40                	int    $0x40
 278:	c3                   	ret    

00000279 <dup>:
SYSCALL(dup)
 279:	b8 0a 00 00 00       	mov    $0xa,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <getpid>:
SYSCALL(getpid)
 281:	b8 0b 00 00 00       	mov    $0xb,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <sbrk>:
SYSCALL(sbrk)
 289:	b8 0c 00 00 00       	mov    $0xc,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <sleep>:
SYSCALL(sleep)
 291:	b8 0d 00 00 00       	mov    $0xd,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <uptime>:
SYSCALL(uptime)
 299:	b8 0e 00 00 00       	mov    $0xe,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <date>:
SYSCALL(date)
 2a1:	b8 16 00 00 00       	mov    $0x16,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <dup2>:
SYSCALL(dup2)
 2a9:	b8 17 00 00 00       	mov    $0x17,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	83 ec 1c             	sub    $0x1c,%esp
 2b7:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2ba:	6a 01                	push   $0x1
 2bc:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2bf:	52                   	push   %edx
 2c0:	50                   	push   %eax
 2c1:	e8 5b ff ff ff       	call   221 <write>
}
 2c6:	83 c4 10             	add    $0x10,%esp
 2c9:	c9                   	leave  
 2ca:	c3                   	ret    

000002cb <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2cb:	55                   	push   %ebp
 2cc:	89 e5                	mov    %esp,%ebp
 2ce:	57                   	push   %edi
 2cf:	56                   	push   %esi
 2d0:	53                   	push   %ebx
 2d1:	83 ec 2c             	sub    $0x2c,%esp
 2d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 2d7:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2dd:	74 04                	je     2e3 <printint+0x18>
 2df:	85 d2                	test   %edx,%edx
 2e1:	78 3a                	js     31d <printint+0x52>
  neg = 0;
 2e3:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2ea:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 2ef:	89 f0                	mov    %esi,%eax
 2f1:	ba 00 00 00 00       	mov    $0x0,%edx
 2f6:	f7 f1                	div    %ecx
 2f8:	89 df                	mov    %ebx,%edi
 2fa:	43                   	inc    %ebx
 2fb:	8a 92 b8 04 00 00    	mov    0x4b8(%edx),%dl
 301:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 305:	89 f2                	mov    %esi,%edx
 307:	89 c6                	mov    %eax,%esi
 309:	39 d1                	cmp    %edx,%ecx
 30b:	76 e2                	jbe    2ef <printint+0x24>
  if(neg)
 30d:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 311:	74 22                	je     335 <printint+0x6a>
    buf[i++] = '-';
 313:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 318:	8d 5f 02             	lea    0x2(%edi),%ebx
 31b:	eb 18                	jmp    335 <printint+0x6a>
    x = -xx;
 31d:	f7 de                	neg    %esi
    neg = 1;
 31f:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 326:	eb c2                	jmp    2ea <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 328:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 32d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 330:	e8 7c ff ff ff       	call   2b1 <putc>
  while(--i >= 0)
 335:	4b                   	dec    %ebx
 336:	79 f0                	jns    328 <printint+0x5d>
}
 338:	83 c4 2c             	add    $0x2c,%esp
 33b:	5b                   	pop    %ebx
 33c:	5e                   	pop    %esi
 33d:	5f                   	pop    %edi
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	57                   	push   %edi
 348:	56                   	push   %esi
 349:	53                   	push   %ebx
 34a:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 34d:	8d 45 10             	lea    0x10(%ebp),%eax
 350:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 353:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 358:	bb 00 00 00 00       	mov    $0x0,%ebx
 35d:	eb 12                	jmp    371 <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 35f:	89 fa                	mov    %edi,%edx
 361:	8b 45 08             	mov    0x8(%ebp),%eax
 364:	e8 48 ff ff ff       	call   2b1 <putc>
 369:	eb 05                	jmp    370 <printf+0x30>
      }
    } else if(state == '%'){
 36b:	83 fe 25             	cmp    $0x25,%esi
 36e:	74 22                	je     392 <printf+0x52>
  for(i = 0; fmt[i]; i++){
 370:	43                   	inc    %ebx
 371:	8b 45 0c             	mov    0xc(%ebp),%eax
 374:	8a 04 18             	mov    (%eax,%ebx,1),%al
 377:	84 c0                	test   %al,%al
 379:	0f 84 13 01 00 00    	je     492 <printf+0x152>
    c = fmt[i] & 0xff;
 37f:	0f be f8             	movsbl %al,%edi
 382:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 385:	85 f6                	test   %esi,%esi
 387:	75 e2                	jne    36b <printf+0x2b>
      if(c == '%'){
 389:	83 f8 25             	cmp    $0x25,%eax
 38c:	75 d1                	jne    35f <printf+0x1f>
        state = '%';
 38e:	89 c6                	mov    %eax,%esi
 390:	eb de                	jmp    370 <printf+0x30>
      if(c == 'd'){
 392:	83 f8 64             	cmp    $0x64,%eax
 395:	74 43                	je     3da <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 397:	83 f8 78             	cmp    $0x78,%eax
 39a:	74 68                	je     404 <printf+0xc4>
 39c:	83 f8 70             	cmp    $0x70,%eax
 39f:	74 63                	je     404 <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3a1:	83 f8 73             	cmp    $0x73,%eax
 3a4:	0f 84 84 00 00 00    	je     42e <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3aa:	83 f8 63             	cmp    $0x63,%eax
 3ad:	0f 84 ad 00 00 00    	je     460 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3b3:	83 f8 25             	cmp    $0x25,%eax
 3b6:	0f 84 c2 00 00 00    	je     47e <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 3bc:	ba 25 00 00 00       	mov    $0x25,%edx
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	e8 e8 fe ff ff       	call   2b1 <putc>
        putc(fd, c);
 3c9:	89 fa                	mov    %edi,%edx
 3cb:	8b 45 08             	mov    0x8(%ebp),%eax
 3ce:	e8 de fe ff ff       	call   2b1 <putc>
      }
      state = 0;
 3d3:	be 00 00 00 00       	mov    $0x0,%esi
 3d8:	eb 96                	jmp    370 <printf+0x30>
        printint(fd, *ap, 10, 1);
 3da:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3dd:	8b 17                	mov    (%edi),%edx
 3df:	83 ec 0c             	sub    $0xc,%esp
 3e2:	6a 01                	push   $0x1
 3e4:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ec:	e8 da fe ff ff       	call   2cb <printint>
        ap++;
 3f1:	83 c7 04             	add    $0x4,%edi
 3f4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3f7:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3fa:	be 00 00 00 00       	mov    $0x0,%esi
 3ff:	e9 6c ff ff ff       	jmp    370 <printf+0x30>
        printint(fd, *ap, 16, 0);
 404:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 407:	8b 17                	mov    (%edi),%edx
 409:	83 ec 0c             	sub    $0xc,%esp
 40c:	6a 00                	push   $0x0
 40e:	b9 10 00 00 00       	mov    $0x10,%ecx
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	e8 b0 fe ff ff       	call   2cb <printint>
        ap++;
 41b:	83 c7 04             	add    $0x4,%edi
 41e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 421:	83 c4 10             	add    $0x10,%esp
      state = 0;
 424:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 429:	e9 42 ff ff ff       	jmp    370 <printf+0x30>
        s = (char*)*ap;
 42e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 431:	8b 30                	mov    (%eax),%esi
        ap++;
 433:	83 c0 04             	add    $0x4,%eax
 436:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 439:	85 f6                	test   %esi,%esi
 43b:	75 13                	jne    450 <printf+0x110>
          s = "(null)";
 43d:	be b0 04 00 00       	mov    $0x4b0,%esi
 442:	eb 0c                	jmp    450 <printf+0x110>
          putc(fd, *s);
 444:	0f be d2             	movsbl %dl,%edx
 447:	8b 45 08             	mov    0x8(%ebp),%eax
 44a:	e8 62 fe ff ff       	call   2b1 <putc>
          s++;
 44f:	46                   	inc    %esi
        while(*s != 0){
 450:	8a 16                	mov    (%esi),%dl
 452:	84 d2                	test   %dl,%dl
 454:	75 ee                	jne    444 <printf+0x104>
      state = 0;
 456:	be 00 00 00 00       	mov    $0x0,%esi
 45b:	e9 10 ff ff ff       	jmp    370 <printf+0x30>
        putc(fd, *ap);
 460:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 463:	0f be 17             	movsbl (%edi),%edx
 466:	8b 45 08             	mov    0x8(%ebp),%eax
 469:	e8 43 fe ff ff       	call   2b1 <putc>
        ap++;
 46e:	83 c7 04             	add    $0x4,%edi
 471:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 474:	be 00 00 00 00       	mov    $0x0,%esi
 479:	e9 f2 fe ff ff       	jmp    370 <printf+0x30>
        putc(fd, c);
 47e:	89 fa                	mov    %edi,%edx
 480:	8b 45 08             	mov    0x8(%ebp),%eax
 483:	e8 29 fe ff ff       	call   2b1 <putc>
      state = 0;
 488:	be 00 00 00 00       	mov    $0x0,%esi
 48d:	e9 de fe ff ff       	jmp    370 <printf+0x30>
    }
  }
}
 492:	8d 65 f4             	lea    -0xc(%ebp),%esp
 495:	5b                   	pop    %ebx
 496:	5e                   	pop    %esi
 497:	5f                   	pop    %edi
 498:	5d                   	pop    %ebp
 499:	c3                   	ret    
