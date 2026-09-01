.set noat
.set noreorder

glabel func_800BBA44
/* 800BBA44 27bdffe8 */  addiu    $sp,$sp,-24
/* 800BBA48 afb00010 */  sw       $s0,16($sp)
/* 800BBA4C 8f900f84 */  lw       $s0,3972($gp)
/* 800BBA50 00000000 */  nop      
/* 800BBA54 12000007 */  beqz     $s0,.L800BBA74
/* 800BBA58 afbf0014 */  sw       $ra,20($sp)
/* 800BBA5C 8e040000 */  lw       $a0,0($s0)
/* 800BBA60 0c039846 */  jal      func_800E6118
/* 800BBA64 00000000 */  nop      
/* 800BBA68 02002021 */  move     $a0,$s0
/* 800BBA6C 0c029245 */  jal      func_800A4914
/* 800BBA70 ac800004 */  sw       $zero,4($a0)
.L800BBA74:
/* 800BBA74 8f840f74 */  lw       $a0,3956($gp)
/* 800BBA78 00000000 */  nop      
/* 800BBA7C 10800005 */  beqz     $a0,.L800BBA94
/* 800BBA80 3c028012 */  lui      $v0,0x8012
/* 800BBA84 0c02ef63 */  jal      func_800BBD8C
/* 800BBA88 24050003 */  li       $a1,3
/* 800BBA8C af800f74 */  sw       $zero,3956($gp)
/* 800BBA90 3c028012 */  lui      $v0,0x8012
.L800BBA94:
/* 800BBA94 2443f474 */  addiu    $v1,$v0,-2956
/* 800BBA98 8c620004 */  lw       $v0,4($v1)
/* 800BBA9C 00000000 */  nop      
/* 800BBAA0 10400002 */  beqz     $v0,.L800BBAAC
/* 800BBAA4 00000000 */  nop      
/* 800BBAA8 ac600004 */  sw       $zero,4($v1)
.L800BBAAC:
/* 800BBAAC 0c01fce3 */  jal      func_8007F38C
/* 800BBAB0 00000000 */  nop      
/* 800BBAB4 0c029df1 */  jal      func_800A77C4
/* 800BBAB8 00000000 */  nop      
/* 800BBABC 0c02e835 */  jal      func_800BA0D4
/* 800BBAC0 00000000 */  nop      
/* 800BBAC4 3c048014 */  lui      $a0,0x8014
/* 800BBAC8 8c84db38 */  lw       $a0,-9416($a0)
/* 800BBACC 00000000 */  nop      
/* 800BBAD0 10800005 */  beqz     $a0,.L800BBAE8
/* 800BBAD4 00000000 */  nop      
/* 800BBAD8 0c039846 */  jal      func_800E6118
/* 800BBADC 00000000 */  nop      
/* 800BBAE0 3c018014 */  lui      $at,0x8014
/* 800BBAE4 ac20db38 */  sw       $zero,-9416($at)
.L800BBAE8:
/* 800BBAE8 8f840f70 */  lw       $a0,3952($gp)
/* 800BBAEC 00000000 */  nop      
/* 800BBAF0 10800003 */  beqz     $a0,.L800BBB00
/* 800BBAF4 00000000 */  nop      
/* 800BBAF8 0c039846 */  jal      func_800E6118
/* 800BBAFC 00000000 */  nop      
.L800BBB00:
/* 800BBB00 8fbf0014 */  lw       $ra,20($sp)
/* 800BBB04 8fb00010 */  lw       $s0,16($sp)
/* 800BBB08 af800f70 */  sw       $zero,3952($gp)
/* 800BBB0C af800f6c */  sw       $zero,3948($gp)
/* 800BBB10 af800f68 */  sw       $zero,3944($gp)
/* 800BBB14 af800f64 */  sw       $zero,3940($gp)
/* 800BBB18 03e00008 */  jr       $ra
/* 800BBB1C 27bd0018 */  addiu    $sp,$sp,24
