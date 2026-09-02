.set noat
.set noreorder

glabel func_800DCE50
/* 800DCE50 27bdffe8 */  addiu    $sp,$sp,-24
/* 800DCE54 afbf0010 */  sw       $ra,16($sp)
/* 800DCE58 0c03d2c7 */  jal      func_800F4B1C
/* 800DCE5C 00000000 */  nop      
/* 800DCE60 0c03cbe5 */  jal      func_800F2F94
/* 800DCE64 00000000 */  nop      
/* 800DCE68 0c03b76e */  jal      func_800EDDB8
/* 800DCE6C 24040003 */  li       $a0,3
/* 800DCE70 0c03d050 */  jal      func_800F4140
/* 800DCE74 24040002 */  li       $a0,2
/* 800DCE78 2404000a */  li       $a0,10
/* 800DCE7C 240502c6 */  li       $a1,710
/* 800DCE80 0c03b0cf */  jal      func_800EC33C
/* 800DCE84 24060030 */  li       $a2,48
/* 800DCE88 8fbf0010 */  lw       $ra,16($sp)
/* 800DCE8C 00000000 */  nop      
/* 800DCE90 03e00008 */  jr       $ra
/* 800DCE94 27bd0018 */  addiu    $sp,$sp,24
