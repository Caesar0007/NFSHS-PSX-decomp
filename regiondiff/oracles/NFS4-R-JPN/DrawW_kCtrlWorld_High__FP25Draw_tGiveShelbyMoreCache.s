.set noat
.set noreorder

glabel func_800C79B4
/* 800C79B4 27bdffd8 */  addiu    $sp,$sp,-40
/* 800C79B8 afb20018 */  sw       $s2,24($sp)
/* 800C79BC 00809021 */  move     $s2,$a0
/* 800C79C0 2402ffff */  li       $v0,-1
/* 800C79C4 afbf0020 */  sw       $ra,32($sp)
/* 800C79C8 afb3001c */  sw       $s3,28($sp)
/* 800C79CC afb10014 */  sw       $s1,20($sp)
/* 800C79D0 afb00010 */  sw       $s0,16($sp)
/* 800C79D4 925000e7 */  lbu      $s0,231($s2)
/* 800C79D8 8e5100e8 */  lw       $s1,232($s2)
/* 800C79DC 2610ffff */  addiu    $s0,$s0,-1
/* 800C79E0 12020007 */  beq      $s0,$v0,.L800C7A00
/* 800C79E4 00409821 */  move     $s3,$v0
.L800C79E8:
/* 800C79E8 02402021 */  move     $a0,$s2
/* 800C79EC 0c031c1d */  jal      func_800C7074
/* 800C79F0 02202821 */  move     $a1,$s1
/* 800C79F4 2610ffff */  addiu    $s0,$s0,-1
/* 800C79F8 1613fffb */  bne      $s0,$s3,.L800C79E8
/* 800C79FC 26310006 */  addiu    $s1,$s1,6
.L800C7A00:
/* 800C7A00 8fbf0020 */  lw       $ra,32($sp)
/* 800C7A04 8fb3001c */  lw       $s3,28($sp)
/* 800C7A08 8fb20018 */  lw       $s2,24($sp)
/* 800C7A0C 8fb10014 */  lw       $s1,20($sp)
/* 800C7A10 8fb00010 */  lw       $s0,16($sp)
/* 800C7A14 03e00008 */  jr       $ra
/* 800C7A18 27bd0028 */  addiu    $sp,$sp,40
