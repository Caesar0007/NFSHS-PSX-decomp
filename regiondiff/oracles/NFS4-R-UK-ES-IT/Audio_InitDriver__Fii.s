.set noat
.set noreorder

glabel func_800BC95C
/* 800BC95C 27bdffa0 */  addiu    $sp,$sp,-96
/* 800BC960 afb00050 */  sw       $s0,80($sp)
/* 800BC964 00808021 */  move     $s0,$a0
/* 800BC968 afb10054 */  sw       $s1,84($sp)
/* 800BC96C 00a08821 */  move     $s1,$a1
/* 800BC970 00002021 */  move     $a0,$zero
/* 800BC974 3c028011 */  lui      $v0,0x8011
/* 800BC978 2443fb98 */  addiu    $v1,$v0,-1128
/* 800BC97C afbf0058 */  sw       $ra,88($sp)
.L800BC980:
/* 800BC980 ac640000 */  sw       $a0,0($v1)
/* 800BC984 ac600008 */  sw       $zero,8($v1)
/* 800BC988 24840001 */  addiu    $a0,$a0,1
/* 800BC98C 28820007 */  slti     $v0,$a0,7
/* 800BC990 1440fffb */  bnez     $v0,.L800BC980
/* 800BC994 2463000c */  addiu    $v1,$v1,12
/* 800BC998 3c028014 */  lui      $v0,0x8014
/* 800BC99C 8c42d964 */  lw       $v0,-9884($v0)
/* 800BC9A0 00000000 */  nop      
/* 800BC9A4 14400006 */  bnez     $v0,.L800BC9C0
/* 800BC9A8 00000000 */  nop      
/* 800BC9AC 3c028014 */  lui      $v0,0x8014
/* 800BC9B0 8c42d968 */  lw       $v0,-9880($v0)
/* 800BC9B4 00000000 */  nop      
/* 800BC9B8 10400019 */  beqz     $v0,.L800BCA20
/* 800BC9BC 00000000 */  nop      
.L800BC9C0:
/* 800BC9C0 0c03c2e1 */  jal      func_800F0B84
/* 800BC9C4 27a40010 */  addiu    $a0,$sp,16
/* 800BC9C8 3c038014 */  lui      $v1,0x8014
/* 800BC9CC 8c63d994 */  lw       $v1,-9836($v1)
/* 800BC9D0 24020030 */  li       $v0,48
/* 800BC9D4 14600003 */  bnez     $v1,.L800BC9E4
/* 800BC9D8 a7a2001c */  sh       $v0,28($sp)
/* 800BC9DC 24020001 */  li       $v0,1
/* 800BC9E0 a3a20020 */  sb       $v0,32($sp)
.L800BC9E4:
/* 800BC9E4 0c03c310 */  jal      func_800F0C40
/* 800BC9E8 27a40010 */  addiu    $a0,$sp,16
/* 800BC9EC 0c03cab6 */  jal      func_800F2AD8
/* 800BC9F0 00000000 */  nop      
/* 800BC9F4 3c048005 */  lui      $a0,0x8005
/* 800BC9F8 24846f08 */  addiu    $a0,$a0,28424
/* 800BC9FC 24051000 */  li       $a1,4096
/* 800BCA00 0c0397c5 */  jal      func_800E5F14
/* 800BCA04 00003021 */  move     $a2,$zero
/* 800BCA08 af820fac */  sw       $v0,4012($gp)
/* 800BCA0C 00402021 */  move     $a0,$v0
/* 800BCA10 0c03c34f */  jal      func_800F0D3C
/* 800BCA14 24051000 */  li       $a1,4096
/* 800BCA18 0c01ea3d */  jal      func_8007A8F4
/* 800BCA1C 00000000 */  nop      
.L800BCA20:
/* 800BCA20 1a000005 */  blez     $s0,.L800BCA38
/* 800BCA24 02002021 */  move     $a0,$s0
/* 800BCA28 02202821 */  move     $a1,$s1
/* 800BCA2C 3c068014 */  lui      $a2,0x8014
/* 800BCA30 0c01ed6b */  jal      func_8007B5AC
/* 800BCA34 24c6e818 */  addiu    $a2,$a2,-6120
.L800BCA38:
/* 800BCA38 8fbf0058 */  lw       $ra,88($sp)
/* 800BCA3C 8fb10054 */  lw       $s1,84($sp)
/* 800BCA40 8fb00050 */  lw       $s0,80($sp)
/* 800BCA44 af800fa8 */  sw       $zero,4008($gp)
/* 800BCA48 03e00008 */  jr       $ra
/* 800BCA4C 27bd0060 */  addiu    $sp,$sp,96
