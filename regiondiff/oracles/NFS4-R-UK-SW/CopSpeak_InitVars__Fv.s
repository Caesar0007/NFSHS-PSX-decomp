.set noat
.set noreorder

glabel func_8009A714
/* 8009A714 27bdffe8 */  addiu    $sp,$sp,-24
/* 8009A718 afbf0010 */  sw       $ra,16($sp)
/* 8009A71C 00002021 */  move     $a0,$zero
/* 8009A720 3c028011 */  lui      $v0,0x8011
/* 8009A724 24433194 */  addiu    $v1,$v0,12692
.L8009A728:
/* 8009A728 ac600004 */  sw       $zero,4($v1)
/* 8009A72C ac600008 */  sw       $zero,8($v1)
/* 8009A730 24840001 */  addiu    $a0,$a0,1
/* 8009A734 28820004 */  slti     $v0,$a0,4
/* 8009A738 1440fffb */  bnez     $v0,.L8009A728
/* 8009A73C 24630010 */  addiu    $v1,$v1,16
/* 8009A740 2402ffff */  li       $v0,-1
/* 8009A744 af820b68 */  sw       $v0,2920($gp)
/* 8009A748 24027ffc */  li       $v0,32764
/* 8009A74C 3c048011 */  lui      $a0,0x8011
/* 8009A750 af800b80 */  sw       $zero,2944($gp)
/* 8009A754 af800b60 */  sw       $zero,2912($gp)
/* 8009A758 af800b70 */  sw       $zero,2928($gp)
/* 8009A75C af800b74 */  sw       $zero,2932($gp)
/* 8009A760 af800b64 */  sw       $zero,2916($gp)
/* 8009A764 af800b78 */  sw       $zero,2936($gp)
/* 8009A768 a7800b84 */  sh       $zero,2948($gp)
/* 8009A76C a7800b8a */  sh       $zero,2954($gp)
/* 8009A770 a7800b86 */  sh       $zero,2950($gp)
/* 8009A774 af800b7c */  sw       $zero,2940($gp)
/* 8009A778 a7820b88 */  sh       $v0,2952($gp)
/* 8009A77C 0c026835 */  jal      func_8009A0D4
/* 8009A780 248431f4 */  addiu    $a0,$a0,12788
/* 8009A784 8fbf0010 */  lw       $ra,16($sp)
/* 8009A788 00000000 */  nop      
/* 8009A78C 03e00008 */  jr       $ra
/* 8009A790 27bd0018 */  addiu    $sp,$sp,24
