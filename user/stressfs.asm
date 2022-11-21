
stressfs:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

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
  15:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  1b:	8d 7d de             	lea    -0x22(%ebp),%edi
  1e:	be 77 05 00 00       	mov    $0x577,%esi
  23:	b9 0a 00 00 00       	mov    $0xa,%ecx
  28:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  2a:	68 54 05 00 00       	push   $0x554
  2f:	6a 01                	push   $0x1
  31:	e8 c3 03 00 00       	call   3f9 <printf>
  memset(data, 'a', sizeof(data));
  36:	83 c4 0c             	add    $0xc,%esp
  39:	68 00 02 00 00       	push   $0x200
  3e:	6a 61                	push   $0x61
  40:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  46:	50                   	push   %eax
  47:	e8 31 01 00 00       	call   17d <memset>

  for(i = 0; i < 4; i++)
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	bb 00 00 00 00       	mov    $0x0,%ebx
  54:	83 fb 03             	cmp    $0x3,%ebx
  57:	7f 0c                	jg     65 <main+0x65>
    if(fork() > 0)
  59:	e8 54 02 00 00       	call   2b2 <fork>
  5e:	85 c0                	test   %eax,%eax
  60:	7f 03                	jg     65 <main+0x65>
  for(i = 0; i < 4; i++)
  62:	43                   	inc    %ebx
  63:	eb ef                	jmp    54 <main+0x54>
      break;

  printf(1, "write %d\n", i);
  65:	83 ec 04             	sub    $0x4,%esp
  68:	53                   	push   %ebx
  69:	68 67 05 00 00       	push   $0x567
  6e:	6a 01                	push   $0x1
  70:	e8 84 03 00 00       	call   3f9 <printf>

  path[8] += i;
  75:	00 5d e6             	add    %bl,-0x1a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  78:	83 c4 08             	add    $0x8,%esp
  7b:	68 02 02 00 00       	push   $0x202
  80:	8d 45 de             	lea    -0x22(%ebp),%eax
  83:	50                   	push   %eax
  84:	e8 71 02 00 00       	call   2fa <open>
  89:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++)
  8b:	83 c4 10             	add    $0x10,%esp
  8e:	bb 00 00 00 00       	mov    $0x0,%ebx
  93:	eb 19                	jmp    ae <main+0xae>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  95:	83 ec 04             	sub    $0x4,%esp
  98:	68 00 02 00 00       	push   $0x200
  9d:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  a3:	50                   	push   %eax
  a4:	56                   	push   %esi
  a5:	e8 30 02 00 00       	call   2da <write>
  for(i = 0; i < 20; i++)
  aa:	43                   	inc    %ebx
  ab:	83 c4 10             	add    $0x10,%esp
  ae:	83 fb 13             	cmp    $0x13,%ebx
  b1:	7e e2                	jle    95 <main+0x95>
  close(fd);
  b3:	83 ec 0c             	sub    $0xc,%esp
  b6:	56                   	push   %esi
  b7:	e8 26 02 00 00       	call   2e2 <close>

  printf(1, "read\n");
  bc:	83 c4 08             	add    $0x8,%esp
  bf:	68 71 05 00 00       	push   $0x571
  c4:	6a 01                	push   $0x1
  c6:	e8 2e 03 00 00       	call   3f9 <printf>

  fd = open(path, O_RDONLY);
  cb:	83 c4 08             	add    $0x8,%esp
  ce:	6a 00                	push   $0x0
  d0:	8d 45 de             	lea    -0x22(%ebp),%eax
  d3:	50                   	push   %eax
  d4:	e8 21 02 00 00       	call   2fa <open>
  d9:	89 c6                	mov    %eax,%esi
  for (i = 0; i < 20; i++)
  db:	83 c4 10             	add    $0x10,%esp
  de:	bb 00 00 00 00       	mov    $0x0,%ebx
  e3:	eb 19                	jmp    fe <main+0xfe>
    read(fd, data, sizeof(data));
  e5:	83 ec 04             	sub    $0x4,%esp
  e8:	68 00 02 00 00       	push   $0x200
  ed:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  f3:	50                   	push   %eax
  f4:	56                   	push   %esi
  f5:	e8 d8 01 00 00       	call   2d2 <read>
  for (i = 0; i < 20; i++)
  fa:	43                   	inc    %ebx
  fb:	83 c4 10             	add    $0x10,%esp
  fe:	83 fb 13             	cmp    $0x13,%ebx
 101:	7e e2                	jle    e5 <main+0xe5>
  close(fd);
 103:	83 ec 0c             	sub    $0xc,%esp
 106:	56                   	push   %esi
 107:	e8 d6 01 00 00       	call   2e2 <close>

  wait();
 10c:	e8 b1 01 00 00       	call   2c2 <wait>

  exit();
 111:	e8 a4 01 00 00       	call   2ba <exit>

