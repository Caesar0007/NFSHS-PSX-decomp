.set noat
.set noreorder

glabel func_8007B40C
/* 8007B40C 8f8201d8 */  lw       $v0,472($gp)
/* 8007B410 2403ffff */  li       $v1,-1
/* 8007B414 ac43000c */  sw       $v1,12($v0)
/* 8007B418 24430114 */  addiu    $v1,$v0,276
/* 8007B41C ac400000 */  sw       $zero,0($v0)
/* 8007B420 ac400020 */  sw       $zero,32($v0)
/* 8007B424 ac400008 */  sw       $zero,8($v0)
/* 8007B428 ac400010 */  sw       $zero,16($v0)
/* 8007B42C ac400018 */  sw       $zero,24($v0)
/* 8007B430 ac400028 */  sw       $zero,40($v0)
/* 8007B434 ac400014 */  sw       $zero,20($v0)
/* 8007B438 ac40001c */  sw       $zero,28($v0)
/* 8007B43C ac400080 */  sw       $zero,128($v0)
/* 8007B440 ac400110 */  sw       $zero,272($v0)
/* 8007B444 ac600018 */  sw       $zero,24($v1)
/* 8007B448 ac400114 */  sw       $zero,276($v0)
/* 8007B44C ac600004 */  sw       $zero,4($v1)
/* 8007B450 ac600008 */  sw       $zero,8($v1)
/* 8007B454 ac60000c */  sw       $zero,12($v1)
/* 8007B458 ac600014 */  sw       $zero,20($v1)
/* 8007B45C 24030001 */  li       $v1,1
/* 8007B460 03e00008 */  jr       $ra
/* 8007B464 ac43007c */  sw       $v1,124($v0)
