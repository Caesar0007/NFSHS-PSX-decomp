.set noat
.set noreorder

glabel func_800B3E64
/* 800B3E64 27bdffd0 */  addiu    $sp,$sp,-48
/* 800B3E68 24020140 */  li       $v0,320
/* 800B3E6C afa20010 */  sw       $v0,16($sp)
/* 800B3E70 24020100 */  li       $v0,256
/* 800B3E74 afa20014 */  sw       $v0,20($sp)
/* 800B3E78 24020001 */  li       $v0,1
/* 800B3E7C 00002021 */  move     $a0,$zero
/* 800B3E80 24050100 */  li       $a1,256
/* 800B3E84 24060140 */  li       $a2,320
/* 800B3E88 00a03821 */  move     $a3,$a1
/* 800B3E8C afbf0028 */  sw       $ra,40($sp)
/* 800B3E90 afa00018 */  sw       $zero,24($sp)
/* 800B3E94 afa0001c */  sw       $zero,28($sp)
/* 800B3E98 0c02fa2b */  jal      func_800BE8AC
/* 800B3E9C afa20020 */  sw       $v0,32($sp)
/* 800B3EA0 8fbf0028 */  lw       $ra,40($sp)
/* 800B3EA4 af820e90 */  sw       $v0,3728($gp)
/* 800B3EA8 03e00008 */  jr       $ra
/* 800B3EAC 27bd0030 */  addiu    $sp,$sp,48
