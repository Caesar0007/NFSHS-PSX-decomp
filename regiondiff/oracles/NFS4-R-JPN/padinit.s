.set noat
.set noreorder

glabel func_800E4AE0
/* 800E4AE0 27bdffe0 */  addiu    $sp,$sp,-32
/* 800E4AE4 afb00010 */  sw       $s0,16($sp)
/* 800E4AE8 3c108014 */  lui      $s0,0x8014
/* 800E4AEC 8e02f990 */  lw       $v0,-1648($s0)
/* 800E4AF0 afb10014 */  sw       $s1,20($sp)
/* 800E4AF4 2611f990 */  addiu    $s1,$s0,-1648
/* 800E4AF8 1440000f */  bnez     $v0,.L800E4B38
/* 800E4AFC afbf0018 */  sw       $ra,24($sp)
/* 800E4B00 3c048014 */  lui      $a0,0x8014
/* 800E4B04 2484f9e4 */  addiu    $a0,$a0,-1564
/* 800E4B08 0c03f930 */  jal      func_800FE4C0
/* 800E4B0C 24850022 */  addiu    $a1,$a0,34
/* 800E4B10 0c03c16a */  jal      func_800F05A8
/* 800E4B14 00000000 */  nop      
/* 800E4B18 02202021 */  move     $a0,$s1
/* 800E4B1C 0c03c8b0 */  jal      func_800F22C0
/* 800E4B20 24050054 */  li       $a1,84
/* 800E4B24 24020001 */  li       $v0,1
/* 800E4B28 ae02f990 */  sw       $v0,-1648($s0)
/* 800E4B2C 3c04800e */  lui      $a0,0x800e
/* 800E4B30 0c03adcc */  jal      func_800EB730
/* 800E4B34 24844bf4 */  addiu    $a0,$a0,19444
.L800E4B38:
/* 800E4B38 8fbf0018 */  lw       $ra,24($sp)
/* 800E4B3C 8fb10014 */  lw       $s1,20($sp)
/* 800E4B40 8fb00010 */  lw       $s0,16($sp)
/* 800E4B44 03e00008 */  jr       $ra
/* 800E4B48 27bd0020 */  addiu    $sp,$sp,32
