.set noat
.set noreorder

glabel func_800E4CE0
/* 800E4CE0 27bdffe0 */  addiu    $sp,$sp,-32
/* 800E4CE4 afb00010 */  sw       $s0,16($sp)
/* 800E4CE8 3c108014 */  lui      $s0,0x8014
/* 800E4CEC 8e02fbd0 */  lw       $v0,-1072($s0)
/* 800E4CF0 afb10014 */  sw       $s1,20($sp)
/* 800E4CF4 2611fbd0 */  addiu    $s1,$s0,-1072
/* 800E4CF8 1440000f */  bnez     $v0,.L800E4D38
/* 800E4CFC afbf0018 */  sw       $ra,24($sp)
/* 800E4D00 3c048014 */  lui      $a0,0x8014
/* 800E4D04 2484fc24 */  addiu    $a0,$a0,-988
/* 800E4D08 0c03f9c0 */  jal      func_800FE700
/* 800E4D0C 24850022 */  addiu    $a1,$a0,34
/* 800E4D10 0c03c1fa */  jal      func_800F07E8
/* 800E4D14 00000000 */  nop      
/* 800E4D18 02202021 */  move     $a0,$s1
/* 800E4D1C 0c03c940 */  jal      func_800F2500
/* 800E4D20 24050054 */  li       $a1,84
/* 800E4D24 24020001 */  li       $v0,1
/* 800E4D28 ae02fbd0 */  sw       $v0,-1072($s0)
/* 800E4D2C 3c04800e */  lui      $a0,0x800e
/* 800E4D30 0c03ae4c */  jal      func_800EB930
/* 800E4D34 24844df4 */  addiu    $a0,$a0,19956
.L800E4D38:
/* 800E4D38 8fbf0018 */  lw       $ra,24($sp)
/* 800E4D3C 8fb10014 */  lw       $s1,20($sp)
/* 800E4D40 8fb00010 */  lw       $s0,16($sp)
/* 800E4D44 03e00008 */  jr       $ra
/* 800E4D48 27bd0020 */  addiu    $sp,$sp,32
