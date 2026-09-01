.set noat
.set noreorder

glabel func_8006FEF8
/* 8006FEF8 27bdffe8 */  addiu    $sp,$sp,-24
/* 8006FEFC afbf0010 */  sw       $ra,16($sp)
/* 8006FF00 0c01bfcf */  jal      func_8006FF3C
/* 8006FF04 ac85001c */  sw       $a1,28($a0)
/* 8006FF08 8fbf0010 */  lw       $ra,16($sp)
/* 8006FF0C 00000000 */  nop      
/* 8006FF10 03e00008 */  jr       $ra
/* 8006FF14 27bd0018 */  addiu    $sp,$sp,24
