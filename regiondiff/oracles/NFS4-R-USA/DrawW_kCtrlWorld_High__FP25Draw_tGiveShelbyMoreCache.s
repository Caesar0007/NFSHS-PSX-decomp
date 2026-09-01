.set noat
.set noreorder

glabel func_800C7BC8
/* 800C7BC8 27bdffd8 */  addiu    $sp,$sp,-40
/* 800C7BCC afb20018 */  sw       $s2,24($sp)
/* 800C7BD0 00809021 */  move     $s2,$a0
/* 800C7BD4 2402ffff */  li       $v0,-1
/* 800C7BD8 afbf0020 */  sw       $ra,32($sp)
/* 800C7BDC afb3001c */  sw       $s3,28($sp)
/* 800C7BE0 afb10014 */  sw       $s1,20($sp)
/* 800C7BE4 afb00010 */  sw       $s0,16($sp)
/* 800C7BE8 925000e7 */  lbu      $s0,231($s2)
/* 800C7BEC 8e5100e8 */  lw       $s1,232($s2)
/* 800C7BF0 2610ffff */  addiu    $s0,$s0,-1
/* 800C7BF4 12020007 */  beq      $s0,$v0,.L800C7C14
/* 800C7BF8 00409821 */  move     $s3,$v0
.L800C7BFC:
/* 800C7BFC 02402021 */  move     $a0,$s2
/* 800C7C00 0c031ca2 */  jal      func_800C7288
/* 800C7C04 02202821 */  move     $a1,$s1
/* 800C7C08 2610ffff */  addiu    $s0,$s0,-1
/* 800C7C0C 1613fffb */  bne      $s0,$s3,.L800C7BFC
/* 800C7C10 26310006 */  addiu    $s1,$s1,6
.L800C7C14:
/* 800C7C14 8fbf0020 */  lw       $ra,32($sp)
/* 800C7C18 8fb3001c */  lw       $s3,28($sp)
/* 800C7C1C 8fb20018 */  lw       $s2,24($sp)
/* 800C7C20 8fb10014 */  lw       $s1,20($sp)
/* 800C7C24 8fb00010 */  lw       $s0,16($sp)
/* 800C7C28 03e00008 */  jr       $ra
/* 800C7C2C 27bd0028 */  addiu    $sp,$sp,40
