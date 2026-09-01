.set noat
.set noreorder

glabel func_800B3F84
/* 800B3F84 27bdffe0 */  addiu    $sp,$sp,-32
/* 800B3F88 afb00010 */  sw       $s0,16($sp)
/* 800B3F8C 00808021 */  move     $s0,$a0
/* 800B3F90 afbf0018 */  sw       $ra,24($sp)
/* 800B3F94 0c01fabc */  jal      func_8007EAF0
/* 800B3F98 afb10014 */  sw       $s1,20($sp)
/* 800B3F9C 0c03482a */  jal      func_800D20A8
/* 800B3FA0 02002021 */  move     $a0,$s0
/* 800B3FA4 3c041f80 */  lui      $a0,0x1f80
/* 800B3FA8 0c039421 */  jal      func_800E5084
/* 800B3FAC 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3FB0 00408821 */  move     $s1,$v0
/* 800B3FB4 0c03924a */  jal      func_800E4928
/* 800B3FB8 02002021 */  move     $a0,$s0
/* 800B3FBC 0c039421 */  jal      func_800E5084
/* 800B3FC0 02202021 */  move     $a0,$s1
/* 800B3FC4 0c02d1d1 */  jal      func_800B4744
/* 800B3FC8 00000000 */  nop      
/* 800B3FCC 3c041f80 */  lui      $a0,0x1f80
/* 800B3FD0 0c039421 */  jal      func_800E5084
/* 800B3FD4 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3FD8 00408821 */  move     $s1,$v0
/* 800B3FDC 0c038027 */  jal      func_800E009C
/* 800B3FE0 02002021 */  move     $a0,$s0
/* 800B3FE4 0c039421 */  jal      func_800E5084
/* 800B3FE8 02202021 */  move     $a0,$s1
/* 800B3FEC 3c041f80 */  lui      $a0,0x1f80
/* 800B3FF0 0c039421 */  jal      func_800E5084
/* 800B3FF4 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3FF8 00408821 */  move     $s1,$v0
/* 800B3FFC 0c02e2b0 */  jal      func_800B8AC0
/* 800B4000 02002021 */  move     $a0,$s0
/* 800B4004 0c039421 */  jal      func_800E5084
/* 800B4008 02202021 */  move     $a0,$s1
/* 800B400C 0c02ce31 */  jal      func_800B38C4
/* 800B4010 02002021 */  move     $a0,$s0
/* 800B4014 8fbf0018 */  lw       $ra,24($sp)
/* 800B4018 8fb10014 */  lw       $s1,20($sp)
/* 800B401C 8fb00010 */  lw       $s0,16($sp)
/* 800B4020 03e00008 */  jr       $ra
/* 800B4024 27bd0020 */  addiu    $sp,$sp,32
