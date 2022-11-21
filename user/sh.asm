
sh:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	8b 5d 08             	mov    0x8(%ebp),%ebx
   c:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
   f:	83 ec 08             	sub    $0x8,%esp
  12:	68 78 0f 00 00       	push   $0xf78
  17:	6a 02                	push   $0x2
  19:	e8 b0 0c 00 00       	call   cce <printf>
  memset(buf, 0, nbuf);
  1e:	83 c4 0c             	add    $0xc,%esp
  21:	56                   	push   %esi
  22:	6a 00                	push   $0x0
  24:	53                   	push   %ebx
  25:	e8 28 0a 00 00       	call   a52 <memset>
  gets(buf, nbuf);
  2a:	83 c4 08             	add    $0x8,%esp
  2d:	56                   	push   %esi
  2e:	53                   	push   %ebx
  2f:	e8 59 0a 00 00       	call   a8d <gets>
  if(buf[0] == 0) // EOF
  34:	83 c4 10             	add    $0x10,%esp
  37:	80 3b 00             	cmpb   $0x0,(%ebx)
  3a:	74 0c                	je     48 <getcmd+0x48>
    return -1;
  return 0;
  3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  41:	8d 65 f8             	lea    -0x8(%ebp),%esp
  44:	5b                   	pop    %ebx
  45:	5e                   	pop    %esi
  46:	5d                   	pop    %ebp
  47:	c3                   	ret    
    return -1;
  48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4d:	eb f2                	jmp    41 <getcmd+0x41>

0000004f <panic>:
  exit();
}

void
panic(char *s)
{
  4f:	f3 0f 1e fb          	endbr32 
  53:	55                   	push   %ebp
  54:	89 e5                	mov    %esp,%ebp
  56:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
  59:	ff 75 08             	pushl  0x8(%ebp)
  5c:	68 15 10 00 00       	push   $0x1015
  61:	6a 02                	push   $0x2
  63:	e8 66 0c 00 00       	call   cce <printf>
  exit();
  68:	e8 22 0b 00 00       	call   b8f <exit>

0000006d <fork1>:
}

int
fork1(void)
{
  6d:	f3 0f 1e fb          	endbr32 
  71:	55                   	push   %ebp
  72:	89 e5                	mov    %esp,%ebp
  74:	83 ec 08             	sub    $0x8,%esp
  int pid;

  pid = fork();
  77:	e8 0b 0b 00 00       	call   b87 <fork>
  if(pid == -1)
  7c:	83 f8 ff             	cmp    $0xffffffff,%eax
  7f:	74 02                	je     83 <fork1+0x16>
    panic("fork");
  return pid;
}
  81:	c9                   	leave  
  82:	c3                   	ret    
    panic("fork");
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	68 7b 0f 00 00       	push   $0xf7b
  8b:	e8 bf ff ff ff       	call   4f <panic>

