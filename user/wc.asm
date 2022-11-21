
wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
   9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  10:	be 00 00 00 00       	mov    $0x0,%esi
  15:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  23:	83 ec 04             	sub    $0x4,%esp
  26:	68 00 02 00 00       	push   $0x200
  2b:	68 a0 08 00 00       	push   $0x8a0
  30:	ff 75 08             	push   0x8(%ebp)
  33:	e8 d5 02 00 00       	call   30d <read>
  38:	89 c7                	mov    %eax,%edi
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	7e 4d                	jle    8e <wc+0x8e>
    for(i=0; i<n; i++){
  41:	bb 00 00 00 00       	mov    $0x0,%ebx
  46:	eb 20                	jmp    68 <wc+0x68>
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	0f be c0             	movsbl %al,%eax
  4e:	50                   	push   %eax
  4f:	68 98 05 00 00       	push   $0x598
  54:	e8 89 01 00 00       	call   1e2 <strchr>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	85 c0                	test   %eax,%eax
  5e:	74 1c                	je     7c <wc+0x7c>
        inword = 0;
  60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  67:	43                   	inc    %ebx
  68:	39 fb                	cmp    %edi,%ebx
  6a:	7d b7                	jge    23 <wc+0x23>
      c++;
  6c:	46                   	inc    %esi
      if(buf[i] == '\n')
  6d:	8a 83 a0 08 00 00    	mov    0x8a0(%ebx),%al
  73:	3c 0a                	cmp    $0xa,%al
  75:	75 d1                	jne    48 <wc+0x48>
        l++;
  77:	ff 45 e0             	incl   -0x20(%ebp)
  7a:	eb cc                	jmp    48 <wc+0x48>
      else if(!inword){
  7c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80:	75 e5                	jne    67 <wc+0x67>
        w++;
  82:	ff 45 dc             	incl   -0x24(%ebp)
        inword = 1;
  85:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  8c:	eb d9                	jmp    67 <wc+0x67>
      }
    }
  }
  if(n < 0){
  8e:	78 24                	js     b4 <wc+0xb4>
    printf(1, "wc: read error\n");
    exit(0);
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  90:	83 ec 08             	sub    $0x8,%esp
  93:	ff 75 0c             	push   0xc(%ebp)
  96:	56                   	push   %esi
  97:	ff 75 dc             	push   -0x24(%ebp)
  9a:	ff 75 e0             	push   -0x20(%ebp)
  9d:	68 ae 05 00 00       	push   $0x5ae
  a2:	6a 01                	push   $0x1
  a4:	e8 8f 03 00 00       	call   438 <printf>
}
  a9:	83 c4 20             	add    $0x20,%esp
  ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
  af:	5b                   	pop    %ebx
  b0:	5e                   	pop    %esi
  b1:	5f                   	pop    %edi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    
    printf(1, "wc: read error\n");
  b4:	83 ec 08             	sub    $0x8,%esp
  b7:	68 9e 05 00 00       	push   $0x59e
  bc:	6a 01                	push   $0x1
  be:	e8 75 03 00 00       	call   438 <printf>
    exit(0);
  c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ca:	e8 26 02 00 00       	call   2f5 <exit>

000000cf <main>:

