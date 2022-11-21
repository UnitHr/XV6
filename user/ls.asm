
ls:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	83 ec 0c             	sub    $0xc,%esp
   f:	53                   	push   %ebx
  10:	e8 22 03 00 00       	call   337 <strlen>
  15:	01 d8                	add    %ebx,%eax
  17:	83 c4 10             	add    $0x10,%esp
  1a:	39 d8                	cmp    %ebx,%eax
  1c:	72 08                	jb     26 <fmtname+0x26>
  1e:	80 38 2f             	cmpb   $0x2f,(%eax)
  21:	74 03                	je     26 <fmtname+0x26>
  23:	48                   	dec    %eax
  24:	eb f4                	jmp    1a <fmtname+0x1a>
    ;
  p++;
  26:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	53                   	push   %ebx
  2d:	e8 05 03 00 00       	call   337 <strlen>
  32:	83 c4 10             	add    $0x10,%esp
  35:	83 f8 0d             	cmp    $0xd,%eax
  38:	76 09                	jbe    43 <fmtname+0x43>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  3a:	89 d8                	mov    %ebx,%eax
  3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  3f:	5b                   	pop    %ebx
  40:	5e                   	pop    %esi
  41:	5d                   	pop    %ebp
  42:	c3                   	ret    
  memmove(buf, p, strlen(p));
  43:	83 ec 0c             	sub    $0xc,%esp
  46:	53                   	push   %ebx
  47:	e8 eb 02 00 00       	call   337 <strlen>
  4c:	83 c4 0c             	add    $0xc,%esp
  4f:	50                   	push   %eax
  50:	53                   	push   %ebx
  51:	68 14 0a 00 00       	push   $0xa14
  56:	e8 fe 03 00 00       	call   459 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  5b:	89 1c 24             	mov    %ebx,(%esp)
  5e:	e8 d4 02 00 00       	call   337 <strlen>
  63:	89 c6                	mov    %eax,%esi
  65:	89 1c 24             	mov    %ebx,(%esp)
  68:	e8 ca 02 00 00       	call   337 <strlen>
  6d:	83 c4 0c             	add    $0xc,%esp
  70:	ba 0e 00 00 00       	mov    $0xe,%edx
  75:	29 f2                	sub    %esi,%edx
  77:	52                   	push   %edx
  78:	6a 20                	push   $0x20
  7a:	05 14 0a 00 00       	add    $0xa14,%eax
  7f:	50                   	push   %eax
  80:	e8 cc 02 00 00       	call   351 <memset>
  return buf;
  85:	83 c4 10             	add    $0x10,%esp
  88:	bb 14 0a 00 00       	mov    $0xa14,%ebx
  8d:	eb ab                	jmp    3a <fmtname+0x3a>

0000008f <ls>:

