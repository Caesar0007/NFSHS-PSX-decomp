.set noat
.set noreorder

glabel func_800FA620
/* 800FA620 27bdffe8 */  addiu    $sp,$sp,-24
/* 800FA624 3c028015 */  lui      $v0,0x8015
/* 800FA628 2443802c */  addiu    $v1,$v0,-32724
/* 800FA62C afbf0010 */  sw       $ra,16($sp)
/* 800FA630 8c620018 */  lw       $v0,24($v1)
/* 800FA634 00000000 */  nop      
/* 800FA638 1040000d */  beqz     $v0,.L800FA670
/* 800FA63C 2442ffff */  addiu    $v0,$v0,-1
/* 800FA640 1440000b */  bnez     $v0,.L800FA670
/* 800FA644 ac620018 */  sw       $v0,24($v1)
/* 800FA648 0c03e08a */  jal      func_800F8228
/* 800FA64C 00002021 */  move     $a0,$zero
/* 800FA650 3c048010 */  lui      $a0,0x8010
/* 800FA654 2484a470 */  addiu    $a0,$a0,-23440
/* 800FA658 00002821 */  move     $a1,$zero
/* 800FA65C 0c039db3 */  jal      func_800E76CC
/* 800FA660 00a03021 */  move     $a2,$a1
/* 800FA664 3c048010 */  lui      $a0,0x8010
/* 800FA668 0c03ae64 */  jal      func_800EB990
/* 800FA66C 2484a620 */  addiu    $a0,$a0,-23008
.L800FA670:
/* 800FA670 8fbf0010 */  lw       $ra,16($sp)
/* 800FA674 00000000 */  nop      
/* 800FA678 03e00008 */  jr       $ra
/* 800FA67C 27bd0018 */  addiu    $sp,$sp,24
