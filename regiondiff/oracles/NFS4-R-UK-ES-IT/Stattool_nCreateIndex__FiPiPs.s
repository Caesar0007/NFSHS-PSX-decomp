.set noat
.set noreorder

glabel func_8004ADD0
/* 8004ADD0 27bdffd8 */  addiu    $sp,$sp,-40
/* 8004ADD4 afb10014 */  sw       $s1,20($sp)
/* 8004ADD8 00808821 */  move     $s1,$a0
/* 8004ADDC afb3001c */  sw       $s3,28($sp)
/* 8004ADE0 00a09821 */  move     $s3,$a1
/* 8004ADE4 afb20018 */  sw       $s2,24($sp)
/* 8004ADE8 00c09021 */  move     $s2,$a2
/* 8004ADEC 3c048001 */  lui      $a0,0x8001
/* 8004ADF0 248424cc */  addiu    $a0,$a0,9420
/* 8004ADF4 26250001 */  addiu    $a1,$s1,1
/* 8004ADF8 00052880 */  sll      $a1,$a1,0x2
/* 8004ADFC 24060010 */  li       $a2,16
/* 8004AE00 afbf0020 */  sw       $ra,32($sp)
/* 8004AE04 0c0397c5 */  jal      func_800E5F14
/* 8004AE08 afb00010 */  sw       $s0,16($sp)
/* 8004AE0C 00008021 */  move     $s0,$zero
/* 8004AE10 1a20000d */  blez     $s1,.L8004AE48
/* 8004AE14 00402021 */  move     $a0,$v0
/* 8004AE18 00803021 */  move     $a2,$a0
/* 8004AE1C 02602821 */  move     $a1,$s3
/* 8004AE20 02401821 */  move     $v1,$s2
.L8004AE24:
/* 8004AE24 a4700000 */  sh       $s0,0($v1)
/* 8004AE28 8ca20000 */  lw       $v0,0($a1)
/* 8004AE2C 24a50004 */  addiu    $a1,$a1,4
/* 8004AE30 24630002 */  addiu    $v1,$v1,2
/* 8004AE34 26100001 */  addiu    $s0,$s0,1
/* 8004AE38 acc20000 */  sw       $v0,0($a2)
/* 8004AE3C 0211102a */  slt      $v0,$s0,$s1
/* 8004AE40 1440fff8 */  bnez     $v0,.L8004AE24
/* 8004AE44 24c60004 */  addiu    $a2,$a2,4
.L8004AE48:
/* 8004AE48 24020001 */  li       $v0,1
/* 8004AE4C 12220024 */  beq      $s1,$v0,.L8004AEE0
/* 8004AE50 24100001 */  li       $s0,1
/* 8004AE54 0211102a */  slt      $v0,$s0,$s1
/* 8004AE58 10400021 */  beqz     $v0,.L8004AEE0
/* 8004AE5C 264a0002 */  addiu    $t2,$s2,2
/* 8004AE60 24890004 */  addiu    $t1,$a0,4
.L8004AE64:
/* 8004AE64 2606ffff */  addiu    $a2,$s0,-1
/* 8004AE68 8d280000 */  lw       $t0,0($t1)
/* 8004AE6C 854b0000 */  lh       $t3,0($t2)
/* 8004AE70 04c00010 */  bltz     $a2,.L8004AEB4
/* 8004AE74 00061040 */  sll      $v0,$a2,0x1
/* 8004AE78 00523821 */  addu     $a3,$v0,$s2
/* 8004AE7C 00061080 */  sll      $v0,$a2,0x2
/* 8004AE80 00442821 */  addu     $a1,$v0,$a0
.L8004AE84:
/* 8004AE84 8ca30000 */  lw       $v1,0($a1)
/* 8004AE88 00000000 */  nop      
/* 8004AE8C 0068102a */  slt      $v0,$v1,$t0
/* 8004AE90 14400008 */  bnez     $v0,.L8004AEB4
/* 8004AE94 00000000 */  nop      
/* 8004AE98 aca30004 */  sw       $v1,4($a1)
/* 8004AE9C 24a5fffc */  addiu    $a1,$a1,-4
/* 8004AEA0 94e20000 */  lhu      $v0,0($a3)
/* 8004AEA4 24c6ffff */  addiu    $a2,$a2,-1
/* 8004AEA8 a4e20002 */  sh       $v0,2($a3)
/* 8004AEAC 04c1fff5 */  bgez     $a2,.L8004AE84
/* 8004AEB0 24e7fffe */  addiu    $a3,$a3,-2
.L8004AEB4:
/* 8004AEB4 254a0002 */  addiu    $t2,$t2,2
/* 8004AEB8 26100001 */  addiu    $s0,$s0,1
/* 8004AEBC 00061080 */  sll      $v0,$a2,0x2
/* 8004AEC0 00441021 */  addu     $v0,$v0,$a0
/* 8004AEC4 ac480004 */  sw       $t0,4($v0)
/* 8004AEC8 00061040 */  sll      $v0,$a2,0x1
/* 8004AECC 00521021 */  addu     $v0,$v0,$s2
/* 8004AED0 a44b0002 */  sh       $t3,2($v0)
/* 8004AED4 0211102a */  slt      $v0,$s0,$s1
/* 8004AED8 1440ffe2 */  bnez     $v0,.L8004AE64
/* 8004AEDC 25290004 */  addiu    $t1,$t1,4
.L8004AEE0:
/* 8004AEE0 0c039846 */  jal      func_800E6118
/* 8004AEE4 00000000 */  nop      
/* 8004AEE8 8fbf0020 */  lw       $ra,32($sp)
/* 8004AEEC 8fb3001c */  lw       $s3,28($sp)
/* 8004AEF0 8fb20018 */  lw       $s2,24($sp)
/* 8004AEF4 8fb10014 */  lw       $s1,20($sp)
/* 8004AEF8 8fb00010 */  lw       $s0,16($sp)
/* 8004AEFC 03e00008 */  jr       $ra
/* 8004AF00 27bd0028 */  addiu    $sp,$sp,40
