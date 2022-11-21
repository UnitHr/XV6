
grep:     file format elf32-i386


Disassembly of section .text:

00000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	8b 75 08             	mov    0x8(%ebp),%esi
   c:	8b 7d 0c             	mov    0xc(%ebp),%edi
   f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  12:	83 ec 08             	sub    $0x8,%esp
  15:	53                   	push   %ebx
  16:	57                   	push   %edi
  17:	e8 29 00 00 00       	call   45 <matchhere>
  1c:	83 c4 10             	add    $0x10,%esp
  1f:	85 c0                	test   %eax,%eax
  21:	75 15                	jne    38 <matchstar+0x38>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  23:	8a 13                	mov    (%ebx),%dl
  25:	84 d2                	test   %dl,%dl
  27:	74 14                	je     3d <matchstar+0x3d>
  29:	43                   	inc    %ebx
  2a:	0f be d2             	movsbl %dl,%edx
  2d:	39 f2                	cmp    %esi,%edx
  2f:	74 e1                	je     12 <matchstar+0x12>
  31:	83 fe 2e             	cmp    $0x2e,%esi
  34:	74 dc                	je     12 <matchstar+0x12>
  36:	eb 05                	jmp    3d <matchstar+0x3d>
      return 1;
  38:	b8 01 00 00 00       	mov    $0x1,%eax
  return 0;
}
  3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  40:	5b                   	pop    %ebx
  41:	5e                   	pop    %esi
  42:	5f                   	pop    %edi
  43:	5d                   	pop    %ebp
  44:	c3                   	ret    

00000045 <matchhere>:
{
  45:	55                   	push   %ebp
  46:	89 e5                	mov    %esp,%ebp
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	8b 55 08             	mov    0x8(%ebp),%edx
  if(re[0] == '\0')
  4e:	8a 02                	mov    (%edx),%al
  50:	84 c0                	test   %al,%al
  52:	74 62                	je     b6 <matchhere+0x71>
  if(re[1] == '*')
  54:	8a 4a 01             	mov    0x1(%edx),%cl
  57:	80 f9 2a             	cmp    $0x2a,%cl
  5a:	74 1c                	je     78 <matchhere+0x33>
  if(re[0] == '$' && re[1] == '\0')
  5c:	3c 24                	cmp    $0x24,%al
  5e:	74 30                	je     90 <matchhere+0x4b>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  60:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  63:	8a 09                	mov    (%ecx),%cl
  65:	84 c9                	test   %cl,%cl
  67:	74 54                	je     bd <matchhere+0x78>
  69:	3c 2e                	cmp    $0x2e,%al
  6b:	74 35                	je     a2 <matchhere+0x5d>
  6d:	38 c8                	cmp    %cl,%al
  6f:	74 31                	je     a2 <matchhere+0x5d>
  return 0;
  71:	b8 00 00 00 00       	mov    $0x0,%eax
  76:	eb 43                	jmp    bb <matchhere+0x76>
    return matchstar(re[0], re+2, text);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	ff 75 0c             	push   0xc(%ebp)
  7e:	83 c2 02             	add    $0x2,%edx
  81:	52                   	push   %edx
  82:	0f be c0             	movsbl %al,%eax
  85:	50                   	push   %eax
  86:	e8 75 ff ff ff       	call   0 <matchstar>
  8b:	83 c4 10             	add    $0x10,%esp
  8e:	eb 2b                	jmp    bb <matchhere+0x76>
  if(re[0] == '$' && re[1] == '\0')
  90:	84 c9                	test   %cl,%cl
  92:	75 cc                	jne    60 <matchhere+0x1b>
    return *text == '\0';
  94:	8b 45 0c             	mov    0xc(%ebp),%eax
  97:	80 38 00             	cmpb   $0x0,(%eax)
  9a:	0f 94 c0             	sete   %al
  9d:	0f b6 c0             	movzbl %al,%eax
  a0:	eb 19                	jmp    bb <matchhere+0x76>
    return matchhere(re+1, text+1);
  a2:	83 ec 08             	sub    $0x8,%esp
  a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  a8:	40                   	inc    %eax
  a9:	50                   	push   %eax
  aa:	42                   	inc    %edx
  ab:	52                   	push   %edx
  ac:	e8 94 ff ff ff       	call   45 <matchhere>
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	eb 05                	jmp    bb <matchhere+0x76>
    return 1;
  b6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  bb:	c9                   	leave  
  bc:	c3                   	ret    
  return 0;
  bd:	b8 00 00 00 00       	mov    $0x0,%eax
  c2:	eb f7                	jmp    bb <matchhere+0x76>

000000c4 <match>:
{
  c4:	55                   	push   %ebp
  c5:	89 e5                	mov    %esp,%ebp
  c7:	56                   	push   %esi
  c8:	53                   	push   %ebx
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
  cf:	80 3e 5e             	cmpb   $0x5e,(%esi)
  d2:	75 12                	jne    e6 <match+0x22>
    return matchhere(re+1, text);
  d4:	83 ec 08             	sub    $0x8,%esp
  d7:	53                   	push   %ebx
  d8:	46                   	inc    %esi
  d9:	56                   	push   %esi
  da:	e8 66 ff ff ff       	call   45 <matchhere>
  df:	83 c4 10             	add    $0x10,%esp
  e2:	eb 22                	jmp    106 <match+0x42>
  }while(*text++ != '\0');
  e4:	89 d3                	mov    %edx,%ebx
    if(matchhere(re, text))
  e6:	83 ec 08             	sub    $0x8,%esp
  e9:	53                   	push   %ebx
  ea:	56                   	push   %esi
  eb:	e8 55 ff ff ff       	call   45 <matchhere>
  f0:	83 c4 10             	add    $0x10,%esp
  f3:	85 c0                	test   %eax,%eax
  f5:	75 0a                	jne    101 <match+0x3d>
  }while(*text++ != '\0');
  f7:	8d 53 01             	lea    0x1(%ebx),%edx
  fa:	80 3b 00             	cmpb   $0x0,(%ebx)
  fd:	75 e5                	jne    e4 <match+0x20>
  ff:	eb 05                	jmp    106 <match+0x42>
      return 1;
 101:	b8 01 00 00 00       	mov    $0x1,%eax
}
 106:	8d 65 f8             	lea    -0x8(%ebp),%esp
 109:	5b                   	pop    %ebx
 10a:	5e                   	pop    %esi
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    

