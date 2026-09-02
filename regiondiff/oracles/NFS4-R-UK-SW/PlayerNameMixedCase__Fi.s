.set noat
.set noreorder

glabel func_8002BBDC
/* 8002BBDC 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BBE0 afb20018 */  sw       $s2,24($sp)
/* 8002BBE4 00809021 */  move     $s2,$a0
/* 8002BBE8 001218c0 */  sll      $v1,$s2,0x3
/* 8002BBEC 3c028011 */  lui      $v0,0x8011
/* 8002BBF0 afb10014 */  sw       $s1,20($sp)
/* 8002BBF4 24515c48 */  addiu    $s1,$v0,23624
/* 8002BBF8 afb00010 */  sw       $s0,16($sp)
/* 8002BBFC 00718021 */  addu     $s0,$v1,$s1
/* 8002BC00 afbf001c */  sw       $ra,28($sp)
/* 8002BC04 0c03aa2f */  jal      func_800EA8BC
/* 8002BC08 02002021 */  move     $a0,$s0
/* 8002BC0C 14400008 */  bnez     $v0,.L8002BC30
/* 8002BC10 02001021 */  move     $v0,$s0
/* 8002BC14 9223fc9f */  lbu      $v1,-865($s1)
/* 8002BC18 24020001 */  li       $v0,1
/* 8002BC1C 14620002 */  bne      $v1,$v0,.L8002BC28
/* 8002BC20 2404004f */  li       $a0,79
/* 8002BC24 26440051 */  addiu    $a0,$s2,81
.L8002BC28:
/* 8002BC28 0c02e7c7 */  jal      func_800B9F1C
/* 8002BC2C 00000000 */  nop      
.L8002BC30:
/* 8002BC30 8fbf001c */  lw       $ra,28($sp)
/* 8002BC34 8fb20018 */  lw       $s2,24($sp)
/* 8002BC38 8fb10014 */  lw       $s1,20($sp)
/* 8002BC3C 8fb00010 */  lw       $s0,16($sp)
/* 8002BC40 03e00008 */  jr       $ra
/* 8002BC44 27bd0020 */  addiu    $sp,$sp,32
