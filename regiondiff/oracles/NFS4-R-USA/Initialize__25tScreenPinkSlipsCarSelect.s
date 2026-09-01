.set noat
.set noreorder

glabel func_8003F5E8
/* 8003F5E8 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003F5EC afb00010 */  sw       $s0,16($sp)
/* 8003F5F0 00808021 */  move     $s0,$a0
/* 8003F5F4 24040001 */  li       $a0,1
/* 8003F5F8 3c028005 */  lui      $v0,0x8005
/* 8003F5FC afbf0014 */  sw       $ra,20($sp)
/* 8003F600 ae000438 */  sw       $zero,1080($s0)
/* 8003F604 ae000440 */  sw       $zero,1088($s0)
/* 8003F608 ae000444 */  sw       $zero,1092($s0)
/* 8003F60C ac4024c4 */  sw       $zero,9412($v0)
/* 8003F610 244224c4 */  addiu    $v0,$v0,9412
/* 8003F614 0c0141cb */  jal      func_8005072C
/* 8003F618 ac400004 */  sw       $zero,4($v0)
/* 8003F61C 24040001 */  li       $a0,1
/* 8003F620 00802821 */  move     $a1,$a0
/* 8003F624 0c00d1f5 */  jal      func_800347D4
/* 8003F628 ae02043c */  sw       $v0,1084($s0)
/* 8003F62C 02002021 */  move     $a0,$s0
/* 8003F630 0c00fc50 */  jal      func_8003F140
/* 8003F634 ae000448 */  sw       $zero,1096($s0)
/* 8003F638 9602003a */  lhu      $v0,58($s0)
/* 8003F63C 00000000 */  nop      
/* 8003F640 3042fffe */  andi     $v0,$v0,0xfffe
/* 8003F644 a602003a */  sh       $v0,58($s0)
/* 8003F648 8fbf0014 */  lw       $ra,20($sp)
/* 8003F64C 8fb00010 */  lw       $s0,16($sp)
/* 8003F650 03e00008 */  jr       $ra
/* 8003F654 27bd0018 */  addiu    $sp,$sp,24
