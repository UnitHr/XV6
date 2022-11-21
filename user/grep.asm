
grep:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	57                   	push   %edi
   8:	56                   	push   %esi
   9:	53                   	push   %ebx
   a:	83 ec 0c             	sub    $0xc,%esp
   d:	8b 75 08             	mov    0x8(%ebp),%esi
  10:	8b 7d 0c             	mov    0xc(%ebp),%edi
  13:	8b 5d 10             	mov    0x10(%ebp),%ebx
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  16:	83 ec 08             	sub    $0x8,%esp
  19:	53                   	push   %ebx
  1a:	57                   	push   %edi
  1b:	e8 29 00 00 00       	call   49 <matchhere>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	75 15                	jne    3c <matchstar+0x3c>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  27:	8a 13                	mov    (%ebx),%dl
  29:	84 d2                	test   %dl,%dl
  2b:	74 14                	je     41 <matchstar+0x41>
  2d:	43                   	inc    %ebx
  2e:	0f be d2             	movsbl %dl,%edx
  31:	39 f2                	cmp    %esi,%edx
  33:	74 e1                	je     16 <matchstar+0x16>
  35:	83 fe 2e             	cmp    $0x2e,%esi
  38:	74 dc                	je     16 <matchstar+0x16>
  3a:	eb 05                	jmp    41 <matchstar+0x41>
      return 1;
  3c:	b8 01 00 00 00       	mov    $0x1,%eax
  return 0;
}
  41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  44:	5b                   	pop    %ebx
  45:	5e                   	pop    %esi
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <matchhere>:
{
  49:	f3 0f 1e fb          	endbr32 
  4d:	55                   	push   %ebp
  4e:	89 e5                	mov    %esp,%ebp
  50:	83 ec 08             	sub    $0x8,%esp
  53:	8b 55 08             	mov    0x8(%ebp),%edx
  if(re[0] == '\0')
  56:	8a 02                	mov    (%edx),%al
  58:	84 c0                	test   %al,%al
  5a:	74 62                	je     be <matchhere+0x75>
  if(re[1] == '*')
  5c:	8a 4a 01             	mov    0x1(%edx),%cl
  5f:	80 f9 2a             	cmp    $0x2a,%cl
  62:	74 1c                	je     80 <matchhere+0x37>
  if(re[0] == '$' && re[1] == '\0')
  64:	3c 24                	cmp    $0x24,%al
  66:	74 30                	je     98 <matchhere+0x4f>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  68:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  6b:	8a 09                	mov    (%ecx),%cl
  6d:	84 c9                	test   %cl,%cl
  6f:	74 54                	je     c5 <matchhere+0x7c>
  71:	3c 2e                	cmp    $0x2e,%al
  73:	74 35                	je     aa <matchhere+0x61>
  75:	38 c8                	cmp    %cl,%al
  77:	74 31                	je     aa <matchhere+0x61>
  return 0;
  79:	b8 00 00 00 00       	mov    $0x0,%eax
  7e:	eb 43                	jmp    c3 <matchhere+0x7a>
    return matchstar(re[0], re+2, text);
  80:	83 ec 04             	sub    $0x4,%esp
  83:	ff 75 0c             	pushl  0xc(%ebp)
  86:	83 c2 02             	add    $0x2,%edx
  89:	52                   	push   %edx
  8a:	0f be c0             	movsbl %al,%eax
  8d:	50                   	push   %eax
  8e:	e8 6d ff ff ff       	call   0 <matchstar>
  93:	83 c4 10             	add    $0x10,%esp
  96:	eb 2b                	jmp    c3 <matchhere+0x7a>
  if(re[0] == '$' && re[1] == '\0')
  98:	84 c9                	test   %cl,%cl
  9a:	75 cc                	jne    68 <matchhere+0x1f>
    return *text == '\0';
  9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  9f:	80 38 00             	cmpb   $0x0,(%eax)
  a2:	0f 94 c0             	sete   %al
  a5:	0f b6 c0             	movzbl %al,%eax
  a8:	eb 19                	jmp    c3 <matchhere+0x7a>
    return matchhere(re+1, text+1);
  aa:	83 ec 08             	sub    $0x8,%esp
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	40                   	inc    %eax
  b1:	50                   	push   %eax
  b2:	42                   	inc    %edx
  b3:	52                   	push   %edx
  b4:	e8 90 ff ff ff       	call   49 <matchhere>
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	eb 05                	jmp    c3 <matchhere+0x7a>
    return 1;
  be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  c3:	c9                   	leave  
  c4:	c3                   	ret    
  return 0;
  c5:	b8 00 00 00 00       	mov    $0x0,%eax
  ca:	eb f7                	jmp    c3 <matchhere+0x7a>

000000cc <match>:
{
  cc:	f3 0f 1e fb          	endbr32 
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	56                   	push   %esi
  d4:	53                   	push   %ebx
  d5:	8b 75 08             	mov    0x8(%ebp),%esi
  d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
  db:	80 3e 5e             	cmpb   $0x5e,(%esi)
  de:	75 12                	jne    f2 <match+0x26>
    return matchhere(re+1, text);
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	53                   	push   %ebx
  e4:	46                   	inc    %esi
  e5:	56                   	push   %esi
  e6:	e8 5e ff ff ff       	call   49 <matchhere>
  eb:	83 c4 10             	add    $0x10,%esp
  ee:	eb 22                	jmp    112 <match+0x46>
  }while(*text++ != '\0');
  f0:	89 d3                	mov    %edx,%ebx
    if(matchhere(re, text))
  f2:	83 ec 08             	sub    $0x8,%esp
  f5:	53                   	push   %ebx
  f6:	56                   	push   %esi
  f7:	e8 4d ff ff ff       	call   49 <matchhere>
  fc:	83 c4 10             	add    $0x10,%esp
  ff:	85 c0                	test   %eax,%eax
 101:	75 0a                	jne    10d <match+0x41>
  }while(*text++ != '\0');
 103:	8d 53 01             	lea    0x1(%ebx),%edx
 106:	80 3b 00             	cmpb   $0x0,(%ebx)
 109:	75 e5                	jne    f0 <match+0x24>
 10b:	eb 05                	jmp    112 <match+0x46>
      return 1;
 10d:	b8 01 00 00 00       	mov    $0x1,%eax
}
 112:	8d 65 f8             	lea    -0x8(%ebp),%esp
 115:	5b                   	pop    %ebx
 116:	5e                   	pop    %esi
 117:	5d                   	pop    %ebp
 118:	c3                   	ret    

