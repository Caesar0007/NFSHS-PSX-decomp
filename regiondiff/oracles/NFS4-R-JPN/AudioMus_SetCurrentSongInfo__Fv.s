.set noat
.set noreorder

glabel func_8007AE0C
/* 8007AE0C 8f8301d8 */  lw       $v1,472($gp)
/* 8007AE10 27bdffe8 */  addiu    $sp,$sp,-24
/* 8007AE14 afbf0010 */  sw       $ra,16($sp)
/* 8007AE18 8c6200a0 */  lw       $v0,160($v1)
/* 8007AE1C 8c65009c */  lw       $a1,156($v1)
/* 8007AE20 24640114 */  addiu    $a0,$v1,276
/* 8007AE24 ac620110 */  sw       $v0,272($v1)
/* 8007AE28 00451021 */  addu     $v0,$v0,$a1
/* 8007AE2C ac820018 */  sw       $v0,24($a0)
/* 8007AE30 8c620028 */  lw       $v0,40($v1)
/* 8007AE34 0c01eb61 */  jal      func_8007AD84
/* 8007AE38 ac620114 */  sw       $v0,276($v1)
/* 8007AE3C 8fbf0010 */  lw       $ra,16($sp)
/* 8007AE40 00000000 */  nop      
/* 8007AE44 03e00008 */  jr       $ra
/* 8007AE48 27bd0018 */  addiu    $sp,$sp,24
