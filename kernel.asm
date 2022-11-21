
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 80 10 00       	mov    $0x108000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 44 11 80       	mov    $0x801144d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 92 29 10 80       	mov    $0x80102992,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	57                   	push   %edi
80100038:	56                   	push   %esi
80100039:	53                   	push   %ebx
8010003a:	83 ec 18             	sub    $0x18,%esp
8010003d:	89 c6                	mov    %eax,%esi
8010003f:	89 d7                	mov    %edx,%edi
  struct buf *b;

  acquire(&bcache.lock);
80100041:	68 20 95 10 80       	push   $0x80109520
80100046:	e8 70 3a 00 00       	call   80103abb <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010004b:	8b 1d 70 dc 10 80    	mov    0x8010dc70,%ebx
80100051:	83 c4 10             	add    $0x10,%esp
80100054:	eb 03                	jmp    80100059 <bget+0x25>
80100056:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100059:	81 fb 1c dc 10 80    	cmp    $0x8010dc1c,%ebx
8010005f:	74 2e                	je     8010008f <bget+0x5b>
    if(b->dev == dev && b->blockno == blockno){
80100061:	39 73 04             	cmp    %esi,0x4(%ebx)
80100064:	75 f0                	jne    80100056 <bget+0x22>
80100066:	39 7b 08             	cmp    %edi,0x8(%ebx)
80100069:	75 eb                	jne    80100056 <bget+0x22>
      b->refcnt++;
8010006b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010006e:	40                   	inc    %eax
8010006f:	89 43 4c             	mov    %eax,0x4c(%ebx)
      release(&bcache.lock);
80100072:	83 ec 0c             	sub    $0xc,%esp
80100075:	68 20 95 10 80       	push   $0x80109520
8010007a:	e8 a1 3a 00 00       	call   80103b20 <release>
      acquiresleep(&b->lock);
8010007f:	8d 43 0c             	lea    0xc(%ebx),%eax
80100082:	89 04 24             	mov    %eax,(%esp)
80100085:	e8 22 38 00 00       	call   801038ac <acquiresleep>
      return b;
8010008a:	83 c4 10             	add    $0x10,%esp
8010008d:	eb 4c                	jmp    801000db <bget+0xa7>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
8010008f:	8b 1d 6c dc 10 80    	mov    0x8010dc6c,%ebx
80100095:	eb 03                	jmp    8010009a <bget+0x66>
80100097:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010009a:	81 fb 1c dc 10 80    	cmp    $0x8010dc1c,%ebx
801000a0:	74 43                	je     801000e5 <bget+0xb1>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
801000a2:	83 7b 4c 00          	cmpl   $0x0,0x4c(%ebx)
801000a6:	75 ef                	jne    80100097 <bget+0x63>
801000a8:	f6 03 04             	testb  $0x4,(%ebx)
801000ab:	75 ea                	jne    80100097 <bget+0x63>
      b->dev = dev;
801000ad:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
801000b0:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
801000b3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
801000b9:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
801000c0:	83 ec 0c             	sub    $0xc,%esp
801000c3:	68 20 95 10 80       	push   $0x80109520
801000c8:	e8 53 3a 00 00       	call   80103b20 <release>
      acquiresleep(&b->lock);
801000cd:	8d 43 0c             	lea    0xc(%ebx),%eax
801000d0:	89 04 24             	mov    %eax,(%esp)
801000d3:	e8 d4 37 00 00       	call   801038ac <acquiresleep>
      return b;
801000d8:	83 c4 10             	add    $0x10,%esp
    }
  }
  panic("bget: no buffers");
}
801000db:	89 d8                	mov    %ebx,%eax
801000dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801000e0:	5b                   	pop    %ebx
801000e1:	5e                   	pop    %esi
801000e2:	5f                   	pop    %edi
801000e3:	5d                   	pop    %ebp
801000e4:	c3                   	ret    
  panic("bget: no buffers");
801000e5:	83 ec 0c             	sub    $0xc,%esp
801000e8:	68 a0 65 10 80       	push   $0x801065a0
801000ed:	e8 4f 02 00 00       	call   80100341 <panic>

801000f2 <binit>:
{
801000f2:	55                   	push   %ebp
801000f3:	89 e5                	mov    %esp,%ebp
801000f5:	53                   	push   %ebx
801000f6:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
801000f9:	68 b1 65 10 80       	push   $0x801065b1
801000fe:	68 20 95 10 80       	push   $0x80109520
80100103:	e8 7c 38 00 00       	call   80103984 <initlock>
  bcache.head.prev = &bcache.head;
80100108:	c7 05 6c dc 10 80 1c 	movl   $0x8010dc1c,0x8010dc6c
8010010f:	dc 10 80 
  bcache.head.next = &bcache.head;
80100112:	c7 05 70 dc 10 80 1c 	movl   $0x8010dc1c,0x8010dc70
80100119:	dc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010011c:	83 c4 10             	add    $0x10,%esp
8010011f:	bb 54 95 10 80       	mov    $0x80109554,%ebx
80100124:	eb 37                	jmp    8010015d <binit+0x6b>
    b->next = bcache.head.next;
80100126:	a1 70 dc 10 80       	mov    0x8010dc70,%eax
8010012b:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
8010012e:	c7 43 50 1c dc 10 80 	movl   $0x8010dc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100135:	83 ec 08             	sub    $0x8,%esp
80100138:	68 b8 65 10 80       	push   $0x801065b8
8010013d:	8d 43 0c             	lea    0xc(%ebx),%eax
80100140:	50                   	push   %eax
80100141:	e8 33 37 00 00       	call   80103879 <initsleeplock>
    bcache.head.next->prev = b;
80100146:	a1 70 dc 10 80       	mov    0x8010dc70,%eax
8010014b:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010014e:	89 1d 70 dc 10 80    	mov    %ebx,0x8010dc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100154:	81 c3 5c 02 00 00    	add    $0x25c,%ebx
8010015a:	83 c4 10             	add    $0x10,%esp
8010015d:	81 fb 1c dc 10 80    	cmp    $0x8010dc1c,%ebx
80100163:	72 c1                	jb     80100126 <binit+0x34>
}
80100165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100168:	c9                   	leave  
80100169:	c3                   	ret    

8010016a <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
8010016a:	55                   	push   %ebp
8010016b:	89 e5                	mov    %esp,%ebp
8010016d:	53                   	push   %ebx
8010016e:	83 ec 04             	sub    $0x4,%esp
  struct buf *b;

  b = bget(dev, blockno);
80100171:	8b 55 0c             	mov    0xc(%ebp),%edx
80100174:	8b 45 08             	mov    0x8(%ebp),%eax
80100177:	e8 b8 fe ff ff       	call   80100034 <bget>
8010017c:	89 c3                	mov    %eax,%ebx
  if((b->flags & B_VALID) == 0) {
8010017e:	f6 00 02             	testb  $0x2,(%eax)
80100181:	74 07                	je     8010018a <bread+0x20>
    iderw(b);
  }
  return b;
}
80100183:	89 d8                	mov    %ebx,%eax
80100185:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100188:	c9                   	leave  
80100189:	c3                   	ret    
    iderw(b);
8010018a:	83 ec 0c             	sub    $0xc,%esp
8010018d:	50                   	push   %eax
8010018e:	e8 ea 1b 00 00       	call   80101d7d <iderw>
80100193:	83 c4 10             	add    $0x10,%esp
  return b;
80100196:	eb eb                	jmp    80100183 <bread+0x19>

80100198 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100198:	55                   	push   %ebp
80100199:	89 e5                	mov    %esp,%ebp
8010019b:	53                   	push   %ebx
8010019c:	83 ec 10             	sub    $0x10,%esp
8010019f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001a2:	8d 43 0c             	lea    0xc(%ebx),%eax
801001a5:	50                   	push   %eax
801001a6:	e8 8b 37 00 00       	call   80103936 <holdingsleep>
801001ab:	83 c4 10             	add    $0x10,%esp
801001ae:	85 c0                	test   %eax,%eax
801001b0:	74 14                	je     801001c6 <bwrite+0x2e>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b2:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001b5:	83 ec 0c             	sub    $0xc,%esp
801001b8:	53                   	push   %ebx
801001b9:	e8 bf 1b 00 00       	call   80101d7d <iderw>
}
801001be:	83 c4 10             	add    $0x10,%esp
801001c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c4:	c9                   	leave  
801001c5:	c3                   	ret    
    panic("bwrite");
801001c6:	83 ec 0c             	sub    $0xc,%esp
801001c9:	68 bf 65 10 80       	push   $0x801065bf
801001ce:	e8 6e 01 00 00       	call   80100341 <panic>

801001d3 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001d3:	55                   	push   %ebp
801001d4:	89 e5                	mov    %esp,%ebp
801001d6:	56                   	push   %esi
801001d7:	53                   	push   %ebx
801001d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001db:	8d 73 0c             	lea    0xc(%ebx),%esi
801001de:	83 ec 0c             	sub    $0xc,%esp
801001e1:	56                   	push   %esi
801001e2:	e8 4f 37 00 00       	call   80103936 <holdingsleep>
801001e7:	83 c4 10             	add    $0x10,%esp
801001ea:	85 c0                	test   %eax,%eax
801001ec:	74 69                	je     80100257 <brelse+0x84>
    panic("brelse");

  releasesleep(&b->lock);
801001ee:	83 ec 0c             	sub    $0xc,%esp
801001f1:	56                   	push   %esi
801001f2:	e8 04 37 00 00       	call   801038fb <releasesleep>

  acquire(&bcache.lock);
801001f7:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
801001fe:	e8 b8 38 00 00       	call   80103abb <acquire>
  b->refcnt--;
80100203:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100206:	48                   	dec    %eax
80100207:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010020a:	83 c4 10             	add    $0x10,%esp
8010020d:	85 c0                	test   %eax,%eax
8010020f:	75 2f                	jne    80100240 <brelse+0x6d>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100211:	8b 43 54             	mov    0x54(%ebx),%eax
80100214:	8b 53 50             	mov    0x50(%ebx),%edx
80100217:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021a:	8b 43 50             	mov    0x50(%ebx),%eax
8010021d:	8b 53 54             	mov    0x54(%ebx),%edx
80100220:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100223:	a1 70 dc 10 80       	mov    0x8010dc70,%eax
80100228:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
8010022b:	c7 43 50 1c dc 10 80 	movl   $0x8010dc1c,0x50(%ebx)
    bcache.head.next->prev = b;
80100232:	a1 70 dc 10 80       	mov    0x8010dc70,%eax
80100237:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023a:	89 1d 70 dc 10 80    	mov    %ebx,0x8010dc70
  }
  
  release(&bcache.lock);
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	68 20 95 10 80       	push   $0x80109520
80100248:	e8 d3 38 00 00       	call   80103b20 <release>
}
8010024d:	83 c4 10             	add    $0x10,%esp
80100250:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100253:	5b                   	pop    %ebx
80100254:	5e                   	pop    %esi
80100255:	5d                   	pop    %ebp
80100256:	c3                   	ret    
    panic("brelse");
80100257:	83 ec 0c             	sub    $0xc,%esp
8010025a:	68 c6 65 10 80       	push   $0x801065c6
8010025f:	e8 dd 00 00 00       	call   80100341 <panic>

80100264 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100264:	55                   	push   %ebp
80100265:	89 e5                	mov    %esp,%ebp
80100267:	57                   	push   %edi
80100268:	56                   	push   %esi
80100269:	53                   	push   %ebx
8010026a:	83 ec 28             	sub    $0x28,%esp
8010026d:	8b 7d 08             	mov    0x8(%ebp),%edi
80100270:	8b 75 0c             	mov    0xc(%ebp),%esi
80100273:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
80100276:	57                   	push   %edi
80100277:	e8 4a 13 00 00       	call   801015c6 <iunlock>
  target = n;
8010027c:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
8010027f:	c7 04 24 20 df 10 80 	movl   $0x8010df20,(%esp)
80100286:	e8 30 38 00 00       	call   80103abb <acquire>
  while(n > 0){
8010028b:	83 c4 10             	add    $0x10,%esp
8010028e:	85 db                	test   %ebx,%ebx
80100290:	0f 8e 8c 00 00 00    	jle    80100322 <consoleread+0xbe>
    while(input.r == input.w){
80100296:	a1 00 df 10 80       	mov    0x8010df00,%eax
8010029b:	3b 05 04 df 10 80    	cmp    0x8010df04,%eax
801002a1:	75 47                	jne    801002ea <consoleread+0x86>
      if(myproc()->killed){
801002a3:	e8 71 2e 00 00       	call   80103119 <myproc>
801002a8:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
801002ac:	75 17                	jne    801002c5 <consoleread+0x61>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002ae:	83 ec 08             	sub    $0x8,%esp
801002b1:	68 20 df 10 80       	push   $0x8010df20
801002b6:	68 00 df 10 80       	push   $0x8010df00
801002bb:	e8 05 33 00 00       	call   801035c5 <sleep>
801002c0:	83 c4 10             	add    $0x10,%esp
801002c3:	eb d1                	jmp    80100296 <consoleread+0x32>
        release(&cons.lock);
801002c5:	83 ec 0c             	sub    $0xc,%esp
801002c8:	68 20 df 10 80       	push   $0x8010df20
801002cd:	e8 4e 38 00 00       	call   80103b20 <release>
        ilock(ip);
801002d2:	89 3c 24             	mov    %edi,(%esp)
801002d5:	e8 2c 12 00 00       	call   80101506 <ilock>
        return -1;
801002da:	83 c4 10             	add    $0x10,%esp
801002dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002e5:	5b                   	pop    %ebx
801002e6:	5e                   	pop    %esi
801002e7:	5f                   	pop    %edi
801002e8:	5d                   	pop    %ebp
801002e9:	c3                   	ret    
    c = input.buf[input.r++ % INPUT_BUF];
801002ea:	8d 50 01             	lea    0x1(%eax),%edx
801002ed:	89 15 00 df 10 80    	mov    %edx,0x8010df00
801002f3:	89 c2                	mov    %eax,%edx
801002f5:	83 e2 7f             	and    $0x7f,%edx
801002f8:	8a 92 80 de 10 80    	mov    -0x7fef2180(%edx),%dl
801002fe:	0f be ca             	movsbl %dl,%ecx
    if(c == C('D')){  // EOF
80100301:	80 fa 04             	cmp    $0x4,%dl
80100304:	74 12                	je     80100318 <consoleread+0xb4>
    *dst++ = c;
80100306:	8d 46 01             	lea    0x1(%esi),%eax
80100309:	88 16                	mov    %dl,(%esi)
    --n;
8010030b:	4b                   	dec    %ebx
    if(c == '\n')
8010030c:	83 f9 0a             	cmp    $0xa,%ecx
8010030f:	74 11                	je     80100322 <consoleread+0xbe>
    *dst++ = c;
80100311:	89 c6                	mov    %eax,%esi
80100313:	e9 76 ff ff ff       	jmp    8010028e <consoleread+0x2a>
      if(n < target){
80100318:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
8010031b:	73 05                	jae    80100322 <consoleread+0xbe>
        input.r--;
8010031d:	a3 00 df 10 80       	mov    %eax,0x8010df00
  release(&cons.lock);
80100322:	83 ec 0c             	sub    $0xc,%esp
80100325:	68 20 df 10 80       	push   $0x8010df20
8010032a:	e8 f1 37 00 00       	call   80103b20 <release>
  ilock(ip);
8010032f:	89 3c 24             	mov    %edi,(%esp)
80100332:	e8 cf 11 00 00       	call   80101506 <ilock>
  return target - n;
80100337:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010033a:	29 d8                	sub    %ebx,%eax
8010033c:	83 c4 10             	add    $0x10,%esp
8010033f:	eb a1                	jmp    801002e2 <consoleread+0x7e>

80100341 <panic>:
{
80100341:	55                   	push   %ebp
80100342:	89 e5                	mov    %esp,%ebp
80100344:	53                   	push   %ebx
80100345:	83 ec 34             	sub    $0x34,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100348:	fa                   	cli    
  cons.locking = 0;
80100349:	c7 05 54 df 10 80 00 	movl   $0x0,0x8010df54
80100350:	00 00 00 
  cprintf("lapicid %d: panic: ", lapicid());
80100353:	e8 8b 1f 00 00       	call   801022e3 <lapicid>
80100358:	83 ec 08             	sub    $0x8,%esp
8010035b:	50                   	push   %eax
8010035c:	68 cd 65 10 80       	push   $0x801065cd
80100361:	e8 74 02 00 00       	call   801005da <cprintf>
  cprintf(s);
80100366:	83 c4 04             	add    $0x4,%esp
80100369:	ff 75 08             	push   0x8(%ebp)
8010036c:	e8 69 02 00 00       	call   801005da <cprintf>
  cprintf("\n");
80100371:	c7 04 24 ff 6e 10 80 	movl   $0x80106eff,(%esp)
80100378:	e8 5d 02 00 00       	call   801005da <cprintf>
  getcallerpcs(&s, pcs);
8010037d:	83 c4 08             	add    $0x8,%esp
80100380:	8d 45 d0             	lea    -0x30(%ebp),%eax
80100383:	50                   	push   %eax
80100384:	8d 45 08             	lea    0x8(%ebp),%eax
80100387:	50                   	push   %eax
80100388:	e8 12 36 00 00       	call   8010399f <getcallerpcs>
  for(i=0; i<10; i++)
8010038d:	83 c4 10             	add    $0x10,%esp
80100390:	bb 00 00 00 00       	mov    $0x0,%ebx
80100395:	eb 15                	jmp    801003ac <panic+0x6b>
    cprintf(" %p", pcs[i]);
80100397:	83 ec 08             	sub    $0x8,%esp
8010039a:	ff 74 9d d0          	push   -0x30(%ebp,%ebx,4)
8010039e:	68 e1 65 10 80       	push   $0x801065e1
801003a3:	e8 32 02 00 00       	call   801005da <cprintf>
  for(i=0; i<10; i++)
801003a8:	43                   	inc    %ebx
801003a9:	83 c4 10             	add    $0x10,%esp
801003ac:	83 fb 09             	cmp    $0x9,%ebx
801003af:	7e e6                	jle    80100397 <panic+0x56>
  panicked = 1; // freeze other CPU
801003b1:	c7 05 58 df 10 80 01 	movl   $0x1,0x8010df58
801003b8:	00 00 00 
  for(;;)
801003bb:	eb fe                	jmp    801003bb <panic+0x7a>

801003bd <cgaputc>:
{
801003bd:	55                   	push   %ebp
801003be:	89 e5                	mov    %esp,%ebp
801003c0:	57                   	push   %edi
801003c1:	56                   	push   %esi
801003c2:	53                   	push   %ebx
801003c3:	83 ec 0c             	sub    $0xc,%esp
801003c6:	89 c3                	mov    %eax,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003c8:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003cd:	b0 0e                	mov    $0xe,%al
801003cf:	89 fa                	mov    %edi,%edx
801003d1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003d2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801003d7:	89 ca                	mov    %ecx,%edx
801003d9:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801003da:	0f b6 f0             	movzbl %al,%esi
801003dd:	c1 e6 08             	shl    $0x8,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003e0:	b0 0f                	mov    $0xf,%al
801003e2:	89 fa                	mov    %edi,%edx
801003e4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003e5:	89 ca                	mov    %ecx,%edx
801003e7:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801003e8:	0f b6 c8             	movzbl %al,%ecx
801003eb:	09 f1                	or     %esi,%ecx
  if(c == '\n')
801003ed:	83 fb 0a             	cmp    $0xa,%ebx
801003f0:	74 5a                	je     8010044c <cgaputc+0x8f>
  else if(c == BACKSPACE){
801003f2:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
801003f8:	74 62                	je     8010045c <cgaputc+0x9f>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801003fa:	0f b6 c3             	movzbl %bl,%eax
801003fd:	8d 59 01             	lea    0x1(%ecx),%ebx
80100400:	80 cc 07             	or     $0x7,%ah
80100403:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
8010040a:	80 
  if(pos < 0 || pos > 25*80)
8010040b:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100411:	77 56                	ja     80100469 <cgaputc+0xac>
  if((pos/80) >= 24){  // Scroll up.
80100413:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100419:	7f 5b                	jg     80100476 <cgaputc+0xb9>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010041b:	be d4 03 00 00       	mov    $0x3d4,%esi
80100420:	b0 0e                	mov    $0xe,%al
80100422:	89 f2                	mov    %esi,%edx
80100424:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, pos>>8);
80100425:	0f b6 c7             	movzbl %bh,%eax
80100428:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010042d:	89 ca                	mov    %ecx,%edx
8010042f:	ee                   	out    %al,(%dx)
80100430:	b0 0f                	mov    $0xf,%al
80100432:	89 f2                	mov    %esi,%edx
80100434:	ee                   	out    %al,(%dx)
80100435:	88 d8                	mov    %bl,%al
80100437:	89 ca                	mov    %ecx,%edx
80100439:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
8010043a:	66 c7 84 1b 00 80 0b 	movw   $0x720,-0x7ff48000(%ebx,%ebx,1)
80100441:	80 20 07 
}
80100444:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100447:	5b                   	pop    %ebx
80100448:	5e                   	pop    %esi
80100449:	5f                   	pop    %edi
8010044a:	5d                   	pop    %ebp
8010044b:	c3                   	ret    
    pos += 80 - pos%80;
8010044c:	bb 50 00 00 00       	mov    $0x50,%ebx
80100451:	89 c8                	mov    %ecx,%eax
80100453:	99                   	cltd   
80100454:	f7 fb                	idiv   %ebx
80100456:	29 d3                	sub    %edx,%ebx
80100458:	01 cb                	add    %ecx,%ebx
8010045a:	eb af                	jmp    8010040b <cgaputc+0x4e>
    if(pos > 0) --pos;
8010045c:	85 c9                	test   %ecx,%ecx
8010045e:	7e 05                	jle    80100465 <cgaputc+0xa8>
80100460:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80100463:	eb a6                	jmp    8010040b <cgaputc+0x4e>
  pos |= inb(CRTPORT+1);
80100465:	89 cb                	mov    %ecx,%ebx
80100467:	eb a2                	jmp    8010040b <cgaputc+0x4e>
    panic("pos under/overflow");
80100469:	83 ec 0c             	sub    $0xc,%esp
8010046c:	68 e5 65 10 80       	push   $0x801065e5
80100471:	e8 cb fe ff ff       	call   80100341 <panic>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100476:	83 ec 04             	sub    $0x4,%esp
80100479:	68 60 0e 00 00       	push   $0xe60
8010047e:	68 a0 80 0b 80       	push   $0x800b80a0
80100483:	68 00 80 0b 80       	push   $0x800b8000
80100488:	e8 50 37 00 00       	call   80103bdd <memmove>
    pos -= 80;
8010048d:	83 eb 50             	sub    $0x50,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100490:	b8 80 07 00 00       	mov    $0x780,%eax
80100495:	29 d8                	sub    %ebx,%eax
80100497:	8d 94 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%edx
8010049e:	83 c4 0c             	add    $0xc,%esp
801004a1:	01 c0                	add    %eax,%eax
801004a3:	50                   	push   %eax
801004a4:	6a 00                	push   $0x0
801004a6:	52                   	push   %edx
801004a7:	e8 bb 36 00 00       	call   80103b67 <memset>
801004ac:	83 c4 10             	add    $0x10,%esp
801004af:	e9 67 ff ff ff       	jmp    8010041b <cgaputc+0x5e>

801004b4 <consputc>:
  if(panicked){
801004b4:	83 3d 58 df 10 80 00 	cmpl   $0x0,0x8010df58
801004bb:	74 03                	je     801004c0 <consputc+0xc>
  asm volatile("cli");
801004bd:	fa                   	cli    
    for(;;)
801004be:	eb fe                	jmp    801004be <consputc+0xa>
{
801004c0:	55                   	push   %ebp
801004c1:	89 e5                	mov    %esp,%ebp
801004c3:	53                   	push   %ebx
801004c4:	83 ec 04             	sub    $0x4,%esp
801004c7:	89 c3                	mov    %eax,%ebx
  if(c == BACKSPACE){
801004c9:	3d 00 01 00 00       	cmp    $0x100,%eax
801004ce:	74 18                	je     801004e8 <consputc+0x34>
    uartputc(c);
801004d0:	83 ec 0c             	sub    $0xc,%esp
801004d3:	50                   	push   %eax
801004d4:	e8 fb 4a 00 00       	call   80104fd4 <uartputc>
801004d9:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801004dc:	89 d8                	mov    %ebx,%eax
801004de:	e8 da fe ff ff       	call   801003bd <cgaputc>
}
801004e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801004e6:	c9                   	leave  
801004e7:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e8:	83 ec 0c             	sub    $0xc,%esp
801004eb:	6a 08                	push   $0x8
801004ed:	e8 e2 4a 00 00       	call   80104fd4 <uartputc>
801004f2:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f9:	e8 d6 4a 00 00       	call   80104fd4 <uartputc>
801004fe:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100505:	e8 ca 4a 00 00       	call   80104fd4 <uartputc>
8010050a:	83 c4 10             	add    $0x10,%esp
8010050d:	eb cd                	jmp    801004dc <consputc+0x28>

8010050f <printint>:
{
8010050f:	55                   	push   %ebp
80100510:	89 e5                	mov    %esp,%ebp
80100512:	57                   	push   %edi
80100513:	56                   	push   %esi
80100514:	53                   	push   %ebx
80100515:	83 ec 2c             	sub    $0x2c,%esp
80100518:	89 d6                	mov    %edx,%esi
8010051a:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
8010051d:	85 c9                	test   %ecx,%ecx
8010051f:	74 0c                	je     8010052d <printint+0x1e>
80100521:	89 c7                	mov    %eax,%edi
80100523:	c1 ef 1f             	shr    $0x1f,%edi
80100526:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80100529:	85 c0                	test   %eax,%eax
8010052b:	78 35                	js     80100562 <printint+0x53>
    x = xx;
8010052d:	89 c1                	mov    %eax,%ecx
  i = 0;
8010052f:	bb 00 00 00 00       	mov    $0x0,%ebx
    buf[i++] = digits[x % base];
80100534:	89 c8                	mov    %ecx,%eax
80100536:	ba 00 00 00 00       	mov    $0x0,%edx
8010053b:	f7 f6                	div    %esi
8010053d:	89 df                	mov    %ebx,%edi
8010053f:	43                   	inc    %ebx
80100540:	8a 92 10 66 10 80    	mov    -0x7fef99f0(%edx),%dl
80100546:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
8010054a:	89 ca                	mov    %ecx,%edx
8010054c:	89 c1                	mov    %eax,%ecx
8010054e:	39 d6                	cmp    %edx,%esi
80100550:	76 e2                	jbe    80100534 <printint+0x25>
  if(sign)
80100552:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100556:	74 1a                	je     80100572 <printint+0x63>
    buf[i++] = '-';
80100558:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
8010055d:	8d 5f 02             	lea    0x2(%edi),%ebx
80100560:	eb 10                	jmp    80100572 <printint+0x63>
    x = -xx;
80100562:	f7 d8                	neg    %eax
80100564:	89 c1                	mov    %eax,%ecx
80100566:	eb c7                	jmp    8010052f <printint+0x20>
    consputc(buf[i]);
80100568:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
8010056d:	e8 42 ff ff ff       	call   801004b4 <consputc>
  while(--i >= 0)
80100572:	4b                   	dec    %ebx
80100573:	79 f3                	jns    80100568 <printint+0x59>
}
80100575:	83 c4 2c             	add    $0x2c,%esp
80100578:	5b                   	pop    %ebx
80100579:	5e                   	pop    %esi
8010057a:	5f                   	pop    %edi
8010057b:	5d                   	pop    %ebp
8010057c:	c3                   	ret    

8010057d <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010057d:	55                   	push   %ebp
8010057e:	89 e5                	mov    %esp,%ebp
80100580:	57                   	push   %edi
80100581:	56                   	push   %esi
80100582:	53                   	push   %ebx
80100583:	83 ec 18             	sub    $0x18,%esp
80100586:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100589:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010058c:	ff 75 08             	push   0x8(%ebp)
8010058f:	e8 32 10 00 00       	call   801015c6 <iunlock>
  acquire(&cons.lock);
80100594:	c7 04 24 20 df 10 80 	movl   $0x8010df20,(%esp)
8010059b:	e8 1b 35 00 00       	call   80103abb <acquire>
  for(i = 0; i < n; i++)
801005a0:	83 c4 10             	add    $0x10,%esp
801005a3:	bb 00 00 00 00       	mov    $0x0,%ebx
801005a8:	eb 0a                	jmp    801005b4 <consolewrite+0x37>
    consputc(buf[i] & 0xff);
801005aa:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801005ae:	e8 01 ff ff ff       	call   801004b4 <consputc>
  for(i = 0; i < n; i++)
801005b3:	43                   	inc    %ebx
801005b4:	39 f3                	cmp    %esi,%ebx
801005b6:	7c f2                	jl     801005aa <consolewrite+0x2d>
  release(&cons.lock);
801005b8:	83 ec 0c             	sub    $0xc,%esp
801005bb:	68 20 df 10 80       	push   $0x8010df20
801005c0:	e8 5b 35 00 00       	call   80103b20 <release>
  ilock(ip);
801005c5:	83 c4 04             	add    $0x4,%esp
801005c8:	ff 75 08             	push   0x8(%ebp)
801005cb:	e8 36 0f 00 00       	call   80101506 <ilock>

  return n;
}
801005d0:	89 f0                	mov    %esi,%eax
801005d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005d5:	5b                   	pop    %ebx
801005d6:	5e                   	pop    %esi
801005d7:	5f                   	pop    %edi
801005d8:	5d                   	pop    %ebp
801005d9:	c3                   	ret    

801005da <cprintf>:
{
801005da:	55                   	push   %ebp
801005db:	89 e5                	mov    %esp,%ebp
801005dd:	57                   	push   %edi
801005de:	56                   	push   %esi
801005df:	53                   	push   %ebx
801005e0:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801005e3:	a1 54 df 10 80       	mov    0x8010df54,%eax
801005e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801005eb:	85 c0                	test   %eax,%eax
801005ed:	75 10                	jne    801005ff <cprintf+0x25>
  if (fmt == 0)
801005ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801005f3:	74 1c                	je     80100611 <cprintf+0x37>
  argp = (uint*)(void*)(&fmt + 1);
801005f5:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801005f8:	be 00 00 00 00       	mov    $0x0,%esi
801005fd:	eb 25                	jmp    80100624 <cprintf+0x4a>
    acquire(&cons.lock);
801005ff:	83 ec 0c             	sub    $0xc,%esp
80100602:	68 20 df 10 80       	push   $0x8010df20
80100607:	e8 af 34 00 00       	call   80103abb <acquire>
8010060c:	83 c4 10             	add    $0x10,%esp
8010060f:	eb de                	jmp    801005ef <cprintf+0x15>
    panic("null fmt");
80100611:	83 ec 0c             	sub    $0xc,%esp
80100614:	68 ff 65 10 80       	push   $0x801065ff
80100619:	e8 23 fd ff ff       	call   80100341 <panic>
      consputc(c);
8010061e:	e8 91 fe ff ff       	call   801004b4 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100623:	46                   	inc    %esi
80100624:	8b 55 08             	mov    0x8(%ebp),%edx
80100627:	0f b6 04 32          	movzbl (%edx,%esi,1),%eax
8010062b:	85 c0                	test   %eax,%eax
8010062d:	0f 84 ac 00 00 00    	je     801006df <cprintf+0x105>
    if(c != '%'){
80100633:	83 f8 25             	cmp    $0x25,%eax
80100636:	75 e6                	jne    8010061e <cprintf+0x44>
    c = fmt[++i] & 0xff;
80100638:	46                   	inc    %esi
80100639:	0f b6 1c 32          	movzbl (%edx,%esi,1),%ebx
    if(c == 0)
8010063d:	85 db                	test   %ebx,%ebx
8010063f:	0f 84 9a 00 00 00    	je     801006df <cprintf+0x105>
    switch(c){
80100645:	83 fb 70             	cmp    $0x70,%ebx
80100648:	74 2e                	je     80100678 <cprintf+0x9e>
8010064a:	7f 22                	jg     8010066e <cprintf+0x94>
8010064c:	83 fb 25             	cmp    $0x25,%ebx
8010064f:	74 69                	je     801006ba <cprintf+0xe0>
80100651:	83 fb 64             	cmp    $0x64,%ebx
80100654:	75 73                	jne    801006c9 <cprintf+0xef>
      printint(*argp++, 10, 1);
80100656:	8d 5f 04             	lea    0x4(%edi),%ebx
80100659:	8b 07                	mov    (%edi),%eax
8010065b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100660:	ba 0a 00 00 00       	mov    $0xa,%edx
80100665:	e8 a5 fe ff ff       	call   8010050f <printint>
8010066a:	89 df                	mov    %ebx,%edi
      break;
8010066c:	eb b5                	jmp    80100623 <cprintf+0x49>
    switch(c){
8010066e:	83 fb 73             	cmp    $0x73,%ebx
80100671:	74 1d                	je     80100690 <cprintf+0xb6>
80100673:	83 fb 78             	cmp    $0x78,%ebx
80100676:	75 51                	jne    801006c9 <cprintf+0xef>
      printint(*argp++, 16, 0);
80100678:	8d 5f 04             	lea    0x4(%edi),%ebx
8010067b:	8b 07                	mov    (%edi),%eax
8010067d:	b9 00 00 00 00       	mov    $0x0,%ecx
80100682:	ba 10 00 00 00       	mov    $0x10,%edx
80100687:	e8 83 fe ff ff       	call   8010050f <printint>
8010068c:	89 df                	mov    %ebx,%edi
      break;
8010068e:	eb 93                	jmp    80100623 <cprintf+0x49>
      if((s = (char*)*argp++) == 0)
80100690:	8d 47 04             	lea    0x4(%edi),%eax
80100693:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100696:	8b 1f                	mov    (%edi),%ebx
80100698:	85 db                	test   %ebx,%ebx
8010069a:	75 10                	jne    801006ac <cprintf+0xd2>
        s = "(null)";
8010069c:	bb f8 65 10 80       	mov    $0x801065f8,%ebx
801006a1:	eb 09                	jmp    801006ac <cprintf+0xd2>
        consputc(*s);
801006a3:	0f be c0             	movsbl %al,%eax
801006a6:	e8 09 fe ff ff       	call   801004b4 <consputc>
      for(; *s; s++)
801006ab:	43                   	inc    %ebx
801006ac:	8a 03                	mov    (%ebx),%al
801006ae:	84 c0                	test   %al,%al
801006b0:	75 f1                	jne    801006a3 <cprintf+0xc9>
      if((s = (char*)*argp++) == 0)
801006b2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801006b5:	e9 69 ff ff ff       	jmp    80100623 <cprintf+0x49>
      consputc('%');
801006ba:	b8 25 00 00 00       	mov    $0x25,%eax
801006bf:	e8 f0 fd ff ff       	call   801004b4 <consputc>
      break;
801006c4:	e9 5a ff ff ff       	jmp    80100623 <cprintf+0x49>
      consputc('%');
801006c9:	b8 25 00 00 00       	mov    $0x25,%eax
801006ce:	e8 e1 fd ff ff       	call   801004b4 <consputc>
      consputc(c);
801006d3:	89 d8                	mov    %ebx,%eax
801006d5:	e8 da fd ff ff       	call   801004b4 <consputc>
      break;
801006da:	e9 44 ff ff ff       	jmp    80100623 <cprintf+0x49>
  if(locking)
801006df:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801006e3:	75 08                	jne    801006ed <cprintf+0x113>
}
801006e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006e8:	5b                   	pop    %ebx
801006e9:	5e                   	pop    %esi
801006ea:	5f                   	pop    %edi
801006eb:	5d                   	pop    %ebp
801006ec:	c3                   	ret    
    release(&cons.lock);
801006ed:	83 ec 0c             	sub    $0xc,%esp
801006f0:	68 20 df 10 80       	push   $0x8010df20
801006f5:	e8 26 34 00 00       	call   80103b20 <release>
801006fa:	83 c4 10             	add    $0x10,%esp
}
801006fd:	eb e6                	jmp    801006e5 <cprintf+0x10b>

801006ff <consoleintr>:
{
801006ff:	55                   	push   %ebp
80100700:	89 e5                	mov    %esp,%ebp
80100702:	57                   	push   %edi
80100703:	56                   	push   %esi
80100704:	53                   	push   %ebx
80100705:	83 ec 18             	sub    $0x18,%esp
80100708:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010070b:	68 20 df 10 80       	push   $0x8010df20
80100710:	e8 a6 33 00 00       	call   80103abb <acquire>
  while((c = getc()) >= 0){
80100715:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100718:	be 00 00 00 00       	mov    $0x0,%esi
  while((c = getc()) >= 0){
8010071d:	eb 13                	jmp    80100732 <consoleintr+0x33>
    switch(c){
8010071f:	83 ff 08             	cmp    $0x8,%edi
80100722:	0f 84 d1 00 00 00    	je     801007f9 <consoleintr+0xfa>
80100728:	83 ff 10             	cmp    $0x10,%edi
8010072b:	75 25                	jne    80100752 <consoleintr+0x53>
8010072d:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100732:	ff d3                	call   *%ebx
80100734:	89 c7                	mov    %eax,%edi
80100736:	85 c0                	test   %eax,%eax
80100738:	0f 88 eb 00 00 00    	js     80100829 <consoleintr+0x12a>
    switch(c){
8010073e:	83 ff 15             	cmp    $0x15,%edi
80100741:	0f 84 8d 00 00 00    	je     801007d4 <consoleintr+0xd5>
80100747:	7e d6                	jle    8010071f <consoleintr+0x20>
80100749:	83 ff 7f             	cmp    $0x7f,%edi
8010074c:	0f 84 a7 00 00 00    	je     801007f9 <consoleintr+0xfa>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100752:	85 ff                	test   %edi,%edi
80100754:	74 dc                	je     80100732 <consoleintr+0x33>
80100756:	a1 08 df 10 80       	mov    0x8010df08,%eax
8010075b:	89 c2                	mov    %eax,%edx
8010075d:	2b 15 00 df 10 80    	sub    0x8010df00,%edx
80100763:	83 fa 7f             	cmp    $0x7f,%edx
80100766:	77 ca                	ja     80100732 <consoleintr+0x33>
        c = (c == '\r') ? '\n' : c;
80100768:	83 ff 0d             	cmp    $0xd,%edi
8010076b:	0f 84 ae 00 00 00    	je     8010081f <consoleintr+0x120>
        input.buf[input.e++ % INPUT_BUF] = c;
80100771:	8d 50 01             	lea    0x1(%eax),%edx
80100774:	89 15 08 df 10 80    	mov    %edx,0x8010df08
8010077a:	83 e0 7f             	and    $0x7f,%eax
8010077d:	89 f9                	mov    %edi,%ecx
8010077f:	88 88 80 de 10 80    	mov    %cl,-0x7fef2180(%eax)
        consputc(c);
80100785:	89 f8                	mov    %edi,%eax
80100787:	e8 28 fd ff ff       	call   801004b4 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010078c:	83 ff 0a             	cmp    $0xa,%edi
8010078f:	74 15                	je     801007a6 <consoleintr+0xa7>
80100791:	83 ff 04             	cmp    $0x4,%edi
80100794:	74 10                	je     801007a6 <consoleintr+0xa7>
80100796:	a1 00 df 10 80       	mov    0x8010df00,%eax
8010079b:	83 e8 80             	sub    $0xffffff80,%eax
8010079e:	39 05 08 df 10 80    	cmp    %eax,0x8010df08
801007a4:	75 8c                	jne    80100732 <consoleintr+0x33>
          input.w = input.e;
801007a6:	a1 08 df 10 80       	mov    0x8010df08,%eax
801007ab:	a3 04 df 10 80       	mov    %eax,0x8010df04
          wakeup(&input.r);
801007b0:	83 ec 0c             	sub    $0xc,%esp
801007b3:	68 00 df 10 80       	push   $0x8010df00
801007b8:	e8 6f 2f 00 00       	call   8010372c <wakeup>
801007bd:	83 c4 10             	add    $0x10,%esp
801007c0:	e9 6d ff ff ff       	jmp    80100732 <consoleintr+0x33>
        input.e--;
801007c5:	a3 08 df 10 80       	mov    %eax,0x8010df08
        consputc(BACKSPACE);
801007ca:	b8 00 01 00 00       	mov    $0x100,%eax
801007cf:	e8 e0 fc ff ff       	call   801004b4 <consputc>
      while(input.e != input.w &&
801007d4:	a1 08 df 10 80       	mov    0x8010df08,%eax
801007d9:	3b 05 04 df 10 80    	cmp    0x8010df04,%eax
801007df:	0f 84 4d ff ff ff    	je     80100732 <consoleintr+0x33>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801007e5:	48                   	dec    %eax
801007e6:	89 c2                	mov    %eax,%edx
801007e8:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801007eb:	80 ba 80 de 10 80 0a 	cmpb   $0xa,-0x7fef2180(%edx)
801007f2:	75 d1                	jne    801007c5 <consoleintr+0xc6>
801007f4:	e9 39 ff ff ff       	jmp    80100732 <consoleintr+0x33>
      if(input.e != input.w){
801007f9:	a1 08 df 10 80       	mov    0x8010df08,%eax
801007fe:	3b 05 04 df 10 80    	cmp    0x8010df04,%eax
80100804:	0f 84 28 ff ff ff    	je     80100732 <consoleintr+0x33>
        input.e--;
8010080a:	48                   	dec    %eax
8010080b:	a3 08 df 10 80       	mov    %eax,0x8010df08
        consputc(BACKSPACE);
80100810:	b8 00 01 00 00       	mov    $0x100,%eax
80100815:	e8 9a fc ff ff       	call   801004b4 <consputc>
8010081a:	e9 13 ff ff ff       	jmp    80100732 <consoleintr+0x33>
        c = (c == '\r') ? '\n' : c;
8010081f:	bf 0a 00 00 00       	mov    $0xa,%edi
80100824:	e9 48 ff ff ff       	jmp    80100771 <consoleintr+0x72>
  release(&cons.lock);
80100829:	83 ec 0c             	sub    $0xc,%esp
8010082c:	68 20 df 10 80       	push   $0x8010df20
80100831:	e8 ea 32 00 00       	call   80103b20 <release>
  if(doprocdump) {
80100836:	83 c4 10             	add    $0x10,%esp
80100839:	85 f6                	test   %esi,%esi
8010083b:	75 08                	jne    80100845 <consoleintr+0x146>
}
8010083d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100840:	5b                   	pop    %ebx
80100841:	5e                   	pop    %esi
80100842:	5f                   	pop    %edi
80100843:	5d                   	pop    %ebp
80100844:	c3                   	ret    
    procdump();  // now call procdump() wo. cons.lock held
80100845:	e8 7f 2f 00 00       	call   801037c9 <procdump>
}
8010084a:	eb f1                	jmp    8010083d <consoleintr+0x13e>

8010084c <consoleinit>:

void
consoleinit(void)
{
8010084c:	55                   	push   %ebp
8010084d:	89 e5                	mov    %esp,%ebp
8010084f:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100852:	68 08 66 10 80       	push   $0x80106608
80100857:	68 20 df 10 80       	push   $0x8010df20
8010085c:	e8 23 31 00 00       	call   80103984 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100861:	c7 05 0c e9 10 80 7d 	movl   $0x8010057d,0x8010e90c
80100868:	05 10 80 
  devsw[CONSOLE].read = consoleread;
8010086b:	c7 05 08 e9 10 80 64 	movl   $0x80100264,0x8010e908
80100872:	02 10 80 
  cons.locking = 1;
80100875:	c7 05 54 df 10 80 01 	movl   $0x1,0x8010df54
8010087c:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
8010087f:	83 c4 08             	add    $0x8,%esp
80100882:	6a 00                	push   $0x0
80100884:	6a 01                	push   $0x1
80100886:	e8 5a 16 00 00       	call   80101ee5 <ioapicenable>
}
8010088b:	83 c4 10             	add    $0x10,%esp
8010088e:	c9                   	leave  
8010088f:	c3                   	ret    

80100890 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100890:	55                   	push   %ebp
80100891:	89 e5                	mov    %esp,%ebp
80100893:	57                   	push   %edi
80100894:	56                   	push   %esi
80100895:	53                   	push   %ebx
80100896:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010089c:	e8 78 28 00 00       	call   80103119 <myproc>
801008a1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801008a7:	e8 30 1e 00 00       	call   801026dc <begin_op>

  if((ip = namei(path)) == 0){
801008ac:	83 ec 0c             	sub    $0xc,%esp
801008af:	ff 75 08             	push   0x8(%ebp)
801008b2:	e8 b3 12 00 00       	call   80101b6a <namei>
801008b7:	83 c4 10             	add    $0x10,%esp
801008ba:	85 c0                	test   %eax,%eax
801008bc:	74 56                	je     80100914 <exec+0x84>
801008be:	89 c3                	mov    %eax,%ebx
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801008c0:	83 ec 0c             	sub    $0xc,%esp
801008c3:	50                   	push   %eax
801008c4:	e8 3d 0c 00 00       	call   80101506 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801008c9:	6a 34                	push   $0x34
801008cb:	6a 00                	push   $0x0
801008cd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801008d3:	50                   	push   %eax
801008d4:	53                   	push   %ebx
801008d5:	e8 19 0e 00 00       	call   801016f3 <readi>
801008da:	83 c4 20             	add    $0x20,%esp
801008dd:	83 f8 34             	cmp    $0x34,%eax
801008e0:	75 0c                	jne    801008ee <exec+0x5e>
    goto bad;
  if(elf.magic != ELF_MAGIC)
801008e2:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801008e9:	45 4c 46 
801008ec:	74 42                	je     80100930 <exec+0xa0>
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir, 1);
  if(ip){
801008ee:	85 db                	test   %ebx,%ebx
801008f0:	0f 84 cc 02 00 00    	je     80100bc2 <exec+0x332>
    iunlockput(ip);
801008f6:	83 ec 0c             	sub    $0xc,%esp
801008f9:	53                   	push   %ebx
801008fa:	e8 aa 0d 00 00       	call   801016a9 <iunlockput>
    end_op();
801008ff:	e8 54 1e 00 00       	call   80102758 <end_op>
80100904:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100907:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010090c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010090f:	5b                   	pop    %ebx
80100910:	5e                   	pop    %esi
80100911:	5f                   	pop    %edi
80100912:	5d                   	pop    %ebp
80100913:	c3                   	ret    
    end_op();
80100914:	e8 3f 1e 00 00       	call   80102758 <end_op>
    cprintf("exec: fail\n");
80100919:	83 ec 0c             	sub    $0xc,%esp
8010091c:	68 21 66 10 80       	push   $0x80106621
80100921:	e8 b4 fc ff ff       	call   801005da <cprintf>
    return -1;
80100926:	83 c4 10             	add    $0x10,%esp
80100929:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010092e:	eb dc                	jmp    8010090c <exec+0x7c>
  if((pgdir = setupkvm()) == 0)
80100930:	e8 0d 5a 00 00       	call   80106342 <setupkvm>
80100935:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
8010093b:	85 c0                	test   %eax,%eax
8010093d:	0f 84 14 01 00 00    	je     80100a57 <exec+0x1c7>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100943:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  sz = 0;
80100949:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100950:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100953:	be 00 00 00 00       	mov    $0x0,%esi
80100958:	eb 04                	jmp    8010095e <exec+0xce>
8010095a:	46                   	inc    %esi
8010095b:	8d 47 20             	lea    0x20(%edi),%eax
8010095e:	0f b7 95 50 ff ff ff 	movzwl -0xb0(%ebp),%edx
80100965:	39 f2                	cmp    %esi,%edx
80100967:	0f 8e a1 00 00 00    	jle    80100a0e <exec+0x17e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010096d:	89 c7                	mov    %eax,%edi
8010096f:	6a 20                	push   $0x20
80100971:	50                   	push   %eax
80100972:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100978:	50                   	push   %eax
80100979:	53                   	push   %ebx
8010097a:	e8 74 0d 00 00       	call   801016f3 <readi>
8010097f:	83 c4 10             	add    $0x10,%esp
80100982:	83 f8 20             	cmp    $0x20,%eax
80100985:	0f 85 cc 00 00 00    	jne    80100a57 <exec+0x1c7>
    if(ph.type != ELF_PROG_LOAD || ph.memsz == 0)
8010098b:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100992:	75 c6                	jne    8010095a <exec+0xca>
80100994:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010099a:	85 c0                	test   %eax,%eax
8010099c:	74 bc                	je     8010095a <exec+0xca>
    if(ph.memsz < ph.filesz)
8010099e:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801009a4:	0f 82 ad 00 00 00    	jb     80100a57 <exec+0x1c7>
    if(ph.vaddr + ph.memsz < ph.vaddr)
801009aa:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801009b0:	0f 82 a1 00 00 00    	jb     80100a57 <exec+0x1c7>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801009b6:	83 ec 04             	sub    $0x4,%esp
801009b9:	50                   	push   %eax
801009ba:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
801009c0:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801009c6:	e8 17 58 00 00       	call   801061e2 <allocuvm>
801009cb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801009d1:	83 c4 10             	add    $0x10,%esp
801009d4:	85 c0                	test   %eax,%eax
801009d6:	74 7f                	je     80100a57 <exec+0x1c7>
    if(ph.vaddr % PGSIZE != 0)
801009d8:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801009de:	a9 ff 0f 00 00       	test   $0xfff,%eax
801009e3:	75 72                	jne    80100a57 <exec+0x1c7>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801009e5:	83 ec 0c             	sub    $0xc,%esp
801009e8:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
801009ee:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
801009f4:	53                   	push   %ebx
801009f5:	50                   	push   %eax
801009f6:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801009fc:	e8 b7 56 00 00       	call   801060b8 <loaduvm>
80100a01:	83 c4 20             	add    $0x20,%esp
80100a04:	85 c0                	test   %eax,%eax
80100a06:	0f 89 4e ff ff ff    	jns    8010095a <exec+0xca>
80100a0c:	eb 49                	jmp    80100a57 <exec+0x1c7>
  iunlockput(ip);
80100a0e:	83 ec 0c             	sub    $0xc,%esp
80100a11:	53                   	push   %ebx
80100a12:	e8 92 0c 00 00       	call   801016a9 <iunlockput>
  end_op();
80100a17:	e8 3c 1d 00 00       	call   80102758 <end_op>
  sz = PGROUNDUP(sz);
80100a1c:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a22:	05 ff 0f 00 00       	add    $0xfff,%eax
80100a27:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100a2c:	83 c4 0c             	add    $0xc,%esp
80100a2f:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100a35:	52                   	push   %edx
80100a36:	50                   	push   %eax
80100a37:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100a3d:	57                   	push   %edi
80100a3e:	e8 9f 57 00 00       	call   801061e2 <allocuvm>
80100a43:	89 c6                	mov    %eax,%esi
80100a45:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a4b:	83 c4 10             	add    $0x10,%esp
80100a4e:	85 c0                	test   %eax,%eax
80100a50:	75 26                	jne    80100a78 <exec+0x1e8>
  ip = 0;
80100a52:	bb 00 00 00 00       	mov    $0x0,%ebx
  if(pgdir)
80100a57:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a5d:	85 c0                	test   %eax,%eax
80100a5f:	0f 84 89 fe ff ff    	je     801008ee <exec+0x5e>
    freevm(pgdir, 1);
80100a65:	83 ec 08             	sub    $0x8,%esp
80100a68:	6a 01                	push   $0x1
80100a6a:	50                   	push   %eax
80100a6b:	e8 5c 58 00 00       	call   801062cc <freevm>
80100a70:	83 c4 10             	add    $0x10,%esp
80100a73:	e9 76 fe ff ff       	jmp    801008ee <exec+0x5e>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100a78:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100a7e:	83 ec 08             	sub    $0x8,%esp
80100a81:	50                   	push   %eax
80100a82:	57                   	push   %edi
80100a83:	e8 41 59 00 00       	call   801063c9 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100a88:	83 c4 10             	add    $0x10,%esp
80100a8b:	bf 00 00 00 00       	mov    $0x0,%edi
80100a90:	eb 08                	jmp    80100a9a <exec+0x20a>
    ustack[3+argc] = sp;
80100a92:	89 b4 bd 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100a99:	47                   	inc    %edi
80100a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a9d:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
80100aa0:	8b 03                	mov    (%ebx),%eax
80100aa2:	85 c0                	test   %eax,%eax
80100aa4:	74 43                	je     80100ae9 <exec+0x259>
    if(argc >= MAXARG)
80100aa6:	83 ff 1f             	cmp    $0x1f,%edi
80100aa9:	0f 87 09 01 00 00    	ja     80100bb8 <exec+0x328>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100aaf:	83 ec 0c             	sub    $0xc,%esp
80100ab2:	50                   	push   %eax
80100ab3:	e8 3f 32 00 00       	call   80103cf7 <strlen>
80100ab8:	29 c6                	sub    %eax,%esi
80100aba:	4e                   	dec    %esi
80100abb:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100abe:	83 c4 04             	add    $0x4,%esp
80100ac1:	ff 33                	push   (%ebx)
80100ac3:	e8 2f 32 00 00       	call   80103cf7 <strlen>
80100ac8:	40                   	inc    %eax
80100ac9:	50                   	push   %eax
80100aca:	ff 33                	push   (%ebx)
80100acc:	56                   	push   %esi
80100acd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ad3:	e8 41 5a 00 00       	call   80106519 <copyout>
80100ad8:	83 c4 20             	add    $0x20,%esp
80100adb:	85 c0                	test   %eax,%eax
80100add:	79 b3                	jns    80100a92 <exec+0x202>
  ip = 0;
80100adf:	bb 00 00 00 00       	mov    $0x0,%ebx
80100ae4:	e9 6e ff ff ff       	jmp    80100a57 <exec+0x1c7>
  ustack[3+argc] = 0;
80100ae9:	89 f1                	mov    %esi,%ecx
80100aeb:	89 c3                	mov    %eax,%ebx
80100aed:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100af4:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100af8:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100aff:	ff ff ff 
  ustack[1] = argc;
80100b02:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100b08:	8d 14 bd 04 00 00 00 	lea    0x4(,%edi,4),%edx
80100b0f:	89 f0                	mov    %esi,%eax
80100b11:	29 d0                	sub    %edx,%eax
80100b13:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  sp -= (3+argc+1) * 4;
80100b19:	8d 04 bd 10 00 00 00 	lea    0x10(,%edi,4),%eax
80100b20:	29 c1                	sub    %eax,%ecx
80100b22:	89 ce                	mov    %ecx,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100b24:	50                   	push   %eax
80100b25:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
80100b2b:	50                   	push   %eax
80100b2c:	51                   	push   %ecx
80100b2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100b33:	e8 e1 59 00 00       	call   80106519 <copyout>
80100b38:	83 c4 10             	add    $0x10,%esp
80100b3b:	85 c0                	test   %eax,%eax
80100b3d:	0f 88 14 ff ff ff    	js     80100a57 <exec+0x1c7>
  for(last=s=path; *s; s++)
80100b43:	8b 55 08             	mov    0x8(%ebp),%edx
80100b46:	89 d0                	mov    %edx,%eax
80100b48:	eb 01                	jmp    80100b4b <exec+0x2bb>
80100b4a:	40                   	inc    %eax
80100b4b:	8a 08                	mov    (%eax),%cl
80100b4d:	84 c9                	test   %cl,%cl
80100b4f:	74 0a                	je     80100b5b <exec+0x2cb>
    if(*s == '/')
80100b51:	80 f9 2f             	cmp    $0x2f,%cl
80100b54:	75 f4                	jne    80100b4a <exec+0x2ba>
      last = s+1;
80100b56:	8d 50 01             	lea    0x1(%eax),%edx
80100b59:	eb ef                	jmp    80100b4a <exec+0x2ba>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100b5b:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100b61:	89 f8                	mov    %edi,%eax
80100b63:	83 c0 6c             	add    $0x6c,%eax
80100b66:	83 ec 04             	sub    $0x4,%esp
80100b69:	6a 10                	push   $0x10
80100b6b:	52                   	push   %edx
80100b6c:	50                   	push   %eax
80100b6d:	e8 4d 31 00 00       	call   80103cbf <safestrcpy>
  oldpgdir = curproc->pgdir;
80100b72:	8b 5f 04             	mov    0x4(%edi),%ebx
  curproc->pgdir = pgdir;
80100b75:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100b7b:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100b7e:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100b84:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100b86:	8b 47 18             	mov    0x18(%edi),%eax
80100b89:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100b8f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100b92:	8b 47 18             	mov    0x18(%edi),%eax
80100b95:	89 70 44             	mov    %esi,0x44(%eax)
  switchuvm(curproc);
80100b98:	89 3c 24             	mov    %edi,(%esp)
80100b9b:	e8 53 53 00 00       	call   80105ef3 <switchuvm>
  freevm(oldpgdir, 1);
80100ba0:	83 c4 08             	add    $0x8,%esp
80100ba3:	6a 01                	push   $0x1
80100ba5:	53                   	push   %ebx
80100ba6:	e8 21 57 00 00       	call   801062cc <freevm>
  return 0;
80100bab:	83 c4 10             	add    $0x10,%esp
80100bae:	b8 00 00 00 00       	mov    $0x0,%eax
80100bb3:	e9 54 fd ff ff       	jmp    8010090c <exec+0x7c>
  ip = 0;
80100bb8:	bb 00 00 00 00       	mov    $0x0,%ebx
80100bbd:	e9 95 fe ff ff       	jmp    80100a57 <exec+0x1c7>
  return -1;
80100bc2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc7:	e9 40 fd ff ff       	jmp    8010090c <exec+0x7c>

80100bcc <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100bcc:	55                   	push   %ebp
80100bcd:	89 e5                	mov    %esp,%ebp
80100bcf:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100bd2:	68 2d 66 10 80       	push   $0x8010662d
80100bd7:	68 60 df 10 80       	push   $0x8010df60
80100bdc:	e8 a3 2d 00 00       	call   80103984 <initlock>
}
80100be1:	83 c4 10             	add    $0x10,%esp
80100be4:	c9                   	leave  
80100be5:	c3                   	ret    

80100be6 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100be6:	55                   	push   %ebp
80100be7:	89 e5                	mov    %esp,%ebp
80100be9:	53                   	push   %ebx
80100bea:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100bed:	68 60 df 10 80       	push   $0x8010df60
80100bf2:	e8 c4 2e 00 00       	call   80103abb <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100bf7:	83 c4 10             	add    $0x10,%esp
80100bfa:	bb 94 df 10 80       	mov    $0x8010df94,%ebx
80100bff:	81 fb f4 e8 10 80    	cmp    $0x8010e8f4,%ebx
80100c05:	73 29                	jae    80100c30 <filealloc+0x4a>
    if(f->ref == 0){
80100c07:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
80100c0b:	74 05                	je     80100c12 <filealloc+0x2c>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100c0d:	83 c3 18             	add    $0x18,%ebx
80100c10:	eb ed                	jmp    80100bff <filealloc+0x19>
      f->ref = 1;
80100c12:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100c19:	83 ec 0c             	sub    $0xc,%esp
80100c1c:	68 60 df 10 80       	push   $0x8010df60
80100c21:	e8 fa 2e 00 00       	call   80103b20 <release>
      return f;
80100c26:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100c29:	89 d8                	mov    %ebx,%eax
80100c2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100c2e:	c9                   	leave  
80100c2f:	c3                   	ret    
  release(&ftable.lock);
80100c30:	83 ec 0c             	sub    $0xc,%esp
80100c33:	68 60 df 10 80       	push   $0x8010df60
80100c38:	e8 e3 2e 00 00       	call   80103b20 <release>
  return 0;
80100c3d:	83 c4 10             	add    $0x10,%esp
80100c40:	bb 00 00 00 00       	mov    $0x0,%ebx
80100c45:	eb e2                	jmp    80100c29 <filealloc+0x43>

80100c47 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100c47:	55                   	push   %ebp
80100c48:	89 e5                	mov    %esp,%ebp
80100c4a:	53                   	push   %ebx
80100c4b:	83 ec 10             	sub    $0x10,%esp
80100c4e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100c51:	68 60 df 10 80       	push   $0x8010df60
80100c56:	e8 60 2e 00 00       	call   80103abb <acquire>
  if(f->ref < 1)
80100c5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100c5e:	83 c4 10             	add    $0x10,%esp
80100c61:	85 c0                	test   %eax,%eax
80100c63:	7e 18                	jle    80100c7d <filedup+0x36>
    panic("filedup");
  f->ref++;
80100c65:	40                   	inc    %eax
80100c66:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100c69:	83 ec 0c             	sub    $0xc,%esp
80100c6c:	68 60 df 10 80       	push   $0x8010df60
80100c71:	e8 aa 2e 00 00       	call   80103b20 <release>
  return f;
}
80100c76:	89 d8                	mov    %ebx,%eax
80100c78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100c7b:	c9                   	leave  
80100c7c:	c3                   	ret    
    panic("filedup");
80100c7d:	83 ec 0c             	sub    $0xc,%esp
80100c80:	68 34 66 10 80       	push   $0x80106634
80100c85:	e8 b7 f6 ff ff       	call   80100341 <panic>

80100c8a <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100c8a:	55                   	push   %ebp
80100c8b:	89 e5                	mov    %esp,%ebp
80100c8d:	57                   	push   %edi
80100c8e:	56                   	push   %esi
80100c8f:	53                   	push   %ebx
80100c90:	83 ec 38             	sub    $0x38,%esp
80100c93:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100c96:	68 60 df 10 80       	push   $0x8010df60
80100c9b:	e8 1b 2e 00 00       	call   80103abb <acquire>
  if(f->ref < 1)
80100ca0:	8b 43 04             	mov    0x4(%ebx),%eax
80100ca3:	83 c4 10             	add    $0x10,%esp
80100ca6:	85 c0                	test   %eax,%eax
80100ca8:	7e 58                	jle    80100d02 <fileclose+0x78>
    panic("fileclose");
  if(--f->ref > 0){
80100caa:	48                   	dec    %eax
80100cab:	89 43 04             	mov    %eax,0x4(%ebx)
80100cae:	85 c0                	test   %eax,%eax
80100cb0:	7f 5d                	jg     80100d0f <fileclose+0x85>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100cb2:	8d 7d d0             	lea    -0x30(%ebp),%edi
80100cb5:	b9 06 00 00 00       	mov    $0x6,%ecx
80100cba:	89 de                	mov    %ebx,%esi
80100cbc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  f->ref = 0;
80100cbe:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
80100cc5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
80100ccb:	83 ec 0c             	sub    $0xc,%esp
80100cce:	68 60 df 10 80       	push   $0x8010df60
80100cd3:	e8 48 2e 00 00       	call   80103b20 <release>

  if(ff.type == FD_PIPE)
80100cd8:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100cdb:	83 c4 10             	add    $0x10,%esp
80100cde:	83 f8 01             	cmp    $0x1,%eax
80100ce1:	74 44                	je     80100d27 <fileclose+0x9d>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ce3:	83 f8 02             	cmp    $0x2,%eax
80100ce6:	75 37                	jne    80100d1f <fileclose+0x95>
    begin_op();
80100ce8:	e8 ef 19 00 00       	call   801026dc <begin_op>
    iput(ff.ip);
80100ced:	83 ec 0c             	sub    $0xc,%esp
80100cf0:	ff 75 e0             	push   -0x20(%ebp)
80100cf3:	e8 13 09 00 00       	call   8010160b <iput>
    end_op();
80100cf8:	e8 5b 1a 00 00       	call   80102758 <end_op>
80100cfd:	83 c4 10             	add    $0x10,%esp
80100d00:	eb 1d                	jmp    80100d1f <fileclose+0x95>
    panic("fileclose");
80100d02:	83 ec 0c             	sub    $0xc,%esp
80100d05:	68 3c 66 10 80       	push   $0x8010663c
80100d0a:	e8 32 f6 ff ff       	call   80100341 <panic>
    release(&ftable.lock);
80100d0f:	83 ec 0c             	sub    $0xc,%esp
80100d12:	68 60 df 10 80       	push   $0x8010df60
80100d17:	e8 04 2e 00 00       	call   80103b20 <release>
    return;
80100d1c:	83 c4 10             	add    $0x10,%esp
  }
}
80100d1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d22:	5b                   	pop    %ebx
80100d23:	5e                   	pop    %esi
80100d24:	5f                   	pop    %edi
80100d25:	5d                   	pop    %ebp
80100d26:	c3                   	ret    
    pipeclose(ff.pipe, ff.writable);
80100d27:	83 ec 08             	sub    $0x8,%esp
80100d2a:	0f be 45 d9          	movsbl -0x27(%ebp),%eax
80100d2e:	50                   	push   %eax
80100d2f:	ff 75 dc             	push   -0x24(%ebp)
80100d32:	e8 06 20 00 00       	call   80102d3d <pipeclose>
80100d37:	83 c4 10             	add    $0x10,%esp
80100d3a:	eb e3                	jmp    80100d1f <fileclose+0x95>

80100d3c <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100d3c:	55                   	push   %ebp
80100d3d:	89 e5                	mov    %esp,%ebp
80100d3f:	53                   	push   %ebx
80100d40:	83 ec 04             	sub    $0x4,%esp
80100d43:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100d46:	83 3b 02             	cmpl   $0x2,(%ebx)
80100d49:	75 31                	jne    80100d7c <filestat+0x40>
    ilock(f->ip);
80100d4b:	83 ec 0c             	sub    $0xc,%esp
80100d4e:	ff 73 10             	push   0x10(%ebx)
80100d51:	e8 b0 07 00 00       	call   80101506 <ilock>
    stati(f->ip, st);
80100d56:	83 c4 08             	add    $0x8,%esp
80100d59:	ff 75 0c             	push   0xc(%ebp)
80100d5c:	ff 73 10             	push   0x10(%ebx)
80100d5f:	e8 65 09 00 00       	call   801016c9 <stati>
    iunlock(f->ip);
80100d64:	83 c4 04             	add    $0x4,%esp
80100d67:	ff 73 10             	push   0x10(%ebx)
80100d6a:	e8 57 08 00 00       	call   801015c6 <iunlock>
    return 0;
80100d6f:	83 c4 10             	add    $0x10,%esp
80100d72:	b8 00 00 00 00       	mov    $0x0,%eax
  }
  return -1;
}
80100d77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d7a:	c9                   	leave  
80100d7b:	c3                   	ret    
  return -1;
80100d7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d81:	eb f4                	jmp    80100d77 <filestat+0x3b>

80100d83 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100d83:	55                   	push   %ebp
80100d84:	89 e5                	mov    %esp,%ebp
80100d86:	56                   	push   %esi
80100d87:	53                   	push   %ebx
80100d88:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;

  if(f->readable == 0)
80100d8b:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100d8f:	74 70                	je     80100e01 <fileread+0x7e>
    return -1;
  if(f->type == FD_PIPE)
80100d91:	8b 03                	mov    (%ebx),%eax
80100d93:	83 f8 01             	cmp    $0x1,%eax
80100d96:	74 44                	je     80100ddc <fileread+0x59>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100d98:	83 f8 02             	cmp    $0x2,%eax
80100d9b:	75 57                	jne    80100df4 <fileread+0x71>
    ilock(f->ip);
80100d9d:	83 ec 0c             	sub    $0xc,%esp
80100da0:	ff 73 10             	push   0x10(%ebx)
80100da3:	e8 5e 07 00 00       	call   80101506 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100da8:	ff 75 10             	push   0x10(%ebp)
80100dab:	ff 73 14             	push   0x14(%ebx)
80100dae:	ff 75 0c             	push   0xc(%ebp)
80100db1:	ff 73 10             	push   0x10(%ebx)
80100db4:	e8 3a 09 00 00       	call   801016f3 <readi>
80100db9:	89 c6                	mov    %eax,%esi
80100dbb:	83 c4 20             	add    $0x20,%esp
80100dbe:	85 c0                	test   %eax,%eax
80100dc0:	7e 03                	jle    80100dc5 <fileread+0x42>
      f->off += r;
80100dc2:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100dc5:	83 ec 0c             	sub    $0xc,%esp
80100dc8:	ff 73 10             	push   0x10(%ebx)
80100dcb:	e8 f6 07 00 00       	call   801015c6 <iunlock>
    return r;
80100dd0:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100dd3:	89 f0                	mov    %esi,%eax
80100dd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100dd8:	5b                   	pop    %ebx
80100dd9:	5e                   	pop    %esi
80100dda:	5d                   	pop    %ebp
80100ddb:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100ddc:	83 ec 04             	sub    $0x4,%esp
80100ddf:	ff 75 10             	push   0x10(%ebp)
80100de2:	ff 75 0c             	push   0xc(%ebp)
80100de5:	ff 73 0c             	push   0xc(%ebx)
80100de8:	e8 9e 20 00 00       	call   80102e8b <piperead>
80100ded:	89 c6                	mov    %eax,%esi
80100def:	83 c4 10             	add    $0x10,%esp
80100df2:	eb df                	jmp    80100dd3 <fileread+0x50>
  panic("fileread");
80100df4:	83 ec 0c             	sub    $0xc,%esp
80100df7:	68 46 66 10 80       	push   $0x80106646
80100dfc:	e8 40 f5 ff ff       	call   80100341 <panic>
    return -1;
80100e01:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100e06:	eb cb                	jmp    80100dd3 <fileread+0x50>

80100e08 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100e08:	55                   	push   %ebp
80100e09:	89 e5                	mov    %esp,%ebp
80100e0b:	57                   	push   %edi
80100e0c:	56                   	push   %esi
80100e0d:	53                   	push   %ebx
80100e0e:	83 ec 1c             	sub    $0x1c,%esp
80100e11:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;

  if(f->writable == 0)
80100e14:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
80100e18:	0f 84 cc 00 00 00    	je     80100eea <filewrite+0xe2>
    return -1;
  if(f->type == FD_PIPE)
80100e1e:	8b 06                	mov    (%esi),%eax
80100e20:	83 f8 01             	cmp    $0x1,%eax
80100e23:	74 10                	je     80100e35 <filewrite+0x2d>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100e25:	83 f8 02             	cmp    $0x2,%eax
80100e28:	0f 85 af 00 00 00    	jne    80100edd <filewrite+0xd5>
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
80100e2e:	bf 00 00 00 00       	mov    $0x0,%edi
80100e33:	eb 67                	jmp    80100e9c <filewrite+0x94>
    return pipewrite(f->pipe, addr, n);
80100e35:	83 ec 04             	sub    $0x4,%esp
80100e38:	ff 75 10             	push   0x10(%ebp)
80100e3b:	ff 75 0c             	push   0xc(%ebp)
80100e3e:	ff 76 0c             	push   0xc(%esi)
80100e41:	e8 83 1f 00 00       	call   80102dc9 <pipewrite>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	e9 82 00 00 00       	jmp    80100ed0 <filewrite+0xc8>
    while(i < n){
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
80100e4e:	e8 89 18 00 00       	call   801026dc <begin_op>
      ilock(f->ip);
80100e53:	83 ec 0c             	sub    $0xc,%esp
80100e56:	ff 76 10             	push   0x10(%esi)
80100e59:	e8 a8 06 00 00       	call   80101506 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100e5e:	ff 75 e4             	push   -0x1c(%ebp)
80100e61:	ff 76 14             	push   0x14(%esi)
80100e64:	89 f8                	mov    %edi,%eax
80100e66:	03 45 0c             	add    0xc(%ebp),%eax
80100e69:	50                   	push   %eax
80100e6a:	ff 76 10             	push   0x10(%esi)
80100e6d:	e8 81 09 00 00       	call   801017f3 <writei>
80100e72:	89 c3                	mov    %eax,%ebx
80100e74:	83 c4 20             	add    $0x20,%esp
80100e77:	85 c0                	test   %eax,%eax
80100e79:	7e 03                	jle    80100e7e <filewrite+0x76>
        f->off += r;
80100e7b:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80100e7e:	83 ec 0c             	sub    $0xc,%esp
80100e81:	ff 76 10             	push   0x10(%esi)
80100e84:	e8 3d 07 00 00       	call   801015c6 <iunlock>
      end_op();
80100e89:	e8 ca 18 00 00       	call   80102758 <end_op>

      if(r < 0)
80100e8e:	83 c4 10             	add    $0x10,%esp
80100e91:	85 db                	test   %ebx,%ebx
80100e93:	78 31                	js     80100ec6 <filewrite+0xbe>
        break;
      if(r != n1)
80100e95:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80100e98:	75 1f                	jne    80100eb9 <filewrite+0xb1>
        panic("short filewrite");
      i += r;
80100e9a:	01 df                	add    %ebx,%edi
    while(i < n){
80100e9c:	3b 7d 10             	cmp    0x10(%ebp),%edi
80100e9f:	7d 25                	jge    80100ec6 <filewrite+0xbe>
      int n1 = n - i;
80100ea1:	8b 45 10             	mov    0x10(%ebp),%eax
80100ea4:	29 f8                	sub    %edi,%eax
80100ea6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(n1 > max)
80100ea9:	3d 00 06 00 00       	cmp    $0x600,%eax
80100eae:	7e 9e                	jle    80100e4e <filewrite+0x46>
        n1 = max;
80100eb0:	c7 45 e4 00 06 00 00 	movl   $0x600,-0x1c(%ebp)
80100eb7:	eb 95                	jmp    80100e4e <filewrite+0x46>
        panic("short filewrite");
80100eb9:	83 ec 0c             	sub    $0xc,%esp
80100ebc:	68 4f 66 10 80       	push   $0x8010664f
80100ec1:	e8 7b f4 ff ff       	call   80100341 <panic>
    }
    return i == n ? n : -1;
80100ec6:	3b 7d 10             	cmp    0x10(%ebp),%edi
80100ec9:	74 0d                	je     80100ed8 <filewrite+0xd0>
80100ecb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80100ed0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ed3:	5b                   	pop    %ebx
80100ed4:	5e                   	pop    %esi
80100ed5:	5f                   	pop    %edi
80100ed6:	5d                   	pop    %ebp
80100ed7:	c3                   	ret    
    return i == n ? n : -1;
80100ed8:	8b 45 10             	mov    0x10(%ebp),%eax
80100edb:	eb f3                	jmp    80100ed0 <filewrite+0xc8>
  panic("filewrite");
80100edd:	83 ec 0c             	sub    $0xc,%esp
80100ee0:	68 55 66 10 80       	push   $0x80106655
80100ee5:	e8 57 f4 ff ff       	call   80100341 <panic>
    return -1;
80100eea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100eef:	eb df                	jmp    80100ed0 <filewrite+0xc8>

80100ef1 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80100ef1:	55                   	push   %ebp
80100ef2:	89 e5                	mov    %esp,%ebp
80100ef4:	57                   	push   %edi
80100ef5:	56                   	push   %esi
80100ef6:	53                   	push   %ebx
80100ef7:	83 ec 0c             	sub    $0xc,%esp
80100efa:	89 d6                	mov    %edx,%esi
  char *s;
  int len;

  while(*path == '/')
80100efc:	eb 01                	jmp    80100eff <skipelem+0xe>
    path++;
80100efe:	40                   	inc    %eax
  while(*path == '/')
80100eff:	8a 10                	mov    (%eax),%dl
80100f01:	80 fa 2f             	cmp    $0x2f,%dl
80100f04:	74 f8                	je     80100efe <skipelem+0xd>
  if(*path == 0)
80100f06:	84 d2                	test   %dl,%dl
80100f08:	74 4e                	je     80100f58 <skipelem+0x67>
80100f0a:	89 c3                	mov    %eax,%ebx
80100f0c:	eb 01                	jmp    80100f0f <skipelem+0x1e>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80100f0e:	43                   	inc    %ebx
  while(*path != '/' && *path != 0)
80100f0f:	8a 13                	mov    (%ebx),%dl
80100f11:	80 fa 2f             	cmp    $0x2f,%dl
80100f14:	74 04                	je     80100f1a <skipelem+0x29>
80100f16:	84 d2                	test   %dl,%dl
80100f18:	75 f4                	jne    80100f0e <skipelem+0x1d>
  len = path - s;
80100f1a:	89 df                	mov    %ebx,%edi
80100f1c:	29 c7                	sub    %eax,%edi
  if(len >= DIRSIZ)
80100f1e:	83 ff 0d             	cmp    $0xd,%edi
80100f21:	7e 11                	jle    80100f34 <skipelem+0x43>
    memmove(name, s, DIRSIZ);
80100f23:	83 ec 04             	sub    $0x4,%esp
80100f26:	6a 0e                	push   $0xe
80100f28:	50                   	push   %eax
80100f29:	56                   	push   %esi
80100f2a:	e8 ae 2c 00 00       	call   80103bdd <memmove>
80100f2f:	83 c4 10             	add    $0x10,%esp
80100f32:	eb 15                	jmp    80100f49 <skipelem+0x58>
  else {
    memmove(name, s, len);
80100f34:	83 ec 04             	sub    $0x4,%esp
80100f37:	57                   	push   %edi
80100f38:	50                   	push   %eax
80100f39:	56                   	push   %esi
80100f3a:	e8 9e 2c 00 00       	call   80103bdd <memmove>
    name[len] = 0;
80100f3f:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
80100f43:	83 c4 10             	add    $0x10,%esp
80100f46:	eb 01                	jmp    80100f49 <skipelem+0x58>
  }
  while(*path == '/')
    path++;
80100f48:	43                   	inc    %ebx
  while(*path == '/')
80100f49:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80100f4c:	74 fa                	je     80100f48 <skipelem+0x57>
  return path;
}
80100f4e:	89 d8                	mov    %ebx,%eax
80100f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f53:	5b                   	pop    %ebx
80100f54:	5e                   	pop    %esi
80100f55:	5f                   	pop    %edi
80100f56:	5d                   	pop    %ebp
80100f57:	c3                   	ret    
    return 0;
80100f58:	bb 00 00 00 00       	mov    $0x0,%ebx
80100f5d:	eb ef                	jmp    80100f4e <skipelem+0x5d>

80100f5f <bzero>:
{
80100f5f:	55                   	push   %ebp
80100f60:	89 e5                	mov    %esp,%ebp
80100f62:	53                   	push   %ebx
80100f63:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, bno);
80100f66:	52                   	push   %edx
80100f67:	50                   	push   %eax
80100f68:	e8 fd f1 ff ff       	call   8010016a <bread>
80100f6d:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80100f6f:	8d 40 5c             	lea    0x5c(%eax),%eax
80100f72:	83 c4 0c             	add    $0xc,%esp
80100f75:	68 00 02 00 00       	push   $0x200
80100f7a:	6a 00                	push   $0x0
80100f7c:	50                   	push   %eax
80100f7d:	e8 e5 2b 00 00       	call   80103b67 <memset>
  log_write(bp);
80100f82:	89 1c 24             	mov    %ebx,(%esp)
80100f85:	e8 7b 18 00 00       	call   80102805 <log_write>
  brelse(bp);
80100f8a:	89 1c 24             	mov    %ebx,(%esp)
80100f8d:	e8 41 f2 ff ff       	call   801001d3 <brelse>
}
80100f92:	83 c4 10             	add    $0x10,%esp
80100f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f98:	c9                   	leave  
80100f99:	c3                   	ret    

80100f9a <balloc>:
{
80100f9a:	55                   	push   %ebp
80100f9b:	89 e5                	mov    %esp,%ebp
80100f9d:	57                   	push   %edi
80100f9e:	56                   	push   %esi
80100f9f:	53                   	push   %ebx
80100fa0:	83 ec 1c             	sub    $0x1c,%esp
80100fa3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80100fa6:	be 00 00 00 00       	mov    $0x0,%esi
80100fab:	eb 5b                	jmp    80101008 <balloc+0x6e>
    bp = bread(dev, BBLOCK(b, sb));
80100fad:	8d 86 ff 0f 00 00    	lea    0xfff(%esi),%eax
80100fb3:	eb 61                	jmp    80101016 <balloc+0x7c>
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80100fb5:	c1 fa 03             	sar    $0x3,%edx
80100fb8:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100fbb:	8a 4c 17 5c          	mov    0x5c(%edi,%edx,1),%cl
80100fbf:	0f b6 f9             	movzbl %cl,%edi
80100fc2:	85 7d e4             	test   %edi,-0x1c(%ebp)
80100fc5:	74 7e                	je     80101045 <balloc+0xab>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80100fc7:	40                   	inc    %eax
80100fc8:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80100fcd:	7f 25                	jg     80100ff4 <balloc+0x5a>
80100fcf:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80100fd2:	3b 1d b4 05 11 80    	cmp    0x801105b4,%ebx
80100fd8:	73 1a                	jae    80100ff4 <balloc+0x5a>
      m = 1 << (bi % 8);
80100fda:	89 c1                	mov    %eax,%ecx
80100fdc:	83 e1 07             	and    $0x7,%ecx
80100fdf:	ba 01 00 00 00       	mov    $0x1,%edx
80100fe4:	d3 e2                	shl    %cl,%edx
80100fe6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80100fe9:	89 c2                	mov    %eax,%edx
80100feb:	85 c0                	test   %eax,%eax
80100fed:	79 c6                	jns    80100fb5 <balloc+0x1b>
80100fef:	8d 50 07             	lea    0x7(%eax),%edx
80100ff2:	eb c1                	jmp    80100fb5 <balloc+0x1b>
    brelse(bp);
80100ff4:	83 ec 0c             	sub    $0xc,%esp
80100ff7:	ff 75 e0             	push   -0x20(%ebp)
80100ffa:	e8 d4 f1 ff ff       	call   801001d3 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80100fff:	81 c6 00 10 00 00    	add    $0x1000,%esi
80101005:	83 c4 10             	add    $0x10,%esp
80101008:	39 35 b4 05 11 80    	cmp    %esi,0x801105b4
8010100e:	76 28                	jbe    80101038 <balloc+0x9e>
    bp = bread(dev, BBLOCK(b, sb));
80101010:	89 f0                	mov    %esi,%eax
80101012:	85 f6                	test   %esi,%esi
80101014:	78 97                	js     80100fad <balloc+0x13>
80101016:	c1 f8 0c             	sar    $0xc,%eax
80101019:	83 ec 08             	sub    $0x8,%esp
8010101c:	03 05 cc 05 11 80    	add    0x801105cc,%eax
80101022:	50                   	push   %eax
80101023:	ff 75 dc             	push   -0x24(%ebp)
80101026:	e8 3f f1 ff ff       	call   8010016a <bread>
8010102b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010102e:	83 c4 10             	add    $0x10,%esp
80101031:	b8 00 00 00 00       	mov    $0x0,%eax
80101036:	eb 90                	jmp    80100fc8 <balloc+0x2e>
  panic("balloc: out of blocks");
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	68 5f 66 10 80       	push   $0x8010665f
80101040:	e8 fc f2 ff ff       	call   80100341 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
80101045:	0b 4d e4             	or     -0x1c(%ebp),%ecx
80101048:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010104b:	88 4c 16 5c          	mov    %cl,0x5c(%esi,%edx,1)
        log_write(bp);
8010104f:	83 ec 0c             	sub    $0xc,%esp
80101052:	56                   	push   %esi
80101053:	e8 ad 17 00 00       	call   80102805 <log_write>
        brelse(bp);
80101058:	89 34 24             	mov    %esi,(%esp)
8010105b:	e8 73 f1 ff ff       	call   801001d3 <brelse>
        bzero(dev, b + bi);
80101060:	89 da                	mov    %ebx,%edx
80101062:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101065:	e8 f5 fe ff ff       	call   80100f5f <bzero>
}
8010106a:	89 d8                	mov    %ebx,%eax
8010106c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010106f:	5b                   	pop    %ebx
80101070:	5e                   	pop    %esi
80101071:	5f                   	pop    %edi
80101072:	5d                   	pop    %ebp
80101073:	c3                   	ret    

80101074 <bmap>:
{
80101074:	55                   	push   %ebp
80101075:	89 e5                	mov    %esp,%ebp
80101077:	57                   	push   %edi
80101078:	56                   	push   %esi
80101079:	53                   	push   %ebx
8010107a:	83 ec 1c             	sub    $0x1c,%esp
8010107d:	89 c3                	mov    %eax,%ebx
8010107f:	89 d7                	mov    %edx,%edi
  if(bn < NDIRECT){
80101081:	83 fa 0b             	cmp    $0xb,%edx
80101084:	76 45                	jbe    801010cb <bmap+0x57>
  bn -= NDIRECT;
80101086:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
80101089:	83 fe 7f             	cmp    $0x7f,%esi
8010108c:	77 7f                	ja     8010110d <bmap+0x99>
    if((addr = ip->addrs[NDIRECT]) == 0)
8010108e:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101094:	85 c0                	test   %eax,%eax
80101096:	74 4a                	je     801010e2 <bmap+0x6e>
    bp = bread(ip->dev, addr);
80101098:	83 ec 08             	sub    $0x8,%esp
8010109b:	50                   	push   %eax
8010109c:	ff 33                	push   (%ebx)
8010109e:	e8 c7 f0 ff ff       	call   8010016a <bread>
801010a3:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801010a5:	8d 44 b0 5c          	lea    0x5c(%eax,%esi,4),%eax
801010a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801010ac:	8b 30                	mov    (%eax),%esi
801010ae:	83 c4 10             	add    $0x10,%esp
801010b1:	85 f6                	test   %esi,%esi
801010b3:	74 3c                	je     801010f1 <bmap+0x7d>
    brelse(bp);
801010b5:	83 ec 0c             	sub    $0xc,%esp
801010b8:	57                   	push   %edi
801010b9:	e8 15 f1 ff ff       	call   801001d3 <brelse>
    return addr;
801010be:	83 c4 10             	add    $0x10,%esp
}
801010c1:	89 f0                	mov    %esi,%eax
801010c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
    if((addr = ip->addrs[bn]) == 0)
801010cb:	8b 74 90 5c          	mov    0x5c(%eax,%edx,4),%esi
801010cf:	85 f6                	test   %esi,%esi
801010d1:	75 ee                	jne    801010c1 <bmap+0x4d>
      ip->addrs[bn] = addr = balloc(ip->dev);
801010d3:	8b 00                	mov    (%eax),%eax
801010d5:	e8 c0 fe ff ff       	call   80100f9a <balloc>
801010da:	89 c6                	mov    %eax,%esi
801010dc:	89 44 bb 5c          	mov    %eax,0x5c(%ebx,%edi,4)
    return addr;
801010e0:	eb df                	jmp    801010c1 <bmap+0x4d>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801010e2:	8b 03                	mov    (%ebx),%eax
801010e4:	e8 b1 fe ff ff       	call   80100f9a <balloc>
801010e9:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801010ef:	eb a7                	jmp    80101098 <bmap+0x24>
      a[bn] = addr = balloc(ip->dev);
801010f1:	8b 03                	mov    (%ebx),%eax
801010f3:	e8 a2 fe ff ff       	call   80100f9a <balloc>
801010f8:	89 c6                	mov    %eax,%esi
801010fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010fd:	89 30                	mov    %esi,(%eax)
      log_write(bp);
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	57                   	push   %edi
80101103:	e8 fd 16 00 00       	call   80102805 <log_write>
80101108:	83 c4 10             	add    $0x10,%esp
8010110b:	eb a8                	jmp    801010b5 <bmap+0x41>
  panic("bmap: out of range");
8010110d:	83 ec 0c             	sub    $0xc,%esp
80101110:	68 75 66 10 80       	push   $0x80106675
80101115:	e8 27 f2 ff ff       	call   80100341 <panic>

8010111a <iget>:
{
8010111a:	55                   	push   %ebp
8010111b:	89 e5                	mov    %esp,%ebp
8010111d:	57                   	push   %edi
8010111e:	56                   	push   %esi
8010111f:	53                   	push   %ebx
80101120:	83 ec 28             	sub    $0x28,%esp
80101123:	89 c7                	mov    %eax,%edi
80101125:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101128:	68 60 e9 10 80       	push   $0x8010e960
8010112d:	e8 89 29 00 00       	call   80103abb <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101132:	83 c4 10             	add    $0x10,%esp
  empty = 0;
80101135:	be 00 00 00 00       	mov    $0x0,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010113a:	bb 94 e9 10 80       	mov    $0x8010e994,%ebx
8010113f:	eb 0a                	jmp    8010114b <iget+0x31>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101141:	85 f6                	test   %esi,%esi
80101143:	74 39                	je     8010117e <iget+0x64>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101145:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010114b:	81 fb b4 05 11 80    	cmp    $0x801105b4,%ebx
80101151:	73 33                	jae    80101186 <iget+0x6c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101153:	8b 43 08             	mov    0x8(%ebx),%eax
80101156:	85 c0                	test   %eax,%eax
80101158:	7e e7                	jle    80101141 <iget+0x27>
8010115a:	39 3b                	cmp    %edi,(%ebx)
8010115c:	75 e3                	jne    80101141 <iget+0x27>
8010115e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101161:	39 4b 04             	cmp    %ecx,0x4(%ebx)
80101164:	75 db                	jne    80101141 <iget+0x27>
      ip->ref++;
80101166:	40                   	inc    %eax
80101167:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
8010116a:	83 ec 0c             	sub    $0xc,%esp
8010116d:	68 60 e9 10 80       	push   $0x8010e960
80101172:	e8 a9 29 00 00       	call   80103b20 <release>
      return ip;
80101177:	83 c4 10             	add    $0x10,%esp
8010117a:	89 de                	mov    %ebx,%esi
8010117c:	eb 32                	jmp    801011b0 <iget+0x96>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010117e:	85 c0                	test   %eax,%eax
80101180:	75 c3                	jne    80101145 <iget+0x2b>
      empty = ip;
80101182:	89 de                	mov    %ebx,%esi
80101184:	eb bf                	jmp    80101145 <iget+0x2b>
  if(empty == 0)
80101186:	85 f6                	test   %esi,%esi
80101188:	74 30                	je     801011ba <iget+0xa0>
  ip->dev = dev;
8010118a:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
8010118c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010118f:	89 46 04             	mov    %eax,0x4(%esi)
  ip->ref = 1;
80101192:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101199:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801011a0:	83 ec 0c             	sub    $0xc,%esp
801011a3:	68 60 e9 10 80       	push   $0x8010e960
801011a8:	e8 73 29 00 00       	call   80103b20 <release>
  return ip;
801011ad:	83 c4 10             	add    $0x10,%esp
}
801011b0:	89 f0                	mov    %esi,%eax
801011b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b5:	5b                   	pop    %ebx
801011b6:	5e                   	pop    %esi
801011b7:	5f                   	pop    %edi
801011b8:	5d                   	pop    %ebp
801011b9:	c3                   	ret    
    panic("iget: no inodes");
801011ba:	83 ec 0c             	sub    $0xc,%esp
801011bd:	68 88 66 10 80       	push   $0x80106688
801011c2:	e8 7a f1 ff ff       	call   80100341 <panic>

801011c7 <readsb>:
{
801011c7:	55                   	push   %ebp
801011c8:	89 e5                	mov    %esp,%ebp
801011ca:	53                   	push   %ebx
801011cb:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, 1);
801011ce:	6a 01                	push   $0x1
801011d0:	ff 75 08             	push   0x8(%ebp)
801011d3:	e8 92 ef ff ff       	call   8010016a <bread>
801011d8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801011da:	8d 40 5c             	lea    0x5c(%eax),%eax
801011dd:	83 c4 0c             	add    $0xc,%esp
801011e0:	6a 1c                	push   $0x1c
801011e2:	50                   	push   %eax
801011e3:	ff 75 0c             	push   0xc(%ebp)
801011e6:	e8 f2 29 00 00       	call   80103bdd <memmove>
  brelse(bp);
801011eb:	89 1c 24             	mov    %ebx,(%esp)
801011ee:	e8 e0 ef ff ff       	call   801001d3 <brelse>
}
801011f3:	83 c4 10             	add    $0x10,%esp
801011f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011f9:	c9                   	leave  
801011fa:	c3                   	ret    

801011fb <bfree>:
{
801011fb:	55                   	push   %ebp
801011fc:	89 e5                	mov    %esp,%ebp
801011fe:	56                   	push   %esi
801011ff:	53                   	push   %ebx
80101200:	89 c3                	mov    %eax,%ebx
80101202:	89 d6                	mov    %edx,%esi
  readsb(dev, &sb);
80101204:	83 ec 08             	sub    $0x8,%esp
80101207:	68 b4 05 11 80       	push   $0x801105b4
8010120c:	50                   	push   %eax
8010120d:	e8 b5 ff ff ff       	call   801011c7 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101212:	89 f0                	mov    %esi,%eax
80101214:	c1 e8 0c             	shr    $0xc,%eax
80101217:	83 c4 08             	add    $0x8,%esp
8010121a:	03 05 cc 05 11 80    	add    0x801105cc,%eax
80101220:	50                   	push   %eax
80101221:	53                   	push   %ebx
80101222:	e8 43 ef ff ff       	call   8010016a <bread>
80101227:	89 c3                	mov    %eax,%ebx
  bi = b % BPB;
80101229:	89 f2                	mov    %esi,%edx
8010122b:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
80101231:	89 f1                	mov    %esi,%ecx
80101233:	83 e1 07             	and    $0x7,%ecx
80101236:	b8 01 00 00 00       	mov    $0x1,%eax
8010123b:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
8010123d:	83 c4 10             	add    $0x10,%esp
80101240:	c1 fa 03             	sar    $0x3,%edx
80101243:	8a 4c 13 5c          	mov    0x5c(%ebx,%edx,1),%cl
80101247:	0f b6 f1             	movzbl %cl,%esi
8010124a:	85 c6                	test   %eax,%esi
8010124c:	74 23                	je     80101271 <bfree+0x76>
  bp->data[bi/8] &= ~m;
8010124e:	f7 d0                	not    %eax
80101250:	21 c8                	and    %ecx,%eax
80101252:	88 44 13 5c          	mov    %al,0x5c(%ebx,%edx,1)
  log_write(bp);
80101256:	83 ec 0c             	sub    $0xc,%esp
80101259:	53                   	push   %ebx
8010125a:	e8 a6 15 00 00       	call   80102805 <log_write>
  brelse(bp);
8010125f:	89 1c 24             	mov    %ebx,(%esp)
80101262:	e8 6c ef ff ff       	call   801001d3 <brelse>
}
80101267:	83 c4 10             	add    $0x10,%esp
8010126a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010126d:	5b                   	pop    %ebx
8010126e:	5e                   	pop    %esi
8010126f:	5d                   	pop    %ebp
80101270:	c3                   	ret    
    panic("freeing free block");
80101271:	83 ec 0c             	sub    $0xc,%esp
80101274:	68 98 66 10 80       	push   $0x80106698
80101279:	e8 c3 f0 ff ff       	call   80100341 <panic>

8010127e <iinit>:
{
8010127e:	55                   	push   %ebp
8010127f:	89 e5                	mov    %esp,%ebp
80101281:	53                   	push   %ebx
80101282:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101285:	68 ab 66 10 80       	push   $0x801066ab
8010128a:	68 60 e9 10 80       	push   $0x8010e960
8010128f:	e8 f0 26 00 00       	call   80103984 <initlock>
  for(i = 0; i < NINODE; i++) {
80101294:	83 c4 10             	add    $0x10,%esp
80101297:	bb 00 00 00 00       	mov    $0x0,%ebx
8010129c:	eb 1f                	jmp    801012bd <iinit+0x3f>
    initsleeplock(&icache.inode[i].lock, "inode");
8010129e:	83 ec 08             	sub    $0x8,%esp
801012a1:	68 b2 66 10 80       	push   $0x801066b2
801012a6:	8d 14 db             	lea    (%ebx,%ebx,8),%edx
801012a9:	89 d0                	mov    %edx,%eax
801012ab:	c1 e0 04             	shl    $0x4,%eax
801012ae:	05 a0 e9 10 80       	add    $0x8010e9a0,%eax
801012b3:	50                   	push   %eax
801012b4:	e8 c0 25 00 00       	call   80103879 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801012b9:	43                   	inc    %ebx
801012ba:	83 c4 10             	add    $0x10,%esp
801012bd:	83 fb 31             	cmp    $0x31,%ebx
801012c0:	7e dc                	jle    8010129e <iinit+0x20>
  readsb(dev, &sb);
801012c2:	83 ec 08             	sub    $0x8,%esp
801012c5:	68 b4 05 11 80       	push   $0x801105b4
801012ca:	ff 75 08             	push   0x8(%ebp)
801012cd:	e8 f5 fe ff ff       	call   801011c7 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801012d2:	ff 35 cc 05 11 80    	push   0x801105cc
801012d8:	ff 35 c8 05 11 80    	push   0x801105c8
801012de:	ff 35 c4 05 11 80    	push   0x801105c4
801012e4:	ff 35 c0 05 11 80    	push   0x801105c0
801012ea:	ff 35 bc 05 11 80    	push   0x801105bc
801012f0:	ff 35 b8 05 11 80    	push   0x801105b8
801012f6:	ff 35 b4 05 11 80    	push   0x801105b4
801012fc:	68 18 67 10 80       	push   $0x80106718
80101301:	e8 d4 f2 ff ff       	call   801005da <cprintf>
}
80101306:	83 c4 30             	add    $0x30,%esp
80101309:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010130c:	c9                   	leave  
8010130d:	c3                   	ret    

8010130e <ialloc>:
{
8010130e:	55                   	push   %ebp
8010130f:	89 e5                	mov    %esp,%ebp
80101311:	57                   	push   %edi
80101312:	56                   	push   %esi
80101313:	53                   	push   %ebx
80101314:	83 ec 1c             	sub    $0x1c,%esp
80101317:	8b 45 0c             	mov    0xc(%ebp),%eax
8010131a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010131d:	bb 01 00 00 00       	mov    $0x1,%ebx
80101322:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101325:	39 1d bc 05 11 80    	cmp    %ebx,0x801105bc
8010132b:	76 3d                	jbe    8010136a <ialloc+0x5c>
    bp = bread(dev, IBLOCK(inum, sb));
8010132d:	89 d8                	mov    %ebx,%eax
8010132f:	c1 e8 03             	shr    $0x3,%eax
80101332:	83 ec 08             	sub    $0x8,%esp
80101335:	03 05 c8 05 11 80    	add    0x801105c8,%eax
8010133b:	50                   	push   %eax
8010133c:	ff 75 08             	push   0x8(%ebp)
8010133f:	e8 26 ee ff ff       	call   8010016a <bread>
80101344:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
80101346:	89 d8                	mov    %ebx,%eax
80101348:	83 e0 07             	and    $0x7,%eax
8010134b:	c1 e0 06             	shl    $0x6,%eax
8010134e:	8d 7c 06 5c          	lea    0x5c(%esi,%eax,1),%edi
    if(dip->type == 0){  // a free inode
80101352:	83 c4 10             	add    $0x10,%esp
80101355:	66 83 3f 00          	cmpw   $0x0,(%edi)
80101359:	74 1c                	je     80101377 <ialloc+0x69>
    brelse(bp);
8010135b:	83 ec 0c             	sub    $0xc,%esp
8010135e:	56                   	push   %esi
8010135f:	e8 6f ee ff ff       	call   801001d3 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101364:	43                   	inc    %ebx
80101365:	83 c4 10             	add    $0x10,%esp
80101368:	eb b8                	jmp    80101322 <ialloc+0x14>
  panic("ialloc: no inodes");
8010136a:	83 ec 0c             	sub    $0xc,%esp
8010136d:	68 b8 66 10 80       	push   $0x801066b8
80101372:	e8 ca ef ff ff       	call   80100341 <panic>
      memset(dip, 0, sizeof(*dip));
80101377:	83 ec 04             	sub    $0x4,%esp
8010137a:	6a 40                	push   $0x40
8010137c:	6a 00                	push   $0x0
8010137e:	57                   	push   %edi
8010137f:	e8 e3 27 00 00       	call   80103b67 <memset>
      dip->type = type;
80101384:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101387:	66 89 07             	mov    %ax,(%edi)
      log_write(bp);   // mark it allocated on the disk
8010138a:	89 34 24             	mov    %esi,(%esp)
8010138d:	e8 73 14 00 00       	call   80102805 <log_write>
      brelse(bp);
80101392:	89 34 24             	mov    %esi,(%esp)
80101395:	e8 39 ee ff ff       	call   801001d3 <brelse>
      return iget(dev, inum);
8010139a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010139d:	8b 45 08             	mov    0x8(%ebp),%eax
801013a0:	e8 75 fd ff ff       	call   8010111a <iget>
}
801013a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013a8:	5b                   	pop    %ebx
801013a9:	5e                   	pop    %esi
801013aa:	5f                   	pop    %edi
801013ab:	5d                   	pop    %ebp
801013ac:	c3                   	ret    

801013ad <iupdate>:
{
801013ad:	55                   	push   %ebp
801013ae:	89 e5                	mov    %esp,%ebp
801013b0:	56                   	push   %esi
801013b1:	53                   	push   %ebx
801013b2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801013b5:	8b 43 04             	mov    0x4(%ebx),%eax
801013b8:	c1 e8 03             	shr    $0x3,%eax
801013bb:	83 ec 08             	sub    $0x8,%esp
801013be:	03 05 c8 05 11 80    	add    0x801105c8,%eax
801013c4:	50                   	push   %eax
801013c5:	ff 33                	push   (%ebx)
801013c7:	e8 9e ed ff ff       	call   8010016a <bread>
801013cc:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801013ce:	8b 43 04             	mov    0x4(%ebx),%eax
801013d1:	83 e0 07             	and    $0x7,%eax
801013d4:	c1 e0 06             	shl    $0x6,%eax
801013d7:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801013db:	8b 53 50             	mov    0x50(%ebx),%edx
801013de:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801013e1:	66 8b 53 52          	mov    0x52(%ebx),%dx
801013e5:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801013e9:	8b 53 54             	mov    0x54(%ebx),%edx
801013ec:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801013f0:	66 8b 53 56          	mov    0x56(%ebx),%dx
801013f4:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801013f8:	8b 53 58             	mov    0x58(%ebx),%edx
801013fb:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801013fe:	83 c3 5c             	add    $0x5c,%ebx
80101401:	83 c0 0c             	add    $0xc,%eax
80101404:	83 c4 0c             	add    $0xc,%esp
80101407:	6a 34                	push   $0x34
80101409:	53                   	push   %ebx
8010140a:	50                   	push   %eax
8010140b:	e8 cd 27 00 00       	call   80103bdd <memmove>
  log_write(bp);
80101410:	89 34 24             	mov    %esi,(%esp)
80101413:	e8 ed 13 00 00       	call   80102805 <log_write>
  brelse(bp);
80101418:	89 34 24             	mov    %esi,(%esp)
8010141b:	e8 b3 ed ff ff       	call   801001d3 <brelse>
}
80101420:	83 c4 10             	add    $0x10,%esp
80101423:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101426:	5b                   	pop    %ebx
80101427:	5e                   	pop    %esi
80101428:	5d                   	pop    %ebp
80101429:	c3                   	ret    

8010142a <itrunc>:
{
8010142a:	55                   	push   %ebp
8010142b:	89 e5                	mov    %esp,%ebp
8010142d:	57                   	push   %edi
8010142e:	56                   	push   %esi
8010142f:	53                   	push   %ebx
80101430:	83 ec 1c             	sub    $0x1c,%esp
80101433:	89 c6                	mov    %eax,%esi
  for(i = 0; i < NDIRECT; i++){
80101435:	bb 00 00 00 00       	mov    $0x0,%ebx
8010143a:	eb 01                	jmp    8010143d <itrunc+0x13>
8010143c:	43                   	inc    %ebx
8010143d:	83 fb 0b             	cmp    $0xb,%ebx
80101440:	7f 19                	jg     8010145b <itrunc+0x31>
    if(ip->addrs[i]){
80101442:	8b 54 9e 5c          	mov    0x5c(%esi,%ebx,4),%edx
80101446:	85 d2                	test   %edx,%edx
80101448:	74 f2                	je     8010143c <itrunc+0x12>
      bfree(ip->dev, ip->addrs[i]);
8010144a:	8b 06                	mov    (%esi),%eax
8010144c:	e8 aa fd ff ff       	call   801011fb <bfree>
      ip->addrs[i] = 0;
80101451:	c7 44 9e 5c 00 00 00 	movl   $0x0,0x5c(%esi,%ebx,4)
80101458:	00 
80101459:	eb e1                	jmp    8010143c <itrunc+0x12>
  if(ip->addrs[NDIRECT]){
8010145b:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101461:	85 c0                	test   %eax,%eax
80101463:	75 1b                	jne    80101480 <itrunc+0x56>
  ip->size = 0;
80101465:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
8010146c:	83 ec 0c             	sub    $0xc,%esp
8010146f:	56                   	push   %esi
80101470:	e8 38 ff ff ff       	call   801013ad <iupdate>
}
80101475:	83 c4 10             	add    $0x10,%esp
80101478:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010147b:	5b                   	pop    %ebx
8010147c:	5e                   	pop    %esi
8010147d:	5f                   	pop    %edi
8010147e:	5d                   	pop    %ebp
8010147f:	c3                   	ret    
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101480:	83 ec 08             	sub    $0x8,%esp
80101483:	50                   	push   %eax
80101484:	ff 36                	push   (%esi)
80101486:	e8 df ec ff ff       	call   8010016a <bread>
8010148b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
8010148e:	8d 78 5c             	lea    0x5c(%eax),%edi
    for(j = 0; j < NINDIRECT; j++){
80101491:	83 c4 10             	add    $0x10,%esp
80101494:	bb 00 00 00 00       	mov    $0x0,%ebx
80101499:	eb 01                	jmp    8010149c <itrunc+0x72>
8010149b:	43                   	inc    %ebx
8010149c:	83 fb 7f             	cmp    $0x7f,%ebx
8010149f:	77 10                	ja     801014b1 <itrunc+0x87>
      if(a[j])
801014a1:	8b 14 9f             	mov    (%edi,%ebx,4),%edx
801014a4:	85 d2                	test   %edx,%edx
801014a6:	74 f3                	je     8010149b <itrunc+0x71>
        bfree(ip->dev, a[j]);
801014a8:	8b 06                	mov    (%esi),%eax
801014aa:	e8 4c fd ff ff       	call   801011fb <bfree>
801014af:	eb ea                	jmp    8010149b <itrunc+0x71>
    brelse(bp);
801014b1:	83 ec 0c             	sub    $0xc,%esp
801014b4:	ff 75 e4             	push   -0x1c(%ebp)
801014b7:	e8 17 ed ff ff       	call   801001d3 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801014bc:	8b 06                	mov    (%esi),%eax
801014be:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801014c4:	e8 32 fd ff ff       	call   801011fb <bfree>
    ip->addrs[NDIRECT] = 0;
801014c9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801014d0:	00 00 00 
801014d3:	83 c4 10             	add    $0x10,%esp
801014d6:	eb 8d                	jmp    80101465 <itrunc+0x3b>

801014d8 <idup>:
{
801014d8:	55                   	push   %ebp
801014d9:	89 e5                	mov    %esp,%ebp
801014db:	53                   	push   %ebx
801014dc:	83 ec 10             	sub    $0x10,%esp
801014df:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801014e2:	68 60 e9 10 80       	push   $0x8010e960
801014e7:	e8 cf 25 00 00       	call   80103abb <acquire>
  ip->ref++;
801014ec:	8b 43 08             	mov    0x8(%ebx),%eax
801014ef:	40                   	inc    %eax
801014f0:	89 43 08             	mov    %eax,0x8(%ebx)
  release(&icache.lock);
801014f3:	c7 04 24 60 e9 10 80 	movl   $0x8010e960,(%esp)
801014fa:	e8 21 26 00 00       	call   80103b20 <release>
}
801014ff:	89 d8                	mov    %ebx,%eax
80101501:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101504:	c9                   	leave  
80101505:	c3                   	ret    

80101506 <ilock>:
{
80101506:	55                   	push   %ebp
80101507:	89 e5                	mov    %esp,%ebp
80101509:	56                   	push   %esi
8010150a:	53                   	push   %ebx
8010150b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010150e:	85 db                	test   %ebx,%ebx
80101510:	74 22                	je     80101534 <ilock+0x2e>
80101512:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
80101516:	7e 1c                	jle    80101534 <ilock+0x2e>
  acquiresleep(&ip->lock);
80101518:	83 ec 0c             	sub    $0xc,%esp
8010151b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010151e:	50                   	push   %eax
8010151f:	e8 88 23 00 00       	call   801038ac <acquiresleep>
  if(ip->valid == 0){
80101524:	83 c4 10             	add    $0x10,%esp
80101527:	83 7b 4c 00          	cmpl   $0x0,0x4c(%ebx)
8010152b:	74 14                	je     80101541 <ilock+0x3b>
}
8010152d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101530:	5b                   	pop    %ebx
80101531:	5e                   	pop    %esi
80101532:	5d                   	pop    %ebp
80101533:	c3                   	ret    
    panic("ilock");
80101534:	83 ec 0c             	sub    $0xc,%esp
80101537:	68 ca 66 10 80       	push   $0x801066ca
8010153c:	e8 00 ee ff ff       	call   80100341 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101541:	8b 43 04             	mov    0x4(%ebx),%eax
80101544:	c1 e8 03             	shr    $0x3,%eax
80101547:	83 ec 08             	sub    $0x8,%esp
8010154a:	03 05 c8 05 11 80    	add    0x801105c8,%eax
80101550:	50                   	push   %eax
80101551:	ff 33                	push   (%ebx)
80101553:	e8 12 ec ff ff       	call   8010016a <bread>
80101558:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010155a:	8b 43 04             	mov    0x4(%ebx),%eax
8010155d:	83 e0 07             	and    $0x7,%eax
80101560:	c1 e0 06             	shl    $0x6,%eax
80101563:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101567:	8b 10                	mov    (%eax),%edx
80101569:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
8010156d:	66 8b 50 02          	mov    0x2(%eax),%dx
80101571:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101575:	8b 50 04             	mov    0x4(%eax),%edx
80101578:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010157c:	66 8b 50 06          	mov    0x6(%eax),%dx
80101580:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101584:	8b 50 08             	mov    0x8(%eax),%edx
80101587:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010158a:	83 c0 0c             	add    $0xc,%eax
8010158d:	8d 53 5c             	lea    0x5c(%ebx),%edx
80101590:	83 c4 0c             	add    $0xc,%esp
80101593:	6a 34                	push   $0x34
80101595:	50                   	push   %eax
80101596:	52                   	push   %edx
80101597:	e8 41 26 00 00       	call   80103bdd <memmove>
    brelse(bp);
8010159c:	89 34 24             	mov    %esi,(%esp)
8010159f:	e8 2f ec ff ff       	call   801001d3 <brelse>
    ip->valid = 1;
801015a4:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801015ab:	83 c4 10             	add    $0x10,%esp
801015ae:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
801015b3:	0f 85 74 ff ff ff    	jne    8010152d <ilock+0x27>
      panic("ilock: no type");
801015b9:	83 ec 0c             	sub    $0xc,%esp
801015bc:	68 d0 66 10 80       	push   $0x801066d0
801015c1:	e8 7b ed ff ff       	call   80100341 <panic>

801015c6 <iunlock>:
{
801015c6:	55                   	push   %ebp
801015c7:	89 e5                	mov    %esp,%ebp
801015c9:	56                   	push   %esi
801015ca:	53                   	push   %ebx
801015cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801015ce:	85 db                	test   %ebx,%ebx
801015d0:	74 2c                	je     801015fe <iunlock+0x38>
801015d2:	8d 73 0c             	lea    0xc(%ebx),%esi
801015d5:	83 ec 0c             	sub    $0xc,%esp
801015d8:	56                   	push   %esi
801015d9:	e8 58 23 00 00       	call   80103936 <holdingsleep>
801015de:	83 c4 10             	add    $0x10,%esp
801015e1:	85 c0                	test   %eax,%eax
801015e3:	74 19                	je     801015fe <iunlock+0x38>
801015e5:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
801015e9:	7e 13                	jle    801015fe <iunlock+0x38>
  releasesleep(&ip->lock);
801015eb:	83 ec 0c             	sub    $0xc,%esp
801015ee:	56                   	push   %esi
801015ef:	e8 07 23 00 00       	call   801038fb <releasesleep>
}
801015f4:	83 c4 10             	add    $0x10,%esp
801015f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015fa:	5b                   	pop    %ebx
801015fb:	5e                   	pop    %esi
801015fc:	5d                   	pop    %ebp
801015fd:	c3                   	ret    
    panic("iunlock");
801015fe:	83 ec 0c             	sub    $0xc,%esp
80101601:	68 df 66 10 80       	push   $0x801066df
80101606:	e8 36 ed ff ff       	call   80100341 <panic>

8010160b <iput>:
{
8010160b:	55                   	push   %ebp
8010160c:	89 e5                	mov    %esp,%ebp
8010160e:	57                   	push   %edi
8010160f:	56                   	push   %esi
80101610:	53                   	push   %ebx
80101611:	83 ec 18             	sub    $0x18,%esp
80101614:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101617:	8d 73 0c             	lea    0xc(%ebx),%esi
8010161a:	56                   	push   %esi
8010161b:	e8 8c 22 00 00       	call   801038ac <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101620:	83 c4 10             	add    $0x10,%esp
80101623:	83 7b 4c 00          	cmpl   $0x0,0x4c(%ebx)
80101627:	74 07                	je     80101630 <iput+0x25>
80101629:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010162e:	74 33                	je     80101663 <iput+0x58>
  releasesleep(&ip->lock);
80101630:	83 ec 0c             	sub    $0xc,%esp
80101633:	56                   	push   %esi
80101634:	e8 c2 22 00 00       	call   801038fb <releasesleep>
  acquire(&icache.lock);
80101639:	c7 04 24 60 e9 10 80 	movl   $0x8010e960,(%esp)
80101640:	e8 76 24 00 00       	call   80103abb <acquire>
  ip->ref--;
80101645:	8b 43 08             	mov    0x8(%ebx),%eax
80101648:	48                   	dec    %eax
80101649:	89 43 08             	mov    %eax,0x8(%ebx)
  release(&icache.lock);
8010164c:	c7 04 24 60 e9 10 80 	movl   $0x8010e960,(%esp)
80101653:	e8 c8 24 00 00       	call   80103b20 <release>
}
80101658:	83 c4 10             	add    $0x10,%esp
8010165b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010165e:	5b                   	pop    %ebx
8010165f:	5e                   	pop    %esi
80101660:	5f                   	pop    %edi
80101661:	5d                   	pop    %ebp
80101662:	c3                   	ret    
    acquire(&icache.lock);
80101663:	83 ec 0c             	sub    $0xc,%esp
80101666:	68 60 e9 10 80       	push   $0x8010e960
8010166b:	e8 4b 24 00 00       	call   80103abb <acquire>
    int r = ip->ref;
80101670:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
80101673:	c7 04 24 60 e9 10 80 	movl   $0x8010e960,(%esp)
8010167a:	e8 a1 24 00 00       	call   80103b20 <release>
    if(r == 1){
8010167f:	83 c4 10             	add    $0x10,%esp
80101682:	83 ff 01             	cmp    $0x1,%edi
80101685:	75 a9                	jne    80101630 <iput+0x25>
      itrunc(ip);
80101687:	89 d8                	mov    %ebx,%eax
80101689:	e8 9c fd ff ff       	call   8010142a <itrunc>
      ip->type = 0;
8010168e:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
80101694:	83 ec 0c             	sub    $0xc,%esp
80101697:	53                   	push   %ebx
80101698:	e8 10 fd ff ff       	call   801013ad <iupdate>
      ip->valid = 0;
8010169d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801016a4:	83 c4 10             	add    $0x10,%esp
801016a7:	eb 87                	jmp    80101630 <iput+0x25>

801016a9 <iunlockput>:
{
801016a9:	55                   	push   %ebp
801016aa:	89 e5                	mov    %esp,%ebp
801016ac:	53                   	push   %ebx
801016ad:	83 ec 10             	sub    $0x10,%esp
801016b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801016b3:	53                   	push   %ebx
801016b4:	e8 0d ff ff ff       	call   801015c6 <iunlock>
  iput(ip);
801016b9:	89 1c 24             	mov    %ebx,(%esp)
801016bc:	e8 4a ff ff ff       	call   8010160b <iput>
}
801016c1:	83 c4 10             	add    $0x10,%esp
801016c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016c7:	c9                   	leave  
801016c8:	c3                   	ret    

801016c9 <stati>:
{
801016c9:	55                   	push   %ebp
801016ca:	89 e5                	mov    %esp,%ebp
801016cc:	8b 55 08             	mov    0x8(%ebp),%edx
801016cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801016d2:	8b 0a                	mov    (%edx),%ecx
801016d4:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801016d7:	8b 4a 04             	mov    0x4(%edx),%ecx
801016da:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801016dd:	8b 4a 50             	mov    0x50(%edx),%ecx
801016e0:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801016e3:	66 8b 4a 56          	mov    0x56(%edx),%cx
801016e7:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801016eb:	8b 52 58             	mov    0x58(%edx),%edx
801016ee:	89 50 10             	mov    %edx,0x10(%eax)
}
801016f1:	5d                   	pop    %ebp
801016f2:	c3                   	ret    

801016f3 <readi>:
{
801016f3:	55                   	push   %ebp
801016f4:	89 e5                	mov    %esp,%ebp
801016f6:	57                   	push   %edi
801016f7:	56                   	push   %esi
801016f8:	53                   	push   %ebx
801016f9:	83 ec 0c             	sub    $0xc,%esp
  if(ip->type == T_DEV){
801016fc:	8b 45 08             	mov    0x8(%ebp),%eax
801016ff:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101704:	74 2c                	je     80101732 <readi+0x3f>
  if(off > ip->size || off + n < off)
80101706:	8b 45 08             	mov    0x8(%ebp),%eax
80101709:	8b 40 58             	mov    0x58(%eax),%eax
8010170c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010170f:	0f 82 d0 00 00 00    	jb     801017e5 <readi+0xf2>
80101715:	8b 55 10             	mov    0x10(%ebp),%edx
80101718:	03 55 14             	add    0x14(%ebp),%edx
8010171b:	0f 82 cb 00 00 00    	jb     801017ec <readi+0xf9>
  if(off + n > ip->size)
80101721:	39 d0                	cmp    %edx,%eax
80101723:	73 06                	jae    8010172b <readi+0x38>
    n = ip->size - off;
80101725:	2b 45 10             	sub    0x10(%ebp),%eax
80101728:	89 45 14             	mov    %eax,0x14(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010172b:	bf 00 00 00 00       	mov    $0x0,%edi
80101730:	eb 55                	jmp    80101787 <readi+0x94>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101732:	66 8b 40 52          	mov    0x52(%eax),%ax
80101736:	66 83 f8 09          	cmp    $0x9,%ax
8010173a:	0f 87 97 00 00 00    	ja     801017d7 <readi+0xe4>
80101740:	98                   	cwtl   
80101741:	8b 04 c5 00 e9 10 80 	mov    -0x7fef1700(,%eax,8),%eax
80101748:	85 c0                	test   %eax,%eax
8010174a:	0f 84 8e 00 00 00    	je     801017de <readi+0xeb>
    return devsw[ip->major].read(ip, dst, n);
80101750:	83 ec 04             	sub    $0x4,%esp
80101753:	ff 75 14             	push   0x14(%ebp)
80101756:	ff 75 0c             	push   0xc(%ebp)
80101759:	ff 75 08             	push   0x8(%ebp)
8010175c:	ff d0                	call   *%eax
8010175e:	83 c4 10             	add    $0x10,%esp
80101761:	eb 6c                	jmp    801017cf <readi+0xdc>
    memmove(dst, bp->data + off%BSIZE, m);
80101763:	83 ec 04             	sub    $0x4,%esp
80101766:	53                   	push   %ebx
80101767:	8d 44 16 5c          	lea    0x5c(%esi,%edx,1),%eax
8010176b:	50                   	push   %eax
8010176c:	ff 75 0c             	push   0xc(%ebp)
8010176f:	e8 69 24 00 00       	call   80103bdd <memmove>
    brelse(bp);
80101774:	89 34 24             	mov    %esi,(%esp)
80101777:	e8 57 ea ff ff       	call   801001d3 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010177c:	01 df                	add    %ebx,%edi
8010177e:	01 5d 10             	add    %ebx,0x10(%ebp)
80101781:	01 5d 0c             	add    %ebx,0xc(%ebp)
80101784:	83 c4 10             	add    $0x10,%esp
80101787:	39 7d 14             	cmp    %edi,0x14(%ebp)
8010178a:	76 40                	jbe    801017cc <readi+0xd9>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010178c:	8b 55 10             	mov    0x10(%ebp),%edx
8010178f:	c1 ea 09             	shr    $0x9,%edx
80101792:	8b 45 08             	mov    0x8(%ebp),%eax
80101795:	e8 da f8 ff ff       	call   80101074 <bmap>
8010179a:	83 ec 08             	sub    $0x8,%esp
8010179d:	50                   	push   %eax
8010179e:	8b 45 08             	mov    0x8(%ebp),%eax
801017a1:	ff 30                	push   (%eax)
801017a3:	e8 c2 e9 ff ff       	call   8010016a <bread>
801017a8:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
801017aa:	8b 55 10             	mov    0x10(%ebp),%edx
801017ad:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801017b3:	b8 00 02 00 00       	mov    $0x200,%eax
801017b8:	29 d0                	sub    %edx,%eax
801017ba:	8b 4d 14             	mov    0x14(%ebp),%ecx
801017bd:	29 f9                	sub    %edi,%ecx
801017bf:	89 c3                	mov    %eax,%ebx
801017c1:	83 c4 10             	add    $0x10,%esp
801017c4:	39 c8                	cmp    %ecx,%eax
801017c6:	76 9b                	jbe    80101763 <readi+0x70>
801017c8:	89 cb                	mov    %ecx,%ebx
801017ca:	eb 97                	jmp    80101763 <readi+0x70>
  return n;
801017cc:	8b 45 14             	mov    0x14(%ebp),%eax
}
801017cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017d2:	5b                   	pop    %ebx
801017d3:	5e                   	pop    %esi
801017d4:	5f                   	pop    %edi
801017d5:	5d                   	pop    %ebp
801017d6:	c3                   	ret    
      return -1;
801017d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801017dc:	eb f1                	jmp    801017cf <readi+0xdc>
801017de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801017e3:	eb ea                	jmp    801017cf <readi+0xdc>
    return -1;
801017e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801017ea:	eb e3                	jmp    801017cf <readi+0xdc>
801017ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801017f1:	eb dc                	jmp    801017cf <readi+0xdc>

801017f3 <writei>:
{
801017f3:	55                   	push   %ebp
801017f4:	89 e5                	mov    %esp,%ebp
801017f6:	57                   	push   %edi
801017f7:	56                   	push   %esi
801017f8:	53                   	push   %ebx
801017f9:	83 ec 0c             	sub    $0xc,%esp
  if(ip->type == T_DEV){
801017fc:	8b 45 08             	mov    0x8(%ebp),%eax
801017ff:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101804:	74 2c                	je     80101832 <writei+0x3f>
  if(off > ip->size || off + n < off)
80101806:	8b 45 08             	mov    0x8(%ebp),%eax
80101809:	8b 7d 10             	mov    0x10(%ebp),%edi
8010180c:	39 78 58             	cmp    %edi,0x58(%eax)
8010180f:	0f 82 fd 00 00 00    	jb     80101912 <writei+0x11f>
80101815:	89 f8                	mov    %edi,%eax
80101817:	03 45 14             	add    0x14(%ebp),%eax
8010181a:	0f 82 f9 00 00 00    	jb     80101919 <writei+0x126>
  if(off + n > MAXFILE*BSIZE)
80101820:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101825:	0f 87 f5 00 00 00    	ja     80101920 <writei+0x12d>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010182b:	bf 00 00 00 00       	mov    $0x0,%edi
80101830:	eb 60                	jmp    80101892 <writei+0x9f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101832:	66 8b 40 52          	mov    0x52(%eax),%ax
80101836:	66 83 f8 09          	cmp    $0x9,%ax
8010183a:	0f 87 c4 00 00 00    	ja     80101904 <writei+0x111>
80101840:	98                   	cwtl   
80101841:	8b 04 c5 04 e9 10 80 	mov    -0x7fef16fc(,%eax,8),%eax
80101848:	85 c0                	test   %eax,%eax
8010184a:	0f 84 bb 00 00 00    	je     8010190b <writei+0x118>
    return devsw[ip->major].write(ip, src, n);
80101850:	83 ec 04             	sub    $0x4,%esp
80101853:	ff 75 14             	push   0x14(%ebp)
80101856:	ff 75 0c             	push   0xc(%ebp)
80101859:	ff 75 08             	push   0x8(%ebp)
8010185c:	ff d0                	call   *%eax
8010185e:	83 c4 10             	add    $0x10,%esp
80101861:	e9 85 00 00 00       	jmp    801018eb <writei+0xf8>
    memmove(bp->data + off%BSIZE, src, m);
80101866:	83 ec 04             	sub    $0x4,%esp
80101869:	56                   	push   %esi
8010186a:	ff 75 0c             	push   0xc(%ebp)
8010186d:	8d 44 13 5c          	lea    0x5c(%ebx,%edx,1),%eax
80101871:	50                   	push   %eax
80101872:	e8 66 23 00 00       	call   80103bdd <memmove>
    log_write(bp);
80101877:	89 1c 24             	mov    %ebx,(%esp)
8010187a:	e8 86 0f 00 00       	call   80102805 <log_write>
    brelse(bp);
8010187f:	89 1c 24             	mov    %ebx,(%esp)
80101882:	e8 4c e9 ff ff       	call   801001d3 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101887:	01 f7                	add    %esi,%edi
80101889:	01 75 10             	add    %esi,0x10(%ebp)
8010188c:	01 75 0c             	add    %esi,0xc(%ebp)
8010188f:	83 c4 10             	add    $0x10,%esp
80101892:	3b 7d 14             	cmp    0x14(%ebp),%edi
80101895:	73 40                	jae    801018d7 <writei+0xe4>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101897:	8b 55 10             	mov    0x10(%ebp),%edx
8010189a:	c1 ea 09             	shr    $0x9,%edx
8010189d:	8b 45 08             	mov    0x8(%ebp),%eax
801018a0:	e8 cf f7 ff ff       	call   80101074 <bmap>
801018a5:	83 ec 08             	sub    $0x8,%esp
801018a8:	50                   	push   %eax
801018a9:	8b 45 08             	mov    0x8(%ebp),%eax
801018ac:	ff 30                	push   (%eax)
801018ae:	e8 b7 e8 ff ff       	call   8010016a <bread>
801018b3:	89 c3                	mov    %eax,%ebx
    m = min(n - tot, BSIZE - off%BSIZE);
801018b5:	8b 55 10             	mov    0x10(%ebp),%edx
801018b8:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801018be:	b8 00 02 00 00       	mov    $0x200,%eax
801018c3:	29 d0                	sub    %edx,%eax
801018c5:	8b 4d 14             	mov    0x14(%ebp),%ecx
801018c8:	29 f9                	sub    %edi,%ecx
801018ca:	89 c6                	mov    %eax,%esi
801018cc:	83 c4 10             	add    $0x10,%esp
801018cf:	39 c8                	cmp    %ecx,%eax
801018d1:	76 93                	jbe    80101866 <writei+0x73>
801018d3:	89 ce                	mov    %ecx,%esi
801018d5:	eb 8f                	jmp    80101866 <writei+0x73>
  if(n > 0 && off > ip->size){
801018d7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801018db:	74 0b                	je     801018e8 <writei+0xf5>
801018dd:	8b 45 08             	mov    0x8(%ebp),%eax
801018e0:	8b 7d 10             	mov    0x10(%ebp),%edi
801018e3:	39 78 58             	cmp    %edi,0x58(%eax)
801018e6:	72 0b                	jb     801018f3 <writei+0x100>
  return n;
801018e8:	8b 45 14             	mov    0x14(%ebp),%eax
}
801018eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018ee:	5b                   	pop    %ebx
801018ef:	5e                   	pop    %esi
801018f0:	5f                   	pop    %edi
801018f1:	5d                   	pop    %ebp
801018f2:	c3                   	ret    
    ip->size = off;
801018f3:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
801018f6:	83 ec 0c             	sub    $0xc,%esp
801018f9:	50                   	push   %eax
801018fa:	e8 ae fa ff ff       	call   801013ad <iupdate>
801018ff:	83 c4 10             	add    $0x10,%esp
80101902:	eb e4                	jmp    801018e8 <writei+0xf5>
      return -1;
80101904:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101909:	eb e0                	jmp    801018eb <writei+0xf8>
8010190b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101910:	eb d9                	jmp    801018eb <writei+0xf8>
    return -1;
80101912:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101917:	eb d2                	jmp    801018eb <writei+0xf8>
80101919:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010191e:	eb cb                	jmp    801018eb <writei+0xf8>
    return -1;
80101920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101925:	eb c4                	jmp    801018eb <writei+0xf8>

80101927 <namecmp>:
{
80101927:	55                   	push   %ebp
80101928:	89 e5                	mov    %esp,%ebp
8010192a:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010192d:	6a 0e                	push   $0xe
8010192f:	ff 75 0c             	push   0xc(%ebp)
80101932:	ff 75 08             	push   0x8(%ebp)
80101935:	e8 09 23 00 00       	call   80103c43 <strncmp>
}
8010193a:	c9                   	leave  
8010193b:	c3                   	ret    

8010193c <dirlookup>:
{
8010193c:	55                   	push   %ebp
8010193d:	89 e5                	mov    %esp,%ebp
8010193f:	57                   	push   %edi
80101940:	56                   	push   %esi
80101941:	53                   	push   %ebx
80101942:	83 ec 1c             	sub    $0x1c,%esp
80101945:	8b 75 08             	mov    0x8(%ebp),%esi
80101948:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(dp->type != T_DIR)
8010194b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101950:	75 07                	jne    80101959 <dirlookup+0x1d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101952:	bb 00 00 00 00       	mov    $0x0,%ebx
80101957:	eb 1d                	jmp    80101976 <dirlookup+0x3a>
    panic("dirlookup not DIR");
80101959:	83 ec 0c             	sub    $0xc,%esp
8010195c:	68 e7 66 10 80       	push   $0x801066e7
80101961:	e8 db e9 ff ff       	call   80100341 <panic>
      panic("dirlookup read");
80101966:	83 ec 0c             	sub    $0xc,%esp
80101969:	68 f9 66 10 80       	push   $0x801066f9
8010196e:	e8 ce e9 ff ff       	call   80100341 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101973:	83 c3 10             	add    $0x10,%ebx
80101976:	39 5e 58             	cmp    %ebx,0x58(%esi)
80101979:	76 48                	jbe    801019c3 <dirlookup+0x87>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010197b:	6a 10                	push   $0x10
8010197d:	53                   	push   %ebx
8010197e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80101981:	50                   	push   %eax
80101982:	56                   	push   %esi
80101983:	e8 6b fd ff ff       	call   801016f3 <readi>
80101988:	83 c4 10             	add    $0x10,%esp
8010198b:	83 f8 10             	cmp    $0x10,%eax
8010198e:	75 d6                	jne    80101966 <dirlookup+0x2a>
    if(de.inum == 0)
80101990:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101995:	74 dc                	je     80101973 <dirlookup+0x37>
    if(namecmp(name, de.name) == 0){
80101997:	83 ec 08             	sub    $0x8,%esp
8010199a:	8d 45 da             	lea    -0x26(%ebp),%eax
8010199d:	50                   	push   %eax
8010199e:	57                   	push   %edi
8010199f:	e8 83 ff ff ff       	call   80101927 <namecmp>
801019a4:	83 c4 10             	add    $0x10,%esp
801019a7:	85 c0                	test   %eax,%eax
801019a9:	75 c8                	jne    80101973 <dirlookup+0x37>
      if(poff)
801019ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801019af:	74 05                	je     801019b6 <dirlookup+0x7a>
        *poff = off;
801019b1:	8b 45 10             	mov    0x10(%ebp),%eax
801019b4:	89 18                	mov    %ebx,(%eax)
      inum = de.inum;
801019b6:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801019ba:	8b 06                	mov    (%esi),%eax
801019bc:	e8 59 f7 ff ff       	call   8010111a <iget>
801019c1:	eb 05                	jmp    801019c8 <dirlookup+0x8c>
  return 0;
801019c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801019c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019cb:	5b                   	pop    %ebx
801019cc:	5e                   	pop    %esi
801019cd:	5f                   	pop    %edi
801019ce:	5d                   	pop    %ebp
801019cf:	c3                   	ret    

801019d0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 1c             	sub    $0x1c,%esp
801019d9:	89 c3                	mov    %eax,%ebx
801019db:	89 55 e0             	mov    %edx,-0x20(%ebp)
801019de:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
801019e1:	80 38 2f             	cmpb   $0x2f,(%eax)
801019e4:	74 17                	je     801019fd <namex+0x2d>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801019e6:	e8 2e 17 00 00       	call   80103119 <myproc>
801019eb:	83 ec 0c             	sub    $0xc,%esp
801019ee:	ff 70 68             	push   0x68(%eax)
801019f1:	e8 e2 fa ff ff       	call   801014d8 <idup>
801019f6:	89 c6                	mov    %eax,%esi
801019f8:	83 c4 10             	add    $0x10,%esp
801019fb:	eb 53                	jmp    80101a50 <namex+0x80>
    ip = iget(ROOTDEV, ROOTINO);
801019fd:	ba 01 00 00 00       	mov    $0x1,%edx
80101a02:	b8 01 00 00 00       	mov    $0x1,%eax
80101a07:	e8 0e f7 ff ff       	call   8010111a <iget>
80101a0c:	89 c6                	mov    %eax,%esi
80101a0e:	eb 40                	jmp    80101a50 <namex+0x80>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
      iunlockput(ip);
80101a10:	83 ec 0c             	sub    $0xc,%esp
80101a13:	56                   	push   %esi
80101a14:	e8 90 fc ff ff       	call   801016a9 <iunlockput>
      return 0;
80101a19:	83 c4 10             	add    $0x10,%esp
80101a1c:	be 00 00 00 00       	mov    $0x0,%esi
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101a21:	89 f0                	mov    %esi,%eax
80101a23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a26:	5b                   	pop    %ebx
80101a27:	5e                   	pop    %esi
80101a28:	5f                   	pop    %edi
80101a29:	5d                   	pop    %ebp
80101a2a:	c3                   	ret    
    if((next = dirlookup(ip, name, 0)) == 0){
80101a2b:	83 ec 04             	sub    $0x4,%esp
80101a2e:	6a 00                	push   $0x0
80101a30:	ff 75 e4             	push   -0x1c(%ebp)
80101a33:	56                   	push   %esi
80101a34:	e8 03 ff ff ff       	call   8010193c <dirlookup>
80101a39:	89 c7                	mov    %eax,%edi
80101a3b:	83 c4 10             	add    $0x10,%esp
80101a3e:	85 c0                	test   %eax,%eax
80101a40:	74 4a                	je     80101a8c <namex+0xbc>
    iunlockput(ip);
80101a42:	83 ec 0c             	sub    $0xc,%esp
80101a45:	56                   	push   %esi
80101a46:	e8 5e fc ff ff       	call   801016a9 <iunlockput>
80101a4b:	83 c4 10             	add    $0x10,%esp
    ip = next;
80101a4e:	89 fe                	mov    %edi,%esi
  while((path = skipelem(path, name)) != 0){
80101a50:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101a53:	89 d8                	mov    %ebx,%eax
80101a55:	e8 97 f4 ff ff       	call   80100ef1 <skipelem>
80101a5a:	89 c3                	mov    %eax,%ebx
80101a5c:	85 c0                	test   %eax,%eax
80101a5e:	74 3c                	je     80101a9c <namex+0xcc>
    ilock(ip);
80101a60:	83 ec 0c             	sub    $0xc,%esp
80101a63:	56                   	push   %esi
80101a64:	e8 9d fa ff ff       	call   80101506 <ilock>
    if(ip->type != T_DIR){
80101a69:	83 c4 10             	add    $0x10,%esp
80101a6c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101a71:	75 9d                	jne    80101a10 <namex+0x40>
    if(nameiparent && *path == '\0'){
80101a73:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101a77:	74 b2                	je     80101a2b <namex+0x5b>
80101a79:	80 3b 00             	cmpb   $0x0,(%ebx)
80101a7c:	75 ad                	jne    80101a2b <namex+0x5b>
      iunlock(ip);
80101a7e:	83 ec 0c             	sub    $0xc,%esp
80101a81:	56                   	push   %esi
80101a82:	e8 3f fb ff ff       	call   801015c6 <iunlock>
      return ip;
80101a87:	83 c4 10             	add    $0x10,%esp
80101a8a:	eb 95                	jmp    80101a21 <namex+0x51>
      iunlockput(ip);
80101a8c:	83 ec 0c             	sub    $0xc,%esp
80101a8f:	56                   	push   %esi
80101a90:	e8 14 fc ff ff       	call   801016a9 <iunlockput>
      return 0;
80101a95:	83 c4 10             	add    $0x10,%esp
80101a98:	89 fe                	mov    %edi,%esi
80101a9a:	eb 85                	jmp    80101a21 <namex+0x51>
  if(nameiparent){
80101a9c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101aa0:	0f 84 7b ff ff ff    	je     80101a21 <namex+0x51>
    iput(ip);
80101aa6:	83 ec 0c             	sub    $0xc,%esp
80101aa9:	56                   	push   %esi
80101aaa:	e8 5c fb ff ff       	call   8010160b <iput>
    return 0;
80101aaf:	83 c4 10             	add    $0x10,%esp
80101ab2:	89 de                	mov    %ebx,%esi
80101ab4:	e9 68 ff ff ff       	jmp    80101a21 <namex+0x51>

80101ab9 <dirlink>:
{
80101ab9:	55                   	push   %ebp
80101aba:	89 e5                	mov    %esp,%ebp
80101abc:	57                   	push   %edi
80101abd:	56                   	push   %esi
80101abe:	53                   	push   %ebx
80101abf:	83 ec 20             	sub    $0x20,%esp
80101ac2:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101ac5:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ac8:	6a 00                	push   $0x0
80101aca:	57                   	push   %edi
80101acb:	53                   	push   %ebx
80101acc:	e8 6b fe ff ff       	call   8010193c <dirlookup>
80101ad1:	83 c4 10             	add    $0x10,%esp
80101ad4:	85 c0                	test   %eax,%eax
80101ad6:	75 2d                	jne    80101b05 <dirlink+0x4c>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ad8:	b8 00 00 00 00       	mov    $0x0,%eax
80101add:	89 c6                	mov    %eax,%esi
80101adf:	39 43 58             	cmp    %eax,0x58(%ebx)
80101ae2:	76 41                	jbe    80101b25 <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ae4:	6a 10                	push   $0x10
80101ae6:	50                   	push   %eax
80101ae7:	8d 45 d8             	lea    -0x28(%ebp),%eax
80101aea:	50                   	push   %eax
80101aeb:	53                   	push   %ebx
80101aec:	e8 02 fc ff ff       	call   801016f3 <readi>
80101af1:	83 c4 10             	add    $0x10,%esp
80101af4:	83 f8 10             	cmp    $0x10,%eax
80101af7:	75 1f                	jne    80101b18 <dirlink+0x5f>
    if(de.inum == 0)
80101af9:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101afe:	74 25                	je     80101b25 <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b00:	8d 46 10             	lea    0x10(%esi),%eax
80101b03:	eb d8                	jmp    80101add <dirlink+0x24>
    iput(ip);
80101b05:	83 ec 0c             	sub    $0xc,%esp
80101b08:	50                   	push   %eax
80101b09:	e8 fd fa ff ff       	call   8010160b <iput>
    return -1;
80101b0e:	83 c4 10             	add    $0x10,%esp
80101b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b16:	eb 3d                	jmp    80101b55 <dirlink+0x9c>
      panic("dirlink read");
80101b18:	83 ec 0c             	sub    $0xc,%esp
80101b1b:	68 08 67 10 80       	push   $0x80106708
80101b20:	e8 1c e8 ff ff       	call   80100341 <panic>
  strncpy(de.name, name, DIRSIZ);
80101b25:	83 ec 04             	sub    $0x4,%esp
80101b28:	6a 0e                	push   $0xe
80101b2a:	57                   	push   %edi
80101b2b:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101b2e:	8d 45 da             	lea    -0x26(%ebp),%eax
80101b31:	50                   	push   %eax
80101b32:	e8 44 21 00 00       	call   80103c7b <strncpy>
  de.inum = inum;
80101b37:	8b 45 10             	mov    0x10(%ebp),%eax
80101b3a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101b3e:	6a 10                	push   $0x10
80101b40:	56                   	push   %esi
80101b41:	57                   	push   %edi
80101b42:	53                   	push   %ebx
80101b43:	e8 ab fc ff ff       	call   801017f3 <writei>
80101b48:	83 c4 20             	add    $0x20,%esp
80101b4b:	83 f8 10             	cmp    $0x10,%eax
80101b4e:	75 0d                	jne    80101b5d <dirlink+0xa4>
  return 0;
80101b50:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b58:	5b                   	pop    %ebx
80101b59:	5e                   	pop    %esi
80101b5a:	5f                   	pop    %edi
80101b5b:	5d                   	pop    %ebp
80101b5c:	c3                   	ret    
    panic("dirlink");
80101b5d:	83 ec 0c             	sub    $0xc,%esp
80101b60:	68 f8 6c 10 80       	push   $0x80106cf8
80101b65:	e8 d7 e7 ff ff       	call   80100341 <panic>

80101b6a <namei>:

struct inode*
namei(char *path)
{
80101b6a:	55                   	push   %ebp
80101b6b:	89 e5                	mov    %esp,%ebp
80101b6d:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101b70:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101b73:	ba 00 00 00 00       	mov    $0x0,%edx
80101b78:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7b:	e8 50 fe ff ff       	call   801019d0 <namex>
}
80101b80:	c9                   	leave  
80101b81:	c3                   	ret    

80101b82 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101b82:	55                   	push   %ebp
80101b83:	89 e5                	mov    %esp,%ebp
80101b85:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
80101b88:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101b8b:	ba 01 00 00 00       	mov    $0x1,%edx
80101b90:	8b 45 08             	mov    0x8(%ebp),%eax
80101b93:	e8 38 fe ff ff       	call   801019d0 <namex>
}
80101b98:	c9                   	leave  
80101b99:	c3                   	ret    

80101b9a <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80101b9a:	89 c1                	mov    %eax,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101b9c:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ba1:	ec                   	in     (%dx),%al
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ba2:	88 c2                	mov    %al,%dl
80101ba4:	83 e2 c0             	and    $0xffffffc0,%edx
80101ba7:	80 fa 40             	cmp    $0x40,%dl
80101baa:	75 f0                	jne    80101b9c <idewait+0x2>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101bac:	85 c9                	test   %ecx,%ecx
80101bae:	74 09                	je     80101bb9 <idewait+0x1f>
80101bb0:	a8 21                	test   $0x21,%al
80101bb2:	75 08                	jne    80101bbc <idewait+0x22>
    return -1;
  return 0;
80101bb4:	b9 00 00 00 00       	mov    $0x0,%ecx
}
80101bb9:	89 c8                	mov    %ecx,%eax
80101bbb:	c3                   	ret    
    return -1;
80101bbc:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80101bc1:	eb f6                	jmp    80101bb9 <idewait+0x1f>

80101bc3 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101bc3:	55                   	push   %ebp
80101bc4:	89 e5                	mov    %esp,%ebp
80101bc6:	56                   	push   %esi
80101bc7:	53                   	push   %ebx
  if(b == 0)
80101bc8:	85 c0                	test   %eax,%eax
80101bca:	0f 84 85 00 00 00    	je     80101c55 <idestart+0x92>
80101bd0:	89 c6                	mov    %eax,%esi
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101bd2:	8b 58 08             	mov    0x8(%eax),%ebx
80101bd5:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101bdb:	0f 87 81 00 00 00    	ja     80101c62 <idestart+0x9f>
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;

  if (sector_per_block > 7) panic("idestart");

  idewait(0);
80101be1:	b8 00 00 00 00       	mov    $0x0,%eax
80101be6:	e8 af ff ff ff       	call   80101b9a <idewait>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101beb:	b0 00                	mov    $0x0,%al
80101bed:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101bf2:	ee                   	out    %al,(%dx)
80101bf3:	b0 01                	mov    $0x1,%al
80101bf5:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101bfa:	ee                   	out    %al,(%dx)
80101bfb:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101c00:	88 d8                	mov    %bl,%al
80101c02:	ee                   	out    %al,(%dx)
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101c03:	0f b6 c7             	movzbl %bh,%eax
80101c06:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101c0b:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
80101c0c:	89 d8                	mov    %ebx,%eax
80101c0e:	c1 f8 10             	sar    $0x10,%eax
80101c11:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101c16:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101c17:	8a 46 04             	mov    0x4(%esi),%al
80101c1a:	c1 e0 04             	shl    $0x4,%eax
80101c1d:	83 e0 10             	and    $0x10,%eax
80101c20:	c1 fb 18             	sar    $0x18,%ebx
80101c23:	83 e3 0f             	and    $0xf,%ebx
80101c26:	09 d8                	or     %ebx,%eax
80101c28:	83 c8 e0             	or     $0xffffffe0,%eax
80101c2b:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101c30:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101c31:	f6 06 04             	testb  $0x4,(%esi)
80101c34:	74 39                	je     80101c6f <idestart+0xac>
80101c36:	b0 30                	mov    $0x30,%al
80101c38:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101c3d:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101c3e:	83 c6 5c             	add    $0x5c,%esi
  asm volatile("cld; rep outsl" :
80101c41:	b9 80 00 00 00       	mov    $0x80,%ecx
80101c46:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101c4b:	fc                   	cld    
80101c4c:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101c4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c51:	5b                   	pop    %ebx
80101c52:	5e                   	pop    %esi
80101c53:	5d                   	pop    %ebp
80101c54:	c3                   	ret    
    panic("idestart");
80101c55:	83 ec 0c             	sub    $0xc,%esp
80101c58:	68 6b 67 10 80       	push   $0x8010676b
80101c5d:	e8 df e6 ff ff       	call   80100341 <panic>
    panic("incorrect blockno");
80101c62:	83 ec 0c             	sub    $0xc,%esp
80101c65:	68 74 67 10 80       	push   $0x80106774
80101c6a:	e8 d2 e6 ff ff       	call   80100341 <panic>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101c6f:	b0 20                	mov    $0x20,%al
80101c71:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101c76:	ee                   	out    %al,(%dx)
}
80101c77:	eb d5                	jmp    80101c4e <idestart+0x8b>

80101c79 <ideinit>:
{
80101c79:	55                   	push   %ebp
80101c7a:	89 e5                	mov    %esp,%ebp
80101c7c:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101c7f:	68 86 67 10 80       	push   $0x80106786
80101c84:	68 00 06 11 80       	push   $0x80110600
80101c89:	e8 f6 1c 00 00       	call   80103984 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101c8e:	83 c4 08             	add    $0x8,%esp
80101c91:	a1 84 07 11 80       	mov    0x80110784,%eax
80101c96:	48                   	dec    %eax
80101c97:	50                   	push   %eax
80101c98:	6a 0e                	push   $0xe
80101c9a:	e8 46 02 00 00       	call   80101ee5 <ioapicenable>
  idewait(0);
80101c9f:	b8 00 00 00 00       	mov    $0x0,%eax
80101ca4:	e8 f1 fe ff ff       	call   80101b9a <idewait>
80101ca9:	b0 f0                	mov    $0xf0,%al
80101cab:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101cb0:	ee                   	out    %al,(%dx)
  for(i=0; i<1000; i++){
80101cb1:	83 c4 10             	add    $0x10,%esp
80101cb4:	b9 00 00 00 00       	mov    $0x0,%ecx
80101cb9:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101cbf:	7f 17                	jg     80101cd8 <ideinit+0x5f>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101cc1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101cc6:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101cc7:	84 c0                	test   %al,%al
80101cc9:	75 03                	jne    80101cce <ideinit+0x55>
  for(i=0; i<1000; i++){
80101ccb:	41                   	inc    %ecx
80101ccc:	eb eb                	jmp    80101cb9 <ideinit+0x40>
      havedisk1 = 1;
80101cce:	c7 05 e0 05 11 80 01 	movl   $0x1,0x801105e0
80101cd5:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101cd8:	b0 e0                	mov    $0xe0,%al
80101cda:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101cdf:	ee                   	out    %al,(%dx)
}
80101ce0:	c9                   	leave  
80101ce1:	c3                   	ret    

80101ce2 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80101ce2:	55                   	push   %ebp
80101ce3:	89 e5                	mov    %esp,%ebp
80101ce5:	57                   	push   %edi
80101ce6:	53                   	push   %ebx
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101ce7:	83 ec 0c             	sub    $0xc,%esp
80101cea:	68 00 06 11 80       	push   $0x80110600
80101cef:	e8 c7 1d 00 00       	call   80103abb <acquire>

  if((b = idequeue) == 0){
80101cf4:	8b 1d e4 05 11 80    	mov    0x801105e4,%ebx
80101cfa:	83 c4 10             	add    $0x10,%esp
80101cfd:	85 db                	test   %ebx,%ebx
80101cff:	74 4a                	je     80101d4b <ideintr+0x69>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101d01:	8b 43 58             	mov    0x58(%ebx),%eax
80101d04:	a3 e4 05 11 80       	mov    %eax,0x801105e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101d09:	f6 03 04             	testb  $0x4,(%ebx)
80101d0c:	74 4f                	je     80101d5d <ideintr+0x7b>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80101d0e:	8b 03                	mov    (%ebx),%eax
80101d10:	83 c8 02             	or     $0x2,%eax
80101d13:	89 03                	mov    %eax,(%ebx)
  b->flags &= ~B_DIRTY;
80101d15:	83 e0 fb             	and    $0xfffffffb,%eax
80101d18:	89 03                	mov    %eax,(%ebx)
  wakeup(b);
80101d1a:	83 ec 0c             	sub    $0xc,%esp
80101d1d:	53                   	push   %ebx
80101d1e:	e8 09 1a 00 00       	call   8010372c <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101d23:	a1 e4 05 11 80       	mov    0x801105e4,%eax
80101d28:	83 c4 10             	add    $0x10,%esp
80101d2b:	85 c0                	test   %eax,%eax
80101d2d:	74 05                	je     80101d34 <ideintr+0x52>
    idestart(idequeue);
80101d2f:	e8 8f fe ff ff       	call   80101bc3 <idestart>

  release(&idelock);
80101d34:	83 ec 0c             	sub    $0xc,%esp
80101d37:	68 00 06 11 80       	push   $0x80110600
80101d3c:	e8 df 1d 00 00       	call   80103b20 <release>
80101d41:	83 c4 10             	add    $0x10,%esp
}
80101d44:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d47:	5b                   	pop    %ebx
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret    
    release(&idelock);
80101d4b:	83 ec 0c             	sub    $0xc,%esp
80101d4e:	68 00 06 11 80       	push   $0x80110600
80101d53:	e8 c8 1d 00 00       	call   80103b20 <release>
    return;
80101d58:	83 c4 10             	add    $0x10,%esp
80101d5b:	eb e7                	jmp    80101d44 <ideintr+0x62>
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101d5d:	b8 01 00 00 00       	mov    $0x1,%eax
80101d62:	e8 33 fe ff ff       	call   80101b9a <idewait>
80101d67:	85 c0                	test   %eax,%eax
80101d69:	78 a3                	js     80101d0e <ideintr+0x2c>
    insl(0x1f0, b->data, BSIZE/4);
80101d6b:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80101d6e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101d73:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101d78:	fc                   	cld    
80101d79:	f3 6d                	rep insl (%dx),%es:(%edi)
}
80101d7b:	eb 91                	jmp    80101d0e <ideintr+0x2c>

80101d7d <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80101d7d:	55                   	push   %ebp
80101d7e:	89 e5                	mov    %esp,%ebp
80101d80:	53                   	push   %ebx
80101d81:	83 ec 10             	sub    $0x10,%esp
80101d84:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80101d87:	8d 43 0c             	lea    0xc(%ebx),%eax
80101d8a:	50                   	push   %eax
80101d8b:	e8 a6 1b 00 00       	call   80103936 <holdingsleep>
80101d90:	83 c4 10             	add    $0x10,%esp
80101d93:	85 c0                	test   %eax,%eax
80101d95:	74 37                	je     80101dce <iderw+0x51>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80101d97:	8b 03                	mov    (%ebx),%eax
80101d99:	83 e0 06             	and    $0x6,%eax
80101d9c:	83 f8 02             	cmp    $0x2,%eax
80101d9f:	74 3a                	je     80101ddb <iderw+0x5e>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80101da1:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
80101da5:	74 09                	je     80101db0 <iderw+0x33>
80101da7:	83 3d e0 05 11 80 00 	cmpl   $0x0,0x801105e0
80101dae:	74 38                	je     80101de8 <iderw+0x6b>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80101db0:	83 ec 0c             	sub    $0xc,%esp
80101db3:	68 00 06 11 80       	push   $0x80110600
80101db8:	e8 fe 1c 00 00       	call   80103abb <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80101dbd:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101dc4:	83 c4 10             	add    $0x10,%esp
80101dc7:	ba e4 05 11 80       	mov    $0x801105e4,%edx
80101dcc:	eb 2a                	jmp    80101df8 <iderw+0x7b>
    panic("iderw: buf not locked");
80101dce:	83 ec 0c             	sub    $0xc,%esp
80101dd1:	68 8a 67 10 80       	push   $0x8010678a
80101dd6:	e8 66 e5 ff ff       	call   80100341 <panic>
    panic("iderw: nothing to do");
80101ddb:	83 ec 0c             	sub    $0xc,%esp
80101dde:	68 a0 67 10 80       	push   $0x801067a0
80101de3:	e8 59 e5 ff ff       	call   80100341 <panic>
    panic("iderw: ide disk 1 not present");
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	68 b5 67 10 80       	push   $0x801067b5
80101df0:	e8 4c e5 ff ff       	call   80100341 <panic>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101df5:	8d 50 58             	lea    0x58(%eax),%edx
80101df8:	8b 02                	mov    (%edx),%eax
80101dfa:	85 c0                	test   %eax,%eax
80101dfc:	75 f7                	jne    80101df5 <iderw+0x78>
    ;
  *pp = b;
80101dfe:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80101e00:	39 1d e4 05 11 80    	cmp    %ebx,0x801105e4
80101e06:	75 1a                	jne    80101e22 <iderw+0xa5>
    idestart(b);
80101e08:	89 d8                	mov    %ebx,%eax
80101e0a:	e8 b4 fd ff ff       	call   80101bc3 <idestart>
80101e0f:	eb 11                	jmp    80101e22 <iderw+0xa5>

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80101e11:	83 ec 08             	sub    $0x8,%esp
80101e14:	68 00 06 11 80       	push   $0x80110600
80101e19:	53                   	push   %ebx
80101e1a:	e8 a6 17 00 00       	call   801035c5 <sleep>
80101e1f:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101e22:	8b 03                	mov    (%ebx),%eax
80101e24:	83 e0 06             	and    $0x6,%eax
80101e27:	83 f8 02             	cmp    $0x2,%eax
80101e2a:	75 e5                	jne    80101e11 <iderw+0x94>
  }


  release(&idelock);
80101e2c:	83 ec 0c             	sub    $0xc,%esp
80101e2f:	68 00 06 11 80       	push   $0x80110600
80101e34:	e8 e7 1c 00 00       	call   80103b20 <release>
}
80101e39:	83 c4 10             	add    $0x10,%esp
80101e3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101e3f:	c9                   	leave  
80101e40:	c3                   	ret    

80101e41 <ioapicread>:
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101e41:	8b 15 34 06 11 80    	mov    0x80110634,%edx
80101e47:	89 02                	mov    %eax,(%edx)
  return ioapic->data;
80101e49:	a1 34 06 11 80       	mov    0x80110634,%eax
80101e4e:	8b 40 10             	mov    0x10(%eax),%eax
}
80101e51:	c3                   	ret    

80101e52 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101e52:	8b 0d 34 06 11 80    	mov    0x80110634,%ecx
80101e58:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80101e5a:	a1 34 06 11 80       	mov    0x80110634,%eax
80101e5f:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e62:	c3                   	ret    

80101e63 <ioapicinit>:

void
ioapicinit(void)
{
80101e63:	55                   	push   %ebp
80101e64:	89 e5                	mov    %esp,%ebp
80101e66:	57                   	push   %edi
80101e67:	56                   	push   %esi
80101e68:	53                   	push   %ebx
80101e69:	83 ec 0c             	sub    $0xc,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80101e6c:	c7 05 34 06 11 80 00 	movl   $0xfec00000,0x80110634
80101e73:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80101e76:	b8 01 00 00 00       	mov    $0x1,%eax
80101e7b:	e8 c1 ff ff ff       	call   80101e41 <ioapicread>
80101e80:	c1 e8 10             	shr    $0x10,%eax
80101e83:	0f b6 f8             	movzbl %al,%edi
  id = ioapicread(REG_ID) >> 24;
80101e86:	b8 00 00 00 00       	mov    $0x0,%eax
80101e8b:	e8 b1 ff ff ff       	call   80101e41 <ioapicread>
80101e90:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80101e93:	0f b6 15 80 07 11 80 	movzbl 0x80110780,%edx
80101e9a:	39 c2                	cmp    %eax,%edx
80101e9c:	75 07                	jne    80101ea5 <ioapicinit+0x42>
{
80101e9e:	bb 00 00 00 00       	mov    $0x0,%ebx
80101ea3:	eb 34                	jmp    80101ed9 <ioapicinit+0x76>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	68 d4 67 10 80       	push   $0x801067d4
80101ead:	e8 28 e7 ff ff       	call   801005da <cprintf>
80101eb2:	83 c4 10             	add    $0x10,%esp
80101eb5:	eb e7                	jmp    80101e9e <ioapicinit+0x3b>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80101eb7:	8d 53 20             	lea    0x20(%ebx),%edx
80101eba:	81 ca 00 00 01 00    	or     $0x10000,%edx
80101ec0:	8d 74 1b 10          	lea    0x10(%ebx,%ebx,1),%esi
80101ec4:	89 f0                	mov    %esi,%eax
80101ec6:	e8 87 ff ff ff       	call   80101e52 <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80101ecb:	8d 46 01             	lea    0x1(%esi),%eax
80101ece:	ba 00 00 00 00       	mov    $0x0,%edx
80101ed3:	e8 7a ff ff ff       	call   80101e52 <ioapicwrite>
  for(i = 0; i <= maxintr; i++){
80101ed8:	43                   	inc    %ebx
80101ed9:	39 fb                	cmp    %edi,%ebx
80101edb:	7e da                	jle    80101eb7 <ioapicinit+0x54>
  }
}
80101edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee0:	5b                   	pop    %ebx
80101ee1:	5e                   	pop    %esi
80101ee2:	5f                   	pop    %edi
80101ee3:	5d                   	pop    %ebp
80101ee4:	c3                   	ret    

80101ee5 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80101ee5:	55                   	push   %ebp
80101ee6:	89 e5                	mov    %esp,%ebp
80101ee8:	53                   	push   %ebx
80101ee9:	83 ec 04             	sub    $0x4,%esp
80101eec:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80101eef:	8d 50 20             	lea    0x20(%eax),%edx
80101ef2:	8d 5c 00 10          	lea    0x10(%eax,%eax,1),%ebx
80101ef6:	89 d8                	mov    %ebx,%eax
80101ef8:	e8 55 ff ff ff       	call   80101e52 <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80101efd:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f00:	c1 e2 18             	shl    $0x18,%edx
80101f03:	8d 43 01             	lea    0x1(%ebx),%eax
80101f06:	e8 47 ff ff ff       	call   80101e52 <ioapicwrite>
}
80101f0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f0e:	c9                   	leave  
80101f0f:	c3                   	ret    

80101f10 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	53                   	push   %ebx
80101f14:	83 ec 04             	sub    $0x4,%esp
80101f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80101f1a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80101f20:	75 4c                	jne    80101f6e <kfree+0x5e>
80101f22:	81 fb d0 44 11 80    	cmp    $0x801144d0,%ebx
80101f28:	72 44                	jb     80101f6e <kfree+0x5e>
80101f2a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80101f30:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80101f35:	77 37                	ja     80101f6e <kfree+0x5e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80101f37:	83 ec 04             	sub    $0x4,%esp
80101f3a:	68 00 10 00 00       	push   $0x1000
80101f3f:	6a 01                	push   $0x1
80101f41:	53                   	push   %ebx
80101f42:	e8 20 1c 00 00       	call   80103b67 <memset>

  if(kmem.use_lock)
80101f47:	83 c4 10             	add    $0x10,%esp
80101f4a:	83 3d 74 06 11 80 00 	cmpl   $0x0,0x80110674
80101f51:	75 28                	jne    80101f7b <kfree+0x6b>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80101f53:	a1 78 06 11 80       	mov    0x80110678,%eax
80101f58:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
80101f5a:	89 1d 78 06 11 80    	mov    %ebx,0x80110678
  if(kmem.use_lock)
80101f60:	83 3d 74 06 11 80 00 	cmpl   $0x0,0x80110674
80101f67:	75 24                	jne    80101f8d <kfree+0x7d>
    release(&kmem.lock);
}
80101f69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f6c:	c9                   	leave  
80101f6d:	c3                   	ret    
    panic("kfree");
80101f6e:	83 ec 0c             	sub    $0xc,%esp
80101f71:	68 06 68 10 80       	push   $0x80106806
80101f76:	e8 c6 e3 ff ff       	call   80100341 <panic>
    acquire(&kmem.lock);
80101f7b:	83 ec 0c             	sub    $0xc,%esp
80101f7e:	68 40 06 11 80       	push   $0x80110640
80101f83:	e8 33 1b 00 00       	call   80103abb <acquire>
80101f88:	83 c4 10             	add    $0x10,%esp
80101f8b:	eb c6                	jmp    80101f53 <kfree+0x43>
    release(&kmem.lock);
80101f8d:	83 ec 0c             	sub    $0xc,%esp
80101f90:	68 40 06 11 80       	push   $0x80110640
80101f95:	e8 86 1b 00 00       	call   80103b20 <release>
80101f9a:	83 c4 10             	add    $0x10,%esp
}
80101f9d:	eb ca                	jmp    80101f69 <kfree+0x59>

80101f9f <freerange>:
{
80101f9f:	55                   	push   %ebp
80101fa0:	89 e5                	mov    %esp,%ebp
80101fa2:	56                   	push   %esi
80101fa3:	53                   	push   %ebx
80101fa4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  p = (char*)PGROUNDUP((uint)vstart);
80101fa7:	8b 45 08             	mov    0x8(%ebp),%eax
80101faa:	05 ff 0f 00 00       	add    $0xfff,%eax
80101faf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80101fb4:	eb 0e                	jmp    80101fc4 <freerange+0x25>
    kfree(p);
80101fb6:	83 ec 0c             	sub    $0xc,%esp
80101fb9:	50                   	push   %eax
80101fba:	e8 51 ff ff ff       	call   80101f10 <kfree>
80101fbf:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80101fc2:	89 f0                	mov    %esi,%eax
80101fc4:	8d b0 00 10 00 00    	lea    0x1000(%eax),%esi
80101fca:	39 de                	cmp    %ebx,%esi
80101fcc:	76 e8                	jbe    80101fb6 <freerange+0x17>
}
80101fce:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fd1:	5b                   	pop    %ebx
80101fd2:	5e                   	pop    %esi
80101fd3:	5d                   	pop    %ebp
80101fd4:	c3                   	ret    

80101fd5 <kinit1>:
{
80101fd5:	55                   	push   %ebp
80101fd6:	89 e5                	mov    %esp,%ebp
80101fd8:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
80101fdb:	68 0c 68 10 80       	push   $0x8010680c
80101fe0:	68 40 06 11 80       	push   $0x80110640
80101fe5:	e8 9a 19 00 00       	call   80103984 <initlock>
  kmem.use_lock = 0;
80101fea:	c7 05 74 06 11 80 00 	movl   $0x0,0x80110674
80101ff1:	00 00 00 
  freerange(vstart, vend);
80101ff4:	83 c4 08             	add    $0x8,%esp
80101ff7:	ff 75 0c             	push   0xc(%ebp)
80101ffa:	ff 75 08             	push   0x8(%ebp)
80101ffd:	e8 9d ff ff ff       	call   80101f9f <freerange>
}
80102002:	83 c4 10             	add    $0x10,%esp
80102005:	c9                   	leave  
80102006:	c3                   	ret    

80102007 <kinit2>:
{
80102007:	55                   	push   %ebp
80102008:	89 e5                	mov    %esp,%ebp
8010200a:	83 ec 10             	sub    $0x10,%esp
  freerange(vstart, vend);
8010200d:	ff 75 0c             	push   0xc(%ebp)
80102010:	ff 75 08             	push   0x8(%ebp)
80102013:	e8 87 ff ff ff       	call   80101f9f <freerange>
  kmem.use_lock = 1;
80102018:	c7 05 74 06 11 80 01 	movl   $0x1,0x80110674
8010201f:	00 00 00 
}
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	c9                   	leave  
80102026:	c3                   	ret    

80102027 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102027:	55                   	push   %ebp
80102028:	89 e5                	mov    %esp,%ebp
8010202a:	53                   	push   %ebx
8010202b:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
8010202e:	83 3d 74 06 11 80 00 	cmpl   $0x0,0x80110674
80102035:	75 21                	jne    80102058 <kalloc+0x31>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102037:	8b 1d 78 06 11 80    	mov    0x80110678,%ebx
  if(r)
8010203d:	85 db                	test   %ebx,%ebx
8010203f:	74 07                	je     80102048 <kalloc+0x21>
    kmem.freelist = r->next;
80102041:	8b 03                	mov    (%ebx),%eax
80102043:	a3 78 06 11 80       	mov    %eax,0x80110678
  if(kmem.use_lock)
80102048:	83 3d 74 06 11 80 00 	cmpl   $0x0,0x80110674
8010204f:	75 19                	jne    8010206a <kalloc+0x43>
    release(&kmem.lock);
  return (char*)r;
}
80102051:	89 d8                	mov    %ebx,%eax
80102053:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102056:	c9                   	leave  
80102057:	c3                   	ret    
    acquire(&kmem.lock);
80102058:	83 ec 0c             	sub    $0xc,%esp
8010205b:	68 40 06 11 80       	push   $0x80110640
80102060:	e8 56 1a 00 00       	call   80103abb <acquire>
80102065:	83 c4 10             	add    $0x10,%esp
80102068:	eb cd                	jmp    80102037 <kalloc+0x10>
    release(&kmem.lock);
8010206a:	83 ec 0c             	sub    $0xc,%esp
8010206d:	68 40 06 11 80       	push   $0x80110640
80102072:	e8 a9 1a 00 00       	call   80103b20 <release>
80102077:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
8010207a:	eb d5                	jmp    80102051 <kalloc+0x2a>

8010207c <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010207c:	ba 64 00 00 00       	mov    $0x64,%edx
80102081:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102082:	a8 01                	test   $0x1,%al
80102084:	0f 84 b3 00 00 00    	je     8010213d <kbdgetc+0xc1>
8010208a:	ba 60 00 00 00       	mov    $0x60,%edx
8010208f:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102090:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102093:	3c e0                	cmp    $0xe0,%al
80102095:	74 61                	je     801020f8 <kbdgetc+0x7c>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102097:	84 c0                	test   %al,%al
80102099:	78 6a                	js     80102105 <kbdgetc+0x89>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010209b:	8b 15 7c 06 11 80    	mov    0x8011067c,%edx
801020a1:	f6 c2 40             	test   $0x40,%dl
801020a4:	74 0f                	je     801020b5 <kbdgetc+0x39>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801020a6:	83 c8 80             	or     $0xffffff80,%eax
801020a9:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
801020ac:	83 e2 bf             	and    $0xffffffbf,%edx
801020af:	89 15 7c 06 11 80    	mov    %edx,0x8011067c
  }

  shift |= shiftcode[data];
801020b5:	0f b6 91 40 69 10 80 	movzbl -0x7fef96c0(%ecx),%edx
801020bc:	0b 15 7c 06 11 80    	or     0x8011067c,%edx
801020c2:	89 15 7c 06 11 80    	mov    %edx,0x8011067c
  shift ^= togglecode[data];
801020c8:	0f b6 81 40 68 10 80 	movzbl -0x7fef97c0(%ecx),%eax
801020cf:	31 c2                	xor    %eax,%edx
801020d1:	89 15 7c 06 11 80    	mov    %edx,0x8011067c
  c = charcode[shift & (CTL | SHIFT)][data];
801020d7:	89 d0                	mov    %edx,%eax
801020d9:	83 e0 03             	and    $0x3,%eax
801020dc:	8b 04 85 20 68 10 80 	mov    -0x7fef97e0(,%eax,4),%eax
801020e3:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801020e7:	f6 c2 08             	test   $0x8,%dl
801020ea:	74 56                	je     80102142 <kbdgetc+0xc6>
    if('a' <= c && c <= 'z')
801020ec:	8d 50 9f             	lea    -0x61(%eax),%edx
801020ef:	83 fa 19             	cmp    $0x19,%edx
801020f2:	77 3d                	ja     80102131 <kbdgetc+0xb5>
      c += 'A' - 'a';
801020f4:	83 e8 20             	sub    $0x20,%eax
801020f7:	c3                   	ret    
    shift |= E0ESC;
801020f8:	83 0d 7c 06 11 80 40 	orl    $0x40,0x8011067c
    return 0;
801020ff:	b8 00 00 00 00       	mov    $0x0,%eax
80102104:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102105:	8b 15 7c 06 11 80    	mov    0x8011067c,%edx
8010210b:	f6 c2 40             	test   $0x40,%dl
8010210e:	75 05                	jne    80102115 <kbdgetc+0x99>
80102110:	89 c1                	mov    %eax,%ecx
80102112:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102115:	8a 81 40 69 10 80    	mov    -0x7fef96c0(%ecx),%al
8010211b:	83 c8 40             	or     $0x40,%eax
8010211e:	0f b6 c0             	movzbl %al,%eax
80102121:	f7 d0                	not    %eax
80102123:	21 c2                	and    %eax,%edx
80102125:	89 15 7c 06 11 80    	mov    %edx,0x8011067c
    return 0;
8010212b:	b8 00 00 00 00       	mov    $0x0,%eax
80102130:	c3                   	ret    
    else if('A' <= c && c <= 'Z')
80102131:	8d 50 bf             	lea    -0x41(%eax),%edx
80102134:	83 fa 19             	cmp    $0x19,%edx
80102137:	77 09                	ja     80102142 <kbdgetc+0xc6>
      c += 'a' - 'A';
80102139:	83 c0 20             	add    $0x20,%eax
  }
  return c;
8010213c:	c3                   	ret    
    return -1;
8010213d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102142:	c3                   	ret    

80102143 <kbdintr>:

void
kbdintr(void)
{
80102143:	55                   	push   %ebp
80102144:	89 e5                	mov    %esp,%ebp
80102146:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102149:	68 7c 20 10 80       	push   $0x8010207c
8010214e:	e8 ac e5 ff ff       	call   801006ff <consoleintr>
}
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	c9                   	leave  
80102157:	c3                   	ret    

80102158 <lapicw>:

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102158:	8b 0d 80 06 11 80    	mov    0x80110680,%ecx
8010215e:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80102161:	89 10                	mov    %edx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102163:	a1 80 06 11 80       	mov    0x80110680,%eax
80102168:	8b 40 20             	mov    0x20(%eax),%eax
}
8010216b:	c3                   	ret    

8010216c <cmos_read>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010216c:	ba 70 00 00 00       	mov    $0x70,%edx
80102171:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102172:	ba 71 00 00 00       	mov    $0x71,%edx
80102177:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
80102178:	0f b6 c0             	movzbl %al,%eax
}
8010217b:	c3                   	ret    

8010217c <fill_rtcdate>:

static void
fill_rtcdate(struct rtcdate *r)
{
8010217c:	55                   	push   %ebp
8010217d:	89 e5                	mov    %esp,%ebp
8010217f:	53                   	push   %ebx
80102180:	83 ec 04             	sub    $0x4,%esp
80102183:	89 c3                	mov    %eax,%ebx
  r->second = cmos_read(SECS);
80102185:	b8 00 00 00 00       	mov    $0x0,%eax
8010218a:	e8 dd ff ff ff       	call   8010216c <cmos_read>
8010218f:	89 03                	mov    %eax,(%ebx)
  r->minute = cmos_read(MINS);
80102191:	b8 02 00 00 00       	mov    $0x2,%eax
80102196:	e8 d1 ff ff ff       	call   8010216c <cmos_read>
8010219b:	89 43 04             	mov    %eax,0x4(%ebx)
  r->hour   = cmos_read(HOURS);
8010219e:	b8 04 00 00 00       	mov    $0x4,%eax
801021a3:	e8 c4 ff ff ff       	call   8010216c <cmos_read>
801021a8:	89 43 08             	mov    %eax,0x8(%ebx)
  r->day    = cmos_read(DAY);
801021ab:	b8 07 00 00 00       	mov    $0x7,%eax
801021b0:	e8 b7 ff ff ff       	call   8010216c <cmos_read>
801021b5:	89 43 0c             	mov    %eax,0xc(%ebx)
  r->month  = cmos_read(MONTH);
801021b8:	b8 08 00 00 00       	mov    $0x8,%eax
801021bd:	e8 aa ff ff ff       	call   8010216c <cmos_read>
801021c2:	89 43 10             	mov    %eax,0x10(%ebx)
  r->year   = cmos_read(YEAR);
801021c5:	b8 09 00 00 00       	mov    $0x9,%eax
801021ca:	e8 9d ff ff ff       	call   8010216c <cmos_read>
801021cf:	89 43 14             	mov    %eax,0x14(%ebx)
}
801021d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021d5:	c9                   	leave  
801021d6:	c3                   	ret    

801021d7 <lapicinit>:
  if(!lapic)
801021d7:	83 3d 80 06 11 80 00 	cmpl   $0x0,0x80110680
801021de:	0f 84 fe 00 00 00    	je     801022e2 <lapicinit+0x10b>
{
801021e4:	55                   	push   %ebp
801021e5:	89 e5                	mov    %esp,%ebp
801021e7:	83 ec 08             	sub    $0x8,%esp
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
801021ea:	ba 3f 01 00 00       	mov    $0x13f,%edx
801021ef:	b8 3c 00 00 00       	mov    $0x3c,%eax
801021f4:	e8 5f ff ff ff       	call   80102158 <lapicw>
  lapicw(TDCR, X1);
801021f9:	ba 0b 00 00 00       	mov    $0xb,%edx
801021fe:	b8 f8 00 00 00       	mov    $0xf8,%eax
80102203:	e8 50 ff ff ff       	call   80102158 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102208:	ba 20 00 02 00       	mov    $0x20020,%edx
8010220d:	b8 c8 00 00 00       	mov    $0xc8,%eax
80102212:	e8 41 ff ff ff       	call   80102158 <lapicw>
  lapicw(TICR, 10000000);
80102217:	ba 80 96 98 00       	mov    $0x989680,%edx
8010221c:	b8 e0 00 00 00       	mov    $0xe0,%eax
80102221:	e8 32 ff ff ff       	call   80102158 <lapicw>
  lapicw(LINT0, MASKED);
80102226:	ba 00 00 01 00       	mov    $0x10000,%edx
8010222b:	b8 d4 00 00 00       	mov    $0xd4,%eax
80102230:	e8 23 ff ff ff       	call   80102158 <lapicw>
  lapicw(LINT1, MASKED);
80102235:	ba 00 00 01 00       	mov    $0x10000,%edx
8010223a:	b8 d8 00 00 00       	mov    $0xd8,%eax
8010223f:	e8 14 ff ff ff       	call   80102158 <lapicw>
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102244:	a1 80 06 11 80       	mov    0x80110680,%eax
80102249:	8b 40 30             	mov    0x30(%eax),%eax
8010224c:	c1 e8 10             	shr    $0x10,%eax
8010224f:	a8 fc                	test   $0xfc,%al
80102251:	75 7b                	jne    801022ce <lapicinit+0xf7>
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102253:	ba 33 00 00 00       	mov    $0x33,%edx
80102258:	b8 dc 00 00 00       	mov    $0xdc,%eax
8010225d:	e8 f6 fe ff ff       	call   80102158 <lapicw>
  lapicw(ESR, 0);
80102262:	ba 00 00 00 00       	mov    $0x0,%edx
80102267:	b8 a0 00 00 00       	mov    $0xa0,%eax
8010226c:	e8 e7 fe ff ff       	call   80102158 <lapicw>
  lapicw(ESR, 0);
80102271:	ba 00 00 00 00       	mov    $0x0,%edx
80102276:	b8 a0 00 00 00       	mov    $0xa0,%eax
8010227b:	e8 d8 fe ff ff       	call   80102158 <lapicw>
  lapicw(EOI, 0);
80102280:	ba 00 00 00 00       	mov    $0x0,%edx
80102285:	b8 2c 00 00 00       	mov    $0x2c,%eax
8010228a:	e8 c9 fe ff ff       	call   80102158 <lapicw>
  lapicw(ICRHI, 0);
8010228f:	ba 00 00 00 00       	mov    $0x0,%edx
80102294:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102299:	e8 ba fe ff ff       	call   80102158 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
8010229e:	ba 00 85 08 00       	mov    $0x88500,%edx
801022a3:	b8 c0 00 00 00       	mov    $0xc0,%eax
801022a8:	e8 ab fe ff ff       	call   80102158 <lapicw>
  while(lapic[ICRLO] & DELIVS)
801022ad:	a1 80 06 11 80       	mov    0x80110680,%eax
801022b2:	8b 80 00 03 00 00    	mov    0x300(%eax),%eax
801022b8:	f6 c4 10             	test   $0x10,%ah
801022bb:	75 f0                	jne    801022ad <lapicinit+0xd6>
  lapicw(TPR, 0);
801022bd:	ba 00 00 00 00       	mov    $0x0,%edx
801022c2:	b8 20 00 00 00       	mov    $0x20,%eax
801022c7:	e8 8c fe ff ff       	call   80102158 <lapicw>
}
801022cc:	c9                   	leave  
801022cd:	c3                   	ret    
    lapicw(PCINT, MASKED);
801022ce:	ba 00 00 01 00       	mov    $0x10000,%edx
801022d3:	b8 d0 00 00 00       	mov    $0xd0,%eax
801022d8:	e8 7b fe ff ff       	call   80102158 <lapicw>
801022dd:	e9 71 ff ff ff       	jmp    80102253 <lapicinit+0x7c>
801022e2:	c3                   	ret    

801022e3 <lapicid>:
  if (!lapic)
801022e3:	a1 80 06 11 80       	mov    0x80110680,%eax
801022e8:	85 c0                	test   %eax,%eax
801022ea:	74 07                	je     801022f3 <lapicid+0x10>
  return lapic[ID] >> 24;
801022ec:	8b 40 20             	mov    0x20(%eax),%eax
801022ef:	c1 e8 18             	shr    $0x18,%eax
801022f2:	c3                   	ret    
    return 0;
801022f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022f8:	c3                   	ret    

801022f9 <lapiceoi>:
  if(lapic)
801022f9:	83 3d 80 06 11 80 00 	cmpl   $0x0,0x80110680
80102300:	74 17                	je     80102319 <lapiceoi+0x20>
{
80102302:	55                   	push   %ebp
80102303:	89 e5                	mov    %esp,%ebp
80102305:	83 ec 08             	sub    $0x8,%esp
    lapicw(EOI, 0);
80102308:	ba 00 00 00 00       	mov    $0x0,%edx
8010230d:	b8 2c 00 00 00       	mov    $0x2c,%eax
80102312:	e8 41 fe ff ff       	call   80102158 <lapicw>
}
80102317:	c9                   	leave  
80102318:	c3                   	ret    
80102319:	c3                   	ret    

8010231a <microdelay>:
}
8010231a:	c3                   	ret    

8010231b <lapicstartap>:
{
8010231b:	55                   	push   %ebp
8010231c:	89 e5                	mov    %esp,%ebp
8010231e:	57                   	push   %edi
8010231f:	56                   	push   %esi
80102320:	53                   	push   %ebx
80102321:	83 ec 0c             	sub    $0xc,%esp
80102324:	8b 75 08             	mov    0x8(%ebp),%esi
80102327:	8b 7d 0c             	mov    0xc(%ebp),%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010232a:	b0 0f                	mov    $0xf,%al
8010232c:	ba 70 00 00 00       	mov    $0x70,%edx
80102331:	ee                   	out    %al,(%dx)
80102332:	b0 0a                	mov    $0xa,%al
80102334:	ba 71 00 00 00       	mov    $0x71,%edx
80102339:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
8010233a:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
80102341:	00 00 
  wrv[1] = addr >> 4;
80102343:	89 f8                	mov    %edi,%eax
80102345:	c1 e8 04             	shr    $0x4,%eax
80102348:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapicw(ICRHI, apicid<<24);
8010234e:	c1 e6 18             	shl    $0x18,%esi
80102351:	89 f2                	mov    %esi,%edx
80102353:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102358:	e8 fb fd ff ff       	call   80102158 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
8010235d:	ba 00 c5 00 00       	mov    $0xc500,%edx
80102362:	b8 c0 00 00 00       	mov    $0xc0,%eax
80102367:	e8 ec fd ff ff       	call   80102158 <lapicw>
  lapicw(ICRLO, INIT | LEVEL);
8010236c:	ba 00 85 00 00       	mov    $0x8500,%edx
80102371:	b8 c0 00 00 00       	mov    $0xc0,%eax
80102376:	e8 dd fd ff ff       	call   80102158 <lapicw>
  for(i = 0; i < 2; i++){
8010237b:	bb 00 00 00 00       	mov    $0x0,%ebx
80102380:	eb 1f                	jmp    801023a1 <lapicstartap+0x86>
    lapicw(ICRHI, apicid<<24);
80102382:	89 f2                	mov    %esi,%edx
80102384:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102389:	e8 ca fd ff ff       	call   80102158 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
8010238e:	89 fa                	mov    %edi,%edx
80102390:	c1 ea 0c             	shr    $0xc,%edx
80102393:	80 ce 06             	or     $0x6,%dh
80102396:	b8 c0 00 00 00       	mov    $0xc0,%eax
8010239b:	e8 b8 fd ff ff       	call   80102158 <lapicw>
  for(i = 0; i < 2; i++){
801023a0:	43                   	inc    %ebx
801023a1:	83 fb 01             	cmp    $0x1,%ebx
801023a4:	7e dc                	jle    80102382 <lapicstartap+0x67>
}
801023a6:	83 c4 0c             	add    $0xc,%esp
801023a9:	5b                   	pop    %ebx
801023aa:	5e                   	pop    %esi
801023ab:	5f                   	pop    %edi
801023ac:	5d                   	pop    %ebp
801023ad:	c3                   	ret    

801023ae <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801023ae:	55                   	push   %ebp
801023af:	89 e5                	mov    %esp,%ebp
801023b1:	57                   	push   %edi
801023b2:	56                   	push   %esi
801023b3:	53                   	push   %ebx
801023b4:	83 ec 3c             	sub    $0x3c,%esp
801023b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801023ba:	b8 0b 00 00 00       	mov    $0xb,%eax
801023bf:	e8 a8 fd ff ff       	call   8010216c <cmos_read>

  bcd = (sb & (1 << 2)) == 0;
801023c4:	83 e0 04             	and    $0x4,%eax
801023c7:	89 c7                	mov    %eax,%edi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
801023c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
801023cc:	e8 ab fd ff ff       	call   8010217c <fill_rtcdate>
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801023d1:	b8 0a 00 00 00       	mov    $0xa,%eax
801023d6:	e8 91 fd ff ff       	call   8010216c <cmos_read>
801023db:	a8 80                	test   $0x80,%al
801023dd:	75 ea                	jne    801023c9 <cmostime+0x1b>
        continue;
    fill_rtcdate(&t2);
801023df:	8d 75 b8             	lea    -0x48(%ebp),%esi
801023e2:	89 f0                	mov    %esi,%eax
801023e4:	e8 93 fd ff ff       	call   8010217c <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801023e9:	83 ec 04             	sub    $0x4,%esp
801023ec:	6a 18                	push   $0x18
801023ee:	56                   	push   %esi
801023ef:	8d 45 d0             	lea    -0x30(%ebp),%eax
801023f2:	50                   	push   %eax
801023f3:	e8 b6 17 00 00       	call   80103bae <memcmp>
801023f8:	83 c4 10             	add    $0x10,%esp
801023fb:	85 c0                	test   %eax,%eax
801023fd:	75 ca                	jne    801023c9 <cmostime+0x1b>
      break;
  }

  // convert
  if(bcd) {
801023ff:	85 ff                	test   %edi,%edi
80102401:	75 7e                	jne    80102481 <cmostime+0xd3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102403:	8b 55 d0             	mov    -0x30(%ebp),%edx
80102406:	89 d0                	mov    %edx,%eax
80102408:	c1 e8 04             	shr    $0x4,%eax
8010240b:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010240e:	01 c0                	add    %eax,%eax
80102410:	83 e2 0f             	and    $0xf,%edx
80102413:	01 d0                	add    %edx,%eax
80102415:	89 45 d0             	mov    %eax,-0x30(%ebp)
    CONV(minute);
80102418:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010241b:	89 d0                	mov    %edx,%eax
8010241d:	c1 e8 04             	shr    $0x4,%eax
80102420:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102423:	01 c0                	add    %eax,%eax
80102425:	83 e2 0f             	and    $0xf,%edx
80102428:	01 d0                	add    %edx,%eax
8010242a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    CONV(hour  );
8010242d:	8b 55 d8             	mov    -0x28(%ebp),%edx
80102430:	89 d0                	mov    %edx,%eax
80102432:	c1 e8 04             	shr    $0x4,%eax
80102435:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102438:	01 c0                	add    %eax,%eax
8010243a:	83 e2 0f             	and    $0xf,%edx
8010243d:	01 d0                	add    %edx,%eax
8010243f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(day   );
80102442:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102445:	89 d0                	mov    %edx,%eax
80102447:	c1 e8 04             	shr    $0x4,%eax
8010244a:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010244d:	01 c0                	add    %eax,%eax
8010244f:	83 e2 0f             	and    $0xf,%edx
80102452:	01 d0                	add    %edx,%eax
80102454:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(month );
80102457:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010245a:	89 d0                	mov    %edx,%eax
8010245c:	c1 e8 04             	shr    $0x4,%eax
8010245f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102462:	01 c0                	add    %eax,%eax
80102464:	83 e2 0f             	and    $0xf,%edx
80102467:	01 d0                	add    %edx,%eax
80102469:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(year  );
8010246c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010246f:	89 d0                	mov    %edx,%eax
80102471:	c1 e8 04             	shr    $0x4,%eax
80102474:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102477:	01 c0                	add    %eax,%eax
80102479:	83 e2 0f             	and    $0xf,%edx
8010247c:	01 d0                	add    %edx,%eax
8010247e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
#undef     CONV
  }

  *r = t1;
80102481:	8d 75 d0             	lea    -0x30(%ebp),%esi
80102484:	b9 06 00 00 00       	mov    $0x6,%ecx
80102489:	89 df                	mov    %ebx,%edi
8010248b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
8010248d:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102494:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102497:	5b                   	pop    %ebx
80102498:	5e                   	pop    %esi
80102499:	5f                   	pop    %edi
8010249a:	5d                   	pop    %ebp
8010249b:	c3                   	ret    

8010249c <read_head>:
}

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
8010249c:	55                   	push   %ebp
8010249d:	89 e5                	mov    %esp,%ebp
8010249f:	53                   	push   %ebx
801024a0:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
801024a3:	ff 35 d4 06 11 80    	push   0x801106d4
801024a9:	ff 35 e4 06 11 80    	push   0x801106e4
801024af:	e8 b6 dc ff ff       	call   8010016a <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
801024b4:	8b 58 5c             	mov    0x5c(%eax),%ebx
801024b7:	89 1d e8 06 11 80    	mov    %ebx,0x801106e8
  for (i = 0; i < log.lh.n; i++) {
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	ba 00 00 00 00       	mov    $0x0,%edx
801024c5:	eb 0c                	jmp    801024d3 <read_head+0x37>
    log.lh.block[i] = lh->block[i];
801024c7:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801024cb:	89 0c 95 ec 06 11 80 	mov    %ecx,-0x7feef914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801024d2:	42                   	inc    %edx
801024d3:	39 d3                	cmp    %edx,%ebx
801024d5:	7f f0                	jg     801024c7 <read_head+0x2b>
  }
  brelse(buf);
801024d7:	83 ec 0c             	sub    $0xc,%esp
801024da:	50                   	push   %eax
801024db:	e8 f3 dc ff ff       	call   801001d3 <brelse>
}
801024e0:	83 c4 10             	add    $0x10,%esp
801024e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024e6:	c9                   	leave  
801024e7:	c3                   	ret    

801024e8 <install_trans>:
{
801024e8:	55                   	push   %ebp
801024e9:	89 e5                	mov    %esp,%ebp
801024eb:	57                   	push   %edi
801024ec:	56                   	push   %esi
801024ed:	53                   	push   %ebx
801024ee:	83 ec 0c             	sub    $0xc,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
801024f1:	be 00 00 00 00       	mov    $0x0,%esi
801024f6:	eb 62                	jmp    8010255a <install_trans+0x72>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801024f8:	89 f0                	mov    %esi,%eax
801024fa:	03 05 d4 06 11 80    	add    0x801106d4,%eax
80102500:	40                   	inc    %eax
80102501:	83 ec 08             	sub    $0x8,%esp
80102504:	50                   	push   %eax
80102505:	ff 35 e4 06 11 80    	push   0x801106e4
8010250b:	e8 5a dc ff ff       	call   8010016a <bread>
80102510:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102512:	83 c4 08             	add    $0x8,%esp
80102515:	ff 34 b5 ec 06 11 80 	push   -0x7feef914(,%esi,4)
8010251c:	ff 35 e4 06 11 80    	push   0x801106e4
80102522:	e8 43 dc ff ff       	call   8010016a <bread>
80102527:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102529:	8d 57 5c             	lea    0x5c(%edi),%edx
8010252c:	8d 40 5c             	lea    0x5c(%eax),%eax
8010252f:	83 c4 0c             	add    $0xc,%esp
80102532:	68 00 02 00 00       	push   $0x200
80102537:	52                   	push   %edx
80102538:	50                   	push   %eax
80102539:	e8 9f 16 00 00       	call   80103bdd <memmove>
    bwrite(dbuf);  // write dst to disk
8010253e:	89 1c 24             	mov    %ebx,(%esp)
80102541:	e8 52 dc ff ff       	call   80100198 <bwrite>
    brelse(lbuf);
80102546:	89 3c 24             	mov    %edi,(%esp)
80102549:	e8 85 dc ff ff       	call   801001d3 <brelse>
    brelse(dbuf);
8010254e:	89 1c 24             	mov    %ebx,(%esp)
80102551:	e8 7d dc ff ff       	call   801001d3 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102556:	46                   	inc    %esi
80102557:	83 c4 10             	add    $0x10,%esp
8010255a:	39 35 e8 06 11 80    	cmp    %esi,0x801106e8
80102560:	7f 96                	jg     801024f8 <install_trans+0x10>
}
80102562:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102565:	5b                   	pop    %ebx
80102566:	5e                   	pop    %esi
80102567:	5f                   	pop    %edi
80102568:	5d                   	pop    %ebp
80102569:	c3                   	ret    

8010256a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010256a:	55                   	push   %ebp
8010256b:	89 e5                	mov    %esp,%ebp
8010256d:	53                   	push   %ebx
8010256e:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102571:	ff 35 d4 06 11 80    	push   0x801106d4
80102577:	ff 35 e4 06 11 80    	push   0x801106e4
8010257d:	e8 e8 db ff ff       	call   8010016a <bread>
80102582:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102584:	8b 0d e8 06 11 80    	mov    0x801106e8,%ecx
8010258a:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010258d:	83 c4 10             	add    $0x10,%esp
80102590:	b8 00 00 00 00       	mov    $0x0,%eax
80102595:	eb 0c                	jmp    801025a3 <write_head+0x39>
    hb->block[i] = log.lh.block[i];
80102597:	8b 14 85 ec 06 11 80 	mov    -0x7feef914(,%eax,4),%edx
8010259e:	89 54 83 60          	mov    %edx,0x60(%ebx,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
801025a2:	40                   	inc    %eax
801025a3:	39 c1                	cmp    %eax,%ecx
801025a5:	7f f0                	jg     80102597 <write_head+0x2d>
  }
  bwrite(buf);
801025a7:	83 ec 0c             	sub    $0xc,%esp
801025aa:	53                   	push   %ebx
801025ab:	e8 e8 db ff ff       	call   80100198 <bwrite>
  brelse(buf);
801025b0:	89 1c 24             	mov    %ebx,(%esp)
801025b3:	e8 1b dc ff ff       	call   801001d3 <brelse>
}
801025b8:	83 c4 10             	add    $0x10,%esp
801025bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025be:	c9                   	leave  
801025bf:	c3                   	ret    

801025c0 <recover_from_log>:

static void
recover_from_log(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	83 ec 08             	sub    $0x8,%esp
  read_head();
801025c6:	e8 d1 fe ff ff       	call   8010249c <read_head>
  install_trans(); // if committed, copy from log to disk
801025cb:	e8 18 ff ff ff       	call   801024e8 <install_trans>
  log.lh.n = 0;
801025d0:	c7 05 e8 06 11 80 00 	movl   $0x0,0x801106e8
801025d7:	00 00 00 
  write_head(); // clear the log
801025da:	e8 8b ff ff ff       	call   8010256a <write_head>
}
801025df:	c9                   	leave  
801025e0:	c3                   	ret    

801025e1 <write_log>:
}

// Copy modified blocks from cache to log.
static void
write_log(void)
{
801025e1:	55                   	push   %ebp
801025e2:	89 e5                	mov    %esp,%ebp
801025e4:	57                   	push   %edi
801025e5:	56                   	push   %esi
801025e6:	53                   	push   %ebx
801025e7:	83 ec 0c             	sub    $0xc,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801025ea:	be 00 00 00 00       	mov    $0x0,%esi
801025ef:	eb 62                	jmp    80102653 <write_log+0x72>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801025f1:	89 f0                	mov    %esi,%eax
801025f3:	03 05 d4 06 11 80    	add    0x801106d4,%eax
801025f9:	40                   	inc    %eax
801025fa:	83 ec 08             	sub    $0x8,%esp
801025fd:	50                   	push   %eax
801025fe:	ff 35 e4 06 11 80    	push   0x801106e4
80102604:	e8 61 db ff ff       	call   8010016a <bread>
80102609:	89 c3                	mov    %eax,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010260b:	83 c4 08             	add    $0x8,%esp
8010260e:	ff 34 b5 ec 06 11 80 	push   -0x7feef914(,%esi,4)
80102615:	ff 35 e4 06 11 80    	push   0x801106e4
8010261b:	e8 4a db ff ff       	call   8010016a <bread>
80102620:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102622:	8d 50 5c             	lea    0x5c(%eax),%edx
80102625:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102628:	83 c4 0c             	add    $0xc,%esp
8010262b:	68 00 02 00 00       	push   $0x200
80102630:	52                   	push   %edx
80102631:	50                   	push   %eax
80102632:	e8 a6 15 00 00       	call   80103bdd <memmove>
    bwrite(to);  // write the log
80102637:	89 1c 24             	mov    %ebx,(%esp)
8010263a:	e8 59 db ff ff       	call   80100198 <bwrite>
    brelse(from);
8010263f:	89 3c 24             	mov    %edi,(%esp)
80102642:	e8 8c db ff ff       	call   801001d3 <brelse>
    brelse(to);
80102647:	89 1c 24             	mov    %ebx,(%esp)
8010264a:	e8 84 db ff ff       	call   801001d3 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
8010264f:	46                   	inc    %esi
80102650:	83 c4 10             	add    $0x10,%esp
80102653:	39 35 e8 06 11 80    	cmp    %esi,0x801106e8
80102659:	7f 96                	jg     801025f1 <write_log+0x10>
  }
}
8010265b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010265e:	5b                   	pop    %ebx
8010265f:	5e                   	pop    %esi
80102660:	5f                   	pop    %edi
80102661:	5d                   	pop    %ebp
80102662:	c3                   	ret    

80102663 <commit>:

static void
commit()
{
  if (log.lh.n > 0) {
80102663:	83 3d e8 06 11 80 00 	cmpl   $0x0,0x801106e8
8010266a:	7f 01                	jg     8010266d <commit+0xa>
8010266c:	c3                   	ret    
{
8010266d:	55                   	push   %ebp
8010266e:	89 e5                	mov    %esp,%ebp
80102670:	83 ec 08             	sub    $0x8,%esp
    write_log();     // Write modified blocks from cache to log
80102673:	e8 69 ff ff ff       	call   801025e1 <write_log>
    write_head();    // Write header to disk -- the real commit
80102678:	e8 ed fe ff ff       	call   8010256a <write_head>
    install_trans(); // Now install writes to home locations
8010267d:	e8 66 fe ff ff       	call   801024e8 <install_trans>
    log.lh.n = 0;
80102682:	c7 05 e8 06 11 80 00 	movl   $0x0,0x801106e8
80102689:	00 00 00 
    write_head();    // Erase the transaction from the log
8010268c:	e8 d9 fe ff ff       	call   8010256a <write_head>
  }
}
80102691:	c9                   	leave  
80102692:	c3                   	ret    

80102693 <initlog>:
{
80102693:	55                   	push   %ebp
80102694:	89 e5                	mov    %esp,%ebp
80102696:	53                   	push   %ebx
80102697:	83 ec 2c             	sub    $0x2c,%esp
8010269a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010269d:	68 40 6a 10 80       	push   $0x80106a40
801026a2:	68 a0 06 11 80       	push   $0x801106a0
801026a7:	e8 d8 12 00 00       	call   80103984 <initlock>
  readsb(dev, &sb);
801026ac:	83 c4 08             	add    $0x8,%esp
801026af:	8d 45 dc             	lea    -0x24(%ebp),%eax
801026b2:	50                   	push   %eax
801026b3:	53                   	push   %ebx
801026b4:	e8 0e eb ff ff       	call   801011c7 <readsb>
  log.start = sb.logstart;
801026b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801026bc:	a3 d4 06 11 80       	mov    %eax,0x801106d4
  log.size = sb.nlog;
801026c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801026c4:	a3 d8 06 11 80       	mov    %eax,0x801106d8
  log.dev = dev;
801026c9:	89 1d e4 06 11 80    	mov    %ebx,0x801106e4
  recover_from_log();
801026cf:	e8 ec fe ff ff       	call   801025c0 <recover_from_log>
}
801026d4:	83 c4 10             	add    $0x10,%esp
801026d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026da:	c9                   	leave  
801026db:	c3                   	ret    

801026dc <begin_op>:
{
801026dc:	55                   	push   %ebp
801026dd:	89 e5                	mov    %esp,%ebp
801026df:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801026e2:	68 a0 06 11 80       	push   $0x801106a0
801026e7:	e8 cf 13 00 00       	call   80103abb <acquire>
801026ec:	83 c4 10             	add    $0x10,%esp
801026ef:	eb 15                	jmp    80102706 <begin_op+0x2a>
      sleep(&log, &log.lock);
801026f1:	83 ec 08             	sub    $0x8,%esp
801026f4:	68 a0 06 11 80       	push   $0x801106a0
801026f9:	68 a0 06 11 80       	push   $0x801106a0
801026fe:	e8 c2 0e 00 00       	call   801035c5 <sleep>
80102703:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102706:	83 3d e0 06 11 80 00 	cmpl   $0x0,0x801106e0
8010270d:	75 e2                	jne    801026f1 <begin_op+0x15>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010270f:	a1 dc 06 11 80       	mov    0x801106dc,%eax
80102714:	8d 48 01             	lea    0x1(%eax),%ecx
80102717:	8d 54 80 05          	lea    0x5(%eax,%eax,4),%edx
8010271b:	8d 04 12             	lea    (%edx,%edx,1),%eax
8010271e:	03 05 e8 06 11 80    	add    0x801106e8,%eax
80102724:	83 f8 1e             	cmp    $0x1e,%eax
80102727:	7e 17                	jle    80102740 <begin_op+0x64>
      sleep(&log, &log.lock);
80102729:	83 ec 08             	sub    $0x8,%esp
8010272c:	68 a0 06 11 80       	push   $0x801106a0
80102731:	68 a0 06 11 80       	push   $0x801106a0
80102736:	e8 8a 0e 00 00       	call   801035c5 <sleep>
8010273b:	83 c4 10             	add    $0x10,%esp
8010273e:	eb c6                	jmp    80102706 <begin_op+0x2a>
      log.outstanding += 1;
80102740:	89 0d dc 06 11 80    	mov    %ecx,0x801106dc
      release(&log.lock);
80102746:	83 ec 0c             	sub    $0xc,%esp
80102749:	68 a0 06 11 80       	push   $0x801106a0
8010274e:	e8 cd 13 00 00       	call   80103b20 <release>
}
80102753:	83 c4 10             	add    $0x10,%esp
80102756:	c9                   	leave  
80102757:	c3                   	ret    

80102758 <end_op>:
{
80102758:	55                   	push   %ebp
80102759:	89 e5                	mov    %esp,%ebp
8010275b:	53                   	push   %ebx
8010275c:	83 ec 10             	sub    $0x10,%esp
  acquire(&log.lock);
8010275f:	68 a0 06 11 80       	push   $0x801106a0
80102764:	e8 52 13 00 00       	call   80103abb <acquire>
  log.outstanding -= 1;
80102769:	a1 dc 06 11 80       	mov    0x801106dc,%eax
8010276e:	48                   	dec    %eax
8010276f:	a3 dc 06 11 80       	mov    %eax,0x801106dc
  if(log.committing)
80102774:	8b 1d e0 06 11 80    	mov    0x801106e0,%ebx
8010277a:	83 c4 10             	add    $0x10,%esp
8010277d:	85 db                	test   %ebx,%ebx
8010277f:	75 2c                	jne    801027ad <end_op+0x55>
  if(log.outstanding == 0){
80102781:	85 c0                	test   %eax,%eax
80102783:	75 35                	jne    801027ba <end_op+0x62>
    log.committing = 1;
80102785:	c7 05 e0 06 11 80 01 	movl   $0x1,0x801106e0
8010278c:	00 00 00 
    do_commit = 1;
8010278f:	bb 01 00 00 00       	mov    $0x1,%ebx
  release(&log.lock);
80102794:	83 ec 0c             	sub    $0xc,%esp
80102797:	68 a0 06 11 80       	push   $0x801106a0
8010279c:	e8 7f 13 00 00       	call   80103b20 <release>
  if(do_commit){
801027a1:	83 c4 10             	add    $0x10,%esp
801027a4:	85 db                	test   %ebx,%ebx
801027a6:	75 24                	jne    801027cc <end_op+0x74>
}
801027a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027ab:	c9                   	leave  
801027ac:	c3                   	ret    
    panic("log.committing");
801027ad:	83 ec 0c             	sub    $0xc,%esp
801027b0:	68 44 6a 10 80       	push   $0x80106a44
801027b5:	e8 87 db ff ff       	call   80100341 <panic>
    wakeup(&log);
801027ba:	83 ec 0c             	sub    $0xc,%esp
801027bd:	68 a0 06 11 80       	push   $0x801106a0
801027c2:	e8 65 0f 00 00       	call   8010372c <wakeup>
801027c7:	83 c4 10             	add    $0x10,%esp
801027ca:	eb c8                	jmp    80102794 <end_op+0x3c>
    commit();
801027cc:	e8 92 fe ff ff       	call   80102663 <commit>
    acquire(&log.lock);
801027d1:	83 ec 0c             	sub    $0xc,%esp
801027d4:	68 a0 06 11 80       	push   $0x801106a0
801027d9:	e8 dd 12 00 00       	call   80103abb <acquire>
    log.committing = 0;
801027de:	c7 05 e0 06 11 80 00 	movl   $0x0,0x801106e0
801027e5:	00 00 00 
    wakeup(&log);
801027e8:	c7 04 24 a0 06 11 80 	movl   $0x801106a0,(%esp)
801027ef:	e8 38 0f 00 00       	call   8010372c <wakeup>
    release(&log.lock);
801027f4:	c7 04 24 a0 06 11 80 	movl   $0x801106a0,(%esp)
801027fb:	e8 20 13 00 00       	call   80103b20 <release>
80102800:	83 c4 10             	add    $0x10,%esp
}
80102803:	eb a3                	jmp    801027a8 <end_op+0x50>

80102805 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102805:	55                   	push   %ebp
80102806:	89 e5                	mov    %esp,%ebp
80102808:	53                   	push   %ebx
80102809:	83 ec 04             	sub    $0x4,%esp
8010280c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010280f:	8b 15 e8 06 11 80    	mov    0x801106e8,%edx
80102815:	83 fa 1d             	cmp    $0x1d,%edx
80102818:	7f 2a                	jg     80102844 <log_write+0x3f>
8010281a:	a1 d8 06 11 80       	mov    0x801106d8,%eax
8010281f:	48                   	dec    %eax
80102820:	39 c2                	cmp    %eax,%edx
80102822:	7d 20                	jge    80102844 <log_write+0x3f>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102824:	83 3d dc 06 11 80 00 	cmpl   $0x0,0x801106dc
8010282b:	7e 24                	jle    80102851 <log_write+0x4c>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010282d:	83 ec 0c             	sub    $0xc,%esp
80102830:	68 a0 06 11 80       	push   $0x801106a0
80102835:	e8 81 12 00 00       	call   80103abb <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010283a:	83 c4 10             	add    $0x10,%esp
8010283d:	b8 00 00 00 00       	mov    $0x0,%eax
80102842:	eb 1b                	jmp    8010285f <log_write+0x5a>
    panic("too big a transaction");
80102844:	83 ec 0c             	sub    $0xc,%esp
80102847:	68 53 6a 10 80       	push   $0x80106a53
8010284c:	e8 f0 da ff ff       	call   80100341 <panic>
    panic("log_write outside of trans");
80102851:	83 ec 0c             	sub    $0xc,%esp
80102854:	68 69 6a 10 80       	push   $0x80106a69
80102859:	e8 e3 da ff ff       	call   80100341 <panic>
  for (i = 0; i < log.lh.n; i++) {
8010285e:	40                   	inc    %eax
8010285f:	8b 15 e8 06 11 80    	mov    0x801106e8,%edx
80102865:	39 c2                	cmp    %eax,%edx
80102867:	7e 0c                	jle    80102875 <log_write+0x70>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102869:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010286c:	39 0c 85 ec 06 11 80 	cmp    %ecx,-0x7feef914(,%eax,4)
80102873:	75 e9                	jne    8010285e <log_write+0x59>
      break;
  }
  log.lh.block[i] = b->blockno;
80102875:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102878:	89 0c 85 ec 06 11 80 	mov    %ecx,-0x7feef914(,%eax,4)
  if (i == log.lh.n)
8010287f:	39 c2                	cmp    %eax,%edx
80102881:	74 18                	je     8010289b <log_write+0x96>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102883:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102886:	83 ec 0c             	sub    $0xc,%esp
80102889:	68 a0 06 11 80       	push   $0x801106a0
8010288e:	e8 8d 12 00 00       	call   80103b20 <release>
}
80102893:	83 c4 10             	add    $0x10,%esp
80102896:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102899:	c9                   	leave  
8010289a:	c3                   	ret    
    log.lh.n++;
8010289b:	42                   	inc    %edx
8010289c:	89 15 e8 06 11 80    	mov    %edx,0x801106e8
801028a2:	eb df                	jmp    80102883 <log_write+0x7e>

801028a4 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801028a4:	55                   	push   %ebp
801028a5:	89 e5                	mov    %esp,%ebp
801028a7:	53                   	push   %ebx
801028a8:	83 ec 08             	sub    $0x8,%esp

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801028ab:	68 8e 00 00 00       	push   $0x8e
801028b0:	68 8c 94 10 80       	push   $0x8010948c
801028b5:	68 00 70 00 80       	push   $0x80007000
801028ba:	e8 1e 13 00 00       	call   80103bdd <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801028bf:	83 c4 10             	add    $0x10,%esp
801028c2:	bb a0 07 11 80       	mov    $0x801107a0,%ebx
801028c7:	eb 06                	jmp    801028cf <startothers+0x2b>
801028c9:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801028cf:	8b 15 84 07 11 80    	mov    0x80110784,%edx
801028d5:	8d 04 92             	lea    (%edx,%edx,4),%eax
801028d8:	01 c0                	add    %eax,%eax
801028da:	01 d0                	add    %edx,%eax
801028dc:	c1 e0 04             	shl    $0x4,%eax
801028df:	05 a0 07 11 80       	add    $0x801107a0,%eax
801028e4:	39 d8                	cmp    %ebx,%eax
801028e6:	76 4c                	jbe    80102934 <startothers+0x90>
    if(c == mycpu())  // We've started already.
801028e8:	e8 97 07 00 00       	call   80103084 <mycpu>
801028ed:	39 c3                	cmp    %eax,%ebx
801028ef:	74 d8                	je     801028c9 <startothers+0x25>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801028f1:	e8 31 f7 ff ff       	call   80102027 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801028f6:	05 00 10 00 00       	add    $0x1000,%eax
801028fb:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
80102900:	c7 05 f8 6f 00 80 78 	movl   $0x80102978,0x80006ff8
80102907:	29 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010290a:	c7 05 f4 6f 00 80 00 	movl   $0x108000,0x80006ff4
80102911:	80 10 00 

    lapicstartap(c->apicid, V2P(code));
80102914:	83 ec 08             	sub    $0x8,%esp
80102917:	68 00 70 00 00       	push   $0x7000
8010291c:	0f b6 03             	movzbl (%ebx),%eax
8010291f:	50                   	push   %eax
80102920:	e8 f6 f9 ff ff       	call   8010231b <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102925:	83 c4 10             	add    $0x10,%esp
80102928:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
8010292e:	85 c0                	test   %eax,%eax
80102930:	74 f6                	je     80102928 <startothers+0x84>
80102932:	eb 95                	jmp    801028c9 <startothers+0x25>
      ;
  }
}
80102934:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102937:	c9                   	leave  
80102938:	c3                   	ret    

80102939 <mpmain>:
{
80102939:	55                   	push   %ebp
8010293a:	89 e5                	mov    %esp,%ebp
8010293c:	53                   	push   %ebx
8010293d:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102940:	e8 a3 07 00 00       	call   801030e8 <cpuid>
80102945:	89 c3                	mov    %eax,%ebx
80102947:	e8 9c 07 00 00       	call   801030e8 <cpuid>
8010294c:	83 ec 04             	sub    $0x4,%esp
8010294f:	53                   	push   %ebx
80102950:	50                   	push   %eax
80102951:	68 84 6a 10 80       	push   $0x80106a84
80102956:	e8 7f dc ff ff       	call   801005da <cprintf>
  idtinit();       // load idt register
8010295b:	e8 16 24 00 00       	call   80104d76 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102960:	e8 1f 07 00 00       	call   80103084 <mycpu>
80102965:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102967:	b8 01 00 00 00       	mov    $0x1,%eax
8010296c:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102973:	e8 19 0a 00 00       	call   80103391 <scheduler>

80102978 <mpenter>:
{
80102978:	55                   	push   %ebp
80102979:	89 e5                	mov    %esp,%ebp
8010297b:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010297e:	e8 62 35 00 00       	call   80105ee5 <switchkvm>
  seginit();
80102983:	e8 8d 32 00 00       	call   80105c15 <seginit>
  lapicinit();
80102988:	e8 4a f8 ff ff       	call   801021d7 <lapicinit>
  mpmain();
8010298d:	e8 a7 ff ff ff       	call   80102939 <mpmain>

80102992 <main>:
{
80102992:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102996:	83 e4 f0             	and    $0xfffffff0,%esp
80102999:	ff 71 fc             	push   -0x4(%ecx)
8010299c:	55                   	push   %ebp
8010299d:	89 e5                	mov    %esp,%ebp
8010299f:	51                   	push   %ecx
801029a0:	83 ec 0c             	sub    $0xc,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801029a3:	68 00 00 40 80       	push   $0x80400000
801029a8:	68 d0 44 11 80       	push   $0x801144d0
801029ad:	e8 23 f6 ff ff       	call   80101fd5 <kinit1>
  kvmalloc();      // kernel page table
801029b2:	e8 fb 39 00 00       	call   801063b2 <kvmalloc>
  mpinit();        // detect other processors
801029b7:	e8 b8 01 00 00       	call   80102b74 <mpinit>
  lapicinit();     // interrupt controller
801029bc:	e8 16 f8 ff ff       	call   801021d7 <lapicinit>
  seginit();       // segment descriptors
801029c1:	e8 4f 32 00 00       	call   80105c15 <seginit>
  picinit();       // disable pic
801029c6:	e8 79 02 00 00       	call   80102c44 <picinit>
  ioapicinit();    // another interrupt controller
801029cb:	e8 93 f4 ff ff       	call   80101e63 <ioapicinit>
  consoleinit();   // console hardware
801029d0:	e8 77 de ff ff       	call   8010084c <consoleinit>
  uartinit();      // serial port
801029d5:	e8 3d 26 00 00       	call   80105017 <uartinit>
  pinit();         // process table
801029da:	e8 8b 06 00 00       	call   8010306a <pinit>
  tvinit();        // trap vectors
801029df:	e8 95 22 00 00       	call   80104c79 <tvinit>
  binit();         // buffer cache
801029e4:	e8 09 d7 ff ff       	call   801000f2 <binit>
  fileinit();      // file table
801029e9:	e8 de e1 ff ff       	call   80100bcc <fileinit>
  ideinit();       // disk 
801029ee:	e8 86 f2 ff ff       	call   80101c79 <ideinit>
  startothers();   // start other processors
801029f3:	e8 ac fe ff ff       	call   801028a4 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801029f8:	83 c4 08             	add    $0x8,%esp
801029fb:	68 00 00 00 8e       	push   $0x8e000000
80102a00:	68 00 00 40 80       	push   $0x80400000
80102a05:	e8 fd f5 ff ff       	call   80102007 <kinit2>
  userinit();      // first user process
80102a0a:	e8 2d 07 00 00       	call   8010313c <userinit>
  mpmain();        // finish this processor's setup
80102a0f:	e8 25 ff ff ff       	call   80102939 <mpmain>

80102a14 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80102a14:	55                   	push   %ebp
80102a15:	89 e5                	mov    %esp,%ebp
80102a17:	56                   	push   %esi
80102a18:	53                   	push   %ebx
80102a19:	89 c6                	mov    %eax,%esi
  int i, sum;

  sum = 0;
80102a1b:	b8 00 00 00 00       	mov    $0x0,%eax
  for(i=0; i<len; i++)
80102a20:	b9 00 00 00 00       	mov    $0x0,%ecx
80102a25:	eb 07                	jmp    80102a2e <sum+0x1a>
    sum += addr[i];
80102a27:	0f b6 1c 0e          	movzbl (%esi,%ecx,1),%ebx
80102a2b:	01 d8                	add    %ebx,%eax
  for(i=0; i<len; i++)
80102a2d:	41                   	inc    %ecx
80102a2e:	39 d1                	cmp    %edx,%ecx
80102a30:	7c f5                	jl     80102a27 <sum+0x13>
  return sum;
}
80102a32:	5b                   	pop    %ebx
80102a33:	5e                   	pop    %esi
80102a34:	5d                   	pop    %ebp
80102a35:	c3                   	ret    

80102a36 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102a36:	55                   	push   %ebp
80102a37:	89 e5                	mov    %esp,%ebp
80102a39:	56                   	push   %esi
80102a3a:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
80102a3b:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80102a41:	89 f3                	mov    %esi,%ebx
  e = addr+len;
80102a43:	01 d6                	add    %edx,%esi
  for(p = addr; p < e; p += sizeof(struct mp))
80102a45:	eb 03                	jmp    80102a4a <mpsearch1+0x14>
80102a47:	83 c3 10             	add    $0x10,%ebx
80102a4a:	39 f3                	cmp    %esi,%ebx
80102a4c:	73 29                	jae    80102a77 <mpsearch1+0x41>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102a4e:	83 ec 04             	sub    $0x4,%esp
80102a51:	6a 04                	push   $0x4
80102a53:	68 98 6a 10 80       	push   $0x80106a98
80102a58:	53                   	push   %ebx
80102a59:	e8 50 11 00 00       	call   80103bae <memcmp>
80102a5e:	83 c4 10             	add    $0x10,%esp
80102a61:	85 c0                	test   %eax,%eax
80102a63:	75 e2                	jne    80102a47 <mpsearch1+0x11>
80102a65:	ba 10 00 00 00       	mov    $0x10,%edx
80102a6a:	89 d8                	mov    %ebx,%eax
80102a6c:	e8 a3 ff ff ff       	call   80102a14 <sum>
80102a71:	84 c0                	test   %al,%al
80102a73:	75 d2                	jne    80102a47 <mpsearch1+0x11>
80102a75:	eb 05                	jmp    80102a7c <mpsearch1+0x46>
      return (struct mp*)p;
  return 0;
80102a77:	bb 00 00 00 00       	mov    $0x0,%ebx
}
80102a7c:	89 d8                	mov    %ebx,%eax
80102a7e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a81:	5b                   	pop    %ebx
80102a82:	5e                   	pop    %esi
80102a83:	5d                   	pop    %ebp
80102a84:	c3                   	ret    

80102a85 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80102a85:	55                   	push   %ebp
80102a86:	89 e5                	mov    %esp,%ebp
80102a88:	83 ec 08             	sub    $0x8,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102a8b:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102a92:	c1 e0 08             	shl    $0x8,%eax
80102a95:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102a9c:	09 d0                	or     %edx,%eax
80102a9e:	c1 e0 04             	shl    $0x4,%eax
80102aa1:	74 1f                	je     80102ac2 <mpsearch+0x3d>
    if((mp = mpsearch1(p, 1024)))
80102aa3:	ba 00 04 00 00       	mov    $0x400,%edx
80102aa8:	e8 89 ff ff ff       	call   80102a36 <mpsearch1>
80102aad:	85 c0                	test   %eax,%eax
80102aaf:	75 0f                	jne    80102ac0 <mpsearch+0x3b>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80102ab1:	ba 00 00 01 00       	mov    $0x10000,%edx
80102ab6:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80102abb:	e8 76 ff ff ff       	call   80102a36 <mpsearch1>
}
80102ac0:	c9                   	leave  
80102ac1:	c3                   	ret    
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102ac2:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102ac9:	c1 e0 08             	shl    $0x8,%eax
80102acc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102ad3:	09 d0                	or     %edx,%eax
80102ad5:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102ad8:	2d 00 04 00 00       	sub    $0x400,%eax
80102add:	ba 00 04 00 00       	mov    $0x400,%edx
80102ae2:	e8 4f ff ff ff       	call   80102a36 <mpsearch1>
80102ae7:	85 c0                	test   %eax,%eax
80102ae9:	75 d5                	jne    80102ac0 <mpsearch+0x3b>
80102aeb:	eb c4                	jmp    80102ab1 <mpsearch+0x2c>

80102aed <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80102aed:	55                   	push   %ebp
80102aee:	89 e5                	mov    %esp,%ebp
80102af0:	57                   	push   %edi
80102af1:	56                   	push   %esi
80102af2:	53                   	push   %ebx
80102af3:	83 ec 1c             	sub    $0x1c,%esp
80102af6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102af9:	e8 87 ff ff ff       	call   80102a85 <mpsearch>
80102afe:	89 c3                	mov    %eax,%ebx
80102b00:	85 c0                	test   %eax,%eax
80102b02:	74 53                	je     80102b57 <mpconfig+0x6a>
80102b04:	8b 70 04             	mov    0x4(%eax),%esi
80102b07:	85 f6                	test   %esi,%esi
80102b09:	74 50                	je     80102b5b <mpconfig+0x6e>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102b0b:	8d be 00 00 00 80    	lea    -0x80000000(%esi),%edi
  if(memcmp(conf, "PCMP", 4) != 0)
80102b11:	83 ec 04             	sub    $0x4,%esp
80102b14:	6a 04                	push   $0x4
80102b16:	68 9d 6a 10 80       	push   $0x80106a9d
80102b1b:	57                   	push   %edi
80102b1c:	e8 8d 10 00 00       	call   80103bae <memcmp>
80102b21:	83 c4 10             	add    $0x10,%esp
80102b24:	85 c0                	test   %eax,%eax
80102b26:	75 37                	jne    80102b5f <mpconfig+0x72>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80102b28:	8a 86 06 00 00 80    	mov    -0x7ffffffa(%esi),%al
80102b2e:	3c 01                	cmp    $0x1,%al
80102b30:	74 04                	je     80102b36 <mpconfig+0x49>
80102b32:	3c 04                	cmp    $0x4,%al
80102b34:	75 30                	jne    80102b66 <mpconfig+0x79>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102b36:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80102b3d:	89 f8                	mov    %edi,%eax
80102b3f:	e8 d0 fe ff ff       	call   80102a14 <sum>
80102b44:	84 c0                	test   %al,%al
80102b46:	75 25                	jne    80102b6d <mpconfig+0x80>
    return 0;
  *pmp = mp;
80102b48:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102b4b:	89 18                	mov    %ebx,(%eax)
  return conf;
}
80102b4d:	89 f8                	mov    %edi,%eax
80102b4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b52:	5b                   	pop    %ebx
80102b53:	5e                   	pop    %esi
80102b54:	5f                   	pop    %edi
80102b55:	5d                   	pop    %ebp
80102b56:	c3                   	ret    
    return 0;
80102b57:	89 c7                	mov    %eax,%edi
80102b59:	eb f2                	jmp    80102b4d <mpconfig+0x60>
80102b5b:	89 f7                	mov    %esi,%edi
80102b5d:	eb ee                	jmp    80102b4d <mpconfig+0x60>
    return 0;
80102b5f:	bf 00 00 00 00       	mov    $0x0,%edi
80102b64:	eb e7                	jmp    80102b4d <mpconfig+0x60>
    return 0;
80102b66:	bf 00 00 00 00       	mov    $0x0,%edi
80102b6b:	eb e0                	jmp    80102b4d <mpconfig+0x60>
    return 0;
80102b6d:	bf 00 00 00 00       	mov    $0x0,%edi
80102b72:	eb d9                	jmp    80102b4d <mpconfig+0x60>

80102b74 <mpinit>:

void
mpinit(void)
{
80102b74:	55                   	push   %ebp
80102b75:	89 e5                	mov    %esp,%ebp
80102b77:	57                   	push   %edi
80102b78:	56                   	push   %esi
80102b79:	53                   	push   %ebx
80102b7a:	83 ec 1c             	sub    $0x1c,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80102b7d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80102b80:	e8 68 ff ff ff       	call   80102aed <mpconfig>
80102b85:	85 c0                	test   %eax,%eax
80102b87:	74 19                	je     80102ba2 <mpinit+0x2e>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102b89:	8b 50 24             	mov    0x24(%eax),%edx
80102b8c:	89 15 80 06 11 80    	mov    %edx,0x80110680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102b92:	8d 50 2c             	lea    0x2c(%eax),%edx
80102b95:	0f b7 48 04          	movzwl 0x4(%eax),%ecx
80102b99:	01 c1                	add    %eax,%ecx
  ismp = 1;
80102b9b:	bf 01 00 00 00       	mov    $0x1,%edi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102ba0:	eb 20                	jmp    80102bc2 <mpinit+0x4e>
    panic("Expect to run on an SMP");
80102ba2:	83 ec 0c             	sub    $0xc,%esp
80102ba5:	68 a2 6a 10 80       	push   $0x80106aa2
80102baa:	e8 92 d7 ff ff       	call   80100341 <panic>
    switch(*p){
80102baf:	bf 00 00 00 00       	mov    $0x0,%edi
80102bb4:	eb 0c                	jmp    80102bc2 <mpinit+0x4e>
80102bb6:	83 e8 03             	sub    $0x3,%eax
80102bb9:	3c 01                	cmp    $0x1,%al
80102bbb:	76 19                	jbe    80102bd6 <mpinit+0x62>
80102bbd:	bf 00 00 00 00       	mov    $0x0,%edi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102bc2:	39 ca                	cmp    %ecx,%edx
80102bc4:	73 4a                	jae    80102c10 <mpinit+0x9c>
    switch(*p){
80102bc6:	8a 02                	mov    (%edx),%al
80102bc8:	3c 02                	cmp    $0x2,%al
80102bca:	74 37                	je     80102c03 <mpinit+0x8f>
80102bcc:	77 e8                	ja     80102bb6 <mpinit+0x42>
80102bce:	84 c0                	test   %al,%al
80102bd0:	74 09                	je     80102bdb <mpinit+0x67>
80102bd2:	3c 01                	cmp    $0x1,%al
80102bd4:	75 d9                	jne    80102baf <mpinit+0x3b>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102bd6:	83 c2 08             	add    $0x8,%edx
      continue;
80102bd9:	eb e7                	jmp    80102bc2 <mpinit+0x4e>
      if(ncpu < NCPU) {
80102bdb:	a1 84 07 11 80       	mov    0x80110784,%eax
80102be0:	83 f8 07             	cmp    $0x7,%eax
80102be3:	7f 19                	jg     80102bfe <mpinit+0x8a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102be5:	8d 34 80             	lea    (%eax,%eax,4),%esi
80102be8:	01 f6                	add    %esi,%esi
80102bea:	01 c6                	add    %eax,%esi
80102bec:	c1 e6 04             	shl    $0x4,%esi
80102bef:	8a 5a 01             	mov    0x1(%edx),%bl
80102bf2:	88 9e a0 07 11 80    	mov    %bl,-0x7feef860(%esi)
        ncpu++;
80102bf8:	40                   	inc    %eax
80102bf9:	a3 84 07 11 80       	mov    %eax,0x80110784
      p += sizeof(struct mpproc);
80102bfe:	83 c2 14             	add    $0x14,%edx
      continue;
80102c01:	eb bf                	jmp    80102bc2 <mpinit+0x4e>
      ioapicid = ioapic->apicno;
80102c03:	8a 42 01             	mov    0x1(%edx),%al
80102c06:	a2 80 07 11 80       	mov    %al,0x80110780
      p += sizeof(struct mpioapic);
80102c0b:	83 c2 08             	add    $0x8,%edx
      continue;
80102c0e:	eb b2                	jmp    80102bc2 <mpinit+0x4e>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102c10:	85 ff                	test   %edi,%edi
80102c12:	74 23                	je     80102c37 <mpinit+0xc3>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102c14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102c17:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80102c1b:	74 12                	je     80102c2f <mpinit+0xbb>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c1d:	b0 70                	mov    $0x70,%al
80102c1f:	ba 22 00 00 00       	mov    $0x22,%edx
80102c24:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c25:	ba 23 00 00 00       	mov    $0x23,%edx
80102c2a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102c2b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c2e:	ee                   	out    %al,(%dx)
  }
}
80102c2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c32:	5b                   	pop    %ebx
80102c33:	5e                   	pop    %esi
80102c34:	5f                   	pop    %edi
80102c35:	5d                   	pop    %ebp
80102c36:	c3                   	ret    
    panic("Didn't find a suitable machine");
80102c37:	83 ec 0c             	sub    $0xc,%esp
80102c3a:	68 bc 6a 10 80       	push   $0x80106abc
80102c3f:	e8 fd d6 ff ff       	call   80100341 <panic>

80102c44 <picinit>:
80102c44:	b0 ff                	mov    $0xff,%al
80102c46:	ba 21 00 00 00       	mov    $0x21,%edx
80102c4b:	ee                   	out    %al,(%dx)
80102c4c:	ba a1 00 00 00       	mov    $0xa1,%edx
80102c51:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102c52:	c3                   	ret    

80102c53 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102c53:	55                   	push   %ebp
80102c54:	89 e5                	mov    %esp,%ebp
80102c56:	57                   	push   %edi
80102c57:	56                   	push   %esi
80102c58:	53                   	push   %ebx
80102c59:	83 ec 0c             	sub    $0xc,%esp
80102c5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c5f:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102c62:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102c68:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102c6e:	e8 73 df ff ff       	call   80100be6 <filealloc>
80102c73:	89 03                	mov    %eax,(%ebx)
80102c75:	85 c0                	test   %eax,%eax
80102c77:	0f 84 88 00 00 00    	je     80102d05 <pipealloc+0xb2>
80102c7d:	e8 64 df ff ff       	call   80100be6 <filealloc>
80102c82:	89 06                	mov    %eax,(%esi)
80102c84:	85 c0                	test   %eax,%eax
80102c86:	74 7d                	je     80102d05 <pipealloc+0xb2>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102c88:	e8 9a f3 ff ff       	call   80102027 <kalloc>
80102c8d:	89 c7                	mov    %eax,%edi
80102c8f:	85 c0                	test   %eax,%eax
80102c91:	74 72                	je     80102d05 <pipealloc+0xb2>
    goto bad;
  p->readopen = 1;
80102c93:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102c9a:	00 00 00 
  p->writeopen = 1;
80102c9d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102ca4:	00 00 00 
  p->nwrite = 0;
80102ca7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102cae:	00 00 00 
  p->nread = 0;
80102cb1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102cb8:	00 00 00 
  initlock(&p->lock, "pipe");
80102cbb:	83 ec 08             	sub    $0x8,%esp
80102cbe:	68 db 6a 10 80       	push   $0x80106adb
80102cc3:	50                   	push   %eax
80102cc4:	e8 bb 0c 00 00       	call   80103984 <initlock>
  (*f0)->type = FD_PIPE;
80102cc9:	8b 03                	mov    (%ebx),%eax
80102ccb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80102cd1:	8b 03                	mov    (%ebx),%eax
80102cd3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80102cd7:	8b 03                	mov    (%ebx),%eax
80102cd9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80102cdd:	8b 03                	mov    (%ebx),%eax
80102cdf:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80102ce2:	8b 06                	mov    (%esi),%eax
80102ce4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80102cea:	8b 06                	mov    (%esi),%eax
80102cec:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80102cf0:	8b 06                	mov    (%esi),%eax
80102cf2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80102cf6:	8b 06                	mov    (%esi),%eax
80102cf8:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
80102cfb:	83 c4 10             	add    $0x10,%esp
80102cfe:	b8 00 00 00 00       	mov    $0x0,%eax
80102d03:	eb 29                	jmp    80102d2e <pipealloc+0xdb>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80102d05:	8b 03                	mov    (%ebx),%eax
80102d07:	85 c0                	test   %eax,%eax
80102d09:	74 0c                	je     80102d17 <pipealloc+0xc4>
    fileclose(*f0);
80102d0b:	83 ec 0c             	sub    $0xc,%esp
80102d0e:	50                   	push   %eax
80102d0f:	e8 76 df ff ff       	call   80100c8a <fileclose>
80102d14:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80102d17:	8b 06                	mov    (%esi),%eax
80102d19:	85 c0                	test   %eax,%eax
80102d1b:	74 19                	je     80102d36 <pipealloc+0xe3>
    fileclose(*f1);
80102d1d:	83 ec 0c             	sub    $0xc,%esp
80102d20:	50                   	push   %eax
80102d21:	e8 64 df ff ff       	call   80100c8a <fileclose>
80102d26:	83 c4 10             	add    $0x10,%esp
  return -1;
80102d29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102d2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d31:	5b                   	pop    %ebx
80102d32:	5e                   	pop    %esi
80102d33:	5f                   	pop    %edi
80102d34:	5d                   	pop    %ebp
80102d35:	c3                   	ret    
  return -1;
80102d36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d3b:	eb f1                	jmp    80102d2e <pipealloc+0xdb>

80102d3d <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80102d3d:	55                   	push   %ebp
80102d3e:	89 e5                	mov    %esp,%ebp
80102d40:	53                   	push   %ebx
80102d41:	83 ec 10             	sub    $0x10,%esp
80102d44:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&p->lock);
80102d47:	53                   	push   %ebx
80102d48:	e8 6e 0d 00 00       	call   80103abb <acquire>
  if(writable){
80102d4d:	83 c4 10             	add    $0x10,%esp
80102d50:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102d54:	74 3f                	je     80102d95 <pipeclose+0x58>
    p->writeopen = 0;
80102d56:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80102d5d:	00 00 00 
    wakeup(&p->nread);
80102d60:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102d66:	83 ec 0c             	sub    $0xc,%esp
80102d69:	50                   	push   %eax
80102d6a:	e8 bd 09 00 00       	call   8010372c <wakeup>
80102d6f:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80102d72:	83 bb 3c 02 00 00 00 	cmpl   $0x0,0x23c(%ebx)
80102d79:	75 09                	jne    80102d84 <pipeclose+0x47>
80102d7b:	83 bb 40 02 00 00 00 	cmpl   $0x0,0x240(%ebx)
80102d82:	74 2f                	je     80102db3 <pipeclose+0x76>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102d84:	83 ec 0c             	sub    $0xc,%esp
80102d87:	53                   	push   %ebx
80102d88:	e8 93 0d 00 00       	call   80103b20 <release>
80102d8d:	83 c4 10             	add    $0x10,%esp
}
80102d90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d93:	c9                   	leave  
80102d94:	c3                   	ret    
    p->readopen = 0;
80102d95:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80102d9c:	00 00 00 
    wakeup(&p->nwrite);
80102d9f:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102da5:	83 ec 0c             	sub    $0xc,%esp
80102da8:	50                   	push   %eax
80102da9:	e8 7e 09 00 00       	call   8010372c <wakeup>
80102dae:	83 c4 10             	add    $0x10,%esp
80102db1:	eb bf                	jmp    80102d72 <pipeclose+0x35>
    release(&p->lock);
80102db3:	83 ec 0c             	sub    $0xc,%esp
80102db6:	53                   	push   %ebx
80102db7:	e8 64 0d 00 00       	call   80103b20 <release>
    kfree((char*)p);
80102dbc:	89 1c 24             	mov    %ebx,(%esp)
80102dbf:	e8 4c f1 ff ff       	call   80101f10 <kfree>
80102dc4:	83 c4 10             	add    $0x10,%esp
80102dc7:	eb c7                	jmp    80102d90 <pipeclose+0x53>

80102dc9 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80102dc9:	55                   	push   %ebp
80102dca:	89 e5                	mov    %esp,%ebp
80102dcc:	56                   	push   %esi
80102dcd:	53                   	push   %ebx
80102dce:	83 ec 1c             	sub    $0x1c,%esp
80102dd1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80102dd4:	53                   	push   %ebx
80102dd5:	e8 e1 0c 00 00       	call   80103abb <acquire>
  for(i = 0; i < n; i++){
80102dda:	83 c4 10             	add    $0x10,%esp
80102ddd:	be 00 00 00 00       	mov    $0x0,%esi
80102de2:	3b 75 10             	cmp    0x10(%ebp),%esi
80102de5:	7c 41                	jl     80102e28 <pipewrite+0x5f>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80102de7:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102ded:	83 ec 0c             	sub    $0xc,%esp
80102df0:	50                   	push   %eax
80102df1:	e8 36 09 00 00       	call   8010372c <wakeup>
  release(&p->lock);
80102df6:	89 1c 24             	mov    %ebx,(%esp)
80102df9:	e8 22 0d 00 00       	call   80103b20 <release>
  return n;
80102dfe:	83 c4 10             	add    $0x10,%esp
80102e01:	8b 45 10             	mov    0x10(%ebp),%eax
80102e04:	eb 5c                	jmp    80102e62 <pipewrite+0x99>
      wakeup(&p->nread);
80102e06:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102e0c:	83 ec 0c             	sub    $0xc,%esp
80102e0f:	50                   	push   %eax
80102e10:	e8 17 09 00 00       	call   8010372c <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102e15:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102e1b:	83 c4 08             	add    $0x8,%esp
80102e1e:	53                   	push   %ebx
80102e1f:	50                   	push   %eax
80102e20:	e8 a0 07 00 00       	call   801035c5 <sleep>
80102e25:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102e28:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80102e2e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80102e34:	05 00 02 00 00       	add    $0x200,%eax
80102e39:	39 c2                	cmp    %eax,%edx
80102e3b:	75 2c                	jne    80102e69 <pipewrite+0xa0>
      if(p->readopen == 0 || myproc()->killed){
80102e3d:	83 bb 3c 02 00 00 00 	cmpl   $0x0,0x23c(%ebx)
80102e44:	74 0b                	je     80102e51 <pipewrite+0x88>
80102e46:	e8 ce 02 00 00       	call   80103119 <myproc>
80102e4b:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80102e4f:	74 b5                	je     80102e06 <pipewrite+0x3d>
        release(&p->lock);
80102e51:	83 ec 0c             	sub    $0xc,%esp
80102e54:	53                   	push   %ebx
80102e55:	e8 c6 0c 00 00       	call   80103b20 <release>
        return -1;
80102e5a:	83 c4 10             	add    $0x10,%esp
80102e5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e65:	5b                   	pop    %ebx
80102e66:	5e                   	pop    %esi
80102e67:	5d                   	pop    %ebp
80102e68:	c3                   	ret    
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80102e69:	8d 42 01             	lea    0x1(%edx),%eax
80102e6c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80102e72:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80102e78:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e7b:	8a 04 30             	mov    (%eax,%esi,1),%al
80102e7e:	88 45 f7             	mov    %al,-0x9(%ebp)
80102e81:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80102e85:	46                   	inc    %esi
80102e86:	e9 57 ff ff ff       	jmp    80102de2 <pipewrite+0x19>

80102e8b <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80102e8b:	55                   	push   %ebp
80102e8c:	89 e5                	mov    %esp,%ebp
80102e8e:	57                   	push   %edi
80102e8f:	56                   	push   %esi
80102e90:	53                   	push   %ebx
80102e91:	83 ec 18             	sub    $0x18,%esp
80102e94:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e97:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80102e9a:	53                   	push   %ebx
80102e9b:	e8 1b 0c 00 00       	call   80103abb <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80102ea0:	83 c4 10             	add    $0x10,%esp
80102ea3:	eb 13                	jmp    80102eb8 <piperead+0x2d>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80102ea5:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102eab:	83 ec 08             	sub    $0x8,%esp
80102eae:	53                   	push   %ebx
80102eaf:	50                   	push   %eax
80102eb0:	e8 10 07 00 00       	call   801035c5 <sleep>
80102eb5:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80102eb8:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80102ebe:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80102ec4:	75 75                	jne    80102f3b <piperead+0xb0>
80102ec6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
80102ecc:	85 f6                	test   %esi,%esi
80102ece:	74 34                	je     80102f04 <piperead+0x79>
    if(myproc()->killed){
80102ed0:	e8 44 02 00 00       	call   80103119 <myproc>
80102ed5:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80102ed9:	74 ca                	je     80102ea5 <piperead+0x1a>
      release(&p->lock);
80102edb:	83 ec 0c             	sub    $0xc,%esp
80102ede:	53                   	push   %ebx
80102edf:	e8 3c 0c 00 00       	call   80103b20 <release>
      return -1;
80102ee4:	83 c4 10             	add    $0x10,%esp
80102ee7:	be ff ff ff ff       	mov    $0xffffffff,%esi
80102eec:	eb 43                	jmp    80102f31 <piperead+0xa6>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80102eee:	8d 50 01             	lea    0x1(%eax),%edx
80102ef1:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
80102ef7:	25 ff 01 00 00       	and    $0x1ff,%eax
80102efc:	8a 44 03 34          	mov    0x34(%ebx,%eax,1),%al
80102f00:	88 04 37             	mov    %al,(%edi,%esi,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80102f03:	46                   	inc    %esi
80102f04:	3b 75 10             	cmp    0x10(%ebp),%esi
80102f07:	7d 0e                	jge    80102f17 <piperead+0x8c>
    if(p->nread == p->nwrite)
80102f09:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80102f0f:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80102f15:	75 d7                	jne    80102eee <piperead+0x63>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80102f17:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102f1d:	83 ec 0c             	sub    $0xc,%esp
80102f20:	50                   	push   %eax
80102f21:	e8 06 08 00 00       	call   8010372c <wakeup>
  release(&p->lock);
80102f26:	89 1c 24             	mov    %ebx,(%esp)
80102f29:	e8 f2 0b 00 00       	call   80103b20 <release>
  return i;
80102f2e:	83 c4 10             	add    $0x10,%esp
}
80102f31:	89 f0                	mov    %esi,%eax
80102f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f36:	5b                   	pop    %ebx
80102f37:	5e                   	pop    %esi
80102f38:	5f                   	pop    %edi
80102f39:	5d                   	pop    %ebp
80102f3a:	c3                   	ret    
80102f3b:	be 00 00 00 00       	mov    $0x0,%esi
80102f40:	eb c2                	jmp    80102f04 <piperead+0x79>

80102f42 <wakeup1>:
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80102f42:	ba 54 0d 11 80       	mov    $0x80110d54,%edx
80102f47:	eb 03                	jmp    80102f4c <wakeup1+0xa>
80102f49:	83 c2 7c             	add    $0x7c,%edx
80102f4c:	81 fa 54 2c 11 80    	cmp    $0x80112c54,%edx
80102f52:	73 14                	jae    80102f68 <wakeup1+0x26>
    if(p->state == SLEEPING && p->chan == chan)
80102f54:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80102f58:	75 ef                	jne    80102f49 <wakeup1+0x7>
80102f5a:	39 42 20             	cmp    %eax,0x20(%edx)
80102f5d:	75 ea                	jne    80102f49 <wakeup1+0x7>
      p->state = RUNNABLE;
80102f5f:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80102f66:	eb e1                	jmp    80102f49 <wakeup1+0x7>
}
80102f68:	c3                   	ret    

80102f69 <allocproc>:
{
80102f69:	55                   	push   %ebp
80102f6a:	89 e5                	mov    %esp,%ebp
80102f6c:	53                   	push   %ebx
80102f6d:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80102f70:	68 20 0d 11 80       	push   $0x80110d20
80102f75:	e8 41 0b 00 00       	call   80103abb <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80102f7a:	83 c4 10             	add    $0x10,%esp
80102f7d:	bb 54 0d 11 80       	mov    $0x80110d54,%ebx
80102f82:	eb 03                	jmp    80102f87 <allocproc+0x1e>
80102f84:	83 c3 7c             	add    $0x7c,%ebx
80102f87:	81 fb 54 2c 11 80    	cmp    $0x80112c54,%ebx
80102f8d:	73 76                	jae    80103005 <allocproc+0x9c>
    if(p->state == UNUSED)
80102f8f:	83 7b 0c 00          	cmpl   $0x0,0xc(%ebx)
80102f93:	75 ef                	jne    80102f84 <allocproc+0x1b>
  p->state = EMBRYO;
80102f95:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80102f9c:	a1 04 90 10 80       	mov    0x80109004,%eax
80102fa1:	8d 50 01             	lea    0x1(%eax),%edx
80102fa4:	89 15 04 90 10 80    	mov    %edx,0x80109004
80102faa:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80102fad:	83 ec 0c             	sub    $0xc,%esp
80102fb0:	68 20 0d 11 80       	push   $0x80110d20
80102fb5:	e8 66 0b 00 00       	call   80103b20 <release>
  if((p->kstack = kalloc()) == 0){
80102fba:	e8 68 f0 ff ff       	call   80102027 <kalloc>
80102fbf:	89 43 08             	mov    %eax,0x8(%ebx)
80102fc2:	83 c4 10             	add    $0x10,%esp
80102fc5:	85 c0                	test   %eax,%eax
80102fc7:	74 53                	je     8010301c <allocproc+0xb3>
  sp -= sizeof *p->tf;
80102fc9:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  p->tf = (struct trapframe*)sp;
80102fcf:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80102fd2:	c7 80 b0 0f 00 00 6e 	movl   $0x80104c6e,0xfb0(%eax)
80102fd9:	4c 10 80 
  sp -= sizeof *p->context;
80102fdc:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
80102fe1:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80102fe4:	83 ec 04             	sub    $0x4,%esp
80102fe7:	6a 14                	push   $0x14
80102fe9:	6a 00                	push   $0x0
80102feb:	50                   	push   %eax
80102fec:	e8 76 0b 00 00       	call   80103b67 <memset>
  p->context->eip = (uint)forkret;
80102ff1:	8b 43 1c             	mov    0x1c(%ebx),%eax
80102ff4:	c7 40 10 27 30 10 80 	movl   $0x80103027,0x10(%eax)
  return p;
80102ffb:	83 c4 10             	add    $0x10,%esp
}
80102ffe:	89 d8                	mov    %ebx,%eax
80103000:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103003:	c9                   	leave  
80103004:	c3                   	ret    
  release(&ptable.lock);
80103005:	83 ec 0c             	sub    $0xc,%esp
80103008:	68 20 0d 11 80       	push   $0x80110d20
8010300d:	e8 0e 0b 00 00       	call   80103b20 <release>
  return 0;
80103012:	83 c4 10             	add    $0x10,%esp
80103015:	bb 00 00 00 00       	mov    $0x0,%ebx
8010301a:	eb e2                	jmp    80102ffe <allocproc+0x95>
    p->state = UNUSED;
8010301c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103023:	89 c3                	mov    %eax,%ebx
80103025:	eb d7                	jmp    80102ffe <allocproc+0x95>

80103027 <forkret>:
{
80103027:	55                   	push   %ebp
80103028:	89 e5                	mov    %esp,%ebp
8010302a:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
8010302d:	68 20 0d 11 80       	push   $0x80110d20
80103032:	e8 e9 0a 00 00       	call   80103b20 <release>
  if (first) {
80103037:	83 c4 10             	add    $0x10,%esp
8010303a:	83 3d 00 90 10 80 00 	cmpl   $0x0,0x80109000
80103041:	75 02                	jne    80103045 <forkret+0x1e>
}
80103043:	c9                   	leave  
80103044:	c3                   	ret    
    first = 0;
80103045:	c7 05 00 90 10 80 00 	movl   $0x0,0x80109000
8010304c:	00 00 00 
    iinit(ROOTDEV);
8010304f:	83 ec 0c             	sub    $0xc,%esp
80103052:	6a 01                	push   $0x1
80103054:	e8 25 e2 ff ff       	call   8010127e <iinit>
    initlog(ROOTDEV);
80103059:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103060:	e8 2e f6 ff ff       	call   80102693 <initlog>
80103065:	83 c4 10             	add    $0x10,%esp
}
80103068:	eb d9                	jmp    80103043 <forkret+0x1c>

8010306a <pinit>:
{
8010306a:	55                   	push   %ebp
8010306b:	89 e5                	mov    %esp,%ebp
8010306d:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103070:	68 e0 6a 10 80       	push   $0x80106ae0
80103075:	68 20 0d 11 80       	push   $0x80110d20
8010307a:	e8 05 09 00 00       	call   80103984 <initlock>
}
8010307f:	83 c4 10             	add    $0x10,%esp
80103082:	c9                   	leave  
80103083:	c3                   	ret    

80103084 <mycpu>:
{
80103084:	55                   	push   %ebp
80103085:	89 e5                	mov    %esp,%ebp
80103087:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010308a:	9c                   	pushf  
8010308b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010308c:	f6 c4 02             	test   $0x2,%ah
8010308f:	75 2c                	jne    801030bd <mycpu+0x39>
  apicid = lapicid();
80103091:	e8 4d f2 ff ff       	call   801022e3 <lapicid>
80103096:	89 c1                	mov    %eax,%ecx
  for (i = 0; i < ncpu; ++i) {
80103098:	ba 00 00 00 00       	mov    $0x0,%edx
8010309d:	39 15 84 07 11 80    	cmp    %edx,0x80110784
801030a3:	7e 25                	jle    801030ca <mycpu+0x46>
    if (cpus[i].apicid == apicid)
801030a5:	8d 04 92             	lea    (%edx,%edx,4),%eax
801030a8:	01 c0                	add    %eax,%eax
801030aa:	01 d0                	add    %edx,%eax
801030ac:	c1 e0 04             	shl    $0x4,%eax
801030af:	0f b6 80 a0 07 11 80 	movzbl -0x7feef860(%eax),%eax
801030b6:	39 c8                	cmp    %ecx,%eax
801030b8:	74 1d                	je     801030d7 <mycpu+0x53>
  for (i = 0; i < ncpu; ++i) {
801030ba:	42                   	inc    %edx
801030bb:	eb e0                	jmp    8010309d <mycpu+0x19>
    panic("mycpu called with interrupts enabled\n");
801030bd:	83 ec 0c             	sub    $0xc,%esp
801030c0:	68 c4 6b 10 80       	push   $0x80106bc4
801030c5:	e8 77 d2 ff ff       	call   80100341 <panic>
  panic("unknown apicid\n");
801030ca:	83 ec 0c             	sub    $0xc,%esp
801030cd:	68 e7 6a 10 80       	push   $0x80106ae7
801030d2:	e8 6a d2 ff ff       	call   80100341 <panic>
      return &cpus[i];
801030d7:	8d 04 92             	lea    (%edx,%edx,4),%eax
801030da:	01 c0                	add    %eax,%eax
801030dc:	01 d0                	add    %edx,%eax
801030de:	c1 e0 04             	shl    $0x4,%eax
801030e1:	05 a0 07 11 80       	add    $0x801107a0,%eax
}
801030e6:	c9                   	leave  
801030e7:	c3                   	ret    

801030e8 <cpuid>:
cpuid() {
801030e8:	55                   	push   %ebp
801030e9:	89 e5                	mov    %esp,%ebp
801030eb:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801030ee:	e8 91 ff ff ff       	call   80103084 <mycpu>
801030f3:	2d a0 07 11 80       	sub    $0x801107a0,%eax
801030f8:	c1 f8 04             	sar    $0x4,%eax
801030fb:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
801030fe:	89 ca                	mov    %ecx,%edx
80103100:	c1 e2 05             	shl    $0x5,%edx
80103103:	29 ca                	sub    %ecx,%edx
80103105:	8d 14 90             	lea    (%eax,%edx,4),%edx
80103108:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
8010310b:	89 ca                	mov    %ecx,%edx
8010310d:	c1 e2 0f             	shl    $0xf,%edx
80103110:	29 ca                	sub    %ecx,%edx
80103112:	8d 04 90             	lea    (%eax,%edx,4),%eax
80103115:	f7 d8                	neg    %eax
}
80103117:	c9                   	leave  
80103118:	c3                   	ret    

80103119 <myproc>:
myproc(void) {
80103119:	55                   	push   %ebp
8010311a:	89 e5                	mov    %esp,%ebp
8010311c:	53                   	push   %ebx
8010311d:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103120:	e8 bc 08 00 00       	call   801039e1 <pushcli>
  c = mycpu();
80103125:	e8 5a ff ff ff       	call   80103084 <mycpu>
  p = c->proc;
8010312a:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103130:	e8 e7 08 00 00       	call   80103a1c <popcli>
}
80103135:	89 d8                	mov    %ebx,%eax
80103137:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010313a:	c9                   	leave  
8010313b:	c3                   	ret    

8010313c <userinit>:
{
8010313c:	55                   	push   %ebp
8010313d:	89 e5                	mov    %esp,%ebp
8010313f:	53                   	push   %ebx
80103140:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103143:	e8 21 fe ff ff       	call   80102f69 <allocproc>
80103148:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010314a:	a3 54 2c 11 80       	mov    %eax,0x80112c54
  if((p->pgdir = setupkvm()) == 0)
8010314f:	e8 ee 31 00 00       	call   80106342 <setupkvm>
80103154:	89 43 04             	mov    %eax,0x4(%ebx)
80103157:	85 c0                	test   %eax,%eax
80103159:	0f 84 b6 00 00 00    	je     80103215 <userinit+0xd9>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010315f:	83 ec 04             	sub    $0x4,%esp
80103162:	68 2c 00 00 00       	push   $0x2c
80103167:	68 60 94 10 80       	push   $0x80109460
8010316c:	50                   	push   %eax
8010316d:	e8 dd 2e 00 00       	call   8010604f <inituvm>
  p->sz = PGSIZE;
80103172:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103178:	8b 43 18             	mov    0x18(%ebx),%eax
8010317b:	83 c4 0c             	add    $0xc,%esp
8010317e:	6a 4c                	push   $0x4c
80103180:	6a 00                	push   $0x0
80103182:	50                   	push   %eax
80103183:	e8 df 09 00 00       	call   80103b67 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103188:	8b 43 18             	mov    0x18(%ebx),%eax
8010318b:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103191:	8b 43 18             	mov    0x18(%ebx),%eax
80103194:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010319a:	8b 43 18             	mov    0x18(%ebx),%eax
8010319d:	8b 50 2c             	mov    0x2c(%eax),%edx
801031a0:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801031a4:	8b 43 18             	mov    0x18(%ebx),%eax
801031a7:	8b 50 2c             	mov    0x2c(%eax),%edx
801031aa:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801031ae:	8b 43 18             	mov    0x18(%ebx),%eax
801031b1:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801031b8:	8b 43 18             	mov    0x18(%ebx),%eax
801031bb:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801031c2:	8b 43 18             	mov    0x18(%ebx),%eax
801031c5:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801031cc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801031cf:	83 c4 0c             	add    $0xc,%esp
801031d2:	6a 10                	push   $0x10
801031d4:	68 10 6b 10 80       	push   $0x80106b10
801031d9:	50                   	push   %eax
801031da:	e8 e0 0a 00 00       	call   80103cbf <safestrcpy>
  p->cwd = namei("/");
801031df:	c7 04 24 19 6b 10 80 	movl   $0x80106b19,(%esp)
801031e6:	e8 7f e9 ff ff       	call   80101b6a <namei>
801031eb:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801031ee:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
801031f5:	e8 c1 08 00 00       	call   80103abb <acquire>
  p->state = RUNNABLE;
801031fa:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103201:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
80103208:	e8 13 09 00 00       	call   80103b20 <release>
}
8010320d:	83 c4 10             	add    $0x10,%esp
80103210:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103213:	c9                   	leave  
80103214:	c3                   	ret    
    panic("userinit: out of memory?");
80103215:	83 ec 0c             	sub    $0xc,%esp
80103218:	68 f7 6a 10 80       	push   $0x80106af7
8010321d:	e8 1f d1 ff ff       	call   80100341 <panic>

80103222 <growproc>:
{
80103222:	55                   	push   %ebp
80103223:	89 e5                	mov    %esp,%ebp
80103225:	56                   	push   %esi
80103226:	53                   	push   %ebx
80103227:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
8010322a:	e8 ea fe ff ff       	call   80103119 <myproc>
8010322f:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
80103231:	8b 00                	mov    (%eax),%eax
  if(n > 0){
80103233:	85 f6                	test   %esi,%esi
80103235:	7f 1b                	jg     80103252 <growproc+0x30>
  } else if(n < 0){
80103237:	78 36                	js     8010326f <growproc+0x4d>
  curproc->sz = sz;
80103239:	89 03                	mov    %eax,(%ebx)
  lcr3(V2P(curproc->pgdir));  // Invalidate TLB.
8010323b:	8b 43 04             	mov    0x4(%ebx),%eax
8010323e:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80103243:	0f 22 d8             	mov    %eax,%cr3
  return 0;
80103246:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010324b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010324e:	5b                   	pop    %ebx
8010324f:	5e                   	pop    %esi
80103250:	5d                   	pop    %ebp
80103251:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103252:	83 ec 04             	sub    $0x4,%esp
80103255:	01 c6                	add    %eax,%esi
80103257:	56                   	push   %esi
80103258:	50                   	push   %eax
80103259:	ff 73 04             	push   0x4(%ebx)
8010325c:	e8 81 2f 00 00       	call   801061e2 <allocuvm>
80103261:	83 c4 10             	add    $0x10,%esp
80103264:	85 c0                	test   %eax,%eax
80103266:	75 d1                	jne    80103239 <growproc+0x17>
      return -1;
80103268:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010326d:	eb dc                	jmp    8010324b <growproc+0x29>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010326f:	83 ec 04             	sub    $0x4,%esp
80103272:	01 c6                	add    %eax,%esi
80103274:	56                   	push   %esi
80103275:	50                   	push   %eax
80103276:	ff 73 04             	push   0x4(%ebx)
80103279:	e8 d4 2e 00 00       	call   80106152 <deallocuvm>
8010327e:	83 c4 10             	add    $0x10,%esp
80103281:	85 c0                	test   %eax,%eax
80103283:	75 b4                	jne    80103239 <growproc+0x17>
      return -1;
80103285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010328a:	eb bf                	jmp    8010324b <growproc+0x29>

8010328c <fork>:
{
8010328c:	55                   	push   %ebp
8010328d:	89 e5                	mov    %esp,%ebp
8010328f:	57                   	push   %edi
80103290:	56                   	push   %esi
80103291:	53                   	push   %ebx
80103292:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
80103295:	e8 7f fe ff ff       	call   80103119 <myproc>
8010329a:	89 c3                	mov    %eax,%ebx
  if((np = allocproc()) == 0){
8010329c:	e8 c8 fc ff ff       	call   80102f69 <allocproc>
801032a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801032a4:	85 c0                	test   %eax,%eax
801032a6:	0f 84 de 00 00 00    	je     8010338a <fork+0xfe>
801032ac:	89 c7                	mov    %eax,%edi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801032ae:	83 ec 08             	sub    $0x8,%esp
801032b1:	ff 33                	push   (%ebx)
801032b3:	ff 73 04             	push   0x4(%ebx)
801032b6:	e8 3a 31 00 00       	call   801063f5 <copyuvm>
801032bb:	89 47 04             	mov    %eax,0x4(%edi)
801032be:	83 c4 10             	add    $0x10,%esp
801032c1:	85 c0                	test   %eax,%eax
801032c3:	74 2a                	je     801032ef <fork+0x63>
  np->sz = curproc->sz;
801032c5:	8b 03                	mov    (%ebx),%eax
801032c7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801032ca:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801032cc:	89 c8                	mov    %ecx,%eax
801032ce:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801032d1:	8b 73 18             	mov    0x18(%ebx),%esi
801032d4:	8b 79 18             	mov    0x18(%ecx),%edi
801032d7:	b9 13 00 00 00       	mov    $0x13,%ecx
801032dc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
801032de:	8b 40 18             	mov    0x18(%eax),%eax
801032e1:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801032e8:	be 00 00 00 00       	mov    $0x0,%esi
801032ed:	eb 27                	jmp    80103316 <fork+0x8a>
    kfree(np->kstack);
801032ef:	83 ec 0c             	sub    $0xc,%esp
801032f2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801032f5:	ff 73 08             	push   0x8(%ebx)
801032f8:	e8 13 ec ff ff       	call   80101f10 <kfree>
    np->kstack = 0;
801032fd:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103304:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
8010330b:	83 c4 10             	add    $0x10,%esp
8010330e:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103313:	eb 6b                	jmp    80103380 <fork+0xf4>
  for(i = 0; i < NOFILE; i++)
80103315:	46                   	inc    %esi
80103316:	83 fe 0f             	cmp    $0xf,%esi
80103319:	7f 1d                	jg     80103338 <fork+0xac>
    if(curproc->ofile[i])
8010331b:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010331f:	85 c0                	test   %eax,%eax
80103321:	74 f2                	je     80103315 <fork+0x89>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103323:	83 ec 0c             	sub    $0xc,%esp
80103326:	50                   	push   %eax
80103327:	e8 1b d9 ff ff       	call   80100c47 <filedup>
8010332c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010332f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
80103333:	83 c4 10             	add    $0x10,%esp
80103336:	eb dd                	jmp    80103315 <fork+0x89>
  np->cwd = idup(curproc->cwd);
80103338:	83 ec 0c             	sub    $0xc,%esp
8010333b:	ff 73 68             	push   0x68(%ebx)
8010333e:	e8 95 e1 ff ff       	call   801014d8 <idup>
80103343:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103346:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103349:	83 c3 6c             	add    $0x6c,%ebx
8010334c:	8d 47 6c             	lea    0x6c(%edi),%eax
8010334f:	83 c4 0c             	add    $0xc,%esp
80103352:	6a 10                	push   $0x10
80103354:	53                   	push   %ebx
80103355:	50                   	push   %eax
80103356:	e8 64 09 00 00       	call   80103cbf <safestrcpy>
  pid = np->pid;
8010335b:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
8010335e:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
80103365:	e8 51 07 00 00       	call   80103abb <acquire>
  np->state = RUNNABLE;
8010336a:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103371:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
80103378:	e8 a3 07 00 00       	call   80103b20 <release>
  return pid;
8010337d:	83 c4 10             	add    $0x10,%esp
}
80103380:	89 d8                	mov    %ebx,%eax
80103382:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103385:	5b                   	pop    %ebx
80103386:	5e                   	pop    %esi
80103387:	5f                   	pop    %edi
80103388:	5d                   	pop    %ebp
80103389:	c3                   	ret    
    return -1;
8010338a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010338f:	eb ef                	jmp    80103380 <fork+0xf4>

80103391 <scheduler>:
{
80103391:	55                   	push   %ebp
80103392:	89 e5                	mov    %esp,%ebp
80103394:	56                   	push   %esi
80103395:	53                   	push   %ebx
  struct cpu *c = mycpu();
80103396:	e8 e9 fc ff ff       	call   80103084 <mycpu>
8010339b:	89 c6                	mov    %eax,%esi
  c->proc = 0;
8010339d:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801033a4:	00 00 00 
801033a7:	eb 5a                	jmp    80103403 <scheduler+0x72>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801033a9:	83 c3 7c             	add    $0x7c,%ebx
801033ac:	81 fb 54 2c 11 80    	cmp    $0x80112c54,%ebx
801033b2:	73 3f                	jae    801033f3 <scheduler+0x62>
      if(p->state != RUNNABLE)
801033b4:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801033b8:	75 ef                	jne    801033a9 <scheduler+0x18>
      c->proc = p;
801033ba:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801033c0:	83 ec 0c             	sub    $0xc,%esp
801033c3:	53                   	push   %ebx
801033c4:	e8 2a 2b 00 00       	call   80105ef3 <switchuvm>
      p->state = RUNNING;
801033c9:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801033d0:	83 c4 08             	add    $0x8,%esp
801033d3:	ff 73 1c             	push   0x1c(%ebx)
801033d6:	8d 46 04             	lea    0x4(%esi),%eax
801033d9:	50                   	push   %eax
801033da:	e8 2e 09 00 00       	call   80103d0d <swtch>
      switchkvm();
801033df:	e8 01 2b 00 00       	call   80105ee5 <switchkvm>
      c->proc = 0;
801033e4:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801033eb:	00 00 00 
801033ee:	83 c4 10             	add    $0x10,%esp
801033f1:	eb b6                	jmp    801033a9 <scheduler+0x18>
    release(&ptable.lock);
801033f3:	83 ec 0c             	sub    $0xc,%esp
801033f6:	68 20 0d 11 80       	push   $0x80110d20
801033fb:	e8 20 07 00 00       	call   80103b20 <release>
    sti();
80103400:	83 c4 10             	add    $0x10,%esp
  asm volatile("sti");
80103403:	fb                   	sti    
    acquire(&ptable.lock);
80103404:	83 ec 0c             	sub    $0xc,%esp
80103407:	68 20 0d 11 80       	push   $0x80110d20
8010340c:	e8 aa 06 00 00       	call   80103abb <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103411:	83 c4 10             	add    $0x10,%esp
80103414:	bb 54 0d 11 80       	mov    $0x80110d54,%ebx
80103419:	eb 91                	jmp    801033ac <scheduler+0x1b>

8010341b <sched>:
{
8010341b:	55                   	push   %ebp
8010341c:	89 e5                	mov    %esp,%ebp
8010341e:	56                   	push   %esi
8010341f:	53                   	push   %ebx
  struct proc *p = myproc();
80103420:	e8 f4 fc ff ff       	call   80103119 <myproc>
80103425:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
80103427:	83 ec 0c             	sub    $0xc,%esp
8010342a:	68 20 0d 11 80       	push   $0x80110d20
8010342f:	e8 48 06 00 00       	call   80103a7c <holding>
80103434:	83 c4 10             	add    $0x10,%esp
80103437:	85 c0                	test   %eax,%eax
80103439:	74 4f                	je     8010348a <sched+0x6f>
  if(mycpu()->ncli != 1)
8010343b:	e8 44 fc ff ff       	call   80103084 <mycpu>
80103440:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103447:	75 4e                	jne    80103497 <sched+0x7c>
  if(p->state == RUNNING)
80103449:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
8010344d:	74 55                	je     801034a4 <sched+0x89>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010344f:	9c                   	pushf  
80103450:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103451:	f6 c4 02             	test   $0x2,%ah
80103454:	75 5b                	jne    801034b1 <sched+0x96>
  intena = mycpu()->intena;
80103456:	e8 29 fc ff ff       	call   80103084 <mycpu>
8010345b:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103461:	e8 1e fc ff ff       	call   80103084 <mycpu>
80103466:	83 ec 08             	sub    $0x8,%esp
80103469:	ff 70 04             	push   0x4(%eax)
8010346c:	83 c3 1c             	add    $0x1c,%ebx
8010346f:	53                   	push   %ebx
80103470:	e8 98 08 00 00       	call   80103d0d <swtch>
  mycpu()->intena = intena;
80103475:	e8 0a fc ff ff       	call   80103084 <mycpu>
8010347a:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103480:	83 c4 10             	add    $0x10,%esp
80103483:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103486:	5b                   	pop    %ebx
80103487:	5e                   	pop    %esi
80103488:	5d                   	pop    %ebp
80103489:	c3                   	ret    
    panic("sched ptable.lock");
8010348a:	83 ec 0c             	sub    $0xc,%esp
8010348d:	68 1b 6b 10 80       	push   $0x80106b1b
80103492:	e8 aa ce ff ff       	call   80100341 <panic>
    panic("sched locks");
80103497:	83 ec 0c             	sub    $0xc,%esp
8010349a:	68 2d 6b 10 80       	push   $0x80106b2d
8010349f:	e8 9d ce ff ff       	call   80100341 <panic>
    panic("sched running");
801034a4:	83 ec 0c             	sub    $0xc,%esp
801034a7:	68 39 6b 10 80       	push   $0x80106b39
801034ac:	e8 90 ce ff ff       	call   80100341 <panic>
    panic("sched interruptible");
801034b1:	83 ec 0c             	sub    $0xc,%esp
801034b4:	68 47 6b 10 80       	push   $0x80106b47
801034b9:	e8 83 ce ff ff       	call   80100341 <panic>

801034be <exit>:
{
801034be:	55                   	push   %ebp
801034bf:	89 e5                	mov    %esp,%ebp
801034c1:	56                   	push   %esi
801034c2:	53                   	push   %ebx
  struct proc *curproc = myproc();
801034c3:	e8 51 fc ff ff       	call   80103119 <myproc>
  if(curproc == initproc)
801034c8:	39 05 54 2c 11 80    	cmp    %eax,0x80112c54
801034ce:	74 09                	je     801034d9 <exit+0x1b>
801034d0:	89 c6                	mov    %eax,%esi
  for(fd = 0; fd < NOFILE; fd++){
801034d2:	bb 00 00 00 00       	mov    $0x0,%ebx
801034d7:	eb 22                	jmp    801034fb <exit+0x3d>
    panic("init exiting");
801034d9:	83 ec 0c             	sub    $0xc,%esp
801034dc:	68 5b 6b 10 80       	push   $0x80106b5b
801034e1:	e8 5b ce ff ff       	call   80100341 <panic>
      fileclose(curproc->ofile[fd]);
801034e6:	83 ec 0c             	sub    $0xc,%esp
801034e9:	50                   	push   %eax
801034ea:	e8 9b d7 ff ff       	call   80100c8a <fileclose>
      curproc->ofile[fd] = 0;
801034ef:	c7 44 9e 28 00 00 00 	movl   $0x0,0x28(%esi,%ebx,4)
801034f6:	00 
801034f7:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801034fa:	43                   	inc    %ebx
801034fb:	83 fb 0f             	cmp    $0xf,%ebx
801034fe:	7f 0a                	jg     8010350a <exit+0x4c>
    if(curproc->ofile[fd]){
80103500:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
80103504:	85 c0                	test   %eax,%eax
80103506:	75 de                	jne    801034e6 <exit+0x28>
80103508:	eb f0                	jmp    801034fa <exit+0x3c>
  begin_op();
8010350a:	e8 cd f1 ff ff       	call   801026dc <begin_op>
  iput(curproc->cwd);
8010350f:	83 ec 0c             	sub    $0xc,%esp
80103512:	ff 76 68             	push   0x68(%esi)
80103515:	e8 f1 e0 ff ff       	call   8010160b <iput>
  end_op();
8010351a:	e8 39 f2 ff ff       	call   80102758 <end_op>
  curproc->cwd = 0;
8010351f:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103526:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
8010352d:	e8 89 05 00 00       	call   80103abb <acquire>
  wakeup1(curproc->parent);
80103532:	8b 46 14             	mov    0x14(%esi),%eax
80103535:	e8 08 fa ff ff       	call   80102f42 <wakeup1>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010353a:	83 c4 10             	add    $0x10,%esp
8010353d:	bb 54 0d 11 80       	mov    $0x80110d54,%ebx
80103542:	eb 03                	jmp    80103547 <exit+0x89>
80103544:	83 c3 7c             	add    $0x7c,%ebx
80103547:	81 fb 54 2c 11 80    	cmp    $0x80112c54,%ebx
8010354d:	73 1a                	jae    80103569 <exit+0xab>
    if(p->parent == curproc){
8010354f:	39 73 14             	cmp    %esi,0x14(%ebx)
80103552:	75 f0                	jne    80103544 <exit+0x86>
      p->parent = initproc;
80103554:	a1 54 2c 11 80       	mov    0x80112c54,%eax
80103559:	89 43 14             	mov    %eax,0x14(%ebx)
      if(p->state == ZOMBIE)
8010355c:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103560:	75 e2                	jne    80103544 <exit+0x86>
        wakeup1(initproc);
80103562:	e8 db f9 ff ff       	call   80102f42 <wakeup1>
80103567:	eb db                	jmp    80103544 <exit+0x86>
  deallocuvm(curproc->pgdir, KERNBASE, 0);
80103569:	83 ec 04             	sub    $0x4,%esp
8010356c:	6a 00                	push   $0x0
8010356e:	68 00 00 00 80       	push   $0x80000000
80103573:	ff 76 04             	push   0x4(%esi)
80103576:	e8 d7 2b 00 00       	call   80106152 <deallocuvm>
  curproc->state = ZOMBIE;
8010357b:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103582:	e8 94 fe ff ff       	call   8010341b <sched>
  panic("zombie exit");
80103587:	c7 04 24 68 6b 10 80 	movl   $0x80106b68,(%esp)
8010358e:	e8 ae cd ff ff       	call   80100341 <panic>

80103593 <yield>:
{
80103593:	55                   	push   %ebp
80103594:	89 e5                	mov    %esp,%ebp
80103596:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103599:	68 20 0d 11 80       	push   $0x80110d20
8010359e:	e8 18 05 00 00       	call   80103abb <acquire>
  myproc()->state = RUNNABLE;
801035a3:	e8 71 fb ff ff       	call   80103119 <myproc>
801035a8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
801035af:	e8 67 fe ff ff       	call   8010341b <sched>
  release(&ptable.lock);
801035b4:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
801035bb:	e8 60 05 00 00       	call   80103b20 <release>
}
801035c0:	83 c4 10             	add    $0x10,%esp
801035c3:	c9                   	leave  
801035c4:	c3                   	ret    

801035c5 <sleep>:
{
801035c5:	55                   	push   %ebp
801035c6:	89 e5                	mov    %esp,%ebp
801035c8:	56                   	push   %esi
801035c9:	53                   	push   %ebx
801035ca:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
801035cd:	e8 47 fb ff ff       	call   80103119 <myproc>
  if(p == 0)
801035d2:	85 c0                	test   %eax,%eax
801035d4:	74 66                	je     8010363c <sleep+0x77>
801035d6:	89 c3                	mov    %eax,%ebx
  if(lk == 0)
801035d8:	85 f6                	test   %esi,%esi
801035da:	74 6d                	je     80103649 <sleep+0x84>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801035dc:	81 fe 20 0d 11 80    	cmp    $0x80110d20,%esi
801035e2:	74 18                	je     801035fc <sleep+0x37>
    acquire(&ptable.lock);  //DOC: sleeplock1
801035e4:	83 ec 0c             	sub    $0xc,%esp
801035e7:	68 20 0d 11 80       	push   $0x80110d20
801035ec:	e8 ca 04 00 00       	call   80103abb <acquire>
    release(lk);
801035f1:	89 34 24             	mov    %esi,(%esp)
801035f4:	e8 27 05 00 00       	call   80103b20 <release>
801035f9:	83 c4 10             	add    $0x10,%esp
  p->chan = chan;
801035fc:	8b 45 08             	mov    0x8(%ebp),%eax
801035ff:	89 43 20             	mov    %eax,0x20(%ebx)
  p->state = SLEEPING;
80103602:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103609:	e8 0d fe ff ff       	call   8010341b <sched>
  p->chan = 0;
8010360e:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  if(lk != &ptable.lock){  //DOC: sleeplock2
80103615:	81 fe 20 0d 11 80    	cmp    $0x80110d20,%esi
8010361b:	74 18                	je     80103635 <sleep+0x70>
    release(&ptable.lock);
8010361d:	83 ec 0c             	sub    $0xc,%esp
80103620:	68 20 0d 11 80       	push   $0x80110d20
80103625:	e8 f6 04 00 00       	call   80103b20 <release>
    acquire(lk);
8010362a:	89 34 24             	mov    %esi,(%esp)
8010362d:	e8 89 04 00 00       	call   80103abb <acquire>
80103632:	83 c4 10             	add    $0x10,%esp
}
80103635:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103638:	5b                   	pop    %ebx
80103639:	5e                   	pop    %esi
8010363a:	5d                   	pop    %ebp
8010363b:	c3                   	ret    
    panic("sleep");
8010363c:	83 ec 0c             	sub    $0xc,%esp
8010363f:	68 74 6b 10 80       	push   $0x80106b74
80103644:	e8 f8 cc ff ff       	call   80100341 <panic>
    panic("sleep without lk");
80103649:	83 ec 0c             	sub    $0xc,%esp
8010364c:	68 7a 6b 10 80       	push   $0x80106b7a
80103651:	e8 eb cc ff ff       	call   80100341 <panic>

80103656 <wait>:
{
80103656:	55                   	push   %ebp
80103657:	89 e5                	mov    %esp,%ebp
80103659:	56                   	push   %esi
8010365a:	53                   	push   %ebx
  struct proc *curproc = myproc();
8010365b:	e8 b9 fa ff ff       	call   80103119 <myproc>
80103660:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80103662:	83 ec 0c             	sub    $0xc,%esp
80103665:	68 20 0d 11 80       	push   $0x80110d20
8010366a:	e8 4c 04 00 00       	call   80103abb <acquire>
8010366f:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103672:	b8 00 00 00 00       	mov    $0x0,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103677:	bb 54 0d 11 80       	mov    $0x80110d54,%ebx
8010367c:	eb 5d                	jmp    801036db <wait+0x85>
        pid = p->pid;
8010367e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103681:	83 ec 0c             	sub    $0xc,%esp
80103684:	ff 73 08             	push   0x8(%ebx)
80103687:	e8 84 e8 ff ff       	call   80101f10 <kfree>
        p->kstack = 0;
8010368c:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir, 0); // User zone deleted before
80103693:	83 c4 08             	add    $0x8,%esp
80103696:	6a 00                	push   $0x0
80103698:	ff 73 04             	push   0x4(%ebx)
8010369b:	e8 2c 2c 00 00       	call   801062cc <freevm>
        p->pid = 0;
801036a0:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801036a7:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801036ae:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801036b2:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801036b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801036c0:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
801036c7:	e8 54 04 00 00       	call   80103b20 <release>
        return pid;
801036cc:	83 c4 10             	add    $0x10,%esp
}
801036cf:	89 f0                	mov    %esi,%eax
801036d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036d4:	5b                   	pop    %ebx
801036d5:	5e                   	pop    %esi
801036d6:	5d                   	pop    %ebp
801036d7:	c3                   	ret    
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801036d8:	83 c3 7c             	add    $0x7c,%ebx
801036db:	81 fb 54 2c 11 80    	cmp    $0x80112c54,%ebx
801036e1:	73 12                	jae    801036f5 <wait+0x9f>
      if(p->parent != curproc)
801036e3:	39 73 14             	cmp    %esi,0x14(%ebx)
801036e6:	75 f0                	jne    801036d8 <wait+0x82>
      if(p->state == ZOMBIE){
801036e8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801036ec:	74 90                	je     8010367e <wait+0x28>
      havekids = 1;
801036ee:	b8 01 00 00 00       	mov    $0x1,%eax
801036f3:	eb e3                	jmp    801036d8 <wait+0x82>
    if(!havekids || curproc->killed){
801036f5:	85 c0                	test   %eax,%eax
801036f7:	74 06                	je     801036ff <wait+0xa9>
801036f9:	83 7e 24 00          	cmpl   $0x0,0x24(%esi)
801036fd:	74 17                	je     80103716 <wait+0xc0>
      release(&ptable.lock);
801036ff:	83 ec 0c             	sub    $0xc,%esp
80103702:	68 20 0d 11 80       	push   $0x80110d20
80103707:	e8 14 04 00 00       	call   80103b20 <release>
      return -1;
8010370c:	83 c4 10             	add    $0x10,%esp
8010370f:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103714:	eb b9                	jmp    801036cf <wait+0x79>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103716:	83 ec 08             	sub    $0x8,%esp
80103719:	68 20 0d 11 80       	push   $0x80110d20
8010371e:	56                   	push   %esi
8010371f:	e8 a1 fe ff ff       	call   801035c5 <sleep>
    havekids = 0;
80103724:	83 c4 10             	add    $0x10,%esp
80103727:	e9 46 ff ff ff       	jmp    80103672 <wait+0x1c>

8010372c <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
8010372c:	55                   	push   %ebp
8010372d:	89 e5                	mov    %esp,%ebp
8010372f:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
80103732:	68 20 0d 11 80       	push   $0x80110d20
80103737:	e8 7f 03 00 00       	call   80103abb <acquire>
  wakeup1(chan);
8010373c:	8b 45 08             	mov    0x8(%ebp),%eax
8010373f:	e8 fe f7 ff ff       	call   80102f42 <wakeup1>
  release(&ptable.lock);
80103744:	c7 04 24 20 0d 11 80 	movl   $0x80110d20,(%esp)
8010374b:	e8 d0 03 00 00       	call   80103b20 <release>
}
80103750:	83 c4 10             	add    $0x10,%esp
80103753:	c9                   	leave  
80103754:	c3                   	ret    

80103755 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103755:	55                   	push   %ebp
80103756:	89 e5                	mov    %esp,%ebp
80103758:	53                   	push   %ebx
80103759:	83 ec 10             	sub    $0x10,%esp
8010375c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010375f:	68 20 0d 11 80       	push   $0x80110d20
80103764:	e8 52 03 00 00       	call   80103abb <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103769:	83 c4 10             	add    $0x10,%esp
8010376c:	b8 54 0d 11 80       	mov    $0x80110d54,%eax
80103771:	eb 0c                	jmp    8010377f <kill+0x2a>
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103773:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010377a:	eb 1c                	jmp    80103798 <kill+0x43>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010377c:	83 c0 7c             	add    $0x7c,%eax
8010377f:	3d 54 2c 11 80       	cmp    $0x80112c54,%eax
80103784:	73 2c                	jae    801037b2 <kill+0x5d>
    if(p->pid == pid){
80103786:	39 58 10             	cmp    %ebx,0x10(%eax)
80103789:	75 f1                	jne    8010377c <kill+0x27>
      p->killed = 1;
8010378b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80103792:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103796:	74 db                	je     80103773 <kill+0x1e>
      release(&ptable.lock);
80103798:	83 ec 0c             	sub    $0xc,%esp
8010379b:	68 20 0d 11 80       	push   $0x80110d20
801037a0:	e8 7b 03 00 00       	call   80103b20 <release>
      return 0;
801037a5:	83 c4 10             	add    $0x10,%esp
801037a8:	b8 00 00 00 00       	mov    $0x0,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801037ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037b0:	c9                   	leave  
801037b1:	c3                   	ret    
  release(&ptable.lock);
801037b2:	83 ec 0c             	sub    $0xc,%esp
801037b5:	68 20 0d 11 80       	push   $0x80110d20
801037ba:	e8 61 03 00 00       	call   80103b20 <release>
  return -1;
801037bf:	83 c4 10             	add    $0x10,%esp
801037c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801037c7:	eb e4                	jmp    801037ad <kill+0x58>

801037c9 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801037c9:	55                   	push   %ebp
801037ca:	89 e5                	mov    %esp,%ebp
801037cc:	56                   	push   %esi
801037cd:	53                   	push   %ebx
801037ce:	83 ec 30             	sub    $0x30,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801037d1:	bb 54 0d 11 80       	mov    $0x80110d54,%ebx
801037d6:	eb 33                	jmp    8010380b <procdump+0x42>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
801037d8:	b8 8b 6b 10 80       	mov    $0x80106b8b,%eax
    cprintf("%d %s %s", p->pid, state, p->name);
801037dd:	8d 53 6c             	lea    0x6c(%ebx),%edx
801037e0:	52                   	push   %edx
801037e1:	50                   	push   %eax
801037e2:	ff 73 10             	push   0x10(%ebx)
801037e5:	68 8f 6b 10 80       	push   $0x80106b8f
801037ea:	e8 eb cd ff ff       	call   801005da <cprintf>
    if(p->state == SLEEPING){
801037ef:	83 c4 10             	add    $0x10,%esp
801037f2:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801037f6:	74 39                	je     80103831 <procdump+0x68>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801037f8:	83 ec 0c             	sub    $0xc,%esp
801037fb:	68 ff 6e 10 80       	push   $0x80106eff
80103800:	e8 d5 cd ff ff       	call   801005da <cprintf>
80103805:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103808:	83 c3 7c             	add    $0x7c,%ebx
8010380b:	81 fb 54 2c 11 80    	cmp    $0x80112c54,%ebx
80103811:	73 5f                	jae    80103872 <procdump+0xa9>
    if(p->state == UNUSED)
80103813:	8b 43 0c             	mov    0xc(%ebx),%eax
80103816:	85 c0                	test   %eax,%eax
80103818:	74 ee                	je     80103808 <procdump+0x3f>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010381a:	83 f8 05             	cmp    $0x5,%eax
8010381d:	77 b9                	ja     801037d8 <procdump+0xf>
8010381f:	8b 04 85 ec 6b 10 80 	mov    -0x7fef9414(,%eax,4),%eax
80103826:	85 c0                	test   %eax,%eax
80103828:	75 b3                	jne    801037dd <procdump+0x14>
      state = "???";
8010382a:	b8 8b 6b 10 80       	mov    $0x80106b8b,%eax
8010382f:	eb ac                	jmp    801037dd <procdump+0x14>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103831:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103834:	8b 40 0c             	mov    0xc(%eax),%eax
80103837:	83 c0 08             	add    $0x8,%eax
8010383a:	83 ec 08             	sub    $0x8,%esp
8010383d:	8d 55 d0             	lea    -0x30(%ebp),%edx
80103840:	52                   	push   %edx
80103841:	50                   	push   %eax
80103842:	e8 58 01 00 00       	call   8010399f <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80103847:	83 c4 10             	add    $0x10,%esp
8010384a:	be 00 00 00 00       	mov    $0x0,%esi
8010384f:	eb 12                	jmp    80103863 <procdump+0x9a>
        cprintf(" %p", pc[i]);
80103851:	83 ec 08             	sub    $0x8,%esp
80103854:	50                   	push   %eax
80103855:	68 e1 65 10 80       	push   $0x801065e1
8010385a:	e8 7b cd ff ff       	call   801005da <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010385f:	46                   	inc    %esi
80103860:	83 c4 10             	add    $0x10,%esp
80103863:	83 fe 09             	cmp    $0x9,%esi
80103866:	7f 90                	jg     801037f8 <procdump+0x2f>
80103868:	8b 44 b5 d0          	mov    -0x30(%ebp,%esi,4),%eax
8010386c:	85 c0                	test   %eax,%eax
8010386e:	75 e1                	jne    80103851 <procdump+0x88>
80103870:	eb 86                	jmp    801037f8 <procdump+0x2f>
  }
}
80103872:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103875:	5b                   	pop    %ebx
80103876:	5e                   	pop    %esi
80103877:	5d                   	pop    %ebp
80103878:	c3                   	ret    

80103879 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80103879:	55                   	push   %ebp
8010387a:	89 e5                	mov    %esp,%ebp
8010387c:	53                   	push   %ebx
8010387d:	83 ec 0c             	sub    $0xc,%esp
80103880:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103883:	68 04 6c 10 80       	push   $0x80106c04
80103888:	8d 43 04             	lea    0x4(%ebx),%eax
8010388b:	50                   	push   %eax
8010388c:	e8 f3 00 00 00       	call   80103984 <initlock>
  lk->name = name;
80103891:	8b 45 0c             	mov    0xc(%ebp),%eax
80103894:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103897:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010389d:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
801038a4:	83 c4 10             	add    $0x10,%esp
801038a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038aa:	c9                   	leave  
801038ab:	c3                   	ret    

801038ac <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801038ac:	55                   	push   %ebp
801038ad:	89 e5                	mov    %esp,%ebp
801038af:	56                   	push   %esi
801038b0:	53                   	push   %ebx
801038b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801038b4:	8d 73 04             	lea    0x4(%ebx),%esi
801038b7:	83 ec 0c             	sub    $0xc,%esp
801038ba:	56                   	push   %esi
801038bb:	e8 fb 01 00 00       	call   80103abb <acquire>
  while (lk->locked) {
801038c0:	83 c4 10             	add    $0x10,%esp
801038c3:	eb 0d                	jmp    801038d2 <acquiresleep+0x26>
    sleep(lk, &lk->lk);
801038c5:	83 ec 08             	sub    $0x8,%esp
801038c8:	56                   	push   %esi
801038c9:	53                   	push   %ebx
801038ca:	e8 f6 fc ff ff       	call   801035c5 <sleep>
801038cf:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
801038d2:	83 3b 00             	cmpl   $0x0,(%ebx)
801038d5:	75 ee                	jne    801038c5 <acquiresleep+0x19>
  }
  lk->locked = 1;
801038d7:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801038dd:	e8 37 f8 ff ff       	call   80103119 <myproc>
801038e2:	8b 40 10             	mov    0x10(%eax),%eax
801038e5:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801038e8:	83 ec 0c             	sub    $0xc,%esp
801038eb:	56                   	push   %esi
801038ec:	e8 2f 02 00 00       	call   80103b20 <release>
}
801038f1:	83 c4 10             	add    $0x10,%esp
801038f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038f7:	5b                   	pop    %ebx
801038f8:	5e                   	pop    %esi
801038f9:	5d                   	pop    %ebp
801038fa:	c3                   	ret    

801038fb <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801038fb:	55                   	push   %ebp
801038fc:	89 e5                	mov    %esp,%ebp
801038fe:	56                   	push   %esi
801038ff:	53                   	push   %ebx
80103900:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103903:	8d 73 04             	lea    0x4(%ebx),%esi
80103906:	83 ec 0c             	sub    $0xc,%esp
80103909:	56                   	push   %esi
8010390a:	e8 ac 01 00 00       	call   80103abb <acquire>
  lk->locked = 0;
8010390f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103915:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
8010391c:	89 1c 24             	mov    %ebx,(%esp)
8010391f:	e8 08 fe ff ff       	call   8010372c <wakeup>
  release(&lk->lk);
80103924:	89 34 24             	mov    %esi,(%esp)
80103927:	e8 f4 01 00 00       	call   80103b20 <release>
}
8010392c:	83 c4 10             	add    $0x10,%esp
8010392f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103932:	5b                   	pop    %ebx
80103933:	5e                   	pop    %esi
80103934:	5d                   	pop    %ebp
80103935:	c3                   	ret    

80103936 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80103936:	55                   	push   %ebp
80103937:	89 e5                	mov    %esp,%ebp
80103939:	56                   	push   %esi
8010393a:	53                   	push   %ebx
8010393b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010393e:	8d 73 04             	lea    0x4(%ebx),%esi
80103941:	83 ec 0c             	sub    $0xc,%esp
80103944:	56                   	push   %esi
80103945:	e8 71 01 00 00       	call   80103abb <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010394a:	83 c4 10             	add    $0x10,%esp
8010394d:	83 3b 00             	cmpl   $0x0,(%ebx)
80103950:	75 17                	jne    80103969 <holdingsleep+0x33>
80103952:	bb 00 00 00 00       	mov    $0x0,%ebx
  release(&lk->lk);
80103957:	83 ec 0c             	sub    $0xc,%esp
8010395a:	56                   	push   %esi
8010395b:	e8 c0 01 00 00       	call   80103b20 <release>
  return r;
}
80103960:	89 d8                	mov    %ebx,%eax
80103962:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103965:	5b                   	pop    %ebx
80103966:	5e                   	pop    %esi
80103967:	5d                   	pop    %ebp
80103968:	c3                   	ret    
  r = lk->locked && (lk->pid == myproc()->pid);
80103969:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010396c:	e8 a8 f7 ff ff       	call   80103119 <myproc>
80103971:	3b 58 10             	cmp    0x10(%eax),%ebx
80103974:	74 07                	je     8010397d <holdingsleep+0x47>
80103976:	bb 00 00 00 00       	mov    $0x0,%ebx
8010397b:	eb da                	jmp    80103957 <holdingsleep+0x21>
8010397d:	bb 01 00 00 00       	mov    $0x1,%ebx
80103982:	eb d3                	jmp    80103957 <holdingsleep+0x21>

80103984 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103984:	55                   	push   %ebp
80103985:	89 e5                	mov    %esp,%ebp
80103987:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
8010398a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010398d:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103990:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103996:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010399d:	5d                   	pop    %ebp
8010399e:	c3                   	ret    

8010399f <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
8010399f:	55                   	push   %ebp
801039a0:	89 e5                	mov    %esp,%ebp
801039a2:	53                   	push   %ebx
801039a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801039a6:	8b 45 08             	mov    0x8(%ebp),%eax
801039a9:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801039ac:	b8 00 00 00 00       	mov    $0x0,%eax
801039b1:	83 f8 09             	cmp    $0x9,%eax
801039b4:	7f 21                	jg     801039d7 <getcallerpcs+0x38>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801039b6:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801039bc:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801039c2:	77 13                	ja     801039d7 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801039c4:	8b 5a 04             	mov    0x4(%edx),%ebx
801039c7:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
801039ca:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801039cc:	40                   	inc    %eax
801039cd:	eb e2                	jmp    801039b1 <getcallerpcs+0x12>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801039cf:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801039d6:	40                   	inc    %eax
801039d7:	83 f8 09             	cmp    $0x9,%eax
801039da:	7e f3                	jle    801039cf <getcallerpcs+0x30>
}
801039dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039df:	c9                   	leave  
801039e0:	c3                   	ret    

801039e1 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801039e1:	55                   	push   %ebp
801039e2:	89 e5                	mov    %esp,%ebp
801039e4:	53                   	push   %ebx
801039e5:	83 ec 04             	sub    $0x4,%esp
801039e8:	9c                   	pushf  
801039e9:	5b                   	pop    %ebx
  asm volatile("cli");
801039ea:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801039eb:	e8 94 f6 ff ff       	call   80103084 <mycpu>
801039f0:	83 b8 a4 00 00 00 00 	cmpl   $0x0,0xa4(%eax)
801039f7:	74 10                	je     80103a09 <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801039f9:	e8 86 f6 ff ff       	call   80103084 <mycpu>
801039fe:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103a04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a07:	c9                   	leave  
80103a08:	c3                   	ret    
    mycpu()->intena = eflags & FL_IF;
80103a09:	e8 76 f6 ff ff       	call   80103084 <mycpu>
80103a0e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103a14:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80103a1a:	eb dd                	jmp    801039f9 <pushcli+0x18>

80103a1c <popcli>:

void
popcli(void)
{
80103a1c:	55                   	push   %ebp
80103a1d:	89 e5                	mov    %esp,%ebp
80103a1f:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a22:	9c                   	pushf  
80103a23:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a24:	f6 c4 02             	test   $0x2,%ah
80103a27:	75 28                	jne    80103a51 <popcli+0x35>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103a29:	e8 56 f6 ff ff       	call   80103084 <mycpu>
80103a2e:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103a34:	8d 51 ff             	lea    -0x1(%ecx),%edx
80103a37:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80103a3d:	85 d2                	test   %edx,%edx
80103a3f:	78 1d                	js     80103a5e <popcli+0x42>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103a41:	e8 3e f6 ff ff       	call   80103084 <mycpu>
80103a46:	83 b8 a4 00 00 00 00 	cmpl   $0x0,0xa4(%eax)
80103a4d:	74 1c                	je     80103a6b <popcli+0x4f>
    sti();
}
80103a4f:	c9                   	leave  
80103a50:	c3                   	ret    
    panic("popcli - interruptible");
80103a51:	83 ec 0c             	sub    $0xc,%esp
80103a54:	68 0f 6c 10 80       	push   $0x80106c0f
80103a59:	e8 e3 c8 ff ff       	call   80100341 <panic>
    panic("popcli");
80103a5e:	83 ec 0c             	sub    $0xc,%esp
80103a61:	68 26 6c 10 80       	push   $0x80106c26
80103a66:	e8 d6 c8 ff ff       	call   80100341 <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103a6b:	e8 14 f6 ff ff       	call   80103084 <mycpu>
80103a70:	83 b8 a8 00 00 00 00 	cmpl   $0x0,0xa8(%eax)
80103a77:	74 d6                	je     80103a4f <popcli+0x33>
  asm volatile("sti");
80103a79:	fb                   	sti    
}
80103a7a:	eb d3                	jmp    80103a4f <popcli+0x33>

80103a7c <holding>:
{
80103a7c:	55                   	push   %ebp
80103a7d:	89 e5                	mov    %esp,%ebp
80103a7f:	53                   	push   %ebx
80103a80:	83 ec 04             	sub    $0x4,%esp
80103a83:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80103a86:	e8 56 ff ff ff       	call   801039e1 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103a8b:	83 3b 00             	cmpl   $0x0,(%ebx)
80103a8e:	75 11                	jne    80103aa1 <holding+0x25>
80103a90:	bb 00 00 00 00       	mov    $0x0,%ebx
  popcli();
80103a95:	e8 82 ff ff ff       	call   80103a1c <popcli>
}
80103a9a:	89 d8                	mov    %ebx,%eax
80103a9c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a9f:	c9                   	leave  
80103aa0:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80103aa1:	8b 5b 08             	mov    0x8(%ebx),%ebx
80103aa4:	e8 db f5 ff ff       	call   80103084 <mycpu>
80103aa9:	39 c3                	cmp    %eax,%ebx
80103aab:	74 07                	je     80103ab4 <holding+0x38>
80103aad:	bb 00 00 00 00       	mov    $0x0,%ebx
80103ab2:	eb e1                	jmp    80103a95 <holding+0x19>
80103ab4:	bb 01 00 00 00       	mov    $0x1,%ebx
80103ab9:	eb da                	jmp    80103a95 <holding+0x19>

80103abb <acquire>:
{
80103abb:	55                   	push   %ebp
80103abc:	89 e5                	mov    %esp,%ebp
80103abe:	53                   	push   %ebx
80103abf:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80103ac2:	e8 1a ff ff ff       	call   801039e1 <pushcli>
  if(holding(lk))
80103ac7:	83 ec 0c             	sub    $0xc,%esp
80103aca:	ff 75 08             	push   0x8(%ebp)
80103acd:	e8 aa ff ff ff       	call   80103a7c <holding>
80103ad2:	83 c4 10             	add    $0x10,%esp
80103ad5:	85 c0                	test   %eax,%eax
80103ad7:	75 3a                	jne    80103b13 <acquire+0x58>
  while(xchg(&lk->locked, 1) != 0)
80103ad9:	8b 55 08             	mov    0x8(%ebp),%edx
  asm volatile("lock; xchgl %0, %1" :
80103adc:	b8 01 00 00 00       	mov    $0x1,%eax
80103ae1:	f0 87 02             	lock xchg %eax,(%edx)
80103ae4:	85 c0                	test   %eax,%eax
80103ae6:	75 f1                	jne    80103ad9 <acquire+0x1e>
  __sync_synchronize();
80103ae8:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80103aed:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103af0:	e8 8f f5 ff ff       	call   80103084 <mycpu>
80103af5:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80103af8:	8b 45 08             	mov    0x8(%ebp),%eax
80103afb:	83 c0 0c             	add    $0xc,%eax
80103afe:	83 ec 08             	sub    $0x8,%esp
80103b01:	50                   	push   %eax
80103b02:	8d 45 08             	lea    0x8(%ebp),%eax
80103b05:	50                   	push   %eax
80103b06:	e8 94 fe ff ff       	call   8010399f <getcallerpcs>
}
80103b0b:	83 c4 10             	add    $0x10,%esp
80103b0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b11:	c9                   	leave  
80103b12:	c3                   	ret    
    panic("acquire");
80103b13:	83 ec 0c             	sub    $0xc,%esp
80103b16:	68 2d 6c 10 80       	push   $0x80106c2d
80103b1b:	e8 21 c8 ff ff       	call   80100341 <panic>

80103b20 <release>:
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	53                   	push   %ebx
80103b24:	83 ec 10             	sub    $0x10,%esp
80103b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80103b2a:	53                   	push   %ebx
80103b2b:	e8 4c ff ff ff       	call   80103a7c <holding>
80103b30:	83 c4 10             	add    $0x10,%esp
80103b33:	85 c0                	test   %eax,%eax
80103b35:	74 23                	je     80103b5a <release+0x3a>
  lk->pcs[0] = 0;
80103b37:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80103b3e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80103b45:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80103b4a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  popcli();
80103b50:	e8 c7 fe ff ff       	call   80103a1c <popcli>
}
80103b55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b58:	c9                   	leave  
80103b59:	c3                   	ret    
    panic("release");
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	68 35 6c 10 80       	push   $0x80106c35
80103b62:	e8 da c7 ff ff       	call   80100341 <panic>

80103b67 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80103b67:	55                   	push   %ebp
80103b68:	89 e5                	mov    %esp,%ebp
80103b6a:	57                   	push   %edi
80103b6b:	53                   	push   %ebx
80103b6c:	8b 55 08             	mov    0x8(%ebp),%edx
80103b6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80103b72:	f6 c2 03             	test   $0x3,%dl
80103b75:	75 29                	jne    80103ba0 <memset+0x39>
80103b77:	f6 45 10 03          	testb  $0x3,0x10(%ebp)
80103b7b:	75 23                	jne    80103ba0 <memset+0x39>
    c &= 0xFF;
80103b7d:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80103b80:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103b83:	c1 e9 02             	shr    $0x2,%ecx
80103b86:	c1 e0 18             	shl    $0x18,%eax
80103b89:	89 fb                	mov    %edi,%ebx
80103b8b:	c1 e3 10             	shl    $0x10,%ebx
80103b8e:	09 d8                	or     %ebx,%eax
80103b90:	89 fb                	mov    %edi,%ebx
80103b92:	c1 e3 08             	shl    $0x8,%ebx
80103b95:	09 d8                	or     %ebx,%eax
80103b97:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80103b99:	89 d7                	mov    %edx,%edi
80103b9b:	fc                   	cld    
80103b9c:	f3 ab                	rep stos %eax,%es:(%edi)
}
80103b9e:	eb 08                	jmp    80103ba8 <memset+0x41>
  asm volatile("cld; rep stosb" :
80103ba0:	89 d7                	mov    %edx,%edi
80103ba2:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103ba5:	fc                   	cld    
80103ba6:	f3 aa                	rep stos %al,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80103ba8:	89 d0                	mov    %edx,%eax
80103baa:	5b                   	pop    %ebx
80103bab:	5f                   	pop    %edi
80103bac:	5d                   	pop    %ebp
80103bad:	c3                   	ret    

80103bae <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80103bae:	55                   	push   %ebp
80103baf:	89 e5                	mov    %esp,%ebp
80103bb1:	56                   	push   %esi
80103bb2:	53                   	push   %ebx
80103bb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103bb6:	8b 55 0c             	mov    0xc(%ebp),%edx
80103bb9:	8b 45 10             	mov    0x10(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103bbc:	eb 04                	jmp    80103bc2 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80103bbe:	41                   	inc    %ecx
80103bbf:	42                   	inc    %edx
  while(n-- > 0){
80103bc0:	89 f0                	mov    %esi,%eax
80103bc2:	8d 70 ff             	lea    -0x1(%eax),%esi
80103bc5:	85 c0                	test   %eax,%eax
80103bc7:	74 10                	je     80103bd9 <memcmp+0x2b>
    if(*s1 != *s2)
80103bc9:	8a 01                	mov    (%ecx),%al
80103bcb:	8a 1a                	mov    (%edx),%bl
80103bcd:	38 d8                	cmp    %bl,%al
80103bcf:	74 ed                	je     80103bbe <memcmp+0x10>
      return *s1 - *s2;
80103bd1:	0f b6 c0             	movzbl %al,%eax
80103bd4:	0f b6 db             	movzbl %bl,%ebx
80103bd7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80103bd9:	5b                   	pop    %ebx
80103bda:	5e                   	pop    %esi
80103bdb:	5d                   	pop    %ebp
80103bdc:	c3                   	ret    

80103bdd <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80103bdd:	55                   	push   %ebp
80103bde:	89 e5                	mov    %esp,%ebp
80103be0:	56                   	push   %esi
80103be1:	53                   	push   %ebx
80103be2:	8b 75 08             	mov    0x8(%ebp),%esi
80103be5:	8b 55 0c             	mov    0xc(%ebp),%edx
80103be8:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80103beb:	39 f2                	cmp    %esi,%edx
80103bed:	73 36                	jae    80103c25 <memmove+0x48>
80103bef:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80103bf2:	39 f1                	cmp    %esi,%ecx
80103bf4:	76 33                	jbe    80103c29 <memmove+0x4c>
    s += n;
    d += n;
80103bf6:	8d 14 06             	lea    (%esi,%eax,1),%edx
    while(n-- > 0)
80103bf9:	eb 08                	jmp    80103c03 <memmove+0x26>
      *--d = *--s;
80103bfb:	49                   	dec    %ecx
80103bfc:	4a                   	dec    %edx
80103bfd:	8a 01                	mov    (%ecx),%al
80103bff:	88 02                	mov    %al,(%edx)
    while(n-- > 0)
80103c01:	89 d8                	mov    %ebx,%eax
80103c03:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103c06:	85 c0                	test   %eax,%eax
80103c08:	75 f1                	jne    80103bfb <memmove+0x1e>
80103c0a:	eb 13                	jmp    80103c1f <memmove+0x42>
  } else
    while(n-- > 0)
      *d++ = *s++;
80103c0c:	8a 02                	mov    (%edx),%al
80103c0e:	88 01                	mov    %al,(%ecx)
80103c10:	8d 49 01             	lea    0x1(%ecx),%ecx
80103c13:	8d 52 01             	lea    0x1(%edx),%edx
    while(n-- > 0)
80103c16:	89 d8                	mov    %ebx,%eax
80103c18:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103c1b:	85 c0                	test   %eax,%eax
80103c1d:	75 ed                	jne    80103c0c <memmove+0x2f>

  return dst;
}
80103c1f:	89 f0                	mov    %esi,%eax
80103c21:	5b                   	pop    %ebx
80103c22:	5e                   	pop    %esi
80103c23:	5d                   	pop    %ebp
80103c24:	c3                   	ret    
80103c25:	89 f1                	mov    %esi,%ecx
80103c27:	eb ef                	jmp    80103c18 <memmove+0x3b>
80103c29:	89 f1                	mov    %esi,%ecx
80103c2b:	eb eb                	jmp    80103c18 <memmove+0x3b>

80103c2d <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80103c2d:	55                   	push   %ebp
80103c2e:	89 e5                	mov    %esp,%ebp
80103c30:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80103c33:	ff 75 10             	push   0x10(%ebp)
80103c36:	ff 75 0c             	push   0xc(%ebp)
80103c39:	ff 75 08             	push   0x8(%ebp)
80103c3c:	e8 9c ff ff ff       	call   80103bdd <memmove>
}
80103c41:	c9                   	leave  
80103c42:	c3                   	ret    

80103c43 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80103c43:	55                   	push   %ebp
80103c44:	89 e5                	mov    %esp,%ebp
80103c46:	53                   	push   %ebx
80103c47:	8b 55 08             	mov    0x8(%ebp),%edx
80103c4a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103c4d:	8b 45 10             	mov    0x10(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80103c50:	eb 03                	jmp    80103c55 <strncmp+0x12>
    n--, p++, q++;
80103c52:	48                   	dec    %eax
80103c53:	42                   	inc    %edx
80103c54:	41                   	inc    %ecx
  while(n > 0 && *p && *p == *q)
80103c55:	85 c0                	test   %eax,%eax
80103c57:	74 0a                	je     80103c63 <strncmp+0x20>
80103c59:	8a 1a                	mov    (%edx),%bl
80103c5b:	84 db                	test   %bl,%bl
80103c5d:	74 04                	je     80103c63 <strncmp+0x20>
80103c5f:	3a 19                	cmp    (%ecx),%bl
80103c61:	74 ef                	je     80103c52 <strncmp+0xf>
  if(n == 0)
80103c63:	85 c0                	test   %eax,%eax
80103c65:	74 0d                	je     80103c74 <strncmp+0x31>
    return 0;
  return (uchar)*p - (uchar)*q;
80103c67:	0f b6 02             	movzbl (%edx),%eax
80103c6a:	0f b6 11             	movzbl (%ecx),%edx
80103c6d:	29 d0                	sub    %edx,%eax
}
80103c6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c72:	c9                   	leave  
80103c73:	c3                   	ret    
    return 0;
80103c74:	b8 00 00 00 00       	mov    $0x0,%eax
80103c79:	eb f4                	jmp    80103c6f <strncmp+0x2c>

80103c7b <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80103c7b:	55                   	push   %ebp
80103c7c:	89 e5                	mov    %esp,%ebp
80103c7e:	57                   	push   %edi
80103c7f:	56                   	push   %esi
80103c80:	53                   	push   %ebx
80103c81:	8b 45 08             	mov    0x8(%ebp),%eax
80103c84:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103c87:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80103c8a:	89 c1                	mov    %eax,%ecx
80103c8c:	eb 04                	jmp    80103c92 <strncpy+0x17>
80103c8e:	89 fb                	mov    %edi,%ebx
80103c90:	89 f1                	mov    %esi,%ecx
80103c92:	89 d6                	mov    %edx,%esi
80103c94:	4a                   	dec    %edx
80103c95:	85 f6                	test   %esi,%esi
80103c97:	7e 10                	jle    80103ca9 <strncpy+0x2e>
80103c99:	8d 7b 01             	lea    0x1(%ebx),%edi
80103c9c:	8d 71 01             	lea    0x1(%ecx),%esi
80103c9f:	8a 1b                	mov    (%ebx),%bl
80103ca1:	88 19                	mov    %bl,(%ecx)
80103ca3:	84 db                	test   %bl,%bl
80103ca5:	75 e7                	jne    80103c8e <strncpy+0x13>
80103ca7:	89 f1                	mov    %esi,%ecx
    ;
  while(n-- > 0)
80103ca9:	8d 5a ff             	lea    -0x1(%edx),%ebx
80103cac:	85 d2                	test   %edx,%edx
80103cae:	7e 0a                	jle    80103cba <strncpy+0x3f>
    *s++ = 0;
80103cb0:	c6 01 00             	movb   $0x0,(%ecx)
  while(n-- > 0)
80103cb3:	89 da                	mov    %ebx,%edx
    *s++ = 0;
80103cb5:	8d 49 01             	lea    0x1(%ecx),%ecx
80103cb8:	eb ef                	jmp    80103ca9 <strncpy+0x2e>
  return os;
}
80103cba:	5b                   	pop    %ebx
80103cbb:	5e                   	pop    %esi
80103cbc:	5f                   	pop    %edi
80103cbd:	5d                   	pop    %ebp
80103cbe:	c3                   	ret    

80103cbf <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80103cbf:	55                   	push   %ebp
80103cc0:	89 e5                	mov    %esp,%ebp
80103cc2:	57                   	push   %edi
80103cc3:	56                   	push   %esi
80103cc4:	53                   	push   %ebx
80103cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80103cc8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103ccb:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80103cce:	85 d2                	test   %edx,%edx
80103cd0:	7e 20                	jle    80103cf2 <safestrcpy+0x33>
80103cd2:	89 c1                	mov    %eax,%ecx
80103cd4:	eb 04                	jmp    80103cda <safestrcpy+0x1b>
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80103cd6:	89 fb                	mov    %edi,%ebx
80103cd8:	89 f1                	mov    %esi,%ecx
80103cda:	4a                   	dec    %edx
80103cdb:	85 d2                	test   %edx,%edx
80103cdd:	7e 10                	jle    80103cef <safestrcpy+0x30>
80103cdf:	8d 7b 01             	lea    0x1(%ebx),%edi
80103ce2:	8d 71 01             	lea    0x1(%ecx),%esi
80103ce5:	8a 1b                	mov    (%ebx),%bl
80103ce7:	88 19                	mov    %bl,(%ecx)
80103ce9:	84 db                	test   %bl,%bl
80103ceb:	75 e9                	jne    80103cd6 <safestrcpy+0x17>
80103ced:	89 f1                	mov    %esi,%ecx
    ;
  *s = 0;
80103cef:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80103cf2:	5b                   	pop    %ebx
80103cf3:	5e                   	pop    %esi
80103cf4:	5f                   	pop    %edi
80103cf5:	5d                   	pop    %ebp
80103cf6:	c3                   	ret    

80103cf7 <strlen>:

int
strlen(const char *s)
{
80103cf7:	55                   	push   %ebp
80103cf8:	89 e5                	mov    %esp,%ebp
80103cfa:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80103cfd:	b8 00 00 00 00       	mov    $0x0,%eax
80103d02:	eb 01                	jmp    80103d05 <strlen+0xe>
80103d04:	40                   	inc    %eax
80103d05:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80103d09:	75 f9                	jne    80103d04 <strlen+0xd>
    ;
  return n;
}
80103d0b:	5d                   	pop    %ebp
80103d0c:	c3                   	ret    

80103d0d <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80103d0d:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80103d11:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80103d15:	55                   	push   %ebp
  pushl %ebx
80103d16:	53                   	push   %ebx
  pushl %esi
80103d17:	56                   	push   %esi
  pushl %edi
80103d18:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80103d19:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80103d1b:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80103d1d:	5f                   	pop    %edi
  popl %esi
80103d1e:	5e                   	pop    %esi
  popl %ebx
80103d1f:	5b                   	pop    %ebx
  popl %ebp
80103d20:	5d                   	pop    %ebp
  ret
80103d21:	c3                   	ret    

80103d22 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80103d22:	55                   	push   %ebp
80103d23:	89 e5                	mov    %esp,%ebp
80103d25:	53                   	push   %ebx
80103d26:	83 ec 04             	sub    $0x4,%esp
80103d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80103d2c:	e8 e8 f3 ff ff       	call   80103119 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80103d31:	8b 00                	mov    (%eax),%eax
80103d33:	39 d8                	cmp    %ebx,%eax
80103d35:	76 18                	jbe    80103d4f <fetchint+0x2d>
80103d37:	8d 53 04             	lea    0x4(%ebx),%edx
80103d3a:	39 d0                	cmp    %edx,%eax
80103d3c:	72 18                	jb     80103d56 <fetchint+0x34>
    return -1;
  *ip = *(int*)(addr);
80103d3e:	8b 13                	mov    (%ebx),%edx
80103d40:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d43:	89 10                	mov    %edx,(%eax)
  return 0;
80103d45:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103d4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d4d:	c9                   	leave  
80103d4e:	c3                   	ret    
    return -1;
80103d4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d54:	eb f4                	jmp    80103d4a <fetchint+0x28>
80103d56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d5b:	eb ed                	jmp    80103d4a <fetchint+0x28>

80103d5d <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80103d5d:	55                   	push   %ebp
80103d5e:	89 e5                	mov    %esp,%ebp
80103d60:	53                   	push   %ebx
80103d61:	83 ec 04             	sub    $0x4,%esp
80103d64:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80103d67:	e8 ad f3 ff ff       	call   80103119 <myproc>

  if(addr >= curproc->sz)
80103d6c:	39 18                	cmp    %ebx,(%eax)
80103d6e:	76 23                	jbe    80103d93 <fetchstr+0x36>
    return -1;
  *pp = (char*)addr;
80103d70:	8b 55 0c             	mov    0xc(%ebp),%edx
80103d73:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80103d75:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80103d77:	89 d8                	mov    %ebx,%eax
80103d79:	eb 01                	jmp    80103d7c <fetchstr+0x1f>
80103d7b:	40                   	inc    %eax
80103d7c:	39 d0                	cmp    %edx,%eax
80103d7e:	73 09                	jae    80103d89 <fetchstr+0x2c>
    if(*s == 0)
80103d80:	80 38 00             	cmpb   $0x0,(%eax)
80103d83:	75 f6                	jne    80103d7b <fetchstr+0x1e>
      return s - *pp;
80103d85:	29 d8                	sub    %ebx,%eax
80103d87:	eb 05                	jmp    80103d8e <fetchstr+0x31>
  }
  return -1;
80103d89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d91:	c9                   	leave  
80103d92:	c3                   	ret    
    return -1;
80103d93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d98:	eb f4                	jmp    80103d8e <fetchstr+0x31>

80103d9a <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80103d9a:	55                   	push   %ebp
80103d9b:	89 e5                	mov    %esp,%ebp
80103d9d:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80103da0:	e8 74 f3 ff ff       	call   80103119 <myproc>
80103da5:	8b 50 18             	mov    0x18(%eax),%edx
80103da8:	8b 45 08             	mov    0x8(%ebp),%eax
80103dab:	c1 e0 02             	shl    $0x2,%eax
80103dae:	03 42 44             	add    0x44(%edx),%eax
80103db1:	83 ec 08             	sub    $0x8,%esp
80103db4:	ff 75 0c             	push   0xc(%ebp)
80103db7:	83 c0 04             	add    $0x4,%eax
80103dba:	50                   	push   %eax
80103dbb:	e8 62 ff ff ff       	call   80103d22 <fetchint>
}
80103dc0:	c9                   	leave  
80103dc1:	c3                   	ret    

80103dc2 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, void **pp, int size)
{
80103dc2:	55                   	push   %ebp
80103dc3:	89 e5                	mov    %esp,%ebp
80103dc5:	56                   	push   %esi
80103dc6:	53                   	push   %ebx
80103dc7:	83 ec 10             	sub    $0x10,%esp
80103dca:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80103dcd:	e8 47 f3 ff ff       	call   80103119 <myproc>
80103dd2:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80103dd4:	83 ec 08             	sub    $0x8,%esp
80103dd7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80103dda:	50                   	push   %eax
80103ddb:	ff 75 08             	push   0x8(%ebp)
80103dde:	e8 b7 ff ff ff       	call   80103d9a <argint>
80103de3:	83 c4 10             	add    $0x10,%esp
80103de6:	85 c0                	test   %eax,%eax
80103de8:	78 24                	js     80103e0e <argptr+0x4c>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80103dea:	85 db                	test   %ebx,%ebx
80103dec:	78 27                	js     80103e15 <argptr+0x53>
80103dee:	8b 16                	mov    (%esi),%edx
80103df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df3:	39 c2                	cmp    %eax,%edx
80103df5:	76 25                	jbe    80103e1c <argptr+0x5a>
80103df7:	01 c3                	add    %eax,%ebx
80103df9:	39 da                	cmp    %ebx,%edx
80103dfb:	72 26                	jb     80103e23 <argptr+0x61>
    return -1;
  *pp = (void*)i;
80103dfd:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e00:	89 02                	mov    %eax,(%edx)
  return 0;
80103e02:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103e07:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e0a:	5b                   	pop    %ebx
80103e0b:	5e                   	pop    %esi
80103e0c:	5d                   	pop    %ebp
80103e0d:	c3                   	ret    
    return -1;
80103e0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e13:	eb f2                	jmp    80103e07 <argptr+0x45>
    return -1;
80103e15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e1a:	eb eb                	jmp    80103e07 <argptr+0x45>
80103e1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e21:	eb e4                	jmp    80103e07 <argptr+0x45>
80103e23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e28:	eb dd                	jmp    80103e07 <argptr+0x45>

80103e2a <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80103e2a:	55                   	push   %ebp
80103e2b:	89 e5                	mov    %esp,%ebp
80103e2d:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80103e30:	8d 45 f4             	lea    -0xc(%ebp),%eax
80103e33:	50                   	push   %eax
80103e34:	ff 75 08             	push   0x8(%ebp)
80103e37:	e8 5e ff ff ff       	call   80103d9a <argint>
80103e3c:	83 c4 10             	add    $0x10,%esp
80103e3f:	85 c0                	test   %eax,%eax
80103e41:	78 13                	js     80103e56 <argstr+0x2c>
    return -1;
  return fetchstr(addr, pp);
80103e43:	83 ec 08             	sub    $0x8,%esp
80103e46:	ff 75 0c             	push   0xc(%ebp)
80103e49:	ff 75 f4             	push   -0xc(%ebp)
80103e4c:	e8 0c ff ff ff       	call   80103d5d <fetchstr>
80103e51:	83 c4 10             	add    $0x10,%esp
}
80103e54:	c9                   	leave  
80103e55:	c3                   	ret    
    return -1;
80103e56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e5b:	eb f7                	jmp    80103e54 <argstr+0x2a>

80103e5d <syscall>:
[SYS_dup2]    sys_dup2,
};

void
syscall(void)
{
80103e5d:	55                   	push   %ebp
80103e5e:	89 e5                	mov    %esp,%ebp
80103e60:	53                   	push   %ebx
80103e61:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80103e64:	e8 b0 f2 ff ff       	call   80103119 <myproc>
80103e69:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80103e6b:	8b 40 18             	mov    0x18(%eax),%eax
80103e6e:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80103e71:	8d 50 ff             	lea    -0x1(%eax),%edx
80103e74:	83 fa 16             	cmp    $0x16,%edx
80103e77:	77 17                	ja     80103e90 <syscall+0x33>
80103e79:	8b 14 85 60 6c 10 80 	mov    -0x7fef93a0(,%eax,4),%edx
80103e80:	85 d2                	test   %edx,%edx
80103e82:	74 0c                	je     80103e90 <syscall+0x33>
    curproc->tf->eax = syscalls[num]();
80103e84:	ff d2                	call   *%edx
80103e86:	89 c2                	mov    %eax,%edx
80103e88:	8b 43 18             	mov    0x18(%ebx),%eax
80103e8b:	89 50 1c             	mov    %edx,0x1c(%eax)
80103e8e:	eb 1f                	jmp    80103eaf <syscall+0x52>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
80103e90:	8d 53 6c             	lea    0x6c(%ebx),%edx
    cprintf("%d %s: unknown sys call %d\n",
80103e93:	50                   	push   %eax
80103e94:	52                   	push   %edx
80103e95:	ff 73 10             	push   0x10(%ebx)
80103e98:	68 3d 6c 10 80       	push   $0x80106c3d
80103e9d:	e8 38 c7 ff ff       	call   801005da <cprintf>
    curproc->tf->eax = -1;
80103ea2:	8b 43 18             	mov    0x18(%ebx),%eax
80103ea5:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80103eac:	83 c4 10             	add    $0x10,%esp
  }
}
80103eaf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103eb2:	c9                   	leave  
80103eb3:	c3                   	ret    

80103eb4 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80103eb4:	55                   	push   %ebp
80103eb5:	89 e5                	mov    %esp,%ebp
80103eb7:	56                   	push   %esi
80103eb8:	53                   	push   %ebx
80103eb9:	83 ec 18             	sub    $0x18,%esp
80103ebc:	89 d6                	mov    %edx,%esi
80103ebe:	89 cb                	mov    %ecx,%ebx
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80103ec0:	8d 55 f4             	lea    -0xc(%ebp),%edx
80103ec3:	52                   	push   %edx
80103ec4:	50                   	push   %eax
80103ec5:	e8 d0 fe ff ff       	call   80103d9a <argint>
80103eca:	83 c4 10             	add    $0x10,%esp
80103ecd:	85 c0                	test   %eax,%eax
80103ecf:	78 35                	js     80103f06 <argfd+0x52>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80103ed1:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80103ed5:	77 28                	ja     80103eff <argfd+0x4b>
80103ed7:	e8 3d f2 ff ff       	call   80103119 <myproc>
80103edc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103edf:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80103ee3:	85 c0                	test   %eax,%eax
80103ee5:	74 18                	je     80103eff <argfd+0x4b>
    return -1;
  if(pfd)
80103ee7:	85 f6                	test   %esi,%esi
80103ee9:	74 02                	je     80103eed <argfd+0x39>
    *pfd = fd;
80103eeb:	89 16                	mov    %edx,(%esi)
  if(pf)
80103eed:	85 db                	test   %ebx,%ebx
80103eef:	74 1c                	je     80103f0d <argfd+0x59>
    *pf = f;
80103ef1:	89 03                	mov    %eax,(%ebx)
  return 0;
80103ef3:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103ef8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103efb:	5b                   	pop    %ebx
80103efc:	5e                   	pop    %esi
80103efd:	5d                   	pop    %ebp
80103efe:	c3                   	ret    
    return -1;
80103eff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f04:	eb f2                	jmp    80103ef8 <argfd+0x44>
    return -1;
80103f06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f0b:	eb eb                	jmp    80103ef8 <argfd+0x44>
  return 0;
80103f0d:	b8 00 00 00 00       	mov    $0x0,%eax
80103f12:	eb e4                	jmp    80103ef8 <argfd+0x44>

80103f14 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80103f14:	55                   	push   %ebp
80103f15:	89 e5                	mov    %esp,%ebp
80103f17:	53                   	push   %ebx
80103f18:	83 ec 04             	sub    $0x4,%esp
80103f1b:	89 c3                	mov    %eax,%ebx
  int fd;
  struct proc *curproc = myproc();
80103f1d:	e8 f7 f1 ff ff       	call   80103119 <myproc>
80103f22:	89 c2                	mov    %eax,%edx

  for(fd = 0; fd < NOFILE; fd++){
80103f24:	b8 00 00 00 00       	mov    $0x0,%eax
80103f29:	83 f8 0f             	cmp    $0xf,%eax
80103f2c:	7f 10                	jg     80103f3e <fdalloc+0x2a>
    if(curproc->ofile[fd] == 0){
80103f2e:	83 7c 82 28 00       	cmpl   $0x0,0x28(%edx,%eax,4)
80103f33:	74 03                	je     80103f38 <fdalloc+0x24>
  for(fd = 0; fd < NOFILE; fd++){
80103f35:	40                   	inc    %eax
80103f36:	eb f1                	jmp    80103f29 <fdalloc+0x15>
      curproc->ofile[fd] = f;
80103f38:	89 5c 82 28          	mov    %ebx,0x28(%edx,%eax,4)
      return fd;
80103f3c:	eb 05                	jmp    80103f43 <fdalloc+0x2f>
    }
  }
  return -1;
80103f3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103f43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f46:	c9                   	leave  
80103f47:	c3                   	ret    

80103f48 <isdirempty>:
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80103f48:	55                   	push   %ebp
80103f49:	89 e5                	mov    %esp,%ebp
80103f4b:	56                   	push   %esi
80103f4c:	53                   	push   %ebx
80103f4d:	83 ec 10             	sub    $0x10,%esp
80103f50:	89 c3                	mov    %eax,%ebx
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80103f52:	b8 20 00 00 00       	mov    $0x20,%eax
80103f57:	89 c6                	mov    %eax,%esi
80103f59:	39 43 58             	cmp    %eax,0x58(%ebx)
80103f5c:	76 2e                	jbe    80103f8c <isdirempty+0x44>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103f5e:	6a 10                	push   $0x10
80103f60:	50                   	push   %eax
80103f61:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103f64:	50                   	push   %eax
80103f65:	53                   	push   %ebx
80103f66:	e8 88 d7 ff ff       	call   801016f3 <readi>
80103f6b:	83 c4 10             	add    $0x10,%esp
80103f6e:	83 f8 10             	cmp    $0x10,%eax
80103f71:	75 0c                	jne    80103f7f <isdirempty+0x37>
      panic("isdirempty: readi");
    if(de.inum != 0)
80103f73:	66 83 7d e8 00       	cmpw   $0x0,-0x18(%ebp)
80103f78:	75 1e                	jne    80103f98 <isdirempty+0x50>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80103f7a:	8d 46 10             	lea    0x10(%esi),%eax
80103f7d:	eb d8                	jmp    80103f57 <isdirempty+0xf>
      panic("isdirempty: readi");
80103f7f:	83 ec 0c             	sub    $0xc,%esp
80103f82:	68 c0 6c 10 80       	push   $0x80106cc0
80103f87:	e8 b5 c3 ff ff       	call   80100341 <panic>
      return 0;
  }
  return 1;
80103f8c:	b8 01 00 00 00       	mov    $0x1,%eax
}
80103f91:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f94:	5b                   	pop    %ebx
80103f95:	5e                   	pop    %esi
80103f96:	5d                   	pop    %ebp
80103f97:	c3                   	ret    
      return 0;
80103f98:	b8 00 00 00 00       	mov    $0x0,%eax
80103f9d:	eb f2                	jmp    80103f91 <isdirempty+0x49>

80103f9f <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80103f9f:	55                   	push   %ebp
80103fa0:	89 e5                	mov    %esp,%ebp
80103fa2:	57                   	push   %edi
80103fa3:	56                   	push   %esi
80103fa4:	53                   	push   %ebx
80103fa5:	83 ec 44             	sub    $0x44,%esp
80103fa8:	89 d7                	mov    %edx,%edi
80103faa:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
80103fad:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103fb0:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80103fb3:	8d 55 d6             	lea    -0x2a(%ebp),%edx
80103fb6:	52                   	push   %edx
80103fb7:	50                   	push   %eax
80103fb8:	e8 c5 db ff ff       	call   80101b82 <nameiparent>
80103fbd:	89 c6                	mov    %eax,%esi
80103fbf:	83 c4 10             	add    $0x10,%esp
80103fc2:	85 c0                	test   %eax,%eax
80103fc4:	0f 84 32 01 00 00    	je     801040fc <create+0x15d>
    return 0;
  ilock(dp);
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	50                   	push   %eax
80103fce:	e8 33 d5 ff ff       	call   80101506 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80103fd3:	83 c4 0c             	add    $0xc,%esp
80103fd6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80103fd9:	50                   	push   %eax
80103fda:	8d 45 d6             	lea    -0x2a(%ebp),%eax
80103fdd:	50                   	push   %eax
80103fde:	56                   	push   %esi
80103fdf:	e8 58 d9 ff ff       	call   8010193c <dirlookup>
80103fe4:	89 c3                	mov    %eax,%ebx
80103fe6:	83 c4 10             	add    $0x10,%esp
80103fe9:	85 c0                	test   %eax,%eax
80103feb:	74 3c                	je     80104029 <create+0x8a>
    iunlockput(dp);
80103fed:	83 ec 0c             	sub    $0xc,%esp
80103ff0:	56                   	push   %esi
80103ff1:	e8 b3 d6 ff ff       	call   801016a9 <iunlockput>
    ilock(ip);
80103ff6:	89 1c 24             	mov    %ebx,(%esp)
80103ff9:	e8 08 d5 ff ff       	call   80101506 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80103ffe:	83 c4 10             	add    $0x10,%esp
80104001:	66 83 ff 02          	cmp    $0x2,%di
80104005:	75 07                	jne    8010400e <create+0x6f>
80104007:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
8010400c:	74 11                	je     8010401f <create+0x80>
      return ip;
    iunlockput(ip);
8010400e:	83 ec 0c             	sub    $0xc,%esp
80104011:	53                   	push   %ebx
80104012:	e8 92 d6 ff ff       	call   801016a9 <iunlockput>
    return 0;
80104017:	83 c4 10             	add    $0x10,%esp
8010401a:	bb 00 00 00 00       	mov    $0x0,%ebx
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010401f:	89 d8                	mov    %ebx,%eax
80104021:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104024:	5b                   	pop    %ebx
80104025:	5e                   	pop    %esi
80104026:	5f                   	pop    %edi
80104027:	5d                   	pop    %ebp
80104028:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104029:	83 ec 08             	sub    $0x8,%esp
8010402c:	0f bf c7             	movswl %di,%eax
8010402f:	50                   	push   %eax
80104030:	ff 36                	push   (%esi)
80104032:	e8 d7 d2 ff ff       	call   8010130e <ialloc>
80104037:	89 c3                	mov    %eax,%ebx
80104039:	83 c4 10             	add    $0x10,%esp
8010403c:	85 c0                	test   %eax,%eax
8010403e:	74 53                	je     80104093 <create+0xf4>
  ilock(ip);
80104040:	83 ec 0c             	sub    $0xc,%esp
80104043:	50                   	push   %eax
80104044:	e8 bd d4 ff ff       	call   80101506 <ilock>
  ip->major = major;
80104049:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010404c:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104050:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104053:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104057:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)
  iupdate(ip);
8010405d:	89 1c 24             	mov    %ebx,(%esp)
80104060:	e8 48 d3 ff ff       	call   801013ad <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104065:	83 c4 10             	add    $0x10,%esp
80104068:	66 83 ff 01          	cmp    $0x1,%di
8010406c:	74 32                	je     801040a0 <create+0x101>
  if(dirlink(dp, name, ip->inum) < 0)
8010406e:	83 ec 04             	sub    $0x4,%esp
80104071:	ff 73 04             	push   0x4(%ebx)
80104074:	8d 45 d6             	lea    -0x2a(%ebp),%eax
80104077:	50                   	push   %eax
80104078:	56                   	push   %esi
80104079:	e8 3b da ff ff       	call   80101ab9 <dirlink>
8010407e:	83 c4 10             	add    $0x10,%esp
80104081:	85 c0                	test   %eax,%eax
80104083:	78 6a                	js     801040ef <create+0x150>
  iunlockput(dp);
80104085:	83 ec 0c             	sub    $0xc,%esp
80104088:	56                   	push   %esi
80104089:	e8 1b d6 ff ff       	call   801016a9 <iunlockput>
  return ip;
8010408e:	83 c4 10             	add    $0x10,%esp
80104091:	eb 8c                	jmp    8010401f <create+0x80>
    panic("create: ialloc");
80104093:	83 ec 0c             	sub    $0xc,%esp
80104096:	68 d2 6c 10 80       	push   $0x80106cd2
8010409b:	e8 a1 c2 ff ff       	call   80100341 <panic>
    dp->nlink++;  // for ".."
801040a0:	66 8b 46 56          	mov    0x56(%esi),%ax
801040a4:	40                   	inc    %eax
801040a5:	66 89 46 56          	mov    %ax,0x56(%esi)
    iupdate(dp);
801040a9:	83 ec 0c             	sub    $0xc,%esp
801040ac:	56                   	push   %esi
801040ad:	e8 fb d2 ff ff       	call   801013ad <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801040b2:	83 c4 0c             	add    $0xc,%esp
801040b5:	ff 73 04             	push   0x4(%ebx)
801040b8:	68 e2 6c 10 80       	push   $0x80106ce2
801040bd:	53                   	push   %ebx
801040be:	e8 f6 d9 ff ff       	call   80101ab9 <dirlink>
801040c3:	83 c4 10             	add    $0x10,%esp
801040c6:	85 c0                	test   %eax,%eax
801040c8:	78 18                	js     801040e2 <create+0x143>
801040ca:	83 ec 04             	sub    $0x4,%esp
801040cd:	ff 76 04             	push   0x4(%esi)
801040d0:	68 e1 6c 10 80       	push   $0x80106ce1
801040d5:	53                   	push   %ebx
801040d6:	e8 de d9 ff ff       	call   80101ab9 <dirlink>
801040db:	83 c4 10             	add    $0x10,%esp
801040de:	85 c0                	test   %eax,%eax
801040e0:	79 8c                	jns    8010406e <create+0xcf>
      panic("create dots");
801040e2:	83 ec 0c             	sub    $0xc,%esp
801040e5:	68 e4 6c 10 80       	push   $0x80106ce4
801040ea:	e8 52 c2 ff ff       	call   80100341 <panic>
    panic("create: dirlink");
801040ef:	83 ec 0c             	sub    $0xc,%esp
801040f2:	68 f0 6c 10 80       	push   $0x80106cf0
801040f7:	e8 45 c2 ff ff       	call   80100341 <panic>
    return 0;
801040fc:	89 c3                	mov    %eax,%ebx
801040fe:	e9 1c ff ff ff       	jmp    8010401f <create+0x80>

80104103 <sys_dup>:
{
80104103:	55                   	push   %ebp
80104104:	89 e5                	mov    %esp,%ebp
80104106:	53                   	push   %ebx
80104107:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
8010410a:	8d 4d f4             	lea    -0xc(%ebp),%ecx
8010410d:	ba 00 00 00 00       	mov    $0x0,%edx
80104112:	b8 00 00 00 00       	mov    $0x0,%eax
80104117:	e8 98 fd ff ff       	call   80103eb4 <argfd>
8010411c:	85 c0                	test   %eax,%eax
8010411e:	78 23                	js     80104143 <sys_dup+0x40>
  if((fd=fdalloc(f)) < 0)
80104120:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104123:	e8 ec fd ff ff       	call   80103f14 <fdalloc>
80104128:	89 c3                	mov    %eax,%ebx
8010412a:	85 c0                	test   %eax,%eax
8010412c:	78 1c                	js     8010414a <sys_dup+0x47>
  filedup(f);
8010412e:	83 ec 0c             	sub    $0xc,%esp
80104131:	ff 75 f4             	push   -0xc(%ebp)
80104134:	e8 0e cb ff ff       	call   80100c47 <filedup>
  return fd;
80104139:	83 c4 10             	add    $0x10,%esp
}
8010413c:	89 d8                	mov    %ebx,%eax
8010413e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104141:	c9                   	leave  
80104142:	c3                   	ret    
    return -1;
80104143:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104148:	eb f2                	jmp    8010413c <sys_dup+0x39>
    return -1;
8010414a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010414f:	eb eb                	jmp    8010413c <sys_dup+0x39>

80104151 <sys_dup2>:
sys_dup2(void){
80104151:	55                   	push   %ebp
80104152:	89 e5                	mov    %esp,%ebp
80104154:	57                   	push   %edi
80104155:	56                   	push   %esi
80104156:	53                   	push   %ebx
80104157:	83 ec 1c             	sub    $0x1c,%esp
 if(argfd(0, &oldfd, &oldfile) < 0 || argint(1, &newfd) < 0 || newfd < 0 || newfd >= NOFILE) 
8010415a:	8d 4d e4             	lea    -0x1c(%ebp),%ecx
8010415d:	8d 55 e0             	lea    -0x20(%ebp),%edx
80104160:	b8 00 00 00 00       	mov    $0x0,%eax
80104165:	e8 4a fd ff ff       	call   80103eb4 <argfd>
8010416a:	85 c0                	test   %eax,%eax
8010416c:	78 78                	js     801041e6 <sys_dup2+0x95>
8010416e:	83 ec 08             	sub    $0x8,%esp
80104171:	8d 45 dc             	lea    -0x24(%ebp),%eax
80104174:	50                   	push   %eax
80104175:	6a 01                	push   $0x1
80104177:	e8 1e fc ff ff       	call   80103d9a <argint>
8010417c:	83 c4 10             	add    $0x10,%esp
8010417f:	85 c0                	test   %eax,%eax
80104181:	78 63                	js     801041e6 <sys_dup2+0x95>
80104183:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104186:	85 c0                	test   %eax,%eax
80104188:	78 5c                	js     801041e6 <sys_dup2+0x95>
8010418a:	83 f8 0f             	cmp    $0xf,%eax
8010418d:	7f 57                	jg     801041e6 <sys_dup2+0x95>
 if(oldfd == newfd)
8010418f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104192:	39 d0                	cmp    %edx,%eax
80104194:	74 46                	je     801041dc <sys_dup2+0x8b>
 if(myproc()->ofile[newfd])
80104196:	e8 7e ef ff ff       	call   80103119 <myproc>
8010419b:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010419e:	83 7c 90 28 00       	cmpl   $0x0,0x28(%eax,%edx,4)
801041a3:	74 17                	je     801041bc <sys_dup2+0x6b>
	fileclose(myproc()->ofile[newfd]);
801041a5:	e8 6f ef ff ff       	call   80103119 <myproc>
801041aa:	83 ec 0c             	sub    $0xc,%esp
801041ad:	8b 55 dc             	mov    -0x24(%ebp),%edx
801041b0:	ff 74 90 28          	push   0x28(%eax,%edx,4)
801041b4:	e8 d1 ca ff ff       	call   80100c8a <fileclose>
801041b9:	83 c4 10             	add    $0x10,%esp
 myproc()->ofile[newfd] = filedup(oldfile);
801041bc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801041bf:	e8 55 ef ff ff       	call   80103119 <myproc>
801041c4:	89 c3                	mov    %eax,%ebx
801041c6:	8b 75 dc             	mov    -0x24(%ebp),%esi
801041c9:	83 ec 0c             	sub    $0xc,%esp
801041cc:	57                   	push   %edi
801041cd:	e8 75 ca ff ff       	call   80100c47 <filedup>
801041d2:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
 return newfd;
801041d6:	8b 55 dc             	mov    -0x24(%ebp),%edx
801041d9:	83 c4 10             	add    $0x10,%esp
}
801041dc:	89 d0                	mov    %edx,%eax
801041de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041e1:	5b                   	pop    %ebx
801041e2:	5e                   	pop    %esi
801041e3:	5f                   	pop    %edi
801041e4:	5d                   	pop    %ebp
801041e5:	c3                   	ret    
	return -1;
801041e6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801041eb:	eb ef                	jmp    801041dc <sys_dup2+0x8b>

801041ed <sys_read>:
{
801041ed:	55                   	push   %ebp
801041ee:	89 e5                	mov    %esp,%ebp
801041f0:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, (void**)&p, n) < 0)
801041f3:	8d 4d f4             	lea    -0xc(%ebp),%ecx
801041f6:	ba 00 00 00 00       	mov    $0x0,%edx
801041fb:	b8 00 00 00 00       	mov    $0x0,%eax
80104200:	e8 af fc ff ff       	call   80103eb4 <argfd>
80104205:	85 c0                	test   %eax,%eax
80104207:	78 43                	js     8010424c <sys_read+0x5f>
80104209:	83 ec 08             	sub    $0x8,%esp
8010420c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010420f:	50                   	push   %eax
80104210:	6a 02                	push   $0x2
80104212:	e8 83 fb ff ff       	call   80103d9a <argint>
80104217:	83 c4 10             	add    $0x10,%esp
8010421a:	85 c0                	test   %eax,%eax
8010421c:	78 2e                	js     8010424c <sys_read+0x5f>
8010421e:	83 ec 04             	sub    $0x4,%esp
80104221:	ff 75 f0             	push   -0x10(%ebp)
80104224:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104227:	50                   	push   %eax
80104228:	6a 01                	push   $0x1
8010422a:	e8 93 fb ff ff       	call   80103dc2 <argptr>
8010422f:	83 c4 10             	add    $0x10,%esp
80104232:	85 c0                	test   %eax,%eax
80104234:	78 16                	js     8010424c <sys_read+0x5f>
  return fileread(f, p, n);
80104236:	83 ec 04             	sub    $0x4,%esp
80104239:	ff 75 f0             	push   -0x10(%ebp)
8010423c:	ff 75 ec             	push   -0x14(%ebp)
8010423f:	ff 75 f4             	push   -0xc(%ebp)
80104242:	e8 3c cb ff ff       	call   80100d83 <fileread>
80104247:	83 c4 10             	add    $0x10,%esp
}
8010424a:	c9                   	leave  
8010424b:	c3                   	ret    
    return -1;
8010424c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104251:	eb f7                	jmp    8010424a <sys_read+0x5d>

80104253 <sys_write>:
{
80104253:	55                   	push   %ebp
80104254:	89 e5                	mov    %esp,%ebp
80104256:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, (void**)&p, n) < 0)
80104259:	8d 4d f4             	lea    -0xc(%ebp),%ecx
8010425c:	ba 00 00 00 00       	mov    $0x0,%edx
80104261:	b8 00 00 00 00       	mov    $0x0,%eax
80104266:	e8 49 fc ff ff       	call   80103eb4 <argfd>
8010426b:	85 c0                	test   %eax,%eax
8010426d:	78 43                	js     801042b2 <sys_write+0x5f>
8010426f:	83 ec 08             	sub    $0x8,%esp
80104272:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104275:	50                   	push   %eax
80104276:	6a 02                	push   $0x2
80104278:	e8 1d fb ff ff       	call   80103d9a <argint>
8010427d:	83 c4 10             	add    $0x10,%esp
80104280:	85 c0                	test   %eax,%eax
80104282:	78 2e                	js     801042b2 <sys_write+0x5f>
80104284:	83 ec 04             	sub    $0x4,%esp
80104287:	ff 75 f0             	push   -0x10(%ebp)
8010428a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010428d:	50                   	push   %eax
8010428e:	6a 01                	push   $0x1
80104290:	e8 2d fb ff ff       	call   80103dc2 <argptr>
80104295:	83 c4 10             	add    $0x10,%esp
80104298:	85 c0                	test   %eax,%eax
8010429a:	78 16                	js     801042b2 <sys_write+0x5f>
  return filewrite(f, p, n);
8010429c:	83 ec 04             	sub    $0x4,%esp
8010429f:	ff 75 f0             	push   -0x10(%ebp)
801042a2:	ff 75 ec             	push   -0x14(%ebp)
801042a5:	ff 75 f4             	push   -0xc(%ebp)
801042a8:	e8 5b cb ff ff       	call   80100e08 <filewrite>
801042ad:	83 c4 10             	add    $0x10,%esp
}
801042b0:	c9                   	leave  
801042b1:	c3                   	ret    
    return -1;
801042b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042b7:	eb f7                	jmp    801042b0 <sys_write+0x5d>

801042b9 <sys_close>:
{
801042b9:	55                   	push   %ebp
801042ba:	89 e5                	mov    %esp,%ebp
801042bc:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801042bf:	8d 4d f0             	lea    -0x10(%ebp),%ecx
801042c2:	8d 55 f4             	lea    -0xc(%ebp),%edx
801042c5:	b8 00 00 00 00       	mov    $0x0,%eax
801042ca:	e8 e5 fb ff ff       	call   80103eb4 <argfd>
801042cf:	85 c0                	test   %eax,%eax
801042d1:	78 25                	js     801042f8 <sys_close+0x3f>
  myproc()->ofile[fd] = 0;
801042d3:	e8 41 ee ff ff       	call   80103119 <myproc>
801042d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042db:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801042e2:	00 
  fileclose(f);
801042e3:	83 ec 0c             	sub    $0xc,%esp
801042e6:	ff 75 f0             	push   -0x10(%ebp)
801042e9:	e8 9c c9 ff ff       	call   80100c8a <fileclose>
  return 0;
801042ee:	83 c4 10             	add    $0x10,%esp
801042f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801042f6:	c9                   	leave  
801042f7:	c3                   	ret    
    return -1;
801042f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042fd:	eb f7                	jmp    801042f6 <sys_close+0x3d>

801042ff <sys_fstat>:
{
801042ff:	55                   	push   %ebp
80104300:	89 e5                	mov    %esp,%ebp
80104302:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104305:	8d 4d f4             	lea    -0xc(%ebp),%ecx
80104308:	ba 00 00 00 00       	mov    $0x0,%edx
8010430d:	b8 00 00 00 00       	mov    $0x0,%eax
80104312:	e8 9d fb ff ff       	call   80103eb4 <argfd>
80104317:	85 c0                	test   %eax,%eax
80104319:	78 2a                	js     80104345 <sys_fstat+0x46>
8010431b:	83 ec 04             	sub    $0x4,%esp
8010431e:	6a 14                	push   $0x14
80104320:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104323:	50                   	push   %eax
80104324:	6a 01                	push   $0x1
80104326:	e8 97 fa ff ff       	call   80103dc2 <argptr>
8010432b:	83 c4 10             	add    $0x10,%esp
8010432e:	85 c0                	test   %eax,%eax
80104330:	78 13                	js     80104345 <sys_fstat+0x46>
  return filestat(f, st);
80104332:	83 ec 08             	sub    $0x8,%esp
80104335:	ff 75 f0             	push   -0x10(%ebp)
80104338:	ff 75 f4             	push   -0xc(%ebp)
8010433b:	e8 fc c9 ff ff       	call   80100d3c <filestat>
80104340:	83 c4 10             	add    $0x10,%esp
}
80104343:	c9                   	leave  
80104344:	c3                   	ret    
    return -1;
80104345:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010434a:	eb f7                	jmp    80104343 <sys_fstat+0x44>

8010434c <sys_link>:
{
8010434c:	55                   	push   %ebp
8010434d:	89 e5                	mov    %esp,%ebp
8010434f:	56                   	push   %esi
80104350:	53                   	push   %ebx
80104351:	83 ec 28             	sub    $0x28,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104354:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104357:	50                   	push   %eax
80104358:	6a 00                	push   $0x0
8010435a:	e8 cb fa ff ff       	call   80103e2a <argstr>
8010435f:	83 c4 10             	add    $0x10,%esp
80104362:	85 c0                	test   %eax,%eax
80104364:	0f 88 d1 00 00 00    	js     8010443b <sys_link+0xef>
8010436a:	83 ec 08             	sub    $0x8,%esp
8010436d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104370:	50                   	push   %eax
80104371:	6a 01                	push   $0x1
80104373:	e8 b2 fa ff ff       	call   80103e2a <argstr>
80104378:	83 c4 10             	add    $0x10,%esp
8010437b:	85 c0                	test   %eax,%eax
8010437d:	0f 88 b8 00 00 00    	js     8010443b <sys_link+0xef>
  begin_op();
80104383:	e8 54 e3 ff ff       	call   801026dc <begin_op>
  if((ip = namei(old)) == 0){
80104388:	83 ec 0c             	sub    $0xc,%esp
8010438b:	ff 75 e0             	push   -0x20(%ebp)
8010438e:	e8 d7 d7 ff ff       	call   80101b6a <namei>
80104393:	89 c3                	mov    %eax,%ebx
80104395:	83 c4 10             	add    $0x10,%esp
80104398:	85 c0                	test   %eax,%eax
8010439a:	0f 84 a2 00 00 00    	je     80104442 <sys_link+0xf6>
  ilock(ip);
801043a0:	83 ec 0c             	sub    $0xc,%esp
801043a3:	50                   	push   %eax
801043a4:	e8 5d d1 ff ff       	call   80101506 <ilock>
  if(ip->type == T_DIR){
801043a9:	83 c4 10             	add    $0x10,%esp
801043ac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801043b1:	0f 84 97 00 00 00    	je     8010444e <sys_link+0x102>
  ip->nlink++;
801043b7:	66 8b 43 56          	mov    0x56(%ebx),%ax
801043bb:	40                   	inc    %eax
801043bc:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801043c0:	83 ec 0c             	sub    $0xc,%esp
801043c3:	53                   	push   %ebx
801043c4:	e8 e4 cf ff ff       	call   801013ad <iupdate>
  iunlock(ip);
801043c9:	89 1c 24             	mov    %ebx,(%esp)
801043cc:	e8 f5 d1 ff ff       	call   801015c6 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801043d1:	83 c4 08             	add    $0x8,%esp
801043d4:	8d 45 ea             	lea    -0x16(%ebp),%eax
801043d7:	50                   	push   %eax
801043d8:	ff 75 e4             	push   -0x1c(%ebp)
801043db:	e8 a2 d7 ff ff       	call   80101b82 <nameiparent>
801043e0:	89 c6                	mov    %eax,%esi
801043e2:	83 c4 10             	add    $0x10,%esp
801043e5:	85 c0                	test   %eax,%eax
801043e7:	0f 84 85 00 00 00    	je     80104472 <sys_link+0x126>
  ilock(dp);
801043ed:	83 ec 0c             	sub    $0xc,%esp
801043f0:	50                   	push   %eax
801043f1:	e8 10 d1 ff ff       	call   80101506 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801043f6:	83 c4 10             	add    $0x10,%esp
801043f9:	8b 03                	mov    (%ebx),%eax
801043fb:	39 06                	cmp    %eax,(%esi)
801043fd:	75 67                	jne    80104466 <sys_link+0x11a>
801043ff:	83 ec 04             	sub    $0x4,%esp
80104402:	ff 73 04             	push   0x4(%ebx)
80104405:	8d 45 ea             	lea    -0x16(%ebp),%eax
80104408:	50                   	push   %eax
80104409:	56                   	push   %esi
8010440a:	e8 aa d6 ff ff       	call   80101ab9 <dirlink>
8010440f:	83 c4 10             	add    $0x10,%esp
80104412:	85 c0                	test   %eax,%eax
80104414:	78 50                	js     80104466 <sys_link+0x11a>
  iunlockput(dp);
80104416:	83 ec 0c             	sub    $0xc,%esp
80104419:	56                   	push   %esi
8010441a:	e8 8a d2 ff ff       	call   801016a9 <iunlockput>
  iput(ip);
8010441f:	89 1c 24             	mov    %ebx,(%esp)
80104422:	e8 e4 d1 ff ff       	call   8010160b <iput>
  end_op();
80104427:	e8 2c e3 ff ff       	call   80102758 <end_op>
  return 0;
8010442c:	83 c4 10             	add    $0x10,%esp
8010442f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104434:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104437:	5b                   	pop    %ebx
80104438:	5e                   	pop    %esi
80104439:	5d                   	pop    %ebp
8010443a:	c3                   	ret    
    return -1;
8010443b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104440:	eb f2                	jmp    80104434 <sys_link+0xe8>
    end_op();
80104442:	e8 11 e3 ff ff       	call   80102758 <end_op>
    return -1;
80104447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010444c:	eb e6                	jmp    80104434 <sys_link+0xe8>
    iunlockput(ip);
8010444e:	83 ec 0c             	sub    $0xc,%esp
80104451:	53                   	push   %ebx
80104452:	e8 52 d2 ff ff       	call   801016a9 <iunlockput>
    end_op();
80104457:	e8 fc e2 ff ff       	call   80102758 <end_op>
    return -1;
8010445c:	83 c4 10             	add    $0x10,%esp
8010445f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104464:	eb ce                	jmp    80104434 <sys_link+0xe8>
    iunlockput(dp);
80104466:	83 ec 0c             	sub    $0xc,%esp
80104469:	56                   	push   %esi
8010446a:	e8 3a d2 ff ff       	call   801016a9 <iunlockput>
    goto bad;
8010446f:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104472:	83 ec 0c             	sub    $0xc,%esp
80104475:	53                   	push   %ebx
80104476:	e8 8b d0 ff ff       	call   80101506 <ilock>
  ip->nlink--;
8010447b:	66 8b 43 56          	mov    0x56(%ebx),%ax
8010447f:	48                   	dec    %eax
80104480:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104484:	89 1c 24             	mov    %ebx,(%esp)
80104487:	e8 21 cf ff ff       	call   801013ad <iupdate>
  iunlockput(ip);
8010448c:	89 1c 24             	mov    %ebx,(%esp)
8010448f:	e8 15 d2 ff ff       	call   801016a9 <iunlockput>
  end_op();
80104494:	e8 bf e2 ff ff       	call   80102758 <end_op>
  return -1;
80104499:	83 c4 10             	add    $0x10,%esp
8010449c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044a1:	eb 91                	jmp    80104434 <sys_link+0xe8>

801044a3 <sys_unlink>:
{
801044a3:	55                   	push   %ebp
801044a4:	89 e5                	mov    %esp,%ebp
801044a6:	57                   	push   %edi
801044a7:	56                   	push   %esi
801044a8:	53                   	push   %ebx
801044a9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801044ac:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801044af:	50                   	push   %eax
801044b0:	6a 00                	push   $0x0
801044b2:	e8 73 f9 ff ff       	call   80103e2a <argstr>
801044b7:	83 c4 10             	add    $0x10,%esp
801044ba:	85 c0                	test   %eax,%eax
801044bc:	0f 88 7f 01 00 00    	js     80104641 <sys_unlink+0x19e>
  begin_op();
801044c2:	e8 15 e2 ff ff       	call   801026dc <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801044c7:	83 ec 08             	sub    $0x8,%esp
801044ca:	8d 45 ca             	lea    -0x36(%ebp),%eax
801044cd:	50                   	push   %eax
801044ce:	ff 75 c4             	push   -0x3c(%ebp)
801044d1:	e8 ac d6 ff ff       	call   80101b82 <nameiparent>
801044d6:	89 c6                	mov    %eax,%esi
801044d8:	83 c4 10             	add    $0x10,%esp
801044db:	85 c0                	test   %eax,%eax
801044dd:	0f 84 eb 00 00 00    	je     801045ce <sys_unlink+0x12b>
  ilock(dp);
801044e3:	83 ec 0c             	sub    $0xc,%esp
801044e6:	50                   	push   %eax
801044e7:	e8 1a d0 ff ff       	call   80101506 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801044ec:	83 c4 08             	add    $0x8,%esp
801044ef:	68 e2 6c 10 80       	push   $0x80106ce2
801044f4:	8d 45 ca             	lea    -0x36(%ebp),%eax
801044f7:	50                   	push   %eax
801044f8:	e8 2a d4 ff ff       	call   80101927 <namecmp>
801044fd:	83 c4 10             	add    $0x10,%esp
80104500:	85 c0                	test   %eax,%eax
80104502:	0f 84 fa 00 00 00    	je     80104602 <sys_unlink+0x15f>
80104508:	83 ec 08             	sub    $0x8,%esp
8010450b:	68 e1 6c 10 80       	push   $0x80106ce1
80104510:	8d 45 ca             	lea    -0x36(%ebp),%eax
80104513:	50                   	push   %eax
80104514:	e8 0e d4 ff ff       	call   80101927 <namecmp>
80104519:	83 c4 10             	add    $0x10,%esp
8010451c:	85 c0                	test   %eax,%eax
8010451e:	0f 84 de 00 00 00    	je     80104602 <sys_unlink+0x15f>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104524:	83 ec 04             	sub    $0x4,%esp
80104527:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010452a:	50                   	push   %eax
8010452b:	8d 45 ca             	lea    -0x36(%ebp),%eax
8010452e:	50                   	push   %eax
8010452f:	56                   	push   %esi
80104530:	e8 07 d4 ff ff       	call   8010193c <dirlookup>
80104535:	89 c3                	mov    %eax,%ebx
80104537:	83 c4 10             	add    $0x10,%esp
8010453a:	85 c0                	test   %eax,%eax
8010453c:	0f 84 c0 00 00 00    	je     80104602 <sys_unlink+0x15f>
  ilock(ip);
80104542:	83 ec 0c             	sub    $0xc,%esp
80104545:	50                   	push   %eax
80104546:	e8 bb cf ff ff       	call   80101506 <ilock>
  if(ip->nlink < 1)
8010454b:	83 c4 10             	add    $0x10,%esp
8010454e:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104553:	0f 8e 81 00 00 00    	jle    801045da <sys_unlink+0x137>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104559:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010455e:	0f 84 83 00 00 00    	je     801045e7 <sys_unlink+0x144>
  memset(&de, 0, sizeof(de));
80104564:	83 ec 04             	sub    $0x4,%esp
80104567:	6a 10                	push   $0x10
80104569:	6a 00                	push   $0x0
8010456b:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010456e:	57                   	push   %edi
8010456f:	e8 f3 f5 ff ff       	call   80103b67 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104574:	6a 10                	push   $0x10
80104576:	ff 75 c0             	push   -0x40(%ebp)
80104579:	57                   	push   %edi
8010457a:	56                   	push   %esi
8010457b:	e8 73 d2 ff ff       	call   801017f3 <writei>
80104580:	83 c4 20             	add    $0x20,%esp
80104583:	83 f8 10             	cmp    $0x10,%eax
80104586:	0f 85 8e 00 00 00    	jne    8010461a <sys_unlink+0x177>
  if(ip->type == T_DIR){
8010458c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104591:	0f 84 90 00 00 00    	je     80104627 <sys_unlink+0x184>
  iunlockput(dp);
80104597:	83 ec 0c             	sub    $0xc,%esp
8010459a:	56                   	push   %esi
8010459b:	e8 09 d1 ff ff       	call   801016a9 <iunlockput>
  ip->nlink--;
801045a0:	66 8b 43 56          	mov    0x56(%ebx),%ax
801045a4:	48                   	dec    %eax
801045a5:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801045a9:	89 1c 24             	mov    %ebx,(%esp)
801045ac:	e8 fc cd ff ff       	call   801013ad <iupdate>
  iunlockput(ip);
801045b1:	89 1c 24             	mov    %ebx,(%esp)
801045b4:	e8 f0 d0 ff ff       	call   801016a9 <iunlockput>
  end_op();
801045b9:	e8 9a e1 ff ff       	call   80102758 <end_op>
  return 0;
801045be:	83 c4 10             	add    $0x10,%esp
801045c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801045c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045c9:	5b                   	pop    %ebx
801045ca:	5e                   	pop    %esi
801045cb:	5f                   	pop    %edi
801045cc:	5d                   	pop    %ebp
801045cd:	c3                   	ret    
    end_op();
801045ce:	e8 85 e1 ff ff       	call   80102758 <end_op>
    return -1;
801045d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045d8:	eb ec                	jmp    801045c6 <sys_unlink+0x123>
    panic("unlink: nlink < 1");
801045da:	83 ec 0c             	sub    $0xc,%esp
801045dd:	68 00 6d 10 80       	push   $0x80106d00
801045e2:	e8 5a bd ff ff       	call   80100341 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
801045e7:	89 d8                	mov    %ebx,%eax
801045e9:	e8 5a f9 ff ff       	call   80103f48 <isdirempty>
801045ee:	85 c0                	test   %eax,%eax
801045f0:	0f 85 6e ff ff ff    	jne    80104564 <sys_unlink+0xc1>
    iunlockput(ip);
801045f6:	83 ec 0c             	sub    $0xc,%esp
801045f9:	53                   	push   %ebx
801045fa:	e8 aa d0 ff ff       	call   801016a9 <iunlockput>
    goto bad;
801045ff:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80104602:	83 ec 0c             	sub    $0xc,%esp
80104605:	56                   	push   %esi
80104606:	e8 9e d0 ff ff       	call   801016a9 <iunlockput>
  end_op();
8010460b:	e8 48 e1 ff ff       	call   80102758 <end_op>
  return -1;
80104610:	83 c4 10             	add    $0x10,%esp
80104613:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104618:	eb ac                	jmp    801045c6 <sys_unlink+0x123>
    panic("unlink: writei");
8010461a:	83 ec 0c             	sub    $0xc,%esp
8010461d:	68 12 6d 10 80       	push   $0x80106d12
80104622:	e8 1a bd ff ff       	call   80100341 <panic>
    dp->nlink--;
80104627:	66 8b 46 56          	mov    0x56(%esi),%ax
8010462b:	48                   	dec    %eax
8010462c:	66 89 46 56          	mov    %ax,0x56(%esi)
    iupdate(dp);
80104630:	83 ec 0c             	sub    $0xc,%esp
80104633:	56                   	push   %esi
80104634:	e8 74 cd ff ff       	call   801013ad <iupdate>
80104639:	83 c4 10             	add    $0x10,%esp
8010463c:	e9 56 ff ff ff       	jmp    80104597 <sys_unlink+0xf4>
    return -1;
80104641:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104646:	e9 7b ff ff ff       	jmp    801045c6 <sys_unlink+0x123>

8010464b <sys_open>:

int
sys_open(void)
{
8010464b:	55                   	push   %ebp
8010464c:	89 e5                	mov    %esp,%ebp
8010464e:	57                   	push   %edi
8010464f:	56                   	push   %esi
80104650:	53                   	push   %ebx
80104651:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104654:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104657:	50                   	push   %eax
80104658:	6a 00                	push   $0x0
8010465a:	e8 cb f7 ff ff       	call   80103e2a <argstr>
8010465f:	83 c4 10             	add    $0x10,%esp
80104662:	85 c0                	test   %eax,%eax
80104664:	0f 88 a0 00 00 00    	js     8010470a <sys_open+0xbf>
8010466a:	83 ec 08             	sub    $0x8,%esp
8010466d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104670:	50                   	push   %eax
80104671:	6a 01                	push   $0x1
80104673:	e8 22 f7 ff ff       	call   80103d9a <argint>
80104678:	83 c4 10             	add    $0x10,%esp
8010467b:	85 c0                	test   %eax,%eax
8010467d:	0f 88 87 00 00 00    	js     8010470a <sys_open+0xbf>
    return -1;

  begin_op();
80104683:	e8 54 e0 ff ff       	call   801026dc <begin_op>

  if(omode & O_CREATE){
80104688:	f6 45 e1 02          	testb  $0x2,-0x1f(%ebp)
8010468c:	0f 84 8b 00 00 00    	je     8010471d <sys_open+0xd2>
    ip = create(path, T_FILE, 0, 0);
80104692:	83 ec 0c             	sub    $0xc,%esp
80104695:	6a 00                	push   $0x0
80104697:	b9 00 00 00 00       	mov    $0x0,%ecx
8010469c:	ba 02 00 00 00       	mov    $0x2,%edx
801046a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801046a4:	e8 f6 f8 ff ff       	call   80103f9f <create>
801046a9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801046ab:	83 c4 10             	add    $0x10,%esp
801046ae:	85 c0                	test   %eax,%eax
801046b0:	74 5f                	je     80104711 <sys_open+0xc6>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801046b2:	e8 2f c5 ff ff       	call   80100be6 <filealloc>
801046b7:	89 c3                	mov    %eax,%ebx
801046b9:	85 c0                	test   %eax,%eax
801046bb:	0f 84 b5 00 00 00    	je     80104776 <sys_open+0x12b>
801046c1:	e8 4e f8 ff ff       	call   80103f14 <fdalloc>
801046c6:	89 c7                	mov    %eax,%edi
801046c8:	85 c0                	test   %eax,%eax
801046ca:	0f 88 a6 00 00 00    	js     80104776 <sys_open+0x12b>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801046d0:	83 ec 0c             	sub    $0xc,%esp
801046d3:	56                   	push   %esi
801046d4:	e8 ed ce ff ff       	call   801015c6 <iunlock>
  end_op();
801046d9:	e8 7a e0 ff ff       	call   80102758 <end_op>

  f->type = FD_INODE;
801046de:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
801046e4:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
801046e7:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
801046ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046f1:	83 c4 10             	add    $0x10,%esp
801046f4:	a8 01                	test   $0x1,%al
801046f6:	0f 94 43 08          	sete   0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801046fa:	a8 03                	test   $0x3,%al
801046fc:	0f 95 43 09          	setne  0x9(%ebx)
  return fd;
}
80104700:	89 f8                	mov    %edi,%eax
80104702:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104705:	5b                   	pop    %ebx
80104706:	5e                   	pop    %esi
80104707:	5f                   	pop    %edi
80104708:	5d                   	pop    %ebp
80104709:	c3                   	ret    
    return -1;
8010470a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010470f:	eb ef                	jmp    80104700 <sys_open+0xb5>
      end_op();
80104711:	e8 42 e0 ff ff       	call   80102758 <end_op>
      return -1;
80104716:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010471b:	eb e3                	jmp    80104700 <sys_open+0xb5>
    if((ip = namei(path)) == 0){
8010471d:	83 ec 0c             	sub    $0xc,%esp
80104720:	ff 75 e4             	push   -0x1c(%ebp)
80104723:	e8 42 d4 ff ff       	call   80101b6a <namei>
80104728:	89 c6                	mov    %eax,%esi
8010472a:	83 c4 10             	add    $0x10,%esp
8010472d:	85 c0                	test   %eax,%eax
8010472f:	74 39                	je     8010476a <sys_open+0x11f>
    ilock(ip);
80104731:	83 ec 0c             	sub    $0xc,%esp
80104734:	50                   	push   %eax
80104735:	e8 cc cd ff ff       	call   80101506 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010473a:	83 c4 10             	add    $0x10,%esp
8010473d:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104742:	0f 85 6a ff ff ff    	jne    801046b2 <sys_open+0x67>
80104748:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010474c:	0f 84 60 ff ff ff    	je     801046b2 <sys_open+0x67>
      iunlockput(ip);
80104752:	83 ec 0c             	sub    $0xc,%esp
80104755:	56                   	push   %esi
80104756:	e8 4e cf ff ff       	call   801016a9 <iunlockput>
      end_op();
8010475b:	e8 f8 df ff ff       	call   80102758 <end_op>
      return -1;
80104760:	83 c4 10             	add    $0x10,%esp
80104763:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104768:	eb 96                	jmp    80104700 <sys_open+0xb5>
      end_op();
8010476a:	e8 e9 df ff ff       	call   80102758 <end_op>
      return -1;
8010476f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104774:	eb 8a                	jmp    80104700 <sys_open+0xb5>
    if(f)
80104776:	85 db                	test   %ebx,%ebx
80104778:	74 0c                	je     80104786 <sys_open+0x13b>
      fileclose(f);
8010477a:	83 ec 0c             	sub    $0xc,%esp
8010477d:	53                   	push   %ebx
8010477e:	e8 07 c5 ff ff       	call   80100c8a <fileclose>
80104783:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80104786:	83 ec 0c             	sub    $0xc,%esp
80104789:	56                   	push   %esi
8010478a:	e8 1a cf ff ff       	call   801016a9 <iunlockput>
    end_op();
8010478f:	e8 c4 df ff ff       	call   80102758 <end_op>
    return -1;
80104794:	83 c4 10             	add    $0x10,%esp
80104797:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010479c:	e9 5f ff ff ff       	jmp    80104700 <sys_open+0xb5>

801047a1 <sys_mkdir>:

int
sys_mkdir(void)
{
801047a1:	55                   	push   %ebp
801047a2:	89 e5                	mov    %esp,%ebp
801047a4:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801047a7:	e8 30 df ff ff       	call   801026dc <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801047ac:	83 ec 08             	sub    $0x8,%esp
801047af:	8d 45 f4             	lea    -0xc(%ebp),%eax
801047b2:	50                   	push   %eax
801047b3:	6a 00                	push   $0x0
801047b5:	e8 70 f6 ff ff       	call   80103e2a <argstr>
801047ba:	83 c4 10             	add    $0x10,%esp
801047bd:	85 c0                	test   %eax,%eax
801047bf:	78 36                	js     801047f7 <sys_mkdir+0x56>
801047c1:	83 ec 0c             	sub    $0xc,%esp
801047c4:	6a 00                	push   $0x0
801047c6:	b9 00 00 00 00       	mov    $0x0,%ecx
801047cb:	ba 01 00 00 00       	mov    $0x1,%edx
801047d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047d3:	e8 c7 f7 ff ff       	call   80103f9f <create>
801047d8:	83 c4 10             	add    $0x10,%esp
801047db:	85 c0                	test   %eax,%eax
801047dd:	74 18                	je     801047f7 <sys_mkdir+0x56>
    end_op();
    return -1;
  }
  iunlockput(ip);
801047df:	83 ec 0c             	sub    $0xc,%esp
801047e2:	50                   	push   %eax
801047e3:	e8 c1 ce ff ff       	call   801016a9 <iunlockput>
  end_op();
801047e8:	e8 6b df ff ff       	call   80102758 <end_op>
  return 0;
801047ed:	83 c4 10             	add    $0x10,%esp
801047f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801047f5:	c9                   	leave  
801047f6:	c3                   	ret    
    end_op();
801047f7:	e8 5c df ff ff       	call   80102758 <end_op>
    return -1;
801047fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104801:	eb f2                	jmp    801047f5 <sys_mkdir+0x54>

80104803 <sys_mknod>:

int
sys_mknod(void)
{
80104803:	55                   	push   %ebp
80104804:	89 e5                	mov    %esp,%ebp
80104806:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104809:	e8 ce de ff ff       	call   801026dc <begin_op>
  if((argstr(0, &path)) < 0 ||
8010480e:	83 ec 08             	sub    $0x8,%esp
80104811:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104814:	50                   	push   %eax
80104815:	6a 00                	push   $0x0
80104817:	e8 0e f6 ff ff       	call   80103e2a <argstr>
8010481c:	83 c4 10             	add    $0x10,%esp
8010481f:	85 c0                	test   %eax,%eax
80104821:	78 62                	js     80104885 <sys_mknod+0x82>
     argint(1, &major) < 0 ||
80104823:	83 ec 08             	sub    $0x8,%esp
80104826:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104829:	50                   	push   %eax
8010482a:	6a 01                	push   $0x1
8010482c:	e8 69 f5 ff ff       	call   80103d9a <argint>
  if((argstr(0, &path)) < 0 ||
80104831:	83 c4 10             	add    $0x10,%esp
80104834:	85 c0                	test   %eax,%eax
80104836:	78 4d                	js     80104885 <sys_mknod+0x82>
     argint(2, &minor) < 0 ||
80104838:	83 ec 08             	sub    $0x8,%esp
8010483b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010483e:	50                   	push   %eax
8010483f:	6a 02                	push   $0x2
80104841:	e8 54 f5 ff ff       	call   80103d9a <argint>
     argint(1, &major) < 0 ||
80104846:	83 c4 10             	add    $0x10,%esp
80104849:	85 c0                	test   %eax,%eax
8010484b:	78 38                	js     80104885 <sys_mknod+0x82>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010484d:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104851:	83 ec 0c             	sub    $0xc,%esp
80104854:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
80104858:	50                   	push   %eax
80104859:	ba 03 00 00 00       	mov    $0x3,%edx
8010485e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104861:	e8 39 f7 ff ff       	call   80103f9f <create>
     argint(2, &minor) < 0 ||
80104866:	83 c4 10             	add    $0x10,%esp
80104869:	85 c0                	test   %eax,%eax
8010486b:	74 18                	je     80104885 <sys_mknod+0x82>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010486d:	83 ec 0c             	sub    $0xc,%esp
80104870:	50                   	push   %eax
80104871:	e8 33 ce ff ff       	call   801016a9 <iunlockput>
  end_op();
80104876:	e8 dd de ff ff       	call   80102758 <end_op>
  return 0;
8010487b:	83 c4 10             	add    $0x10,%esp
8010487e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104883:	c9                   	leave  
80104884:	c3                   	ret    
    end_op();
80104885:	e8 ce de ff ff       	call   80102758 <end_op>
    return -1;
8010488a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010488f:	eb f2                	jmp    80104883 <sys_mknod+0x80>

80104891 <sys_chdir>:

int
sys_chdir(void)
{
80104891:	55                   	push   %ebp
80104892:	89 e5                	mov    %esp,%ebp
80104894:	56                   	push   %esi
80104895:	53                   	push   %ebx
80104896:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80104899:	e8 7b e8 ff ff       	call   80103119 <myproc>
8010489e:	89 c6                	mov    %eax,%esi
  
  begin_op();
801048a0:	e8 37 de ff ff       	call   801026dc <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801048a5:	83 ec 08             	sub    $0x8,%esp
801048a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048ab:	50                   	push   %eax
801048ac:	6a 00                	push   $0x0
801048ae:	e8 77 f5 ff ff       	call   80103e2a <argstr>
801048b3:	83 c4 10             	add    $0x10,%esp
801048b6:	85 c0                	test   %eax,%eax
801048b8:	78 52                	js     8010490c <sys_chdir+0x7b>
801048ba:	83 ec 0c             	sub    $0xc,%esp
801048bd:	ff 75 f4             	push   -0xc(%ebp)
801048c0:	e8 a5 d2 ff ff       	call   80101b6a <namei>
801048c5:	89 c3                	mov    %eax,%ebx
801048c7:	83 c4 10             	add    $0x10,%esp
801048ca:	85 c0                	test   %eax,%eax
801048cc:	74 3e                	je     8010490c <sys_chdir+0x7b>
    end_op();
    return -1;
  }
  ilock(ip);
801048ce:	83 ec 0c             	sub    $0xc,%esp
801048d1:	50                   	push   %eax
801048d2:	e8 2f cc ff ff       	call   80101506 <ilock>
  if(ip->type != T_DIR){
801048d7:	83 c4 10             	add    $0x10,%esp
801048da:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801048df:	75 37                	jne    80104918 <sys_chdir+0x87>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801048e1:	83 ec 0c             	sub    $0xc,%esp
801048e4:	53                   	push   %ebx
801048e5:	e8 dc cc ff ff       	call   801015c6 <iunlock>
  iput(curproc->cwd);
801048ea:	83 c4 04             	add    $0x4,%esp
801048ed:	ff 76 68             	push   0x68(%esi)
801048f0:	e8 16 cd ff ff       	call   8010160b <iput>
  end_op();
801048f5:	e8 5e de ff ff       	call   80102758 <end_op>
  curproc->cwd = ip;
801048fa:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801048fd:	83 c4 10             	add    $0x10,%esp
80104900:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104905:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104908:	5b                   	pop    %ebx
80104909:	5e                   	pop    %esi
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
    end_op();
8010490c:	e8 47 de ff ff       	call   80102758 <end_op>
    return -1;
80104911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104916:	eb ed                	jmp    80104905 <sys_chdir+0x74>
    iunlockput(ip);
80104918:	83 ec 0c             	sub    $0xc,%esp
8010491b:	53                   	push   %ebx
8010491c:	e8 88 cd ff ff       	call   801016a9 <iunlockput>
    end_op();
80104921:	e8 32 de ff ff       	call   80102758 <end_op>
    return -1;
80104926:	83 c4 10             	add    $0x10,%esp
80104929:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010492e:	eb d5                	jmp    80104905 <sys_chdir+0x74>

80104930 <sys_exec>:

int
sys_exec(void)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010493a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010493d:	50                   	push   %eax
8010493e:	6a 00                	push   $0x0
80104940:	e8 e5 f4 ff ff       	call   80103e2a <argstr>
80104945:	83 c4 10             	add    $0x10,%esp
80104948:	85 c0                	test   %eax,%eax
8010494a:	78 38                	js     80104984 <sys_exec+0x54>
8010494c:	83 ec 08             	sub    $0x8,%esp
8010494f:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80104955:	50                   	push   %eax
80104956:	6a 01                	push   $0x1
80104958:	e8 3d f4 ff ff       	call   80103d9a <argint>
8010495d:	83 c4 10             	add    $0x10,%esp
80104960:	85 c0                	test   %eax,%eax
80104962:	78 20                	js     80104984 <sys_exec+0x54>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104964:	83 ec 04             	sub    $0x4,%esp
80104967:	68 80 00 00 00       	push   $0x80
8010496c:	6a 00                	push   $0x0
8010496e:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
80104974:	50                   	push   %eax
80104975:	e8 ed f1 ff ff       	call   80103b67 <memset>
8010497a:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
8010497d:	bb 00 00 00 00       	mov    $0x0,%ebx
80104982:	eb 2a                	jmp    801049ae <sys_exec+0x7e>
    return -1;
80104984:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104989:	eb 76                	jmp    80104a01 <sys_exec+0xd1>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
8010498b:	c7 84 9d 74 ff ff ff 	movl   $0x0,-0x8c(%ebp,%ebx,4)
80104992:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104996:	83 ec 08             	sub    $0x8,%esp
80104999:	8d 85 74 ff ff ff    	lea    -0x8c(%ebp),%eax
8010499f:	50                   	push   %eax
801049a0:	ff 75 f4             	push   -0xc(%ebp)
801049a3:	e8 e8 be ff ff       	call   80100890 <exec>
801049a8:	83 c4 10             	add    $0x10,%esp
801049ab:	eb 54                	jmp    80104a01 <sys_exec+0xd1>
  for(i=0;; i++){
801049ad:	43                   	inc    %ebx
    if(i >= NELEM(argv))
801049ae:	83 fb 1f             	cmp    $0x1f,%ebx
801049b1:	77 49                	ja     801049fc <sys_exec+0xcc>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801049b3:	83 ec 08             	sub    $0x8,%esp
801049b6:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801049bc:	50                   	push   %eax
801049bd:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
801049c3:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801049c6:	50                   	push   %eax
801049c7:	e8 56 f3 ff ff       	call   80103d22 <fetchint>
801049cc:	83 c4 10             	add    $0x10,%esp
801049cf:	85 c0                	test   %eax,%eax
801049d1:	78 33                	js     80104a06 <sys_exec+0xd6>
    if(uarg == 0){
801049d3:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801049d9:	85 c0                	test   %eax,%eax
801049db:	74 ae                	je     8010498b <sys_exec+0x5b>
    if(fetchstr(uarg, &argv[i]) < 0)
801049dd:	83 ec 08             	sub    $0x8,%esp
801049e0:	8d 94 9d 74 ff ff ff 	lea    -0x8c(%ebp,%ebx,4),%edx
801049e7:	52                   	push   %edx
801049e8:	50                   	push   %eax
801049e9:	e8 6f f3 ff ff       	call   80103d5d <fetchstr>
801049ee:	83 c4 10             	add    $0x10,%esp
801049f1:	85 c0                	test   %eax,%eax
801049f3:	79 b8                	jns    801049ad <sys_exec+0x7d>
      return -1;
801049f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049fa:	eb 05                	jmp    80104a01 <sys_exec+0xd1>
      return -1;
801049fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a04:	c9                   	leave  
80104a05:	c3                   	ret    
      return -1;
80104a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a0b:	eb f4                	jmp    80104a01 <sys_exec+0xd1>

80104a0d <sys_pipe>:

int
sys_pipe(void)
{
80104a0d:	55                   	push   %ebp
80104a0e:	89 e5                	mov    %esp,%ebp
80104a10:	53                   	push   %ebx
80104a11:	83 ec 18             	sub    $0x18,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104a14:	6a 08                	push   $0x8
80104a16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a19:	50                   	push   %eax
80104a1a:	6a 00                	push   $0x0
80104a1c:	e8 a1 f3 ff ff       	call   80103dc2 <argptr>
80104a21:	83 c4 10             	add    $0x10,%esp
80104a24:	85 c0                	test   %eax,%eax
80104a26:	78 79                	js     80104aa1 <sys_pipe+0x94>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104a28:	83 ec 08             	sub    $0x8,%esp
80104a2b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104a2e:	50                   	push   %eax
80104a2f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a32:	50                   	push   %eax
80104a33:	e8 1b e2 ff ff       	call   80102c53 <pipealloc>
80104a38:	83 c4 10             	add    $0x10,%esp
80104a3b:	85 c0                	test   %eax,%eax
80104a3d:	78 69                	js     80104aa8 <sys_pipe+0x9b>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a42:	e8 cd f4 ff ff       	call   80103f14 <fdalloc>
80104a47:	89 c3                	mov    %eax,%ebx
80104a49:	85 c0                	test   %eax,%eax
80104a4b:	78 21                	js     80104a6e <sys_pipe+0x61>
80104a4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a50:	e8 bf f4 ff ff       	call   80103f14 <fdalloc>
80104a55:	85 c0                	test   %eax,%eax
80104a57:	78 15                	js     80104a6e <sys_pipe+0x61>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104a59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a5c:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80104a5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a61:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80104a64:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104a69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a6c:	c9                   	leave  
80104a6d:	c3                   	ret    
    if(fd0 >= 0)
80104a6e:	85 db                	test   %ebx,%ebx
80104a70:	79 20                	jns    80104a92 <sys_pipe+0x85>
    fileclose(rf);
80104a72:	83 ec 0c             	sub    $0xc,%esp
80104a75:	ff 75 f0             	push   -0x10(%ebp)
80104a78:	e8 0d c2 ff ff       	call   80100c8a <fileclose>
    fileclose(wf);
80104a7d:	83 c4 04             	add    $0x4,%esp
80104a80:	ff 75 ec             	push   -0x14(%ebp)
80104a83:	e8 02 c2 ff ff       	call   80100c8a <fileclose>
    return -1;
80104a88:	83 c4 10             	add    $0x10,%esp
80104a8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a90:	eb d7                	jmp    80104a69 <sys_pipe+0x5c>
      myproc()->ofile[fd0] = 0;
80104a92:	e8 82 e6 ff ff       	call   80103119 <myproc>
80104a97:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
80104a9e:	00 
80104a9f:	eb d1                	jmp    80104a72 <sys_pipe+0x65>
    return -1;
80104aa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104aa6:	eb c1                	jmp    80104a69 <sys_pipe+0x5c>
    return -1;
80104aa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104aad:	eb ba                	jmp    80104a69 <sys_pipe+0x5c>

80104aaf <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80104aaf:	55                   	push   %ebp
80104ab0:	89 e5                	mov    %esp,%ebp
80104ab2:	83 ec 08             	sub    $0x8,%esp
  return fork();
80104ab5:	e8 d2 e7 ff ff       	call   8010328c <fork>
}
80104aba:	c9                   	leave  
80104abb:	c3                   	ret    

80104abc <sys_exit>:

int
sys_exit(int status)
{
80104abc:	55                   	push   %ebp
80104abd:	89 e5                	mov    %esp,%ebp
80104abf:	83 ec 08             	sub    $0x8,%esp
  exit();
80104ac2:	e8 f7 e9 ff ff       	call   801034be <exit>
  return 0;  // not reached
}
80104ac7:	b8 00 00 00 00       	mov    $0x0,%eax
80104acc:	c9                   	leave  
80104acd:	c3                   	ret    

80104ace <sys_wait>:

int
sys_wait()
{
80104ace:	55                   	push   %ebp
80104acf:	89 e5                	mov    %esp,%ebp
80104ad1:	83 ec 08             	sub    $0x8,%esp
  return wait();
80104ad4:	e8 7d eb ff ff       	call   80103656 <wait>
}
80104ad9:	c9                   	leave  
80104ada:	c3                   	ret    

80104adb <sys_kill>:

int
sys_kill(void)
{
80104adb:	55                   	push   %ebp
80104adc:	89 e5                	mov    %esp,%ebp
80104ade:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104ae1:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ae4:	50                   	push   %eax
80104ae5:	6a 00                	push   $0x0
80104ae7:	e8 ae f2 ff ff       	call   80103d9a <argint>
80104aec:	83 c4 10             	add    $0x10,%esp
80104aef:	85 c0                	test   %eax,%eax
80104af1:	78 10                	js     80104b03 <sys_kill+0x28>
    return -1;
  return kill(pid);
80104af3:	83 ec 0c             	sub    $0xc,%esp
80104af6:	ff 75 f4             	push   -0xc(%ebp)
80104af9:	e8 57 ec ff ff       	call   80103755 <kill>
80104afe:	83 c4 10             	add    $0x10,%esp
}
80104b01:	c9                   	leave  
80104b02:	c3                   	ret    
    return -1;
80104b03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b08:	eb f7                	jmp    80104b01 <sys_kill+0x26>

80104b0a <sys_date>:

int
sys_date(void)
{
80104b0a:	55                   	push   %ebp
80104b0b:	89 e5                	mov    %esp,%ebp
80104b0d:	83 ec 1c             	sub    $0x1c,%esp
 struct rtcdate* d;

 if(argptr(0, (void **) &d, sizeof(struct rtcdate)) < 0 )
80104b10:	6a 18                	push   $0x18
80104b12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b15:	50                   	push   %eax
80104b16:	6a 00                	push   $0x0
80104b18:	e8 a5 f2 ff ff       	call   80103dc2 <argptr>
80104b1d:	83 c4 10             	add    $0x10,%esp
80104b20:	85 c0                	test   %eax,%eax
80104b22:	78 15                	js     80104b39 <sys_date+0x2f>
	 return -1;
 cmostime(d);
80104b24:	83 ec 0c             	sub    $0xc,%esp
80104b27:	ff 75 f4             	push   -0xc(%ebp)
80104b2a:	e8 7f d8 ff ff       	call   801023ae <cmostime>
 return 0;
80104b2f:	83 c4 10             	add    $0x10,%esp
80104b32:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104b37:	c9                   	leave  
80104b38:	c3                   	ret    
	 return -1;
80104b39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b3e:	eb f7                	jmp    80104b37 <sys_date+0x2d>

80104b40 <sys_getpid>:

int
sys_getpid(void)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104b46:	e8 ce e5 ff ff       	call   80103119 <myproc>
80104b4b:	8b 40 10             	mov    0x10(%eax),%eax
}
80104b4e:	c9                   	leave  
80104b4f:	c3                   	ret    

80104b50 <sys_sbrk>:

int
sys_sbrk(void)
{
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	53                   	push   %ebx
80104b54:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104b57:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b5a:	50                   	push   %eax
80104b5b:	6a 00                	push   $0x0
80104b5d:	e8 38 f2 ff ff       	call   80103d9a <argint>
80104b62:	83 c4 10             	add    $0x10,%esp
80104b65:	85 c0                	test   %eax,%eax
80104b67:	78 20                	js     80104b89 <sys_sbrk+0x39>
    return -1;
  addr = myproc()->sz;
80104b69:	e8 ab e5 ff ff       	call   80103119 <myproc>
80104b6e:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104b70:	83 ec 0c             	sub    $0xc,%esp
80104b73:	ff 75 f4             	push   -0xc(%ebp)
80104b76:	e8 a7 e6 ff ff       	call   80103222 <growproc>
80104b7b:	83 c4 10             	add    $0x10,%esp
80104b7e:	85 c0                	test   %eax,%eax
80104b80:	78 0e                	js     80104b90 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80104b82:	89 d8                	mov    %ebx,%eax
80104b84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b87:	c9                   	leave  
80104b88:	c3                   	ret    
    return -1;
80104b89:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104b8e:	eb f2                	jmp    80104b82 <sys_sbrk+0x32>
    return -1;
80104b90:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104b95:	eb eb                	jmp    80104b82 <sys_sbrk+0x32>

80104b97 <sys_sleep>:

int
sys_sleep(void)
{
80104b97:	55                   	push   %ebp
80104b98:	89 e5                	mov    %esp,%ebp
80104b9a:	53                   	push   %ebx
80104b9b:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80104b9e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ba1:	50                   	push   %eax
80104ba2:	6a 00                	push   $0x0
80104ba4:	e8 f1 f1 ff ff       	call   80103d9a <argint>
80104ba9:	83 c4 10             	add    $0x10,%esp
80104bac:	85 c0                	test   %eax,%eax
80104bae:	78 75                	js     80104c25 <sys_sleep+0x8e>
    return -1;
  acquire(&tickslock);
80104bb0:	83 ec 0c             	sub    $0xc,%esp
80104bb3:	68 80 2c 11 80       	push   $0x80112c80
80104bb8:	e8 fe ee ff ff       	call   80103abb <acquire>
  ticks0 = ticks;
80104bbd:	8b 1d 60 2c 11 80    	mov    0x80112c60,%ebx
  while(ticks - ticks0 < n){
80104bc3:	83 c4 10             	add    $0x10,%esp
80104bc6:	a1 60 2c 11 80       	mov    0x80112c60,%eax
80104bcb:	29 d8                	sub    %ebx,%eax
80104bcd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80104bd0:	73 39                	jae    80104c0b <sys_sleep+0x74>
    if(myproc()->killed){
80104bd2:	e8 42 e5 ff ff       	call   80103119 <myproc>
80104bd7:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104bdb:	75 17                	jne    80104bf4 <sys_sleep+0x5d>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80104bdd:	83 ec 08             	sub    $0x8,%esp
80104be0:	68 80 2c 11 80       	push   $0x80112c80
80104be5:	68 60 2c 11 80       	push   $0x80112c60
80104bea:	e8 d6 e9 ff ff       	call   801035c5 <sleep>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	eb d2                	jmp    80104bc6 <sys_sleep+0x2f>
      release(&tickslock);
80104bf4:	83 ec 0c             	sub    $0xc,%esp
80104bf7:	68 80 2c 11 80       	push   $0x80112c80
80104bfc:	e8 1f ef ff ff       	call   80103b20 <release>
      return -1;
80104c01:	83 c4 10             	add    $0x10,%esp
80104c04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c09:	eb 15                	jmp    80104c20 <sys_sleep+0x89>
  }
  release(&tickslock);
80104c0b:	83 ec 0c             	sub    $0xc,%esp
80104c0e:	68 80 2c 11 80       	push   $0x80112c80
80104c13:	e8 08 ef ff ff       	call   80103b20 <release>
  return 0;
80104c18:	83 c4 10             	add    $0x10,%esp
80104c1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104c20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c23:	c9                   	leave  
80104c24:	c3                   	ret    
    return -1;
80104c25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c2a:	eb f4                	jmp    80104c20 <sys_sleep+0x89>

80104c2c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80104c2c:	55                   	push   %ebp
80104c2d:	89 e5                	mov    %esp,%ebp
80104c2f:	53                   	push   %ebx
80104c30:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80104c33:	68 80 2c 11 80       	push   $0x80112c80
80104c38:	e8 7e ee ff ff       	call   80103abb <acquire>
  xticks = ticks;
80104c3d:	8b 1d 60 2c 11 80    	mov    0x80112c60,%ebx
  release(&tickslock);
80104c43:	c7 04 24 80 2c 11 80 	movl   $0x80112c80,(%esp)
80104c4a:	e8 d1 ee ff ff       	call   80103b20 <release>
  return xticks;
}
80104c4f:	89 d8                	mov    %ebx,%eax
80104c51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c54:	c9                   	leave  
80104c55:	c3                   	ret    

80104c56 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80104c56:	1e                   	push   %ds
  pushl %es
80104c57:	06                   	push   %es
  pushl %fs
80104c58:	0f a0                	push   %fs
  pushl %gs
80104c5a:	0f a8                	push   %gs
  pushal
80104c5c:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80104c5d:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80104c61:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80104c63:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80104c65:	54                   	push   %esp
  call trap
80104c66:	e8 2f 01 00 00       	call   80104d9a <trap>
  addl $4, %esp
80104c6b:	83 c4 04             	add    $0x4,%esp

80104c6e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80104c6e:	61                   	popa   
  popl %gs
80104c6f:	0f a9                	pop    %gs
  popl %fs
80104c71:	0f a1                	pop    %fs
  popl %es
80104c73:	07                   	pop    %es
  popl %ds
80104c74:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80104c75:	83 c4 08             	add    $0x8,%esp
  iret
80104c78:	cf                   	iret   

80104c79 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80104c79:	55                   	push   %ebp
80104c7a:	89 e5                	mov    %esp,%ebp
80104c7c:	53                   	push   %ebx
80104c7d:	83 ec 04             	sub    $0x4,%esp
  int i;

  for(i = 0; i < 256; i++)
80104c80:	b8 00 00 00 00       	mov    $0x0,%eax
80104c85:	eb 72                	jmp    80104cf9 <tvinit+0x80>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80104c87:	8b 0c 85 08 90 10 80 	mov    -0x7fef6ff8(,%eax,4),%ecx
80104c8e:	66 89 0c c5 c0 2c 11 	mov    %cx,-0x7feed340(,%eax,8)
80104c95:	80 
80104c96:	66 c7 04 c5 c2 2c 11 	movw   $0x8,-0x7feed33e(,%eax,8)
80104c9d:	80 08 00 
80104ca0:	8a 14 c5 c4 2c 11 80 	mov    -0x7feed33c(,%eax,8),%dl
80104ca7:	83 e2 e0             	and    $0xffffffe0,%edx
80104caa:	88 14 c5 c4 2c 11 80 	mov    %dl,-0x7feed33c(,%eax,8)
80104cb1:	c6 04 c5 c4 2c 11 80 	movb   $0x0,-0x7feed33c(,%eax,8)
80104cb8:	00 
80104cb9:	8a 14 c5 c5 2c 11 80 	mov    -0x7feed33b(,%eax,8),%dl
80104cc0:	83 e2 f0             	and    $0xfffffff0,%edx
80104cc3:	83 ca 0e             	or     $0xe,%edx
80104cc6:	88 14 c5 c5 2c 11 80 	mov    %dl,-0x7feed33b(,%eax,8)
80104ccd:	88 d3                	mov    %dl,%bl
80104ccf:	83 e3 ef             	and    $0xffffffef,%ebx
80104cd2:	88 1c c5 c5 2c 11 80 	mov    %bl,-0x7feed33b(,%eax,8)
80104cd9:	83 e2 8f             	and    $0xffffff8f,%edx
80104cdc:	88 14 c5 c5 2c 11 80 	mov    %dl,-0x7feed33b(,%eax,8)
80104ce3:	83 ca 80             	or     $0xffffff80,%edx
80104ce6:	88 14 c5 c5 2c 11 80 	mov    %dl,-0x7feed33b(,%eax,8)
80104ced:	c1 e9 10             	shr    $0x10,%ecx
80104cf0:	66 89 0c c5 c6 2c 11 	mov    %cx,-0x7feed33a(,%eax,8)
80104cf7:	80 
  for(i = 0; i < 256; i++)
80104cf8:	40                   	inc    %eax
80104cf9:	3d ff 00 00 00       	cmp    $0xff,%eax
80104cfe:	7e 87                	jle    80104c87 <tvinit+0xe>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80104d00:	8b 15 08 91 10 80    	mov    0x80109108,%edx
80104d06:	66 89 15 c0 2e 11 80 	mov    %dx,0x80112ec0
80104d0d:	66 c7 05 c2 2e 11 80 	movw   $0x8,0x80112ec2
80104d14:	08 00 
80104d16:	a0 c4 2e 11 80       	mov    0x80112ec4,%al
80104d1b:	83 e0 e0             	and    $0xffffffe0,%eax
80104d1e:	a2 c4 2e 11 80       	mov    %al,0x80112ec4
80104d23:	c6 05 c4 2e 11 80 00 	movb   $0x0,0x80112ec4
80104d2a:	a0 c5 2e 11 80       	mov    0x80112ec5,%al
80104d2f:	83 c8 0f             	or     $0xf,%eax
80104d32:	a2 c5 2e 11 80       	mov    %al,0x80112ec5
80104d37:	83 e0 ef             	and    $0xffffffef,%eax
80104d3a:	a2 c5 2e 11 80       	mov    %al,0x80112ec5
80104d3f:	88 c1                	mov    %al,%cl
80104d41:	83 c9 60             	or     $0x60,%ecx
80104d44:	88 0d c5 2e 11 80    	mov    %cl,0x80112ec5
80104d4a:	83 c8 e0             	or     $0xffffffe0,%eax
80104d4d:	a2 c5 2e 11 80       	mov    %al,0x80112ec5
80104d52:	c1 ea 10             	shr    $0x10,%edx
80104d55:	66 89 15 c6 2e 11 80 	mov    %dx,0x80112ec6

  initlock(&tickslock, "time");
80104d5c:	83 ec 08             	sub    $0x8,%esp
80104d5f:	68 21 6d 10 80       	push   $0x80106d21
80104d64:	68 80 2c 11 80       	push   $0x80112c80
80104d69:	e8 16 ec ff ff       	call   80103984 <initlock>
}
80104d6e:	83 c4 10             	add    $0x10,%esp
80104d71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d74:	c9                   	leave  
80104d75:	c3                   	ret    

80104d76 <idtinit>:

void
idtinit(void)
{
80104d76:	55                   	push   %ebp
80104d77:	89 e5                	mov    %esp,%ebp
80104d79:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80104d7c:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80104d82:	b8 c0 2c 11 80       	mov    $0x80112cc0,%eax
80104d87:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80104d8b:	c1 e8 10             	shr    $0x10,%eax
80104d8e:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80104d92:	8d 45 fa             	lea    -0x6(%ebp),%eax
80104d95:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80104d98:	c9                   	leave  
80104d99:	c3                   	ret    

80104d9a <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80104d9a:	55                   	push   %ebp
80104d9b:	89 e5                	mov    %esp,%ebp
80104d9d:	57                   	push   %edi
80104d9e:	56                   	push   %esi
80104d9f:	53                   	push   %ebx
80104da0:	83 ec 1c             	sub    $0x1c,%esp
80104da3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80104da6:	8b 43 30             	mov    0x30(%ebx),%eax
80104da9:	83 f8 40             	cmp    $0x40,%eax
80104dac:	74 13                	je     80104dc1 <trap+0x27>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80104dae:	83 e8 20             	sub    $0x20,%eax
80104db1:	83 f8 1f             	cmp    $0x1f,%eax
80104db4:	0f 87 36 01 00 00    	ja     80104ef0 <trap+0x156>
80104dba:	ff 24 85 c8 6d 10 80 	jmp    *-0x7fef9238(,%eax,4)
    if(myproc()->killed)
80104dc1:	e8 53 e3 ff ff       	call   80103119 <myproc>
80104dc6:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104dca:	75 1f                	jne    80104deb <trap+0x51>
    myproc()->tf = tf;
80104dcc:	e8 48 e3 ff ff       	call   80103119 <myproc>
80104dd1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80104dd4:	e8 84 f0 ff ff       	call   80103e5d <syscall>
    if(myproc()->killed)
80104dd9:	e8 3b e3 ff ff       	call   80103119 <myproc>
80104dde:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104de2:	74 7c                	je     80104e60 <trap+0xc6>
      exit();
80104de4:	e8 d5 e6 ff ff       	call   801034be <exit>
    return;
80104de9:	eb 75                	jmp    80104e60 <trap+0xc6>
      exit();
80104deb:	e8 ce e6 ff ff       	call   801034be <exit>
80104df0:	eb da                	jmp    80104dcc <trap+0x32>
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80104df2:	e8 f1 e2 ff ff       	call   801030e8 <cpuid>
80104df7:	85 c0                	test   %eax,%eax
80104df9:	74 6d                	je     80104e68 <trap+0xce>
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
80104dfb:	e8 f9 d4 ff ff       	call   801022f9 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104e00:	e8 14 e3 ff ff       	call   80103119 <myproc>
80104e05:	85 c0                	test   %eax,%eax
80104e07:	74 1b                	je     80104e24 <trap+0x8a>
80104e09:	e8 0b e3 ff ff       	call   80103119 <myproc>
80104e0e:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104e12:	74 10                	je     80104e24 <trap+0x8a>
80104e14:	8b 43 3c             	mov    0x3c(%ebx),%eax
80104e17:	83 e0 03             	and    $0x3,%eax
80104e1a:	66 83 f8 03          	cmp    $0x3,%ax
80104e1e:	0f 84 5f 01 00 00    	je     80104f83 <trap+0x1e9>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80104e24:	e8 f0 e2 ff ff       	call   80103119 <myproc>
80104e29:	85 c0                	test   %eax,%eax
80104e2b:	74 0f                	je     80104e3c <trap+0xa2>
80104e2d:	e8 e7 e2 ff ff       	call   80103119 <myproc>
80104e32:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80104e36:	0f 84 51 01 00 00    	je     80104f8d <trap+0x1f3>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104e3c:	e8 d8 e2 ff ff       	call   80103119 <myproc>
80104e41:	85 c0                	test   %eax,%eax
80104e43:	74 1b                	je     80104e60 <trap+0xc6>
80104e45:	e8 cf e2 ff ff       	call   80103119 <myproc>
80104e4a:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80104e4e:	74 10                	je     80104e60 <trap+0xc6>
80104e50:	8b 43 3c             	mov    0x3c(%ebx),%eax
80104e53:	83 e0 03             	and    $0x3,%eax
80104e56:	66 83 f8 03          	cmp    $0x3,%ax
80104e5a:	0f 84 41 01 00 00    	je     80104fa1 <trap+0x207>
    exit();
}
80104e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e63:	5b                   	pop    %ebx
80104e64:	5e                   	pop    %esi
80104e65:	5f                   	pop    %edi
80104e66:	5d                   	pop    %ebp
80104e67:	c3                   	ret    
      acquire(&tickslock);
80104e68:	83 ec 0c             	sub    $0xc,%esp
80104e6b:	68 80 2c 11 80       	push   $0x80112c80
80104e70:	e8 46 ec ff ff       	call   80103abb <acquire>
      ticks++;
80104e75:	ff 05 60 2c 11 80    	incl   0x80112c60
      wakeup(&ticks);
80104e7b:	c7 04 24 60 2c 11 80 	movl   $0x80112c60,(%esp)
80104e82:	e8 a5 e8 ff ff       	call   8010372c <wakeup>
      release(&tickslock);
80104e87:	c7 04 24 80 2c 11 80 	movl   $0x80112c80,(%esp)
80104e8e:	e8 8d ec ff ff       	call   80103b20 <release>
80104e93:	83 c4 10             	add    $0x10,%esp
80104e96:	e9 60 ff ff ff       	jmp    80104dfb <trap+0x61>
    ideintr();
80104e9b:	e8 42 ce ff ff       	call   80101ce2 <ideintr>
    lapiceoi();
80104ea0:	e8 54 d4 ff ff       	call   801022f9 <lapiceoi>
    break;
80104ea5:	e9 56 ff ff ff       	jmp    80104e00 <trap+0x66>
    kbdintr();
80104eaa:	e8 94 d2 ff ff       	call   80102143 <kbdintr>
    lapiceoi();
80104eaf:	e8 45 d4 ff ff       	call   801022f9 <lapiceoi>
    break;
80104eb4:	e9 47 ff ff ff       	jmp    80104e00 <trap+0x66>
    uartintr();
80104eb9:	e8 e9 01 00 00       	call   801050a7 <uartintr>
    lapiceoi();
80104ebe:	e8 36 d4 ff ff       	call   801022f9 <lapiceoi>
    break;
80104ec3:	e9 38 ff ff ff       	jmp    80104e00 <trap+0x66>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80104ec8:	8b 7b 38             	mov    0x38(%ebx),%edi
            cpuid(), tf->cs, tf->eip);
80104ecb:	8b 73 3c             	mov    0x3c(%ebx),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80104ece:	e8 15 e2 ff ff       	call   801030e8 <cpuid>
80104ed3:	57                   	push   %edi
80104ed4:	0f b7 f6             	movzwl %si,%esi
80104ed7:	56                   	push   %esi
80104ed8:	50                   	push   %eax
80104ed9:	68 2c 6d 10 80       	push   $0x80106d2c
80104ede:	e8 f7 b6 ff ff       	call   801005da <cprintf>
    lapiceoi();
80104ee3:	e8 11 d4 ff ff       	call   801022f9 <lapiceoi>
    break;
80104ee8:	83 c4 10             	add    $0x10,%esp
80104eeb:	e9 10 ff ff ff       	jmp    80104e00 <trap+0x66>
    if(myproc() == 0 || (tf->cs&3) == 0){
80104ef0:	e8 24 e2 ff ff       	call   80103119 <myproc>
80104ef5:	85 c0                	test   %eax,%eax
80104ef7:	74 5f                	je     80104f58 <trap+0x1be>
80104ef9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80104efd:	74 59                	je     80104f58 <trap+0x1be>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80104eff:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104f02:	8b 43 38             	mov    0x38(%ebx),%eax
80104f05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104f08:	e8 db e1 ff ff       	call   801030e8 <cpuid>
80104f0d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104f10:	8b 53 34             	mov    0x34(%ebx),%edx
80104f13:	89 55 dc             	mov    %edx,-0x24(%ebp)
80104f16:	8b 73 30             	mov    0x30(%ebx),%esi
            myproc()->pid, myproc()->name, tf->trapno,
80104f19:	e8 fb e1 ff ff       	call   80103119 <myproc>
80104f1e:	8d 48 6c             	lea    0x6c(%eax),%ecx
80104f21:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80104f24:	e8 f0 e1 ff ff       	call   80103119 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104f29:	57                   	push   %edi
80104f2a:	ff 75 e4             	push   -0x1c(%ebp)
80104f2d:	ff 75 e0             	push   -0x20(%ebp)
80104f30:	ff 75 dc             	push   -0x24(%ebp)
80104f33:	56                   	push   %esi
80104f34:	ff 75 d8             	push   -0x28(%ebp)
80104f37:	ff 70 10             	push   0x10(%eax)
80104f3a:	68 84 6d 10 80       	push   $0x80106d84
80104f3f:	e8 96 b6 ff ff       	call   801005da <cprintf>
    myproc()->killed = 1;
80104f44:	83 c4 20             	add    $0x20,%esp
80104f47:	e8 cd e1 ff ff       	call   80103119 <myproc>
80104f4c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104f53:	e9 a8 fe ff ff       	jmp    80104e00 <trap+0x66>
80104f58:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80104f5b:	8b 73 38             	mov    0x38(%ebx),%esi
80104f5e:	e8 85 e1 ff ff       	call   801030e8 <cpuid>
80104f63:	83 ec 0c             	sub    $0xc,%esp
80104f66:	57                   	push   %edi
80104f67:	56                   	push   %esi
80104f68:	50                   	push   %eax
80104f69:	ff 73 30             	push   0x30(%ebx)
80104f6c:	68 50 6d 10 80       	push   $0x80106d50
80104f71:	e8 64 b6 ff ff       	call   801005da <cprintf>
      panic("trap");
80104f76:	83 c4 14             	add    $0x14,%esp
80104f79:	68 26 6d 10 80       	push   $0x80106d26
80104f7e:	e8 be b3 ff ff       	call   80100341 <panic>
    exit();
80104f83:	e8 36 e5 ff ff       	call   801034be <exit>
80104f88:	e9 97 fe ff ff       	jmp    80104e24 <trap+0x8a>
  if(myproc() && myproc()->state == RUNNING &&
80104f8d:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80104f91:	0f 85 a5 fe ff ff    	jne    80104e3c <trap+0xa2>
    yield();
80104f97:	e8 f7 e5 ff ff       	call   80103593 <yield>
80104f9c:	e9 9b fe ff ff       	jmp    80104e3c <trap+0xa2>
    exit();
80104fa1:	e8 18 e5 ff ff       	call   801034be <exit>
80104fa6:	e9 b5 fe ff ff       	jmp    80104e60 <trap+0xc6>

80104fab <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80104fab:	83 3d c0 34 11 80 00 	cmpl   $0x0,0x801134c0
80104fb2:	74 14                	je     80104fc8 <uartgetc+0x1d>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80104fb4:	ba fd 03 00 00       	mov    $0x3fd,%edx
80104fb9:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80104fba:	a8 01                	test   $0x1,%al
80104fbc:	74 10                	je     80104fce <uartgetc+0x23>
80104fbe:	ba f8 03 00 00       	mov    $0x3f8,%edx
80104fc3:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80104fc4:	0f b6 c0             	movzbl %al,%eax
80104fc7:	c3                   	ret    
    return -1;
80104fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fcd:	c3                   	ret    
    return -1;
80104fce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd3:	c3                   	ret    

80104fd4 <uartputc>:
  if(!uart)
80104fd4:	83 3d c0 34 11 80 00 	cmpl   $0x0,0x801134c0
80104fdb:	74 39                	je     80105016 <uartputc+0x42>
{
80104fdd:	55                   	push   %ebp
80104fde:	89 e5                	mov    %esp,%ebp
80104fe0:	53                   	push   %ebx
80104fe1:	83 ec 04             	sub    $0x4,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80104fe4:	bb 00 00 00 00       	mov    $0x0,%ebx
80104fe9:	eb 0e                	jmp    80104ff9 <uartputc+0x25>
    microdelay(10);
80104feb:	83 ec 0c             	sub    $0xc,%esp
80104fee:	6a 0a                	push   $0xa
80104ff0:	e8 25 d3 ff ff       	call   8010231a <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80104ff5:	43                   	inc    %ebx
80104ff6:	83 c4 10             	add    $0x10,%esp
80104ff9:	83 fb 7f             	cmp    $0x7f,%ebx
80104ffc:	7f 0a                	jg     80105008 <uartputc+0x34>
80104ffe:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105003:	ec                   	in     (%dx),%al
80105004:	a8 20                	test   $0x20,%al
80105006:	74 e3                	je     80104feb <uartputc+0x17>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105008:	8b 45 08             	mov    0x8(%ebp),%eax
8010500b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105010:	ee                   	out    %al,(%dx)
}
80105011:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105014:	c9                   	leave  
80105015:	c3                   	ret    
80105016:	c3                   	ret    

80105017 <uartinit>:
{
80105017:	55                   	push   %ebp
80105018:	89 e5                	mov    %esp,%ebp
8010501a:	56                   	push   %esi
8010501b:	53                   	push   %ebx
8010501c:	b1 00                	mov    $0x0,%cl
8010501e:	ba fa 03 00 00       	mov    $0x3fa,%edx
80105023:	88 c8                	mov    %cl,%al
80105025:	ee                   	out    %al,(%dx)
80105026:	be fb 03 00 00       	mov    $0x3fb,%esi
8010502b:	b0 80                	mov    $0x80,%al
8010502d:	89 f2                	mov    %esi,%edx
8010502f:	ee                   	out    %al,(%dx)
80105030:	b0 0c                	mov    $0xc,%al
80105032:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105037:	ee                   	out    %al,(%dx)
80105038:	bb f9 03 00 00       	mov    $0x3f9,%ebx
8010503d:	88 c8                	mov    %cl,%al
8010503f:	89 da                	mov    %ebx,%edx
80105041:	ee                   	out    %al,(%dx)
80105042:	b0 03                	mov    $0x3,%al
80105044:	89 f2                	mov    %esi,%edx
80105046:	ee                   	out    %al,(%dx)
80105047:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010504c:	88 c8                	mov    %cl,%al
8010504e:	ee                   	out    %al,(%dx)
8010504f:	b0 01                	mov    $0x1,%al
80105051:	89 da                	mov    %ebx,%edx
80105053:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105054:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105059:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
8010505a:	3c ff                	cmp    $0xff,%al
8010505c:	74 42                	je     801050a0 <uartinit+0x89>
  uart = 1;
8010505e:	c7 05 c0 34 11 80 01 	movl   $0x1,0x801134c0
80105065:	00 00 00 
80105068:	ba fa 03 00 00       	mov    $0x3fa,%edx
8010506d:	ec                   	in     (%dx),%al
8010506e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105073:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105074:	83 ec 08             	sub    $0x8,%esp
80105077:	6a 00                	push   $0x0
80105079:	6a 04                	push   $0x4
8010507b:	e8 65 ce ff ff       	call   80101ee5 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105080:	83 c4 10             	add    $0x10,%esp
80105083:	bb 48 6e 10 80       	mov    $0x80106e48,%ebx
80105088:	eb 10                	jmp    8010509a <uartinit+0x83>
    uartputc(*p);
8010508a:	83 ec 0c             	sub    $0xc,%esp
8010508d:	0f be c0             	movsbl %al,%eax
80105090:	50                   	push   %eax
80105091:	e8 3e ff ff ff       	call   80104fd4 <uartputc>
  for(p="xv6...\n"; *p; p++)
80105096:	43                   	inc    %ebx
80105097:	83 c4 10             	add    $0x10,%esp
8010509a:	8a 03                	mov    (%ebx),%al
8010509c:	84 c0                	test   %al,%al
8010509e:	75 ea                	jne    8010508a <uartinit+0x73>
}
801050a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050a3:	5b                   	pop    %ebx
801050a4:	5e                   	pop    %esi
801050a5:	5d                   	pop    %ebp
801050a6:	c3                   	ret    

801050a7 <uartintr>:

void
uartintr(void)
{
801050a7:	55                   	push   %ebp
801050a8:	89 e5                	mov    %esp,%ebp
801050aa:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801050ad:	68 ab 4f 10 80       	push   $0x80104fab
801050b2:	e8 48 b6 ff ff       	call   801006ff <consoleintr>
}
801050b7:	83 c4 10             	add    $0x10,%esp
801050ba:	c9                   	leave  
801050bb:	c3                   	ret    

801050bc <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801050bc:	6a 00                	push   $0x0
  pushl $0
801050be:	6a 00                	push   $0x0
  jmp alltraps
801050c0:	e9 91 fb ff ff       	jmp    80104c56 <alltraps>

801050c5 <vector1>:
.globl vector1
vector1:
  pushl $0
801050c5:	6a 00                	push   $0x0
  pushl $1
801050c7:	6a 01                	push   $0x1
  jmp alltraps
801050c9:	e9 88 fb ff ff       	jmp    80104c56 <alltraps>

801050ce <vector2>:
.globl vector2
vector2:
  pushl $0
801050ce:	6a 00                	push   $0x0
  pushl $2
801050d0:	6a 02                	push   $0x2
  jmp alltraps
801050d2:	e9 7f fb ff ff       	jmp    80104c56 <alltraps>

801050d7 <vector3>:
.globl vector3
vector3:
  pushl $0
801050d7:	6a 00                	push   $0x0
  pushl $3
801050d9:	6a 03                	push   $0x3
  jmp alltraps
801050db:	e9 76 fb ff ff       	jmp    80104c56 <alltraps>

801050e0 <vector4>:
.globl vector4
vector4:
  pushl $0
801050e0:	6a 00                	push   $0x0
  pushl $4
801050e2:	6a 04                	push   $0x4
  jmp alltraps
801050e4:	e9 6d fb ff ff       	jmp    80104c56 <alltraps>

801050e9 <vector5>:
.globl vector5
vector5:
  pushl $0
801050e9:	6a 00                	push   $0x0
  pushl $5
801050eb:	6a 05                	push   $0x5
  jmp alltraps
801050ed:	e9 64 fb ff ff       	jmp    80104c56 <alltraps>

801050f2 <vector6>:
.globl vector6
vector6:
  pushl $0
801050f2:	6a 00                	push   $0x0
  pushl $6
801050f4:	6a 06                	push   $0x6
  jmp alltraps
801050f6:	e9 5b fb ff ff       	jmp    80104c56 <alltraps>

801050fb <vector7>:
.globl vector7
vector7:
  pushl $0
801050fb:	6a 00                	push   $0x0
  pushl $7
801050fd:	6a 07                	push   $0x7
  jmp alltraps
801050ff:	e9 52 fb ff ff       	jmp    80104c56 <alltraps>

80105104 <vector8>:
.globl vector8
vector8:
  pushl $8
80105104:	6a 08                	push   $0x8
  jmp alltraps
80105106:	e9 4b fb ff ff       	jmp    80104c56 <alltraps>

8010510b <vector9>:
.globl vector9
vector9:
  pushl $0
8010510b:	6a 00                	push   $0x0
  pushl $9
8010510d:	6a 09                	push   $0x9
  jmp alltraps
8010510f:	e9 42 fb ff ff       	jmp    80104c56 <alltraps>

80105114 <vector10>:
.globl vector10
vector10:
  pushl $10
80105114:	6a 0a                	push   $0xa
  jmp alltraps
80105116:	e9 3b fb ff ff       	jmp    80104c56 <alltraps>

8010511b <vector11>:
.globl vector11
vector11:
  pushl $11
8010511b:	6a 0b                	push   $0xb
  jmp alltraps
8010511d:	e9 34 fb ff ff       	jmp    80104c56 <alltraps>

80105122 <vector12>:
.globl vector12
vector12:
  pushl $12
80105122:	6a 0c                	push   $0xc
  jmp alltraps
80105124:	e9 2d fb ff ff       	jmp    80104c56 <alltraps>

80105129 <vector13>:
.globl vector13
vector13:
  pushl $13
80105129:	6a 0d                	push   $0xd
  jmp alltraps
8010512b:	e9 26 fb ff ff       	jmp    80104c56 <alltraps>

80105130 <vector14>:
.globl vector14
vector14:
  pushl $14
80105130:	6a 0e                	push   $0xe
  jmp alltraps
80105132:	e9 1f fb ff ff       	jmp    80104c56 <alltraps>

80105137 <vector15>:
.globl vector15
vector15:
  pushl $0
80105137:	6a 00                	push   $0x0
  pushl $15
80105139:	6a 0f                	push   $0xf
  jmp alltraps
8010513b:	e9 16 fb ff ff       	jmp    80104c56 <alltraps>

80105140 <vector16>:
.globl vector16
vector16:
  pushl $0
80105140:	6a 00                	push   $0x0
  pushl $16
80105142:	6a 10                	push   $0x10
  jmp alltraps
80105144:	e9 0d fb ff ff       	jmp    80104c56 <alltraps>

80105149 <vector17>:
.globl vector17
vector17:
  pushl $17
80105149:	6a 11                	push   $0x11
  jmp alltraps
8010514b:	e9 06 fb ff ff       	jmp    80104c56 <alltraps>

80105150 <vector18>:
.globl vector18
vector18:
  pushl $0
80105150:	6a 00                	push   $0x0
  pushl $18
80105152:	6a 12                	push   $0x12
  jmp alltraps
80105154:	e9 fd fa ff ff       	jmp    80104c56 <alltraps>

80105159 <vector19>:
.globl vector19
vector19:
  pushl $0
80105159:	6a 00                	push   $0x0
  pushl $19
8010515b:	6a 13                	push   $0x13
  jmp alltraps
8010515d:	e9 f4 fa ff ff       	jmp    80104c56 <alltraps>

80105162 <vector20>:
.globl vector20
vector20:
  pushl $0
80105162:	6a 00                	push   $0x0
  pushl $20
80105164:	6a 14                	push   $0x14
  jmp alltraps
80105166:	e9 eb fa ff ff       	jmp    80104c56 <alltraps>

8010516b <vector21>:
.globl vector21
vector21:
  pushl $0
8010516b:	6a 00                	push   $0x0
  pushl $21
8010516d:	6a 15                	push   $0x15
  jmp alltraps
8010516f:	e9 e2 fa ff ff       	jmp    80104c56 <alltraps>

80105174 <vector22>:
.globl vector22
vector22:
  pushl $0
80105174:	6a 00                	push   $0x0
  pushl $22
80105176:	6a 16                	push   $0x16
  jmp alltraps
80105178:	e9 d9 fa ff ff       	jmp    80104c56 <alltraps>

8010517d <vector23>:
.globl vector23
vector23:
  pushl $0
8010517d:	6a 00                	push   $0x0
  pushl $23
8010517f:	6a 17                	push   $0x17
  jmp alltraps
80105181:	e9 d0 fa ff ff       	jmp    80104c56 <alltraps>

80105186 <vector24>:
.globl vector24
vector24:
  pushl $0
80105186:	6a 00                	push   $0x0
  pushl $24
80105188:	6a 18                	push   $0x18
  jmp alltraps
8010518a:	e9 c7 fa ff ff       	jmp    80104c56 <alltraps>

8010518f <vector25>:
.globl vector25
vector25:
  pushl $0
8010518f:	6a 00                	push   $0x0
  pushl $25
80105191:	6a 19                	push   $0x19
  jmp alltraps
80105193:	e9 be fa ff ff       	jmp    80104c56 <alltraps>

80105198 <vector26>:
.globl vector26
vector26:
  pushl $0
80105198:	6a 00                	push   $0x0
  pushl $26
8010519a:	6a 1a                	push   $0x1a
  jmp alltraps
8010519c:	e9 b5 fa ff ff       	jmp    80104c56 <alltraps>

801051a1 <vector27>:
.globl vector27
vector27:
  pushl $0
801051a1:	6a 00                	push   $0x0
  pushl $27
801051a3:	6a 1b                	push   $0x1b
  jmp alltraps
801051a5:	e9 ac fa ff ff       	jmp    80104c56 <alltraps>

801051aa <vector28>:
.globl vector28
vector28:
  pushl $0
801051aa:	6a 00                	push   $0x0
  pushl $28
801051ac:	6a 1c                	push   $0x1c
  jmp alltraps
801051ae:	e9 a3 fa ff ff       	jmp    80104c56 <alltraps>

801051b3 <vector29>:
.globl vector29
vector29:
  pushl $0
801051b3:	6a 00                	push   $0x0
  pushl $29
801051b5:	6a 1d                	push   $0x1d
  jmp alltraps
801051b7:	e9 9a fa ff ff       	jmp    80104c56 <alltraps>

801051bc <vector30>:
.globl vector30
vector30:
  pushl $0
801051bc:	6a 00                	push   $0x0
  pushl $30
801051be:	6a 1e                	push   $0x1e
  jmp alltraps
801051c0:	e9 91 fa ff ff       	jmp    80104c56 <alltraps>

801051c5 <vector31>:
.globl vector31
vector31:
  pushl $0
801051c5:	6a 00                	push   $0x0
  pushl $31
801051c7:	6a 1f                	push   $0x1f
  jmp alltraps
801051c9:	e9 88 fa ff ff       	jmp    80104c56 <alltraps>

801051ce <vector32>:
.globl vector32
vector32:
  pushl $0
801051ce:	6a 00                	push   $0x0
  pushl $32
801051d0:	6a 20                	push   $0x20
  jmp alltraps
801051d2:	e9 7f fa ff ff       	jmp    80104c56 <alltraps>

801051d7 <vector33>:
.globl vector33
vector33:
  pushl $0
801051d7:	6a 00                	push   $0x0
  pushl $33
801051d9:	6a 21                	push   $0x21
  jmp alltraps
801051db:	e9 76 fa ff ff       	jmp    80104c56 <alltraps>

801051e0 <vector34>:
.globl vector34
vector34:
  pushl $0
801051e0:	6a 00                	push   $0x0
  pushl $34
801051e2:	6a 22                	push   $0x22
  jmp alltraps
801051e4:	e9 6d fa ff ff       	jmp    80104c56 <alltraps>

801051e9 <vector35>:
.globl vector35
vector35:
  pushl $0
801051e9:	6a 00                	push   $0x0
  pushl $35
801051eb:	6a 23                	push   $0x23
  jmp alltraps
801051ed:	e9 64 fa ff ff       	jmp    80104c56 <alltraps>

801051f2 <vector36>:
.globl vector36
vector36:
  pushl $0
801051f2:	6a 00                	push   $0x0
  pushl $36
801051f4:	6a 24                	push   $0x24
  jmp alltraps
801051f6:	e9 5b fa ff ff       	jmp    80104c56 <alltraps>

801051fb <vector37>:
.globl vector37
vector37:
  pushl $0
801051fb:	6a 00                	push   $0x0
  pushl $37
801051fd:	6a 25                	push   $0x25
  jmp alltraps
801051ff:	e9 52 fa ff ff       	jmp    80104c56 <alltraps>

80105204 <vector38>:
.globl vector38
vector38:
  pushl $0
80105204:	6a 00                	push   $0x0
  pushl $38
80105206:	6a 26                	push   $0x26
  jmp alltraps
80105208:	e9 49 fa ff ff       	jmp    80104c56 <alltraps>

8010520d <vector39>:
.globl vector39
vector39:
  pushl $0
8010520d:	6a 00                	push   $0x0
  pushl $39
8010520f:	6a 27                	push   $0x27
  jmp alltraps
80105211:	e9 40 fa ff ff       	jmp    80104c56 <alltraps>

80105216 <vector40>:
.globl vector40
vector40:
  pushl $0
80105216:	6a 00                	push   $0x0
  pushl $40
80105218:	6a 28                	push   $0x28
  jmp alltraps
8010521a:	e9 37 fa ff ff       	jmp    80104c56 <alltraps>

8010521f <vector41>:
.globl vector41
vector41:
  pushl $0
8010521f:	6a 00                	push   $0x0
  pushl $41
80105221:	6a 29                	push   $0x29
  jmp alltraps
80105223:	e9 2e fa ff ff       	jmp    80104c56 <alltraps>

80105228 <vector42>:
.globl vector42
vector42:
  pushl $0
80105228:	6a 00                	push   $0x0
  pushl $42
8010522a:	6a 2a                	push   $0x2a
  jmp alltraps
8010522c:	e9 25 fa ff ff       	jmp    80104c56 <alltraps>

80105231 <vector43>:
.globl vector43
vector43:
  pushl $0
80105231:	6a 00                	push   $0x0
  pushl $43
80105233:	6a 2b                	push   $0x2b
  jmp alltraps
80105235:	e9 1c fa ff ff       	jmp    80104c56 <alltraps>

8010523a <vector44>:
.globl vector44
vector44:
  pushl $0
8010523a:	6a 00                	push   $0x0
  pushl $44
8010523c:	6a 2c                	push   $0x2c
  jmp alltraps
8010523e:	e9 13 fa ff ff       	jmp    80104c56 <alltraps>

80105243 <vector45>:
.globl vector45
vector45:
  pushl $0
80105243:	6a 00                	push   $0x0
  pushl $45
80105245:	6a 2d                	push   $0x2d
  jmp alltraps
80105247:	e9 0a fa ff ff       	jmp    80104c56 <alltraps>

8010524c <vector46>:
.globl vector46
vector46:
  pushl $0
8010524c:	6a 00                	push   $0x0
  pushl $46
8010524e:	6a 2e                	push   $0x2e
  jmp alltraps
80105250:	e9 01 fa ff ff       	jmp    80104c56 <alltraps>

80105255 <vector47>:
.globl vector47
vector47:
  pushl $0
80105255:	6a 00                	push   $0x0
  pushl $47
80105257:	6a 2f                	push   $0x2f
  jmp alltraps
80105259:	e9 f8 f9 ff ff       	jmp    80104c56 <alltraps>

8010525e <vector48>:
.globl vector48
vector48:
  pushl $0
8010525e:	6a 00                	push   $0x0
  pushl $48
80105260:	6a 30                	push   $0x30
  jmp alltraps
80105262:	e9 ef f9 ff ff       	jmp    80104c56 <alltraps>

80105267 <vector49>:
.globl vector49
vector49:
  pushl $0
80105267:	6a 00                	push   $0x0
  pushl $49
80105269:	6a 31                	push   $0x31
  jmp alltraps
8010526b:	e9 e6 f9 ff ff       	jmp    80104c56 <alltraps>

80105270 <vector50>:
.globl vector50
vector50:
  pushl $0
80105270:	6a 00                	push   $0x0
  pushl $50
80105272:	6a 32                	push   $0x32
  jmp alltraps
80105274:	e9 dd f9 ff ff       	jmp    80104c56 <alltraps>

80105279 <vector51>:
.globl vector51
vector51:
  pushl $0
80105279:	6a 00                	push   $0x0
  pushl $51
8010527b:	6a 33                	push   $0x33
  jmp alltraps
8010527d:	e9 d4 f9 ff ff       	jmp    80104c56 <alltraps>

80105282 <vector52>:
.globl vector52
vector52:
  pushl $0
80105282:	6a 00                	push   $0x0
  pushl $52
80105284:	6a 34                	push   $0x34
  jmp alltraps
80105286:	e9 cb f9 ff ff       	jmp    80104c56 <alltraps>

8010528b <vector53>:
.globl vector53
vector53:
  pushl $0
8010528b:	6a 00                	push   $0x0
  pushl $53
8010528d:	6a 35                	push   $0x35
  jmp alltraps
8010528f:	e9 c2 f9 ff ff       	jmp    80104c56 <alltraps>

80105294 <vector54>:
.globl vector54
vector54:
  pushl $0
80105294:	6a 00                	push   $0x0
  pushl $54
80105296:	6a 36                	push   $0x36
  jmp alltraps
80105298:	e9 b9 f9 ff ff       	jmp    80104c56 <alltraps>

8010529d <vector55>:
.globl vector55
vector55:
  pushl $0
8010529d:	6a 00                	push   $0x0
  pushl $55
8010529f:	6a 37                	push   $0x37
  jmp alltraps
801052a1:	e9 b0 f9 ff ff       	jmp    80104c56 <alltraps>

801052a6 <vector56>:
.globl vector56
vector56:
  pushl $0
801052a6:	6a 00                	push   $0x0
  pushl $56
801052a8:	6a 38                	push   $0x38
  jmp alltraps
801052aa:	e9 a7 f9 ff ff       	jmp    80104c56 <alltraps>

801052af <vector57>:
.globl vector57
vector57:
  pushl $0
801052af:	6a 00                	push   $0x0
  pushl $57
801052b1:	6a 39                	push   $0x39
  jmp alltraps
801052b3:	e9 9e f9 ff ff       	jmp    80104c56 <alltraps>

801052b8 <vector58>:
.globl vector58
vector58:
  pushl $0
801052b8:	6a 00                	push   $0x0
  pushl $58
801052ba:	6a 3a                	push   $0x3a
  jmp alltraps
801052bc:	e9 95 f9 ff ff       	jmp    80104c56 <alltraps>

801052c1 <vector59>:
.globl vector59
vector59:
  pushl $0
801052c1:	6a 00                	push   $0x0
  pushl $59
801052c3:	6a 3b                	push   $0x3b
  jmp alltraps
801052c5:	e9 8c f9 ff ff       	jmp    80104c56 <alltraps>

801052ca <vector60>:
.globl vector60
vector60:
  pushl $0
801052ca:	6a 00                	push   $0x0
  pushl $60
801052cc:	6a 3c                	push   $0x3c
  jmp alltraps
801052ce:	e9 83 f9 ff ff       	jmp    80104c56 <alltraps>

801052d3 <vector61>:
.globl vector61
vector61:
  pushl $0
801052d3:	6a 00                	push   $0x0
  pushl $61
801052d5:	6a 3d                	push   $0x3d
  jmp alltraps
801052d7:	e9 7a f9 ff ff       	jmp    80104c56 <alltraps>

801052dc <vector62>:
.globl vector62
vector62:
  pushl $0
801052dc:	6a 00                	push   $0x0
  pushl $62
801052de:	6a 3e                	push   $0x3e
  jmp alltraps
801052e0:	e9 71 f9 ff ff       	jmp    80104c56 <alltraps>

801052e5 <vector63>:
.globl vector63
vector63:
  pushl $0
801052e5:	6a 00                	push   $0x0
  pushl $63
801052e7:	6a 3f                	push   $0x3f
  jmp alltraps
801052e9:	e9 68 f9 ff ff       	jmp    80104c56 <alltraps>

801052ee <vector64>:
.globl vector64
vector64:
  pushl $0
801052ee:	6a 00                	push   $0x0
  pushl $64
801052f0:	6a 40                	push   $0x40
  jmp alltraps
801052f2:	e9 5f f9 ff ff       	jmp    80104c56 <alltraps>

801052f7 <vector65>:
.globl vector65
vector65:
  pushl $0
801052f7:	6a 00                	push   $0x0
  pushl $65
801052f9:	6a 41                	push   $0x41
  jmp alltraps
801052fb:	e9 56 f9 ff ff       	jmp    80104c56 <alltraps>

80105300 <vector66>:
.globl vector66
vector66:
  pushl $0
80105300:	6a 00                	push   $0x0
  pushl $66
80105302:	6a 42                	push   $0x42
  jmp alltraps
80105304:	e9 4d f9 ff ff       	jmp    80104c56 <alltraps>

80105309 <vector67>:
.globl vector67
vector67:
  pushl $0
80105309:	6a 00                	push   $0x0
  pushl $67
8010530b:	6a 43                	push   $0x43
  jmp alltraps
8010530d:	e9 44 f9 ff ff       	jmp    80104c56 <alltraps>

80105312 <vector68>:
.globl vector68
vector68:
  pushl $0
80105312:	6a 00                	push   $0x0
  pushl $68
80105314:	6a 44                	push   $0x44
  jmp alltraps
80105316:	e9 3b f9 ff ff       	jmp    80104c56 <alltraps>

8010531b <vector69>:
.globl vector69
vector69:
  pushl $0
8010531b:	6a 00                	push   $0x0
  pushl $69
8010531d:	6a 45                	push   $0x45
  jmp alltraps
8010531f:	e9 32 f9 ff ff       	jmp    80104c56 <alltraps>

80105324 <vector70>:
.globl vector70
vector70:
  pushl $0
80105324:	6a 00                	push   $0x0
  pushl $70
80105326:	6a 46                	push   $0x46
  jmp alltraps
80105328:	e9 29 f9 ff ff       	jmp    80104c56 <alltraps>

8010532d <vector71>:
.globl vector71
vector71:
  pushl $0
8010532d:	6a 00                	push   $0x0
  pushl $71
8010532f:	6a 47                	push   $0x47
  jmp alltraps
80105331:	e9 20 f9 ff ff       	jmp    80104c56 <alltraps>

80105336 <vector72>:
.globl vector72
vector72:
  pushl $0
80105336:	6a 00                	push   $0x0
  pushl $72
80105338:	6a 48                	push   $0x48
  jmp alltraps
8010533a:	e9 17 f9 ff ff       	jmp    80104c56 <alltraps>

8010533f <vector73>:
.globl vector73
vector73:
  pushl $0
8010533f:	6a 00                	push   $0x0
  pushl $73
80105341:	6a 49                	push   $0x49
  jmp alltraps
80105343:	e9 0e f9 ff ff       	jmp    80104c56 <alltraps>

80105348 <vector74>:
.globl vector74
vector74:
  pushl $0
80105348:	6a 00                	push   $0x0
  pushl $74
8010534a:	6a 4a                	push   $0x4a
  jmp alltraps
8010534c:	e9 05 f9 ff ff       	jmp    80104c56 <alltraps>

80105351 <vector75>:
.globl vector75
vector75:
  pushl $0
80105351:	6a 00                	push   $0x0
  pushl $75
80105353:	6a 4b                	push   $0x4b
  jmp alltraps
80105355:	e9 fc f8 ff ff       	jmp    80104c56 <alltraps>

8010535a <vector76>:
.globl vector76
vector76:
  pushl $0
8010535a:	6a 00                	push   $0x0
  pushl $76
8010535c:	6a 4c                	push   $0x4c
  jmp alltraps
8010535e:	e9 f3 f8 ff ff       	jmp    80104c56 <alltraps>

80105363 <vector77>:
.globl vector77
vector77:
  pushl $0
80105363:	6a 00                	push   $0x0
  pushl $77
80105365:	6a 4d                	push   $0x4d
  jmp alltraps
80105367:	e9 ea f8 ff ff       	jmp    80104c56 <alltraps>

8010536c <vector78>:
.globl vector78
vector78:
  pushl $0
8010536c:	6a 00                	push   $0x0
  pushl $78
8010536e:	6a 4e                	push   $0x4e
  jmp alltraps
80105370:	e9 e1 f8 ff ff       	jmp    80104c56 <alltraps>

80105375 <vector79>:
.globl vector79
vector79:
  pushl $0
80105375:	6a 00                	push   $0x0
  pushl $79
80105377:	6a 4f                	push   $0x4f
  jmp alltraps
80105379:	e9 d8 f8 ff ff       	jmp    80104c56 <alltraps>

8010537e <vector80>:
.globl vector80
vector80:
  pushl $0
8010537e:	6a 00                	push   $0x0
  pushl $80
80105380:	6a 50                	push   $0x50
  jmp alltraps
80105382:	e9 cf f8 ff ff       	jmp    80104c56 <alltraps>

80105387 <vector81>:
.globl vector81
vector81:
  pushl $0
80105387:	6a 00                	push   $0x0
  pushl $81
80105389:	6a 51                	push   $0x51
  jmp alltraps
8010538b:	e9 c6 f8 ff ff       	jmp    80104c56 <alltraps>

80105390 <vector82>:
.globl vector82
vector82:
  pushl $0
80105390:	6a 00                	push   $0x0
  pushl $82
80105392:	6a 52                	push   $0x52
  jmp alltraps
80105394:	e9 bd f8 ff ff       	jmp    80104c56 <alltraps>

80105399 <vector83>:
.globl vector83
vector83:
  pushl $0
80105399:	6a 00                	push   $0x0
  pushl $83
8010539b:	6a 53                	push   $0x53
  jmp alltraps
8010539d:	e9 b4 f8 ff ff       	jmp    80104c56 <alltraps>

801053a2 <vector84>:
.globl vector84
vector84:
  pushl $0
801053a2:	6a 00                	push   $0x0
  pushl $84
801053a4:	6a 54                	push   $0x54
  jmp alltraps
801053a6:	e9 ab f8 ff ff       	jmp    80104c56 <alltraps>

801053ab <vector85>:
.globl vector85
vector85:
  pushl $0
801053ab:	6a 00                	push   $0x0
  pushl $85
801053ad:	6a 55                	push   $0x55
  jmp alltraps
801053af:	e9 a2 f8 ff ff       	jmp    80104c56 <alltraps>

801053b4 <vector86>:
.globl vector86
vector86:
  pushl $0
801053b4:	6a 00                	push   $0x0
  pushl $86
801053b6:	6a 56                	push   $0x56
  jmp alltraps
801053b8:	e9 99 f8 ff ff       	jmp    80104c56 <alltraps>

801053bd <vector87>:
.globl vector87
vector87:
  pushl $0
801053bd:	6a 00                	push   $0x0
  pushl $87
801053bf:	6a 57                	push   $0x57
  jmp alltraps
801053c1:	e9 90 f8 ff ff       	jmp    80104c56 <alltraps>

801053c6 <vector88>:
.globl vector88
vector88:
  pushl $0
801053c6:	6a 00                	push   $0x0
  pushl $88
801053c8:	6a 58                	push   $0x58
  jmp alltraps
801053ca:	e9 87 f8 ff ff       	jmp    80104c56 <alltraps>

801053cf <vector89>:
.globl vector89
vector89:
  pushl $0
801053cf:	6a 00                	push   $0x0
  pushl $89
801053d1:	6a 59                	push   $0x59
  jmp alltraps
801053d3:	e9 7e f8 ff ff       	jmp    80104c56 <alltraps>

801053d8 <vector90>:
.globl vector90
vector90:
  pushl $0
801053d8:	6a 00                	push   $0x0
  pushl $90
801053da:	6a 5a                	push   $0x5a
  jmp alltraps
801053dc:	e9 75 f8 ff ff       	jmp    80104c56 <alltraps>

801053e1 <vector91>:
.globl vector91
vector91:
  pushl $0
801053e1:	6a 00                	push   $0x0
  pushl $91
801053e3:	6a 5b                	push   $0x5b
  jmp alltraps
801053e5:	e9 6c f8 ff ff       	jmp    80104c56 <alltraps>

801053ea <vector92>:
.globl vector92
vector92:
  pushl $0
801053ea:	6a 00                	push   $0x0
  pushl $92
801053ec:	6a 5c                	push   $0x5c
  jmp alltraps
801053ee:	e9 63 f8 ff ff       	jmp    80104c56 <alltraps>

801053f3 <vector93>:
.globl vector93
vector93:
  pushl $0
801053f3:	6a 00                	push   $0x0
  pushl $93
801053f5:	6a 5d                	push   $0x5d
  jmp alltraps
801053f7:	e9 5a f8 ff ff       	jmp    80104c56 <alltraps>

801053fc <vector94>:
.globl vector94
vector94:
  pushl $0
801053fc:	6a 00                	push   $0x0
  pushl $94
801053fe:	6a 5e                	push   $0x5e
  jmp alltraps
80105400:	e9 51 f8 ff ff       	jmp    80104c56 <alltraps>

80105405 <vector95>:
.globl vector95
vector95:
  pushl $0
80105405:	6a 00                	push   $0x0
  pushl $95
80105407:	6a 5f                	push   $0x5f
  jmp alltraps
80105409:	e9 48 f8 ff ff       	jmp    80104c56 <alltraps>

8010540e <vector96>:
.globl vector96
vector96:
  pushl $0
8010540e:	6a 00                	push   $0x0
  pushl $96
80105410:	6a 60                	push   $0x60
  jmp alltraps
80105412:	e9 3f f8 ff ff       	jmp    80104c56 <alltraps>

80105417 <vector97>:
.globl vector97
vector97:
  pushl $0
80105417:	6a 00                	push   $0x0
  pushl $97
80105419:	6a 61                	push   $0x61
  jmp alltraps
8010541b:	e9 36 f8 ff ff       	jmp    80104c56 <alltraps>

80105420 <vector98>:
.globl vector98
vector98:
  pushl $0
80105420:	6a 00                	push   $0x0
  pushl $98
80105422:	6a 62                	push   $0x62
  jmp alltraps
80105424:	e9 2d f8 ff ff       	jmp    80104c56 <alltraps>

80105429 <vector99>:
.globl vector99
vector99:
  pushl $0
80105429:	6a 00                	push   $0x0
  pushl $99
8010542b:	6a 63                	push   $0x63
  jmp alltraps
8010542d:	e9 24 f8 ff ff       	jmp    80104c56 <alltraps>

80105432 <vector100>:
.globl vector100
vector100:
  pushl $0
80105432:	6a 00                	push   $0x0
  pushl $100
80105434:	6a 64                	push   $0x64
  jmp alltraps
80105436:	e9 1b f8 ff ff       	jmp    80104c56 <alltraps>

8010543b <vector101>:
.globl vector101
vector101:
  pushl $0
8010543b:	6a 00                	push   $0x0
  pushl $101
8010543d:	6a 65                	push   $0x65
  jmp alltraps
8010543f:	e9 12 f8 ff ff       	jmp    80104c56 <alltraps>

80105444 <vector102>:
.globl vector102
vector102:
  pushl $0
80105444:	6a 00                	push   $0x0
  pushl $102
80105446:	6a 66                	push   $0x66
  jmp alltraps
80105448:	e9 09 f8 ff ff       	jmp    80104c56 <alltraps>

8010544d <vector103>:
.globl vector103
vector103:
  pushl $0
8010544d:	6a 00                	push   $0x0
  pushl $103
8010544f:	6a 67                	push   $0x67
  jmp alltraps
80105451:	e9 00 f8 ff ff       	jmp    80104c56 <alltraps>

80105456 <vector104>:
.globl vector104
vector104:
  pushl $0
80105456:	6a 00                	push   $0x0
  pushl $104
80105458:	6a 68                	push   $0x68
  jmp alltraps
8010545a:	e9 f7 f7 ff ff       	jmp    80104c56 <alltraps>

8010545f <vector105>:
.globl vector105
vector105:
  pushl $0
8010545f:	6a 00                	push   $0x0
  pushl $105
80105461:	6a 69                	push   $0x69
  jmp alltraps
80105463:	e9 ee f7 ff ff       	jmp    80104c56 <alltraps>

80105468 <vector106>:
.globl vector106
vector106:
  pushl $0
80105468:	6a 00                	push   $0x0
  pushl $106
8010546a:	6a 6a                	push   $0x6a
  jmp alltraps
8010546c:	e9 e5 f7 ff ff       	jmp    80104c56 <alltraps>

80105471 <vector107>:
.globl vector107
vector107:
  pushl $0
80105471:	6a 00                	push   $0x0
  pushl $107
80105473:	6a 6b                	push   $0x6b
  jmp alltraps
80105475:	e9 dc f7 ff ff       	jmp    80104c56 <alltraps>

8010547a <vector108>:
.globl vector108
vector108:
  pushl $0
8010547a:	6a 00                	push   $0x0
  pushl $108
8010547c:	6a 6c                	push   $0x6c
  jmp alltraps
8010547e:	e9 d3 f7 ff ff       	jmp    80104c56 <alltraps>

80105483 <vector109>:
.globl vector109
vector109:
  pushl $0
80105483:	6a 00                	push   $0x0
  pushl $109
80105485:	6a 6d                	push   $0x6d
  jmp alltraps
80105487:	e9 ca f7 ff ff       	jmp    80104c56 <alltraps>

8010548c <vector110>:
.globl vector110
vector110:
  pushl $0
8010548c:	6a 00                	push   $0x0
  pushl $110
8010548e:	6a 6e                	push   $0x6e
  jmp alltraps
80105490:	e9 c1 f7 ff ff       	jmp    80104c56 <alltraps>

80105495 <vector111>:
.globl vector111
vector111:
  pushl $0
80105495:	6a 00                	push   $0x0
  pushl $111
80105497:	6a 6f                	push   $0x6f
  jmp alltraps
80105499:	e9 b8 f7 ff ff       	jmp    80104c56 <alltraps>

8010549e <vector112>:
.globl vector112
vector112:
  pushl $0
8010549e:	6a 00                	push   $0x0
  pushl $112
801054a0:	6a 70                	push   $0x70
  jmp alltraps
801054a2:	e9 af f7 ff ff       	jmp    80104c56 <alltraps>

801054a7 <vector113>:
.globl vector113
vector113:
  pushl $0
801054a7:	6a 00                	push   $0x0
  pushl $113
801054a9:	6a 71                	push   $0x71
  jmp alltraps
801054ab:	e9 a6 f7 ff ff       	jmp    80104c56 <alltraps>

801054b0 <vector114>:
.globl vector114
vector114:
  pushl $0
801054b0:	6a 00                	push   $0x0
  pushl $114
801054b2:	6a 72                	push   $0x72
  jmp alltraps
801054b4:	e9 9d f7 ff ff       	jmp    80104c56 <alltraps>

801054b9 <vector115>:
.globl vector115
vector115:
  pushl $0
801054b9:	6a 00                	push   $0x0
  pushl $115
801054bb:	6a 73                	push   $0x73
  jmp alltraps
801054bd:	e9 94 f7 ff ff       	jmp    80104c56 <alltraps>

801054c2 <vector116>:
.globl vector116
vector116:
  pushl $0
801054c2:	6a 00                	push   $0x0
  pushl $116
801054c4:	6a 74                	push   $0x74
  jmp alltraps
801054c6:	e9 8b f7 ff ff       	jmp    80104c56 <alltraps>

801054cb <vector117>:
.globl vector117
vector117:
  pushl $0
801054cb:	6a 00                	push   $0x0
  pushl $117
801054cd:	6a 75                	push   $0x75
  jmp alltraps
801054cf:	e9 82 f7 ff ff       	jmp    80104c56 <alltraps>

801054d4 <vector118>:
.globl vector118
vector118:
  pushl $0
801054d4:	6a 00                	push   $0x0
  pushl $118
801054d6:	6a 76                	push   $0x76
  jmp alltraps
801054d8:	e9 79 f7 ff ff       	jmp    80104c56 <alltraps>

801054dd <vector119>:
.globl vector119
vector119:
  pushl $0
801054dd:	6a 00                	push   $0x0
  pushl $119
801054df:	6a 77                	push   $0x77
  jmp alltraps
801054e1:	e9 70 f7 ff ff       	jmp    80104c56 <alltraps>

801054e6 <vector120>:
.globl vector120
vector120:
  pushl $0
801054e6:	6a 00                	push   $0x0
  pushl $120
801054e8:	6a 78                	push   $0x78
  jmp alltraps
801054ea:	e9 67 f7 ff ff       	jmp    80104c56 <alltraps>

801054ef <vector121>:
.globl vector121
vector121:
  pushl $0
801054ef:	6a 00                	push   $0x0
  pushl $121
801054f1:	6a 79                	push   $0x79
  jmp alltraps
801054f3:	e9 5e f7 ff ff       	jmp    80104c56 <alltraps>

801054f8 <vector122>:
.globl vector122
vector122:
  pushl $0
801054f8:	6a 00                	push   $0x0
  pushl $122
801054fa:	6a 7a                	push   $0x7a
  jmp alltraps
801054fc:	e9 55 f7 ff ff       	jmp    80104c56 <alltraps>

80105501 <vector123>:
.globl vector123
vector123:
  pushl $0
80105501:	6a 00                	push   $0x0
  pushl $123
80105503:	6a 7b                	push   $0x7b
  jmp alltraps
80105505:	e9 4c f7 ff ff       	jmp    80104c56 <alltraps>

8010550a <vector124>:
.globl vector124
vector124:
  pushl $0
8010550a:	6a 00                	push   $0x0
  pushl $124
8010550c:	6a 7c                	push   $0x7c
  jmp alltraps
8010550e:	e9 43 f7 ff ff       	jmp    80104c56 <alltraps>

80105513 <vector125>:
.globl vector125
vector125:
  pushl $0
80105513:	6a 00                	push   $0x0
  pushl $125
80105515:	6a 7d                	push   $0x7d
  jmp alltraps
80105517:	e9 3a f7 ff ff       	jmp    80104c56 <alltraps>

8010551c <vector126>:
.globl vector126
vector126:
  pushl $0
8010551c:	6a 00                	push   $0x0
  pushl $126
8010551e:	6a 7e                	push   $0x7e
  jmp alltraps
80105520:	e9 31 f7 ff ff       	jmp    80104c56 <alltraps>

80105525 <vector127>:
.globl vector127
vector127:
  pushl $0
80105525:	6a 00                	push   $0x0
  pushl $127
80105527:	6a 7f                	push   $0x7f
  jmp alltraps
80105529:	e9 28 f7 ff ff       	jmp    80104c56 <alltraps>

8010552e <vector128>:
.globl vector128
vector128:
  pushl $0
8010552e:	6a 00                	push   $0x0
  pushl $128
80105530:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105535:	e9 1c f7 ff ff       	jmp    80104c56 <alltraps>

8010553a <vector129>:
.globl vector129
vector129:
  pushl $0
8010553a:	6a 00                	push   $0x0
  pushl $129
8010553c:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105541:	e9 10 f7 ff ff       	jmp    80104c56 <alltraps>

80105546 <vector130>:
.globl vector130
vector130:
  pushl $0
80105546:	6a 00                	push   $0x0
  pushl $130
80105548:	68 82 00 00 00       	push   $0x82
  jmp alltraps
8010554d:	e9 04 f7 ff ff       	jmp    80104c56 <alltraps>

80105552 <vector131>:
.globl vector131
vector131:
  pushl $0
80105552:	6a 00                	push   $0x0
  pushl $131
80105554:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105559:	e9 f8 f6 ff ff       	jmp    80104c56 <alltraps>

8010555e <vector132>:
.globl vector132
vector132:
  pushl $0
8010555e:	6a 00                	push   $0x0
  pushl $132
80105560:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105565:	e9 ec f6 ff ff       	jmp    80104c56 <alltraps>

8010556a <vector133>:
.globl vector133
vector133:
  pushl $0
8010556a:	6a 00                	push   $0x0
  pushl $133
8010556c:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105571:	e9 e0 f6 ff ff       	jmp    80104c56 <alltraps>

80105576 <vector134>:
.globl vector134
vector134:
  pushl $0
80105576:	6a 00                	push   $0x0
  pushl $134
80105578:	68 86 00 00 00       	push   $0x86
  jmp alltraps
8010557d:	e9 d4 f6 ff ff       	jmp    80104c56 <alltraps>

80105582 <vector135>:
.globl vector135
vector135:
  pushl $0
80105582:	6a 00                	push   $0x0
  pushl $135
80105584:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105589:	e9 c8 f6 ff ff       	jmp    80104c56 <alltraps>

8010558e <vector136>:
.globl vector136
vector136:
  pushl $0
8010558e:	6a 00                	push   $0x0
  pushl $136
80105590:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105595:	e9 bc f6 ff ff       	jmp    80104c56 <alltraps>

8010559a <vector137>:
.globl vector137
vector137:
  pushl $0
8010559a:	6a 00                	push   $0x0
  pushl $137
8010559c:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801055a1:	e9 b0 f6 ff ff       	jmp    80104c56 <alltraps>

801055a6 <vector138>:
.globl vector138
vector138:
  pushl $0
801055a6:	6a 00                	push   $0x0
  pushl $138
801055a8:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801055ad:	e9 a4 f6 ff ff       	jmp    80104c56 <alltraps>

801055b2 <vector139>:
.globl vector139
vector139:
  pushl $0
801055b2:	6a 00                	push   $0x0
  pushl $139
801055b4:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801055b9:	e9 98 f6 ff ff       	jmp    80104c56 <alltraps>

801055be <vector140>:
.globl vector140
vector140:
  pushl $0
801055be:	6a 00                	push   $0x0
  pushl $140
801055c0:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801055c5:	e9 8c f6 ff ff       	jmp    80104c56 <alltraps>

801055ca <vector141>:
.globl vector141
vector141:
  pushl $0
801055ca:	6a 00                	push   $0x0
  pushl $141
801055cc:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801055d1:	e9 80 f6 ff ff       	jmp    80104c56 <alltraps>

801055d6 <vector142>:
.globl vector142
vector142:
  pushl $0
801055d6:	6a 00                	push   $0x0
  pushl $142
801055d8:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801055dd:	e9 74 f6 ff ff       	jmp    80104c56 <alltraps>

801055e2 <vector143>:
.globl vector143
vector143:
  pushl $0
801055e2:	6a 00                	push   $0x0
  pushl $143
801055e4:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801055e9:	e9 68 f6 ff ff       	jmp    80104c56 <alltraps>

801055ee <vector144>:
.globl vector144
vector144:
  pushl $0
801055ee:	6a 00                	push   $0x0
  pushl $144
801055f0:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801055f5:	e9 5c f6 ff ff       	jmp    80104c56 <alltraps>

801055fa <vector145>:
.globl vector145
vector145:
  pushl $0
801055fa:	6a 00                	push   $0x0
  pushl $145
801055fc:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105601:	e9 50 f6 ff ff       	jmp    80104c56 <alltraps>

80105606 <vector146>:
.globl vector146
vector146:
  pushl $0
80105606:	6a 00                	push   $0x0
  pushl $146
80105608:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010560d:	e9 44 f6 ff ff       	jmp    80104c56 <alltraps>

80105612 <vector147>:
.globl vector147
vector147:
  pushl $0
80105612:	6a 00                	push   $0x0
  pushl $147
80105614:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105619:	e9 38 f6 ff ff       	jmp    80104c56 <alltraps>

8010561e <vector148>:
.globl vector148
vector148:
  pushl $0
8010561e:	6a 00                	push   $0x0
  pushl $148
80105620:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105625:	e9 2c f6 ff ff       	jmp    80104c56 <alltraps>

8010562a <vector149>:
.globl vector149
vector149:
  pushl $0
8010562a:	6a 00                	push   $0x0
  pushl $149
8010562c:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105631:	e9 20 f6 ff ff       	jmp    80104c56 <alltraps>

80105636 <vector150>:
.globl vector150
vector150:
  pushl $0
80105636:	6a 00                	push   $0x0
  pushl $150
80105638:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010563d:	e9 14 f6 ff ff       	jmp    80104c56 <alltraps>

80105642 <vector151>:
.globl vector151
vector151:
  pushl $0
80105642:	6a 00                	push   $0x0
  pushl $151
80105644:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105649:	e9 08 f6 ff ff       	jmp    80104c56 <alltraps>

8010564e <vector152>:
.globl vector152
vector152:
  pushl $0
8010564e:	6a 00                	push   $0x0
  pushl $152
80105650:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105655:	e9 fc f5 ff ff       	jmp    80104c56 <alltraps>

8010565a <vector153>:
.globl vector153
vector153:
  pushl $0
8010565a:	6a 00                	push   $0x0
  pushl $153
8010565c:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105661:	e9 f0 f5 ff ff       	jmp    80104c56 <alltraps>

80105666 <vector154>:
.globl vector154
vector154:
  pushl $0
80105666:	6a 00                	push   $0x0
  pushl $154
80105668:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010566d:	e9 e4 f5 ff ff       	jmp    80104c56 <alltraps>

80105672 <vector155>:
.globl vector155
vector155:
  pushl $0
80105672:	6a 00                	push   $0x0
  pushl $155
80105674:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105679:	e9 d8 f5 ff ff       	jmp    80104c56 <alltraps>

8010567e <vector156>:
.globl vector156
vector156:
  pushl $0
8010567e:	6a 00                	push   $0x0
  pushl $156
80105680:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105685:	e9 cc f5 ff ff       	jmp    80104c56 <alltraps>

8010568a <vector157>:
.globl vector157
vector157:
  pushl $0
8010568a:	6a 00                	push   $0x0
  pushl $157
8010568c:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105691:	e9 c0 f5 ff ff       	jmp    80104c56 <alltraps>

80105696 <vector158>:
.globl vector158
vector158:
  pushl $0
80105696:	6a 00                	push   $0x0
  pushl $158
80105698:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
8010569d:	e9 b4 f5 ff ff       	jmp    80104c56 <alltraps>

801056a2 <vector159>:
.globl vector159
vector159:
  pushl $0
801056a2:	6a 00                	push   $0x0
  pushl $159
801056a4:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801056a9:	e9 a8 f5 ff ff       	jmp    80104c56 <alltraps>

801056ae <vector160>:
.globl vector160
vector160:
  pushl $0
801056ae:	6a 00                	push   $0x0
  pushl $160
801056b0:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801056b5:	e9 9c f5 ff ff       	jmp    80104c56 <alltraps>

801056ba <vector161>:
.globl vector161
vector161:
  pushl $0
801056ba:	6a 00                	push   $0x0
  pushl $161
801056bc:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801056c1:	e9 90 f5 ff ff       	jmp    80104c56 <alltraps>

801056c6 <vector162>:
.globl vector162
vector162:
  pushl $0
801056c6:	6a 00                	push   $0x0
  pushl $162
801056c8:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801056cd:	e9 84 f5 ff ff       	jmp    80104c56 <alltraps>

801056d2 <vector163>:
.globl vector163
vector163:
  pushl $0
801056d2:	6a 00                	push   $0x0
  pushl $163
801056d4:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801056d9:	e9 78 f5 ff ff       	jmp    80104c56 <alltraps>

801056de <vector164>:
.globl vector164
vector164:
  pushl $0
801056de:	6a 00                	push   $0x0
  pushl $164
801056e0:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801056e5:	e9 6c f5 ff ff       	jmp    80104c56 <alltraps>

801056ea <vector165>:
.globl vector165
vector165:
  pushl $0
801056ea:	6a 00                	push   $0x0
  pushl $165
801056ec:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801056f1:	e9 60 f5 ff ff       	jmp    80104c56 <alltraps>

801056f6 <vector166>:
.globl vector166
vector166:
  pushl $0
801056f6:	6a 00                	push   $0x0
  pushl $166
801056f8:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801056fd:	e9 54 f5 ff ff       	jmp    80104c56 <alltraps>

80105702 <vector167>:
.globl vector167
vector167:
  pushl $0
80105702:	6a 00                	push   $0x0
  pushl $167
80105704:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105709:	e9 48 f5 ff ff       	jmp    80104c56 <alltraps>

8010570e <vector168>:
.globl vector168
vector168:
  pushl $0
8010570e:	6a 00                	push   $0x0
  pushl $168
80105710:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105715:	e9 3c f5 ff ff       	jmp    80104c56 <alltraps>

8010571a <vector169>:
.globl vector169
vector169:
  pushl $0
8010571a:	6a 00                	push   $0x0
  pushl $169
8010571c:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105721:	e9 30 f5 ff ff       	jmp    80104c56 <alltraps>

80105726 <vector170>:
.globl vector170
vector170:
  pushl $0
80105726:	6a 00                	push   $0x0
  pushl $170
80105728:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010572d:	e9 24 f5 ff ff       	jmp    80104c56 <alltraps>

80105732 <vector171>:
.globl vector171
vector171:
  pushl $0
80105732:	6a 00                	push   $0x0
  pushl $171
80105734:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80105739:	e9 18 f5 ff ff       	jmp    80104c56 <alltraps>

8010573e <vector172>:
.globl vector172
vector172:
  pushl $0
8010573e:	6a 00                	push   $0x0
  pushl $172
80105740:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80105745:	e9 0c f5 ff ff       	jmp    80104c56 <alltraps>

8010574a <vector173>:
.globl vector173
vector173:
  pushl $0
8010574a:	6a 00                	push   $0x0
  pushl $173
8010574c:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80105751:	e9 00 f5 ff ff       	jmp    80104c56 <alltraps>

80105756 <vector174>:
.globl vector174
vector174:
  pushl $0
80105756:	6a 00                	push   $0x0
  pushl $174
80105758:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010575d:	e9 f4 f4 ff ff       	jmp    80104c56 <alltraps>

80105762 <vector175>:
.globl vector175
vector175:
  pushl $0
80105762:	6a 00                	push   $0x0
  pushl $175
80105764:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80105769:	e9 e8 f4 ff ff       	jmp    80104c56 <alltraps>

8010576e <vector176>:
.globl vector176
vector176:
  pushl $0
8010576e:	6a 00                	push   $0x0
  pushl $176
80105770:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80105775:	e9 dc f4 ff ff       	jmp    80104c56 <alltraps>

8010577a <vector177>:
.globl vector177
vector177:
  pushl $0
8010577a:	6a 00                	push   $0x0
  pushl $177
8010577c:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80105781:	e9 d0 f4 ff ff       	jmp    80104c56 <alltraps>

80105786 <vector178>:
.globl vector178
vector178:
  pushl $0
80105786:	6a 00                	push   $0x0
  pushl $178
80105788:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
8010578d:	e9 c4 f4 ff ff       	jmp    80104c56 <alltraps>

80105792 <vector179>:
.globl vector179
vector179:
  pushl $0
80105792:	6a 00                	push   $0x0
  pushl $179
80105794:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80105799:	e9 b8 f4 ff ff       	jmp    80104c56 <alltraps>

8010579e <vector180>:
.globl vector180
vector180:
  pushl $0
8010579e:	6a 00                	push   $0x0
  pushl $180
801057a0:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801057a5:	e9 ac f4 ff ff       	jmp    80104c56 <alltraps>

801057aa <vector181>:
.globl vector181
vector181:
  pushl $0
801057aa:	6a 00                	push   $0x0
  pushl $181
801057ac:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801057b1:	e9 a0 f4 ff ff       	jmp    80104c56 <alltraps>

801057b6 <vector182>:
.globl vector182
vector182:
  pushl $0
801057b6:	6a 00                	push   $0x0
  pushl $182
801057b8:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801057bd:	e9 94 f4 ff ff       	jmp    80104c56 <alltraps>

801057c2 <vector183>:
.globl vector183
vector183:
  pushl $0
801057c2:	6a 00                	push   $0x0
  pushl $183
801057c4:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801057c9:	e9 88 f4 ff ff       	jmp    80104c56 <alltraps>

801057ce <vector184>:
.globl vector184
vector184:
  pushl $0
801057ce:	6a 00                	push   $0x0
  pushl $184
801057d0:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801057d5:	e9 7c f4 ff ff       	jmp    80104c56 <alltraps>

801057da <vector185>:
.globl vector185
vector185:
  pushl $0
801057da:	6a 00                	push   $0x0
  pushl $185
801057dc:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801057e1:	e9 70 f4 ff ff       	jmp    80104c56 <alltraps>

801057e6 <vector186>:
.globl vector186
vector186:
  pushl $0
801057e6:	6a 00                	push   $0x0
  pushl $186
801057e8:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801057ed:	e9 64 f4 ff ff       	jmp    80104c56 <alltraps>

801057f2 <vector187>:
.globl vector187
vector187:
  pushl $0
801057f2:	6a 00                	push   $0x0
  pushl $187
801057f4:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801057f9:	e9 58 f4 ff ff       	jmp    80104c56 <alltraps>

801057fe <vector188>:
.globl vector188
vector188:
  pushl $0
801057fe:	6a 00                	push   $0x0
  pushl $188
80105800:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80105805:	e9 4c f4 ff ff       	jmp    80104c56 <alltraps>

8010580a <vector189>:
.globl vector189
vector189:
  pushl $0
8010580a:	6a 00                	push   $0x0
  pushl $189
8010580c:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80105811:	e9 40 f4 ff ff       	jmp    80104c56 <alltraps>

80105816 <vector190>:
.globl vector190
vector190:
  pushl $0
80105816:	6a 00                	push   $0x0
  pushl $190
80105818:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010581d:	e9 34 f4 ff ff       	jmp    80104c56 <alltraps>

80105822 <vector191>:
.globl vector191
vector191:
  pushl $0
80105822:	6a 00                	push   $0x0
  pushl $191
80105824:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80105829:	e9 28 f4 ff ff       	jmp    80104c56 <alltraps>

8010582e <vector192>:
.globl vector192
vector192:
  pushl $0
8010582e:	6a 00                	push   $0x0
  pushl $192
80105830:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80105835:	e9 1c f4 ff ff       	jmp    80104c56 <alltraps>

8010583a <vector193>:
.globl vector193
vector193:
  pushl $0
8010583a:	6a 00                	push   $0x0
  pushl $193
8010583c:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80105841:	e9 10 f4 ff ff       	jmp    80104c56 <alltraps>

80105846 <vector194>:
.globl vector194
vector194:
  pushl $0
80105846:	6a 00                	push   $0x0
  pushl $194
80105848:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010584d:	e9 04 f4 ff ff       	jmp    80104c56 <alltraps>

80105852 <vector195>:
.globl vector195
vector195:
  pushl $0
80105852:	6a 00                	push   $0x0
  pushl $195
80105854:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80105859:	e9 f8 f3 ff ff       	jmp    80104c56 <alltraps>

8010585e <vector196>:
.globl vector196
vector196:
  pushl $0
8010585e:	6a 00                	push   $0x0
  pushl $196
80105860:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105865:	e9 ec f3 ff ff       	jmp    80104c56 <alltraps>

8010586a <vector197>:
.globl vector197
vector197:
  pushl $0
8010586a:	6a 00                	push   $0x0
  pushl $197
8010586c:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80105871:	e9 e0 f3 ff ff       	jmp    80104c56 <alltraps>

80105876 <vector198>:
.globl vector198
vector198:
  pushl $0
80105876:	6a 00                	push   $0x0
  pushl $198
80105878:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010587d:	e9 d4 f3 ff ff       	jmp    80104c56 <alltraps>

80105882 <vector199>:
.globl vector199
vector199:
  pushl $0
80105882:	6a 00                	push   $0x0
  pushl $199
80105884:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80105889:	e9 c8 f3 ff ff       	jmp    80104c56 <alltraps>

8010588e <vector200>:
.globl vector200
vector200:
  pushl $0
8010588e:	6a 00                	push   $0x0
  pushl $200
80105890:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80105895:	e9 bc f3 ff ff       	jmp    80104c56 <alltraps>

8010589a <vector201>:
.globl vector201
vector201:
  pushl $0
8010589a:	6a 00                	push   $0x0
  pushl $201
8010589c:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801058a1:	e9 b0 f3 ff ff       	jmp    80104c56 <alltraps>

801058a6 <vector202>:
.globl vector202
vector202:
  pushl $0
801058a6:	6a 00                	push   $0x0
  pushl $202
801058a8:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801058ad:	e9 a4 f3 ff ff       	jmp    80104c56 <alltraps>

801058b2 <vector203>:
.globl vector203
vector203:
  pushl $0
801058b2:	6a 00                	push   $0x0
  pushl $203
801058b4:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801058b9:	e9 98 f3 ff ff       	jmp    80104c56 <alltraps>

801058be <vector204>:
.globl vector204
vector204:
  pushl $0
801058be:	6a 00                	push   $0x0
  pushl $204
801058c0:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801058c5:	e9 8c f3 ff ff       	jmp    80104c56 <alltraps>

801058ca <vector205>:
.globl vector205
vector205:
  pushl $0
801058ca:	6a 00                	push   $0x0
  pushl $205
801058cc:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801058d1:	e9 80 f3 ff ff       	jmp    80104c56 <alltraps>

801058d6 <vector206>:
.globl vector206
vector206:
  pushl $0
801058d6:	6a 00                	push   $0x0
  pushl $206
801058d8:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801058dd:	e9 74 f3 ff ff       	jmp    80104c56 <alltraps>

801058e2 <vector207>:
.globl vector207
vector207:
  pushl $0
801058e2:	6a 00                	push   $0x0
  pushl $207
801058e4:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801058e9:	e9 68 f3 ff ff       	jmp    80104c56 <alltraps>

801058ee <vector208>:
.globl vector208
vector208:
  pushl $0
801058ee:	6a 00                	push   $0x0
  pushl $208
801058f0:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801058f5:	e9 5c f3 ff ff       	jmp    80104c56 <alltraps>

801058fa <vector209>:
.globl vector209
vector209:
  pushl $0
801058fa:	6a 00                	push   $0x0
  pushl $209
801058fc:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80105901:	e9 50 f3 ff ff       	jmp    80104c56 <alltraps>

80105906 <vector210>:
.globl vector210
vector210:
  pushl $0
80105906:	6a 00                	push   $0x0
  pushl $210
80105908:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010590d:	e9 44 f3 ff ff       	jmp    80104c56 <alltraps>

80105912 <vector211>:
.globl vector211
vector211:
  pushl $0
80105912:	6a 00                	push   $0x0
  pushl $211
80105914:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80105919:	e9 38 f3 ff ff       	jmp    80104c56 <alltraps>

8010591e <vector212>:
.globl vector212
vector212:
  pushl $0
8010591e:	6a 00                	push   $0x0
  pushl $212
80105920:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80105925:	e9 2c f3 ff ff       	jmp    80104c56 <alltraps>

8010592a <vector213>:
.globl vector213
vector213:
  pushl $0
8010592a:	6a 00                	push   $0x0
  pushl $213
8010592c:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80105931:	e9 20 f3 ff ff       	jmp    80104c56 <alltraps>

80105936 <vector214>:
.globl vector214
vector214:
  pushl $0
80105936:	6a 00                	push   $0x0
  pushl $214
80105938:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010593d:	e9 14 f3 ff ff       	jmp    80104c56 <alltraps>

80105942 <vector215>:
.globl vector215
vector215:
  pushl $0
80105942:	6a 00                	push   $0x0
  pushl $215
80105944:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105949:	e9 08 f3 ff ff       	jmp    80104c56 <alltraps>

8010594e <vector216>:
.globl vector216
vector216:
  pushl $0
8010594e:	6a 00                	push   $0x0
  pushl $216
80105950:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105955:	e9 fc f2 ff ff       	jmp    80104c56 <alltraps>

8010595a <vector217>:
.globl vector217
vector217:
  pushl $0
8010595a:	6a 00                	push   $0x0
  pushl $217
8010595c:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105961:	e9 f0 f2 ff ff       	jmp    80104c56 <alltraps>

80105966 <vector218>:
.globl vector218
vector218:
  pushl $0
80105966:	6a 00                	push   $0x0
  pushl $218
80105968:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010596d:	e9 e4 f2 ff ff       	jmp    80104c56 <alltraps>

80105972 <vector219>:
.globl vector219
vector219:
  pushl $0
80105972:	6a 00                	push   $0x0
  pushl $219
80105974:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105979:	e9 d8 f2 ff ff       	jmp    80104c56 <alltraps>

8010597e <vector220>:
.globl vector220
vector220:
  pushl $0
8010597e:	6a 00                	push   $0x0
  pushl $220
80105980:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105985:	e9 cc f2 ff ff       	jmp    80104c56 <alltraps>

8010598a <vector221>:
.globl vector221
vector221:
  pushl $0
8010598a:	6a 00                	push   $0x0
  pushl $221
8010598c:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105991:	e9 c0 f2 ff ff       	jmp    80104c56 <alltraps>

80105996 <vector222>:
.globl vector222
vector222:
  pushl $0
80105996:	6a 00                	push   $0x0
  pushl $222
80105998:	68 de 00 00 00       	push   $0xde
  jmp alltraps
8010599d:	e9 b4 f2 ff ff       	jmp    80104c56 <alltraps>

801059a2 <vector223>:
.globl vector223
vector223:
  pushl $0
801059a2:	6a 00                	push   $0x0
  pushl $223
801059a4:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801059a9:	e9 a8 f2 ff ff       	jmp    80104c56 <alltraps>

801059ae <vector224>:
.globl vector224
vector224:
  pushl $0
801059ae:	6a 00                	push   $0x0
  pushl $224
801059b0:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801059b5:	e9 9c f2 ff ff       	jmp    80104c56 <alltraps>

801059ba <vector225>:
.globl vector225
vector225:
  pushl $0
801059ba:	6a 00                	push   $0x0
  pushl $225
801059bc:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801059c1:	e9 90 f2 ff ff       	jmp    80104c56 <alltraps>

801059c6 <vector226>:
.globl vector226
vector226:
  pushl $0
801059c6:	6a 00                	push   $0x0
  pushl $226
801059c8:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801059cd:	e9 84 f2 ff ff       	jmp    80104c56 <alltraps>

801059d2 <vector227>:
.globl vector227
vector227:
  pushl $0
801059d2:	6a 00                	push   $0x0
  pushl $227
801059d4:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801059d9:	e9 78 f2 ff ff       	jmp    80104c56 <alltraps>

801059de <vector228>:
.globl vector228
vector228:
  pushl $0
801059de:	6a 00                	push   $0x0
  pushl $228
801059e0:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801059e5:	e9 6c f2 ff ff       	jmp    80104c56 <alltraps>

801059ea <vector229>:
.globl vector229
vector229:
  pushl $0
801059ea:	6a 00                	push   $0x0
  pushl $229
801059ec:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801059f1:	e9 60 f2 ff ff       	jmp    80104c56 <alltraps>

801059f6 <vector230>:
.globl vector230
vector230:
  pushl $0
801059f6:	6a 00                	push   $0x0
  pushl $230
801059f8:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801059fd:	e9 54 f2 ff ff       	jmp    80104c56 <alltraps>

80105a02 <vector231>:
.globl vector231
vector231:
  pushl $0
80105a02:	6a 00                	push   $0x0
  pushl $231
80105a04:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105a09:	e9 48 f2 ff ff       	jmp    80104c56 <alltraps>

80105a0e <vector232>:
.globl vector232
vector232:
  pushl $0
80105a0e:	6a 00                	push   $0x0
  pushl $232
80105a10:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105a15:	e9 3c f2 ff ff       	jmp    80104c56 <alltraps>

80105a1a <vector233>:
.globl vector233
vector233:
  pushl $0
80105a1a:	6a 00                	push   $0x0
  pushl $233
80105a1c:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105a21:	e9 30 f2 ff ff       	jmp    80104c56 <alltraps>

80105a26 <vector234>:
.globl vector234
vector234:
  pushl $0
80105a26:	6a 00                	push   $0x0
  pushl $234
80105a28:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105a2d:	e9 24 f2 ff ff       	jmp    80104c56 <alltraps>

80105a32 <vector235>:
.globl vector235
vector235:
  pushl $0
80105a32:	6a 00                	push   $0x0
  pushl $235
80105a34:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105a39:	e9 18 f2 ff ff       	jmp    80104c56 <alltraps>

80105a3e <vector236>:
.globl vector236
vector236:
  pushl $0
80105a3e:	6a 00                	push   $0x0
  pushl $236
80105a40:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105a45:	e9 0c f2 ff ff       	jmp    80104c56 <alltraps>

80105a4a <vector237>:
.globl vector237
vector237:
  pushl $0
80105a4a:	6a 00                	push   $0x0
  pushl $237
80105a4c:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105a51:	e9 00 f2 ff ff       	jmp    80104c56 <alltraps>

80105a56 <vector238>:
.globl vector238
vector238:
  pushl $0
80105a56:	6a 00                	push   $0x0
  pushl $238
80105a58:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105a5d:	e9 f4 f1 ff ff       	jmp    80104c56 <alltraps>

80105a62 <vector239>:
.globl vector239
vector239:
  pushl $0
80105a62:	6a 00                	push   $0x0
  pushl $239
80105a64:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105a69:	e9 e8 f1 ff ff       	jmp    80104c56 <alltraps>

80105a6e <vector240>:
.globl vector240
vector240:
  pushl $0
80105a6e:	6a 00                	push   $0x0
  pushl $240
80105a70:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105a75:	e9 dc f1 ff ff       	jmp    80104c56 <alltraps>

80105a7a <vector241>:
.globl vector241
vector241:
  pushl $0
80105a7a:	6a 00                	push   $0x0
  pushl $241
80105a7c:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105a81:	e9 d0 f1 ff ff       	jmp    80104c56 <alltraps>

80105a86 <vector242>:
.globl vector242
vector242:
  pushl $0
80105a86:	6a 00                	push   $0x0
  pushl $242
80105a88:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105a8d:	e9 c4 f1 ff ff       	jmp    80104c56 <alltraps>

80105a92 <vector243>:
.globl vector243
vector243:
  pushl $0
80105a92:	6a 00                	push   $0x0
  pushl $243
80105a94:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105a99:	e9 b8 f1 ff ff       	jmp    80104c56 <alltraps>

80105a9e <vector244>:
.globl vector244
vector244:
  pushl $0
80105a9e:	6a 00                	push   $0x0
  pushl $244
80105aa0:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105aa5:	e9 ac f1 ff ff       	jmp    80104c56 <alltraps>

80105aaa <vector245>:
.globl vector245
vector245:
  pushl $0
80105aaa:	6a 00                	push   $0x0
  pushl $245
80105aac:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105ab1:	e9 a0 f1 ff ff       	jmp    80104c56 <alltraps>

80105ab6 <vector246>:
.globl vector246
vector246:
  pushl $0
80105ab6:	6a 00                	push   $0x0
  pushl $246
80105ab8:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105abd:	e9 94 f1 ff ff       	jmp    80104c56 <alltraps>

80105ac2 <vector247>:
.globl vector247
vector247:
  pushl $0
80105ac2:	6a 00                	push   $0x0
  pushl $247
80105ac4:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105ac9:	e9 88 f1 ff ff       	jmp    80104c56 <alltraps>

80105ace <vector248>:
.globl vector248
vector248:
  pushl $0
80105ace:	6a 00                	push   $0x0
  pushl $248
80105ad0:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105ad5:	e9 7c f1 ff ff       	jmp    80104c56 <alltraps>

80105ada <vector249>:
.globl vector249
vector249:
  pushl $0
80105ada:	6a 00                	push   $0x0
  pushl $249
80105adc:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105ae1:	e9 70 f1 ff ff       	jmp    80104c56 <alltraps>

80105ae6 <vector250>:
.globl vector250
vector250:
  pushl $0
80105ae6:	6a 00                	push   $0x0
  pushl $250
80105ae8:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105aed:	e9 64 f1 ff ff       	jmp    80104c56 <alltraps>

80105af2 <vector251>:
.globl vector251
vector251:
  pushl $0
80105af2:	6a 00                	push   $0x0
  pushl $251
80105af4:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105af9:	e9 58 f1 ff ff       	jmp    80104c56 <alltraps>

80105afe <vector252>:
.globl vector252
vector252:
  pushl $0
80105afe:	6a 00                	push   $0x0
  pushl $252
80105b00:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105b05:	e9 4c f1 ff ff       	jmp    80104c56 <alltraps>

80105b0a <vector253>:
.globl vector253
vector253:
  pushl $0
80105b0a:	6a 00                	push   $0x0
  pushl $253
80105b0c:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105b11:	e9 40 f1 ff ff       	jmp    80104c56 <alltraps>

80105b16 <vector254>:
.globl vector254
vector254:
  pushl $0
80105b16:	6a 00                	push   $0x0
  pushl $254
80105b18:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105b1d:	e9 34 f1 ff ff       	jmp    80104c56 <alltraps>

80105b22 <vector255>:
.globl vector255
vector255:
  pushl $0
80105b22:	6a 00                	push   $0x0
  pushl $255
80105b24:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105b29:	e9 28 f1 ff ff       	jmp    80104c56 <alltraps>

80105b2e <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80105b2e:	55                   	push   %ebp
80105b2f:	89 e5                	mov    %esp,%ebp
80105b31:	57                   	push   %edi
80105b32:	56                   	push   %esi
80105b33:	53                   	push   %ebx
80105b34:	83 ec 0c             	sub    $0xc,%esp
80105b37:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80105b39:	c1 ea 16             	shr    $0x16,%edx
80105b3c:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  if(*pde & PTE_P){
80105b3f:	8b 37                	mov    (%edi),%esi
80105b41:	f7 c6 01 00 00 00    	test   $0x1,%esi
80105b47:	74 20                	je     80105b69 <walkpgdir+0x3b>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105b49:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80105b4f:	81 c6 00 00 00 80    	add    $0x80000000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80105b55:	c1 eb 0c             	shr    $0xc,%ebx
80105b58:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
80105b5e:	8d 04 9e             	lea    (%esi,%ebx,4),%eax
}
80105b61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b64:	5b                   	pop    %ebx
80105b65:	5e                   	pop    %esi
80105b66:	5f                   	pop    %edi
80105b67:	5d                   	pop    %ebp
80105b68:	c3                   	ret    
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80105b69:	85 c9                	test   %ecx,%ecx
80105b6b:	74 2b                	je     80105b98 <walkpgdir+0x6a>
80105b6d:	e8 b5 c4 ff ff       	call   80102027 <kalloc>
80105b72:	89 c6                	mov    %eax,%esi
80105b74:	85 c0                	test   %eax,%eax
80105b76:	74 20                	je     80105b98 <walkpgdir+0x6a>
    memset(pgtab, 0, PGSIZE);
80105b78:	83 ec 04             	sub    $0x4,%esp
80105b7b:	68 00 10 00 00       	push   $0x1000
80105b80:	6a 00                	push   $0x0
80105b82:	50                   	push   %eax
80105b83:	e8 df df ff ff       	call   80103b67 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80105b88:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80105b8e:	83 c8 07             	or     $0x7,%eax
80105b91:	89 07                	mov    %eax,(%edi)
80105b93:	83 c4 10             	add    $0x10,%esp
80105b96:	eb bd                	jmp    80105b55 <walkpgdir+0x27>
      return 0;
80105b98:	b8 00 00 00 00       	mov    $0x0,%eax
80105b9d:	eb c2                	jmp    80105b61 <walkpgdir+0x33>

80105b9f <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80105b9f:	55                   	push   %ebp
80105ba0:	89 e5                	mov    %esp,%ebp
80105ba2:	57                   	push   %edi
80105ba3:	56                   	push   %esi
80105ba4:	53                   	push   %ebx
80105ba5:	83 ec 1c             	sub    $0x1c,%esp
80105ba8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105bab:	8b 75 08             	mov    0x8(%ebp),%esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80105bae:	89 d3                	mov    %edx,%ebx
80105bb0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80105bb6:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
80105bba:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105bc0:	b9 01 00 00 00       	mov    $0x1,%ecx
80105bc5:	89 da                	mov    %ebx,%edx
80105bc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105bca:	e8 5f ff ff ff       	call   80105b2e <walkpgdir>
80105bcf:	85 c0                	test   %eax,%eax
80105bd1:	74 2e                	je     80105c01 <mappages+0x62>
      return -1;
    if(*pte & PTE_P)
80105bd3:	f6 00 01             	testb  $0x1,(%eax)
80105bd6:	75 1c                	jne    80105bf4 <mappages+0x55>
      panic("remap");
    *pte = pa | perm | PTE_P;
80105bd8:	89 f2                	mov    %esi,%edx
80105bda:	0b 55 0c             	or     0xc(%ebp),%edx
80105bdd:	83 ca 01             	or     $0x1,%edx
80105be0:	89 10                	mov    %edx,(%eax)
    if(a == last)
80105be2:	39 fb                	cmp    %edi,%ebx
80105be4:	74 28                	je     80105c0e <mappages+0x6f>
      break;
    a += PGSIZE;
80105be6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
80105bec:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105bf2:	eb cc                	jmp    80105bc0 <mappages+0x21>
      panic("remap");
80105bf4:	83 ec 0c             	sub    $0xc,%esp
80105bf7:	68 50 6e 10 80       	push   $0x80106e50
80105bfc:	e8 40 a7 ff ff       	call   80100341 <panic>
      return -1;
80105c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80105c06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c09:	5b                   	pop    %ebx
80105c0a:	5e                   	pop    %esi
80105c0b:	5f                   	pop    %edi
80105c0c:	5d                   	pop    %ebp
80105c0d:	c3                   	ret    
  return 0;
80105c0e:	b8 00 00 00 00       	mov    $0x0,%eax
80105c13:	eb f1                	jmp    80105c06 <mappages+0x67>

80105c15 <seginit>:
{
80105c15:	55                   	push   %ebp
80105c16:	89 e5                	mov    %esp,%ebp
80105c18:	57                   	push   %edi
80105c19:	56                   	push   %esi
80105c1a:	53                   	push   %ebx
80105c1b:	83 ec 2c             	sub    $0x2c,%esp
  c = &cpus[cpuid()];
80105c1e:	e8 c5 d4 ff ff       	call   801030e8 <cpuid>
80105c23:	89 c3                	mov    %eax,%ebx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80105c25:	8d 14 80             	lea    (%eax,%eax,4),%edx
80105c28:	8d 0c 12             	lea    (%edx,%edx,1),%ecx
80105c2b:	8d 04 01             	lea    (%ecx,%eax,1),%eax
80105c2e:	c1 e0 04             	shl    $0x4,%eax
80105c31:	66 c7 80 18 08 11 80 	movw   $0xffff,-0x7feef7e8(%eax)
80105c38:	ff ff 
80105c3a:	66 c7 80 1a 08 11 80 	movw   $0x0,-0x7feef7e6(%eax)
80105c41:	00 00 
80105c43:	c6 80 1c 08 11 80 00 	movb   $0x0,-0x7feef7e4(%eax)
80105c4a:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
80105c4d:	01 d9                	add    %ebx,%ecx
80105c4f:	c1 e1 04             	shl    $0x4,%ecx
80105c52:	0f b6 b1 1d 08 11 80 	movzbl -0x7feef7e3(%ecx),%esi
80105c59:	83 e6 f0             	and    $0xfffffff0,%esi
80105c5c:	89 f7                	mov    %esi,%edi
80105c5e:	83 cf 0a             	or     $0xa,%edi
80105c61:	89 fa                	mov    %edi,%edx
80105c63:	88 91 1d 08 11 80    	mov    %dl,-0x7feef7e3(%ecx)
80105c69:	83 ce 1a             	or     $0x1a,%esi
80105c6c:	89 f2                	mov    %esi,%edx
80105c6e:	88 91 1d 08 11 80    	mov    %dl,-0x7feef7e3(%ecx)
80105c74:	83 e6 9f             	and    $0xffffff9f,%esi
80105c77:	89 f2                	mov    %esi,%edx
80105c79:	88 91 1d 08 11 80    	mov    %dl,-0x7feef7e3(%ecx)
80105c7f:	83 ce 80             	or     $0xffffff80,%esi
80105c82:	89 f2                	mov    %esi,%edx
80105c84:	88 91 1d 08 11 80    	mov    %dl,-0x7feef7e3(%ecx)
80105c8a:	0f b6 b1 1e 08 11 80 	movzbl -0x7feef7e2(%ecx),%esi
80105c91:	83 ce 0f             	or     $0xf,%esi
80105c94:	89 f2                	mov    %esi,%edx
80105c96:	88 91 1e 08 11 80    	mov    %dl,-0x7feef7e2(%ecx)
80105c9c:	89 f7                	mov    %esi,%edi
80105c9e:	83 e7 ef             	and    $0xffffffef,%edi
80105ca1:	89 fa                	mov    %edi,%edx
80105ca3:	88 91 1e 08 11 80    	mov    %dl,-0x7feef7e2(%ecx)
80105ca9:	83 e6 cf             	and    $0xffffffcf,%esi
80105cac:	89 f2                	mov    %esi,%edx
80105cae:	88 91 1e 08 11 80    	mov    %dl,-0x7feef7e2(%ecx)
80105cb4:	89 f7                	mov    %esi,%edi
80105cb6:	83 cf 40             	or     $0x40,%edi
80105cb9:	89 fa                	mov    %edi,%edx
80105cbb:	88 91 1e 08 11 80    	mov    %dl,-0x7feef7e2(%ecx)
80105cc1:	83 ce c0             	or     $0xffffffc0,%esi
80105cc4:	89 f2                	mov    %esi,%edx
80105cc6:	88 91 1e 08 11 80    	mov    %dl,-0x7feef7e2(%ecx)
80105ccc:	c6 80 1f 08 11 80 00 	movb   $0x0,-0x7feef7e1(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80105cd3:	66 c7 80 20 08 11 80 	movw   $0xffff,-0x7feef7e0(%eax)
80105cda:	ff ff 
80105cdc:	66 c7 80 22 08 11 80 	movw   $0x0,-0x7feef7de(%eax)
80105ce3:	00 00 
80105ce5:	c6 80 24 08 11 80 00 	movb   $0x0,-0x7feef7dc(%eax)
80105cec:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105cef:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80105cf2:	c1 e1 04             	shl    $0x4,%ecx
80105cf5:	0f b6 b1 25 08 11 80 	movzbl -0x7feef7db(%ecx),%esi
80105cfc:	83 e6 f0             	and    $0xfffffff0,%esi
80105cff:	89 f7                	mov    %esi,%edi
80105d01:	83 cf 02             	or     $0x2,%edi
80105d04:	89 fa                	mov    %edi,%edx
80105d06:	88 91 25 08 11 80    	mov    %dl,-0x7feef7db(%ecx)
80105d0c:	83 ce 12             	or     $0x12,%esi
80105d0f:	89 f2                	mov    %esi,%edx
80105d11:	88 91 25 08 11 80    	mov    %dl,-0x7feef7db(%ecx)
80105d17:	83 e6 9f             	and    $0xffffff9f,%esi
80105d1a:	89 f2                	mov    %esi,%edx
80105d1c:	88 91 25 08 11 80    	mov    %dl,-0x7feef7db(%ecx)
80105d22:	83 ce 80             	or     $0xffffff80,%esi
80105d25:	89 f2                	mov    %esi,%edx
80105d27:	88 91 25 08 11 80    	mov    %dl,-0x7feef7db(%ecx)
80105d2d:	0f b6 b1 26 08 11 80 	movzbl -0x7feef7da(%ecx),%esi
80105d34:	83 ce 0f             	or     $0xf,%esi
80105d37:	89 f2                	mov    %esi,%edx
80105d39:	88 91 26 08 11 80    	mov    %dl,-0x7feef7da(%ecx)
80105d3f:	89 f7                	mov    %esi,%edi
80105d41:	83 e7 ef             	and    $0xffffffef,%edi
80105d44:	89 fa                	mov    %edi,%edx
80105d46:	88 91 26 08 11 80    	mov    %dl,-0x7feef7da(%ecx)
80105d4c:	83 e6 cf             	and    $0xffffffcf,%esi
80105d4f:	89 f2                	mov    %esi,%edx
80105d51:	88 91 26 08 11 80    	mov    %dl,-0x7feef7da(%ecx)
80105d57:	89 f7                	mov    %esi,%edi
80105d59:	83 cf 40             	or     $0x40,%edi
80105d5c:	89 fa                	mov    %edi,%edx
80105d5e:	88 91 26 08 11 80    	mov    %dl,-0x7feef7da(%ecx)
80105d64:	83 ce c0             	or     $0xffffffc0,%esi
80105d67:	89 f2                	mov    %esi,%edx
80105d69:	88 91 26 08 11 80    	mov    %dl,-0x7feef7da(%ecx)
80105d6f:	c6 80 27 08 11 80 00 	movb   $0x0,-0x7feef7d9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80105d76:	66 c7 80 28 08 11 80 	movw   $0xffff,-0x7feef7d8(%eax)
80105d7d:	ff ff 
80105d7f:	66 c7 80 2a 08 11 80 	movw   $0x0,-0x7feef7d6(%eax)
80105d86:	00 00 
80105d88:	c6 80 2c 08 11 80 00 	movb   $0x0,-0x7feef7d4(%eax)
80105d8f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105d92:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80105d95:	c1 e1 04             	shl    $0x4,%ecx
80105d98:	0f b6 b1 2d 08 11 80 	movzbl -0x7feef7d3(%ecx),%esi
80105d9f:	83 e6 f0             	and    $0xfffffff0,%esi
80105da2:	89 f7                	mov    %esi,%edi
80105da4:	83 cf 0a             	or     $0xa,%edi
80105da7:	89 fa                	mov    %edi,%edx
80105da9:	88 91 2d 08 11 80    	mov    %dl,-0x7feef7d3(%ecx)
80105daf:	89 f7                	mov    %esi,%edi
80105db1:	83 cf 1a             	or     $0x1a,%edi
80105db4:	89 fa                	mov    %edi,%edx
80105db6:	88 91 2d 08 11 80    	mov    %dl,-0x7feef7d3(%ecx)
80105dbc:	83 ce 7a             	or     $0x7a,%esi
80105dbf:	89 f2                	mov    %esi,%edx
80105dc1:	88 91 2d 08 11 80    	mov    %dl,-0x7feef7d3(%ecx)
80105dc7:	c6 81 2d 08 11 80 fa 	movb   $0xfa,-0x7feef7d3(%ecx)
80105dce:	0f b6 b1 2e 08 11 80 	movzbl -0x7feef7d2(%ecx),%esi
80105dd5:	83 ce 0f             	or     $0xf,%esi
80105dd8:	89 f2                	mov    %esi,%edx
80105dda:	88 91 2e 08 11 80    	mov    %dl,-0x7feef7d2(%ecx)
80105de0:	89 f7                	mov    %esi,%edi
80105de2:	83 e7 ef             	and    $0xffffffef,%edi
80105de5:	89 fa                	mov    %edi,%edx
80105de7:	88 91 2e 08 11 80    	mov    %dl,-0x7feef7d2(%ecx)
80105ded:	83 e6 cf             	and    $0xffffffcf,%esi
80105df0:	89 f2                	mov    %esi,%edx
80105df2:	88 91 2e 08 11 80    	mov    %dl,-0x7feef7d2(%ecx)
80105df8:	89 f7                	mov    %esi,%edi
80105dfa:	83 cf 40             	or     $0x40,%edi
80105dfd:	89 fa                	mov    %edi,%edx
80105dff:	88 91 2e 08 11 80    	mov    %dl,-0x7feef7d2(%ecx)
80105e05:	83 ce c0             	or     $0xffffffc0,%esi
80105e08:	89 f2                	mov    %esi,%edx
80105e0a:	88 91 2e 08 11 80    	mov    %dl,-0x7feef7d2(%ecx)
80105e10:	c6 80 2f 08 11 80 00 	movb   $0x0,-0x7feef7d1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80105e17:	66 c7 80 30 08 11 80 	movw   $0xffff,-0x7feef7d0(%eax)
80105e1e:	ff ff 
80105e20:	66 c7 80 32 08 11 80 	movw   $0x0,-0x7feef7ce(%eax)
80105e27:	00 00 
80105e29:	c6 80 34 08 11 80 00 	movb   $0x0,-0x7feef7cc(%eax)
80105e30:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105e33:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
80105e36:	c1 e1 04             	shl    $0x4,%ecx
80105e39:	0f b6 b1 35 08 11 80 	movzbl -0x7feef7cb(%ecx),%esi
80105e40:	83 e6 f0             	and    $0xfffffff0,%esi
80105e43:	89 f7                	mov    %esi,%edi
80105e45:	83 cf 02             	or     $0x2,%edi
80105e48:	89 fa                	mov    %edi,%edx
80105e4a:	88 91 35 08 11 80    	mov    %dl,-0x7feef7cb(%ecx)
80105e50:	89 f7                	mov    %esi,%edi
80105e52:	83 cf 12             	or     $0x12,%edi
80105e55:	89 fa                	mov    %edi,%edx
80105e57:	88 91 35 08 11 80    	mov    %dl,-0x7feef7cb(%ecx)
80105e5d:	83 ce 72             	or     $0x72,%esi
80105e60:	89 f2                	mov    %esi,%edx
80105e62:	88 91 35 08 11 80    	mov    %dl,-0x7feef7cb(%ecx)
80105e68:	c6 81 35 08 11 80 f2 	movb   $0xf2,-0x7feef7cb(%ecx)
80105e6f:	0f b6 b1 36 08 11 80 	movzbl -0x7feef7ca(%ecx),%esi
80105e76:	83 ce 0f             	or     $0xf,%esi
80105e79:	89 f2                	mov    %esi,%edx
80105e7b:	88 91 36 08 11 80    	mov    %dl,-0x7feef7ca(%ecx)
80105e81:	89 f7                	mov    %esi,%edi
80105e83:	83 e7 ef             	and    $0xffffffef,%edi
80105e86:	89 fa                	mov    %edi,%edx
80105e88:	88 91 36 08 11 80    	mov    %dl,-0x7feef7ca(%ecx)
80105e8e:	83 e6 cf             	and    $0xffffffcf,%esi
80105e91:	89 f2                	mov    %esi,%edx
80105e93:	88 91 36 08 11 80    	mov    %dl,-0x7feef7ca(%ecx)
80105e99:	89 f7                	mov    %esi,%edi
80105e9b:	83 cf 40             	or     $0x40,%edi
80105e9e:	89 fa                	mov    %edi,%edx
80105ea0:	88 91 36 08 11 80    	mov    %dl,-0x7feef7ca(%ecx)
80105ea6:	83 ce c0             	or     $0xffffffc0,%esi
80105ea9:	89 f2                	mov    %esi,%edx
80105eab:	88 91 36 08 11 80    	mov    %dl,-0x7feef7ca(%ecx)
80105eb1:	c6 80 37 08 11 80 00 	movb   $0x0,-0x7feef7c9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80105eb8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105ebb:	01 da                	add    %ebx,%edx
80105ebd:	c1 e2 04             	shl    $0x4,%edx
80105ec0:	81 c2 10 08 11 80    	add    $0x80110810,%edx
  pd[0] = size-1;
80105ec6:	66 c7 45 e2 2f 00    	movw   $0x2f,-0x1e(%ebp)
  pd[1] = (uint)p;
80105ecc:	66 89 55 e4          	mov    %dx,-0x1c(%ebp)
  pd[2] = (uint)p >> 16;
80105ed0:	c1 ea 10             	shr    $0x10,%edx
80105ed3:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80105ed7:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105eda:	0f 01 10             	lgdtl  (%eax)
}
80105edd:	83 c4 2c             	add    $0x2c,%esp
80105ee0:	5b                   	pop    %ebx
80105ee1:	5e                   	pop    %esi
80105ee2:	5f                   	pop    %edi
80105ee3:	5d                   	pop    %ebp
80105ee4:	c3                   	ret    

80105ee5 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80105ee5:	a1 c4 34 11 80       	mov    0x801134c4,%eax
80105eea:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80105eef:	0f 22 d8             	mov    %eax,%cr3
}
80105ef2:	c3                   	ret    

80105ef3 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80105ef3:	55                   	push   %ebp
80105ef4:	89 e5                	mov    %esp,%ebp
80105ef6:	57                   	push   %edi
80105ef7:	56                   	push   %esi
80105ef8:	53                   	push   %ebx
80105ef9:	83 ec 1c             	sub    $0x1c,%esp
80105efc:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80105eff:	85 f6                	test   %esi,%esi
80105f01:	0f 84 21 01 00 00    	je     80106028 <switchuvm+0x135>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80105f07:	83 7e 08 00          	cmpl   $0x0,0x8(%esi)
80105f0b:	0f 84 24 01 00 00    	je     80106035 <switchuvm+0x142>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80105f11:	83 7e 04 00          	cmpl   $0x0,0x4(%esi)
80105f15:	0f 84 27 01 00 00    	je     80106042 <switchuvm+0x14f>
    panic("switchuvm: no pgdir");

  pushcli();
80105f1b:	e8 c1 da ff ff       	call   801039e1 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80105f20:	e8 5f d1 ff ff       	call   80103084 <mycpu>
80105f25:	89 c3                	mov    %eax,%ebx
80105f27:	e8 58 d1 ff ff       	call   80103084 <mycpu>
80105f2c:	8d 78 08             	lea    0x8(%eax),%edi
80105f2f:	e8 50 d1 ff ff       	call   80103084 <mycpu>
80105f34:	83 c0 08             	add    $0x8,%eax
80105f37:	c1 e8 10             	shr    $0x10,%eax
80105f3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105f3d:	e8 42 d1 ff ff       	call   80103084 <mycpu>
80105f42:	83 c0 08             	add    $0x8,%eax
80105f45:	c1 e8 18             	shr    $0x18,%eax
80105f48:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80105f4f:	67 00 
80105f51:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80105f58:	8a 4d e4             	mov    -0x1c(%ebp),%cl
80105f5b:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80105f61:	8a 93 9d 00 00 00    	mov    0x9d(%ebx),%dl
80105f67:	83 e2 f0             	and    $0xfffffff0,%edx
80105f6a:	88 d1                	mov    %dl,%cl
80105f6c:	83 c9 09             	or     $0x9,%ecx
80105f6f:	88 8b 9d 00 00 00    	mov    %cl,0x9d(%ebx)
80105f75:	83 ca 19             	or     $0x19,%edx
80105f78:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
80105f7e:	83 e2 9f             	and    $0xffffff9f,%edx
80105f81:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
80105f87:	83 ca 80             	or     $0xffffff80,%edx
80105f8a:	88 93 9d 00 00 00    	mov    %dl,0x9d(%ebx)
80105f90:	8a 93 9e 00 00 00    	mov    0x9e(%ebx),%dl
80105f96:	88 d1                	mov    %dl,%cl
80105f98:	83 e1 f0             	and    $0xfffffff0,%ecx
80105f9b:	88 8b 9e 00 00 00    	mov    %cl,0x9e(%ebx)
80105fa1:	88 d1                	mov    %dl,%cl
80105fa3:	83 e1 e0             	and    $0xffffffe0,%ecx
80105fa6:	88 8b 9e 00 00 00    	mov    %cl,0x9e(%ebx)
80105fac:	83 e2 c0             	and    $0xffffffc0,%edx
80105faf:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80105fb5:	83 ca 40             	or     $0x40,%edx
80105fb8:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80105fbe:	83 e2 7f             	and    $0x7f,%edx
80105fc1:	88 93 9e 00 00 00    	mov    %dl,0x9e(%ebx)
80105fc7:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80105fcd:	e8 b2 d0 ff ff       	call   80103084 <mycpu>
80105fd2:	8a 90 9d 00 00 00    	mov    0x9d(%eax),%dl
80105fd8:	83 e2 ef             	and    $0xffffffef,%edx
80105fdb:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80105fe1:	e8 9e d0 ff ff       	call   80103084 <mycpu>
80105fe6:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80105fec:	8b 5e 08             	mov    0x8(%esi),%ebx
80105fef:	e8 90 d0 ff ff       	call   80103084 <mycpu>
80105ff4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105ffa:	89 58 0c             	mov    %ebx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80105ffd:	e8 82 d0 ff ff       	call   80103084 <mycpu>
80106002:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106008:	b8 28 00 00 00       	mov    $0x28,%eax
8010600d:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106010:	8b 46 04             	mov    0x4(%esi),%eax
80106013:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106018:	0f 22 d8             	mov    %eax,%cr3
  popcli();
8010601b:	e8 fc d9 ff ff       	call   80103a1c <popcli>
}
80106020:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106023:	5b                   	pop    %ebx
80106024:	5e                   	pop    %esi
80106025:	5f                   	pop    %edi
80106026:	5d                   	pop    %ebp
80106027:	c3                   	ret    
    panic("switchuvm: no process");
80106028:	83 ec 0c             	sub    $0xc,%esp
8010602b:	68 56 6e 10 80       	push   $0x80106e56
80106030:	e8 0c a3 ff ff       	call   80100341 <panic>
    panic("switchuvm: no kstack");
80106035:	83 ec 0c             	sub    $0xc,%esp
80106038:	68 6c 6e 10 80       	push   $0x80106e6c
8010603d:	e8 ff a2 ff ff       	call   80100341 <panic>
    panic("switchuvm: no pgdir");
80106042:	83 ec 0c             	sub    $0xc,%esp
80106045:	68 81 6e 10 80       	push   $0x80106e81
8010604a:	e8 f2 a2 ff ff       	call   80100341 <panic>

8010604f <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010604f:	55                   	push   %ebp
80106050:	89 e5                	mov    %esp,%ebp
80106052:	56                   	push   %esi
80106053:	53                   	push   %ebx
80106054:	8b 75 10             	mov    0x10(%ebp),%esi
  char *mem;

  if(sz >= PGSIZE)
80106057:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010605d:	77 4c                	ja     801060ab <inituvm+0x5c>
    panic("inituvm: more than a page");
  mem = kalloc();
8010605f:	e8 c3 bf ff ff       	call   80102027 <kalloc>
80106064:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106066:	83 ec 04             	sub    $0x4,%esp
80106069:	68 00 10 00 00       	push   $0x1000
8010606e:	6a 00                	push   $0x0
80106070:	50                   	push   %eax
80106071:	e8 f1 da ff ff       	call   80103b67 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106076:	83 c4 08             	add    $0x8,%esp
80106079:	6a 06                	push   $0x6
8010607b:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106081:	50                   	push   %eax
80106082:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106087:	ba 00 00 00 00       	mov    $0x0,%edx
8010608c:	8b 45 08             	mov    0x8(%ebp),%eax
8010608f:	e8 0b fb ff ff       	call   80105b9f <mappages>
  memmove(mem, init, sz);
80106094:	83 c4 0c             	add    $0xc,%esp
80106097:	56                   	push   %esi
80106098:	ff 75 0c             	push   0xc(%ebp)
8010609b:	53                   	push   %ebx
8010609c:	e8 3c db ff ff       	call   80103bdd <memmove>
}
801060a1:	83 c4 10             	add    $0x10,%esp
801060a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060a7:	5b                   	pop    %ebx
801060a8:	5e                   	pop    %esi
801060a9:	5d                   	pop    %ebp
801060aa:	c3                   	ret    
    panic("inituvm: more than a page");
801060ab:	83 ec 0c             	sub    $0xc,%esp
801060ae:	68 95 6e 10 80       	push   $0x80106e95
801060b3:	e8 89 a2 ff ff       	call   80100341 <panic>

801060b8 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801060b8:	55                   	push   %ebp
801060b9:	89 e5                	mov    %esp,%ebp
801060bb:	57                   	push   %edi
801060bc:	56                   	push   %esi
801060bd:	53                   	push   %ebx
801060be:	83 ec 0c             	sub    $0xc,%esp
801060c1:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801060c4:	89 fb                	mov    %edi,%ebx
801060c6:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
801060cc:	74 3c                	je     8010610a <loaduvm+0x52>
    panic("loaduvm: addr must be page aligned");
801060ce:	83 ec 0c             	sub    $0xc,%esp
801060d1:	68 50 6f 10 80       	push   $0x80106f50
801060d6:	e8 66 a2 ff ff       	call   80100341 <panic>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801060db:	83 ec 0c             	sub    $0xc,%esp
801060de:	68 af 6e 10 80       	push   $0x80106eaf
801060e3:	e8 59 a2 ff ff       	call   80100341 <panic>
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801060e8:	05 00 00 00 80       	add    $0x80000000,%eax
801060ed:	56                   	push   %esi
801060ee:	89 da                	mov    %ebx,%edx
801060f0:	03 55 14             	add    0x14(%ebp),%edx
801060f3:	52                   	push   %edx
801060f4:	50                   	push   %eax
801060f5:	ff 75 10             	push   0x10(%ebp)
801060f8:	e8 f6 b5 ff ff       	call   801016f3 <readi>
801060fd:	83 c4 10             	add    $0x10,%esp
80106100:	39 f0                	cmp    %esi,%eax
80106102:	75 47                	jne    8010614b <loaduvm+0x93>
  for(i = 0; i < sz; i += PGSIZE){
80106104:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010610a:	3b 5d 18             	cmp    0x18(%ebp),%ebx
8010610d:	73 2f                	jae    8010613e <loaduvm+0x86>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010610f:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
80106112:	b9 00 00 00 00       	mov    $0x0,%ecx
80106117:	8b 45 08             	mov    0x8(%ebp),%eax
8010611a:	e8 0f fa ff ff       	call   80105b2e <walkpgdir>
8010611f:	85 c0                	test   %eax,%eax
80106121:	74 b8                	je     801060db <loaduvm+0x23>
    pa = PTE_ADDR(*pte);
80106123:	8b 00                	mov    (%eax),%eax
80106125:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010612a:	8b 75 18             	mov    0x18(%ebp),%esi
8010612d:	29 de                	sub    %ebx,%esi
8010612f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106135:	76 b1                	jbe    801060e8 <loaduvm+0x30>
      n = PGSIZE;
80106137:	be 00 10 00 00       	mov    $0x1000,%esi
8010613c:	eb aa                	jmp    801060e8 <loaduvm+0x30>
      return -1;
  }
  return 0;
8010613e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106143:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106146:	5b                   	pop    %ebx
80106147:	5e                   	pop    %esi
80106148:	5f                   	pop    %edi
80106149:	5d                   	pop    %ebp
8010614a:	c3                   	ret    
      return -1;
8010614b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106150:	eb f1                	jmp    80106143 <loaduvm+0x8b>

80106152 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106152:	55                   	push   %ebp
80106153:	89 e5                	mov    %esp,%ebp
80106155:	57                   	push   %edi
80106156:	56                   	push   %esi
80106157:	53                   	push   %ebx
80106158:	83 ec 0c             	sub    $0xc,%esp
8010615b:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010615e:	39 7d 10             	cmp    %edi,0x10(%ebp)
80106161:	73 11                	jae    80106174 <deallocuvm+0x22>
    return oldsz;

  a = PGROUNDUP(newsz);
80106163:	8b 45 10             	mov    0x10(%ebp),%eax
80106166:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010616c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106172:	eb 17                	jmp    8010618b <deallocuvm+0x39>
    return oldsz;
80106174:	89 f8                	mov    %edi,%eax
80106176:	eb 62                	jmp    801061da <deallocuvm+0x88>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106178:	c1 eb 16             	shr    $0x16,%ebx
8010617b:	43                   	inc    %ebx
8010617c:	c1 e3 16             	shl    $0x16,%ebx
8010617f:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106185:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010618b:	39 fb                	cmp    %edi,%ebx
8010618d:	73 48                	jae    801061d7 <deallocuvm+0x85>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010618f:	b9 00 00 00 00       	mov    $0x0,%ecx
80106194:	89 da                	mov    %ebx,%edx
80106196:	8b 45 08             	mov    0x8(%ebp),%eax
80106199:	e8 90 f9 ff ff       	call   80105b2e <walkpgdir>
8010619e:	89 c6                	mov    %eax,%esi
    if(!pte)
801061a0:	85 c0                	test   %eax,%eax
801061a2:	74 d4                	je     80106178 <deallocuvm+0x26>
    else if((*pte & PTE_P) != 0){
801061a4:	8b 00                	mov    (%eax),%eax
801061a6:	a8 01                	test   $0x1,%al
801061a8:	74 db                	je     80106185 <deallocuvm+0x33>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801061aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801061af:	74 19                	je     801061ca <deallocuvm+0x78>
        panic("kfree");
      char *v = P2V(pa);
801061b1:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801061b6:	83 ec 0c             	sub    $0xc,%esp
801061b9:	50                   	push   %eax
801061ba:	e8 51 bd ff ff       	call   80101f10 <kfree>
      *pte = 0;
801061bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801061c5:	83 c4 10             	add    $0x10,%esp
801061c8:	eb bb                	jmp    80106185 <deallocuvm+0x33>
        panic("kfree");
801061ca:	83 ec 0c             	sub    $0xc,%esp
801061cd:	68 06 68 10 80       	push   $0x80106806
801061d2:	e8 6a a1 ff ff       	call   80100341 <panic>
    }
  }
  return newsz;
801061d7:	8b 45 10             	mov    0x10(%ebp),%eax
}
801061da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061dd:	5b                   	pop    %ebx
801061de:	5e                   	pop    %esi
801061df:	5f                   	pop    %edi
801061e0:	5d                   	pop    %ebp
801061e1:	c3                   	ret    

801061e2 <allocuvm>:
{
801061e2:	55                   	push   %ebp
801061e3:	89 e5                	mov    %esp,%ebp
801061e5:	57                   	push   %edi
801061e6:	56                   	push   %esi
801061e7:	53                   	push   %ebx
801061e8:	83 ec 1c             	sub    $0x1c,%esp
801061eb:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
801061ee:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801061f1:	85 ff                	test   %edi,%edi
801061f3:	0f 88 c1 00 00 00    	js     801062ba <allocuvm+0xd8>
  if(newsz < oldsz)
801061f9:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801061fc:	72 5c                	jb     8010625a <allocuvm+0x78>
  a = PGROUNDUP(oldsz);
801061fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80106201:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106207:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
8010620d:	39 fe                	cmp    %edi,%esi
8010620f:	0f 83 ac 00 00 00    	jae    801062c1 <allocuvm+0xdf>
    mem = kalloc();
80106215:	e8 0d be ff ff       	call   80102027 <kalloc>
8010621a:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
8010621c:	85 c0                	test   %eax,%eax
8010621e:	74 42                	je     80106262 <allocuvm+0x80>
    memset(mem, 0, PGSIZE);
80106220:	83 ec 04             	sub    $0x4,%esp
80106223:	68 00 10 00 00       	push   $0x1000
80106228:	6a 00                	push   $0x0
8010622a:	50                   	push   %eax
8010622b:	e8 37 d9 ff ff       	call   80103b67 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106230:	83 c4 08             	add    $0x8,%esp
80106233:	6a 06                	push   $0x6
80106235:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010623b:	50                   	push   %eax
8010623c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106241:	89 f2                	mov    %esi,%edx
80106243:	8b 45 08             	mov    0x8(%ebp),%eax
80106246:	e8 54 f9 ff ff       	call   80105b9f <mappages>
8010624b:	83 c4 10             	add    $0x10,%esp
8010624e:	85 c0                	test   %eax,%eax
80106250:	78 38                	js     8010628a <allocuvm+0xa8>
  for(; a < newsz; a += PGSIZE){
80106252:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106258:	eb b3                	jmp    8010620d <allocuvm+0x2b>
    return oldsz;
8010625a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010625d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106260:	eb 5f                	jmp    801062c1 <allocuvm+0xdf>
      cprintf("allocuvm out of memory\n");
80106262:	83 ec 0c             	sub    $0xc,%esp
80106265:	68 cd 6e 10 80       	push   $0x80106ecd
8010626a:	e8 6b a3 ff ff       	call   801005da <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
8010626f:	83 c4 0c             	add    $0xc,%esp
80106272:	ff 75 0c             	push   0xc(%ebp)
80106275:	57                   	push   %edi
80106276:	ff 75 08             	push   0x8(%ebp)
80106279:	e8 d4 fe ff ff       	call   80106152 <deallocuvm>
      return 0;
8010627e:	83 c4 10             	add    $0x10,%esp
80106281:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80106288:	eb 37                	jmp    801062c1 <allocuvm+0xdf>
      cprintf("allocuvm out of memory (2)\n");
8010628a:	83 ec 0c             	sub    $0xc,%esp
8010628d:	68 e5 6e 10 80       	push   $0x80106ee5
80106292:	e8 43 a3 ff ff       	call   801005da <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106297:	83 c4 0c             	add    $0xc,%esp
8010629a:	ff 75 0c             	push   0xc(%ebp)
8010629d:	57                   	push   %edi
8010629e:	ff 75 08             	push   0x8(%ebp)
801062a1:	e8 ac fe ff ff       	call   80106152 <deallocuvm>
      kfree(mem);
801062a6:	89 1c 24             	mov    %ebx,(%esp)
801062a9:	e8 62 bc ff ff       	call   80101f10 <kfree>
      return 0;
801062ae:	83 c4 10             	add    $0x10,%esp
801062b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801062b8:	eb 07                	jmp    801062c1 <allocuvm+0xdf>
    return 0;
801062ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801062c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062c7:	5b                   	pop    %ebx
801062c8:	5e                   	pop    %esi
801062c9:	5f                   	pop    %edi
801062ca:	5d                   	pop    %ebp
801062cb:	c3                   	ret    

801062cc <freevm>:

// Free a page table and all the physical memory pages
// in the user part if dodeallocuvm is not zero
void
freevm(pde_t *pgdir, int dodeallocuvm)
{
801062cc:	55                   	push   %ebp
801062cd:	89 e5                	mov    %esp,%ebp
801062cf:	56                   	push   %esi
801062d0:	53                   	push   %ebx
801062d1:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801062d4:	85 f6                	test   %esi,%esi
801062d6:	74 0d                	je     801062e5 <freevm+0x19>
    panic("freevm: no pgdir");
  if (dodeallocuvm)
801062d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801062dc:	75 14                	jne    801062f2 <freevm+0x26>
{
801062de:	bb 00 00 00 00       	mov    $0x0,%ebx
801062e3:	eb 23                	jmp    80106308 <freevm+0x3c>
    panic("freevm: no pgdir");
801062e5:	83 ec 0c             	sub    $0xc,%esp
801062e8:	68 01 6f 10 80       	push   $0x80106f01
801062ed:	e8 4f a0 ff ff       	call   80100341 <panic>
    deallocuvm(pgdir, KERNBASE, 0);
801062f2:	83 ec 04             	sub    $0x4,%esp
801062f5:	6a 00                	push   $0x0
801062f7:	68 00 00 00 80       	push   $0x80000000
801062fc:	56                   	push   %esi
801062fd:	e8 50 fe ff ff       	call   80106152 <deallocuvm>
80106302:	83 c4 10             	add    $0x10,%esp
80106305:	eb d7                	jmp    801062de <freevm+0x12>
  for(i = 0; i < NPDENTRIES; i++){
80106307:	43                   	inc    %ebx
80106308:	81 fb ff 03 00 00    	cmp    $0x3ff,%ebx
8010630e:	77 1f                	ja     8010632f <freevm+0x63>
    if(pgdir[i] & PTE_P){
80106310:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
80106313:	a8 01                	test   $0x1,%al
80106315:	74 f0                	je     80106307 <freevm+0x3b>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106317:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010631c:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106321:	83 ec 0c             	sub    $0xc,%esp
80106324:	50                   	push   %eax
80106325:	e8 e6 bb ff ff       	call   80101f10 <kfree>
8010632a:	83 c4 10             	add    $0x10,%esp
8010632d:	eb d8                	jmp    80106307 <freevm+0x3b>
    }
  }
  kfree((char*)pgdir);
8010632f:	83 ec 0c             	sub    $0xc,%esp
80106332:	56                   	push   %esi
80106333:	e8 d8 bb ff ff       	call   80101f10 <kfree>
}
80106338:	83 c4 10             	add    $0x10,%esp
8010633b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010633e:	5b                   	pop    %ebx
8010633f:	5e                   	pop    %esi
80106340:	5d                   	pop    %ebp
80106341:	c3                   	ret    

80106342 <setupkvm>:
{
80106342:	55                   	push   %ebp
80106343:	89 e5                	mov    %esp,%ebp
80106345:	56                   	push   %esi
80106346:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106347:	e8 db bc ff ff       	call   80102027 <kalloc>
8010634c:	89 c6                	mov    %eax,%esi
8010634e:	85 c0                	test   %eax,%eax
80106350:	74 57                	je     801063a9 <setupkvm+0x67>
  memset(pgdir, 0, PGSIZE);
80106352:	83 ec 04             	sub    $0x4,%esp
80106355:	68 00 10 00 00       	push   $0x1000
8010635a:	6a 00                	push   $0x0
8010635c:	50                   	push   %eax
8010635d:	e8 05 d8 ff ff       	call   80103b67 <memset>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106362:	83 c4 10             	add    $0x10,%esp
80106365:	bb 20 94 10 80       	mov    $0x80109420,%ebx
8010636a:	81 fb 60 94 10 80    	cmp    $0x80109460,%ebx
80106370:	73 37                	jae    801063a9 <setupkvm+0x67>
                (uint)k->phys_start, k->perm) < 0) {
80106372:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106375:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106378:	29 c1                	sub    %eax,%ecx
8010637a:	83 ec 08             	sub    $0x8,%esp
8010637d:	ff 73 0c             	push   0xc(%ebx)
80106380:	50                   	push   %eax
80106381:	8b 13                	mov    (%ebx),%edx
80106383:	89 f0                	mov    %esi,%eax
80106385:	e8 15 f8 ff ff       	call   80105b9f <mappages>
8010638a:	83 c4 10             	add    $0x10,%esp
8010638d:	85 c0                	test   %eax,%eax
8010638f:	78 05                	js     80106396 <setupkvm+0x54>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106391:	83 c3 10             	add    $0x10,%ebx
80106394:	eb d4                	jmp    8010636a <setupkvm+0x28>
      freevm(pgdir, 0);
80106396:	83 ec 08             	sub    $0x8,%esp
80106399:	6a 00                	push   $0x0
8010639b:	56                   	push   %esi
8010639c:	e8 2b ff ff ff       	call   801062cc <freevm>
      return 0;
801063a1:	83 c4 10             	add    $0x10,%esp
801063a4:	be 00 00 00 00       	mov    $0x0,%esi
}
801063a9:	89 f0                	mov    %esi,%eax
801063ab:	8d 65 f8             	lea    -0x8(%ebp),%esp
801063ae:	5b                   	pop    %ebx
801063af:	5e                   	pop    %esi
801063b0:	5d                   	pop    %ebp
801063b1:	c3                   	ret    

801063b2 <kvmalloc>:
{
801063b2:	55                   	push   %ebp
801063b3:	89 e5                	mov    %esp,%ebp
801063b5:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801063b8:	e8 85 ff ff ff       	call   80106342 <setupkvm>
801063bd:	a3 c4 34 11 80       	mov    %eax,0x801134c4
  switchkvm();
801063c2:	e8 1e fb ff ff       	call   80105ee5 <switchkvm>
}
801063c7:	c9                   	leave  
801063c8:	c3                   	ret    

801063c9 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801063c9:	55                   	push   %ebp
801063ca:	89 e5                	mov    %esp,%ebp
801063cc:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801063cf:	b9 00 00 00 00       	mov    $0x0,%ecx
801063d4:	8b 55 0c             	mov    0xc(%ebp),%edx
801063d7:	8b 45 08             	mov    0x8(%ebp),%eax
801063da:	e8 4f f7 ff ff       	call   80105b2e <walkpgdir>
  if(pte == 0)
801063df:	85 c0                	test   %eax,%eax
801063e1:	74 05                	je     801063e8 <clearpteu+0x1f>
    panic("clearpteu");
  *pte &= ~PTE_U;
801063e3:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801063e6:	c9                   	leave  
801063e7:	c3                   	ret    
    panic("clearpteu");
801063e8:	83 ec 0c             	sub    $0xc,%esp
801063eb:	68 12 6f 10 80       	push   $0x80106f12
801063f0:	e8 4c 9f ff ff       	call   80100341 <panic>

801063f5 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801063f5:	55                   	push   %ebp
801063f6:	89 e5                	mov    %esp,%ebp
801063f8:	57                   	push   %edi
801063f9:	56                   	push   %esi
801063fa:	53                   	push   %ebx
801063fb:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801063fe:	e8 3f ff ff ff       	call   80106342 <setupkvm>
80106403:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106406:	85 c0                	test   %eax,%eax
80106408:	0f 84 c6 00 00 00    	je     801064d4 <copyuvm+0xdf>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010640e:	bb 00 00 00 00       	mov    $0x0,%ebx
80106413:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
80106416:	0f 83 b8 00 00 00    	jae    801064d4 <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010641c:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010641f:	b9 00 00 00 00       	mov    $0x0,%ecx
80106424:	89 da                	mov    %ebx,%edx
80106426:	8b 45 08             	mov    0x8(%ebp),%eax
80106429:	e8 00 f7 ff ff       	call   80105b2e <walkpgdir>
8010642e:	85 c0                	test   %eax,%eax
80106430:	74 65                	je     80106497 <copyuvm+0xa2>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106432:	8b 00                	mov    (%eax),%eax
80106434:	a8 01                	test   $0x1,%al
80106436:	74 6c                	je     801064a4 <copyuvm+0xaf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106438:	89 c6                	mov    %eax,%esi
8010643a:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    flags = PTE_FLAGS(*pte);
80106440:	25 ff 0f 00 00       	and    $0xfff,%eax
80106445:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if((mem = kalloc()) == 0)
80106448:	e8 da bb ff ff       	call   80102027 <kalloc>
8010644d:	89 c7                	mov    %eax,%edi
8010644f:	85 c0                	test   %eax,%eax
80106451:	74 6a                	je     801064bd <copyuvm+0xc8>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106453:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106459:	83 ec 04             	sub    $0x4,%esp
8010645c:	68 00 10 00 00       	push   $0x1000
80106461:	56                   	push   %esi
80106462:	50                   	push   %eax
80106463:	e8 75 d7 ff ff       	call   80103bdd <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106468:	83 c4 08             	add    $0x8,%esp
8010646b:	ff 75 e0             	push   -0x20(%ebp)
8010646e:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
80106474:	50                   	push   %eax
80106475:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010647a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010647d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106480:	e8 1a f7 ff ff       	call   80105b9f <mappages>
80106485:	83 c4 10             	add    $0x10,%esp
80106488:	85 c0                	test   %eax,%eax
8010648a:	78 25                	js     801064b1 <copyuvm+0xbc>
  for(i = 0; i < sz; i += PGSIZE){
8010648c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106492:	e9 7c ff ff ff       	jmp    80106413 <copyuvm+0x1e>
      panic("copyuvm: pte should exist");
80106497:	83 ec 0c             	sub    $0xc,%esp
8010649a:	68 1c 6f 10 80       	push   $0x80106f1c
8010649f:	e8 9d 9e ff ff       	call   80100341 <panic>
      panic("copyuvm: page not present");
801064a4:	83 ec 0c             	sub    $0xc,%esp
801064a7:	68 36 6f 10 80       	push   $0x80106f36
801064ac:	e8 90 9e ff ff       	call   80100341 <panic>
      kfree(mem);
801064b1:	83 ec 0c             	sub    $0xc,%esp
801064b4:	57                   	push   %edi
801064b5:	e8 56 ba ff ff       	call   80101f10 <kfree>
      goto bad;
801064ba:	83 c4 10             	add    $0x10,%esp
    }
  }
  return d;

bad:
  freevm(d, 1);
801064bd:	83 ec 08             	sub    $0x8,%esp
801064c0:	6a 01                	push   $0x1
801064c2:	ff 75 dc             	push   -0x24(%ebp)
801064c5:	e8 02 fe ff ff       	call   801062cc <freevm>
  return 0;
801064ca:	83 c4 10             	add    $0x10,%esp
801064cd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
}
801064d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801064d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064da:	5b                   	pop    %ebx
801064db:	5e                   	pop    %esi
801064dc:	5f                   	pop    %edi
801064dd:	5d                   	pop    %ebp
801064de:	c3                   	ret    

801064df <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801064df:	55                   	push   %ebp
801064e0:	89 e5                	mov    %esp,%ebp
801064e2:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801064e5:	b9 00 00 00 00       	mov    $0x0,%ecx
801064ea:	8b 55 0c             	mov    0xc(%ebp),%edx
801064ed:	8b 45 08             	mov    0x8(%ebp),%eax
801064f0:	e8 39 f6 ff ff       	call   80105b2e <walkpgdir>
  if((*pte & PTE_P) == 0)
801064f5:	8b 00                	mov    (%eax),%eax
801064f7:	a8 01                	test   $0x1,%al
801064f9:	74 10                	je     8010650b <uva2ka+0x2c>
    return 0;
  if((*pte & PTE_U) == 0)
801064fb:	a8 04                	test   $0x4,%al
801064fd:	74 13                	je     80106512 <uva2ka+0x33>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801064ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106504:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106509:	c9                   	leave  
8010650a:	c3                   	ret    
    return 0;
8010650b:	b8 00 00 00 00       	mov    $0x0,%eax
80106510:	eb f7                	jmp    80106509 <uva2ka+0x2a>
    return 0;
80106512:	b8 00 00 00 00       	mov    $0x0,%eax
80106517:	eb f0                	jmp    80106509 <uva2ka+0x2a>

80106519 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106519:	55                   	push   %ebp
8010651a:	89 e5                	mov    %esp,%ebp
8010651c:	57                   	push   %edi
8010651d:	56                   	push   %esi
8010651e:	53                   	push   %ebx
8010651f:	83 ec 0c             	sub    $0xc,%esp
80106522:	8b 7d 14             	mov    0x14(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106525:	eb 25                	jmp    8010654c <copyout+0x33>
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106527:	8b 55 0c             	mov    0xc(%ebp),%edx
8010652a:	29 f2                	sub    %esi,%edx
8010652c:	01 d0                	add    %edx,%eax
8010652e:	83 ec 04             	sub    $0x4,%esp
80106531:	53                   	push   %ebx
80106532:	ff 75 10             	push   0x10(%ebp)
80106535:	50                   	push   %eax
80106536:	e8 a2 d6 ff ff       	call   80103bdd <memmove>
    len -= n;
8010653b:	29 df                	sub    %ebx,%edi
    buf += n;
8010653d:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80106540:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
80106546:	89 45 0c             	mov    %eax,0xc(%ebp)
80106549:	83 c4 10             	add    $0x10,%esp
  while(len > 0){
8010654c:	85 ff                	test   %edi,%edi
8010654e:	74 2f                	je     8010657f <copyout+0x66>
    va0 = (uint)PGROUNDDOWN(va);
80106550:	8b 75 0c             	mov    0xc(%ebp),%esi
80106553:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106559:	83 ec 08             	sub    $0x8,%esp
8010655c:	56                   	push   %esi
8010655d:	ff 75 08             	push   0x8(%ebp)
80106560:	e8 7a ff ff ff       	call   801064df <uva2ka>
    if(pa0 == 0)
80106565:	83 c4 10             	add    $0x10,%esp
80106568:	85 c0                	test   %eax,%eax
8010656a:	74 20                	je     8010658c <copyout+0x73>
    n = PGSIZE - (va - va0);
8010656c:	89 f3                	mov    %esi,%ebx
8010656e:	2b 5d 0c             	sub    0xc(%ebp),%ebx
80106571:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80106577:	39 df                	cmp    %ebx,%edi
80106579:	73 ac                	jae    80106527 <copyout+0xe>
      n = len;
8010657b:	89 fb                	mov    %edi,%ebx
8010657d:	eb a8                	jmp    80106527 <copyout+0xe>
  }
  return 0;
8010657f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106584:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106587:	5b                   	pop    %ebx
80106588:	5e                   	pop    %esi
80106589:	5f                   	pop    %edi
8010658a:	5d                   	pop    %ebp
8010658b:	c3                   	ret    
      return -1;
8010658c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106591:	eb f1                	jmp    80106584 <copyout+0x6b>
