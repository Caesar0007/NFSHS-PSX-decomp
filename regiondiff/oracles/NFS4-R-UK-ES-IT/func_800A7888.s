.set noat
.set noreorder

glabel func_800A7888
/* 800A7888 27bdffe8 */  addiu    $sp,$sp,-24
/* 800A788C afbf0010 */  sw       $ra,16($sp)
/* 800A7890 0c029e04 */  jal      func_800A7810
/* 800A7894 00000000 */  nop      
/* 800A7898 8fbf0010 */  lw       $ra,16($sp)
/* 800A789C 00000000 */  nop      
/* 800A78A0 03e00008 */  jr       $ra
/* 800A78A4 27bd0018 */  addiu    $sp,$sp,24