void
ls(char *path)
{
  8f:	f3 0f 1e fb          	endbr32 
  93:	55                   	push   %ebp
  94:	89 e5                	mov    %esp,%ebp
  96:	57                   	push   %edi
  97:	56                   	push   %esi
  98:	53                   	push   %ebx
  99:	81 ec 54 02 00 00    	sub    $0x254,%esp
  9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  a2:	6a 00                	push   $0x0
  a4:	53                   	push   %ebx
  a5:	e8 24 04 00 00       	call   4ce <open>
  aa:	83 c4 10             	add    $0x10,%esp
  ad:	85 c0                	test   %eax,%eax
  af:	0f 88 8b 00 00 00    	js     140 <ls+0xb1>
  b5:	89 c7                	mov    %eax,%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b7:	83 ec 08             	sub    $0x8,%esp
  ba:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
  c0:	50                   	push   %eax
  c1:	57                   	push   %edi
  c2:	e8 1f 04 00 00       	call   4e6 <fstat>
  c7:	83 c4 10             	add    $0x10,%esp
  ca:	85 c0                	test   %eax,%eax
  cc:	0f 88 83 00 00 00    	js     155 <ls+0xc6>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  d2:	8b 85 c4 fd ff ff    	mov    -0x23c(%ebp),%eax
  d8:	0f bf f0             	movswl %ax,%esi
  db:	66 83 f8 01          	cmp    $0x1,%ax
  df:	0f 84 8d 00 00 00    	je     172 <ls+0xe3>
  e5:	66 83 f8 02          	cmp    $0x2,%ax
  e9:	75 41                	jne    12c <ls+0x9d>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  eb:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
  f1:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
  f7:	8b 8d cc fd ff ff    	mov    -0x234(%ebp),%ecx
  fd:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 103:	83 ec 0c             	sub    $0xc,%esp
 106:	53                   	push   %ebx
 107:	e8 f4 fe ff ff       	call   0 <fmtname>
 10c:	83 c4 08             	add    $0x8,%esp
 10f:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 115:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 11b:	56                   	push   %esi
 11c:	50                   	push   %eax
 11d:	68 50 07 00 00       	push   $0x750
 122:	6a 01                	push   $0x1
 124:	e8 a4 04 00 00       	call   5cd <printf>
    break;
 129:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 12c:	83 ec 0c             	sub    $0xc,%esp
 12f:	57                   	push   %edi
 130:	e8 81 03 00 00       	call   4b6 <close>
 135:	83 c4 10             	add    $0x10,%esp
}
 138:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13b:	5b                   	pop    %ebx
 13c:	5e                   	pop    %esi
 13d:	5f                   	pop    %edi
 13e:	5d                   	pop    %ebp
 13f:	c3                   	ret    
    printf(2, "ls: cannot open %s\n", path);
 140:	83 ec 04             	sub    $0x4,%esp
 143:	53                   	push   %ebx
 144:	68 28 07 00 00       	push   $0x728
 149:	6a 02                	push   $0x2
 14b:	e8 7d 04 00 00       	call   5cd <printf>
    return;
 150:	83 c4 10             	add    $0x10,%esp
 153:	eb e3                	jmp    138 <ls+0xa9>
    printf(2, "ls: cannot stat %s\n", path);
 155:	83 ec 04             	sub    $0x4,%esp
 158:	53                   	push   %ebx
 159:	68 3c 07 00 00       	push   $0x73c
 15e:	6a 02                	push   $0x2
 160:	e8 68 04 00 00       	call   5cd <printf>
    close(fd);
 165:	89 3c 24             	mov    %edi,(%esp)
 168:	e8 49 03 00 00       	call   4b6 <close>
    return;
 16d:	83 c4 10             	add    $0x10,%esp
 170:	eb c6                	jmp    138 <ls+0xa9>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 172:	83 ec 0c             	sub    $0xc,%esp
 175:	53                   	push   %ebx
 176:	e8 bc 01 00 00       	call   337 <strlen>
 17b:	83 c0 10             	add    $0x10,%eax
 17e:	83 c4 10             	add    $0x10,%esp
 181:	3d 00 02 00 00       	cmp    $0x200,%eax
 186:	76 14                	jbe    19c <ls+0x10d>
      printf(1, "ls: path too long\n");
 188:	83 ec 08             	sub    $0x8,%esp
 18b:	68 5d 07 00 00       	push   $0x75d
 190:	6a 01                	push   $0x1
 192:	e8 36 04 00 00       	call   5cd <printf>
      break;
 197:	83 c4 10             	add    $0x10,%esp
 19a:	eb 90                	jmp    12c <ls+0x9d>
    strcpy(buf, path);
 19c:	83 ec 08             	sub    $0x8,%esp
 19f:	53                   	push   %ebx
 1a0:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
 1a6:	53                   	push   %ebx
 1a7:	e8 43 01 00 00       	call   2ef <strcpy>
    p = buf+strlen(buf);
 1ac:	89 1c 24             	mov    %ebx,(%esp)
 1af:	e8 83 01 00 00       	call   337 <strlen>
 1b4:	8d 34 03             	lea    (%ebx,%eax,1),%esi
    *p++ = '/';
 1b7:	8d 44 03 01          	lea    0x1(%ebx,%eax,1),%eax
 1bb:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 1c1:	c6 06 2f             	movb   $0x2f,(%esi)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1c4:	83 c4 10             	add    $0x10,%esp
 1c7:	eb 19                	jmp    1e2 <ls+0x153>
        printf(1, "ls: cannot stat %s\n", buf);
 1c9:	83 ec 04             	sub    $0x4,%esp
 1cc:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1d2:	50                   	push   %eax
 1d3:	68 3c 07 00 00       	push   $0x73c
 1d8:	6a 01                	push   $0x1
 1da:	e8 ee 03 00 00       	call   5cd <printf>
        continue;
 1df:	83 c4 10             	add    $0x10,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e2:	83 ec 04             	sub    $0x4,%esp
 1e5:	6a 10                	push   $0x10
 1e7:	8d 85 d8 fd ff ff    	lea    -0x228(%ebp),%eax
 1ed:	50                   	push   %eax
 1ee:	57                   	push   %edi
 1ef:	e8 b2 02 00 00       	call   4a6 <read>
 1f4:	83 c4 10             	add    $0x10,%esp
 1f7:	83 f8 10             	cmp    $0x10,%eax
 1fa:	0f 85 2c ff ff ff    	jne    12c <ls+0x9d>
      if(de.inum == 0)
 200:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
 207:	00 
 208:	74 d8                	je     1e2 <ls+0x153>
      memmove(p, de.name, DIRSIZ);
 20a:	83 ec 04             	sub    $0x4,%esp
 20d:	6a 0e                	push   $0xe
 20f:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
 215:	50                   	push   %eax
 216:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 21c:	e8 38 02 00 00       	call   459 <memmove>
      p[DIRSIZ] = 0;
 221:	c6 46 0f 00          	movb   $0x0,0xf(%esi)
      if(stat(buf, &st) < 0){
 225:	83 c4 08             	add    $0x8,%esp
 228:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 22e:	50                   	push   %eax
 22f:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 235:	50                   	push   %eax
 236:	e8 a7 01 00 00       	call   3e2 <stat>
 23b:	83 c4 10             	add    $0x10,%esp
 23e:	85 c0                	test   %eax,%eax
 240:	78 87                	js     1c9 <ls+0x13a>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 242:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
 248:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 24e:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
 254:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 25a:	8b 9d c4 fd ff ff    	mov    -0x23c(%ebp),%ebx
 260:	83 ec 0c             	sub    $0xc,%esp
 263:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 269:	50                   	push   %eax
 26a:	e8 91 fd ff ff       	call   0 <fmtname>
 26f:	83 c4 08             	add    $0x8,%esp
 272:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 278:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 27e:	0f bf db             	movswl %bx,%ebx
 281:	53                   	push   %ebx
 282:	50                   	push   %eax
 283:	68 50 07 00 00       	push   $0x750
 288:	6a 01                	push   $0x1
 28a:	e8 3e 03 00 00       	call   5cd <printf>
 28f:	83 c4 20             	add    $0x20,%esp
 292:	e9 4b ff ff ff       	jmp    1e2 <ls+0x153>

00000297 <main>:

int
main(int argc, char *argv[])
{
 297:	f3 0f 1e fb          	endbr32 
 29b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 29f:	83 e4 f0             	and    $0xfffffff0,%esp
 2a2:	ff 71 fc             	pushl  -0x4(%ecx)
 2a5:	55                   	push   %ebp
 2a6:	89 e5                	mov    %esp,%ebp
 2a8:	57                   	push   %edi
 2a9:	56                   	push   %esi
 2aa:	53                   	push   %ebx
 2ab:	51                   	push   %ecx
 2ac:	83 ec 08             	sub    $0x8,%esp
 2af:	8b 31                	mov    (%ecx),%esi
 2b1:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
 2b4:	83 fe 01             	cmp    $0x1,%esi
 2b7:	7e 07                	jle    2c0 <main+0x29>
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 2b9:	bb 01 00 00 00       	mov    $0x1,%ebx
 2be:	eb 21                	jmp    2e1 <main+0x4a>
    ls(".");
 2c0:	83 ec 0c             	sub    $0xc,%esp
 2c3:	68 70 07 00 00       	push   $0x770
 2c8:	e8 c2 fd ff ff       	call   8f <ls>
    exit();
 2cd:	e8 bc 01 00 00       	call   48e <exit>
    ls(argv[i]);
 2d2:	83 ec 0c             	sub    $0xc,%esp
 2d5:	ff 34 9f             	pushl  (%edi,%ebx,4)
 2d8:	e8 b2 fd ff ff       	call   8f <ls>
  for(i=1; i<argc; i++)
 2dd:	43                   	inc    %ebx
 2de:	83 c4 10             	add    $0x10,%esp
 2e1:	39 f3                	cmp    %esi,%ebx
 2e3:	7c ed                	jl     2d2 <main+0x3b>
  exit();
 2e5:	e8 a4 01 00 00       	call   48e <exit>

000002ea <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
 2ea:	f3 0f 1e fb          	endbr32 
}
 2ee:	c3                   	ret    

000002ef <strcpy>:

char*
strcpy(char *s, const char *t)
{
 2ef:	f3 0f 1e fb          	endbr32 
 2f3:	55                   	push   %ebp
 2f4:	89 e5                	mov    %esp,%ebp
 2f6:	56                   	push   %esi
 2f7:	53                   	push   %ebx
 2f8:	8b 45 08             	mov    0x8(%ebp),%eax
 2fb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2fe:	89 c2                	mov    %eax,%edx
 300:	89 cb                	mov    %ecx,%ebx
 302:	41                   	inc    %ecx
 303:	89 d6                	mov    %edx,%esi
 305:	42                   	inc    %edx
 306:	8a 1b                	mov    (%ebx),%bl
 308:	88 1e                	mov    %bl,(%esi)
 30a:	84 db                	test   %bl,%bl
 30c:	75 f2                	jne    300 <strcpy+0x11>
    ;
  return os;
}
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5d                   	pop    %ebp
 311:	c3                   	ret    

00000312 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 312:	f3 0f 1e fb          	endbr32 
 316:	55                   	push   %ebp
 317:	89 e5                	mov    %esp,%ebp
 319:	8b 4d 08             	mov    0x8(%ebp),%ecx
 31c:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 31f:	8a 01                	mov    (%ecx),%al
 321:	84 c0                	test   %al,%al
 323:	74 08                	je     32d <strcmp+0x1b>
 325:	3a 02                	cmp    (%edx),%al
 327:	75 04                	jne    32d <strcmp+0x1b>
    p++, q++;
 329:	41                   	inc    %ecx
 32a:	42                   	inc    %edx
 32b:	eb f2                	jmp    31f <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 32d:	0f b6 c0             	movzbl %al,%eax
 330:	0f b6 12             	movzbl (%edx),%edx
 333:	29 d0                	sub    %edx,%eax
}
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    