0000010d <grep>:
{
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
 110:	57                   	push   %edi
 111:	56                   	push   %esi
 112:	53                   	push   %ebx
 113:	83 ec 1c             	sub    $0x1c,%esp
 116:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
 119:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 120:	eb 53                	jmp    175 <grep+0x68>
      p = q+1;
 122:	8d 73 01             	lea    0x1(%ebx),%esi
    while((q = strchr(p, '\n')) != 0){
 125:	83 ec 08             	sub    $0x8,%esp
 128:	6a 0a                	push   $0xa
 12a:	56                   	push   %esi
 12b:	e8 ef 01 00 00       	call   31f <strchr>
 130:	89 c3                	mov    %eax,%ebx
 132:	83 c4 10             	add    $0x10,%esp
 135:	85 c0                	test   %eax,%eax
 137:	74 2d                	je     166 <grep+0x59>
      *q = 0;
 139:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 13c:	83 ec 08             	sub    $0x8,%esp
 13f:	56                   	push   %esi
 140:	57                   	push   %edi
 141:	e8 7e ff ff ff       	call   c4 <match>
 146:	83 c4 10             	add    $0x10,%esp
 149:	85 c0                	test   %eax,%eax
 14b:	74 d5                	je     122 <grep+0x15>
        *q = '\n';
 14d:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 150:	8d 43 01             	lea    0x1(%ebx),%eax
 153:	83 ec 04             	sub    $0x4,%esp
 156:	29 f0                	sub    %esi,%eax
 158:	50                   	push   %eax
 159:	56                   	push   %esi
 15a:	6a 01                	push   $0x1
 15c:	e8 f1 02 00 00       	call   452 <write>
 161:	83 c4 10             	add    $0x10,%esp
 164:	eb bc                	jmp    122 <grep+0x15>
    if(p == buf)
 166:	81 fe 60 0a 00 00    	cmp    $0xa60,%esi
 16c:	74 62                	je     1d0 <grep+0xc3>
    if(m > 0){
 16e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 171:	85 c9                	test   %ecx,%ecx
 173:	7f 3b                	jg     1b0 <grep+0xa3>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 175:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 17a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 17d:	29 c8                	sub    %ecx,%eax
 17f:	83 ec 04             	sub    $0x4,%esp
 182:	50                   	push   %eax
 183:	8d 81 60 0a 00 00    	lea    0xa60(%ecx),%eax
 189:	50                   	push   %eax
 18a:	ff 75 0c             	push   0xc(%ebp)
 18d:	e8 b8 02 00 00       	call   44a <read>
 192:	83 c4 10             	add    $0x10,%esp
 195:	85 c0                	test   %eax,%eax
 197:	7e 40                	jle    1d9 <grep+0xcc>
    m += n;
 199:	01 45 e4             	add    %eax,-0x1c(%ebp)
 19c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 19f:	c6 82 60 0a 00 00 00 	movb   $0x0,0xa60(%edx)
    p = buf;
 1a6:	be 60 0a 00 00       	mov    $0xa60,%esi
    while((q = strchr(p, '\n')) != 0){
 1ab:	e9 75 ff ff ff       	jmp    125 <grep+0x18>
      m -= p - buf;
 1b0:	89 f0                	mov    %esi,%eax
 1b2:	2d 60 0a 00 00       	sub    $0xa60,%eax
 1b7:	29 c1                	sub    %eax,%ecx
 1b9:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      memmove(buf, p, m);
 1bc:	83 ec 04             	sub    $0x4,%esp
 1bf:	51                   	push   %ecx
 1c0:	56                   	push   %esi
 1c1:	68 60 0a 00 00       	push   $0xa60
 1c6:	e8 36 02 00 00       	call   401 <memmove>
 1cb:	83 c4 10             	add    $0x10,%esp
 1ce:	eb a5                	jmp    175 <grep+0x68>
      m = 0;
 1d0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1d7:	eb 9c                	jmp    175 <grep+0x68>
}
 1d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1dc:	5b                   	pop    %ebx
 1dd:	5e                   	pop    %esi
 1de:	5f                   	pop    %edi
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret    

000001e1 <main>:
{
 1e1:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1e5:	83 e4 f0             	and    $0xfffffff0,%esp
 1e8:	ff 71 fc             	push   -0x4(%ecx)
 1eb:	55                   	push   %ebp
 1ec:	89 e5                	mov    %esp,%ebp
 1ee:	57                   	push   %edi
 1ef:	56                   	push   %esi
 1f0:	53                   	push   %ebx
 1f1:	51                   	push   %ecx
 1f2:	83 ec 18             	sub    $0x18,%esp
 1f5:	8b 01                	mov    (%ecx),%eax
 1f7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 1fa:	8b 51 04             	mov    0x4(%ecx),%edx
 1fd:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(argc <= 1){
 200:	83 f8 01             	cmp    $0x1,%eax
 203:	7e 52                	jle    257 <main+0x76>
  pattern = argv[1];
 205:	8b 45 e0             	mov    -0x20(%ebp),%eax
 208:	8b 40 04             	mov    0x4(%eax),%eax
 20b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(argc <= 2){
 20e:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
 212:	7e 5e                	jle    272 <main+0x91>
  for(i = 2; i < argc; i++){
 214:	be 02 00 00 00       	mov    $0x2,%esi
 219:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
 21c:	0f 8d 84 00 00 00    	jge    2a6 <main+0xc5>
    if((fd = open(argv[i], 0)) < 0){
 222:	8b 45 e0             	mov    -0x20(%ebp),%eax
 225:	8d 3c b0             	lea    (%eax,%esi,4),%edi
 228:	83 ec 08             	sub    $0x8,%esp
 22b:	6a 00                	push   $0x0
 22d:	ff 37                	push   (%edi)
 22f:	e8 3e 02 00 00       	call   472 <open>
 234:	89 c3                	mov    %eax,%ebx
 236:	83 c4 10             	add    $0x10,%esp
 239:	85 c0                	test   %eax,%eax
 23b:	78 4c                	js     289 <main+0xa8>
    grep(pattern, fd);
 23d:	83 ec 08             	sub    $0x8,%esp
 240:	50                   	push   %eax
 241:	ff 75 dc             	push   -0x24(%ebp)
 244:	e8 c4 fe ff ff       	call   10d <grep>
    close(fd);
 249:	89 1c 24             	mov    %ebx,(%esp)
 24c:	e8 09 02 00 00       	call   45a <close>
  for(i = 2; i < argc; i++){
 251:	46                   	inc    %esi
 252:	83 c4 10             	add    $0x10,%esp
 255:	eb c2                	jmp    219 <main+0x38>
    printf(2, "usage: grep pattern [file ...]\n");
 257:	83 ec 08             	sub    $0x8,%esp
 25a:	68 d8 06 00 00       	push   $0x6d8
 25f:	6a 02                	push   $0x2
 261:	e8 0f 03 00 00       	call   575 <printf>
    exit(0);
 266:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 26d:	e8 c0 01 00 00       	call   432 <exit>
    grep(pattern, 0);
 272:	83 ec 08             	sub    $0x8,%esp
 275:	6a 00                	push   $0x0
 277:	50                   	push   %eax
 278:	e8 90 fe ff ff       	call   10d <grep>
    exit(0);
 27d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 284:	e8 a9 01 00 00       	call   432 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
 289:	83 ec 04             	sub    $0x4,%esp
 28c:	ff 37                	push   (%edi)
 28e:	68 f8 06 00 00       	push   $0x6f8
 293:	6a 01                	push   $0x1
 295:	e8 db 02 00 00       	call   575 <printf>
      exit(0);
 29a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2a1:	e8 8c 01 00 00       	call   432 <exit>
  exit(0);
 2a6:	83 ec 0c             	sub    $0xc,%esp
 2a9:	6a 00                	push   $0x0
 2ab:	e8 82 01 00 00       	call   432 <exit>

000002b0 <start>:

// Entry point of the library	
void
start()
{
}
 2b0:	c3                   	ret    

000002b1 <strcpy>:

char*
strcpy(char *s, const char *t)
{
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2bc:	89 c2                	mov    %eax,%edx
 2be:	89 cb                	mov    %ecx,%ebx
 2c0:	41                   	inc    %ecx
 2c1:	89 d6                	mov    %edx,%esi
 2c3:	42                   	inc    %edx
 2c4:	8a 1b                	mov    (%ebx),%bl
 2c6:	88 1e                	mov    %bl,(%esi)
 2c8:	84 db                	test   %bl,%bl
 2ca:	75 f2                	jne    2be <strcpy+0xd>
    ;
  return os;
}
 2cc:	5b                   	pop    %ebx
 2cd:	5e                   	pop    %esi
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    

000002d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 2d9:	eb 02                	jmp    2dd <strcmp+0xd>
    p++, q++;
 2db:	41                   	inc    %ecx
 2dc:	42                   	inc    %edx
  while(*p && *p == *q)
 2dd:	8a 01                	mov    (%ecx),%al
 2df:	84 c0                	test   %al,%al
 2e1:	74 04                	je     2e7 <strcmp+0x17>
 2e3:	3a 02                	cmp    (%edx),%al
 2e5:	74 f4                	je     2db <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 2e7:	0f b6 c0             	movzbl %al,%eax
 2ea:	0f b6 12             	movzbl (%edx),%edx
 2ed:	29 d0                	sub    %edx,%eax
}
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    

000002f1 <strlen>:

uint
strlen(const char *s)
{
 2f1:	55                   	push   %ebp
 2f2:	89 e5                	mov    %esp,%ebp
 2f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f7:	b8 00 00 00 00       	mov    $0x0,%eax
 2fc:	eb 01                	jmp    2ff <strlen+0xe>
 2fe:	40                   	inc    %eax
 2ff:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 303:	75 f9                	jne    2fe <strlen+0xd>
    ;
  return n;
}
 305:	5d                   	pop    %ebp
 306:	c3                   	ret    

00000307 <memset>:

void*
memset(void *dst, int c, uint n)
{
 307:	55                   	push   %ebp
 308:	89 e5                	mov    %esp,%ebp
 30a:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 30b:	8b 7d 08             	mov    0x8(%ebp),%edi
 30e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 311:	8b 45 0c             	mov    0xc(%ebp),%eax
 314:	fc                   	cld    
 315:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 317:	8b 45 08             	mov    0x8(%ebp),%eax
 31a:	8b 7d fc             	mov    -0x4(%ebp),%edi
 31d:	c9                   	leave  
 31e:	c3                   	ret    

0000031f <strchr>:

char*
strchr(const char *s, char c)
{
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 328:	eb 01                	jmp    32b <strchr+0xc>
 32a:	40                   	inc    %eax
 32b:	8a 10                	mov    (%eax),%dl
 32d:	84 d2                	test   %dl,%dl
 32f:	74 06                	je     337 <strchr+0x18>
    if(*s == c)
 331:	38 ca                	cmp    %cl,%dl
 333:	75 f5                	jne    32a <strchr+0xb>
 335:	eb 05                	jmp    33c <strchr+0x1d>
      return (char*)s;
  return 0;
 337:	b8 00 00 00 00       	mov    $0x0,%eax
}
 33c:	5d                   	pop    %ebp
 33d:	c3                   	ret    

0000033e <gets>:

char*
gets(char *buf, int max)
{
 33e:	55                   	push   %ebp
 33f:	89 e5                	mov    %esp,%ebp
 341:	57                   	push   %edi
 342:	56                   	push   %esi
 343:	53                   	push   %ebx
 344:	83 ec 1c             	sub    $0x1c,%esp
 347:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34a:	bb 00 00 00 00       	mov    $0x0,%ebx
 34f:	89 de                	mov    %ebx,%esi
 351:	43                   	inc    %ebx
 352:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 355:	7d 2b                	jge    382 <gets+0x44>
    cc = read(0, &c, 1);
 357:	83 ec 04             	sub    $0x4,%esp
 35a:	6a 01                	push   $0x1
 35c:	8d 45 e7             	lea    -0x19(%ebp),%eax
 35f:	50                   	push   %eax
 360:	6a 00                	push   $0x0
 362:	e8 e3 00 00 00       	call   44a <read>
    if(cc < 1)
 367:	83 c4 10             	add    $0x10,%esp
 36a:	85 c0                	test   %eax,%eax
 36c:	7e 14                	jle    382 <gets+0x44>
      break;
    buf[i++] = c;
 36e:	8a 45 e7             	mov    -0x19(%ebp),%al
 371:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 374:	3c 0a                	cmp    $0xa,%al
 376:	74 08                	je     380 <gets+0x42>
 378:	3c 0d                	cmp    $0xd,%al
 37a:	75 d3                	jne    34f <gets+0x11>
    buf[i++] = c;
 37c:	89 de                	mov    %ebx,%esi
 37e:	eb 02                	jmp    382 <gets+0x44>
 380:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 382:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 386:	89 f8                	mov    %edi,%eax
 388:	8d 65 f4             	lea    -0xc(%ebp),%esp
 38b:	5b                   	pop    %ebx
 38c:	5e                   	pop    %esi
 38d:	5f                   	pop    %edi
 38e:	5d                   	pop    %ebp
 38f:	c3                   	ret    

00000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 395:	83 ec 08             	sub    $0x8,%esp
 398:	6a 00                	push   $0x0
 39a:	ff 75 08             	push   0x8(%ebp)
 39d:	e8 d0 00 00 00       	call   472 <open>
  if(fd < 0)
 3a2:	83 c4 10             	add    $0x10,%esp
 3a5:	85 c0                	test   %eax,%eax
 3a7:	78 24                	js     3cd <stat+0x3d>
 3a9:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3ab:	83 ec 08             	sub    $0x8,%esp
 3ae:	ff 75 0c             	push   0xc(%ebp)
 3b1:	50                   	push   %eax
 3b2:	e8 d3 00 00 00       	call   48a <fstat>
 3b7:	89 c6                	mov    %eax,%esi
  close(fd);
 3b9:	89 1c 24             	mov    %ebx,(%esp)
 3bc:	e8 99 00 00 00       	call   45a <close>
  return r;
 3c1:	83 c4 10             	add    $0x10,%esp
}
 3c4:	89 f0                	mov    %esi,%eax
 3c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3c9:	5b                   	pop    %ebx
 3ca:	5e                   	pop    %esi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
    return -1;
 3cd:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3d2:	eb f0                	jmp    3c4 <stat+0x34>

000003d4 <atoi>:

int
atoi(const char *s)
{
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	53                   	push   %ebx
 3d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 3db:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 3e0:	eb 0e                	jmp    3f0 <atoi+0x1c>
    n = n*10 + *s++ - '0';
 3e2:	8d 14 92             	lea    (%edx,%edx,4),%edx
 3e5:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 3e8:	41                   	inc    %ecx
 3e9:	0f be c0             	movsbl %al,%eax
 3ec:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
  while('0' <= *s && *s <= '9')
 3f0:	8a 01                	mov    (%ecx),%al
 3f2:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3f5:	80 fb 09             	cmp    $0x9,%bl
 3f8:	76 e8                	jbe    3e2 <atoi+0xe>
  return n;
}
 3fa:	89 d0                	mov    %edx,%eax
 3fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ff:	c9                   	leave  
 400:	c3                   	ret    

00000401 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 401:	55                   	push   %ebp
 402:	89 e5                	mov    %esp,%ebp
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	8b 45 08             	mov    0x8(%ebp),%eax
 409:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 40c:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 40f:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 411:	eb 0c                	jmp    41f <memmove+0x1e>
    *dst++ = *src++;
 413:	8a 13                	mov    (%ebx),%dl
 415:	88 11                	mov    %dl,(%ecx)
 417:	8d 5b 01             	lea    0x1(%ebx),%ebx
 41a:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 41d:	89 f2                	mov    %esi,%edx
 41f:	8d 72 ff             	lea    -0x1(%edx),%esi
 422:	85 d2                	test   %edx,%edx
 424:	7f ed                	jg     413 <memmove+0x12>
  return vdst;
}
 426:	5b                   	pop    %ebx
 427:	5e                   	pop    %esi
 428:	5d                   	pop    %ebp
 429:	c3                   	ret    

0000042a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42a:	b8 01 00 00 00       	mov    $0x1,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <exit>:
SYSCALL(exit)
 432:	b8 02 00 00 00       	mov    $0x2,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <wait>:
SYSCALL(wait)
 43a:	b8 03 00 00 00       	mov    $0x3,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <pipe>:
SYSCALL(pipe)
 442:	b8 04 00 00 00       	mov    $0x4,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <read>:
SYSCALL(read)
 44a:	b8 05 00 00 00       	mov    $0x5,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <write>:
SYSCALL(write)
 452:	b8 10 00 00 00       	mov    $0x10,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <close>:
SYSCALL(close)
 45a:	b8 15 00 00 00       	mov    $0x15,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <kill>:
SYSCALL(kill)
 462:	b8 06 00 00 00       	mov    $0x6,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <exec>:
SYSCALL(exec)
 46a:	b8 07 00 00 00       	mov    $0x7,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <open>:
SYSCALL(open)
 472:	b8 0f 00 00 00       	mov    $0xf,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <mknod>:
SYSCALL(mknod)
 47a:	b8 11 00 00 00       	mov    $0x11,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <unlink>:
SYSCALL(unlink)
 482:	b8 12 00 00 00       	mov    $0x12,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <fstat>:
SYSCALL(fstat)
 48a:	b8 08 00 00 00       	mov    $0x8,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <link>:
SYSCALL(link)
 492:	b8 13 00 00 00       	mov    $0x13,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <mkdir>:
SYSCALL(mkdir)
 49a:	b8 14 00 00 00       	mov    $0x14,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <chdir>:
SYSCALL(chdir)
 4a2:	b8 09 00 00 00       	mov    $0x9,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <dup>:
SYSCALL(dup)
 4aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <getpid>:
SYSCALL(getpid)
 4b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <sbrk>:
SYSCALL(sbrk)
 4ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <sleep>:
SYSCALL(sleep)
 4c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <uptime>:
SYSCALL(uptime)
 4ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <date>:
SYSCALL(date)
 4d2:	b8 16 00 00 00       	mov    $0x16,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <dup2>:
SYSCALL(dup2)
 4da:	b8 17 00 00 00       	mov    $0x17,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4e2:	55                   	push   %ebp
 4e3:	89 e5                	mov    %esp,%ebp
 4e5:	83 ec 1c             	sub    $0x1c,%esp
 4e8:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 4eb:	6a 01                	push   $0x1
 4ed:	8d 55 f4             	lea    -0xc(%ebp),%edx
 4f0:	52                   	push   %edx
 4f1:	50                   	push   %eax
 4f2:	e8 5b ff ff ff       	call   452 <write>
}
 4f7:	83 c4 10             	add    $0x10,%esp
 4fa:	c9                   	leave  
 4fb:	c3                   	ret    

000004fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fc:	55                   	push   %ebp
 4fd:	89 e5                	mov    %esp,%ebp
 4ff:	57                   	push   %edi
 500:	56                   	push   %esi
 501:	53                   	push   %ebx
 502:	83 ec 2c             	sub    $0x2c,%esp
 505:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 508:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 50e:	74 04                	je     514 <printint+0x18>
 510:	85 d2                	test   %edx,%edx
 512:	78 3c                	js     550 <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 514:	89 d1                	mov    %edx,%ecx
  neg = 0;
 516:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
 51d:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 522:	89 c8                	mov    %ecx,%eax
 524:	ba 00 00 00 00       	mov    $0x0,%edx
 529:	f7 f6                	div    %esi
 52b:	89 df                	mov    %ebx,%edi
 52d:	43                   	inc    %ebx
 52e:	8a 92 70 07 00 00    	mov    0x770(%edx),%dl
 534:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 538:	89 ca                	mov    %ecx,%edx
 53a:	89 c1                	mov    %eax,%ecx
 53c:	39 d6                	cmp    %edx,%esi
 53e:	76 e2                	jbe    522 <printint+0x26>
  if(neg)
 540:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 544:	74 24                	je     56a <printint+0x6e>
    buf[i++] = '-';
 546:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 54b:	8d 5f 02             	lea    0x2(%edi),%ebx
 54e:	eb 1a                	jmp    56a <printint+0x6e>
    x = -xx;
 550:	89 d1                	mov    %edx,%ecx
 552:	f7 d9                	neg    %ecx
    neg = 1;
 554:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 55b:	eb c0                	jmp    51d <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
 55d:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 562:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 565:	e8 78 ff ff ff       	call   4e2 <putc>
  while(--i >= 0)
 56a:	4b                   	dec    %ebx
 56b:	79 f0                	jns    55d <printint+0x61>
}
 56d:	83 c4 2c             	add    $0x2c,%esp
 570:	5b                   	pop    %ebx
 571:	5e                   	pop    %esi
 572:	5f                   	pop    %edi
 573:	5d                   	pop    %ebp
 574:	c3                   	ret    

00000575 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 575:	55                   	push   %ebp
 576:	89 e5                	mov    %esp,%ebp
 578:	57                   	push   %edi
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
 57b:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 57e:	8d 45 10             	lea    0x10(%ebp),%eax
 581:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 584:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 589:	bb 00 00 00 00       	mov    $0x0,%ebx
 58e:	eb 12                	jmp    5a2 <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 590:	89 fa                	mov    %edi,%edx
 592:	8b 45 08             	mov    0x8(%ebp),%eax
 595:	e8 48 ff ff ff       	call   4e2 <putc>
 59a:	eb 05                	jmp    5a1 <printf+0x2c>
      }
    } else if(state == '%'){
 59c:	83 fe 25             	cmp    $0x25,%esi
 59f:	74 22                	je     5c3 <printf+0x4e>
  for(i = 0; fmt[i]; i++){
 5a1:	43                   	inc    %ebx
 5a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a5:	8a 04 18             	mov    (%eax,%ebx,1),%al
 5a8:	84 c0                	test   %al,%al
 5aa:	0f 84 1d 01 00 00    	je     6cd <printf+0x158>
    c = fmt[i] & 0xff;
 5b0:	0f be f8             	movsbl %al,%edi
 5b3:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 5b6:	85 f6                	test   %esi,%esi
 5b8:	75 e2                	jne    59c <printf+0x27>
      if(c == '%'){
 5ba:	83 f8 25             	cmp    $0x25,%eax
 5bd:	75 d1                	jne    590 <printf+0x1b>
        state = '%';
 5bf:	89 c6                	mov    %eax,%esi
 5c1:	eb de                	jmp    5a1 <printf+0x2c>
      if(c == 'd'){
 5c3:	83 f8 25             	cmp    $0x25,%eax
 5c6:	0f 84 cc 00 00 00    	je     698 <printf+0x123>
 5cc:	0f 8c da 00 00 00    	jl     6ac <printf+0x137>
 5d2:	83 f8 78             	cmp    $0x78,%eax
 5d5:	0f 8f d1 00 00 00    	jg     6ac <printf+0x137>
 5db:	83 f8 63             	cmp    $0x63,%eax
 5de:	0f 8c c8 00 00 00    	jl     6ac <printf+0x137>
 5e4:	83 e8 63             	sub    $0x63,%eax
 5e7:	83 f8 15             	cmp    $0x15,%eax
 5ea:	0f 87 bc 00 00 00    	ja     6ac <printf+0x137>
 5f0:	ff 24 85 18 07 00 00 	jmp    *0x718(,%eax,4)
        printint(fd, *ap, 10, 1);
 5f7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5fa:	8b 17                	mov    (%edi),%edx
 5fc:	83 ec 0c             	sub    $0xc,%esp
 5ff:	6a 01                	push   $0x1
 601:	b9 0a 00 00 00       	mov    $0xa,%ecx
 606:	8b 45 08             	mov    0x8(%ebp),%eax
 609:	e8 ee fe ff ff       	call   4fc <printint>
        ap++;
 60e:	83 c7 04             	add    $0x4,%edi
 611:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 614:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 617:	be 00 00 00 00       	mov    $0x0,%esi
 61c:	eb 83                	jmp    5a1 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 61e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 621:	8b 17                	mov    (%edi),%edx
 623:	83 ec 0c             	sub    $0xc,%esp
 626:	6a 00                	push   $0x0
 628:	b9 10 00 00 00       	mov    $0x10,%ecx
 62d:	8b 45 08             	mov    0x8(%ebp),%eax
 630:	e8 c7 fe ff ff       	call   4fc <printint>
        ap++;
 635:	83 c7 04             	add    $0x4,%edi
 638:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 63b:	83 c4 10             	add    $0x10,%esp
      state = 0;
 63e:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 643:	e9 59 ff ff ff       	jmp    5a1 <printf+0x2c>
        s = (char*)*ap;
 648:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64b:	8b 30                	mov    (%eax),%esi
        ap++;
 64d:	83 c0 04             	add    $0x4,%eax
 650:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 653:	85 f6                	test   %esi,%esi
 655:	75 13                	jne    66a <printf+0xf5>
          s = "(null)";
 657:	be 0e 07 00 00       	mov    $0x70e,%esi
 65c:	eb 0c                	jmp    66a <printf+0xf5>
          putc(fd, *s);
 65e:	0f be d2             	movsbl %dl,%edx
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	e8 79 fe ff ff       	call   4e2 <putc>
          s++;
 669:	46                   	inc    %esi
        while(*s != 0){
 66a:	8a 16                	mov    (%esi),%dl
 66c:	84 d2                	test   %dl,%dl
 66e:	75 ee                	jne    65e <printf+0xe9>
      state = 0;
 670:	be 00 00 00 00       	mov    $0x0,%esi
 675:	e9 27 ff ff ff       	jmp    5a1 <printf+0x2c>
        putc(fd, *ap);
 67a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 67d:	0f be 17             	movsbl (%edi),%edx
 680:	8b 45 08             	mov    0x8(%ebp),%eax
 683:	e8 5a fe ff ff       	call   4e2 <putc>
        ap++;
 688:	83 c7 04             	add    $0x4,%edi
 68b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 68e:	be 00 00 00 00       	mov    $0x0,%esi
 693:	e9 09 ff ff ff       	jmp    5a1 <printf+0x2c>
        putc(fd, c);
 698:	89 fa                	mov    %edi,%edx
 69a:	8b 45 08             	mov    0x8(%ebp),%eax
 69d:	e8 40 fe ff ff       	call   4e2 <putc>
      state = 0;
 6a2:	be 00 00 00 00       	mov    $0x0,%esi
 6a7:	e9 f5 fe ff ff       	jmp    5a1 <printf+0x2c>
        putc(fd, '%');
 6ac:	ba 25 00 00 00       	mov    $0x25,%edx
 6b1:	8b 45 08             	mov    0x8(%ebp),%eax
 6b4:	e8 29 fe ff ff       	call   4e2 <putc>
        putc(fd, c);
 6b9:	89 fa                	mov    %edi,%edx
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	e8 1f fe ff ff       	call   4e2 <putc>
      state = 0;
 6c3:	be 00 00 00 00       	mov    $0x0,%esi
 6c8:	e9 d4 fe ff ff       	jmp    5a1 <printf+0x2c>
    }
  }
}
 6cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d0:	5b                   	pop    %ebx
 6d1:	5e                   	pop    %esi
 6d2:	5f                   	pop    %edi
 6d3:	5d                   	pop    %ebp
 6d4:	c3                   	ret    
