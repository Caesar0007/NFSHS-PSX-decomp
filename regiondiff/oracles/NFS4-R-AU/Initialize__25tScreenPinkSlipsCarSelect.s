.set noat
.set noreorder

glabel func_8003F5E0
/* 8003F5E0 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003F5E4 afb00010 */  sw       $s0,16($sp)
/* 8003F5E8 00808021 */  move     $s0,$a0
/* 8003F5EC 24040001 */  li       $a0,1
/* 8003F5F0 3c028005 */  lui      $v0,0x8005
/* 8003F5F4 afbf0014 */  sw       $ra,20($sp)
/* 8003F5F8 ae000438 */  sw       $zero,1080($s0)
/* 8003F5FC ae000440 */  sw       $zero,1088($s0)
/* 8003F600 ae000444 */  sw       $zero,1092($s0)
/* 8003F604 ac402584 */  sw       $zero,9604($v0)
/* 8003F608 24422584 */  addiu    $v0,$v0,9604
/* 8003F60C 0c0141f9 */  jal      func_800507E4
/* 8003F610 ac400004 */  sw       $zero,4($v0)
/* 8003F614 24040001 */  li       $a0,1
/* 8003F618 00802821 */  move     $a1,$a0
/* 8003F61C 0c00d213 */  jal      func_8003484C
/* 8003F620 ae02043c */  sw       $v0,1084($s0)
/* 8003F624 02002021 */  move     $a0,$s0
/* 8003F628 0c00fc4e */  jal      func_8003F138
/* 8003F62C ae000448 */  sw       $zero,1096($s0)
/* 8003F630 9602003a */  lhu      $v0,58($s0)
/* 8003F634 00000000 */  nop      
/* 8003F638 3042fffe */  andi     $v0,$v0,0xfffe
/* 8003F63C a602003a */  sh       $v0,58($s0)
/* 8003F640 8fbf0014 */  lw       $ra,20($sp)
/* 8003F644 8fb00010 */  lw       $s0,16($sp)
/* 8003F648 03e00008 */  jr       $ra
/* 8003F64C 27bd0018 */  addiu    $sp,$sp,24
