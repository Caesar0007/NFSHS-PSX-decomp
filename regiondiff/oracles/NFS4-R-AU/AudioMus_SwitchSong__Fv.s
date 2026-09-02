.set noat
.set noreorder

glabel func_8007AB50
/* 8007AB50 8f8301d8 */  lw       $v1,472($gp)
/* 8007AB54 27bdffe8 */  addiu    $sp,$sp,-24
/* 8007AB58 10600037 */  beqz     $v1,.L8007AC38
/* 8007AB5C afbf0010 */  sw       $ra,16($sp)
/* 8007AB60 8c620008 */  lw       $v0,8($v1)
/* 8007AB64 00000000 */  nop      
/* 8007AB68 10400033 */  beqz     $v0,.L8007AC38
/* 8007AB6C 00000000 */  nop      
/* 8007AB70 8c620000 */  lw       $v0,0($v1)
/* 8007AB74 00000000 */  nop      
/* 8007AB78 1840002f */  blez     $v0,.L8007AC38
/* 8007AB7C 24020001 */  li       $v0,1
/* 8007AB80 ac620018 */  sw       $v0,24($v1)
/* 8007AB84 24620114 */  addiu    $v0,$v1,276
/* 8007AB88 ac600028 */  sw       $zero,40($v1)
/* 8007AB8C ac60001c */  sw       $zero,28($v1)
/* 8007AB90 ac600110 */  sw       $zero,272($v1)
/* 8007AB94 ac400018 */  sw       $zero,24($v0)
/* 8007AB98 ac600114 */  sw       $zero,276($v1)
/* 8007AB9C ac400004 */  sw       $zero,4($v0)
/* 8007ABA0 ac400008 */  sw       $zero,8($v0)
/* 8007ABA4 ac40000c */  sw       $zero,12($v0)
/* 8007ABA8 ac400014 */  sw       $zero,20($v0)
/* 8007ABAC 8c620014 */  lw       $v0,20($v1)
/* 8007ABB0 00000000 */  nop      
/* 8007ABB4 1440000b */  bnez     $v0,.L8007ABE4
/* 8007ABB8 00000000 */  nop      
/* 8007ABBC 8c62000c */  lw       $v0,12($v1)
/* 8007ABC0 00000000 */  nop      
/* 8007ABC4 04400007 */  bltz     $v0,.L8007ABE4
/* 8007ABC8 240507d0 */  li       $a1,2000
/* 8007ABCC 8c640070 */  lw       $a0,112($v1)
/* 8007ABD0 0c03a9cc */  jal      func_800EA730
/* 8007ABD4 00003021 */  move     $a2,$zero
/* 8007ABD8 8f8301d8 */  lw       $v1,472($gp)
/* 8007ABDC 240203e8 */  li       $v0,1000
/* 8007ABE0 ac620020 */  sw       $v0,32($v1)
.L8007ABE4:
/* 8007ABE4 8f8401d8 */  lw       $a0,472($gp)
/* 8007ABE8 00000000 */  nop      
/* 8007ABEC 8c82000c */  lw       $v0,12($a0)
/* 8007ABF0 3c038014 */  lui      $v1,0x8014
/* 8007ABF4 8c63ec4c */  lw       $v1,-5044($v1)
/* 8007ABF8 24450001 */  addiu    $a1,$v0,1
/* 8007ABFC 14600006 */  bnez     $v1,.L8007AC18
/* 8007AC00 ac85000c */  sw       $a1,12($a0)
/* 8007AC04 8c820008 */  lw       $v0,8($a0)
/* 8007AC08 00000000 */  nop      
/* 8007AC0C 00a2102a */  slt      $v0,$a1,$v0
/* 8007AC10 14400008 */  bnez     $v0,.L8007AC34
/* 8007AC14 24020001 */  li       $v0,1
.L8007AC18:
/* 8007AC18 2402ffff */  li       $v0,-1
/* 8007AC1C 3c018014 */  lui      $at,0x8014
/* 8007AC20 ac20ec4c */  sw       $zero,-5044($at)
/* 8007AC24 ac800010 */  sw       $zero,16($a0)
/* 8007AC28 ac820014 */  sw       $v0,20($a0)
/* 8007AC2C 0801eb0e */  j        .L8007AC38
/* 8007AC30 ac82000c */  sw       $v0,12($a0)
.L8007AC34:
/* 8007AC34 ac820014 */  sw       $v0,20($a0)
.L8007AC38:
/* 8007AC38 8fbf0010 */  lw       $ra,16($sp)
/* 8007AC3C 00000000 */  nop      
/* 8007AC40 03e00008 */  jr       $ra
/* 8007AC44 27bd0018 */  addiu    $sp,$sp,24
