.set noat
.set noreorder

glabel func_8002BB50
/* 8002BB50 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BB54 afb20018 */  sw       $s2,24($sp)
/* 8002BB58 00809021 */  move     $s2,$a0
/* 8002BB5C 001228c0 */  sll      $a1,$s2,0x3
/* 8002BB60 3c028011 */  lui      $v0,0x8011
/* 8002BB64 afb10014 */  sw       $s1,20($sp)
/* 8002BB68 24515c58 */  addiu    $s1,$v0,23640
/* 8002BB6C afb00010 */  sw       $s0,16($sp)
/* 8002BB70 00b18021 */  addu     $s0,$a1,$s1
/* 8002BB74 02002021 */  move     $a0,$s0
/* 8002BB78 2622fff0 */  addiu    $v0,$s1,-16
/* 8002BB7C afbf001c */  sw       $ra,28($sp)
/* 8002BB80 0c039425 */  jal      func_800E5094
/* 8002BB84 00a22821 */  addu     $a1,$a1,$v0
/* 8002BB88 0c03aa2f */  jal      func_800EA8BC
/* 8002BB8C 02002021 */  move     $a0,$s0
/* 8002BB90 10400005 */  beqz     $v0,.L8002BBA8
/* 8002BB94 24020001 */  li       $v0,1
/* 8002BB98 0c012c68 */  jal      func_8004B1A0
/* 8002BB9C 02002021 */  move     $a0,$s0
/* 8002BBA0 0800aef1 */  j        .L8002BBC4
/* 8002BBA4 02001021 */  move     $v0,$s0
.L8002BBA8:
/* 8002BBA8 9223fc8f */  lbu      $v1,-881($s1)
/* 8002BBAC 00000000 */  nop      
/* 8002BBB0 14620002 */  bne      $v1,$v0,.L8002BBBC
/* 8002BBB4 2404004f */  li       $a0,79
/* 8002BBB8 26440051 */  addiu    $a0,$s2,81
.L8002BBBC:
/* 8002BBBC 0c02e7c7 */  jal      func_800B9F1C
/* 8002BBC0 00000000 */  nop      
.L8002BBC4:
/* 8002BBC4 8fbf001c */  lw       $ra,28($sp)
/* 8002BBC8 8fb20018 */  lw       $s2,24($sp)
/* 8002BBCC 8fb10014 */  lw       $s1,20($sp)
/* 8002BBD0 8fb00010 */  lw       $s0,16($sp)
/* 8002BBD4 03e00008 */  jr       $ra
/* 8002BBD8 27bd0020 */  addiu    $sp,$sp,32
