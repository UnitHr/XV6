
stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

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
  11:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  17:	8d 7d de             	lea    -0x22(%ebp),%edi
  1a:	be 6b 05 00 00       	mov    $0x56b,%esi
  1f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  24:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  26:	68 48 05 00 00       	push   $0x548
  2b:	6a 01                	push   $0x1
  2d:	e8 b3 03 00 00       	call   3e5 <printf>
  memset(data, 'a', sizeof(data));
  32:	83 c4 0c             	add    $0xc,%esp
  35:	68 00 02 00 00       	push   $0x200
  3a:	6a 61                	push   $0x61
  3c:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  42:	50                   	push   %eax
  43:	e8 2f 01 00 00       	call   177 <memset>

  for(i = 0; i < 4; i++)
  48:	83 c4 10             	add    $0x10,%esp
  4b:	bb 00 00 00 00       	mov    $0x0,%ebx
  50:	83 fb 03             	cmp    $0x3,%ebx
  53:	7f 0c                	jg     61 <main+0x61>
    if(fork() > 0)
  55:	e8 40 02 00 00       	call   29a <fork>
  5a:	85 c0                	test   %eax,%eax
  5c:	7f 03                	jg     61 <main+0x61>
  for(i = 0; i < 4; i++)
  5e:	43                   	inc    %ebx
  5f:	eb ef                	jmp    50 <main+0x50>
      break;

  printf(1, "write %d\n", i);
  61:	83 ec 04             	sub    $0x4,%esp
  64:	53                   	push   %ebx
  65:	68 5b 05 00 00       	push   $0x55b
  6a:	6a 01                	push   $0x1
  6c:	e8 74 03 00 00       	call   3e5 <printf>

  path[8] += i;
  71:	00 5d e6             	add    %bl,-0x1a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  74:	83 c4 08             	add    $0x8,%esp
  77:	68 02 02 00 00       	push   $0x202
  7c:	8d 45 de             	lea    -0x22(%ebp),%eax
  7f:	50                   	push   %eax
  80:	e8 5d 02 00 00       	call   2e2 <open>
  85:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++)
  87:	83 c4 10             	add    $0x10,%esp
  8a:	bb 00 00 00 00       	mov    $0x0,%ebx
  8f:	eb 19                	jmp    aa <main+0xaa>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  91:	83 ec 04             	sub    $0x4,%esp
  94:	68 00 02 00 00       	push   $0x200
  99:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9f:	50                   	push   %eax
  a0:	56                   	push   %esi
  a1:	e8 1c 02 00 00       	call   2c2 <write>
  for(i = 0; i < 20; i++)
  a6:	43                   	inc    %ebx
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	83 fb 13             	cmp    $0x13,%ebx
  ad:	7e e2                	jle    91 <main+0x91>
  close(fd);
  af:	83 ec 0c             	sub    $0xc,%esp
  b2:	56                   	push   %esi
  b3:	e8 12 02 00 00       	call   2ca <close>

  printf(1, "read\n");
  b8:	83 c4 08             	add    $0x8,%esp
  bb:	68 65 05 00 00       	push   $0x565
  c0:	6a 01                	push   $0x1
  c2:	e8 1e 03 00 00       	call   3e5 <printf>

  fd = open(path, O_RDONLY);
  c7:	83 c4 08             	add    $0x8,%esp
  ca:	6a 00                	push   $0x0
  cc:	8d 45 de             	lea    -0x22(%ebp),%eax
  cf:	50                   	push   %eax
  d0:	e8 0d 02 00 00       	call   2e2 <open>
  d5:	89 c6                	mov    %eax,%esi
  for (i = 0; i < 20; i++)
  d7:	83 c4 10             	add    $0x10,%esp
  da:	bb 00 00 00 00       	mov    $0x0,%ebx
  df:	eb 19                	jmp    fa <main+0xfa>
    read(fd, data, sizeof(data));
  e1:	83 ec 04             	sub    $0x4,%esp
  e4:	68 00 02 00 00       	push   $0x200
  e9:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  ef:	50                   	push   %eax
  f0:	56                   	push   %esi
  f1:	e8 c4 01 00 00       	call   2ba <read>
  for (i = 0; i < 20; i++)
  f6:	43                   	inc    %ebx
  f7:	83 c4 10             	add    $0x10,%esp
  fa:	83 fb 13             	cmp    $0x13,%ebx
  fd:	7e e2                	jle    e1 <main+0xe1>
  close(fd);
  ff:	83 ec 0c             	sub    $0xc,%esp
 102:	56                   	push   %esi
 103:	e8 c2 01 00 00       	call   2ca <close>

  wait(NULL);
 108:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 10f:	e8 96 01 00 00       	call   2aa <wait>

  exit(0);
 114:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 11b:	e8 82 01 00 00       	call   2a2 <exit>

