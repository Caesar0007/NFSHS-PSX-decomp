.set noat
.set noreorder

glabel func_800BBA40
/* 800BBA40 27bdffe8 */  addiu    $sp,$sp,-24
/* 800BBA44 afb00010 */  sw       $s0,16($sp)
/* 800BBA48 8f900f84 */  lw       $s0,3972($gp)
/* 800BBA4C 00000000 */  nop      
/* 800BBA50 12000007 */  beqz     $s0,.L800BBA70
/* 800BBA54 afbf0014 */  sw       $ra,20($sp)
/* 800BBA58 8e040000 */  lw       $a0,0($s0)
/* 800BBA5C 0c03984b */  jal      func_800E612C
/* 800BBA60 00000000 */  nop      
/* 800BBA64 02002021 */  move     $a0,$s0
/* 800BBA68 0c029244 */  jal      func_800A4910
/* 800BBA6C ac800004 */  sw       $zero,4($a0)
.L800BBA70:
/* 800BBA70 8f840f74 */  lw       $a0,3956($gp)
/* 800BBA74 00000000 */  nop      
/* 800BBA78 10800005 */  beqz     $a0,.L800BBA90
/* 800BBA7C 3c028012 */  lui      $v0,0x8012
/* 800BBA80 0c02ef62 */  jal      func_800BBD88
/* 800BBA84 24050003 */  li       $a1,3
/* 800BBA88 af800f74 */  sw       $zero,3956($gp)
/* 800BBA8C 3c028012 */  lui      $v0,0x8012
.L800BBA90:
/* 800BBA90 2443f448 */  addiu    $v1,$v0,-3000
/* 800BBA94 8c620004 */  lw       $v0,4($v1)
/* 800BBA98 00000000 */  nop      
/* 800BBA9C 10400002 */  beqz     $v0,.L800BBAA8
/* 800BBAA0 00000000 */  nop      
/* 800BBAA4 ac600004 */  sw       $zero,4($v1)
.L800BBAA8:
/* 800BBAA8 0c01fce3 */  jal      func_8007F38C
/* 800BBAAC 00000000 */  nop      
/* 800BBAB0 0c029df0 */  jal      func_800A77C0
/* 800BBAB4 00000000 */  nop      
/* 800BBAB8 0c02e834 */  jal      func_800BA0D0
/* 800BBABC 00000000 */  nop      
/* 800BBAC0 3c048014 */  lui      $a0,0x8014
/* 800BBAC4 8c84db0c */  lw       $a0,-9460($a0)
/* 800BBAC8 00000000 */  nop      
/* 800BBACC 10800005 */  beqz     $a0,.L800BBAE4
/* 800BBAD0 00000000 */  nop      
/* 800BBAD4 0c03984b */  jal      func_800E612C
/* 800BBAD8 00000000 */  nop      
/* 800BBADC 3c018014 */  lui      $at,0x8014
/* 800BBAE0 ac20db0c */  sw       $zero,-9460($at)
.L800BBAE4:
/* 800BBAE4 8f840f70 */  lw       $a0,3952($gp)
/* 800BBAE8 00000000 */  nop      
/* 800BBAEC 10800003 */  beqz     $a0,.L800BBAFC
/* 800BBAF0 00000000 */  nop      
/* 800BBAF4 0c03984b */  jal      func_800E612C
/* 800BBAF8 00000000 */  nop      
.L800BBAFC:
/* 800BBAFC 8fbf0014 */  lw       $ra,20($sp)
/* 800BBB00 8fb00010 */  lw       $s0,16($sp)
/* 800BBB04 af800f70 */  sw       $zero,3952($gp)
/* 800BBB08 af800f6c */  sw       $zero,3948($gp)
/* 800BBB0C af800f68 */  sw       $zero,3944($gp)
/* 800BBB10 af800f64 */  sw       $zero,3940($gp)
/* 800BBB14 03e00008 */  jr       $ra
/* 800BBB18 27bd0018 */  addiu    $sp,$sp,24
