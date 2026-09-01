.set noat
.set noreorder

glabel func_8003F1A8
/* 8003F1A8 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003F1AC afb00010 */  sw       $s0,16($sp)
/* 8003F1B0 afbf0014 */  sw       $ra,20($sp)
/* 8003F1B4 0c00f032 */  jal      func_8003C0C8
/* 8003F1B8 00808021 */  move     $s0,$a0
/* 8003F1BC 3c028005 */  lui      $v0,0x8005
/* 8003F1C0 8c421d68 */  lw       $v0,7528($v0)
/* 8003F1C4 00000000 */  nop      
/* 8003F1C8 9043022c */  lbu      $v1,556($v0)
/* 8003F1CC 24020001 */  li       $v0,1
/* 8003F1D0 14620006 */  bne      $v1,$v0,.L8003F1EC
/* 8003F1D4 26040304 */  addiu    $a0,$s0,772
/* 8003F1D8 2402ffff */  li       $v0,-1
/* 8003F1DC a602011e */  sh       $v0,286($s0)
/* 8003F1E0 a6020120 */  sh       $v0,288($s0)
/* 8003F1E4 0800fc7f */  j        .L8003F1FC
/* 8003F1E8 a6020122 */  sh       $v0,290($s0)
.L8003F1EC:
/* 8003F1EC 240500f9 */  li       $a1,249
/* 8003F1F0 2406010e */  li       $a2,270
/* 8003F1F4 0c00dafb */  jal      func_80036BEC
/* 8003F1F8 2407002d */  li       $a3,45
.L8003F1FC:
/* 8003F1FC a600011c */  sh       $zero,284($s0)
/* 8003F200 a600037a */  sh       $zero,890($s0)
/* 8003F204 a6000378 */  sh       $zero,888($s0)
/* 8003F208 a6000376 */  sh       $zero,886($s0)
/* 8003F20C a6000374 */  sh       $zero,884($s0)
/* 8003F210 8fbf0014 */  lw       $ra,20($sp)
/* 8003F214 8fb00010 */  lw       $s0,16($sp)
/* 8003F218 3c028005 */  lui      $v0,0x8005
/* 8003F21C ac401d5c */  sw       $zero,7516($v0)
/* 8003F220 03e00008 */  jr       $ra
/* 8003F224 27bd0018 */  addiu    $sp,$sp,24