00000337 <strlen>:

uint
strlen(const char *s)
{
 337:	f3 0f 1e fb          	endbr32 
 33b:	55                   	push   %ebp
 33c:	89 e5                	mov    %esp,%ebp
 33e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 341:	b8 00 00 00 00       	mov    $0x0,%eax
 346:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 34a:	74 03                	je     34f <strlen+0x18>
 34c:	40                   	inc    %eax
 34d:	eb f7                	jmp    346 <strlen+0xf>
    ;
  return n;
}
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    

00000351 <memset>:

void*
memset(void *dst, int c, uint n)
{
 351:	f3 0f 1e fb          	endbr32 
 355:	55                   	push   %ebp
 356:	89 e5                	mov    %esp,%ebp
 358:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 359:	8b 7d 08             	mov    0x8(%ebp),%edi
 35c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 35f:	8b 45 0c             	mov    0xc(%ebp),%eax
 362:	fc                   	cld    
 363:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 365:	8b 45 08             	mov    0x8(%ebp),%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    

0000036b <strchr>:

char*
strchr(const char *s, char c)
{
 36b:	f3 0f 1e fb          	endbr32 
 36f:	55                   	push   %ebp
 370:	89 e5                	mov    %esp,%ebp
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 378:	8a 10                	mov    (%eax),%dl
 37a:	84 d2                	test   %dl,%dl
 37c:	74 07                	je     385 <strchr+0x1a>
    if(*s == c)
 37e:	38 ca                	cmp    %cl,%dl
 380:	74 08                	je     38a <strchr+0x1f>
  for(; *s; s++)
 382:	40                   	inc    %eax
 383:	eb f3                	jmp    378 <strchr+0xd>
      return (char*)s;
  return 0;
 385:	b8 00 00 00 00       	mov    $0x0,%eax
}
 38a:	5d                   	pop    %ebp
 38b:	c3                   	ret    

0000038c <gets>:

char*
gets(char *buf, int max)
{
 38c:	f3 0f 1e fb          	endbr32 
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 1c             	sub    $0x1c,%esp
 399:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39c:	bb 00 00 00 00       	mov    $0x0,%ebx
 3a1:	89 de                	mov    %ebx,%esi
 3a3:	43                   	inc    %ebx
 3a4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3a7:	7d 2b                	jge    3d4 <gets+0x48>
    cc = read(0, &c, 1);
 3a9:	83 ec 04             	sub    $0x4,%esp
 3ac:	6a 01                	push   $0x1
 3ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3b1:	50                   	push   %eax
 3b2:	6a 00                	push   $0x0
 3b4:	e8 ed 00 00 00       	call   4a6 <read>
    if(cc < 1)
 3b9:	83 c4 10             	add    $0x10,%esp
 3bc:	85 c0                	test   %eax,%eax
 3be:	7e 14                	jle    3d4 <gets+0x48>
      break;
    buf[i++] = c;
 3c0:	8a 45 e7             	mov    -0x19(%ebp),%al
 3c3:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 3c6:	3c 0a                	cmp    $0xa,%al
 3c8:	74 08                	je     3d2 <gets+0x46>
 3ca:	3c 0d                	cmp    $0xd,%al
 3cc:	75 d3                	jne    3a1 <gets+0x15>
    buf[i++] = c;
 3ce:	89 de                	mov    %ebx,%esi
 3d0:	eb 02                	jmp    3d4 <gets+0x48>
 3d2:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3d4:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3d8:	89 f8                	mov    %edi,%eax
 3da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3dd:	5b                   	pop    %ebx
 3de:	5e                   	pop    %esi
 3df:	5f                   	pop    %edi
 3e0:	5d                   	pop    %ebp
 3e1:	c3                   	ret    

000003e2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e2:	f3 0f 1e fb          	endbr32 
 3e6:	55                   	push   %ebp
 3e7:	89 e5                	mov    %esp,%ebp
 3e9:	56                   	push   %esi
 3ea:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3eb:	83 ec 08             	sub    $0x8,%esp
 3ee:	6a 00                	push   $0x0
 3f0:	ff 75 08             	pushl  0x8(%ebp)
 3f3:	e8 d6 00 00 00       	call   4ce <open>
  if(fd < 0)
 3f8:	83 c4 10             	add    $0x10,%esp
 3fb:	85 c0                	test   %eax,%eax
 3fd:	78 24                	js     423 <stat+0x41>
 3ff:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 401:	83 ec 08             	sub    $0x8,%esp
 404:	ff 75 0c             	pushl  0xc(%ebp)
 407:	50                   	push   %eax
 408:	e8 d9 00 00 00       	call   4e6 <fstat>
 40d:	89 c6                	mov    %eax,%esi
  close(fd);
 40f:	89 1c 24             	mov    %ebx,(%esp)
 412:	e8 9f 00 00 00       	call   4b6 <close>
  return r;
 417:	83 c4 10             	add    $0x10,%esp
}
 41a:	89 f0                	mov    %esi,%eax
 41c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 41f:	5b                   	pop    %ebx
 420:	5e                   	pop    %esi
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
    return -1;
 423:	be ff ff ff ff       	mov    $0xffffffff,%esi
 428:	eb f0                	jmp    41a <stat+0x38>

0000042a <atoi>:

int
atoi(const char *s)
{
 42a:	f3 0f 1e fb          	endbr32 
 42e:	55                   	push   %ebp
 42f:	89 e5                	mov    %esp,%ebp
 431:	53                   	push   %ebx
 432:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 435:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 43a:	8a 01                	mov    (%ecx),%al
 43c:	8d 58 d0             	lea    -0x30(%eax),%ebx
 43f:	80 fb 09             	cmp    $0x9,%bl
 442:	77 10                	ja     454 <atoi+0x2a>
    n = n*10 + *s++ - '0';
 444:	8d 14 92             	lea    (%edx,%edx,4),%edx
 447:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 44a:	41                   	inc    %ecx
 44b:	0f be c0             	movsbl %al,%eax
 44e:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
 452:	eb e6                	jmp    43a <atoi+0x10>
  return n;
}
 454:	89 d0                	mov    %edx,%eax
 456:	5b                   	pop    %ebx
 457:	5d                   	pop    %ebp
 458:	c3                   	ret    

00000459 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 459:	f3 0f 1e fb          	endbr32 
 45d:	55                   	push   %ebp
 45e:	89 e5                	mov    %esp,%ebp
 460:	56                   	push   %esi
 461:	53                   	push   %ebx
 462:	8b 45 08             	mov    0x8(%ebp),%eax
 465:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 468:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 46b:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 46d:	8d 72 ff             	lea    -0x1(%edx),%esi
 470:	85 d2                	test   %edx,%edx
 472:	7e 0e                	jle    482 <memmove+0x29>
    *dst++ = *src++;
 474:	8a 13                	mov    (%ebx),%dl
 476:	88 11                	mov    %dl,(%ecx)
 478:	8d 5b 01             	lea    0x1(%ebx),%ebx
 47b:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 47e:	89 f2                	mov    %esi,%edx
 480:	eb eb                	jmp    46d <memmove+0x14>
  return vdst;
}
 482:	5b                   	pop    %ebx
 483:	5e                   	pop    %esi
 484:	5d                   	pop    %ebp
 485:	c3                   	ret    

