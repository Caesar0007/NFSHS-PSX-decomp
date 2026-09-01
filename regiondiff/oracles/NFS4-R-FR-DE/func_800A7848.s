.set noat
.set noreorder

glabel func_800A7848
/* 800A7848 27bdffe8 */  addiu    $sp,$sp,-24
/* 800A784C afbf0010 */  sw       $ra,16($sp)
/* 800A7850 0c029e04 */  jal      func_800A7810
/* 800A7854 00000000 */  nop      
/* 800A7858 8fbf0010 */  lw       $ra,16($sp)
/* 800A785C 00000000 */  nop      
/* 800A7860 03e00008 */  jr       $ra
/* 800A7864 27bd0018 */  addiu    $sp,$sp,24
