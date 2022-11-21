
usertests:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
       a:	68 ca 3b 00 00       	push   $0x3bca
       f:	ff 35 80 5b 00 00    	pushl  0x5b80
      15:	e8 6e 38 00 00       	call   3888 <printf>

  if(mkdir("iputdir") < 0){
      1a:	c7 04 24 5d 3b 00 00 	movl   $0x3b5d,(%esp)
      21:	e8 8b 37 00 00       	call   37b1 <mkdir>
      26:	83 c4 10             	add    $0x10,%esp
      29:	85 c0                	test   %eax,%eax
      2b:	78 54                	js     81 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
      2d:	83 ec 0c             	sub    $0xc,%esp
      30:	68 5d 3b 00 00       	push   $0x3b5d
      35:	e8 7f 37 00 00       	call   37b9 <chdir>
      3a:	83 c4 10             	add    $0x10,%esp
      3d:	85 c0                	test   %eax,%eax
      3f:	78 58                	js     99 <iputtest+0x99>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
      41:	83 ec 0c             	sub    $0xc,%esp
      44:	68 5a 3b 00 00       	push   $0x3b5a
      49:	e8 4b 37 00 00       	call   3799 <unlink>
      4e:	83 c4 10             	add    $0x10,%esp
      51:	85 c0                	test   %eax,%eax
      53:	78 5c                	js     b1 <iputtest+0xb1>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
      55:	83 ec 0c             	sub    $0xc,%esp
      58:	68 7f 3b 00 00       	push   $0x3b7f
      5d:	e8 57 37 00 00       	call   37b9 <chdir>
      62:	83 c4 10             	add    $0x10,%esp
      65:	85 c0                	test   %eax,%eax
      67:	78 60                	js     c9 <iputtest+0xc9>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
      69:	83 ec 08             	sub    $0x8,%esp
      6c:	68 02 3c 00 00       	push   $0x3c02
      71:	ff 35 80 5b 00 00    	pushl  0x5b80
      77:	e8 0c 38 00 00       	call   3888 <printf>
}
      7c:	83 c4 10             	add    $0x10,%esp
      7f:	c9                   	leave  
      80:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
      81:	83 ec 08             	sub    $0x8,%esp
      84:	68 36 3b 00 00       	push   $0x3b36
      89:	ff 35 80 5b 00 00    	pushl  0x5b80
      8f:	e8 f4 37 00 00       	call   3888 <printf>
    exit();
      94:	e8 b0 36 00 00       	call   3749 <exit>
    printf(stdout, "chdir iputdir failed\n");
      99:	83 ec 08             	sub    $0x8,%esp
      9c:	68 44 3b 00 00       	push   $0x3b44
      a1:	ff 35 80 5b 00 00    	pushl  0x5b80
      a7:	e8 dc 37 00 00       	call   3888 <printf>
    exit();
      ac:	e8 98 36 00 00       	call   3749 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
      b1:	83 ec 08             	sub    $0x8,%esp
      b4:	68 65 3b 00 00       	push   $0x3b65
      b9:	ff 35 80 5b 00 00    	pushl  0x5b80
      bf:	e8 c4 37 00 00       	call   3888 <printf>
    exit();
      c4:	e8 80 36 00 00       	call   3749 <exit>
    printf(stdout, "chdir / failed\n");
      c9:	83 ec 08             	sub    $0x8,%esp
      cc:	68 81 3b 00 00       	push   $0x3b81
      d1:	ff 35 80 5b 00 00    	pushl  0x5b80
      d7:	e8 ac 37 00 00       	call   3888 <printf>
    exit();
      dc:	e8 68 36 00 00       	call   3749 <exit>

000000e1 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      e1:	f3 0f 1e fb          	endbr32 
      e5:	55                   	push   %ebp
      e6:	89 e5                	mov    %esp,%ebp
      e8:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      eb:	68 91 3b 00 00       	push   $0x3b91
      f0:	ff 35 80 5b 00 00    	pushl  0x5b80
      f6:	e8 8d 37 00 00       	call   3888 <printf>

  pid = fork();
      fb:	e8 41 36 00 00       	call   3741 <fork>
  if(pid < 0){
     100:	83 c4 10             	add    $0x10,%esp
     103:	85 c0                	test   %eax,%eax
     105:	78 47                	js     14e <exitiputtest+0x6d>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     107:	0f 85 a1 00 00 00    	jne    1ae <exitiputtest+0xcd>
    if(mkdir("iputdir") < 0){
     10d:	83 ec 0c             	sub    $0xc,%esp
     110:	68 5d 3b 00 00       	push   $0x3b5d
     115:	e8 97 36 00 00       	call   37b1 <mkdir>
     11a:	83 c4 10             	add    $0x10,%esp
     11d:	85 c0                	test   %eax,%eax
     11f:	78 45                	js     166 <exitiputtest+0x85>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     121:	83 ec 0c             	sub    $0xc,%esp
     124:	68 5d 3b 00 00       	push   $0x3b5d
     129:	e8 8b 36 00 00       	call   37b9 <chdir>
     12e:	83 c4 10             	add    $0x10,%esp
     131:	85 c0                	test   %eax,%eax
     133:	78 49                	js     17e <exitiputtest+0x9d>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     135:	83 ec 0c             	sub    $0xc,%esp
     138:	68 5a 3b 00 00       	push   $0x3b5a
     13d:	e8 57 36 00 00       	call   3799 <unlink>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 4d                	js     196 <exitiputtest+0xb5>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     149:	e8 fb 35 00 00       	call   3749 <exit>
    printf(stdout, "fork failed\n");
     14e:	83 ec 08             	sub    $0x8,%esp
     151:	68 71 4a 00 00       	push   $0x4a71
     156:	ff 35 80 5b 00 00    	pushl  0x5b80
     15c:	e8 27 37 00 00       	call   3888 <printf>
    exit();
     161:	e8 e3 35 00 00       	call   3749 <exit>
      printf(stdout, "mkdir failed\n");
     166:	83 ec 08             	sub    $0x8,%esp
     169:	68 36 3b 00 00       	push   $0x3b36
     16e:	ff 35 80 5b 00 00    	pushl  0x5b80
     174:	e8 0f 37 00 00       	call   3888 <printf>
      exit();
     179:	e8 cb 35 00 00       	call   3749 <exit>
      printf(stdout, "child chdir failed\n");
     17e:	83 ec 08             	sub    $0x8,%esp
     181:	68 a0 3b 00 00       	push   $0x3ba0
     186:	ff 35 80 5b 00 00    	pushl  0x5b80
     18c:	e8 f7 36 00 00       	call   3888 <printf>
      exit();
     191:	e8 b3 35 00 00       	call   3749 <exit>
      printf(stdout, "unlink ../iputdir failed\n");
     196:	83 ec 08             	sub    $0x8,%esp
     199:	68 65 3b 00 00       	push   $0x3b65
     19e:	ff 35 80 5b 00 00    	pushl  0x5b80
     1a4:	e8 df 36 00 00       	call   3888 <printf>
      exit();
     1a9:	e8 9b 35 00 00       	call   3749 <exit>
  }
  wait();
     1ae:	e8 9e 35 00 00       	call   3751 <wait>
  printf(stdout, "exitiput test ok\n");
     1b3:	83 ec 08             	sub    $0x8,%esp
     1b6:	68 b4 3b 00 00       	push   $0x3bb4
     1bb:	ff 35 80 5b 00 00    	pushl  0x5b80
     1c1:	e8 c2 36 00 00       	call   3888 <printf>
}
     1c6:	83 c4 10             	add    $0x10,%esp
     1c9:	c9                   	leave  
     1ca:	c3                   	ret    

