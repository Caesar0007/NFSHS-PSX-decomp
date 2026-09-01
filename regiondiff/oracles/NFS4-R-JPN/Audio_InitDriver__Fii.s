.set noat
.set noreorder

glabel func_800BC70C
/* 800BC70C 27bdffa0 */  addiu    $sp,$sp,-96
/* 800BC710 afb00050 */  sw       $s0,80($sp)
/* 800BC714 00808021 */  move     $s0,$a0
/* 800BC718 afb10054 */  sw       $s1,84($sp)
/* 800BC71C 00a08821 */  move     $s1,$a1
/* 800BC720 00002021 */  move     $a0,$zero
/* 800BC724 3c028011 */  lui      $v0,0x8011
/* 800BC728 2443f958 */  addiu    $v1,$v0,-1704
/* 800BC72C afbf0058 */  sw       $ra,88($sp)
.L800BC730:
/* 800BC730 ac640000 */  sw       $a0,0($v1)
/* 800BC734 ac600008 */  sw       $zero,8($v1)
/* 800BC738 24840001 */  addiu    $a0,$a0,1
/* 800BC73C 28820007 */  slti     $v0,$a0,7
/* 800BC740 1440fffb */  bnez     $v0,.L800BC730
/* 800BC744 2463000c */  addiu    $v1,$v1,12
/* 800BC748 3c028014 */  lui      $v0,0x8014
/* 800BC74C 8c42d724 */  lw       $v0,-10460($v0)
/* 800BC750 00000000 */  nop      
/* 800BC754 14400006 */  bnez     $v0,.L800BC770
/* 800BC758 00000000 */  nop      
/* 800BC75C 3c028014 */  lui      $v0,0x8014
/* 800BC760 8c42d728 */  lw       $v0,-10456($v0)
/* 800BC764 00000000 */  nop      
/* 800BC768 10400019 */  beqz     $v0,.L800BC7D0
/* 800BC76C 00000000 */  nop      
.L800BC770:
/* 800BC770 0c03c251 */  jal      func_800F0944
/* 800BC774 27a40010 */  addiu    $a0,$sp,16
/* 800BC778 3c038014 */  lui      $v1,0x8014
/* 800BC77C 8c63d754 */  lw       $v1,-10412($v1)
/* 800BC780 24020030 */  li       $v0,48
/* 800BC784 14600003 */  bnez     $v1,.L800BC794
/* 800BC788 a7a2001c */  sh       $v0,28($sp)
/* 800BC78C 24020001 */  li       $v0,1
/* 800BC790 a3a20020 */  sb       $v0,32($sp)
.L800BC794:
/* 800BC794 0c03c280 */  jal      func_800F0A00
/* 800BC798 27a40010 */  addiu    $a0,$sp,16
/* 800BC79C 0c03ca26 */  jal      func_800F2898
/* 800BC7A0 00000000 */  nop      
/* 800BC7A4 3c048005 */  lui      $a0,0x8005
/* 800BC7A8 24846f08 */  addiu    $a0,$a0,28424
/* 800BC7AC 24051000 */  li       $a1,4096
/* 800BC7B0 0c039745 */  jal      func_800E5D14
/* 800BC7B4 00003021 */  move     $a2,$zero
/* 800BC7B8 af820fac */  sw       $v0,4012($gp)
/* 800BC7BC 00402021 */  move     $a0,$v0
/* 800BC7C0 0c03c2bf */  jal      func_800F0AFC
/* 800BC7C4 24051000 */  li       $a1,4096
/* 800BC7C8 0c01ea3d */  jal      func_8007A8F4
/* 800BC7CC 00000000 */  nop      
.L800BC7D0:
/* 800BC7D0 1a000005 */  blez     $s0,.L800BC7E8
/* 800BC7D4 02002021 */  move     $a0,$s0
/* 800BC7D8 02202821 */  move     $a1,$s1
/* 800BC7DC 3c068014 */  lui      $a2,0x8014
/* 800BC7E0 0c01ed6b */  jal      func_8007B5AC
/* 800BC7E4 24c6e5d8 */  addiu    $a2,$a2,-6696
.L800BC7E8:
/* 800BC7E8 8fbf0058 */  lw       $ra,88($sp)
/* 800BC7EC 8fb10054 */  lw       $s1,84($sp)
/* 800BC7F0 8fb00050 */  lw       $s0,80($sp)
/* 800BC7F4 af800fa8 */  sw       $zero,4008($gp)
/* 800BC7F8 03e00008 */  jr       $ra
/* 800BC7FC 27bd0060 */  addiu    $sp,$sp,96
