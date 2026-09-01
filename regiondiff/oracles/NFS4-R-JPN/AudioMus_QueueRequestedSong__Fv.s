.set noat
.set noreorder

glabel func_8007ACE4
/* 8007ACE4 8f8201d8 */  lw       $v0,472($gp)
/* 8007ACE8 27bdffd8 */  addiu    $sp,$sp,-40
/* 8007ACEC afbf0020 */  sw       $ra,32($sp)
/* 8007ACF0 8c43000c */  lw       $v1,12($v0)
/* 8007ACF4 00000000 */  nop      
/* 8007ACF8 00431821 */  addu     $v1,$v0,$v1
/* 8007ACFC 906600e8 */  lbu      $a2,232($v1)
/* 8007AD00 00002821 */  move     $a1,$zero
/* 8007AD04 afa00010 */  sw       $zero,16($sp)
/* 8007AD08 8c440088 */  lw       $a0,136($v0)
/* 8007AD0C 0c039ae4 */  jal      func_800E6B90
/* 8007AD10 27a70018 */  addiu    $a3,$sp,24
/* 8007AD14 8f8601d8 */  lw       $a2,472($gp)
/* 8007AD18 00000000 */  nop      
/* 8007AD1C 8cc40070 */  lw       $a0,112($a2)
/* 8007AD20 00000000 */  nop      
/* 8007AD24 04800008 */  bltz     $a0,.L8007AD48
/* 8007AD28 acc20028 */  sw       $v0,40($a2)
/* 8007AD2C 240503e8 */  li       $a1,1000
/* 8007AD30 8fa70018 */  lw       $a3,24($sp)
/* 8007AD34 0c03a8e0 */  jal      func_800EA380
/* 8007AD38 24c600a8 */  addiu    $a2,$a2,168
/* 8007AD3C 8f8301d8 */  lw       $v1,472($gp)
/* 8007AD40 00000000 */  nop      
/* 8007AD44 ac620074 */  sw       $v0,116($v1)
.L8007AD48:
/* 8007AD48 8f8201d8 */  lw       $v0,472($gp)
/* 8007AD4C 24030002 */  li       $v1,2
/* 8007AD50 ac430014 */  sw       $v1,20($v0)
/* 8007AD54 24430114 */  addiu    $v1,$v0,276
/* 8007AD58 ac400110 */  sw       $zero,272($v0)
/* 8007AD5C ac600018 */  sw       $zero,24($v1)
/* 8007AD60 ac400114 */  sw       $zero,276($v0)
/* 8007AD64 ac600004 */  sw       $zero,4($v1)
/* 8007AD68 ac600008 */  sw       $zero,8($v1)
/* 8007AD6C ac60000c */  sw       $zero,12($v1)
/* 8007AD70 ac600014 */  sw       $zero,20($v1)
/* 8007AD74 8fbf0020 */  lw       $ra,32($sp)
/* 8007AD78 00000000 */  nop      
/* 8007AD7C 03e00008 */  jr       $ra
/* 8007AD80 27bd0028 */  addiu    $sp,$sp,40