00000090 <runcmd>:
{
  90:	f3 0f 1e fb          	endbr32 
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	53                   	push   %ebx
  98:	83 ec 14             	sub    $0x14,%esp
  9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
  9e:	85 db                	test   %ebx,%ebx
  a0:	74 0f                	je     b1 <runcmd+0x21>
  switch(cmd->type){
  a2:	8b 03                	mov    (%ebx),%eax
  a4:	83 f8 05             	cmp    $0x5,%eax
  a7:	77 0d                	ja     b6 <runcmd+0x26>
  a9:	3e ff 24 85 30 10 00 	notrack jmp *0x1030(,%eax,4)
  b0:	00 
    exit();
  b1:	e8 d9 0a 00 00       	call   b8f <exit>
    panic("runcmd");
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	68 80 0f 00 00       	push   $0xf80
  be:	e8 8c ff ff ff       	call   4f <panic>
    if(ecmd->argv[0] == 0)
  c3:	8b 43 04             	mov    0x4(%ebx),%eax
  c6:	85 c0                	test   %eax,%eax
  c8:	74 27                	je     f1 <runcmd+0x61>
    exec(ecmd->argv[0], ecmd->argv);
  ca:	8d 53 04             	lea    0x4(%ebx),%edx
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	52                   	push   %edx
  d1:	50                   	push   %eax
  d2:	e8 f0 0a 00 00       	call   bc7 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
  d7:	83 c4 0c             	add    $0xc,%esp
  da:	ff 73 04             	pushl  0x4(%ebx)
  dd:	68 87 0f 00 00       	push   $0xf87
  e2:	6a 02                	push   $0x2
  e4:	e8 e5 0b 00 00       	call   cce <printf>
    break;
  e9:	83 c4 10             	add    $0x10,%esp
  exit();
  ec:	e8 9e 0a 00 00       	call   b8f <exit>
      exit();
  f1:	e8 99 0a 00 00       	call   b8f <exit>
    close(rcmd->fd);
  f6:	83 ec 0c             	sub    $0xc,%esp
  f9:	ff 73 14             	pushl  0x14(%ebx)
  fc:	e8 b6 0a 00 00       	call   bb7 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
 101:	83 c4 08             	add    $0x8,%esp
 104:	ff 73 10             	pushl  0x10(%ebx)
 107:	ff 73 08             	pushl  0x8(%ebx)
 10a:	e8 c0 0a 00 00       	call   bcf <open>
 10f:	83 c4 10             	add    $0x10,%esp
 112:	85 c0                	test   %eax,%eax
 114:	78 0b                	js     121 <runcmd+0x91>
    runcmd(rcmd->cmd);
 116:	83 ec 0c             	sub    $0xc,%esp
 119:	ff 73 04             	pushl  0x4(%ebx)
 11c:	e8 6f ff ff ff       	call   90 <runcmd>
      printf(2, "open %s failed\n", rcmd->file);
 121:	83 ec 04             	sub    $0x4,%esp
 124:	ff 73 08             	pushl  0x8(%ebx)
 127:	68 97 0f 00 00       	push   $0xf97
 12c:	6a 02                	push   $0x2
 12e:	e8 9b 0b 00 00       	call   cce <printf>
      exit();
 133:	e8 57 0a 00 00       	call   b8f <exit>
    if(fork1() == 0)
 138:	e8 30 ff ff ff       	call   6d <fork1>
 13d:	85 c0                	test   %eax,%eax
 13f:	74 10                	je     151 <runcmd+0xc1>
    wait();
 141:	e8 51 0a 00 00       	call   b97 <wait>
    runcmd(lcmd->right);
 146:	83 ec 0c             	sub    $0xc,%esp
 149:	ff 73 08             	pushl  0x8(%ebx)
 14c:	e8 3f ff ff ff       	call   90 <runcmd>
      runcmd(lcmd->left);
 151:	83 ec 0c             	sub    $0xc,%esp
 154:	ff 73 04             	pushl  0x4(%ebx)
 157:	e8 34 ff ff ff       	call   90 <runcmd>
    if(pipe(p) < 0)
 15c:	83 ec 0c             	sub    $0xc,%esp
 15f:	8d 45 f0             	lea    -0x10(%ebp),%eax
 162:	50                   	push   %eax
 163:	e8 37 0a 00 00       	call   b9f <pipe>
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	78 3a                	js     1a9 <runcmd+0x119>
    if(fork1() == 0){
 16f:	e8 f9 fe ff ff       	call   6d <fork1>
 174:	85 c0                	test   %eax,%eax
 176:	74 3e                	je     1b6 <runcmd+0x126>
    if(fork1() == 0){
 178:	e8 f0 fe ff ff       	call   6d <fork1>
 17d:	85 c0                	test   %eax,%eax
 17f:	74 6b                	je     1ec <runcmd+0x15c>
    close(p[0]);
 181:	83 ec 0c             	sub    $0xc,%esp
 184:	ff 75 f0             	pushl  -0x10(%ebp)
 187:	e8 2b 0a 00 00       	call   bb7 <close>
    close(p[1]);
 18c:	83 c4 04             	add    $0x4,%esp
 18f:	ff 75 f4             	pushl  -0xc(%ebp)
 192:	e8 20 0a 00 00       	call   bb7 <close>
    wait();
 197:	e8 fb 09 00 00       	call   b97 <wait>
    wait();
 19c:	e8 f6 09 00 00       	call   b97 <wait>
    break;
 1a1:	83 c4 10             	add    $0x10,%esp
 1a4:	e9 43 ff ff ff       	jmp    ec <runcmd+0x5c>
      panic("pipe");
 1a9:	83 ec 0c             	sub    $0xc,%esp
 1ac:	68 a7 0f 00 00       	push   $0xfa7
 1b1:	e8 99 fe ff ff       	call   4f <panic>
      close(1);
 1b6:	83 ec 0c             	sub    $0xc,%esp
 1b9:	6a 01                	push   $0x1
 1bb:	e8 f7 09 00 00       	call   bb7 <close>
      dup(p[1]);
 1c0:	83 c4 04             	add    $0x4,%esp
 1c3:	ff 75 f4             	pushl  -0xc(%ebp)
 1c6:	e8 3c 0a 00 00       	call   c07 <dup>
      close(p[0]);
 1cb:	83 c4 04             	add    $0x4,%esp
 1ce:	ff 75 f0             	pushl  -0x10(%ebp)
 1d1:	e8 e1 09 00 00       	call   bb7 <close>
      close(p[1]);
 1d6:	83 c4 04             	add    $0x4,%esp
 1d9:	ff 75 f4             	pushl  -0xc(%ebp)
 1dc:	e8 d6 09 00 00       	call   bb7 <close>
      runcmd(pcmd->left);
 1e1:	83 c4 04             	add    $0x4,%esp
 1e4:	ff 73 04             	pushl  0x4(%ebx)
 1e7:	e8 a4 fe ff ff       	call   90 <runcmd>
      close(0);
 1ec:	83 ec 0c             	sub    $0xc,%esp
 1ef:	6a 00                	push   $0x0
 1f1:	e8 c1 09 00 00       	call   bb7 <close>
      dup(p[0]);
 1f6:	83 c4 04             	add    $0x4,%esp
 1f9:	ff 75 f0             	pushl  -0x10(%ebp)
 1fc:	e8 06 0a 00 00       	call   c07 <dup>
      close(p[0]);
 201:	83 c4 04             	add    $0x4,%esp
 204:	ff 75 f0             	pushl  -0x10(%ebp)
 207:	e8 ab 09 00 00       	call   bb7 <close>
      close(p[1]);
 20c:	83 c4 04             	add    $0x4,%esp
 20f:	ff 75 f4             	pushl  -0xc(%ebp)
 212:	e8 a0 09 00 00       	call   bb7 <close>
      runcmd(pcmd->right);
 217:	83 c4 04             	add    $0x4,%esp
 21a:	ff 73 08             	pushl  0x8(%ebx)
 21d:	e8 6e fe ff ff       	call   90 <runcmd>
    if(fork1() == 0)
 222:	e8 46 fe ff ff       	call   6d <fork1>
 227:	85 c0                	test   %eax,%eax
 229:	0f 85 bd fe ff ff    	jne    ec <runcmd+0x5c>
      runcmd(bcmd->cmd);
 22f:	83 ec 0c             	sub    $0xc,%esp
 232:	ff 73 04             	pushl  0x4(%ebx)
 235:	e8 56 fe ff ff       	call   90 <runcmd>

0000023a <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
 23a:	f3 0f 1e fb          	endbr32 
 23e:	55                   	push   %ebp
 23f:	89 e5                	mov    %esp,%ebp
 241:	53                   	push   %ebx
 242:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 245:	6a 54                	push   $0x54
 247:	e8 a0 0c 00 00       	call   eec <malloc>
 24c:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 24e:	83 c4 0c             	add    $0xc,%esp
 251:	6a 54                	push   $0x54
 253:	6a 00                	push   $0x0
 255:	50                   	push   %eax
 256:	e8 f7 07 00 00       	call   a52 <memset>
  cmd->type = EXEC;
 25b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
 261:	89 d8                	mov    %ebx,%eax
 263:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 266:	c9                   	leave  
 267:	c3                   	ret    

00000268 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
 268:	f3 0f 1e fb          	endbr32 
 26c:	55                   	push   %ebp
 26d:	89 e5                	mov    %esp,%ebp
 26f:	53                   	push   %ebx
 270:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
 273:	6a 18                	push   $0x18
 275:	e8 72 0c 00 00       	call   eec <malloc>
 27a:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 27c:	83 c4 0c             	add    $0xc,%esp
 27f:	6a 18                	push   $0x18
 281:	6a 00                	push   $0x0
 283:	50                   	push   %eax
 284:	e8 c9 07 00 00       	call   a52 <memset>
  cmd->type = REDIR;
 289:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
 295:	8b 45 0c             	mov    0xc(%ebp),%eax
 298:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
 29b:	8b 45 10             	mov    0x10(%ebp),%eax
 29e:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
 2a1:	8b 45 14             	mov    0x14(%ebp),%eax
 2a4:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
 2a7:	8b 45 18             	mov    0x18(%ebp),%eax
 2aa:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
 2ad:	89 d8                	mov    %ebx,%eax
 2af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2b2:	c9                   	leave  
 2b3:	c3                   	ret    

000002b4 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
 2b4:	f3 0f 1e fb          	endbr32 
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	53                   	push   %ebx
 2bc:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
 2bf:	6a 0c                	push   $0xc
 2c1:	e8 26 0c 00 00       	call   eec <malloc>
 2c6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 2c8:	83 c4 0c             	add    $0xc,%esp
 2cb:	6a 0c                	push   $0xc
 2cd:	6a 00                	push   $0x0
 2cf:	50                   	push   %eax
 2d0:	e8 7d 07 00 00       	call   a52 <memset>
  cmd->type = PIPE;
 2d5:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
 2e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e4:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
 2e7:	89 d8                	mov    %ebx,%eax
 2e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2ec:	c9                   	leave  
 2ed:	c3                   	ret    

000002ee <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
 2ee:	f3 0f 1e fb          	endbr32 
 2f2:	55                   	push   %ebp
 2f3:	89 e5                	mov    %esp,%ebp
 2f5:	53                   	push   %ebx
 2f6:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 2f9:	6a 0c                	push   $0xc
 2fb:	e8 ec 0b 00 00       	call   eec <malloc>
 300:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 302:	83 c4 0c             	add    $0xc,%esp
 305:	6a 0c                	push   $0xc
 307:	6a 00                	push   $0x0
 309:	50                   	push   %eax
 30a:	e8 43 07 00 00       	call   a52 <memset>
  cmd->type = LIST;
 30f:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
 315:	8b 45 08             	mov    0x8(%ebp),%eax
 318:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
 31b:	8b 45 0c             	mov    0xc(%ebp),%eax
 31e:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
 321:	89 d8                	mov    %ebx,%eax
 323:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 326:	c9                   	leave  
 327:	c3                   	ret    

00000328 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
 328:	f3 0f 1e fb          	endbr32 
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	53                   	push   %ebx
 330:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 333:	6a 08                	push   $0x8
 335:	e8 b2 0b 00 00       	call   eec <malloc>
 33a:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 33c:	83 c4 0c             	add    $0xc,%esp
 33f:	6a 08                	push   $0x8
 341:	6a 00                	push   $0x0
 343:	50                   	push   %eax
 344:	e8 09 07 00 00       	call   a52 <memset>
  cmd->type = BACK;
 349:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
 34f:	8b 45 08             	mov    0x8(%ebp),%eax
 352:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
 355:	89 d8                	mov    %ebx,%eax
 357:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 35a:	c9                   	leave  
 35b:	c3                   	ret    

0000035c <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
 35c:	f3 0f 1e fb          	endbr32 
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 0c             	sub    $0xc,%esp
 369:	8b 75 0c             	mov    0xc(%ebp),%esi
 36c:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *s;
  int ret;

  s = *ps;
 36f:	8b 45 08             	mov    0x8(%ebp),%eax
 372:	8b 18                	mov    (%eax),%ebx
  while(s < es && strchr(whitespace, *s))
 374:	39 f3                	cmp    %esi,%ebx
 376:	73 1b                	jae    393 <gettoken+0x37>
 378:	83 ec 08             	sub    $0x8,%esp
 37b:	0f be 03             	movsbl (%ebx),%eax
 37e:	50                   	push   %eax
 37f:	68 f8 15 00 00       	push   $0x15f8
 384:	e8 e3 06 00 00       	call   a6c <strchr>
 389:	83 c4 10             	add    $0x10,%esp
 38c:	85 c0                	test   %eax,%eax
 38e:	74 03                	je     393 <gettoken+0x37>
    s++;
 390:	43                   	inc    %ebx
 391:	eb e1                	jmp    374 <gettoken+0x18>
  if(q)
 393:	85 ff                	test   %edi,%edi
 395:	74 02                	je     399 <gettoken+0x3d>
    *q = s;
 397:	89 1f                	mov    %ebx,(%edi)
  ret = *s;
 399:	8a 03                	mov    (%ebx),%al
 39b:	0f be f8             	movsbl %al,%edi
  switch(*s){
 39e:	3c 3c                	cmp    $0x3c,%al
 3a0:	7f 25                	jg     3c7 <gettoken+0x6b>
 3a2:	3c 3b                	cmp    $0x3b,%al
 3a4:	7d 13                	jge    3b9 <gettoken+0x5d>
 3a6:	84 c0                	test   %al,%al
 3a8:	74 10                	je     3ba <gettoken+0x5e>
 3aa:	78 3d                	js     3e9 <gettoken+0x8d>
 3ac:	3c 26                	cmp    $0x26,%al
 3ae:	74 09                	je     3b9 <gettoken+0x5d>
 3b0:	7c 37                	jl     3e9 <gettoken+0x8d>
 3b2:	83 e8 28             	sub    $0x28,%eax
 3b5:	3c 01                	cmp    $0x1,%al
 3b7:	77 30                	ja     3e9 <gettoken+0x8d>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
 3b9:	43                   	inc    %ebx
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
 3ba:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3be:	74 73                	je     433 <gettoken+0xd7>
    *eq = s;
 3c0:	8b 45 14             	mov    0x14(%ebp),%eax
 3c3:	89 18                	mov    %ebx,(%eax)
 3c5:	eb 6c                	jmp    433 <gettoken+0xd7>
  switch(*s){
 3c7:	3c 3e                	cmp    $0x3e,%al
 3c9:	75 0d                	jne    3d8 <gettoken+0x7c>
    s++;
 3cb:	8d 43 01             	lea    0x1(%ebx),%eax
    if(*s == '>'){
 3ce:	80 7b 01 3e          	cmpb   $0x3e,0x1(%ebx)
 3d2:	74 0a                	je     3de <gettoken+0x82>
    s++;
 3d4:	89 c3                	mov    %eax,%ebx
 3d6:	eb e2                	jmp    3ba <gettoken+0x5e>
  switch(*s){
 3d8:	3c 7c                	cmp    $0x7c,%al
 3da:	75 0d                	jne    3e9 <gettoken+0x8d>
 3dc:	eb db                	jmp    3b9 <gettoken+0x5d>
      s++;
 3de:	83 c3 02             	add    $0x2,%ebx
      ret = '+';
 3e1:	bf 2b 00 00 00       	mov    $0x2b,%edi
 3e6:	eb d2                	jmp    3ba <gettoken+0x5e>
      s++;
 3e8:	43                   	inc    %ebx
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
 3e9:	39 f3                	cmp    %esi,%ebx
 3eb:	73 37                	jae    424 <gettoken+0xc8>
 3ed:	83 ec 08             	sub    $0x8,%esp
 3f0:	0f be 03             	movsbl (%ebx),%eax
 3f3:	50                   	push   %eax
 3f4:	68 f8 15 00 00       	push   $0x15f8
 3f9:	e8 6e 06 00 00       	call   a6c <strchr>
 3fe:	83 c4 10             	add    $0x10,%esp
 401:	85 c0                	test   %eax,%eax
 403:	75 26                	jne    42b <gettoken+0xcf>
 405:	83 ec 08             	sub    $0x8,%esp
 408:	0f be 03             	movsbl (%ebx),%eax
 40b:	50                   	push   %eax
 40c:	68 f0 15 00 00       	push   $0x15f0
 411:	e8 56 06 00 00       	call   a6c <strchr>
 416:	83 c4 10             	add    $0x10,%esp
 419:	85 c0                	test   %eax,%eax
 41b:	74 cb                	je     3e8 <gettoken+0x8c>
    ret = 'a';
 41d:	bf 61 00 00 00       	mov    $0x61,%edi
 422:	eb 96                	jmp    3ba <gettoken+0x5e>
 424:	bf 61 00 00 00       	mov    $0x61,%edi
 429:	eb 8f                	jmp    3ba <gettoken+0x5e>
 42b:	bf 61 00 00 00       	mov    $0x61,%edi
 430:	eb 88                	jmp    3ba <gettoken+0x5e>

  while(s < es && strchr(whitespace, *s))
    s++;
 432:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
 433:	39 f3                	cmp    %esi,%ebx
 435:	73 18                	jae    44f <gettoken+0xf3>
 437:	83 ec 08             	sub    $0x8,%esp
 43a:	0f be 03             	movsbl (%ebx),%eax
 43d:	50                   	push   %eax
 43e:	68 f8 15 00 00       	push   $0x15f8
 443:	e8 24 06 00 00       	call   a6c <strchr>
 448:	83 c4 10             	add    $0x10,%esp
 44b:	85 c0                	test   %eax,%eax
 44d:	75 e3                	jne    432 <gettoken+0xd6>
  *ps = s;
 44f:	8b 45 08             	mov    0x8(%ebp),%eax
 452:	89 18                	mov    %ebx,(%eax)
  return ret;
}
 454:	89 f8                	mov    %edi,%eax
 456:	8d 65 f4             	lea    -0xc(%ebp),%esp
 459:	5b                   	pop    %ebx
 45a:	5e                   	pop    %esi
 45b:	5f                   	pop    %edi
 45c:	5d                   	pop    %ebp
 45d:	c3                   	ret    

0000045e <peek>:

int
peek(char **ps, char *es, char *toks)
{
 45e:	f3 0f 1e fb          	endbr32 
 462:	55                   	push   %ebp
 463:	89 e5                	mov    %esp,%ebp
 465:	57                   	push   %edi
 466:	56                   	push   %esi
 467:	53                   	push   %ebx
 468:	83 ec 0c             	sub    $0xc,%esp
 46b:	8b 7d 08             	mov    0x8(%ebp),%edi
 46e:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
 471:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
 473:	39 f3                	cmp    %esi,%ebx
 475:	73 1b                	jae    492 <peek+0x34>
 477:	83 ec 08             	sub    $0x8,%esp
 47a:	0f be 03             	movsbl (%ebx),%eax
 47d:	50                   	push   %eax
 47e:	68 f8 15 00 00       	push   $0x15f8
 483:	e8 e4 05 00 00       	call   a6c <strchr>
 488:	83 c4 10             	add    $0x10,%esp
 48b:	85 c0                	test   %eax,%eax
 48d:	74 03                	je     492 <peek+0x34>
    s++;
 48f:	43                   	inc    %ebx
 490:	eb e1                	jmp    473 <peek+0x15>
  *ps = s;
 492:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
 494:	8a 03                	mov    (%ebx),%al
 496:	84 c0                	test   %al,%al
 498:	75 0d                	jne    4a7 <peek+0x49>
 49a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 49f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a2:	5b                   	pop    %ebx
 4a3:	5e                   	pop    %esi
 4a4:	5f                   	pop    %edi
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret    
  return *s && strchr(toks, *s);
 4a7:	83 ec 08             	sub    $0x8,%esp
 4aa:	0f be c0             	movsbl %al,%eax
 4ad:	50                   	push   %eax
 4ae:	ff 75 10             	pushl  0x10(%ebp)
 4b1:	e8 b6 05 00 00       	call   a6c <strchr>
 4b6:	83 c4 10             	add    $0x10,%esp
 4b9:	85 c0                	test   %eax,%eax
 4bb:	74 07                	je     4c4 <peek+0x66>
 4bd:	b8 01 00 00 00       	mov    $0x1,%eax
 4c2:	eb db                	jmp    49f <peek+0x41>
 4c4:	b8 00 00 00 00       	mov    $0x0,%eax
 4c9:	eb d4                	jmp    49f <peek+0x41>

000004cb <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
 4cb:	f3 0f 1e fb          	endbr32 
 4cf:	55                   	push   %ebp
 4d0:	89 e5                	mov    %esp,%ebp
 4d2:	57                   	push   %edi
 4d3:	56                   	push   %esi
 4d4:	53                   	push   %ebx
 4d5:	83 ec 1c             	sub    $0x1c,%esp
 4d8:	8b 7d 0c             	mov    0xc(%ebp),%edi
 4db:	8b 75 10             	mov    0x10(%ebp),%esi
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
 4de:	eb 28                	jmp    508 <parseredirs+0x3d>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
 4e0:	83 ec 0c             	sub    $0xc,%esp
 4e3:	68 ac 0f 00 00       	push   $0xfac
 4e8:	e8 62 fb ff ff       	call   4f <panic>
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
 4ed:	83 ec 0c             	sub    $0xc,%esp
 4f0:	6a 00                	push   $0x0
 4f2:	6a 00                	push   $0x0
 4f4:	ff 75 e0             	pushl  -0x20(%ebp)
 4f7:	ff 75 e4             	pushl  -0x1c(%ebp)
 4fa:	ff 75 08             	pushl  0x8(%ebp)
 4fd:	e8 66 fd ff ff       	call   268 <redircmd>
 502:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
 505:	83 c4 20             	add    $0x20,%esp
  while(peek(ps, es, "<>")){
 508:	83 ec 04             	sub    $0x4,%esp
 50b:	68 c9 0f 00 00       	push   $0xfc9
 510:	56                   	push   %esi
 511:	57                   	push   %edi
 512:	e8 47 ff ff ff       	call   45e <peek>
 517:	83 c4 10             	add    $0x10,%esp
 51a:	85 c0                	test   %eax,%eax
 51c:	74 76                	je     594 <parseredirs+0xc9>
    tok = gettoken(ps, es, 0, 0);
 51e:	6a 00                	push   $0x0
 520:	6a 00                	push   $0x0
 522:	56                   	push   %esi
 523:	57                   	push   %edi
 524:	e8 33 fe ff ff       	call   35c <gettoken>
 529:	89 c3                	mov    %eax,%ebx
    if(gettoken(ps, es, &q, &eq) != 'a')
 52b:	8d 45 e0             	lea    -0x20(%ebp),%eax
 52e:	50                   	push   %eax
 52f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 532:	50                   	push   %eax
 533:	56                   	push   %esi
 534:	57                   	push   %edi
 535:	e8 22 fe ff ff       	call   35c <gettoken>
 53a:	83 c4 20             	add    $0x20,%esp
 53d:	83 f8 61             	cmp    $0x61,%eax
 540:	75 9e                	jne    4e0 <parseredirs+0x15>
    switch(tok){
 542:	83 fb 3c             	cmp    $0x3c,%ebx
 545:	74 a6                	je     4ed <parseredirs+0x22>
 547:	83 fb 3e             	cmp    $0x3e,%ebx
 54a:	74 25                	je     571 <parseredirs+0xa6>
 54c:	83 fb 2b             	cmp    $0x2b,%ebx
 54f:	75 b7                	jne    508 <parseredirs+0x3d>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
 551:	83 ec 0c             	sub    $0xc,%esp
 554:	6a 01                	push   $0x1
 556:	68 01 02 00 00       	push   $0x201
 55b:	ff 75 e0             	pushl  -0x20(%ebp)
 55e:	ff 75 e4             	pushl  -0x1c(%ebp)
 561:	ff 75 08             	pushl  0x8(%ebp)
 564:	e8 ff fc ff ff       	call   268 <redircmd>
 569:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
 56c:	83 c4 20             	add    $0x20,%esp
 56f:	eb 97                	jmp    508 <parseredirs+0x3d>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
 571:	83 ec 0c             	sub    $0xc,%esp
 574:	6a 01                	push   $0x1
 576:	68 01 02 00 00       	push   $0x201
 57b:	ff 75 e0             	pushl  -0x20(%ebp)
 57e:	ff 75 e4             	pushl  -0x1c(%ebp)
 581:	ff 75 08             	pushl  0x8(%ebp)
 584:	e8 df fc ff ff       	call   268 <redircmd>
 589:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
 58c:	83 c4 20             	add    $0x20,%esp
 58f:	e9 74 ff ff ff       	jmp    508 <parseredirs+0x3d>
    }
  }
  return cmd;
}
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	8d 65 f4             	lea    -0xc(%ebp),%esp
 59a:	5b                   	pop    %ebx
 59b:	5e                   	pop    %esi
 59c:	5f                   	pop    %edi
 59d:	5d                   	pop    %ebp
 59e:	c3                   	ret    

0000059f <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
 59f:	f3 0f 1e fb          	endbr32 
 5a3:	55                   	push   %ebp
 5a4:	89 e5                	mov    %esp,%ebp
 5a6:	57                   	push   %edi
 5a7:	56                   	push   %esi
 5a8:	53                   	push   %ebx
 5a9:	83 ec 30             	sub    $0x30,%esp
 5ac:	8b 75 08             	mov    0x8(%ebp),%esi
 5af:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
 5b2:	68 cc 0f 00 00       	push   $0xfcc
 5b7:	57                   	push   %edi
 5b8:	56                   	push   %esi
 5b9:	e8 a0 fe ff ff       	call   45e <peek>
 5be:	83 c4 10             	add    $0x10,%esp
 5c1:	85 c0                	test   %eax,%eax
 5c3:	75 1d                	jne    5e2 <parseexec+0x43>
 5c5:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
 5c7:	e8 6e fc ff ff       	call   23a <execcmd>
 5cc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
 5cf:	83 ec 04             	sub    $0x4,%esp
 5d2:	57                   	push   %edi
 5d3:	56                   	push   %esi
 5d4:	50                   	push   %eax
 5d5:	e8 f1 fe ff ff       	call   4cb <parseredirs>
 5da:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	eb 3b                	jmp    61d <parseexec+0x7e>
    return parseblock(ps, es);
 5e2:	83 ec 08             	sub    $0x8,%esp
 5e5:	57                   	push   %edi
 5e6:	56                   	push   %esi
 5e7:	e8 95 01 00 00       	call   781 <parseblock>
 5ec:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5ef:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
 5f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f8:	5b                   	pop    %ebx
 5f9:	5e                   	pop    %esi
 5fa:	5f                   	pop    %edi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret    
      panic("syntax");
 5fd:	83 ec 0c             	sub    $0xc,%esp
 600:	68 ce 0f 00 00       	push   $0xfce
 605:	e8 45 fa ff ff       	call   4f <panic>
    ret = parseredirs(ret, ps, es);
 60a:	83 ec 04             	sub    $0x4,%esp
 60d:	57                   	push   %edi
 60e:	56                   	push   %esi
 60f:	ff 75 d4             	pushl  -0x2c(%ebp)
 612:	e8 b4 fe ff ff       	call   4cb <parseredirs>
 617:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 61a:	83 c4 10             	add    $0x10,%esp
  while(!peek(ps, es, "|)&;")){
 61d:	83 ec 04             	sub    $0x4,%esp
 620:	68 e3 0f 00 00       	push   $0xfe3
 625:	57                   	push   %edi
 626:	56                   	push   %esi
 627:	e8 32 fe ff ff       	call   45e <peek>
 62c:	83 c4 10             	add    $0x10,%esp
 62f:	85 c0                	test   %eax,%eax
 631:	75 3f                	jne    672 <parseexec+0xd3>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
 633:	8d 45 e0             	lea    -0x20(%ebp),%eax
 636:	50                   	push   %eax
 637:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 63a:	50                   	push   %eax
 63b:	57                   	push   %edi
 63c:	56                   	push   %esi
 63d:	e8 1a fd ff ff       	call   35c <gettoken>
 642:	83 c4 10             	add    $0x10,%esp
 645:	85 c0                	test   %eax,%eax
 647:	74 29                	je     672 <parseexec+0xd3>
    if(tok != 'a')
 649:	83 f8 61             	cmp    $0x61,%eax
 64c:	75 af                	jne    5fd <parseexec+0x5e>
    cmd->argv[argc] = q;
 64e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 651:	8b 55 d0             	mov    -0x30(%ebp),%edx
 654:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
 658:	8b 45 e0             	mov    -0x20(%ebp),%eax
 65b:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
 65f:	43                   	inc    %ebx
    if(argc >= MAXARGS)
 660:	83 fb 09             	cmp    $0x9,%ebx
 663:	7e a5                	jle    60a <parseexec+0x6b>
      panic("too many args");
 665:	83 ec 0c             	sub    $0xc,%esp
 668:	68 d5 0f 00 00       	push   $0xfd5
 66d:	e8 dd f9 ff ff       	call   4f <panic>
  cmd->argv[argc] = 0;
 672:	8b 45 d0             	mov    -0x30(%ebp),%eax
 675:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
 67c:	00 
  cmd->eargv[argc] = 0;
 67d:	c7 44 98 2c 00 00 00 	movl   $0x0,0x2c(%eax,%ebx,4)
 684:	00 
  return ret;
 685:	e9 68 ff ff ff       	jmp    5f2 <parseexec+0x53>

0000068a <parsepipe>:
{
 68a:	f3 0f 1e fb          	endbr32 
 68e:	55                   	push   %ebp
 68f:	89 e5                	mov    %esp,%ebp
 691:	57                   	push   %edi
 692:	56                   	push   %esi
 693:	53                   	push   %ebx
 694:	83 ec 14             	sub    $0x14,%esp
 697:	8b 75 08             	mov    0x8(%ebp),%esi
 69a:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
 69d:	57                   	push   %edi
 69e:	56                   	push   %esi
 69f:	e8 fb fe ff ff       	call   59f <parseexec>
 6a4:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
 6a6:	83 c4 0c             	add    $0xc,%esp
 6a9:	68 e8 0f 00 00       	push   $0xfe8
 6ae:	57                   	push   %edi
 6af:	56                   	push   %esi
 6b0:	e8 a9 fd ff ff       	call   45e <peek>
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	85 c0                	test   %eax,%eax
 6ba:	75 0a                	jne    6c6 <parsepipe+0x3c>
}
 6bc:	89 d8                	mov    %ebx,%eax
 6be:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c1:	5b                   	pop    %ebx
 6c2:	5e                   	pop    %esi
 6c3:	5f                   	pop    %edi
 6c4:	5d                   	pop    %ebp
 6c5:	c3                   	ret    
    gettoken(ps, es, 0, 0);
 6c6:	6a 00                	push   $0x0
 6c8:	6a 00                	push   $0x0
 6ca:	57                   	push   %edi
 6cb:	56                   	push   %esi
 6cc:	e8 8b fc ff ff       	call   35c <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
 6d1:	83 c4 08             	add    $0x8,%esp
 6d4:	57                   	push   %edi
 6d5:	56                   	push   %esi
 6d6:	e8 af ff ff ff       	call   68a <parsepipe>
 6db:	83 c4 08             	add    $0x8,%esp
 6de:	50                   	push   %eax
 6df:	53                   	push   %ebx
 6e0:	e8 cf fb ff ff       	call   2b4 <pipecmd>
 6e5:	89 c3                	mov    %eax,%ebx
 6e7:	83 c4 10             	add    $0x10,%esp
  return cmd;
 6ea:	eb d0                	jmp    6bc <parsepipe+0x32>

000006ec <parseline>:
{
 6ec:	f3 0f 1e fb          	endbr32 
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 14             	sub    $0x14,%esp
 6f9:	8b 75 08             	mov    0x8(%ebp),%esi
 6fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
 6ff:	57                   	push   %edi
 700:	56                   	push   %esi
 701:	e8 84 ff ff ff       	call   68a <parsepipe>
 706:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
 708:	83 c4 10             	add    $0x10,%esp
 70b:	83 ec 04             	sub    $0x4,%esp
 70e:	68 ea 0f 00 00       	push   $0xfea
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	e8 44 fd ff ff       	call   45e <peek>
 71a:	83 c4 10             	add    $0x10,%esp
 71d:	85 c0                	test   %eax,%eax
 71f:	74 1a                	je     73b <parseline+0x4f>
    gettoken(ps, es, 0, 0);
 721:	6a 00                	push   $0x0
 723:	6a 00                	push   $0x0
 725:	57                   	push   %edi
 726:	56                   	push   %esi
 727:	e8 30 fc ff ff       	call   35c <gettoken>
    cmd = backcmd(cmd);
 72c:	89 1c 24             	mov    %ebx,(%esp)
 72f:	e8 f4 fb ff ff       	call   328 <backcmd>
 734:	89 c3                	mov    %eax,%ebx
 736:	83 c4 10             	add    $0x10,%esp
 739:	eb d0                	jmp    70b <parseline+0x1f>
  if(peek(ps, es, ";")){
 73b:	83 ec 04             	sub    $0x4,%esp
 73e:	68 e6 0f 00 00       	push   $0xfe6
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	e8 14 fd ff ff       	call   45e <peek>
 74a:	83 c4 10             	add    $0x10,%esp
 74d:	85 c0                	test   %eax,%eax
 74f:	75 0a                	jne    75b <parseline+0x6f>
}
 751:	89 d8                	mov    %ebx,%eax
 753:	8d 65 f4             	lea    -0xc(%ebp),%esp
 756:	5b                   	pop    %ebx
 757:	5e                   	pop    %esi
 758:	5f                   	pop    %edi
 759:	5d                   	pop    %ebp
 75a:	c3                   	ret    
    gettoken(ps, es, 0, 0);
 75b:	6a 00                	push   $0x0
 75d:	6a 00                	push   $0x0
 75f:	57                   	push   %edi
 760:	56                   	push   %esi
 761:	e8 f6 fb ff ff       	call   35c <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
 766:	83 c4 08             	add    $0x8,%esp
 769:	57                   	push   %edi
 76a:	56                   	push   %esi
 76b:	e8 7c ff ff ff       	call   6ec <parseline>
 770:	83 c4 08             	add    $0x8,%esp
 773:	50                   	push   %eax
 774:	53                   	push   %ebx
 775:	e8 74 fb ff ff       	call   2ee <listcmd>
 77a:	89 c3                	mov    %eax,%ebx
 77c:	83 c4 10             	add    $0x10,%esp
  return cmd;
 77f:	eb d0                	jmp    751 <parseline+0x65>

00000781 <parseblock>:
{
 781:	f3 0f 1e fb          	endbr32 
 785:	55                   	push   %ebp
 786:	89 e5                	mov    %esp,%ebp
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	53                   	push   %ebx
 78b:	83 ec 10             	sub    $0x10,%esp
 78e:	8b 5d 08             	mov    0x8(%ebp),%ebx
 791:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
 794:	68 cc 0f 00 00       	push   $0xfcc
 799:	56                   	push   %esi
 79a:	53                   	push   %ebx
 79b:	e8 be fc ff ff       	call   45e <peek>
 7a0:	83 c4 10             	add    $0x10,%esp
 7a3:	85 c0                	test   %eax,%eax
 7a5:	74 4b                	je     7f2 <parseblock+0x71>
  gettoken(ps, es, 0, 0);
 7a7:	6a 00                	push   $0x0
 7a9:	6a 00                	push   $0x0
 7ab:	56                   	push   %esi
 7ac:	53                   	push   %ebx
 7ad:	e8 aa fb ff ff       	call   35c <gettoken>
  cmd = parseline(ps, es);
 7b2:	83 c4 08             	add    $0x8,%esp
 7b5:	56                   	push   %esi
 7b6:	53                   	push   %ebx
 7b7:	e8 30 ff ff ff       	call   6ec <parseline>
 7bc:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
 7be:	83 c4 0c             	add    $0xc,%esp
 7c1:	68 08 10 00 00       	push   $0x1008
 7c6:	56                   	push   %esi
 7c7:	53                   	push   %ebx
 7c8:	e8 91 fc ff ff       	call   45e <peek>
 7cd:	83 c4 10             	add    $0x10,%esp
 7d0:	85 c0                	test   %eax,%eax
 7d2:	74 2b                	je     7ff <parseblock+0x7e>
  gettoken(ps, es, 0, 0);
 7d4:	6a 00                	push   $0x0
 7d6:	6a 00                	push   $0x0
 7d8:	56                   	push   %esi
 7d9:	53                   	push   %ebx
 7da:	e8 7d fb ff ff       	call   35c <gettoken>
  cmd = parseredirs(cmd, ps, es);
 7df:	83 c4 0c             	add    $0xc,%esp
 7e2:	56                   	push   %esi
 7e3:	53                   	push   %ebx
 7e4:	57                   	push   %edi
 7e5:	e8 e1 fc ff ff       	call   4cb <parseredirs>
}
 7ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7ed:	5b                   	pop    %ebx
 7ee:	5e                   	pop    %esi
 7ef:	5f                   	pop    %edi
 7f0:	5d                   	pop    %ebp
 7f1:	c3                   	ret    
    panic("parseblock");
 7f2:	83 ec 0c             	sub    $0xc,%esp
 7f5:	68 ec 0f 00 00       	push   $0xfec
 7fa:	e8 50 f8 ff ff       	call   4f <panic>
    panic("syntax - missing )");
 7ff:	83 ec 0c             	sub    $0xc,%esp
 802:	68 f7 0f 00 00       	push   $0xff7
 807:	e8 43 f8 ff ff       	call   4f <panic>

0000080c <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
 80c:	f3 0f 1e fb          	endbr32 
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	53                   	push   %ebx
 814:	83 ec 04             	sub    $0x4,%esp
 817:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
 81a:	85 db                	test   %ebx,%ebx
 81c:	74 39                	je     857 <nulterminate+0x4b>
    return 0;

  switch(cmd->type){
 81e:	8b 03                	mov    (%ebx),%eax
 820:	83 f8 05             	cmp    $0x5,%eax
 823:	77 32                	ja     857 <nulterminate+0x4b>
 825:	3e ff 24 85 48 10 00 	notrack jmp *0x1048(,%eax,4)
 82c:	00 
 82d:	b8 00 00 00 00       	mov    $0x0,%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
 832:	83 7c 83 04 00       	cmpl   $0x0,0x4(%ebx,%eax,4)
 837:	74 1e                	je     857 <nulterminate+0x4b>
      *ecmd->eargv[i] = 0;
 839:	8b 54 83 2c          	mov    0x2c(%ebx,%eax,4),%edx
 83d:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
 840:	40                   	inc    %eax
 841:	eb ef                	jmp    832 <nulterminate+0x26>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
 843:	83 ec 0c             	sub    $0xc,%esp
 846:	ff 73 04             	pushl  0x4(%ebx)
 849:	e8 be ff ff ff       	call   80c <nulterminate>
    *rcmd->efile = 0;
 84e:	8b 43 0c             	mov    0xc(%ebx),%eax
 851:	c6 00 00             	movb   $0x0,(%eax)
    break;
 854:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 857:	89 d8                	mov    %ebx,%eax
 859:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 85c:	c9                   	leave  
 85d:	c3                   	ret    
    nulterminate(pcmd->left);
 85e:	83 ec 0c             	sub    $0xc,%esp
 861:	ff 73 04             	pushl  0x4(%ebx)
 864:	e8 a3 ff ff ff       	call   80c <nulterminate>
    nulterminate(pcmd->right);
 869:	83 c4 04             	add    $0x4,%esp
 86c:	ff 73 08             	pushl  0x8(%ebx)
 86f:	e8 98 ff ff ff       	call   80c <nulterminate>
    break;
 874:	83 c4 10             	add    $0x10,%esp
 877:	eb de                	jmp    857 <nulterminate+0x4b>
    nulterminate(lcmd->left);
 879:	83 ec 0c             	sub    $0xc,%esp
 87c:	ff 73 04             	pushl  0x4(%ebx)
 87f:	e8 88 ff ff ff       	call   80c <nulterminate>
    nulterminate(lcmd->right);
 884:	83 c4 04             	add    $0x4,%esp
 887:	ff 73 08             	pushl  0x8(%ebx)
 88a:	e8 7d ff ff ff       	call   80c <nulterminate>
    break;
 88f:	83 c4 10             	add    $0x10,%esp
 892:	eb c3                	jmp    857 <nulterminate+0x4b>
    nulterminate(bcmd->cmd);
 894:	83 ec 0c             	sub    $0xc,%esp
 897:	ff 73 04             	pushl  0x4(%ebx)
 89a:	e8 6d ff ff ff       	call   80c <nulterminate>
    break;
 89f:	83 c4 10             	add    $0x10,%esp
 8a2:	eb b3                	jmp    857 <nulterminate+0x4b>

000008a4 <parsecmd>:
{
 8a4:	f3 0f 1e fb          	endbr32 
 8a8:	55                   	push   %ebp
 8a9:	89 e5                	mov    %esp,%ebp
 8ab:	56                   	push   %esi
 8ac:	53                   	push   %ebx
  es = s + strlen(s);
 8ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8b0:	83 ec 0c             	sub    $0xc,%esp
 8b3:	53                   	push   %ebx
 8b4:	e8 7f 01 00 00       	call   a38 <strlen>
 8b9:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
 8bb:	83 c4 08             	add    $0x8,%esp
 8be:	53                   	push   %ebx
 8bf:	8d 45 08             	lea    0x8(%ebp),%eax
 8c2:	50                   	push   %eax
 8c3:	e8 24 fe ff ff       	call   6ec <parseline>
 8c8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
 8ca:	83 c4 0c             	add    $0xc,%esp
 8cd:	68 96 0f 00 00       	push   $0xf96
 8d2:	53                   	push   %ebx
 8d3:	8d 45 08             	lea    0x8(%ebp),%eax
 8d6:	50                   	push   %eax
 8d7:	e8 82 fb ff ff       	call   45e <peek>
  if(s != es){
 8dc:	8b 45 08             	mov    0x8(%ebp),%eax
 8df:	83 c4 10             	add    $0x10,%esp
 8e2:	39 d8                	cmp    %ebx,%eax
 8e4:	75 12                	jne    8f8 <parsecmd+0x54>
  nulterminate(cmd);
 8e6:	83 ec 0c             	sub    $0xc,%esp
 8e9:	56                   	push   %esi
 8ea:	e8 1d ff ff ff       	call   80c <nulterminate>
}
 8ef:	89 f0                	mov    %esi,%eax
 8f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8f4:	5b                   	pop    %ebx
 8f5:	5e                   	pop    %esi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
 8f8:	83 ec 04             	sub    $0x4,%esp
 8fb:	50                   	push   %eax
 8fc:	68 0a 10 00 00       	push   $0x100a
 901:	6a 02                	push   $0x2
 903:	e8 c6 03 00 00       	call   cce <printf>
    panic("syntax");
 908:	c7 04 24 ce 0f 00 00 	movl   $0xfce,(%esp)
 90f:	e8 3b f7 ff ff       	call   4f <panic>

00000914 <main>:
{
 914:	f3 0f 1e fb          	endbr32 
 918:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 91c:	83 e4 f0             	and    $0xfffffff0,%esp
 91f:	ff 71 fc             	pushl  -0x4(%ecx)
 922:	55                   	push   %ebp
 923:	89 e5                	mov    %esp,%ebp
 925:	51                   	push   %ecx
 926:	83 ec 04             	sub    $0x4,%esp
  while((fd = open("console", O_RDWR)) >= 0){
 929:	83 ec 08             	sub    $0x8,%esp
 92c:	6a 02                	push   $0x2
 92e:	68 19 10 00 00       	push   $0x1019
 933:	e8 97 02 00 00       	call   bcf <open>
 938:	83 c4 10             	add    $0x10,%esp
 93b:	85 c0                	test   %eax,%eax
 93d:	78 21                	js     960 <main+0x4c>
    if(fd >= 3){
 93f:	83 f8 02             	cmp    $0x2,%eax
 942:	7e e5                	jle    929 <main+0x15>
      close(fd);
 944:	83 ec 0c             	sub    $0xc,%esp
 947:	50                   	push   %eax
 948:	e8 6a 02 00 00       	call   bb7 <close>
      break;
 94d:	83 c4 10             	add    $0x10,%esp
 950:	eb 0e                	jmp    960 <main+0x4c>
    if(fork1() == 0)
 952:	e8 16 f7 ff ff       	call   6d <fork1>
 957:	85 c0                	test   %eax,%eax
 959:	74 76                	je     9d1 <main+0xbd>
    wait();
 95b:	e8 37 02 00 00       	call   b97 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
 960:	83 ec 08             	sub    $0x8,%esp
 963:	6a 64                	push   $0x64
 965:	68 00 16 00 00       	push   $0x1600
 96a:	e8 91 f6 ff ff       	call   0 <getcmd>
 96f:	83 c4 10             	add    $0x10,%esp
 972:	85 c0                	test   %eax,%eax
 974:	78 70                	js     9e6 <main+0xd2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
 976:	80 3d 00 16 00 00 63 	cmpb   $0x63,0x1600
 97d:	75 d3                	jne    952 <main+0x3e>
 97f:	80 3d 01 16 00 00 64 	cmpb   $0x64,0x1601
 986:	75 ca                	jne    952 <main+0x3e>
 988:	80 3d 02 16 00 00 20 	cmpb   $0x20,0x1602
 98f:	75 c1                	jne    952 <main+0x3e>
      buf[strlen(buf)-1] = 0;  // chop \n
 991:	83 ec 0c             	sub    $0xc,%esp
 994:	68 00 16 00 00       	push   $0x1600
 999:	e8 9a 00 00 00       	call   a38 <strlen>
 99e:	c6 80 ff 15 00 00 00 	movb   $0x0,0x15ff(%eax)
      if(chdir(buf+3) < 0)
 9a5:	c7 04 24 03 16 00 00 	movl   $0x1603,(%esp)
 9ac:	e8 4e 02 00 00       	call   bff <chdir>
 9b1:	83 c4 10             	add    $0x10,%esp
 9b4:	85 c0                	test   %eax,%eax
 9b6:	79 a8                	jns    960 <main+0x4c>
        printf(2, "cannot cd %s\n", buf+3);
 9b8:	83 ec 04             	sub    $0x4,%esp
 9bb:	68 03 16 00 00       	push   $0x1603
 9c0:	68 21 10 00 00       	push   $0x1021
 9c5:	6a 02                	push   $0x2
 9c7:	e8 02 03 00 00       	call   cce <printf>
 9cc:	83 c4 10             	add    $0x10,%esp
      continue;
 9cf:	eb 8f                	jmp    960 <main+0x4c>
      runcmd(parsecmd(buf));
 9d1:	83 ec 0c             	sub    $0xc,%esp
 9d4:	68 00 16 00 00       	push   $0x1600
 9d9:	e8 c6 fe ff ff       	call   8a4 <parsecmd>
 9de:	89 04 24             	mov    %eax,(%esp)
 9e1:	e8 aa f6 ff ff       	call   90 <runcmd>
  exit();
 9e6:	e8 a4 01 00 00       	call   b8f <exit>

000009eb <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
 9eb:	f3 0f 1e fb          	endbr32 
}
 9ef:	c3                   	ret    

000009f0 <strcpy>:

char*
strcpy(char *s, const char *t)
{
 9f0:	f3 0f 1e fb          	endbr32 
 9f4:	55                   	push   %ebp
 9f5:	89 e5                	mov    %esp,%ebp
 9f7:	56                   	push   %esi
 9f8:	53                   	push   %ebx
 9f9:	8b 45 08             	mov    0x8(%ebp),%eax
 9fc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 9ff:	89 c2                	mov    %eax,%edx
 a01:	89 cb                	mov    %ecx,%ebx
 a03:	41                   	inc    %ecx
 a04:	89 d6                	mov    %edx,%esi
 a06:	42                   	inc    %edx
 a07:	8a 1b                	mov    (%ebx),%bl
 a09:	88 1e                	mov    %bl,(%esi)
 a0b:	84 db                	test   %bl,%bl
 a0d:	75 f2                	jne    a01 <strcpy+0x11>
    ;
  return os;
}
 a0f:	5b                   	pop    %ebx
 a10:	5e                   	pop    %esi
 a11:	5d                   	pop    %ebp
 a12:	c3                   	ret    

00000a13 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 a13:	f3 0f 1e fb          	endbr32 
 a17:	55                   	push   %ebp
 a18:	89 e5                	mov    %esp,%ebp
 a1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 a20:	8a 01                	mov    (%ecx),%al
 a22:	84 c0                	test   %al,%al
 a24:	74 08                	je     a2e <strcmp+0x1b>
 a26:	3a 02                	cmp    (%edx),%al
 a28:	75 04                	jne    a2e <strcmp+0x1b>
    p++, q++;
 a2a:	41                   	inc    %ecx
 a2b:	42                   	inc    %edx
 a2c:	eb f2                	jmp    a20 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 a2e:	0f b6 c0             	movzbl %al,%eax
 a31:	0f b6 12             	movzbl (%edx),%edx
 a34:	29 d0                	sub    %edx,%eax
}
 a36:	5d                   	pop    %ebp
 a37:	c3                   	ret    

00000a38 <strlen>:

uint
strlen(const char *s)
{
 a38:	f3 0f 1e fb          	endbr32 
 a3c:	55                   	push   %ebp
 a3d:	89 e5                	mov    %esp,%ebp
 a3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 a42:	b8 00 00 00 00       	mov    $0x0,%eax
 a47:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 a4b:	74 03                	je     a50 <strlen+0x18>
 a4d:	40                   	inc    %eax
 a4e:	eb f7                	jmp    a47 <strlen+0xf>
    ;
  return n;
}
 a50:	5d                   	pop    %ebp
 a51:	c3                   	ret    

00000a52 <memset>:

void*
memset(void *dst, int c, uint n)
{
 a52:	f3 0f 1e fb          	endbr32 
 a56:	55                   	push   %ebp
 a57:	89 e5                	mov    %esp,%ebp
 a59:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 a5a:	8b 7d 08             	mov    0x8(%ebp),%edi
 a5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 a60:	8b 45 0c             	mov    0xc(%ebp),%eax
 a63:	fc                   	cld    
 a64:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 a66:	8b 45 08             	mov    0x8(%ebp),%eax
 a69:	5f                   	pop    %edi
 a6a:	5d                   	pop    %ebp
 a6b:	c3                   	ret    

00000a6c <strchr>:

char*
strchr(const char *s, char c)
{
 a6c:	f3 0f 1e fb          	endbr32 
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	8b 45 08             	mov    0x8(%ebp),%eax
 a76:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 a79:	8a 10                	mov    (%eax),%dl
 a7b:	84 d2                	test   %dl,%dl
 a7d:	74 07                	je     a86 <strchr+0x1a>
    if(*s == c)
 a7f:	38 ca                	cmp    %cl,%dl
 a81:	74 08                	je     a8b <strchr+0x1f>
  for(; *s; s++)
 a83:	40                   	inc    %eax
 a84:	eb f3                	jmp    a79 <strchr+0xd>
      return (char*)s;
  return 0;
 a86:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a8b:	5d                   	pop    %ebp
 a8c:	c3                   	ret    

00000a8d <gets>:

char*
gets(char *buf, int max)
{
 a8d:	f3 0f 1e fb          	endbr32 
 a91:	55                   	push   %ebp
 a92:	89 e5                	mov    %esp,%ebp
 a94:	57                   	push   %edi
 a95:	56                   	push   %esi
 a96:	53                   	push   %ebx
 a97:	83 ec 1c             	sub    $0x1c,%esp
 a9a:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a9d:	bb 00 00 00 00       	mov    $0x0,%ebx
 aa2:	89 de                	mov    %ebx,%esi
 aa4:	43                   	inc    %ebx
 aa5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 aa8:	7d 2b                	jge    ad5 <gets+0x48>
    cc = read(0, &c, 1);
 aaa:	83 ec 04             	sub    $0x4,%esp
 aad:	6a 01                	push   $0x1
 aaf:	8d 45 e7             	lea    -0x19(%ebp),%eax
 ab2:	50                   	push   %eax
 ab3:	6a 00                	push   $0x0
 ab5:	e8 ed 00 00 00       	call   ba7 <read>
    if(cc < 1)
 aba:	83 c4 10             	add    $0x10,%esp
 abd:	85 c0                	test   %eax,%eax
 abf:	7e 14                	jle    ad5 <gets+0x48>
      break;
    buf[i++] = c;
 ac1:	8a 45 e7             	mov    -0x19(%ebp),%al
 ac4:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 ac7:	3c 0a                	cmp    $0xa,%al
 ac9:	74 08                	je     ad3 <gets+0x46>
 acb:	3c 0d                	cmp    $0xd,%al
 acd:	75 d3                	jne    aa2 <gets+0x15>
    buf[i++] = c;
 acf:	89 de                	mov    %ebx,%esi
 ad1:	eb 02                	jmp    ad5 <gets+0x48>
 ad3:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 ad5:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 ad9:	89 f8                	mov    %edi,%eax
 adb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ade:	5b                   	pop    %ebx
 adf:	5e                   	pop    %esi
 ae0:	5f                   	pop    %edi
 ae1:	5d                   	pop    %ebp
 ae2:	c3                   	ret    

00000ae3 <stat>:

int
stat(const char *n, struct stat *st)
{
 ae3:	f3 0f 1e fb          	endbr32 
 ae7:	55                   	push   %ebp
 ae8:	89 e5                	mov    %esp,%ebp
 aea:	56                   	push   %esi
 aeb:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 aec:	83 ec 08             	sub    $0x8,%esp
 aef:	6a 00                	push   $0x0
 af1:	ff 75 08             	pushl  0x8(%ebp)
 af4:	e8 d6 00 00 00       	call   bcf <open>
  if(fd < 0)
 af9:	83 c4 10             	add    $0x10,%esp
 afc:	85 c0                	test   %eax,%eax
 afe:	78 24                	js     b24 <stat+0x41>
 b00:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 b02:	83 ec 08             	sub    $0x8,%esp
 b05:	ff 75 0c             	pushl  0xc(%ebp)
 b08:	50                   	push   %eax
 b09:	e8 d9 00 00 00       	call   be7 <fstat>
 b0e:	89 c6                	mov    %eax,%esi
  close(fd);
 b10:	89 1c 24             	mov    %ebx,(%esp)
 b13:	e8 9f 00 00 00       	call   bb7 <close>
  return r;
 b18:	83 c4 10             	add    $0x10,%esp
}
 b1b:	89 f0                	mov    %esi,%eax
 b1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 b20:	5b                   	pop    %ebx
 b21:	5e                   	pop    %esi
 b22:	5d                   	pop    %ebp
 b23:	c3                   	ret    
    return -1;
 b24:	be ff ff ff ff       	mov    $0xffffffff,%esi
 b29:	eb f0                	jmp    b1b <stat+0x38>

00000b2b <atoi>:

int
atoi(const char *s)
{
 b2b:	f3 0f 1e fb          	endbr32 
 b2f:	55                   	push   %ebp
 b30:	89 e5                	mov    %esp,%ebp
 b32:	53                   	push   %ebx
 b33:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 b36:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 b3b:	8a 01                	mov    (%ecx),%al
 b3d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 b40:	80 fb 09             	cmp    $0x9,%bl
 b43:	77 10                	ja     b55 <atoi+0x2a>
    n = n*10 + *s++ - '0';
 b45:	8d 14 92             	lea    (%edx,%edx,4),%edx
 b48:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
 b4b:	41                   	inc    %ecx
 b4c:	0f be c0             	movsbl %al,%eax
 b4f:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
 b53:	eb e6                	jmp    b3b <atoi+0x10>
  return n;
}
 b55:	89 d0                	mov    %edx,%eax
 b57:	5b                   	pop    %ebx
 b58:	5d                   	pop    %ebp
 b59:	c3                   	ret    

00000b5a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 b5a:	f3 0f 1e fb          	endbr32 
 b5e:	55                   	push   %ebp
 b5f:	89 e5                	mov    %esp,%ebp
 b61:	56                   	push   %esi
 b62:	53                   	push   %ebx
 b63:	8b 45 08             	mov    0x8(%ebp),%eax
 b66:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 b69:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 b6c:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 b6e:	8d 72 ff             	lea    -0x1(%edx),%esi
 b71:	85 d2                	test   %edx,%edx
 b73:	7e 0e                	jle    b83 <memmove+0x29>
    *dst++ = *src++;
 b75:	8a 13                	mov    (%ebx),%dl
 b77:	88 11                	mov    %dl,(%ecx)
 b79:	8d 5b 01             	lea    0x1(%ebx),%ebx
 b7c:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 b7f:	89 f2                	mov    %esi,%edx
 b81:	eb eb                	jmp    b6e <memmove+0x14>
  return vdst;
}
 b83:	5b                   	pop    %ebx
 b84:	5e                   	pop    %esi
 b85:	5d                   	pop    %ebp
 b86:	c3                   	ret    

00000b87 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 b87:	b8 01 00 00 00       	mov    $0x1,%eax
 b8c:	cd 40                	int    $0x40
 b8e:	c3                   	ret    

00000b8f <exit>:
SYSCALL(exit)
 b8f:	b8 02 00 00 00       	mov    $0x2,%eax
 b94:	cd 40                	int    $0x40
 b96:	c3                   	ret    

00000b97 <wait>:
SYSCALL(wait)
 b97:	b8 03 00 00 00       	mov    $0x3,%eax
 b9c:	cd 40                	int    $0x40
 b9e:	c3                   	ret    

00000b9f <pipe>:
SYSCALL(pipe)
 b9f:	b8 04 00 00 00       	mov    $0x4,%eax
 ba4:	cd 40                	int    $0x40
 ba6:	c3                   	ret    

00000ba7 <read>:
SYSCALL(read)
 ba7:	b8 05 00 00 00       	mov    $0x5,%eax
 bac:	cd 40                	int    $0x40
 bae:	c3                   	ret    

00000baf <write>:
SYSCALL(write)
 baf:	b8 10 00 00 00       	mov    $0x10,%eax
 bb4:	cd 40                	int    $0x40
 bb6:	c3                   	ret    

00000bb7 <close>:
SYSCALL(close)
 bb7:	b8 15 00 00 00       	mov    $0x15,%eax
 bbc:	cd 40                	int    $0x40
 bbe:	c3                   	ret    

00000bbf <kill>:
SYSCALL(kill)
 bbf:	b8 06 00 00 00       	mov    $0x6,%eax
 bc4:	cd 40                	int    $0x40
 bc6:	c3                   	ret    

00000bc7 <exec>:
SYSCALL(exec)
 bc7:	b8 07 00 00 00       	mov    $0x7,%eax
 bcc:	cd 40                	int    $0x40
 bce:	c3                   	ret    

00000bcf <open>:
SYSCALL(open)
 bcf:	b8 0f 00 00 00       	mov    $0xf,%eax
 bd4:	cd 40                	int    $0x40
 bd6:	c3                   	ret    

00000bd7 <mknod>:
SYSCALL(mknod)
 bd7:	b8 11 00 00 00       	mov    $0x11,%eax
 bdc:	cd 40                	int    $0x40
 bde:	c3                   	ret    

00000bdf <unlink>:
SYSCALL(unlink)
 bdf:	b8 12 00 00 00       	mov    $0x12,%eax
 be4:	cd 40                	int    $0x40
 be6:	c3                   	ret    

00000be7 <fstat>:
SYSCALL(fstat)
 be7:	b8 08 00 00 00       	mov    $0x8,%eax
 bec:	cd 40                	int    $0x40
 bee:	c3                   	ret    

00000bef <link>:
SYSCALL(link)
 bef:	b8 13 00 00 00       	mov    $0x13,%eax
 bf4:	cd 40                	int    $0x40
 bf6:	c3                   	ret    

00000bf7 <mkdir>:
SYSCALL(mkdir)
 bf7:	b8 14 00 00 00       	mov    $0x14,%eax
 bfc:	cd 40                	int    $0x40
 bfe:	c3                   	ret    

00000bff <chdir>:
SYSCALL(chdir)
 bff:	b8 09 00 00 00       	mov    $0x9,%eax
 c04:	cd 40                	int    $0x40
 c06:	c3                   	ret    

00000c07 <dup>:
SYSCALL(dup)
 c07:	b8 0a 00 00 00       	mov    $0xa,%eax
 c0c:	cd 40                	int    $0x40
 c0e:	c3                   	ret    

00000c0f <getpid>:
SYSCALL(getpid)
 c0f:	b8 0b 00 00 00       	mov    $0xb,%eax
 c14:	cd 40                	int    $0x40
 c16:	c3                   	ret    

00000c17 <sbrk>:
SYSCALL(sbrk)
 c17:	b8 0c 00 00 00       	mov    $0xc,%eax
 c1c:	cd 40                	int    $0x40
 c1e:	c3                   	ret    

00000c1f <sleep>:
SYSCALL(sleep)
 c1f:	b8 0d 00 00 00       	mov    $0xd,%eax
 c24:	cd 40                	int    $0x40
 c26:	c3                   	ret    

00000c27 <uptime>:
SYSCALL(uptime)
 c27:	b8 0e 00 00 00       	mov    $0xe,%eax
 c2c:	cd 40                	int    $0x40
 c2e:	c3                   	ret    

00000c2f <date>:
SYSCALL(date)
 c2f:	b8 16 00 00 00       	mov    $0x16,%eax
 c34:	cd 40                	int    $0x40
 c36:	c3                   	ret    

00000c37 <dup2>:
SYSCALL(dup2)
 c37:	b8 17 00 00 00       	mov    $0x17,%eax
 c3c:	cd 40                	int    $0x40
 c3e:	c3                   	ret    

00000c3f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 c3f:	55                   	push   %ebp
 c40:	89 e5                	mov    %esp,%ebp
 c42:	83 ec 1c             	sub    $0x1c,%esp
 c45:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 c48:	6a 01                	push   $0x1
 c4a:	8d 55 f4             	lea    -0xc(%ebp),%edx
 c4d:	52                   	push   %edx
 c4e:	50                   	push   %eax
 c4f:	e8 5b ff ff ff       	call   baf <write>
}
 c54:	83 c4 10             	add    $0x10,%esp
 c57:	c9                   	leave  
 c58:	c3                   	ret    

00000c59 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 c59:	55                   	push   %ebp
 c5a:	89 e5                	mov    %esp,%ebp
 c5c:	57                   	push   %edi
 c5d:	56                   	push   %esi
 c5e:	53                   	push   %ebx
 c5f:	83 ec 2c             	sub    $0x2c,%esp
 c62:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 c65:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 c67:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 c6b:	74 04                	je     c71 <printint+0x18>
 c6d:	85 d2                	test   %edx,%edx
 c6f:	78 3a                	js     cab <printint+0x52>
  neg = 0;
 c71:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 c78:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 c7d:	89 f0                	mov    %esi,%eax
 c7f:	ba 00 00 00 00       	mov    $0x0,%edx
 c84:	f7 f1                	div    %ecx
 c86:	89 df                	mov    %ebx,%edi
 c88:	43                   	inc    %ebx
 c89:	8a 92 68 10 00 00    	mov    0x1068(%edx),%dl
 c8f:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 c93:	89 f2                	mov    %esi,%edx
 c95:	89 c6                	mov    %eax,%esi
 c97:	39 d1                	cmp    %edx,%ecx
 c99:	76 e2                	jbe    c7d <printint+0x24>
  if(neg)
 c9b:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
 c9f:	74 22                	je     cc3 <printint+0x6a>
    buf[i++] = '-';
 ca1:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 ca6:	8d 5f 02             	lea    0x2(%edi),%ebx
 ca9:	eb 18                	jmp    cc3 <printint+0x6a>
    x = -xx;
 cab:	f7 de                	neg    %esi
    neg = 1;
 cad:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
 cb4:	eb c2                	jmp    c78 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
 cb6:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 cbb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 cbe:	e8 7c ff ff ff       	call   c3f <putc>
  while(--i >= 0)
 cc3:	4b                   	dec    %ebx
 cc4:	79 f0                	jns    cb6 <printint+0x5d>
}
 cc6:	83 c4 2c             	add    $0x2c,%esp
 cc9:	5b                   	pop    %ebx
 cca:	5e                   	pop    %esi
 ccb:	5f                   	pop    %edi
 ccc:	5d                   	pop    %ebp
 ccd:	c3                   	ret    

00000cce <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 cce:	f3 0f 1e fb          	endbr32 
 cd2:	55                   	push   %ebp
 cd3:	89 e5                	mov    %esp,%ebp
 cd5:	57                   	push   %edi
 cd6:	56                   	push   %esi
 cd7:	53                   	push   %ebx
 cd8:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 cdb:	8d 45 10             	lea    0x10(%ebp),%eax
 cde:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 ce1:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 ce6:	bb 00 00 00 00       	mov    $0x0,%ebx
 ceb:	eb 12                	jmp    cff <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 ced:	89 fa                	mov    %edi,%edx
 cef:	8b 45 08             	mov    0x8(%ebp),%eax
 cf2:	e8 48 ff ff ff       	call   c3f <putc>
 cf7:	eb 05                	jmp    cfe <printf+0x30>
      }
    } else if(state == '%'){
 cf9:	83 fe 25             	cmp    $0x25,%esi
 cfc:	74 22                	je     d20 <printf+0x52>
  for(i = 0; fmt[i]; i++){
 cfe:	43                   	inc    %ebx
 cff:	8b 45 0c             	mov    0xc(%ebp),%eax
 d02:	8a 04 18             	mov    (%eax,%ebx,1),%al
 d05:	84 c0                	test   %al,%al
 d07:	0f 84 13 01 00 00    	je     e20 <printf+0x152>
    c = fmt[i] & 0xff;
 d0d:	0f be f8             	movsbl %al,%edi
 d10:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 d13:	85 f6                	test   %esi,%esi
 d15:	75 e2                	jne    cf9 <printf+0x2b>
      if(c == '%'){
 d17:	83 f8 25             	cmp    $0x25,%eax
 d1a:	75 d1                	jne    ced <printf+0x1f>
        state = '%';
 d1c:	89 c6                	mov    %eax,%esi
 d1e:	eb de                	jmp    cfe <printf+0x30>
      if(c == 'd'){
 d20:	83 f8 64             	cmp    $0x64,%eax
 d23:	74 43                	je     d68 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 d25:	83 f8 78             	cmp    $0x78,%eax
 d28:	74 68                	je     d92 <printf+0xc4>
 d2a:	83 f8 70             	cmp    $0x70,%eax
 d2d:	74 63                	je     d92 <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 d2f:	83 f8 73             	cmp    $0x73,%eax
 d32:	0f 84 84 00 00 00    	je     dbc <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 d38:	83 f8 63             	cmp    $0x63,%eax
 d3b:	0f 84 ad 00 00 00    	je     dee <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d41:	83 f8 25             	cmp    $0x25,%eax
 d44:	0f 84 c2 00 00 00    	je     e0c <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 d4a:	ba 25 00 00 00       	mov    $0x25,%edx
 d4f:	8b 45 08             	mov    0x8(%ebp),%eax
 d52:	e8 e8 fe ff ff       	call   c3f <putc>
        putc(fd, c);
 d57:	89 fa                	mov    %edi,%edx
 d59:	8b 45 08             	mov    0x8(%ebp),%eax
 d5c:	e8 de fe ff ff       	call   c3f <putc>
      }
      state = 0;
 d61:	be 00 00 00 00       	mov    $0x0,%esi
 d66:	eb 96                	jmp    cfe <printf+0x30>
        printint(fd, *ap, 10, 1);
 d68:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 d6b:	8b 17                	mov    (%edi),%edx
 d6d:	83 ec 0c             	sub    $0xc,%esp
 d70:	6a 01                	push   $0x1
 d72:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d77:	8b 45 08             	mov    0x8(%ebp),%eax
 d7a:	e8 da fe ff ff       	call   c59 <printint>
        ap++;
 d7f:	83 c7 04             	add    $0x4,%edi
 d82:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 d85:	83 c4 10             	add    $0x10,%esp
      state = 0;
 d88:	be 00 00 00 00       	mov    $0x0,%esi
 d8d:	e9 6c ff ff ff       	jmp    cfe <printf+0x30>
        printint(fd, *ap, 16, 0);
 d92:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 d95:	8b 17                	mov    (%edi),%edx
 d97:	83 ec 0c             	sub    $0xc,%esp
 d9a:	6a 00                	push   $0x0
 d9c:	b9 10 00 00 00       	mov    $0x10,%ecx
 da1:	8b 45 08             	mov    0x8(%ebp),%eax
 da4:	e8 b0 fe ff ff       	call   c59 <printint>
        ap++;
 da9:	83 c7 04             	add    $0x4,%edi
 dac:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 daf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 db2:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
 db7:	e9 42 ff ff ff       	jmp    cfe <printf+0x30>
        s = (char*)*ap;
 dbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 dbf:	8b 30                	mov    (%eax),%esi
        ap++;
 dc1:	83 c0 04             	add    $0x4,%eax
 dc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 dc7:	85 f6                	test   %esi,%esi
 dc9:	75 13                	jne    dde <printf+0x110>
          s = "(null)";
 dcb:	be 60 10 00 00       	mov    $0x1060,%esi
 dd0:	eb 0c                	jmp    dde <printf+0x110>
          putc(fd, *s);
 dd2:	0f be d2             	movsbl %dl,%edx
 dd5:	8b 45 08             	mov    0x8(%ebp),%eax
 dd8:	e8 62 fe ff ff       	call   c3f <putc>
          s++;
 ddd:	46                   	inc    %esi
        while(*s != 0){
 dde:	8a 16                	mov    (%esi),%dl
 de0:	84 d2                	test   %dl,%dl
 de2:	75 ee                	jne    dd2 <printf+0x104>
      state = 0;
 de4:	be 00 00 00 00       	mov    $0x0,%esi
 de9:	e9 10 ff ff ff       	jmp    cfe <printf+0x30>
        putc(fd, *ap);
 dee:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 df1:	0f be 17             	movsbl (%edi),%edx
 df4:	8b 45 08             	mov    0x8(%ebp),%eax
 df7:	e8 43 fe ff ff       	call   c3f <putc>
        ap++;
 dfc:	83 c7 04             	add    $0x4,%edi
 dff:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 e02:	be 00 00 00 00       	mov    $0x0,%esi
 e07:	e9 f2 fe ff ff       	jmp    cfe <printf+0x30>
        putc(fd, c);
 e0c:	89 fa                	mov    %edi,%edx
 e0e:	8b 45 08             	mov    0x8(%ebp),%eax
 e11:	e8 29 fe ff ff       	call   c3f <putc>
      state = 0;
 e16:	be 00 00 00 00       	mov    $0x0,%esi
 e1b:	e9 de fe ff ff       	jmp    cfe <printf+0x30>
    }
  }
}
 e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
 e23:	5b                   	pop    %ebx
 e24:	5e                   	pop    %esi
 e25:	5f                   	pop    %edi
 e26:	5d                   	pop    %ebp
 e27:	c3                   	ret    

00000e28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e28:	f3 0f 1e fb          	endbr32 
 e2c:	55                   	push   %ebp
 e2d:	89 e5                	mov    %esp,%ebp
 e2f:	57                   	push   %edi
 e30:	56                   	push   %esi
 e31:	53                   	push   %ebx
 e32:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e35:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e38:	a1 64 16 00 00       	mov    0x1664,%eax
 e3d:	eb 02                	jmp    e41 <free+0x19>
 e3f:	89 d0                	mov    %edx,%eax
 e41:	39 c8                	cmp    %ecx,%eax
 e43:	73 04                	jae    e49 <free+0x21>
 e45:	39 08                	cmp    %ecx,(%eax)
 e47:	77 12                	ja     e5b <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e49:	8b 10                	mov    (%eax),%edx
 e4b:	39 c2                	cmp    %eax,%edx
 e4d:	77 f0                	ja     e3f <free+0x17>
 e4f:	39 c8                	cmp    %ecx,%eax
 e51:	72 08                	jb     e5b <free+0x33>
 e53:	39 ca                	cmp    %ecx,%edx
 e55:	77 04                	ja     e5b <free+0x33>
 e57:	89 d0                	mov    %edx,%eax
 e59:	eb e6                	jmp    e41 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e5b:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e5e:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e61:	8b 10                	mov    (%eax),%edx
 e63:	39 d7                	cmp    %edx,%edi
 e65:	74 19                	je     e80 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e67:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e6a:	8b 50 04             	mov    0x4(%eax),%edx
 e6d:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e70:	39 ce                	cmp    %ecx,%esi
 e72:	74 1b                	je     e8f <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e74:	89 08                	mov    %ecx,(%eax)
  freep = p;
 e76:	a3 64 16 00 00       	mov    %eax,0x1664
}
 e7b:	5b                   	pop    %ebx
 e7c:	5e                   	pop    %esi
 e7d:	5f                   	pop    %edi
 e7e:	5d                   	pop    %ebp
 e7f:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 e80:	03 72 04             	add    0x4(%edx),%esi
 e83:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e86:	8b 10                	mov    (%eax),%edx
 e88:	8b 12                	mov    (%edx),%edx
 e8a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 e8d:	eb db                	jmp    e6a <free+0x42>
    p->s.size += bp->s.size;
 e8f:	03 53 fc             	add    -0x4(%ebx),%edx
 e92:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e95:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e98:	89 10                	mov    %edx,(%eax)
 e9a:	eb da                	jmp    e76 <free+0x4e>

00000e9c <morecore>:

static Header*
morecore(uint nu)
{
 e9c:	55                   	push   %ebp
 e9d:	89 e5                	mov    %esp,%ebp
 e9f:	53                   	push   %ebx
 ea0:	83 ec 04             	sub    $0x4,%esp
 ea3:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 ea5:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 eaa:	77 05                	ja     eb1 <morecore+0x15>
    nu = 4096;
 eac:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 eb1:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 eb8:	83 ec 0c             	sub    $0xc,%esp
 ebb:	50                   	push   %eax
 ebc:	e8 56 fd ff ff       	call   c17 <sbrk>
  if(p == (char*)-1)
 ec1:	83 c4 10             	add    $0x10,%esp
 ec4:	83 f8 ff             	cmp    $0xffffffff,%eax
 ec7:	74 1c                	je     ee5 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 ec9:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ecc:	83 c0 08             	add    $0x8,%eax
 ecf:	83 ec 0c             	sub    $0xc,%esp
 ed2:	50                   	push   %eax
 ed3:	e8 50 ff ff ff       	call   e28 <free>
  return freep;
 ed8:	a1 64 16 00 00       	mov    0x1664,%eax
 edd:	83 c4 10             	add    $0x10,%esp
}
 ee0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 ee3:	c9                   	leave  
 ee4:	c3                   	ret    
    return 0;
 ee5:	b8 00 00 00 00       	mov    $0x0,%eax
 eea:	eb f4                	jmp    ee0 <morecore+0x44>

00000eec <malloc>:

void*
malloc(uint nbytes)
{
 eec:	f3 0f 1e fb          	endbr32 
 ef0:	55                   	push   %ebp
 ef1:	89 e5                	mov    %esp,%ebp
 ef3:	53                   	push   %ebx
 ef4:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ef7:	8b 45 08             	mov    0x8(%ebp),%eax
 efa:	8d 58 07             	lea    0x7(%eax),%ebx
 efd:	c1 eb 03             	shr    $0x3,%ebx
 f00:	43                   	inc    %ebx
  if((prevp = freep) == 0){
 f01:	8b 0d 64 16 00 00    	mov    0x1664,%ecx
 f07:	85 c9                	test   %ecx,%ecx
 f09:	74 04                	je     f0f <malloc+0x23>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f0b:	8b 01                	mov    (%ecx),%eax
 f0d:	eb 4b                	jmp    f5a <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 f0f:	c7 05 64 16 00 00 68 	movl   $0x1668,0x1664
 f16:	16 00 00 
 f19:	c7 05 68 16 00 00 68 	movl   $0x1668,0x1668
 f20:	16 00 00 
    base.s.size = 0;
 f23:	c7 05 6c 16 00 00 00 	movl   $0x0,0x166c
 f2a:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 f2d:	b9 68 16 00 00       	mov    $0x1668,%ecx
 f32:	eb d7                	jmp    f0b <malloc+0x1f>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f34:	74 1a                	je     f50 <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f36:	29 da                	sub    %ebx,%edx
 f38:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 f3b:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 f3e:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 f41:	89 0d 64 16 00 00    	mov    %ecx,0x1664
      return (void*)(p + 1);
 f47:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 f4a:	83 c4 04             	add    $0x4,%esp
 f4d:	5b                   	pop    %ebx
 f4e:	5d                   	pop    %ebp
 f4f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 f50:	8b 10                	mov    (%eax),%edx
 f52:	89 11                	mov    %edx,(%ecx)
 f54:	eb eb                	jmp    f41 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f56:	89 c1                	mov    %eax,%ecx
 f58:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 f5a:	8b 50 04             	mov    0x4(%eax),%edx
 f5d:	39 da                	cmp    %ebx,%edx
 f5f:	73 d3                	jae    f34 <malloc+0x48>
    if(p == freep)
 f61:	39 05 64 16 00 00    	cmp    %eax,0x1664
 f67:	75 ed                	jne    f56 <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 f69:	89 d8                	mov    %ebx,%eax
 f6b:	e8 2c ff ff ff       	call   e9c <morecore>
 f70:	85 c0                	test   %eax,%eax
 f72:	75 e2                	jne    f56 <malloc+0x6a>
 f74:	eb d4                	jmp    f4a <malloc+0x5e>
