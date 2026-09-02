.set noat
.set noreorder

glabel func_8001BE60
/* 8001BE60 27bdffc8 */  addiu    $sp,$sp,-56
/* 8001BE64 afb40030 */  sw       $s4,48($sp)
/* 8001BE68 0080a021 */  move     $s4,$a0
/* 8001BE6C 24020080 */  li       $v0,128
/* 8001BE70 afbf0034 */  sw       $ra,52($sp)
/* 8001BE74 afb3002c */  sw       $s3,44($sp)
/* 8001BE78 afb20028 */  sw       $s2,40($sp)
/* 8001BE7C afb10024 */  sw       $s1,36($sp)
/* 8001BE80 14a20004 */  bne      $a1,$v0,.L8001BE94
/* 8001BE84 afb00020 */  sw       $s0,32($sp)
/* 8001BE88 8ce20000 */  lw       $v0,0($a3)
/* 8001BE8C 08006fa9 */  j        .L8001BEA4
/* 8001BE90 24420001 */  addiu    $v0,$v0,1
.L8001BE94:
/* 8001BE94 8ce20000 */  lw       $v0,0($a3)
/* 8001BE98 00000000 */  nop      
/* 8001BE9C 10400002 */  beqz     $v0,.L8001BEA8
/* 8001BEA0 24420005 */  addiu    $v0,$v0,5
.L8001BEA4:
/* 8001BEA4 ace20000 */  sw       $v0,0($a3)
.L8001BEA8:
/* 8001BEA8 8ce20000 */  lw       $v0,0($a3)
/* 8001BEAC 00000000 */  nop      
/* 8001BEB0 2842003d */  slti     $v0,$v0,61
/* 8001BEB4 14400002 */  bnez     $v0,.L8001BEC0
/* 8001BEB8 00000000 */  nop      
/* 8001BEBC ace00000 */  sw       $zero,0($a3)
.L8001BEC0:
/* 8001BEC0 8ce70000 */  lw       $a3,0($a3)
/* 8001BEC4 00000000 */  nop      
/* 8001BEC8 28e2001f */  slti     $v0,$a3,31
/* 8001BECC 14400005 */  bnez     $v0,.L8001BEE4
/* 8001BED0 2402003c */  li       $v0,60
/* 8001BED4 00471023 */  subu     $v0,$v0,$a3
/* 8001BED8 00021fc2 */  srl      $v1,$v0,0x1f
/* 8001BEDC 08006fbb */  j        .L8001BEEC
/* 8001BEE0 00431021 */  addu     $v0,$v0,$v1
.L8001BEE4:
/* 8001BEE4 000717c2 */  srl      $v0,$a3,0x1f
/* 8001BEE8 00e21021 */  addu     $v0,$a3,$v0
.L8001BEEC:
/* 8001BEEC 00028843 */  sra      $s1,$v0,0x1
/* 8001BEF0 26310014 */  addiu    $s1,$s1,20
/* 8001BEF4 02250018 */  mult     $s1,$a1
/* 8001BEF8 00008812 */  mflo     $s1
/* 8001BEFC 24030080 */  li       $v1,128
/* 8001BF00 00661023 */  subu     $v0,$v1,$a2
/* 8001BF04 02220018 */  mult     $s1,$v0
/* 8001BF08 00009012 */  mflo     $s2
/* 8001BF0C 06410002 */  bgez     $s2,.L8001BF18
/* 8001BF10 00659823 */  subu     $s3,$v1,$a1
/* 8001BF14 2652007f */  addiu    $s2,$s2,127
.L8001BF18:
/* 8001BF18 0266102a */  slt      $v0,$s3,$a2
/* 8001BF1C 10400002 */  beqz     $v0,.L8001BF28
/* 8001BF20 001289c3 */  sra      $s1,$s2,0x7
/* 8001BF24 00c09821 */  move     $s3,$a2
.L8001BF28:
/* 8001BF28 1a20001c */  blez     $s1,.L8001BF9C
/* 8001BF2C 00000000 */  nop      
/* 8001BF30 0c02e743 */  jal      func_800B9D0C
/* 8001BF34 240401df */  li       $a0,479
/* 8001BF38 3c035555 */  lui      $v1,0x5555
/* 8001BF3C 34635556 */  ori      $v1,$v1,0x5556
/* 8001BF40 00113840 */  sll      $a3,$s1,0x1
/* 8001BF44 00e30018 */  mult     $a3,$v1
/* 8001BF48 00408021 */  move     $s0,$v0
/* 8001BF4C 02002021 */  move     $a0,$s0
/* 8001BF50 26850005 */  addiu    $a1,$s4,5
/* 8001BF54 001237c2 */  srl      $a2,$s2,0x1f
/* 8001BF58 02263021 */  addu     $a2,$s1,$a2
/* 8001BF5C 00063043 */  sra      $a2,$a2,0x1
/* 8001BF60 24020017 */  li       $v0,23
/* 8001BF64 00073fc3 */  sra      $a3,$a3,0x1f
/* 8001BF68 afa20010 */  sw       $v0,16($sp)
/* 8001BF6C 00004010 */  mfhi     $t0
/* 8001BF70 0c033aaf */  jal      func_800CEABC
/* 8001BF74 01073823 */  subu     $a3,$t0,$a3
/* 8001BF78 00002021 */  move     $a0,$zero
/* 8001BF7C 00802821 */  move     $a1,$a0
/* 8001BF80 2606fffd */  addiu    $a2,$s0,-3
/* 8001BF84 2687ffff */  addiu    $a3,$s4,-1
/* 8001BF88 0093102b */  sltu     $v0,$a0,$s3
/* 8001BF8C afb30010 */  sw       $s3,16($sp)
/* 8001BF90 afa20014 */  sw       $v0,20($sp)
/* 8001BF94 0c01398a */  jal      func_8004E628
/* 8001BF98 afa00018 */  sw       $zero,24($sp)
.L8001BF9C:
/* 8001BF9C 8fbf0034 */  lw       $ra,52($sp)
/* 8001BFA0 8fb40030 */  lw       $s4,48($sp)
/* 8001BFA4 8fb3002c */  lw       $s3,44($sp)
/* 8001BFA8 8fb20028 */  lw       $s2,40($sp)
/* 8001BFAC 8fb10024 */  lw       $s1,36($sp)
/* 8001BFB0 8fb00020 */  lw       $s0,32($sp)
/* 8001BFB4 03e00008 */  jr       $ra
/* 8001BFB8 27bd0038 */  addiu    $sp,$sp,56
