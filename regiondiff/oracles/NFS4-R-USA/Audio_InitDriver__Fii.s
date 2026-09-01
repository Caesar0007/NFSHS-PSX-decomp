.set noat
.set noreorder

glabel func_800BC958
/* 800BC958 27bdffa0 */  addiu    $sp,$sp,-96
/* 800BC95C afb00050 */  sw       $s0,80($sp)
/* 800BC960 00808021 */  move     $s0,$a0
/* 800BC964 afb10054 */  sw       $s1,84($sp)
/* 800BC968 00a08821 */  move     $s1,$a1
/* 800BC96C 00002021 */  move     $a0,$zero
/* 800BC970 3c028011 */  lui      $v0,0x8011
/* 800BC974 2443fb6c */  addiu    $v1,$v0,-1172
/* 800BC978 afbf0058 */  sw       $ra,88($sp)
.L800BC97C:
/* 800BC97C ac640000 */  sw       $a0,0($v1)
/* 800BC980 ac600008 */  sw       $zero,8($v1)
/* 800BC984 24840001 */  addiu    $a0,$a0,1
/* 800BC988 28820007 */  slti     $v0,$a0,7
/* 800BC98C 1440fffb */  bnez     $v0,.L800BC97C
/* 800BC990 2463000c */  addiu    $v1,$v1,12
/* 800BC994 3c028014 */  lui      $v0,0x8014
/* 800BC998 8c42d938 */  lw       $v0,-9928($v0)
/* 800BC99C 00000000 */  nop      
/* 800BC9A0 14400006 */  bnez     $v0,.L800BC9BC
/* 800BC9A4 00000000 */  nop      
/* 800BC9A8 3c028014 */  lui      $v0,0x8014
/* 800BC9AC 8c42d93c */  lw       $v0,-9924($v0)
/* 800BC9B0 00000000 */  nop      
/* 800BC9B4 10400019 */  beqz     $v0,.L800BCA1C
/* 800BC9B8 00000000 */  nop      
.L800BC9BC:
/* 800BC9BC 0c03c2d6 */  jal      func_800F0B58
/* 800BC9C0 27a40010 */  addiu    $a0,$sp,16
/* 800BC9C4 3c038014 */  lui      $v1,0x8014
/* 800BC9C8 8c63d968 */  lw       $v1,-9880($v1)
/* 800BC9CC 24020030 */  li       $v0,48
/* 800BC9D0 14600003 */  bnez     $v1,.L800BC9E0
/* 800BC9D4 a7a2001c */  sh       $v0,28($sp)
/* 800BC9D8 24020001 */  li       $v0,1
/* 800BC9DC a3a20020 */  sb       $v0,32($sp)
.L800BC9E0:
/* 800BC9E0 0c03c305 */  jal      func_800F0C14
/* 800BC9E4 27a40010 */  addiu    $a0,$sp,16
/* 800BC9E8 0c03caab */  jal      func_800F2AAC
/* 800BC9EC 00000000 */  nop      
/* 800BC9F0 3c048005 */  lui      $a0,0x8005
/* 800BC9F4 24846f08 */  addiu    $a0,$a0,28424
/* 800BC9F8 24051000 */  li       $a1,4096
/* 800BC9FC 0c0397ca */  jal      func_800E5F28
/* 800BCA00 00003021 */  move     $a2,$zero
/* 800BCA04 af820fac */  sw       $v0,4012($gp)
/* 800BCA08 00402021 */  move     $a0,$v0
/* 800BCA0C 0c03c344 */  jal      func_800F0D10
/* 800BCA10 24051000 */  li       $a1,4096
/* 800BCA14 0c01ea3d */  jal      func_8007A8F4
/* 800BCA18 00000000 */  nop      
.L800BCA1C:
/* 800BCA1C 1a000005 */  blez     $s0,.L800BCA34
/* 800BCA20 02002021 */  move     $a0,$s0
/* 800BCA24 02202821 */  move     $a1,$s1
/* 800BCA28 3c068014 */  lui      $a2,0x8014
/* 800BCA2C 0c01ed6b */  jal      func_8007B5AC
/* 800BCA30 24c6e7ec */  addiu    $a2,$a2,-6164
.L800BCA34:
/* 800BCA34 8fbf0058 */  lw       $ra,88($sp)
/* 800BCA38 8fb10054 */  lw       $s1,84($sp)
/* 800BCA3C 8fb00050 */  lw       $s0,80($sp)
/* 800BCA40 af800fa8 */  sw       $zero,4008($gp)
/* 800BCA44 03e00008 */  jr       $ra
/* 800BCA48 27bd0060 */  addiu    $sp,$sp,96
