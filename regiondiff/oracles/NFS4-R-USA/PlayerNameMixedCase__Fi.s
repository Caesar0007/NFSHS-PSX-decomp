.set noat
.set noreorder

glabel func_8002BB08
/* 8002BB08 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BB0C afb20018 */  sw       $s2,24($sp)
/* 8002BB10 00809021 */  move     $s2,$a0
/* 8002BB14 001218c0 */  sll      $v1,$s2,0x3
/* 8002BB18 3c028011 */  lui      $v0,0x8011
/* 8002BB1C afb10014 */  sw       $s1,20($sp)
/* 8002BB20 24515c1c */  addiu    $s1,$v0,23580
/* 8002BB24 afb00010 */  sw       $s0,16($sp)
/* 8002BB28 00718021 */  addu     $s0,$v1,$s1
/* 8002BB2C afbf001c */  sw       $ra,28($sp)
/* 8002BB30 0c03aa34 */  jal      func_800EA8D0
/* 8002BB34 02002021 */  move     $a0,$s0
/* 8002BB38 14400008 */  bnez     $v0,.L8002BB5C
/* 8002BB3C 02001021 */  move     $v0,$s0
/* 8002BB40 9223fc9f */  lbu      $v1,-865($s1)
/* 8002BB44 24020001 */  li       $v0,1
/* 8002BB48 14620002 */  bne      $v1,$v0,.L8002BB54
/* 8002BB4C 2404004f */  li       $a0,79
/* 8002BB50 26440051 */  addiu    $a0,$s2,81
.L8002BB54:
/* 8002BB54 0c02e7c6 */  jal      func_800B9F18
/* 8002BB58 00000000 */  nop      
.L8002BB5C:
/* 8002BB5C 8fbf001c */  lw       $ra,28($sp)
/* 8002BB60 8fb20018 */  lw       $s2,24($sp)
/* 8002BB64 8fb10014 */  lw       $s1,20($sp)
/* 8002BB68 8fb00010 */  lw       $s0,16($sp)
/* 8002BB6C 03e00008 */  jr       $ra
/* 8002BB70 27bd0020 */  addiu    $sp,$sp,32