00000119 <grep>:
{
 119:	f3 0f 1e fb          	endbr32 
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	57                   	push   %edi
 121:	56                   	push   %esi
 122:	53                   	push   %ebx
 123:	83 ec 1c             	sub    $0x1c,%esp
 126:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
 129:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 130:	eb 53                	jmp    185 <grep+0x6c>
        *q = '\n';
 132:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 135:	8d 43 01             	lea    0x1(%ebx),%eax
 138:	83 ec 04             	sub    $0x4,%esp
 13b:	29 f0                	sub    %esi,%eax
 13d:	50                   	push   %eax
 13e:	56                   	push   %esi
 13f:	6a 01                	push   $0x1
 141:	e8 21 03 00 00       	call   467 <write>
 146:	83 c4 10             	add    $0x10,%esp
      p = q+1;
 149:	8d 73 01             	lea    0x1(%ebx),%esi
    while((q = strchr(p, '\n')) != 0){
 14c:	83 ec 08             	sub    $0x8,%esp
 14f:	6a 0a                	push   $0xa
 151:	56                   	push   %esi
 152:	e8 cd 01 00 00       	call   324 <strchr>
 157:	89 c3                	mov    %eax,%ebx
 159:	83 c4 10             	add    $0x10,%esp
 15c:	85 c0                	test   %eax,%eax
 15e:	74 16                	je     176 <grep+0x5d>
      *q = 0;
 160:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 163:	83 ec 08             	sub    $0x8,%esp
 166:	56                   	push   %esi
 167:	57                   	push   %edi
 168:	e8 5f ff ff ff       	call   cc <match>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	85 c0                	test   %eax,%eax
 172:	74 d5                	je     149 <grep+0x30>
 174:	eb bc                	jmp    132 <grep+0x19>
    if(p == buf)
 176:	81 fe 00 0a 00 00    	cmp    $0xa00,%esi
 17c:	74 5f                	je     1dd <grep+0xc4>
    if(m > 0){
 17e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 181:	85 c9                	test   %ecx,%ecx
 183:	7f 38                	jg     1bd <grep+0xa4>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 185:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 18a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 18d:	29 c8                	sub    %ecx,%eax
 18f:	83 ec 04             	sub    $0x4,%esp
 192:	50                   	push   %eax
 193:	8d 81 00 0a 00 00    	lea    0xa00(%ecx),%eax
 199:	50                   	push   %eax
 19a:	ff 75 0c             	pushl  0xc(%ebp)
 19d:	e8 bd 02 00 00       	call   45f <read>
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	85 c0                	test   %eax,%eax
 1a7:	7e 3d                	jle    1e6 <grep+0xcd>
    m += n;
 1a9:	01 45 e4             	add    %eax,-0x1c(%ebp)
 1ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 1af:	c6 82 00 0a 00 00 00 	movb   $0x0,0xa00(%edx)
    p = buf;
 1b6:	be 00 0a 00 00       	mov    $0xa00,%esi
    while((q = strchr(p, '\n')) != 0){
 1bb:	eb 8f                	jmp    14c <grep+0x33>
      m -= p - buf;
 1bd:	89 f0                	mov    %esi,%eax
 1bf:	2d 00 0a 00 00       	sub    $0xa00,%eax
 1c4:	29 c1                	sub    %eax,%ecx
 1c6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      memmove(buf, p, m);
 1c9:	83 ec 04             	sub    $0x4,%esp
 1cc:	51                   	push   %ecx
 1cd:	56                   	push   %esi
 1ce:	68 00 0a 00 00       	push   $0xa00
 1d3:	e8 3a 02 00 00       	call   412 <memmove>
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	eb a8                	jmp    185 <grep+0x6c>
      m = 0;
 1dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1e4:	eb 9f                	jmp    185 <grep+0x6c>
}
 1e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5f                   	pop    %edi
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    

000001ee <main>:
{
 1ee:	f3 0f 1e fb          	endbr32 
 1f2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1f6:	83 e4 f0             	and    $0xfffffff0,%esp
 1f9:	ff 71 fc             	pushl  -0x4(%ecx)
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	57                   	push   %edi
 200:	56                   	push   %esi
 201:	53                   	push   %ebx
 202:	51                   	push   %ecx
 203:	83 ec 18             	sub    $0x18,%esp
 206:	8b 01                	mov    (%ecx),%eax
 208:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 20b:	8b 51 04             	mov    0x4(%ecx),%edx
 20e:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(argc <= 1){
 211:	83 f8 01             	cmp    $0x1,%eax
 214:	7e 4e                	jle    264 <main+0x76>
  pattern = argv[1];
 216:	8b 45 e0             	mov    -0x20(%ebp),%eax
 219:	8b 40 04             	mov    0x4(%eax),%eax
 21c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(argc <= 2){
 21f:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
 223:	7e 53                	jle    278 <main+0x8a>
  for(i = 2; i < argc; i++){
 225:	be 02 00 00 00       	mov    $0x2,%esi
 22a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
 22d:	7d 6f                	jge    29e <main+0xb0>
    if((fd = open(argv[i], 0)) < 0){
 22f:	8b 45 e0             	mov    -0x20(%ebp),%eax
 232:	8d 3c b0             	lea    (%eax,%esi,4),%edi
 235:	83 ec 08             	sub    $0x8,%esp
 238:	6a 00                	push   $0x0
 23a:	ff 37                	pushl  (%edi)
 23c:	e8 46 02 00 00       	call   487 <open>
 241:	89 c3                	mov    %eax,%ebx
 243:	83 c4 10             	add    $0x10,%esp
 246:	85 c0                	test   %eax,%eax
 248:	78 3e                	js     288 <main+0x9a>
    grep(pattern, fd);
 24a:	83 ec 08             	sub    $0x8,%esp
 24d:	50                   	push   %eax
 24e:	ff 75 dc             	pushl  -0x24(%ebp)
 251:	e8 c3 fe ff ff       	call   119 <grep>
    close(fd);
 256:	89 1c 24             	mov    %ebx,(%esp)
 259:	e8 11 02 00 00       	call   46f <close>
  for(i = 2; i < argc; i++){
 25e:	46                   	inc    %esi
 25f:	83 c4 10             	add    $0x10,%esp
 262:	eb c6                	jmp    22a <main+0x3c>
    printf(2, "usage: grep pattern [file ...]\n");
 264:	83 ec 08             	sub    $0x8,%esp
 267:	68 e0 06 00 00       	push   $0x6e0
 26c:	6a 02                	push   $0x2
 26e:	e8 13 03 00 00       	call   586 <printf>
    exit();
 273:	e8 cf 01 00 00       	call   447 <exit>
    grep(pattern, 0);
 278:	83 ec 08             	sub    $0x8,%esp
 27b:	6a 00                	push   $0x0
 27d:	50                   	push   %eax
 27e:	e8 96 fe ff ff       	call   119 <grep>
    exit();
 283:	e8 bf 01 00 00       	call   447 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
 288:	83 ec 04             	sub    $0x4,%esp
 28b:	ff 37                	pushl  (%edi)
 28d:	68 00 07 00 00       	push   $0x700
 292:	6a 01                	push   $0x1
 294:	e8 ed 02 00 00       	call   586 <printf>
      exit();
 299:	e8 a9 01 00 00       	call   447 <exit>
  exit();
 29e:	e8 a4 01 00 00       	call   447 <exit>

000002a3 <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
 2a3:	f3 0f 1e fb          	endbr32 
}
 2a7:	c3                   	ret    

000002a8 <strcpy>:

char*
strcpy(char *s, const char *t)
{
 2a8:	f3 0f 1e fb          	endbr32 
 2ac:	55                   	push   %ebp
 2ad:	89 e5                	mov    %esp,%ebp
 2af:	56                   	push   %esi
 2b0:	53                   	push   %ebx
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b7:	89 c2                	mov    %eax,%edx
 2b9:	89 cb                	mov    %ecx,%ebx
 2bb:	41                   	inc    %ecx
 2bc:	89 d6                	mov    %edx,%esi
 2be:	42                   	inc    %edx
 2bf:	8a 1b                	mov    (%ebx),%bl
 2c1:	88 1e                	mov    %bl,(%esi)
 2c3:	84 db                	test   %bl,%bl
 2c5:	75 f2                	jne    2b9 <strcpy+0x11>
    ;
  return os;
}
 2c7:	5b                   	pop    %ebx
 2c8:	5e                   	pop    %esi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret    

000002cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2cb:	f3 0f 1e fb          	endbr32 
 2cf:	55                   	push   %ebp
 2d0:	89 e5                	mov    %esp,%ebp
 2d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 2d8:	8a 01                	mov    (%ecx),%al
 2da:	84 c0                	test   %al,%al
 2dc:	74 08                	je     2e6 <strcmp+0x1b>
 2de:	3a 02                	cmp    (%edx),%al
 2e0:	75 04                	jne    2e6 <strcmp+0x1b>
    p++, q++;
 2e2:	41                   	inc    %ecx
 2e3:	42                   	inc    %edx
 2e4:	eb f2                	jmp    2d8 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 2e6:	0f b6 c0             	movzbl %al,%eax
 2e9:	0f b6 12             	movzbl (%edx),%edx
 2ec:	29 d0                	sub    %edx,%eax
}
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    

000002f0 <strlen>:

uint
strlen(const char *s)
{
 2f0:	f3 0f 1e fb          	endbr32 
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2fa:	b8 00 00 00 00       	mov    $0x0,%eax
 2ff:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 303:	74 03                	je     308 <strlen+0x18>
 305:	40                   	inc    %eax
 306:	eb f7                	jmp    2ff <strlen+0xf>
    ;
  return n;
}
 308:	5d                   	pop    %ebp
 309:	c3                   	ret    

0000030a <memset>:

void*
memset(void *dst, int c, uint n)
{
 30a:	f3 0f 1e fb          	endbr32 
 30e:	55                   	push   %ebp
 30f:	89 e5                	mov    %esp,%ebp
 311:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 312:	8b 7d 08             	mov    0x8(%ebp),%edi
 315:	8b 4d 10             	mov    0x10(%ebp),%ecx
 318:	8b 45 0c             	mov    0xc(%ebp),%eax
 31b:	fc                   	cld    
 31c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 31e:	8b 45 08             	mov    0x8(%ebp),%eax
 321:	5f                   	pop    %edi
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    

00000324 <strchr>:

char*
strchr(const char *s, char c)
{
 324:	f3 0f 1e fb          	endbr32 
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 331:	8a 10                	mov    (%eax),%dl
 333:	84 d2                	test   %dl,%dl
 335:	74 07                	je     33e <strchr+0x1a>
    if(*s == c)
 337:	38 ca                	cmp    %cl,%dl
 339:	74 08                	je     343 <strchr+0x1f>
  for(; *s; s++)
 33b:	40                   	inc    %eax
 33c:	eb f3                	jmp    331 <strchr+0xd>
      return (char*)s;
  return 0;
 33e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 343:	5d                   	pop    %ebp
 344:	c3                   	ret    

00000345 <gets>:

char*
gets(char *buf, int max)
{
 345:	f3 0f 1e fb          	endbr32 
 349:	55                   	push   %ebp
 34a:	89 e5                	mov    %esp,%ebp
 34c:	57                   	push   %edi
 34d:	56                   	push   %esi
 34e:	53                   	push   %ebx
 34f:	83 ec 1c             	sub    $0x1c,%esp
 352:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 355:	bb 00 00 00 00       	mov    $0x0,%ebx
 35a:	89 de                	mov    %ebx,%esi
 35c:	43                   	inc    %ebx
 35d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 360:	7d 2b                	jge    38d <gets+0x48>
    cc = read(0, &c, 1);
 362:	83 ec 04             	sub    $0x4,%esp
 365:	6a 01                	push   $0x1
 367:	8d 45 e7             	lea    -0x19(%ebp),%eax
 36a:	50                   	push   %eax
 36b:	6a 00                	push   $0x0
 36d:	e8 ed 00 00 00       	call   45f <read>
    if(cc < 1)
 372:	83 c4 10             	add    $0x10,%esp
 375:	85 c0                	test   %eax,%eax
 377:	7e 14                	jle    38d <gets+0x48>
      break;
    buf[i++] = c;
 379:	8a 45 e7             	mov    -0x19(%ebp),%al
 37c:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 37f:	3c 0a                	cmp    $0xa,%al
 381:	74 08                	je     38b <gets+0x46>
 383:	3c 0d                	cmp    $0xd,%al
 385:	75 d3                	jne    35a <gets+0x15>
    buf[i++] = c;
 387:	89 de                	mov    %ebx,%esi
 389:	eb 02                	jmp    38d <gets+0x48>
 38b:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 38d:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 391:	89 f8                	mov    %edi,%eax
 393:	8d 65 f4             	lea    -0xc(%ebp),%esp
 396:	5b                   	pop    %ebx
 397:	5e                   	pop    %esi
 398:	5f                   	pop    %edi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret    

0000039b <stat>:

int
stat(const char *n, struct stat *st)
{
 39b:	f3 0f 1e fb          	endbr32 
 39f:	55                   	push   %ebp
 3a0:	89 e5                	mov    %esp,%ebp
 3a2:	56                   	push   %esi
 3a3:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a4:	83 ec 08             	sub    $0x8,%esp
 3a7:	6a 00                	push   $0x0
 3a9:	ff 75 08             	pushl  0x8(%ebp)
 3ac:	e8 d6 00 00 00       	call   487 <open>
  if(fd < 0)
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	85 c0                	test   %eax,%eax
 3b6:	78 24                	js     3dc <stat+0x41>
 3b8:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3ba:	83 ec 08             	sub    $0x8,%esp
 3bd:	ff 75 0c             	pushl  0xc(%ebp)
 3c0:	50                   	push   %eax
 3c1:	e8 d9 00 00 00       	call   49f <fstat>
 3c6:	89 c6                	mov    %eax,%esi
  close(fd);
 3c8:	89 1c 24             	mov    %ebx,(%esp)
 3cb:	e8 9f 00 00 00       	call   46f <close>
  return r;
 3d0:	83 c4 10             	add    $0x10,%esp
}
 3d3:	89 f0                	mov    %esi,%eax
 3d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3d8:	5b                   	pop    %ebx
 3d9:	5e                   	pop    %esi
 3da:	5d                   	pop    %ebp
 3db:	c3                   	ret    
    return -1;
 3dc:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3e1:	eb f0                	jmp    3d3 <stat+0x38>

000003e3 <atoi>:

int
atoi(const char *s)
{
 3e3:	f3 0f 1e fb          	endbr32 
 3e7:	55                   	push   %ebp
 3e8:	89 e5                	mov    %esp,%ebp
 3ea:	53                   	push   %ebx
 3eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 3ee:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 3f3:	8a 01                	mov    (%ecx),%al
 3f5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3f8:	80 fb 09             	cmp    $0x9,%bl
 3fb:	77 10                	ja     40d <atoi+0x2a>
    n = n*10 + *s++ - '0';
 3fd:	8d 14 92             	lea    (%edx,%edx,4),%edx
 400:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 403:	41                   	inc    %ecx
 404:	0f be c0             	movsbl %al,%eax
 407:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
 40b:	eb e6                	jmp    3f3 <atoi+0x10>
  return n;
}
 40d:	89 d0                	mov    %edx,%eax
 40f:	5b                   	pop    %ebx
 410:	5d                   	pop    %ebp
 411:	c3                   	ret    

00000412 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 412:	f3 0f 1e fb          	endbr32 
 416:	55                   	push   %ebp
 417:	89 e5                	mov    %esp,%ebp
 419:	56                   	push   %esi
 41a:	53                   	push   %ebx
 41b:	8b 45 08             	mov    0x8(%ebp),%eax
 41e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 421:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 424:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 426:	8d 72 ff             	lea    -0x1(%edx),%esi
 429:	85 d2                	test   %edx,%edx
 42b:	7e 0e                	jle    43b <memmove+0x29>
    *dst++ = *src++;
 42d:	8a 13                	mov    (%ebx),%dl
 42f:	88 11                	mov    %dl,(%ecx)
 431:	8d 5b 01             	lea    0x1(%ebx),%ebx
 434:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 437:	89 f2                	mov    %esi,%edx
 439:	eb eb                	jmp    426 <memmove+0x14>
  return vdst;
}
 43b:	5b                   	pop    %ebx
 43c:	5e                   	pop    %esi
 43d:	5d                   	pop    %ebp
 43e:	c3                   	ret    

0000043f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43f:	b8 01 00 00 00       	mov    $0x1,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <exit>:
SYSCALL(exit)
 447:	b8 02 00 00 00       	mov    $0x2,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <wait>:
SYSCALL(wait)
 44f:	b8 03 00 00 00       	mov    $0x3,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <pipe>:
SYSCALL(pipe)
 457:	b8 04 00 00 00       	mov    $0x4,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <read>:
SYSCALL(read)
 45f:	b8 05 00 00 00       	mov    $0x5,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <write>:
SYSCALL(write)
 467:	b8 10 00 00 00       	mov    $0x10,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <close>:
SYSCALL(close)
 46f:	b8 15 00 00 00       	mov    $0x15,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <kill>:
SYSCALL(kill)
 477:	b8 06 00 00 00       	mov    $0x6,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <exec>:
SYSCALL(exec)
 47f:	b8 07 00 00 00       	mov    $0x7,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <open>:
SYSCALL(open)
 487:	b8 0f 00 00 00       	mov    $0xf,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <mknod>:
SYSCALL(mknod)
 48f:	b8 11 00 00 00       	mov    $0x11,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <unlink>:
SYSCALL(unlink)
 497:	b8 12 00 00 00       	mov    $0x12,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret    

0000049f <fstat>:
SYSCALL(fstat)
 49f:	b8 08 00 00 00       	mov    $0x8,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret    

000004a7 <link>:
SYSCALL(link)
 4a7:	b8 13 00 00 00       	mov    $0x13,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret    

000004af <mkdir>:
SYSCALL(mkdir)
 4af:	b8 14 00 00 00       	mov    $0x14,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <chdir>:
SYSCALL(chdir)
 4b7:	b8 09 00 00 00       	mov    $0x9,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <dup>:
SYSCALL(dup)
 4bf:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <getpid>:
SYSCALL(getpid)
 4c7:	b8 0b 00 00 00       	mov    $0xb,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <sbrk>:
SYSCALL(sbrk)
 4cf:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <sleep>:
SYSCALL(sleep)
 4d7:	b8 0d 00 00 00       	mov    $0xd,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <uptime>:
SYSCALL(uptime)
 4df:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <date>:
SYSCALL(date)
 4e7:	b8 16 00 00 00       	mov    $0x16,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    

000004ef <dup2>:
SYSCALL(dup2)
 4ef:	b8 17 00 00 00       	mov    $0x17,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret    

000004f7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4f7:	55                   	push   %ebp
 4f8:	89 e5                	mov    %esp,%ebp
 4fa:	83 ec 1c             	sub    $0x1c,%esp
 4fd:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 500:	6a 01                	push   $0x1
 502:	8d 55 f4             	lea    -0xc(%ebp),%edx
 505:	52                   	push   %edx
 506:	50                   	push   %eax
 507:	e8 5b ff ff ff       	call   467 <write>
}
 50c:	83 c4 10             	add    $0x10,%esp
 50f:	c9                   	leave  
 510:	c3                   	ret    

00000511 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 511:	55                   	push   %ebp
 512:	89 e5                	mov    %esp,%ebp
 514:	57                   	push   %edi
 515:	56                   	push   %esi
 516:	53                   	push   %ebx
 517:	83 ec 2c             	sub    $0x2c,%esp
 51a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 51d:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 51f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 523:	74 04                	je     529 <printint+0x18>
 525:	85 d2                	test   %edx,%edx
 527:	78 3a                	js     563 <printint+0x52>
  neg = 0;
 529:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 530:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 535:	89 f0                	mov    %esi,%eax
 537:	ba 00 00 00 00       	mov    $0x0,%edx
 53c:	f7 f1                	div    %ecx
 53e:	89 df                	mov    %ebx,%edi
 540:	43                   	inc    %ebx
 541:	8a 92 20 07 00 00    	mov    0x720(%edx),%dl
 547:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 54b:	89 f2                	mov    %esi,%edx
 54d:	89 c6                	mov    %eax,%esi
 54f:	39 d1                	cmp    %edx,%ecx
 551:	76 e2                	jbe    535 <printint+0x24>
  if(neg)
 553:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 557:	74 22                	je     57b <printint+0x6a>
    buf[i++] = '-';
 559:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 55e:	8d 5f 02             	lea    0x2(%edi),%ebx
 561:	eb 18                	jmp    57b <printint+0x6a>
    x = -xx;
 563:	f7 de                	neg    %esi
    neg = 1;
 565:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 56c:	eb c2                	jmp    530 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 56e:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 573:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 576:	e8 7c ff ff ff       	call   4f7 <putc>
  while(--i >= 0)
 57b:	4b                   	dec    %ebx
 57c:	79 f0                	jns    56e <printint+0x5d>
}
 57e:	83 c4 2c             	add    $0x2c,%esp
 581:	5b                   	pop    %ebx
 582:	5e                   	pop    %esi
 583:	5f                   	pop    %edi
 584:	5d                   	pop    %ebp
 585:	c3                   	ret    

00000586 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 586:	f3 0f 1e fb          	endbr32 
 58a:	55                   	push   %ebp
 58b:	89 e5                	mov    %esp,%ebp
 58d:	57                   	push   %edi
 58e:	56                   	push   %esi
 58f:	53                   	push   %ebx
 590:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 593:	8d 45 10             	lea    0x10(%ebp),%eax
 596:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 599:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 59e:	bb 00 00 00 00       	mov    $0x0,%ebx
 5a3:	eb 12                	jmp    5b7 <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5a5:	89 fa                	mov    %edi,%edx
 5a7:	8b 45 08             	mov    0x8(%ebp),%eax
 5aa:	e8 48 ff ff ff       	call   4f7 <putc>
 5af:	eb 05                	jmp    5b6 <printf+0x30>
      }
    } else if(state == '%'){
 5b1:	83 fe 25             	cmp    $0x25,%esi
 5b4:	74 22                	je     5d8 <printf+0x52>
  for(i = 0; fmt[i]; i++){
 5b6:	43                   	inc    %ebx
 5b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ba:	8a 04 18             	mov    (%eax,%ebx,1),%al
 5bd:	84 c0                	test   %al,%al
 5bf:	0f 84 13 01 00 00    	je     6d8 <printf+0x152>
    c = fmt[i] & 0xff;
 5c5:	0f be f8             	movsbl %al,%edi
 5c8:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 5cb:	85 f6                	test   %esi,%esi
 5cd:	75 e2                	jne    5b1 <printf+0x2b>
      if(c == '%'){
 5cf:	83 f8 25             	cmp    $0x25,%eax
 5d2:	75 d1                	jne    5a5 <printf+0x1f>
        state = '%';
 5d4:	89 c6                	mov    %eax,%esi
 5d6:	eb de                	jmp    5b6 <printf+0x30>
      if(c == 'd'){
 5d8:	83 f8 64             	cmp    $0x64,%eax
 5db:	74 43                	je     620 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5dd:	83 f8 78             	cmp    $0x78,%eax
 5e0:	74 68                	je     64a <printf+0xc4>
 5e2:	83 f8 70             	cmp    $0x70,%eax
 5e5:	74 63                	je     64a <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e7:	83 f8 73             	cmp    $0x73,%eax
 5ea:	0f 84 84 00 00 00    	je     674 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f0:	83 f8 63             	cmp    $0x63,%eax
 5f3:	0f 84 ad 00 00 00    	je     6a6 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f9:	83 f8 25             	cmp    $0x25,%eax
 5fc:	0f 84 c2 00 00 00    	je     6c4 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 602:	ba 25 00 00 00       	mov    $0x25,%edx
 607:	8b 45 08             	mov    0x8(%ebp),%eax
 60a:	e8 e8 fe ff ff       	call   4f7 <putc>
        putc(fd, c);
 60f:	89 fa                	mov    %edi,%edx
 611:	8b 45 08             	mov    0x8(%ebp),%eax
 614:	e8 de fe ff ff       	call   4f7 <putc>
      }
      state = 0;
 619:	be 00 00 00 00       	mov    $0x0,%esi
 61e:	eb 96                	jmp    5b6 <printf+0x30>
        printint(fd, *ap, 10, 1);
 620:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 623:	8b 17                	mov    (%edi),%edx
 625:	83 ec 0c             	sub    $0xc,%esp
 628:	6a 01                	push   $0x1
 62a:	b9 0a 00 00 00       	mov    $0xa,%ecx
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	e8 da fe ff ff       	call   511 <printint>
        ap++;
 637:	83 c7 04             	add    $0x4,%edi
 63a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 63d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 640:	be 00 00 00 00       	mov    $0x0,%esi
 645:	e9 6c ff ff ff       	jmp    5b6 <printf+0x30>
        printint(fd, *ap, 16, 0);
 64a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 64d:	8b 17                	mov    (%edi),%edx
 64f:	83 ec 0c             	sub    $0xc,%esp
 652:	6a 00                	push   $0x0
 654:	b9 10 00 00 00       	mov    $0x10,%ecx
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	e8 b0 fe ff ff       	call   511 <printint>
        ap++;
 661:	83 c7 04             	add    $0x4,%edi
 664:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 667:	83 c4 10             	add    $0x10,%esp
      state = 0;
 66a:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 66f:	e9 42 ff ff ff       	jmp    5b6 <printf+0x30>
        s = (char*)*ap;
 674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 677:	8b 30                	mov    (%eax),%esi
        ap++;
 679:	83 c0 04             	add    $0x4,%eax
 67c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 67f:	85 f6                	test   %esi,%esi
 681:	75 13                	jne    696 <printf+0x110>
          s = "(null)";
 683:	be 16 07 00 00       	mov    $0x716,%esi
 688:	eb 0c                	jmp    696 <printf+0x110>
          putc(fd, *s);
 68a:	0f be d2             	movsbl %dl,%edx
 68d:	8b 45 08             	mov    0x8(%ebp),%eax
 690:	e8 62 fe ff ff       	call   4f7 <putc>
          s++;
 695:	46                   	inc    %esi
        while(*s != 0){
 696:	8a 16                	mov    (%esi),%dl
 698:	84 d2                	test   %dl,%dl
 69a:	75 ee                	jne    68a <printf+0x104>
      state = 0;
 69c:	be 00 00 00 00       	mov    $0x0,%esi
 6a1:	e9 10 ff ff ff       	jmp    5b6 <printf+0x30>
        putc(fd, *ap);
 6a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 6a9:	0f be 17             	movsbl (%edi),%edx
 6ac:	8b 45 08             	mov    0x8(%ebp),%eax
 6af:	e8 43 fe ff ff       	call   4f7 <putc>
        ap++;
 6b4:	83 c7 04             	add    $0x4,%edi
 6b7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 6ba:	be 00 00 00 00       	mov    $0x0,%esi
 6bf:	e9 f2 fe ff ff       	jmp    5b6 <printf+0x30>
        putc(fd, c);
 6c4:	89 fa                	mov    %edi,%edx
 6c6:	8b 45 08             	mov    0x8(%ebp),%eax
 6c9:	e8 29 fe ff ff       	call   4f7 <putc>
      state = 0;
 6ce:	be 00 00 00 00       	mov    $0x0,%esi
 6d3:	e9 de fe ff ff       	jmp    5b6 <printf+0x30>
    }
  }
}
 6d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret    