00000486 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 486:	b8 01 00 00 00       	mov    $0x1,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <exit>:
SYSCALL(exit)
 48e:	b8 02 00 00 00       	mov    $0x2,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <wait>:
SYSCALL(wait)
 496:	b8 03 00 00 00       	mov    $0x3,%eax
 49b:	cd 40                	int    $0x40
 49d:	c3                   	ret    

0000049e <pipe>:
SYSCALL(pipe)
 49e:	b8 04 00 00 00       	mov    $0x4,%eax
 4a3:	cd 40                	int    $0x40
 4a5:	c3                   	ret    

000004a6 <read>:
SYSCALL(read)
 4a6:	b8 05 00 00 00       	mov    $0x5,%eax
 4ab:	cd 40                	int    $0x40
 4ad:	c3                   	ret    

000004ae <write>:
SYSCALL(write)
 4ae:	b8 10 00 00 00       	mov    $0x10,%eax
 4b3:	cd 40                	int    $0x40
 4b5:	c3                   	ret    

000004b6 <close>:
SYSCALL(close)
 4b6:	b8 15 00 00 00       	mov    $0x15,%eax
 4bb:	cd 40                	int    $0x40
 4bd:	c3                   	ret    

000004be <kill>:
SYSCALL(kill)
 4be:	b8 06 00 00 00       	mov    $0x6,%eax
 4c3:	cd 40                	int    $0x40
 4c5:	c3                   	ret    