00000116 <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
 116:	f3 0f 1e fb          	endbr32 
}
 11a:	c3                   	ret    

0000011b <strcpy>:

char*
strcpy(char *s, const char *t)
{
 11b:	f3 0f 1e fb          	endbr32 
 11f:	55                   	push   %ebp
 120:	89 e5                	mov    %esp,%ebp
 122:	56                   	push   %esi
 123:	53                   	push   %ebx
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12a:	89 c2                	mov    %eax,%edx
 12c:	89 cb                	mov    %ecx,%ebx
 12e:	41                   	inc    %ecx
 12f:	89 d6                	mov    %edx,%esi
 131:	42                   	inc    %edx
 132:	8a 1b                	mov    (%ebx),%bl
 134:	88 1e                	mov    %bl,(%esi)
 136:	84 db                	test   %bl,%bl
 138:	75 f2                	jne    12c <strcpy+0x11>
    ;
  return os;
}
 13a:	5b                   	pop    %ebx
 13b:	5e                   	pop    %esi
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    

0000013e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13e:	f3 0f 1e fb          	endbr32 
 142:	55                   	push   %ebp
 143:	89 e5                	mov    %esp,%ebp
 145:	8b 4d 08             	mov    0x8(%ebp),%ecx
 148:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 14b:	8a 01                	mov    (%ecx),%al
 14d:	84 c0                	test   %al,%al
 14f:	74 08                	je     159 <strcmp+0x1b>
 151:	3a 02                	cmp    (%edx),%al
 153:	75 04                	jne    159 <strcmp+0x1b>
    p++, q++;
 155:	41                   	inc    %ecx
 156:	42                   	inc    %edx
 157:	eb f2                	jmp    14b <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 159:	0f b6 c0             	movzbl %al,%eax
 15c:	0f b6 12             	movzbl (%edx),%edx
 15f:	29 d0                	sub    %edx,%eax
}
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    

00000163 <strlen>:

uint
strlen(const char *s)
{
 163:	f3 0f 1e fb          	endbr32 
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 16d:	b8 00 00 00 00       	mov    $0x0,%eax
 172:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 176:	74 03                	je     17b <strlen+0x18>
 178:	40                   	inc    %eax
 179:	eb f7                	jmp    172 <strlen+0xf>
    ;
  return n;
}
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    

0000017d <memset>:

