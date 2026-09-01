.set noat
.set noreorder

glabel func_800E4B90
/* 800E4B90 27bdffe8 */  addiu    $sp,$sp,-24
/* 800E4B94 3c028014 */  lui      $v0,0x8014
/* 800E4B98 8c43f990 */  lw       $v1,-1648($v0)
/* 800E4B9C 2445f990 */  addiu    $a1,$v0,-1648
/* 800E4BA0 afbf0010 */  sw       $ra,16($sp)
/* 800E4BA4 1060000a */  beqz     $v1,.L800E4BD0
/* 800E4BA8 00001021 */  move     $v0,$zero
/* 800E4BAC 2c820008 */  sltiu    $v0,$a0,8
/* 800E4BB0 10400006 */  beqz     $v0,.L800E4BCC
/* 800E4BB4 000410c0 */  sll      $v0,$a0,0x3
/* 800E4BB8 24a40004 */  addiu    $a0,$a1,4
/* 800E4BBC 0c0392f8 */  jal      func_800E4BE0
/* 800E4BC0 00442021 */  addu     $a0,$v0,$a0
/* 800E4BC4 080392f4 */  j        .L800E4BD0
/* 800E4BC8 3042ffff */  andi     $v0,$v0,0xffff
.L800E4BCC:
/* 800E4BCC 00001021 */  move     $v0,$zero
.L800E4BD0:
/* 800E4BD0 8fbf0010 */  lw       $ra,16($sp)
/* 800E4BD4 00000000 */  nop      
/* 800E4BD8 03e00008 */  jr       $ra
/* 800E4BDC 27bd0018 */  addiu    $sp,$sp,24