000004c6 <exec>:
SYSCALL(exec)
 4c6:	b8 07 00 00 00       	mov    $0x7,%eax
 4cb:	cd 40                	int    $0x40
 4cd:	c3                   	ret    

000004ce <open>:
SYSCALL(open)
 4ce:	b8 0f 00 00 00       	mov    $0xf,%eax
 4d3:	cd 40                	int    $0x40
 4d5:	c3                   	ret    

000004d6 <mknod>:
SYSCALL(mknod)
 4d6:	b8 11 00 00 00       	mov    $0x11,%eax
 4db:	cd 40                	int    $0x40
 4dd:	c3                   	ret    

000004de <unlink>:
SYSCALL(unlink)
 4de:	b8 12 00 00 00       	mov    $0x12,%eax
 4e3:	cd 40                	int    $0x40
 4e5:	c3                   	ret    

000004e6 <fstat>:
SYSCALL(fstat)
 4e6:	b8 08 00 00 00       	mov    $0x8,%eax
 4eb:	cd 40                	int    $0x40
 4ed:	c3                   	ret    

000004ee <link>:
SYSCALL(link)
 4ee:	b8 13 00 00 00       	mov    $0x13,%eax
 4f3:	cd 40                	int    $0x40
 4f5:	c3                   	ret    

