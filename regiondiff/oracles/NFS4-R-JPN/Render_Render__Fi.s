.set noat
.set noreorder

glabel func_800B3F24
/* 800B3F24 27bdffe8 */  addiu    $sp,$sp,-24
/* 800B3F28 afbf0014 */  sw       $ra,20($sp)
/* 800B3F2C 1080002a */  beqz     $a0,.L800B3FD8
/* 800B3F30 afb00010 */  sw       $s0,16($sp)
/* 800B3F34 8f820e84 */  lw       $v0,3716($gp)
/* 800B3F38 00000000 */  nop      
/* 800B3F3C 14400012 */  bnez     $v0,.L800B3F88
/* 800B3F40 24100001 */  li       $s0,1
/* 800B3F44 24020140 */  li       $v0,320
/* 800B3F48 a7820e80 */  sh       $v0,3712($gp)
/* 800B3F4C 240200f0 */  li       $v0,240
/* 800B3F50 af900e84 */  sw       $s0,3716($gp)
/* 800B3F54 a7800e7c */  sh       $zero,3708($gp)
/* 800B3F58 a7800e7e */  sh       $zero,3710($gp)
/* 800B3F5C a7820e82 */  sh       $v0,3714($gp)
/* 800B3F60 0c03b7f1 */  jal      func_800EDFC4
/* 800B3F64 00002021 */  move     $a0,$zero
/* 800B3F68 0c03762f */  jal      func_800DD8BC
/* 800B3F6C 00000000 */  nop      
/* 800B3F70 0c027de3 */  jal      func_8009F78C
/* 800B3F74 00000000 */  nop      
/* 800B3F78 3c018014 */  lui      $at,0x8014
/* 800B3F7C ac30e328 */  sw       $s0,-7384($at)
/* 800B3F80 3c018014 */  lui      $at,0x8014
/* 800B3F84 ac20e304 */  sw       $zero,-7420($at)
.L800B3F88:
/* 800B3F88 3c038014 */  lui      $v1,0x8014
/* 800B3F8C 8c63e328 */  lw       $v1,-7384($v1)
/* 800B3F90 2402004e */  li       $v0,78
/* 800B3F94 a7820e7c */  sh       $v0,3708($gp)
/* 800B3F98 24020062 */  li       $v0,98
/* 800B3F9C a7820e7e */  sh       $v0,3710($gp)
/* 800B3FA0 240200a4 */  li       $v0,164
/* 800B3FA4 a7820e80 */  sh       $v0,3712($gp)
/* 800B3FA8 2402008b */  li       $v0,139
/* 800B3FAC a7820e82 */  sh       $v0,3714($gp)
/* 800B3FB0 1060002a */  beqz     $v1,.L800B405C
/* 800B3FB4 00000000 */  nop      
/* 800B3FB8 0c03765f */  jal      func_800DD97C
/* 800B3FBC 00000000 */  nop      
/* 800B3FC0 0c02cfab */  jal      func_800B3EAC
/* 800B3FC4 00000000 */  nop      
/* 800B3FC8 0c037667 */  jal      func_800DD99C
/* 800B3FCC 00000000 */  nop      
/* 800B3FD0 0802d017 */  j        .L800B405C
/* 800B3FD4 00000000 */  nop      
.L800B3FD8:
/* 800B3FD8 8f820e84 */  lw       $v0,3716($gp)
/* 800B3FDC 00000000 */  nop      
/* 800B3FE0 10400004 */  beqz     $v0,.L800B3FF4
/* 800B3FE4 3c028011 */  lui      $v0,0x8011
/* 800B3FE8 af800e84 */  sw       $zero,3716($gp)
/* 800B3FEC 0802d017 */  j        .L800B405C
/* 800B3FF0 00000000 */  nop      
.L800B3FF4:
/* 800B3FF4 8c43429c */  lw       $v1,17052($v0)
/* 800B3FF8 24020001 */  li       $v0,1
/* 800B3FFC 1462000b */  bne      $v1,$v0,.L800B402C
/* 800B4000 00000000 */  nop      
/* 800B4004 0c02cf8b */  jal      func_800B3E2C
/* 800B4008 00000000 */  nop      
/* 800B400C 0c03668c */  jal      func_800D9A30
/* 800B4010 00000000 */  nop      
/* 800B4014 8f840e74 */  lw       $a0,3700($gp)
/* 800B4018 0c02cf76 */  jal      func_800B3DD8
/* 800B401C 00002821 */  move     $a1,$zero
/* 800B4020 8f840e78 */  lw       $a0,3704($gp)
/* 800B4024 0802d011 */  j        .L800B4044
/* 800B4028 24050001 */  li       $a1,1
.L800B402C:
/* 800B402C 0c02cf8b */  jal      func_800B3E2C
/* 800B4030 00000000 */  nop      
/* 800B4034 0c03668c */  jal      func_800D9A30
/* 800B4038 00000000 */  nop      
/* 800B403C 8f840e74 */  lw       $a0,3700($gp)
/* 800B4040 00002821 */  move     $a1,$zero
.L800B4044:
/* 800B4044 0c02cf76 */  jal      func_800B3DD8
/* 800B4048 00000000 */  nop      
/* 800B404C 0c02cf89 */  jal      func_800B3E24
/* 800B4050 00000000 */  nop      
/* 800B4054 0c02cf9b */  jal      func_800B3E6C
/* 800B4058 00000000 */  nop      
.L800B405C:
/* 800B405C 8fbf0014 */  lw       $ra,20($sp)
/* 800B4060 8fb00010 */  lw       $s0,16($sp)
/* 800B4064 03e00008 */  jr       $ra
/* 800B4068 27bd0018 */  addiu    $sp,$sp,24