int
main(int argc, char *argv[])
{
  cf:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  d3:	83 e4 f0             	and    $0xfffffff0,%esp
  d6:	ff 71 fc             	push   -0x4(%ecx)
  d9:	55                   	push   %ebp
  da:	89 e5                	mov    %esp,%ebp
  dc:	57                   	push   %edi
  dd:	56                   	push   %esi
  de:	53                   	push   %ebx
  df:	51                   	push   %ecx
  e0:	83 ec 18             	sub    $0x18,%esp
  e3:	8b 01                	mov    (%ecx),%eax
  e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  e8:	8b 51 04             	mov    0x4(%ecx),%edx
  eb:	89 55 e0             	mov    %edx,-0x20(%ebp)
  int fd, i;

  if(argc <= 1){
  ee:	83 f8 01             	cmp    $0x1,%eax
  f1:	7e 07                	jle    fa <main+0x2b>
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
  f3:	be 01 00 00 00       	mov    $0x1,%esi
  f8:	eb 32                	jmp    12c <main+0x5d>
    wc(0, "");
  fa:	83 ec 08             	sub    $0x8,%esp
  fd:	68 ad 05 00 00       	push   $0x5ad
 102:	6a 00                	push   $0x0
 104:	e8 f7 fe ff ff       	call   0 <wc>
    exit(0);
 109:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 110:	e8 e0 01 00 00       	call   2f5 <exit>
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit(0);
    }
    wc(fd, argv[i]);
 115:	83 ec 08             	sub    $0x8,%esp
 118:	ff 37                	push   (%edi)
 11a:	50                   	push   %eax
 11b:	e8 e0 fe ff ff       	call   0 <wc>
    close(fd);
 120:	89 1c 24             	mov    %ebx,(%esp)
 123:	e8 f5 01 00 00       	call   31d <close>
  for(i = 1; i < argc; i++){
 128:	46                   	inc    %esi
 129:	83 c4 10             	add    $0x10,%esp
 12c:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
 12f:	7d 38                	jge    169 <main+0x9a>
    if((fd = open(argv[i], 0)) < 0){
 131:	8b 45 e0             	mov    -0x20(%ebp),%eax
 134:	8d 3c b0             	lea    (%eax,%esi,4),%edi
 137:	83 ec 08             	sub    $0x8,%esp
 13a:	6a 00                	push   $0x0
 13c:	ff 37                	push   (%edi)
 13e:	e8 f2 01 00 00       	call   335 <open>
 143:	89 c3                	mov    %eax,%ebx
 145:	83 c4 10             	add    $0x10,%esp
 148:	85 c0                	test   %eax,%eax
 14a:	79 c9                	jns    115 <main+0x46>
      printf(1, "wc: cannot open %s\n", argv[i]);
 14c:	83 ec 04             	sub    $0x4,%esp
 14f:	ff 37                	push   (%edi)
 151:	68 bb 05 00 00       	push   $0x5bb
 156:	6a 01                	push   $0x1
 158:	e8 db 02 00 00       	call   438 <printf>
      exit(0);
 15d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 164:	e8 8c 01 00 00       	call   2f5 <exit>
  }
  exit(0);
 169:	83 ec 0c             	sub    $0xc,%esp
 16c:	6a 00                	push   $0x0
 16e:	e8 82 01 00 00       	call   2f5 <exit>

00000173 <start>:

// Entry point of the library	
void
start()
{
}
 173:	c3                   	ret    

00000174 <strcpy>:

char*
strcpy(char *s, const char *t)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	56                   	push   %esi
 178:	53                   	push   %ebx
 179:	8b 45 08             	mov    0x8(%ebp),%eax
 17c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17f:	89 c2                	mov    %eax,%edx
 181:	89 cb                	mov    %ecx,%ebx
 183:	41                   	inc    %ecx
 184:	89 d6                	mov    %edx,%esi
 186:	42                   	inc    %edx
 187:	8a 1b                	mov    (%ebx),%bl
 189:	88 1e                	mov    %bl,(%esi)
 18b:	84 db                	test   %bl,%bl
 18d:	75 f2                	jne    181 <strcpy+0xd>
    ;
  return os;
}
 18f:	5b                   	pop    %ebx
 190:	5e                   	pop    %esi
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    

00000193 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 193:	55                   	push   %ebp
 194:	89 e5                	mov    %esp,%ebp
 196:	8b 4d 08             	mov    0x8(%ebp),%ecx
 199:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 19c:	eb 02                	jmp    1a0 <strcmp+0xd>
    p++, q++;
 19e:	41                   	inc    %ecx
 19f:	42                   	inc    %edx
  while(*p && *p == *q)
 1a0:	8a 01                	mov    (%ecx),%al
 1a2:	84 c0                	test   %al,%al
 1a4:	74 04                	je     1aa <strcmp+0x17>
 1a6:	3a 02                	cmp    (%edx),%al
 1a8:	74 f4                	je     19e <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 1aa:	0f b6 c0             	movzbl %al,%eax
 1ad:	0f b6 12             	movzbl (%edx),%edx
 1b0:	29 d0                	sub    %edx,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    

000001b4 <strlen>:

uint
strlen(const char *s)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1ba:	b8 00 00 00 00       	mov    $0x0,%eax
 1bf:	eb 01                	jmp    1c2 <strlen+0xe>
 1c1:	40                   	inc    %eax
 1c2:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 1c6:	75 f9                	jne    1c1 <strlen+0xd>
    ;
  return n;
}
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    

