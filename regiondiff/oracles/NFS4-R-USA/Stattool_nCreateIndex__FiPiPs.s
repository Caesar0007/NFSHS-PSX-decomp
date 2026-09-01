.set noat
.set noreorder

glabel func_8004AD40
/* 8004AD40 27bdffd8 */  addiu    $sp,$sp,-40
/* 8004AD44 afb10014 */  sw       $s1,20($sp)
/* 8004AD48 00808821 */  move     $s1,$a0
/* 8004AD4C afb3001c */  sw       $s3,28($sp)
/* 8004AD50 00a09821 */  move     $s3,$a1
/* 8004AD54 afb20018 */  sw       $s2,24($sp)
/* 8004AD58 00c09021 */  move     $s2,$a2
/* 8004AD5C 3c048001 */  lui      $a0,0x8001
/* 8004AD60 248424c4 */  addiu    $a0,$a0,9412
/* 8004AD64 26250001 */  addiu    $a1,$s1,1
/* 8004AD68 00052880 */  sll      $a1,$a1,0x2
/* 8004AD6C 24060010 */  li       $a2,16
/* 8004AD70 afbf0020 */  sw       $ra,32($sp)
/* 8004AD74 0c0397ca */  jal      func_800E5F28
/* 8004AD78 afb00010 */  sw       $s0,16($sp)
/* 8004AD7C 00008021 */  move     $s0,$zero
/* 8004AD80 1a20000d */  blez     $s1,.L8004ADB8
/* 8004AD84 00402021 */  move     $a0,$v0
/* 8004AD88 00803021 */  move     $a2,$a0
/* 8004AD8C 02602821 */  move     $a1,$s3
/* 8004AD90 02401821 */  move     $v1,$s2
.L8004AD94:
/* 8004AD94 a4700000 */  sh       $s0,0($v1)
/* 8004AD98 8ca20000 */  lw       $v0,0($a1)
/* 8004AD9C 24a50004 */  addiu    $a1,$a1,4
/* 8004ADA0 24630002 */  addiu    $v1,$v1,2
/* 8004ADA4 26100001 */  addiu    $s0,$s0,1
/* 8004ADA8 acc20000 */  sw       $v0,0($a2)
/* 8004ADAC 0211102a */  slt      $v0,$s0,$s1
/* 8004ADB0 1440fff8 */  bnez     $v0,.L8004AD94
/* 8004ADB4 24c60004 */  addiu    $a2,$a2,4
.L8004ADB8:
/* 8004ADB8 24020001 */  li       $v0,1
/* 8004ADBC 12220024 */  beq      $s1,$v0,.L8004AE50
/* 8004ADC0 24100001 */  li       $s0,1
/* 8004ADC4 0211102a */  slt      $v0,$s0,$s1
/* 8004ADC8 10400021 */  beqz     $v0,.L8004AE50
/* 8004ADCC 264a0002 */  addiu    $t2,$s2,2
/* 8004ADD0 24890004 */  addiu    $t1,$a0,4
.L8004ADD4:
/* 8004ADD4 2606ffff */  addiu    $a2,$s0,-1
/* 8004ADD8 8d280000 */  lw       $t0,0($t1)
/* 8004ADDC 854b0000 */  lh       $t3,0($t2)
/* 8004ADE0 04c00010 */  bltz     $a2,.L8004AE24
/* 8004ADE4 00061040 */  sll      $v0,$a2,0x1
/* 8004ADE8 00523821 */  addu     $a3,$v0,$s2
/* 8004ADEC 00061080 */  sll      $v0,$a2,0x2
/* 8004ADF0 00442821 */  addu     $a1,$v0,$a0
.L8004ADF4:
/* 8004ADF4 8ca30000 */  lw       $v1,0($a1)
/* 8004ADF8 00000000 */  nop      
/* 8004ADFC 0068102a */  slt      $v0,$v1,$t0
/* 8004AE00 14400008 */  bnez     $v0,.L8004AE24
/* 8004AE04 00000000 */  nop      
/* 8004AE08 aca30004 */  sw       $v1,4($a1)
/* 8004AE0C 24a5fffc */  addiu    $a1,$a1,-4
/* 8004AE10 94e20000 */  lhu      $v0,0($a3)
/* 8004AE14 24c6ffff */  addiu    $a2,$a2,-1
/* 8004AE18 a4e20002 */  sh       $v0,2($a3)
/* 8004AE1C 04c1fff5 */  bgez     $a2,.L8004ADF4
/* 8004AE20 24e7fffe */  addiu    $a3,$a3,-2
.L8004AE24:
/* 8004AE24 254a0002 */  addiu    $t2,$t2,2
/* 8004AE28 26100001 */  addiu    $s0,$s0,1
/* 8004AE2C 00061080 */  sll      $v0,$a2,0x2
/* 8004AE30 00441021 */  addu     $v0,$v0,$a0
/* 8004AE34 ac480004 */  sw       $t0,4($v0)
/* 8004AE38 00061040 */  sll      $v0,$a2,0x1
/* 8004AE3C 00521021 */  addu     $v0,$v0,$s2
/* 8004AE40 a44b0002 */  sh       $t3,2($v0)
/* 8004AE44 0211102a */  slt      $v0,$s0,$s1
/* 8004AE48 1440ffe2 */  bnez     $v0,.L8004ADD4
/* 8004AE4C 25290004 */  addiu    $t1,$t1,4
.L8004AE50:
/* 8004AE50 0c03984b */  jal      func_800E612C
/* 8004AE54 00000000 */  nop      
/* 8004AE58 8fbf0020 */  lw       $ra,32($sp)
/* 8004AE5C 8fb3001c */  lw       $s3,28($sp)
/* 8004AE60 8fb20018 */  lw       $s2,24($sp)
/* 8004AE64 8fb10014 */  lw       $s1,20($sp)
/* 8004AE68 8fb00010 */  lw       $s0,16($sp)
/* 8004AE6C 03e00008 */  jr       $ra
/* 8004AE70 27bd0028 */  addiu    $sp,$sp,40
