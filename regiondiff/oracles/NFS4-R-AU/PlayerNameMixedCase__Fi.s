.set noat
.set noreorder

glabel func_8002BB84
/* 8002BB84 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BB88 afb20018 */  sw       $s2,24($sp)
/* 8002BB8C 00809021 */  move     $s2,$a0
/* 8002BB90 001218c0 */  sll      $v1,$s2,0x3
/* 8002BB94 3c028011 */  lui      $v0,0x8011
/* 8002BB98 afb10014 */  sw       $s1,20($sp)
/* 8002BB9C 24515c48 */  addiu    $s1,$v0,23624
/* 8002BBA0 afb00010 */  sw       $s0,16($sp)
/* 8002BBA4 00718021 */  addu     $s0,$v1,$s1
/* 8002BBA8 afbf001c */  sw       $ra,28($sp)
/* 8002BBAC 0c03aa2f */  jal      func_800EA8BC
/* 8002BBB0 02002021 */  move     $a0,$s0
/* 8002BBB4 14400008 */  bnez     $v0,.L8002BBD8
/* 8002BBB8 02001021 */  move     $v0,$s0
/* 8002BBBC 9223fc9f */  lbu      $v1,-865($s1)
/* 8002BBC0 24020001 */  li       $v0,1
/* 8002BBC4 14620002 */  bne      $v1,$v0,.L8002BBD0
/* 8002BBC8 2404004f */  li       $a0,79
/* 8002BBCC 26440051 */  addiu    $a0,$s2,81
.L8002BBD0:
/* 8002BBD0 0c02e7c7 */  jal      func_800B9F1C
/* 8002BBD4 00000000 */  nop      
.L8002BBD8:
/* 8002BBD8 8fbf001c */  lw       $ra,28($sp)
/* 8002BBDC 8fb20018 */  lw       $s2,24($sp)
/* 8002BBE0 8fb10014 */  lw       $s1,20($sp)
/* 8002BBE4 8fb00010 */  lw       $s0,16($sp)
/* 8002BBE8 03e00008 */  jr       $ra
/* 8002BBEC 27bd0020 */  addiu    $sp,$sp,32
