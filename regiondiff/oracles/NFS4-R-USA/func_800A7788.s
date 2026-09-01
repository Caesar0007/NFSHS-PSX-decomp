.set noat
.set noreorder

glabel func_800A7788
/* 800A7788 27bdffe8 */  addiu    $sp,$sp,-24
/* 800A778C 3c028005 */  lui      $v0,0x8005
/* 800A7790 00042840 */  sll      $a1,$a0,0x1
/* 800A7794 00a42821 */  addu     $a1,$a1,$a0
/* 800A7798 24446830 */  addiu    $a0,$v0,26672
/* 800A779C 00052900 */  sll      $a1,$a1,0x4
/* 800A77A0 afbf0010 */  sw       $ra,16($sp)
/* 800A77A4 0c0397ca */  jal      func_800E5F28
/* 800A77A8 00003021 */  move     $a2,$zero
/* 800A77AC 8fbf0010 */  lw       $ra,16($sp)
/* 800A77B0 af820d80 */  sw       $v0,3456($gp)
/* 800A77B4 af800d84 */  sw       $zero,3460($gp)
/* 800A77B8 03e00008 */  jr       $ra
/* 800A77BC 27bd0018 */  addiu    $sp,$sp,24
