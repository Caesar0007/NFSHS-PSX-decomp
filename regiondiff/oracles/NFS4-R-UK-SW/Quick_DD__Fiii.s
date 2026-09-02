.set noat
.set noreorder

glabel func_8004DCE0
/* 8004DCE0 27bdffd0 */  addiu    $sp,$sp,-48
/* 8004DCE4 afa40010 */  sw       $a0,16($sp)
/* 8004DCE8 00002021 */  move     $a0,$zero
/* 8004DCEC afa50014 */  sw       $a1,20($sp)
/* 8004DCF0 00802821 */  move     $a1,$a0
/* 8004DCF4 afa60018 */  sw       $a2,24($sp)
/* 8004DCF8 24060200 */  li       $a2,512
/* 8004DCFC 24070100 */  li       $a3,256
/* 8004DD00 afbf0028 */  sw       $ra,40($sp)
/* 8004DD04 afa0001c */  sw       $zero,28($sp)
/* 8004DD08 afa00020 */  sw       $zero,32($sp)
/* 8004DD0C 0c02fc80 */  jal      func_800BF200
/* 8004DD10 afa00024 */  sw       $zero,36($sp)
/* 8004DD14 8fbf0028 */  lw       $ra,40($sp)
/* 8004DD18 00000000 */  nop      
/* 8004DD1C 03e00008 */  jr       $ra
/* 8004DD20 27bd0030 */  addiu    $sp,$sp,48
