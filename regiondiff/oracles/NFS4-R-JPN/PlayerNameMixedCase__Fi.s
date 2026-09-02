.set noat
.set noreorder

glabel func_8002B750
/* 8002B750 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002B754 afb20018 */  sw       $s2,24($sp)
/* 8002B758 00809021 */  move     $s2,$a0
/* 8002B75C 001218c0 */  sll      $v1,$s2,0x3
/* 8002B760 3c028011 */  lui      $v0,0x8011
/* 8002B764 afb10014 */  sw       $s1,20($sp)
/* 8002B768 24515a08 */  addiu    $s1,$v0,23048
/* 8002B76C afb00010 */  sw       $s0,16($sp)
/* 8002B770 00718021 */  addu     $s0,$v1,$s1
/* 8002B774 afbf001c */  sw       $ra,28($sp)
/* 8002B778 0c03a9af */  jal      func_800EA6BC
/* 8002B77C 02002021 */  move     $a0,$s0
/* 8002B780 14400008 */  bnez     $v0,.L8002B7A4
/* 8002B784 02001021 */  move     $v0,$s0
/* 8002B788 9223fc9f */  lbu      $v1,-865($s1)
/* 8002B78C 24020001 */  li       $v0,1
/* 8002B790 14620002 */  bne      $v1,$v0,.L8002B79C
/* 8002B794 2404004f */  li       $a0,79
/* 8002B798 26440051 */  addiu    $a0,$s2,81
.L8002B79C:
/* 8002B79C 0c02e733 */  jal      func_800B9CCC
/* 8002B7A0 00000000 */  nop      
.L8002B7A4:
/* 8002B7A4 8fbf001c */  lw       $ra,28($sp)
/* 8002B7A8 8fb20018 */  lw       $s2,24($sp)
/* 8002B7AC 8fb10014 */  lw       $s1,20($sp)
/* 8002B7B0 8fb00010 */  lw       $s0,16($sp)
/* 8002B7B4 03e00008 */  jr       $ra
/* 8002B7B8 27bd0020 */  addiu    $sp,$sp,32
