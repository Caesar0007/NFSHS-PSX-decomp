.set noat
.set noreorder

glabel func_8003FA24
/* 8003FA24 27bdffe0 */  addiu    $sp,$sp,-32
/* 8003FA28 afb10014 */  sw       $s1,20($sp)
/* 8003FA2C 8fb10030 */  lw       $s1,48($sp)
/* 8003FA30 24020034 */  li       $v0,52
/* 8003FA34 afbf0018 */  sw       $ra,24($sp)
/* 8003FA38 afb00010 */  sw       $s0,16($sp)
/* 8003FA3C a4a20000 */  sh       $v0,0($a1)
/* 8003FA40 24020005 */  li       $v0,5
/* 8003FA44 a4c20000 */  sh       $v0,0($a2)
/* 8003FA48 2402ffff */  li       $v0,-1
/* 8003FA4C a482011e */  sh       $v0,286($a0)
/* 8003FA50 a4820120 */  sh       $v0,288($a0)
/* 8003FA54 a4820122 */  sh       $v0,290($a0)
/* 8003FA58 3c028001 */  lui      $v0,0x8001
/* 8003FA5C 24421ad8 */  addiu    $v0,$v0,6872
/* 8003FA60 3c108005 */  lui      $s0,0x8005
/* 8003FA64 261030b8 */  addiu    $s0,$s0,12472
/* 8003FA68 3c058001 */  lui      $a1,0x8001
/* 8003FA6C 3c068001 */  lui      $a2,0x8001
/* 8003FA70 02002021 */  move     $a0,$s0
/* 8003FA74 24a51a84 */  addiu    $a1,$a1,6788
/* 8003FA78 24c61b04 */  addiu    $a2,$a2,6916
/* 8003FA7C 0c03942a */  jal      func_800E50A8
/* 8003FA80 ace20000 */  sw       $v0,0($a3)
/* 8003FA84 ae300000 */  sw       $s0,0($s1)
/* 8003FA88 8fbf0018 */  lw       $ra,24($sp)
/* 8003FA8C 8fb10014 */  lw       $s1,20($sp)
/* 8003FA90 8fb00010 */  lw       $s0,16($sp)
/* 8003FA94 03e00008 */  jr       $ra
/* 8003FA98 27bd0020 */  addiu    $sp,$sp,32
