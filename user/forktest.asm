
forktest:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	53                   	push   %ebx
   8:	83 ec 10             	sub    $0x10,%esp
   b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   e:	53                   	push   %ebx
   f:	e8 2a 01 00 00       	call   13e <strlen>
  14:	83 c4 0c             	add    $0xc,%esp
  17:	50                   	push   %eax
  18:	53                   	push   %ebx
  19:	ff 75 08             	pushl  0x8(%ebp)
  1c:	e8 94 02 00 00       	call   2b5 <write>
}
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	f3 0f 1e fb          	endbr32 
  2d:	55                   	push   %ebp
  2e:	89 e5                	mov    %esp,%ebp
  30:	53                   	push   %ebx
  31:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
  34:	68 48 03 00 00       	push   $0x348
  39:	6a 01                	push   $0x1
  3b:	e8 c0 ff ff ff       	call   0 <printf>

  for(n=0; n<N; n++){
  40:	83 c4 10             	add    $0x10,%esp
  43:	bb 00 00 00 00       	mov    $0x0,%ebx
  48:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
  4e:	7f 13                	jg     63 <forktest+0x3a>
    pid = fork();
  50:	e8 38 02 00 00       	call   28d <fork>
    if(pid < 0)
  55:	85 c0                	test   %eax,%eax
  57:	78 0a                	js     63 <forktest+0x3a>
      break;
    if(pid == 0)
  59:	74 03                	je     5e <forktest+0x35>
  for(n=0; n<N; n++){
  5b:	43                   	inc    %ebx
  5c:	eb ea                	jmp    48 <forktest+0x1f>
      exit();
  5e:	e8 32 02 00 00       	call   295 <exit>
  }

  if(n == N){
  63:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  69:	74 10                	je     7b <forktest+0x52>
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  6b:	85 db                	test   %ebx,%ebx
  6d:	7e 39                	jle    a8 <forktest+0x7f>
    if(wait() < 0){
  6f:	e8 29 02 00 00       	call   29d <wait>
  74:	85 c0                	test   %eax,%eax
  76:	78 1c                	js     94 <forktest+0x6b>
  for(; n > 0; n--){
  78:	4b                   	dec    %ebx
  79:	eb f0                	jmp    6b <forktest+0x42>
    printf(1, "fork claimed to work N times!\n", N);
  7b:	83 ec 04             	sub    $0x4,%esp
  7e:	68 e8 03 00 00       	push   $0x3e8
  83:	68 88 03 00 00       	push   $0x388
  88:	6a 01                	push   $0x1
  8a:	e8 71 ff ff ff       	call   0 <printf>
    exit();
  8f:	e8 01 02 00 00       	call   295 <exit>
      printf(1, "wait stopped early\n");
  94:	83 ec 08             	sub    $0x8,%esp
  97:	68 53 03 00 00       	push   $0x353
  9c:	6a 01                	push   $0x1
  9e:	e8 5d ff ff ff       	call   0 <printf>
      exit();
  a3:	e8 ed 01 00 00       	call   295 <exit>
    }
  }

  if(wait() != -1){
  a8:	e8 f0 01 00 00       	call   29d <wait>
  ad:	83 f8 ff             	cmp    $0xffffffff,%eax
  b0:	75 17                	jne    c9 <forktest+0xa0>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
  b2:	83 ec 08             	sub    $0x8,%esp
  b5:	68 7a 03 00 00       	push   $0x37a
  ba:	6a 01                	push   $0x1
  bc:	e8 3f ff ff ff       	call   0 <printf>
}
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c7:	c9                   	leave  
  c8:	c3                   	ret    
    printf(1, "wait got too many\n");
  c9:	83 ec 08             	sub    $0x8,%esp
  cc:	68 67 03 00 00       	push   $0x367
  d1:	6a 01                	push   $0x1
  d3:	e8 28 ff ff ff       	call   0 <printf>
    exit();
  d8:	e8 b8 01 00 00       	call   295 <exit>

000000dd <main>:

int
main(void)
{
  dd:	f3 0f 1e fb          	endbr32 
  e1:	55                   	push   %ebp
  e2:	89 e5                	mov    %esp,%ebp
  e4:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
  e7:	e8 3d ff ff ff       	call   29 <forktest>
  exit();
  ec:	e8 a4 01 00 00       	call   295 <exit>

000000f1 <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
  f1:	f3 0f 1e fb          	endbr32 
}
  f5:	c3                   	ret    

000000f6 <strcpy>:

char*
strcpy(char *s, const char *t)
{
  f6:	f3 0f 1e fb          	endbr32 
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	56                   	push   %esi
  fe:	53                   	push   %ebx
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 105:	89 c2                	mov    %eax,%edx
 107:	89 cb                	mov    %ecx,%ebx
 109:	41                   	inc    %ecx
 10a:	89 d6                	mov    %edx,%esi
 10c:	42                   	inc    %edx
 10d:	8a 1b                	mov    (%ebx),%bl
 10f:	88 1e                	mov    %bl,(%esi)
 111:	84 db                	test   %bl,%bl
 113:	75 f2                	jne    107 <strcpy+0x11>
    ;
  return os;
}
 115:	5b                   	pop    %ebx
 116:	5e                   	pop    %esi
 117:	5d                   	pop    %ebp
 118:	c3                   	ret    

00000119 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 119:	f3 0f 1e fb          	endbr32 
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	8b 4d 08             	mov    0x8(%ebp),%ecx
 123:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 126:	8a 01                	mov    (%ecx),%al
 128:	84 c0                	test   %al,%al
 12a:	74 08                	je     134 <strcmp+0x1b>
 12c:	3a 02                	cmp    (%edx),%al
 12e:	75 04                	jne    134 <strcmp+0x1b>
    p++, q++;
 130:	41                   	inc    %ecx
 131:	42                   	inc    %edx
 132:	eb f2                	jmp    126 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 134:	0f b6 c0             	movzbl %al,%eax
 137:	0f b6 12             	movzbl (%edx),%edx
 13a:	29 d0                	sub    %edx,%eax
}
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    

0000013e <strlen>:

uint
strlen(const char *s)
{
 13e:	f3 0f 1e fb          	endbr32 
 142:	55                   	push   %ebp
 143:	89 e5                	mov    %esp,%ebp
 145:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 148:	b8 00 00 00 00       	mov    $0x0,%eax
 14d:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 151:	74 03                	je     156 <strlen+0x18>
 153:	40                   	inc    %eax
 154:	eb f7                	jmp    14d <strlen+0xf>
    ;
  return n;
}
 156:	5d                   	pop    %ebp
 157:	c3                   	ret    

00000158 <memset>:

void*
memset(void *dst, int c, uint n)
{
 158:	f3 0f 1e fb          	endbr32 
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 160:	8b 7d 08             	mov    0x8(%ebp),%edi
 163:	8b 4d 10             	mov    0x10(%ebp),%ecx
 166:	8b 45 0c             	mov    0xc(%ebp),%eax
 169:	fc                   	cld    
 16a:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	5f                   	pop    %edi
 170:	5d                   	pop    %ebp
 171:	c3                   	ret    

00000172 <strchr>:

char*
strchr(const char *s, char c)
{
 172:	f3 0f 1e fb          	endbr32 
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
 179:	8b 45 08             	mov    0x8(%ebp),%eax
 17c:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 17f:	8a 10                	mov    (%eax),%dl
 181:	84 d2                	test   %dl,%dl
 183:	74 07                	je     18c <strchr+0x1a>
    if(*s == c)
 185:	38 ca                	cmp    %cl,%dl
 187:	74 08                	je     191 <strchr+0x1f>
  for(; *s; s++)
 189:	40                   	inc    %eax
 18a:	eb f3                	jmp    17f <strchr+0xd>
      return (char*)s;
  return 0;
 18c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    

00000193 <gets>:

char*
gets(char *buf, int max)
{
 193:	f3 0f 1e fb          	endbr32 
 197:	55                   	push   %ebp
 198:	89 e5                	mov    %esp,%ebp
 19a:	57                   	push   %edi
 19b:	56                   	push   %esi
 19c:	53                   	push   %ebx
 19d:	83 ec 1c             	sub    $0x1c,%esp
 1a0:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a3:	bb 00 00 00 00       	mov    $0x0,%ebx
 1a8:	89 de                	mov    %ebx,%esi
 1aa:	43                   	inc    %ebx
 1ab:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ae:	7d 2b                	jge    1db <gets+0x48>
    cc = read(0, &c, 1);
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1b8:	50                   	push   %eax
 1b9:	6a 00                	push   $0x0
 1bb:	e8 ed 00 00 00       	call   2ad <read>
    if(cc < 1)
 1c0:	83 c4 10             	add    $0x10,%esp
 1c3:	85 c0                	test   %eax,%eax
 1c5:	7e 14                	jle    1db <gets+0x48>
      break;
    buf[i++] = c;
 1c7:	8a 45 e7             	mov    -0x19(%ebp),%al
 1ca:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 08                	je     1d9 <gets+0x46>
 1d1:	3c 0d                	cmp    $0xd,%al
 1d3:	75 d3                	jne    1a8 <gets+0x15>
    buf[i++] = c;
 1d5:	89 de                	mov    %ebx,%esi
 1d7:	eb 02                	jmp    1db <gets+0x48>
 1d9:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1db:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1df:	89 f8                	mov    %edi,%eax
 1e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	5f                   	pop    %edi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    

000001e9 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e9:	f3 0f 1e fb          	endbr32 
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
 1f0:	56                   	push   %esi
 1f1:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	6a 00                	push   $0x0
 1f7:	ff 75 08             	pushl  0x8(%ebp)
 1fa:	e8 d6 00 00 00       	call   2d5 <open>
  if(fd < 0)
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	85 c0                	test   %eax,%eax
 204:	78 24                	js     22a <stat+0x41>
 206:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 208:	83 ec 08             	sub    $0x8,%esp
 20b:	ff 75 0c             	pushl  0xc(%ebp)
 20e:	50                   	push   %eax
 20f:	e8 d9 00 00 00       	call   2ed <fstat>
 214:	89 c6                	mov    %eax,%esi
  close(fd);
 216:	89 1c 24             	mov    %ebx,(%esp)
 219:	e8 9f 00 00 00       	call   2bd <close>
  return r;
 21e:	83 c4 10             	add    $0x10,%esp
}
 221:	89 f0                	mov    %esi,%eax
 223:	8d 65 f8             	lea    -0x8(%ebp),%esp
 226:	5b                   	pop    %ebx
 227:	5e                   	pop    %esi
 228:	5d                   	pop    %ebp
 229:	c3                   	ret    
    return -1;
 22a:	be ff ff ff ff       	mov    $0xffffffff,%esi
 22f:	eb f0                	jmp    221 <stat+0x38>

00000231 <atoi>:

int
atoi(const char *s)
{
 231:	f3 0f 1e fb          	endbr32 
 235:	55                   	push   %ebp
 236:	89 e5                	mov    %esp,%ebp
 238:	53                   	push   %ebx
 239:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 23c:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 241:	8a 01                	mov    (%ecx),%al
 243:	8d 58 d0             	lea    -0x30(%eax),%ebx
 246:	80 fb 09             	cmp    $0x9,%bl
 249:	77 10                	ja     25b <atoi+0x2a>
    n = n*10 + *s++ - '0';
 24b:	8d 14 92             	lea    (%edx,%edx,4),%edx
 24e:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 251:	41                   	inc    %ecx
 252:	0f be c0             	movsbl %al,%eax
 255:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
 259:	eb e6                	jmp    241 <atoi+0x10>
  return n;
}
 25b:	89 d0                	mov    %edx,%eax
 25d:	5b                   	pop    %ebx
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	56                   	push   %esi
 268:	53                   	push   %ebx
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 26f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 272:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 274:	8d 72 ff             	lea    -0x1(%edx),%esi
 277:	85 d2                	test   %edx,%edx
 279:	7e 0e                	jle    289 <memmove+0x29>
    *dst++ = *src++;
 27b:	8a 13                	mov    (%ebx),%dl
 27d:	88 11                	mov    %dl,(%ecx)
 27f:	8d 5b 01             	lea    0x1(%ebx),%ebx
 282:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 285:	89 f2                	mov    %esi,%edx
 287:	eb eb                	jmp    274 <memmove+0x14>
  return vdst;
}
 289:	5b                   	pop    %ebx
 28a:	5e                   	pop    %esi
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret    

0000028d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28d:	b8 01 00 00 00       	mov    $0x1,%eax
 292:	cd 40                	int    $0x40
 294:	c3                   	ret    

00000295 <exit>:
SYSCALL(exit)
 295:	b8 02 00 00 00       	mov    $0x2,%eax
 29a:	cd 40                	int    $0x40
 29c:	c3                   	ret    

0000029d <wait>:
SYSCALL(wait)
 29d:	b8 03 00 00 00       	mov    $0x3,%eax
 2a2:	cd 40                	int    $0x40
 2a4:	c3                   	ret    

000002a5 <pipe>:
SYSCALL(pipe)
 2a5:	b8 04 00 00 00       	mov    $0x4,%eax
 2aa:	cd 40                	int    $0x40
 2ac:	c3                   	ret    

000002ad <read>:
SYSCALL(read)
 2ad:	b8 05 00 00 00       	mov    $0x5,%eax
 2b2:	cd 40                	int    $0x40
 2b4:	c3                   	ret    

000002b5 <write>:
SYSCALL(write)
 2b5:	b8 10 00 00 00       	mov    $0x10,%eax
 2ba:	cd 40                	int    $0x40
 2bc:	c3                   	ret    

000002bd <close>:
SYSCALL(close)
 2bd:	b8 15 00 00 00       	mov    $0x15,%eax
 2c2:	cd 40                	int    $0x40
 2c4:	c3                   	ret    

000002c5 <kill>:
SYSCALL(kill)
 2c5:	b8 06 00 00 00       	mov    $0x6,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <exec>:
SYSCALL(exec)
 2cd:	b8 07 00 00 00       	mov    $0x7,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <open>:
SYSCALL(open)
 2d5:	b8 0f 00 00 00       	mov    $0xf,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <mknod>:
SYSCALL(mknod)
 2dd:	b8 11 00 00 00       	mov    $0x11,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <unlink>:
SYSCALL(unlink)
 2e5:	b8 12 00 00 00       	mov    $0x12,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <fstat>:
SYSCALL(fstat)
 2ed:	b8 08 00 00 00       	mov    $0x8,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <link>:
SYSCALL(link)
 2f5:	b8 13 00 00 00       	mov    $0x13,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <mkdir>:
SYSCALL(mkdir)
 2fd:	b8 14 00 00 00       	mov    $0x14,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <chdir>:
SYSCALL(chdir)
 305:	b8 09 00 00 00       	mov    $0x9,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <dup>:
SYSCALL(dup)
 30d:	b8 0a 00 00 00       	mov    $0xa,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <getpid>:
SYSCALL(getpid)
 315:	b8 0b 00 00 00       	mov    $0xb,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <sbrk>:
SYSCALL(sbrk)
 31d:	b8 0c 00 00 00       	mov    $0xc,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <sleep>:
SYSCALL(sleep)
 325:	b8 0d 00 00 00       	mov    $0xd,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <uptime>:
SYSCALL(uptime)
 32d:	b8 0e 00 00 00       	mov    $0xe,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <date>:
SYSCALL(date)
 335:	b8 16 00 00 00       	mov    $0x16,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <dup2>:
SYSCALL(dup2)
 33d:	b8 17 00 00 00       	mov    $0x17,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    
