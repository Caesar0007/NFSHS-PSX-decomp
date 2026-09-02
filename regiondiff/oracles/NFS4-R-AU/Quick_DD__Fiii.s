.set noat
.set noreorder

glabel func_8004DC70
/* 8004DC70 27bdffd0 */  addiu    $sp,$sp,-48
/* 8004DC74 afa40010 */  sw       $a0,16($sp)
/* 8004DC78 00002021 */  move     $a0,$zero
/* 8004DC7C afa50014 */  sw       $a1,20($sp)
/* 8004DC80 00802821 */  move     $a1,$a0
/* 8004DC84 afa60018 */  sw       $a2,24($sp)
/* 8004DC88 24060200 */  li       $a2,512
/* 8004DC8C 24070100 */  li       $a3,256
/* 8004DC90 afbf0028 */  sw       $ra,40($sp)
/* 8004DC94 afa0001c */  sw       $zero,28($sp)
/* 8004DC98 afa00020 */  sw       $zero,32($sp)
/* 8004DC9C 0c02fc80 */  jal      func_800BF200
/* 8004DCA0 afa00024 */  sw       $zero,36($sp)
/* 8004DCA4 8fbf0028 */  lw       $ra,40($sp)
/* 8004DCA8 00000000 */  nop      
/* 8004DCAC 03e00008 */  jr       $ra
/* 8004DCB0 27bd0030 */  addiu    $sp,$sp,48
