.set noat
.set noreorder

glabel func_8003FA1C
/* 8003FA1C 27bdffe0 */  addiu    $sp,$sp,-32
/* 8003FA20 afb10014 */  sw       $s1,20($sp)
/* 8003FA24 8fb10030 */  lw       $s1,48($sp)
/* 8003FA28 24020034 */  li       $v0,52
/* 8003FA2C afbf0018 */  sw       $ra,24($sp)
/* 8003FA30 afb00010 */  sw       $s0,16($sp)
/* 8003FA34 a4a20000 */  sh       $v0,0($a1)
/* 8003FA38 24020005 */  li       $v0,5
/* 8003FA3C a4c20000 */  sh       $v0,0($a2)
/* 8003FA40 2402ffff */  li       $v0,-1
/* 8003FA44 a482011e */  sh       $v0,286($a0)
/* 8003FA48 a4820120 */  sh       $v0,288($a0)
/* 8003FA4C a4820122 */  sh       $v0,290($a0)
/* 8003FA50 3c028001 */  lui      $v0,0x8001
/* 8003FA54 24421ae0 */  addiu    $v0,$v0,6880
/* 8003FA58 3c108005 */  lui      $s0,0x8005
/* 8003FA5C 26103178 */  addiu    $s0,$s0,12664
/* 8003FA60 3c058001 */  lui      $a1,0x8001
/* 8003FA64 3c068001 */  lui      $a2,0x8001
/* 8003FA68 02002021 */  move     $a0,$s0
/* 8003FA6C 24a51a8c */  addiu    $a1,$a1,6796
/* 8003FA70 24c61b0c */  addiu    $a2,$a2,6924
/* 8003FA74 0c039425 */  jal      func_800E5094
/* 8003FA78 ace20000 */  sw       $v0,0($a3)
/* 8003FA7C ae300000 */  sw       $s0,0($s1)
/* 8003FA80 8fbf0018 */  lw       $ra,24($sp)
/* 8003FA84 8fb10014 */  lw       $s1,20($sp)
/* 8003FA88 8fb00010 */  lw       $s0,16($sp)
/* 8003FA8C 03e00008 */  jr       $ra
/* 8003FA90 27bd0020 */  addiu    $sp,$sp,32