00000120 <start>:

// Entry point of the library	
void
start()
{
}
 120:	c3                   	ret    

00000121 <strcpy>:

char*
strcpy(char *s, const char *t)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
 124:	56                   	push   %esi
 125:	53                   	push   %ebx
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12c:	89 c2                	mov    %eax,%edx
 12e:	89 cb                	mov    %ecx,%ebx
 130:	41                   	inc    %ecx
 131:	89 d6                	mov    %edx,%esi
 133:	42                   	inc    %edx
 134:	8a 1b                	mov    (%ebx),%bl
 136:	88 1e                	mov    %bl,(%esi)
 138:	84 db                	test   %bl,%bl
 13a:	75 f2                	jne    12e <strcpy+0xd>
    ;
  return os;
}
 13c:	5b                   	pop    %ebx
 13d:	5e                   	pop    %esi
 13e:	5d                   	pop    %ebp
 13f:	c3                   	ret    

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 4d 08             	mov    0x8(%ebp),%ecx
 146:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 149:	eb 02                	jmp    14d <strcmp+0xd>
    p++, q++;
 14b:	41                   	inc    %ecx
 14c:	42                   	inc    %edx
  while(*p && *p == *q)
 14d:	8a 01                	mov    (%ecx),%al
 14f:	84 c0                	test   %al,%al
 151:	74 04                	je     157 <strcmp+0x17>
 153:	3a 02                	cmp    (%edx),%al
 155:	74 f4                	je     14b <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 157:	0f b6 c0             	movzbl %al,%eax
 15a:	0f b6 12             	movzbl (%edx),%edx
 15d:	29 d0                	sub    %edx,%eax
}
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret    

00000161 <strlen>:

uint
strlen(const char *s)
{
 161:	55                   	push   %ebp
 162:	89 e5                	mov    %esp,%ebp
 164:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 167:	b8 00 00 00 00       	mov    $0x0,%eax
 16c:	eb 01                	jmp    16f <strlen+0xe>
 16e:	40                   	inc    %eax
 16f:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 173:	75 f9                	jne    16e <strlen+0xd>
    ;
  return n;
}
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    

00000177 <memset>:

