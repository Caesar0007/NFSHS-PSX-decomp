.set noat
.set noreorder

glabel func_8003FA8C
/* 8003FA8C 27bdffe0 */  addiu    $sp,$sp,-32
/* 8003FA90 afb10014 */  sw       $s1,20($sp)
/* 8003FA94 8fb10030 */  lw       $s1,48($sp)
/* 8003FA98 24020034 */  li       $v0,52
/* 8003FA9C afbf0018 */  sw       $ra,24($sp)
/* 8003FAA0 afb00010 */  sw       $s0,16($sp)
/* 8003FAA4 a4a20000 */  sh       $v0,0($a1)
/* 8003FAA8 24020005 */  li       $v0,5
/* 8003FAAC a4c20000 */  sh       $v0,0($a2)
/* 8003FAB0 2402ffff */  li       $v0,-1
/* 8003FAB4 a482011e */  sh       $v0,286($a0)
/* 8003FAB8 a4820120 */  sh       $v0,288($a0)
/* 8003FABC a4820122 */  sh       $v0,290($a0)
/* 8003FAC0 3c028001 */  lui      $v0,0x8001
/* 8003FAC4 24421ae0 */  addiu    $v0,$v0,6880
/* 8003FAC8 3c108005 */  lui      $s0,0x8005
/* 8003FACC 26103478 */  addiu    $s0,$s0,13432
/* 8003FAD0 3c058001 */  lui      $a1,0x8001
/* 8003FAD4 3c068001 */  lui      $a2,0x8001
/* 8003FAD8 02002021 */  move     $a0,$s0
/* 8003FADC 24a51a8c */  addiu    $a1,$a1,6796
/* 8003FAE0 24c61b0c */  addiu    $a2,$a2,6924
/* 8003FAE4 0c039425 */  jal      func_800E5094
/* 8003FAE8 ace20000 */  sw       $v0,0($a3)
/* 8003FAEC ae300000 */  sw       $s0,0($s1)
/* 8003FAF0 8fbf0018 */  lw       $ra,24($sp)
/* 8003FAF4 8fb10014 */  lw       $s1,20($sp)
/* 8003FAF8 8fb00010 */  lw       $s0,16($sp)
/* 8003FAFC 03e00008 */  jr       $ra
/* 8003FB00 27bd0020 */  addiu    $sp,$sp,32
