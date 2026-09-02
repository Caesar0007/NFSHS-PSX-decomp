.set noat
.set noreorder

glabel func_8002BB68
/* 8002BB68 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BB6C afb20018 */  sw       $s2,24($sp)
/* 8002BB70 00809021 */  move     $s2,$a0
/* 8002BB74 001228c0 */  sll      $a1,$s2,0x3
/* 8002BB78 3c028011 */  lui      $v0,0x8011
/* 8002BB7C afb10014 */  sw       $s1,20($sp)
/* 8002BB80 24515c58 */  addiu    $s1,$v0,23640
/* 8002BB84 afb00010 */  sw       $s0,16($sp)
/* 8002BB88 00b18021 */  addu     $s0,$a1,$s1
/* 8002BB8C 02002021 */  move     $a0,$s0
/* 8002BB90 2622fff0 */  addiu    $v0,$s1,-16
/* 8002BB94 afbf001c */  sw       $ra,28($sp)
/* 8002BB98 0c039425 */  jal      func_800E5094
/* 8002BB9C 00a22821 */  addu     $a1,$a1,$v0
/* 8002BBA0 0c03aa2f */  jal      func_800EA8BC
/* 8002BBA4 02002021 */  move     $a0,$s0
/* 8002BBA8 10400005 */  beqz     $v0,.L8002BBC0
/* 8002BBAC 24020001 */  li       $v0,1
/* 8002BBB0 0c012c6e */  jal      func_8004B1B8
/* 8002BBB4 02002021 */  move     $a0,$s0
/* 8002BBB8 0800aef7 */  j        .L8002BBDC
/* 8002BBBC 02001021 */  move     $v0,$s0
.L8002BBC0:
/* 8002BBC0 9223fc8f */  lbu      $v1,-881($s1)
/* 8002BBC4 00000000 */  nop      
/* 8002BBC8 14620002 */  bne      $v1,$v0,.L8002BBD4
/* 8002BBCC 2404004f */  li       $a0,79
/* 8002BBD0 26440051 */  addiu    $a0,$s2,81
.L8002BBD4:
/* 8002BBD4 0c02e7c7 */  jal      func_800B9F1C
/* 8002BBD8 00000000 */  nop      
.L8002BBDC:
/* 8002BBDC 8fbf001c */  lw       $ra,28($sp)
/* 8002BBE0 8fb20018 */  lw       $s2,24($sp)
/* 8002BBE4 8fb10014 */  lw       $s1,20($sp)
/* 8002BBE8 8fb00010 */  lw       $s0,16($sp)
/* 8002BBEC 03e00008 */  jr       $ra
/* 8002BBF0 27bd0020 */  addiu    $sp,$sp,32
