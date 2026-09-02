.set noat
.set noreorder

glabel func_800DD064
/* 800DD064 27bdffe8 */  addiu    $sp,$sp,-24
/* 800DD068 afbf0010 */  sw       $ra,16($sp)
/* 800DD06C 0c03d34c */  jal      func_800F4D30
/* 800DD070 00000000 */  nop      
/* 800DD074 0c03cc6a */  jal      func_800F31A8
/* 800DD078 00000000 */  nop      
/* 800DD07C 0c03b7f3 */  jal      func_800EDFCC
/* 800DD080 24040003 */  li       $a0,3
/* 800DD084 0c03d0d5 */  jal      func_800F4354
/* 800DD088 24040002 */  li       $a0,2
/* 800DD08C 2404000a */  li       $a0,10
/* 800DD090 240502c6 */  li       $a1,710
/* 800DD094 0c03b154 */  jal      func_800EC550
/* 800DD098 24060030 */  li       $a2,48
/* 800DD09C 8fbf0010 */  lw       $ra,16($sp)
/* 800DD0A0 00000000 */  nop      
/* 800DD0A4 03e00008 */  jr       $ra
/* 800DD0A8 27bd0018 */  addiu    $sp,$sp,24