000001cb <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     1cb:	f3 0f 1e fb          	endbr32 
     1cf:	55                   	push   %ebp
     1d0:	89 e5                	mov    %esp,%ebp
     1d2:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
     1d5:	68 c6 3b 00 00       	push   $0x3bc6
     1da:	ff 35 80 5b 00 00    	pushl  0x5b80
     1e0:	e8 a3 36 00 00       	call   3888 <printf>
  if(mkdir("oidir") < 0){
     1e5:	c7 04 24 d5 3b 00 00 	movl   $0x3bd5,(%esp)
     1ec:	e8 c0 35 00 00       	call   37b1 <mkdir>
     1f1:	83 c4 10             	add    $0x10,%esp
     1f4:	85 c0                	test   %eax,%eax
     1f6:	78 39                	js     231 <openiputtest+0x66>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
     1f8:	e8 44 35 00 00       	call   3741 <fork>
  if(pid < 0){
     1fd:	85 c0                	test   %eax,%eax
     1ff:	78 48                	js     249 <openiputtest+0x7e>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     201:	75 63                	jne    266 <openiputtest+0x9b>
    int fd = open("oidir", O_RDWR);
     203:	83 ec 08             	sub    $0x8,%esp
     206:	6a 02                	push   $0x2
     208:	68 d5 3b 00 00       	push   $0x3bd5
     20d:	e8 77 35 00 00       	call   3789 <open>
    if(fd >= 0){
     212:	83 c4 10             	add    $0x10,%esp
     215:	85 c0                	test   %eax,%eax
     217:	78 48                	js     261 <openiputtest+0x96>
      printf(stdout, "open directory for write succeeded\n");
     219:	83 ec 08             	sub    $0x8,%esp
     21c:	68 54 4b 00 00       	push   $0x4b54
     221:	ff 35 80 5b 00 00    	pushl  0x5b80
     227:	e8 5c 36 00 00       	call   3888 <printf>
      exit();
     22c:	e8 18 35 00 00       	call   3749 <exit>
    printf(stdout, "mkdir oidir failed\n");
     231:	83 ec 08             	sub    $0x8,%esp
     234:	68 db 3b 00 00       	push   $0x3bdb
     239:	ff 35 80 5b 00 00    	pushl  0x5b80
     23f:	e8 44 36 00 00       	call   3888 <printf>
    exit();
     244:	e8 00 35 00 00       	call   3749 <exit>
    printf(stdout, "fork failed\n");
     249:	83 ec 08             	sub    $0x8,%esp
     24c:	68 71 4a 00 00       	push   $0x4a71
     251:	ff 35 80 5b 00 00    	pushl  0x5b80
     257:	e8 2c 36 00 00       	call   3888 <printf>
    exit();
     25c:	e8 e8 34 00 00       	call   3749 <exit>
    }
    exit();
     261:	e8 e3 34 00 00       	call   3749 <exit>
  }
  sleep(1);
     266:	83 ec 0c             	sub    $0xc,%esp
     269:	6a 01                	push   $0x1
     26b:	e8 69 35 00 00       	call   37d9 <sleep>
  if(unlink("oidir") != 0){
     270:	c7 04 24 d5 3b 00 00 	movl   $0x3bd5,(%esp)
     277:	e8 1d 35 00 00       	call   3799 <unlink>
     27c:	83 c4 10             	add    $0x10,%esp
     27f:	85 c0                	test   %eax,%eax
     281:	75 1d                	jne    2a0 <openiputtest+0xd5>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     283:	e8 c9 34 00 00       	call   3751 <wait>
  printf(stdout, "openiput test ok\n");
     288:	83 ec 08             	sub    $0x8,%esp
     28b:	68 fe 3b 00 00       	push   $0x3bfe
     290:	ff 35 80 5b 00 00    	pushl  0x5b80
     296:	e8 ed 35 00 00       	call   3888 <printf>
}
     29b:	83 c4 10             	add    $0x10,%esp
     29e:	c9                   	leave  
     29f:	c3                   	ret    
    printf(stdout, "unlink failed\n");
     2a0:	83 ec 08             	sub    $0x8,%esp
     2a3:	68 ef 3b 00 00       	push   $0x3bef
     2a8:	ff 35 80 5b 00 00    	pushl  0x5b80
     2ae:	e8 d5 35 00 00       	call   3888 <printf>
    exit();
     2b3:	e8 91 34 00 00       	call   3749 <exit>

000002b8 <opentest>:

// simple file system tests

void
opentest(void)
{
     2b8:	f3 0f 1e fb          	endbr32 
     2bc:	55                   	push   %ebp
     2bd:	89 e5                	mov    %esp,%ebp
     2bf:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     2c2:	68 10 3c 00 00       	push   $0x3c10
     2c7:	ff 35 80 5b 00 00    	pushl  0x5b80
     2cd:	e8 b6 35 00 00       	call   3888 <printf>
  fd = open("echo", 0);
     2d2:	83 c4 08             	add    $0x8,%esp
     2d5:	6a 00                	push   $0x0
     2d7:	68 1b 3c 00 00       	push   $0x3c1b
     2dc:	e8 a8 34 00 00       	call   3789 <open>
  if(fd < 0){
     2e1:	83 c4 10             	add    $0x10,%esp
     2e4:	85 c0                	test   %eax,%eax
     2e6:	78 37                	js     31f <opentest+0x67>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     2e8:	83 ec 0c             	sub    $0xc,%esp
     2eb:	50                   	push   %eax
     2ec:	e8 80 34 00 00       	call   3771 <close>
  fd = open("doesnotexist", 0);
     2f1:	83 c4 08             	add    $0x8,%esp
     2f4:	6a 00                	push   $0x0
     2f6:	68 33 3c 00 00       	push   $0x3c33
     2fb:	e8 89 34 00 00       	call   3789 <open>
  if(fd >= 0){
     300:	83 c4 10             	add    $0x10,%esp
     303:	85 c0                	test   %eax,%eax
     305:	79 30                	jns    337 <opentest+0x7f>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     307:	83 ec 08             	sub    $0x8,%esp
     30a:	68 5e 3c 00 00       	push   $0x3c5e
     30f:	ff 35 80 5b 00 00    	pushl  0x5b80
     315:	e8 6e 35 00 00       	call   3888 <printf>
}
     31a:	83 c4 10             	add    $0x10,%esp
     31d:	c9                   	leave  
     31e:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     31f:	83 ec 08             	sub    $0x8,%esp
     322:	68 20 3c 00 00       	push   $0x3c20
     327:	ff 35 80 5b 00 00    	pushl  0x5b80
     32d:	e8 56 35 00 00       	call   3888 <printf>
    exit();
     332:	e8 12 34 00 00       	call   3749 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     337:	83 ec 08             	sub    $0x8,%esp
     33a:	68 40 3c 00 00       	push   $0x3c40
     33f:	ff 35 80 5b 00 00    	pushl  0x5b80
     345:	e8 3e 35 00 00       	call   3888 <printf>
    exit();
     34a:	e8 fa 33 00 00       	call   3749 <exit>

0000034f <writetest>:

void
writetest(void)
{
     34f:	f3 0f 1e fb          	endbr32 
     353:	55                   	push   %ebp
     354:	89 e5                	mov    %esp,%ebp
     356:	56                   	push   %esi
     357:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     358:	83 ec 08             	sub    $0x8,%esp
     35b:	68 6c 3c 00 00       	push   $0x3c6c
     360:	ff 35 80 5b 00 00    	pushl  0x5b80
     366:	e8 1d 35 00 00       	call   3888 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     36b:	83 c4 08             	add    $0x8,%esp
     36e:	68 02 02 00 00       	push   $0x202
     373:	68 7d 3c 00 00       	push   $0x3c7d
     378:	e8 0c 34 00 00       	call   3789 <open>
  if(fd >= 0){
     37d:	83 c4 10             	add    $0x10,%esp
     380:	85 c0                	test   %eax,%eax
     382:	78 55                	js     3d9 <writetest+0x8a>
     384:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     386:	83 ec 08             	sub    $0x8,%esp
     389:	68 83 3c 00 00       	push   $0x3c83
     38e:	ff 35 80 5b 00 00    	pushl  0x5b80
     394:	e8 ef 34 00 00       	call   3888 <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     399:	83 c4 10             	add    $0x10,%esp
     39c:	bb 00 00 00 00       	mov    $0x0,%ebx
     3a1:	83 fb 63             	cmp    $0x63,%ebx
     3a4:	7f 7d                	jg     423 <writetest+0xd4>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     3a6:	83 ec 04             	sub    $0x4,%esp
     3a9:	6a 0a                	push   $0xa
     3ab:	68 ba 3c 00 00       	push   $0x3cba
     3b0:	56                   	push   %esi
     3b1:	e8 b3 33 00 00       	call   3769 <write>
     3b6:	83 c4 10             	add    $0x10,%esp
     3b9:	83 f8 0a             	cmp    $0xa,%eax
     3bc:	75 33                	jne    3f1 <writetest+0xa2>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     3be:	83 ec 04             	sub    $0x4,%esp
     3c1:	6a 0a                	push   $0xa
     3c3:	68 c5 3c 00 00       	push   $0x3cc5
     3c8:	56                   	push   %esi
     3c9:	e8 9b 33 00 00       	call   3769 <write>
     3ce:	83 c4 10             	add    $0x10,%esp
     3d1:	83 f8 0a             	cmp    $0xa,%eax
     3d4:	75 34                	jne    40a <writetest+0xbb>
  for(i = 0; i < 100; i++){
     3d6:	43                   	inc    %ebx
     3d7:	eb c8                	jmp    3a1 <writetest+0x52>
    printf(stdout, "error: creat small failed!\n");
     3d9:	83 ec 08             	sub    $0x8,%esp
     3dc:	68 9e 3c 00 00       	push   $0x3c9e
     3e1:	ff 35 80 5b 00 00    	pushl  0x5b80
     3e7:	e8 9c 34 00 00       	call   3888 <printf>
    exit();
     3ec:	e8 58 33 00 00       	call   3749 <exit>
      printf(stdout, "error: write aa %d new file failed\n", i);
     3f1:	83 ec 04             	sub    $0x4,%esp
     3f4:	53                   	push   %ebx
     3f5:	68 78 4b 00 00       	push   $0x4b78
     3fa:	ff 35 80 5b 00 00    	pushl  0x5b80
     400:	e8 83 34 00 00       	call   3888 <printf>
      exit();
     405:	e8 3f 33 00 00       	call   3749 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     40a:	83 ec 04             	sub    $0x4,%esp
     40d:	53                   	push   %ebx
     40e:	68 9c 4b 00 00       	push   $0x4b9c
     413:	ff 35 80 5b 00 00    	pushl  0x5b80
     419:	e8 6a 34 00 00       	call   3888 <printf>
      exit();
     41e:	e8 26 33 00 00       	call   3749 <exit>
    }
  }
  printf(stdout, "writes ok\n");
     423:	83 ec 08             	sub    $0x8,%esp
     426:	68 d0 3c 00 00       	push   $0x3cd0
     42b:	ff 35 80 5b 00 00    	pushl  0x5b80
     431:	e8 52 34 00 00       	call   3888 <printf>
  close(fd);
     436:	89 34 24             	mov    %esi,(%esp)
     439:	e8 33 33 00 00       	call   3771 <close>
  fd = open("small", O_RDONLY);
     43e:	83 c4 08             	add    $0x8,%esp
     441:	6a 00                	push   $0x0
     443:	68 7d 3c 00 00       	push   $0x3c7d
     448:	e8 3c 33 00 00       	call   3789 <open>
     44d:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     44f:	83 c4 10             	add    $0x10,%esp
     452:	85 c0                	test   %eax,%eax
     454:	78 7b                	js     4d1 <writetest+0x182>
    printf(stdout, "open small succeeded ok\n");
     456:	83 ec 08             	sub    $0x8,%esp
     459:	68 db 3c 00 00       	push   $0x3cdb
     45e:	ff 35 80 5b 00 00    	pushl  0x5b80
     464:	e8 1f 34 00 00       	call   3888 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     469:	83 c4 0c             	add    $0xc,%esp
     46c:	68 d0 07 00 00       	push   $0x7d0
     471:	68 60 83 00 00       	push   $0x8360
     476:	53                   	push   %ebx
     477:	e8 e5 32 00 00       	call   3761 <read>
  if(i == 2000){
     47c:	83 c4 10             	add    $0x10,%esp
     47f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     484:	75 63                	jne    4e9 <writetest+0x19a>
    printf(stdout, "read succeeded ok\n");
     486:	83 ec 08             	sub    $0x8,%esp
     489:	68 0f 3d 00 00       	push   $0x3d0f
     48e:	ff 35 80 5b 00 00    	pushl  0x5b80
     494:	e8 ef 33 00 00       	call   3888 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     499:	89 1c 24             	mov    %ebx,(%esp)
     49c:	e8 d0 32 00 00       	call   3771 <close>

  if(unlink("small") < 0){
     4a1:	c7 04 24 7d 3c 00 00 	movl   $0x3c7d,(%esp)
     4a8:	e8 ec 32 00 00       	call   3799 <unlink>
     4ad:	83 c4 10             	add    $0x10,%esp
     4b0:	85 c0                	test   %eax,%eax
     4b2:	78 4d                	js     501 <writetest+0x1b2>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	68 37 3d 00 00       	push   $0x3d37
     4bc:	ff 35 80 5b 00 00    	pushl  0x5b80
     4c2:	e8 c1 33 00 00       	call   3888 <printf>
}
     4c7:	83 c4 10             	add    $0x10,%esp
     4ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
     4cd:	5b                   	pop    %ebx
     4ce:	5e                   	pop    %esi
     4cf:	5d                   	pop    %ebp
     4d0:	c3                   	ret    
    printf(stdout, "error: open small failed!\n");
     4d1:	83 ec 08             	sub    $0x8,%esp
     4d4:	68 f4 3c 00 00       	push   $0x3cf4
     4d9:	ff 35 80 5b 00 00    	pushl  0x5b80
     4df:	e8 a4 33 00 00       	call   3888 <printf>
    exit();
     4e4:	e8 60 32 00 00       	call   3749 <exit>
    printf(stdout, "read failed\n");
     4e9:	83 ec 08             	sub    $0x8,%esp
     4ec:	68 35 40 00 00       	push   $0x4035
     4f1:	ff 35 80 5b 00 00    	pushl  0x5b80
     4f7:	e8 8c 33 00 00       	call   3888 <printf>
    exit();
     4fc:	e8 48 32 00 00       	call   3749 <exit>
    printf(stdout, "unlink small failed\n");
     501:	83 ec 08             	sub    $0x8,%esp
     504:	68 22 3d 00 00       	push   $0x3d22
     509:	ff 35 80 5b 00 00    	pushl  0x5b80
     50f:	e8 74 33 00 00       	call   3888 <printf>
    exit();
     514:	e8 30 32 00 00       	call   3749 <exit>

00000519 <writetest1>:

void
writetest1(void)
{
     519:	f3 0f 1e fb          	endbr32 
     51d:	55                   	push   %ebp
     51e:	89 e5                	mov    %esp,%ebp
     520:	56                   	push   %esi
     521:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     522:	83 ec 08             	sub    $0x8,%esp
     525:	68 4b 3d 00 00       	push   $0x3d4b
     52a:	ff 35 80 5b 00 00    	pushl  0x5b80
     530:	e8 53 33 00 00       	call   3888 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     535:	83 c4 08             	add    $0x8,%esp
     538:	68 02 02 00 00       	push   $0x202
     53d:	68 c5 3d 00 00       	push   $0x3dc5
     542:	e8 42 32 00 00       	call   3789 <open>
  if(fd < 0){
     547:	83 c4 10             	add    $0x10,%esp
     54a:	85 c0                	test   %eax,%eax
     54c:	78 35                	js     583 <writetest1+0x6a>
     54e:	89 c6                	mov    %eax,%esi
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     550:	bb 00 00 00 00       	mov    $0x0,%ebx
     555:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     55b:	77 57                	ja     5b4 <writetest1+0x9b>
    ((int*)buf)[0] = i;
     55d:	89 1d 60 83 00 00    	mov    %ebx,0x8360
    if(write(fd, buf, 512) != 512){
     563:	83 ec 04             	sub    $0x4,%esp
     566:	68 00 02 00 00       	push   $0x200
     56b:	68 60 83 00 00       	push   $0x8360
     570:	56                   	push   %esi
     571:	e8 f3 31 00 00       	call   3769 <write>
     576:	83 c4 10             	add    $0x10,%esp
     579:	3d 00 02 00 00       	cmp    $0x200,%eax
     57e:	75 1b                	jne    59b <writetest1+0x82>
  for(i = 0; i < MAXFILE; i++){
     580:	43                   	inc    %ebx
     581:	eb d2                	jmp    555 <writetest1+0x3c>
    printf(stdout, "error: creat big failed!\n");
     583:	83 ec 08             	sub    $0x8,%esp
     586:	68 5b 3d 00 00       	push   $0x3d5b
     58b:	ff 35 80 5b 00 00    	pushl  0x5b80
     591:	e8 f2 32 00 00       	call   3888 <printf>
    exit();
     596:	e8 ae 31 00 00       	call   3749 <exit>
      printf(stdout, "error: write big file failed\n", i);
     59b:	83 ec 04             	sub    $0x4,%esp
     59e:	53                   	push   %ebx
     59f:	68 75 3d 00 00       	push   $0x3d75
     5a4:	ff 35 80 5b 00 00    	pushl  0x5b80
     5aa:	e8 d9 32 00 00       	call   3888 <printf>
      exit();
     5af:	e8 95 31 00 00       	call   3749 <exit>
    }
  }

  close(fd);
     5b4:	83 ec 0c             	sub    $0xc,%esp
     5b7:	56                   	push   %esi
     5b8:	e8 b4 31 00 00       	call   3771 <close>

  fd = open("big", O_RDONLY);
     5bd:	83 c4 08             	add    $0x8,%esp
     5c0:	6a 00                	push   $0x0
     5c2:	68 c5 3d 00 00       	push   $0x3dc5
     5c7:	e8 bd 31 00 00       	call   3789 <open>
     5cc:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     5ce:	83 c4 10             	add    $0x10,%esp
     5d1:	85 c0                	test   %eax,%eax
     5d3:	78 3a                	js     60f <writetest1+0xf6>
    printf(stdout, "error: open big failed!\n");
    exit();
  }

  n = 0;
     5d5:	bb 00 00 00 00       	mov    $0x0,%ebx
  for(;;){
    i = read(fd, buf, 512);
     5da:	83 ec 04             	sub    $0x4,%esp
     5dd:	68 00 02 00 00       	push   $0x200
     5e2:	68 60 83 00 00       	push   $0x8360
     5e7:	56                   	push   %esi
     5e8:	e8 74 31 00 00       	call   3761 <read>
    if(i == 0){
     5ed:	83 c4 10             	add    $0x10,%esp
     5f0:	85 c0                	test   %eax,%eax
     5f2:	74 33                	je     627 <writetest1+0x10e>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     5f4:	3d 00 02 00 00       	cmp    $0x200,%eax
     5f9:	0f 85 82 00 00 00    	jne    681 <writetest1+0x168>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     5ff:	a1 60 83 00 00       	mov    0x8360,%eax
     604:	39 d8                	cmp    %ebx,%eax
     606:	0f 85 8e 00 00 00    	jne    69a <writetest1+0x181>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     60c:	43                   	inc    %ebx
    i = read(fd, buf, 512);
     60d:	eb cb                	jmp    5da <writetest1+0xc1>
    printf(stdout, "error: open big failed!\n");
     60f:	83 ec 08             	sub    $0x8,%esp
     612:	68 93 3d 00 00       	push   $0x3d93
     617:	ff 35 80 5b 00 00    	pushl  0x5b80
     61d:	e8 66 32 00 00       	call   3888 <printf>
    exit();
     622:	e8 22 31 00 00       	call   3749 <exit>
      if(n == MAXFILE - 1){
     627:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     62d:	74 39                	je     668 <writetest1+0x14f>
  }
  close(fd);
     62f:	83 ec 0c             	sub    $0xc,%esp
     632:	56                   	push   %esi
     633:	e8 39 31 00 00       	call   3771 <close>
  if(unlink("big") < 0){
     638:	c7 04 24 c5 3d 00 00 	movl   $0x3dc5,(%esp)
     63f:	e8 55 31 00 00       	call   3799 <unlink>
     644:	83 c4 10             	add    $0x10,%esp
     647:	85 c0                	test   %eax,%eax
     649:	78 66                	js     6b1 <writetest1+0x198>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     64b:	83 ec 08             	sub    $0x8,%esp
     64e:	68 ec 3d 00 00       	push   $0x3dec
     653:	ff 35 80 5b 00 00    	pushl  0x5b80
     659:	e8 2a 32 00 00       	call   3888 <printf>
}
     65e:	83 c4 10             	add    $0x10,%esp
     661:	8d 65 f8             	lea    -0x8(%ebp),%esp
     664:	5b                   	pop    %ebx
     665:	5e                   	pop    %esi
     666:	5d                   	pop    %ebp
     667:	c3                   	ret    
        printf(stdout, "read only %d blocks from big", n);
     668:	83 ec 04             	sub    $0x4,%esp
     66b:	53                   	push   %ebx
     66c:	68 ac 3d 00 00       	push   $0x3dac
     671:	ff 35 80 5b 00 00    	pushl  0x5b80
     677:	e8 0c 32 00 00       	call   3888 <printf>
        exit();
     67c:	e8 c8 30 00 00       	call   3749 <exit>
      printf(stdout, "read failed %d\n", i);
     681:	83 ec 04             	sub    $0x4,%esp
     684:	50                   	push   %eax
     685:	68 c9 3d 00 00       	push   $0x3dc9
     68a:	ff 35 80 5b 00 00    	pushl  0x5b80
     690:	e8 f3 31 00 00       	call   3888 <printf>
      exit();
     695:	e8 af 30 00 00       	call   3749 <exit>
      printf(stdout, "read content of block %d is %d\n",
     69a:	50                   	push   %eax
     69b:	53                   	push   %ebx
     69c:	68 c0 4b 00 00       	push   $0x4bc0
     6a1:	ff 35 80 5b 00 00    	pushl  0x5b80
     6a7:	e8 dc 31 00 00       	call   3888 <printf>
      exit();
     6ac:	e8 98 30 00 00       	call   3749 <exit>
    printf(stdout, "unlink big failed\n");
     6b1:	83 ec 08             	sub    $0x8,%esp
     6b4:	68 d9 3d 00 00       	push   $0x3dd9
     6b9:	ff 35 80 5b 00 00    	pushl  0x5b80
     6bf:	e8 c4 31 00 00       	call   3888 <printf>
    exit();
     6c4:	e8 80 30 00 00       	call   3749 <exit>

000006c9 <createtest>:

void
createtest(void)
{
     6c9:	f3 0f 1e fb          	endbr32 
     6cd:	55                   	push   %ebp
     6ce:	89 e5                	mov    %esp,%ebp
     6d0:	53                   	push   %ebx
     6d1:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     6d4:	68 e0 4b 00 00       	push   $0x4be0
     6d9:	ff 35 80 5b 00 00    	pushl  0x5b80
     6df:	e8 a4 31 00 00       	call   3888 <printf>

  name[0] = 'a';
     6e4:	c6 05 60 a3 00 00 61 	movb   $0x61,0xa360
  name[2] = '\0';
     6eb:	c6 05 62 a3 00 00 00 	movb   $0x0,0xa362
  for(i = 0; i < 52; i++){
     6f2:	83 c4 10             	add    $0x10,%esp
     6f5:	bb 00 00 00 00       	mov    $0x0,%ebx
     6fa:	eb 26                	jmp    722 <createtest+0x59>
    name[1] = '0' + i;
     6fc:	8d 43 30             	lea    0x30(%ebx),%eax
     6ff:	a2 61 a3 00 00       	mov    %al,0xa361
    fd = open(name, O_CREATE|O_RDWR);
     704:	83 ec 08             	sub    $0x8,%esp
     707:	68 02 02 00 00       	push   $0x202
     70c:	68 60 a3 00 00       	push   $0xa360
     711:	e8 73 30 00 00       	call   3789 <open>
    close(fd);
     716:	89 04 24             	mov    %eax,(%esp)
     719:	e8 53 30 00 00       	call   3771 <close>
  for(i = 0; i < 52; i++){
     71e:	43                   	inc    %ebx
     71f:	83 c4 10             	add    $0x10,%esp
     722:	83 fb 33             	cmp    $0x33,%ebx
     725:	7e d5                	jle    6fc <createtest+0x33>
  }
  name[0] = 'a';
     727:	c6 05 60 a3 00 00 61 	movb   $0x61,0xa360
  name[2] = '\0';
     72e:	c6 05 62 a3 00 00 00 	movb   $0x0,0xa362
  for(i = 0; i < 52; i++){
     735:	bb 00 00 00 00       	mov    $0x0,%ebx
     73a:	eb 19                	jmp    755 <createtest+0x8c>
    name[1] = '0' + i;
     73c:	8d 43 30             	lea    0x30(%ebx),%eax
     73f:	a2 61 a3 00 00       	mov    %al,0xa361
    unlink(name);
     744:	83 ec 0c             	sub    $0xc,%esp
     747:	68 60 a3 00 00       	push   $0xa360
     74c:	e8 48 30 00 00       	call   3799 <unlink>
  for(i = 0; i < 52; i++){
     751:	43                   	inc    %ebx
     752:	83 c4 10             	add    $0x10,%esp
     755:	83 fb 33             	cmp    $0x33,%ebx
     758:	7e e2                	jle    73c <createtest+0x73>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     75a:	83 ec 08             	sub    $0x8,%esp
     75d:	68 08 4c 00 00       	push   $0x4c08
     762:	ff 35 80 5b 00 00    	pushl  0x5b80
     768:	e8 1b 31 00 00       	call   3888 <printf>
}
     76d:	83 c4 10             	add    $0x10,%esp
     770:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     773:	c9                   	leave  
     774:	c3                   	ret    

00000775 <dirtest>:

void dirtest(void)
{
     775:	f3 0f 1e fb          	endbr32 
     779:	55                   	push   %ebp
     77a:	89 e5                	mov    %esp,%ebp
     77c:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     77f:	68 fa 3d 00 00       	push   $0x3dfa
     784:	ff 35 80 5b 00 00    	pushl  0x5b80
     78a:	e8 f9 30 00 00       	call   3888 <printf>

  if(mkdir("dir0") < 0){
     78f:	c7 04 24 06 3e 00 00 	movl   $0x3e06,(%esp)
     796:	e8 16 30 00 00       	call   37b1 <mkdir>
     79b:	83 c4 10             	add    $0x10,%esp
     79e:	85 c0                	test   %eax,%eax
     7a0:	78 54                	js     7f6 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     7a2:	83 ec 0c             	sub    $0xc,%esp
     7a5:	68 06 3e 00 00       	push   $0x3e06
     7aa:	e8 0a 30 00 00       	call   37b9 <chdir>
     7af:	83 c4 10             	add    $0x10,%esp
     7b2:	85 c0                	test   %eax,%eax
     7b4:	78 58                	js     80e <dirtest+0x99>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     7b6:	83 ec 0c             	sub    $0xc,%esp
     7b9:	68 a5 43 00 00       	push   $0x43a5
     7be:	e8 f6 2f 00 00       	call   37b9 <chdir>
     7c3:	83 c4 10             	add    $0x10,%esp
     7c6:	85 c0                	test   %eax,%eax
     7c8:	78 5c                	js     826 <dirtest+0xb1>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     7ca:	83 ec 0c             	sub    $0xc,%esp
     7cd:	68 06 3e 00 00       	push   $0x3e06
     7d2:	e8 c2 2f 00 00       	call   3799 <unlink>
     7d7:	83 c4 10             	add    $0x10,%esp
     7da:	85 c0                	test   %eax,%eax
     7dc:	78 60                	js     83e <dirtest+0xc9>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     7de:	83 ec 08             	sub    $0x8,%esp
     7e1:	68 43 3e 00 00       	push   $0x3e43
     7e6:	ff 35 80 5b 00 00    	pushl  0x5b80
     7ec:	e8 97 30 00 00       	call   3888 <printf>
}
     7f1:	83 c4 10             	add    $0x10,%esp
     7f4:	c9                   	leave  
     7f5:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     7f6:	83 ec 08             	sub    $0x8,%esp
     7f9:	68 36 3b 00 00       	push   $0x3b36
     7fe:	ff 35 80 5b 00 00    	pushl  0x5b80
     804:	e8 7f 30 00 00       	call   3888 <printf>
    exit();
     809:	e8 3b 2f 00 00       	call   3749 <exit>
    printf(stdout, "chdir dir0 failed\n");
     80e:	83 ec 08             	sub    $0x8,%esp
     811:	68 0b 3e 00 00       	push   $0x3e0b
     816:	ff 35 80 5b 00 00    	pushl  0x5b80
     81c:	e8 67 30 00 00       	call   3888 <printf>
    exit();
     821:	e8 23 2f 00 00       	call   3749 <exit>
    printf(stdout, "chdir .. failed\n");
     826:	83 ec 08             	sub    $0x8,%esp
     829:	68 1e 3e 00 00       	push   $0x3e1e
     82e:	ff 35 80 5b 00 00    	pushl  0x5b80
     834:	e8 4f 30 00 00       	call   3888 <printf>
    exit();
     839:	e8 0b 2f 00 00       	call   3749 <exit>
    printf(stdout, "unlink dir0 failed\n");
     83e:	83 ec 08             	sub    $0x8,%esp
     841:	68 2f 3e 00 00       	push   $0x3e2f
     846:	ff 35 80 5b 00 00    	pushl  0x5b80
     84c:	e8 37 30 00 00       	call   3888 <printf>
    exit();
     851:	e8 f3 2e 00 00       	call   3749 <exit>

00000856 <exectest>:

void
exectest(void)
{
     856:	f3 0f 1e fb          	endbr32 
     85a:	55                   	push   %ebp
     85b:	89 e5                	mov    %esp,%ebp
     85d:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     860:	68 52 3e 00 00       	push   $0x3e52
     865:	ff 35 80 5b 00 00    	pushl  0x5b80
     86b:	e8 18 30 00 00       	call   3888 <printf>
  if(exec("echo", echoargv) < 0){
     870:	83 c4 08             	add    $0x8,%esp
     873:	68 84 5b 00 00       	push   $0x5b84
     878:	68 1b 3c 00 00       	push   $0x3c1b
     87d:	e8 ff 2e 00 00       	call   3781 <exec>
     882:	83 c4 10             	add    $0x10,%esp
     885:	85 c0                	test   %eax,%eax
     887:	78 02                	js     88b <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     889:	c9                   	leave  
     88a:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     88b:	83 ec 08             	sub    $0x8,%esp
     88e:	68 5d 3e 00 00       	push   $0x3e5d
     893:	ff 35 80 5b 00 00    	pushl  0x5b80
     899:	e8 ea 2f 00 00       	call   3888 <printf>
    exit();
     89e:	e8 a6 2e 00 00       	call   3749 <exit>

000008a3 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     8a3:	f3 0f 1e fb          	endbr32 
     8a7:	55                   	push   %ebp
     8a8:	89 e5                	mov    %esp,%ebp
     8aa:	57                   	push   %edi
     8ab:	56                   	push   %esi
     8ac:	53                   	push   %ebx
     8ad:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     8b0:	8d 45 e0             	lea    -0x20(%ebp),%eax
     8b3:	50                   	push   %eax
     8b4:	e8 a0 2e 00 00       	call   3759 <pipe>
     8b9:	83 c4 10             	add    $0x10,%esp
     8bc:	85 c0                	test   %eax,%eax
     8be:	75 72                	jne    932 <pipe1+0x8f>
     8c0:	89 c6                	mov    %eax,%esi
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     8c2:	e8 7a 2e 00 00       	call   3741 <fork>
     8c7:	89 c7                	mov    %eax,%edi
  seq = 0;
  if(pid == 0){
     8c9:	85 c0                	test   %eax,%eax
     8cb:	74 79                	je     946 <pipe1+0xa3>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     8cd:	0f 8e 5c 01 00 00    	jle    a2f <pipe1+0x18c>
    close(fds[1]);
     8d3:	83 ec 0c             	sub    $0xc,%esp
     8d6:	ff 75 e4             	pushl  -0x1c(%ebp)
     8d9:	e8 93 2e 00 00       	call   3771 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     8de:	83 c4 10             	add    $0x10,%esp
    total = 0;
     8e1:	89 75 d0             	mov    %esi,-0x30(%ebp)
  seq = 0;
     8e4:	89 f3                	mov    %esi,%ebx
    cc = 1;
     8e6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     8ed:	83 ec 04             	sub    $0x4,%esp
     8f0:	ff 75 d4             	pushl  -0x2c(%ebp)
     8f3:	68 60 83 00 00       	push   $0x8360
     8f8:	ff 75 e0             	pushl  -0x20(%ebp)
     8fb:	e8 61 2e 00 00       	call   3761 <read>
     900:	89 c7                	mov    %eax,%edi
     902:	83 c4 10             	add    $0x10,%esp
     905:	85 c0                	test   %eax,%eax
     907:	0f 8e de 00 00 00    	jle    9eb <pipe1+0x148>
      for(i = 0; i < n; i++){
     90d:	89 f0                	mov    %esi,%eax
     90f:	89 d9                	mov    %ebx,%ecx
     911:	39 f8                	cmp    %edi,%eax
     913:	0f 8d ae 00 00 00    	jge    9c7 <pipe1+0x124>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     919:	0f be 98 60 83 00 00 	movsbl 0x8360(%eax),%ebx
     920:	8d 51 01             	lea    0x1(%ecx),%edx
     923:	31 cb                	xor    %ecx,%ebx
     925:	84 db                	test   %bl,%bl
     927:	0f 85 80 00 00 00    	jne    9ad <pipe1+0x10a>
      for(i = 0; i < n; i++){
     92d:	40                   	inc    %eax
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     92e:	89 d1                	mov    %edx,%ecx
     930:	eb df                	jmp    911 <pipe1+0x6e>
    printf(1, "pipe() failed\n");
     932:	83 ec 08             	sub    $0x8,%esp
     935:	68 6f 3e 00 00       	push   $0x3e6f
     93a:	6a 01                	push   $0x1
     93c:	e8 47 2f 00 00       	call   3888 <printf>
    exit();
     941:	e8 03 2e 00 00       	call   3749 <exit>
    close(fds[0]);
     946:	83 ec 0c             	sub    $0xc,%esp
     949:	ff 75 e0             	pushl  -0x20(%ebp)
     94c:	e8 20 2e 00 00       	call   3771 <close>
    for(n = 0; n < 5; n++){
     951:	83 c4 10             	add    $0x10,%esp
     954:	89 fe                	mov    %edi,%esi
  seq = 0;
     956:	89 fb                	mov    %edi,%ebx
    for(n = 0; n < 5; n++){
     958:	eb 20                	jmp    97a <pipe1+0xd7>
      if(write(fds[1], buf, 1033) != 1033){
     95a:	83 ec 04             	sub    $0x4,%esp
     95d:	68 09 04 00 00       	push   $0x409
     962:	68 60 83 00 00       	push   $0x8360
     967:	ff 75 e4             	pushl  -0x1c(%ebp)
     96a:	e8 fa 2d 00 00       	call   3769 <write>
     96f:	83 c4 10             	add    $0x10,%esp
     972:	3d 09 04 00 00       	cmp    $0x409,%eax
     977:	75 1b                	jne    994 <pipe1+0xf1>
    for(n = 0; n < 5; n++){
     979:	46                   	inc    %esi
     97a:	83 fe 04             	cmp    $0x4,%esi
     97d:	7f 29                	jg     9a8 <pipe1+0x105>
      for(i = 0; i < 1033; i++)
     97f:	89 f8                	mov    %edi,%eax
     981:	3d 08 04 00 00       	cmp    $0x408,%eax
     986:	7f d2                	jg     95a <pipe1+0xb7>
        buf[i] = seq++;
     988:	88 98 60 83 00 00    	mov    %bl,0x8360(%eax)
      for(i = 0; i < 1033; i++)
     98e:	40                   	inc    %eax
        buf[i] = seq++;
     98f:	8d 5b 01             	lea    0x1(%ebx),%ebx
     992:	eb ed                	jmp    981 <pipe1+0xde>
        printf(1, "pipe1 oops 1\n");
     994:	83 ec 08             	sub    $0x8,%esp
     997:	68 7e 3e 00 00       	push   $0x3e7e
     99c:	6a 01                	push   $0x1
     99e:	e8 e5 2e 00 00       	call   3888 <printf>
        exit();
     9a3:	e8 a1 2d 00 00       	call   3749 <exit>
    exit();
     9a8:	e8 9c 2d 00 00       	call   3749 <exit>
          printf(1, "pipe1 oops 2\n");
     9ad:	83 ec 08             	sub    $0x8,%esp
     9b0:	68 8c 3e 00 00       	push   $0x3e8c
     9b5:	6a 01                	push   $0x1
     9b7:	e8 cc 2e 00 00       	call   3888 <printf>
          return;
     9bc:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     9bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c2:	5b                   	pop    %ebx
     9c3:	5e                   	pop    %esi
     9c4:	5f                   	pop    %edi
     9c5:	5d                   	pop    %ebp
     9c6:	c3                   	ret    
     9c7:	89 cb                	mov    %ecx,%ebx
      total += n;
     9c9:	01 7d d0             	add    %edi,-0x30(%ebp)
      cc = cc * 2;
     9cc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     9cf:	01 c0                	add    %eax,%eax
     9d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
      if(cc > sizeof(buf))
     9d4:	3d 00 20 00 00       	cmp    $0x2000,%eax
     9d9:	0f 86 0e ff ff ff    	jbe    8ed <pipe1+0x4a>
        cc = sizeof(buf);
     9df:	c7 45 d4 00 20 00 00 	movl   $0x2000,-0x2c(%ebp)
     9e6:	e9 02 ff ff ff       	jmp    8ed <pipe1+0x4a>
    if(total != 5 * 1033){
     9eb:	81 7d d0 2d 14 00 00 	cmpl   $0x142d,-0x30(%ebp)
     9f2:	75 24                	jne    a18 <pipe1+0x175>
    close(fds[0]);
     9f4:	83 ec 0c             	sub    $0xc,%esp
     9f7:	ff 75 e0             	pushl  -0x20(%ebp)
     9fa:	e8 72 2d 00 00       	call   3771 <close>
    wait();
     9ff:	e8 4d 2d 00 00       	call   3751 <wait>
  printf(1, "pipe1 ok\n");
     a04:	83 c4 08             	add    $0x8,%esp
     a07:	68 b1 3e 00 00       	push   $0x3eb1
     a0c:	6a 01                	push   $0x1
     a0e:	e8 75 2e 00 00       	call   3888 <printf>
     a13:	83 c4 10             	add    $0x10,%esp
     a16:	eb a7                	jmp    9bf <pipe1+0x11c>
      printf(1, "pipe1 oops 3 total %d\n", total);
     a18:	83 ec 04             	sub    $0x4,%esp
     a1b:	ff 75 d0             	pushl  -0x30(%ebp)
     a1e:	68 9a 3e 00 00       	push   $0x3e9a
     a23:	6a 01                	push   $0x1
     a25:	e8 5e 2e 00 00       	call   3888 <printf>
      exit();
     a2a:	e8 1a 2d 00 00       	call   3749 <exit>
    printf(1, "fork() failed\n");
     a2f:	83 ec 08             	sub    $0x8,%esp
     a32:	68 bb 3e 00 00       	push   $0x3ebb
     a37:	6a 01                	push   $0x1
     a39:	e8 4a 2e 00 00       	call   3888 <printf>
    exit();
     a3e:	e8 06 2d 00 00       	call   3749 <exit>

00000a43 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     a43:	f3 0f 1e fb          	endbr32 
     a47:	55                   	push   %ebp
     a48:	89 e5                	mov    %esp,%ebp
     a4a:	57                   	push   %edi
     a4b:	56                   	push   %esi
     a4c:	53                   	push   %ebx
     a4d:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     a50:	68 ca 3e 00 00       	push   $0x3eca
     a55:	6a 01                	push   $0x1
     a57:	e8 2c 2e 00 00       	call   3888 <printf>
  pid1 = fork();
     a5c:	e8 e0 2c 00 00       	call   3741 <fork>
  if(pid1 == 0)
     a61:	83 c4 10             	add    $0x10,%esp
     a64:	85 c0                	test   %eax,%eax
     a66:	75 02                	jne    a6a <preempt+0x27>
    for(;;)
     a68:	eb fe                	jmp    a68 <preempt+0x25>
     a6a:	89 c7                	mov    %eax,%edi
      ;

  pid2 = fork();
     a6c:	e8 d0 2c 00 00       	call   3741 <fork>
     a71:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     a73:	85 c0                	test   %eax,%eax
     a75:	75 02                	jne    a79 <preempt+0x36>
    for(;;)
     a77:	eb fe                	jmp    a77 <preempt+0x34>
      ;

  pipe(pfds);
     a79:	83 ec 0c             	sub    $0xc,%esp
     a7c:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a7f:	50                   	push   %eax
     a80:	e8 d4 2c 00 00       	call   3759 <pipe>
  pid3 = fork();
     a85:	e8 b7 2c 00 00       	call   3741 <fork>
     a8a:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     a8c:	83 c4 10             	add    $0x10,%esp
     a8f:	85 c0                	test   %eax,%eax
     a91:	75 49                	jne    adc <preempt+0x99>
    close(pfds[0]);
     a93:	83 ec 0c             	sub    $0xc,%esp
     a96:	ff 75 e0             	pushl  -0x20(%ebp)
     a99:	e8 d3 2c 00 00       	call   3771 <close>
    if(write(pfds[1], "x", 1) != 1)
     a9e:	83 c4 0c             	add    $0xc,%esp
     aa1:	6a 01                	push   $0x1
     aa3:	68 89 44 00 00       	push   $0x4489
     aa8:	ff 75 e4             	pushl  -0x1c(%ebp)
     aab:	e8 b9 2c 00 00       	call   3769 <write>
     ab0:	83 c4 10             	add    $0x10,%esp
     ab3:	83 f8 01             	cmp    $0x1,%eax
     ab6:	75 10                	jne    ac8 <preempt+0x85>
      printf(1, "preempt write error");
    close(pfds[1]);
     ab8:	83 ec 0c             	sub    $0xc,%esp
     abb:	ff 75 e4             	pushl  -0x1c(%ebp)
     abe:	e8 ae 2c 00 00       	call   3771 <close>
     ac3:	83 c4 10             	add    $0x10,%esp
    for(;;)
     ac6:	eb fe                	jmp    ac6 <preempt+0x83>
      printf(1, "preempt write error");
     ac8:	83 ec 08             	sub    $0x8,%esp
     acb:	68 d4 3e 00 00       	push   $0x3ed4
     ad0:	6a 01                	push   $0x1
     ad2:	e8 b1 2d 00 00       	call   3888 <printf>
     ad7:	83 c4 10             	add    $0x10,%esp
     ada:	eb dc                	jmp    ab8 <preempt+0x75>
      ;
  }

  close(pfds[1]);
     adc:	83 ec 0c             	sub    $0xc,%esp
     adf:	ff 75 e4             	pushl  -0x1c(%ebp)
     ae2:	e8 8a 2c 00 00       	call   3771 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     ae7:	83 c4 0c             	add    $0xc,%esp
     aea:	68 00 20 00 00       	push   $0x2000
     aef:	68 60 83 00 00       	push   $0x8360
     af4:	ff 75 e0             	pushl  -0x20(%ebp)
     af7:	e8 65 2c 00 00       	call   3761 <read>
     afc:	83 c4 10             	add    $0x10,%esp
     aff:	83 f8 01             	cmp    $0x1,%eax
     b02:	74 1a                	je     b1e <preempt+0xdb>
    printf(1, "preempt read error");
     b04:	83 ec 08             	sub    $0x8,%esp
     b07:	68 e8 3e 00 00       	push   $0x3ee8
     b0c:	6a 01                	push   $0x1
     b0e:	e8 75 2d 00 00       	call   3888 <printf>
    return;
     b13:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     b16:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b19:	5b                   	pop    %ebx
     b1a:	5e                   	pop    %esi
     b1b:	5f                   	pop    %edi
     b1c:	5d                   	pop    %ebp
     b1d:	c3                   	ret    
  close(pfds[0]);
     b1e:	83 ec 0c             	sub    $0xc,%esp
     b21:	ff 75 e0             	pushl  -0x20(%ebp)
     b24:	e8 48 2c 00 00       	call   3771 <close>
  printf(1, "kill... ");
     b29:	83 c4 08             	add    $0x8,%esp
     b2c:	68 fb 3e 00 00       	push   $0x3efb
     b31:	6a 01                	push   $0x1
     b33:	e8 50 2d 00 00       	call   3888 <printf>
  kill(pid1);
     b38:	89 3c 24             	mov    %edi,(%esp)
     b3b:	e8 39 2c 00 00       	call   3779 <kill>
  kill(pid2);
     b40:	89 34 24             	mov    %esi,(%esp)
     b43:	e8 31 2c 00 00       	call   3779 <kill>
  kill(pid3);
     b48:	89 1c 24             	mov    %ebx,(%esp)
     b4b:	e8 29 2c 00 00       	call   3779 <kill>
  printf(1, "wait... ");
     b50:	83 c4 08             	add    $0x8,%esp
     b53:	68 04 3f 00 00       	push   $0x3f04
     b58:	6a 01                	push   $0x1
     b5a:	e8 29 2d 00 00       	call   3888 <printf>
  wait();
     b5f:	e8 ed 2b 00 00       	call   3751 <wait>
  wait();
     b64:	e8 e8 2b 00 00       	call   3751 <wait>
  wait();
     b69:	e8 e3 2b 00 00       	call   3751 <wait>
  printf(1, "preempt ok\n");
     b6e:	83 c4 08             	add    $0x8,%esp
     b71:	68 0d 3f 00 00       	push   $0x3f0d
     b76:	6a 01                	push   $0x1
     b78:	e8 0b 2d 00 00       	call   3888 <printf>
     b7d:	83 c4 10             	add    $0x10,%esp
     b80:	eb 94                	jmp    b16 <preempt+0xd3>

00000b82 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     b82:	f3 0f 1e fb          	endbr32 
     b86:	55                   	push   %ebp
     b87:	89 e5                	mov    %esp,%ebp
     b89:	56                   	push   %esi
     b8a:	53                   	push   %ebx
  int i, pid;

  for(i = 0; i < 100; i++){
     b8b:	be 00 00 00 00       	mov    $0x0,%esi
     b90:	eb 1f                	jmp    bb1 <exitwait+0x2f>
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
     b92:	83 ec 08             	sub    $0x8,%esp
     b95:	68 71 4a 00 00       	push   $0x4a71
     b9a:	6a 01                	push   $0x1
     b9c:	e8 e7 2c 00 00       	call   3888 <printf>
      return;
     ba1:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     ba4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ba7:	5b                   	pop    %ebx
     ba8:	5e                   	pop    %esi
     ba9:	5d                   	pop    %ebp
     baa:	c3                   	ret    
      exit();
     bab:	e8 99 2b 00 00       	call   3749 <exit>
  for(i = 0; i < 100; i++){
     bb0:	46                   	inc    %esi
     bb1:	83 fe 63             	cmp    $0x63,%esi
     bb4:	7f 2a                	jg     be0 <exitwait+0x5e>
    pid = fork();
     bb6:	e8 86 2b 00 00       	call   3741 <fork>
     bbb:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     bbd:	85 c0                	test   %eax,%eax
     bbf:	78 d1                	js     b92 <exitwait+0x10>
    if(pid){
     bc1:	74 e8                	je     bab <exitwait+0x29>
      if(wait() != pid){
     bc3:	e8 89 2b 00 00       	call   3751 <wait>
     bc8:	39 d8                	cmp    %ebx,%eax
     bca:	74 e4                	je     bb0 <exitwait+0x2e>
        printf(1, "wait wrong pid\n");
     bcc:	83 ec 08             	sub    $0x8,%esp
     bcf:	68 19 3f 00 00       	push   $0x3f19
     bd4:	6a 01                	push   $0x1
     bd6:	e8 ad 2c 00 00       	call   3888 <printf>
        return;
     bdb:	83 c4 10             	add    $0x10,%esp
     bde:	eb c4                	jmp    ba4 <exitwait+0x22>
  printf(1, "exitwait ok\n");
     be0:	83 ec 08             	sub    $0x8,%esp
     be3:	68 29 3f 00 00       	push   $0x3f29
     be8:	6a 01                	push   $0x1
     bea:	e8 99 2c 00 00       	call   3888 <printf>
     bef:	83 c4 10             	add    $0x10,%esp
     bf2:	eb b0                	jmp    ba4 <exitwait+0x22>

00000bf4 <mem>:

void
mem(void)
{
     bf4:	f3 0f 1e fb          	endbr32 
     bf8:	55                   	push   %ebp
     bf9:	89 e5                	mov    %esp,%ebp
     bfb:	57                   	push   %edi
     bfc:	56                   	push   %esi
     bfd:	53                   	push   %ebx
     bfe:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     c01:	68 36 3f 00 00       	push   $0x3f36
     c06:	6a 01                	push   $0x1
     c08:	e8 7b 2c 00 00       	call   3888 <printf>
  ppid = getpid();
     c0d:	e8 b7 2b 00 00       	call   37c9 <getpid>
     c12:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     c14:	e8 28 2b 00 00       	call   3741 <fork>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	85 c0                	test   %eax,%eax
     c1e:	0f 85 80 00 00 00    	jne    ca4 <mem+0xb0>
    m1 = 0;
     c24:	bb 00 00 00 00       	mov    $0x0,%ebx
    while((m2 = malloc(10001)) != 0){
     c29:	83 ec 0c             	sub    $0xc,%esp
     c2c:	68 11 27 00 00       	push   $0x2711
     c31:	e8 70 2e 00 00       	call   3aa6 <malloc>
     c36:	83 c4 10             	add    $0x10,%esp
     c39:	85 c0                	test   %eax,%eax
     c3b:	74 16                	je     c53 <mem+0x5f>
      *(char**)m2 = m1;
     c3d:	89 18                	mov    %ebx,(%eax)
      m1 = m2;
     c3f:	89 c3                	mov    %eax,%ebx
     c41:	eb e6                	jmp    c29 <mem+0x35>
    }
    while(m1){
      m2 = *(char**)m1;
     c43:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     c45:	83 ec 0c             	sub    $0xc,%esp
     c48:	53                   	push   %ebx
     c49:	e8 94 2d 00 00       	call   39e2 <free>
     c4e:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     c51:	89 fb                	mov    %edi,%ebx
    while(m1){
     c53:	85 db                	test   %ebx,%ebx
     c55:	75 ec                	jne    c43 <mem+0x4f>
    }
    m1 = malloc(1024*20);
     c57:	83 ec 0c             	sub    $0xc,%esp
     c5a:	68 00 50 00 00       	push   $0x5000
     c5f:	e8 42 2e 00 00       	call   3aa6 <malloc>
    if(m1 == 0){
     c64:	83 c4 10             	add    $0x10,%esp
     c67:	85 c0                	test   %eax,%eax
     c69:	74 1d                	je     c88 <mem+0x94>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     c6b:	83 ec 0c             	sub    $0xc,%esp
     c6e:	50                   	push   %eax
     c6f:	e8 6e 2d 00 00       	call   39e2 <free>
    printf(1, "mem ok\n");
     c74:	83 c4 08             	add    $0x8,%esp
     c77:	68 5a 3f 00 00       	push   $0x3f5a
     c7c:	6a 01                	push   $0x1
     c7e:	e8 05 2c 00 00       	call   3888 <printf>
    exit();
     c83:	e8 c1 2a 00 00       	call   3749 <exit>
      printf(1, "couldn't allocate mem?!!\n");
     c88:	83 ec 08             	sub    $0x8,%esp
     c8b:	68 40 3f 00 00       	push   $0x3f40
     c90:	6a 01                	push   $0x1
     c92:	e8 f1 2b 00 00       	call   3888 <printf>
      kill(ppid);
     c97:	89 34 24             	mov    %esi,(%esp)
     c9a:	e8 da 2a 00 00       	call   3779 <kill>
      exit();
     c9f:	e8 a5 2a 00 00       	call   3749 <exit>
  } else {
    wait();
     ca4:	e8 a8 2a 00 00       	call   3751 <wait>
  }
}
     ca9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cac:	5b                   	pop    %ebx
     cad:	5e                   	pop    %esi
     cae:	5f                   	pop    %edi
     caf:	5d                   	pop    %ebp
     cb0:	c3                   	ret    

00000cb1 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     cb1:	f3 0f 1e fb          	endbr32 
     cb5:	55                   	push   %ebp
     cb6:	89 e5                	mov    %esp,%ebp
     cb8:	57                   	push   %edi
     cb9:	56                   	push   %esi
     cba:	53                   	push   %ebx
     cbb:	83 ec 24             	sub    $0x24,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     cbe:	68 62 3f 00 00       	push   $0x3f62
     cc3:	6a 01                	push   $0x1
     cc5:	e8 be 2b 00 00       	call   3888 <printf>

  unlink("sharedfd");
     cca:	c7 04 24 71 3f 00 00 	movl   $0x3f71,(%esp)
     cd1:	e8 c3 2a 00 00       	call   3799 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     cd6:	83 c4 08             	add    $0x8,%esp
     cd9:	68 02 02 00 00       	push   $0x202
     cde:	68 71 3f 00 00       	push   $0x3f71
     ce3:	e8 a1 2a 00 00       	call   3789 <open>
  if(fd < 0){
     ce8:	83 c4 10             	add    $0x10,%esp
     ceb:	85 c0                	test   %eax,%eax
     ced:	78 4b                	js     d3a <sharedfd+0x89>
     cef:	89 c6                	mov    %eax,%esi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     cf1:	e8 4b 2a 00 00       	call   3741 <fork>
     cf6:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     cf8:	85 c0                	test   %eax,%eax
     cfa:	75 55                	jne    d51 <sharedfd+0xa0>
     cfc:	b8 63 00 00 00       	mov    $0x63,%eax
     d01:	83 ec 04             	sub    $0x4,%esp
     d04:	6a 0a                	push   $0xa
     d06:	50                   	push   %eax
     d07:	8d 45 de             	lea    -0x22(%ebp),%eax
     d0a:	50                   	push   %eax
     d0b:	e8 fc 28 00 00       	call   360c <memset>
  for(i = 0; i < 1000; i++){
     d10:	83 c4 10             	add    $0x10,%esp
     d13:	bb 00 00 00 00       	mov    $0x0,%ebx
     d18:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
     d1e:	7f 4a                	jg     d6a <sharedfd+0xb9>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     d20:	83 ec 04             	sub    $0x4,%esp
     d23:	6a 0a                	push   $0xa
     d25:	8d 45 de             	lea    -0x22(%ebp),%eax
     d28:	50                   	push   %eax
     d29:	56                   	push   %esi
     d2a:	e8 3a 2a 00 00       	call   3769 <write>
     d2f:	83 c4 10             	add    $0x10,%esp
     d32:	83 f8 0a             	cmp    $0xa,%eax
     d35:	75 21                	jne    d58 <sharedfd+0xa7>
  for(i = 0; i < 1000; i++){
     d37:	43                   	inc    %ebx
     d38:	eb de                	jmp    d18 <sharedfd+0x67>
    printf(1, "fstests: cannot open sharedfd for writing");
     d3a:	83 ec 08             	sub    $0x8,%esp
     d3d:	68 30 4c 00 00       	push   $0x4c30
     d42:	6a 01                	push   $0x1
     d44:	e8 3f 2b 00 00       	call   3888 <printf>
    return;
     d49:	83 c4 10             	add    $0x10,%esp
     d4c:	e9 d5 00 00 00       	jmp    e26 <sharedfd+0x175>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     d51:	b8 70 00 00 00       	mov    $0x70,%eax
     d56:	eb a9                	jmp    d01 <sharedfd+0x50>
      printf(1, "fstests: write sharedfd failed\n");
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 5c 4c 00 00       	push   $0x4c5c
     d60:	6a 01                	push   $0x1
     d62:	e8 21 2b 00 00       	call   3888 <printf>
      break;
     d67:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
     d6a:	85 ff                	test   %edi,%edi
     d6c:	74 4d                	je     dbb <sharedfd+0x10a>
    exit();
  else
    wait();
     d6e:	e8 de 29 00 00       	call   3751 <wait>
  close(fd);
     d73:	83 ec 0c             	sub    $0xc,%esp
     d76:	56                   	push   %esi
     d77:	e8 f5 29 00 00       	call   3771 <close>
  fd = open("sharedfd", 0);
     d7c:	83 c4 08             	add    $0x8,%esp
     d7f:	6a 00                	push   $0x0
     d81:	68 71 3f 00 00       	push   $0x3f71
     d86:	e8 fe 29 00 00       	call   3789 <open>
     d8b:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     d8d:	83 c4 10             	add    $0x10,%esp
     d90:	85 c0                	test   %eax,%eax
     d92:	78 2c                	js     dc0 <sharedfd+0x10f>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
     d94:	be 00 00 00 00       	mov    $0x0,%esi
     d99:	bb 00 00 00 00       	mov    $0x0,%ebx
  while((n = read(fd, buf, sizeof(buf))) > 0){
     d9e:	83 ec 04             	sub    $0x4,%esp
     da1:	6a 0a                	push   $0xa
     da3:	8d 45 de             	lea    -0x22(%ebp),%eax
     da6:	50                   	push   %eax
     da7:	57                   	push   %edi
     da8:	e8 b4 29 00 00       	call   3761 <read>
     dad:	83 c4 10             	add    $0x10,%esp
     db0:	85 c0                	test   %eax,%eax
     db2:	7e 38                	jle    dec <sharedfd+0x13b>
    for(i = 0; i < sizeof(buf); i++){
     db4:	ba 00 00 00 00       	mov    $0x0,%edx
     db9:	eb 1d                	jmp    dd8 <sharedfd+0x127>
    exit();
     dbb:	e8 89 29 00 00       	call   3749 <exit>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     dc0:	83 ec 08             	sub    $0x8,%esp
     dc3:	68 7c 4c 00 00       	push   $0x4c7c
     dc8:	6a 01                	push   $0x1
     dca:	e8 b9 2a 00 00       	call   3888 <printf>
    return;
     dcf:	83 c4 10             	add    $0x10,%esp
     dd2:	eb 52                	jmp    e26 <sharedfd+0x175>
      if(buf[i] == 'c')
        nc++;
     dd4:	43                   	inc    %ebx
     dd5:	eb 0e                	jmp    de5 <sharedfd+0x134>
    for(i = 0; i < sizeof(buf); i++){
     dd7:	42                   	inc    %edx
     dd8:	83 fa 09             	cmp    $0x9,%edx
     ddb:	77 c1                	ja     d9e <sharedfd+0xed>
      if(buf[i] == 'c')
     ddd:	8a 44 15 de          	mov    -0x22(%ebp,%edx,1),%al
     de1:	3c 63                	cmp    $0x63,%al
     de3:	74 ef                	je     dd4 <sharedfd+0x123>
      if(buf[i] == 'p')
     de5:	3c 70                	cmp    $0x70,%al
     de7:	75 ee                	jne    dd7 <sharedfd+0x126>
        np++;
     de9:	46                   	inc    %esi
     dea:	eb eb                	jmp    dd7 <sharedfd+0x126>
    }
  }
  close(fd);
     dec:	83 ec 0c             	sub    $0xc,%esp
     def:	57                   	push   %edi
     df0:	e8 7c 29 00 00       	call   3771 <close>
  unlink("sharedfd");
     df5:	c7 04 24 71 3f 00 00 	movl   $0x3f71,(%esp)
     dfc:	e8 98 29 00 00       	call   3799 <unlink>
  if(nc == 10000 && np == 10000){
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     e0a:	75 22                	jne    e2e <sharedfd+0x17d>
     e0c:	81 fe 10 27 00 00    	cmp    $0x2710,%esi
     e12:	75 1a                	jne    e2e <sharedfd+0x17d>
    printf(1, "sharedfd ok\n");
     e14:	83 ec 08             	sub    $0x8,%esp
     e17:	68 7a 3f 00 00       	push   $0x3f7a
     e1c:	6a 01                	push   $0x1
     e1e:	e8 65 2a 00 00       	call   3888 <printf>
     e23:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     e26:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e29:	5b                   	pop    %ebx
     e2a:	5e                   	pop    %esi
     e2b:	5f                   	pop    %edi
     e2c:	5d                   	pop    %ebp
     e2d:	c3                   	ret    
    printf(1, "sharedfd oops %d %d\n", nc, np);
     e2e:	56                   	push   %esi
     e2f:	53                   	push   %ebx
     e30:	68 87 3f 00 00       	push   $0x3f87
     e35:	6a 01                	push   $0x1
     e37:	e8 4c 2a 00 00       	call   3888 <printf>
    exit();
     e3c:	e8 08 29 00 00       	call   3749 <exit>

00000e41 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
     e41:	f3 0f 1e fb          	endbr32 
     e45:	55                   	push   %ebp
     e46:	89 e5                	mov    %esp,%ebp
     e48:	57                   	push   %edi
     e49:	56                   	push   %esi
     e4a:	53                   	push   %ebx
     e4b:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
     e4e:	8d 7d d8             	lea    -0x28(%ebp),%edi
     e51:	be c8 52 00 00       	mov    $0x52c8,%esi
     e56:	b9 04 00 00 00       	mov    $0x4,%ecx
     e5b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
     e5d:	68 9c 3f 00 00       	push   $0x3f9c
     e62:	6a 01                	push   $0x1
     e64:	e8 1f 2a 00 00       	call   3888 <printf>

  for(pi = 0; pi < 4; pi++){
     e69:	83 c4 10             	add    $0x10,%esp
     e6c:	be 00 00 00 00       	mov    $0x0,%esi
     e71:	83 fe 03             	cmp    $0x3,%esi
     e74:	0f 8f b7 00 00 00    	jg     f31 <fourfiles+0xf0>
    fname = names[pi];
     e7a:	8b 7c b5 d8          	mov    -0x28(%ebp,%esi,4),%edi
    unlink(fname);
     e7e:	83 ec 0c             	sub    $0xc,%esp
     e81:	57                   	push   %edi
     e82:	e8 12 29 00 00       	call   3799 <unlink>

    pid = fork();
     e87:	e8 b5 28 00 00       	call   3741 <fork>
    if(pid < 0){
     e8c:	83 c4 10             	add    $0x10,%esp
     e8f:	85 c0                	test   %eax,%eax
     e91:	78 05                	js     e98 <fourfiles+0x57>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
     e93:	74 17                	je     eac <fourfiles+0x6b>
  for(pi = 0; pi < 4; pi++){
     e95:	46                   	inc    %esi
     e96:	eb d9                	jmp    e71 <fourfiles+0x30>
      printf(1, "fork failed\n");
     e98:	83 ec 08             	sub    $0x8,%esp
     e9b:	68 71 4a 00 00       	push   $0x4a71
     ea0:	6a 01                	push   $0x1
     ea2:	e8 e1 29 00 00       	call   3888 <printf>
      exit();
     ea7:	e8 9d 28 00 00       	call   3749 <exit>
     eac:	89 c3                	mov    %eax,%ebx
      fd = open(fname, O_CREATE | O_RDWR);
     eae:	83 ec 08             	sub    $0x8,%esp
     eb1:	68 02 02 00 00       	push   $0x202
     eb6:	57                   	push   %edi
     eb7:	e8 cd 28 00 00       	call   3789 <open>
     ebc:	89 c7                	mov    %eax,%edi
      if(fd < 0){
     ebe:	83 c4 10             	add    $0x10,%esp
     ec1:	85 c0                	test   %eax,%eax
     ec3:	78 3e                	js     f03 <fourfiles+0xc2>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
     ec5:	83 ec 04             	sub    $0x4,%esp
     ec8:	68 00 02 00 00       	push   $0x200
     ecd:	83 c6 30             	add    $0x30,%esi
     ed0:	56                   	push   %esi
     ed1:	68 60 83 00 00       	push   $0x8360
     ed6:	e8 31 27 00 00       	call   360c <memset>
      for(i = 0; i < 12; i++){
     edb:	83 c4 10             	add    $0x10,%esp
     ede:	83 fb 0b             	cmp    $0xb,%ebx
     ee1:	7f 49                	jg     f2c <fourfiles+0xeb>
        if((n = write(fd, buf, 500)) != 500){
     ee3:	83 ec 04             	sub    $0x4,%esp
     ee6:	68 f4 01 00 00       	push   $0x1f4
     eeb:	68 60 83 00 00       	push   $0x8360
     ef0:	57                   	push   %edi
     ef1:	e8 73 28 00 00       	call   3769 <write>
     ef6:	83 c4 10             	add    $0x10,%esp
     ef9:	3d f4 01 00 00       	cmp    $0x1f4,%eax
     efe:	75 17                	jne    f17 <fourfiles+0xd6>
      for(i = 0; i < 12; i++){
     f00:	43                   	inc    %ebx
     f01:	eb db                	jmp    ede <fourfiles+0x9d>
        printf(1, "create failed\n");
     f03:	83 ec 08             	sub    $0x8,%esp
     f06:	68 37 42 00 00       	push   $0x4237
     f0b:	6a 01                	push   $0x1
     f0d:	e8 76 29 00 00       	call   3888 <printf>
        exit();
     f12:	e8 32 28 00 00       	call   3749 <exit>
          printf(1, "write failed %d\n", n);
     f17:	83 ec 04             	sub    $0x4,%esp
     f1a:	50                   	push   %eax
     f1b:	68 ac 3f 00 00       	push   $0x3fac
     f20:	6a 01                	push   $0x1
     f22:	e8 61 29 00 00       	call   3888 <printf>
          exit();
     f27:	e8 1d 28 00 00       	call   3749 <exit>
        }
      }
      exit();
     f2c:	e8 18 28 00 00       	call   3749 <exit>
    }
  }

  for(pi = 0; pi < 4; pi++){
     f31:	bb 00 00 00 00       	mov    $0x0,%ebx
     f36:	eb 06                	jmp    f3e <fourfiles+0xfd>
    wait();
     f38:	e8 14 28 00 00       	call   3751 <wait>
  for(pi = 0; pi < 4; pi++){
     f3d:	43                   	inc    %ebx
     f3e:	83 fb 03             	cmp    $0x3,%ebx
     f41:	7e f5                	jle    f38 <fourfiles+0xf7>
  }

  for(i = 0; i < 2; i++){
     f43:	bb 00 00 00 00       	mov    $0x0,%ebx
     f48:	eb 6f                	jmp    fb9 <fourfiles+0x178>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
     f4a:	83 ec 08             	sub    $0x8,%esp
     f4d:	68 bd 3f 00 00       	push   $0x3fbd
     f52:	6a 01                	push   $0x1
     f54:	e8 2f 29 00 00       	call   3888 <printf>
          exit();
     f59:	e8 eb 27 00 00       	call   3749 <exit>
        }
      }
      total += n;
     f5e:	01 45 d4             	add    %eax,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f61:	83 ec 04             	sub    $0x4,%esp
     f64:	68 00 20 00 00       	push   $0x2000
     f69:	68 60 83 00 00       	push   $0x8360
     f6e:	56                   	push   %esi
     f6f:	e8 ed 27 00 00       	call   3761 <read>
     f74:	83 c4 10             	add    $0x10,%esp
     f77:	85 c0                	test   %eax,%eax
     f79:	7e 1a                	jle    f95 <fourfiles+0x154>
      for(j = 0; j < n; j++){
     f7b:	ba 00 00 00 00       	mov    $0x0,%edx
     f80:	39 c2                	cmp    %eax,%edx
     f82:	7d da                	jge    f5e <fourfiles+0x11d>
        if(buf[j] != '0'+i){
     f84:	0f be ba 60 83 00 00 	movsbl 0x8360(%edx),%edi
     f8b:	8d 4b 30             	lea    0x30(%ebx),%ecx
     f8e:	39 cf                	cmp    %ecx,%edi
     f90:	75 b8                	jne    f4a <fourfiles+0x109>
      for(j = 0; j < n; j++){
     f92:	42                   	inc    %edx
     f93:	eb eb                	jmp    f80 <fourfiles+0x13f>
    }
    close(fd);
     f95:	83 ec 0c             	sub    $0xc,%esp
     f98:	56                   	push   %esi
     f99:	e8 d3 27 00 00       	call   3771 <close>
    if(total != 12*500){
     f9e:	83 c4 10             	add    $0x10,%esp
     fa1:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
     fa8:	75 34                	jne    fde <fourfiles+0x19d>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
     faa:	83 ec 0c             	sub    $0xc,%esp
     fad:	ff 75 d0             	pushl  -0x30(%ebp)
     fb0:	e8 e4 27 00 00       	call   3799 <unlink>
  for(i = 0; i < 2; i++){
     fb5:	43                   	inc    %ebx
     fb6:	83 c4 10             	add    $0x10,%esp
     fb9:	83 fb 01             	cmp    $0x1,%ebx
     fbc:	7f 37                	jg     ff5 <fourfiles+0x1b4>
    fname = names[i];
     fbe:	8b 44 9d d8          	mov    -0x28(%ebp,%ebx,4),%eax
     fc2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
     fc5:	83 ec 08             	sub    $0x8,%esp
     fc8:	6a 00                	push   $0x0
     fca:	50                   	push   %eax
     fcb:	e8 b9 27 00 00       	call   3789 <open>
     fd0:	89 c6                	mov    %eax,%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fd2:	83 c4 10             	add    $0x10,%esp
    total = 0;
     fd5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fdc:	eb 83                	jmp    f61 <fourfiles+0x120>
      printf(1, "wrong length %d\n", total);
     fde:	83 ec 04             	sub    $0x4,%esp
     fe1:	ff 75 d4             	pushl  -0x2c(%ebp)
     fe4:	68 c9 3f 00 00       	push   $0x3fc9
     fe9:	6a 01                	push   $0x1
     feb:	e8 98 28 00 00       	call   3888 <printf>
      exit();
     ff0:	e8 54 27 00 00       	call   3749 <exit>
  }

  printf(1, "fourfiles ok\n");
     ff5:	83 ec 08             	sub    $0x8,%esp
     ff8:	68 da 3f 00 00       	push   $0x3fda
     ffd:	6a 01                	push   $0x1
     fff:	e8 84 28 00 00       	call   3888 <printf>
}
    1004:	83 c4 10             	add    $0x10,%esp
    1007:	8d 65 f4             	lea    -0xc(%ebp),%esp
    100a:	5b                   	pop    %ebx
    100b:	5e                   	pop    %esi
    100c:	5f                   	pop    %edi
    100d:	5d                   	pop    %ebp
    100e:	c3                   	ret    

0000100f <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    100f:	f3 0f 1e fb          	endbr32 
    1013:	55                   	push   %ebp
    1014:	89 e5                	mov    %esp,%ebp
    1016:	56                   	push   %esi
    1017:	53                   	push   %ebx
    1018:	83 ec 28             	sub    $0x28,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    101b:	68 e8 3f 00 00       	push   $0x3fe8
    1020:	6a 01                	push   $0x1
    1022:	e8 61 28 00 00       	call   3888 <printf>

  for(pi = 0; pi < 4; pi++){
    1027:	83 c4 10             	add    $0x10,%esp
    102a:	be 00 00 00 00       	mov    $0x0,%esi
    102f:	83 fe 03             	cmp    $0x3,%esi
    1032:	0f 8f b8 00 00 00    	jg     10f0 <createdelete+0xe1>
    pid = fork();
    1038:	e8 04 27 00 00       	call   3741 <fork>
    103d:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    103f:	85 c0                	test   %eax,%eax
    1041:	78 05                	js     1048 <createdelete+0x39>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    1043:	74 17                	je     105c <createdelete+0x4d>
  for(pi = 0; pi < 4; pi++){
    1045:	46                   	inc    %esi
    1046:	eb e7                	jmp    102f <createdelete+0x20>
      printf(1, "fork failed\n");
    1048:	83 ec 08             	sub    $0x8,%esp
    104b:	68 71 4a 00 00       	push   $0x4a71
    1050:	6a 01                	push   $0x1
    1052:	e8 31 28 00 00       	call   3888 <printf>
      exit();
    1057:	e8 ed 26 00 00       	call   3749 <exit>
      name[0] = 'p' + pi;
    105c:	8d 46 70             	lea    0x70(%esi),%eax
    105f:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[2] = '\0';
    1062:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
      for(i = 0; i < N; i++){
    1066:	eb 15                	jmp    107d <createdelete+0x6e>
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    1068:	83 ec 08             	sub    $0x8,%esp
    106b:	68 37 42 00 00       	push   $0x4237
    1070:	6a 01                	push   $0x1
    1072:	e8 11 28 00 00       	call   3888 <printf>
          exit();
    1077:	e8 cd 26 00 00       	call   3749 <exit>
      for(i = 0; i < N; i++){
    107c:	43                   	inc    %ebx
    107d:	83 fb 13             	cmp    $0x13,%ebx
    1080:	7f 69                	jg     10eb <createdelete+0xdc>
        name[1] = '0' + i;
    1082:	8d 43 30             	lea    0x30(%ebx),%eax
    1085:	88 45 d9             	mov    %al,-0x27(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1088:	83 ec 08             	sub    $0x8,%esp
    108b:	68 02 02 00 00       	push   $0x202
    1090:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1093:	50                   	push   %eax
    1094:	e8 f0 26 00 00       	call   3789 <open>
        if(fd < 0){
    1099:	83 c4 10             	add    $0x10,%esp
    109c:	85 c0                	test   %eax,%eax
    109e:	78 c8                	js     1068 <createdelete+0x59>
        }
        close(fd);
    10a0:	83 ec 0c             	sub    $0xc,%esp
    10a3:	50                   	push   %eax
    10a4:	e8 c8 26 00 00       	call   3771 <close>
        if(i > 0 && (i % 2 ) == 0){
    10a9:	83 c4 10             	add    $0x10,%esp
    10ac:	85 db                	test   %ebx,%ebx
    10ae:	7e cc                	jle    107c <createdelete+0x6d>
    10b0:	f6 c3 01             	test   $0x1,%bl
    10b3:	75 c7                	jne    107c <createdelete+0x6d>
          name[1] = '0' + (i / 2);
    10b5:	89 d8                	mov    %ebx,%eax
    10b7:	c1 e8 1f             	shr    $0x1f,%eax
    10ba:	01 d8                	add    %ebx,%eax
    10bc:	d1 f8                	sar    %eax
    10be:	83 c0 30             	add    $0x30,%eax
    10c1:	88 45 d9             	mov    %al,-0x27(%ebp)
          if(unlink(name) < 0){
    10c4:	83 ec 0c             	sub    $0xc,%esp
    10c7:	8d 45 d8             	lea    -0x28(%ebp),%eax
    10ca:	50                   	push   %eax
    10cb:	e8 c9 26 00 00       	call   3799 <unlink>
    10d0:	83 c4 10             	add    $0x10,%esp
    10d3:	85 c0                	test   %eax,%eax
    10d5:	79 a5                	jns    107c <createdelete+0x6d>
            printf(1, "unlink failed\n");
    10d7:	83 ec 08             	sub    $0x8,%esp
    10da:	68 ef 3b 00 00       	push   $0x3bef
    10df:	6a 01                	push   $0x1
    10e1:	e8 a2 27 00 00       	call   3888 <printf>
            exit();
    10e6:	e8 5e 26 00 00       	call   3749 <exit>
          }
        }
      }
      exit();
    10eb:	e8 59 26 00 00       	call   3749 <exit>
    }
  }

  for(pi = 0; pi < 4; pi++){
    10f0:	bb 00 00 00 00       	mov    $0x0,%ebx
    10f5:	eb 06                	jmp    10fd <createdelete+0xee>
    wait();
    10f7:	e8 55 26 00 00       	call   3751 <wait>
  for(pi = 0; pi < 4; pi++){
    10fc:	43                   	inc    %ebx
    10fd:	83 fb 03             	cmp    $0x3,%ebx
    1100:	7e f5                	jle    10f7 <createdelete+0xe8>
  }

  name[0] = name[1] = name[2] = 0;
    1102:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    1106:	c6 45 d9 00          	movb   $0x0,-0x27(%ebp)
    110a:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
  for(i = 0; i < N; i++){
    110e:	be 00 00 00 00       	mov    $0x0,%esi
    1113:	e9 81 00 00 00       	jmp    1199 <createdelete+0x18a>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
    1118:	85 c0                	test   %eax,%eax
    111a:	78 3a                	js     1156 <createdelete+0x147>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    111c:	8d 56 ff             	lea    -0x1(%esi),%edx
    111f:	83 fa 08             	cmp    $0x8,%edx
    1122:	76 4a                	jbe    116e <createdelete+0x15f>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
    1124:	85 c0                	test   %eax,%eax
    1126:	79 62                	jns    118a <createdelete+0x17b>
    for(pi = 0; pi < 4; pi++){
    1128:	43                   	inc    %ebx
    1129:	83 fb 03             	cmp    $0x3,%ebx
    112c:	7f 6a                	jg     1198 <createdelete+0x189>
      name[0] = 'p' + pi;
    112e:	8d 43 70             	lea    0x70(%ebx),%eax
    1131:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[1] = '0' + i;
    1134:	8d 46 30             	lea    0x30(%esi),%eax
    1137:	88 45 d9             	mov    %al,-0x27(%ebp)
      fd = open(name, 0);
    113a:	83 ec 08             	sub    $0x8,%esp
    113d:	6a 00                	push   $0x0
    113f:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1142:	50                   	push   %eax
    1143:	e8 41 26 00 00       	call   3789 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1148:	83 c4 10             	add    $0x10,%esp
    114b:	85 f6                	test   %esi,%esi
    114d:	74 c9                	je     1118 <createdelete+0x109>
    114f:	83 fe 09             	cmp    $0x9,%esi
    1152:	7e c8                	jle    111c <createdelete+0x10d>
    1154:	eb c2                	jmp    1118 <createdelete+0x109>
        printf(1, "oops createdelete %s didn't exist\n", name);
    1156:	83 ec 04             	sub    $0x4,%esp
    1159:	8d 45 d8             	lea    -0x28(%ebp),%eax
    115c:	50                   	push   %eax
    115d:	68 a8 4c 00 00       	push   $0x4ca8
    1162:	6a 01                	push   $0x1
    1164:	e8 1f 27 00 00       	call   3888 <printf>
        exit();
    1169:	e8 db 25 00 00       	call   3749 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    116e:	85 c0                	test   %eax,%eax
    1170:	78 b2                	js     1124 <createdelete+0x115>
        printf(1, "oops createdelete %s did exist\n", name);
    1172:	83 ec 04             	sub    $0x4,%esp
    1175:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1178:	50                   	push   %eax
    1179:	68 cc 4c 00 00       	push   $0x4ccc
    117e:	6a 01                	push   $0x1
    1180:	e8 03 27 00 00       	call   3888 <printf>
        exit();
    1185:	e8 bf 25 00 00       	call   3749 <exit>
        close(fd);
    118a:	83 ec 0c             	sub    $0xc,%esp
    118d:	50                   	push   %eax
    118e:	e8 de 25 00 00       	call   3771 <close>
    1193:	83 c4 10             	add    $0x10,%esp
    1196:	eb 90                	jmp    1128 <createdelete+0x119>
  for(i = 0; i < N; i++){
    1198:	46                   	inc    %esi
    1199:	83 fe 13             	cmp    $0x13,%esi
    119c:	7f 07                	jg     11a5 <createdelete+0x196>
    for(pi = 0; pi < 4; pi++){
    119e:	bb 00 00 00 00       	mov    $0x0,%ebx
    11a3:	eb 84                	jmp    1129 <createdelete+0x11a>
    }
  }

  for(i = 0; i < N; i++){
    11a5:	be 00 00 00 00       	mov    $0x0,%esi
    11aa:	eb 22                	jmp    11ce <createdelete+0x1bf>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    11ac:	8d 46 70             	lea    0x70(%esi),%eax
    11af:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[1] = '0' + i;
    11b2:	8d 46 30             	lea    0x30(%esi),%eax
    11b5:	88 45 d9             	mov    %al,-0x27(%ebp)
      unlink(name);
    11b8:	83 ec 0c             	sub    $0xc,%esp
    11bb:	8d 45 d8             	lea    -0x28(%ebp),%eax
    11be:	50                   	push   %eax
    11bf:	e8 d5 25 00 00       	call   3799 <unlink>
    for(pi = 0; pi < 4; pi++){
    11c4:	43                   	inc    %ebx
    11c5:	83 c4 10             	add    $0x10,%esp
    11c8:	83 fb 03             	cmp    $0x3,%ebx
    11cb:	7e df                	jle    11ac <createdelete+0x19d>
  for(i = 0; i < N; i++){
    11cd:	46                   	inc    %esi
    11ce:	83 fe 13             	cmp    $0x13,%esi
    11d1:	7f 07                	jg     11da <createdelete+0x1cb>
    for(pi = 0; pi < 4; pi++){
    11d3:	bb 00 00 00 00       	mov    $0x0,%ebx
    11d8:	eb ee                	jmp    11c8 <createdelete+0x1b9>
    }
  }

  printf(1, "createdelete ok\n");
    11da:	83 ec 08             	sub    $0x8,%esp
    11dd:	68 fb 3f 00 00       	push   $0x3ffb
    11e2:	6a 01                	push   $0x1
    11e4:	e8 9f 26 00 00       	call   3888 <printf>
}
    11e9:	83 c4 10             	add    $0x10,%esp
    11ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
    11ef:	5b                   	pop    %ebx
    11f0:	5e                   	pop    %esi
    11f1:	5d                   	pop    %ebp
    11f2:	c3                   	ret    

000011f3 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    11f3:	f3 0f 1e fb          	endbr32 
    11f7:	55                   	push   %ebp
    11f8:	89 e5                	mov    %esp,%ebp
    11fa:	56                   	push   %esi
    11fb:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    11fc:	83 ec 08             	sub    $0x8,%esp
    11ff:	68 0c 40 00 00       	push   $0x400c
    1204:	6a 01                	push   $0x1
    1206:	e8 7d 26 00 00       	call   3888 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    120b:	83 c4 08             	add    $0x8,%esp
    120e:	68 02 02 00 00       	push   $0x202
    1213:	68 1d 40 00 00       	push   $0x401d
    1218:	e8 6c 25 00 00       	call   3789 <open>
  if(fd < 0){
    121d:	83 c4 10             	add    $0x10,%esp
    1220:	85 c0                	test   %eax,%eax
    1222:	0f 88 f0 00 00 00    	js     1318 <unlinkread+0x125>
    1228:	89 c3                	mov    %eax,%ebx
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    122a:	83 ec 04             	sub    $0x4,%esp
    122d:	6a 05                	push   $0x5
    122f:	68 42 40 00 00       	push   $0x4042
    1234:	50                   	push   %eax
    1235:	e8 2f 25 00 00       	call   3769 <write>
  close(fd);
    123a:	89 1c 24             	mov    %ebx,(%esp)
    123d:	e8 2f 25 00 00       	call   3771 <close>

  fd = open("unlinkread", O_RDWR);
    1242:	83 c4 08             	add    $0x8,%esp
    1245:	6a 02                	push   $0x2
    1247:	68 1d 40 00 00       	push   $0x401d
    124c:	e8 38 25 00 00       	call   3789 <open>
    1251:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1253:	83 c4 10             	add    $0x10,%esp
    1256:	85 c0                	test   %eax,%eax
    1258:	0f 88 ce 00 00 00    	js     132c <unlinkread+0x139>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    125e:	83 ec 0c             	sub    $0xc,%esp
    1261:	68 1d 40 00 00       	push   $0x401d
    1266:	e8 2e 25 00 00       	call   3799 <unlink>
    126b:	83 c4 10             	add    $0x10,%esp
    126e:	85 c0                	test   %eax,%eax
    1270:	0f 85 ca 00 00 00    	jne    1340 <unlinkread+0x14d>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1276:	83 ec 08             	sub    $0x8,%esp
    1279:	68 02 02 00 00       	push   $0x202
    127e:	68 1d 40 00 00       	push   $0x401d
    1283:	e8 01 25 00 00       	call   3789 <open>
    1288:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    128a:	83 c4 0c             	add    $0xc,%esp
    128d:	6a 03                	push   $0x3
    128f:	68 7a 40 00 00       	push   $0x407a
    1294:	50                   	push   %eax
    1295:	e8 cf 24 00 00       	call   3769 <write>
  close(fd1);
    129a:	89 34 24             	mov    %esi,(%esp)
    129d:	e8 cf 24 00 00       	call   3771 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    12a2:	83 c4 0c             	add    $0xc,%esp
    12a5:	68 00 20 00 00       	push   $0x2000
    12aa:	68 60 83 00 00       	push   $0x8360
    12af:	53                   	push   %ebx
    12b0:	e8 ac 24 00 00       	call   3761 <read>
    12b5:	83 c4 10             	add    $0x10,%esp
    12b8:	83 f8 05             	cmp    $0x5,%eax
    12bb:	0f 85 93 00 00 00    	jne    1354 <unlinkread+0x161>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    12c1:	80 3d 60 83 00 00 68 	cmpb   $0x68,0x8360
    12c8:	0f 85 9a 00 00 00    	jne    1368 <unlinkread+0x175>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    12ce:	83 ec 04             	sub    $0x4,%esp
    12d1:	6a 0a                	push   $0xa
    12d3:	68 60 83 00 00       	push   $0x8360
    12d8:	53                   	push   %ebx
    12d9:	e8 8b 24 00 00       	call   3769 <write>
    12de:	83 c4 10             	add    $0x10,%esp
    12e1:	83 f8 0a             	cmp    $0xa,%eax
    12e4:	0f 85 92 00 00 00    	jne    137c <unlinkread+0x189>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    12ea:	83 ec 0c             	sub    $0xc,%esp
    12ed:	53                   	push   %ebx
    12ee:	e8 7e 24 00 00       	call   3771 <close>
  unlink("unlinkread");
    12f3:	c7 04 24 1d 40 00 00 	movl   $0x401d,(%esp)
    12fa:	e8 9a 24 00 00       	call   3799 <unlink>
  printf(1, "unlinkread ok\n");
    12ff:	83 c4 08             	add    $0x8,%esp
    1302:	68 c5 40 00 00       	push   $0x40c5
    1307:	6a 01                	push   $0x1
    1309:	e8 7a 25 00 00       	call   3888 <printf>
}
    130e:	83 c4 10             	add    $0x10,%esp
    1311:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1314:	5b                   	pop    %ebx
    1315:	5e                   	pop    %esi
    1316:	5d                   	pop    %ebp
    1317:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1318:	83 ec 08             	sub    $0x8,%esp
    131b:	68 28 40 00 00       	push   $0x4028
    1320:	6a 01                	push   $0x1
    1322:	e8 61 25 00 00       	call   3888 <printf>
    exit();
    1327:	e8 1d 24 00 00       	call   3749 <exit>
    printf(1, "open unlinkread failed\n");
    132c:	83 ec 08             	sub    $0x8,%esp
    132f:	68 48 40 00 00       	push   $0x4048
    1334:	6a 01                	push   $0x1
    1336:	e8 4d 25 00 00       	call   3888 <printf>
    exit();
    133b:	e8 09 24 00 00       	call   3749 <exit>
    printf(1, "unlink unlinkread failed\n");
    1340:	83 ec 08             	sub    $0x8,%esp
    1343:	68 60 40 00 00       	push   $0x4060
    1348:	6a 01                	push   $0x1
    134a:	e8 39 25 00 00       	call   3888 <printf>
    exit();
    134f:	e8 f5 23 00 00       	call   3749 <exit>
    printf(1, "unlinkread read failed");
    1354:	83 ec 08             	sub    $0x8,%esp
    1357:	68 7e 40 00 00       	push   $0x407e
    135c:	6a 01                	push   $0x1
    135e:	e8 25 25 00 00       	call   3888 <printf>
    exit();
    1363:	e8 e1 23 00 00       	call   3749 <exit>
    printf(1, "unlinkread wrong data\n");
    1368:	83 ec 08             	sub    $0x8,%esp
    136b:	68 95 40 00 00       	push   $0x4095
    1370:	6a 01                	push   $0x1
    1372:	e8 11 25 00 00       	call   3888 <printf>
    exit();
    1377:	e8 cd 23 00 00       	call   3749 <exit>
    printf(1, "unlinkread write failed\n");
    137c:	83 ec 08             	sub    $0x8,%esp
    137f:	68 ac 40 00 00       	push   $0x40ac
    1384:	6a 01                	push   $0x1
    1386:	e8 fd 24 00 00       	call   3888 <printf>
    exit();
    138b:	e8 b9 23 00 00       	call   3749 <exit>

00001390 <linktest>:

void
linktest(void)
{
    1390:	f3 0f 1e fb          	endbr32 
    1394:	55                   	push   %ebp
    1395:	89 e5                	mov    %esp,%ebp
    1397:	53                   	push   %ebx
    1398:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    139b:	68 d4 40 00 00       	push   $0x40d4
    13a0:	6a 01                	push   $0x1
    13a2:	e8 e1 24 00 00       	call   3888 <printf>

  unlink("lf1");
    13a7:	c7 04 24 de 40 00 00 	movl   $0x40de,(%esp)
    13ae:	e8 e6 23 00 00       	call   3799 <unlink>
  unlink("lf2");
    13b3:	c7 04 24 e2 40 00 00 	movl   $0x40e2,(%esp)
    13ba:	e8 da 23 00 00       	call   3799 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    13bf:	83 c4 08             	add    $0x8,%esp
    13c2:	68 02 02 00 00       	push   $0x202
    13c7:	68 de 40 00 00       	push   $0x40de
    13cc:	e8 b8 23 00 00       	call   3789 <open>
  if(fd < 0){
    13d1:	83 c4 10             	add    $0x10,%esp
    13d4:	85 c0                	test   %eax,%eax
    13d6:	0f 88 2a 01 00 00    	js     1506 <linktest+0x176>
    13dc:	89 c3                	mov    %eax,%ebx
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    13de:	83 ec 04             	sub    $0x4,%esp
    13e1:	6a 05                	push   $0x5
    13e3:	68 42 40 00 00       	push   $0x4042
    13e8:	50                   	push   %eax
    13e9:	e8 7b 23 00 00       	call   3769 <write>
    13ee:	83 c4 10             	add    $0x10,%esp
    13f1:	83 f8 05             	cmp    $0x5,%eax
    13f4:	0f 85 20 01 00 00    	jne    151a <linktest+0x18a>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    13fa:	83 ec 0c             	sub    $0xc,%esp
    13fd:	53                   	push   %ebx
    13fe:	e8 6e 23 00 00       	call   3771 <close>

  if(link("lf1", "lf2") < 0){
    1403:	83 c4 08             	add    $0x8,%esp
    1406:	68 e2 40 00 00       	push   $0x40e2
    140b:	68 de 40 00 00       	push   $0x40de
    1410:	e8 94 23 00 00       	call   37a9 <link>
    1415:	83 c4 10             	add    $0x10,%esp
    1418:	85 c0                	test   %eax,%eax
    141a:	0f 88 0e 01 00 00    	js     152e <linktest+0x19e>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1420:	83 ec 0c             	sub    $0xc,%esp
    1423:	68 de 40 00 00       	push   $0x40de
    1428:	e8 6c 23 00 00       	call   3799 <unlink>

  if(open("lf1", 0) >= 0){
    142d:	83 c4 08             	add    $0x8,%esp
    1430:	6a 00                	push   $0x0
    1432:	68 de 40 00 00       	push   $0x40de
    1437:	e8 4d 23 00 00       	call   3789 <open>
    143c:	83 c4 10             	add    $0x10,%esp
    143f:	85 c0                	test   %eax,%eax
    1441:	0f 89 fb 00 00 00    	jns    1542 <linktest+0x1b2>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1447:	83 ec 08             	sub    $0x8,%esp
    144a:	6a 00                	push   $0x0
    144c:	68 e2 40 00 00       	push   $0x40e2
    1451:	e8 33 23 00 00       	call   3789 <open>
    1456:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1458:	83 c4 10             	add    $0x10,%esp
    145b:	85 c0                	test   %eax,%eax
    145d:	0f 88 f3 00 00 00    	js     1556 <linktest+0x1c6>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1463:	83 ec 04             	sub    $0x4,%esp
    1466:	68 00 20 00 00       	push   $0x2000
    146b:	68 60 83 00 00       	push   $0x8360
    1470:	50                   	push   %eax
    1471:	e8 eb 22 00 00       	call   3761 <read>
    1476:	83 c4 10             	add    $0x10,%esp
    1479:	83 f8 05             	cmp    $0x5,%eax
    147c:	0f 85 e8 00 00 00    	jne    156a <linktest+0x1da>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    1482:	83 ec 0c             	sub    $0xc,%esp
    1485:	53                   	push   %ebx
    1486:	e8 e6 22 00 00       	call   3771 <close>

  if(link("lf2", "lf2") >= 0){
    148b:	83 c4 08             	add    $0x8,%esp
    148e:	68 e2 40 00 00       	push   $0x40e2
    1493:	68 e2 40 00 00       	push   $0x40e2
    1498:	e8 0c 23 00 00       	call   37a9 <link>
    149d:	83 c4 10             	add    $0x10,%esp
    14a0:	85 c0                	test   %eax,%eax
    14a2:	0f 89 d6 00 00 00    	jns    157e <linktest+0x1ee>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    14a8:	83 ec 0c             	sub    $0xc,%esp
    14ab:	68 e2 40 00 00       	push   $0x40e2
    14b0:	e8 e4 22 00 00       	call   3799 <unlink>
  if(link("lf2", "lf1") >= 0){
    14b5:	83 c4 08             	add    $0x8,%esp
    14b8:	68 de 40 00 00       	push   $0x40de
    14bd:	68 e2 40 00 00       	push   $0x40e2
    14c2:	e8 e2 22 00 00       	call   37a9 <link>
    14c7:	83 c4 10             	add    $0x10,%esp
    14ca:	85 c0                	test   %eax,%eax
    14cc:	0f 89 c0 00 00 00    	jns    1592 <linktest+0x202>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    14d2:	83 ec 08             	sub    $0x8,%esp
    14d5:	68 de 40 00 00       	push   $0x40de
    14da:	68 a6 43 00 00       	push   $0x43a6
    14df:	e8 c5 22 00 00       	call   37a9 <link>
    14e4:	83 c4 10             	add    $0x10,%esp
    14e7:	85 c0                	test   %eax,%eax
    14e9:	0f 89 b7 00 00 00    	jns    15a6 <linktest+0x216>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    14ef:	83 ec 08             	sub    $0x8,%esp
    14f2:	68 7c 41 00 00       	push   $0x417c
    14f7:	6a 01                	push   $0x1
    14f9:	e8 8a 23 00 00       	call   3888 <printf>
}
    14fe:	83 c4 10             	add    $0x10,%esp
    1501:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1504:	c9                   	leave  
    1505:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1506:	83 ec 08             	sub    $0x8,%esp
    1509:	68 e6 40 00 00       	push   $0x40e6
    150e:	6a 01                	push   $0x1
    1510:	e8 73 23 00 00       	call   3888 <printf>
    exit();
    1515:	e8 2f 22 00 00       	call   3749 <exit>
    printf(1, "write lf1 failed\n");
    151a:	83 ec 08             	sub    $0x8,%esp
    151d:	68 f9 40 00 00       	push   $0x40f9
    1522:	6a 01                	push   $0x1
    1524:	e8 5f 23 00 00       	call   3888 <printf>
    exit();
    1529:	e8 1b 22 00 00       	call   3749 <exit>
    printf(1, "link lf1 lf2 failed\n");
    152e:	83 ec 08             	sub    $0x8,%esp
    1531:	68 0b 41 00 00       	push   $0x410b
    1536:	6a 01                	push   $0x1
    1538:	e8 4b 23 00 00       	call   3888 <printf>
    exit();
    153d:	e8 07 22 00 00       	call   3749 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1542:	83 ec 08             	sub    $0x8,%esp
    1545:	68 ec 4c 00 00       	push   $0x4cec
    154a:	6a 01                	push   $0x1
    154c:	e8 37 23 00 00       	call   3888 <printf>
    exit();
    1551:	e8 f3 21 00 00       	call   3749 <exit>
    printf(1, "open lf2 failed\n");
    1556:	83 ec 08             	sub    $0x8,%esp
    1559:	68 20 41 00 00       	push   $0x4120
    155e:	6a 01                	push   $0x1
    1560:	e8 23 23 00 00       	call   3888 <printf>
    exit();
    1565:	e8 df 21 00 00       	call   3749 <exit>
    printf(1, "read lf2 failed\n");
    156a:	83 ec 08             	sub    $0x8,%esp
    156d:	68 31 41 00 00       	push   $0x4131
    1572:	6a 01                	push   $0x1
    1574:	e8 0f 23 00 00       	call   3888 <printf>
    exit();
    1579:	e8 cb 21 00 00       	call   3749 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    157e:	83 ec 08             	sub    $0x8,%esp
    1581:	68 42 41 00 00       	push   $0x4142
    1586:	6a 01                	push   $0x1
    1588:	e8 fb 22 00 00       	call   3888 <printf>
    exit();
    158d:	e8 b7 21 00 00       	call   3749 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    1592:	83 ec 08             	sub    $0x8,%esp
    1595:	68 14 4d 00 00       	push   $0x4d14
    159a:	6a 01                	push   $0x1
    159c:	e8 e7 22 00 00       	call   3888 <printf>
    exit();
    15a1:	e8 a3 21 00 00       	call   3749 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    15a6:	83 ec 08             	sub    $0x8,%esp
    15a9:	68 60 41 00 00       	push   $0x4160
    15ae:	6a 01                	push   $0x1
    15b0:	e8 d3 22 00 00       	call   3888 <printf>
    exit();
    15b5:	e8 8f 21 00 00       	call   3749 <exit>

000015ba <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    15ba:	f3 0f 1e fb          	endbr32 
    15be:	55                   	push   %ebp
    15bf:	89 e5                	mov    %esp,%ebp
    15c1:	57                   	push   %edi
    15c2:	56                   	push   %esi
    15c3:	53                   	push   %ebx
    15c4:	83 ec 54             	sub    $0x54,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    15c7:	68 89 41 00 00       	push   $0x4189
    15cc:	6a 01                	push   $0x1
    15ce:	e8 b5 22 00 00       	call   3888 <printf>
  file[0] = 'C';
    15d3:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    15d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    15db:	83 c4 10             	add    $0x10,%esp
    15de:	bb 00 00 00 00       	mov    $0x0,%ebx
    15e3:	eb 41                	jmp    1626 <concreate+0x6c>
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    15e5:	85 f6                	test   %esi,%esi
    15e7:	75 0f                	jne    15f8 <concreate+0x3e>
    15e9:	b9 05 00 00 00       	mov    $0x5,%ecx
    15ee:	89 d8                	mov    %ebx,%eax
    15f0:	99                   	cltd   
    15f1:	f7 f9                	idiv   %ecx
    15f3:	83 fa 01             	cmp    $0x1,%edx
    15f6:	74 78                	je     1670 <concreate+0xb6>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    15f8:	83 ec 08             	sub    $0x8,%esp
    15fb:	68 02 02 00 00       	push   $0x202
    1600:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1603:	50                   	push   %eax
    1604:	e8 80 21 00 00       	call   3789 <open>
      if(fd < 0){
    1609:	83 c4 10             	add    $0x10,%esp
    160c:	85 c0                	test   %eax,%eax
    160e:	78 76                	js     1686 <concreate+0xcc>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1610:	83 ec 0c             	sub    $0xc,%esp
    1613:	50                   	push   %eax
    1614:	e8 58 21 00 00       	call   3771 <close>
    1619:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    161c:	85 f6                	test   %esi,%esi
    161e:	74 7e                	je     169e <concreate+0xe4>
      exit();
    else
      wait();
    1620:	e8 2c 21 00 00       	call   3751 <wait>
  for(i = 0; i < 40; i++){
    1625:	43                   	inc    %ebx
    1626:	83 fb 27             	cmp    $0x27,%ebx
    1629:	7f 78                	jg     16a3 <concreate+0xe9>
    file[1] = '0' + i;
    162b:	8d 43 30             	lea    0x30(%ebx),%eax
    162e:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    1631:	83 ec 0c             	sub    $0xc,%esp
    1634:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1637:	50                   	push   %eax
    1638:	e8 5c 21 00 00       	call   3799 <unlink>
    pid = fork();
    163d:	e8 ff 20 00 00       	call   3741 <fork>
    1642:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    1644:	83 c4 10             	add    $0x10,%esp
    1647:	85 c0                	test   %eax,%eax
    1649:	74 9a                	je     15e5 <concreate+0x2b>
    164b:	b9 03 00 00 00       	mov    $0x3,%ecx
    1650:	89 d8                	mov    %ebx,%eax
    1652:	99                   	cltd   
    1653:	f7 f9                	idiv   %ecx
    1655:	83 fa 01             	cmp    $0x1,%edx
    1658:	75 8b                	jne    15e5 <concreate+0x2b>
      link("C0", file);
    165a:	83 ec 08             	sub    $0x8,%esp
    165d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1660:	50                   	push   %eax
    1661:	68 99 41 00 00       	push   $0x4199
    1666:	e8 3e 21 00 00       	call   37a9 <link>
    166b:	83 c4 10             	add    $0x10,%esp
    166e:	eb ac                	jmp    161c <concreate+0x62>
      link("C0", file);
    1670:	83 ec 08             	sub    $0x8,%esp
    1673:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1676:	50                   	push   %eax
    1677:	68 99 41 00 00       	push   $0x4199
    167c:	e8 28 21 00 00       	call   37a9 <link>
    1681:	83 c4 10             	add    $0x10,%esp
    1684:	eb 96                	jmp    161c <concreate+0x62>
        printf(1, "concreate create %s failed\n", file);
    1686:	83 ec 04             	sub    $0x4,%esp
    1689:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    168c:	50                   	push   %eax
    168d:	68 9c 41 00 00       	push   $0x419c
    1692:	6a 01                	push   $0x1
    1694:	e8 ef 21 00 00       	call   3888 <printf>
        exit();
    1699:	e8 ab 20 00 00       	call   3749 <exit>
      exit();
    169e:	e8 a6 20 00 00       	call   3749 <exit>
  }

  memset(fa, 0, sizeof(fa));
    16a3:	83 ec 04             	sub    $0x4,%esp
    16a6:	6a 28                	push   $0x28
    16a8:	6a 00                	push   $0x0
    16aa:	8d 45 bd             	lea    -0x43(%ebp),%eax
    16ad:	50                   	push   %eax
    16ae:	e8 59 1f 00 00       	call   360c <memset>
  fd = open(".", 0);
    16b3:	83 c4 08             	add    $0x8,%esp
    16b6:	6a 00                	push   $0x0
    16b8:	68 a6 43 00 00       	push   $0x43a6
    16bd:	e8 c7 20 00 00       	call   3789 <open>
    16c2:	89 c3                	mov    %eax,%ebx
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    16c4:	83 c4 10             	add    $0x10,%esp
  n = 0;
    16c7:	be 00 00 00 00       	mov    $0x0,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    16cc:	83 ec 04             	sub    $0x4,%esp
    16cf:	6a 10                	push   $0x10
    16d1:	8d 45 ac             	lea    -0x54(%ebp),%eax
    16d4:	50                   	push   %eax
    16d5:	53                   	push   %ebx
    16d6:	e8 86 20 00 00       	call   3761 <read>
    16db:	83 c4 10             	add    $0x10,%esp
    16de:	85 c0                	test   %eax,%eax
    16e0:	7e 5e                	jle    1740 <concreate+0x186>
    if(de.inum == 0)
    16e2:	66 83 7d ac 00       	cmpw   $0x0,-0x54(%ebp)
    16e7:	74 e3                	je     16cc <concreate+0x112>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    16e9:	80 7d ae 43          	cmpb   $0x43,-0x52(%ebp)
    16ed:	75 dd                	jne    16cc <concreate+0x112>
    16ef:	80 7d b0 00          	cmpb   $0x0,-0x50(%ebp)
    16f3:	75 d7                	jne    16cc <concreate+0x112>
      i = de.name[1] - '0';
    16f5:	0f be 45 af          	movsbl -0x51(%ebp),%eax
    16f9:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    16fc:	83 f8 27             	cmp    $0x27,%eax
    16ff:	77 0f                	ja     1710 <concreate+0x156>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1701:	80 7c 05 bd 00       	cmpb   $0x0,-0x43(%ebp,%eax,1)
    1706:	75 20                	jne    1728 <concreate+0x16e>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    1708:	c6 44 05 bd 01       	movb   $0x1,-0x43(%ebp,%eax,1)
      n++;
    170d:	46                   	inc    %esi
    170e:	eb bc                	jmp    16cc <concreate+0x112>
        printf(1, "concreate weird file %s\n", de.name);
    1710:	83 ec 04             	sub    $0x4,%esp
    1713:	8d 45 ae             	lea    -0x52(%ebp),%eax
    1716:	50                   	push   %eax
    1717:	68 b8 41 00 00       	push   $0x41b8
    171c:	6a 01                	push   $0x1
    171e:	e8 65 21 00 00       	call   3888 <printf>
        exit();
    1723:	e8 21 20 00 00       	call   3749 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1728:	83 ec 04             	sub    $0x4,%esp
    172b:	8d 45 ae             	lea    -0x52(%ebp),%eax
    172e:	50                   	push   %eax
    172f:	68 d1 41 00 00       	push   $0x41d1
    1734:	6a 01                	push   $0x1
    1736:	e8 4d 21 00 00       	call   3888 <printf>
        exit();
    173b:	e8 09 20 00 00       	call   3749 <exit>
    }
  }
  close(fd);
    1740:	83 ec 0c             	sub    $0xc,%esp
    1743:	53                   	push   %ebx
    1744:	e8 28 20 00 00       	call   3771 <close>

  if(n != 40){
    1749:	83 c4 10             	add    $0x10,%esp
    174c:	83 fe 28             	cmp    $0x28,%esi
    174f:	75 07                	jne    1758 <concreate+0x19e>
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1751:	bb 00 00 00 00       	mov    $0x0,%ebx
    1756:	eb 5d                	jmp    17b5 <concreate+0x1fb>
    printf(1, "concreate not enough files in directory listing\n");
    1758:	83 ec 08             	sub    $0x8,%esp
    175b:	68 38 4d 00 00       	push   $0x4d38
    1760:	6a 01                	push   $0x1
    1762:	e8 21 21 00 00       	call   3888 <printf>
    exit();
    1767:	e8 dd 1f 00 00       	call   3749 <exit>
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    176c:	83 ec 08             	sub    $0x8,%esp
    176f:	68 71 4a 00 00       	push   $0x4a71
    1774:	6a 01                	push   $0x1
    1776:	e8 0d 21 00 00       	call   3888 <printf>
      exit();
    177b:	e8 c9 1f 00 00       	call   3749 <exit>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1780:	83 ec 0c             	sub    $0xc,%esp
    1783:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    1786:	57                   	push   %edi
    1787:	e8 0d 20 00 00       	call   3799 <unlink>
      unlink(file);
    178c:	89 3c 24             	mov    %edi,(%esp)
    178f:	e8 05 20 00 00       	call   3799 <unlink>
      unlink(file);
    1794:	89 3c 24             	mov    %edi,(%esp)
    1797:	e8 fd 1f 00 00       	call   3799 <unlink>
      unlink(file);
    179c:	89 3c 24             	mov    %edi,(%esp)
    179f:	e8 f5 1f 00 00       	call   3799 <unlink>
    17a4:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    17a7:	85 f6                	test   %esi,%esi
    17a9:	0f 84 92 00 00 00    	je     1841 <concreate+0x287>
      exit();
    else
      wait();
    17af:	e8 9d 1f 00 00       	call   3751 <wait>
  for(i = 0; i < 40; i++){
    17b4:	43                   	inc    %ebx
    17b5:	83 fb 27             	cmp    $0x27,%ebx
    17b8:	0f 8f 88 00 00 00    	jg     1846 <concreate+0x28c>
    file[1] = '0' + i;
    17be:	8d 43 30             	lea    0x30(%ebx),%eax
    17c1:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    17c4:	e8 78 1f 00 00       	call   3741 <fork>
    17c9:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    17cb:	85 c0                	test   %eax,%eax
    17cd:	78 9d                	js     176c <concreate+0x1b2>
    if(((i % 3) == 0 && pid == 0) ||
    17cf:	b9 03 00 00 00       	mov    $0x3,%ecx
    17d4:	89 d8                	mov    %ebx,%eax
    17d6:	99                   	cltd   
    17d7:	f7 f9                	idiv   %ecx
    17d9:	85 d2                	test   %edx,%edx
    17db:	75 04                	jne    17e1 <concreate+0x227>
    17dd:	85 f6                	test   %esi,%esi
    17df:	74 09                	je     17ea <concreate+0x230>
    17e1:	83 fa 01             	cmp    $0x1,%edx
    17e4:	75 9a                	jne    1780 <concreate+0x1c6>
       ((i % 3) == 1 && pid != 0)){
    17e6:	85 f6                	test   %esi,%esi
    17e8:	74 96                	je     1780 <concreate+0x1c6>
      close(open(file, 0));
    17ea:	83 ec 08             	sub    $0x8,%esp
    17ed:	6a 00                	push   $0x0
    17ef:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    17f2:	57                   	push   %edi
    17f3:	e8 91 1f 00 00       	call   3789 <open>
    17f8:	89 04 24             	mov    %eax,(%esp)
    17fb:	e8 71 1f 00 00       	call   3771 <close>
      close(open(file, 0));
    1800:	83 c4 08             	add    $0x8,%esp
    1803:	6a 00                	push   $0x0
    1805:	57                   	push   %edi
    1806:	e8 7e 1f 00 00       	call   3789 <open>
    180b:	89 04 24             	mov    %eax,(%esp)
    180e:	e8 5e 1f 00 00       	call   3771 <close>
      close(open(file, 0));
    1813:	83 c4 08             	add    $0x8,%esp
    1816:	6a 00                	push   $0x0
    1818:	57                   	push   %edi
    1819:	e8 6b 1f 00 00       	call   3789 <open>
    181e:	89 04 24             	mov    %eax,(%esp)
    1821:	e8 4b 1f 00 00       	call   3771 <close>
      close(open(file, 0));
    1826:	83 c4 08             	add    $0x8,%esp
    1829:	6a 00                	push   $0x0
    182b:	57                   	push   %edi
    182c:	e8 58 1f 00 00       	call   3789 <open>
    1831:	89 04 24             	mov    %eax,(%esp)
    1834:	e8 38 1f 00 00       	call   3771 <close>
    1839:	83 c4 10             	add    $0x10,%esp
    183c:	e9 66 ff ff ff       	jmp    17a7 <concreate+0x1ed>
      exit();
    1841:	e8 03 1f 00 00       	call   3749 <exit>
  }

  printf(1, "concreate ok\n");
    1846:	83 ec 08             	sub    $0x8,%esp
    1849:	68 ee 41 00 00       	push   $0x41ee
    184e:	6a 01                	push   $0x1
    1850:	e8 33 20 00 00       	call   3888 <printf>
}
    1855:	83 c4 10             	add    $0x10,%esp
    1858:	8d 65 f4             	lea    -0xc(%ebp),%esp
    185b:	5b                   	pop    %ebx
    185c:	5e                   	pop    %esi
    185d:	5f                   	pop    %edi
    185e:	5d                   	pop    %ebp
    185f:	c3                   	ret    

00001860 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1860:	f3 0f 1e fb          	endbr32 
    1864:	55                   	push   %ebp
    1865:	89 e5                	mov    %esp,%ebp
    1867:	57                   	push   %edi
    1868:	56                   	push   %esi
    1869:	53                   	push   %ebx
    186a:	83 ec 14             	sub    $0x14,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    186d:	68 fc 41 00 00       	push   $0x41fc
    1872:	6a 01                	push   $0x1
    1874:	e8 0f 20 00 00       	call   3888 <printf>

  unlink("x");
    1879:	c7 04 24 89 44 00 00 	movl   $0x4489,(%esp)
    1880:	e8 14 1f 00 00       	call   3799 <unlink>
  pid = fork();
    1885:	e8 b7 1e 00 00       	call   3741 <fork>
  if(pid < 0){
    188a:	83 c4 10             	add    $0x10,%esp
    188d:	85 c0                	test   %eax,%eax
    188f:	78 10                	js     18a1 <linkunlink+0x41>
    1891:	89 c7                	mov    %eax,%edi
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1893:	74 20                	je     18b5 <linkunlink+0x55>
    1895:	bb 01 00 00 00       	mov    $0x1,%ebx
    189a:	be 00 00 00 00       	mov    $0x0,%esi
    189f:	eb 4b                	jmp    18ec <linkunlink+0x8c>
    printf(1, "fork failed\n");
    18a1:	83 ec 08             	sub    $0x8,%esp
    18a4:	68 71 4a 00 00       	push   $0x4a71
    18a9:	6a 01                	push   $0x1
    18ab:	e8 d8 1f 00 00       	call   3888 <printf>
    exit();
    18b0:	e8 94 1e 00 00       	call   3749 <exit>
  unsigned int x = (pid ? 1 : 97);
    18b5:	bb 61 00 00 00       	mov    $0x61,%ebx
    18ba:	eb de                	jmp    189a <linkunlink+0x3a>
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    18bc:	83 ec 08             	sub    $0x8,%esp
    18bf:	68 02 02 00 00       	push   $0x202
    18c4:	68 89 44 00 00       	push   $0x4489
    18c9:	e8 bb 1e 00 00       	call   3789 <open>
    18ce:	89 04 24             	mov    %eax,(%esp)
    18d1:	e8 9b 1e 00 00       	call   3771 <close>
    18d6:	83 c4 10             	add    $0x10,%esp
    18d9:	eb 10                	jmp    18eb <linkunlink+0x8b>
    } else if((x % 3) == 1){
      link("cat", "x");
    } else {
      unlink("x");
    18db:	83 ec 0c             	sub    $0xc,%esp
    18de:	68 89 44 00 00       	push   $0x4489
    18e3:	e8 b1 1e 00 00       	call   3799 <unlink>
    18e8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    18eb:	46                   	inc    %esi
    18ec:	83 fe 63             	cmp    $0x63,%esi
    18ef:	7f 56                	jg     1947 <linkunlink+0xe7>
    x = x * 1103515245 + 12345;
    18f1:	89 d8                	mov    %ebx,%eax
    18f3:	c1 e0 09             	shl    $0x9,%eax
    18f6:	29 d8                	sub    %ebx,%eax
    18f8:	8d 14 83             	lea    (%ebx,%eax,4),%edx
    18fb:	89 d0                	mov    %edx,%eax
    18fd:	c1 e0 09             	shl    $0x9,%eax
    1900:	29 d0                	sub    %edx,%eax
    1902:	01 c0                	add    %eax,%eax
    1904:	01 d8                	add    %ebx,%eax
    1906:	89 c2                	mov    %eax,%edx
    1908:	c1 e2 05             	shl    $0x5,%edx
    190b:	01 d0                	add    %edx,%eax
    190d:	c1 e0 02             	shl    $0x2,%eax
    1910:	29 d8                	sub    %ebx,%eax
    1912:	8d 9c 83 39 30 00 00 	lea    0x3039(%ebx,%eax,4),%ebx
    if((x % 3) == 0){
    1919:	b9 03 00 00 00       	mov    $0x3,%ecx
    191e:	89 d8                	mov    %ebx,%eax
    1920:	ba 00 00 00 00       	mov    $0x0,%edx
    1925:	f7 f1                	div    %ecx
    1927:	85 d2                	test   %edx,%edx
    1929:	74 91                	je     18bc <linkunlink+0x5c>
    } else if((x % 3) == 1){
    192b:	83 fa 01             	cmp    $0x1,%edx
    192e:	75 ab                	jne    18db <linkunlink+0x7b>
      link("cat", "x");
    1930:	83 ec 08             	sub    $0x8,%esp
    1933:	68 89 44 00 00       	push   $0x4489
    1938:	68 0d 42 00 00       	push   $0x420d
    193d:	e8 67 1e 00 00       	call   37a9 <link>
    1942:	83 c4 10             	add    $0x10,%esp
    1945:	eb a4                	jmp    18eb <linkunlink+0x8b>
    }
  }

  if(pid)
    1947:	85 ff                	test   %edi,%edi
    1949:	74 1c                	je     1967 <linkunlink+0x107>
    wait();
    194b:	e8 01 1e 00 00       	call   3751 <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    1950:	83 ec 08             	sub    $0x8,%esp
    1953:	68 11 42 00 00       	push   $0x4211
    1958:	6a 01                	push   $0x1
    195a:	e8 29 1f 00 00       	call   3888 <printf>
}
    195f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1962:	5b                   	pop    %ebx
    1963:	5e                   	pop    %esi
    1964:	5f                   	pop    %edi
    1965:	5d                   	pop    %ebp
    1966:	c3                   	ret    
    exit();
    1967:	e8 dd 1d 00 00       	call   3749 <exit>

0000196c <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    196c:	f3 0f 1e fb          	endbr32 
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    1973:	53                   	push   %ebx
    1974:	83 ec 1c             	sub    $0x1c,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1977:	68 20 42 00 00       	push   $0x4220
    197c:	6a 01                	push   $0x1
    197e:	e8 05 1f 00 00       	call   3888 <printf>
  unlink("bd");
    1983:	c7 04 24 2d 42 00 00 	movl   $0x422d,(%esp)
    198a:	e8 0a 1e 00 00       	call   3799 <unlink>

  fd = open("bd", O_CREATE);
    198f:	83 c4 08             	add    $0x8,%esp
    1992:	68 00 02 00 00       	push   $0x200
    1997:	68 2d 42 00 00       	push   $0x422d
    199c:	e8 e8 1d 00 00       	call   3789 <open>
  if(fd < 0){
    19a1:	83 c4 10             	add    $0x10,%esp
    19a4:	85 c0                	test   %eax,%eax
    19a6:	78 13                	js     19bb <bigdir+0x4f>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    19a8:	83 ec 0c             	sub    $0xc,%esp
    19ab:	50                   	push   %eax
    19ac:	e8 c0 1d 00 00       	call   3771 <close>

  for(i = 0; i < 500; i++){
    19b1:	83 c4 10             	add    $0x10,%esp
    19b4:	bb 00 00 00 00       	mov    $0x0,%ebx
    19b9:	eb 3c                	jmp    19f7 <bigdir+0x8b>
    printf(1, "bigdir create failed\n");
    19bb:	83 ec 08             	sub    $0x8,%esp
    19be:	68 30 42 00 00       	push   $0x4230
    19c3:	6a 01                	push   $0x1
    19c5:	e8 be 1e 00 00       	call   3888 <printf>
    exit();
    19ca:	e8 7a 1d 00 00       	call   3749 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    19cf:	8d 43 3f             	lea    0x3f(%ebx),%eax
    19d2:	eb 35                	jmp    1a09 <bigdir+0x9d>
    name[2] = '0' + (i % 64);
    19d4:	83 c0 30             	add    $0x30,%eax
    19d7:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    19da:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    19de:	83 ec 08             	sub    $0x8,%esp
    19e1:	8d 45 ee             	lea    -0x12(%ebp),%eax
    19e4:	50                   	push   %eax
    19e5:	68 2d 42 00 00       	push   $0x422d
    19ea:	e8 ba 1d 00 00       	call   37a9 <link>
    19ef:	83 c4 10             	add    $0x10,%esp
    19f2:	85 c0                	test   %eax,%eax
    19f4:	75 2c                	jne    1a22 <bigdir+0xb6>
  for(i = 0; i < 500; i++){
    19f6:	43                   	inc    %ebx
    19f7:	81 fb f3 01 00 00    	cmp    $0x1f3,%ebx
    19fd:	7f 37                	jg     1a36 <bigdir+0xca>
    name[0] = 'x';
    19ff:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1a03:	89 d8                	mov    %ebx,%eax
    1a05:	85 db                	test   %ebx,%ebx
    1a07:	78 c6                	js     19cf <bigdir+0x63>
    1a09:	c1 f8 06             	sar    $0x6,%eax
    1a0c:	83 c0 30             	add    $0x30,%eax
    1a0f:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1a12:	89 d8                	mov    %ebx,%eax
    1a14:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1a19:	79 b9                	jns    19d4 <bigdir+0x68>
    1a1b:	48                   	dec    %eax
    1a1c:	83 c8 c0             	or     $0xffffffc0,%eax
    1a1f:	40                   	inc    %eax
    1a20:	eb b2                	jmp    19d4 <bigdir+0x68>
      printf(1, "bigdir link failed\n");
    1a22:	83 ec 08             	sub    $0x8,%esp
    1a25:	68 46 42 00 00       	push   $0x4246
    1a2a:	6a 01                	push   $0x1
    1a2c:	e8 57 1e 00 00       	call   3888 <printf>
      exit();
    1a31:	e8 13 1d 00 00       	call   3749 <exit>
    }
  }

  unlink("bd");
    1a36:	83 ec 0c             	sub    $0xc,%esp
    1a39:	68 2d 42 00 00       	push   $0x422d
    1a3e:	e8 56 1d 00 00       	call   3799 <unlink>
  for(i = 0; i < 500; i++){
    1a43:	83 c4 10             	add    $0x10,%esp
    1a46:	bb 00 00 00 00       	mov    $0x0,%ebx
    1a4b:	eb 23                	jmp    1a70 <bigdir+0x104>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1a4d:	8d 43 3f             	lea    0x3f(%ebx),%eax
    1a50:	eb 30                	jmp    1a82 <bigdir+0x116>
    name[2] = '0' + (i % 64);
    1a52:	83 c0 30             	add    $0x30,%eax
    1a55:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1a58:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1a5c:	83 ec 0c             	sub    $0xc,%esp
    1a5f:	8d 45 ee             	lea    -0x12(%ebp),%eax
    1a62:	50                   	push   %eax
    1a63:	e8 31 1d 00 00       	call   3799 <unlink>
    1a68:	83 c4 10             	add    $0x10,%esp
    1a6b:	85 c0                	test   %eax,%eax
    1a6d:	75 2c                	jne    1a9b <bigdir+0x12f>
  for(i = 0; i < 500; i++){
    1a6f:	43                   	inc    %ebx
    1a70:	81 fb f3 01 00 00    	cmp    $0x1f3,%ebx
    1a76:	7f 37                	jg     1aaf <bigdir+0x143>
    name[0] = 'x';
    1a78:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1a7c:	89 d8                	mov    %ebx,%eax
    1a7e:	85 db                	test   %ebx,%ebx
    1a80:	78 cb                	js     1a4d <bigdir+0xe1>
    1a82:	c1 f8 06             	sar    $0x6,%eax
    1a85:	83 c0 30             	add    $0x30,%eax
    1a88:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1a8b:	89 d8                	mov    %ebx,%eax
    1a8d:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1a92:	79 be                	jns    1a52 <bigdir+0xe6>
    1a94:	48                   	dec    %eax
    1a95:	83 c8 c0             	or     $0xffffffc0,%eax
    1a98:	40                   	inc    %eax
    1a99:	eb b7                	jmp    1a52 <bigdir+0xe6>
      printf(1, "bigdir unlink failed");
    1a9b:	83 ec 08             	sub    $0x8,%esp
    1a9e:	68 5a 42 00 00       	push   $0x425a
    1aa3:	6a 01                	push   $0x1
    1aa5:	e8 de 1d 00 00       	call   3888 <printf>
      exit();
    1aaa:	e8 9a 1c 00 00       	call   3749 <exit>
    }
  }

  printf(1, "bigdir ok\n");
    1aaf:	83 ec 08             	sub    $0x8,%esp
    1ab2:	68 6f 42 00 00       	push   $0x426f
    1ab7:	6a 01                	push   $0x1
    1ab9:	e8 ca 1d 00 00       	call   3888 <printf>
}
    1abe:	83 c4 10             	add    $0x10,%esp
    1ac1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1ac4:	c9                   	leave  
    1ac5:	c3                   	ret    

00001ac6 <subdir>:

void
subdir(void)
{
    1ac6:	f3 0f 1e fb          	endbr32 
    1aca:	55                   	push   %ebp
    1acb:	89 e5                	mov    %esp,%ebp
    1acd:	53                   	push   %ebx
    1ace:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1ad1:	68 7a 42 00 00       	push   $0x427a
    1ad6:	6a 01                	push   $0x1
    1ad8:	e8 ab 1d 00 00       	call   3888 <printf>

  unlink("ff");
    1add:	c7 04 24 03 43 00 00 	movl   $0x4303,(%esp)
    1ae4:	e8 b0 1c 00 00       	call   3799 <unlink>
  if(mkdir("dd") != 0){
    1ae9:	c7 04 24 a0 43 00 00 	movl   $0x43a0,(%esp)
    1af0:	e8 bc 1c 00 00       	call   37b1 <mkdir>
    1af5:	83 c4 10             	add    $0x10,%esp
    1af8:	85 c0                	test   %eax,%eax
    1afa:	0f 85 14 04 00 00    	jne    1f14 <subdir+0x44e>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1b00:	83 ec 08             	sub    $0x8,%esp
    1b03:	68 02 02 00 00       	push   $0x202
    1b08:	68 d9 42 00 00       	push   $0x42d9
    1b0d:	e8 77 1c 00 00       	call   3789 <open>
    1b12:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b14:	83 c4 10             	add    $0x10,%esp
    1b17:	85 c0                	test   %eax,%eax
    1b19:	0f 88 09 04 00 00    	js     1f28 <subdir+0x462>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1b1f:	83 ec 04             	sub    $0x4,%esp
    1b22:	6a 02                	push   $0x2
    1b24:	68 03 43 00 00       	push   $0x4303
    1b29:	50                   	push   %eax
    1b2a:	e8 3a 1c 00 00       	call   3769 <write>
  close(fd);
    1b2f:	89 1c 24             	mov    %ebx,(%esp)
    1b32:	e8 3a 1c 00 00       	call   3771 <close>

  if(unlink("dd") >= 0){
    1b37:	c7 04 24 a0 43 00 00 	movl   $0x43a0,(%esp)
    1b3e:	e8 56 1c 00 00       	call   3799 <unlink>
    1b43:	83 c4 10             	add    $0x10,%esp
    1b46:	85 c0                	test   %eax,%eax
    1b48:	0f 89 ee 03 00 00    	jns    1f3c <subdir+0x476>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1b4e:	83 ec 0c             	sub    $0xc,%esp
    1b51:	68 b4 42 00 00       	push   $0x42b4
    1b56:	e8 56 1c 00 00       	call   37b1 <mkdir>
    1b5b:	83 c4 10             	add    $0x10,%esp
    1b5e:	85 c0                	test   %eax,%eax
    1b60:	0f 85 ea 03 00 00    	jne    1f50 <subdir+0x48a>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1b66:	83 ec 08             	sub    $0x8,%esp
    1b69:	68 02 02 00 00       	push   $0x202
    1b6e:	68 d6 42 00 00       	push   $0x42d6
    1b73:	e8 11 1c 00 00       	call   3789 <open>
    1b78:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b7a:	83 c4 10             	add    $0x10,%esp
    1b7d:	85 c0                	test   %eax,%eax
    1b7f:	0f 88 df 03 00 00    	js     1f64 <subdir+0x49e>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1b85:	83 ec 04             	sub    $0x4,%esp
    1b88:	6a 02                	push   $0x2
    1b8a:	68 f7 42 00 00       	push   $0x42f7
    1b8f:	50                   	push   %eax
    1b90:	e8 d4 1b 00 00       	call   3769 <write>
  close(fd);
    1b95:	89 1c 24             	mov    %ebx,(%esp)
    1b98:	e8 d4 1b 00 00       	call   3771 <close>

  fd = open("dd/dd/../ff", 0);
    1b9d:	83 c4 08             	add    $0x8,%esp
    1ba0:	6a 00                	push   $0x0
    1ba2:	68 fa 42 00 00       	push   $0x42fa
    1ba7:	e8 dd 1b 00 00       	call   3789 <open>
    1bac:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1bae:	83 c4 10             	add    $0x10,%esp
    1bb1:	85 c0                	test   %eax,%eax
    1bb3:	0f 88 bf 03 00 00    	js     1f78 <subdir+0x4b2>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1bb9:	83 ec 04             	sub    $0x4,%esp
    1bbc:	68 00 20 00 00       	push   $0x2000
    1bc1:	68 60 83 00 00       	push   $0x8360
    1bc6:	50                   	push   %eax
    1bc7:	e8 95 1b 00 00       	call   3761 <read>
  if(cc != 2 || buf[0] != 'f'){
    1bcc:	83 c4 10             	add    $0x10,%esp
    1bcf:	83 f8 02             	cmp    $0x2,%eax
    1bd2:	0f 85 b4 03 00 00    	jne    1f8c <subdir+0x4c6>
    1bd8:	80 3d 60 83 00 00 66 	cmpb   $0x66,0x8360
    1bdf:	0f 85 a7 03 00 00    	jne    1f8c <subdir+0x4c6>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1be5:	83 ec 0c             	sub    $0xc,%esp
    1be8:	53                   	push   %ebx
    1be9:	e8 83 1b 00 00       	call   3771 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1bee:	83 c4 08             	add    $0x8,%esp
    1bf1:	68 3a 43 00 00       	push   $0x433a
    1bf6:	68 d6 42 00 00       	push   $0x42d6
    1bfb:	e8 a9 1b 00 00       	call   37a9 <link>
    1c00:	83 c4 10             	add    $0x10,%esp
    1c03:	85 c0                	test   %eax,%eax
    1c05:	0f 85 95 03 00 00    	jne    1fa0 <subdir+0x4da>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1c0b:	83 ec 0c             	sub    $0xc,%esp
    1c0e:	68 d6 42 00 00       	push   $0x42d6
    1c13:	e8 81 1b 00 00       	call   3799 <unlink>
    1c18:	83 c4 10             	add    $0x10,%esp
    1c1b:	85 c0                	test   %eax,%eax
    1c1d:	0f 85 91 03 00 00    	jne    1fb4 <subdir+0x4ee>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1c23:	83 ec 08             	sub    $0x8,%esp
    1c26:	6a 00                	push   $0x0
    1c28:	68 d6 42 00 00       	push   $0x42d6
    1c2d:	e8 57 1b 00 00       	call   3789 <open>
    1c32:	83 c4 10             	add    $0x10,%esp
    1c35:	85 c0                	test   %eax,%eax
    1c37:	0f 89 8b 03 00 00    	jns    1fc8 <subdir+0x502>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1c3d:	83 ec 0c             	sub    $0xc,%esp
    1c40:	68 a0 43 00 00       	push   $0x43a0
    1c45:	e8 6f 1b 00 00       	call   37b9 <chdir>
    1c4a:	83 c4 10             	add    $0x10,%esp
    1c4d:	85 c0                	test   %eax,%eax
    1c4f:	0f 85 87 03 00 00    	jne    1fdc <subdir+0x516>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1c55:	83 ec 0c             	sub    $0xc,%esp
    1c58:	68 6e 43 00 00       	push   $0x436e
    1c5d:	e8 57 1b 00 00       	call   37b9 <chdir>
    1c62:	83 c4 10             	add    $0x10,%esp
    1c65:	85 c0                	test   %eax,%eax
    1c67:	0f 85 83 03 00 00    	jne    1ff0 <subdir+0x52a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1c6d:	83 ec 0c             	sub    $0xc,%esp
    1c70:	68 94 43 00 00       	push   $0x4394
    1c75:	e8 3f 1b 00 00       	call   37b9 <chdir>
    1c7a:	83 c4 10             	add    $0x10,%esp
    1c7d:	85 c0                	test   %eax,%eax
    1c7f:	0f 85 7f 03 00 00    	jne    2004 <subdir+0x53e>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1c85:	83 ec 0c             	sub    $0xc,%esp
    1c88:	68 a3 43 00 00       	push   $0x43a3
    1c8d:	e8 27 1b 00 00       	call   37b9 <chdir>
    1c92:	83 c4 10             	add    $0x10,%esp
    1c95:	85 c0                	test   %eax,%eax
    1c97:	0f 85 7b 03 00 00    	jne    2018 <subdir+0x552>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1c9d:	83 ec 08             	sub    $0x8,%esp
    1ca0:	6a 00                	push   $0x0
    1ca2:	68 3a 43 00 00       	push   $0x433a
    1ca7:	e8 dd 1a 00 00       	call   3789 <open>
    1cac:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1cae:	83 c4 10             	add    $0x10,%esp
    1cb1:	85 c0                	test   %eax,%eax
    1cb3:	0f 88 73 03 00 00    	js     202c <subdir+0x566>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1cb9:	83 ec 04             	sub    $0x4,%esp
    1cbc:	68 00 20 00 00       	push   $0x2000
    1cc1:	68 60 83 00 00       	push   $0x8360
    1cc6:	50                   	push   %eax
    1cc7:	e8 95 1a 00 00       	call   3761 <read>
    1ccc:	83 c4 10             	add    $0x10,%esp
    1ccf:	83 f8 02             	cmp    $0x2,%eax
    1cd2:	0f 85 68 03 00 00    	jne    2040 <subdir+0x57a>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1cd8:	83 ec 0c             	sub    $0xc,%esp
    1cdb:	53                   	push   %ebx
    1cdc:	e8 90 1a 00 00       	call   3771 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ce1:	83 c4 08             	add    $0x8,%esp
    1ce4:	6a 00                	push   $0x0
    1ce6:	68 d6 42 00 00       	push   $0x42d6
    1ceb:	e8 99 1a 00 00       	call   3789 <open>
    1cf0:	83 c4 10             	add    $0x10,%esp
    1cf3:	85 c0                	test   %eax,%eax
    1cf5:	0f 89 59 03 00 00    	jns    2054 <subdir+0x58e>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1cfb:	83 ec 08             	sub    $0x8,%esp
    1cfe:	68 02 02 00 00       	push   $0x202
    1d03:	68 ee 43 00 00       	push   $0x43ee
    1d08:	e8 7c 1a 00 00       	call   3789 <open>
    1d0d:	83 c4 10             	add    $0x10,%esp
    1d10:	85 c0                	test   %eax,%eax
    1d12:	0f 89 50 03 00 00    	jns    2068 <subdir+0x5a2>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1d18:	83 ec 08             	sub    $0x8,%esp
    1d1b:	68 02 02 00 00       	push   $0x202
    1d20:	68 13 44 00 00       	push   $0x4413
    1d25:	e8 5f 1a 00 00       	call   3789 <open>
    1d2a:	83 c4 10             	add    $0x10,%esp
    1d2d:	85 c0                	test   %eax,%eax
    1d2f:	0f 89 47 03 00 00    	jns    207c <subdir+0x5b6>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1d35:	83 ec 08             	sub    $0x8,%esp
    1d38:	68 00 02 00 00       	push   $0x200
    1d3d:	68 a0 43 00 00       	push   $0x43a0
    1d42:	e8 42 1a 00 00       	call   3789 <open>
    1d47:	83 c4 10             	add    $0x10,%esp
    1d4a:	85 c0                	test   %eax,%eax
    1d4c:	0f 89 3e 03 00 00    	jns    2090 <subdir+0x5ca>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1d52:	83 ec 08             	sub    $0x8,%esp
    1d55:	6a 02                	push   $0x2
    1d57:	68 a0 43 00 00       	push   $0x43a0
    1d5c:	e8 28 1a 00 00       	call   3789 <open>
    1d61:	83 c4 10             	add    $0x10,%esp
    1d64:	85 c0                	test   %eax,%eax
    1d66:	0f 89 38 03 00 00    	jns    20a4 <subdir+0x5de>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1d6c:	83 ec 08             	sub    $0x8,%esp
    1d6f:	6a 01                	push   $0x1
    1d71:	68 a0 43 00 00       	push   $0x43a0
    1d76:	e8 0e 1a 00 00       	call   3789 <open>
    1d7b:	83 c4 10             	add    $0x10,%esp
    1d7e:	85 c0                	test   %eax,%eax
    1d80:	0f 89 32 03 00 00    	jns    20b8 <subdir+0x5f2>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1d86:	83 ec 08             	sub    $0x8,%esp
    1d89:	68 82 44 00 00       	push   $0x4482
    1d8e:	68 ee 43 00 00       	push   $0x43ee
    1d93:	e8 11 1a 00 00       	call   37a9 <link>
    1d98:	83 c4 10             	add    $0x10,%esp
    1d9b:	85 c0                	test   %eax,%eax
    1d9d:	0f 84 29 03 00 00    	je     20cc <subdir+0x606>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1da3:	83 ec 08             	sub    $0x8,%esp
    1da6:	68 82 44 00 00       	push   $0x4482
    1dab:	68 13 44 00 00       	push   $0x4413
    1db0:	e8 f4 19 00 00       	call   37a9 <link>
    1db5:	83 c4 10             	add    $0x10,%esp
    1db8:	85 c0                	test   %eax,%eax
    1dba:	0f 84 20 03 00 00    	je     20e0 <subdir+0x61a>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1dc0:	83 ec 08             	sub    $0x8,%esp
    1dc3:	68 3a 43 00 00       	push   $0x433a
    1dc8:	68 d9 42 00 00       	push   $0x42d9
    1dcd:	e8 d7 19 00 00       	call   37a9 <link>
    1dd2:	83 c4 10             	add    $0x10,%esp
    1dd5:	85 c0                	test   %eax,%eax
    1dd7:	0f 84 17 03 00 00    	je     20f4 <subdir+0x62e>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    1ddd:	83 ec 0c             	sub    $0xc,%esp
    1de0:	68 ee 43 00 00       	push   $0x43ee
    1de5:	e8 c7 19 00 00       	call   37b1 <mkdir>
    1dea:	83 c4 10             	add    $0x10,%esp
    1ded:	85 c0                	test   %eax,%eax
    1def:	0f 84 13 03 00 00    	je     2108 <subdir+0x642>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    1df5:	83 ec 0c             	sub    $0xc,%esp
    1df8:	68 13 44 00 00       	push   $0x4413
    1dfd:	e8 af 19 00 00       	call   37b1 <mkdir>
    1e02:	83 c4 10             	add    $0x10,%esp
    1e05:	85 c0                	test   %eax,%eax
    1e07:	0f 84 0f 03 00 00    	je     211c <subdir+0x656>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    1e0d:	83 ec 0c             	sub    $0xc,%esp
    1e10:	68 3a 43 00 00       	push   $0x433a
    1e15:	e8 97 19 00 00       	call   37b1 <mkdir>
    1e1a:	83 c4 10             	add    $0x10,%esp
    1e1d:	85 c0                	test   %eax,%eax
    1e1f:	0f 84 0b 03 00 00    	je     2130 <subdir+0x66a>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    1e25:	83 ec 0c             	sub    $0xc,%esp
    1e28:	68 13 44 00 00       	push   $0x4413
    1e2d:	e8 67 19 00 00       	call   3799 <unlink>
    1e32:	83 c4 10             	add    $0x10,%esp
    1e35:	85 c0                	test   %eax,%eax
    1e37:	0f 84 07 03 00 00    	je     2144 <subdir+0x67e>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    1e3d:	83 ec 0c             	sub    $0xc,%esp
    1e40:	68 ee 43 00 00       	push   $0x43ee
    1e45:	e8 4f 19 00 00       	call   3799 <unlink>
    1e4a:	83 c4 10             	add    $0x10,%esp
    1e4d:	85 c0                	test   %eax,%eax
    1e4f:	0f 84 03 03 00 00    	je     2158 <subdir+0x692>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    1e55:	83 ec 0c             	sub    $0xc,%esp
    1e58:	68 d9 42 00 00       	push   $0x42d9
    1e5d:	e8 57 19 00 00       	call   37b9 <chdir>
    1e62:	83 c4 10             	add    $0x10,%esp
    1e65:	85 c0                	test   %eax,%eax
    1e67:	0f 84 ff 02 00 00    	je     216c <subdir+0x6a6>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    1e6d:	83 ec 0c             	sub    $0xc,%esp
    1e70:	68 85 44 00 00       	push   $0x4485
    1e75:	e8 3f 19 00 00       	call   37b9 <chdir>
    1e7a:	83 c4 10             	add    $0x10,%esp
    1e7d:	85 c0                	test   %eax,%eax
    1e7f:	0f 84 fb 02 00 00    	je     2180 <subdir+0x6ba>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    1e85:	83 ec 0c             	sub    $0xc,%esp
    1e88:	68 3a 43 00 00       	push   $0x433a
    1e8d:	e8 07 19 00 00       	call   3799 <unlink>
    1e92:	83 c4 10             	add    $0x10,%esp
    1e95:	85 c0                	test   %eax,%eax
    1e97:	0f 85 f7 02 00 00    	jne    2194 <subdir+0x6ce>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1e9d:	83 ec 0c             	sub    $0xc,%esp
    1ea0:	68 d9 42 00 00       	push   $0x42d9
    1ea5:	e8 ef 18 00 00       	call   3799 <unlink>
    1eaa:	83 c4 10             	add    $0x10,%esp
    1ead:	85 c0                	test   %eax,%eax
    1eaf:	0f 85 f3 02 00 00    	jne    21a8 <subdir+0x6e2>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1eb5:	83 ec 0c             	sub    $0xc,%esp
    1eb8:	68 a0 43 00 00       	push   $0x43a0
    1ebd:	e8 d7 18 00 00       	call   3799 <unlink>
    1ec2:	83 c4 10             	add    $0x10,%esp
    1ec5:	85 c0                	test   %eax,%eax
    1ec7:	0f 84 ef 02 00 00    	je     21bc <subdir+0x6f6>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    1ecd:	83 ec 0c             	sub    $0xc,%esp
    1ed0:	68 b5 42 00 00       	push   $0x42b5
    1ed5:	e8 bf 18 00 00       	call   3799 <unlink>
    1eda:	83 c4 10             	add    $0x10,%esp
    1edd:	85 c0                	test   %eax,%eax
    1edf:	0f 88 eb 02 00 00    	js     21d0 <subdir+0x70a>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    1ee5:	83 ec 0c             	sub    $0xc,%esp
    1ee8:	68 a0 43 00 00       	push   $0x43a0
    1eed:	e8 a7 18 00 00       	call   3799 <unlink>
    1ef2:	83 c4 10             	add    $0x10,%esp
    1ef5:	85 c0                	test   %eax,%eax
    1ef7:	0f 88 e7 02 00 00    	js     21e4 <subdir+0x71e>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    1efd:	83 ec 08             	sub    $0x8,%esp
    1f00:	68 82 45 00 00       	push   $0x4582
    1f05:	6a 01                	push   $0x1
    1f07:	e8 7c 19 00 00       	call   3888 <printf>
}
    1f0c:	83 c4 10             	add    $0x10,%esp
    1f0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f12:	c9                   	leave  
    1f13:	c3                   	ret    
    printf(1, "subdir mkdir dd failed\n");
    1f14:	83 ec 08             	sub    $0x8,%esp
    1f17:	68 87 42 00 00       	push   $0x4287
    1f1c:	6a 01                	push   $0x1
    1f1e:	e8 65 19 00 00       	call   3888 <printf>
    exit();
    1f23:	e8 21 18 00 00       	call   3749 <exit>
    printf(1, "create dd/ff failed\n");
    1f28:	83 ec 08             	sub    $0x8,%esp
    1f2b:	68 9f 42 00 00       	push   $0x429f
    1f30:	6a 01                	push   $0x1
    1f32:	e8 51 19 00 00       	call   3888 <printf>
    exit();
    1f37:	e8 0d 18 00 00       	call   3749 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1f3c:	83 ec 08             	sub    $0x8,%esp
    1f3f:	68 6c 4d 00 00       	push   $0x4d6c
    1f44:	6a 01                	push   $0x1
    1f46:	e8 3d 19 00 00       	call   3888 <printf>
    exit();
    1f4b:	e8 f9 17 00 00       	call   3749 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    1f50:	83 ec 08             	sub    $0x8,%esp
    1f53:	68 bb 42 00 00       	push   $0x42bb
    1f58:	6a 01                	push   $0x1
    1f5a:	e8 29 19 00 00       	call   3888 <printf>
    exit();
    1f5f:	e8 e5 17 00 00       	call   3749 <exit>
    printf(1, "create dd/dd/ff failed\n");
    1f64:	83 ec 08             	sub    $0x8,%esp
    1f67:	68 df 42 00 00       	push   $0x42df
    1f6c:	6a 01                	push   $0x1
    1f6e:	e8 15 19 00 00       	call   3888 <printf>
    exit();
    1f73:	e8 d1 17 00 00       	call   3749 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    1f78:	83 ec 08             	sub    $0x8,%esp
    1f7b:	68 06 43 00 00       	push   $0x4306
    1f80:	6a 01                	push   $0x1
    1f82:	e8 01 19 00 00       	call   3888 <printf>
    exit();
    1f87:	e8 bd 17 00 00       	call   3749 <exit>
    printf(1, "dd/dd/../ff wrong content\n");
    1f8c:	83 ec 08             	sub    $0x8,%esp
    1f8f:	68 1f 43 00 00       	push   $0x431f
    1f94:	6a 01                	push   $0x1
    1f96:	e8 ed 18 00 00       	call   3888 <printf>
    exit();
    1f9b:	e8 a9 17 00 00       	call   3749 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1fa0:	83 ec 08             	sub    $0x8,%esp
    1fa3:	68 94 4d 00 00       	push   $0x4d94
    1fa8:	6a 01                	push   $0x1
    1faa:	e8 d9 18 00 00       	call   3888 <printf>
    exit();
    1faf:	e8 95 17 00 00       	call   3749 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    1fb4:	83 ec 08             	sub    $0x8,%esp
    1fb7:	68 45 43 00 00       	push   $0x4345
    1fbc:	6a 01                	push   $0x1
    1fbe:	e8 c5 18 00 00       	call   3888 <printf>
    exit();
    1fc3:	e8 81 17 00 00       	call   3749 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1fc8:	83 ec 08             	sub    $0x8,%esp
    1fcb:	68 b8 4d 00 00       	push   $0x4db8
    1fd0:	6a 01                	push   $0x1
    1fd2:	e8 b1 18 00 00       	call   3888 <printf>
    exit();
    1fd7:	e8 6d 17 00 00       	call   3749 <exit>
    printf(1, "chdir dd failed\n");
    1fdc:	83 ec 08             	sub    $0x8,%esp
    1fdf:	68 5d 43 00 00       	push   $0x435d
    1fe4:	6a 01                	push   $0x1
    1fe6:	e8 9d 18 00 00       	call   3888 <printf>
    exit();
    1feb:	e8 59 17 00 00       	call   3749 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    1ff0:	83 ec 08             	sub    $0x8,%esp
    1ff3:	68 7a 43 00 00       	push   $0x437a
    1ff8:	6a 01                	push   $0x1
    1ffa:	e8 89 18 00 00       	call   3888 <printf>
    exit();
    1fff:	e8 45 17 00 00       	call   3749 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    2004:	83 ec 08             	sub    $0x8,%esp
    2007:	68 7a 43 00 00       	push   $0x437a
    200c:	6a 01                	push   $0x1
    200e:	e8 75 18 00 00       	call   3888 <printf>
    exit();
    2013:	e8 31 17 00 00       	call   3749 <exit>
    printf(1, "chdir ./.. failed\n");
    2018:	83 ec 08             	sub    $0x8,%esp
    201b:	68 a8 43 00 00       	push   $0x43a8
    2020:	6a 01                	push   $0x1
    2022:	e8 61 18 00 00       	call   3888 <printf>
    exit();
    2027:	e8 1d 17 00 00       	call   3749 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    202c:	83 ec 08             	sub    $0x8,%esp
    202f:	68 bb 43 00 00       	push   $0x43bb
    2034:	6a 01                	push   $0x1
    2036:	e8 4d 18 00 00       	call   3888 <printf>
    exit();
    203b:	e8 09 17 00 00       	call   3749 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    2040:	83 ec 08             	sub    $0x8,%esp
    2043:	68 d3 43 00 00       	push   $0x43d3
    2048:	6a 01                	push   $0x1
    204a:	e8 39 18 00 00       	call   3888 <printf>
    exit();
    204f:	e8 f5 16 00 00       	call   3749 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2054:	83 ec 08             	sub    $0x8,%esp
    2057:	68 dc 4d 00 00       	push   $0x4ddc
    205c:	6a 01                	push   $0x1
    205e:	e8 25 18 00 00       	call   3888 <printf>
    exit();
    2063:	e8 e1 16 00 00       	call   3749 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    2068:	83 ec 08             	sub    $0x8,%esp
    206b:	68 f7 43 00 00       	push   $0x43f7
    2070:	6a 01                	push   $0x1
    2072:	e8 11 18 00 00       	call   3888 <printf>
    exit();
    2077:	e8 cd 16 00 00       	call   3749 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    207c:	83 ec 08             	sub    $0x8,%esp
    207f:	68 1c 44 00 00       	push   $0x441c
    2084:	6a 01                	push   $0x1
    2086:	e8 fd 17 00 00       	call   3888 <printf>
    exit();
    208b:	e8 b9 16 00 00       	call   3749 <exit>
    printf(1, "create dd succeeded!\n");
    2090:	83 ec 08             	sub    $0x8,%esp
    2093:	68 38 44 00 00       	push   $0x4438
    2098:	6a 01                	push   $0x1
    209a:	e8 e9 17 00 00       	call   3888 <printf>
    exit();
    209f:	e8 a5 16 00 00       	call   3749 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    20a4:	83 ec 08             	sub    $0x8,%esp
    20a7:	68 4e 44 00 00       	push   $0x444e
    20ac:	6a 01                	push   $0x1
    20ae:	e8 d5 17 00 00       	call   3888 <printf>
    exit();
    20b3:	e8 91 16 00 00       	call   3749 <exit>
    printf(1, "open dd wronly succeeded!\n");
    20b8:	83 ec 08             	sub    $0x8,%esp
    20bb:	68 67 44 00 00       	push   $0x4467
    20c0:	6a 01                	push   $0x1
    20c2:	e8 c1 17 00 00       	call   3888 <printf>
    exit();
    20c7:	e8 7d 16 00 00       	call   3749 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    20cc:	83 ec 08             	sub    $0x8,%esp
    20cf:	68 04 4e 00 00       	push   $0x4e04
    20d4:	6a 01                	push   $0x1
    20d6:	e8 ad 17 00 00       	call   3888 <printf>
    exit();
    20db:	e8 69 16 00 00       	call   3749 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    20e0:	83 ec 08             	sub    $0x8,%esp
    20e3:	68 28 4e 00 00       	push   $0x4e28
    20e8:	6a 01                	push   $0x1
    20ea:	e8 99 17 00 00       	call   3888 <printf>
    exit();
    20ef:	e8 55 16 00 00       	call   3749 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    20f4:	83 ec 08             	sub    $0x8,%esp
    20f7:	68 4c 4e 00 00       	push   $0x4e4c
    20fc:	6a 01                	push   $0x1
    20fe:	e8 85 17 00 00       	call   3888 <printf>
    exit();
    2103:	e8 41 16 00 00       	call   3749 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2108:	83 ec 08             	sub    $0x8,%esp
    210b:	68 8b 44 00 00       	push   $0x448b
    2110:	6a 01                	push   $0x1
    2112:	e8 71 17 00 00       	call   3888 <printf>
    exit();
    2117:	e8 2d 16 00 00       	call   3749 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    211c:	83 ec 08             	sub    $0x8,%esp
    211f:	68 a6 44 00 00       	push   $0x44a6
    2124:	6a 01                	push   $0x1
    2126:	e8 5d 17 00 00       	call   3888 <printf>
    exit();
    212b:	e8 19 16 00 00       	call   3749 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2130:	83 ec 08             	sub    $0x8,%esp
    2133:	68 c1 44 00 00       	push   $0x44c1
    2138:	6a 01                	push   $0x1
    213a:	e8 49 17 00 00       	call   3888 <printf>
    exit();
    213f:	e8 05 16 00 00       	call   3749 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2144:	83 ec 08             	sub    $0x8,%esp
    2147:	68 de 44 00 00       	push   $0x44de
    214c:	6a 01                	push   $0x1
    214e:	e8 35 17 00 00       	call   3888 <printf>
    exit();
    2153:	e8 f1 15 00 00       	call   3749 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2158:	83 ec 08             	sub    $0x8,%esp
    215b:	68 fa 44 00 00       	push   $0x44fa
    2160:	6a 01                	push   $0x1
    2162:	e8 21 17 00 00       	call   3888 <printf>
    exit();
    2167:	e8 dd 15 00 00       	call   3749 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    216c:	83 ec 08             	sub    $0x8,%esp
    216f:	68 16 45 00 00       	push   $0x4516
    2174:	6a 01                	push   $0x1
    2176:	e8 0d 17 00 00       	call   3888 <printf>
    exit();
    217b:	e8 c9 15 00 00       	call   3749 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2180:	83 ec 08             	sub    $0x8,%esp
    2183:	68 2e 45 00 00       	push   $0x452e
    2188:	6a 01                	push   $0x1
    218a:	e8 f9 16 00 00       	call   3888 <printf>
    exit();
    218f:	e8 b5 15 00 00       	call   3749 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    2194:	83 ec 08             	sub    $0x8,%esp
    2197:	68 45 43 00 00       	push   $0x4345
    219c:	6a 01                	push   $0x1
    219e:	e8 e5 16 00 00       	call   3888 <printf>
    exit();
    21a3:	e8 a1 15 00 00       	call   3749 <exit>
    printf(1, "unlink dd/ff failed\n");
    21a8:	83 ec 08             	sub    $0x8,%esp
    21ab:	68 46 45 00 00       	push   $0x4546
    21b0:	6a 01                	push   $0x1
    21b2:	e8 d1 16 00 00       	call   3888 <printf>
    exit();
    21b7:	e8 8d 15 00 00       	call   3749 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    21bc:	83 ec 08             	sub    $0x8,%esp
    21bf:	68 70 4e 00 00       	push   $0x4e70
    21c4:	6a 01                	push   $0x1
    21c6:	e8 bd 16 00 00       	call   3888 <printf>
    exit();
    21cb:	e8 79 15 00 00       	call   3749 <exit>
    printf(1, "unlink dd/dd failed\n");
    21d0:	83 ec 08             	sub    $0x8,%esp
    21d3:	68 5b 45 00 00       	push   $0x455b
    21d8:	6a 01                	push   $0x1
    21da:	e8 a9 16 00 00       	call   3888 <printf>
    exit();
    21df:	e8 65 15 00 00       	call   3749 <exit>
    printf(1, "unlink dd failed\n");
    21e4:	83 ec 08             	sub    $0x8,%esp
    21e7:	68 70 45 00 00       	push   $0x4570
    21ec:	6a 01                	push   $0x1
    21ee:	e8 95 16 00 00       	call   3888 <printf>
    exit();
    21f3:	e8 51 15 00 00       	call   3749 <exit>

000021f8 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    21f8:	f3 0f 1e fb          	endbr32 
    21fc:	55                   	push   %ebp
    21fd:	89 e5                	mov    %esp,%ebp
    21ff:	57                   	push   %edi
    2200:	56                   	push   %esi
    2201:	53                   	push   %ebx
    2202:	83 ec 14             	sub    $0x14,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    2205:	68 8d 45 00 00       	push   $0x458d
    220a:	6a 01                	push   $0x1
    220c:	e8 77 16 00 00       	call   3888 <printf>

  unlink("bigwrite");
    2211:	c7 04 24 9c 45 00 00 	movl   $0x459c,(%esp)
    2218:	e8 7c 15 00 00       	call   3799 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    221d:	83 c4 10             	add    $0x10,%esp
    2220:	be f3 01 00 00       	mov    $0x1f3,%esi
    2225:	eb 45                	jmp    226c <bigwrite+0x74>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    2227:	83 ec 08             	sub    $0x8,%esp
    222a:	68 a5 45 00 00       	push   $0x45a5
    222f:	6a 01                	push   $0x1
    2231:	e8 52 16 00 00       	call   3888 <printf>
      exit();
    2236:	e8 0e 15 00 00       	call   3749 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    223b:	50                   	push   %eax
    223c:	56                   	push   %esi
    223d:	68 bd 45 00 00       	push   $0x45bd
    2242:	6a 01                	push   $0x1
    2244:	e8 3f 16 00 00       	call   3888 <printf>
        exit();
    2249:	e8 fb 14 00 00       	call   3749 <exit>
      }
    }
    close(fd);
    224e:	83 ec 0c             	sub    $0xc,%esp
    2251:	57                   	push   %edi
    2252:	e8 1a 15 00 00       	call   3771 <close>
    unlink("bigwrite");
    2257:	c7 04 24 9c 45 00 00 	movl   $0x459c,(%esp)
    225e:	e8 36 15 00 00       	call   3799 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2263:	81 c6 d7 01 00 00    	add    $0x1d7,%esi
    2269:	83 c4 10             	add    $0x10,%esp
    226c:	81 fe ff 17 00 00    	cmp    $0x17ff,%esi
    2272:	7f 3e                	jg     22b2 <bigwrite+0xba>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2274:	83 ec 08             	sub    $0x8,%esp
    2277:	68 02 02 00 00       	push   $0x202
    227c:	68 9c 45 00 00       	push   $0x459c
    2281:	e8 03 15 00 00       	call   3789 <open>
    2286:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    2288:	83 c4 10             	add    $0x10,%esp
    228b:	85 c0                	test   %eax,%eax
    228d:	78 98                	js     2227 <bigwrite+0x2f>
    for(i = 0; i < 2; i++){
    228f:	bb 00 00 00 00       	mov    $0x0,%ebx
    2294:	83 fb 01             	cmp    $0x1,%ebx
    2297:	7f b5                	jg     224e <bigwrite+0x56>
      int cc = write(fd, buf, sz);
    2299:	83 ec 04             	sub    $0x4,%esp
    229c:	56                   	push   %esi
    229d:	68 60 83 00 00       	push   $0x8360
    22a2:	57                   	push   %edi
    22a3:	e8 c1 14 00 00       	call   3769 <write>
      if(cc != sz){
    22a8:	83 c4 10             	add    $0x10,%esp
    22ab:	39 c6                	cmp    %eax,%esi
    22ad:	75 8c                	jne    223b <bigwrite+0x43>
    for(i = 0; i < 2; i++){
    22af:	43                   	inc    %ebx
    22b0:	eb e2                	jmp    2294 <bigwrite+0x9c>
  }

  printf(1, "bigwrite ok\n");
    22b2:	83 ec 08             	sub    $0x8,%esp
    22b5:	68 cf 45 00 00       	push   $0x45cf
    22ba:	6a 01                	push   $0x1
    22bc:	e8 c7 15 00 00       	call   3888 <printf>
}
    22c1:	83 c4 10             	add    $0x10,%esp
    22c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    22c7:	5b                   	pop    %ebx
    22c8:	5e                   	pop    %esi
    22c9:	5f                   	pop    %edi
    22ca:	5d                   	pop    %ebp
    22cb:	c3                   	ret    

000022cc <bigfile>:

void
bigfile(void)
{
    22cc:	f3 0f 1e fb          	endbr32 
    22d0:	55                   	push   %ebp
    22d1:	89 e5                	mov    %esp,%ebp
    22d3:	57                   	push   %edi
    22d4:	56                   	push   %esi
    22d5:	53                   	push   %ebx
    22d6:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    22d9:	68 dc 45 00 00       	push   $0x45dc
    22de:	6a 01                	push   $0x1
    22e0:	e8 a3 15 00 00       	call   3888 <printf>

  unlink("bigfile");
    22e5:	c7 04 24 f8 45 00 00 	movl   $0x45f8,(%esp)
    22ec:	e8 a8 14 00 00       	call   3799 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    22f1:	83 c4 08             	add    $0x8,%esp
    22f4:	68 02 02 00 00       	push   $0x202
    22f9:	68 f8 45 00 00       	push   $0x45f8
    22fe:	e8 86 14 00 00       	call   3789 <open>
  if(fd < 0){
    2303:	83 c4 10             	add    $0x10,%esp
    2306:	85 c0                	test   %eax,%eax
    2308:	78 3f                	js     2349 <bigfile+0x7d>
    230a:	89 c6                	mov    %eax,%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    230c:	bb 00 00 00 00       	mov    $0x0,%ebx
    2311:	83 fb 13             	cmp    $0x13,%ebx
    2314:	7f 5b                	jg     2371 <bigfile+0xa5>
    memset(buf, i, 600);
    2316:	83 ec 04             	sub    $0x4,%esp
    2319:	68 58 02 00 00       	push   $0x258
    231e:	53                   	push   %ebx
    231f:	68 60 83 00 00       	push   $0x8360
    2324:	e8 e3 12 00 00       	call   360c <memset>
    if(write(fd, buf, 600) != 600){
    2329:	83 c4 0c             	add    $0xc,%esp
    232c:	68 58 02 00 00       	push   $0x258
    2331:	68 60 83 00 00       	push   $0x8360
    2336:	56                   	push   %esi
    2337:	e8 2d 14 00 00       	call   3769 <write>
    233c:	83 c4 10             	add    $0x10,%esp
    233f:	3d 58 02 00 00       	cmp    $0x258,%eax
    2344:	75 17                	jne    235d <bigfile+0x91>
  for(i = 0; i < 20; i++){
    2346:	43                   	inc    %ebx
    2347:	eb c8                	jmp    2311 <bigfile+0x45>
    printf(1, "cannot create bigfile");
    2349:	83 ec 08             	sub    $0x8,%esp
    234c:	68 ea 45 00 00       	push   $0x45ea
    2351:	6a 01                	push   $0x1
    2353:	e8 30 15 00 00       	call   3888 <printf>
    exit();
    2358:	e8 ec 13 00 00       	call   3749 <exit>
      printf(1, "write bigfile failed\n");
    235d:	83 ec 08             	sub    $0x8,%esp
    2360:	68 00 46 00 00       	push   $0x4600
    2365:	6a 01                	push   $0x1
    2367:	e8 1c 15 00 00       	call   3888 <printf>
      exit();
    236c:	e8 d8 13 00 00       	call   3749 <exit>
    }
  }
  close(fd);
    2371:	83 ec 0c             	sub    $0xc,%esp
    2374:	56                   	push   %esi
    2375:	e8 f7 13 00 00       	call   3771 <close>

  fd = open("bigfile", 0);
    237a:	83 c4 08             	add    $0x8,%esp
    237d:	6a 00                	push   $0x0
    237f:	68 f8 45 00 00       	push   $0x45f8
    2384:	e8 00 14 00 00       	call   3789 <open>
    2389:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    238b:	83 c4 10             	add    $0x10,%esp
    238e:	85 c0                	test   %eax,%eax
    2390:	78 51                	js     23e3 <bigfile+0x117>
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
    2392:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; ; i++){
    2397:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(fd, buf, 300);
    239c:	83 ec 04             	sub    $0x4,%esp
    239f:	68 2c 01 00 00       	push   $0x12c
    23a4:	68 60 83 00 00       	push   $0x8360
    23a9:	57                   	push   %edi
    23aa:	e8 b2 13 00 00       	call   3761 <read>
    if(cc < 0){
    23af:	83 c4 10             	add    $0x10,%esp
    23b2:	85 c0                	test   %eax,%eax
    23b4:	78 41                	js     23f7 <bigfile+0x12b>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    23b6:	74 7b                	je     2433 <bigfile+0x167>
      break;
    if(cc != 300){
    23b8:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    23bd:	75 4c                	jne    240b <bigfile+0x13f>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    23bf:	0f be 0d 60 83 00 00 	movsbl 0x8360,%ecx
    23c6:	89 da                	mov    %ebx,%edx
    23c8:	c1 ea 1f             	shr    $0x1f,%edx
    23cb:	01 da                	add    %ebx,%edx
    23cd:	d1 fa                	sar    %edx
    23cf:	39 d1                	cmp    %edx,%ecx
    23d1:	75 4c                	jne    241f <bigfile+0x153>
    23d3:	0f be 0d 8b 84 00 00 	movsbl 0x848b,%ecx
    23da:	39 ca                	cmp    %ecx,%edx
    23dc:	75 41                	jne    241f <bigfile+0x153>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    23de:	01 c6                	add    %eax,%esi
  for(i = 0; ; i++){
    23e0:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    23e1:	eb b9                	jmp    239c <bigfile+0xd0>
    printf(1, "cannot open bigfile\n");
    23e3:	83 ec 08             	sub    $0x8,%esp
    23e6:	68 16 46 00 00       	push   $0x4616
    23eb:	6a 01                	push   $0x1
    23ed:	e8 96 14 00 00       	call   3888 <printf>
    exit();
    23f2:	e8 52 13 00 00       	call   3749 <exit>
      printf(1, "read bigfile failed\n");
    23f7:	83 ec 08             	sub    $0x8,%esp
    23fa:	68 2b 46 00 00       	push   $0x462b
    23ff:	6a 01                	push   $0x1
    2401:	e8 82 14 00 00       	call   3888 <printf>
      exit();
    2406:	e8 3e 13 00 00       	call   3749 <exit>
      printf(1, "short read bigfile\n");
    240b:	83 ec 08             	sub    $0x8,%esp
    240e:	68 40 46 00 00       	push   $0x4640
    2413:	6a 01                	push   $0x1
    2415:	e8 6e 14 00 00       	call   3888 <printf>
      exit();
    241a:	e8 2a 13 00 00       	call   3749 <exit>
      printf(1, "read bigfile wrong data\n");
    241f:	83 ec 08             	sub    $0x8,%esp
    2422:	68 54 46 00 00       	push   $0x4654
    2427:	6a 01                	push   $0x1
    2429:	e8 5a 14 00 00       	call   3888 <printf>
      exit();
    242e:	e8 16 13 00 00       	call   3749 <exit>
  }
  close(fd);
    2433:	83 ec 0c             	sub    $0xc,%esp
    2436:	57                   	push   %edi
    2437:	e8 35 13 00 00       	call   3771 <close>
  if(total != 20*600){
    243c:	83 c4 10             	add    $0x10,%esp
    243f:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    2445:	75 27                	jne    246e <bigfile+0x1a2>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    2447:	83 ec 0c             	sub    $0xc,%esp
    244a:	68 f8 45 00 00       	push   $0x45f8
    244f:	e8 45 13 00 00       	call   3799 <unlink>

  printf(1, "bigfile test ok\n");
    2454:	83 c4 08             	add    $0x8,%esp
    2457:	68 87 46 00 00       	push   $0x4687
    245c:	6a 01                	push   $0x1
    245e:	e8 25 14 00 00       	call   3888 <printf>
}
    2463:	83 c4 10             	add    $0x10,%esp
    2466:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2469:	5b                   	pop    %ebx
    246a:	5e                   	pop    %esi
    246b:	5f                   	pop    %edi
    246c:	5d                   	pop    %ebp
    246d:	c3                   	ret    
    printf(1, "read bigfile wrong total\n");
    246e:	83 ec 08             	sub    $0x8,%esp
    2471:	68 6d 46 00 00       	push   $0x466d
    2476:	6a 01                	push   $0x1
    2478:	e8 0b 14 00 00       	call   3888 <printf>
    exit();
    247d:	e8 c7 12 00 00       	call   3749 <exit>

00002482 <fourteen>:

void
fourteen(void)
{
    2482:	f3 0f 1e fb          	endbr32 
    2486:	55                   	push   %ebp
    2487:	89 e5                	mov    %esp,%ebp
    2489:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    248c:	68 98 46 00 00       	push   $0x4698
    2491:	6a 01                	push   $0x1
    2493:	e8 f0 13 00 00       	call   3888 <printf>

  if(mkdir("12345678901234") != 0){
    2498:	c7 04 24 d3 46 00 00 	movl   $0x46d3,(%esp)
    249f:	e8 0d 13 00 00       	call   37b1 <mkdir>
    24a4:	83 c4 10             	add    $0x10,%esp
    24a7:	85 c0                	test   %eax,%eax
    24a9:	0f 85 9c 00 00 00    	jne    254b <fourteen+0xc9>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    24af:	83 ec 0c             	sub    $0xc,%esp
    24b2:	68 90 4e 00 00       	push   $0x4e90
    24b7:	e8 f5 12 00 00       	call   37b1 <mkdir>
    24bc:	83 c4 10             	add    $0x10,%esp
    24bf:	85 c0                	test   %eax,%eax
    24c1:	0f 85 98 00 00 00    	jne    255f <fourteen+0xdd>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    24c7:	83 ec 08             	sub    $0x8,%esp
    24ca:	68 00 02 00 00       	push   $0x200
    24cf:	68 e0 4e 00 00       	push   $0x4ee0
    24d4:	e8 b0 12 00 00       	call   3789 <open>
  if(fd < 0){
    24d9:	83 c4 10             	add    $0x10,%esp
    24dc:	85 c0                	test   %eax,%eax
    24de:	0f 88 8f 00 00 00    	js     2573 <fourteen+0xf1>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    24e4:	83 ec 0c             	sub    $0xc,%esp
    24e7:	50                   	push   %eax
    24e8:	e8 84 12 00 00       	call   3771 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    24ed:	83 c4 08             	add    $0x8,%esp
    24f0:	6a 00                	push   $0x0
    24f2:	68 50 4f 00 00       	push   $0x4f50
    24f7:	e8 8d 12 00 00       	call   3789 <open>
  if(fd < 0){
    24fc:	83 c4 10             	add    $0x10,%esp
    24ff:	85 c0                	test   %eax,%eax
    2501:	0f 88 80 00 00 00    	js     2587 <fourteen+0x105>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    2507:	83 ec 0c             	sub    $0xc,%esp
    250a:	50                   	push   %eax
    250b:	e8 61 12 00 00       	call   3771 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2510:	c7 04 24 c4 46 00 00 	movl   $0x46c4,(%esp)
    2517:	e8 95 12 00 00       	call   37b1 <mkdir>
    251c:	83 c4 10             	add    $0x10,%esp
    251f:	85 c0                	test   %eax,%eax
    2521:	74 78                	je     259b <fourteen+0x119>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2523:	83 ec 0c             	sub    $0xc,%esp
    2526:	68 ec 4f 00 00       	push   $0x4fec
    252b:	e8 81 12 00 00       	call   37b1 <mkdir>
    2530:	83 c4 10             	add    $0x10,%esp
    2533:	85 c0                	test   %eax,%eax
    2535:	74 78                	je     25af <fourteen+0x12d>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    2537:	83 ec 08             	sub    $0x8,%esp
    253a:	68 e2 46 00 00       	push   $0x46e2
    253f:	6a 01                	push   $0x1
    2541:	e8 42 13 00 00       	call   3888 <printf>
}
    2546:	83 c4 10             	add    $0x10,%esp
    2549:	c9                   	leave  
    254a:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    254b:	83 ec 08             	sub    $0x8,%esp
    254e:	68 a7 46 00 00       	push   $0x46a7
    2553:	6a 01                	push   $0x1
    2555:	e8 2e 13 00 00       	call   3888 <printf>
    exit();
    255a:	e8 ea 11 00 00       	call   3749 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    255f:	83 ec 08             	sub    $0x8,%esp
    2562:	68 b0 4e 00 00       	push   $0x4eb0
    2567:	6a 01                	push   $0x1
    2569:	e8 1a 13 00 00       	call   3888 <printf>
    exit();
    256e:	e8 d6 11 00 00       	call   3749 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2573:	83 ec 08             	sub    $0x8,%esp
    2576:	68 10 4f 00 00       	push   $0x4f10
    257b:	6a 01                	push   $0x1
    257d:	e8 06 13 00 00       	call   3888 <printf>
    exit();
    2582:	e8 c2 11 00 00       	call   3749 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2587:	83 ec 08             	sub    $0x8,%esp
    258a:	68 80 4f 00 00       	push   $0x4f80
    258f:	6a 01                	push   $0x1
    2591:	e8 f2 12 00 00       	call   3888 <printf>
    exit();
    2596:	e8 ae 11 00 00       	call   3749 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    259b:	83 ec 08             	sub    $0x8,%esp
    259e:	68 bc 4f 00 00       	push   $0x4fbc
    25a3:	6a 01                	push   $0x1
    25a5:	e8 de 12 00 00       	call   3888 <printf>
    exit();
    25aa:	e8 9a 11 00 00       	call   3749 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    25af:	83 ec 08             	sub    $0x8,%esp
    25b2:	68 0c 50 00 00       	push   $0x500c
    25b7:	6a 01                	push   $0x1
    25b9:	e8 ca 12 00 00       	call   3888 <printf>
    exit();
    25be:	e8 86 11 00 00       	call   3749 <exit>

000025c3 <rmdot>:

void
rmdot(void)
{
    25c3:	f3 0f 1e fb          	endbr32 
    25c7:	55                   	push   %ebp
    25c8:	89 e5                	mov    %esp,%ebp
    25ca:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    25cd:	68 ef 46 00 00       	push   $0x46ef
    25d2:	6a 01                	push   $0x1
    25d4:	e8 af 12 00 00       	call   3888 <printf>
  if(mkdir("dots") != 0){
    25d9:	c7 04 24 fb 46 00 00 	movl   $0x46fb,(%esp)
    25e0:	e8 cc 11 00 00       	call   37b1 <mkdir>
    25e5:	83 c4 10             	add    $0x10,%esp
    25e8:	85 c0                	test   %eax,%eax
    25ea:	0f 85 bc 00 00 00    	jne    26ac <rmdot+0xe9>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    25f0:	83 ec 0c             	sub    $0xc,%esp
    25f3:	68 fb 46 00 00       	push   $0x46fb
    25f8:	e8 bc 11 00 00       	call   37b9 <chdir>
    25fd:	83 c4 10             	add    $0x10,%esp
    2600:	85 c0                	test   %eax,%eax
    2602:	0f 85 b8 00 00 00    	jne    26c0 <rmdot+0xfd>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2608:	83 ec 0c             	sub    $0xc,%esp
    260b:	68 a6 43 00 00       	push   $0x43a6
    2610:	e8 84 11 00 00       	call   3799 <unlink>
    2615:	83 c4 10             	add    $0x10,%esp
    2618:	85 c0                	test   %eax,%eax
    261a:	0f 84 b4 00 00 00    	je     26d4 <rmdot+0x111>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2620:	83 ec 0c             	sub    $0xc,%esp
    2623:	68 a5 43 00 00       	push   $0x43a5
    2628:	e8 6c 11 00 00       	call   3799 <unlink>
    262d:	83 c4 10             	add    $0x10,%esp
    2630:	85 c0                	test   %eax,%eax
    2632:	0f 84 b0 00 00 00    	je     26e8 <rmdot+0x125>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    2638:	83 ec 0c             	sub    $0xc,%esp
    263b:	68 7f 3b 00 00       	push   $0x3b7f
    2640:	e8 74 11 00 00       	call   37b9 <chdir>
    2645:	83 c4 10             	add    $0x10,%esp
    2648:	85 c0                	test   %eax,%eax
    264a:	0f 85 ac 00 00 00    	jne    26fc <rmdot+0x139>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    2650:	83 ec 0c             	sub    $0xc,%esp
    2653:	68 43 47 00 00       	push   $0x4743
    2658:	e8 3c 11 00 00       	call   3799 <unlink>
    265d:	83 c4 10             	add    $0x10,%esp
    2660:	85 c0                	test   %eax,%eax
    2662:	0f 84 a8 00 00 00    	je     2710 <rmdot+0x14d>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    2668:	83 ec 0c             	sub    $0xc,%esp
    266b:	68 61 47 00 00       	push   $0x4761
    2670:	e8 24 11 00 00       	call   3799 <unlink>
    2675:	83 c4 10             	add    $0x10,%esp
    2678:	85 c0                	test   %eax,%eax
    267a:	0f 84 a4 00 00 00    	je     2724 <rmdot+0x161>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    2680:	83 ec 0c             	sub    $0xc,%esp
    2683:	68 fb 46 00 00       	push   $0x46fb
    2688:	e8 0c 11 00 00       	call   3799 <unlink>
    268d:	83 c4 10             	add    $0x10,%esp
    2690:	85 c0                	test   %eax,%eax
    2692:	0f 85 a0 00 00 00    	jne    2738 <rmdot+0x175>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    2698:	83 ec 08             	sub    $0x8,%esp
    269b:	68 96 47 00 00       	push   $0x4796
    26a0:	6a 01                	push   $0x1
    26a2:	e8 e1 11 00 00       	call   3888 <printf>
}
    26a7:	83 c4 10             	add    $0x10,%esp
    26aa:	c9                   	leave  
    26ab:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    26ac:	83 ec 08             	sub    $0x8,%esp
    26af:	68 00 47 00 00       	push   $0x4700
    26b4:	6a 01                	push   $0x1
    26b6:	e8 cd 11 00 00       	call   3888 <printf>
    exit();
    26bb:	e8 89 10 00 00       	call   3749 <exit>
    printf(1, "chdir dots failed\n");
    26c0:	83 ec 08             	sub    $0x8,%esp
    26c3:	68 13 47 00 00       	push   $0x4713
    26c8:	6a 01                	push   $0x1
    26ca:	e8 b9 11 00 00       	call   3888 <printf>
    exit();
    26cf:	e8 75 10 00 00       	call   3749 <exit>
    printf(1, "rm . worked!\n");
    26d4:	83 ec 08             	sub    $0x8,%esp
    26d7:	68 26 47 00 00       	push   $0x4726
    26dc:	6a 01                	push   $0x1
    26de:	e8 a5 11 00 00       	call   3888 <printf>
    exit();
    26e3:	e8 61 10 00 00       	call   3749 <exit>
    printf(1, "rm .. worked!\n");
    26e8:	83 ec 08             	sub    $0x8,%esp
    26eb:	68 34 47 00 00       	push   $0x4734
    26f0:	6a 01                	push   $0x1
    26f2:	e8 91 11 00 00       	call   3888 <printf>
    exit();
    26f7:	e8 4d 10 00 00       	call   3749 <exit>
    printf(1, "chdir / failed\n");
    26fc:	83 ec 08             	sub    $0x8,%esp
    26ff:	68 81 3b 00 00       	push   $0x3b81
    2704:	6a 01                	push   $0x1
    2706:	e8 7d 11 00 00       	call   3888 <printf>
    exit();
    270b:	e8 39 10 00 00       	call   3749 <exit>
    printf(1, "unlink dots/. worked!\n");
    2710:	83 ec 08             	sub    $0x8,%esp
    2713:	68 4a 47 00 00       	push   $0x474a
    2718:	6a 01                	push   $0x1
    271a:	e8 69 11 00 00       	call   3888 <printf>
    exit();
    271f:	e8 25 10 00 00       	call   3749 <exit>
    printf(1, "unlink dots/.. worked!\n");
    2724:	83 ec 08             	sub    $0x8,%esp
    2727:	68 69 47 00 00       	push   $0x4769
    272c:	6a 01                	push   $0x1
    272e:	e8 55 11 00 00       	call   3888 <printf>
    exit();
    2733:	e8 11 10 00 00       	call   3749 <exit>
    printf(1, "unlink dots failed!\n");
    2738:	83 ec 08             	sub    $0x8,%esp
    273b:	68 81 47 00 00       	push   $0x4781
    2740:	6a 01                	push   $0x1
    2742:	e8 41 11 00 00       	call   3888 <printf>
    exit();
    2747:	e8 fd 0f 00 00       	call   3749 <exit>

0000274c <dirfile>:

void
dirfile(void)
{
    274c:	f3 0f 1e fb          	endbr32 
    2750:	55                   	push   %ebp
    2751:	89 e5                	mov    %esp,%ebp
    2753:	53                   	push   %ebx
    2754:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    2757:	68 a0 47 00 00       	push   $0x47a0
    275c:	6a 01                	push   $0x1
    275e:	e8 25 11 00 00       	call   3888 <printf>

  fd = open("dirfile", O_CREATE);
    2763:	83 c4 08             	add    $0x8,%esp
    2766:	68 00 02 00 00       	push   $0x200
    276b:	68 ad 47 00 00       	push   $0x47ad
    2770:	e8 14 10 00 00       	call   3789 <open>
  if(fd < 0){
    2775:	83 c4 10             	add    $0x10,%esp
    2778:	85 c0                	test   %eax,%eax
    277a:	0f 88 22 01 00 00    	js     28a2 <dirfile+0x156>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    2780:	83 ec 0c             	sub    $0xc,%esp
    2783:	50                   	push   %eax
    2784:	e8 e8 0f 00 00       	call   3771 <close>
  if(chdir("dirfile") == 0){
    2789:	c7 04 24 ad 47 00 00 	movl   $0x47ad,(%esp)
    2790:	e8 24 10 00 00       	call   37b9 <chdir>
    2795:	83 c4 10             	add    $0x10,%esp
    2798:	85 c0                	test   %eax,%eax
    279a:	0f 84 16 01 00 00    	je     28b6 <dirfile+0x16a>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    27a0:	83 ec 08             	sub    $0x8,%esp
    27a3:	6a 00                	push   $0x0
    27a5:	68 e6 47 00 00       	push   $0x47e6
    27aa:	e8 da 0f 00 00       	call   3789 <open>
  if(fd >= 0){
    27af:	83 c4 10             	add    $0x10,%esp
    27b2:	85 c0                	test   %eax,%eax
    27b4:	0f 89 10 01 00 00    	jns    28ca <dirfile+0x17e>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    27ba:	83 ec 08             	sub    $0x8,%esp
    27bd:	68 00 02 00 00       	push   $0x200
    27c2:	68 e6 47 00 00       	push   $0x47e6
    27c7:	e8 bd 0f 00 00       	call   3789 <open>
  if(fd >= 0){
    27cc:	83 c4 10             	add    $0x10,%esp
    27cf:	85 c0                	test   %eax,%eax
    27d1:	0f 89 07 01 00 00    	jns    28de <dirfile+0x192>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    27d7:	83 ec 0c             	sub    $0xc,%esp
    27da:	68 e6 47 00 00       	push   $0x47e6
    27df:	e8 cd 0f 00 00       	call   37b1 <mkdir>
    27e4:	83 c4 10             	add    $0x10,%esp
    27e7:	85 c0                	test   %eax,%eax
    27e9:	0f 84 03 01 00 00    	je     28f2 <dirfile+0x1a6>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    27ef:	83 ec 0c             	sub    $0xc,%esp
    27f2:	68 e6 47 00 00       	push   $0x47e6
    27f7:	e8 9d 0f 00 00       	call   3799 <unlink>
    27fc:	83 c4 10             	add    $0x10,%esp
    27ff:	85 c0                	test   %eax,%eax
    2801:	0f 84 ff 00 00 00    	je     2906 <dirfile+0x1ba>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2807:	83 ec 08             	sub    $0x8,%esp
    280a:	68 e6 47 00 00       	push   $0x47e6
    280f:	68 4a 48 00 00       	push   $0x484a
    2814:	e8 90 0f 00 00       	call   37a9 <link>
    2819:	83 c4 10             	add    $0x10,%esp
    281c:	85 c0                	test   %eax,%eax
    281e:	0f 84 f6 00 00 00    	je     291a <dirfile+0x1ce>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    2824:	83 ec 0c             	sub    $0xc,%esp
    2827:	68 ad 47 00 00       	push   $0x47ad
    282c:	e8 68 0f 00 00       	call   3799 <unlink>
    2831:	83 c4 10             	add    $0x10,%esp
    2834:	85 c0                	test   %eax,%eax
    2836:	0f 85 f2 00 00 00    	jne    292e <dirfile+0x1e2>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    283c:	83 ec 08             	sub    $0x8,%esp
    283f:	6a 02                	push   $0x2
    2841:	68 a6 43 00 00       	push   $0x43a6
    2846:	e8 3e 0f 00 00       	call   3789 <open>
  if(fd >= 0){
    284b:	83 c4 10             	add    $0x10,%esp
    284e:	85 c0                	test   %eax,%eax
    2850:	0f 89 ec 00 00 00    	jns    2942 <dirfile+0x1f6>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2856:	83 ec 08             	sub    $0x8,%esp
    2859:	6a 00                	push   $0x0
    285b:	68 a6 43 00 00       	push   $0x43a6
    2860:	e8 24 0f 00 00       	call   3789 <open>
    2865:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2867:	83 c4 0c             	add    $0xc,%esp
    286a:	6a 01                	push   $0x1
    286c:	68 89 44 00 00       	push   $0x4489
    2871:	50                   	push   %eax
    2872:	e8 f2 0e 00 00       	call   3769 <write>
    2877:	83 c4 10             	add    $0x10,%esp
    287a:	85 c0                	test   %eax,%eax
    287c:	0f 8f d4 00 00 00    	jg     2956 <dirfile+0x20a>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2882:	83 ec 0c             	sub    $0xc,%esp
    2885:	53                   	push   %ebx
    2886:	e8 e6 0e 00 00       	call   3771 <close>

  printf(1, "dir vs file OK\n");
    288b:	83 c4 08             	add    $0x8,%esp
    288e:	68 7d 48 00 00       	push   $0x487d
    2893:	6a 01                	push   $0x1
    2895:	e8 ee 0f 00 00       	call   3888 <printf>
}
    289a:	83 c4 10             	add    $0x10,%esp
    289d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    28a0:	c9                   	leave  
    28a1:	c3                   	ret    
    printf(1, "create dirfile failed\n");
    28a2:	83 ec 08             	sub    $0x8,%esp
    28a5:	68 b5 47 00 00       	push   $0x47b5
    28aa:	6a 01                	push   $0x1
    28ac:	e8 d7 0f 00 00       	call   3888 <printf>
    exit();
    28b1:	e8 93 0e 00 00       	call   3749 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    28b6:	83 ec 08             	sub    $0x8,%esp
    28b9:	68 cc 47 00 00       	push   $0x47cc
    28be:	6a 01                	push   $0x1
    28c0:	e8 c3 0f 00 00       	call   3888 <printf>
    exit();
    28c5:	e8 7f 0e 00 00       	call   3749 <exit>
    printf(1, "create dirfile/xx succeeded!\n");
    28ca:	83 ec 08             	sub    $0x8,%esp
    28cd:	68 f1 47 00 00       	push   $0x47f1
    28d2:	6a 01                	push   $0x1
    28d4:	e8 af 0f 00 00       	call   3888 <printf>
    exit();
    28d9:	e8 6b 0e 00 00       	call   3749 <exit>
    printf(1, "create dirfile/xx succeeded!\n");
    28de:	83 ec 08             	sub    $0x8,%esp
    28e1:	68 f1 47 00 00       	push   $0x47f1
    28e6:	6a 01                	push   $0x1
    28e8:	e8 9b 0f 00 00       	call   3888 <printf>
    exit();
    28ed:	e8 57 0e 00 00       	call   3749 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    28f2:	83 ec 08             	sub    $0x8,%esp
    28f5:	68 0f 48 00 00       	push   $0x480f
    28fa:	6a 01                	push   $0x1
    28fc:	e8 87 0f 00 00       	call   3888 <printf>
    exit();
    2901:	e8 43 0e 00 00       	call   3749 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2906:	83 ec 08             	sub    $0x8,%esp
    2909:	68 2c 48 00 00       	push   $0x482c
    290e:	6a 01                	push   $0x1
    2910:	e8 73 0f 00 00       	call   3888 <printf>
    exit();
    2915:	e8 2f 0e 00 00       	call   3749 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    291a:	83 ec 08             	sub    $0x8,%esp
    291d:	68 40 50 00 00       	push   $0x5040
    2922:	6a 01                	push   $0x1
    2924:	e8 5f 0f 00 00       	call   3888 <printf>
    exit();
    2929:	e8 1b 0e 00 00       	call   3749 <exit>
    printf(1, "unlink dirfile failed!\n");
    292e:	83 ec 08             	sub    $0x8,%esp
    2931:	68 51 48 00 00       	push   $0x4851
    2936:	6a 01                	push   $0x1
    2938:	e8 4b 0f 00 00       	call   3888 <printf>
    exit();
    293d:	e8 07 0e 00 00       	call   3749 <exit>
    printf(1, "open . for writing succeeded!\n");
    2942:	83 ec 08             	sub    $0x8,%esp
    2945:	68 60 50 00 00       	push   $0x5060
    294a:	6a 01                	push   $0x1
    294c:	e8 37 0f 00 00       	call   3888 <printf>
    exit();
    2951:	e8 f3 0d 00 00       	call   3749 <exit>
    printf(1, "write . succeeded!\n");
    2956:	83 ec 08             	sub    $0x8,%esp
    2959:	68 69 48 00 00       	push   $0x4869
    295e:	6a 01                	push   $0x1
    2960:	e8 23 0f 00 00       	call   3888 <printf>
    exit();
    2965:	e8 df 0d 00 00       	call   3749 <exit>

0000296a <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    296a:	f3 0f 1e fb          	endbr32 
    296e:	55                   	push   %ebp
    296f:	89 e5                	mov    %esp,%ebp
    2971:	53                   	push   %ebx
    2972:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2975:	68 8d 48 00 00       	push   $0x488d
    297a:	6a 01                	push   $0x1
    297c:	e8 07 0f 00 00       	call   3888 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2981:	83 c4 10             	add    $0x10,%esp
    2984:	bb 00 00 00 00       	mov    $0x0,%ebx
    2989:	eb 47                	jmp    29d2 <iref+0x68>
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    298b:	83 ec 08             	sub    $0x8,%esp
    298e:	68 a4 48 00 00       	push   $0x48a4
    2993:	6a 01                	push   $0x1
    2995:	e8 ee 0e 00 00       	call   3888 <printf>
      exit();
    299a:	e8 aa 0d 00 00       	call   3749 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    299f:	83 ec 08             	sub    $0x8,%esp
    29a2:	68 b8 48 00 00       	push   $0x48b8
    29a7:	6a 01                	push   $0x1
    29a9:	e8 da 0e 00 00       	call   3888 <printf>
      exit();
    29ae:	e8 96 0d 00 00       	call   3749 <exit>

    mkdir("");
    link("README", "");
    fd = open("", O_CREATE);
    if(fd >= 0)
      close(fd);
    29b3:	83 ec 0c             	sub    $0xc,%esp
    29b6:	50                   	push   %eax
    29b7:	e8 b5 0d 00 00       	call   3771 <close>
    29bc:	83 c4 10             	add    $0x10,%esp
    29bf:	eb 7e                	jmp    2a3f <iref+0xd5>
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
    29c1:	83 ec 0c             	sub    $0xc,%esp
    29c4:	68 88 44 00 00       	push   $0x4488
    29c9:	e8 cb 0d 00 00       	call   3799 <unlink>
  for(i = 0; i < 50 + 1; i++){
    29ce:	43                   	inc    %ebx
    29cf:	83 c4 10             	add    $0x10,%esp
    29d2:	83 fb 32             	cmp    $0x32,%ebx
    29d5:	0f 8f 92 00 00 00    	jg     2a6d <iref+0x103>
    if(mkdir("irefd") != 0){
    29db:	83 ec 0c             	sub    $0xc,%esp
    29de:	68 9e 48 00 00       	push   $0x489e
    29e3:	e8 c9 0d 00 00       	call   37b1 <mkdir>
    29e8:	83 c4 10             	add    $0x10,%esp
    29eb:	85 c0                	test   %eax,%eax
    29ed:	75 9c                	jne    298b <iref+0x21>
    if(chdir("irefd") != 0){
    29ef:	83 ec 0c             	sub    $0xc,%esp
    29f2:	68 9e 48 00 00       	push   $0x489e
    29f7:	e8 bd 0d 00 00       	call   37b9 <chdir>
    29fc:	83 c4 10             	add    $0x10,%esp
    29ff:	85 c0                	test   %eax,%eax
    2a01:	75 9c                	jne    299f <iref+0x35>
    mkdir("");
    2a03:	83 ec 0c             	sub    $0xc,%esp
    2a06:	68 59 3f 00 00       	push   $0x3f59
    2a0b:	e8 a1 0d 00 00       	call   37b1 <mkdir>
    link("README", "");
    2a10:	83 c4 08             	add    $0x8,%esp
    2a13:	68 59 3f 00 00       	push   $0x3f59
    2a18:	68 4a 48 00 00       	push   $0x484a
    2a1d:	e8 87 0d 00 00       	call   37a9 <link>
    fd = open("", O_CREATE);
    2a22:	83 c4 08             	add    $0x8,%esp
    2a25:	68 00 02 00 00       	push   $0x200
    2a2a:	68 59 3f 00 00       	push   $0x3f59
    2a2f:	e8 55 0d 00 00       	call   3789 <open>
    if(fd >= 0)
    2a34:	83 c4 10             	add    $0x10,%esp
    2a37:	85 c0                	test   %eax,%eax
    2a39:	0f 89 74 ff ff ff    	jns    29b3 <iref+0x49>
    fd = open("xx", O_CREATE);
    2a3f:	83 ec 08             	sub    $0x8,%esp
    2a42:	68 00 02 00 00       	push   $0x200
    2a47:	68 88 44 00 00       	push   $0x4488
    2a4c:	e8 38 0d 00 00       	call   3789 <open>
    if(fd >= 0)
    2a51:	83 c4 10             	add    $0x10,%esp
    2a54:	85 c0                	test   %eax,%eax
    2a56:	0f 88 65 ff ff ff    	js     29c1 <iref+0x57>
      close(fd);
    2a5c:	83 ec 0c             	sub    $0xc,%esp
    2a5f:	50                   	push   %eax
    2a60:	e8 0c 0d 00 00       	call   3771 <close>
    2a65:	83 c4 10             	add    $0x10,%esp
    2a68:	e9 54 ff ff ff       	jmp    29c1 <iref+0x57>
  }

  chdir("/");
    2a6d:	83 ec 0c             	sub    $0xc,%esp
    2a70:	68 7f 3b 00 00       	push   $0x3b7f
    2a75:	e8 3f 0d 00 00       	call   37b9 <chdir>
  printf(1, "empty file name OK\n");
    2a7a:	83 c4 08             	add    $0x8,%esp
    2a7d:	68 cc 48 00 00       	push   $0x48cc
    2a82:	6a 01                	push   $0x1
    2a84:	e8 ff 0d 00 00       	call   3888 <printf>
}
    2a89:	83 c4 10             	add    $0x10,%esp
    2a8c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a8f:	c9                   	leave  
    2a90:	c3                   	ret    

00002a91 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2a91:	f3 0f 1e fb          	endbr32 
    2a95:	55                   	push   %ebp
    2a96:	89 e5                	mov    %esp,%ebp
    2a98:	53                   	push   %ebx
    2a99:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    2a9c:	68 e0 48 00 00       	push   $0x48e0
    2aa1:	6a 01                	push   $0x1
    2aa3:	e8 e0 0d 00 00       	call   3888 <printf>

  for(n=0; n<1000; n++){
    2aa8:	83 c4 10             	add    $0x10,%esp
    2aab:	bb 00 00 00 00       	mov    $0x0,%ebx
    2ab0:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
    2ab6:	7f 13                	jg     2acb <forktest+0x3a>
    pid = fork();
    2ab8:	e8 84 0c 00 00       	call   3741 <fork>
    if(pid < 0)
    2abd:	85 c0                	test   %eax,%eax
    2abf:	78 0a                	js     2acb <forktest+0x3a>
      break;
    if(pid == 0)
    2ac1:	74 03                	je     2ac6 <forktest+0x35>
  for(n=0; n<1000; n++){
    2ac3:	43                   	inc    %ebx
    2ac4:	eb ea                	jmp    2ab0 <forktest+0x1f>
      exit();
    2ac6:	e8 7e 0c 00 00       	call   3749 <exit>
  }

  if(n == 1000){
    2acb:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2ad1:	74 10                	je     2ae3 <forktest+0x52>
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2ad3:	85 db                	test   %ebx,%ebx
    2ad5:	7e 34                	jle    2b0b <forktest+0x7a>
    if(wait() < 0){
    2ad7:	e8 75 0c 00 00       	call   3751 <wait>
    2adc:	85 c0                	test   %eax,%eax
    2ade:	78 17                	js     2af7 <forktest+0x66>
  for(; n > 0; n--){
    2ae0:	4b                   	dec    %ebx
    2ae1:	eb f0                	jmp    2ad3 <forktest+0x42>
    printf(1, "fork claimed to work 1000 times!\n");
    2ae3:	83 ec 08             	sub    $0x8,%esp
    2ae6:	68 80 50 00 00       	push   $0x5080
    2aeb:	6a 01                	push   $0x1
    2aed:	e8 96 0d 00 00       	call   3888 <printf>
    exit();
    2af2:	e8 52 0c 00 00       	call   3749 <exit>
      printf(1, "wait stopped early\n");
    2af7:	83 ec 08             	sub    $0x8,%esp
    2afa:	68 eb 48 00 00       	push   $0x48eb
    2aff:	6a 01                	push   $0x1
    2b01:	e8 82 0d 00 00       	call   3888 <printf>
      exit();
    2b06:	e8 3e 0c 00 00       	call   3749 <exit>
    }
  }

  if(wait() != -1){
    2b0b:	e8 41 0c 00 00       	call   3751 <wait>
    2b10:	83 f8 ff             	cmp    $0xffffffff,%eax
    2b13:	75 17                	jne    2b2c <forktest+0x9b>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    2b15:	83 ec 08             	sub    $0x8,%esp
    2b18:	68 12 49 00 00       	push   $0x4912
    2b1d:	6a 01                	push   $0x1
    2b1f:	e8 64 0d 00 00       	call   3888 <printf>
}
    2b24:	83 c4 10             	add    $0x10,%esp
    2b27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2b2a:	c9                   	leave  
    2b2b:	c3                   	ret    
    printf(1, "wait got too many\n");
    2b2c:	83 ec 08             	sub    $0x8,%esp
    2b2f:	68 ff 48 00 00       	push   $0x48ff
    2b34:	6a 01                	push   $0x1
    2b36:	e8 4d 0d 00 00       	call   3888 <printf>
    exit();
    2b3b:	e8 09 0c 00 00       	call   3749 <exit>

00002b40 <sbrktest>:

void
sbrktest(void)
{
    2b40:	f3 0f 1e fb          	endbr32 
    2b44:	55                   	push   %ebp
    2b45:	89 e5                	mov    %esp,%ebp
    2b47:	57                   	push   %edi
    2b48:	56                   	push   %esi
    2b49:	53                   	push   %ebx
    2b4a:	83 ec 54             	sub    $0x54,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2b4d:	68 20 49 00 00       	push   $0x4920
    2b52:	ff 35 80 5b 00 00    	pushl  0x5b80
    2b58:	e8 2b 0d 00 00       	call   3888 <printf>
  oldbrk = sbrk(0);
    2b5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b64:	e8 68 0c 00 00       	call   37d1 <sbrk>
    2b69:	89 c7                	mov    %eax,%edi

  // can one sbrk() less than a page?
  a = sbrk(0);
    2b6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b72:	e8 5a 0c 00 00       	call   37d1 <sbrk>
    2b77:	89 c6                	mov    %eax,%esi
  int i;
  for(i = 0; i < 5000; i++){
    2b79:	83 c4 10             	add    $0x10,%esp
    2b7c:	bb 00 00 00 00       	mov    $0x0,%ebx
    2b81:	81 fb 87 13 00 00    	cmp    $0x1387,%ebx
    2b87:	7f 38                	jg     2bc1 <sbrktest+0x81>
    b = sbrk(1);
    2b89:	83 ec 0c             	sub    $0xc,%esp
    2b8c:	6a 01                	push   $0x1
    2b8e:	e8 3e 0c 00 00       	call   37d1 <sbrk>
    if(b != a){
    2b93:	83 c4 10             	add    $0x10,%esp
    2b96:	39 c6                	cmp    %eax,%esi
    2b98:	75 09                	jne    2ba3 <sbrktest+0x63>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    2b9a:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    2b9d:	8d 70 01             	lea    0x1(%eax),%esi
  for(i = 0; i < 5000; i++){
    2ba0:	43                   	inc    %ebx
    2ba1:	eb de                	jmp    2b81 <sbrktest+0x41>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2ba3:	83 ec 0c             	sub    $0xc,%esp
    2ba6:	50                   	push   %eax
    2ba7:	56                   	push   %esi
    2ba8:	53                   	push   %ebx
    2ba9:	68 2b 49 00 00       	push   $0x492b
    2bae:	ff 35 80 5b 00 00    	pushl  0x5b80
    2bb4:	e8 cf 0c 00 00       	call   3888 <printf>
      exit();
    2bb9:	83 c4 20             	add    $0x20,%esp
    2bbc:	e8 88 0b 00 00       	call   3749 <exit>
  }
  pid = fork();
    2bc1:	e8 7b 0b 00 00       	call   3741 <fork>
    2bc6:	89 c3                	mov    %eax,%ebx
  if(pid < 0){
    2bc8:	85 c0                	test   %eax,%eax
    2bca:	0f 88 4f 01 00 00    	js     2d1f <sbrktest+0x1df>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2bd0:	83 ec 0c             	sub    $0xc,%esp
    2bd3:	6a 01                	push   $0x1
    2bd5:	e8 f7 0b 00 00       	call   37d1 <sbrk>
  c = sbrk(1);
    2bda:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2be1:	e8 eb 0b 00 00       	call   37d1 <sbrk>
  if(c != a + 1){
    2be6:	46                   	inc    %esi
    2be7:	83 c4 10             	add    $0x10,%esp
    2bea:	39 c6                	cmp    %eax,%esi
    2bec:	0f 85 45 01 00 00    	jne    2d37 <sbrktest+0x1f7>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    2bf2:	85 db                	test   %ebx,%ebx
    2bf4:	0f 84 55 01 00 00    	je     2d4f <sbrktest+0x20f>
    exit();
  wait();
    2bfa:	e8 52 0b 00 00       	call   3751 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2bff:	83 ec 0c             	sub    $0xc,%esp
    2c02:	6a 00                	push   $0x0
    2c04:	e8 c8 0b 00 00       	call   37d1 <sbrk>
    2c09:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2c0b:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2c10:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2c12:	89 04 24             	mov    %eax,(%esp)
    2c15:	e8 b7 0b 00 00       	call   37d1 <sbrk>
  if (p != a) {
    2c1a:	83 c4 10             	add    $0x10,%esp
    2c1d:	39 c3                	cmp    %eax,%ebx
    2c1f:	0f 85 2f 01 00 00    	jne    2d54 <sbrktest+0x214>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2c25:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2c2c:	83 ec 0c             	sub    $0xc,%esp
    2c2f:	6a 00                	push   $0x0
    2c31:	e8 9b 0b 00 00       	call   37d1 <sbrk>
    2c36:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2c38:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2c3f:	e8 8d 0b 00 00       	call   37d1 <sbrk>
  if(c == (char*)0xffffffff){
    2c44:	83 c4 10             	add    $0x10,%esp
    2c47:	83 f8 ff             	cmp    $0xffffffff,%eax
    2c4a:	0f 84 1c 01 00 00    	je     2d6c <sbrktest+0x22c>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    2c50:	83 ec 0c             	sub    $0xc,%esp
    2c53:	6a 00                	push   $0x0
    2c55:	e8 77 0b 00 00       	call   37d1 <sbrk>
  if(c != a - 4096){
    2c5a:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2c60:	83 c4 10             	add    $0x10,%esp
    2c63:	39 c2                	cmp    %eax,%edx
    2c65:	0f 85 19 01 00 00    	jne    2d84 <sbrktest+0x244>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2c6b:	83 ec 0c             	sub    $0xc,%esp
    2c6e:	6a 00                	push   $0x0
    2c70:	e8 5c 0b 00 00       	call   37d1 <sbrk>
    2c75:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2c77:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2c7e:	e8 4e 0b 00 00       	call   37d1 <sbrk>
    2c83:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2c85:	83 c4 10             	add    $0x10,%esp
    2c88:	39 c3                	cmp    %eax,%ebx
    2c8a:	0f 85 0b 01 00 00    	jne    2d9b <sbrktest+0x25b>
    2c90:	83 ec 0c             	sub    $0xc,%esp
    2c93:	6a 00                	push   $0x0
    2c95:	e8 37 0b 00 00       	call   37d1 <sbrk>
    2c9a:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2ca0:	83 c4 10             	add    $0x10,%esp
    2ca3:	39 c2                	cmp    %eax,%edx
    2ca5:	0f 85 f0 00 00 00    	jne    2d9b <sbrktest+0x25b>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    2cab:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2cb2:	0f 84 fa 00 00 00    	je     2db2 <sbrktest+0x272>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2cb8:	83 ec 0c             	sub    $0xc,%esp
    2cbb:	6a 00                	push   $0x0
    2cbd:	e8 0f 0b 00 00       	call   37d1 <sbrk>
    2cc2:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2cc4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ccb:	e8 01 0b 00 00       	call   37d1 <sbrk>
    2cd0:	89 f9                	mov    %edi,%ecx
    2cd2:	29 c1                	sub    %eax,%ecx
    2cd4:	89 0c 24             	mov    %ecx,(%esp)
    2cd7:	e8 f5 0a 00 00       	call   37d1 <sbrk>
  if(c != a){
    2cdc:	83 c4 10             	add    $0x10,%esp
    2cdf:	39 c3                	cmp    %eax,%ebx
    2ce1:	0f 85 e3 00 00 00    	jne    2dca <sbrktest+0x28a>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ce7:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2cec:	81 fb 7f 84 1e 80    	cmp    $0x801e847f,%ebx
    2cf2:	0f 87 23 01 00 00    	ja     2e1b <sbrktest+0x2db>
    ppid = getpid();
    2cf8:	e8 cc 0a 00 00       	call   37c9 <getpid>
    2cfd:	89 c6                	mov    %eax,%esi
    pid = fork();
    2cff:	e8 3d 0a 00 00       	call   3741 <fork>
    if(pid < 0){
    2d04:	85 c0                	test   %eax,%eax
    2d06:	0f 88 d5 00 00 00    	js     2de1 <sbrktest+0x2a1>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    2d0c:	0f 84 e7 00 00 00    	je     2df9 <sbrktest+0x2b9>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    2d12:	e8 3a 0a 00 00       	call   3751 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2d17:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2d1d:	eb cd                	jmp    2cec <sbrktest+0x1ac>
    printf(stdout, "sbrk test fork failed\n");
    2d1f:	83 ec 08             	sub    $0x8,%esp
    2d22:	68 46 49 00 00       	push   $0x4946
    2d27:	ff 35 80 5b 00 00    	pushl  0x5b80
    2d2d:	e8 56 0b 00 00       	call   3888 <printf>
    exit();
    2d32:	e8 12 0a 00 00       	call   3749 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    2d37:	83 ec 08             	sub    $0x8,%esp
    2d3a:	68 5d 49 00 00       	push   $0x495d
    2d3f:	ff 35 80 5b 00 00    	pushl  0x5b80
    2d45:	e8 3e 0b 00 00       	call   3888 <printf>
    exit();
    2d4a:	e8 fa 09 00 00       	call   3749 <exit>
    exit();
    2d4f:	e8 f5 09 00 00       	call   3749 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2d54:	83 ec 08             	sub    $0x8,%esp
    2d57:	68 a4 50 00 00       	push   $0x50a4
    2d5c:	ff 35 80 5b 00 00    	pushl  0x5b80
    2d62:	e8 21 0b 00 00       	call   3888 <printf>
    exit();
    2d67:	e8 dd 09 00 00       	call   3749 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    2d6c:	83 ec 08             	sub    $0x8,%esp
    2d6f:	68 79 49 00 00       	push   $0x4979
    2d74:	ff 35 80 5b 00 00    	pushl  0x5b80
    2d7a:	e8 09 0b 00 00       	call   3888 <printf>
    exit();
    2d7f:	e8 c5 09 00 00       	call   3749 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2d84:	50                   	push   %eax
    2d85:	53                   	push   %ebx
    2d86:	68 e4 50 00 00       	push   $0x50e4
    2d8b:	ff 35 80 5b 00 00    	pushl  0x5b80
    2d91:	e8 f2 0a 00 00       	call   3888 <printf>
    exit();
    2d96:	e8 ae 09 00 00       	call   3749 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    2d9b:	56                   	push   %esi
    2d9c:	53                   	push   %ebx
    2d9d:	68 1c 51 00 00       	push   $0x511c
    2da2:	ff 35 80 5b 00 00    	pushl  0x5b80
    2da8:	e8 db 0a 00 00       	call   3888 <printf>
    exit();
    2dad:	e8 97 09 00 00       	call   3749 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    2db2:	83 ec 08             	sub    $0x8,%esp
    2db5:	68 44 51 00 00       	push   $0x5144
    2dba:	ff 35 80 5b 00 00    	pushl  0x5b80
    2dc0:	e8 c3 0a 00 00       	call   3888 <printf>
    exit();
    2dc5:	e8 7f 09 00 00       	call   3749 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    2dca:	50                   	push   %eax
    2dcb:	53                   	push   %ebx
    2dcc:	68 74 51 00 00       	push   $0x5174
    2dd1:	ff 35 80 5b 00 00    	pushl  0x5b80
    2dd7:	e8 ac 0a 00 00       	call   3888 <printf>
    exit();
    2ddc:	e8 68 09 00 00       	call   3749 <exit>
      printf(stdout, "fork failed\n");
    2de1:	83 ec 08             	sub    $0x8,%esp
    2de4:	68 71 4a 00 00       	push   $0x4a71
    2de9:	ff 35 80 5b 00 00    	pushl  0x5b80
    2def:	e8 94 0a 00 00       	call   3888 <printf>
      exit();
    2df4:	e8 50 09 00 00       	call   3749 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    2df9:	0f be 03             	movsbl (%ebx),%eax
    2dfc:	50                   	push   %eax
    2dfd:	53                   	push   %ebx
    2dfe:	68 94 49 00 00       	push   $0x4994
    2e03:	ff 35 80 5b 00 00    	pushl  0x5b80
    2e09:	e8 7a 0a 00 00       	call   3888 <printf>
      kill(ppid);
    2e0e:	89 34 24             	mov    %esi,(%esp)
    2e11:	e8 63 09 00 00       	call   3779 <kill>
      exit();
    2e16:	e8 2e 09 00 00       	call   3749 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    2e1b:	83 ec 0c             	sub    $0xc,%esp
    2e1e:	8d 45 e0             	lea    -0x20(%ebp),%eax
    2e21:	50                   	push   %eax
    2e22:	e8 32 09 00 00       	call   3759 <pipe>
    2e27:	89 c3                	mov    %eax,%ebx
    2e29:	83 c4 10             	add    $0x10,%esp
    2e2c:	85 c0                	test   %eax,%eax
    2e2e:	75 04                	jne    2e34 <sbrktest+0x2f4>
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2e30:	89 c6                	mov    %eax,%esi
    2e32:	eb 57                	jmp    2e8b <sbrktest+0x34b>
    printf(1, "pipe() failed\n");
    2e34:	83 ec 08             	sub    $0x8,%esp
    2e37:	68 6f 3e 00 00       	push   $0x3e6f
    2e3c:	6a 01                	push   $0x1
    2e3e:	e8 45 0a 00 00       	call   3888 <printf>
    exit();
    2e43:	e8 01 09 00 00       	call   3749 <exit>
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    2e48:	83 ec 0c             	sub    $0xc,%esp
    2e4b:	6a 00                	push   $0x0
    2e4d:	e8 7f 09 00 00       	call   37d1 <sbrk>
    2e52:	89 c2                	mov    %eax,%edx
    2e54:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e59:	29 d0                	sub    %edx,%eax
    2e5b:	89 04 24             	mov    %eax,(%esp)
    2e5e:	e8 6e 09 00 00       	call   37d1 <sbrk>
      write(fds[1], "x", 1);
    2e63:	83 c4 0c             	add    $0xc,%esp
    2e66:	6a 01                	push   $0x1
    2e68:	68 89 44 00 00       	push   $0x4489
    2e6d:	ff 75 e4             	pushl  -0x1c(%ebp)
    2e70:	e8 f4 08 00 00       	call   3769 <write>
    2e75:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    2e78:	83 ec 0c             	sub    $0xc,%esp
    2e7b:	68 e8 03 00 00       	push   $0x3e8
    2e80:	e8 54 09 00 00       	call   37d9 <sleep>
    2e85:	83 c4 10             	add    $0x10,%esp
    2e88:	eb ee                	jmp    2e78 <sbrktest+0x338>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2e8a:	46                   	inc    %esi
    2e8b:	83 fe 09             	cmp    $0x9,%esi
    2e8e:	77 28                	ja     2eb8 <sbrktest+0x378>
    if((pids[i] = fork()) == 0){
    2e90:	e8 ac 08 00 00       	call   3741 <fork>
    2e95:	89 44 b5 b8          	mov    %eax,-0x48(%ebp,%esi,4)
    2e99:	85 c0                	test   %eax,%eax
    2e9b:	74 ab                	je     2e48 <sbrktest+0x308>
    }
    if(pids[i] != -1)
    2e9d:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ea0:	74 e8                	je     2e8a <sbrktest+0x34a>
      read(fds[0], &scratch, 1);
    2ea2:	83 ec 04             	sub    $0x4,%esp
    2ea5:	6a 01                	push   $0x1
    2ea7:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2eaa:	50                   	push   %eax
    2eab:	ff 75 e0             	pushl  -0x20(%ebp)
    2eae:	e8 ae 08 00 00       	call   3761 <read>
    2eb3:	83 c4 10             	add    $0x10,%esp
    2eb6:	eb d2                	jmp    2e8a <sbrktest+0x34a>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    2eb8:	83 ec 0c             	sub    $0xc,%esp
    2ebb:	68 00 10 00 00       	push   $0x1000
    2ec0:	e8 0c 09 00 00       	call   37d1 <sbrk>
    2ec5:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2ec7:	83 c4 10             	add    $0x10,%esp
    2eca:	eb 01                	jmp    2ecd <sbrktest+0x38d>
    2ecc:	43                   	inc    %ebx
    2ecd:	83 fb 09             	cmp    $0x9,%ebx
    2ed0:	77 1c                	ja     2eee <sbrktest+0x3ae>
    if(pids[i] == -1)
    2ed2:	8b 44 9d b8          	mov    -0x48(%ebp,%ebx,4),%eax
    2ed6:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ed9:	74 f1                	je     2ecc <sbrktest+0x38c>
      continue;
    kill(pids[i]);
    2edb:	83 ec 0c             	sub    $0xc,%esp
    2ede:	50                   	push   %eax
    2edf:	e8 95 08 00 00       	call   3779 <kill>
    wait();
    2ee4:	e8 68 08 00 00       	call   3751 <wait>
    2ee9:	83 c4 10             	add    $0x10,%esp
    2eec:	eb de                	jmp    2ecc <sbrktest+0x38c>
  }
  if(c == (char*)0xffffffff){
    2eee:	83 fe ff             	cmp    $0xffffffff,%esi
    2ef1:	74 2f                	je     2f22 <sbrktest+0x3e2>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    2ef3:	83 ec 0c             	sub    $0xc,%esp
    2ef6:	6a 00                	push   $0x0
    2ef8:	e8 d4 08 00 00       	call   37d1 <sbrk>
    2efd:	83 c4 10             	add    $0x10,%esp
    2f00:	39 c7                	cmp    %eax,%edi
    2f02:	72 36                	jb     2f3a <sbrktest+0x3fa>
    sbrk(-(sbrk(0) - oldbrk));

  printf(stdout, "sbrk test OK\n");
    2f04:	83 ec 08             	sub    $0x8,%esp
    2f07:	68 c8 49 00 00       	push   $0x49c8
    2f0c:	ff 35 80 5b 00 00    	pushl  0x5b80
    2f12:	e8 71 09 00 00       	call   3888 <printf>
}
    2f17:	83 c4 10             	add    $0x10,%esp
    2f1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2f1d:	5b                   	pop    %ebx
    2f1e:	5e                   	pop    %esi
    2f1f:	5f                   	pop    %edi
    2f20:	5d                   	pop    %ebp
    2f21:	c3                   	ret    
    printf(stdout, "failed sbrk leaked memory\n");
    2f22:	83 ec 08             	sub    $0x8,%esp
    2f25:	68 ad 49 00 00       	push   $0x49ad
    2f2a:	ff 35 80 5b 00 00    	pushl  0x5b80
    2f30:	e8 53 09 00 00       	call   3888 <printf>
    exit();
    2f35:	e8 0f 08 00 00       	call   3749 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    2f3a:	83 ec 0c             	sub    $0xc,%esp
    2f3d:	6a 00                	push   $0x0
    2f3f:	e8 8d 08 00 00       	call   37d1 <sbrk>
    2f44:	29 c7                	sub    %eax,%edi
    2f46:	89 3c 24             	mov    %edi,(%esp)
    2f49:	e8 83 08 00 00       	call   37d1 <sbrk>
    2f4e:	83 c4 10             	add    $0x10,%esp
    2f51:	eb b1                	jmp    2f04 <sbrktest+0x3c4>

00002f53 <validateint>:

void
validateint(int *p)
{
    2f53:	f3 0f 1e fb          	endbr32 
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    2f57:	c3                   	ret    

00002f58 <validatetest>:

void
validatetest(void)
{
    2f58:	f3 0f 1e fb          	endbr32 
    2f5c:	55                   	push   %ebp
    2f5d:	89 e5                	mov    %esp,%ebp
    2f5f:	56                   	push   %esi
    2f60:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    2f61:	83 ec 08             	sub    $0x8,%esp
    2f64:	68 d6 49 00 00       	push   $0x49d6
    2f69:	ff 35 80 5b 00 00    	pushl  0x5b80
    2f6f:	e8 14 09 00 00       	call   3888 <printf>
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    2f74:	83 c4 10             	add    $0x10,%esp
    2f77:	be 00 00 00 00       	mov    $0x0,%esi
    2f7c:	eb 0b                	jmp    2f89 <validatetest+0x31>
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    2f7e:	e8 c6 07 00 00       	call   3749 <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    2f83:	81 c6 00 10 00 00    	add    $0x1000,%esi
    2f89:	81 fe 00 30 11 00    	cmp    $0x113000,%esi
    2f8f:	77 5c                	ja     2fed <validatetest+0x95>
    if((pid = fork()) == 0){
    2f91:	e8 ab 07 00 00       	call   3741 <fork>
    2f96:	89 c3                	mov    %eax,%ebx
    2f98:	85 c0                	test   %eax,%eax
    2f9a:	74 e2                	je     2f7e <validatetest+0x26>
    }
    sleep(0);
    2f9c:	83 ec 0c             	sub    $0xc,%esp
    2f9f:	6a 00                	push   $0x0
    2fa1:	e8 33 08 00 00       	call   37d9 <sleep>
    sleep(0);
    2fa6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fad:	e8 27 08 00 00       	call   37d9 <sleep>
    kill(pid);
    2fb2:	89 1c 24             	mov    %ebx,(%esp)
    2fb5:	e8 bf 07 00 00       	call   3779 <kill>
    wait();
    2fba:	e8 92 07 00 00       	call   3751 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    2fbf:	83 c4 08             	add    $0x8,%esp
    2fc2:	56                   	push   %esi
    2fc3:	68 e5 49 00 00       	push   $0x49e5
    2fc8:	e8 dc 07 00 00       	call   37a9 <link>
    2fcd:	83 c4 10             	add    $0x10,%esp
    2fd0:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fd3:	74 ae                	je     2f83 <validatetest+0x2b>
      printf(stdout, "link should not succeed\n");
    2fd5:	83 ec 08             	sub    $0x8,%esp
    2fd8:	68 f0 49 00 00       	push   $0x49f0
    2fdd:	ff 35 80 5b 00 00    	pushl  0x5b80
    2fe3:	e8 a0 08 00 00       	call   3888 <printf>
      exit();
    2fe8:	e8 5c 07 00 00       	call   3749 <exit>
    }
  }

  printf(stdout, "validate ok\n");
    2fed:	83 ec 08             	sub    $0x8,%esp
    2ff0:	68 09 4a 00 00       	push   $0x4a09
    2ff5:	ff 35 80 5b 00 00    	pushl  0x5b80
    2ffb:	e8 88 08 00 00       	call   3888 <printf>
}
    3000:	83 c4 10             	add    $0x10,%esp
    3003:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3006:	5b                   	pop    %ebx
    3007:	5e                   	pop    %esi
    3008:	5d                   	pop    %ebp
    3009:	c3                   	ret    

0000300a <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    300a:	f3 0f 1e fb          	endbr32 
    300e:	55                   	push   %ebp
    300f:	89 e5                	mov    %esp,%ebp
    3011:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    3014:	68 16 4a 00 00       	push   $0x4a16
    3019:	ff 35 80 5b 00 00    	pushl  0x5b80
    301f:	e8 64 08 00 00       	call   3888 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    3024:	83 c4 10             	add    $0x10,%esp
    3027:	b8 00 00 00 00       	mov    $0x0,%eax
    302c:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3031:	77 24                	ja     3057 <bsstest+0x4d>
    if(uninit[i] != '\0'){
    3033:	80 b8 40 5c 00 00 00 	cmpb   $0x0,0x5c40(%eax)
    303a:	75 03                	jne    303f <bsstest+0x35>
  for(i = 0; i < sizeof(uninit); i++){
    303c:	40                   	inc    %eax
    303d:	eb ed                	jmp    302c <bsstest+0x22>
      printf(stdout, "bss test failed\n");
    303f:	83 ec 08             	sub    $0x8,%esp
    3042:	68 20 4a 00 00       	push   $0x4a20
    3047:	ff 35 80 5b 00 00    	pushl  0x5b80
    304d:	e8 36 08 00 00       	call   3888 <printf>
      exit();
    3052:	e8 f2 06 00 00       	call   3749 <exit>
    }
  }
  printf(stdout, "bss test ok\n");
    3057:	83 ec 08             	sub    $0x8,%esp
    305a:	68 31 4a 00 00       	push   $0x4a31
    305f:	ff 35 80 5b 00 00    	pushl  0x5b80
    3065:	e8 1e 08 00 00       	call   3888 <printf>
}
    306a:	83 c4 10             	add    $0x10,%esp
    306d:	c9                   	leave  
    306e:	c3                   	ret    

0000306f <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    306f:	f3 0f 1e fb          	endbr32 
    3073:	55                   	push   %ebp
    3074:	89 e5                	mov    %esp,%ebp
    3076:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3079:	68 3e 4a 00 00       	push   $0x4a3e
    307e:	e8 16 07 00 00       	call   3799 <unlink>
  pid = fork();
    3083:	e8 b9 06 00 00       	call   3741 <fork>
  if(pid == 0){
    3088:	83 c4 10             	add    $0x10,%esp
    308b:	85 c0                	test   %eax,%eax
    308d:	74 4b                	je     30da <bigargtest+0x6b>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    308f:	0f 88 ab 00 00 00    	js     3140 <bigargtest+0xd1>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    3095:	e8 b7 06 00 00       	call   3751 <wait>
  fd = open("bigarg-ok", 0);
    309a:	83 ec 08             	sub    $0x8,%esp
    309d:	6a 00                	push   $0x0
    309f:	68 3e 4a 00 00       	push   $0x4a3e
    30a4:	e8 e0 06 00 00       	call   3789 <open>
  if(fd < 0){
    30a9:	83 c4 10             	add    $0x10,%esp
    30ac:	85 c0                	test   %eax,%eax
    30ae:	0f 88 a4 00 00 00    	js     3158 <bigargtest+0xe9>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    30b4:	83 ec 0c             	sub    $0xc,%esp
    30b7:	50                   	push   %eax
    30b8:	e8 b4 06 00 00       	call   3771 <close>
  unlink("bigarg-ok");
    30bd:	c7 04 24 3e 4a 00 00 	movl   $0x4a3e,(%esp)
    30c4:	e8 d0 06 00 00       	call   3799 <unlink>
}
    30c9:	83 c4 10             	add    $0x10,%esp
    30cc:	c9                   	leave  
    30cd:	c3                   	ret    
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    30ce:	c7 04 85 a0 5b 00 00 	movl   $0x5198,0x5ba0(,%eax,4)
    30d5:	98 51 00 00 
    for(i = 0; i < MAXARG-1; i++)
    30d9:	40                   	inc    %eax
    30da:	83 f8 1e             	cmp    $0x1e,%eax
    30dd:	7e ef                	jle    30ce <bigargtest+0x5f>
    args[MAXARG-1] = 0;
    30df:	c7 05 1c 5c 00 00 00 	movl   $0x0,0x5c1c
    30e6:	00 00 00 
    printf(stdout, "bigarg test\n");
    30e9:	83 ec 08             	sub    $0x8,%esp
    30ec:	68 48 4a 00 00       	push   $0x4a48
    30f1:	ff 35 80 5b 00 00    	pushl  0x5b80
    30f7:	e8 8c 07 00 00       	call   3888 <printf>
    exec("echo", args);
    30fc:	83 c4 08             	add    $0x8,%esp
    30ff:	68 a0 5b 00 00       	push   $0x5ba0
    3104:	68 1b 3c 00 00       	push   $0x3c1b
    3109:	e8 73 06 00 00       	call   3781 <exec>
    printf(stdout, "bigarg test ok\n");
    310e:	83 c4 08             	add    $0x8,%esp
    3111:	68 55 4a 00 00       	push   $0x4a55
    3116:	ff 35 80 5b 00 00    	pushl  0x5b80
    311c:	e8 67 07 00 00       	call   3888 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3121:	83 c4 08             	add    $0x8,%esp
    3124:	68 00 02 00 00       	push   $0x200
    3129:	68 3e 4a 00 00       	push   $0x4a3e
    312e:	e8 56 06 00 00       	call   3789 <open>
    close(fd);
    3133:	89 04 24             	mov    %eax,(%esp)
    3136:	e8 36 06 00 00       	call   3771 <close>
    exit();
    313b:	e8 09 06 00 00       	call   3749 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3140:	83 ec 08             	sub    $0x8,%esp
    3143:	68 65 4a 00 00       	push   $0x4a65
    3148:	ff 35 80 5b 00 00    	pushl  0x5b80
    314e:	e8 35 07 00 00       	call   3888 <printf>
    exit();
    3153:	e8 f1 05 00 00       	call   3749 <exit>
    printf(stdout, "bigarg test failed!\n");
    3158:	83 ec 08             	sub    $0x8,%esp
    315b:	68 7e 4a 00 00       	push   $0x4a7e
    3160:	ff 35 80 5b 00 00    	pushl  0x5b80
    3166:	e8 1d 07 00 00       	call   3888 <printf>
    exit();
    316b:	e8 d9 05 00 00       	call   3749 <exit>

00003170 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3170:	f3 0f 1e fb          	endbr32 
    3174:	55                   	push   %ebp
    3175:	89 e5                	mov    %esp,%ebp
    3177:	57                   	push   %edi
    3178:	56                   	push   %esi
    3179:	53                   	push   %ebx
    317a:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    317d:	68 93 4a 00 00       	push   $0x4a93
    3182:	6a 01                	push   $0x1
    3184:	e8 ff 06 00 00       	call   3888 <printf>
    3189:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    318c:	bb 00 00 00 00       	mov    $0x0,%ebx
    char name[64];
    name[0] = 'f';
    3191:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3195:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    319a:	f7 eb                	imul   %ebx
    319c:	89 d0                	mov    %edx,%eax
    319e:	c1 f8 06             	sar    $0x6,%eax
    31a1:	89 de                	mov    %ebx,%esi
    31a3:	c1 fe 1f             	sar    $0x1f,%esi
    31a6:	29 f0                	sub    %esi,%eax
    31a8:	8d 50 30             	lea    0x30(%eax),%edx
    31ab:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    31ae:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31b1:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31b4:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31b7:	c1 e0 03             	shl    $0x3,%eax
    31ba:	89 df                	mov    %ebx,%edi
    31bc:	29 c7                	sub    %eax,%edi
    31be:	b9 1f 85 eb 51       	mov    $0x51eb851f,%ecx
    31c3:	89 f8                	mov    %edi,%eax
    31c5:	f7 e9                	imul   %ecx
    31c7:	c1 fa 05             	sar    $0x5,%edx
    31ca:	c1 ff 1f             	sar    $0x1f,%edi
    31cd:	29 fa                	sub    %edi,%edx
    31cf:	83 c2 30             	add    $0x30,%edx
    31d2:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    31d5:	89 c8                	mov    %ecx,%eax
    31d7:	f7 eb                	imul   %ebx
    31d9:	89 d1                	mov    %edx,%ecx
    31db:	c1 f9 05             	sar    $0x5,%ecx
    31de:	29 f1                	sub    %esi,%ecx
    31e0:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
    31e3:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31e6:	c1 e0 02             	shl    $0x2,%eax
    31e9:	89 d9                	mov    %ebx,%ecx
    31eb:	29 c1                	sub    %eax,%ecx
    31ed:	bf 67 66 66 66       	mov    $0x66666667,%edi
    31f2:	89 c8                	mov    %ecx,%eax
    31f4:	f7 ef                	imul   %edi
    31f6:	89 d0                	mov    %edx,%eax
    31f8:	c1 f8 02             	sar    $0x2,%eax
    31fb:	c1 f9 1f             	sar    $0x1f,%ecx
    31fe:	29 c8                	sub    %ecx,%eax
    3200:	83 c0 30             	add    $0x30,%eax
    3203:	88 45 ab             	mov    %al,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3206:	89 f8                	mov    %edi,%eax
    3208:	f7 eb                	imul   %ebx
    320a:	89 d0                	mov    %edx,%eax
    320c:	c1 f8 02             	sar    $0x2,%eax
    320f:	29 f0                	sub    %esi,%eax
    3211:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3214:	01 c0                	add    %eax,%eax
    3216:	89 de                	mov    %ebx,%esi
    3218:	29 c6                	sub    %eax,%esi
    321a:	89 f0                	mov    %esi,%eax
    321c:	83 c0 30             	add    $0x30,%eax
    321f:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    3222:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    3226:	83 ec 04             	sub    $0x4,%esp
    3229:	8d 75 a8             	lea    -0x58(%ebp),%esi
    322c:	56                   	push   %esi
    322d:	68 a0 4a 00 00       	push   $0x4aa0
    3232:	6a 01                	push   $0x1
    3234:	e8 4f 06 00 00       	call   3888 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3239:	83 c4 08             	add    $0x8,%esp
    323c:	68 02 02 00 00       	push   $0x202
    3241:	56                   	push   %esi
    3242:	e8 42 05 00 00       	call   3789 <open>
    3247:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    3249:	83 c4 10             	add    $0x10,%esp
    324c:	85 c0                	test   %eax,%eax
    324e:	79 1b                	jns    326b <fsfull+0xfb>
      printf(1, "open %s failed\n", name);
    3250:	83 ec 04             	sub    $0x4,%esp
    3253:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3256:	50                   	push   %eax
    3257:	68 ac 4a 00 00       	push   $0x4aac
    325c:	6a 01                	push   $0x1
    325e:	e8 25 06 00 00       	call   3888 <printf>
      break;
    3263:	83 c4 10             	add    $0x10,%esp
    3266:	e9 f4 00 00 00       	jmp    335f <fsfull+0x1ef>
    }
    int total = 0;
    326b:	bf 00 00 00 00       	mov    $0x0,%edi
    while(1){
      int cc = write(fd, buf, 512);
    3270:	83 ec 04             	sub    $0x4,%esp
    3273:	68 00 02 00 00       	push   $0x200
    3278:	68 60 83 00 00       	push   $0x8360
    327d:	56                   	push   %esi
    327e:	e8 e6 04 00 00       	call   3769 <write>
      if(cc < 512)
    3283:	83 c4 10             	add    $0x10,%esp
    3286:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    328b:	7e 04                	jle    3291 <fsfull+0x121>
        break;
      total += cc;
    328d:	01 c7                	add    %eax,%edi
    while(1){
    328f:	eb df                	jmp    3270 <fsfull+0x100>
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3291:	83 ec 04             	sub    $0x4,%esp
    3294:	57                   	push   %edi
    3295:	68 bc 4a 00 00       	push   $0x4abc
    329a:	6a 01                	push   $0x1
    329c:	e8 e7 05 00 00       	call   3888 <printf>
    close(fd);
    32a1:	89 34 24             	mov    %esi,(%esp)
    32a4:	e8 c8 04 00 00       	call   3771 <close>
    if(total == 0)
    32a9:	83 c4 10             	add    $0x10,%esp
    32ac:	85 ff                	test   %edi,%edi
    32ae:	0f 84 ab 00 00 00    	je     335f <fsfull+0x1ef>
  for(nfiles = 0; ; nfiles++){
    32b4:	43                   	inc    %ebx
    32b5:	e9 d7 fe ff ff       	jmp    3191 <fsfull+0x21>
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    32ba:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    32be:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    32c3:	f7 eb                	imul   %ebx
    32c5:	89 d0                	mov    %edx,%eax
    32c7:	c1 f8 06             	sar    $0x6,%eax
    32ca:	89 de                	mov    %ebx,%esi
    32cc:	c1 fe 1f             	sar    $0x1f,%esi
    32cf:	29 f0                	sub    %esi,%eax
    32d1:	8d 50 30             	lea    0x30(%eax),%edx
    32d4:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    32d7:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32da:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32dd:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32e0:	c1 e0 03             	shl    $0x3,%eax
    32e3:	89 df                	mov    %ebx,%edi
    32e5:	29 c7                	sub    %eax,%edi
    32e7:	b9 1f 85 eb 51       	mov    $0x51eb851f,%ecx
    32ec:	89 f8                	mov    %edi,%eax
    32ee:	f7 e9                	imul   %ecx
    32f0:	c1 fa 05             	sar    $0x5,%edx
    32f3:	c1 ff 1f             	sar    $0x1f,%edi
    32f6:	29 fa                	sub    %edi,%edx
    32f8:	83 c2 30             	add    $0x30,%edx
    32fb:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    32fe:	89 c8                	mov    %ecx,%eax
    3300:	f7 eb                	imul   %ebx
    3302:	89 d1                	mov    %edx,%ecx
    3304:	c1 f9 05             	sar    $0x5,%ecx
    3307:	29 f1                	sub    %esi,%ecx
    3309:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
    330c:	8d 04 80             	lea    (%eax,%eax,4),%eax
    330f:	c1 e0 02             	shl    $0x2,%eax
    3312:	89 d9                	mov    %ebx,%ecx
    3314:	29 c1                	sub    %eax,%ecx
    3316:	bf 67 66 66 66       	mov    $0x66666667,%edi
    331b:	89 c8                	mov    %ecx,%eax
    331d:	f7 ef                	imul   %edi
    331f:	89 d0                	mov    %edx,%eax
    3321:	c1 f8 02             	sar    $0x2,%eax
    3324:	c1 f9 1f             	sar    $0x1f,%ecx
    3327:	29 c8                	sub    %ecx,%eax
    3329:	83 c0 30             	add    $0x30,%eax
    332c:	88 45 ab             	mov    %al,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    332f:	89 f8                	mov    %edi,%eax
    3331:	f7 eb                	imul   %ebx
    3333:	89 d0                	mov    %edx,%eax
    3335:	c1 f8 02             	sar    $0x2,%eax
    3338:	29 f0                	sub    %esi,%eax
    333a:	8d 04 80             	lea    (%eax,%eax,4),%eax
    333d:	01 c0                	add    %eax,%eax
    333f:	89 de                	mov    %ebx,%esi
    3341:	29 c6                	sub    %eax,%esi
    3343:	89 f0                	mov    %esi,%eax
    3345:	83 c0 30             	add    $0x30,%eax
    3348:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    334b:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    334f:	83 ec 0c             	sub    $0xc,%esp
    3352:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3355:	50                   	push   %eax
    3356:	e8 3e 04 00 00       	call   3799 <unlink>
    nfiles--;
    335b:	4b                   	dec    %ebx
    335c:	83 c4 10             	add    $0x10,%esp
  while(nfiles >= 0){
    335f:	85 db                	test   %ebx,%ebx
    3361:	0f 89 53 ff ff ff    	jns    32ba <fsfull+0x14a>
  }

  printf(1, "fsfull test finished\n");
    3367:	83 ec 08             	sub    $0x8,%esp
    336a:	68 cc 4a 00 00       	push   $0x4acc
    336f:	6a 01                	push   $0x1
    3371:	e8 12 05 00 00       	call   3888 <printf>
}
    3376:	83 c4 10             	add    $0x10,%esp
    3379:	8d 65 f4             	lea    -0xc(%ebp),%esp
    337c:	5b                   	pop    %ebx
    337d:	5e                   	pop    %esi
    337e:	5f                   	pop    %edi
    337f:	5d                   	pop    %ebp
    3380:	c3                   	ret    

00003381 <uio>:

void
uio()
{
    3381:	f3 0f 1e fb          	endbr32 
    3385:	55                   	push   %ebp
    3386:	89 e5                	mov    %esp,%ebp
    3388:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    338b:	68 e2 4a 00 00       	push   $0x4ae2
    3390:	6a 01                	push   $0x1
    3392:	e8 f1 04 00 00       	call   3888 <printf>
  pid = fork();
    3397:	e8 a5 03 00 00       	call   3741 <fork>
  if(pid == 0){
    339c:	83 c4 10             	add    $0x10,%esp
    339f:	85 c0                	test   %eax,%eax
    33a1:	74 1b                	je     33be <uio+0x3d>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    33a3:	78 3b                	js     33e0 <uio+0x5f>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    33a5:	e8 a7 03 00 00       	call   3751 <wait>
  printf(1, "uio test done\n");
    33aa:	83 ec 08             	sub    $0x8,%esp
    33ad:	68 ec 4a 00 00       	push   $0x4aec
    33b2:	6a 01                	push   $0x1
    33b4:	e8 cf 04 00 00       	call   3888 <printf>
}
    33b9:	83 c4 10             	add    $0x10,%esp
    33bc:	c9                   	leave  
    33bd:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    33be:	b0 09                	mov    $0x9,%al
    33c0:	ba 70 00 00 00       	mov    $0x70,%edx
    33c5:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    33c6:	ba 71 00 00 00       	mov    $0x71,%edx
    33cb:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    33cc:	83 ec 08             	sub    $0x8,%esp
    33cf:	68 78 52 00 00       	push   $0x5278
    33d4:	6a 01                	push   $0x1
    33d6:	e8 ad 04 00 00       	call   3888 <printf>
    exit();
    33db:	e8 69 03 00 00       	call   3749 <exit>
    printf (1, "fork failed\n");
    33e0:	83 ec 08             	sub    $0x8,%esp
    33e3:	68 71 4a 00 00       	push   $0x4a71
    33e8:	6a 01                	push   $0x1
    33ea:	e8 99 04 00 00       	call   3888 <printf>
    exit();
    33ef:	e8 55 03 00 00       	call   3749 <exit>

000033f4 <argptest>:

void argptest()
{
    33f4:	f3 0f 1e fb          	endbr32 
    33f8:	55                   	push   %ebp
    33f9:	89 e5                	mov    %esp,%ebp
    33fb:	53                   	push   %ebx
    33fc:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    33ff:	6a 00                	push   $0x0
    3401:	68 fb 4a 00 00       	push   $0x4afb
    3406:	e8 7e 03 00 00       	call   3789 <open>
  if (fd < 0) {
    340b:	83 c4 10             	add    $0x10,%esp
    340e:	85 c0                	test   %eax,%eax
    3410:	78 38                	js     344a <argptest+0x56>
    3412:	89 c3                	mov    %eax,%ebx
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    3414:	83 ec 0c             	sub    $0xc,%esp
    3417:	6a 00                	push   $0x0
    3419:	e8 b3 03 00 00       	call   37d1 <sbrk>
    341e:	48                   	dec    %eax
    341f:	83 c4 0c             	add    $0xc,%esp
    3422:	6a ff                	push   $0xffffffff
    3424:	50                   	push   %eax
    3425:	53                   	push   %ebx
    3426:	e8 36 03 00 00       	call   3761 <read>
  close(fd);
    342b:	89 1c 24             	mov    %ebx,(%esp)
    342e:	e8 3e 03 00 00       	call   3771 <close>
  printf(1, "arg test passed\n");
    3433:	83 c4 08             	add    $0x8,%esp
    3436:	68 0d 4b 00 00       	push   $0x4b0d
    343b:	6a 01                	push   $0x1
    343d:	e8 46 04 00 00       	call   3888 <printf>
}
    3442:	83 c4 10             	add    $0x10,%esp
    3445:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3448:	c9                   	leave  
    3449:	c3                   	ret    
    printf(2, "open failed\n");
    344a:	83 ec 08             	sub    $0x8,%esp
    344d:	68 00 4b 00 00       	push   $0x4b00
    3452:	6a 02                	push   $0x2
    3454:	e8 2f 04 00 00       	call   3888 <printf>
    exit();
    3459:	e8 eb 02 00 00       	call   3749 <exit>

0000345e <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    345e:	f3 0f 1e fb          	endbr32 
  randstate = randstate * 1664525 + 1013904223;
    3462:	a1 7c 5b 00 00       	mov    0x5b7c,%eax
    3467:	8d 14 00             	lea    (%eax,%eax,1),%edx
    346a:	01 c2                	add    %eax,%edx
    346c:	8d 0c 90             	lea    (%eax,%edx,4),%ecx
    346f:	c1 e1 08             	shl    $0x8,%ecx
    3472:	89 ca                	mov    %ecx,%edx
    3474:	01 c2                	add    %eax,%edx
    3476:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3479:	8d 04 90             	lea    (%eax,%edx,4),%eax
    347c:	8d 04 80             	lea    (%eax,%eax,4),%eax
    347f:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    3486:	a3 7c 5b 00 00       	mov    %eax,0x5b7c
  return randstate;
}
    348b:	c3                   	ret    

0000348c <main>:

int
main(int argc, char *argv[])
{
    348c:	f3 0f 1e fb          	endbr32 
    3490:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3494:	83 e4 f0             	and    $0xfffffff0,%esp
    3497:	ff 71 fc             	pushl  -0x4(%ecx)
    349a:	55                   	push   %ebp
    349b:	89 e5                	mov    %esp,%ebp
    349d:	51                   	push   %ecx
    349e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
    34a1:	68 1e 4b 00 00       	push   $0x4b1e
    34a6:	6a 01                	push   $0x1
    34a8:	e8 db 03 00 00       	call   3888 <printf>

  if(open("usertests.ran", 0) >= 0){
    34ad:	83 c4 08             	add    $0x8,%esp
    34b0:	6a 00                	push   $0x0
    34b2:	68 32 4b 00 00       	push   $0x4b32
    34b7:	e8 cd 02 00 00       	call   3789 <open>
    34bc:	83 c4 10             	add    $0x10,%esp
    34bf:	85 c0                	test   %eax,%eax
    34c1:	78 14                	js     34d7 <main+0x4b>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    34c3:	83 ec 08             	sub    $0x8,%esp
    34c6:	68 9c 52 00 00       	push   $0x529c
    34cb:	6a 01                	push   $0x1
    34cd:	e8 b6 03 00 00       	call   3888 <printf>
    exit();
    34d2:	e8 72 02 00 00       	call   3749 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    34d7:	83 ec 08             	sub    $0x8,%esp
    34da:	68 00 02 00 00       	push   $0x200
    34df:	68 32 4b 00 00       	push   $0x4b32
    34e4:	e8 a0 02 00 00       	call   3789 <open>
    34e9:	89 04 24             	mov    %eax,(%esp)
    34ec:	e8 80 02 00 00       	call   3771 <close>

  argptest();
    34f1:	e8 fe fe ff ff       	call   33f4 <argptest>
  createdelete();
    34f6:	e8 14 db ff ff       	call   100f <createdelete>
  linkunlink();
    34fb:	e8 60 e3 ff ff       	call   1860 <linkunlink>
  concreate();
    3500:	e8 b5 e0 ff ff       	call   15ba <concreate>
  fourfiles();
    3505:	e8 37 d9 ff ff       	call   e41 <fourfiles>
  sharedfd();
    350a:	e8 a2 d7 ff ff       	call   cb1 <sharedfd>

  bigargtest();
    350f:	e8 5b fb ff ff       	call   306f <bigargtest>
  bigwrite();
    3514:	e8 df ec ff ff       	call   21f8 <bigwrite>
  bigargtest();
    3519:	e8 51 fb ff ff       	call   306f <bigargtest>
  bsstest();
    351e:	e8 e7 fa ff ff       	call   300a <bsstest>
  sbrktest();
    3523:	e8 18 f6 ff ff       	call   2b40 <sbrktest>
  validatetest();
    3528:	e8 2b fa ff ff       	call   2f58 <validatetest>

  opentest();
    352d:	e8 86 cd ff ff       	call   2b8 <opentest>
  writetest();
    3532:	e8 18 ce ff ff       	call   34f <writetest>
  writetest1();
    3537:	e8 dd cf ff ff       	call   519 <writetest1>
  createtest();
    353c:	e8 88 d1 ff ff       	call   6c9 <createtest>

  openiputtest();
    3541:	e8 85 cc ff ff       	call   1cb <openiputtest>
  exitiputtest();
    3546:	e8 96 cb ff ff       	call   e1 <exitiputtest>
  iputtest();
    354b:	e8 b0 ca ff ff       	call   0 <iputtest>

  mem();
    3550:	e8 9f d6 ff ff       	call   bf4 <mem>
  pipe1();
    3555:	e8 49 d3 ff ff       	call   8a3 <pipe1>
  preempt();
    355a:	e8 e4 d4 ff ff       	call   a43 <preempt>
  exitwait();
    355f:	e8 1e d6 ff ff       	call   b82 <exitwait>

  rmdot();
    3564:	e8 5a f0 ff ff       	call   25c3 <rmdot>
  fourteen();
    3569:	e8 14 ef ff ff       	call   2482 <fourteen>
  bigfile();
    356e:	e8 59 ed ff ff       	call   22cc <bigfile>
  subdir();
    3573:	e8 4e e5 ff ff       	call   1ac6 <subdir>
  linktest();
    3578:	e8 13 de ff ff       	call   1390 <linktest>
  unlinkread();
    357d:	e8 71 dc ff ff       	call   11f3 <unlinkread>
  dirfile();
    3582:	e8 c5 f1 ff ff       	call   274c <dirfile>
  iref();
    3587:	e8 de f3 ff ff       	call   296a <iref>
  forktest();
    358c:	e8 00 f5 ff ff       	call   2a91 <forktest>
  bigdir(); // slow
    3591:	e8 d6 e3 ff ff       	call   196c <bigdir>

  uio();
    3596:	e8 e6 fd ff ff       	call   3381 <uio>

  exectest();
    359b:	e8 b6 d2 ff ff       	call   856 <exectest>

  exit();
    35a0:	e8 a4 01 00 00       	call   3749 <exit>

000035a5 <start>:
#include <x86.h>

// Entry point of the library	
void
start()
{
    35a5:	f3 0f 1e fb          	endbr32 
}
    35a9:	c3                   	ret    

000035aa <strcpy>:

char*
strcpy(char *s, const char *t)
{
    35aa:	f3 0f 1e fb          	endbr32 
    35ae:	55                   	push   %ebp
    35af:	89 e5                	mov    %esp,%ebp
    35b1:	56                   	push   %esi
    35b2:	53                   	push   %ebx
    35b3:	8b 45 08             	mov    0x8(%ebp),%eax
    35b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    35b9:	89 c2                	mov    %eax,%edx
    35bb:	89 cb                	mov    %ecx,%ebx
    35bd:	41                   	inc    %ecx
    35be:	89 d6                	mov    %edx,%esi
    35c0:	42                   	inc    %edx
    35c1:	8a 1b                	mov    (%ebx),%bl
    35c3:	88 1e                	mov    %bl,(%esi)
    35c5:	84 db                	test   %bl,%bl
    35c7:	75 f2                	jne    35bb <strcpy+0x11>
    ;
  return os;
}
    35c9:	5b                   	pop    %ebx
    35ca:	5e                   	pop    %esi
    35cb:	5d                   	pop    %ebp
    35cc:	c3                   	ret    

000035cd <strcmp>:

int
strcmp(const char *p, const char *q)
{
    35cd:	f3 0f 1e fb          	endbr32 
    35d1:	55                   	push   %ebp
    35d2:	89 e5                	mov    %esp,%ebp
    35d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    35d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    35da:	8a 01                	mov    (%ecx),%al
    35dc:	84 c0                	test   %al,%al
    35de:	74 08                	je     35e8 <strcmp+0x1b>
    35e0:	3a 02                	cmp    (%edx),%al
    35e2:	75 04                	jne    35e8 <strcmp+0x1b>
    p++, q++;
    35e4:	41                   	inc    %ecx
    35e5:	42                   	inc    %edx
    35e6:	eb f2                	jmp    35da <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
    35e8:	0f b6 c0             	movzbl %al,%eax
    35eb:	0f b6 12             	movzbl (%edx),%edx
    35ee:	29 d0                	sub    %edx,%eax
}
    35f0:	5d                   	pop    %ebp
    35f1:	c3                   	ret    

000035f2 <strlen>:

uint
strlen(const char *s)
{
    35f2:	f3 0f 1e fb          	endbr32 
    35f6:	55                   	push   %ebp
    35f7:	89 e5                	mov    %esp,%ebp
    35f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    35fc:	b8 00 00 00 00       	mov    $0x0,%eax
    3601:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    3605:	74 03                	je     360a <strlen+0x18>
    3607:	40                   	inc    %eax
    3608:	eb f7                	jmp    3601 <strlen+0xf>
    ;
  return n;
}
    360a:	5d                   	pop    %ebp
    360b:	c3                   	ret    

0000360c <memset>:

void*
memset(void *dst, int c, uint n)
{
    360c:	f3 0f 1e fb          	endbr32 
    3610:	55                   	push   %ebp
    3611:	89 e5                	mov    %esp,%ebp
    3613:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3614:	8b 7d 08             	mov    0x8(%ebp),%edi
    3617:	8b 4d 10             	mov    0x10(%ebp),%ecx
    361a:	8b 45 0c             	mov    0xc(%ebp),%eax
    361d:	fc                   	cld    
    361e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3620:	8b 45 08             	mov    0x8(%ebp),%eax
    3623:	5f                   	pop    %edi
    3624:	5d                   	pop    %ebp
    3625:	c3                   	ret    

00003626 <strchr>:

char*
strchr(const char *s, char c)
{
    3626:	f3 0f 1e fb          	endbr32 
    362a:	55                   	push   %ebp
    362b:	89 e5                	mov    %esp,%ebp
    362d:	8b 45 08             	mov    0x8(%ebp),%eax
    3630:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
    3633:	8a 10                	mov    (%eax),%dl
    3635:	84 d2                	test   %dl,%dl
    3637:	74 07                	je     3640 <strchr+0x1a>
    if(*s == c)
    3639:	38 ca                	cmp    %cl,%dl
    363b:	74 08                	je     3645 <strchr+0x1f>
  for(; *s; s++)
    363d:	40                   	inc    %eax
    363e:	eb f3                	jmp    3633 <strchr+0xd>
      return (char*)s;
  return 0;
    3640:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3645:	5d                   	pop    %ebp
    3646:	c3                   	ret    

00003647 <gets>:

char*
gets(char *buf, int max)
{
    3647:	f3 0f 1e fb          	endbr32 
    364b:	55                   	push   %ebp
    364c:	89 e5                	mov    %esp,%ebp
    364e:	57                   	push   %edi
    364f:	56                   	push   %esi
    3650:	53                   	push   %ebx
    3651:	83 ec 1c             	sub    $0x1c,%esp
    3654:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3657:	bb 00 00 00 00       	mov    $0x0,%ebx
    365c:	89 de                	mov    %ebx,%esi
    365e:	43                   	inc    %ebx
    365f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3662:	7d 2b                	jge    368f <gets+0x48>
    cc = read(0, &c, 1);
    3664:	83 ec 04             	sub    $0x4,%esp
    3667:	6a 01                	push   $0x1
    3669:	8d 45 e7             	lea    -0x19(%ebp),%eax
    366c:	50                   	push   %eax
    366d:	6a 00                	push   $0x0
    366f:	e8 ed 00 00 00       	call   3761 <read>
    if(cc < 1)
    3674:	83 c4 10             	add    $0x10,%esp
    3677:	85 c0                	test   %eax,%eax
    3679:	7e 14                	jle    368f <gets+0x48>
      break;
    buf[i++] = c;
    367b:	8a 45 e7             	mov    -0x19(%ebp),%al
    367e:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    3681:	3c 0a                	cmp    $0xa,%al
    3683:	74 08                	je     368d <gets+0x46>
    3685:	3c 0d                	cmp    $0xd,%al
    3687:	75 d3                	jne    365c <gets+0x15>
    buf[i++] = c;
    3689:	89 de                	mov    %ebx,%esi
    368b:	eb 02                	jmp    368f <gets+0x48>
    368d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    368f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    3693:	89 f8                	mov    %edi,%eax
    3695:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3698:	5b                   	pop    %ebx
    3699:	5e                   	pop    %esi
    369a:	5f                   	pop    %edi
    369b:	5d                   	pop    %ebp
    369c:	c3                   	ret    

0000369d <stat>:

int
stat(const char *n, struct stat *st)
{
    369d:	f3 0f 1e fb          	endbr32 
    36a1:	55                   	push   %ebp
    36a2:	89 e5                	mov    %esp,%ebp
    36a4:	56                   	push   %esi
    36a5:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    36a6:	83 ec 08             	sub    $0x8,%esp
    36a9:	6a 00                	push   $0x0
    36ab:	ff 75 08             	pushl  0x8(%ebp)
    36ae:	e8 d6 00 00 00       	call   3789 <open>
  if(fd < 0)
    36b3:	83 c4 10             	add    $0x10,%esp
    36b6:	85 c0                	test   %eax,%eax
    36b8:	78 24                	js     36de <stat+0x41>
    36ba:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    36bc:	83 ec 08             	sub    $0x8,%esp
    36bf:	ff 75 0c             	pushl  0xc(%ebp)
    36c2:	50                   	push   %eax
    36c3:	e8 d9 00 00 00       	call   37a1 <fstat>
    36c8:	89 c6                	mov    %eax,%esi
  close(fd);
    36ca:	89 1c 24             	mov    %ebx,(%esp)
    36cd:	e8 9f 00 00 00       	call   3771 <close>
  return r;
    36d2:	83 c4 10             	add    $0x10,%esp
}
    36d5:	89 f0                	mov    %esi,%eax
    36d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    36da:	5b                   	pop    %ebx
    36db:	5e                   	pop    %esi
    36dc:	5d                   	pop    %ebp
    36dd:	c3                   	ret    
    return -1;
    36de:	be ff ff ff ff       	mov    $0xffffffff,%esi
    36e3:	eb f0                	jmp    36d5 <stat+0x38>

000036e5 <atoi>:

int
atoi(const char *s)
{
    36e5:	f3 0f 1e fb          	endbr32 
    36e9:	55                   	push   %ebp
    36ea:	89 e5                	mov    %esp,%ebp
    36ec:	53                   	push   %ebx
    36ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    36f0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    36f5:	8a 01                	mov    (%ecx),%al
    36f7:	8d 58 d0             	lea    -0x30(%eax),%ebx
    36fa:	80 fb 09             	cmp    $0x9,%bl
    36fd:	77 10                	ja     370f <atoi+0x2a>
    n = n*10 + *s++ - '0';
    36ff:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3702:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
    3705:	41                   	inc    %ecx
    3706:	0f be c0             	movsbl %al,%eax
    3709:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
    370d:	eb e6                	jmp    36f5 <atoi+0x10>
  return n;
}
    370f:	89 d0                	mov    %edx,%eax
    3711:	5b                   	pop    %ebx
    3712:	5d                   	pop    %ebp
    3713:	c3                   	ret    

00003714 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3714:	f3 0f 1e fb          	endbr32 
    3718:	55                   	push   %ebp
    3719:	89 e5                	mov    %esp,%ebp
    371b:	56                   	push   %esi
    371c:	53                   	push   %ebx
    371d:	8b 45 08             	mov    0x8(%ebp),%eax
    3720:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3723:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
    3726:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
    3728:	8d 72 ff             	lea    -0x1(%edx),%esi
    372b:	85 d2                	test   %edx,%edx
    372d:	7e 0e                	jle    373d <memmove+0x29>
    *dst++ = *src++;
    372f:	8a 13                	mov    (%ebx),%dl
    3731:	88 11                	mov    %dl,(%ecx)
    3733:	8d 5b 01             	lea    0x1(%ebx),%ebx
    3736:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
    3739:	89 f2                	mov    %esi,%edx
    373b:	eb eb                	jmp    3728 <memmove+0x14>
  return vdst;
}
    373d:	5b                   	pop    %ebx
    373e:	5e                   	pop    %esi
    373f:	5d                   	pop    %ebp
    3740:	c3                   	ret    

00003741 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3741:	b8 01 00 00 00       	mov    $0x1,%eax
    3746:	cd 40                	int    $0x40
    3748:	c3                   	ret    

00003749 <exit>:
SYSCALL(exit)
    3749:	b8 02 00 00 00       	mov    $0x2,%eax
    374e:	cd 40                	int    $0x40
    3750:	c3                   	ret    

00003751 <wait>:
SYSCALL(wait)
    3751:	b8 03 00 00 00       	mov    $0x3,%eax
    3756:	cd 40                	int    $0x40
    3758:	c3                   	ret    

00003759 <pipe>:
SYSCALL(pipe)
    3759:	b8 04 00 00 00       	mov    $0x4,%eax
    375e:	cd 40                	int    $0x40
    3760:	c3                   	ret    

00003761 <read>:
SYSCALL(read)
    3761:	b8 05 00 00 00       	mov    $0x5,%eax
    3766:	cd 40                	int    $0x40
    3768:	c3                   	ret    

00003769 <write>:
SYSCALL(write)
    3769:	b8 10 00 00 00       	mov    $0x10,%eax
    376e:	cd 40                	int    $0x40
    3770:	c3                   	ret    

00003771 <close>:
SYSCALL(close)
    3771:	b8 15 00 00 00       	mov    $0x15,%eax
    3776:	cd 40                	int    $0x40
    3778:	c3                   	ret    

00003779 <kill>:
SYSCALL(kill)
    3779:	b8 06 00 00 00       	mov    $0x6,%eax
    377e:	cd 40                	int    $0x40
    3780:	c3                   	ret    

00003781 <exec>:
SYSCALL(exec)
    3781:	b8 07 00 00 00       	mov    $0x7,%eax
    3786:	cd 40                	int    $0x40
    3788:	c3                   	ret    

00003789 <open>:
SYSCALL(open)
    3789:	b8 0f 00 00 00       	mov    $0xf,%eax
    378e:	cd 40                	int    $0x40
    3790:	c3                   	ret    

00003791 <mknod>:
SYSCALL(mknod)
    3791:	b8 11 00 00 00       	mov    $0x11,%eax
    3796:	cd 40                	int    $0x40
    3798:	c3                   	ret    

00003799 <unlink>:
SYSCALL(unlink)
    3799:	b8 12 00 00 00       	mov    $0x12,%eax
    379e:	cd 40                	int    $0x40
    37a0:	c3                   	ret    

000037a1 <fstat>:
SYSCALL(fstat)
    37a1:	b8 08 00 00 00       	mov    $0x8,%eax
    37a6:	cd 40                	int    $0x40
    37a8:	c3                   	ret    

000037a9 <link>:
SYSCALL(link)
    37a9:	b8 13 00 00 00       	mov    $0x13,%eax
    37ae:	cd 40                	int    $0x40
    37b0:	c3                   	ret    

000037b1 <mkdir>:
SYSCALL(mkdir)
    37b1:	b8 14 00 00 00       	mov    $0x14,%eax
    37b6:	cd 40                	int    $0x40
    37b8:	c3                   	ret    

000037b9 <chdir>:
SYSCALL(chdir)
    37b9:	b8 09 00 00 00       	mov    $0x9,%eax
    37be:	cd 40                	int    $0x40
    37c0:	c3                   	ret    

000037c1 <dup>:
SYSCALL(dup)
    37c1:	b8 0a 00 00 00       	mov    $0xa,%eax
    37c6:	cd 40                	int    $0x40
    37c8:	c3                   	ret    

000037c9 <getpid>:
SYSCALL(getpid)
    37c9:	b8 0b 00 00 00       	mov    $0xb,%eax
    37ce:	cd 40                	int    $0x40
    37d0:	c3                   	ret    

000037d1 <sbrk>:
SYSCALL(sbrk)
    37d1:	b8 0c 00 00 00       	mov    $0xc,%eax
    37d6:	cd 40                	int    $0x40
    37d8:	c3                   	ret    

000037d9 <sleep>:
SYSCALL(sleep)
    37d9:	b8 0d 00 00 00       	mov    $0xd,%eax
    37de:	cd 40                	int    $0x40
    37e0:	c3                   	ret    

000037e1 <uptime>:
SYSCALL(uptime)
    37e1:	b8 0e 00 00 00       	mov    $0xe,%eax
    37e6:	cd 40                	int    $0x40
    37e8:	c3                   	ret    

000037e9 <date>:
SYSCALL(date)
    37e9:	b8 16 00 00 00       	mov    $0x16,%eax
    37ee:	cd 40                	int    $0x40
    37f0:	c3                   	ret    

000037f1 <dup2>:
SYSCALL(dup2)
    37f1:	b8 17 00 00 00       	mov    $0x17,%eax
    37f6:	cd 40                	int    $0x40
    37f8:	c3                   	ret    

000037f9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    37f9:	55                   	push   %ebp
    37fa:	89 e5                	mov    %esp,%ebp
    37fc:	83 ec 1c             	sub    $0x1c,%esp
    37ff:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    3802:	6a 01                	push   $0x1
    3804:	8d 55 f4             	lea    -0xc(%ebp),%edx
    3807:	52                   	push   %edx
    3808:	50                   	push   %eax
    3809:	e8 5b ff ff ff       	call   3769 <write>
}
    380e:	83 c4 10             	add    $0x10,%esp
    3811:	c9                   	leave  
    3812:	c3                   	ret    

00003813 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3813:	55                   	push   %ebp
    3814:	89 e5                	mov    %esp,%ebp
    3816:	57                   	push   %edi
    3817:	56                   	push   %esi
    3818:	53                   	push   %ebx
    3819:	83 ec 2c             	sub    $0x2c,%esp
    381c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    381f:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3821:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    3825:	74 04                	je     382b <printint+0x18>
    3827:	85 d2                	test   %edx,%edx
    3829:	78 3a                	js     3865 <printint+0x52>
  neg = 0;
    382b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    3832:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    3837:	89 f0                	mov    %esi,%eax
    3839:	ba 00 00 00 00       	mov    $0x0,%edx
    383e:	f7 f1                	div    %ecx
    3840:	89 df                	mov    %ebx,%edi
    3842:	43                   	inc    %ebx
    3843:	8a 92 e0 52 00 00    	mov    0x52e0(%edx),%dl
    3849:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    384d:	89 f2                	mov    %esi,%edx
    384f:	89 c6                	mov    %eax,%esi
    3851:	39 d1                	cmp    %edx,%ecx
    3853:	76 e2                	jbe    3837 <printint+0x24>
  if(neg)
    3855:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
    3859:	74 22                	je     387d <printint+0x6a>
    buf[i++] = '-';
    385b:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    3860:	8d 5f 02             	lea    0x2(%edi),%ebx
    3863:	eb 18                	jmp    387d <printint+0x6a>
    x = -xx;
    3865:	f7 de                	neg    %esi
    neg = 1;
    3867:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
    386e:	eb c2                	jmp    3832 <printint+0x1f>

  while(--i >= 0)
    putc(fd, buf[i]);
    3870:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    3875:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3878:	e8 7c ff ff ff       	call   37f9 <putc>
  while(--i >= 0)
    387d:	4b                   	dec    %ebx
    387e:	79 f0                	jns    3870 <printint+0x5d>
}
    3880:	83 c4 2c             	add    $0x2c,%esp
    3883:	5b                   	pop    %ebx
    3884:	5e                   	pop    %esi
    3885:	5f                   	pop    %edi
    3886:	5d                   	pop    %ebp
    3887:	c3                   	ret    

00003888 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3888:	f3 0f 1e fb          	endbr32 
    388c:	55                   	push   %ebp
    388d:	89 e5                	mov    %esp,%ebp
    388f:	57                   	push   %edi
    3890:	56                   	push   %esi
    3891:	53                   	push   %ebx
    3892:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3895:	8d 45 10             	lea    0x10(%ebp),%eax
    3898:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    389b:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    38a0:	bb 00 00 00 00       	mov    $0x0,%ebx
    38a5:	eb 12                	jmp    38b9 <printf+0x31>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    38a7:	89 fa                	mov    %edi,%edx
    38a9:	8b 45 08             	mov    0x8(%ebp),%eax
    38ac:	e8 48 ff ff ff       	call   37f9 <putc>
    38b1:	eb 05                	jmp    38b8 <printf+0x30>
      }
    } else if(state == '%'){
    38b3:	83 fe 25             	cmp    $0x25,%esi
    38b6:	74 22                	je     38da <printf+0x52>
  for(i = 0; fmt[i]; i++){
    38b8:	43                   	inc    %ebx
    38b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    38bc:	8a 04 18             	mov    (%eax,%ebx,1),%al
    38bf:	84 c0                	test   %al,%al
    38c1:	0f 84 13 01 00 00    	je     39da <printf+0x152>
    c = fmt[i] & 0xff;
    38c7:	0f be f8             	movsbl %al,%edi
    38ca:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    38cd:	85 f6                	test   %esi,%esi
    38cf:	75 e2                	jne    38b3 <printf+0x2b>
      if(c == '%'){
    38d1:	83 f8 25             	cmp    $0x25,%eax
    38d4:	75 d1                	jne    38a7 <printf+0x1f>
        state = '%';
    38d6:	89 c6                	mov    %eax,%esi
    38d8:	eb de                	jmp    38b8 <printf+0x30>
      if(c == 'd'){
    38da:	83 f8 64             	cmp    $0x64,%eax
    38dd:	74 43                	je     3922 <printf+0x9a>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    38df:	83 f8 78             	cmp    $0x78,%eax
    38e2:	74 68                	je     394c <printf+0xc4>
    38e4:	83 f8 70             	cmp    $0x70,%eax
    38e7:	74 63                	je     394c <printf+0xc4>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    38e9:	83 f8 73             	cmp    $0x73,%eax
    38ec:	0f 84 84 00 00 00    	je     3976 <printf+0xee>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    38f2:	83 f8 63             	cmp    $0x63,%eax
    38f5:	0f 84 ad 00 00 00    	je     39a8 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    38fb:	83 f8 25             	cmp    $0x25,%eax
    38fe:	0f 84 c2 00 00 00    	je     39c6 <printf+0x13e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3904:	ba 25 00 00 00       	mov    $0x25,%edx
    3909:	8b 45 08             	mov    0x8(%ebp),%eax
    390c:	e8 e8 fe ff ff       	call   37f9 <putc>
        putc(fd, c);
    3911:	89 fa                	mov    %edi,%edx
    3913:	8b 45 08             	mov    0x8(%ebp),%eax
    3916:	e8 de fe ff ff       	call   37f9 <putc>
      }
      state = 0;
    391b:	be 00 00 00 00       	mov    $0x0,%esi
    3920:	eb 96                	jmp    38b8 <printf+0x30>
        printint(fd, *ap, 10, 1);
    3922:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    3925:	8b 17                	mov    (%edi),%edx
    3927:	83 ec 0c             	sub    $0xc,%esp
    392a:	6a 01                	push   $0x1
    392c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3931:	8b 45 08             	mov    0x8(%ebp),%eax
    3934:	e8 da fe ff ff       	call   3813 <printint>
        ap++;
    3939:	83 c7 04             	add    $0x4,%edi
    393c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    393f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3942:	be 00 00 00 00       	mov    $0x0,%esi
    3947:	e9 6c ff ff ff       	jmp    38b8 <printf+0x30>
        printint(fd, *ap, 16, 0);
    394c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    394f:	8b 17                	mov    (%edi),%edx
    3951:	83 ec 0c             	sub    $0xc,%esp
    3954:	6a 00                	push   $0x0
    3956:	b9 10 00 00 00       	mov    $0x10,%ecx
    395b:	8b 45 08             	mov    0x8(%ebp),%eax
    395e:	e8 b0 fe ff ff       	call   3813 <printint>
        ap++;
    3963:	83 c7 04             	add    $0x4,%edi
    3966:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    3969:	83 c4 10             	add    $0x10,%esp
      state = 0;
    396c:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
    3971:	e9 42 ff ff ff       	jmp    38b8 <printf+0x30>
        s = (char*)*ap;
    3976:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3979:	8b 30                	mov    (%eax),%esi
        ap++;
    397b:	83 c0 04             	add    $0x4,%eax
    397e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    3981:	85 f6                	test   %esi,%esi
    3983:	75 13                	jne    3998 <printf+0x110>
          s = "(null)";
    3985:	be d8 52 00 00       	mov    $0x52d8,%esi
    398a:	eb 0c                	jmp    3998 <printf+0x110>
          putc(fd, *s);
    398c:	0f be d2             	movsbl %dl,%edx
    398f:	8b 45 08             	mov    0x8(%ebp),%eax
    3992:	e8 62 fe ff ff       	call   37f9 <putc>
          s++;
    3997:	46                   	inc    %esi
        while(*s != 0){
    3998:	8a 16                	mov    (%esi),%dl
    399a:	84 d2                	test   %dl,%dl
    399c:	75 ee                	jne    398c <printf+0x104>
      state = 0;
    399e:	be 00 00 00 00       	mov    $0x0,%esi
    39a3:	e9 10 ff ff ff       	jmp    38b8 <printf+0x30>
        putc(fd, *ap);
    39a8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    39ab:	0f be 17             	movsbl (%edi),%edx
    39ae:	8b 45 08             	mov    0x8(%ebp),%eax
    39b1:	e8 43 fe ff ff       	call   37f9 <putc>
        ap++;
    39b6:	83 c7 04             	add    $0x4,%edi
    39b9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    39bc:	be 00 00 00 00       	mov    $0x0,%esi
    39c1:	e9 f2 fe ff ff       	jmp    38b8 <printf+0x30>
        putc(fd, c);
    39c6:	89 fa                	mov    %edi,%edx
    39c8:	8b 45 08             	mov    0x8(%ebp),%eax
    39cb:	e8 29 fe ff ff       	call   37f9 <putc>
      state = 0;
    39d0:	be 00 00 00 00       	mov    $0x0,%esi
    39d5:	e9 de fe ff ff       	jmp    38b8 <printf+0x30>
    }
  }
}
    39da:	8d 65 f4             	lea    -0xc(%ebp),%esp
    39dd:	5b                   	pop    %ebx
    39de:	5e                   	pop    %esi
    39df:	5f                   	pop    %edi
    39e0:	5d                   	pop    %ebp
    39e1:	c3                   	ret    

000039e2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    39e2:	f3 0f 1e fb          	endbr32 
    39e6:	55                   	push   %ebp
    39e7:	89 e5                	mov    %esp,%ebp
    39e9:	57                   	push   %edi
    39ea:	56                   	push   %esi
    39eb:	53                   	push   %ebx
    39ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    39ef:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    39f2:	a1 20 5c 00 00       	mov    0x5c20,%eax
    39f7:	eb 02                	jmp    39fb <free+0x19>
    39f9:	89 d0                	mov    %edx,%eax
    39fb:	39 c8                	cmp    %ecx,%eax
    39fd:	73 04                	jae    3a03 <free+0x21>
    39ff:	39 08                	cmp    %ecx,(%eax)
    3a01:	77 12                	ja     3a15 <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3a03:	8b 10                	mov    (%eax),%edx
    3a05:	39 c2                	cmp    %eax,%edx
    3a07:	77 f0                	ja     39f9 <free+0x17>
    3a09:	39 c8                	cmp    %ecx,%eax
    3a0b:	72 08                	jb     3a15 <free+0x33>
    3a0d:	39 ca                	cmp    %ecx,%edx
    3a0f:	77 04                	ja     3a15 <free+0x33>
    3a11:	89 d0                	mov    %edx,%eax
    3a13:	eb e6                	jmp    39fb <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3a15:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3a18:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3a1b:	8b 10                	mov    (%eax),%edx
    3a1d:	39 d7                	cmp    %edx,%edi
    3a1f:	74 19                	je     3a3a <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3a21:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3a24:	8b 50 04             	mov    0x4(%eax),%edx
    3a27:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3a2a:	39 ce                	cmp    %ecx,%esi
    3a2c:	74 1b                	je     3a49 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3a2e:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3a30:	a3 20 5c 00 00       	mov    %eax,0x5c20
}
    3a35:	5b                   	pop    %ebx
    3a36:	5e                   	pop    %esi
    3a37:	5f                   	pop    %edi
    3a38:	5d                   	pop    %ebp
    3a39:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    3a3a:	03 72 04             	add    0x4(%edx),%esi
    3a3d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3a40:	8b 10                	mov    (%eax),%edx
    3a42:	8b 12                	mov    (%edx),%edx
    3a44:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3a47:	eb db                	jmp    3a24 <free+0x42>
    p->s.size += bp->s.size;
    3a49:	03 53 fc             	add    -0x4(%ebx),%edx
    3a4c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3a4f:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3a52:	89 10                	mov    %edx,(%eax)
    3a54:	eb da                	jmp    3a30 <free+0x4e>

00003a56 <morecore>:

static Header*
morecore(uint nu)
{
    3a56:	55                   	push   %ebp
    3a57:	89 e5                	mov    %esp,%ebp
    3a59:	53                   	push   %ebx
    3a5a:	83 ec 04             	sub    $0x4,%esp
    3a5d:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    3a5f:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    3a64:	77 05                	ja     3a6b <morecore+0x15>
    nu = 4096;
    3a66:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    3a6b:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3a72:	83 ec 0c             	sub    $0xc,%esp
    3a75:	50                   	push   %eax
    3a76:	e8 56 fd ff ff       	call   37d1 <sbrk>
  if(p == (char*)-1)
    3a7b:	83 c4 10             	add    $0x10,%esp
    3a7e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3a81:	74 1c                	je     3a9f <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3a83:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3a86:	83 c0 08             	add    $0x8,%eax
    3a89:	83 ec 0c             	sub    $0xc,%esp
    3a8c:	50                   	push   %eax
    3a8d:	e8 50 ff ff ff       	call   39e2 <free>
  return freep;
    3a92:	a1 20 5c 00 00       	mov    0x5c20,%eax
    3a97:	83 c4 10             	add    $0x10,%esp
}
    3a9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3a9d:	c9                   	leave  
    3a9e:	c3                   	ret    
    return 0;
    3a9f:	b8 00 00 00 00       	mov    $0x0,%eax
    3aa4:	eb f4                	jmp    3a9a <morecore+0x44>

00003aa6 <malloc>:

void*
malloc(uint nbytes)
{
    3aa6:	f3 0f 1e fb          	endbr32 
    3aaa:	55                   	push   %ebp
    3aab:	89 e5                	mov    %esp,%ebp
    3aad:	53                   	push   %ebx
    3aae:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    3ab4:	8d 58 07             	lea    0x7(%eax),%ebx
    3ab7:	c1 eb 03             	shr    $0x3,%ebx
    3aba:	43                   	inc    %ebx
  if((prevp = freep) == 0){
    3abb:	8b 0d 20 5c 00 00    	mov    0x5c20,%ecx
    3ac1:	85 c9                	test   %ecx,%ecx
    3ac3:	74 04                	je     3ac9 <malloc+0x23>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ac5:	8b 01                	mov    (%ecx),%eax
    3ac7:	eb 4b                	jmp    3b14 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
    3ac9:	c7 05 20 5c 00 00 24 	movl   $0x5c24,0x5c20
    3ad0:	5c 00 00 
    3ad3:	c7 05 24 5c 00 00 24 	movl   $0x5c24,0x5c24
    3ada:	5c 00 00 
    base.s.size = 0;
    3add:	c7 05 28 5c 00 00 00 	movl   $0x0,0x5c28
    3ae4:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    3ae7:	b9 24 5c 00 00       	mov    $0x5c24,%ecx
    3aec:	eb d7                	jmp    3ac5 <malloc+0x1f>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    3aee:	74 1a                	je     3b0a <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3af0:	29 da                	sub    %ebx,%edx
    3af2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    3af5:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    3af8:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    3afb:	89 0d 20 5c 00 00    	mov    %ecx,0x5c20
      return (void*)(p + 1);
    3b01:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3b04:	83 c4 04             	add    $0x4,%esp
    3b07:	5b                   	pop    %ebx
    3b08:	5d                   	pop    %ebp
    3b09:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    3b0a:	8b 10                	mov    (%eax),%edx
    3b0c:	89 11                	mov    %edx,(%ecx)
    3b0e:	eb eb                	jmp    3afb <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3b10:	89 c1                	mov    %eax,%ecx
    3b12:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    3b14:	8b 50 04             	mov    0x4(%eax),%edx
    3b17:	39 da                	cmp    %ebx,%edx
    3b19:	73 d3                	jae    3aee <malloc+0x48>
    if(p == freep)
    3b1b:	39 05 20 5c 00 00    	cmp    %eax,0x5c20
    3b21:	75 ed                	jne    3b10 <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
    3b23:	89 d8                	mov    %ebx,%eax
    3b25:	e8 2c ff ff ff       	call   3a56 <morecore>
    3b2a:	85 c0                	test   %eax,%eax
    3b2c:	75 e2                	jne    3b10 <malloc+0x6a>
    3b2e:	eb d4                	jmp    3b04 <malloc+0x5e>