000004f6 <mkdir>:
SYSCALL(mkdir)
 4f6:	b8 14 00 00 00       	mov    $0x14,%eax
 4fb:	cd 40                	int    $0x40
 4fd:	c3                   	ret    

000004fe <chdir>:
SYSCALL(chdir)
 4fe:	b8 09 00 00 00       	mov    $0x9,%eax
 503:	cd 40                	int    $0x40
 505:	c3                   	ret    

00000506 <dup>:
SYSCALL(dup)
 506:	b8 0a 00 00 00       	mov    $0xa,%eax
 50b:	cd 40                	int    $0x40
 50d:	c3                   	ret    

0000050e <getpid>:
SYSCALL(getpid)
 50e:	b8 0b 00 00 00       	mov    $0xb,%eax
 513:	cd 40                	int    $0x40
 515:	c3                   	ret    

00000516 <sbrk>:
SYSCALL(sbrk)
 516:	b8 0c 00 00 00       	mov    $0xc,%eax
 51b:	cd 40                	int    $0x40
 51d:	c3                   	ret    

0000051e <sleep>:
SYSCALL(sleep)
 51e:	b8 0d 00 00 00       	mov    $0xd,%eax
 523:	cd 40                	int    $0x40
 525:	c3                   	ret    

00000526 <uptime>:
SYSCALL(uptime)
 526:	b8 0e 00 00 00       	mov    $0xe,%eax
 52b:	cd 40                	int    $0x40
 52d:	c3                   	ret    

0000052e <date>:
SYSCALL(date)
 52e:	b8 16 00 00 00       	mov    $0x16,%eax
 533:	cd 40                	int    $0x40
 535:	c3                   	ret    

00000536 <dup2>:
SYSCALL(dup2)
 536:	b8 17 00 00 00       	mov    $0x17,%eax
 53b:	cd 40                	int    $0x40
 53d:	c3                   	ret    

