.set noat
.set noreorder

glabel func_8002BAF8
/* 8002BAF8 27bdffe0 */  addiu    $sp,$sp,-32
/* 8002BAFC afb20018 */  sw       $s2,24($sp)
/* 8002BB00 00809021 */  move     $s2,$a0
/* 8002BB04 001228c0 */  sll      $a1,$s2,0x3
/* 8002BB08 3c028011 */  lui      $v0,0x8011
/* 8002BB0C afb10014 */  sw       $s1,20($sp)
/* 8002BB10 24515c58 */  addiu    $s1,$v0,23640
/* 8002BB14 afb00010 */  sw       $s0,16($sp)
/* 8002BB18 00b18021 */  addu     $s0,$a1,$s1
/* 8002BB1C 02002021 */  move     $a0,$s0
/* 8002BB20 2622fff0 */  addiu    $v0,$s1,-16
/* 8002BB24 afbf001c */  sw       $ra,28($sp)
/* 8002BB28 0c039425 */  jal      func_800E5094
/* 8002BB2C 00a22821 */  addu     $a1,$a1,$v0
/* 8002BB30 0c03aa2f */  jal      func_800EA8BC
/* 8002BB34 02002021 */  move     $a0,$s0
/* 8002BB38 10400005 */  beqz     $v0,.L8002BB50
/* 8002BB3C 24020001 */  li       $v0,1
/* 8002BB40 0c012c4c */  jal      func_8004B130
/* 8002BB44 02002021 */  move     $a0,$s0
/* 8002BB48 0800aedb */  j        .L8002BB6C
/* 8002BB4C 02001021 */  move     $v0,$s0
.L8002BB50:
/* 8002BB50 9223fc8f */  lbu      $v1,-881($s1)
/* 8002BB54 00000000 */  nop      
/* 8002BB58 14620002 */  bne      $v1,$v0,.L8002BB64
/* 8002BB5C 2404004f */  li       $a0,79
/* 8002BB60 26440051 */  addiu    $a0,$s2,81
.L8002BB64:
/* 8002BB64 0c02e7c7 */  jal      func_800B9F1C
/* 8002BB68 00000000 */  nop      
.L8002BB6C:
/* 8002BB6C 8fbf001c */  lw       $ra,28($sp)
/* 8002BB70 8fb20018 */  lw       $s2,24($sp)
/* 8002BB74 8fb10014 */  lw       $s1,20($sp)
/* 8002BB78 8fb00010 */  lw       $s0,16($sp)
/* 8002BB7C 03e00008 */  jr       $ra
/* 8002BB80 27bd0020 */  addiu    $sp,$sp,32
