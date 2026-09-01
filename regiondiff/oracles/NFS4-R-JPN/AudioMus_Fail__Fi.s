.set noat
.set noreorder

glabel func_8007AC48
/* 8007AC48 8f8201d8 */  lw       $v0,472($gp)
/* 8007AC4C 27bdffe8 */  addiu    $sp,$sp,-24
/* 8007AC50 afbf0014 */  sw       $ra,20($sp)
/* 8007AC54 afb00010 */  sw       $s0,16($sp)
/* 8007AC58 8c43008c */  lw       $v1,140($v0)
/* 8007AC5C 00808021 */  move     $s0,$a0
/* 8007AC60 1060000d */  beqz     $v1,.L8007AC98
/* 8007AC64 ac50001c */  sw       $s0,28($v0)
/* 8007AC68 0c01ea92 */  jal      func_8007AA48
/* 8007AC6C 00000000 */  nop      
/* 8007AC70 8f8301d8 */  lw       $v1,472($gp)
/* 8007AC74 00402821 */  move     $a1,$v0
/* 8007AC78 8c640070 */  lw       $a0,112($v1)
/* 8007AC7C 0c03a94c */  jal      func_800EA530
/* 8007AC80 00003021 */  move     $a2,$zero
/* 8007AC84 0c01ea92 */  jal      func_8007AA48
/* 8007AC88 00000000 */  nop      
/* 8007AC8C 8f8301d8 */  lw       $v1,472($gp)
/* 8007AC90 00000000 */  nop      
/* 8007AC94 ac620020 */  sw       $v0,32($v1)
.L8007AC98:
/* 8007AC98 2402fffb */  li       $v0,-5
/* 8007AC9C 16020005 */  bne      $s0,$v0,.L8007ACB4
/* 8007ACA0 24030001 */  li       $v1,1
/* 8007ACA4 8f8301d8 */  lw       $v1,472($gp)
/* 8007ACA8 24020002 */  li       $v0,2
/* 8007ACAC 0801eb35 */  j        .L8007ACD4
/* 8007ACB0 ac620014 */  sw       $v0,20($v1)
.L8007ACB4:
/* 8007ACB4 8f8201d8 */  lw       $v0,472($gp)
/* 8007ACB8 00000000 */  nop      
/* 8007ACBC ac430018 */  sw       $v1,24($v0)
/* 8007ACC0 2403ffff */  li       $v1,-1
/* 8007ACC4 ac400010 */  sw       $zero,16($v0)
/* 8007ACC8 ac400028 */  sw       $zero,40($v0)
/* 8007ACCC ac430014 */  sw       $v1,20($v0)
/* 8007ACD0 ac43000c */  sw       $v1,12($v0)
.L8007ACD4:
/* 8007ACD4 8fbf0014 */  lw       $ra,20($sp)
/* 8007ACD8 8fb00010 */  lw       $s0,16($sp)
/* 8007ACDC 03e00008 */  jr       $ra
/* 8007ACE0 27bd0018 */  addiu    $sp,$sp,24
