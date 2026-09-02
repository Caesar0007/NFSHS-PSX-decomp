.set noat
.set noreorder

glabel func_8002BA7C
/* 8002BA7C 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BA80 afb20018 */  sw       $s2,24($sp)
/* 8002BA84 00809021 */  move     $s2,$a0
/* 8002BA88 001228c0 */  sll      $a1,$s2,0x3
/* 8002BA8C 3c028011 */  lui      $v0,0x8011
/* 8002BA90 afb10014 */  sw       $s1,20($sp)
/* 8002BA94 24515c2c */  addiu    $s1,$v0,23596
/* 8002BA98 afb00010 */  sw       $s0,16($sp)
/* 8002BA9C 00b18021 */  addu     $s0,$a1,$s1
/* 8002BAA0 02002021 */  move     $a0,$s0
/* 8002BAA4 2622fff0 */  addiu    $v0,$s1,-16
/* 8002BAA8 afbf001c */  sw       $ra,28($sp)
/* 8002BAAC 0c03942a */  jal      func_800E50A8
/* 8002BAB0 00a22821 */  addu     $a1,$a1,$v0
/* 8002BAB4 0c03aa34 */  jal      func_800EA8D0
/* 8002BAB8 02002021 */  move     $a0,$s0
/* 8002BABC 10400005 */  beqz     $v0,.L8002BAD4
/* 8002BAC0 24020001 */  li       $v0,1
/* 8002BAC4 0c012c4a */  jal      func_8004B128
/* 8002BAC8 02002021 */  move     $a0,$s0
/* 8002BACC 0800aebc */  j        .L8002BAF0
/* 8002BAD0 02001021 */  move     $v0,$s0
.L8002BAD4:
/* 8002BAD4 9223fc8f */  lbu      $v1,-881($s1)
/* 8002BAD8 00000000 */  nop      
/* 8002BADC 14620002 */  bne      $v1,$v0,.L8002BAE8
/* 8002BAE0 2404004f */  li       $a0,79
/* 8002BAE4 26440051 */  addiu    $a0,$s2,81
.L8002BAE8:
/* 8002BAE8 0c02e7c6 */  jal      func_800B9F18
/* 8002BAEC 00000000 */  nop      
.L8002BAF0:
/* 8002BAF0 8fbf001c */  lw       $ra,28($sp)
/* 8002BAF4 8fb20018 */  lw       $s2,24($sp)
/* 8002BAF8 8fb10014 */  lw       $s1,20($sp)
/* 8002BAFC 8fb00010 */  lw       $s0,16($sp)
/* 8002BB00 03e00008 */  jr       $ra
/* 8002BB04 27bd0020 */  addiu    $sp,$sp,32
