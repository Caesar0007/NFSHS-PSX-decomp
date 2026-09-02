.set noat
.set noreorder

glabel func_8002BBF4
/* 8002BBF4 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BBF8 afb20018 */  sw       $s2,24($sp)
/* 8002BBFC 00809021 */  move     $s2,$a0
/* 8002BC00 001218c0 */  sll      $v1,$s2,0x3
/* 8002BC04 3c028011 */  lui      $v0,0x8011
/* 8002BC08 afb10014 */  sw       $s1,20($sp)
/* 8002BC0C 24515c48 */  addiu    $s1,$v0,23624
/* 8002BC10 afb00010 */  sw       $s0,16($sp)
/* 8002BC14 00718021 */  addu     $s0,$v1,$s1
/* 8002BC18 afbf001c */  sw       $ra,28($sp)
/* 8002BC1C 0c03aa2f */  jal      func_800EA8BC
/* 8002BC20 02002021 */  move     $a0,$s0
/* 8002BC24 14400008 */  bnez     $v0,.L8002BC48
/* 8002BC28 02001021 */  move     $v0,$s0
/* 8002BC2C 9223fc9f */  lbu      $v1,-865($s1)
/* 8002BC30 24020001 */  li       $v0,1
/* 8002BC34 14620002 */  bne      $v1,$v0,.L8002BC40
/* 8002BC38 2404004f */  li       $a0,79
/* 8002BC3C 26440051 */  addiu    $a0,$s2,81
.L8002BC40:
/* 8002BC40 0c02e7c7 */  jal      func_800B9F1C
/* 8002BC44 00000000 */  nop      
.L8002BC48:
/* 8002BC48 8fbf001c */  lw       $ra,28($sp)
/* 8002BC4C 8fb20018 */  lw       $s2,24($sp)
/* 8002BC50 8fb10014 */  lw       $s1,20($sp)
/* 8002BC54 8fb00010 */  lw       $s0,16($sp)
/* 8002BC58 03e00008 */  jr       $ra
/* 8002BC5C 27bd0020 */  addiu    $sp,$sp,32
