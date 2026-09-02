.set noat
.set noreorder

glabel func_8002B6C4
/* 8002B6C4 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002B6C8 afb20018 */  sw       $s2,24($sp)
/* 8002B6CC 00809021 */  move     $s2,$a0
/* 8002B6D0 001228c0 */  sll      $a1,$s2,0x3
/* 8002B6D4 3c028011 */  lui      $v0,0x8011
/* 8002B6D8 afb10014 */  sw       $s1,20($sp)
/* 8002B6DC 24515a18 */  addiu    $s1,$v0,23064
/* 8002B6E0 afb00010 */  sw       $s0,16($sp)
/* 8002B6E4 00b18021 */  addu     $s0,$a1,$s1
/* 8002B6E8 02002021 */  move     $a0,$s0
/* 8002B6EC 2622fff0 */  addiu    $v0,$s1,-16
/* 8002B6F0 afbf001c */  sw       $ra,28($sp)
/* 8002B6F4 0c0393a5 */  jal      func_800E4E94
/* 8002B6F8 00a22821 */  addu     $a1,$a1,$v0
/* 8002B6FC 0c03a9af */  jal      func_800EA6BC
/* 8002B700 02002021 */  move     $a0,$s0
/* 8002B704 10400005 */  beqz     $v0,.L8002B71C
/* 8002B708 24020001 */  li       $v0,1
/* 8002B70C 0c012afc */  jal      func_8004ABF0
/* 8002B710 02002021 */  move     $a0,$s0
/* 8002B714 0800adce */  j        .L8002B738
/* 8002B718 02001021 */  move     $v0,$s0
.L8002B71C:
/* 8002B71C 9223fc8f */  lbu      $v1,-881($s1)
/* 8002B720 00000000 */  nop      
/* 8002B724 14620002 */  bne      $v1,$v0,.L8002B730
/* 8002B728 2404004f */  li       $a0,79
/* 8002B72C 26440051 */  addiu    $a0,$s2,81
.L8002B730:
/* 8002B730 0c02e733 */  jal      func_800B9CCC
/* 8002B734 00000000 */  nop      
.L8002B738:
/* 8002B738 8fbf001c */  lw       $ra,28($sp)
/* 8002B73C 8fb20018 */  lw       $s2,24($sp)
/* 8002B740 8fb10014 */  lw       $s1,20($sp)
/* 8002B744 8fb00010 */  lw       $s0,16($sp)
/* 8002B748 03e00008 */  jr       $ra
/* 8002B74C 27bd0020 */  addiu    $sp,$sp,32
