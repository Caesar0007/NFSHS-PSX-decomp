.set noat
.set noreorder

glabel func_8003FAA4
/* 8003FAA4 27bdffe0 */  addiu    $sp,$sp,-32
/* 8003FAA8 afb10014 */  sw       $s1,20($sp)
/* 8003FAAC 8fb10030 */  lw       $s1,48($sp)
/* 8003FAB0 24020034 */  li       $v0,52
/* 8003FAB4 afbf0018 */  sw       $ra,24($sp)
/* 8003FAB8 afb00010 */  sw       $s0,16($sp)
/* 8003FABC a4a20000 */  sh       $v0,0($a1)
/* 8003FAC0 24020005 */  li       $v0,5
/* 8003FAC4 a4c20000 */  sh       $v0,0($a2)
/* 8003FAC8 2402ffff */  li       $v0,-1
/* 8003FACC a482011e */  sh       $v0,286($a0)
/* 8003FAD0 a4820120 */  sh       $v0,288($a0)
/* 8003FAD4 a4820122 */  sh       $v0,290($a0)
/* 8003FAD8 3c028001 */  lui      $v0,0x8001
/* 8003FADC 24421ae0 */  addiu    $v0,$v0,6880
/* 8003FAE0 3c108005 */  lui      $s0,0x8005
/* 8003FAE4 261034c0 */  addiu    $s0,$s0,13504
/* 8003FAE8 3c058001 */  lui      $a1,0x8001
/* 8003FAEC 3c068001 */  lui      $a2,0x8001
/* 8003FAF0 02002021 */  move     $a0,$s0
/* 8003FAF4 24a51a8c */  addiu    $a1,$a1,6796
/* 8003FAF8 24c61b0c */  addiu    $a2,$a2,6924
/* 8003FAFC 0c039425 */  jal      func_800E5094
/* 8003FB00 ace20000 */  sw       $v0,0($a3)
/* 8003FB04 ae300000 */  sw       $s0,0($s1)
/* 8003FB08 8fbf0018 */  lw       $ra,24($sp)
/* 8003FB0C 8fb10014 */  lw       $s1,20($sp)
/* 8003FB10 8fb00010 */  lw       $s0,16($sp)
/* 8003FB14 03e00008 */  jr       $ra
/* 8003FB18 27bd0020 */  addiu    $sp,$sp,32
