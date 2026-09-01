.set noat
.set noreorder

glabel func_8004ADB8
/* 8004ADB8 27bdffd8 */  addiu    $sp,$sp,-40
/* 8004ADBC afb10014 */  sw       $s1,20($sp)
/* 8004ADC0 00808821 */  move     $s1,$a0
/* 8004ADC4 afb3001c */  sw       $s3,28($sp)
/* 8004ADC8 00a09821 */  move     $s3,$a1
/* 8004ADCC afb20018 */  sw       $s2,24($sp)
/* 8004ADD0 00c09021 */  move     $s2,$a2
/* 8004ADD4 3c048001 */  lui      $a0,0x8001
/* 8004ADD8 248424cc */  addiu    $a0,$a0,9420
/* 8004ADDC 26250001 */  addiu    $a1,$s1,1
/* 8004ADE0 00052880 */  sll      $a1,$a1,0x2
/* 8004ADE4 24060010 */  li       $a2,16
/* 8004ADE8 afbf0020 */  sw       $ra,32($sp)
/* 8004ADEC 0c0397c5 */  jal      func_800E5F14
/* 8004ADF0 afb00010 */  sw       $s0,16($sp)
/* 8004ADF4 00008021 */  move     $s0,$zero
/* 8004ADF8 1a20000d */  blez     $s1,.L8004AE30
/* 8004ADFC 00402021 */  move     $a0,$v0
/* 8004AE00 00803021 */  move     $a2,$a0
/* 8004AE04 02602821 */  move     $a1,$s3
/* 8004AE08 02401821 */  move     $v1,$s2
.L8004AE0C:
/* 8004AE0C a4700000 */  sh       $s0,0($v1)
/* 8004AE10 8ca20000 */  lw       $v0,0($a1)
/* 8004AE14 24a50004 */  addiu    $a1,$a1,4
/* 8004AE18 24630002 */  addiu    $v1,$v1,2
/* 8004AE1C 26100001 */  addiu    $s0,$s0,1
/* 8004AE20 acc20000 */  sw       $v0,0($a2)
/* 8004AE24 0211102a */  slt      $v0,$s0,$s1
/* 8004AE28 1440fff8 */  bnez     $v0,.L8004AE0C
/* 8004AE2C 24c60004 */  addiu    $a2,$a2,4
.L8004AE30:
/* 8004AE30 24020001 */  li       $v0,1
/* 8004AE34 12220024 */  beq      $s1,$v0,.L8004AEC8
/* 8004AE38 24100001 */  li       $s0,1
/* 8004AE3C 0211102a */  slt      $v0,$s0,$s1
/* 8004AE40 10400021 */  beqz     $v0,.L8004AEC8
/* 8004AE44 264a0002 */  addiu    $t2,$s2,2
/* 8004AE48 24890004 */  addiu    $t1,$a0,4
.L8004AE4C:
/* 8004AE4C 2606ffff */  addiu    $a2,$s0,-1
/* 8004AE50 8d280000 */  lw       $t0,0($t1)
/* 8004AE54 854b0000 */  lh       $t3,0($t2)
/* 8004AE58 04c00010 */  bltz     $a2,.L8004AE9C
/* 8004AE5C 00061040 */  sll      $v0,$a2,0x1
/* 8004AE60 00523821 */  addu     $a3,$v0,$s2
/* 8004AE64 00061080 */  sll      $v0,$a2,0x2
/* 8004AE68 00442821 */  addu     $a1,$v0,$a0
.L8004AE6C:
/* 8004AE6C 8ca30000 */  lw       $v1,0($a1)
/* 8004AE70 00000000 */  nop      
/* 8004AE74 0068102a */  slt      $v0,$v1,$t0
/* 8004AE78 14400008 */  bnez     $v0,.L8004AE9C
/* 8004AE7C 00000000 */  nop      
/* 8004AE80 aca30004 */  sw       $v1,4($a1)
/* 8004AE84 24a5fffc */  addiu    $a1,$a1,-4
/* 8004AE88 94e20000 */  lhu      $v0,0($a3)
/* 8004AE8C 24c6ffff */  addiu    $a2,$a2,-1
/* 8004AE90 a4e20002 */  sh       $v0,2($a3)
/* 8004AE94 04c1fff5 */  bgez     $a2,.L8004AE6C
/* 8004AE98 24e7fffe */  addiu    $a3,$a3,-2
.L8004AE9C:
/* 8004AE9C 254a0002 */  addiu    $t2,$t2,2
/* 8004AEA0 26100001 */  addiu    $s0,$s0,1
/* 8004AEA4 00061080 */  sll      $v0,$a2,0x2
/* 8004AEA8 00441021 */  addu     $v0,$v0,$a0
/* 8004AEAC ac480004 */  sw       $t0,4($v0)
/* 8004AEB0 00061040 */  sll      $v0,$a2,0x1
/* 8004AEB4 00521021 */  addu     $v0,$v0,$s2
/* 8004AEB8 a44b0002 */  sh       $t3,2($v0)
/* 8004AEBC 0211102a */  slt      $v0,$s0,$s1
/* 8004AEC0 1440ffe2 */  bnez     $v0,.L8004AE4C
/* 8004AEC4 25290004 */  addiu    $t1,$t1,4
.L8004AEC8:
/* 8004AEC8 0c039846 */  jal      func_800E6118
/* 8004AECC 00000000 */  nop      
/* 8004AED0 8fbf0020 */  lw       $ra,32($sp)
/* 8004AED4 8fb3001c */  lw       $s3,28($sp)
/* 8004AED8 8fb20018 */  lw       $s2,24($sp)
/* 8004AEDC 8fb10014 */  lw       $s1,20($sp)
/* 8004AEE0 8fb00010 */  lw       $s0,16($sp)
/* 8004AEE4 03e00008 */  jr       $ra
/* 8004AEE8 27bd0028 */  addiu    $sp,$sp,40
