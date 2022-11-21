
usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
       6:	68 b8 40 00 00       	push   $0x40b8
       b:	ff 35 cc 60 00 00    	push   0x60cc
      11:	e8 69 3d 00 00       	call   3d7f <printf>

  if(mkdir("iputdir") < 0){
      16:	c7 04 24 4b 40 00 00 	movl   $0x404b,(%esp)
      1d:	e8 82 3c 00 00       	call   3ca4 <mkdir>
      22:	83 c4 10             	add    $0x10,%esp
      25:	85 c0                	test   %eax,%eax
      27:	78 54                	js     7d <iputtest+0x7d>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }
  if(chdir("iputdir") < 0){
      29:	83 ec 0c             	sub    $0xc,%esp
      2c:	68 4b 40 00 00       	push   $0x404b
      31:	e8 76 3c 00 00       	call   3cac <chdir>
      36:	83 c4 10             	add    $0x10,%esp
      39:	85 c0                	test   %eax,%eax
      3b:	78 5f                	js     9c <iputtest+0x9c>
    printf(stdout, "chdir iputdir failed\n");
    exit(0);
  }
  if(unlink("../iputdir") < 0){
      3d:	83 ec 0c             	sub    $0xc,%esp
      40:	68 48 40 00 00       	push   $0x4048
      45:	e8 42 3c 00 00       	call   3c8c <unlink>
      4a:	83 c4 10             	add    $0x10,%esp
      4d:	85 c0                	test   %eax,%eax
      4f:	78 6a                	js     bb <iputtest+0xbb>
    printf(stdout, "unlink ../iputdir failed\n");
    exit(0);
  }
  if(chdir("/") < 0){
      51:	83 ec 0c             	sub    $0xc,%esp
      54:	68 6d 40 00 00       	push   $0x406d
      59:	e8 4e 3c 00 00       	call   3cac <chdir>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	85 c0                	test   %eax,%eax
      63:	78 75                	js     da <iputtest+0xda>
    printf(stdout, "chdir / failed\n");
    exit(0);
  }
  printf(stdout, "iput test ok\n");
      65:	83 ec 08             	sub    $0x8,%esp
      68:	68 f0 40 00 00       	push   $0x40f0
      6d:	ff 35 cc 60 00 00    	push   0x60cc
      73:	e8 07 3d 00 00       	call   3d7f <printf>
}
      78:	83 c4 10             	add    $0x10,%esp
      7b:	c9                   	leave  
      7c:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
      7d:	83 ec 08             	sub    $0x8,%esp
      80:	68 24 40 00 00       	push   $0x4024
      85:	ff 35 cc 60 00 00    	push   0x60cc
      8b:	e8 ef 3c 00 00       	call   3d7f <printf>
    exit(0);
      90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      97:	e8 a0 3b 00 00       	call   3c3c <exit>
    printf(stdout, "chdir iputdir failed\n");
      9c:	83 ec 08             	sub    $0x8,%esp
      9f:	68 32 40 00 00       	push   $0x4032
      a4:	ff 35 cc 60 00 00    	push   0x60cc
      aa:	e8 d0 3c 00 00       	call   3d7f <printf>
    exit(0);
      af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      b6:	e8 81 3b 00 00       	call   3c3c <exit>
    printf(stdout, "unlink ../iputdir failed\n");
      bb:	83 ec 08             	sub    $0x8,%esp
      be:	68 53 40 00 00       	push   $0x4053
      c3:	ff 35 cc 60 00 00    	push   0x60cc
      c9:	e8 b1 3c 00 00       	call   3d7f <printf>
    exit(0);
      ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      d5:	e8 62 3b 00 00       	call   3c3c <exit>
    printf(stdout, "chdir / failed\n");
      da:	83 ec 08             	sub    $0x8,%esp
      dd:	68 6f 40 00 00       	push   $0x406f
      e2:	ff 35 cc 60 00 00    	push   0x60cc
      e8:	e8 92 3c 00 00       	call   3d7f <printf>
    exit(0);
      ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      f4:	e8 43 3b 00 00       	call   3c3c <exit>

000000f9 <exitiputtest>:

// does exit(0) call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      f9:	55                   	push   %ebp
      fa:	89 e5                	mov    %esp,%ebp
      fc:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      ff:	68 7f 40 00 00       	push   $0x407f
     104:	ff 35 cc 60 00 00    	push   0x60cc
     10a:	e8 70 3c 00 00       	call   3d7f <printf>

  pid = fork();
     10f:	e8 20 3b 00 00       	call   3c34 <fork>
  if(pid < 0){
     114:	83 c4 10             	add    $0x10,%esp
     117:	85 c0                	test   %eax,%eax
     119:	78 4c                	js     167 <exitiputtest+0x6e>
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
     11b:	0f 85 c2 00 00 00    	jne    1e3 <exitiputtest+0xea>
    if(mkdir("iputdir") < 0){
     121:	83 ec 0c             	sub    $0xc,%esp
     124:	68 4b 40 00 00       	push   $0x404b
     129:	e8 76 3b 00 00       	call   3ca4 <mkdir>
     12e:	83 c4 10             	add    $0x10,%esp
     131:	85 c0                	test   %eax,%eax
     133:	78 51                	js     186 <exitiputtest+0x8d>
      printf(stdout, "mkdir failed\n");
      exit(0);
    }
    if(chdir("iputdir") < 0){
     135:	83 ec 0c             	sub    $0xc,%esp
     138:	68 4b 40 00 00       	push   $0x404b
     13d:	e8 6a 3b 00 00       	call   3cac <chdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 5c                	js     1a5 <exitiputtest+0xac>
      printf(stdout, "child chdir failed\n");
      exit(0);
    }
    if(unlink("../iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 48 40 00 00       	push   $0x4048
     151:	e8 36 3b 00 00       	call   3c8c <unlink>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	78 67                	js     1c4 <exitiputtest+0xcb>
      printf(stdout, "unlink ../iputdir failed\n");
      exit(0);
    }
    exit(0);
     15d:	83 ec 0c             	sub    $0xc,%esp
     160:	6a 00                	push   $0x0
     162:	e8 d5 3a 00 00       	call   3c3c <exit>
    printf(stdout, "fork failed\n");
     167:	83 ec 08             	sub    $0x8,%esp
     16a:	68 65 4f 00 00       	push   $0x4f65
     16f:	ff 35 cc 60 00 00    	push   0x60cc
     175:	e8 05 3c 00 00       	call   3d7f <printf>
    exit(0);
     17a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     181:	e8 b6 3a 00 00       	call   3c3c <exit>
      printf(stdout, "mkdir failed\n");
     186:	83 ec 08             	sub    $0x8,%esp
     189:	68 24 40 00 00       	push   $0x4024
     18e:	ff 35 cc 60 00 00    	push   0x60cc
     194:	e8 e6 3b 00 00       	call   3d7f <printf>
      exit(0);
     199:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1a0:	e8 97 3a 00 00       	call   3c3c <exit>
      printf(stdout, "child chdir failed\n");
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 8e 40 00 00       	push   $0x408e
     1ad:	ff 35 cc 60 00 00    	push   0x60cc
     1b3:	e8 c7 3b 00 00       	call   3d7f <printf>
      exit(0);
     1b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1bf:	e8 78 3a 00 00       	call   3c3c <exit>
      printf(stdout, "unlink ../iputdir failed\n");
     1c4:	83 ec 08             	sub    $0x8,%esp
     1c7:	68 53 40 00 00       	push   $0x4053
     1cc:	ff 35 cc 60 00 00    	push   0x60cc
     1d2:	e8 a8 3b 00 00       	call   3d7f <printf>
      exit(0);
     1d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1de:	e8 59 3a 00 00       	call   3c3c <exit>
  }
  wait(NULL);
     1e3:	83 ec 0c             	sub    $0xc,%esp
     1e6:	6a 00                	push   $0x0
     1e8:	e8 57 3a 00 00       	call   3c44 <wait>
  printf(stdout, "exitiput test ok\n");
     1ed:	83 c4 08             	add    $0x8,%esp
     1f0:	68 a2 40 00 00       	push   $0x40a2
     1f5:	ff 35 cc 60 00 00    	push   0x60cc
     1fb:	e8 7f 3b 00 00       	call   3d7f <printf>
}
     200:	83 c4 10             	add    $0x10,%esp
     203:	c9                   	leave  
     204:	c3                   	ret    

00000205 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     205:	55                   	push   %ebp
     206:	89 e5                	mov    %esp,%ebp
     208:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
     20b:	68 b4 40 00 00       	push   $0x40b4
     210:	ff 35 cc 60 00 00    	push   0x60cc
     216:	e8 64 3b 00 00       	call   3d7f <printf>
  if(mkdir("oidir") < 0){
     21b:	c7 04 24 c3 40 00 00 	movl   $0x40c3,(%esp)
     222:	e8 7d 3a 00 00       	call   3ca4 <mkdir>
     227:	83 c4 10             	add    $0x10,%esp
     22a:	85 c0                	test   %eax,%eax
     22c:	78 40                	js     26e <openiputtest+0x69>
    printf(stdout, "mkdir oidir failed\n");
    exit(0);
  }
  pid = fork();
     22e:	e8 01 3a 00 00       	call   3c34 <fork>
  if(pid < 0){
     233:	85 c0                	test   %eax,%eax
     235:	78 56                	js     28d <openiputtest+0x88>
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
     237:	75 7d                	jne    2b6 <openiputtest+0xb1>
    int fd = open("oidir", O_RDWR);
     239:	83 ec 08             	sub    $0x8,%esp
     23c:	6a 02                	push   $0x2
     23e:	68 c3 40 00 00       	push   $0x40c3
     243:	e8 34 3a 00 00       	call   3c7c <open>
    if(fd >= 0){
     248:	83 c4 10             	add    $0x10,%esp
     24b:	85 c0                	test   %eax,%eax
     24d:	78 5d                	js     2ac <openiputtest+0xa7>
      printf(stdout, "open directory for write succeeded\n");
     24f:	83 ec 08             	sub    $0x8,%esp
     252:	68 48 50 00 00       	push   $0x5048
     257:	ff 35 cc 60 00 00    	push   0x60cc
     25d:	e8 1d 3b 00 00       	call   3d7f <printf>
      exit(0);
     262:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     269:	e8 ce 39 00 00       	call   3c3c <exit>
    printf(stdout, "mkdir oidir failed\n");
     26e:	83 ec 08             	sub    $0x8,%esp
     271:	68 c9 40 00 00       	push   $0x40c9
     276:	ff 35 cc 60 00 00    	push   0x60cc
     27c:	e8 fe 3a 00 00       	call   3d7f <printf>
    exit(0);
     281:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     288:	e8 af 39 00 00       	call   3c3c <exit>
    printf(stdout, "fork failed\n");
     28d:	83 ec 08             	sub    $0x8,%esp
     290:	68 65 4f 00 00       	push   $0x4f65
     295:	ff 35 cc 60 00 00    	push   0x60cc
     29b:	e8 df 3a 00 00       	call   3d7f <printf>
    exit(0);
     2a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2a7:	e8 90 39 00 00       	call   3c3c <exit>
    }
    exit(0);
     2ac:	83 ec 0c             	sub    $0xc,%esp
     2af:	6a 00                	push   $0x0
     2b1:	e8 86 39 00 00       	call   3c3c <exit>
  }
  sleep(1);
     2b6:	83 ec 0c             	sub    $0xc,%esp
     2b9:	6a 01                	push   $0x1
     2bb:	e8 0c 3a 00 00       	call   3ccc <sleep>
  if(unlink("oidir") != 0){
     2c0:	c7 04 24 c3 40 00 00 	movl   $0x40c3,(%esp)
     2c7:	e8 c0 39 00 00       	call   3c8c <unlink>
     2cc:	83 c4 10             	add    $0x10,%esp
     2cf:	85 c0                	test   %eax,%eax
     2d1:	75 22                	jne    2f5 <openiputtest+0xf0>
    printf(stdout, "unlink failed\n");
    exit(0);
  }
  wait(NULL);
     2d3:	83 ec 0c             	sub    $0xc,%esp
     2d6:	6a 00                	push   $0x0
     2d8:	e8 67 39 00 00       	call   3c44 <wait>
  printf(stdout, "openiput test ok\n");
     2dd:	83 c4 08             	add    $0x8,%esp
     2e0:	68 ec 40 00 00       	push   $0x40ec
     2e5:	ff 35 cc 60 00 00    	push   0x60cc
     2eb:	e8 8f 3a 00 00       	call   3d7f <printf>
}
     2f0:	83 c4 10             	add    $0x10,%esp
     2f3:	c9                   	leave  
     2f4:	c3                   	ret    
    printf(stdout, "unlink failed\n");
     2f5:	83 ec 08             	sub    $0x8,%esp
     2f8:	68 dd 40 00 00       	push   $0x40dd
     2fd:	ff 35 cc 60 00 00    	push   0x60cc
     303:	e8 77 3a 00 00       	call   3d7f <printf>
    exit(0);
     308:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     30f:	e8 28 39 00 00       	call   3c3c <exit>

00000314 <opentest>:

// simple file system tests

void
opentest(void)
{
     314:	55                   	push   %ebp
     315:	89 e5                	mov    %esp,%ebp
     317:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     31a:	68 fe 40 00 00       	push   $0x40fe
     31f:	ff 35 cc 60 00 00    	push   0x60cc
     325:	e8 55 3a 00 00       	call   3d7f <printf>
  fd = open("echo", 0);
     32a:	83 c4 08             	add    $0x8,%esp
     32d:	6a 00                	push   $0x0
     32f:	68 09 41 00 00       	push   $0x4109
     334:	e8 43 39 00 00       	call   3c7c <open>
  if(fd < 0){
     339:	83 c4 10             	add    $0x10,%esp
     33c:	85 c0                	test   %eax,%eax
     33e:	78 37                	js     377 <opentest+0x63>
    printf(stdout, "open echo failed!\n");
    exit(0);
  }
  close(fd);
     340:	83 ec 0c             	sub    $0xc,%esp
     343:	50                   	push   %eax
     344:	e8 1b 39 00 00       	call   3c64 <close>
  fd = open("doesnotexist", 0);
     349:	83 c4 08             	add    $0x8,%esp
     34c:	6a 00                	push   $0x0
     34e:	68 21 41 00 00       	push   $0x4121
     353:	e8 24 39 00 00       	call   3c7c <open>
  if(fd >= 0){
     358:	83 c4 10             	add    $0x10,%esp
     35b:	85 c0                	test   %eax,%eax
     35d:	79 37                	jns    396 <opentest+0x82>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit(0);
  }
  printf(stdout, "open test ok\n");
     35f:	83 ec 08             	sub    $0x8,%esp
     362:	68 4c 41 00 00       	push   $0x414c
     367:	ff 35 cc 60 00 00    	push   0x60cc
     36d:	e8 0d 3a 00 00       	call   3d7f <printf>
}
     372:	83 c4 10             	add    $0x10,%esp
     375:	c9                   	leave  
     376:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     377:	83 ec 08             	sub    $0x8,%esp
     37a:	68 0e 41 00 00       	push   $0x410e
     37f:	ff 35 cc 60 00 00    	push   0x60cc
     385:	e8 f5 39 00 00       	call   3d7f <printf>
    exit(0);
     38a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     391:	e8 a6 38 00 00       	call   3c3c <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     396:	83 ec 08             	sub    $0x8,%esp
     399:	68 2e 41 00 00       	push   $0x412e
     39e:	ff 35 cc 60 00 00    	push   0x60cc
     3a4:	e8 d6 39 00 00       	call   3d7f <printf>
    exit(0);
     3a9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3b0:	e8 87 38 00 00       	call   3c3c <exit>

000003b5 <writetest>:

