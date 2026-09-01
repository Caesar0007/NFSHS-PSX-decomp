.set noat
.set noreorder

glabel func_8003ECF8
/* 8003ECF8 27bdffe8 */  addiu    $sp,$sp,-24
/* 8003ECFC afb00010 */  sw       $s0,16($sp)
/* 8003ED00 afbf0014 */  sw       $ra,20($sp)
/* 8003ED04 0c00ef06 */  jal      func_8003BC18
/* 8003ED08 00808021 */  move     $s0,$a0
/* 8003ED0C 3c028005 */  lui      $v0,0x8005
/* 8003ED10 8c421470 */  lw       $v0,5232($v0)
/* 8003ED14 00000000 */  nop      
/* 8003ED18 9043022c */  lbu      $v1,556($v0)
/* 8003ED1C 24020001 */  li       $v0,1
/* 8003ED20 14620006 */  bne      $v1,$v0,.L8003ED3C
/* 8003ED24 26040304 */  addiu    $a0,$s0,772
/* 8003ED28 2402ffff */  li       $v0,-1
/* 8003ED2C a602011e */  sh       $v0,286($s0)
/* 8003ED30 a6020120 */  sh       $v0,288($s0)
/* 8003ED34 0800fb53 */  j        .L8003ED4C
/* 8003ED38 a6020122 */  sh       $v0,290($s0)
.L8003ED3C:
/* 8003ED3C 240500f9 */  li       $a1,249
/* 8003ED40 2406010e */  li       $a2,270
/* 8003ED44 0c00d9cf */  jal      func_8003673C
/* 8003ED48 2407002d */  li       $a3,45
.L8003ED4C:
/* 8003ED4C a600011c */  sh       $zero,284($s0)
/* 8003ED50 a600037a */  sh       $zero,890($s0)
/* 8003ED54 a6000378 */  sh       $zero,888($s0)
/* 8003ED58 a6000376 */  sh       $zero,886($s0)
/* 8003ED5C a6000374 */  sh       $zero,884($s0)
/* 8003ED60 8fbf0014 */  lw       $ra,20($sp)
/* 8003ED64 8fb00010 */  lw       $s0,16($sp)
/* 8003ED68 3c028005 */  lui      $v0,0x8005
/* 8003ED6C ac401464 */  sw       $zero,5220($v0)
/* 8003ED70 03e00008 */  jr       $ra
/* 8003ED74 27bd0018 */  addiu    $sp,$sp,24
