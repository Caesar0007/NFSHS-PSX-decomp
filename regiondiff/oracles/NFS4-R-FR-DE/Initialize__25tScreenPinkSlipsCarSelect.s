.set noat
.set noreorder

glabel func_8003F650
/* 8003F650 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003F654 afb00010 */  sw       $s0,16($sp)
/* 8003F658 00808021 */  move     $s0,$a0
/* 8003F65C 24040001 */  li       $a0,1
/* 8003F660 3c028005 */  lui      $v0,0x8005
/* 8003F664 afbf0014 */  sw       $ra,20($sp)
/* 8003F668 ae000438 */  sw       $zero,1080($s0)
/* 8003F66C ae000440 */  sw       $zero,1088($s0)
/* 8003F670 ae000444 */  sw       $zero,1092($s0)
/* 8003F674 ac40288c */  sw       $zero,10380($v0)
/* 8003F678 2442288c */  addiu    $v0,$v0,10380
/* 8003F67C 0c0142bd */  jal      func_80050AF4
/* 8003F680 ac400004 */  sw       $zero,4($v0)
/* 8003F684 24040001 */  li       $a0,1
/* 8003F688 00802821 */  move     $a1,$a0
/* 8003F68C 0c00d229 */  jal      func_800348A4
/* 8003F690 ae02043c */  sw       $v0,1084($s0)
/* 8003F694 02002021 */  move     $a0,$s0
/* 8003F698 0c00fc6a */  jal      func_8003F1A8
/* 8003F69C ae000448 */  sw       $zero,1096($s0)
/* 8003F6A0 9602003a */  lhu      $v0,58($s0)
/* 8003F6A4 00000000 */  nop      
/* 8003F6A8 3042fffe */  andi     $v0,$v0,0xfffe
/* 8003F6AC a602003a */  sh       $v0,58($s0)
/* 8003F6B0 8fbf0014 */  lw       $ra,20($sp)
/* 8003F6B4 8fb00010 */  lw       $s0,16($sp)
/* 8003F6B8 03e00008 */  jr       $ra
/* 8003F6BC 27bd0018 */  addiu    $sp,$sp,24