void
writetest(void)
{
     3b5:	55                   	push   %ebp
     3b6:	89 e5                	mov    %esp,%ebp
     3b8:	56                   	push   %esi
     3b9:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     3ba:	83 ec 08             	sub    $0x8,%esp
     3bd:	68 5a 41 00 00       	push   $0x415a
     3c2:	ff 35 cc 60 00 00    	push   0x60cc
     3c8:	e8 b2 39 00 00       	call   3d7f <printf>
  fd = open("small", O_CREATE|O_RDWR);
     3cd:	83 c4 08             	add    $0x8,%esp
     3d0:	68 02 02 00 00       	push   $0x202
     3d5:	68 6b 41 00 00       	push   $0x416b
     3da:	e8 9d 38 00 00       	call   3c7c <open>
  if(fd >= 0){
     3df:	83 c4 10             	add    $0x10,%esp
     3e2:	85 c0                	test   %eax,%eax
     3e4:	78 59                	js     43f <writetest+0x8a>
     3e6:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     3e8:	83 ec 08             	sub    $0x8,%esp
     3eb:	68 71 41 00 00       	push   $0x4171
     3f0:	ff 35 cc 60 00 00    	push   0x60cc
     3f6:	e8 84 39 00 00       	call   3d7f <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
     3fb:	83 c4 10             	add    $0x10,%esp
     3fe:	bb 00 00 00 00       	mov    $0x0,%ebx
     403:	83 fb 63             	cmp    $0x63,%ebx
     406:	0f 8f 92 00 00 00    	jg     49e <writetest+0xe9>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     40c:	83 ec 04             	sub    $0x4,%esp
     40f:	6a 0a                	push   $0xa
     411:	68 a8 41 00 00       	push   $0x41a8
     416:	56                   	push   %esi
     417:	e8 40 38 00 00       	call   3c5c <write>
     41c:	83 c4 10             	add    $0x10,%esp
     41f:	83 f8 0a             	cmp    $0xa,%eax
     422:	75 3a                	jne    45e <writetest+0xa9>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     424:	83 ec 04             	sub    $0x4,%esp
     427:	6a 0a                	push   $0xa
     429:	68 b3 41 00 00       	push   $0x41b3
     42e:	56                   	push   %esi
     42f:	e8 28 38 00 00       	call   3c5c <write>
     434:	83 c4 10             	add    $0x10,%esp
     437:	83 f8 0a             	cmp    $0xa,%eax
     43a:	75 42                	jne    47e <writetest+0xc9>
  for(i = 0; i < 100; i++){
     43c:	43                   	inc    %ebx
     43d:	eb c4                	jmp    403 <writetest+0x4e>
    printf(stdout, "error: creat small failed!\n");
     43f:	83 ec 08             	sub    $0x8,%esp
     442:	68 8c 41 00 00       	push   $0x418c
     447:	ff 35 cc 60 00 00    	push   0x60cc
     44d:	e8 2d 39 00 00       	call   3d7f <printf>
    exit(0);
     452:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     459:	e8 de 37 00 00       	call   3c3c <exit>
      printf(stdout, "error: write aa %d new file failed\n", i);
     45e:	83 ec 04             	sub    $0x4,%esp
     461:	53                   	push   %ebx
     462:	68 6c 50 00 00       	push   $0x506c
     467:	ff 35 cc 60 00 00    	push   0x60cc
     46d:	e8 0d 39 00 00       	call   3d7f <printf>
      exit(0);
     472:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     479:	e8 be 37 00 00       	call   3c3c <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     47e:	83 ec 04             	sub    $0x4,%esp
     481:	53                   	push   %ebx
     482:	68 90 50 00 00       	push   $0x5090
     487:	ff 35 cc 60 00 00    	push   0x60cc
     48d:	e8 ed 38 00 00       	call   3d7f <printf>
      exit(0);
     492:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     499:	e8 9e 37 00 00       	call   3c3c <exit>
    }
  }
  printf(stdout, "writes ok\n");
     49e:	83 ec 08             	sub    $0x8,%esp
     4a1:	68 be 41 00 00       	push   $0x41be
     4a6:	ff 35 cc 60 00 00    	push   0x60cc
     4ac:	e8 ce 38 00 00       	call   3d7f <printf>
  close(fd);
     4b1:	89 34 24             	mov    %esi,(%esp)
     4b4:	e8 ab 37 00 00       	call   3c64 <close>
  fd = open("small", O_RDONLY);
     4b9:	83 c4 08             	add    $0x8,%esp
     4bc:	6a 00                	push   $0x0
     4be:	68 6b 41 00 00       	push   $0x416b
     4c3:	e8 b4 37 00 00       	call   3c7c <open>
     4c8:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     4ca:	83 c4 10             	add    $0x10,%esp
     4cd:	85 c0                	test   %eax,%eax
     4cf:	78 7b                	js     54c <writetest+0x197>
    printf(stdout, "open small succeeded ok\n");
     4d1:	83 ec 08             	sub    $0x8,%esp
     4d4:	68 c9 41 00 00       	push   $0x41c9
     4d9:	ff 35 cc 60 00 00    	push   0x60cc
     4df:	e8 9b 38 00 00       	call   3d7f <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit(0);
  }
  i = read(fd, buf, 2000);
     4e4:	83 c4 0c             	add    $0xc,%esp
     4e7:	68 d0 07 00 00       	push   $0x7d0
     4ec:	68 20 88 00 00       	push   $0x8820
     4f1:	53                   	push   %ebx
     4f2:	e8 5d 37 00 00       	call   3c54 <read>
  if(i == 2000){
     4f7:	83 c4 10             	add    $0x10,%esp
     4fa:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     4ff:	75 6a                	jne    56b <writetest+0x1b6>
    printf(stdout, "read succeeded ok\n");
     501:	83 ec 08             	sub    $0x8,%esp
     504:	68 fd 41 00 00       	push   $0x41fd
     509:	ff 35 cc 60 00 00    	push   0x60cc
     50f:	e8 6b 38 00 00       	call   3d7f <printf>
  } else {
    printf(stdout, "read failed\n");
    exit(0);
  }
  close(fd);
     514:	89 1c 24             	mov    %ebx,(%esp)
     517:	e8 48 37 00 00       	call   3c64 <close>

  if(unlink("small") < 0){
     51c:	c7 04 24 6b 41 00 00 	movl   $0x416b,(%esp)
     523:	e8 64 37 00 00       	call   3c8c <unlink>
     528:	83 c4 10             	add    $0x10,%esp
     52b:	85 c0                	test   %eax,%eax
     52d:	78 5b                	js     58a <writetest+0x1d5>
    printf(stdout, "unlink small failed\n");
    exit(0);
  }
  printf(stdout, "small file test ok\n");
     52f:	83 ec 08             	sub    $0x8,%esp
     532:	68 25 42 00 00       	push   $0x4225
     537:	ff 35 cc 60 00 00    	push   0x60cc
     53d:	e8 3d 38 00 00       	call   3d7f <printf>
}
     542:	83 c4 10             	add    $0x10,%esp
     545:	8d 65 f8             	lea    -0x8(%ebp),%esp
     548:	5b                   	pop    %ebx
     549:	5e                   	pop    %esi
     54a:	5d                   	pop    %ebp
     54b:	c3                   	ret    
    printf(stdout, "error: open small failed!\n");
     54c:	83 ec 08             	sub    $0x8,%esp
     54f:	68 e2 41 00 00       	push   $0x41e2
     554:	ff 35 cc 60 00 00    	push   0x60cc
     55a:	e8 20 38 00 00       	call   3d7f <printf>
    exit(0);
     55f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     566:	e8 d1 36 00 00       	call   3c3c <exit>
    printf(stdout, "read failed\n");
     56b:	83 ec 08             	sub    $0x8,%esp
     56e:	68 29 45 00 00       	push   $0x4529
     573:	ff 35 cc 60 00 00    	push   0x60cc
     579:	e8 01 38 00 00       	call   3d7f <printf>
    exit(0);
     57e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     585:	e8 b2 36 00 00       	call   3c3c <exit>
    printf(stdout, "unlink small failed\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 10 42 00 00       	push   $0x4210
     592:	ff 35 cc 60 00 00    	push   0x60cc
     598:	e8 e2 37 00 00       	call   3d7f <printf>
    exit(0);
     59d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     5a4:	e8 93 36 00 00       	call   3c3c <exit>

000005a9 <writetest1>:

void
writetest1(void)
{
     5a9:	55                   	push   %ebp
     5aa:	89 e5                	mov    %esp,%ebp
     5ac:	56                   	push   %esi
     5ad:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     5ae:	83 ec 08             	sub    $0x8,%esp
     5b1:	68 39 42 00 00       	push   $0x4239
     5b6:	ff 35 cc 60 00 00    	push   0x60cc
     5bc:	e8 be 37 00 00       	call   3d7f <printf>

  fd = open("big", O_CREATE|O_RDWR);
     5c1:	83 c4 08             	add    $0x8,%esp
     5c4:	68 02 02 00 00       	push   $0x202
     5c9:	68 b3 42 00 00       	push   $0x42b3
     5ce:	e8 a9 36 00 00       	call   3c7c <open>
  if(fd < 0){
     5d3:	83 c4 10             	add    $0x10,%esp
     5d6:	85 c0                	test   %eax,%eax
     5d8:	78 35                	js     60f <writetest1+0x66>
     5da:	89 c6                	mov    %eax,%esi
    printf(stdout, "error: creat big failed!\n");
    exit(0);
  }

  for(i = 0; i < MAXFILE; i++){
     5dc:	bb 00 00 00 00       	mov    $0x0,%ebx
     5e1:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     5e7:	77 65                	ja     64e <writetest1+0xa5>
    ((int*)buf)[0] = i;
     5e9:	89 1d 20 88 00 00    	mov    %ebx,0x8820
    if(write(fd, buf, 512) != 512){
     5ef:	83 ec 04             	sub    $0x4,%esp
     5f2:	68 00 02 00 00       	push   $0x200
     5f7:	68 20 88 00 00       	push   $0x8820
     5fc:	56                   	push   %esi
     5fd:	e8 5a 36 00 00       	call   3c5c <write>
     602:	83 c4 10             	add    $0x10,%esp
     605:	3d 00 02 00 00       	cmp    $0x200,%eax
     60a:	75 22                	jne    62e <writetest1+0x85>
  for(i = 0; i < MAXFILE; i++){
     60c:	43                   	inc    %ebx
     60d:	eb d2                	jmp    5e1 <writetest1+0x38>
    printf(stdout, "error: creat big failed!\n");
     60f:	83 ec 08             	sub    $0x8,%esp
     612:	68 49 42 00 00       	push   $0x4249
     617:	ff 35 cc 60 00 00    	push   0x60cc
     61d:	e8 5d 37 00 00       	call   3d7f <printf>
    exit(0);
     622:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     629:	e8 0e 36 00 00       	call   3c3c <exit>
      printf(stdout, "error: write big file failed\n", i);
     62e:	83 ec 04             	sub    $0x4,%esp
     631:	53                   	push   %ebx
     632:	68 63 42 00 00       	push   $0x4263
     637:	ff 35 cc 60 00 00    	push   0x60cc
     63d:	e8 3d 37 00 00       	call   3d7f <printf>
      exit(0);
     642:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     649:	e8 ee 35 00 00       	call   3c3c <exit>
    }
  }

  close(fd);
     64e:	83 ec 0c             	sub    $0xc,%esp
     651:	56                   	push   %esi
     652:	e8 0d 36 00 00       	call   3c64 <close>

  fd = open("big", O_RDONLY);
     657:	83 c4 08             	add    $0x8,%esp
     65a:	6a 00                	push   $0x0
     65c:	68 b3 42 00 00       	push   $0x42b3
     661:	e8 16 36 00 00       	call   3c7c <open>
     666:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     668:	83 c4 10             	add    $0x10,%esp
     66b:	85 c0                	test   %eax,%eax
     66d:	78 3a                	js     6a9 <writetest1+0x100>
    printf(stdout, "error: open big failed!\n");
    exit(0);
  }

  n = 0;
     66f:	bb 00 00 00 00       	mov    $0x0,%ebx
  for(;;){
    i = read(fd, buf, 512);
     674:	83 ec 04             	sub    $0x4,%esp
     677:	68 00 02 00 00       	push   $0x200
     67c:	68 20 88 00 00       	push   $0x8820
     681:	56                   	push   %esi
     682:	e8 cd 35 00 00       	call   3c54 <read>
    if(i == 0){
     687:	83 c4 10             	add    $0x10,%esp
     68a:	85 c0                	test   %eax,%eax
     68c:	74 3a                	je     6c8 <writetest1+0x11f>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
     68e:	3d 00 02 00 00       	cmp    $0x200,%eax
     693:	0f 85 90 00 00 00    	jne    729 <writetest1+0x180>
      printf(stdout, "read failed %d\n", i);
      exit(0);
    }
    if(((int*)buf)[0] != n){
     699:	a1 20 88 00 00       	mov    0x8820,%eax
     69e:	39 d8                	cmp    %ebx,%eax
     6a0:	0f 85 a3 00 00 00    	jne    749 <writetest1+0x1a0>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
     6a6:	43                   	inc    %ebx
    i = read(fd, buf, 512);
     6a7:	eb cb                	jmp    674 <writetest1+0xcb>
    printf(stdout, "error: open big failed!\n");
     6a9:	83 ec 08             	sub    $0x8,%esp
     6ac:	68 81 42 00 00       	push   $0x4281
     6b1:	ff 35 cc 60 00 00    	push   0x60cc
     6b7:	e8 c3 36 00 00       	call   3d7f <printf>
    exit(0);
     6bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     6c3:	e8 74 35 00 00       	call   3c3c <exit>
      if(n == MAXFILE - 1){
     6c8:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     6ce:	74 39                	je     709 <writetest1+0x160>
  }
  close(fd);
     6d0:	83 ec 0c             	sub    $0xc,%esp
     6d3:	56                   	push   %esi
     6d4:	e8 8b 35 00 00       	call   3c64 <close>
  if(unlink("big") < 0){
     6d9:	c7 04 24 b3 42 00 00 	movl   $0x42b3,(%esp)
     6e0:	e8 a7 35 00 00       	call   3c8c <unlink>
     6e5:	83 c4 10             	add    $0x10,%esp
     6e8:	85 c0                	test   %eax,%eax
     6ea:	78 7b                	js     767 <writetest1+0x1be>
    printf(stdout, "unlink big failed\n");
    exit(0);
  }
  printf(stdout, "big files ok\n");
     6ec:	83 ec 08             	sub    $0x8,%esp
     6ef:	68 da 42 00 00       	push   $0x42da
     6f4:	ff 35 cc 60 00 00    	push   0x60cc
     6fa:	e8 80 36 00 00       	call   3d7f <printf>
}
     6ff:	83 c4 10             	add    $0x10,%esp
     702:	8d 65 f8             	lea    -0x8(%ebp),%esp
     705:	5b                   	pop    %ebx
     706:	5e                   	pop    %esi
     707:	5d                   	pop    %ebp
     708:	c3                   	ret    
        printf(stdout, "read only %d blocks from big", n);
     709:	83 ec 04             	sub    $0x4,%esp
     70c:	53                   	push   %ebx
     70d:	68 9a 42 00 00       	push   $0x429a
     712:	ff 35 cc 60 00 00    	push   0x60cc
     718:	e8 62 36 00 00       	call   3d7f <printf>
        exit(0);
     71d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     724:	e8 13 35 00 00       	call   3c3c <exit>
      printf(stdout, "read failed %d\n", i);
     729:	83 ec 04             	sub    $0x4,%esp
     72c:	50                   	push   %eax
     72d:	68 b7 42 00 00       	push   $0x42b7
     732:	ff 35 cc 60 00 00    	push   0x60cc
     738:	e8 42 36 00 00       	call   3d7f <printf>
      exit(0);
     73d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     744:	e8 f3 34 00 00       	call   3c3c <exit>
      printf(stdout, "read content of block %d is %d\n",
     749:	50                   	push   %eax
     74a:	53                   	push   %ebx
     74b:	68 b4 50 00 00       	push   $0x50b4
     750:	ff 35 cc 60 00 00    	push   0x60cc
     756:	e8 24 36 00 00       	call   3d7f <printf>
      exit(0);
     75b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     762:	e8 d5 34 00 00       	call   3c3c <exit>
    printf(stdout, "unlink big failed\n");
     767:	83 ec 08             	sub    $0x8,%esp
     76a:	68 c7 42 00 00       	push   $0x42c7
     76f:	ff 35 cc 60 00 00    	push   0x60cc
     775:	e8 05 36 00 00       	call   3d7f <printf>
    exit(0);
     77a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     781:	e8 b6 34 00 00       	call   3c3c <exit>

00000786 <createtest>:

void
createtest(void)
{
     786:	55                   	push   %ebp
     787:	89 e5                	mov    %esp,%ebp
     789:	53                   	push   %ebx
     78a:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     78d:	68 d4 50 00 00       	push   $0x50d4
     792:	ff 35 cc 60 00 00    	push   0x60cc
     798:	e8 e2 35 00 00       	call   3d7f <printf>

  name[0] = 'a';
     79d:	c6 05 10 88 00 00 61 	movb   $0x61,0x8810
  name[2] = '\0';
     7a4:	c6 05 12 88 00 00 00 	movb   $0x0,0x8812
  for(i = 0; i < 52; i++){
     7ab:	83 c4 10             	add    $0x10,%esp
     7ae:	bb 00 00 00 00       	mov    $0x0,%ebx
     7b3:	eb 26                	jmp    7db <createtest+0x55>
    name[1] = '0' + i;
     7b5:	8d 43 30             	lea    0x30(%ebx),%eax
     7b8:	a2 11 88 00 00       	mov    %al,0x8811
    fd = open(name, O_CREATE|O_RDWR);
     7bd:	83 ec 08             	sub    $0x8,%esp
     7c0:	68 02 02 00 00       	push   $0x202
     7c5:	68 10 88 00 00       	push   $0x8810
     7ca:	e8 ad 34 00 00       	call   3c7c <open>
    close(fd);
     7cf:	89 04 24             	mov    %eax,(%esp)
     7d2:	e8 8d 34 00 00       	call   3c64 <close>
  for(i = 0; i < 52; i++){
     7d7:	43                   	inc    %ebx
     7d8:	83 c4 10             	add    $0x10,%esp
     7db:	83 fb 33             	cmp    $0x33,%ebx
     7de:	7e d5                	jle    7b5 <createtest+0x2f>
  }
  name[0] = 'a';
     7e0:	c6 05 10 88 00 00 61 	movb   $0x61,0x8810
  name[2] = '\0';
     7e7:	c6 05 12 88 00 00 00 	movb   $0x0,0x8812
  for(i = 0; i < 52; i++){
     7ee:	bb 00 00 00 00       	mov    $0x0,%ebx
     7f3:	eb 19                	jmp    80e <createtest+0x88>
    name[1] = '0' + i;
     7f5:	8d 43 30             	lea    0x30(%ebx),%eax
     7f8:	a2 11 88 00 00       	mov    %al,0x8811
    unlink(name);
     7fd:	83 ec 0c             	sub    $0xc,%esp
     800:	68 10 88 00 00       	push   $0x8810
     805:	e8 82 34 00 00       	call   3c8c <unlink>
  for(i = 0; i < 52; i++){
     80a:	43                   	inc    %ebx
     80b:	83 c4 10             	add    $0x10,%esp
     80e:	83 fb 33             	cmp    $0x33,%ebx
     811:	7e e2                	jle    7f5 <createtest+0x6f>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     813:	83 ec 08             	sub    $0x8,%esp
     816:	68 fc 50 00 00       	push   $0x50fc
     81b:	ff 35 cc 60 00 00    	push   0x60cc
     821:	e8 59 35 00 00       	call   3d7f <printf>
}
     826:	83 c4 10             	add    $0x10,%esp
     829:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     82c:	c9                   	leave  
     82d:	c3                   	ret    

0000082e <dirtest>:

void dirtest(void)
{
     82e:	55                   	push   %ebp
     82f:	89 e5                	mov    %esp,%ebp
     831:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     834:	68 e8 42 00 00       	push   $0x42e8
     839:	ff 35 cc 60 00 00    	push   0x60cc
     83f:	e8 3b 35 00 00       	call   3d7f <printf>

  if(mkdir("dir0") < 0){
     844:	c7 04 24 f4 42 00 00 	movl   $0x42f4,(%esp)
     84b:	e8 54 34 00 00       	call   3ca4 <mkdir>
     850:	83 c4 10             	add    $0x10,%esp
     853:	85 c0                	test   %eax,%eax
     855:	78 54                	js     8ab <dirtest+0x7d>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }

  if(chdir("dir0") < 0){
     857:	83 ec 0c             	sub    $0xc,%esp
     85a:	68 f4 42 00 00       	push   $0x42f4
     85f:	e8 48 34 00 00       	call   3cac <chdir>
     864:	83 c4 10             	add    $0x10,%esp
     867:	85 c0                	test   %eax,%eax
     869:	78 5f                	js     8ca <dirtest+0x9c>
    printf(stdout, "chdir dir0 failed\n");
    exit(0);
  }

  if(chdir("..") < 0){
     86b:	83 ec 0c             	sub    $0xc,%esp
     86e:	68 99 48 00 00       	push   $0x4899
     873:	e8 34 34 00 00       	call   3cac <chdir>
     878:	83 c4 10             	add    $0x10,%esp
     87b:	85 c0                	test   %eax,%eax
     87d:	78 6a                	js     8e9 <dirtest+0xbb>
    printf(stdout, "chdir .. failed\n");
    exit(0);
  }

  if(unlink("dir0") < 0){
     87f:	83 ec 0c             	sub    $0xc,%esp
     882:	68 f4 42 00 00       	push   $0x42f4
     887:	e8 00 34 00 00       	call   3c8c <unlink>
     88c:	83 c4 10             	add    $0x10,%esp
     88f:	85 c0                	test   %eax,%eax
     891:	78 75                	js     908 <dirtest+0xda>
    printf(stdout, "unlink dir0 failed\n");
    exit(0);
  }
  printf(stdout, "mkdir test ok\n");
     893:	83 ec 08             	sub    $0x8,%esp
     896:	68 31 43 00 00       	push   $0x4331
     89b:	ff 35 cc 60 00 00    	push   0x60cc
     8a1:	e8 d9 34 00 00       	call   3d7f <printf>
}
     8a6:	83 c4 10             	add    $0x10,%esp
     8a9:	c9                   	leave  
     8aa:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     8ab:	83 ec 08             	sub    $0x8,%esp
     8ae:	68 24 40 00 00       	push   $0x4024
     8b3:	ff 35 cc 60 00 00    	push   0x60cc
     8b9:	e8 c1 34 00 00       	call   3d7f <printf>
    exit(0);
     8be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8c5:	e8 72 33 00 00       	call   3c3c <exit>
    printf(stdout, "chdir dir0 failed\n");
     8ca:	83 ec 08             	sub    $0x8,%esp
     8cd:	68 f9 42 00 00       	push   $0x42f9
     8d2:	ff 35 cc 60 00 00    	push   0x60cc
     8d8:	e8 a2 34 00 00       	call   3d7f <printf>
    exit(0);
     8dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8e4:	e8 53 33 00 00       	call   3c3c <exit>
    printf(stdout, "chdir .. failed\n");
     8e9:	83 ec 08             	sub    $0x8,%esp
     8ec:	68 0c 43 00 00       	push   $0x430c
     8f1:	ff 35 cc 60 00 00    	push   0x60cc
     8f7:	e8 83 34 00 00       	call   3d7f <printf>
    exit(0);
     8fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     903:	e8 34 33 00 00       	call   3c3c <exit>
    printf(stdout, "unlink dir0 failed\n");
     908:	83 ec 08             	sub    $0x8,%esp
     90b:	68 1d 43 00 00       	push   $0x431d
     910:	ff 35 cc 60 00 00    	push   0x60cc
     916:	e8 64 34 00 00       	call   3d7f <printf>
    exit(0);
     91b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     922:	e8 15 33 00 00       	call   3c3c <exit>

00000927 <exectest>:

void
exectest(void)
{
     927:	55                   	push   %ebp
     928:	89 e5                	mov    %esp,%ebp
     92a:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     92d:	68 40 43 00 00       	push   $0x4340
     932:	ff 35 cc 60 00 00    	push   0x60cc
     938:	e8 42 34 00 00       	call   3d7f <printf>
  if(exec("echo", echoargv) < 0){
     93d:	83 c4 08             	add    $0x8,%esp
     940:	68 d0 60 00 00       	push   $0x60d0
     945:	68 09 41 00 00       	push   $0x4109
     94a:	e8 25 33 00 00       	call   3c74 <exec>
     94f:	83 c4 10             	add    $0x10,%esp
     952:	85 c0                	test   %eax,%eax
     954:	78 02                	js     958 <exectest+0x31>
    printf(stdout, "exec echo failed\n");
    exit(0);
  }
}
     956:	c9                   	leave  
     957:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     958:	83 ec 08             	sub    $0x8,%esp
     95b:	68 4b 43 00 00       	push   $0x434b
     960:	ff 35 cc 60 00 00    	push   0x60cc
     966:	e8 14 34 00 00       	call   3d7f <printf>
    exit(0);
     96b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     972:	e8 c5 32 00 00       	call   3c3c <exit>

00000977 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     977:	55                   	push   %ebp
     978:	89 e5                	mov    %esp,%ebp
     97a:	57                   	push   %edi
     97b:	56                   	push   %esi
     97c:	53                   	push   %ebx
     97d:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     980:	8d 45 e0             	lea    -0x20(%ebp),%eax
     983:	50                   	push   %eax
     984:	e8 c3 32 00 00       	call   3c4c <pipe>
     989:	83 c4 10             	add    $0x10,%esp
     98c:	85 c0                	test   %eax,%eax
     98e:	75 76                	jne    a06 <pipe1+0x8f>
     990:	89 c6                	mov    %eax,%esi
    printf(1, "pipe() failed\n");
    exit(0);
  }
  pid = fork();
     992:	e8 9d 32 00 00       	call   3c34 <fork>
     997:	89 c7                	mov    %eax,%edi
  seq = 0;
  if(pid == 0){
     999:	85 c0                	test   %eax,%eax
     99b:	0f 84 80 00 00 00    	je     a21 <pipe1+0xaa>
        printf(1, "pipe1 oops 1\n");
        exit(0);
      }
    }
    exit(0);
  } else if(pid > 0){
     9a1:	0f 8e 7d 01 00 00    	jle    b24 <pipe1+0x1ad>
    close(fds[1]);
     9a7:	83 ec 0c             	sub    $0xc,%esp
     9aa:	ff 75 e4             	push   -0x1c(%ebp)
     9ad:	e8 b2 32 00 00       	call   3c64 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     9b2:	83 c4 10             	add    $0x10,%esp
    total = 0;
     9b5:	89 75 d0             	mov    %esi,-0x30(%ebp)
  seq = 0;
     9b8:	89 f3                	mov    %esi,%ebx
    cc = 1;
     9ba:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     9c1:	83 ec 04             	sub    $0x4,%esp
     9c4:	ff 75 d4             	push   -0x2c(%ebp)
     9c7:	68 20 88 00 00       	push   $0x8820
     9cc:	ff 75 e0             	push   -0x20(%ebp)
     9cf:	e8 80 32 00 00       	call   3c54 <read>
     9d4:	89 c7                	mov    %eax,%edi
     9d6:	83 c4 10             	add    $0x10,%esp
     9d9:	85 c0                	test   %eax,%eax
     9db:	0f 8e f1 00 00 00    	jle    ad2 <pipe1+0x15b>
      for(i = 0; i < n; i++){
     9e1:	89 f0                	mov    %esi,%eax
     9e3:	89 d9                	mov    %ebx,%ecx
     9e5:	39 f8                	cmp    %edi,%eax
     9e7:	0f 8d c1 00 00 00    	jge    aae <pipe1+0x137>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     9ed:	0f be 98 20 88 00 00 	movsbl 0x8820(%eax),%ebx
     9f4:	8d 51 01             	lea    0x1(%ecx),%edx
     9f7:	31 cb                	xor    %ecx,%ebx
     9f9:	84 db                	test   %bl,%bl
     9fb:	0f 85 93 00 00 00    	jne    a94 <pipe1+0x11d>
      for(i = 0; i < n; i++){
     a01:	40                   	inc    %eax
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a02:	89 d1                	mov    %edx,%ecx
     a04:	eb df                	jmp    9e5 <pipe1+0x6e>
    printf(1, "pipe() failed\n");
     a06:	83 ec 08             	sub    $0x8,%esp
     a09:	68 5d 43 00 00       	push   $0x435d
     a0e:	6a 01                	push   $0x1
     a10:	e8 6a 33 00 00       	call   3d7f <printf>
    exit(0);
     a15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a1c:	e8 1b 32 00 00       	call   3c3c <exit>
    close(fds[0]);
     a21:	83 ec 0c             	sub    $0xc,%esp
     a24:	ff 75 e0             	push   -0x20(%ebp)
     a27:	e8 38 32 00 00       	call   3c64 <close>
    for(n = 0; n < 5; n++){
     a2c:	83 c4 10             	add    $0x10,%esp
     a2f:	89 fe                	mov    %edi,%esi
  seq = 0;
     a31:	89 fb                	mov    %edi,%ebx
    for(n = 0; n < 5; n++){
     a33:	eb 31                	jmp    a66 <pipe1+0xef>
        buf[i] = seq++;
     a35:	88 98 20 88 00 00    	mov    %bl,0x8820(%eax)
      for(i = 0; i < 1033; i++)
     a3b:	40                   	inc    %eax
        buf[i] = seq++;
     a3c:	8d 5b 01             	lea    0x1(%ebx),%ebx
      for(i = 0; i < 1033; i++)
     a3f:	3d 08 04 00 00       	cmp    $0x408,%eax
     a44:	7e ef                	jle    a35 <pipe1+0xbe>
      if(write(fds[1], buf, 1033) != 1033){
     a46:	83 ec 04             	sub    $0x4,%esp
     a49:	68 09 04 00 00       	push   $0x409
     a4e:	68 20 88 00 00       	push   $0x8820
     a53:	ff 75 e4             	push   -0x1c(%ebp)
     a56:	e8 01 32 00 00       	call   3c5c <write>
     a5b:	83 c4 10             	add    $0x10,%esp
     a5e:	3d 09 04 00 00       	cmp    $0x409,%eax
     a63:	75 0a                	jne    a6f <pipe1+0xf8>
    for(n = 0; n < 5; n++){
     a65:	46                   	inc    %esi
     a66:	83 fe 04             	cmp    $0x4,%esi
     a69:	7f 1f                	jg     a8a <pipe1+0x113>
      for(i = 0; i < 1033; i++)
     a6b:	89 f8                	mov    %edi,%eax
     a6d:	eb d0                	jmp    a3f <pipe1+0xc8>
        printf(1, "pipe1 oops 1\n");
     a6f:	83 ec 08             	sub    $0x8,%esp
     a72:	68 6c 43 00 00       	push   $0x436c
     a77:	6a 01                	push   $0x1
     a79:	e8 01 33 00 00       	call   3d7f <printf>
        exit(0);
     a7e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a85:	e8 b2 31 00 00       	call   3c3c <exit>
    exit(0);
     a8a:	83 ec 0c             	sub    $0xc,%esp
     a8d:	6a 00                	push   $0x0
     a8f:	e8 a8 31 00 00       	call   3c3c <exit>
          printf(1, "pipe1 oops 2\n");
     a94:	83 ec 08             	sub    $0x8,%esp
     a97:	68 7a 43 00 00       	push   $0x437a
     a9c:	6a 01                	push   $0x1
     a9e:	e8 dc 32 00 00       	call   3d7f <printf>
          return;
     aa3:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit(0);
  }
  printf(1, "pipe1 ok\n");
}
     aa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aa9:	5b                   	pop    %ebx
     aaa:	5e                   	pop    %esi
     aab:	5f                   	pop    %edi
     aac:	5d                   	pop    %ebp
     aad:	c3                   	ret    
      total += n;
     aae:	89 cb                	mov    %ecx,%ebx
     ab0:	01 7d d0             	add    %edi,-0x30(%ebp)
      cc = cc * 2;
     ab3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     ab6:	01 c0                	add    %eax,%eax
     ab8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
      if(cc > sizeof(buf))
     abb:	3d 00 20 00 00       	cmp    $0x2000,%eax
     ac0:	0f 86 fb fe ff ff    	jbe    9c1 <pipe1+0x4a>
        cc = sizeof(buf);
     ac6:	c7 45 d4 00 20 00 00 	movl   $0x2000,-0x2c(%ebp)
     acd:	e9 ef fe ff ff       	jmp    9c1 <pipe1+0x4a>
    if(total != 5 * 1033){
     ad2:	81 7d d0 2d 14 00 00 	cmpl   $0x142d,-0x30(%ebp)
     ad9:	75 2b                	jne    b06 <pipe1+0x18f>
    close(fds[0]);
     adb:	83 ec 0c             	sub    $0xc,%esp
     ade:	ff 75 e0             	push   -0x20(%ebp)
     ae1:	e8 7e 31 00 00       	call   3c64 <close>
    wait(NULL);
     ae6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     aed:	e8 52 31 00 00       	call   3c44 <wait>
  printf(1, "pipe1 ok\n");
     af2:	83 c4 08             	add    $0x8,%esp
     af5:	68 9f 43 00 00       	push   $0x439f
     afa:	6a 01                	push   $0x1
     afc:	e8 7e 32 00 00       	call   3d7f <printf>
     b01:	83 c4 10             	add    $0x10,%esp
     b04:	eb a0                	jmp    aa6 <pipe1+0x12f>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b06:	83 ec 04             	sub    $0x4,%esp
     b09:	ff 75 d0             	push   -0x30(%ebp)
     b0c:	68 88 43 00 00       	push   $0x4388
     b11:	6a 01                	push   $0x1
     b13:	e8 67 32 00 00       	call   3d7f <printf>
      exit(0);
     b18:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b1f:	e8 18 31 00 00       	call   3c3c <exit>
    printf(1, "fork() failed\n");
     b24:	83 ec 08             	sub    $0x8,%esp
     b27:	68 a9 43 00 00       	push   $0x43a9
     b2c:	6a 01                	push   $0x1
     b2e:	e8 4c 32 00 00       	call   3d7f <printf>
    exit(0);
     b33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b3a:	e8 fd 30 00 00       	call   3c3c <exit>

00000b3f <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     b3f:	55                   	push   %ebp
     b40:	89 e5                	mov    %esp,%ebp
     b42:	57                   	push   %edi
     b43:	56                   	push   %esi
     b44:	53                   	push   %ebx
     b45:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     b48:	68 b8 43 00 00       	push   $0x43b8
     b4d:	6a 01                	push   $0x1
     b4f:	e8 2b 32 00 00       	call   3d7f <printf>
  pid1 = fork();
     b54:	e8 db 30 00 00       	call   3c34 <fork>
  if(pid1 == 0)
     b59:	83 c4 10             	add    $0x10,%esp
     b5c:	85 c0                	test   %eax,%eax
     b5e:	75 02                	jne    b62 <preempt+0x23>
    for(;;)
     b60:	eb fe                	jmp    b60 <preempt+0x21>
     b62:	89 c3                	mov    %eax,%ebx
      ;

  pid2 = fork();
     b64:	e8 cb 30 00 00       	call   3c34 <fork>
     b69:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     b6b:	85 c0                	test   %eax,%eax
     b6d:	75 02                	jne    b71 <preempt+0x32>
    for(;;)
     b6f:	eb fe                	jmp    b6f <preempt+0x30>
      ;

  pipe(pfds);
     b71:	83 ec 0c             	sub    $0xc,%esp
     b74:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b77:	50                   	push   %eax
     b78:	e8 cf 30 00 00       	call   3c4c <pipe>
  pid3 = fork();
     b7d:	e8 b2 30 00 00       	call   3c34 <fork>
     b82:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     b84:	83 c4 10             	add    $0x10,%esp
     b87:	85 c0                	test   %eax,%eax
     b89:	75 49                	jne    bd4 <preempt+0x95>
    close(pfds[0]);
     b8b:	83 ec 0c             	sub    $0xc,%esp
     b8e:	ff 75 e0             	push   -0x20(%ebp)
     b91:	e8 ce 30 00 00       	call   3c64 <close>
    if(write(pfds[1], "x", 1) != 1)
     b96:	83 c4 0c             	add    $0xc,%esp
     b99:	6a 01                	push   $0x1
     b9b:	68 7d 49 00 00       	push   $0x497d
     ba0:	ff 75 e4             	push   -0x1c(%ebp)
     ba3:	e8 b4 30 00 00       	call   3c5c <write>
     ba8:	83 c4 10             	add    $0x10,%esp
     bab:	83 f8 01             	cmp    $0x1,%eax
     bae:	75 10                	jne    bc0 <preempt+0x81>
      printf(1, "preempt write error");
    close(pfds[1]);
     bb0:	83 ec 0c             	sub    $0xc,%esp
     bb3:	ff 75 e4             	push   -0x1c(%ebp)
     bb6:	e8 a9 30 00 00       	call   3c64 <close>
     bbb:	83 c4 10             	add    $0x10,%esp
    for(;;)
     bbe:	eb fe                	jmp    bbe <preempt+0x7f>
      printf(1, "preempt write error");
     bc0:	83 ec 08             	sub    $0x8,%esp
     bc3:	68 c2 43 00 00       	push   $0x43c2
     bc8:	6a 01                	push   $0x1
     bca:	e8 b0 31 00 00       	call   3d7f <printf>
     bcf:	83 c4 10             	add    $0x10,%esp
     bd2:	eb dc                	jmp    bb0 <preempt+0x71>
      ;
  }

  close(pfds[1]);
     bd4:	83 ec 0c             	sub    $0xc,%esp
     bd7:	ff 75 e4             	push   -0x1c(%ebp)
     bda:	e8 85 30 00 00       	call   3c64 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     bdf:	83 c4 0c             	add    $0xc,%esp
     be2:	68 00 20 00 00       	push   $0x2000
     be7:	68 20 88 00 00       	push   $0x8820
     bec:	ff 75 e0             	push   -0x20(%ebp)
     bef:	e8 60 30 00 00       	call   3c54 <read>
     bf4:	83 c4 10             	add    $0x10,%esp
     bf7:	83 f8 01             	cmp    $0x1,%eax
     bfa:	74 1a                	je     c16 <preempt+0xd7>
    printf(1, "preempt read error");
     bfc:	83 ec 08             	sub    $0x8,%esp
     bff:	68 d6 43 00 00       	push   $0x43d6
     c04:	6a 01                	push   $0x1
     c06:	e8 74 31 00 00       	call   3d7f <printf>
    return;
     c0b:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait(NULL);
  wait(NULL);
  wait(NULL);
  printf(1, "preempt ok\n");
}
     c0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c11:	5b                   	pop    %ebx
     c12:	5e                   	pop    %esi
     c13:	5f                   	pop    %edi
     c14:	5d                   	pop    %ebp
     c15:	c3                   	ret    
  close(pfds[0]);
     c16:	83 ec 0c             	sub    $0xc,%esp
     c19:	ff 75 e0             	push   -0x20(%ebp)
     c1c:	e8 43 30 00 00       	call   3c64 <close>
  printf(1, "kill... ");
     c21:	83 c4 08             	add    $0x8,%esp
     c24:	68 e9 43 00 00       	push   $0x43e9
     c29:	6a 01                	push   $0x1
     c2b:	e8 4f 31 00 00       	call   3d7f <printf>
  kill(pid1);
     c30:	89 1c 24             	mov    %ebx,(%esp)
     c33:	e8 34 30 00 00       	call   3c6c <kill>
  kill(pid2);
     c38:	89 34 24             	mov    %esi,(%esp)
     c3b:	e8 2c 30 00 00       	call   3c6c <kill>
  kill(pid3);
     c40:	89 3c 24             	mov    %edi,(%esp)
     c43:	e8 24 30 00 00       	call   3c6c <kill>
  printf(1, "wait... ");
     c48:	83 c4 08             	add    $0x8,%esp
     c4b:	68 f2 43 00 00       	push   $0x43f2
     c50:	6a 01                	push   $0x1
     c52:	e8 28 31 00 00       	call   3d7f <printf>
  wait(NULL);
     c57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c5e:	e8 e1 2f 00 00       	call   3c44 <wait>
  wait(NULL);
     c63:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c6a:	e8 d5 2f 00 00       	call   3c44 <wait>
  wait(NULL);
     c6f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c76:	e8 c9 2f 00 00       	call   3c44 <wait>
  printf(1, "preempt ok\n");
     c7b:	83 c4 08             	add    $0x8,%esp
     c7e:	68 fb 43 00 00       	push   $0x43fb
     c83:	6a 01                	push   $0x1
     c85:	e8 f5 30 00 00       	call   3d7f <printf>
     c8a:	83 c4 10             	add    $0x10,%esp
     c8d:	e9 7c ff ff ff       	jmp    c0e <preempt+0xcf>

00000c92 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     c92:	55                   	push   %ebp
     c93:	89 e5                	mov    %esp,%ebp
     c95:	56                   	push   %esi
     c96:	53                   	push   %ebx
  int i, pid;

  for(i = 0; i < 100; i++){
     c97:	be 00 00 00 00       	mov    $0x0,%esi
     c9c:	83 fe 63             	cmp    $0x63,%esi
     c9f:	7f 58                	jg     cf9 <exitwait+0x67>
    pid = fork();
     ca1:	e8 8e 2f 00 00       	call   3c34 <fork>
     ca6:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     ca8:	85 c0                	test   %eax,%eax
     caa:	78 16                	js     cc2 <exitwait+0x30>
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     cac:	74 41                	je     cef <exitwait+0x5d>
      if(wait(NULL) != pid){
     cae:	83 ec 0c             	sub    $0xc,%esp
     cb1:	6a 00                	push   $0x0
     cb3:	e8 8c 2f 00 00       	call   3c44 <wait>
     cb8:	83 c4 10             	add    $0x10,%esp
     cbb:	39 d8                	cmp    %ebx,%eax
     cbd:	75 1c                	jne    cdb <exitwait+0x49>
  for(i = 0; i < 100; i++){
     cbf:	46                   	inc    %esi
     cc0:	eb da                	jmp    c9c <exitwait+0xa>
      printf(1, "fork failed\n");
     cc2:	83 ec 08             	sub    $0x8,%esp
     cc5:	68 65 4f 00 00       	push   $0x4f65
     cca:	6a 01                	push   $0x1
     ccc:	e8 ae 30 00 00       	call   3d7f <printf>
      return;
     cd1:	83 c4 10             	add    $0x10,%esp
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
     cd4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cd7:	5b                   	pop    %ebx
     cd8:	5e                   	pop    %esi
     cd9:	5d                   	pop    %ebp
     cda:	c3                   	ret    
        printf(1, "wait wrong pid\n");
     cdb:	83 ec 08             	sub    $0x8,%esp
     cde:	68 07 44 00 00       	push   $0x4407
     ce3:	6a 01                	push   $0x1
     ce5:	e8 95 30 00 00       	call   3d7f <printf>
        return;
     cea:	83 c4 10             	add    $0x10,%esp
     ced:	eb e5                	jmp    cd4 <exitwait+0x42>
      exit(0);
     cef:	83 ec 0c             	sub    $0xc,%esp
     cf2:	6a 00                	push   $0x0
     cf4:	e8 43 2f 00 00       	call   3c3c <exit>
  printf(1, "exitwait ok\n");
     cf9:	83 ec 08             	sub    $0x8,%esp
     cfc:	68 17 44 00 00       	push   $0x4417
     d01:	6a 01                	push   $0x1
     d03:	e8 77 30 00 00       	call   3d7f <printf>
     d08:	83 c4 10             	add    $0x10,%esp
     d0b:	eb c7                	jmp    cd4 <exitwait+0x42>

00000d0d <mem>:

void
mem(void)
{
     d0d:	55                   	push   %ebp
     d0e:	89 e5                	mov    %esp,%ebp
     d10:	57                   	push   %edi
     d11:	56                   	push   %esi
     d12:	53                   	push   %ebx
     d13:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     d16:	68 24 44 00 00       	push   $0x4424
     d1b:	6a 01                	push   $0x1
     d1d:	e8 5d 30 00 00       	call   3d7f <printf>
  ppid = getpid();
     d22:	e8 95 2f 00 00       	call   3cbc <getpid>
     d27:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     d29:	e8 06 2f 00 00       	call   3c34 <fork>
     d2e:	83 c4 10             	add    $0x10,%esp
     d31:	85 c0                	test   %eax,%eax
     d33:	0f 85 90 00 00 00    	jne    dc9 <mem+0xbc>
    m1 = 0;
     d39:	bb 00 00 00 00       	mov    $0x0,%ebx
     d3e:	eb 04                	jmp    d44 <mem+0x37>
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     d40:	89 18                	mov    %ebx,(%eax)
      m1 = m2;
     d42:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     d44:	83 ec 0c             	sub    $0xc,%esp
     d47:	68 11 27 00 00       	push   $0x2711
     d4c:	e8 4e 32 00 00       	call   3f9f <malloc>
     d51:	83 c4 10             	add    $0x10,%esp
     d54:	85 c0                	test   %eax,%eax
     d56:	75 e8                	jne    d40 <mem+0x33>
     d58:	eb 10                	jmp    d6a <mem+0x5d>
    }
    while(m1){
      m2 = *(char**)m1;
     d5a:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     d5c:	83 ec 0c             	sub    $0xc,%esp
     d5f:	53                   	push   %ebx
     d60:	e8 7a 31 00 00       	call   3edf <free>
     d65:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     d68:	89 fb                	mov    %edi,%ebx
    while(m1){
     d6a:	85 db                	test   %ebx,%ebx
     d6c:	75 ec                	jne    d5a <mem+0x4d>
    }
    m1 = malloc(1024*20);
     d6e:	83 ec 0c             	sub    $0xc,%esp
     d71:	68 00 50 00 00       	push   $0x5000
     d76:	e8 24 32 00 00       	call   3f9f <malloc>
    if(m1 == 0){
     d7b:	83 c4 10             	add    $0x10,%esp
     d7e:	85 c0                	test   %eax,%eax
     d80:	74 24                	je     da6 <mem+0x99>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit(0);
    }
    free(m1);
     d82:	83 ec 0c             	sub    $0xc,%esp
     d85:	50                   	push   %eax
     d86:	e8 54 31 00 00       	call   3edf <free>
    printf(1, "mem ok\n");
     d8b:	83 c4 08             	add    $0x8,%esp
     d8e:	68 48 44 00 00       	push   $0x4448
     d93:	6a 01                	push   $0x1
     d95:	e8 e5 2f 00 00       	call   3d7f <printf>
    exit(0);
     d9a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     da1:	e8 96 2e 00 00       	call   3c3c <exit>
      printf(1, "couldn't allocate mem?!!\n");
     da6:	83 ec 08             	sub    $0x8,%esp
     da9:	68 2e 44 00 00       	push   $0x442e
     dae:	6a 01                	push   $0x1
     db0:	e8 ca 2f 00 00       	call   3d7f <printf>
      kill(ppid);
     db5:	89 34 24             	mov    %esi,(%esp)
     db8:	e8 af 2e 00 00       	call   3c6c <kill>
      exit(0);
     dbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     dc4:	e8 73 2e 00 00       	call   3c3c <exit>
  } else {
    wait(NULL);
     dc9:	83 ec 0c             	sub    $0xc,%esp
     dcc:	6a 00                	push   $0x0
     dce:	e8 71 2e 00 00       	call   3c44 <wait>
  }
}
     dd3:	83 c4 10             	add    $0x10,%esp
     dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dd9:	5b                   	pop    %ebx
     dda:	5e                   	pop    %esi
     ddb:	5f                   	pop    %edi
     ddc:	5d                   	pop    %ebp
     ddd:	c3                   	ret    

00000dde <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     dde:	55                   	push   %ebp
     ddf:	89 e5                	mov    %esp,%ebp
     de1:	57                   	push   %edi
     de2:	56                   	push   %esi
     de3:	53                   	push   %ebx
     de4:	83 ec 24             	sub    $0x24,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     de7:	68 50 44 00 00       	push   $0x4450
     dec:	6a 01                	push   $0x1
     dee:	e8 8c 2f 00 00       	call   3d7f <printf>

  unlink("sharedfd");
     df3:	c7 04 24 5f 44 00 00 	movl   $0x445f,(%esp)
     dfa:	e8 8d 2e 00 00       	call   3c8c <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     dff:	83 c4 08             	add    $0x8,%esp
     e02:	68 02 02 00 00       	push   $0x202
     e07:	68 5f 44 00 00       	push   $0x445f
     e0c:	e8 6b 2e 00 00       	call   3c7c <open>
  if(fd < 0){
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	85 c0                	test   %eax,%eax
     e16:	78 4b                	js     e63 <sharedfd+0x85>
     e18:	89 c6                	mov    %eax,%esi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     e1a:	e8 15 2e 00 00       	call   3c34 <fork>
     e1f:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e21:	85 c0                	test   %eax,%eax
     e23:	75 55                	jne    e7a <sharedfd+0x9c>
     e25:	b8 63 00 00 00       	mov    $0x63,%eax
     e2a:	83 ec 04             	sub    $0x4,%esp
     e2d:	6a 0a                	push   $0xa
     e2f:	50                   	push   %eax
     e30:	8d 45 de             	lea    -0x22(%ebp),%eax
     e33:	50                   	push   %eax
     e34:	e8 d8 2c 00 00       	call   3b11 <memset>
  for(i = 0; i < 1000; i++){
     e39:	83 c4 10             	add    $0x10,%esp
     e3c:	bb 00 00 00 00       	mov    $0x0,%ebx
     e41:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
     e47:	7f 4a                	jg     e93 <sharedfd+0xb5>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     e49:	83 ec 04             	sub    $0x4,%esp
     e4c:	6a 0a                	push   $0xa
     e4e:	8d 45 de             	lea    -0x22(%ebp),%eax
     e51:	50                   	push   %eax
     e52:	56                   	push   %esi
     e53:	e8 04 2e 00 00       	call   3c5c <write>
     e58:	83 c4 10             	add    $0x10,%esp
     e5b:	83 f8 0a             	cmp    $0xa,%eax
     e5e:	75 21                	jne    e81 <sharedfd+0xa3>
  for(i = 0; i < 1000; i++){
     e60:	43                   	inc    %ebx
     e61:	eb de                	jmp    e41 <sharedfd+0x63>
    printf(1, "fstests: cannot open sharedfd for writing");
     e63:	83 ec 08             	sub    $0x8,%esp
     e66:	68 24 51 00 00       	push   $0x5124
     e6b:	6a 01                	push   $0x1
     e6d:	e8 0d 2f 00 00       	call   3d7f <printf>
    return;
     e72:	83 c4 10             	add    $0x10,%esp
     e75:	e9 de 00 00 00       	jmp    f58 <sharedfd+0x17a>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e7a:	b8 70 00 00 00       	mov    $0x70,%eax
     e7f:	eb a9                	jmp    e2a <sharedfd+0x4c>
      printf(1, "fstests: write sharedfd failed\n");
     e81:	83 ec 08             	sub    $0x8,%esp
     e84:	68 50 51 00 00       	push   $0x5150
     e89:	6a 01                	push   $0x1
     e8b:	e8 ef 2e 00 00       	call   3d7f <printf>
      break;
     e90:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
     e93:	85 ff                	test   %edi,%edi
     e95:	74 51                	je     ee8 <sharedfd+0x10a>
    exit(0);
  else
    wait(NULL);
     e97:	83 ec 0c             	sub    $0xc,%esp
     e9a:	6a 00                	push   $0x0
     e9c:	e8 a3 2d 00 00       	call   3c44 <wait>
  close(fd);
     ea1:	89 34 24             	mov    %esi,(%esp)
     ea4:	e8 bb 2d 00 00       	call   3c64 <close>
  fd = open("sharedfd", 0);
     ea9:	83 c4 08             	add    $0x8,%esp
     eac:	6a 00                	push   $0x0
     eae:	68 5f 44 00 00       	push   $0x445f
     eb3:	e8 c4 2d 00 00       	call   3c7c <open>
     eb8:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     eba:	83 c4 10             	add    $0x10,%esp
     ebd:	85 c0                	test   %eax,%eax
     ebf:	78 31                	js     ef2 <sharedfd+0x114>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
     ec1:	be 00 00 00 00       	mov    $0x0,%esi
     ec6:	bb 00 00 00 00       	mov    $0x0,%ebx
  while((n = read(fd, buf, sizeof(buf))) > 0){
     ecb:	83 ec 04             	sub    $0x4,%esp
     ece:	6a 0a                	push   $0xa
     ed0:	8d 45 de             	lea    -0x22(%ebp),%eax
     ed3:	50                   	push   %eax
     ed4:	57                   	push   %edi
     ed5:	e8 7a 2d 00 00       	call   3c54 <read>
     eda:	83 c4 10             	add    $0x10,%esp
     edd:	85 c0                	test   %eax,%eax
     edf:	7e 3d                	jle    f1e <sharedfd+0x140>
    for(i = 0; i < sizeof(buf); i++){
     ee1:	ba 00 00 00 00       	mov    $0x0,%edx
     ee6:	eb 23                	jmp    f0b <sharedfd+0x12d>
    exit(0);
     ee8:	83 ec 0c             	sub    $0xc,%esp
     eeb:	6a 00                	push   $0x0
     eed:	e8 4a 2d 00 00       	call   3c3c <exit>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     ef2:	83 ec 08             	sub    $0x8,%esp
     ef5:	68 70 51 00 00       	push   $0x5170
     efa:	6a 01                	push   $0x1
     efc:	e8 7e 2e 00 00       	call   3d7f <printf>
    return;
     f01:	83 c4 10             	add    $0x10,%esp
     f04:	eb 52                	jmp    f58 <sharedfd+0x17a>
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
     f06:	3c 70                	cmp    $0x70,%al
     f08:	74 11                	je     f1b <sharedfd+0x13d>
    for(i = 0; i < sizeof(buf); i++){
     f0a:	42                   	inc    %edx
     f0b:	83 fa 09             	cmp    $0x9,%edx
     f0e:	77 bb                	ja     ecb <sharedfd+0xed>
      if(buf[i] == 'c')
     f10:	8a 44 15 de          	mov    -0x22(%ebp,%edx,1),%al
     f14:	3c 63                	cmp    $0x63,%al
     f16:	75 ee                	jne    f06 <sharedfd+0x128>
        nc++;
     f18:	43                   	inc    %ebx
     f19:	eb eb                	jmp    f06 <sharedfd+0x128>
        np++;
     f1b:	46                   	inc    %esi
     f1c:	eb ec                	jmp    f0a <sharedfd+0x12c>
    }
  }
  close(fd);
     f1e:	83 ec 0c             	sub    $0xc,%esp
     f21:	57                   	push   %edi
     f22:	e8 3d 2d 00 00       	call   3c64 <close>
  unlink("sharedfd");
     f27:	c7 04 24 5f 44 00 00 	movl   $0x445f,(%esp)
     f2e:	e8 59 2d 00 00       	call   3c8c <unlink>
  if(nc == 10000 && np == 10000){
     f33:	83 c4 10             	add    $0x10,%esp
     f36:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f3c:	75 22                	jne    f60 <sharedfd+0x182>
     f3e:	81 fe 10 27 00 00    	cmp    $0x2710,%esi
     f44:	75 1a                	jne    f60 <sharedfd+0x182>
    printf(1, "sharedfd ok\n");
     f46:	83 ec 08             	sub    $0x8,%esp
     f49:	68 68 44 00 00       	push   $0x4468
     f4e:	6a 01                	push   $0x1
     f50:	e8 2a 2e 00 00       	call   3d7f <printf>
     f55:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(0);
  }
}
     f58:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f5b:	5b                   	pop    %ebx
     f5c:	5e                   	pop    %esi
     f5d:	5f                   	pop    %edi
     f5e:	5d                   	pop    %ebp
     f5f:	c3                   	ret    
    printf(1, "sharedfd oops %d %d\n", nc, np);
     f60:	56                   	push   %esi
     f61:	53                   	push   %ebx
     f62:	68 75 44 00 00       	push   $0x4475
     f67:	6a 01                	push   $0x1
     f69:	e8 11 2e 00 00       	call   3d7f <printf>
    exit(0);
     f6e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f75:	e8 c2 2c 00 00       	call   3c3c <exit>

00000f7a <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
     f7a:	55                   	push   %ebp
     f7b:	89 e5                	mov    %esp,%ebp
     f7d:	57                   	push   %edi
     f7e:	56                   	push   %esi
     f7f:	53                   	push   %ebx
     f80:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
     f83:	8d 7d d8             	lea    -0x28(%ebp),%edi
     f86:	be bc 57 00 00       	mov    $0x57bc,%esi
     f8b:	b9 04 00 00 00       	mov    $0x4,%ecx
     f90:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
     f92:	68 8a 44 00 00       	push   $0x448a
     f97:	6a 01                	push   $0x1
     f99:	e8 e1 2d 00 00       	call   3d7f <printf>

  for(pi = 0; pi < 4; pi++){
     f9e:	83 c4 10             	add    $0x10,%esp
     fa1:	be 00 00 00 00       	mov    $0x0,%esi
     fa6:	eb 5d                	jmp    1005 <fourfiles+0x8b>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
     fa8:	83 ec 08             	sub    $0x8,%esp
     fab:	68 65 4f 00 00       	push   $0x4f65
     fb0:	6a 01                	push   $0x1
     fb2:	e8 c8 2d 00 00       	call   3d7f <printf>
      exit(0);
     fb7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     fbe:	e8 79 2c 00 00       	call   3c3c <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
     fc3:	83 ec 08             	sub    $0x8,%esp
     fc6:	68 2b 47 00 00       	push   $0x472b
     fcb:	6a 01                	push   $0x1
     fcd:	e8 ad 2d 00 00       	call   3d7f <printf>
        exit(0);
     fd2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     fd9:	e8 5e 2c 00 00       	call   3c3c <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
     fde:	83 ec 04             	sub    $0x4,%esp
     fe1:	50                   	push   %eax
     fe2:	68 9a 44 00 00       	push   $0x449a
     fe7:	6a 01                	push   $0x1
     fe9:	e8 91 2d 00 00       	call   3d7f <printf>
          exit(0);
     fee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ff5:	e8 42 2c 00 00       	call   3c3c <exit>
        }
      }
      exit(0);
     ffa:	83 ec 0c             	sub    $0xc,%esp
     ffd:	6a 00                	push   $0x0
     fff:	e8 38 2c 00 00       	call   3c3c <exit>
  for(pi = 0; pi < 4; pi++){
    1004:	46                   	inc    %esi
    1005:	83 fe 03             	cmp    $0x3,%esi
    1008:	7f 76                	jg     1080 <fourfiles+0x106>
    fname = names[pi];
    100a:	8b 7c b5 d8          	mov    -0x28(%ebp,%esi,4),%edi
    unlink(fname);
    100e:	83 ec 0c             	sub    $0xc,%esp
    1011:	57                   	push   %edi
    1012:	e8 75 2c 00 00       	call   3c8c <unlink>
    pid = fork();
    1017:	e8 18 2c 00 00       	call   3c34 <fork>
    if(pid < 0){
    101c:	83 c4 10             	add    $0x10,%esp
    101f:	85 c0                	test   %eax,%eax
    1021:	78 85                	js     fa8 <fourfiles+0x2e>
    if(pid == 0){
    1023:	75 df                	jne    1004 <fourfiles+0x8a>
      fd = open(fname, O_CREATE | O_RDWR);
    1025:	89 c3                	mov    %eax,%ebx
    1027:	83 ec 08             	sub    $0x8,%esp
    102a:	68 02 02 00 00       	push   $0x202
    102f:	57                   	push   %edi
    1030:	e8 47 2c 00 00       	call   3c7c <open>
    1035:	89 c7                	mov    %eax,%edi
      if(fd < 0){
    1037:	83 c4 10             	add    $0x10,%esp
    103a:	85 c0                	test   %eax,%eax
    103c:	78 85                	js     fc3 <fourfiles+0x49>
      memset(buf, '0'+pi, 512);
    103e:	83 ec 04             	sub    $0x4,%esp
    1041:	68 00 02 00 00       	push   $0x200
    1046:	83 c6 30             	add    $0x30,%esi
    1049:	56                   	push   %esi
    104a:	68 20 88 00 00       	push   $0x8820
    104f:	e8 bd 2a 00 00       	call   3b11 <memset>
      for(i = 0; i < 12; i++){
    1054:	83 c4 10             	add    $0x10,%esp
    1057:	83 fb 0b             	cmp    $0xb,%ebx
    105a:	7f 9e                	jg     ffa <fourfiles+0x80>
        if((n = write(fd, buf, 500)) != 500){
    105c:	83 ec 04             	sub    $0x4,%esp
    105f:	68 f4 01 00 00       	push   $0x1f4
    1064:	68 20 88 00 00       	push   $0x8820
    1069:	57                   	push   %edi
    106a:	e8 ed 2b 00 00       	call   3c5c <write>
    106f:	83 c4 10             	add    $0x10,%esp
    1072:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1077:	0f 85 61 ff ff ff    	jne    fde <fourfiles+0x64>
      for(i = 0; i < 12; i++){
    107d:	43                   	inc    %ebx
    107e:	eb d7                	jmp    1057 <fourfiles+0xdd>
    }
  }

  for(pi = 0; pi < 4; pi++){
    1080:	bb 00 00 00 00       	mov    $0x0,%ebx
    1085:	eb 0e                	jmp    1095 <fourfiles+0x11b>
    wait(NULL);
    1087:	83 ec 0c             	sub    $0xc,%esp
    108a:	6a 00                	push   $0x0
    108c:	e8 b3 2b 00 00       	call   3c44 <wait>
  for(pi = 0; pi < 4; pi++){
    1091:	43                   	inc    %ebx
    1092:	83 c4 10             	add    $0x10,%esp
    1095:	83 fb 03             	cmp    $0x3,%ebx
    1098:	7e ed                	jle    1087 <fourfiles+0x10d>
  }

  for(i = 0; i < 2; i++){
    109a:	bb 00 00 00 00       	mov    $0x0,%ebx
    109f:	eb 78                	jmp    1119 <fourfiles+0x19f>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    10a1:	83 ec 08             	sub    $0x8,%esp
    10a4:	68 ab 44 00 00       	push   $0x44ab
    10a9:	6a 01                	push   $0x1
    10ab:	e8 cf 2c 00 00       	call   3d7f <printf>
          exit(0);
    10b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10b7:	e8 80 2b 00 00       	call   3c3c <exit>
        }
      }
      total += n;
    10bc:	01 7d d4             	add    %edi,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10bf:	83 ec 04             	sub    $0x4,%esp
    10c2:	68 00 20 00 00       	push   $0x2000
    10c7:	68 20 88 00 00       	push   $0x8820
    10cc:	56                   	push   %esi
    10cd:	e8 82 2b 00 00       	call   3c54 <read>
    10d2:	89 c7                	mov    %eax,%edi
    10d4:	83 c4 10             	add    $0x10,%esp
    10d7:	85 c0                	test   %eax,%eax
    10d9:	7e 1a                	jle    10f5 <fourfiles+0x17b>
      for(j = 0; j < n; j++){
    10db:	b8 00 00 00 00       	mov    $0x0,%eax
    10e0:	39 f8                	cmp    %edi,%eax
    10e2:	7d d8                	jge    10bc <fourfiles+0x142>
        if(buf[j] != '0'+i){
    10e4:	0f be 88 20 88 00 00 	movsbl 0x8820(%eax),%ecx
    10eb:	8d 53 30             	lea    0x30(%ebx),%edx
    10ee:	39 d1                	cmp    %edx,%ecx
    10f0:	75 af                	jne    10a1 <fourfiles+0x127>
      for(j = 0; j < n; j++){
    10f2:	40                   	inc    %eax
    10f3:	eb eb                	jmp    10e0 <fourfiles+0x166>
    }
    close(fd);
    10f5:	83 ec 0c             	sub    $0xc,%esp
    10f8:	56                   	push   %esi
    10f9:	e8 66 2b 00 00       	call   3c64 <close>
    if(total != 12*500){
    10fe:	83 c4 10             	add    $0x10,%esp
    1101:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
    1108:	75 34                	jne    113e <fourfiles+0x1c4>
      printf(1, "wrong length %d\n", total);
      exit(0);
    }
    unlink(fname);
    110a:	83 ec 0c             	sub    $0xc,%esp
    110d:	ff 75 d0             	push   -0x30(%ebp)
    1110:	e8 77 2b 00 00       	call   3c8c <unlink>
  for(i = 0; i < 2; i++){
    1115:	43                   	inc    %ebx
    1116:	83 c4 10             	add    $0x10,%esp
    1119:	83 fb 01             	cmp    $0x1,%ebx
    111c:	7f 3e                	jg     115c <fourfiles+0x1e2>
    fname = names[i];
    111e:	8b 44 9d d8          	mov    -0x28(%ebp,%ebx,4),%eax
    1122:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    1125:	83 ec 08             	sub    $0x8,%esp
    1128:	6a 00                	push   $0x0
    112a:	50                   	push   %eax
    112b:	e8 4c 2b 00 00       	call   3c7c <open>
    1130:	89 c6                	mov    %eax,%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1132:	83 c4 10             	add    $0x10,%esp
    total = 0;
    1135:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    113c:	eb 81                	jmp    10bf <fourfiles+0x145>
      printf(1, "wrong length %d\n", total);
    113e:	83 ec 04             	sub    $0x4,%esp
    1141:	ff 75 d4             	push   -0x2c(%ebp)
    1144:	68 b7 44 00 00       	push   $0x44b7
    1149:	6a 01                	push   $0x1
    114b:	e8 2f 2c 00 00       	call   3d7f <printf>
      exit(0);
    1150:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1157:	e8 e0 2a 00 00       	call   3c3c <exit>
  }

  printf(1, "fourfiles ok\n");
    115c:	83 ec 08             	sub    $0x8,%esp
    115f:	68 c8 44 00 00       	push   $0x44c8
    1164:	6a 01                	push   $0x1
    1166:	e8 14 2c 00 00       	call   3d7f <printf>
}
    116b:	83 c4 10             	add    $0x10,%esp
    116e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1171:	5b                   	pop    %ebx
    1172:	5e                   	pop    %esi
    1173:	5f                   	pop    %edi
    1174:	5d                   	pop    %ebp
    1175:	c3                   	ret    

00001176 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1176:	55                   	push   %ebp
    1177:	89 e5                	mov    %esp,%ebp
    1179:	56                   	push   %esi
    117a:	53                   	push   %ebx
    117b:	83 ec 28             	sub    $0x28,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    117e:	68 dc 44 00 00       	push   $0x44dc
    1183:	6a 01                	push   $0x1
    1185:	e8 f5 2b 00 00       	call   3d7f <printf>

  for(pi = 0; pi < 4; pi++){
    118a:	83 c4 10             	add    $0x10,%esp
    118d:	be 00 00 00 00       	mov    $0x0,%esi
    1192:	83 fe 03             	cmp    $0x3,%esi
    1195:	0f 8f d2 00 00 00    	jg     126d <createdelete+0xf7>
    pid = fork();
    119b:	e8 94 2a 00 00       	call   3c34 <fork>
    11a0:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    11a2:	85 c0                	test   %eax,%eax
    11a4:	78 05                	js     11ab <createdelete+0x35>
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
    11a6:	74 1e                	je     11c6 <createdelete+0x50>
  for(pi = 0; pi < 4; pi++){
    11a8:	46                   	inc    %esi
    11a9:	eb e7                	jmp    1192 <createdelete+0x1c>
      printf(1, "fork failed\n");
    11ab:	83 ec 08             	sub    $0x8,%esp
    11ae:	68 65 4f 00 00       	push   $0x4f65
    11b3:	6a 01                	push   $0x1
    11b5:	e8 c5 2b 00 00       	call   3d7f <printf>
      exit(0);
    11ba:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11c1:	e8 76 2a 00 00       	call   3c3c <exit>
      name[0] = 'p' + pi;
    11c6:	8d 46 70             	lea    0x70(%esi),%eax
    11c9:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[2] = '\0';
    11cc:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
      for(i = 0; i < N; i++){
    11d0:	eb 1c                	jmp    11ee <createdelete+0x78>
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    11d2:	83 ec 08             	sub    $0x8,%esp
    11d5:	68 2b 47 00 00       	push   $0x472b
    11da:	6a 01                	push   $0x1
    11dc:	e8 9e 2b 00 00       	call   3d7f <printf>
          exit(0);
    11e1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11e8:	e8 4f 2a 00 00       	call   3c3c <exit>
      for(i = 0; i < N; i++){
    11ed:	43                   	inc    %ebx
    11ee:	83 fb 13             	cmp    $0x13,%ebx
    11f1:	7f 70                	jg     1263 <createdelete+0xed>
        name[1] = '0' + i;
    11f3:	8d 43 30             	lea    0x30(%ebx),%eax
    11f6:	88 45 d9             	mov    %al,-0x27(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    11f9:	83 ec 08             	sub    $0x8,%esp
    11fc:	68 02 02 00 00       	push   $0x202
    1201:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1204:	50                   	push   %eax
    1205:	e8 72 2a 00 00       	call   3c7c <open>
        if(fd < 0){
    120a:	83 c4 10             	add    $0x10,%esp
    120d:	85 c0                	test   %eax,%eax
    120f:	78 c1                	js     11d2 <createdelete+0x5c>
        }
        close(fd);
    1211:	83 ec 0c             	sub    $0xc,%esp
    1214:	50                   	push   %eax
    1215:	e8 4a 2a 00 00       	call   3c64 <close>
        if(i > 0 && (i % 2 ) == 0){
    121a:	83 c4 10             	add    $0x10,%esp
    121d:	85 db                	test   %ebx,%ebx
    121f:	7e cc                	jle    11ed <createdelete+0x77>
    1221:	f6 c3 01             	test   $0x1,%bl
    1224:	75 c7                	jne    11ed <createdelete+0x77>
          name[1] = '0' + (i / 2);
    1226:	89 d8                	mov    %ebx,%eax
    1228:	c1 e8 1f             	shr    $0x1f,%eax
    122b:	01 d8                	add    %ebx,%eax
    122d:	d1 f8                	sar    %eax
    122f:	83 c0 30             	add    $0x30,%eax
    1232:	88 45 d9             	mov    %al,-0x27(%ebp)
          if(unlink(name) < 0){
    1235:	83 ec 0c             	sub    $0xc,%esp
    1238:	8d 45 d8             	lea    -0x28(%ebp),%eax
    123b:	50                   	push   %eax
    123c:	e8 4b 2a 00 00       	call   3c8c <unlink>
    1241:	83 c4 10             	add    $0x10,%esp
    1244:	85 c0                	test   %eax,%eax
    1246:	79 a5                	jns    11ed <createdelete+0x77>
            printf(1, "unlink failed\n");
    1248:	83 ec 08             	sub    $0x8,%esp
    124b:	68 dd 40 00 00       	push   $0x40dd
    1250:	6a 01                	push   $0x1
    1252:	e8 28 2b 00 00       	call   3d7f <printf>
            exit(0);
    1257:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    125e:	e8 d9 29 00 00       	call   3c3c <exit>
          }
        }
      }
      exit(0);
    1263:	83 ec 0c             	sub    $0xc,%esp
    1266:	6a 00                	push   $0x0
    1268:	e8 cf 29 00 00       	call   3c3c <exit>
    }
  }

  for(pi = 0; pi < 4; pi++){
    126d:	bb 00 00 00 00       	mov    $0x0,%ebx
    1272:	83 fb 03             	cmp    $0x3,%ebx
    1275:	7f 10                	jg     1287 <createdelete+0x111>
    wait(NULL);
    1277:	83 ec 0c             	sub    $0xc,%esp
    127a:	6a 00                	push   $0x0
    127c:	e8 c3 29 00 00       	call   3c44 <wait>
  for(pi = 0; pi < 4; pi++){
    1281:	43                   	inc    %ebx
    1282:	83 c4 10             	add    $0x10,%esp
    1285:	eb eb                	jmp    1272 <createdelete+0xfc>
  }

  name[0] = name[1] = name[2] = 0;
    1287:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    128b:	c6 45 d9 00          	movb   $0x0,-0x27(%ebp)
    128f:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
  for(i = 0; i < N; i++){
    1293:	be 00 00 00 00       	mov    $0x0,%esi
    1298:	e9 8f 00 00 00       	jmp    132c <createdelete+0x1b6>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
    129d:	85 c0                	test   %eax,%eax
    129f:	78 3a                	js     12db <createdelete+0x165>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12a1:	8d 56 ff             	lea    -0x1(%esi),%edx
    12a4:	83 fa 08             	cmp    $0x8,%edx
    12a7:	76 51                	jbe    12fa <createdelete+0x184>
        printf(1, "oops createdelete %s did exist\n", name);
        exit(0);
      }
      if(fd >= 0)
    12a9:	85 c0                	test   %eax,%eax
    12ab:	79 70                	jns    131d <createdelete+0x1a7>
    for(pi = 0; pi < 4; pi++){
    12ad:	43                   	inc    %ebx
    12ae:	83 fb 03             	cmp    $0x3,%ebx
    12b1:	7f 78                	jg     132b <createdelete+0x1b5>
      name[0] = 'p' + pi;
    12b3:	8d 43 70             	lea    0x70(%ebx),%eax
    12b6:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[1] = '0' + i;
    12b9:	8d 46 30             	lea    0x30(%esi),%eax
    12bc:	88 45 d9             	mov    %al,-0x27(%ebp)
      fd = open(name, 0);
    12bf:	83 ec 08             	sub    $0x8,%esp
    12c2:	6a 00                	push   $0x0
    12c4:	8d 45 d8             	lea    -0x28(%ebp),%eax
    12c7:	50                   	push   %eax
    12c8:	e8 af 29 00 00       	call   3c7c <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12cd:	83 c4 10             	add    $0x10,%esp
    12d0:	85 f6                	test   %esi,%esi
    12d2:	74 c9                	je     129d <createdelete+0x127>
    12d4:	83 fe 09             	cmp    $0x9,%esi
    12d7:	7e c8                	jle    12a1 <createdelete+0x12b>
    12d9:	eb c2                	jmp    129d <createdelete+0x127>
        printf(1, "oops createdelete %s didn't exist\n", name);
    12db:	83 ec 04             	sub    $0x4,%esp
    12de:	8d 45 d8             	lea    -0x28(%ebp),%eax
    12e1:	50                   	push   %eax
    12e2:	68 9c 51 00 00       	push   $0x519c
    12e7:	6a 01                	push   $0x1
    12e9:	e8 91 2a 00 00       	call   3d7f <printf>
        exit(0);
    12ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12f5:	e8 42 29 00 00       	call   3c3c <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12fa:	85 c0                	test   %eax,%eax
    12fc:	78 ab                	js     12a9 <createdelete+0x133>
        printf(1, "oops createdelete %s did exist\n", name);
    12fe:	83 ec 04             	sub    $0x4,%esp
    1301:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1304:	50                   	push   %eax
    1305:	68 c0 51 00 00       	push   $0x51c0
    130a:	6a 01                	push   $0x1
    130c:	e8 6e 2a 00 00       	call   3d7f <printf>
        exit(0);
    1311:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1318:	e8 1f 29 00 00       	call   3c3c <exit>
        close(fd);
    131d:	83 ec 0c             	sub    $0xc,%esp
    1320:	50                   	push   %eax
    1321:	e8 3e 29 00 00       	call   3c64 <close>
    1326:	83 c4 10             	add    $0x10,%esp
    1329:	eb 82                	jmp    12ad <createdelete+0x137>
  for(i = 0; i < N; i++){
    132b:	46                   	inc    %esi
    132c:	83 fe 13             	cmp    $0x13,%esi
    132f:	7f 0a                	jg     133b <createdelete+0x1c5>
    for(pi = 0; pi < 4; pi++){
    1331:	bb 00 00 00 00       	mov    $0x0,%ebx
    1336:	e9 73 ff ff ff       	jmp    12ae <createdelete+0x138>
    }
  }

  for(i = 0; i < N; i++){
    133b:	be 00 00 00 00       	mov    $0x0,%esi
    1340:	eb 22                	jmp    1364 <createdelete+0x1ee>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    1342:	8d 46 70             	lea    0x70(%esi),%eax
    1345:	88 45 d8             	mov    %al,-0x28(%ebp)
      name[1] = '0' + i;
    1348:	8d 46 30             	lea    0x30(%esi),%eax
    134b:	88 45 d9             	mov    %al,-0x27(%ebp)
      unlink(name);
    134e:	83 ec 0c             	sub    $0xc,%esp
    1351:	8d 45 d8             	lea    -0x28(%ebp),%eax
    1354:	50                   	push   %eax
    1355:	e8 32 29 00 00       	call   3c8c <unlink>
    for(pi = 0; pi < 4; pi++){
    135a:	43                   	inc    %ebx
    135b:	83 c4 10             	add    $0x10,%esp
    135e:	83 fb 03             	cmp    $0x3,%ebx
    1361:	7e df                	jle    1342 <createdelete+0x1cc>
  for(i = 0; i < N; i++){
    1363:	46                   	inc    %esi
    1364:	83 fe 13             	cmp    $0x13,%esi
    1367:	7f 07                	jg     1370 <createdelete+0x1fa>
    for(pi = 0; pi < 4; pi++){
    1369:	bb 00 00 00 00       	mov    $0x0,%ebx
    136e:	eb ee                	jmp    135e <createdelete+0x1e8>
    }
  }

  printf(1, "createdelete ok\n");
    1370:	83 ec 08             	sub    $0x8,%esp
    1373:	68 ef 44 00 00       	push   $0x44ef
    1378:	6a 01                	push   $0x1
    137a:	e8 00 2a 00 00       	call   3d7f <printf>
}
    137f:	83 c4 10             	add    $0x10,%esp
    1382:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1385:	5b                   	pop    %ebx
    1386:	5e                   	pop    %esi
    1387:	5d                   	pop    %ebp
    1388:	c3                   	ret    

00001389 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1389:	55                   	push   %ebp
    138a:	89 e5                	mov    %esp,%ebp
    138c:	56                   	push   %esi
    138d:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    138e:	83 ec 08             	sub    $0x8,%esp
    1391:	68 00 45 00 00       	push   $0x4500
    1396:	6a 01                	push   $0x1
    1398:	e8 e2 29 00 00       	call   3d7f <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    139d:	83 c4 08             	add    $0x8,%esp
    13a0:	68 02 02 00 00       	push   $0x202
    13a5:	68 11 45 00 00       	push   $0x4511
    13aa:	e8 cd 28 00 00       	call   3c7c <open>
  if(fd < 0){
    13af:	83 c4 10             	add    $0x10,%esp
    13b2:	85 c0                	test   %eax,%eax
    13b4:	0f 88 f0 00 00 00    	js     14aa <unlinkread+0x121>
    13ba:	89 c3                	mov    %eax,%ebx
    printf(1, "create unlinkread failed\n");
    exit(0);
  }
  write(fd, "hello", 5);
    13bc:	83 ec 04             	sub    $0x4,%esp
    13bf:	6a 05                	push   $0x5
    13c1:	68 36 45 00 00       	push   $0x4536
    13c6:	50                   	push   %eax
    13c7:	e8 90 28 00 00       	call   3c5c <write>
  close(fd);
    13cc:	89 1c 24             	mov    %ebx,(%esp)
    13cf:	e8 90 28 00 00       	call   3c64 <close>

  fd = open("unlinkread", O_RDWR);
    13d4:	83 c4 08             	add    $0x8,%esp
    13d7:	6a 02                	push   $0x2
    13d9:	68 11 45 00 00       	push   $0x4511
    13de:	e8 99 28 00 00       	call   3c7c <open>
    13e3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    13e5:	83 c4 10             	add    $0x10,%esp
    13e8:	85 c0                	test   %eax,%eax
    13ea:	0f 88 d5 00 00 00    	js     14c5 <unlinkread+0x13c>
    printf(1, "open unlinkread failed\n");
    exit(0);
  }
  if(unlink("unlinkread") != 0){
    13f0:	83 ec 0c             	sub    $0xc,%esp
    13f3:	68 11 45 00 00       	push   $0x4511
    13f8:	e8 8f 28 00 00       	call   3c8c <unlink>
    13fd:	83 c4 10             	add    $0x10,%esp
    1400:	85 c0                	test   %eax,%eax
    1402:	0f 85 d8 00 00 00    	jne    14e0 <unlinkread+0x157>
    printf(1, "unlink unlinkread failed\n");
    exit(0);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1408:	83 ec 08             	sub    $0x8,%esp
    140b:	68 02 02 00 00       	push   $0x202
    1410:	68 11 45 00 00       	push   $0x4511
    1415:	e8 62 28 00 00       	call   3c7c <open>
    141a:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    141c:	83 c4 0c             	add    $0xc,%esp
    141f:	6a 03                	push   $0x3
    1421:	68 6e 45 00 00       	push   $0x456e
    1426:	50                   	push   %eax
    1427:	e8 30 28 00 00       	call   3c5c <write>
  close(fd1);
    142c:	89 34 24             	mov    %esi,(%esp)
    142f:	e8 30 28 00 00       	call   3c64 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1434:	83 c4 0c             	add    $0xc,%esp
    1437:	68 00 20 00 00       	push   $0x2000
    143c:	68 20 88 00 00       	push   $0x8820
    1441:	53                   	push   %ebx
    1442:	e8 0d 28 00 00       	call   3c54 <read>
    1447:	83 c4 10             	add    $0x10,%esp
    144a:	83 f8 05             	cmp    $0x5,%eax
    144d:	0f 85 a8 00 00 00    	jne    14fb <unlinkread+0x172>
    printf(1, "unlinkread read failed");
    exit(0);
  }
  if(buf[0] != 'h'){
    1453:	80 3d 20 88 00 00 68 	cmpb   $0x68,0x8820
    145a:	0f 85 b6 00 00 00    	jne    1516 <unlinkread+0x18d>
    printf(1, "unlinkread wrong data\n");
    exit(0);
  }
  if(write(fd, buf, 10) != 10){
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	6a 0a                	push   $0xa
    1465:	68 20 88 00 00       	push   $0x8820
    146a:	53                   	push   %ebx
    146b:	e8 ec 27 00 00       	call   3c5c <write>
    1470:	83 c4 10             	add    $0x10,%esp
    1473:	83 f8 0a             	cmp    $0xa,%eax
    1476:	0f 85 b5 00 00 00    	jne    1531 <unlinkread+0x1a8>
    printf(1, "unlinkread write failed\n");
    exit(0);
  }
  close(fd);
    147c:	83 ec 0c             	sub    $0xc,%esp
    147f:	53                   	push   %ebx
    1480:	e8 df 27 00 00       	call   3c64 <close>
  unlink("unlinkread");
    1485:	c7 04 24 11 45 00 00 	movl   $0x4511,(%esp)
    148c:	e8 fb 27 00 00       	call   3c8c <unlink>
  printf(1, "unlinkread ok\n");
    1491:	83 c4 08             	add    $0x8,%esp
    1494:	68 b9 45 00 00       	push   $0x45b9
    1499:	6a 01                	push   $0x1
    149b:	e8 df 28 00 00       	call   3d7f <printf>
}
    14a0:	83 c4 10             	add    $0x10,%esp
    14a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    14a6:	5b                   	pop    %ebx
    14a7:	5e                   	pop    %esi
    14a8:	5d                   	pop    %ebp
    14a9:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    14aa:	83 ec 08             	sub    $0x8,%esp
    14ad:	68 1c 45 00 00       	push   $0x451c
    14b2:	6a 01                	push   $0x1
    14b4:	e8 c6 28 00 00       	call   3d7f <printf>
    exit(0);
    14b9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14c0:	e8 77 27 00 00       	call   3c3c <exit>
    printf(1, "open unlinkread failed\n");
    14c5:	83 ec 08             	sub    $0x8,%esp
    14c8:	68 3c 45 00 00       	push   $0x453c
    14cd:	6a 01                	push   $0x1
    14cf:	e8 ab 28 00 00       	call   3d7f <printf>
    exit(0);
    14d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14db:	e8 5c 27 00 00       	call   3c3c <exit>
    printf(1, "unlink unlinkread failed\n");
    14e0:	83 ec 08             	sub    $0x8,%esp
    14e3:	68 54 45 00 00       	push   $0x4554
    14e8:	6a 01                	push   $0x1
    14ea:	e8 90 28 00 00       	call   3d7f <printf>
    exit(0);
    14ef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14f6:	e8 41 27 00 00       	call   3c3c <exit>
    printf(1, "unlinkread read failed");
    14fb:	83 ec 08             	sub    $0x8,%esp
    14fe:	68 72 45 00 00       	push   $0x4572
    1503:	6a 01                	push   $0x1
    1505:	e8 75 28 00 00       	call   3d7f <printf>
    exit(0);
    150a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1511:	e8 26 27 00 00       	call   3c3c <exit>
    printf(1, "unlinkread wrong data\n");
    1516:	83 ec 08             	sub    $0x8,%esp
    1519:	68 89 45 00 00       	push   $0x4589
    151e:	6a 01                	push   $0x1
    1520:	e8 5a 28 00 00       	call   3d7f <printf>
    exit(0);
    1525:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    152c:	e8 0b 27 00 00       	call   3c3c <exit>
    printf(1, "unlinkread write failed\n");
    1531:	83 ec 08             	sub    $0x8,%esp
    1534:	68 a0 45 00 00       	push   $0x45a0
    1539:	6a 01                	push   $0x1
    153b:	e8 3f 28 00 00       	call   3d7f <printf>
    exit(0);
    1540:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1547:	e8 f0 26 00 00       	call   3c3c <exit>

0000154c <linktest>:

void
linktest(void)
{
    154c:	55                   	push   %ebp
    154d:	89 e5                	mov    %esp,%ebp
    154f:	53                   	push   %ebx
    1550:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    1553:	68 c8 45 00 00       	push   $0x45c8
    1558:	6a 01                	push   $0x1
    155a:	e8 20 28 00 00       	call   3d7f <printf>

  unlink("lf1");
    155f:	c7 04 24 d2 45 00 00 	movl   $0x45d2,(%esp)
    1566:	e8 21 27 00 00       	call   3c8c <unlink>
  unlink("lf2");
    156b:	c7 04 24 d6 45 00 00 	movl   $0x45d6,(%esp)
    1572:	e8 15 27 00 00       	call   3c8c <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1577:	83 c4 08             	add    $0x8,%esp
    157a:	68 02 02 00 00       	push   $0x202
    157f:	68 d2 45 00 00       	push   $0x45d2
    1584:	e8 f3 26 00 00       	call   3c7c <open>
  if(fd < 0){
    1589:	83 c4 10             	add    $0x10,%esp
    158c:	85 c0                	test   %eax,%eax
    158e:	0f 88 2a 01 00 00    	js     16be <linktest+0x172>
    1594:	89 c3                	mov    %eax,%ebx
    printf(1, "create lf1 failed\n");
    exit(0);
  }
  if(write(fd, "hello", 5) != 5){
    1596:	83 ec 04             	sub    $0x4,%esp
    1599:	6a 05                	push   $0x5
    159b:	68 36 45 00 00       	push   $0x4536
    15a0:	50                   	push   %eax
    15a1:	e8 b6 26 00 00       	call   3c5c <write>
    15a6:	83 c4 10             	add    $0x10,%esp
    15a9:	83 f8 05             	cmp    $0x5,%eax
    15ac:	0f 85 27 01 00 00    	jne    16d9 <linktest+0x18d>
    printf(1, "write lf1 failed\n");
    exit(0);
  }
  close(fd);
    15b2:	83 ec 0c             	sub    $0xc,%esp
    15b5:	53                   	push   %ebx
    15b6:	e8 a9 26 00 00       	call   3c64 <close>

  if(link("lf1", "lf2") < 0){
    15bb:	83 c4 08             	add    $0x8,%esp
    15be:	68 d6 45 00 00       	push   $0x45d6
    15c3:	68 d2 45 00 00       	push   $0x45d2
    15c8:	e8 cf 26 00 00       	call   3c9c <link>
    15cd:	83 c4 10             	add    $0x10,%esp
    15d0:	85 c0                	test   %eax,%eax
    15d2:	0f 88 1c 01 00 00    	js     16f4 <linktest+0x1a8>
    printf(1, "link lf1 lf2 failed\n");
    exit(0);
  }
  unlink("lf1");
    15d8:	83 ec 0c             	sub    $0xc,%esp
    15db:	68 d2 45 00 00       	push   $0x45d2
    15e0:	e8 a7 26 00 00       	call   3c8c <unlink>

  if(open("lf1", 0) >= 0){
    15e5:	83 c4 08             	add    $0x8,%esp
    15e8:	6a 00                	push   $0x0
    15ea:	68 d2 45 00 00       	push   $0x45d2
    15ef:	e8 88 26 00 00       	call   3c7c <open>
    15f4:	83 c4 10             	add    $0x10,%esp
    15f7:	85 c0                	test   %eax,%eax
    15f9:	0f 89 10 01 00 00    	jns    170f <linktest+0x1c3>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(0);
  }

  fd = open("lf2", 0);
    15ff:	83 ec 08             	sub    $0x8,%esp
    1602:	6a 00                	push   $0x0
    1604:	68 d6 45 00 00       	push   $0x45d6
    1609:	e8 6e 26 00 00       	call   3c7c <open>
    160e:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1610:	83 c4 10             	add    $0x10,%esp
    1613:	85 c0                	test   %eax,%eax
    1615:	0f 88 0f 01 00 00    	js     172a <linktest+0x1de>
    printf(1, "open lf2 failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    161b:	83 ec 04             	sub    $0x4,%esp
    161e:	68 00 20 00 00       	push   $0x2000
    1623:	68 20 88 00 00       	push   $0x8820
    1628:	50                   	push   %eax
    1629:	e8 26 26 00 00       	call   3c54 <read>
    162e:	83 c4 10             	add    $0x10,%esp
    1631:	83 f8 05             	cmp    $0x5,%eax
    1634:	0f 85 0b 01 00 00    	jne    1745 <linktest+0x1f9>
    printf(1, "read lf2 failed\n");
    exit(0);
  }
  close(fd);
    163a:	83 ec 0c             	sub    $0xc,%esp
    163d:	53                   	push   %ebx
    163e:	e8 21 26 00 00       	call   3c64 <close>

  if(link("lf2", "lf2") >= 0){
    1643:	83 c4 08             	add    $0x8,%esp
    1646:	68 d6 45 00 00       	push   $0x45d6
    164b:	68 d6 45 00 00       	push   $0x45d6
    1650:	e8 47 26 00 00       	call   3c9c <link>
    1655:	83 c4 10             	add    $0x10,%esp
    1658:	85 c0                	test   %eax,%eax
    165a:	0f 89 00 01 00 00    	jns    1760 <linktest+0x214>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit(0);
  }

  unlink("lf2");
    1660:	83 ec 0c             	sub    $0xc,%esp
    1663:	68 d6 45 00 00       	push   $0x45d6
    1668:	e8 1f 26 00 00       	call   3c8c <unlink>
  if(link("lf2", "lf1") >= 0){
    166d:	83 c4 08             	add    $0x8,%esp
    1670:	68 d2 45 00 00       	push   $0x45d2
    1675:	68 d6 45 00 00       	push   $0x45d6
    167a:	e8 1d 26 00 00       	call   3c9c <link>
    167f:	83 c4 10             	add    $0x10,%esp
    1682:	85 c0                	test   %eax,%eax
    1684:	0f 89 f1 00 00 00    	jns    177b <linktest+0x22f>
    printf(1, "link non-existant succeeded! oops\n");
    exit(0);
  }

  if(link(".", "lf1") >= 0){
    168a:	83 ec 08             	sub    $0x8,%esp
    168d:	68 d2 45 00 00       	push   $0x45d2
    1692:	68 9a 48 00 00       	push   $0x489a
    1697:	e8 00 26 00 00       	call   3c9c <link>
    169c:	83 c4 10             	add    $0x10,%esp
    169f:	85 c0                	test   %eax,%eax
    16a1:	0f 89 ef 00 00 00    	jns    1796 <linktest+0x24a>
    printf(1, "link . lf1 succeeded! oops\n");
    exit(0);
  }

  printf(1, "linktest ok\n");
    16a7:	83 ec 08             	sub    $0x8,%esp
    16aa:	68 70 46 00 00       	push   $0x4670
    16af:	6a 01                	push   $0x1
    16b1:	e8 c9 26 00 00       	call   3d7f <printf>
}
    16b6:	83 c4 10             	add    $0x10,%esp
    16b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16bc:	c9                   	leave  
    16bd:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    16be:	83 ec 08             	sub    $0x8,%esp
    16c1:	68 da 45 00 00       	push   $0x45da
    16c6:	6a 01                	push   $0x1
    16c8:	e8 b2 26 00 00       	call   3d7f <printf>
    exit(0);
    16cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16d4:	e8 63 25 00 00       	call   3c3c <exit>
    printf(1, "write lf1 failed\n");
    16d9:	83 ec 08             	sub    $0x8,%esp
    16dc:	68 ed 45 00 00       	push   $0x45ed
    16e1:	6a 01                	push   $0x1
    16e3:	e8 97 26 00 00       	call   3d7f <printf>
    exit(0);
    16e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16ef:	e8 48 25 00 00       	call   3c3c <exit>
    printf(1, "link lf1 lf2 failed\n");
    16f4:	83 ec 08             	sub    $0x8,%esp
    16f7:	68 ff 45 00 00       	push   $0x45ff
    16fc:	6a 01                	push   $0x1
    16fe:	e8 7c 26 00 00       	call   3d7f <printf>
    exit(0);
    1703:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    170a:	e8 2d 25 00 00       	call   3c3c <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    170f:	83 ec 08             	sub    $0x8,%esp
    1712:	68 e0 51 00 00       	push   $0x51e0
    1717:	6a 01                	push   $0x1
    1719:	e8 61 26 00 00       	call   3d7f <printf>
    exit(0);
    171e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1725:	e8 12 25 00 00       	call   3c3c <exit>
    printf(1, "open lf2 failed\n");
    172a:	83 ec 08             	sub    $0x8,%esp
    172d:	68 14 46 00 00       	push   $0x4614
    1732:	6a 01                	push   $0x1
    1734:	e8 46 26 00 00       	call   3d7f <printf>
    exit(0);
    1739:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1740:	e8 f7 24 00 00       	call   3c3c <exit>
    printf(1, "read lf2 failed\n");
    1745:	83 ec 08             	sub    $0x8,%esp
    1748:	68 25 46 00 00       	push   $0x4625
    174d:	6a 01                	push   $0x1
    174f:	e8 2b 26 00 00       	call   3d7f <printf>
    exit(0);
    1754:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    175b:	e8 dc 24 00 00       	call   3c3c <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1760:	83 ec 08             	sub    $0x8,%esp
    1763:	68 36 46 00 00       	push   $0x4636
    1768:	6a 01                	push   $0x1
    176a:	e8 10 26 00 00       	call   3d7f <printf>
    exit(0);
    176f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1776:	e8 c1 24 00 00       	call   3c3c <exit>
    printf(1, "link non-existant succeeded! oops\n");
    177b:	83 ec 08             	sub    $0x8,%esp
    177e:	68 08 52 00 00       	push   $0x5208
    1783:	6a 01                	push   $0x1
    1785:	e8 f5 25 00 00       	call   3d7f <printf>
    exit(0);
    178a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1791:	e8 a6 24 00 00       	call   3c3c <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1796:	83 ec 08             	sub    $0x8,%esp
    1799:	68 54 46 00 00       	push   $0x4654
    179e:	6a 01                	push   $0x1
    17a0:	e8 da 25 00 00       	call   3d7f <printf>
    exit(0);
    17a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17ac:	e8 8b 24 00 00       	call   3c3c <exit>

000017b1 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    17b1:	55                   	push   %ebp
    17b2:	89 e5                	mov    %esp,%ebp
    17b4:	57                   	push   %edi
    17b5:	56                   	push   %esi
    17b6:	53                   	push   %ebx
    17b7:	83 ec 54             	sub    $0x54,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    17ba:	68 7d 46 00 00       	push   $0x467d
    17bf:	6a 01                	push   $0x1
    17c1:	e8 b9 25 00 00       	call   3d7f <printf>
  file[0] = 'C';
    17c6:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    17ca:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    17ce:	83 c4 10             	add    $0x10,%esp
    17d1:	bb 00 00 00 00       	mov    $0x0,%ebx
    17d6:	eb 55                	jmp    182d <concreate+0x7c>
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    17d8:	85 f6                	test   %esi,%esi
    17da:	75 13                	jne    17ef <concreate+0x3e>
    17dc:	b9 05 00 00 00       	mov    $0x5,%ecx
    17e1:	89 d8                	mov    %ebx,%eax
    17e3:	99                   	cltd   
    17e4:	f7 f9                	idiv   %ecx
    17e6:	83 fa 01             	cmp    $0x1,%edx
    17e9:	0f 84 90 00 00 00    	je     187f <concreate+0xce>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    17ef:	83 ec 08             	sub    $0x8,%esp
    17f2:	68 02 02 00 00       	push   $0x202
    17f7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    17fa:	50                   	push   %eax
    17fb:	e8 7c 24 00 00       	call   3c7c <open>
      if(fd < 0){
    1800:	83 c4 10             	add    $0x10,%esp
    1803:	85 c0                	test   %eax,%eax
    1805:	0f 88 8a 00 00 00    	js     1895 <concreate+0xe4>
        printf(1, "concreate create %s failed\n", file);
        exit(0);
      }
      close(fd);
    180b:	83 ec 0c             	sub    $0xc,%esp
    180e:	50                   	push   %eax
    180f:	e8 50 24 00 00       	call   3c64 <close>
    1814:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1817:	85 f6                	test   %esi,%esi
    1819:	0f 84 95 00 00 00    	je     18b4 <concreate+0x103>
      exit(0);
    else
      wait(NULL);
    181f:	83 ec 0c             	sub    $0xc,%esp
    1822:	6a 00                	push   $0x0
    1824:	e8 1b 24 00 00       	call   3c44 <wait>
  for(i = 0; i < 40; i++){
    1829:	43                   	inc    %ebx
    182a:	83 c4 10             	add    $0x10,%esp
    182d:	83 fb 27             	cmp    $0x27,%ebx
    1830:	0f 8f 88 00 00 00    	jg     18be <concreate+0x10d>
    file[1] = '0' + i;
    1836:	8d 43 30             	lea    0x30(%ebx),%eax
    1839:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    183c:	83 ec 0c             	sub    $0xc,%esp
    183f:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1842:	50                   	push   %eax
    1843:	e8 44 24 00 00       	call   3c8c <unlink>
    pid = fork();
    1848:	e8 e7 23 00 00       	call   3c34 <fork>
    184d:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    184f:	83 c4 10             	add    $0x10,%esp
    1852:	85 c0                	test   %eax,%eax
    1854:	74 82                	je     17d8 <concreate+0x27>
    1856:	b9 03 00 00 00       	mov    $0x3,%ecx
    185b:	89 d8                	mov    %ebx,%eax
    185d:	99                   	cltd   
    185e:	f7 f9                	idiv   %ecx
    1860:	83 fa 01             	cmp    $0x1,%edx
    1863:	0f 85 6f ff ff ff    	jne    17d8 <concreate+0x27>
      link("C0", file);
    1869:	83 ec 08             	sub    $0x8,%esp
    186c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    186f:	50                   	push   %eax
    1870:	68 8d 46 00 00       	push   $0x468d
    1875:	e8 22 24 00 00       	call   3c9c <link>
    187a:	83 c4 10             	add    $0x10,%esp
    187d:	eb 98                	jmp    1817 <concreate+0x66>
      link("C0", file);
    187f:	83 ec 08             	sub    $0x8,%esp
    1882:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1885:	50                   	push   %eax
    1886:	68 8d 46 00 00       	push   $0x468d
    188b:	e8 0c 24 00 00       	call   3c9c <link>
    1890:	83 c4 10             	add    $0x10,%esp
    1893:	eb 82                	jmp    1817 <concreate+0x66>
        printf(1, "concreate create %s failed\n", file);
    1895:	83 ec 04             	sub    $0x4,%esp
    1898:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    189b:	50                   	push   %eax
    189c:	68 90 46 00 00       	push   $0x4690
    18a1:	6a 01                	push   $0x1
    18a3:	e8 d7 24 00 00       	call   3d7f <printf>
        exit(0);
    18a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18af:	e8 88 23 00 00       	call   3c3c <exit>
      exit(0);
    18b4:	83 ec 0c             	sub    $0xc,%esp
    18b7:	6a 00                	push   $0x0
    18b9:	e8 7e 23 00 00       	call   3c3c <exit>
  }

  memset(fa, 0, sizeof(fa));
    18be:	83 ec 04             	sub    $0x4,%esp
    18c1:	6a 28                	push   $0x28
    18c3:	6a 00                	push   $0x0
    18c5:	8d 45 bd             	lea    -0x43(%ebp),%eax
    18c8:	50                   	push   %eax
    18c9:	e8 43 22 00 00       	call   3b11 <memset>
  fd = open(".", 0);
    18ce:	83 c4 08             	add    $0x8,%esp
    18d1:	6a 00                	push   $0x0
    18d3:	68 9a 48 00 00       	push   $0x489a
    18d8:	e8 9f 23 00 00       	call   3c7c <open>
    18dd:	89 c3                	mov    %eax,%ebx
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    18df:	83 c4 10             	add    $0x10,%esp
  n = 0;
    18e2:	be 00 00 00 00       	mov    $0x0,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    18e7:	83 ec 04             	sub    $0x4,%esp
    18ea:	6a 10                	push   $0x10
    18ec:	8d 45 ac             	lea    -0x54(%ebp),%eax
    18ef:	50                   	push   %eax
    18f0:	53                   	push   %ebx
    18f1:	e8 5e 23 00 00       	call   3c54 <read>
    18f6:	83 c4 10             	add    $0x10,%esp
    18f9:	85 c0                	test   %eax,%eax
    18fb:	7e 6c                	jle    1969 <concreate+0x1b8>
    if(de.inum == 0)
    18fd:	66 83 7d ac 00       	cmpw   $0x0,-0x54(%ebp)
    1902:	74 e3                	je     18e7 <concreate+0x136>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1904:	80 7d ae 43          	cmpb   $0x43,-0x52(%ebp)
    1908:	75 dd                	jne    18e7 <concreate+0x136>
    190a:	80 7d b0 00          	cmpb   $0x0,-0x50(%ebp)
    190e:	75 d7                	jne    18e7 <concreate+0x136>
      i = de.name[1] - '0';
    1910:	0f be 45 af          	movsbl -0x51(%ebp),%eax
    1914:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1917:	83 f8 27             	cmp    $0x27,%eax
    191a:	77 0f                	ja     192b <concreate+0x17a>
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
      }
      if(fa[i]){
    191c:	80 7c 05 bd 00       	cmpb   $0x0,-0x43(%ebp,%eax,1)
    1921:	75 27                	jne    194a <concreate+0x199>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit(0);
      }
      fa[i] = 1;
    1923:	c6 44 05 bd 01       	movb   $0x1,-0x43(%ebp,%eax,1)
      n++;
    1928:	46                   	inc    %esi
    1929:	eb bc                	jmp    18e7 <concreate+0x136>
        printf(1, "concreate weird file %s\n", de.name);
    192b:	83 ec 04             	sub    $0x4,%esp
    192e:	8d 45 ae             	lea    -0x52(%ebp),%eax
    1931:	50                   	push   %eax
    1932:	68 ac 46 00 00       	push   $0x46ac
    1937:	6a 01                	push   $0x1
    1939:	e8 41 24 00 00       	call   3d7f <printf>
        exit(0);
    193e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1945:	e8 f2 22 00 00       	call   3c3c <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    194a:	83 ec 04             	sub    $0x4,%esp
    194d:	8d 45 ae             	lea    -0x52(%ebp),%eax
    1950:	50                   	push   %eax
    1951:	68 c5 46 00 00       	push   $0x46c5
    1956:	6a 01                	push   $0x1
    1958:	e8 22 24 00 00       	call   3d7f <printf>
        exit(0);
    195d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1964:	e8 d3 22 00 00       	call   3c3c <exit>
    }
  }
  close(fd);
    1969:	83 ec 0c             	sub    $0xc,%esp
    196c:	53                   	push   %ebx
    196d:	e8 f2 22 00 00       	call   3c64 <close>

  if(n != 40){
    1972:	83 c4 10             	add    $0x10,%esp
    1975:	83 fe 28             	cmp    $0x28,%esi
    1978:	75 07                	jne    1981 <concreate+0x1d0>
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
  }

  for(i = 0; i < 40; i++){
    197a:	bb 00 00 00 00       	mov    $0x0,%ebx
    197f:	eb 73                	jmp    19f4 <concreate+0x243>
    printf(1, "concreate not enough files in directory listing\n");
    1981:	83 ec 08             	sub    $0x8,%esp
    1984:	68 2c 52 00 00       	push   $0x522c
    1989:	6a 01                	push   $0x1
    198b:	e8 ef 23 00 00       	call   3d7f <printf>
    exit(0);
    1990:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1997:	e8 a0 22 00 00       	call   3c3c <exit>
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    199c:	83 ec 08             	sub    $0x8,%esp
    199f:	68 65 4f 00 00       	push   $0x4f65
    19a4:	6a 01                	push   $0x1
    19a6:	e8 d4 23 00 00       	call   3d7f <printf>
      exit(0);
    19ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19b2:	e8 85 22 00 00       	call   3c3c <exit>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    19b7:	83 ec 0c             	sub    $0xc,%esp
    19ba:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    19bd:	57                   	push   %edi
    19be:	e8 c9 22 00 00       	call   3c8c <unlink>
      unlink(file);
    19c3:	89 3c 24             	mov    %edi,(%esp)
    19c6:	e8 c1 22 00 00       	call   3c8c <unlink>
      unlink(file);
    19cb:	89 3c 24             	mov    %edi,(%esp)
    19ce:	e8 b9 22 00 00       	call   3c8c <unlink>
      unlink(file);
    19d3:	89 3c 24             	mov    %edi,(%esp)
    19d6:	e8 b1 22 00 00       	call   3c8c <unlink>
    19db:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    19de:	85 f6                	test   %esi,%esi
    19e0:	0f 84 9a 00 00 00    	je     1a80 <concreate+0x2cf>
      exit(0);
    else
      wait(NULL);
    19e6:	83 ec 0c             	sub    $0xc,%esp
    19e9:	6a 00                	push   $0x0
    19eb:	e8 54 22 00 00       	call   3c44 <wait>
  for(i = 0; i < 40; i++){
    19f0:	43                   	inc    %ebx
    19f1:	83 c4 10             	add    $0x10,%esp
    19f4:	83 fb 27             	cmp    $0x27,%ebx
    19f7:	0f 8f 8d 00 00 00    	jg     1a8a <concreate+0x2d9>
    file[1] = '0' + i;
    19fd:	8d 43 30             	lea    0x30(%ebx),%eax
    1a00:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1a03:	e8 2c 22 00 00       	call   3c34 <fork>
    1a08:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    1a0a:	85 c0                	test   %eax,%eax
    1a0c:	78 8e                	js     199c <concreate+0x1eb>
    if(((i % 3) == 0 && pid == 0) ||
    1a0e:	b9 03 00 00 00       	mov    $0x3,%ecx
    1a13:	89 d8                	mov    %ebx,%eax
    1a15:	99                   	cltd   
    1a16:	f7 f9                	idiv   %ecx
    1a18:	85 d2                	test   %edx,%edx
    1a1a:	75 04                	jne    1a20 <concreate+0x26f>
    1a1c:	85 f6                	test   %esi,%esi
    1a1e:	74 09                	je     1a29 <concreate+0x278>
    1a20:	83 fa 01             	cmp    $0x1,%edx
    1a23:	75 92                	jne    19b7 <concreate+0x206>
       ((i % 3) == 1 && pid != 0)){
    1a25:	85 f6                	test   %esi,%esi
    1a27:	74 8e                	je     19b7 <concreate+0x206>
      close(open(file, 0));
    1a29:	83 ec 08             	sub    $0x8,%esp
    1a2c:	6a 00                	push   $0x0
    1a2e:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    1a31:	57                   	push   %edi
    1a32:	e8 45 22 00 00       	call   3c7c <open>
    1a37:	89 04 24             	mov    %eax,(%esp)
    1a3a:	e8 25 22 00 00       	call   3c64 <close>
      close(open(file, 0));
    1a3f:	83 c4 08             	add    $0x8,%esp
    1a42:	6a 00                	push   $0x0
    1a44:	57                   	push   %edi
    1a45:	e8 32 22 00 00       	call   3c7c <open>
    1a4a:	89 04 24             	mov    %eax,(%esp)
    1a4d:	e8 12 22 00 00       	call   3c64 <close>
      close(open(file, 0));
    1a52:	83 c4 08             	add    $0x8,%esp
    1a55:	6a 00                	push   $0x0
    1a57:	57                   	push   %edi
    1a58:	e8 1f 22 00 00       	call   3c7c <open>
    1a5d:	89 04 24             	mov    %eax,(%esp)
    1a60:	e8 ff 21 00 00       	call   3c64 <close>
      close(open(file, 0));
    1a65:	83 c4 08             	add    $0x8,%esp
    1a68:	6a 00                	push   $0x0
    1a6a:	57                   	push   %edi
    1a6b:	e8 0c 22 00 00       	call   3c7c <open>
    1a70:	89 04 24             	mov    %eax,(%esp)
    1a73:	e8 ec 21 00 00       	call   3c64 <close>
    1a78:	83 c4 10             	add    $0x10,%esp
    1a7b:	e9 5e ff ff ff       	jmp    19de <concreate+0x22d>
      exit(0);
    1a80:	83 ec 0c             	sub    $0xc,%esp
    1a83:	6a 00                	push   $0x0
    1a85:	e8 b2 21 00 00       	call   3c3c <exit>
  }

  printf(1, "concreate ok\n");
    1a8a:	83 ec 08             	sub    $0x8,%esp
    1a8d:	68 e2 46 00 00       	push   $0x46e2
    1a92:	6a 01                	push   $0x1
    1a94:	e8 e6 22 00 00       	call   3d7f <printf>
}
    1a99:	83 c4 10             	add    $0x10,%esp
    1a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a9f:	5b                   	pop    %ebx
    1aa0:	5e                   	pop    %esi
    1aa1:	5f                   	pop    %edi
    1aa2:	5d                   	pop    %ebp
    1aa3:	c3                   	ret    

00001aa4 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1aa4:	55                   	push   %ebp
    1aa5:	89 e5                	mov    %esp,%ebp
    1aa7:	57                   	push   %edi
    1aa8:	56                   	push   %esi
    1aa9:	53                   	push   %ebx
    1aaa:	83 ec 14             	sub    $0x14,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1aad:	68 f0 46 00 00       	push   $0x46f0
    1ab2:	6a 01                	push   $0x1
    1ab4:	e8 c6 22 00 00       	call   3d7f <printf>

  unlink("x");
    1ab9:	c7 04 24 7d 49 00 00 	movl   $0x497d,(%esp)
    1ac0:	e8 c7 21 00 00       	call   3c8c <unlink>
  pid = fork();
    1ac5:	e8 6a 21 00 00       	call   3c34 <fork>
  if(pid < 0){
    1aca:	83 c4 10             	add    $0x10,%esp
    1acd:	85 c0                	test   %eax,%eax
    1acf:	78 10                	js     1ae1 <linkunlink+0x3d>
    1ad1:	89 c7                	mov    %eax,%edi
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
    1ad3:	74 27                	je     1afc <linkunlink+0x58>
    1ad5:	bb 01 00 00 00       	mov    $0x1,%ebx
    1ada:	be 00 00 00 00       	mov    $0x0,%esi
    1adf:	eb 40                	jmp    1b21 <linkunlink+0x7d>
    printf(1, "fork failed\n");
    1ae1:	83 ec 08             	sub    $0x8,%esp
    1ae4:	68 65 4f 00 00       	push   $0x4f65
    1ae9:	6a 01                	push   $0x1
    1aeb:	e8 8f 22 00 00       	call   3d7f <printf>
    exit(0);
    1af0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1af7:	e8 40 21 00 00       	call   3c3c <exit>
  unsigned int x = (pid ? 1 : 97);
    1afc:	bb 61 00 00 00       	mov    $0x61,%ebx
    1b01:	eb d7                	jmp    1ada <linkunlink+0x36>
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    1b03:	83 ec 08             	sub    $0x8,%esp
    1b06:	68 02 02 00 00       	push   $0x202
    1b0b:	68 7d 49 00 00       	push   $0x497d
    1b10:	e8 67 21 00 00       	call   3c7c <open>
    1b15:	89 04 24             	mov    %eax,(%esp)
    1b18:	e8 47 21 00 00       	call   3c64 <close>
    1b1d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b20:	46                   	inc    %esi
    1b21:	83 fe 63             	cmp    $0x63,%esi
    1b24:	7f 68                	jg     1b8e <linkunlink+0xea>
    x = x * 1103515245 + 12345;
    1b26:	89 d8                	mov    %ebx,%eax
    1b28:	c1 e0 09             	shl    $0x9,%eax
    1b2b:	29 d8                	sub    %ebx,%eax
    1b2d:	8d 14 83             	lea    (%ebx,%eax,4),%edx
    1b30:	89 d0                	mov    %edx,%eax
    1b32:	c1 e0 09             	shl    $0x9,%eax
    1b35:	29 d0                	sub    %edx,%eax
    1b37:	01 c0                	add    %eax,%eax
    1b39:	01 d8                	add    %ebx,%eax
    1b3b:	89 c2                	mov    %eax,%edx
    1b3d:	c1 e2 05             	shl    $0x5,%edx
    1b40:	01 d0                	add    %edx,%eax
    1b42:	c1 e0 02             	shl    $0x2,%eax
    1b45:	29 d8                	sub    %ebx,%eax
    1b47:	8d 9c 83 39 30 00 00 	lea    0x3039(%ebx,%eax,4),%ebx
    if((x % 3) == 0){
    1b4e:	b9 03 00 00 00       	mov    $0x3,%ecx
    1b53:	89 d8                	mov    %ebx,%eax
    1b55:	ba 00 00 00 00       	mov    $0x0,%edx
    1b5a:	f7 f1                	div    %ecx
    1b5c:	85 d2                	test   %edx,%edx
    1b5e:	74 a3                	je     1b03 <linkunlink+0x5f>
    } else if((x % 3) == 1){
    1b60:	83 fa 01             	cmp    $0x1,%edx
    1b63:	74 12                	je     1b77 <linkunlink+0xd3>
      link("cat", "x");
    } else {
      unlink("x");
    1b65:	83 ec 0c             	sub    $0xc,%esp
    1b68:	68 7d 49 00 00       	push   $0x497d
    1b6d:	e8 1a 21 00 00       	call   3c8c <unlink>
    1b72:	83 c4 10             	add    $0x10,%esp
    1b75:	eb a9                	jmp    1b20 <linkunlink+0x7c>
      link("cat", "x");
    1b77:	83 ec 08             	sub    $0x8,%esp
    1b7a:	68 7d 49 00 00       	push   $0x497d
    1b7f:	68 01 47 00 00       	push   $0x4701
    1b84:	e8 13 21 00 00       	call   3c9c <link>
    1b89:	83 c4 10             	add    $0x10,%esp
    1b8c:	eb 92                	jmp    1b20 <linkunlink+0x7c>
    }
  }

  if(pid)
    1b8e:	85 ff                	test   %edi,%edi
    1b90:	74 21                	je     1bb3 <linkunlink+0x10f>
    wait(NULL);
    1b92:	83 ec 0c             	sub    $0xc,%esp
    1b95:	6a 00                	push   $0x0
    1b97:	e8 a8 20 00 00       	call   3c44 <wait>
  else
    exit(0);

  printf(1, "linkunlink ok\n");
    1b9c:	83 c4 08             	add    $0x8,%esp
    1b9f:	68 05 47 00 00       	push   $0x4705
    1ba4:	6a 01                	push   $0x1
    1ba6:	e8 d4 21 00 00       	call   3d7f <printf>
}
    1bab:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bae:	5b                   	pop    %ebx
    1baf:	5e                   	pop    %esi
    1bb0:	5f                   	pop    %edi
    1bb1:	5d                   	pop    %ebp
    1bb2:	c3                   	ret    
    exit(0);
    1bb3:	83 ec 0c             	sub    $0xc,%esp
    1bb6:	6a 00                	push   $0x0
    1bb8:	e8 7f 20 00 00       	call   3c3c <exit>

00001bbd <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1bbd:	55                   	push   %ebp
    1bbe:	89 e5                	mov    %esp,%ebp
    1bc0:	53                   	push   %ebx
    1bc1:	83 ec 1c             	sub    $0x1c,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1bc4:	68 14 47 00 00       	push   $0x4714
    1bc9:	6a 01                	push   $0x1
    1bcb:	e8 af 21 00 00       	call   3d7f <printf>
  unlink("bd");
    1bd0:	c7 04 24 21 47 00 00 	movl   $0x4721,(%esp)
    1bd7:	e8 b0 20 00 00       	call   3c8c <unlink>

  fd = open("bd", O_CREATE);
    1bdc:	83 c4 08             	add    $0x8,%esp
    1bdf:	68 00 02 00 00       	push   $0x200
    1be4:	68 21 47 00 00       	push   $0x4721
    1be9:	e8 8e 20 00 00       	call   3c7c <open>
  if(fd < 0){
    1bee:	83 c4 10             	add    $0x10,%esp
    1bf1:	85 c0                	test   %eax,%eax
    1bf3:	78 13                	js     1c08 <bigdir+0x4b>
    printf(1, "bigdir create failed\n");
    exit(0);
  }
  close(fd);
    1bf5:	83 ec 0c             	sub    $0xc,%esp
    1bf8:	50                   	push   %eax
    1bf9:	e8 66 20 00 00       	call   3c64 <close>

  for(i = 0; i < 500; i++){
    1bfe:	83 c4 10             	add    $0x10,%esp
    1c01:	bb 00 00 00 00       	mov    $0x0,%ebx
    1c06:	eb 43                	jmp    1c4b <bigdir+0x8e>
    printf(1, "bigdir create failed\n");
    1c08:	83 ec 08             	sub    $0x8,%esp
    1c0b:	68 24 47 00 00       	push   $0x4724
    1c10:	6a 01                	push   $0x1
    1c12:	e8 68 21 00 00       	call   3d7f <printf>
    exit(0);
    1c17:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c1e:	e8 19 20 00 00       	call   3c3c <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c23:	8d 43 3f             	lea    0x3f(%ebx),%eax
    1c26:	eb 35                	jmp    1c5d <bigdir+0xa0>
    name[2] = '0' + (i % 64);
    1c28:	83 c0 30             	add    $0x30,%eax
    1c2b:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1c2e:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1c32:	83 ec 08             	sub    $0x8,%esp
    1c35:	8d 45 ee             	lea    -0x12(%ebp),%eax
    1c38:	50                   	push   %eax
    1c39:	68 21 47 00 00       	push   $0x4721
    1c3e:	e8 59 20 00 00       	call   3c9c <link>
    1c43:	83 c4 10             	add    $0x10,%esp
    1c46:	85 c0                	test   %eax,%eax
    1c48:	75 2c                	jne    1c76 <bigdir+0xb9>
  for(i = 0; i < 500; i++){
    1c4a:	43                   	inc    %ebx
    1c4b:	81 fb f3 01 00 00    	cmp    $0x1f3,%ebx
    1c51:	7f 3e                	jg     1c91 <bigdir+0xd4>
    name[0] = 'x';
    1c53:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1c57:	89 d8                	mov    %ebx,%eax
    1c59:	85 db                	test   %ebx,%ebx
    1c5b:	78 c6                	js     1c23 <bigdir+0x66>
    1c5d:	c1 f8 06             	sar    $0x6,%eax
    1c60:	83 c0 30             	add    $0x30,%eax
    1c63:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1c66:	89 d8                	mov    %ebx,%eax
    1c68:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1c6d:	79 b9                	jns    1c28 <bigdir+0x6b>
    1c6f:	48                   	dec    %eax
    1c70:	83 c8 c0             	or     $0xffffffc0,%eax
    1c73:	40                   	inc    %eax
    1c74:	eb b2                	jmp    1c28 <bigdir+0x6b>
      printf(1, "bigdir link failed\n");
    1c76:	83 ec 08             	sub    $0x8,%esp
    1c79:	68 3a 47 00 00       	push   $0x473a
    1c7e:	6a 01                	push   $0x1
    1c80:	e8 fa 20 00 00       	call   3d7f <printf>
      exit(0);
    1c85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c8c:	e8 ab 1f 00 00       	call   3c3c <exit>
    }
  }

  unlink("bd");
    1c91:	83 ec 0c             	sub    $0xc,%esp
    1c94:	68 21 47 00 00       	push   $0x4721
    1c99:	e8 ee 1f 00 00       	call   3c8c <unlink>
  for(i = 0; i < 500; i++){
    1c9e:	83 c4 10             	add    $0x10,%esp
    1ca1:	bb 00 00 00 00       	mov    $0x0,%ebx
    1ca6:	eb 23                	jmp    1ccb <bigdir+0x10e>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1ca8:	8d 43 3f             	lea    0x3f(%ebx),%eax
    1cab:	eb 30                	jmp    1cdd <bigdir+0x120>
    name[2] = '0' + (i % 64);
    1cad:	83 c0 30             	add    $0x30,%eax
    1cb0:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1cb3:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1cb7:	83 ec 0c             	sub    $0xc,%esp
    1cba:	8d 45 ee             	lea    -0x12(%ebp),%eax
    1cbd:	50                   	push   %eax
    1cbe:	e8 c9 1f 00 00       	call   3c8c <unlink>
    1cc3:	83 c4 10             	add    $0x10,%esp
    1cc6:	85 c0                	test   %eax,%eax
    1cc8:	75 2c                	jne    1cf6 <bigdir+0x139>
  for(i = 0; i < 500; i++){
    1cca:	43                   	inc    %ebx
    1ccb:	81 fb f3 01 00 00    	cmp    $0x1f3,%ebx
    1cd1:	7f 3e                	jg     1d11 <bigdir+0x154>
    name[0] = 'x';
    1cd3:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1cd7:	89 d8                	mov    %ebx,%eax
    1cd9:	85 db                	test   %ebx,%ebx
    1cdb:	78 cb                	js     1ca8 <bigdir+0xeb>
    1cdd:	c1 f8 06             	sar    $0x6,%eax
    1ce0:	83 c0 30             	add    $0x30,%eax
    1ce3:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1ce6:	89 d8                	mov    %ebx,%eax
    1ce8:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1ced:	79 be                	jns    1cad <bigdir+0xf0>
    1cef:	48                   	dec    %eax
    1cf0:	83 c8 c0             	or     $0xffffffc0,%eax
    1cf3:	40                   	inc    %eax
    1cf4:	eb b7                	jmp    1cad <bigdir+0xf0>
      printf(1, "bigdir unlink failed");
    1cf6:	83 ec 08             	sub    $0x8,%esp
    1cf9:	68 4e 47 00 00       	push   $0x474e
    1cfe:	6a 01                	push   $0x1
    1d00:	e8 7a 20 00 00       	call   3d7f <printf>
      exit(0);
    1d05:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d0c:	e8 2b 1f 00 00       	call   3c3c <exit>
    }
  }

  printf(1, "bigdir ok\n");
    1d11:	83 ec 08             	sub    $0x8,%esp
    1d14:	68 63 47 00 00       	push   $0x4763
    1d19:	6a 01                	push   $0x1
    1d1b:	e8 5f 20 00 00       	call   3d7f <printf>
}
    1d20:	83 c4 10             	add    $0x10,%esp
    1d23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1d26:	c9                   	leave  
    1d27:	c3                   	ret    

00001d28 <subdir>:

void
subdir(void)
{
    1d28:	55                   	push   %ebp
    1d29:	89 e5                	mov    %esp,%ebp
    1d2b:	53                   	push   %ebx
    1d2c:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1d2f:	68 6e 47 00 00       	push   $0x476e
    1d34:	6a 01                	push   $0x1
    1d36:	e8 44 20 00 00       	call   3d7f <printf>

  unlink("ff");
    1d3b:	c7 04 24 f7 47 00 00 	movl   $0x47f7,(%esp)
    1d42:	e8 45 1f 00 00       	call   3c8c <unlink>
  if(mkdir("dd") != 0){
    1d47:	c7 04 24 94 48 00 00 	movl   $0x4894,(%esp)
    1d4e:	e8 51 1f 00 00       	call   3ca4 <mkdir>
    1d53:	83 c4 10             	add    $0x10,%esp
    1d56:	85 c0                	test   %eax,%eax
    1d58:	0f 85 14 04 00 00    	jne    2172 <subdir+0x44a>
    printf(1, "subdir mkdir dd failed\n");
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d5e:	83 ec 08             	sub    $0x8,%esp
    1d61:	68 02 02 00 00       	push   $0x202
    1d66:	68 cd 47 00 00       	push   $0x47cd
    1d6b:	e8 0c 1f 00 00       	call   3c7c <open>
    1d70:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d72:	83 c4 10             	add    $0x10,%esp
    1d75:	85 c0                	test   %eax,%eax
    1d77:	0f 88 10 04 00 00    	js     218d <subdir+0x465>
    printf(1, "create dd/ff failed\n");
    exit(0);
  }
  write(fd, "ff", 2);
    1d7d:	83 ec 04             	sub    $0x4,%esp
    1d80:	6a 02                	push   $0x2
    1d82:	68 f7 47 00 00       	push   $0x47f7
    1d87:	50                   	push   %eax
    1d88:	e8 cf 1e 00 00       	call   3c5c <write>
  close(fd);
    1d8d:	89 1c 24             	mov    %ebx,(%esp)
    1d90:	e8 cf 1e 00 00       	call   3c64 <close>

  if(unlink("dd") >= 0){
    1d95:	c7 04 24 94 48 00 00 	movl   $0x4894,(%esp)
    1d9c:	e8 eb 1e 00 00       	call   3c8c <unlink>
    1da1:	83 c4 10             	add    $0x10,%esp
    1da4:	85 c0                	test   %eax,%eax
    1da6:	0f 89 fc 03 00 00    	jns    21a8 <subdir+0x480>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    1dac:	83 ec 0c             	sub    $0xc,%esp
    1daf:	68 a8 47 00 00       	push   $0x47a8
    1db4:	e8 eb 1e 00 00       	call   3ca4 <mkdir>
    1db9:	83 c4 10             	add    $0x10,%esp
    1dbc:	85 c0                	test   %eax,%eax
    1dbe:	0f 85 ff 03 00 00    	jne    21c3 <subdir+0x49b>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dc4:	83 ec 08             	sub    $0x8,%esp
    1dc7:	68 02 02 00 00       	push   $0x202
    1dcc:	68 ca 47 00 00       	push   $0x47ca
    1dd1:	e8 a6 1e 00 00       	call   3c7c <open>
    1dd6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dd8:	83 c4 10             	add    $0x10,%esp
    1ddb:	85 c0                	test   %eax,%eax
    1ddd:	0f 88 fb 03 00 00    	js     21de <subdir+0x4b6>
    printf(1, "create dd/dd/ff failed\n");
    exit(0);
  }
  write(fd, "FF", 2);
    1de3:	83 ec 04             	sub    $0x4,%esp
    1de6:	6a 02                	push   $0x2
    1de8:	68 eb 47 00 00       	push   $0x47eb
    1ded:	50                   	push   %eax
    1dee:	e8 69 1e 00 00       	call   3c5c <write>
  close(fd);
    1df3:	89 1c 24             	mov    %ebx,(%esp)
    1df6:	e8 69 1e 00 00       	call   3c64 <close>

  fd = open("dd/dd/../ff", 0);
    1dfb:	83 c4 08             	add    $0x8,%esp
    1dfe:	6a 00                	push   $0x0
    1e00:	68 ee 47 00 00       	push   $0x47ee
    1e05:	e8 72 1e 00 00       	call   3c7c <open>
    1e0a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e0c:	83 c4 10             	add    $0x10,%esp
    1e0f:	85 c0                	test   %eax,%eax
    1e11:	0f 88 e2 03 00 00    	js     21f9 <subdir+0x4d1>
    printf(1, "open dd/dd/../ff failed\n");
    exit(0);
  }
  cc = read(fd, buf, sizeof(buf));
    1e17:	83 ec 04             	sub    $0x4,%esp
    1e1a:	68 00 20 00 00       	push   $0x2000
    1e1f:	68 20 88 00 00       	push   $0x8820
    1e24:	50                   	push   %eax
    1e25:	e8 2a 1e 00 00       	call   3c54 <read>
  if(cc != 2 || buf[0] != 'f'){
    1e2a:	83 c4 10             	add    $0x10,%esp
    1e2d:	83 f8 02             	cmp    $0x2,%eax
    1e30:	0f 85 de 03 00 00    	jne    2214 <subdir+0x4ec>
    1e36:	80 3d 20 88 00 00 66 	cmpb   $0x66,0x8820
    1e3d:	0f 85 d1 03 00 00    	jne    2214 <subdir+0x4ec>
    printf(1, "dd/dd/../ff wrong content\n");
    exit(0);
  }
  close(fd);
    1e43:	83 ec 0c             	sub    $0xc,%esp
    1e46:	53                   	push   %ebx
    1e47:	e8 18 1e 00 00       	call   3c64 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e4c:	83 c4 08             	add    $0x8,%esp
    1e4f:	68 2e 48 00 00       	push   $0x482e
    1e54:	68 ca 47 00 00       	push   $0x47ca
    1e59:	e8 3e 1e 00 00       	call   3c9c <link>
    1e5e:	83 c4 10             	add    $0x10,%esp
    1e61:	85 c0                	test   %eax,%eax
    1e63:	0f 85 c6 03 00 00    	jne    222f <subdir+0x507>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit(0);
  }

  if(unlink("dd/dd/ff") != 0){
    1e69:	83 ec 0c             	sub    $0xc,%esp
    1e6c:	68 ca 47 00 00       	push   $0x47ca
    1e71:	e8 16 1e 00 00       	call   3c8c <unlink>
    1e76:	83 c4 10             	add    $0x10,%esp
    1e79:	85 c0                	test   %eax,%eax
    1e7b:	0f 85 c9 03 00 00    	jne    224a <subdir+0x522>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e81:	83 ec 08             	sub    $0x8,%esp
    1e84:	6a 00                	push   $0x0
    1e86:	68 ca 47 00 00       	push   $0x47ca
    1e8b:	e8 ec 1d 00 00       	call   3c7c <open>
    1e90:	83 c4 10             	add    $0x10,%esp
    1e93:	85 c0                	test   %eax,%eax
    1e95:	0f 89 ca 03 00 00    	jns    2265 <subdir+0x53d>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    1e9b:	83 ec 0c             	sub    $0xc,%esp
    1e9e:	68 94 48 00 00       	push   $0x4894
    1ea3:	e8 04 1e 00 00       	call   3cac <chdir>
    1ea8:	83 c4 10             	add    $0x10,%esp
    1eab:	85 c0                	test   %eax,%eax
    1ead:	0f 85 cd 03 00 00    	jne    2280 <subdir+0x558>
    printf(1, "chdir dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../dd") != 0){
    1eb3:	83 ec 0c             	sub    $0xc,%esp
    1eb6:	68 62 48 00 00       	push   $0x4862
    1ebb:	e8 ec 1d 00 00       	call   3cac <chdir>
    1ec0:	83 c4 10             	add    $0x10,%esp
    1ec3:	85 c0                	test   %eax,%eax
    1ec5:	0f 85 d0 03 00 00    	jne    229b <subdir+0x573>
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../../dd") != 0){
    1ecb:	83 ec 0c             	sub    $0xc,%esp
    1ece:	68 88 48 00 00       	push   $0x4888
    1ed3:	e8 d4 1d 00 00       	call   3cac <chdir>
    1ed8:	83 c4 10             	add    $0x10,%esp
    1edb:	85 c0                	test   %eax,%eax
    1edd:	0f 85 d3 03 00 00    	jne    22b6 <subdir+0x58e>
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("./..") != 0){
    1ee3:	83 ec 0c             	sub    $0xc,%esp
    1ee6:	68 97 48 00 00       	push   $0x4897
    1eeb:	e8 bc 1d 00 00       	call   3cac <chdir>
    1ef0:	83 c4 10             	add    $0x10,%esp
    1ef3:	85 c0                	test   %eax,%eax
    1ef5:	0f 85 d6 03 00 00    	jne    22d1 <subdir+0x5a9>
    printf(1, "chdir ./.. failed\n");
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
    1efb:	83 ec 08             	sub    $0x8,%esp
    1efe:	6a 00                	push   $0x0
    1f00:	68 2e 48 00 00       	push   $0x482e
    1f05:	e8 72 1d 00 00       	call   3c7c <open>
    1f0a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f0c:	83 c4 10             	add    $0x10,%esp
    1f0f:	85 c0                	test   %eax,%eax
    1f11:	0f 88 d5 03 00 00    	js     22ec <subdir+0x5c4>
    printf(1, "open dd/dd/ffff failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1f17:	83 ec 04             	sub    $0x4,%esp
    1f1a:	68 00 20 00 00       	push   $0x2000
    1f1f:	68 20 88 00 00       	push   $0x8820
    1f24:	50                   	push   %eax
    1f25:	e8 2a 1d 00 00       	call   3c54 <read>
    1f2a:	83 c4 10             	add    $0x10,%esp
    1f2d:	83 f8 02             	cmp    $0x2,%eax
    1f30:	0f 85 d1 03 00 00    	jne    2307 <subdir+0x5df>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit(0);
  }
  close(fd);
    1f36:	83 ec 0c             	sub    $0xc,%esp
    1f39:	53                   	push   %ebx
    1f3a:	e8 25 1d 00 00       	call   3c64 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f3f:	83 c4 08             	add    $0x8,%esp
    1f42:	6a 00                	push   $0x0
    1f44:	68 ca 47 00 00       	push   $0x47ca
    1f49:	e8 2e 1d 00 00       	call   3c7c <open>
    1f4e:	83 c4 10             	add    $0x10,%esp
    1f51:	85 c0                	test   %eax,%eax
    1f53:	0f 89 c9 03 00 00    	jns    2322 <subdir+0x5fa>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f59:	83 ec 08             	sub    $0x8,%esp
    1f5c:	68 02 02 00 00       	push   $0x202
    1f61:	68 e2 48 00 00       	push   $0x48e2
    1f66:	e8 11 1d 00 00       	call   3c7c <open>
    1f6b:	83 c4 10             	add    $0x10,%esp
    1f6e:	85 c0                	test   %eax,%eax
    1f70:	0f 89 c7 03 00 00    	jns    233d <subdir+0x615>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f76:	83 ec 08             	sub    $0x8,%esp
    1f79:	68 02 02 00 00       	push   $0x202
    1f7e:	68 07 49 00 00       	push   $0x4907
    1f83:	e8 f4 1c 00 00       	call   3c7c <open>
    1f88:	83 c4 10             	add    $0x10,%esp
    1f8b:	85 c0                	test   %eax,%eax
    1f8d:	0f 89 c5 03 00 00    	jns    2358 <subdir+0x630>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    1f93:	83 ec 08             	sub    $0x8,%esp
    1f96:	68 00 02 00 00       	push   $0x200
    1f9b:	68 94 48 00 00       	push   $0x4894
    1fa0:	e8 d7 1c 00 00       	call   3c7c <open>
    1fa5:	83 c4 10             	add    $0x10,%esp
    1fa8:	85 c0                	test   %eax,%eax
    1faa:	0f 89 c3 03 00 00    	jns    2373 <subdir+0x64b>
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    1fb0:	83 ec 08             	sub    $0x8,%esp
    1fb3:	6a 02                	push   $0x2
    1fb5:	68 94 48 00 00       	push   $0x4894
    1fba:	e8 bd 1c 00 00       	call   3c7c <open>
    1fbf:	83 c4 10             	add    $0x10,%esp
    1fc2:	85 c0                	test   %eax,%eax
    1fc4:	0f 89 c4 03 00 00    	jns    238e <subdir+0x666>
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    1fca:	83 ec 08             	sub    $0x8,%esp
    1fcd:	6a 01                	push   $0x1
    1fcf:	68 94 48 00 00       	push   $0x4894
    1fd4:	e8 a3 1c 00 00       	call   3c7c <open>
    1fd9:	83 c4 10             	add    $0x10,%esp
    1fdc:	85 c0                	test   %eax,%eax
    1fde:	0f 89 c5 03 00 00    	jns    23a9 <subdir+0x681>
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fe4:	83 ec 08             	sub    $0x8,%esp
    1fe7:	68 76 49 00 00       	push   $0x4976
    1fec:	68 e2 48 00 00       	push   $0x48e2
    1ff1:	e8 a6 1c 00 00       	call   3c9c <link>
    1ff6:	83 c4 10             	add    $0x10,%esp
    1ff9:	85 c0                	test   %eax,%eax
    1ffb:	0f 84 c3 03 00 00    	je     23c4 <subdir+0x69c>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2001:	83 ec 08             	sub    $0x8,%esp
    2004:	68 76 49 00 00       	push   $0x4976
    2009:	68 07 49 00 00       	push   $0x4907
    200e:	e8 89 1c 00 00       	call   3c9c <link>
    2013:	83 c4 10             	add    $0x10,%esp
    2016:	85 c0                	test   %eax,%eax
    2018:	0f 84 c1 03 00 00    	je     23df <subdir+0x6b7>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    201e:	83 ec 08             	sub    $0x8,%esp
    2021:	68 2e 48 00 00       	push   $0x482e
    2026:	68 cd 47 00 00       	push   $0x47cd
    202b:	e8 6c 1c 00 00       	call   3c9c <link>
    2030:	83 c4 10             	add    $0x10,%esp
    2033:	85 c0                	test   %eax,%eax
    2035:	0f 84 bf 03 00 00    	je     23fa <subdir+0x6d2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    203b:	83 ec 0c             	sub    $0xc,%esp
    203e:	68 e2 48 00 00       	push   $0x48e2
    2043:	e8 5c 1c 00 00       	call   3ca4 <mkdir>
    2048:	83 c4 10             	add    $0x10,%esp
    204b:	85 c0                	test   %eax,%eax
    204d:	0f 84 c2 03 00 00    	je     2415 <subdir+0x6ed>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    2053:	83 ec 0c             	sub    $0xc,%esp
    2056:	68 07 49 00 00       	push   $0x4907
    205b:	e8 44 1c 00 00       	call   3ca4 <mkdir>
    2060:	83 c4 10             	add    $0x10,%esp
    2063:	85 c0                	test   %eax,%eax
    2065:	0f 84 c5 03 00 00    	je     2430 <subdir+0x708>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    206b:	83 ec 0c             	sub    $0xc,%esp
    206e:	68 2e 48 00 00       	push   $0x482e
    2073:	e8 2c 1c 00 00       	call   3ca4 <mkdir>
    2078:	83 c4 10             	add    $0x10,%esp
    207b:	85 c0                	test   %eax,%eax
    207d:	0f 84 c8 03 00 00    	je     244b <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    2083:	83 ec 0c             	sub    $0xc,%esp
    2086:	68 07 49 00 00       	push   $0x4907
    208b:	e8 fc 1b 00 00       	call   3c8c <unlink>
    2090:	83 c4 10             	add    $0x10,%esp
    2093:	85 c0                	test   %eax,%eax
    2095:	0f 84 cb 03 00 00    	je     2466 <subdir+0x73e>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    209b:	83 ec 0c             	sub    $0xc,%esp
    209e:	68 e2 48 00 00       	push   $0x48e2
    20a3:	e8 e4 1b 00 00       	call   3c8c <unlink>
    20a8:	83 c4 10             	add    $0x10,%esp
    20ab:	85 c0                	test   %eax,%eax
    20ad:	0f 84 ce 03 00 00    	je     2481 <subdir+0x759>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    20b3:	83 ec 0c             	sub    $0xc,%esp
    20b6:	68 cd 47 00 00       	push   $0x47cd
    20bb:	e8 ec 1b 00 00       	call   3cac <chdir>
    20c0:	83 c4 10             	add    $0x10,%esp
    20c3:	85 c0                	test   %eax,%eax
    20c5:	0f 84 d1 03 00 00    	je     249c <subdir+0x774>
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    20cb:	83 ec 0c             	sub    $0xc,%esp
    20ce:	68 79 49 00 00       	push   $0x4979
    20d3:	e8 d4 1b 00 00       	call   3cac <chdir>
    20d8:	83 c4 10             	add    $0x10,%esp
    20db:	85 c0                	test   %eax,%eax
    20dd:	0f 84 d4 03 00 00    	je     24b7 <subdir+0x78f>
    printf(1, "chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    20e3:	83 ec 0c             	sub    $0xc,%esp
    20e6:	68 2e 48 00 00       	push   $0x482e
    20eb:	e8 9c 1b 00 00       	call   3c8c <unlink>
    20f0:	83 c4 10             	add    $0x10,%esp
    20f3:	85 c0                	test   %eax,%eax
    20f5:	0f 85 d7 03 00 00    	jne    24d2 <subdir+0x7aa>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd/ff") != 0){
    20fb:	83 ec 0c             	sub    $0xc,%esp
    20fe:	68 cd 47 00 00       	push   $0x47cd
    2103:	e8 84 1b 00 00       	call   3c8c <unlink>
    2108:	83 c4 10             	add    $0x10,%esp
    210b:	85 c0                	test   %eax,%eax
    210d:	0f 85 da 03 00 00    	jne    24ed <subdir+0x7c5>
    printf(1, "unlink dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd") == 0){
    2113:	83 ec 0c             	sub    $0xc,%esp
    2116:	68 94 48 00 00       	push   $0x4894
    211b:	e8 6c 1b 00 00       	call   3c8c <unlink>
    2120:	83 c4 10             	add    $0x10,%esp
    2123:	85 c0                	test   %eax,%eax
    2125:	0f 84 dd 03 00 00    	je     2508 <subdir+0x7e0>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    212b:	83 ec 0c             	sub    $0xc,%esp
    212e:	68 a9 47 00 00       	push   $0x47a9
    2133:	e8 54 1b 00 00       	call   3c8c <unlink>
    2138:	83 c4 10             	add    $0x10,%esp
    213b:	85 c0                	test   %eax,%eax
    213d:	0f 88 e0 03 00 00    	js     2523 <subdir+0x7fb>
    printf(1, "unlink dd/dd failed\n");
    exit(0);
  }
  if(unlink("dd") < 0){
    2143:	83 ec 0c             	sub    $0xc,%esp
    2146:	68 94 48 00 00       	push   $0x4894
    214b:	e8 3c 1b 00 00       	call   3c8c <unlink>
    2150:	83 c4 10             	add    $0x10,%esp
    2153:	85 c0                	test   %eax,%eax
    2155:	0f 88 e3 03 00 00    	js     253e <subdir+0x816>
    printf(1, "unlink dd failed\n");
    exit(0);
  }

  printf(1, "subdir ok\n");
    215b:	83 ec 08             	sub    $0x8,%esp
    215e:	68 76 4a 00 00       	push   $0x4a76
    2163:	6a 01                	push   $0x1
    2165:	e8 15 1c 00 00       	call   3d7f <printf>
}
    216a:	83 c4 10             	add    $0x10,%esp
    216d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2170:	c9                   	leave  
    2171:	c3                   	ret    
    printf(1, "subdir mkdir dd failed\n");
    2172:	83 ec 08             	sub    $0x8,%esp
    2175:	68 7b 47 00 00       	push   $0x477b
    217a:	6a 01                	push   $0x1
    217c:	e8 fe 1b 00 00       	call   3d7f <printf>
    exit(0);
    2181:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2188:	e8 af 1a 00 00       	call   3c3c <exit>
    printf(1, "create dd/ff failed\n");
    218d:	83 ec 08             	sub    $0x8,%esp
    2190:	68 93 47 00 00       	push   $0x4793
    2195:	6a 01                	push   $0x1
    2197:	e8 e3 1b 00 00       	call   3d7f <printf>
    exit(0);
    219c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    21a3:	e8 94 1a 00 00       	call   3c3c <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    21a8:	83 ec 08             	sub    $0x8,%esp
    21ab:	68 60 52 00 00       	push   $0x5260
    21b0:	6a 01                	push   $0x1
    21b2:	e8 c8 1b 00 00       	call   3d7f <printf>
    exit(0);
    21b7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    21be:	e8 79 1a 00 00       	call   3c3c <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    21c3:	83 ec 08             	sub    $0x8,%esp
    21c6:	68 af 47 00 00       	push   $0x47af
    21cb:	6a 01                	push   $0x1
    21cd:	e8 ad 1b 00 00       	call   3d7f <printf>
    exit(0);
    21d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    21d9:	e8 5e 1a 00 00       	call   3c3c <exit>
    printf(1, "create dd/dd/ff failed\n");
    21de:	83 ec 08             	sub    $0x8,%esp
    21e1:	68 d3 47 00 00       	push   $0x47d3
    21e6:	6a 01                	push   $0x1
    21e8:	e8 92 1b 00 00       	call   3d7f <printf>
    exit(0);
    21ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    21f4:	e8 43 1a 00 00       	call   3c3c <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21f9:	83 ec 08             	sub    $0x8,%esp
    21fc:	68 fa 47 00 00       	push   $0x47fa
    2201:	6a 01                	push   $0x1
    2203:	e8 77 1b 00 00       	call   3d7f <printf>
    exit(0);
    2208:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    220f:	e8 28 1a 00 00       	call   3c3c <exit>
    printf(1, "dd/dd/../ff wrong content\n");
    2214:	83 ec 08             	sub    $0x8,%esp
    2217:	68 13 48 00 00       	push   $0x4813
    221c:	6a 01                	push   $0x1
    221e:	e8 5c 1b 00 00       	call   3d7f <printf>
    exit(0);
    2223:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    222a:	e8 0d 1a 00 00       	call   3c3c <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    222f:	83 ec 08             	sub    $0x8,%esp
    2232:	68 88 52 00 00       	push   $0x5288
    2237:	6a 01                	push   $0x1
    2239:	e8 41 1b 00 00       	call   3d7f <printf>
    exit(0);
    223e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2245:	e8 f2 19 00 00       	call   3c3c <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    224a:	83 ec 08             	sub    $0x8,%esp
    224d:	68 39 48 00 00       	push   $0x4839
    2252:	6a 01                	push   $0x1
    2254:	e8 26 1b 00 00       	call   3d7f <printf>
    exit(0);
    2259:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2260:	e8 d7 19 00 00       	call   3c3c <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2265:	83 ec 08             	sub    $0x8,%esp
    2268:	68 ac 52 00 00       	push   $0x52ac
    226d:	6a 01                	push   $0x1
    226f:	e8 0b 1b 00 00       	call   3d7f <printf>
    exit(0);
    2274:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    227b:	e8 bc 19 00 00       	call   3c3c <exit>
    printf(1, "chdir dd failed\n");
    2280:	83 ec 08             	sub    $0x8,%esp
    2283:	68 51 48 00 00       	push   $0x4851
    2288:	6a 01                	push   $0x1
    228a:	e8 f0 1a 00 00       	call   3d7f <printf>
    exit(0);
    228f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2296:	e8 a1 19 00 00       	call   3c3c <exit>
    printf(1, "chdir dd/../../dd failed\n");
    229b:	83 ec 08             	sub    $0x8,%esp
    229e:	68 6e 48 00 00       	push   $0x486e
    22a3:	6a 01                	push   $0x1
    22a5:	e8 d5 1a 00 00       	call   3d7f <printf>
    exit(0);
    22aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    22b1:	e8 86 19 00 00       	call   3c3c <exit>
    printf(1, "chdir dd/../../dd failed\n");
    22b6:	83 ec 08             	sub    $0x8,%esp
    22b9:	68 6e 48 00 00       	push   $0x486e
    22be:	6a 01                	push   $0x1
    22c0:	e8 ba 1a 00 00       	call   3d7f <printf>
    exit(0);
    22c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    22cc:	e8 6b 19 00 00       	call   3c3c <exit>
    printf(1, "chdir ./.. failed\n");
    22d1:	83 ec 08             	sub    $0x8,%esp
    22d4:	68 9c 48 00 00       	push   $0x489c
    22d9:	6a 01                	push   $0x1
    22db:	e8 9f 1a 00 00       	call   3d7f <printf>
    exit(0);
    22e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    22e7:	e8 50 19 00 00       	call   3c3c <exit>
    printf(1, "open dd/dd/ffff failed\n");
    22ec:	83 ec 08             	sub    $0x8,%esp
    22ef:	68 af 48 00 00       	push   $0x48af
    22f4:	6a 01                	push   $0x1
    22f6:	e8 84 1a 00 00       	call   3d7f <printf>
    exit(0);
    22fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2302:	e8 35 19 00 00       	call   3c3c <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    2307:	83 ec 08             	sub    $0x8,%esp
    230a:	68 c7 48 00 00       	push   $0x48c7
    230f:	6a 01                	push   $0x1
    2311:	e8 69 1a 00 00       	call   3d7f <printf>
    exit(0);
    2316:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    231d:	e8 1a 19 00 00       	call   3c3c <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2322:	83 ec 08             	sub    $0x8,%esp
    2325:	68 d0 52 00 00       	push   $0x52d0
    232a:	6a 01                	push   $0x1
    232c:	e8 4e 1a 00 00       	call   3d7f <printf>
    exit(0);
    2331:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2338:	e8 ff 18 00 00       	call   3c3c <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    233d:	83 ec 08             	sub    $0x8,%esp
    2340:	68 eb 48 00 00       	push   $0x48eb
    2345:	6a 01                	push   $0x1
    2347:	e8 33 1a 00 00       	call   3d7f <printf>
    exit(0);
    234c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2353:	e8 e4 18 00 00       	call   3c3c <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2358:	83 ec 08             	sub    $0x8,%esp
    235b:	68 10 49 00 00       	push   $0x4910
    2360:	6a 01                	push   $0x1
    2362:	e8 18 1a 00 00       	call   3d7f <printf>
    exit(0);
    2367:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    236e:	e8 c9 18 00 00       	call   3c3c <exit>
    printf(1, "create dd succeeded!\n");
    2373:	83 ec 08             	sub    $0x8,%esp
    2376:	68 2c 49 00 00       	push   $0x492c
    237b:	6a 01                	push   $0x1
    237d:	e8 fd 19 00 00       	call   3d7f <printf>
    exit(0);
    2382:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2389:	e8 ae 18 00 00       	call   3c3c <exit>
    printf(1, "open dd rdwr succeeded!\n");
    238e:	83 ec 08             	sub    $0x8,%esp
    2391:	68 42 49 00 00       	push   $0x4942
    2396:	6a 01                	push   $0x1
    2398:	e8 e2 19 00 00       	call   3d7f <printf>
    exit(0);
    239d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    23a4:	e8 93 18 00 00       	call   3c3c <exit>
    printf(1, "open dd wronly succeeded!\n");
    23a9:	83 ec 08             	sub    $0x8,%esp
    23ac:	68 5b 49 00 00       	push   $0x495b
    23b1:	6a 01                	push   $0x1
    23b3:	e8 c7 19 00 00       	call   3d7f <printf>
    exit(0);
    23b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    23bf:	e8 78 18 00 00       	call   3c3c <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    23c4:	83 ec 08             	sub    $0x8,%esp
    23c7:	68 f8 52 00 00       	push   $0x52f8
    23cc:	6a 01                	push   $0x1
    23ce:	e8 ac 19 00 00       	call   3d7f <printf>
    exit(0);
    23d3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    23da:	e8 5d 18 00 00       	call   3c3c <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    23df:	83 ec 08             	sub    $0x8,%esp
    23e2:	68 1c 53 00 00       	push   $0x531c
    23e7:	6a 01                	push   $0x1
    23e9:	e8 91 19 00 00       	call   3d7f <printf>
    exit(0);
    23ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    23f5:	e8 42 18 00 00       	call   3c3c <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 40 53 00 00       	push   $0x5340
    2402:	6a 01                	push   $0x1
    2404:	e8 76 19 00 00       	call   3d7f <printf>
    exit(0);
    2409:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2410:	e8 27 18 00 00       	call   3c3c <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2415:	83 ec 08             	sub    $0x8,%esp
    2418:	68 7f 49 00 00       	push   $0x497f
    241d:	6a 01                	push   $0x1
    241f:	e8 5b 19 00 00       	call   3d7f <printf>
    exit(0);
    2424:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    242b:	e8 0c 18 00 00       	call   3c3c <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 9a 49 00 00       	push   $0x499a
    2438:	6a 01                	push   $0x1
    243a:	e8 40 19 00 00       	call   3d7f <printf>
    exit(0);
    243f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2446:	e8 f1 17 00 00       	call   3c3c <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    244b:	83 ec 08             	sub    $0x8,%esp
    244e:	68 b5 49 00 00       	push   $0x49b5
    2453:	6a 01                	push   $0x1
    2455:	e8 25 19 00 00       	call   3d7f <printf>
    exit(0);
    245a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2461:	e8 d6 17 00 00       	call   3c3c <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2466:	83 ec 08             	sub    $0x8,%esp
    2469:	68 d2 49 00 00       	push   $0x49d2
    246e:	6a 01                	push   $0x1
    2470:	e8 0a 19 00 00       	call   3d7f <printf>
    exit(0);
    2475:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    247c:	e8 bb 17 00 00       	call   3c3c <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2481:	83 ec 08             	sub    $0x8,%esp
    2484:	68 ee 49 00 00       	push   $0x49ee
    2489:	6a 01                	push   $0x1
    248b:	e8 ef 18 00 00       	call   3d7f <printf>
    exit(0);
    2490:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2497:	e8 a0 17 00 00       	call   3c3c <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    249c:	83 ec 08             	sub    $0x8,%esp
    249f:	68 0a 4a 00 00       	push   $0x4a0a
    24a4:	6a 01                	push   $0x1
    24a6:	e8 d4 18 00 00       	call   3d7f <printf>
    exit(0);
    24ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24b2:	e8 85 17 00 00       	call   3c3c <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    24b7:	83 ec 08             	sub    $0x8,%esp
    24ba:	68 22 4a 00 00       	push   $0x4a22
    24bf:	6a 01                	push   $0x1
    24c1:	e8 b9 18 00 00       	call   3d7f <printf>
    exit(0);
    24c6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24cd:	e8 6a 17 00 00       	call   3c3c <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    24d2:	83 ec 08             	sub    $0x8,%esp
    24d5:	68 39 48 00 00       	push   $0x4839
    24da:	6a 01                	push   $0x1
    24dc:	e8 9e 18 00 00       	call   3d7f <printf>
    exit(0);
    24e1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24e8:	e8 4f 17 00 00       	call   3c3c <exit>
    printf(1, "unlink dd/ff failed\n");
    24ed:	83 ec 08             	sub    $0x8,%esp
    24f0:	68 3a 4a 00 00       	push   $0x4a3a
    24f5:	6a 01                	push   $0x1
    24f7:	e8 83 18 00 00       	call   3d7f <printf>
    exit(0);
    24fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2503:	e8 34 17 00 00       	call   3c3c <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2508:	83 ec 08             	sub    $0x8,%esp
    250b:	68 64 53 00 00       	push   $0x5364
    2510:	6a 01                	push   $0x1
    2512:	e8 68 18 00 00       	call   3d7f <printf>
    exit(0);
    2517:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    251e:	e8 19 17 00 00       	call   3c3c <exit>
    printf(1, "unlink dd/dd failed\n");
    2523:	83 ec 08             	sub    $0x8,%esp
    2526:	68 4f 4a 00 00       	push   $0x4a4f
    252b:	6a 01                	push   $0x1
    252d:	e8 4d 18 00 00       	call   3d7f <printf>
    exit(0);
    2532:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2539:	e8 fe 16 00 00       	call   3c3c <exit>
    printf(1, "unlink dd failed\n");
    253e:	83 ec 08             	sub    $0x8,%esp
    2541:	68 64 4a 00 00       	push   $0x4a64
    2546:	6a 01                	push   $0x1
    2548:	e8 32 18 00 00       	call   3d7f <printf>
    exit(0);
    254d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2554:	e8 e3 16 00 00       	call   3c3c <exit>

00002559 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2559:	55                   	push   %ebp
    255a:	89 e5                	mov    %esp,%ebp
    255c:	57                   	push   %edi
    255d:	56                   	push   %esi
    255e:	53                   	push   %ebx
    255f:	83 ec 14             	sub    $0x14,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    2562:	68 81 4a 00 00       	push   $0x4a81
    2567:	6a 01                	push   $0x1
    2569:	e8 11 18 00 00       	call   3d7f <printf>

  unlink("bigwrite");
    256e:	c7 04 24 90 4a 00 00 	movl   $0x4a90,(%esp)
    2575:	e8 12 17 00 00       	call   3c8c <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    257a:	83 c4 10             	add    $0x10,%esp
    257d:	be f3 01 00 00       	mov    $0x1f3,%esi
    2582:	eb 53                	jmp    25d7 <bigwrite+0x7e>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    2584:	83 ec 08             	sub    $0x8,%esp
    2587:	68 99 4a 00 00       	push   $0x4a99
    258c:	6a 01                	push   $0x1
    258e:	e8 ec 17 00 00       	call   3d7f <printf>
      exit(0);
    2593:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    259a:	e8 9d 16 00 00       	call   3c3c <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    259f:	50                   	push   %eax
    25a0:	56                   	push   %esi
    25a1:	68 b1 4a 00 00       	push   $0x4ab1
    25a6:	6a 01                	push   $0x1
    25a8:	e8 d2 17 00 00       	call   3d7f <printf>
        exit(0);
    25ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25b4:	e8 83 16 00 00       	call   3c3c <exit>
      }
    }
    close(fd);
    25b9:	83 ec 0c             	sub    $0xc,%esp
    25bc:	57                   	push   %edi
    25bd:	e8 a2 16 00 00       	call   3c64 <close>
    unlink("bigwrite");
    25c2:	c7 04 24 90 4a 00 00 	movl   $0x4a90,(%esp)
    25c9:	e8 be 16 00 00       	call   3c8c <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    25ce:	81 c6 d7 01 00 00    	add    $0x1d7,%esi
    25d4:	83 c4 10             	add    $0x10,%esp
    25d7:	81 fe ff 17 00 00    	cmp    $0x17ff,%esi
    25dd:	7f 3e                	jg     261d <bigwrite+0xc4>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    25df:	83 ec 08             	sub    $0x8,%esp
    25e2:	68 02 02 00 00       	push   $0x202
    25e7:	68 90 4a 00 00       	push   $0x4a90
    25ec:	e8 8b 16 00 00       	call   3c7c <open>
    25f1:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    25f3:	83 c4 10             	add    $0x10,%esp
    25f6:	85 c0                	test   %eax,%eax
    25f8:	78 8a                	js     2584 <bigwrite+0x2b>
    for(i = 0; i < 2; i++){
    25fa:	bb 00 00 00 00       	mov    $0x0,%ebx
    25ff:	83 fb 01             	cmp    $0x1,%ebx
    2602:	7f b5                	jg     25b9 <bigwrite+0x60>
      int cc = write(fd, buf, sz);
    2604:	83 ec 04             	sub    $0x4,%esp
    2607:	56                   	push   %esi
    2608:	68 20 88 00 00       	push   $0x8820
    260d:	57                   	push   %edi
    260e:	e8 49 16 00 00       	call   3c5c <write>
      if(cc != sz){
    2613:	83 c4 10             	add    $0x10,%esp
    2616:	39 c6                	cmp    %eax,%esi
    2618:	75 85                	jne    259f <bigwrite+0x46>
    for(i = 0; i < 2; i++){
    261a:	43                   	inc    %ebx
    261b:	eb e2                	jmp    25ff <bigwrite+0xa6>
  }

  printf(1, "bigwrite ok\n");
    261d:	83 ec 08             	sub    $0x8,%esp
    2620:	68 c3 4a 00 00       	push   $0x4ac3
    2625:	6a 01                	push   $0x1
    2627:	e8 53 17 00 00       	call   3d7f <printf>
}
    262c:	83 c4 10             	add    $0x10,%esp
    262f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2632:	5b                   	pop    %ebx
    2633:	5e                   	pop    %esi
    2634:	5f                   	pop    %edi
    2635:	5d                   	pop    %ebp
    2636:	c3                   	ret    

00002637 <bigfile>:

void
bigfile(void)
{
    2637:	55                   	push   %ebp
    2638:	89 e5                	mov    %esp,%ebp
    263a:	57                   	push   %edi
    263b:	56                   	push   %esi
    263c:	53                   	push   %ebx
    263d:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2640:	68 d0 4a 00 00       	push   $0x4ad0
    2645:	6a 01                	push   $0x1
    2647:	e8 33 17 00 00       	call   3d7f <printf>

  unlink("bigfile");
    264c:	c7 04 24 ec 4a 00 00 	movl   $0x4aec,(%esp)
    2653:	e8 34 16 00 00       	call   3c8c <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2658:	83 c4 08             	add    $0x8,%esp
    265b:	68 02 02 00 00       	push   $0x202
    2660:	68 ec 4a 00 00       	push   $0x4aec
    2665:	e8 12 16 00 00       	call   3c7c <open>
  if(fd < 0){
    266a:	83 c4 10             	add    $0x10,%esp
    266d:	85 c0                	test   %eax,%eax
    266f:	78 3f                	js     26b0 <bigfile+0x79>
    2671:	89 c6                	mov    %eax,%esi
    printf(1, "cannot create bigfile");
    exit(0);
  }
  for(i = 0; i < 20; i++){
    2673:	bb 00 00 00 00       	mov    $0x0,%ebx
    2678:	83 fb 13             	cmp    $0x13,%ebx
    267b:	7f 69                	jg     26e6 <bigfile+0xaf>
    memset(buf, i, 600);
    267d:	83 ec 04             	sub    $0x4,%esp
    2680:	68 58 02 00 00       	push   $0x258
    2685:	53                   	push   %ebx
    2686:	68 20 88 00 00       	push   $0x8820
    268b:	e8 81 14 00 00       	call   3b11 <memset>
    if(write(fd, buf, 600) != 600){
    2690:	83 c4 0c             	add    $0xc,%esp
    2693:	68 58 02 00 00       	push   $0x258
    2698:	68 20 88 00 00       	push   $0x8820
    269d:	56                   	push   %esi
    269e:	e8 b9 15 00 00       	call   3c5c <write>
    26a3:	83 c4 10             	add    $0x10,%esp
    26a6:	3d 58 02 00 00       	cmp    $0x258,%eax
    26ab:	75 1e                	jne    26cb <bigfile+0x94>
  for(i = 0; i < 20; i++){
    26ad:	43                   	inc    %ebx
    26ae:	eb c8                	jmp    2678 <bigfile+0x41>
    printf(1, "cannot create bigfile");
    26b0:	83 ec 08             	sub    $0x8,%esp
    26b3:	68 de 4a 00 00       	push   $0x4ade
    26b8:	6a 01                	push   $0x1
    26ba:	e8 c0 16 00 00       	call   3d7f <printf>
    exit(0);
    26bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26c6:	e8 71 15 00 00       	call   3c3c <exit>
      printf(1, "write bigfile failed\n");
    26cb:	83 ec 08             	sub    $0x8,%esp
    26ce:	68 f4 4a 00 00       	push   $0x4af4
    26d3:	6a 01                	push   $0x1
    26d5:	e8 a5 16 00 00       	call   3d7f <printf>
      exit(0);
    26da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26e1:	e8 56 15 00 00       	call   3c3c <exit>
    }
  }
  close(fd);
    26e6:	83 ec 0c             	sub    $0xc,%esp
    26e9:	56                   	push   %esi
    26ea:	e8 75 15 00 00       	call   3c64 <close>

  fd = open("bigfile", 0);
    26ef:	83 c4 08             	add    $0x8,%esp
    26f2:	6a 00                	push   $0x0
    26f4:	68 ec 4a 00 00       	push   $0x4aec
    26f9:	e8 7e 15 00 00       	call   3c7c <open>
    26fe:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2700:	83 c4 10             	add    $0x10,%esp
    2703:	85 c0                	test   %eax,%eax
    2705:	78 55                	js     275c <bigfile+0x125>
    printf(1, "cannot open bigfile\n");
    exit(0);
  }
  total = 0;
    2707:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; ; i++){
    270c:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(fd, buf, 300);
    2711:	83 ec 04             	sub    $0x4,%esp
    2714:	68 2c 01 00 00       	push   $0x12c
    2719:	68 20 88 00 00       	push   $0x8820
    271e:	57                   	push   %edi
    271f:	e8 30 15 00 00       	call   3c54 <read>
    if(cc < 0){
    2724:	83 c4 10             	add    $0x10,%esp
    2727:	85 c0                	test   %eax,%eax
    2729:	78 4c                	js     2777 <bigfile+0x140>
      printf(1, "read bigfile failed\n");
      exit(0);
    }
    if(cc == 0)
    272b:	0f 84 97 00 00 00    	je     27c8 <bigfile+0x191>
      break;
    if(cc != 300){
    2731:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2736:	75 5a                	jne    2792 <bigfile+0x15b>
      printf(1, "short read bigfile\n");
      exit(0);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2738:	0f be 0d 20 88 00 00 	movsbl 0x8820,%ecx
    273f:	89 da                	mov    %ebx,%edx
    2741:	c1 ea 1f             	shr    $0x1f,%edx
    2744:	01 da                	add    %ebx,%edx
    2746:	d1 fa                	sar    %edx
    2748:	39 d1                	cmp    %edx,%ecx
    274a:	75 61                	jne    27ad <bigfile+0x176>
    274c:	0f be 0d 4b 89 00 00 	movsbl 0x894b,%ecx
    2753:	39 ca                	cmp    %ecx,%edx
    2755:	75 56                	jne    27ad <bigfile+0x176>
      printf(1, "read bigfile wrong data\n");
      exit(0);
    }
    total += cc;
    2757:	01 c6                	add    %eax,%esi
  for(i = 0; ; i++){
    2759:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    275a:	eb b5                	jmp    2711 <bigfile+0xda>
    printf(1, "cannot open bigfile\n");
    275c:	83 ec 08             	sub    $0x8,%esp
    275f:	68 0a 4b 00 00       	push   $0x4b0a
    2764:	6a 01                	push   $0x1
    2766:	e8 14 16 00 00       	call   3d7f <printf>
    exit(0);
    276b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2772:	e8 c5 14 00 00       	call   3c3c <exit>
      printf(1, "read bigfile failed\n");
    2777:	83 ec 08             	sub    $0x8,%esp
    277a:	68 1f 4b 00 00       	push   $0x4b1f
    277f:	6a 01                	push   $0x1
    2781:	e8 f9 15 00 00       	call   3d7f <printf>
      exit(0);
    2786:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    278d:	e8 aa 14 00 00       	call   3c3c <exit>
      printf(1, "short read bigfile\n");
    2792:	83 ec 08             	sub    $0x8,%esp
    2795:	68 34 4b 00 00       	push   $0x4b34
    279a:	6a 01                	push   $0x1
    279c:	e8 de 15 00 00       	call   3d7f <printf>
      exit(0);
    27a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27a8:	e8 8f 14 00 00       	call   3c3c <exit>
      printf(1, "read bigfile wrong data\n");
    27ad:	83 ec 08             	sub    $0x8,%esp
    27b0:	68 48 4b 00 00       	push   $0x4b48
    27b5:	6a 01                	push   $0x1
    27b7:	e8 c3 15 00 00       	call   3d7f <printf>
      exit(0);
    27bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27c3:	e8 74 14 00 00       	call   3c3c <exit>
  }
  close(fd);
    27c8:	83 ec 0c             	sub    $0xc,%esp
    27cb:	57                   	push   %edi
    27cc:	e8 93 14 00 00       	call   3c64 <close>
  if(total != 20*600){
    27d1:	83 c4 10             	add    $0x10,%esp
    27d4:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    27da:	75 27                	jne    2803 <bigfile+0x1cc>
    printf(1, "read bigfile wrong total\n");
    exit(0);
  }
  unlink("bigfile");
    27dc:	83 ec 0c             	sub    $0xc,%esp
    27df:	68 ec 4a 00 00       	push   $0x4aec
    27e4:	e8 a3 14 00 00       	call   3c8c <unlink>

  printf(1, "bigfile test ok\n");
    27e9:	83 c4 08             	add    $0x8,%esp
    27ec:	68 7b 4b 00 00       	push   $0x4b7b
    27f1:	6a 01                	push   $0x1
    27f3:	e8 87 15 00 00       	call   3d7f <printf>
}
    27f8:	83 c4 10             	add    $0x10,%esp
    27fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    27fe:	5b                   	pop    %ebx
    27ff:	5e                   	pop    %esi
    2800:	5f                   	pop    %edi
    2801:	5d                   	pop    %ebp
    2802:	c3                   	ret    
    printf(1, "read bigfile wrong total\n");
    2803:	83 ec 08             	sub    $0x8,%esp
    2806:	68 61 4b 00 00       	push   $0x4b61
    280b:	6a 01                	push   $0x1
    280d:	e8 6d 15 00 00       	call   3d7f <printf>
    exit(0);
    2812:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2819:	e8 1e 14 00 00       	call   3c3c <exit>

0000281e <fourteen>:

void
fourteen(void)
{
    281e:	55                   	push   %ebp
    281f:	89 e5                	mov    %esp,%ebp
    2821:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2824:	68 8c 4b 00 00       	push   $0x4b8c
    2829:	6a 01                	push   $0x1
    282b:	e8 4f 15 00 00       	call   3d7f <printf>

  if(mkdir("12345678901234") != 0){
    2830:	c7 04 24 c7 4b 00 00 	movl   $0x4bc7,(%esp)
    2837:	e8 68 14 00 00       	call   3ca4 <mkdir>
    283c:	83 c4 10             	add    $0x10,%esp
    283f:	85 c0                	test   %eax,%eax
    2841:	0f 85 a4 00 00 00    	jne    28eb <fourteen+0xcd>
    printf(1, "mkdir 12345678901234 failed\n");
    exit(0);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2847:	83 ec 0c             	sub    $0xc,%esp
    284a:	68 84 53 00 00       	push   $0x5384
    284f:	e8 50 14 00 00       	call   3ca4 <mkdir>
    2854:	83 c4 10             	add    $0x10,%esp
    2857:	85 c0                	test   %eax,%eax
    2859:	0f 85 a7 00 00 00    	jne    2906 <fourteen+0xe8>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(0);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    285f:	83 ec 08             	sub    $0x8,%esp
    2862:	68 00 02 00 00       	push   $0x200
    2867:	68 d4 53 00 00       	push   $0x53d4
    286c:	e8 0b 14 00 00       	call   3c7c <open>
  if(fd < 0){
    2871:	83 c4 10             	add    $0x10,%esp
    2874:	85 c0                	test   %eax,%eax
    2876:	0f 88 a5 00 00 00    	js     2921 <fourteen+0x103>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit(0);
  }
  close(fd);
    287c:	83 ec 0c             	sub    $0xc,%esp
    287f:	50                   	push   %eax
    2880:	e8 df 13 00 00       	call   3c64 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2885:	83 c4 08             	add    $0x8,%esp
    2888:	6a 00                	push   $0x0
    288a:	68 44 54 00 00       	push   $0x5444
    288f:	e8 e8 13 00 00       	call   3c7c <open>
  if(fd < 0){
    2894:	83 c4 10             	add    $0x10,%esp
    2897:	85 c0                	test   %eax,%eax
    2899:	0f 88 9d 00 00 00    	js     293c <fourteen+0x11e>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit(0);
  }
  close(fd);
    289f:	83 ec 0c             	sub    $0xc,%esp
    28a2:	50                   	push   %eax
    28a3:	e8 bc 13 00 00       	call   3c64 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    28a8:	c7 04 24 b8 4b 00 00 	movl   $0x4bb8,(%esp)
    28af:	e8 f0 13 00 00       	call   3ca4 <mkdir>
    28b4:	83 c4 10             	add    $0x10,%esp
    28b7:	85 c0                	test   %eax,%eax
    28b9:	0f 84 98 00 00 00    	je     2957 <fourteen+0x139>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    28bf:	83 ec 0c             	sub    $0xc,%esp
    28c2:	68 e0 54 00 00       	push   $0x54e0
    28c7:	e8 d8 13 00 00       	call   3ca4 <mkdir>
    28cc:	83 c4 10             	add    $0x10,%esp
    28cf:	85 c0                	test   %eax,%eax
    28d1:	0f 84 9b 00 00 00    	je     2972 <fourteen+0x154>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit(0);
  }

  printf(1, "fourteen ok\n");
    28d7:	83 ec 08             	sub    $0x8,%esp
    28da:	68 d6 4b 00 00       	push   $0x4bd6
    28df:	6a 01                	push   $0x1
    28e1:	e8 99 14 00 00       	call   3d7f <printf>
}
    28e6:	83 c4 10             	add    $0x10,%esp
    28e9:	c9                   	leave  
    28ea:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    28eb:	83 ec 08             	sub    $0x8,%esp
    28ee:	68 9b 4b 00 00       	push   $0x4b9b
    28f3:	6a 01                	push   $0x1
    28f5:	e8 85 14 00 00       	call   3d7f <printf>
    exit(0);
    28fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2901:	e8 36 13 00 00       	call   3c3c <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2906:	83 ec 08             	sub    $0x8,%esp
    2909:	68 a4 53 00 00       	push   $0x53a4
    290e:	6a 01                	push   $0x1
    2910:	e8 6a 14 00 00       	call   3d7f <printf>
    exit(0);
    2915:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    291c:	e8 1b 13 00 00       	call   3c3c <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2921:	83 ec 08             	sub    $0x8,%esp
    2924:	68 04 54 00 00       	push   $0x5404
    2929:	6a 01                	push   $0x1
    292b:	e8 4f 14 00 00       	call   3d7f <printf>
    exit(0);
    2930:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2937:	e8 00 13 00 00       	call   3c3c <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    293c:	83 ec 08             	sub    $0x8,%esp
    293f:	68 74 54 00 00       	push   $0x5474
    2944:	6a 01                	push   $0x1
    2946:	e8 34 14 00 00       	call   3d7f <printf>
    exit(0);
    294b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2952:	e8 e5 12 00 00       	call   3c3c <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2957:	83 ec 08             	sub    $0x8,%esp
    295a:	68 b0 54 00 00       	push   $0x54b0
    295f:	6a 01                	push   $0x1
    2961:	e8 19 14 00 00       	call   3d7f <printf>
    exit(0);
    2966:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    296d:	e8 ca 12 00 00       	call   3c3c <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2972:	83 ec 08             	sub    $0x8,%esp
    2975:	68 00 55 00 00       	push   $0x5500
    297a:	6a 01                	push   $0x1
    297c:	e8 fe 13 00 00       	call   3d7f <printf>
    exit(0);
    2981:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2988:	e8 af 12 00 00       	call   3c3c <exit>

0000298d <rmdot>:

void
rmdot(void)
{
    298d:	55                   	push   %ebp
    298e:	89 e5                	mov    %esp,%ebp
    2990:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    2993:	68 e3 4b 00 00       	push   $0x4be3
    2998:	6a 01                	push   $0x1
    299a:	e8 e0 13 00 00       	call   3d7f <printf>
  if(mkdir("dots") != 0){
    299f:	c7 04 24 ef 4b 00 00 	movl   $0x4bef,(%esp)
    29a6:	e8 f9 12 00 00       	call   3ca4 <mkdir>
    29ab:	83 c4 10             	add    $0x10,%esp
    29ae:	85 c0                	test   %eax,%eax
    29b0:	0f 85 bc 00 00 00    	jne    2a72 <rmdot+0xe5>
    printf(1, "mkdir dots failed\n");
    exit(0);
  }
  if(chdir("dots") != 0){
    29b6:	83 ec 0c             	sub    $0xc,%esp
    29b9:	68 ef 4b 00 00       	push   $0x4bef
    29be:	e8 e9 12 00 00       	call   3cac <chdir>
    29c3:	83 c4 10             	add    $0x10,%esp
    29c6:	85 c0                	test   %eax,%eax
    29c8:	0f 85 bf 00 00 00    	jne    2a8d <rmdot+0x100>
    printf(1, "chdir dots failed\n");
    exit(0);
  }
  if(unlink(".") == 0){
    29ce:	83 ec 0c             	sub    $0xc,%esp
    29d1:	68 9a 48 00 00       	push   $0x489a
    29d6:	e8 b1 12 00 00       	call   3c8c <unlink>
    29db:	83 c4 10             	add    $0x10,%esp
    29de:	85 c0                	test   %eax,%eax
    29e0:	0f 84 c2 00 00 00    	je     2aa8 <rmdot+0x11b>
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    29e6:	83 ec 0c             	sub    $0xc,%esp
    29e9:	68 99 48 00 00       	push   $0x4899
    29ee:	e8 99 12 00 00       	call   3c8c <unlink>
    29f3:	83 c4 10             	add    $0x10,%esp
    29f6:	85 c0                	test   %eax,%eax
    29f8:	0f 84 c5 00 00 00    	je     2ac3 <rmdot+0x136>
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    29fe:	83 ec 0c             	sub    $0xc,%esp
    2a01:	68 6d 40 00 00       	push   $0x406d
    2a06:	e8 a1 12 00 00       	call   3cac <chdir>
    2a0b:	83 c4 10             	add    $0x10,%esp
    2a0e:	85 c0                	test   %eax,%eax
    2a10:	0f 85 c8 00 00 00    	jne    2ade <rmdot+0x151>
    printf(1, "chdir / failed\n");
    exit(0);
  }
  if(unlink("dots/.") == 0){
    2a16:	83 ec 0c             	sub    $0xc,%esp
    2a19:	68 37 4c 00 00       	push   $0x4c37
    2a1e:	e8 69 12 00 00       	call   3c8c <unlink>
    2a23:	83 c4 10             	add    $0x10,%esp
    2a26:	85 c0                	test   %eax,%eax
    2a28:	0f 84 cb 00 00 00    	je     2af9 <rmdot+0x16c>
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    2a2e:	83 ec 0c             	sub    $0xc,%esp
    2a31:	68 55 4c 00 00       	push   $0x4c55
    2a36:	e8 51 12 00 00       	call   3c8c <unlink>
    2a3b:	83 c4 10             	add    $0x10,%esp
    2a3e:	85 c0                	test   %eax,%eax
    2a40:	0f 84 ce 00 00 00    	je     2b14 <rmdot+0x187>
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    2a46:	83 ec 0c             	sub    $0xc,%esp
    2a49:	68 ef 4b 00 00       	push   $0x4bef
    2a4e:	e8 39 12 00 00       	call   3c8c <unlink>
    2a53:	83 c4 10             	add    $0x10,%esp
    2a56:	85 c0                	test   %eax,%eax
    2a58:	0f 85 d1 00 00 00    	jne    2b2f <rmdot+0x1a2>
    printf(1, "unlink dots failed!\n");
    exit(0);
  }
  printf(1, "rmdot ok\n");
    2a5e:	83 ec 08             	sub    $0x8,%esp
    2a61:	68 8a 4c 00 00       	push   $0x4c8a
    2a66:	6a 01                	push   $0x1
    2a68:	e8 12 13 00 00       	call   3d7f <printf>
}
    2a6d:	83 c4 10             	add    $0x10,%esp
    2a70:	c9                   	leave  
    2a71:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    2a72:	83 ec 08             	sub    $0x8,%esp
    2a75:	68 f4 4b 00 00       	push   $0x4bf4
    2a7a:	6a 01                	push   $0x1
    2a7c:	e8 fe 12 00 00       	call   3d7f <printf>
    exit(0);
    2a81:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a88:	e8 af 11 00 00       	call   3c3c <exit>
    printf(1, "chdir dots failed\n");
    2a8d:	83 ec 08             	sub    $0x8,%esp
    2a90:	68 07 4c 00 00       	push   $0x4c07
    2a95:	6a 01                	push   $0x1
    2a97:	e8 e3 12 00 00       	call   3d7f <printf>
    exit(0);
    2a9c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2aa3:	e8 94 11 00 00       	call   3c3c <exit>
    printf(1, "rm . worked!\n");
    2aa8:	83 ec 08             	sub    $0x8,%esp
    2aab:	68 1a 4c 00 00       	push   $0x4c1a
    2ab0:	6a 01                	push   $0x1
    2ab2:	e8 c8 12 00 00       	call   3d7f <printf>
    exit(0);
    2ab7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2abe:	e8 79 11 00 00       	call   3c3c <exit>
    printf(1, "rm .. worked!\n");
    2ac3:	83 ec 08             	sub    $0x8,%esp
    2ac6:	68 28 4c 00 00       	push   $0x4c28
    2acb:	6a 01                	push   $0x1
    2acd:	e8 ad 12 00 00       	call   3d7f <printf>
    exit(0);
    2ad2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ad9:	e8 5e 11 00 00       	call   3c3c <exit>
    printf(1, "chdir / failed\n");
    2ade:	83 ec 08             	sub    $0x8,%esp
    2ae1:	68 6f 40 00 00       	push   $0x406f
    2ae6:	6a 01                	push   $0x1
    2ae8:	e8 92 12 00 00       	call   3d7f <printf>
    exit(0);
    2aed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2af4:	e8 43 11 00 00       	call   3c3c <exit>
    printf(1, "unlink dots/. worked!\n");
    2af9:	83 ec 08             	sub    $0x8,%esp
    2afc:	68 3e 4c 00 00       	push   $0x4c3e
    2b01:	6a 01                	push   $0x1
    2b03:	e8 77 12 00 00       	call   3d7f <printf>
    exit(0);
    2b08:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b0f:	e8 28 11 00 00       	call   3c3c <exit>
    printf(1, "unlink dots/.. worked!\n");
    2b14:	83 ec 08             	sub    $0x8,%esp
    2b17:	68 5d 4c 00 00       	push   $0x4c5d
    2b1c:	6a 01                	push   $0x1
    2b1e:	e8 5c 12 00 00       	call   3d7f <printf>
    exit(0);
    2b23:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b2a:	e8 0d 11 00 00       	call   3c3c <exit>
    printf(1, "unlink dots failed!\n");
    2b2f:	83 ec 08             	sub    $0x8,%esp
    2b32:	68 75 4c 00 00       	push   $0x4c75
    2b37:	6a 01                	push   $0x1
    2b39:	e8 41 12 00 00       	call   3d7f <printf>
    exit(0);
    2b3e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b45:	e8 f2 10 00 00       	call   3c3c <exit>

00002b4a <dirfile>:

void
dirfile(void)
{
    2b4a:	55                   	push   %ebp
    2b4b:	89 e5                	mov    %esp,%ebp
    2b4d:	53                   	push   %ebx
    2b4e:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    2b51:	68 94 4c 00 00       	push   $0x4c94
    2b56:	6a 01                	push   $0x1
    2b58:	e8 22 12 00 00       	call   3d7f <printf>

  fd = open("dirfile", O_CREATE);
    2b5d:	83 c4 08             	add    $0x8,%esp
    2b60:	68 00 02 00 00       	push   $0x200
    2b65:	68 a1 4c 00 00       	push   $0x4ca1
    2b6a:	e8 0d 11 00 00       	call   3c7c <open>
  if(fd < 0){
    2b6f:	83 c4 10             	add    $0x10,%esp
    2b72:	85 c0                	test   %eax,%eax
    2b74:	0f 88 22 01 00 00    	js     2c9c <dirfile+0x152>
    printf(1, "create dirfile failed\n");
    exit(0);
  }
  close(fd);
    2b7a:	83 ec 0c             	sub    $0xc,%esp
    2b7d:	50                   	push   %eax
    2b7e:	e8 e1 10 00 00       	call   3c64 <close>
  if(chdir("dirfile") == 0){
    2b83:	c7 04 24 a1 4c 00 00 	movl   $0x4ca1,(%esp)
    2b8a:	e8 1d 11 00 00       	call   3cac <chdir>
    2b8f:	83 c4 10             	add    $0x10,%esp
    2b92:	85 c0                	test   %eax,%eax
    2b94:	0f 84 1d 01 00 00    	je     2cb7 <dirfile+0x16d>
    printf(1, "chdir dirfile succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", 0);
    2b9a:	83 ec 08             	sub    $0x8,%esp
    2b9d:	6a 00                	push   $0x0
    2b9f:	68 da 4c 00 00       	push   $0x4cda
    2ba4:	e8 d3 10 00 00       	call   3c7c <open>
  if(fd >= 0){
    2ba9:	83 c4 10             	add    $0x10,%esp
    2bac:	85 c0                	test   %eax,%eax
    2bae:	0f 89 1e 01 00 00    	jns    2cd2 <dirfile+0x188>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
    2bb4:	83 ec 08             	sub    $0x8,%esp
    2bb7:	68 00 02 00 00       	push   $0x200
    2bbc:	68 da 4c 00 00       	push   $0x4cda
    2bc1:	e8 b6 10 00 00       	call   3c7c <open>
  if(fd >= 0){
    2bc6:	83 c4 10             	add    $0x10,%esp
    2bc9:	85 c0                	test   %eax,%eax
    2bcb:	0f 89 1c 01 00 00    	jns    2ced <dirfile+0x1a3>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    2bd1:	83 ec 0c             	sub    $0xc,%esp
    2bd4:	68 da 4c 00 00       	push   $0x4cda
    2bd9:	e8 c6 10 00 00       	call   3ca4 <mkdir>
    2bde:	83 c4 10             	add    $0x10,%esp
    2be1:	85 c0                	test   %eax,%eax
    2be3:	0f 84 1f 01 00 00    	je     2d08 <dirfile+0x1be>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    2be9:	83 ec 0c             	sub    $0xc,%esp
    2bec:	68 da 4c 00 00       	push   $0x4cda
    2bf1:	e8 96 10 00 00       	call   3c8c <unlink>
    2bf6:	83 c4 10             	add    $0x10,%esp
    2bf9:	85 c0                	test   %eax,%eax
    2bfb:	0f 84 22 01 00 00    	je     2d23 <dirfile+0x1d9>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    2c01:	83 ec 08             	sub    $0x8,%esp
    2c04:	68 da 4c 00 00       	push   $0x4cda
    2c09:	68 3e 4d 00 00       	push   $0x4d3e
    2c0e:	e8 89 10 00 00       	call   3c9c <link>
    2c13:	83 c4 10             	add    $0x10,%esp
    2c16:	85 c0                	test   %eax,%eax
    2c18:	0f 84 20 01 00 00    	je     2d3e <dirfile+0x1f4>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    2c1e:	83 ec 0c             	sub    $0xc,%esp
    2c21:	68 a1 4c 00 00       	push   $0x4ca1
    2c26:	e8 61 10 00 00       	call   3c8c <unlink>
    2c2b:	83 c4 10             	add    $0x10,%esp
    2c2e:	85 c0                	test   %eax,%eax
    2c30:	0f 85 23 01 00 00    	jne    2d59 <dirfile+0x20f>
    printf(1, "unlink dirfile failed!\n");
    exit(0);
  }

  fd = open(".", O_RDWR);
    2c36:	83 ec 08             	sub    $0x8,%esp
    2c39:	6a 02                	push   $0x2
    2c3b:	68 9a 48 00 00       	push   $0x489a
    2c40:	e8 37 10 00 00       	call   3c7c <open>
  if(fd >= 0){
    2c45:	83 c4 10             	add    $0x10,%esp
    2c48:	85 c0                	test   %eax,%eax
    2c4a:	0f 89 24 01 00 00    	jns    2d74 <dirfile+0x22a>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    2c50:	83 ec 08             	sub    $0x8,%esp
    2c53:	6a 00                	push   $0x0
    2c55:	68 9a 48 00 00       	push   $0x489a
    2c5a:	e8 1d 10 00 00       	call   3c7c <open>
    2c5f:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2c61:	83 c4 0c             	add    $0xc,%esp
    2c64:	6a 01                	push   $0x1
    2c66:	68 7d 49 00 00       	push   $0x497d
    2c6b:	50                   	push   %eax
    2c6c:	e8 eb 0f 00 00       	call   3c5c <write>
    2c71:	83 c4 10             	add    $0x10,%esp
    2c74:	85 c0                	test   %eax,%eax
    2c76:	0f 8f 13 01 00 00    	jg     2d8f <dirfile+0x245>
    printf(1, "write . succeeded!\n");
    exit(0);
  }
  close(fd);
    2c7c:	83 ec 0c             	sub    $0xc,%esp
    2c7f:	53                   	push   %ebx
    2c80:	e8 df 0f 00 00       	call   3c64 <close>

  printf(1, "dir vs file OK\n");
    2c85:	83 c4 08             	add    $0x8,%esp
    2c88:	68 71 4d 00 00       	push   $0x4d71
    2c8d:	6a 01                	push   $0x1
    2c8f:	e8 eb 10 00 00       	call   3d7f <printf>
}
    2c94:	83 c4 10             	add    $0x10,%esp
    2c97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c9a:	c9                   	leave  
    2c9b:	c3                   	ret    
    printf(1, "create dirfile failed\n");
    2c9c:	83 ec 08             	sub    $0x8,%esp
    2c9f:	68 a9 4c 00 00       	push   $0x4ca9
    2ca4:	6a 01                	push   $0x1
    2ca6:	e8 d4 10 00 00       	call   3d7f <printf>
    exit(0);
    2cab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2cb2:	e8 85 0f 00 00       	call   3c3c <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2cb7:	83 ec 08             	sub    $0x8,%esp
    2cba:	68 c0 4c 00 00       	push   $0x4cc0
    2cbf:	6a 01                	push   $0x1
    2cc1:	e8 b9 10 00 00       	call   3d7f <printf>
    exit(0);
    2cc6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ccd:	e8 6a 0f 00 00       	call   3c3c <exit>
    printf(1, "create dirfile/xx succeeded!\n");
    2cd2:	83 ec 08             	sub    $0x8,%esp
    2cd5:	68 e5 4c 00 00       	push   $0x4ce5
    2cda:	6a 01                	push   $0x1
    2cdc:	e8 9e 10 00 00       	call   3d7f <printf>
    exit(0);
    2ce1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ce8:	e8 4f 0f 00 00       	call   3c3c <exit>
    printf(1, "create dirfile/xx succeeded!\n");
    2ced:	83 ec 08             	sub    $0x8,%esp
    2cf0:	68 e5 4c 00 00       	push   $0x4ce5
    2cf5:	6a 01                	push   $0x1
    2cf7:	e8 83 10 00 00       	call   3d7f <printf>
    exit(0);
    2cfc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d03:	e8 34 0f 00 00       	call   3c3c <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2d08:	83 ec 08             	sub    $0x8,%esp
    2d0b:	68 03 4d 00 00       	push   $0x4d03
    2d10:	6a 01                	push   $0x1
    2d12:	e8 68 10 00 00       	call   3d7f <printf>
    exit(0);
    2d17:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d1e:	e8 19 0f 00 00       	call   3c3c <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2d23:	83 ec 08             	sub    $0x8,%esp
    2d26:	68 20 4d 00 00       	push   $0x4d20
    2d2b:	6a 01                	push   $0x1
    2d2d:	e8 4d 10 00 00       	call   3d7f <printf>
    exit(0);
    2d32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d39:	e8 fe 0e 00 00       	call   3c3c <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2d3e:	83 ec 08             	sub    $0x8,%esp
    2d41:	68 34 55 00 00       	push   $0x5534
    2d46:	6a 01                	push   $0x1
    2d48:	e8 32 10 00 00       	call   3d7f <printf>
    exit(0);
    2d4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d54:	e8 e3 0e 00 00       	call   3c3c <exit>
    printf(1, "unlink dirfile failed!\n");
    2d59:	83 ec 08             	sub    $0x8,%esp
    2d5c:	68 45 4d 00 00       	push   $0x4d45
    2d61:	6a 01                	push   $0x1
    2d63:	e8 17 10 00 00       	call   3d7f <printf>
    exit(0);
    2d68:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d6f:	e8 c8 0e 00 00       	call   3c3c <exit>
    printf(1, "open . for writing succeeded!\n");
    2d74:	83 ec 08             	sub    $0x8,%esp
    2d77:	68 54 55 00 00       	push   $0x5554
    2d7c:	6a 01                	push   $0x1
    2d7e:	e8 fc 0f 00 00       	call   3d7f <printf>
    exit(0);
    2d83:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d8a:	e8 ad 0e 00 00       	call   3c3c <exit>
    printf(1, "write . succeeded!\n");
    2d8f:	83 ec 08             	sub    $0x8,%esp
    2d92:	68 5d 4d 00 00       	push   $0x4d5d
    2d97:	6a 01                	push   $0x1
    2d99:	e8 e1 0f 00 00       	call   3d7f <printf>
    exit(0);
    2d9e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2da5:	e8 92 0e 00 00       	call   3c3c <exit>

00002daa <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2daa:	55                   	push   %ebp
    2dab:	89 e5                	mov    %esp,%ebp
    2dad:	53                   	push   %ebx
    2dae:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2db1:	68 81 4d 00 00       	push   $0x4d81
    2db6:	6a 01                	push   $0x1
    2db8:	e8 c2 0f 00 00       	call   3d7f <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2dbd:	83 c4 10             	add    $0x10,%esp
    2dc0:	bb 00 00 00 00       	mov    $0x0,%ebx
    2dc5:	eb 55                	jmp    2e1c <iref+0x72>
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2dc7:	83 ec 08             	sub    $0x8,%esp
    2dca:	68 98 4d 00 00       	push   $0x4d98
    2dcf:	6a 01                	push   $0x1
    2dd1:	e8 a9 0f 00 00       	call   3d7f <printf>
      exit(0);
    2dd6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ddd:	e8 5a 0e 00 00       	call   3c3c <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2de2:	83 ec 08             	sub    $0x8,%esp
    2de5:	68 ac 4d 00 00       	push   $0x4dac
    2dea:	6a 01                	push   $0x1
    2dec:	e8 8e 0f 00 00       	call   3d7f <printf>
      exit(0);
    2df1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2df8:	e8 3f 0e 00 00       	call   3c3c <exit>

    mkdir("");
    link("README", "");
    fd = open("", O_CREATE);
    if(fd >= 0)
      close(fd);
    2dfd:	83 ec 0c             	sub    $0xc,%esp
    2e00:	50                   	push   %eax
    2e01:	e8 5e 0e 00 00       	call   3c64 <close>
    2e06:	83 c4 10             	add    $0x10,%esp
    2e09:	eb 7e                	jmp    2e89 <iref+0xdf>
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
    2e0b:	83 ec 0c             	sub    $0xc,%esp
    2e0e:	68 7c 49 00 00       	push   $0x497c
    2e13:	e8 74 0e 00 00       	call   3c8c <unlink>
  for(i = 0; i < 50 + 1; i++){
    2e18:	43                   	inc    %ebx
    2e19:	83 c4 10             	add    $0x10,%esp
    2e1c:	83 fb 32             	cmp    $0x32,%ebx
    2e1f:	0f 8f 92 00 00 00    	jg     2eb7 <iref+0x10d>
    if(mkdir("irefd") != 0){
    2e25:	83 ec 0c             	sub    $0xc,%esp
    2e28:	68 92 4d 00 00       	push   $0x4d92
    2e2d:	e8 72 0e 00 00       	call   3ca4 <mkdir>
    2e32:	83 c4 10             	add    $0x10,%esp
    2e35:	85 c0                	test   %eax,%eax
    2e37:	75 8e                	jne    2dc7 <iref+0x1d>
    if(chdir("irefd") != 0){
    2e39:	83 ec 0c             	sub    $0xc,%esp
    2e3c:	68 92 4d 00 00       	push   $0x4d92
    2e41:	e8 66 0e 00 00       	call   3cac <chdir>
    2e46:	83 c4 10             	add    $0x10,%esp
    2e49:	85 c0                	test   %eax,%eax
    2e4b:	75 95                	jne    2de2 <iref+0x38>
    mkdir("");
    2e4d:	83 ec 0c             	sub    $0xc,%esp
    2e50:	68 47 44 00 00       	push   $0x4447
    2e55:	e8 4a 0e 00 00       	call   3ca4 <mkdir>
    link("README", "");
    2e5a:	83 c4 08             	add    $0x8,%esp
    2e5d:	68 47 44 00 00       	push   $0x4447
    2e62:	68 3e 4d 00 00       	push   $0x4d3e
    2e67:	e8 30 0e 00 00       	call   3c9c <link>
    fd = open("", O_CREATE);
    2e6c:	83 c4 08             	add    $0x8,%esp
    2e6f:	68 00 02 00 00       	push   $0x200
    2e74:	68 47 44 00 00       	push   $0x4447
    2e79:	e8 fe 0d 00 00       	call   3c7c <open>
    if(fd >= 0)
    2e7e:	83 c4 10             	add    $0x10,%esp
    2e81:	85 c0                	test   %eax,%eax
    2e83:	0f 89 74 ff ff ff    	jns    2dfd <iref+0x53>
    fd = open("xx", O_CREATE);
    2e89:	83 ec 08             	sub    $0x8,%esp
    2e8c:	68 00 02 00 00       	push   $0x200
    2e91:	68 7c 49 00 00       	push   $0x497c
    2e96:	e8 e1 0d 00 00       	call   3c7c <open>
    if(fd >= 0)
    2e9b:	83 c4 10             	add    $0x10,%esp
    2e9e:	85 c0                	test   %eax,%eax
    2ea0:	0f 88 65 ff ff ff    	js     2e0b <iref+0x61>
      close(fd);
    2ea6:	83 ec 0c             	sub    $0xc,%esp
    2ea9:	50                   	push   %eax
    2eaa:	e8 b5 0d 00 00       	call   3c64 <close>
    2eaf:	83 c4 10             	add    $0x10,%esp
    2eb2:	e9 54 ff ff ff       	jmp    2e0b <iref+0x61>
  }

  chdir("/");
    2eb7:	83 ec 0c             	sub    $0xc,%esp
    2eba:	68 6d 40 00 00       	push   $0x406d
    2ebf:	e8 e8 0d 00 00       	call   3cac <chdir>
  printf(1, "empty file name OK\n");
    2ec4:	83 c4 08             	add    $0x8,%esp
    2ec7:	68 c0 4d 00 00       	push   $0x4dc0
    2ecc:	6a 01                	push   $0x1
    2ece:	e8 ac 0e 00 00       	call   3d7f <printf>
}
    2ed3:	83 c4 10             	add    $0x10,%esp
    2ed6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ed9:	c9                   	leave  
    2eda:	c3                   	ret    

00002edb <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2edb:	55                   	push   %ebp
    2edc:	89 e5                	mov    %esp,%ebp
    2ede:	53                   	push   %ebx
    2edf:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    2ee2:	68 d4 4d 00 00       	push   $0x4dd4
    2ee7:	6a 01                	push   $0x1
    2ee9:	e8 91 0e 00 00       	call   3d7f <printf>

  for(n=0; n<1000; n++){
    2eee:	83 c4 10             	add    $0x10,%esp
    2ef1:	bb 00 00 00 00       	mov    $0x0,%ebx
    2ef6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
    2efc:	7f 18                	jg     2f16 <forktest+0x3b>
    pid = fork();
    2efe:	e8 31 0d 00 00       	call   3c34 <fork>
    if(pid < 0)
    2f03:	85 c0                	test   %eax,%eax
    2f05:	78 0f                	js     2f16 <forktest+0x3b>
      break;
    if(pid == 0)
    2f07:	74 03                	je     2f0c <forktest+0x31>
  for(n=0; n<1000; n++){
    2f09:	43                   	inc    %ebx
    2f0a:	eb ea                	jmp    2ef6 <forktest+0x1b>
      exit(0);
    2f0c:	83 ec 0c             	sub    $0xc,%esp
    2f0f:	6a 00                	push   $0x0
    2f11:	e8 26 0d 00 00       	call   3c3c <exit>
  }

  if(n == 1000){
    2f16:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2f1c:	74 18                	je     2f36 <forktest+0x5b>
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
    2f1e:	85 db                	test   %ebx,%ebx
    2f20:	7e 4a                	jle    2f6c <forktest+0x91>
    if(wait(NULL) < 0){
    2f22:	83 ec 0c             	sub    $0xc,%esp
    2f25:	6a 00                	push   $0x0
    2f27:	e8 18 0d 00 00       	call   3c44 <wait>
    2f2c:	83 c4 10             	add    $0x10,%esp
    2f2f:	85 c0                	test   %eax,%eax
    2f31:	78 1e                	js     2f51 <forktest+0x76>
  for(; n > 0; n--){
    2f33:	4b                   	dec    %ebx
    2f34:	eb e8                	jmp    2f1e <forktest+0x43>
    printf(1, "fork claimed to work 1000 times!\n");
    2f36:	83 ec 08             	sub    $0x8,%esp
    2f39:	68 74 55 00 00       	push   $0x5574
    2f3e:	6a 01                	push   $0x1
    2f40:	e8 3a 0e 00 00       	call   3d7f <printf>
    exit(0);
    2f45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f4c:	e8 eb 0c 00 00       	call   3c3c <exit>
      printf(1, "wait stopped early\n");
    2f51:	83 ec 08             	sub    $0x8,%esp
    2f54:	68 df 4d 00 00       	push   $0x4ddf
    2f59:	6a 01                	push   $0x1
    2f5b:	e8 1f 0e 00 00       	call   3d7f <printf>
      exit(0);
    2f60:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f67:	e8 d0 0c 00 00       	call   3c3c <exit>
    }
  }

  if(wait(NULL) != -1){
    2f6c:	83 ec 0c             	sub    $0xc,%esp
    2f6f:	6a 00                	push   $0x0
    2f71:	e8 ce 0c 00 00       	call   3c44 <wait>
    2f76:	83 c4 10             	add    $0x10,%esp
    2f79:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f7c:	75 17                	jne    2f95 <forktest+0xba>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
    2f7e:	83 ec 08             	sub    $0x8,%esp
    2f81:	68 06 4e 00 00       	push   $0x4e06
    2f86:	6a 01                	push   $0x1
    2f88:	e8 f2 0d 00 00       	call   3d7f <printf>
}
    2f8d:	83 c4 10             	add    $0x10,%esp
    2f90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2f93:	c9                   	leave  
    2f94:	c3                   	ret    
    printf(1, "wait got too many\n");
    2f95:	83 ec 08             	sub    $0x8,%esp
    2f98:	68 f3 4d 00 00       	push   $0x4df3
    2f9d:	6a 01                	push   $0x1
    2f9f:	e8 db 0d 00 00       	call   3d7f <printf>
    exit(0);
    2fa4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fab:	e8 8c 0c 00 00       	call   3c3c <exit>

00002fb0 <sbrktest>:

void
sbrktest(void)
{
    2fb0:	55                   	push   %ebp
    2fb1:	89 e5                	mov    %esp,%ebp
    2fb3:	57                   	push   %edi
    2fb4:	56                   	push   %esi
    2fb5:	53                   	push   %ebx
    2fb6:	83 ec 54             	sub    $0x54,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2fb9:	68 14 4e 00 00       	push   $0x4e14
    2fbe:	ff 35 cc 60 00 00    	push   0x60cc
    2fc4:	e8 b6 0d 00 00       	call   3d7f <printf>
  oldbrk = sbrk(0);
    2fc9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fd0:	e8 ef 0c 00 00       	call   3cc4 <sbrk>
    2fd5:	89 c7                	mov    %eax,%edi

  // can one sbrk() less than a page?
  a = sbrk(0);
    2fd7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fde:	e8 e1 0c 00 00       	call   3cc4 <sbrk>
    2fe3:	89 c6                	mov    %eax,%esi
  int i;
  for(i = 0; i < 5000; i++){
    2fe5:	83 c4 10             	add    $0x10,%esp
    2fe8:	bb 00 00 00 00       	mov    $0x0,%ebx
    2fed:	81 fb 87 13 00 00    	cmp    $0x1387,%ebx
    2ff3:	7f 3a                	jg     302f <sbrktest+0x7f>
    b = sbrk(1);
    2ff5:	83 ec 0c             	sub    $0xc,%esp
    2ff8:	6a 01                	push   $0x1
    2ffa:	e8 c5 0c 00 00       	call   3cc4 <sbrk>
    if(b != a){
    2fff:	83 c4 10             	add    $0x10,%esp
    3002:	39 c6                	cmp    %eax,%esi
    3004:	75 09                	jne    300f <sbrktest+0x5f>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit(0);
    }
    *b = 1;
    3006:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    3009:	8d 70 01             	lea    0x1(%eax),%esi
  for(i = 0; i < 5000; i++){
    300c:	43                   	inc    %ebx
    300d:	eb de                	jmp    2fed <sbrktest+0x3d>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    300f:	83 ec 0c             	sub    $0xc,%esp
    3012:	50                   	push   %eax
    3013:	56                   	push   %esi
    3014:	53                   	push   %ebx
    3015:	68 1f 4e 00 00       	push   $0x4e1f
    301a:	ff 35 cc 60 00 00    	push   0x60cc
    3020:	e8 5a 0d 00 00       	call   3d7f <printf>
      exit(0);
    3025:	83 c4 14             	add    $0x14,%esp
    3028:	6a 00                	push   $0x0
    302a:	e8 0d 0c 00 00       	call   3c3c <exit>
  }
  pid = fork();
    302f:	e8 00 0c 00 00       	call   3c34 <fork>
    3034:	89 c3                	mov    %eax,%ebx
  if(pid < 0){
    3036:	85 c0                	test   %eax,%eax
    3038:	0f 88 60 01 00 00    	js     319e <sbrktest+0x1ee>
    printf(stdout, "sbrk test fork failed\n");
    exit(0);
  }
  c = sbrk(1);
    303e:	83 ec 0c             	sub    $0xc,%esp
    3041:	6a 01                	push   $0x1
    3043:	e8 7c 0c 00 00       	call   3cc4 <sbrk>
  c = sbrk(1);
    3048:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    304f:	e8 70 0c 00 00       	call   3cc4 <sbrk>
  if(c != a + 1){
    3054:	46                   	inc    %esi
    3055:	83 c4 10             	add    $0x10,%esp
    3058:	39 c6                	cmp    %eax,%esi
    305a:	0f 85 5d 01 00 00    	jne    31bd <sbrktest+0x20d>
    printf(stdout, "sbrk test failed post-fork\n");
    exit(0);
  }
  if(pid == 0)
    3060:	85 db                	test   %ebx,%ebx
    3062:	0f 84 74 01 00 00    	je     31dc <sbrktest+0x22c>
    exit(0);
  wait(NULL);
    3068:	83 ec 0c             	sub    $0xc,%esp
    306b:	6a 00                	push   $0x0
    306d:	e8 d2 0b 00 00       	call   3c44 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3072:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3079:	e8 46 0c 00 00       	call   3cc4 <sbrk>
    307e:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    3080:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3085:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    3087:	89 04 24             	mov    %eax,(%esp)
    308a:	e8 35 0c 00 00       	call   3cc4 <sbrk>
  if (p != a) {
    308f:	83 c4 10             	add    $0x10,%esp
    3092:	39 c3                	cmp    %eax,%ebx
    3094:	0f 85 4c 01 00 00    	jne    31e6 <sbrktest+0x236>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit(0);
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    309a:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    30a1:	83 ec 0c             	sub    $0xc,%esp
    30a4:	6a 00                	push   $0x0
    30a6:	e8 19 0c 00 00       	call   3cc4 <sbrk>
    30ab:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    30ad:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    30b4:	e8 0b 0c 00 00       	call   3cc4 <sbrk>
  if(c == (char*)0xffffffff){
    30b9:	83 c4 10             	add    $0x10,%esp
    30bc:	83 f8 ff             	cmp    $0xffffffff,%eax
    30bf:	0f 84 40 01 00 00    	je     3205 <sbrktest+0x255>
    printf(stdout, "sbrk could not deallocate\n");
    exit(0);
  }
  c = sbrk(0);
    30c5:	83 ec 0c             	sub    $0xc,%esp
    30c8:	6a 00                	push   $0x0
    30ca:	e8 f5 0b 00 00       	call   3cc4 <sbrk>
  if(c != a - 4096){
    30cf:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    30d5:	83 c4 10             	add    $0x10,%esp
    30d8:	39 c2                	cmp    %eax,%edx
    30da:	0f 85 44 01 00 00    	jne    3224 <sbrktest+0x274>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
    30e0:	83 ec 0c             	sub    $0xc,%esp
    30e3:	6a 00                	push   $0x0
    30e5:	e8 da 0b 00 00       	call   3cc4 <sbrk>
    30ea:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    30ec:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    30f3:	e8 cc 0b 00 00       	call   3cc4 <sbrk>
    30f8:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    30fa:	83 c4 10             	add    $0x10,%esp
    30fd:	39 c3                	cmp    %eax,%ebx
    30ff:	0f 85 3d 01 00 00    	jne    3242 <sbrktest+0x292>
    3105:	83 ec 0c             	sub    $0xc,%esp
    3108:	6a 00                	push   $0x0
    310a:	e8 b5 0b 00 00       	call   3cc4 <sbrk>
    310f:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    3115:	83 c4 10             	add    $0x10,%esp
    3118:	39 c2                	cmp    %eax,%edx
    311a:	0f 85 22 01 00 00    	jne    3242 <sbrktest+0x292>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(0);
  }
  if(*lastaddr == 99){
    3120:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    3127:	0f 84 33 01 00 00    	je     3260 <sbrktest+0x2b0>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    312d:	83 ec 0c             	sub    $0xc,%esp
    3130:	6a 00                	push   $0x0
    3132:	e8 8d 0b 00 00       	call   3cc4 <sbrk>
    3137:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    3139:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3140:	e8 7f 0b 00 00       	call   3cc4 <sbrk>
    3145:	89 c2                	mov    %eax,%edx
    3147:	89 f8                	mov    %edi,%eax
    3149:	29 d0                	sub    %edx,%eax
    314b:	89 04 24             	mov    %eax,(%esp)
    314e:	e8 71 0b 00 00       	call   3cc4 <sbrk>
  if(c != a){
    3153:	83 c4 10             	add    $0x10,%esp
    3156:	39 c3                	cmp    %eax,%ebx
    3158:	0f 85 21 01 00 00    	jne    327f <sbrktest+0x2cf>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    315e:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    3163:	81 fb 7f 84 1e 80    	cmp    $0x801e847f,%ebx
    3169:	0f 87 76 01 00 00    	ja     32e5 <sbrktest+0x335>
    ppid = getpid();
    316f:	e8 48 0b 00 00       	call   3cbc <getpid>
    3174:	89 c6                	mov    %eax,%esi
    pid = fork();
    3176:	e8 b9 0a 00 00       	call   3c34 <fork>
    if(pid < 0){
    317b:	85 c0                	test   %eax,%eax
    317d:	0f 88 1a 01 00 00    	js     329d <sbrktest+0x2ed>
      printf(stdout, "fork failed\n");
      exit(0);
    }
    if(pid == 0){
    3183:	0f 84 33 01 00 00    	je     32bc <sbrktest+0x30c>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit(0);
    }
    wait(NULL);
    3189:	83 ec 0c             	sub    $0xc,%esp
    318c:	6a 00                	push   $0x0
    318e:	e8 b1 0a 00 00       	call   3c44 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3193:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    3199:	83 c4 10             	add    $0x10,%esp
    319c:	eb c5                	jmp    3163 <sbrktest+0x1b3>
    printf(stdout, "sbrk test fork failed\n");
    319e:	83 ec 08             	sub    $0x8,%esp
    31a1:	68 3a 4e 00 00       	push   $0x4e3a
    31a6:	ff 35 cc 60 00 00    	push   0x60cc
    31ac:	e8 ce 0b 00 00       	call   3d7f <printf>
    exit(0);
    31b1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31b8:	e8 7f 0a 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    31bd:	83 ec 08             	sub    $0x8,%esp
    31c0:	68 51 4e 00 00       	push   $0x4e51
    31c5:	ff 35 cc 60 00 00    	push   0x60cc
    31cb:	e8 af 0b 00 00       	call   3d7f <printf>
    exit(0);
    31d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31d7:	e8 60 0a 00 00       	call   3c3c <exit>
    exit(0);
    31dc:	83 ec 0c             	sub    $0xc,%esp
    31df:	6a 00                	push   $0x0
    31e1:	e8 56 0a 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    31e6:	83 ec 08             	sub    $0x8,%esp
    31e9:	68 98 55 00 00       	push   $0x5598
    31ee:	ff 35 cc 60 00 00    	push   0x60cc
    31f4:	e8 86 0b 00 00       	call   3d7f <printf>
    exit(0);
    31f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3200:	e8 37 0a 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk could not deallocate\n");
    3205:	83 ec 08             	sub    $0x8,%esp
    3208:	68 6d 4e 00 00       	push   $0x4e6d
    320d:	ff 35 cc 60 00 00    	push   0x60cc
    3213:	e8 67 0b 00 00       	call   3d7f <printf>
    exit(0);
    3218:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    321f:	e8 18 0a 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3224:	50                   	push   %eax
    3225:	53                   	push   %ebx
    3226:	68 d8 55 00 00       	push   $0x55d8
    322b:	ff 35 cc 60 00 00    	push   0x60cc
    3231:	e8 49 0b 00 00       	call   3d7f <printf>
    exit(0);
    3236:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    323d:	e8 fa 09 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3242:	56                   	push   %esi
    3243:	53                   	push   %ebx
    3244:	68 10 56 00 00       	push   $0x5610
    3249:	ff 35 cc 60 00 00    	push   0x60cc
    324f:	e8 2b 0b 00 00       	call   3d7f <printf>
    exit(0);
    3254:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    325b:	e8 dc 09 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3260:	83 ec 08             	sub    $0x8,%esp
    3263:	68 38 56 00 00       	push   $0x5638
    3268:	ff 35 cc 60 00 00    	push   0x60cc
    326e:	e8 0c 0b 00 00       	call   3d7f <printf>
    exit(0);
    3273:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    327a:	e8 bd 09 00 00       	call   3c3c <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    327f:	50                   	push   %eax
    3280:	53                   	push   %ebx
    3281:	68 68 56 00 00       	push   $0x5668
    3286:	ff 35 cc 60 00 00    	push   0x60cc
    328c:	e8 ee 0a 00 00       	call   3d7f <printf>
    exit(0);
    3291:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3298:	e8 9f 09 00 00       	call   3c3c <exit>
      printf(stdout, "fork failed\n");
    329d:	83 ec 08             	sub    $0x8,%esp
    32a0:	68 65 4f 00 00       	push   $0x4f65
    32a5:	ff 35 cc 60 00 00    	push   0x60cc
    32ab:	e8 cf 0a 00 00       	call   3d7f <printf>
      exit(0);
    32b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32b7:	e8 80 09 00 00       	call   3c3c <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    32bc:	0f be 03             	movsbl (%ebx),%eax
    32bf:	50                   	push   %eax
    32c0:	53                   	push   %ebx
    32c1:	68 88 4e 00 00       	push   $0x4e88
    32c6:	ff 35 cc 60 00 00    	push   0x60cc
    32cc:	e8 ae 0a 00 00       	call   3d7f <printf>
      kill(ppid);
    32d1:	89 34 24             	mov    %esi,(%esp)
    32d4:	e8 93 09 00 00       	call   3c6c <kill>
      exit(0);
    32d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32e0:	e8 57 09 00 00       	call   3c3c <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    32e5:	83 ec 0c             	sub    $0xc,%esp
    32e8:	8d 45 e0             	lea    -0x20(%ebp),%eax
    32eb:	50                   	push   %eax
    32ec:	e8 5b 09 00 00       	call   3c4c <pipe>
    32f1:	89 c3                	mov    %eax,%ebx
    32f3:	83 c4 10             	add    $0x10,%esp
    32f6:	85 c0                	test   %eax,%eax
    32f8:	75 04                	jne    32fe <sbrktest+0x34e>
    printf(1, "pipe() failed\n");
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32fa:	89 c6                	mov    %eax,%esi
    32fc:	eb 5e                	jmp    335c <sbrktest+0x3ac>
    printf(1, "pipe() failed\n");
    32fe:	83 ec 08             	sub    $0x8,%esp
    3301:	68 5d 43 00 00       	push   $0x435d
    3306:	6a 01                	push   $0x1
    3308:	e8 72 0a 00 00       	call   3d7f <printf>
    exit(0);
    330d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3314:	e8 23 09 00 00       	call   3c3c <exit>
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3319:	83 ec 0c             	sub    $0xc,%esp
    331c:	6a 00                	push   $0x0
    331e:	e8 a1 09 00 00       	call   3cc4 <sbrk>
    3323:	89 c2                	mov    %eax,%edx
    3325:	b8 00 00 40 06       	mov    $0x6400000,%eax
    332a:	29 d0                	sub    %edx,%eax
    332c:	89 04 24             	mov    %eax,(%esp)
    332f:	e8 90 09 00 00       	call   3cc4 <sbrk>
      write(fds[1], "x", 1);
    3334:	83 c4 0c             	add    $0xc,%esp
    3337:	6a 01                	push   $0x1
    3339:	68 7d 49 00 00       	push   $0x497d
    333e:	ff 75 e4             	push   -0x1c(%ebp)
    3341:	e8 16 09 00 00       	call   3c5c <write>
    3346:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3349:	83 ec 0c             	sub    $0xc,%esp
    334c:	68 e8 03 00 00       	push   $0x3e8
    3351:	e8 76 09 00 00       	call   3ccc <sleep>
    3356:	83 c4 10             	add    $0x10,%esp
    3359:	eb ee                	jmp    3349 <sbrktest+0x399>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    335b:	46                   	inc    %esi
    335c:	83 fe 09             	cmp    $0x9,%esi
    335f:	77 28                	ja     3389 <sbrktest+0x3d9>
    if((pids[i] = fork()) == 0){
    3361:	e8 ce 08 00 00       	call   3c34 <fork>
    3366:	89 44 b5 b8          	mov    %eax,-0x48(%ebp,%esi,4)
    336a:	85 c0                	test   %eax,%eax
    336c:	74 ab                	je     3319 <sbrktest+0x369>
    }
    if(pids[i] != -1)
    336e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3371:	74 e8                	je     335b <sbrktest+0x3ab>
      read(fds[0], &scratch, 1);
    3373:	83 ec 04             	sub    $0x4,%esp
    3376:	6a 01                	push   $0x1
    3378:	8d 45 b7             	lea    -0x49(%ebp),%eax
    337b:	50                   	push   %eax
    337c:	ff 75 e0             	push   -0x20(%ebp)
    337f:	e8 d0 08 00 00       	call   3c54 <read>
    3384:	83 c4 10             	add    $0x10,%esp
    3387:	eb d2                	jmp    335b <sbrktest+0x3ab>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3389:	83 ec 0c             	sub    $0xc,%esp
    338c:	68 00 10 00 00       	push   $0x1000
    3391:	e8 2e 09 00 00       	call   3cc4 <sbrk>
    3396:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3398:	83 c4 10             	add    $0x10,%esp
    339b:	eb 01                	jmp    339e <sbrktest+0x3ee>
    339d:	43                   	inc    %ebx
    339e:	83 fb 09             	cmp    $0x9,%ebx
    33a1:	77 23                	ja     33c6 <sbrktest+0x416>
    if(pids[i] == -1)
    33a3:	8b 44 9d b8          	mov    -0x48(%ebp,%ebx,4),%eax
    33a7:	83 f8 ff             	cmp    $0xffffffff,%eax
    33aa:	74 f1                	je     339d <sbrktest+0x3ed>
      continue;
    kill(pids[i]);
    33ac:	83 ec 0c             	sub    $0xc,%esp
    33af:	50                   	push   %eax
    33b0:	e8 b7 08 00 00       	call   3c6c <kill>
    wait(NULL);
    33b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33bc:	e8 83 08 00 00       	call   3c44 <wait>
    33c1:	83 c4 10             	add    $0x10,%esp
    33c4:	eb d7                	jmp    339d <sbrktest+0x3ed>
  }
  if(c == (char*)0xffffffff){
    33c6:	83 fe ff             	cmp    $0xffffffff,%esi
    33c9:	74 2f                	je     33fa <sbrktest+0x44a>
    printf(stdout, "failed sbrk leaked memory\n");
    exit(0);
  }

  if(sbrk(0) > oldbrk)
    33cb:	83 ec 0c             	sub    $0xc,%esp
    33ce:	6a 00                	push   $0x0
    33d0:	e8 ef 08 00 00       	call   3cc4 <sbrk>
    33d5:	83 c4 10             	add    $0x10,%esp
    33d8:	39 c7                	cmp    %eax,%edi
    33da:	72 3d                	jb     3419 <sbrktest+0x469>
    sbrk(-(sbrk(0) - oldbrk));

  printf(stdout, "sbrk test OK\n");
    33dc:	83 ec 08             	sub    $0x8,%esp
    33df:	68 bc 4e 00 00       	push   $0x4ebc
    33e4:	ff 35 cc 60 00 00    	push   0x60cc
    33ea:	e8 90 09 00 00       	call   3d7f <printf>
}
    33ef:	83 c4 10             	add    $0x10,%esp
    33f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    33f5:	5b                   	pop    %ebx
    33f6:	5e                   	pop    %esi
    33f7:	5f                   	pop    %edi
    33f8:	5d                   	pop    %ebp
    33f9:	c3                   	ret    
    printf(stdout, "failed sbrk leaked memory\n");
    33fa:	83 ec 08             	sub    $0x8,%esp
    33fd:	68 a1 4e 00 00       	push   $0x4ea1
    3402:	ff 35 cc 60 00 00    	push   0x60cc
    3408:	e8 72 09 00 00       	call   3d7f <printf>
    exit(0);
    340d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3414:	e8 23 08 00 00       	call   3c3c <exit>
    sbrk(-(sbrk(0) - oldbrk));
    3419:	83 ec 0c             	sub    $0xc,%esp
    341c:	6a 00                	push   $0x0
    341e:	e8 a1 08 00 00       	call   3cc4 <sbrk>
    3423:	29 c7                	sub    %eax,%edi
    3425:	89 3c 24             	mov    %edi,(%esp)
    3428:	e8 97 08 00 00       	call   3cc4 <sbrk>
    342d:	83 c4 10             	add    $0x10,%esp
    3430:	eb aa                	jmp    33dc <sbrktest+0x42c>

00003432 <validateint>:
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3432:	c3                   	ret    

00003433 <validatetest>:

void
validatetest(void)
{
    3433:	55                   	push   %ebp
    3434:	89 e5                	mov    %esp,%ebp
    3436:	56                   	push   %esi
    3437:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3438:	83 ec 08             	sub    $0x8,%esp
    343b:	68 ca 4e 00 00       	push   $0x4eca
    3440:	ff 35 cc 60 00 00    	push   0x60cc
    3446:	e8 34 09 00 00       	call   3d7f <printf>
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    344b:	83 c4 10             	add    $0x10,%esp
    344e:	be 00 00 00 00       	mov    $0x0,%esi
    3453:	81 fe 00 30 11 00    	cmp    $0x113000,%esi
    3459:	77 7c                	ja     34d7 <validatetest+0xa4>
    if((pid = fork()) == 0){
    345b:	e8 d4 07 00 00       	call   3c34 <fork>
    3460:	89 c3                	mov    %eax,%ebx
    3462:	85 c0                	test   %eax,%eax
    3464:	74 48                	je     34ae <validatetest+0x7b>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit(0);
    }
    sleep(0);
    3466:	83 ec 0c             	sub    $0xc,%esp
    3469:	6a 00                	push   $0x0
    346b:	e8 5c 08 00 00       	call   3ccc <sleep>
    sleep(0);
    3470:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3477:	e8 50 08 00 00       	call   3ccc <sleep>
    kill(pid);
    347c:	89 1c 24             	mov    %ebx,(%esp)
    347f:	e8 e8 07 00 00       	call   3c6c <kill>
    wait(NULL);
    3484:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    348b:	e8 b4 07 00 00       	call   3c44 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3490:	83 c4 08             	add    $0x8,%esp
    3493:	56                   	push   %esi
    3494:	68 d9 4e 00 00       	push   $0x4ed9
    3499:	e8 fe 07 00 00       	call   3c9c <link>
    349e:	83 c4 10             	add    $0x10,%esp
    34a1:	83 f8 ff             	cmp    $0xffffffff,%eax
    34a4:	75 12                	jne    34b8 <validatetest+0x85>
  for(p = 0; p <= (uint)hi; p += 4096){
    34a6:	81 c6 00 10 00 00    	add    $0x1000,%esi
    34ac:	eb a5                	jmp    3453 <validatetest+0x20>
      exit(0);
    34ae:	83 ec 0c             	sub    $0xc,%esp
    34b1:	6a 00                	push   $0x0
    34b3:	e8 84 07 00 00       	call   3c3c <exit>
      printf(stdout, "link should not succeed\n");
    34b8:	83 ec 08             	sub    $0x8,%esp
    34bb:	68 e4 4e 00 00       	push   $0x4ee4
    34c0:	ff 35 cc 60 00 00    	push   0x60cc
    34c6:	e8 b4 08 00 00       	call   3d7f <printf>
      exit(0);
    34cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34d2:	e8 65 07 00 00       	call   3c3c <exit>
    }
  }

  printf(stdout, "validate ok\n");
    34d7:	83 ec 08             	sub    $0x8,%esp
    34da:	68 fd 4e 00 00       	push   $0x4efd
    34df:	ff 35 cc 60 00 00    	push   0x60cc
    34e5:	e8 95 08 00 00       	call   3d7f <printf>
}
    34ea:	83 c4 10             	add    $0x10,%esp
    34ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
    34f0:	5b                   	pop    %ebx
    34f1:	5e                   	pop    %esi
    34f2:	5d                   	pop    %ebp
    34f3:	c3                   	ret    

000034f4 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    34f4:	55                   	push   %ebp
    34f5:	89 e5                	mov    %esp,%ebp
    34f7:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    34fa:	68 0a 4f 00 00       	push   $0x4f0a
    34ff:	ff 35 cc 60 00 00    	push   0x60cc
    3505:	e8 75 08 00 00       	call   3d7f <printf>
  for(i = 0; i < sizeof(uninit); i++){
    350a:	83 c4 10             	add    $0x10,%esp
    350d:	b8 00 00 00 00       	mov    $0x0,%eax
    3512:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3517:	77 2b                	ja     3544 <bsstest+0x50>
    if(uninit[i] != '\0'){
    3519:	80 b8 00 61 00 00 00 	cmpb   $0x0,0x6100(%eax)
    3520:	75 03                	jne    3525 <bsstest+0x31>
  for(i = 0; i < sizeof(uninit); i++){
    3522:	40                   	inc    %eax
    3523:	eb ed                	jmp    3512 <bsstest+0x1e>
      printf(stdout, "bss test failed\n");
    3525:	83 ec 08             	sub    $0x8,%esp
    3528:	68 14 4f 00 00       	push   $0x4f14
    352d:	ff 35 cc 60 00 00    	push   0x60cc
    3533:	e8 47 08 00 00       	call   3d7f <printf>
      exit(0);
    3538:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    353f:	e8 f8 06 00 00       	call   3c3c <exit>
    }
  }
  printf(stdout, "bss test ok\n");
    3544:	83 ec 08             	sub    $0x8,%esp
    3547:	68 25 4f 00 00       	push   $0x4f25
    354c:	ff 35 cc 60 00 00    	push   0x60cc
    3552:	e8 28 08 00 00       	call   3d7f <printf>
}
    3557:	83 c4 10             	add    $0x10,%esp
    355a:	c9                   	leave  
    355b:	c3                   	ret    

0000355c <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    355c:	55                   	push   %ebp
    355d:	89 e5                	mov    %esp,%ebp
    355f:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3562:	68 32 4f 00 00       	push   $0x4f32
    3567:	e8 20 07 00 00       	call   3c8c <unlink>
  pid = fork();
    356c:	e8 c3 06 00 00       	call   3c34 <fork>
  if(pid == 0){
    3571:	83 c4 10             	add    $0x10,%esp
    3574:	85 c0                	test   %eax,%eax
    3576:	74 50                	je     35c8 <bigargtest+0x6c>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
    3578:	0f 88 b7 00 00 00    	js     3635 <bigargtest+0xd9>
    printf(stdout, "bigargtest: fork failed\n");
    exit(0);
  }
  wait(NULL);
    357e:	83 ec 0c             	sub    $0xc,%esp
    3581:	6a 00                	push   $0x0
    3583:	e8 bc 06 00 00       	call   3c44 <wait>
  fd = open("bigarg-ok", 0);
    3588:	83 c4 08             	add    $0x8,%esp
    358b:	6a 00                	push   $0x0
    358d:	68 32 4f 00 00       	push   $0x4f32
    3592:	e8 e5 06 00 00       	call   3c7c <open>
  if(fd < 0){
    3597:	83 c4 10             	add    $0x10,%esp
    359a:	85 c0                	test   %eax,%eax
    359c:	0f 88 b2 00 00 00    	js     3654 <bigargtest+0xf8>
    printf(stdout, "bigarg test failed!\n");
    exit(0);
  }
  close(fd);
    35a2:	83 ec 0c             	sub    $0xc,%esp
    35a5:	50                   	push   %eax
    35a6:	e8 b9 06 00 00       	call   3c64 <close>
  unlink("bigarg-ok");
    35ab:	c7 04 24 32 4f 00 00 	movl   $0x4f32,(%esp)
    35b2:	e8 d5 06 00 00       	call   3c8c <unlink>
}
    35b7:	83 c4 10             	add    $0x10,%esp
    35ba:	c9                   	leave  
    35bb:	c3                   	ret    
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    35bc:	c7 04 85 20 a8 00 00 	movl   $0x568c,0xa820(,%eax,4)
    35c3:	8c 56 00 00 
    for(i = 0; i < MAXARG-1; i++)
    35c7:	40                   	inc    %eax
    35c8:	83 f8 1e             	cmp    $0x1e,%eax
    35cb:	7e ef                	jle    35bc <bigargtest+0x60>
    args[MAXARG-1] = 0;
    35cd:	c7 05 9c a8 00 00 00 	movl   $0x0,0xa89c
    35d4:	00 00 00 
    printf(stdout, "bigarg test\n");
    35d7:	83 ec 08             	sub    $0x8,%esp
    35da:	68 3c 4f 00 00       	push   $0x4f3c
    35df:	ff 35 cc 60 00 00    	push   0x60cc
    35e5:	e8 95 07 00 00       	call   3d7f <printf>
    exec("echo", args);
    35ea:	83 c4 08             	add    $0x8,%esp
    35ed:	68 20 a8 00 00       	push   $0xa820
    35f2:	68 09 41 00 00       	push   $0x4109
    35f7:	e8 78 06 00 00       	call   3c74 <exec>
    printf(stdout, "bigarg test ok\n");
    35fc:	83 c4 08             	add    $0x8,%esp
    35ff:	68 49 4f 00 00       	push   $0x4f49
    3604:	ff 35 cc 60 00 00    	push   0x60cc
    360a:	e8 70 07 00 00       	call   3d7f <printf>
    fd = open("bigarg-ok", O_CREATE);
    360f:	83 c4 08             	add    $0x8,%esp
    3612:	68 00 02 00 00       	push   $0x200
    3617:	68 32 4f 00 00       	push   $0x4f32
    361c:	e8 5b 06 00 00       	call   3c7c <open>
    close(fd);
    3621:	89 04 24             	mov    %eax,(%esp)
    3624:	e8 3b 06 00 00       	call   3c64 <close>
    exit(0);
    3629:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3630:	e8 07 06 00 00       	call   3c3c <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3635:	83 ec 08             	sub    $0x8,%esp
    3638:	68 59 4f 00 00       	push   $0x4f59
    363d:	ff 35 cc 60 00 00    	push   0x60cc
    3643:	e8 37 07 00 00       	call   3d7f <printf>
    exit(0);
    3648:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    364f:	e8 e8 05 00 00       	call   3c3c <exit>
    printf(stdout, "bigarg test failed!\n");
    3654:	83 ec 08             	sub    $0x8,%esp
    3657:	68 72 4f 00 00       	push   $0x4f72
    365c:	ff 35 cc 60 00 00    	push   0x60cc
    3662:	e8 18 07 00 00       	call   3d7f <printf>
    exit(0);
    3667:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    366e:	e8 c9 05 00 00       	call   3c3c <exit>

00003673 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3673:	55                   	push   %ebp
    3674:	89 e5                	mov    %esp,%ebp
    3676:	57                   	push   %edi
    3677:	56                   	push   %esi
    3678:	53                   	push   %ebx
    3679:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    367c:	68 87 4f 00 00       	push   $0x4f87
    3681:	6a 01                	push   $0x1
    3683:	e8 f7 06 00 00       	call   3d7f <printf>
    3688:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    368b:	bb 00 00 00 00       	mov    $0x0,%ebx
    char name[64];
    name[0] = 'f';
    3690:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3694:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3699:	f7 eb                	imul   %ebx
    369b:	89 d0                	mov    %edx,%eax
    369d:	c1 f8 06             	sar    $0x6,%eax
    36a0:	89 de                	mov    %ebx,%esi
    36a2:	c1 fe 1f             	sar    $0x1f,%esi
    36a5:	29 f0                	sub    %esi,%eax
    36a7:	8d 50 30             	lea    0x30(%eax),%edx
    36aa:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    36ad:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36b3:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36b6:	c1 e0 03             	shl    $0x3,%eax
    36b9:	89 df                	mov    %ebx,%edi
    36bb:	29 c7                	sub    %eax,%edi
    36bd:	b9 1f 85 eb 51       	mov    $0x51eb851f,%ecx
    36c2:	89 f8                	mov    %edi,%eax
    36c4:	f7 e9                	imul   %ecx
    36c6:	c1 fa 05             	sar    $0x5,%edx
    36c9:	c1 ff 1f             	sar    $0x1f,%edi
    36cc:	29 fa                	sub    %edi,%edx
    36ce:	83 c2 30             	add    $0x30,%edx
    36d1:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    36d4:	89 c8                	mov    %ecx,%eax
    36d6:	f7 eb                	imul   %ebx
    36d8:	89 d1                	mov    %edx,%ecx
    36da:	c1 f9 05             	sar    $0x5,%ecx
    36dd:	29 f1                	sub    %esi,%ecx
    36df:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
    36e2:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36e5:	c1 e0 02             	shl    $0x2,%eax
    36e8:	89 d9                	mov    %ebx,%ecx
    36ea:	29 c1                	sub    %eax,%ecx
    36ec:	bf 67 66 66 66       	mov    $0x66666667,%edi
    36f1:	89 c8                	mov    %ecx,%eax
    36f3:	f7 ef                	imul   %edi
    36f5:	89 d0                	mov    %edx,%eax
    36f7:	c1 f8 02             	sar    $0x2,%eax
    36fa:	c1 f9 1f             	sar    $0x1f,%ecx
    36fd:	29 c8                	sub    %ecx,%eax
    36ff:	83 c0 30             	add    $0x30,%eax
    3702:	88 45 ab             	mov    %al,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3705:	89 f8                	mov    %edi,%eax
    3707:	f7 eb                	imul   %ebx
    3709:	89 d0                	mov    %edx,%eax
    370b:	c1 f8 02             	sar    $0x2,%eax
    370e:	29 f0                	sub    %esi,%eax
    3710:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3713:	8d 14 00             	lea    (%eax,%eax,1),%edx
    3716:	89 d8                	mov    %ebx,%eax
    3718:	29 d0                	sub    %edx,%eax
    371a:	83 c0 30             	add    $0x30,%eax
    371d:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    3720:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    3724:	83 ec 04             	sub    $0x4,%esp
    3727:	8d 75 a8             	lea    -0x58(%ebp),%esi
    372a:	56                   	push   %esi
    372b:	68 94 4f 00 00       	push   $0x4f94
    3730:	6a 01                	push   $0x1
    3732:	e8 48 06 00 00       	call   3d7f <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3737:	83 c4 08             	add    $0x8,%esp
    373a:	68 02 02 00 00       	push   $0x202
    373f:	56                   	push   %esi
    3740:	e8 37 05 00 00       	call   3c7c <open>
    3745:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    3747:	83 c4 10             	add    $0x10,%esp
    374a:	85 c0                	test   %eax,%eax
    374c:	79 1b                	jns    3769 <fsfull+0xf6>
      printf(1, "open %s failed\n", name);
    374e:	83 ec 04             	sub    $0x4,%esp
    3751:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3754:	50                   	push   %eax
    3755:	68 a0 4f 00 00       	push   $0x4fa0
    375a:	6a 01                	push   $0x1
    375c:	e8 1e 06 00 00       	call   3d7f <printf>
      break;
    3761:	83 c4 10             	add    $0x10,%esp
    3764:	e9 f3 00 00 00       	jmp    385c <fsfull+0x1e9>
    }
    int total = 0;
    3769:	bf 00 00 00 00       	mov    $0x0,%edi
    while(1){
      int cc = write(fd, buf, 512);
    376e:	83 ec 04             	sub    $0x4,%esp
    3771:	68 00 02 00 00       	push   $0x200
    3776:	68 20 88 00 00       	push   $0x8820
    377b:	56                   	push   %esi
    377c:	e8 db 04 00 00       	call   3c5c <write>
      if(cc < 512)
    3781:	83 c4 10             	add    $0x10,%esp
    3784:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3789:	7e 04                	jle    378f <fsfull+0x11c>
        break;
      total += cc;
    378b:	01 c7                	add    %eax,%edi
    while(1){
    378d:	eb df                	jmp    376e <fsfull+0xfb>
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    378f:	83 ec 04             	sub    $0x4,%esp
    3792:	57                   	push   %edi
    3793:	68 b0 4f 00 00       	push   $0x4fb0
    3798:	6a 01                	push   $0x1
    379a:	e8 e0 05 00 00       	call   3d7f <printf>
    close(fd);
    379f:	89 34 24             	mov    %esi,(%esp)
    37a2:	e8 bd 04 00 00       	call   3c64 <close>
    if(total == 0)
    37a7:	83 c4 10             	add    $0x10,%esp
    37aa:	85 ff                	test   %edi,%edi
    37ac:	0f 84 aa 00 00 00    	je     385c <fsfull+0x1e9>
  for(nfiles = 0; ; nfiles++){
    37b2:	43                   	inc    %ebx
    37b3:	e9 d8 fe ff ff       	jmp    3690 <fsfull+0x1d>
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    37b8:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    37bc:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    37c1:	f7 eb                	imul   %ebx
    37c3:	89 d0                	mov    %edx,%eax
    37c5:	c1 f8 06             	sar    $0x6,%eax
    37c8:	89 de                	mov    %ebx,%esi
    37ca:	c1 fe 1f             	sar    $0x1f,%esi
    37cd:	29 f0                	sub    %esi,%eax
    37cf:	8d 50 30             	lea    0x30(%eax),%edx
    37d2:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    37d5:	8d 04 80             	lea    (%eax,%eax,4),%eax
    37d8:	8d 04 80             	lea    (%eax,%eax,4),%eax
    37db:	8d 04 80             	lea    (%eax,%eax,4),%eax
    37de:	c1 e0 03             	shl    $0x3,%eax
    37e1:	89 df                	mov    %ebx,%edi
    37e3:	29 c7                	sub    %eax,%edi
    37e5:	b9 1f 85 eb 51       	mov    $0x51eb851f,%ecx
    37ea:	89 f8                	mov    %edi,%eax
    37ec:	f7 e9                	imul   %ecx
    37ee:	c1 fa 05             	sar    $0x5,%edx
    37f1:	c1 ff 1f             	sar    $0x1f,%edi
    37f4:	29 fa                	sub    %edi,%edx
    37f6:	83 c2 30             	add    $0x30,%edx
    37f9:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    37fc:	89 c8                	mov    %ecx,%eax
    37fe:	f7 eb                	imul   %ebx
    3800:	89 d1                	mov    %edx,%ecx
    3802:	c1 f9 05             	sar    $0x5,%ecx
    3805:	29 f1                	sub    %esi,%ecx
    3807:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
    380a:	8d 04 80             	lea    (%eax,%eax,4),%eax
    380d:	c1 e0 02             	shl    $0x2,%eax
    3810:	89 d9                	mov    %ebx,%ecx
    3812:	29 c1                	sub    %eax,%ecx
    3814:	bf 67 66 66 66       	mov    $0x66666667,%edi
    3819:	89 c8                	mov    %ecx,%eax
    381b:	f7 ef                	imul   %edi
    381d:	89 d0                	mov    %edx,%eax
    381f:	c1 f8 02             	sar    $0x2,%eax
    3822:	c1 f9 1f             	sar    $0x1f,%ecx
    3825:	29 c8                	sub    %ecx,%eax
    3827:	83 c0 30             	add    $0x30,%eax
    382a:	88 45 ab             	mov    %al,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    382d:	89 f8                	mov    %edi,%eax
    382f:	f7 eb                	imul   %ebx
    3831:	89 d0                	mov    %edx,%eax
    3833:	c1 f8 02             	sar    $0x2,%eax
    3836:	29 f0                	sub    %esi,%eax
    3838:	8d 04 80             	lea    (%eax,%eax,4),%eax
    383b:	8d 14 00             	lea    (%eax,%eax,1),%edx
    383e:	89 d8                	mov    %ebx,%eax
    3840:	29 d0                	sub    %edx,%eax
    3842:	83 c0 30             	add    $0x30,%eax
    3845:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    3848:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    384c:	83 ec 0c             	sub    $0xc,%esp
    384f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3852:	50                   	push   %eax
    3853:	e8 34 04 00 00       	call   3c8c <unlink>
    nfiles--;
    3858:	4b                   	dec    %ebx
    3859:	83 c4 10             	add    $0x10,%esp
  while(nfiles >= 0){
    385c:	85 db                	test   %ebx,%ebx
    385e:	0f 89 54 ff ff ff    	jns    37b8 <fsfull+0x145>
  }

  printf(1, "fsfull test finished\n");
    3864:	83 ec 08             	sub    $0x8,%esp
    3867:	68 c0 4f 00 00       	push   $0x4fc0
    386c:	6a 01                	push   $0x1
    386e:	e8 0c 05 00 00       	call   3d7f <printf>
}
    3873:	83 c4 10             	add    $0x10,%esp
    3876:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3879:	5b                   	pop    %ebx
    387a:	5e                   	pop    %esi
    387b:	5f                   	pop    %edi
    387c:	5d                   	pop    %ebp
    387d:	c3                   	ret    

0000387e <uio>:

void
uio()
{
    387e:	55                   	push   %ebp
    387f:	89 e5                	mov    %esp,%ebp
    3881:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3884:	68 d6 4f 00 00       	push   $0x4fd6
    3889:	6a 01                	push   $0x1
    388b:	e8 ef 04 00 00       	call   3d7f <printf>
  pid = fork();
    3890:	e8 9f 03 00 00       	call   3c34 <fork>
  if(pid == 0){
    3895:	83 c4 10             	add    $0x10,%esp
    3898:	85 c0                	test   %eax,%eax
    389a:	74 20                	je     38bc <uio+0x3e>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit(0);
  } else if(pid < 0){
    389c:	78 47                	js     38e5 <uio+0x67>
    printf (1, "fork failed\n");
    exit(0);
  }
  wait(NULL);
    389e:	83 ec 0c             	sub    $0xc,%esp
    38a1:	6a 00                	push   $0x0
    38a3:	e8 9c 03 00 00       	call   3c44 <wait>
  printf(1, "uio test done\n");
    38a8:	83 c4 08             	add    $0x8,%esp
    38ab:	68 e0 4f 00 00       	push   $0x4fe0
    38b0:	6a 01                	push   $0x1
    38b2:	e8 c8 04 00 00       	call   3d7f <printf>
}
    38b7:	83 c4 10             	add    $0x10,%esp
    38ba:	c9                   	leave  
    38bb:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    38bc:	b0 09                	mov    $0x9,%al
    38be:	ba 70 00 00 00       	mov    $0x70,%edx
    38c3:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    38c4:	ba 71 00 00 00       	mov    $0x71,%edx
    38c9:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    38ca:	83 ec 08             	sub    $0x8,%esp
    38cd:	68 6c 57 00 00       	push   $0x576c
    38d2:	6a 01                	push   $0x1
    38d4:	e8 a6 04 00 00       	call   3d7f <printf>
    exit(0);
    38d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38e0:	e8 57 03 00 00       	call   3c3c <exit>
    printf (1, "fork failed\n");
    38e5:	83 ec 08             	sub    $0x8,%esp
    38e8:	68 65 4f 00 00       	push   $0x4f65
    38ed:	6a 01                	push   $0x1
    38ef:	e8 8b 04 00 00       	call   3d7f <printf>
    exit(0);
    38f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38fb:	e8 3c 03 00 00       	call   3c3c <exit>

00003900 <argptest>:

void argptest()
{
    3900:	55                   	push   %ebp
    3901:	89 e5                	mov    %esp,%ebp
    3903:	53                   	push   %ebx
    3904:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    3907:	6a 00                	push   $0x0
    3909:	68 ef 4f 00 00       	push   $0x4fef
    390e:	e8 69 03 00 00       	call   3c7c <open>
  if (fd < 0) {
    3913:	83 c4 10             	add    $0x10,%esp
    3916:	85 c0                	test   %eax,%eax
    3918:	78 38                	js     3952 <argptest+0x52>
    391a:	89 c3                	mov    %eax,%ebx
    printf(2, "open failed\n");
    exit(0);
  }
  read(fd, sbrk(0) - 1, -1);
    391c:	83 ec 0c             	sub    $0xc,%esp
    391f:	6a 00                	push   $0x0
    3921:	e8 9e 03 00 00       	call   3cc4 <sbrk>
    3926:	48                   	dec    %eax
    3927:	83 c4 0c             	add    $0xc,%esp
    392a:	6a ff                	push   $0xffffffff
    392c:	50                   	push   %eax
    392d:	53                   	push   %ebx
    392e:	e8 21 03 00 00       	call   3c54 <read>
  close(fd);
    3933:	89 1c 24             	mov    %ebx,(%esp)
    3936:	e8 29 03 00 00       	call   3c64 <close>
  printf(1, "arg test passed\n");
    393b:	83 c4 08             	add    $0x8,%esp
    393e:	68 01 50 00 00       	push   $0x5001
    3943:	6a 01                	push   $0x1
    3945:	e8 35 04 00 00       	call   3d7f <printf>
}
    394a:	83 c4 10             	add    $0x10,%esp
    394d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3950:	c9                   	leave  
    3951:	c3                   	ret    
    printf(2, "open failed\n");
    3952:	83 ec 08             	sub    $0x8,%esp
    3955:	68 f4 4f 00 00       	push   $0x4ff4
    395a:	6a 02                	push   $0x2
    395c:	e8 1e 04 00 00       	call   3d7f <printf>
    exit(0);
    3961:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3968:	e8 cf 02 00 00       	call   3c3c <exit>

0000396d <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    396d:	a1 c8 60 00 00       	mov    0x60c8,%eax
    3972:	8d 14 00             	lea    (%eax,%eax,1),%edx
    3975:	01 c2                	add    %eax,%edx
    3977:	8d 0c 90             	lea    (%eax,%edx,4),%ecx
    397a:	c1 e1 08             	shl    $0x8,%ecx
    397d:	89 ca                	mov    %ecx,%edx
    397f:	01 c2                	add    %eax,%edx
    3981:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3984:	8d 04 90             	lea    (%eax,%edx,4),%eax
    3987:	8d 04 80             	lea    (%eax,%eax,4),%eax
    398a:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    3991:	a3 c8 60 00 00       	mov    %eax,0x60c8
  return randstate;
}
    3996:	c3                   	ret    

00003997 <main>:

int
main(int argc, char *argv[])
{
    3997:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    399b:	83 e4 f0             	and    $0xfffffff0,%esp
    399e:	ff 71 fc             	push   -0x4(%ecx)
    39a1:	55                   	push   %ebp
    39a2:	89 e5                	mov    %esp,%ebp
    39a4:	51                   	push   %ecx
    39a5:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
    39a8:	68 12 50 00 00       	push   $0x5012
    39ad:	6a 01                	push   $0x1
    39af:	e8 cb 03 00 00       	call   3d7f <printf>

  if(open("usertests.ran", 0) >= 0){
    39b4:	83 c4 08             	add    $0x8,%esp
    39b7:	6a 00                	push   $0x0
    39b9:	68 26 50 00 00       	push   $0x5026
    39be:	e8 b9 02 00 00       	call   3c7c <open>
    39c3:	83 c4 10             	add    $0x10,%esp
    39c6:	85 c0                	test   %eax,%eax
    39c8:	78 1b                	js     39e5 <main+0x4e>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    39ca:	83 ec 08             	sub    $0x8,%esp
    39cd:	68 90 57 00 00       	push   $0x5790
    39d2:	6a 01                	push   $0x1
    39d4:	e8 a6 03 00 00       	call   3d7f <printf>
    exit(0);
    39d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    39e0:	e8 57 02 00 00       	call   3c3c <exit>
  }
  close(open("usertests.ran", O_CREATE));
    39e5:	83 ec 08             	sub    $0x8,%esp
    39e8:	68 00 02 00 00       	push   $0x200
    39ed:	68 26 50 00 00       	push   $0x5026
    39f2:	e8 85 02 00 00       	call   3c7c <open>
    39f7:	89 04 24             	mov    %eax,(%esp)
    39fa:	e8 65 02 00 00       	call   3c64 <close>

  argptest();
    39ff:	e8 fc fe ff ff       	call   3900 <argptest>
  createdelete();
    3a04:	e8 6d d7 ff ff       	call   1176 <createdelete>
  linkunlink();
    3a09:	e8 96 e0 ff ff       	call   1aa4 <linkunlink>
  concreate();
    3a0e:	e8 9e dd ff ff       	call   17b1 <concreate>
  fourfiles();
    3a13:	e8 62 d5 ff ff       	call   f7a <fourfiles>
  sharedfd();
    3a18:	e8 c1 d3 ff ff       	call   dde <sharedfd>

  bigargtest();
    3a1d:	e8 3a fb ff ff       	call   355c <bigargtest>
  bigwrite();
    3a22:	e8 32 eb ff ff       	call   2559 <bigwrite>
  bigargtest();
    3a27:	e8 30 fb ff ff       	call   355c <bigargtest>
  bsstest();
    3a2c:	e8 c3 fa ff ff       	call   34f4 <bsstest>
  sbrktest();
    3a31:	e8 7a f5 ff ff       	call   2fb0 <sbrktest>
  validatetest();
    3a36:	e8 f8 f9 ff ff       	call   3433 <validatetest>

  opentest();
    3a3b:	e8 d4 c8 ff ff       	call   314 <opentest>
  writetest();
    3a40:	e8 70 c9 ff ff       	call   3b5 <writetest>
  writetest1();
    3a45:	e8 5f cb ff ff       	call   5a9 <writetest1>
  createtest();
    3a4a:	e8 37 cd ff ff       	call   786 <createtest>

  openiputtest();
    3a4f:	e8 b1 c7 ff ff       	call   205 <openiputtest>
  exitiputtest();
    3a54:	e8 a0 c6 ff ff       	call   f9 <exitiputtest>
  iputtest();
    3a59:	e8 a2 c5 ff ff       	call   0 <iputtest>

  mem();
    3a5e:	e8 aa d2 ff ff       	call   d0d <mem>
  pipe1();
    3a63:	e8 0f cf ff ff       	call   977 <pipe1>
  preempt();
    3a68:	e8 d2 d0 ff ff       	call   b3f <preempt>
  exitwait();
    3a6d:	e8 20 d2 ff ff       	call   c92 <exitwait>

  rmdot();
    3a72:	e8 16 ef ff ff       	call   298d <rmdot>
  fourteen();
    3a77:	e8 a2 ed ff ff       	call   281e <fourteen>
  bigfile();
    3a7c:	e8 b6 eb ff ff       	call   2637 <bigfile>
  subdir();
    3a81:	e8 a2 e2 ff ff       	call   1d28 <subdir>
  linktest();
    3a86:	e8 c1 da ff ff       	call   154c <linktest>
  unlinkread();
    3a8b:	e8 f9 d8 ff ff       	call   1389 <unlinkread>
  dirfile();
    3a90:	e8 b5 f0 ff ff       	call   2b4a <dirfile>
  iref();
    3a95:	e8 10 f3 ff ff       	call   2daa <iref>
  forktest();
    3a9a:	e8 3c f4 ff ff       	call   2edb <forktest>
  bigdir(); // slow
    3a9f:	e8 19 e1 ff ff       	call   1bbd <bigdir>

  uio();
    3aa4:	e8 d5 fd ff ff       	call   387e <uio>

  exectest();
    3aa9:	e8 79 ce ff ff       	call   927 <exectest>

  exit(0);
    3aae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3ab5:	e8 82 01 00 00       	call   3c3c <exit>

00003aba <start>:

// Entry point of the library	
void
start()
{
}
    3aba:	c3                   	ret    

00003abb <strcpy>:

char*
strcpy(char *s, const char *t)
{
    3abb:	55                   	push   %ebp
    3abc:	89 e5                	mov    %esp,%ebp
    3abe:	56                   	push   %esi
    3abf:	53                   	push   %ebx
    3ac0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ac3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3ac6:	89 c2                	mov    %eax,%edx
    3ac8:	89 cb                	mov    %ecx,%ebx
    3aca:	41                   	inc    %ecx
    3acb:	89 d6                	mov    %edx,%esi
    3acd:	42                   	inc    %edx
    3ace:	8a 1b                	mov    (%ebx),%bl
    3ad0:	88 1e                	mov    %bl,(%esi)
    3ad2:	84 db                	test   %bl,%bl
    3ad4:	75 f2                	jne    3ac8 <strcpy+0xd>
    ;
  return os;
}
    3ad6:	5b                   	pop    %ebx
    3ad7:	5e                   	pop    %esi
    3ad8:	5d                   	pop    %ebp
    3ad9:	c3                   	ret    

00003ada <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3ada:	55                   	push   %ebp
    3adb:	89 e5                	mov    %esp,%ebp
    3add:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3ae0:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    3ae3:	eb 02                	jmp    3ae7 <strcmp+0xd>
    p++, q++;
    3ae5:	41                   	inc    %ecx
    3ae6:	42                   	inc    %edx
  while(*p && *p == *q)
    3ae7:	8a 01                	mov    (%ecx),%al
    3ae9:	84 c0                	test   %al,%al
    3aeb:	74 04                	je     3af1 <strcmp+0x17>
    3aed:	3a 02                	cmp    (%edx),%al
    3aef:	74 f4                	je     3ae5 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
    3af1:	0f b6 c0             	movzbl %al,%eax
    3af4:	0f b6 12             	movzbl (%edx),%edx
    3af7:	29 d0                	sub    %edx,%eax
}
    3af9:	5d                   	pop    %ebp
    3afa:	c3                   	ret    

00003afb <strlen>:

uint
strlen(const char *s)
{
    3afb:	55                   	push   %ebp
    3afc:	89 e5                	mov    %esp,%ebp
    3afe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3b01:	b8 00 00 00 00       	mov    $0x0,%eax
    3b06:	eb 01                	jmp    3b09 <strlen+0xe>
    3b08:	40                   	inc    %eax
    3b09:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
    3b0d:	75 f9                	jne    3b08 <strlen+0xd>
    ;
  return n;
}
    3b0f:	5d                   	pop    %ebp
    3b10:	c3                   	ret    

00003b11 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3b11:	55                   	push   %ebp
    3b12:	89 e5                	mov    %esp,%ebp
    3b14:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3b15:	8b 7d 08             	mov    0x8(%ebp),%edi
    3b18:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
    3b1e:	fc                   	cld    
    3b1f:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3b21:	8b 45 08             	mov    0x8(%ebp),%eax
    3b24:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3b27:	c9                   	leave  
    3b28:	c3                   	ret    

00003b29 <strchr>:

char*
strchr(const char *s, char c)
{
    3b29:	55                   	push   %ebp
    3b2a:	89 e5                	mov    %esp,%ebp
    3b2c:	8b 45 08             	mov    0x8(%ebp),%eax
    3b2f:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
    3b32:	eb 01                	jmp    3b35 <strchr+0xc>
    3b34:	40                   	inc    %eax
    3b35:	8a 10                	mov    (%eax),%dl
    3b37:	84 d2                	test   %dl,%dl
    3b39:	74 06                	je     3b41 <strchr+0x18>
    if(*s == c)
    3b3b:	38 ca                	cmp    %cl,%dl
    3b3d:	75 f5                	jne    3b34 <strchr+0xb>
    3b3f:	eb 05                	jmp    3b46 <strchr+0x1d>
      return (char*)s;
  return 0;
    3b41:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3b46:	5d                   	pop    %ebp
    3b47:	c3                   	ret    

00003b48 <gets>:

char*
gets(char *buf, int max)
{
    3b48:	55                   	push   %ebp
    3b49:	89 e5                	mov    %esp,%ebp
    3b4b:	57                   	push   %edi
    3b4c:	56                   	push   %esi
    3b4d:	53                   	push   %ebx
    3b4e:	83 ec 1c             	sub    $0x1c,%esp
    3b51:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3b54:	bb 00 00 00 00       	mov    $0x0,%ebx
    3b59:	89 de                	mov    %ebx,%esi
    3b5b:	43                   	inc    %ebx
    3b5c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3b5f:	7d 2b                	jge    3b8c <gets+0x44>
    cc = read(0, &c, 1);
    3b61:	83 ec 04             	sub    $0x4,%esp
    3b64:	6a 01                	push   $0x1
    3b66:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3b69:	50                   	push   %eax
    3b6a:	6a 00                	push   $0x0
    3b6c:	e8 e3 00 00 00       	call   3c54 <read>
    if(cc < 1)
    3b71:	83 c4 10             	add    $0x10,%esp
    3b74:	85 c0                	test   %eax,%eax
    3b76:	7e 14                	jle    3b8c <gets+0x44>
      break;
    buf[i++] = c;
    3b78:	8a 45 e7             	mov    -0x19(%ebp),%al
    3b7b:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
    3b7e:	3c 0a                	cmp    $0xa,%al
    3b80:	74 08                	je     3b8a <gets+0x42>
    3b82:	3c 0d                	cmp    $0xd,%al
    3b84:	75 d3                	jne    3b59 <gets+0x11>
    buf[i++] = c;
    3b86:	89 de                	mov    %ebx,%esi
    3b88:	eb 02                	jmp    3b8c <gets+0x44>
    3b8a:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    3b8c:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    3b90:	89 f8                	mov    %edi,%eax
    3b92:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b95:	5b                   	pop    %ebx
    3b96:	5e                   	pop    %esi
    3b97:	5f                   	pop    %edi
    3b98:	5d                   	pop    %ebp
    3b99:	c3                   	ret    

00003b9a <stat>:

int
stat(const char *n, struct stat *st)
{
    3b9a:	55                   	push   %ebp
    3b9b:	89 e5                	mov    %esp,%ebp
    3b9d:	56                   	push   %esi
    3b9e:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b9f:	83 ec 08             	sub    $0x8,%esp
    3ba2:	6a 00                	push   $0x0
    3ba4:	ff 75 08             	push   0x8(%ebp)
    3ba7:	e8 d0 00 00 00       	call   3c7c <open>
  if(fd < 0)
    3bac:	83 c4 10             	add    $0x10,%esp
    3baf:	85 c0                	test   %eax,%eax
    3bb1:	78 24                	js     3bd7 <stat+0x3d>
    3bb3:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    3bb5:	83 ec 08             	sub    $0x8,%esp
    3bb8:	ff 75 0c             	push   0xc(%ebp)
    3bbb:	50                   	push   %eax
    3bbc:	e8 d3 00 00 00       	call   3c94 <fstat>
    3bc1:	89 c6                	mov    %eax,%esi
  close(fd);
    3bc3:	89 1c 24             	mov    %ebx,(%esp)
    3bc6:	e8 99 00 00 00       	call   3c64 <close>
  return r;
    3bcb:	83 c4 10             	add    $0x10,%esp
}
    3bce:	89 f0                	mov    %esi,%eax
    3bd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3bd3:	5b                   	pop    %ebx
    3bd4:	5e                   	pop    %esi
    3bd5:	5d                   	pop    %ebp
    3bd6:	c3                   	ret    
    return -1;
    3bd7:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3bdc:	eb f0                	jmp    3bce <stat+0x34>

00003bde <atoi>:

int
atoi(const char *s)
{
    3bde:	55                   	push   %ebp
    3bdf:	89 e5                	mov    %esp,%ebp
    3be1:	53                   	push   %ebx
    3be2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
    3be5:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    3bea:	eb 0e                	jmp    3bfa <atoi+0x1c>
    n = n*10 + *s++ - '0';
    3bec:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3bef:	8d 1c 12             	lea    (%edx,%edx,1),%ebx
    3bf2:	41                   	inc    %ecx
    3bf3:	0f be c0             	movsbl %al,%eax
    3bf6:	8d 54 18 d0          	lea    -0x30(%eax,%ebx,1),%edx
  while('0' <= *s && *s <= '9')
    3bfa:	8a 01                	mov    (%ecx),%al
    3bfc:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3bff:	80 fb 09             	cmp    $0x9,%bl
    3c02:	76 e8                	jbe    3bec <atoi+0xe>
  return n;
}
    3c04:	89 d0                	mov    %edx,%eax
    3c06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3c09:	c9                   	leave  
    3c0a:	c3                   	ret    

00003c0b <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3c0b:	55                   	push   %ebp
    3c0c:	89 e5                	mov    %esp,%ebp
    3c0e:	56                   	push   %esi
    3c0f:	53                   	push   %ebx
    3c10:	8b 45 08             	mov    0x8(%ebp),%eax
    3c13:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3c16:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
    3c19:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
    3c1b:	eb 0c                	jmp    3c29 <memmove+0x1e>
    *dst++ = *src++;
    3c1d:	8a 13                	mov    (%ebx),%dl
    3c1f:	88 11                	mov    %dl,(%ecx)
    3c21:	8d 5b 01             	lea    0x1(%ebx),%ebx
    3c24:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
    3c27:	89 f2                	mov    %esi,%edx
    3c29:	8d 72 ff             	lea    -0x1(%edx),%esi
    3c2c:	85 d2                	test   %edx,%edx
    3c2e:	7f ed                	jg     3c1d <memmove+0x12>
  return vdst;
}
    3c30:	5b                   	pop    %ebx
    3c31:	5e                   	pop    %esi
    3c32:	5d                   	pop    %ebp
    3c33:	c3                   	ret    

00003c34 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3c34:	b8 01 00 00 00       	mov    $0x1,%eax
    3c39:	cd 40                	int    $0x40
    3c3b:	c3                   	ret    

00003c3c <exit>:
SYSCALL(exit)
    3c3c:	b8 02 00 00 00       	mov    $0x2,%eax
    3c41:	cd 40                	int    $0x40
    3c43:	c3                   	ret    

00003c44 <wait>:
SYSCALL(wait)
    3c44:	b8 03 00 00 00       	mov    $0x3,%eax
    3c49:	cd 40                	int    $0x40
    3c4b:	c3                   	ret    

00003c4c <pipe>:
SYSCALL(pipe)
    3c4c:	b8 04 00 00 00       	mov    $0x4,%eax
    3c51:	cd 40                	int    $0x40
    3c53:	c3                   	ret    

00003c54 <read>:
SYSCALL(read)
    3c54:	b8 05 00 00 00       	mov    $0x5,%eax
    3c59:	cd 40                	int    $0x40
    3c5b:	c3                   	ret    

00003c5c <write>:
SYSCALL(write)
    3c5c:	b8 10 00 00 00       	mov    $0x10,%eax
    3c61:	cd 40                	int    $0x40
    3c63:	c3                   	ret    

00003c64 <close>:
SYSCALL(close)
    3c64:	b8 15 00 00 00       	mov    $0x15,%eax
    3c69:	cd 40                	int    $0x40
    3c6b:	c3                   	ret    

00003c6c <kill>:
SYSCALL(kill)
    3c6c:	b8 06 00 00 00       	mov    $0x6,%eax
    3c71:	cd 40                	int    $0x40
    3c73:	c3                   	ret    

00003c74 <exec>:
SYSCALL(exec)
    3c74:	b8 07 00 00 00       	mov    $0x7,%eax
    3c79:	cd 40                	int    $0x40
    3c7b:	c3                   	ret    

00003c7c <open>:
SYSCALL(open)
    3c7c:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c81:	cd 40                	int    $0x40
    3c83:	c3                   	ret    

00003c84 <mknod>:
SYSCALL(mknod)
    3c84:	b8 11 00 00 00       	mov    $0x11,%eax
    3c89:	cd 40                	int    $0x40
    3c8b:	c3                   	ret    

00003c8c <unlink>:
SYSCALL(unlink)
    3c8c:	b8 12 00 00 00       	mov    $0x12,%eax
    3c91:	cd 40                	int    $0x40
    3c93:	c3                   	ret    

00003c94 <fstat>:
SYSCALL(fstat)
    3c94:	b8 08 00 00 00       	mov    $0x8,%eax
    3c99:	cd 40                	int    $0x40
    3c9b:	c3                   	ret    

00003c9c <link>:
SYSCALL(link)
    3c9c:	b8 13 00 00 00       	mov    $0x13,%eax
    3ca1:	cd 40                	int    $0x40
    3ca3:	c3                   	ret    

00003ca4 <mkdir>:
SYSCALL(mkdir)
    3ca4:	b8 14 00 00 00       	mov    $0x14,%eax
    3ca9:	cd 40                	int    $0x40
    3cab:	c3                   	ret    

00003cac <chdir>:
SYSCALL(chdir)
    3cac:	b8 09 00 00 00       	mov    $0x9,%eax
    3cb1:	cd 40                	int    $0x40
    3cb3:	c3                   	ret    

00003cb4 <dup>:
SYSCALL(dup)
    3cb4:	b8 0a 00 00 00       	mov    $0xa,%eax
    3cb9:	cd 40                	int    $0x40
    3cbb:	c3                   	ret    

00003cbc <getpid>:
SYSCALL(getpid)
    3cbc:	b8 0b 00 00 00       	mov    $0xb,%eax
    3cc1:	cd 40                	int    $0x40
    3cc3:	c3                   	ret    

00003cc4 <sbrk>:
SYSCALL(sbrk)
    3cc4:	b8 0c 00 00 00       	mov    $0xc,%eax
    3cc9:	cd 40                	int    $0x40
    3ccb:	c3                   	ret    

00003ccc <sleep>:
SYSCALL(sleep)
    3ccc:	b8 0d 00 00 00       	mov    $0xd,%eax
    3cd1:	cd 40                	int    $0x40
    3cd3:	c3                   	ret    

00003cd4 <uptime>:
SYSCALL(uptime)
    3cd4:	b8 0e 00 00 00       	mov    $0xe,%eax
    3cd9:	cd 40                	int    $0x40
    3cdb:	c3                   	ret    

00003cdc <date>:
SYSCALL(date)
    3cdc:	b8 16 00 00 00       	mov    $0x16,%eax
    3ce1:	cd 40                	int    $0x40
    3ce3:	c3                   	ret    

00003ce4 <dup2>:
SYSCALL(dup2)
    3ce4:	b8 17 00 00 00       	mov    $0x17,%eax
    3ce9:	cd 40                	int    $0x40
    3ceb:	c3                   	ret    

00003cec <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3cec:	55                   	push   %ebp
    3ced:	89 e5                	mov    %esp,%ebp
    3cef:	83 ec 1c             	sub    $0x1c,%esp
    3cf2:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    3cf5:	6a 01                	push   $0x1
    3cf7:	8d 55 f4             	lea    -0xc(%ebp),%edx
    3cfa:	52                   	push   %edx
    3cfb:	50                   	push   %eax
    3cfc:	e8 5b ff ff ff       	call   3c5c <write>
}
    3d01:	83 c4 10             	add    $0x10,%esp
    3d04:	c9                   	leave  
    3d05:	c3                   	ret    

00003d06 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3d06:	55                   	push   %ebp
    3d07:	89 e5                	mov    %esp,%ebp
    3d09:	57                   	push   %edi
    3d0a:	56                   	push   %esi
    3d0b:	53                   	push   %ebx
    3d0c:	83 ec 2c             	sub    $0x2c,%esp
    3d0f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3d12:	89 ce                	mov    %ecx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3d14:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    3d18:	74 04                	je     3d1e <printint+0x18>
    3d1a:	85 d2                	test   %edx,%edx
    3d1c:	78 3c                	js     3d5a <printint+0x54>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3d1e:	89 d1                	mov    %edx,%ecx
  neg = 0;
    3d20:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  }

  i = 0;
    3d27:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
    3d2c:	89 c8                	mov    %ecx,%eax
    3d2e:	ba 00 00 00 00       	mov    $0x0,%edx
    3d33:	f7 f6                	div    %esi
    3d35:	89 df                	mov    %ebx,%edi
    3d37:	43                   	inc    %ebx
    3d38:	8a 92 2c 58 00 00    	mov    0x582c(%edx),%dl
    3d3e:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
    3d42:	89 ca                	mov    %ecx,%edx
    3d44:	89 c1                	mov    %eax,%ecx
    3d46:	39 d6                	cmp    %edx,%esi
    3d48:	76 e2                	jbe    3d2c <printint+0x26>
  if(neg)
    3d4a:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
    3d4e:	74 24                	je     3d74 <printint+0x6e>
    buf[i++] = '-';
    3d50:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    3d55:	8d 5f 02             	lea    0x2(%edi),%ebx
    3d58:	eb 1a                	jmp    3d74 <printint+0x6e>
    x = -xx;
    3d5a:	89 d1                	mov    %edx,%ecx
    3d5c:	f7 d9                	neg    %ecx
    neg = 1;
    3d5e:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
    3d65:	eb c0                	jmp    3d27 <printint+0x21>

  while(--i >= 0)
    putc(fd, buf[i]);
    3d67:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
    3d6c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3d6f:	e8 78 ff ff ff       	call   3cec <putc>
  while(--i >= 0)
    3d74:	4b                   	dec    %ebx
    3d75:	79 f0                	jns    3d67 <printint+0x61>
}
    3d77:	83 c4 2c             	add    $0x2c,%esp
    3d7a:	5b                   	pop    %ebx
    3d7b:	5e                   	pop    %esi
    3d7c:	5f                   	pop    %edi
    3d7d:	5d                   	pop    %ebp
    3d7e:	c3                   	ret    

00003d7f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3d7f:	55                   	push   %ebp
    3d80:	89 e5                	mov    %esp,%ebp
    3d82:	57                   	push   %edi
    3d83:	56                   	push   %esi
    3d84:	53                   	push   %ebx
    3d85:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3d88:	8d 45 10             	lea    0x10(%ebp),%eax
    3d8b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
    3d8e:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
    3d93:	bb 00 00 00 00       	mov    $0x0,%ebx
    3d98:	eb 12                	jmp    3dac <printf+0x2d>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    3d9a:	89 fa                	mov    %edi,%edx
    3d9c:	8b 45 08             	mov    0x8(%ebp),%eax
    3d9f:	e8 48 ff ff ff       	call   3cec <putc>
    3da4:	eb 05                	jmp    3dab <printf+0x2c>
      }
    } else if(state == '%'){
    3da6:	83 fe 25             	cmp    $0x25,%esi
    3da9:	74 22                	je     3dcd <printf+0x4e>
  for(i = 0; fmt[i]; i++){
    3dab:	43                   	inc    %ebx
    3dac:	8b 45 0c             	mov    0xc(%ebp),%eax
    3daf:	8a 04 18             	mov    (%eax,%ebx,1),%al
    3db2:	84 c0                	test   %al,%al
    3db4:	0f 84 1d 01 00 00    	je     3ed7 <printf+0x158>
    c = fmt[i] & 0xff;
    3dba:	0f be f8             	movsbl %al,%edi
    3dbd:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
    3dc0:	85 f6                	test   %esi,%esi
    3dc2:	75 e2                	jne    3da6 <printf+0x27>
      if(c == '%'){
    3dc4:	83 f8 25             	cmp    $0x25,%eax
    3dc7:	75 d1                	jne    3d9a <printf+0x1b>
        state = '%';
    3dc9:	89 c6                	mov    %eax,%esi
    3dcb:	eb de                	jmp    3dab <printf+0x2c>
      if(c == 'd'){
    3dcd:	83 f8 25             	cmp    $0x25,%eax
    3dd0:	0f 84 cc 00 00 00    	je     3ea2 <printf+0x123>
    3dd6:	0f 8c da 00 00 00    	jl     3eb6 <printf+0x137>
    3ddc:	83 f8 78             	cmp    $0x78,%eax
    3ddf:	0f 8f d1 00 00 00    	jg     3eb6 <printf+0x137>
    3de5:	83 f8 63             	cmp    $0x63,%eax
    3de8:	0f 8c c8 00 00 00    	jl     3eb6 <printf+0x137>
    3dee:	83 e8 63             	sub    $0x63,%eax
    3df1:	83 f8 15             	cmp    $0x15,%eax
    3df4:	0f 87 bc 00 00 00    	ja     3eb6 <printf+0x137>
    3dfa:	ff 24 85 d4 57 00 00 	jmp    *0x57d4(,%eax,4)
        printint(fd, *ap, 10, 1);
    3e01:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    3e04:	8b 17                	mov    (%edi),%edx
    3e06:	83 ec 0c             	sub    $0xc,%esp
    3e09:	6a 01                	push   $0x1
    3e0b:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3e10:	8b 45 08             	mov    0x8(%ebp),%eax
    3e13:	e8 ee fe ff ff       	call   3d06 <printint>
        ap++;
    3e18:	83 c7 04             	add    $0x4,%edi
    3e1b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    3e1e:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3e21:	be 00 00 00 00       	mov    $0x0,%esi
    3e26:	eb 83                	jmp    3dab <printf+0x2c>
        printint(fd, *ap, 16, 0);
    3e28:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    3e2b:	8b 17                	mov    (%edi),%edx
    3e2d:	83 ec 0c             	sub    $0xc,%esp
    3e30:	6a 00                	push   $0x0
    3e32:	b9 10 00 00 00       	mov    $0x10,%ecx
    3e37:	8b 45 08             	mov    0x8(%ebp),%eax
    3e3a:	e8 c7 fe ff ff       	call   3d06 <printint>
        ap++;
    3e3f:	83 c7 04             	add    $0x4,%edi
    3e42:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    3e45:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3e48:	be 00 00 00 00       	mov    $0x0,%esi
        ap++;
    3e4d:	e9 59 ff ff ff       	jmp    3dab <printf+0x2c>
        s = (char*)*ap;
    3e52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3e55:	8b 30                	mov    (%eax),%esi
        ap++;
    3e57:	83 c0 04             	add    $0x4,%eax
    3e5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
    3e5d:	85 f6                	test   %esi,%esi
    3e5f:	75 13                	jne    3e74 <printf+0xf5>
          s = "(null)";
    3e61:	be cc 57 00 00       	mov    $0x57cc,%esi
    3e66:	eb 0c                	jmp    3e74 <printf+0xf5>
          putc(fd, *s);
    3e68:	0f be d2             	movsbl %dl,%edx
    3e6b:	8b 45 08             	mov    0x8(%ebp),%eax
    3e6e:	e8 79 fe ff ff       	call   3cec <putc>
          s++;
    3e73:	46                   	inc    %esi
        while(*s != 0){
    3e74:	8a 16                	mov    (%esi),%dl
    3e76:	84 d2                	test   %dl,%dl
    3e78:	75 ee                	jne    3e68 <printf+0xe9>
      state = 0;
    3e7a:	be 00 00 00 00       	mov    $0x0,%esi
    3e7f:	e9 27 ff ff ff       	jmp    3dab <printf+0x2c>
        putc(fd, *ap);
    3e84:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    3e87:	0f be 17             	movsbl (%edi),%edx
    3e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    3e8d:	e8 5a fe ff ff       	call   3cec <putc>
        ap++;
    3e92:	83 c7 04             	add    $0x4,%edi
    3e95:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
    3e98:	be 00 00 00 00       	mov    $0x0,%esi
    3e9d:	e9 09 ff ff ff       	jmp    3dab <printf+0x2c>
        putc(fd, c);
    3ea2:	89 fa                	mov    %edi,%edx
    3ea4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ea7:	e8 40 fe ff ff       	call   3cec <putc>
      state = 0;
    3eac:	be 00 00 00 00       	mov    $0x0,%esi
    3eb1:	e9 f5 fe ff ff       	jmp    3dab <printf+0x2c>
        putc(fd, '%');
    3eb6:	ba 25 00 00 00       	mov    $0x25,%edx
    3ebb:	8b 45 08             	mov    0x8(%ebp),%eax
    3ebe:	e8 29 fe ff ff       	call   3cec <putc>
        putc(fd, c);
    3ec3:	89 fa                	mov    %edi,%edx
    3ec5:	8b 45 08             	mov    0x8(%ebp),%eax
    3ec8:	e8 1f fe ff ff       	call   3cec <putc>
      state = 0;
    3ecd:	be 00 00 00 00       	mov    $0x0,%esi
    3ed2:	e9 d4 fe ff ff       	jmp    3dab <printf+0x2c>
    }
  }
}
    3ed7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3eda:	5b                   	pop    %ebx
    3edb:	5e                   	pop    %esi
    3edc:	5f                   	pop    %edi
    3edd:	5d                   	pop    %ebp
    3ede:	c3                   	ret    

00003edf <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3edf:	55                   	push   %ebp
    3ee0:	89 e5                	mov    %esp,%ebp
    3ee2:	57                   	push   %edi
    3ee3:	56                   	push   %esi
    3ee4:	53                   	push   %ebx
    3ee5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3ee8:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3eeb:	a1 a0 a8 00 00       	mov    0xa8a0,%eax
    3ef0:	eb 02                	jmp    3ef4 <free+0x15>
    3ef2:	89 d0                	mov    %edx,%eax
    3ef4:	39 c8                	cmp    %ecx,%eax
    3ef6:	73 04                	jae    3efc <free+0x1d>
    3ef8:	39 08                	cmp    %ecx,(%eax)
    3efa:	77 12                	ja     3f0e <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3efc:	8b 10                	mov    (%eax),%edx
    3efe:	39 c2                	cmp    %eax,%edx
    3f00:	77 f0                	ja     3ef2 <free+0x13>
    3f02:	39 c8                	cmp    %ecx,%eax
    3f04:	72 08                	jb     3f0e <free+0x2f>
    3f06:	39 ca                	cmp    %ecx,%edx
    3f08:	77 04                	ja     3f0e <free+0x2f>
    3f0a:	89 d0                	mov    %edx,%eax
    3f0c:	eb e6                	jmp    3ef4 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3f0e:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3f11:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3f14:	8b 10                	mov    (%eax),%edx
    3f16:	39 d7                	cmp    %edx,%edi
    3f18:	74 19                	je     3f33 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3f1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3f1d:	8b 50 04             	mov    0x4(%eax),%edx
    3f20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3f23:	39 ce                	cmp    %ecx,%esi
    3f25:	74 1b                	je     3f42 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3f27:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3f29:	a3 a0 a8 00 00       	mov    %eax,0xa8a0
}
    3f2e:	5b                   	pop    %ebx
    3f2f:	5e                   	pop    %esi
    3f30:	5f                   	pop    %edi
    3f31:	5d                   	pop    %ebp
    3f32:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    3f33:	03 72 04             	add    0x4(%edx),%esi
    3f36:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3f39:	8b 10                	mov    (%eax),%edx
    3f3b:	8b 12                	mov    (%edx),%edx
    3f3d:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3f40:	eb db                	jmp    3f1d <free+0x3e>
    p->s.size += bp->s.size;
    3f42:	03 53 fc             	add    -0x4(%ebx),%edx
    3f45:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3f48:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3f4b:	89 10                	mov    %edx,(%eax)
    3f4d:	eb da                	jmp    3f29 <free+0x4a>

00003f4f <morecore>:

static Header*
morecore(uint nu)
{
    3f4f:	55                   	push   %ebp
    3f50:	89 e5                	mov    %esp,%ebp
    3f52:	53                   	push   %ebx
    3f53:	83 ec 04             	sub    $0x4,%esp
    3f56:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    3f58:	3d ff 0f 00 00       	cmp    $0xfff,%eax
    3f5d:	77 05                	ja     3f64 <morecore+0x15>
    nu = 4096;
    3f5f:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
    3f64:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3f6b:	83 ec 0c             	sub    $0xc,%esp
    3f6e:	50                   	push   %eax
    3f6f:	e8 50 fd ff ff       	call   3cc4 <sbrk>
  if(p == (char*)-1)
    3f74:	83 c4 10             	add    $0x10,%esp
    3f77:	83 f8 ff             	cmp    $0xffffffff,%eax
    3f7a:	74 1c                	je     3f98 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3f7c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3f7f:	83 c0 08             	add    $0x8,%eax
    3f82:	83 ec 0c             	sub    $0xc,%esp
    3f85:	50                   	push   %eax
    3f86:	e8 54 ff ff ff       	call   3edf <free>
  return freep;
    3f8b:	a1 a0 a8 00 00       	mov    0xa8a0,%eax
    3f90:	83 c4 10             	add    $0x10,%esp
}
    3f93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3f96:	c9                   	leave  
    3f97:	c3                   	ret    
    return 0;
    3f98:	b8 00 00 00 00       	mov    $0x0,%eax
    3f9d:	eb f4                	jmp    3f93 <morecore+0x44>

00003f9f <malloc>:

void*
malloc(uint nbytes)
{
    3f9f:	55                   	push   %ebp
    3fa0:	89 e5                	mov    %esp,%ebp
    3fa2:	53                   	push   %ebx
    3fa3:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3fa6:	8b 45 08             	mov    0x8(%ebp),%eax
    3fa9:	8d 58 07             	lea    0x7(%eax),%ebx
    3fac:	c1 eb 03             	shr    $0x3,%ebx
    3faf:	43                   	inc    %ebx
  if((prevp = freep) == 0){
    3fb0:	8b 0d a0 a8 00 00    	mov    0xa8a0,%ecx
    3fb6:	85 c9                	test   %ecx,%ecx
    3fb8:	74 04                	je     3fbe <malloc+0x1f>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3fba:	8b 01                	mov    (%ecx),%eax
    3fbc:	eb 4a                	jmp    4008 <malloc+0x69>
    base.s.ptr = freep = prevp = &base;
    3fbe:	c7 05 a0 a8 00 00 a4 	movl   $0xa8a4,0xa8a0
    3fc5:	a8 00 00 
    3fc8:	c7 05 a4 a8 00 00 a4 	movl   $0xa8a4,0xa8a4
    3fcf:	a8 00 00 
    base.s.size = 0;
    3fd2:	c7 05 a8 a8 00 00 00 	movl   $0x0,0xa8a8
    3fd9:	00 00 00 
    base.s.ptr = freep = prevp = &base;
    3fdc:	b9 a4 a8 00 00       	mov    $0xa8a4,%ecx
    3fe1:	eb d7                	jmp    3fba <malloc+0x1b>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    3fe3:	74 19                	je     3ffe <malloc+0x5f>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3fe5:	29 da                	sub    %ebx,%edx
    3fe7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    3fea:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    3fed:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    3ff0:	89 0d a0 a8 00 00    	mov    %ecx,0xa8a0
      return (void*)(p + 1);
    3ff6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3ff9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3ffc:	c9                   	leave  
    3ffd:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    3ffe:	8b 10                	mov    (%eax),%edx
    4000:	89 11                	mov    %edx,(%ecx)
    4002:	eb ec                	jmp    3ff0 <malloc+0x51>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4004:	89 c1                	mov    %eax,%ecx
    4006:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
    4008:	8b 50 04             	mov    0x4(%eax),%edx
    400b:	39 da                	cmp    %ebx,%edx
    400d:	73 d4                	jae    3fe3 <malloc+0x44>
    if(p == freep)
    400f:	39 05 a0 a8 00 00    	cmp    %eax,0xa8a0
    4015:	75 ed                	jne    4004 <malloc+0x65>
      if((p = morecore(nunits)) == 0)
    4017:	89 d8                	mov    %ebx,%eax
    4019:	e8 31 ff ff ff       	call   3f4f <morecore>
    401e:	85 c0                	test   %eax,%eax
    4020:	75 e2                	jne    4004 <malloc+0x65>
    4022:	eb d5                	jmp    3ff9 <malloc+0x5a>
