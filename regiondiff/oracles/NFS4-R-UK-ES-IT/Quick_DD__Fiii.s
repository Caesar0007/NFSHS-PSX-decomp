.set noat
.set noreorder

glabel func_8004DCF8
/* 8004DCF8 27bdffd0 */  addiu    $sp,$sp,-48
/* 8004DCFC afa40010 */  sw       $a0,16($sp)
/* 8004DD00 00002021 */  move     $a0,$zero
/* 8004DD04 afa50014 */  sw       $a1,20($sp)
/* 8004DD08 00802821 */  move     $a1,$a0
/* 8004DD0C afa60018 */  sw       $a2,24($sp)
/* 8004DD10 24060200 */  li       $a2,512
/* 8004DD14 24070100 */  li       $a3,256
/* 8004DD18 afbf0028 */  sw       $ra,40($sp)
/* 8004DD1C afa0001c */  sw       $zero,28($sp)
/* 8004DD20 afa00020 */  sw       $zero,32($sp)
/* 8004DD24 0c02fc80 */  jal      func_800BF200
/* 8004DD28 afa00024 */  sw       $zero,36($sp)
/* 8004DD2C 8fbf0028 */  lw       $ra,40($sp)
/* 8004DD30 00000000 */  nop      
/* 8004DD34 03e00008 */  jr       $ra
/* 8004DD38 27bd0030 */  addiu    $sp,$sp,48
