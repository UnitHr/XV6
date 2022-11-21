
forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 10             	sub    $0x10,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	53                   	push   %ebx
   b:	e8 50 01 00 00       	call   160 <strlen>
  10:	83 c4 0c             	add    $0xc,%esp
  13:	50                   	push   %eax
  14:	53                   	push   %ebx
  15:	ff 75 08             	push   0x8(%ebp)
  18:	e8 a4 02 00 00       	call   2c1 <write>
}
  1d:	83 c4 10             	add    $0x10,%esp
  20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  23:	c9                   	leave  
  24:	c3                   	ret    

00000025 <forktest>:

void
forktest(void)
{
  25:	55                   	push   %ebp
  26:	89 e5                	mov    %esp,%ebp
  28:	53                   	push   %ebx
  29:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
  2c:	68 54 03 00 00       	push   $0x354
  31:	6a 01                	push   $0x1
  33:	e8 c8 ff ff ff       	call   0 <printf>

  for(n=0; n<N; n++){
  38:	83 c4 10             	add    $0x10,%esp
  3b:	bb 00 00 00 00       	mov    $0x0,%ebx
  40:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
  46:	7f 18                	jg     60 <forktest+0x3b>
    pid = fork();
  48:	e8 4c 02 00 00       	call   299 <fork>
    if(pid < 0)
  4d:	85 c0                	test   %eax,%eax
  4f:	78 0f                	js     60 <forktest+0x3b>
      break;
    if(pid == 0)
  51:	74 03                	je     56 <forktest+0x31>
  for(n=0; n<N; n++){
  53:	43                   	inc    %ebx
  54:	eb ea                	jmp    40 <forktest+0x1b>
      exit(0);
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	6a 00                	push   $0x0
  5b:	e8 41 02 00 00       	call   2a1 <exit>
  }

  if(n == N){
  60:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  66:	74 18                	je     80 <forktest+0x5b>
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  68:	85 db                	test   %ebx,%ebx
  6a:	7e 4f                	jle    bb <forktest+0x96>
    if(wait(NULL) < 0){
  6c:	83 ec 0c             	sub    $0xc,%esp
  6f:	6a 00                	push   $0x0
  71:	e8 33 02 00 00       	call   2a9 <wait>
  76:	83 c4 10             	add    $0x10,%esp
  79:	85 c0                	test   %eax,%eax
  7b:	78 23                	js     a0 <forktest+0x7b>
  for(; n > 0; n--){
  7d:	4b                   	dec    %ebx
  7e:	eb e8                	jmp    68 <forktest+0x43>
    printf(1, "fork claimed to work N times!\n", N);
  80:	83 ec 04             	sub    $0x4,%esp
  83:	68 e8 03 00 00       	push   $0x3e8
  88:	68 94 03 00 00       	push   $0x394
  8d:	6a 01                	push   $0x1
  8f:	e8 6c ff ff ff       	call   0 <printf>
    exit(0);
  94:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  9b:	e8 01 02 00 00       	call   2a1 <exit>
      printf(1, "wait stopped early\n");
  a0:	83 ec 08             	sub    $0x8,%esp
  a3:	68 5f 03 00 00       	push   $0x35f
  a8:	6a 01                	push   $0x1
  aa:	e8 51 ff ff ff       	call   0 <printf>
      exit(0);
  af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b6:	e8 e6 01 00 00       	call   2a1 <exit>
    }
  }

  if(wait(NULL) != -1){
  bb:	83 ec 0c             	sub    $0xc,%esp
  be:	6a 00                	push   $0x0
  c0:	e8 e4 01 00 00       	call   2a9 <wait>
  c5:	83 c4 10             	add    $0x10,%esp
  c8:	83 f8 ff             	cmp    $0xffffffff,%eax
  cb:	75 17                	jne    e4 <forktest+0xbf>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	68 86 03 00 00       	push   $0x386
  d5:	6a 01                	push   $0x1
  d7:	e8 24 ff ff ff       	call   0 <printf>
}
  dc:	83 c4 10             	add    $0x10,%esp
  df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e2:	c9                   	leave  
  e3:	c3                   	ret    
    printf(1, "wait got too many\n");
  e4:	83 ec 08             	sub    $0x8,%esp
  e7:	68 73 03 00 00       	push   $0x373
  ec:	6a 01                	push   $0x1
  ee:	e8 0d ff ff ff       	call   0 <printf>
    exit(0);
  f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  fa:	e8 a2 01 00 00       	call   2a1 <exit>

000000ff <main>:

int
main(void)
{
  ff:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 103:	83 e4 f0             	and    $0xfffffff0,%esp
 106:	ff 71 fc             	push   -0x4(%ecx)
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	51                   	push   %ecx
 10d:	83 ec 04             	sub    $0x4,%esp
  forktest();
 110:	e8 10 ff ff ff       	call   25 <forktest>
  exit(0);
 115:	83 ec 0c             	sub    $0xc,%esp
 118:	6a 00                	push   $0x0
 11a:	e8 82 01 00 00       	call   2a1 <exit>

0000011f <start>:

// Entry point of the library	
void
start()
{
}
 11f:	c3                   	ret    

00000120 <strcpy>:

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	56                   	push   %esi
 124:	53                   	push   %ebx
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12b:	89 c2                	mov    %eax,%edx
 12d:	89 cb                	mov    %ecx,%ebx
 12f:	41                   	inc    %ecx
 130:	89 d6                	mov    %edx,%esi
 132:	42                   	inc    %edx
 133:	8a 1b                	mov    (%ebx),%bl
 135:	88 1e                	mov    %bl,(%esi)
 137:	84 db                	test   %bl,%bl
 139:	75 f2                	jne    12d <strcpy+0xd>
    ;
  return os;
}
 13b:	5b                   	pop    %ebx
 13c:	5e                   	pop    %esi
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret    

0000013f <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13f:	55                   	push   %ebp
 140:	89 e5                	mov    %esp,%ebp
 142:	8b 4d 08             	mov    0x8(%ebp),%ecx
 145:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 148:	eb 02                	jmp    14c <strcmp+0xd>
    p++, q++;
 14a:	41                   	inc    %ecx
 14b:	42                   	inc    %edx
  while(*p && *p == *q)
 14c:	8a 01                	mov    (%ecx),%al
 14e:	84 c0                	test   %al,%al
 150:	74 04                	je     156 <strcmp+0x17>
 152:	3a 02                	cmp    (%edx),%al
 154:	74 f4                	je     14a <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 156:	0f b6 c0             	movzbl %al,%eax
 159:	0f b6 12             	movzbl (%edx),%edx
 15c:	29 d0                	sub    %edx,%eax
}
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 166:	b8 00 00 00 00       	mov    $0x0,%eax
 16b:	eb 01                	jmp    16e <strlen+0xe>
 16d:	40                   	inc    %eax
 16e:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 172:	75 f9                	jne    16d <strlen+0xd>
    ;
  return n;
}
 174:	5d                   	pop    %ebp
 175:	c3                   	ret    

00000176 <memset>:

void*
memset(void *dst, int c, uint n)
{
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
 179:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 17a:	8b 7d 08             	mov    0x8(%ebp),%edi
 17d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 180:	8b 45 0c             	mov    0xc(%ebp),%eax
 183:	fc                   	cld    
 184:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	8b 7d fc             	mov    -0x4(%ebp),%edi
 18c:	c9                   	leave  
 18d:	c3                   	ret    

0000018e <strchr>:

char*
strchr(const char *s, char c)
{
 18e:	55                   	push   %ebp
 18f:	89 e5                	mov    %esp,%ebp
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 197:	eb 01                	jmp    19a <strchr+0xc>
 199:	40                   	inc    %eax
 19a:	8a 10                	mov    (%eax),%dl
 19c:	84 d2                	test   %dl,%dl
 19e:	74 06                	je     1a6 <strchr+0x18>
    if(*s == c)
 1a0:	38 ca                	cmp    %cl,%dl
 1a2:	75 f5                	jne    199 <strchr+0xb>
 1a4:	eb 05                	jmp    1ab <strchr+0x1d>
      return (char*)s;
  return 0;
 1a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    

000001ad <gets>:

char*
gets(char *buf, int max)
{
 1ad:	55                   	push   %ebp
 1ae:	89 e5                	mov    %esp,%ebp
 1b0:	57                   	push   %edi
 1b1:	56                   	push   %esi
 1b2:	53                   	push   %ebx
 1b3:	83 ec 1c             	sub    $0x1c,%esp
 1b6:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b9:	bb 00 00 00 00       	mov    $0x0,%ebx
 1be:	89 de                	mov    %ebx,%esi
 1c0:	43                   	inc    %ebx
 1c1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c4:	7d 2b                	jge    1f1 <gets+0x44>
    cc = read(0, &c, 1);
 1c6:	83 ec 04             	sub    $0x4,%esp
 1c9:	6a 01                	push   $0x1
 1cb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ce:	50                   	push   %eax
 1cf:	6a 00                	push   $0x0
 1d1:	e8 e3 00 00 00       	call   2b9 <read>
    if(cc < 1)
 1d6:	83 c4 10             	add    $0x10,%esp
 1d9:	85 c0                	test   %eax,%eax
 1db:	7e 14                	jle    1f1 <gets+0x44>
      break;
    buf[i++] = c;
 1dd:	8a 45 e7             	mov    -0x19(%ebp),%al
 1e0:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1e3:	3c 0a                	cmp    $0xa,%al
 1e5:	74 08                	je     1ef <gets+0x42>
 1e7:	3c 0d                	cmp    $0xd,%al
 1e9:	75 d3                	jne    1be <gets+0x11>
    buf[i++] = c;
 1eb:	89 de                	mov    %ebx,%esi
 1ed:	eb 02                	jmp    1f1 <gets+0x44>
 1ef:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1f1:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1f5:	89 f8                	mov    %edi,%eax
 1f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fa:	5b                   	pop    %ebx
 1fb:	5e                   	pop    %esi
 1fc:	5f                   	pop    %edi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    

000001ff <stat>:

int
stat(const char *n, struct stat *st)
{
 1ff:	55                   	push   %ebp
 200:	89 e5                	mov    %esp,%ebp
 202:	56                   	push   %esi
 203:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 204:	83 ec 08             	sub    $0x8,%esp
 207:	6a 00                	push   $0x0
 209:	ff 75 08             	push   0x8(%ebp)
 20c:	e8 d0 00 00 00       	call   2e1 <open>
  if(fd < 0)
 211:	83 c4 10             	add    $0x10,%esp
 214:	85 c0                	test   %eax,%eax
 216:	78 24                	js     23c <stat+0x3d>
 218:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 21a:	83 ec 08             	sub    $0x8,%esp
 21d:	ff 75 0c             	push   0xc(%ebp)
 220:	50                   	push   %eax
 221:	e8 d3 00 00 00       	call   2f9 <fstat>
 226:	89 c6                	mov    %eax,%esi
  close(fd);
 228:	89 1c 24             	mov    %ebx,(%esp)
 22b:	e8 99 00 00 00       	call   2c9 <close>
  return r;
 230:	83 c4 10             	add    $0x10,%esp
}
 233:	89 f0                	mov    %esi,%eax
 235:	8d 65 f8             	lea    -0x8(%ebp),%esp
 238:	5b                   	pop    %ebx
 239:	5e                   	pop    %esi
 23a:	5d                   	pop    %ebp
 23b:	c3                   	ret    
    return -1;
 23c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 241:	eb f0                	jmp    233 <stat+0x34>

00000243 <atoi>:

int
atoi(const char *s)
{
 243:	55                   	push   %ebp
 244:	89 e5                	mov    %esp,%ebp
 246:	53                   	push   %ebx
 247:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 24a:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 24f:	eb 0e                	jmp    25f <atoi+0x1c>
    n = n*10 + *s++ - '0';
 251:	8d 14 92             	lea    (%edx,%edx,4),%edx
 254:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 257:	41                   	inc    %ecx
 258:	0f be c0             	movsbl %al,%eax
 25b:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
  while('0' <= *s && *s <= '9')
 25f:	8a 01                	mov    (%ecx),%al
 261:	8d 58 d0             	lea    -0x30(%eax),%ebx
 264:	80 fb 09             	cmp    $0x9,%bl
 267:	76 e8                	jbe    251 <atoi+0xe>
  return n;
}
 269:	89 d0                	mov    %edx,%eax
 26b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 26e:	c9                   	leave  
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	53                   	push   %ebx
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 27b:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 27e:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 280:	eb 0c                	jmp    28e <memmove+0x1e>
    *dst++ = *src++;
 282:	8a 13                	mov    (%ebx),%dl
 284:	88 11                	mov    %dl,(%ecx)
 286:	8d 5b 01             	lea    0x1(%ebx),%ebx
 289:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 28c:	89 f2                	mov    %esi,%edx
 28e:	8d 72 ff             	lea    -0x1(%edx),%esi
 291:	85 d2                	test   %edx,%edx
 293:	7f ed                	jg     282 <memmove+0x12>
  return vdst;
}
 295:	5b                   	pop    %ebx
 296:	5e                   	pop    %esi
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    

00000299 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 299:	b8 01 00 00 00       	mov    $0x1,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <exit>:
SYSCALL(exit)
 2a1:	b8 02 00 00 00       	mov    $0x2,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <wait>:
SYSCALL(wait)
 2a9:	b8 03 00 00 00       	mov    $0x3,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <pipe>:
SYSCALL(pipe)
 2b1:	b8 04 00 00 00       	mov    $0x4,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <read>:
SYSCALL(read)
 2b9:	b8 05 00 00 00       	mov    $0x5,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <write>:
SYSCALL(write)
 2c1:	b8 10 00 00 00       	mov    $0x10,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <close>:
SYSCALL(close)
 2c9:	b8 15 00 00 00       	mov    $0x15,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <kill>:
SYSCALL(kill)
 2d1:	b8 06 00 00 00       	mov    $0x6,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <exec>:
SYSCALL(exec)
 2d9:	b8 07 00 00 00       	mov    $0x7,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <open>:
SYSCALL(open)
 2e1:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <mknod>:
SYSCALL(mknod)
 2e9:	b8 11 00 00 00       	mov    $0x11,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <unlink>:
SYSCALL(unlink)
 2f1:	b8 12 00 00 00       	mov    $0x12,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <fstat>:
SYSCALL(fstat)
 2f9:	b8 08 00 00 00       	mov    $0x8,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <link>:
SYSCALL(link)
 301:	b8 13 00 00 00       	mov    $0x13,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <mkdir>:
SYSCALL(mkdir)
 309:	b8 14 00 00 00       	mov    $0x14,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <chdir>:
SYSCALL(chdir)
 311:	b8 09 00 00 00       	mov    $0x9,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <dup>:
SYSCALL(dup)
 319:	b8 0a 00 00 00       	mov    $0xa,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <getpid>:
SYSCALL(getpid)
 321:	b8 0b 00 00 00       	mov    $0xb,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <sbrk>:
SYSCALL(sbrk)
 329:	b8 0c 00 00 00       	mov    $0xc,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <sleep>:
SYSCALL(sleep)
 331:	b8 0d 00 00 00       	mov    $0xd,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <uptime>:
SYSCALL(uptime)
 339:	b8 0e 00 00 00       	mov    $0xe,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <date>:
SYSCALL(date)
 341:	b8 16 00 00 00       	mov    $0x16,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <dup2>:
SYSCALL(dup2)
 349:	b8 17 00 00 00       	mov    $0x17,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    
