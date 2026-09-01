.set noat
.set noreorder

glabel func_800FA5F4
/* 800FA5F4 27bdffe8 */  addiu    $sp,$sp,-24
/* 800FA5F8 3c028015 */  lui      $v0,0x8015
/* 800FA5FC 24438000 */  addiu    $v1,$v0,-32768
/* 800FA600 afbf0010 */  sw       $ra,16($sp)
/* 800FA604 8c620018 */  lw       $v0,24($v1)
/* 800FA608 00000000 */  nop      
/* 800FA60C 1040000d */  beqz     $v0,.L800FA644
/* 800FA610 2442ffff */  addiu    $v0,$v0,-1
/* 800FA614 1440000b */  bnez     $v0,.L800FA644
/* 800FA618 ac620018 */  sw       $v0,24($v1)
/* 800FA61C 0c03e07f */  jal      func_800F81FC
/* 800FA620 00002021 */  move     $a0,$zero
/* 800FA624 3c048010 */  lui      $a0,0x8010
/* 800FA628 2484a444 */  addiu    $a0,$a0,-23484
/* 800FA62C 00002821 */  move     $a1,$zero
/* 800FA630 0c039db8 */  jal      func_800E76E0
/* 800FA634 00a03021 */  move     $a2,$a1
/* 800FA638 3c048010 */  lui      $a0,0x8010
/* 800FA63C 0c03ae69 */  jal      func_800EB9A4
/* 800FA640 2484a5f4 */  addiu    $a0,$a0,-23052
.L800FA644:
/* 800FA644 8fbf0010 */  lw       $ra,16($sp)
/* 800FA648 00000000 */  nop      
/* 800FA64C 03e00008 */  jr       $ra
/* 800FA650 27bd0018 */  addiu    $sp,$sp,24