000001ca <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ca:	55                   	push   %ebp
 1cb:	89 e5                	mov    %esp,%ebp
 1cd:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1ce:	8b 7d 08             	mov    0x8(%ebp),%edi
 1d1:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d7:	fc                   	cld    
 1d8:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1e0:	c9                   	leave  
 1e1:	c3                   	ret    

000001e2 <strchr>:

char*
strchr(const char *s, char c)
{
 1e2:	55                   	push   %ebp
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1eb:	eb 01                	jmp    1ee <strchr+0xc>
 1ed:	40                   	inc    %eax
 1ee:	8a 10                	mov    (%eax),%dl
 1f0:	84 d2                	test   %dl,%dl
 1f2:	74 06                	je     1fa <strchr+0x18>
    if(*s == c)
 1f4:	38 ca                	cmp    %cl,%dl
 1f6:	75 f5                	jne    1ed <strchr+0xb>
 1f8:	eb 05                	jmp    1ff <strchr+0x1d>
      return (char*)s;
  return 0;
 1fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    

00000201 <gets>:

char*
gets(char *buf, int max)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	57                   	push   %edi
 205:	56                   	push   %esi
 206:	53                   	push   %ebx
 207:	83 ec 1c             	sub    $0x1c,%esp
 20a:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20d:	bb 00 00 00 00       	mov    $0x0,%ebx
 212:	89 de                	mov    %ebx,%esi
 214:	43                   	inc    %ebx
 215:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 218:	7d 2b                	jge    245 <gets+0x44>
    cc = read(0, &c, 1);
 21a:	83 ec 04             	sub    $0x4,%esp
 21d:	6a 01                	push   $0x1
 21f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 222:	50                   	push   %eax
 223:	6a 00                	push   $0x0
 225:	e8 e3 00 00 00       	call   30d <read>
    if(cc < 1)
 22a:	83 c4 10             	add    $0x10,%esp
 22d:	85 c0                	test   %eax,%eax
 22f:	7e 14                	jle    245 <gets+0x44>
      break;
    buf[i++] = c;
 231:	8a 45 e7             	mov    -0x19(%ebp),%al
 234:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 237:	3c 0a                	cmp    $0xa,%al
 239:	74 08                	je     243 <gets+0x42>
 23b:	3c 0d                	cmp    $0xd,%al
 23d:	75 d3                	jne    212 <gets+0x11>
    buf[i++] = c;
 23f:	89 de                	mov    %ebx,%esi
 241:	eb 02                	jmp    245 <gets+0x44>
 243:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 245:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 249:	89 f8                	mov    %edi,%eax
 24b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24e:	5b                   	pop    %ebx
 24f:	5e                   	pop    %esi
 250:	5f                   	pop    %edi
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    

00000253 <stat>:

int
stat(const char *n, struct stat *st)
{
 253:	55                   	push   %ebp
 254:	89 e5                	mov    %esp,%ebp
 256:	56                   	push   %esi
 257:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	83 ec 08             	sub    $0x8,%esp
 25b:	6a 00                	push   $0x0
 25d:	ff 75 08             	push   0x8(%ebp)
 260:	e8 d0 00 00 00       	call   335 <open>
  if(fd < 0)
 265:	83 c4 10             	add    $0x10,%esp
 268:	85 c0                	test   %eax,%eax
 26a:	78 24                	js     290 <stat+0x3d>
 26c:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 26e:	83 ec 08             	sub    $0x8,%esp
 271:	ff 75 0c             	push   0xc(%ebp)
 274:	50                   	push   %eax
 275:	e8 d3 00 00 00       	call   34d <fstat>
 27a:	89 c6                	mov    %eax,%esi
  close(fd);
 27c:	89 1c 24             	mov    %ebx,(%esp)
 27f:	e8 99 00 00 00       	call   31d <close>
  return r;
 284:	83 c4 10             	add    $0x10,%esp
}
 287:	89 f0                	mov    %esi,%eax
 289:	8d 65 f8             	lea    -0x8(%ebp),%esp
 28c:	5b                   	pop    %ebx
 28d:	5e                   	pop    %esi
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    
    return -1;
 290:	be ff ff ff ff       	mov    $0xffffffff,%esi
 295:	eb f0                	jmp    287 <stat+0x34>

00000297 <atoi>:

int
atoi(const char *s)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	53                   	push   %ebx
 29b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 29e:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 2a3:	eb 0e                	jmp    2b3 <atoi+0x1c>
    n = n*10 + *s++ - '0';
 2a5:	8d 14 92             	lea    (%edx,%edx,4),%edx
 2a8:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 2ab:	41                   	inc    %ecx
 2ac:	0f be c0             	movsbl %al,%eax
 2af:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
  while('0' <= *s && *s <= '9')
 2b3:	8a 01                	mov    (%ecx),%al
 2b5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2b8:	80 fb 09             	cmp    $0x9,%bl
 2bb:	76 e8                	jbe    2a5 <atoi+0xe>
  return n;
}
 2bd:	89 d0                	mov    %edx,%eax
 2bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2c2:	c9                   	leave  
 2c3:	c3                   	ret    