void*
memset(void *dst, int c, uint n)
{
 17d:	f3 0f 1e fb          	endbr32 
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 185:	8b 7d 08             	mov    0x8(%ebp),%edi
 188:	8b 4d 10             	mov    0x10(%ebp),%ecx
 18b:	8b 45 0c             	mov    0xc(%ebp),%eax
 18e:	fc                   	cld    
 18f:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	5f                   	pop    %edi
 195:	5d                   	pop    %ebp
 196:	c3                   	ret    

00000197 <strchr>:

char*
strchr(const char *s, char c)
{
 197:	f3 0f 1e fb          	endbr32 
 19b:	55                   	push   %ebp
 19c:	89 e5                	mov    %esp,%ebp
 19e:	8b 45 08             	mov    0x8(%ebp),%eax
 1a1:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1a4:	8a 10                	mov    (%eax),%dl
 1a6:	84 d2                	test   %dl,%dl
 1a8:	74 07                	je     1b1 <strchr+0x1a>
    if(*s == c)
 1aa:	38 ca                	cmp    %cl,%dl
 1ac:	74 08                	je     1b6 <strchr+0x1f>
  for(; *s; s++)
 1ae:	40                   	inc    %eax
 1af:	eb f3                	jmp    1a4 <strchr+0xd>
      return (char*)s;
  return 0;
 1b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b6:	5d                   	pop    %ebp
 1b7:	c3                   	ret    

000001b8 <gets>:

char*
gets(char *buf, int max)
{
 1b8:	f3 0f 1e fb          	endbr32 
 1bc:	55                   	push   %ebp
 1bd:	89 e5                	mov    %esp,%ebp
 1bf:	57                   	push   %edi
 1c0:	56                   	push   %esi
 1c1:	53                   	push   %ebx
 1c2:	83 ec 1c             	sub    $0x1c,%esp
 1c5:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c8:	bb 00 00 00 00       	mov    $0x0,%ebx
 1cd:	89 de                	mov    %ebx,%esi
 1cf:	43                   	inc    %ebx
 1d0:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d3:	7d 2b                	jge    200 <gets+0x48>
    cc = read(0, &c, 1);
 1d5:	83 ec 04             	sub    $0x4,%esp
 1d8:	6a 01                	push   $0x1
 1da:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1dd:	50                   	push   %eax
 1de:	6a 00                	push   $0x0
 1e0:	e8 ed 00 00 00       	call   2d2 <read>
    if(cc < 1)
 1e5:	83 c4 10             	add    $0x10,%esp
 1e8:	85 c0                	test   %eax,%eax
 1ea:	7e 14                	jle    200 <gets+0x48>
      break;
    buf[i++] = c;
 1ec:	8a 45 e7             	mov    -0x19(%ebp),%al
 1ef:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1f2:	3c 0a                	cmp    $0xa,%al
 1f4:	74 08                	je     1fe <gets+0x46>
 1f6:	3c 0d                	cmp    $0xd,%al
 1f8:	75 d3                	jne    1cd <gets+0x15>
    buf[i++] = c;
 1fa:	89 de                	mov    %ebx,%esi
 1fc:	eb 02                	jmp    200 <gets+0x48>
 1fe:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 200:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 204:	89 f8                	mov    %edi,%eax
 206:	8d 65 f4             	lea    -0xc(%ebp),%esp
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5f                   	pop    %edi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    

0000020e <stat>:

int
stat(const char *n, struct stat *st)
{
 20e:	f3 0f 1e fb          	endbr32 
 212:	55                   	push   %ebp
 213:	89 e5                	mov    %esp,%ebp
 215:	56                   	push   %esi
 216:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 217:	83 ec 08             	sub    $0x8,%esp
 21a:	6a 00                	push   $0x0
 21c:	ff 75 08             	pushl  0x8(%ebp)
 21f:	e8 d6 00 00 00       	call   2fa <open>
  if(fd < 0)
 224:	83 c4 10             	add    $0x10,%esp
 227:	85 c0                	test   %eax,%eax
 229:	78 24                	js     24f <stat+0x41>
 22b:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 22d:	83 ec 08             	sub    $0x8,%esp
 230:	ff 75 0c             	pushl  0xc(%ebp)
 233:	50                   	push   %eax
 234:	e8 d9 00 00 00       	call   312 <fstat>
 239:	89 c6                	mov    %eax,%esi
  close(fd);
 23b:	89 1c 24             	mov    %ebx,(%esp)
 23e:	e8 9f 00 00 00       	call   2e2 <close>
  return r;
 243:	83 c4 10             	add    $0x10,%esp
}
 246:	89 f0                	mov    %esi,%eax
 248:	8d 65 f8             	lea    -0x8(%ebp),%esp
 24b:	5b                   	pop    %ebx
 24c:	5e                   	pop    %esi
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
    return -1;
 24f:	be ff ff ff ff       	mov    $0xffffffff,%esi
 254:	eb f0                	jmp    246 <stat+0x38>

00000256 <atoi>:

int
atoi(const char *s)
{
 256:	f3 0f 1e fb          	endbr32 
 25a:	55                   	push   %ebp
 25b:	89 e5                	mov    %esp,%ebp
 25d:	53                   	push   %ebx
 25e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 261:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 266:	8a 01                	mov    (%ecx),%al
 268:	8d 58 d0             	lea    -0x30(%eax),%ebx
 26b:	80 fb 09             	cmp    $0x9,%bl
 26e:	77 10                	ja     280 <atoi+0x2a>
    n = n*10 + *s++ - '0';
 270:	8d 14 92             	lea    (%edx,%edx,4),%edx
 273:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 276:	41                   	inc    %ecx
 277:	0f be c0             	movsbl %al,%eax
 27a:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
 27e:	eb e6                	jmp    266 <atoi+0x10>
  return n;
}
 280:	89 d0                	mov    %edx,%eax
 282:	5b                   	pop    %ebx
 283:	5d                   	pop    %ebp
 284:	c3                   	ret    

00000285 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 285:	f3 0f 1e fb          	endbr32 
 289:	55                   	push   %ebp
 28a:	89 e5                	mov    %esp,%ebp
 28c:	56                   	push   %esi
 28d:	53                   	push   %ebx
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
 291:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 294:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 297:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 299:	8d 72 ff             	lea    -0x1(%edx),%esi
 29c:	85 d2                	test   %edx,%edx
 29e:	7e 0e                	jle    2ae <memmove+0x29>
    *dst++ = *src++;
 2a0:	8a 13                	mov    (%ebx),%dl
 2a2:	88 11                	mov    %dl,(%ecx)
 2a4:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2a7:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 2aa:	89 f2                	mov    %esi,%edx
 2ac:	eb eb                	jmp    299 <memmove+0x14>
  return vdst;
}
 2ae:	5b                   	pop    %ebx
 2af:	5e                   	pop    %esi
 2b0:	5d                   	pop    %ebp
 2b1:	c3                   	ret    

000002b2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b2:	b8 01 00 00 00       	mov    $0x1,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exit>:
SYSCALL(exit)
 2ba:	b8 02 00 00 00       	mov    $0x2,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <wait>:
SYSCALL(wait)
 2c2:	b8 03 00 00 00       	mov    $0x3,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <pipe>:
SYSCALL(pipe)
 2ca:	b8 04 00 00 00       	mov    $0x4,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <read>:
SYSCALL(read)
 2d2:	b8 05 00 00 00       	mov    $0x5,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <write>:
SYSCALL(write)
 2da:	b8 10 00 00 00       	mov    $0x10,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <close>:
SYSCALL(close)
 2e2:	b8 15 00 00 00       	mov    $0x15,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <kill>:
SYSCALL(kill)
 2ea:	b8 06 00 00 00       	mov    $0x6,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <exec>:
SYSCALL(exec)
 2f2:	b8 07 00 00 00       	mov    $0x7,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <open>:
SYSCALL(open)
 2fa:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <mknod>:
SYSCALL(mknod)
 302:	b8 11 00 00 00       	mov    $0x11,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <unlink>:
SYSCALL(unlink)
 30a:	b8 12 00 00 00       	mov    $0x12,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <fstat>:
SYSCALL(fstat)
 312:	b8 08 00 00 00       	mov    $0x8,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <link>:
SYSCALL(link)
 31a:	b8 13 00 00 00       	mov    $0x13,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <mkdir>:
SYSCALL(mkdir)
 322:	b8 14 00 00 00       	mov    $0x14,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <chdir>:
SYSCALL(chdir)
 32a:	b8 09 00 00 00       	mov    $0x9,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <dup>:
SYSCALL(dup)
 332:	b8 0a 00 00 00       	mov    $0xa,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <getpid>:
SYSCALL(getpid)
 33a:	b8 0b 00 00 00       	mov    $0xb,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sbrk>:
SYSCALL(sbrk)
 342:	b8 0c 00 00 00       	mov    $0xc,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sleep>:
SYSCALL(sleep)
 34a:	b8 0d 00 00 00       	mov    $0xd,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <uptime>:
SYSCALL(uptime)
 352:	b8 0e 00 00 00       	mov    $0xe,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <date>:
SYSCALL(date)
 35a:	b8 16 00 00 00       	mov    $0x16,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <dup2>:
SYSCALL(dup2)
 362:	b8 17 00 00 00       	mov    $0x17,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36a:	55                   	push   %ebp
 36b:	89 e5                	mov    %esp,%ebp
 36d:	83 ec 1c             	sub    $0x1c,%esp
 370:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 373:	6a 01                	push   $0x1
 375:	8d 55 f4             	lea    -0xc(%ebp),%edx
 378:	52                   	push   %edx
 379:	50                   	push   %eax
 37a:	e8 5b ff ff ff       	call   2da <write>
}
 37f:	83 c4 10             	add    $0x10,%esp
 382:	c9                   	leave  
 383:	c3                   	ret    

00000384 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	57                   	push   %edi
 388:	56                   	push   %esi
 389:	53                   	push   %ebx
 38a:	83 ec 2c             	sub    $0x2c,%esp
 38d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 390:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 392:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 396:	74 04                	je     39c <printint+0x18>
 398:	85 d2                	test   %edx,%edx
 39a:	78 3a                	js     3d6 <printint+0x52>
  neg = 0;
 39c:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3a3:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 3a8:	89 f0                	mov    %esi,%eax
 3aa:	ba 00 00 00 00       	mov    $0x0,%edx
 3af:	f7 f1                	div    %ecx
 3b1:	89 df                	mov    %ebx,%edi
 3b3:	43                   	inc    %ebx
 3b4:	8a 92 88 05 00 00    	mov    0x588(%edx),%dl
 3ba:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 3be:	89 f2                	mov    %esi,%edx
 3c0:	89 c6                	mov    %eax,%esi
 3c2:	39 d1                	cmp    %edx,%ecx
 3c4:	76 e2                	jbe    3a8 <printint+0x24>
  if(neg)
 3c6:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 3ca:	74 22                	je     3ee <printint+0x6a>
    buf[i++] = '-';
 3cc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3d1:	8d 5f 02             	lea    0x2(%edi),%ebx
 3d4:	eb 18                	jmp    3ee <printint+0x6a>
    x = -xx;
 3d6:	f7 de                	neg    %esi
    neg = 1;
 3d8:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 3df:	eb c2                	jmp    3a3 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 3e1:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 3e6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3e9:	e8 7c ff ff ff       	call   36a <putc>
  while(--i >= 0)
 3ee:	4b                   	dec    %ebx
 3ef:	79 f0                	jns    3e1 <printint+0x5d>
}
 3f1:	83 c4 2c             	add    $0x2c,%esp
 3f4:	5b                   	pop    %ebx
 3f5:	5e                   	pop    %esi
 3f6:	5f                   	pop    %edi
 3f7:	5d                   	pop    %ebp
 3f8:	c3                   	ret    

