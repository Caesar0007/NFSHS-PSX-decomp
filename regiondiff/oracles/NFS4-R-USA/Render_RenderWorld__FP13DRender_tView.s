.set noat
.set noreorder

glabel func_800B3F80
/* 800B3F80 27bdffe0 */  addiu    $sp,$sp,-32
/* 800B3F84 afb00010 */  sw       $s0,16($sp)
/* 800B3F88 00808021 */  move     $s0,$a0
/* 800B3F8C afbf0018 */  sw       $ra,24($sp)
/* 800B3F90 0c01fabc */  jal      func_8007EAF0
/* 800B3F94 afb10014 */  sw       $s1,20($sp)
/* 800B3F98 0c03481f */  jal      func_800D207C
/* 800B3F9C 02002021 */  move     $a0,$s0
/* 800B3FA0 3c041f80 */  lui      $a0,0x1f80
/* 800B3FA4 0c039426 */  jal      func_800E5098
/* 800B3FA8 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3FAC 00408821 */  move     $s1,$v0
/* 800B3FB0 0c03924f */  jal      func_800E493C
/* 800B3FB4 02002021 */  move     $a0,$s0
/* 800B3FB8 0c039426 */  jal      func_800E5098
/* 800B3FBC 02202021 */  move     $a0,$s1
/* 800B3FC0 0c02d1d0 */  jal      func_800B4740
/* 800B3FC4 00000000 */  nop      
/* 800B3FC8 3c041f80 */  lui      $a0,0x1f80
/* 800B3FCC 0c039426 */  jal      func_800E5098
/* 800B3FD0 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3FD4 00408821 */  move     $s1,$v0
/* 800B3FD8 0c03801c */  jal      func_800E0070
/* 800B3FDC 02002021 */  move     $a0,$s0
/* 800B3FE0 0c039426 */  jal      func_800E5098
/* 800B3FE4 02202021 */  move     $a0,$s1
/* 800B3FE8 3c041f80 */  lui      $a0,0x1f80
/* 800B3FEC 0c039426 */  jal      func_800E5098
/* 800B3FF0 348403fc */  ori      $a0,$a0,0x3fc
/* 800B3FF4 00408821 */  move     $s1,$v0
/* 800B3FF8 0c02e2af */  jal      func_800B8ABC
/* 800B3FFC 02002021 */  move     $a0,$s0
/* 800B4000 0c039426 */  jal      func_800E5098
/* 800B4004 02202021 */  move     $a0,$s1
/* 800B4008 0c02ce30 */  jal      func_800B38C0
/* 800B400C 02002021 */  move     $a0,$s0
/* 800B4010 8fbf0018 */  lw       $ra,24($sp)
/* 800B4014 8fb10014 */  lw       $s1,20($sp)
/* 800B4018 8fb00010 */  lw       $s0,16($sp)
/* 800B401C 03e00008 */  jr       $ra
/* 800B4020 27bd0020 */  addiu    $sp,$sp,32