000002c4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c4:	55                   	push   %ebp
 2c5:	89 e5                	mov    %esp,%ebp
 2c7:	56                   	push   %esi
 2c8:	53                   	push   %ebx
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
 2cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2cf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 2d2:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 2d4:	eb 0c                	jmp    2e2 <memmove+0x1e>
    *dst++ = *src++;
 2d6:	8a 13                	mov    (%ebx),%dl
 2d8:	88 11                	mov    %dl,(%ecx)
 2da:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2dd:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 2e0:	89 f2                	mov    %esi,%edx
 2e2:	8d 72 ff             	lea    -0x1(%edx),%esi
 2e5:	85 d2                	test   %edx,%edx
 2e7:	7f ed                	jg     2d6 <memmove+0x12>
  return vdst;
}
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    

000002ed <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ed:	b8 01 00 00 00       	mov    $0x1,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <exit>:
SYSCALL(exit)
 2f5:	b8 02 00 00 00       	mov    $0x2,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <wait>:
SYSCALL(wait)
 2fd:	b8 03 00 00 00       	mov    $0x3,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <pipe>:
SYSCALL(pipe)
 305:	b8 04 00 00 00       	mov    $0x4,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <read>:
SYSCALL(read)
 30d:	b8 05 00 00 00       	mov    $0x5,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <write>:
SYSCALL(write)
 315:	b8 10 00 00 00       	mov    $0x10,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <close>:
SYSCALL(close)
 31d:	b8 15 00 00 00       	mov    $0x15,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <kill>:
SYSCALL(kill)
 325:	b8 06 00 00 00       	mov    $0x6,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <exec>:
SYSCALL(exec)
 32d:	b8 07 00 00 00       	mov    $0x7,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <open>:
SYSCALL(open)
 335:	b8 0f 00 00 00       	mov    $0xf,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <mknod>:
SYSCALL(mknod)
 33d:	b8 11 00 00 00       	mov    $0x11,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <unlink>:
SYSCALL(unlink)
 345:	b8 12 00 00 00       	mov    $0x12,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <fstat>:
SYSCALL(fstat)
 34d:	b8 08 00 00 00       	mov    $0x8,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <link>:
SYSCALL(link)
 355:	b8 13 00 00 00       	mov    $0x13,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <mkdir>:
SYSCALL(mkdir)
 35d:	b8 14 00 00 00       	mov    $0x14,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <chdir>:
SYSCALL(chdir)
 365:	b8 09 00 00 00       	mov    $0x9,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <dup>:
SYSCALL(dup)
 36d:	b8 0a 00 00 00       	mov    $0xa,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <getpid>:
SYSCALL(getpid)
 375:	b8 0b 00 00 00       	mov    $0xb,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <sbrk>:
SYSCALL(sbrk)
 37d:	b8 0c 00 00 00       	mov    $0xc,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <sleep>:
SYSCALL(sleep)
 385:	b8 0d 00 00 00       	mov    $0xd,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <uptime>:
SYSCALL(uptime)
 38d:	b8 0e 00 00 00       	mov    $0xe,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <date>:
SYSCALL(date)
 395:	b8 16 00 00 00       	mov    $0x16,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <dup2>:
SYSCALL(dup2)
 39d:	b8 17 00 00 00       	mov    $0x17,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3a5:	55                   	push   %ebp
 3a6:	89 e5                	mov    %esp,%ebp
 3a8:	83 ec 1c             	sub    $0x1c,%esp
 3ab:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3ae:	6a 01                	push   $0x1
 3b0:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3b3:	52                   	push   %edx
 3b4:	50                   	push   %eax
 3b5:	e8 5b ff ff ff       	call   315 <write>
}
 3ba:	83 c4 10             	add    $0x10,%esp
 3bd:	c9                   	leave  
 3be:	c3                   	ret    