000003f9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3f9:	f3 0f 1e fb          	endbr32 
 3fd:	55                   	push   %ebp
 3fe:	89 e5                	mov    %esp,%ebp
 400:	57                   	push   %edi
 401:	56                   	push   %esi
 402:	53                   	push   %ebx
 403:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 406:	8d 45 10             	lea    0x10(%ebp),%eax
 409:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 40c:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 411:	bb 00 00 00 00       	mov    $0x0,%ebx
 416:	eb 12                	jmp    42a <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 418:	89 fa                	mov    %edi,%edx
 41a:	8b 45 08             	mov    0x8(%ebp),%eax
 41d:	e8 48 ff ff ff       	call   36a <putc>
 422:	eb 05                	jmp    429 <printf+0x30>
      }
    } else if(state == '%'){
 424:	83 fe 25             	cmp    $0x25,%esi
 427:	74 22                	je     44b <printf+0x52>
  for(i = 0; fmt[i]; i++){
 429:	43                   	inc    %ebx
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	8a 04 18             	mov    (%eax,%ebx,1),%al
 430:	84 c0                	test   %al,%al
 432:	0f 84 13 01 00 00    	je     54b <printf+0x152>
    c = fmt[i] & 0xff;
 438:	0f be f8             	movsbl %al,%edi
 43b:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 43e:	85 f6                	test   %esi,%esi
 440:	75 e2                	jne    424 <printf+0x2b>
      if(c == '%'){
 442:	83 f8 25             	cmp    $0x25,%eax
 445:	75 d1                	jne    418 <printf+0x1f>
        state = '%';
 447:	89 c6                	mov    %eax,%esi
 449:	eb de                	jmp    429 <printf+0x30>
      if(c == 'd'){
 44b:	83 f8 64             	cmp    $0x64,%eax
 44e:	74 43                	je     493 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 450:	83 f8 78             	cmp    $0x78,%eax
 453:	74 68                	je     4bd <printf+0xc4>
 455:	83 f8 70             	cmp    $0x70,%eax
 458:	74 63                	je     4bd <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 45a:	83 f8 73             	cmp    $0x73,%eax
 45d:	0f 84 84 00 00 00    	je     4e7 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 463:	83 f8 63             	cmp    $0x63,%eax
 466:	0f 84 ad 00 00 00    	je     519 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 46c:	83 f8 25             	cmp    $0x25,%eax
 46f:	0f 84 c2 00 00 00    	je     537 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 475:	ba 25 00 00 00       	mov    $0x25,%edx
 47a:	8b 45 08             	mov    0x8(%ebp),%eax
 47d:	e8 e8 fe ff ff       	call   36a <putc>
        putc(fd, c);
 482:	89 fa                	mov    %edi,%edx
 484:	8b 45 08             	mov    0x8(%ebp),%eax
 487:	e8 de fe ff ff       	call   36a <putc>
      }
      state = 0;
 48c:	be 00 00 00 00       	mov    $0x0,%esi
 491:	eb 96                	jmp    429 <printf+0x30>
        printint(fd, *ap, 10, 1);
 493:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 496:	8b 17                	mov    (%edi),%edx
 498:	83 ec 0c             	sub    $0xc,%esp
 49b:	6a 01                	push   $0x1
 49d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4a2:	8b 45 08             	mov    0x8(%ebp),%eax
 4a5:	e8 da fe ff ff       	call   384 <printint>
        ap++;
 4aa:	83 c7 04             	add    $0x4,%edi
 4ad:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4b0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4b3:	be 00 00 00 00       	mov    $0x0,%esi
 4b8:	e9 6c ff ff ff       	jmp    429 <printf+0x30>
        printint(fd, *ap, 16, 0);
 4bd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4c0:	8b 17                	mov    (%edi),%edx
 4c2:	83 ec 0c             	sub    $0xc,%esp
 4c5:	6a 00                	push   $0x0
 4c7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4cc:	8b 45 08             	mov    0x8(%ebp),%eax
 4cf:	e8 b0 fe ff ff       	call   384 <printint>
        ap++;
 4d4:	83 c7 04             	add    $0x4,%edi
 4d7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4da:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4dd:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 4e2:	e9 42 ff ff ff       	jmp    429 <printf+0x30>
        s = (char*)*ap;
 4e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ea:	8b 30                	mov    (%eax),%esi
        ap++;
 4ec:	83 c0 04             	add    $0x4,%eax
 4ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 4f2:	85 f6                	test   %esi,%esi
 4f4:	75 13                	jne    509 <printf+0x110>
          s = "(null)";
 4f6:	be 81 05 00 00       	mov    $0x581,%esi
 4fb:	eb 0c                	jmp    509 <printf+0x110>
          putc(fd, *s);
 4fd:	0f be d2             	movsbl %dl,%edx
 500:	8b 45 08             	mov    0x8(%ebp),%eax
 503:	e8 62 fe ff ff       	call   36a <putc>
          s++;
 508:	46                   	inc    %esi
        while(*s != 0){
 509:	8a 16                	mov    (%esi),%dl
 50b:	84 d2                	test   %dl,%dl
 50d:	75 ee                	jne    4fd <printf+0x104>
      state = 0;
 50f:	be 00 00 00 00       	mov    $0x0,%esi
 514:	e9 10 ff ff ff       	jmp    429 <printf+0x30>
        putc(fd, *ap);
 519:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 51c:	0f be 17             	movsbl (%edi),%edx
 51f:	8b 45 08             	mov    0x8(%ebp),%eax
 522:	e8 43 fe ff ff       	call   36a <putc>
        ap++;
 527:	83 c7 04             	add    $0x4,%edi
 52a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 52d:	be 00 00 00 00       	mov    $0x0,%esi
 532:	e9 f2 fe ff ff       	jmp    429 <printf+0x30>
        putc(fd, c);
 537:	89 fa                	mov    %edi,%edx
 539:	8b 45 08             	mov    0x8(%ebp),%eax
 53c:	e8 29 fe ff ff       	call   36a <putc>
      state = 0;
 541:	be 00 00 00 00       	mov    $0x0,%esi
 546:	e9 de fe ff ff       	jmp    429 <printf+0x30>
    }
  }
}
 54b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 54e:	5b                   	pop    %ebx
 54f:	5e                   	pop    %esi
 550:	5f                   	pop    %edi
 551:	5d                   	pop    %ebp
 552:	c3                   	ret    