void*
memset(void *dst, int c, uint n)
{
 177:	55                   	push   %ebp
 178:	89 e5                	mov    %esp,%ebp
 17a:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 17b:	8b 7d 08             	mov    0x8(%ebp),%edi
 17e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 181:	8b 45 0c             	mov    0xc(%ebp),%eax
 184:	fc                   	cld    
 185:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	8b 7d fc             	mov    -0x4(%ebp),%edi
 18d:	c9                   	leave  
 18e:	c3                   	ret    

0000018f <strchr>:

char*
strchr(const char *s, char c)
{
 18f:	55                   	push   %ebp
 190:	89 e5                	mov    %esp,%ebp
 192:	8b 45 08             	mov    0x8(%ebp),%eax
 195:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 198:	eb 01                	jmp    19b <strchr+0xc>
 19a:	40                   	inc    %eax
 19b:	8a 10                	mov    (%eax),%dl
 19d:	84 d2                	test   %dl,%dl
 19f:	74 06                	je     1a7 <strchr+0x18>
    if(*s == c)
 1a1:	38 ca                	cmp    %cl,%dl
 1a3:	75 f5                	jne    19a <strchr+0xb>
 1a5:	eb 05                	jmp    1ac <strchr+0x1d>
      return (char*)s;
  return 0;
 1a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ac:	5d                   	pop    %ebp
 1ad:	c3                   	ret    

000001ae <gets>:

char*
gets(char *buf, int max)
{
 1ae:	55                   	push   %ebp
 1af:	89 e5                	mov    %esp,%ebp
 1b1:	57                   	push   %edi
 1b2:	56                   	push   %esi
 1b3:	53                   	push   %ebx
 1b4:	83 ec 1c             	sub    $0x1c,%esp
 1b7:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	bb 00 00 00 00       	mov    $0x0,%ebx
 1bf:	89 de                	mov    %ebx,%esi
 1c1:	43                   	inc    %ebx
 1c2:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c5:	7d 2b                	jge    1f2 <gets+0x44>
    cc = read(0, &c, 1);
 1c7:	83 ec 04             	sub    $0x4,%esp
 1ca:	6a 01                	push   $0x1
 1cc:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1cf:	50                   	push   %eax
 1d0:	6a 00                	push   $0x0
 1d2:	e8 e3 00 00 00       	call   2ba <read>
    if(cc < 1)
 1d7:	83 c4 10             	add    $0x10,%esp
 1da:	85 c0                	test   %eax,%eax
 1dc:	7e 14                	jle    1f2 <gets+0x44>
      break;
    buf[i++] = c;
 1de:	8a 45 e7             	mov    -0x19(%ebp),%al
 1e1:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1e4:	3c 0a                	cmp    $0xa,%al
 1e6:	74 08                	je     1f0 <gets+0x42>
 1e8:	3c 0d                	cmp    $0xd,%al
 1ea:	75 d3                	jne    1bf <gets+0x11>
    buf[i++] = c;
 1ec:	89 de                	mov    %ebx,%esi
 1ee:	eb 02                	jmp    1f2 <gets+0x44>
 1f0:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1f2:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1f6:	89 f8                	mov    %edi,%eax
 1f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fb:	5b                   	pop    %ebx
 1fc:	5e                   	pop    %esi
 1fd:	5f                   	pop    %edi
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	push   0x8(%ebp)
 20d:	e8 d0 00 00 00       	call   2e2 <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 24                	js     23d <stat+0x3d>
 219:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 21b:	83 ec 08             	sub    $0x8,%esp
 21e:	ff 75 0c             	push   0xc(%ebp)
 221:	50                   	push   %eax
 222:	e8 d3 00 00 00       	call   2fa <fstat>
 227:	89 c6                	mov    %eax,%esi
  close(fd);
 229:	89 1c 24             	mov    %ebx,(%esp)
 22c:	e8 99 00 00 00       	call   2ca <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
}
 234:	89 f0                	mov    %esi,%eax
 236:	8d 65 f8             	lea    -0x8(%ebp),%esp
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
    return -1;
 23d:	be ff ff ff ff       	mov    $0xffffffff,%esi
 242:	eb f0                	jmp    234 <stat+0x34>

00000244 <atoi>:

int
atoi(const char *s)
{
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	53                   	push   %ebx
 248:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 24b:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 250:	eb 0e                	jmp    260 <atoi+0x1c>
    n = n*10 + *s++ - '0';
 252:	8d 14 92             	lea    (%edx,%edx,4),%edx
 255:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 258:	41                   	inc    %ecx
 259:	0f be c0             	movsbl %al,%eax
 25c:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
  while('0' <= *s && *s <= '9')
 260:	8a 01                	mov    (%ecx),%al
 262:	8d 58 d0             	lea    -0x30(%eax),%ebx
 265:	80 fb 09             	cmp    $0x9,%bl
 268:	76 e8                	jbe    252 <atoi+0xe>
  return n;
}
 26a:	89 d0                	mov    %edx,%eax
 26c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 26f:	c9                   	leave  
 270:	c3                   	ret    

00000271 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 271:	55                   	push   %ebp
 272:	89 e5                	mov    %esp,%ebp
 274:	56                   	push   %esi
 275:	53                   	push   %ebx
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 27c:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 27f:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 281:	eb 0c                	jmp    28f <memmove+0x1e>
    *dst++ = *src++;
 283:	8a 13                	mov    (%ebx),%dl
 285:	88 11                	mov    %dl,(%ecx)
 287:	8d 5b 01             	lea    0x1(%ebx),%ebx
 28a:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 28d:	89 f2                	mov    %esi,%edx
 28f:	8d 72 ff             	lea    -0x1(%edx),%esi
 292:	85 d2                	test   %edx,%edx
 294:	7f ed                	jg     283 <memmove+0x12>
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    

0000029a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29a:	b8 01 00 00 00       	mov    $0x1,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exit>:
SYSCALL(exit)
 2a2:	b8 02 00 00 00       	mov    $0x2,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <wait>:
SYSCALL(wait)
 2aa:	b8 03 00 00 00       	mov    $0x3,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <pipe>:
SYSCALL(pipe)
 2b2:	b8 04 00 00 00       	mov    $0x4,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <read>:
SYSCALL(read)
 2ba:	b8 05 00 00 00       	mov    $0x5,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <write>:
SYSCALL(write)
 2c2:	b8 10 00 00 00       	mov    $0x10,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <close>:
SYSCALL(close)
 2ca:	b8 15 00 00 00       	mov    $0x15,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <kill>:
SYSCALL(kill)
 2d2:	b8 06 00 00 00       	mov    $0x6,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exec>:
SYSCALL(exec)
 2da:	b8 07 00 00 00       	mov    $0x7,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <open>:
SYSCALL(open)
 2e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mknod>:
SYSCALL(mknod)
 2ea:	b8 11 00 00 00       	mov    $0x11,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <unlink>:
SYSCALL(unlink)
 2f2:	b8 12 00 00 00       	mov    $0x12,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <fstat>:
SYSCALL(fstat)
 2fa:	b8 08 00 00 00       	mov    $0x8,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <link>:
SYSCALL(link)
 302:	b8 13 00 00 00       	mov    $0x13,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mkdir>:
SYSCALL(mkdir)
 30a:	b8 14 00 00 00       	mov    $0x14,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <date>:
SYSCALL(date)
 342:	b8 16 00 00 00       	mov    $0x16,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <dup2>:
SYSCALL(dup2)
 34a:	b8 17 00 00 00       	mov    $0x17,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 352:	55                   	push   %ebp
 353:	89 e5                	mov    %esp,%ebp
 355:	83 ec 1c             	sub    $0x1c,%esp
 358:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 35b:	6a 01                	push   $0x1
 35d:	8d 55 f4             	lea    -0xc(%ebp),%edx
 360:	52                   	push   %edx
 361:	50                   	push   %eax
 362:	e8 5b ff ff ff       	call   2c2 <write>
}
 367:	83 c4 10             	add    $0x10,%esp
 36a:	c9                   	leave  
 36b:	c3                   	ret    

0000036c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	57                   	push   %edi
 370:	56                   	push   %esi
 371:	53                   	push   %ebx
 372:	83 ec 2c             	sub    $0x2c,%esp
 375:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 378:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 37e:	74 04                	je     384 <printint+0x18>
 380:	85 d2                	test   %edx,%edx
 382:	78 3c                	js     3c0 <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 384:	89 d1                	mov    %edx,%ecx
  neg = 0;
 386:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 38d:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 392:	89 c8                	mov    %ecx,%eax
 394:	ba 00 00 00 00       	mov    $0x0,%edx
 399:	f7 f6                	div    %esi
 39b:	89 df                	mov    %ebx,%edi
 39d:	43                   	inc    %ebx
 39e:	8a 92 d4 05 00 00    	mov    0x5d4(%edx),%dl
 3a4:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 3a8:	89 ca                	mov    %ecx,%edx
 3aa:	89 c1                	mov    %eax,%ecx
 3ac:	39 d6                	cmp    %edx,%esi
 3ae:	76 e2                	jbe    392 <printint+0x26>
  if(neg)
 3b0:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 3b4:	74 24                	je     3da <printint+0x6e>
    buf[i++] = '-';
 3b6:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3bb:	8d 5f 02             	lea    0x2(%edi),%ebx
 3be:	eb 1a                	jmp    3da <printint+0x6e>
    x = -xx;
 3c0:	89 d1                	mov    %edx,%ecx
 3c2:	f7 d9                	neg    %ecx
    neg = 1;
 3c4:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 3cb:	eb c0                	jmp    38d <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 3cd:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 3d2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3d5:	e8 78 ff ff ff       	call   352 <putc>
  while(--i >= 0)
 3da:	4b                   	dec    %ebx
 3db:	79 f0                	jns    3cd <printint+0x61>
}
 3dd:	83 c4 2c             	add    $0x2c,%esp
 3e0:	5b                   	pop    %ebx
 3e1:	5e                   	pop    %esi
 3e2:	5f                   	pop    %edi
 3e3:	5d                   	pop    %ebp
 3e4:	c3                   	ret    