000003bf <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3bf:	55                   	push   %ebp
 3c0:	89 e5                	mov    %esp,%ebp
 3c2:	57                   	push   %edi
 3c3:	56                   	push   %esi
 3c4:	53                   	push   %ebx
 3c5:	83 ec 2c             	sub    $0x2c,%esp
 3c8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3cb:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 3d1:	74 04                	je     3d7 <printint+0x18>
 3d3:	85 d2                	test   %edx,%edx
 3d5:	78 3c                	js     413 <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d7:	89 d1                	mov    %edx,%ecx
  neg = 0;
 3d9:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 3e0:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 3e5:	89 c8                	mov    %ecx,%eax
 3e7:	ba 00 00 00 00       	mov    $0x0,%edx
 3ec:	f7 f6                	div    %esi
 3ee:	89 df                	mov    %ebx,%edi
 3f0:	43                   	inc    %ebx
 3f1:	8a 92 30 06 00 00    	mov    0x630(%edx),%dl
 3f7:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 3fb:	89 ca                	mov    %ecx,%edx
 3fd:	89 c1                	mov    %eax,%ecx
 3ff:	39 d6                	cmp    %edx,%esi
 401:	76 e2                	jbe    3e5 <printint+0x26>
  if(neg)
 403:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 407:	74 24                	je     42d <printint+0x6e>
    buf[i++] = '-';
 409:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 40e:	8d 5f 02             	lea    0x2(%edi),%ebx
 411:	eb 1a                	jmp    42d <printint+0x6e>
    x = -xx;
 413:	89 d1                	mov    %edx,%ecx
 415:	f7 d9                	neg    %ecx
    neg = 1;
 417:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 41e:	eb c0                	jmp    3e0 <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 420:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 425:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 428:	e8 78 ff ff ff       	call   3a5 <putc>
  while(--i >= 0)
 42d:	4b                   	dec    %ebx
 42e:	79 f0                	jns    420 <printint+0x61>
}
 430:	83 c4 2c             	add    $0x2c,%esp
 433:	5b                   	pop    %ebx
 434:	5e                   	pop    %esi
 435:	5f                   	pop    %edi
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    

