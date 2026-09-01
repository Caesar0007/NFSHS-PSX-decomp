.set noat
.set noreorder

glabel func_800C7BF4
/* 800C7BF4 27bdffd8 */  addiu    $sp,$sp,-40
/* 800C7BF8 afb20018 */  sw       $s2,24($sp)
/* 800C7BFC 00809021 */  move     $s2,$a0
/* 800C7C00 2402ffff */  li       $v0,-1
/* 800C7C04 afbf0020 */  sw       $ra,32($sp)
/* 800C7C08 afb3001c */  sw       $s3,28($sp)
/* 800C7C0C afb10014 */  sw       $s1,20($sp)
/* 800C7C10 afb00010 */  sw       $s0,16($sp)
/* 800C7C14 925000e7 */  lbu      $s0,231($s2)
/* 800C7C18 8e5100e8 */  lw       $s1,232($s2)
/* 800C7C1C 2610ffff */  addiu    $s0,$s0,-1
/* 800C7C20 12020007 */  beq      $s0,$v0,.L800C7C40
/* 800C7C24 00409821 */  move     $s3,$v0
.L800C7C28:
/* 800C7C28 02402021 */  move     $a0,$s2
/* 800C7C2C 0c031cad */  jal      func_800C72B4
/* 800C7C30 02202821 */  move     $a1,$s1
/* 800C7C34 2610ffff */  addiu    $s0,$s0,-1
/* 800C7C38 1613fffb */  bne      $s0,$s3,.L800C7C28
/* 800C7C3C 26310006 */  addiu    $s1,$s1,6
.L800C7C40:
/* 800C7C40 8fbf0020 */  lw       $ra,32($sp)
/* 800C7C44 8fb3001c */  lw       $s3,28($sp)
/* 800C7C48 8fb20018 */  lw       $s2,24($sp)
/* 800C7C4C 8fb10014 */  lw       $s1,20($sp)
/* 800C7C50 8fb00010 */  lw       $s0,16($sp)
/* 800C7C54 03e00008 */  jr       $ra
/* 800C7C58 27bd0028 */  addiu    $sp,$sp,40