000003e5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3e5:	55                   	push   %ebp
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	57                   	push   %edi
 3e9:	56                   	push   %esi
 3ea:	53                   	push   %ebx
 3eb:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3ee:	8d 45 10             	lea    0x10(%ebp),%eax
 3f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 3f4:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 3f9:	bb 00 00 00 00       	mov    $0x0,%ebx
 3fe:	eb 12                	jmp    412 <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 400:	89 fa                	mov    %edi,%edx
 402:	8b 45 08             	mov    0x8(%ebp),%eax
 405:	e8 48 ff ff ff       	call   352 <putc>
 40a:	eb 05                	jmp    411 <printf+0x2c>
      }
    } else if(state == '%'){
 40c:	83 fe 25             	cmp    $0x25,%esi
 40f:	74 22                	je     433 <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 411:	43                   	inc    %ebx
 412:	8b 45 0c             	mov    0xc(%ebp),%eax
 415:	8a 04 18             	mov    (%eax,%ebx,1),%al
 418:	84 c0                	test   %al,%al
 41a:	0f 84 1d 01 00 00    	je     53d <printf+0x158>
    c = fmt[i] & 0xff;
 420:	0f be f8             	movsbl %al,%edi
 423:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 426:	85 f6                	test   %esi,%esi
 428:	75 e2                	jne    40c <printf+0x27>
      if(c == '%'){
 42a:	83 f8 25             	cmp    $0x25,%eax
 42d:	75 d1                	jne    400 <printf+0x1b>
        state = '%';
 42f:	89 c6                	mov    %eax,%esi
 431:	eb de                	jmp    411 <printf+0x2c>
      if(c == 'd'){
 433:	83 f8 25             	cmp    $0x25,%eax
 436:	0f 84 cc 00 00 00    	je     508 <printf+0x123>
 43c:	0f 8c da 00 00 00    	jl     51c <printf+0x137>
 442:	83 f8 78             	cmp    $0x78,%eax
 445:	0f 8f d1 00 00 00    	jg     51c <printf+0x137>
 44b:	83 f8 63             	cmp    $0x63,%eax
 44e:	0f 8c c8 00 00 00    	jl     51c <printf+0x137>
 454:	83 e8 63             	sub    $0x63,%eax
 457:	83 f8 15             	cmp    $0x15,%eax
 45a:	0f 87 bc 00 00 00    	ja     51c <printf+0x137>
 460:	ff 24 85 7c 05 00 00 	jmp    *0x57c(,%eax,4)
        printint(fd, *ap, 10, 1);
 467:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 46a:	8b 17                	mov    (%edi),%edx
 46c:	83 ec 0c             	sub    $0xc,%esp
 46f:	6a 01                	push   $0x1
 471:	b9 0a 00 00 00       	mov    $0xa,%ecx
 476:	8b 45 08             	mov    0x8(%ebp),%eax
 479:	e8 ee fe ff ff       	call   36c <printint>
        ap++;
 47e:	83 c7 04             	add    $0x4,%edi
 481:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 484:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 487:	be 00 00 00 00       	mov    $0x0,%esi
 48c:	eb 83                	jmp    411 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 48e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 491:	8b 17                	mov    (%edi),%edx
 493:	83 ec 0c             	sub    $0xc,%esp
 496:	6a 00                	push   $0x0
 498:	b9 10 00 00 00       	mov    $0x10,%ecx
 49d:	8b 45 08             	mov    0x8(%ebp),%eax
 4a0:	e8 c7 fe ff ff       	call   36c <printint>
        ap++;
 4a5:	83 c7 04             	add    $0x4,%edi
 4a8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4ab:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4ae:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 4b3:	e9 59 ff ff ff       	jmp    411 <printf+0x2c>
        s = (char*)*ap;
 4b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4bb:	8b 30                	mov    (%eax),%esi
        ap++;
 4bd:	83 c0 04             	add    $0x4,%eax
 4c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 4c3:	85 f6                	test   %esi,%esi
 4c5:	75 13                	jne    4da <printf+0xf5>
          s = "(null)";
 4c7:	be 75 05 00 00       	mov    $0x575,%esi
 4cc:	eb 0c                	jmp    4da <printf+0xf5>
          putc(fd, *s);
 4ce:	0f be d2             	movsbl %dl,%edx
 4d1:	8b 45 08             	mov    0x8(%ebp),%eax
 4d4:	e8 79 fe ff ff       	call   352 <putc>
          s++;
 4d9:	46                   	inc    %esi
        while(*s != 0){
 4da:	8a 16                	mov    (%esi),%dl
 4dc:	84 d2                	test   %dl,%dl
 4de:	75 ee                	jne    4ce <printf+0xe9>
      state = 0;
 4e0:	be 00 00 00 00       	mov    $0x0,%esi
 4e5:	e9 27 ff ff ff       	jmp    411 <printf+0x2c>
        putc(fd, *ap);
 4ea:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4ed:	0f be 17             	movsbl (%edi),%edx
 4f0:	8b 45 08             	mov    0x8(%ebp),%eax
 4f3:	e8 5a fe ff ff       	call   352 <putc>
        ap++;
 4f8:	83 c7 04             	add    $0x4,%edi
 4fb:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 4fe:	be 00 00 00 00       	mov    $0x0,%esi
 503:	e9 09 ff ff ff       	jmp    411 <printf+0x2c>
        putc(fd, c);
 508:	89 fa                	mov    %edi,%edx
 50a:	8b 45 08             	mov    0x8(%ebp),%eax
 50d:	e8 40 fe ff ff       	call   352 <putc>
      state = 0;
 512:	be 00 00 00 00       	mov    $0x0,%esi
 517:	e9 f5 fe ff ff       	jmp    411 <printf+0x2c>
        putc(fd, '%');
 51c:	ba 25 00 00 00       	mov    $0x25,%edx
 521:	8b 45 08             	mov    0x8(%ebp),%eax
 524:	e8 29 fe ff ff       	call   352 <putc>
        putc(fd, c);
 529:	89 fa                	mov    %edi,%edx
 52b:	8b 45 08             	mov    0x8(%ebp),%eax
 52e:	e8 1f fe ff ff       	call   352 <putc>
      state = 0;
 533:	be 00 00 00 00       	mov    $0x0,%esi
 538:	e9 d4 fe ff ff       	jmp    411 <printf+0x2c>
    }
  }
}
 53d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 540:	5b                   	pop    %ebx
 541:	5e                   	pop    %esi
 542:	5f                   	pop    %edi
 543:	5d                   	pop    %ebp
 544:	c3                   	ret    
