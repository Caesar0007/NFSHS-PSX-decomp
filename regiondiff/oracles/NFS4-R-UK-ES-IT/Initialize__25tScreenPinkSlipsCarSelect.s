.set noat
.set noreorder

glabel func_8003F668
/* 8003F668 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003F66C afb00010 */  sw       $s0,16($sp)
/* 8003F670 00808021 */  move     $s0,$a0
/* 8003F674 24040001 */  li       $a0,1
/* 8003F678 3c028005 */  lui      $v0,0x8005
/* 8003F67C afbf0014 */  sw       $ra,20($sp)
/* 8003F680 ae000438 */  sw       $zero,1080($s0)
/* 8003F684 ae000440 */  sw       $zero,1088($s0)
/* 8003F688 ae000444 */  sw       $zero,1092($s0)
/* 8003F68C ac4028cc */  sw       $zero,10444($v0)
/* 8003F690 244228cc */  addiu    $v0,$v0,10444
/* 8003F694 0c0142cd */  jal      func_80050B34
/* 8003F698 ac400004 */  sw       $zero,4($v0)
/* 8003F69C 24040001 */  li       $a0,1
/* 8003F6A0 00802821 */  move     $a1,$a0
/* 8003F6A4 0c00d22f */  jal      func_800348BC
/* 8003F6A8 ae02043c */  sw       $v0,1084($s0)
/* 8003F6AC 02002021 */  move     $a0,$s0
/* 8003F6B0 0c00fc70 */  jal      func_8003F1C0
/* 8003F6B4 ae000448 */  sw       $zero,1096($s0)
/* 8003F6B8 9602003a */  lhu      $v0,58($s0)
/* 8003F6BC 00000000 */  nop      
/* 8003F6C0 3042fffe */  andi     $v0,$v0,0xfffe
/* 8003F6C4 a602003a */  sh       $v0,58($s0)
/* 8003F6C8 8fbf0014 */  lw       $ra,20($sp)
/* 8003F6CC 8fb00010 */  lw       $s0,16($sp)
/* 8003F6D0 03e00008 */  jr       $ra
/* 8003F6D4 27bd0018 */  addiu    $sp,$sp,24