00000438 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 438:	55                   	push   %ebp
 439:	89 e5                	mov    %esp,%ebp
 43b:	57                   	push   %edi
 43c:	56                   	push   %esi
 43d:	53                   	push   %ebx
 43e:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 441:	8d 45 10             	lea    0x10(%ebp),%eax
 444:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 447:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 44c:	bb 00 00 00 00       	mov    $0x0,%ebx
 451:	eb 12                	jmp    465 <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 453:	89 fa                	mov    %edi,%edx
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	e8 48 ff ff ff       	call   3a5 <putc>
 45d:	eb 05                	jmp    464 <printf+0x2c>
      }
    } else if(state == '%'){
 45f:	83 fe 25             	cmp    $0x25,%esi
 462:	74 22                	je     486 <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 464:	43                   	inc    %ebx
 465:	8b 45 0c             	mov    0xc(%ebp),%eax
 468:	8a 04 18             	mov    (%eax,%ebx,1),%al
 46b:	84 c0                	test   %al,%al
 46d:	0f 84 1d 01 00 00    	je     590 <printf+0x158>
    c = fmt[i] & 0xff;
 473:	0f be f8             	movsbl %al,%edi
 476:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 479:	85 f6                	test   %esi,%esi
 47b:	75 e2                	jne    45f <printf+0x27>
      if(c == '%'){
 47d:	83 f8 25             	cmp    $0x25,%eax
 480:	75 d1                	jne    453 <printf+0x1b>
        state = '%';
 482:	89 c6                	mov    %eax,%esi
 484:	eb de                	jmp    464 <printf+0x2c>
      if(c == 'd'){
 486:	83 f8 25             	cmp    $0x25,%eax
 489:	0f 84 cc 00 00 00    	je     55b <printf+0x123>
 48f:	0f 8c da 00 00 00    	jl     56f <printf+0x137>
 495:	83 f8 78             	cmp    $0x78,%eax
 498:	0f 8f d1 00 00 00    	jg     56f <printf+0x137>
 49e:	83 f8 63             	cmp    $0x63,%eax
 4a1:	0f 8c c8 00 00 00    	jl     56f <printf+0x137>
 4a7:	83 e8 63             	sub    $0x63,%eax
 4aa:	83 f8 15             	cmp    $0x15,%eax
 4ad:	0f 87 bc 00 00 00    	ja     56f <printf+0x137>
 4b3:	ff 24 85 d8 05 00 00 	jmp    *0x5d8(,%eax,4)
        printint(fd, *ap, 10, 1);
 4ba:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4bd:	8b 17                	mov    (%edi),%edx
 4bf:	83 ec 0c             	sub    $0xc,%esp
 4c2:	6a 01                	push   $0x1
 4c4:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4c9:	8b 45 08             	mov    0x8(%ebp),%eax
 4cc:	e8 ee fe ff ff       	call   3bf <printint>
        ap++;
 4d1:	83 c7 04             	add    $0x4,%edi
 4d4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4d7:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4da:	be 00 00 00 00       	mov    $0x0,%esi
 4df:	eb 83                	jmp    464 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 4e1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4e4:	8b 17                	mov    (%edi),%edx
 4e6:	83 ec 0c             	sub    $0xc,%esp
 4e9:	6a 00                	push   $0x0
 4eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f0:	8b 45 08             	mov    0x8(%ebp),%eax
 4f3:	e8 c7 fe ff ff       	call   3bf <printint>
        ap++;
 4f8:	83 c7 04             	add    $0x4,%edi
 4fb:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4fe:	83 c4 10             	add    $0x10,%esp
      state = 0;
 501:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 506:	e9 59 ff ff ff       	jmp    464 <printf+0x2c>
        s = (char*)*ap;
 50b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50e:	8b 30                	mov    (%eax),%esi
        ap++;
 510:	83 c0 04             	add    $0x4,%eax
 513:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 516:	85 f6                	test   %esi,%esi
 518:	75 13                	jne    52d <printf+0xf5>
          s = "(null)";
 51a:	be cf 05 00 00       	mov    $0x5cf,%esi
 51f:	eb 0c                	jmp    52d <printf+0xf5>
          putc(fd, *s);
 521:	0f be d2             	movsbl %dl,%edx
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	e8 79 fe ff ff       	call   3a5 <putc>
          s++;
 52c:	46                   	inc    %esi
        while(*s != 0){
 52d:	8a 16                	mov    (%esi),%dl
 52f:	84 d2                	test   %dl,%dl
 531:	75 ee                	jne    521 <printf+0xe9>
      state = 0;
 533:	be 00 00 00 00       	mov    $0x0,%esi
 538:	e9 27 ff ff ff       	jmp    464 <printf+0x2c>
        putc(fd, *ap);
 53d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 540:	0f be 17             	movsbl (%edi),%edx
 543:	8b 45 08             	mov    0x8(%ebp),%eax
 546:	e8 5a fe ff ff       	call   3a5 <putc>
        ap++;
 54b:	83 c7 04             	add    $0x4,%edi
 54e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 551:	be 00 00 00 00       	mov    $0x0,%esi
 556:	e9 09 ff ff ff       	jmp    464 <printf+0x2c>
        putc(fd, c);
 55b:	89 fa                	mov    %edi,%edx
 55d:	8b 45 08             	mov    0x8(%ebp),%eax
 560:	e8 40 fe ff ff       	call   3a5 <putc>
      state = 0;
 565:	be 00 00 00 00       	mov    $0x0,%esi
 56a:	e9 f5 fe ff ff       	jmp    464 <printf+0x2c>
        putc(fd, '%');
 56f:	ba 25 00 00 00       	mov    $0x25,%edx
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	e8 29 fe ff ff       	call   3a5 <putc>
        putc(fd, c);
 57c:	89 fa                	mov    %edi,%edx
 57e:	8b 45 08             	mov    0x8(%ebp),%eax
 581:	e8 1f fe ff ff       	call   3a5 <putc>
      state = 0;
 586:	be 00 00 00 00       	mov    $0x0,%esi
 58b:	e9 d4 fe ff ff       	jmp    464 <printf+0x2c>
    }
  }
}
 590:	8d 65 f4             	lea    -0xc(%ebp),%esp
 593:	5b                   	pop    %ebx
 594:	5e                   	pop    %esi
 595:	5f                   	pop    %edi
 596:	5d                   	pop    %ebp
 597:	c3                   	ret    
