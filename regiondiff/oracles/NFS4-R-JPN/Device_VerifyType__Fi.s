.set noat
.set noreorder

glabel func_800BDF80
/* 800BDF80 3c028014 */  lui      $v0,0x8014
/* 800BDF84 8c42e338 */  lw       $v0,-7368($v0)
/* 800BDF88 27bdffe0 */  addiu    $sp,$sp,-32
/* 800BDF8C afbf0018 */  sw       $ra,24($sp)
/* 800BDF90 afb10014 */  sw       $s1,20($sp)
/* 800BDF94 10400023 */  beqz     $v0,.L800BE024
/* 800BDF98 afb00010 */  sw       $s0,16($sp)
/* 800BDF9C 3c028014 */  lui      $v0,0x8014
/* 800BDFA0 2442f990 */  addiu    $v0,$v0,-1648
/* 800BDFA4 000418c0 */  sll      $v1,$a0,0x3
/* 800BDFA8 00628021 */  addu     $s0,$v1,$v0
/* 800BDFAC 92020004 */  lbu      $v0,4($s0)
/* 800BDFB0 00000000 */  nop      
/* 800BDFB4 1440001c */  bnez     $v0,.L800BE028
/* 800BDFB8 00001021 */  move     $v0,$zero
/* 800BDFBC 92030005 */  lbu      $v1,5($s0)
/* 800BDFC0 24020023 */  li       $v0,35
/* 800BDFC4 14620003 */  bne      $v1,$v0,.L800BDFD4
/* 800BDFC8 3c038011 */  lui      $v1,0x8011
/* 800BDFCC 0802f80a */  j        .L800BE028
/* 800BDFD0 00001021 */  move     $v0,$zero
.L800BDFD4:
/* 800BDFD4 246356a4 */  addiu    $v1,$v1,22180
/* 800BDFD8 0004202b */  sltu     $a0,$zero,$a0
/* 800BDFDC 00042823 */  negu     $a1,$a0
/* 800BDFE0 30a20002 */  andi     $v0,$a1,0x2
/* 800BDFE4 00438821 */  addu     $s1,$v0,$v1
/* 800BDFE8 92030005 */  lbu      $v1,5($s0)
/* 800BDFEC 8622035e */  lh       $v0,862($s1)
/* 800BDFF0 00000000 */  nop      
/* 800BDFF4 1062000b */  beq      $v1,$v0,.L800BE024
/* 800BDFF8 3c028011 */  lui      $v0,0x8011
/* 800BDFFC 24424290 */  addiu    $v0,$v0,17040
/* 800BE000 30a30004 */  andi     $v1,$a1,0x4
/* 800BE004 00621821 */  addu     $v1,$v1,$v0
/* 800BE008 8c650060 */  lw       $a1,96($v1)
/* 800BE00C 0c0373b1 */  jal      func_800DCEC4
/* 800BE010 00000000 */  nop      
/* 800BE014 92030005 */  lbu      $v1,5($s0)
/* 800BE018 24020001 */  li       $v0,1
/* 800BE01C 0802f80a */  j        .L800BE028
/* 800BE020 a623035e */  sh       $v1,862($s1)
.L800BE024:
/* 800BE024 24020001 */  li       $v0,1
.L800BE028:
/* 800BE028 8fbf0018 */  lw       $ra,24($sp)
/* 800BE02C 8fb10014 */  lw       $s1,20($sp)
/* 800BE030 8fb00010 */  lw       $s0,16($sp)
/* 800BE034 03e00008 */  jr       $ra
/* 800BE038 27bd0020 */  addiu    $sp,$sp,32
