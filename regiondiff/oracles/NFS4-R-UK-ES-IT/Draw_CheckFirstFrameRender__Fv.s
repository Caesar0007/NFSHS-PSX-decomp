.set noat
.set noreorder

glabel func_800BEFB8
/* 800BEFB8 27bdffd0 */  addiu    $sp,$sp,-48
/* 800BEFBC 8f831260 */  lw       $v1,4704($gp)
/* 800BEFC0 2402ffff */  li       $v0,-1
/* 800BEFC4 afbf002c */  sw       $ra,44($sp)
/* 800BEFC8 1462001b */  bne      $v1,$v0,.L800BF038
/* 800BEFCC afb00028 */  sw       $s0,40($sp)
/* 800BEFD0 24040140 */  li       $a0,320
/* 800BEFD4 24050100 */  li       $a1,256
/* 800BEFD8 00803021 */  move     $a2,$a0
/* 800BEFDC 00a03821 */  move     $a3,$a1
/* 800BEFE0 24100001 */  li       $s0,1
/* 800BEFE4 afb00010 */  sw       $s0,16($sp)
/* 800BEFE8 afa00014 */  sw       $zero,20($sp)
/* 800BEFEC afb00018 */  sw       $s0,24($sp)
/* 800BEFF0 afa0001c */  sw       $zero,28($sp)
/* 800BEFF4 afa00020 */  sw       $zero,32($sp)
/* 800BEFF8 0c02fc80 */  jal      func_800BF200
/* 800BEFFC afa00024 */  sw       $zero,36($sp)
/* 800BF000 00002021 */  move     $a0,$zero
/* 800BF004 24050100 */  li       $a1,256
/* 800BF008 24060140 */  li       $a2,320
/* 800BF00C 00a03821 */  move     $a3,$a1
/* 800BF010 afb00010 */  sw       $s0,16($sp)
/* 800BF014 afb00014 */  sw       $s0,20($sp)
/* 800BF018 afb00018 */  sw       $s0,24($sp)
/* 800BF01C afa0001c */  sw       $zero,28($sp)
/* 800BF020 afa00020 */  sw       $zero,32($sp)
/* 800BF024 0c02fc80 */  jal      func_800BF200
/* 800BF028 afa00024 */  sw       $zero,36($sp)
/* 800BF02C af901260 */  sw       $s0,4704($gp)
/* 800BF030 0c02fb14 */  jal      func_800BEC50
/* 800BF034 00000000 */  nop      
.L800BF038:
/* 800BF038 8fbf002c */  lw       $ra,44($sp)
/* 800BF03C 8fb00028 */  lw       $s0,40($sp)
/* 800BF040 03e00008 */  jr       $ra
/* 800BF044 27bd0030 */  addiu    $sp,$sp,48
