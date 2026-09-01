.set noat
.set noreorder

glabel func_8003F1A0
/* 8003F1A0 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003F1A4 afb00010 */  sw       $s0,16($sp)
/* 8003F1A8 00808021 */  move     $s0,$a0
/* 8003F1AC 24040001 */  li       $a0,1
/* 8003F1B0 3c028005 */  lui      $v0,0x8005
/* 8003F1B4 afbf0014 */  sw       $ra,20($sp)
/* 8003F1B8 ae000438 */  sw       $zero,1080($s0)
/* 8003F1BC ae000440 */  sw       $zero,1088($s0)
/* 8003F1C0 ae000444 */  sw       $zero,1092($s0)
/* 8003F1C4 ac401f8c */  sw       $zero,8076($v0)
/* 8003F1C8 24421f8c */  addiu    $v0,$v0,8076
/* 8003F1CC 0c01407d */  jal      func_800501F4
/* 8003F1D0 ac400004 */  sw       $zero,4($v0)
/* 8003F1D4 24040001 */  li       $a0,1
/* 8003F1D8 00802821 */  move     $a1,$a0
/* 8003F1DC 0c00d0fd */  jal      func_800343F4
/* 8003F1E0 ae02043c */  sw       $v0,1084($s0)
/* 8003F1E4 02002021 */  move     $a0,$s0
/* 8003F1E8 0c00fb3e */  jal      func_8003ECF8
/* 8003F1EC ae000448 */  sw       $zero,1096($s0)
/* 8003F1F0 9602003a */  lhu      $v0,58($s0)
/* 8003F1F4 00000000 */  nop      
/* 8003F1F8 3042fffe */  andi     $v0,$v0,0xfffe
/* 8003F1FC a602003a */  sh       $v0,58($s0)
/* 8003F200 8fbf0014 */  lw       $ra,20($sp)
/* 8003F204 8fb00010 */  lw       $s0,16($sp)
/* 8003F208 03e00008 */  jr       $ra
/* 8003F20C 27bd0018 */  addiu    $sp,$sp,24