0000053e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 53e:	55                   	push   %ebp
 53f:	89 e5                	mov    %esp,%ebp
 541:	83 ec 1c             	sub    $0x1c,%esp
 544:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 547:	6a 01                	push   $0x1
 549:	8d 55 f4             	lea    -0xc(%ebp),%edx
 54c:	52                   	push   %edx
 54d:	50                   	push   %eax
 54e:	e8 5b ff ff ff       	call   4ae <write>
}
 553:	83 c4 10             	add    $0x10,%esp
 556:	c9                   	leave  
 557:	c3                   	ret    

00000558 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 558:	55                   	push   %ebp
 559:	89 e5                	mov    %esp,%ebp
 55b:	57                   	push   %edi
 55c:	56                   	push   %esi
 55d:	53                   	push   %ebx
 55e:	83 ec 2c             	sub    $0x2c,%esp
 561:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 564:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 566:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 56a:	74 04                	je     570 <printint+0x18>
 56c:	85 d2                	test   %edx,%edx
 56e:	78 3a                	js     5aa <printint+0x52>
  neg = 0;
 570:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 577:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 57c:	89 f0                	mov    %esi,%eax
 57e:	ba 00 00 00 00       	mov    $0x0,%edx
 583:	f7 f1                	div    %ecx
 585:	89 df                	mov    %ebx,%edi
 587:	43                   	inc    %ebx
 588:	8a 92 7c 07 00 00    	mov    0x77c(%edx),%dl
 58e:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 592:	89 f2                	mov    %esi,%edx
 594:	89 c6                	mov    %eax,%esi
 596:	39 d1                	cmp    %edx,%ecx
 598:	76 e2                	jbe    57c <printint+0x24>
  if(neg)
 59a:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 59e:	74 22                	je     5c2 <printint+0x6a>
    buf[i++] = '-';
 5a0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 5a5:	8d 5f 02             	lea    0x2(%edi),%ebx
 5a8:	eb 18                	jmp    5c2 <printint+0x6a>
    x = -xx;
 5aa:	f7 de                	neg    %esi
    neg = 1;
 5ac:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 5b3:	eb c2                	jmp    577 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 5b5:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 5ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5bd:	e8 7c ff ff ff       	call   53e <putc>
  while(--i >= 0)
 5c2:	4b                   	dec    %ebx
 5c3:	79 f0                	jns    5b5 <printint+0x5d>
}
 5c5:	83 c4 2c             	add    $0x2c,%esp
 5c8:	5b                   	pop    %ebx
 5c9:	5e                   	pop    %esi
 5ca:	5f                   	pop    %edi
 5cb:	5d                   	pop    %ebp
 5cc:	c3                   	ret    

