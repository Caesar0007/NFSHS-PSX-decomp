.set noat
.set noreorder

glabel func_800E4CF4
/* 800E4CF4 27bdffe0 */  addiu    $sp,$sp,-32
/* 800E4CF8 afb00010 */  sw       $s0,16($sp)
/* 800E4CFC 3c108014 */  lui      $s0,0x8014
/* 800E4D00 8e02fba4 */  lw       $v0,-1116($s0)
/* 800E4D04 afb10014 */  sw       $s1,20($sp)
/* 800E4D08 2611fba4 */  addiu    $s1,$s0,-1116
/* 800E4D0C 1440000f */  bnez     $v0,.L800E4D4C
/* 800E4D10 afbf0018 */  sw       $ra,24($sp)
/* 800E4D14 3c048014 */  lui      $a0,0x8014
/* 800E4D18 2484fbf8 */  addiu    $a0,$a0,-1032
/* 800E4D1C 0c03f9b5 */  jal      func_800FE6D4
/* 800E4D20 24850022 */  addiu    $a1,$a0,34
/* 800E4D24 0c03c1ef */  jal      func_800F07BC
/* 800E4D28 00000000 */  nop      
/* 800E4D2C 02202021 */  move     $a0,$s1
/* 800E4D30 0c03c935 */  jal      func_800F24D4
/* 800E4D34 24050054 */  li       $a1,84
/* 800E4D38 24020001 */  li       $v0,1
/* 800E4D3C ae02fba4 */  sw       $v0,-1116($s0)
/* 800E4D40 3c04800e */  lui      $a0,0x800e
/* 800E4D44 0c03ae51 */  jal      func_800EB944
/* 800E4D48 24844e08 */  addiu    $a0,$a0,19976
.L800E4D4C:
/* 800E4D4C 8fbf0018 */  lw       $ra,24($sp)
/* 800E4D50 8fb10014 */  lw       $s1,20($sp)
/* 800E4D54 8fb00010 */  lw       $s0,16($sp)
/* 800E4D58 03e00008 */  jr       $ra
/* 800E4D5C 27bd0020 */  addiu    $sp,$sp,32