000005cd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5cd:	f3 0f 1e fb          	endbr32 
 5d1:	55                   	push   %ebp
 5d2:	89 e5                	mov    %esp,%ebp
 5d4:	57                   	push   %edi
 5d5:	56                   	push   %esi
 5d6:	53                   	push   %ebx
 5d7:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5da:	8d 45 10             	lea    0x10(%ebp),%eax
 5dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 5e0:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 5e5:	bb 00 00 00 00       	mov    $0x0,%ebx
 5ea:	eb 12                	jmp    5fe <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5ec:	89 fa                	mov    %edi,%edx
 5ee:	8b 45 08             	mov    0x8(%ebp),%eax
 5f1:	e8 48 ff ff ff       	call   53e <putc>
 5f6:	eb 05                	jmp    5fd <printf+0x30>
      }
    } else if(state == '%'){
 5f8:	83 fe 25             	cmp    $0x25,%esi
 5fb:	74 22                	je     61f <printf+0x52>
  for(i = 0; fmt[i]; i++){
 5fd:	43                   	inc    %ebx
 5fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 601:	8a 04 18             	mov    (%eax,%ebx,1),%al
 604:	84 c0                	test   %al,%al
 606:	0f 84 13 01 00 00    	je     71f <printf+0x152>
    c = fmt[i] & 0xff;
 60c:	0f be f8             	movsbl %al,%edi
 60f:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 612:	85 f6                	test   %esi,%esi
 614:	75 e2                	jne    5f8 <printf+0x2b>
      if(c == '%'){
 616:	83 f8 25             	cmp    $0x25,%eax
 619:	75 d1                	jne    5ec <printf+0x1f>
        state = '%';
 61b:	89 c6                	mov    %eax,%esi
 61d:	eb de                	jmp    5fd <printf+0x30>
      if(c == 'd'){
 61f:	83 f8 64             	cmp    $0x64,%eax
 622:	74 43                	je     667 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 624:	83 f8 78             	cmp    $0x78,%eax
 627:	74 68                	je     691 <printf+0xc4>
 629:	83 f8 70             	cmp    $0x70,%eax
 62c:	74 63                	je     691 <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 62e:	83 f8 73             	cmp    $0x73,%eax
 631:	0f 84 84 00 00 00    	je     6bb <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 637:	83 f8 63             	cmp    $0x63,%eax
 63a:	0f 84 ad 00 00 00    	je     6ed <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 640:	83 f8 25             	cmp    $0x25,%eax
 643:	0f 84 c2 00 00 00    	je     70b <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 649:	ba 25 00 00 00       	mov    $0x25,%edx
 64e:	8b 45 08             	mov    0x8(%ebp),%eax
 651:	e8 e8 fe ff ff       	call   53e <putc>
        putc(fd, c);
 656:	89 fa                	mov    %edi,%edx
 658:	8b 45 08             	mov    0x8(%ebp),%eax
 65b:	e8 de fe ff ff       	call   53e <putc>
      }
      state = 0;
 660:	be 00 00 00 00       	mov    $0x0,%esi
 665:	eb 96                	jmp    5fd <printf+0x30>
        printint(fd, *ap, 10, 1);
 667:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 66a:	8b 17                	mov    (%edi),%edx
 66c:	83 ec 0c             	sub    $0xc,%esp
 66f:	6a 01                	push   $0x1
 671:	b9 0a 00 00 00       	mov    $0xa,%ecx
 676:	8b 45 08             	mov    0x8(%ebp),%eax
 679:	e8 da fe ff ff       	call   558 <printint>
        ap++;
 67e:	83 c7 04             	add    $0x4,%edi
 681:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 684:	83 c4 10             	add    $0x10,%esp
      state = 0;
 687:	be 00 00 00 00       	mov    $0x0,%esi
 68c:	e9 6c ff ff ff       	jmp    5fd <printf+0x30>
        printint(fd, *ap, 16, 0);
 691:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 694:	8b 17                	mov    (%edi),%edx
 696:	83 ec 0c             	sub    $0xc,%esp
 699:	6a 00                	push   $0x0
 69b:	b9 10 00 00 00       	mov    $0x10,%ecx
 6a0:	8b 45 08             	mov    0x8(%ebp),%eax
 6a3:	e8 b0 fe ff ff       	call   558 <printint>
        ap++;
 6a8:	83 c7 04             	add    $0x4,%edi
 6ab:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 6ae:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6b1:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 6b6:	e9 42 ff ff ff       	jmp    5fd <printf+0x30>
        s = (char*)*ap;
 6bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6be:	8b 30                	mov    (%eax),%esi
        ap++;
 6c0:	83 c0 04             	add    $0x4,%eax
 6c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 6c6:	85 f6                	test   %esi,%esi
 6c8:	75 13                	jne    6dd <printf+0x110>
          s = "(null)";
 6ca:	be 72 07 00 00       	mov    $0x772,%esi
 6cf:	eb 0c                	jmp    6dd <printf+0x110>
          putc(fd, *s);
 6d1:	0f be d2             	movsbl %dl,%edx
 6d4:	8b 45 08             	mov    0x8(%ebp),%eax
 6d7:	e8 62 fe ff ff       	call   53e <putc>
          s++;
 6dc:	46                   	inc    %esi
        while(*s != 0){
 6dd:	8a 16                	mov    (%esi),%dl
 6df:	84 d2                	test   %dl,%dl
 6e1:	75 ee                	jne    6d1 <printf+0x104>
      state = 0;
 6e3:	be 00 00 00 00       	mov    $0x0,%esi
 6e8:	e9 10 ff ff ff       	jmp    5fd <printf+0x30>
        putc(fd, *ap);
 6ed:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 6f0:	0f be 17             	movsbl (%edi),%edx
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	e8 43 fe ff ff       	call   53e <putc>
        ap++;
 6fb:	83 c7 04             	add    $0x4,%edi
 6fe:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 701:	be 00 00 00 00       	mov    $0x0,%esi
 706:	e9 f2 fe ff ff       	jmp    5fd <printf+0x30>
        putc(fd, c);
 70b:	89 fa                	mov    %edi,%edx
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
 710:	e8 29 fe ff ff       	call   53e <putc>
      state = 0;
 715:	be 00 00 00 00       	mov    $0x0,%esi
 71a:	e9 de fe ff ff       	jmp    5fd <printf+0x30>
    }
  }
}
 71f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 722:	5b                   	pop    %ebx
 723:	5e                   	pop    %esi
 724:	5f                   	pop    %edi
 725:	5d                   	pop    %ebp
 726:	c3                   	ret    
