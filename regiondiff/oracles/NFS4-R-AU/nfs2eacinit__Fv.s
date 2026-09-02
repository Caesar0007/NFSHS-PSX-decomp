.set noat
.set noreorder

glabel func_800DD090
/* 800DD090 27bdffe8 */  addiu    $sp,$sp,-24
/* 800DD094 afbf0010 */  sw       $ra,16($sp)
/* 800DD098 0c03d357 */  jal      func_800F4D5C
/* 800DD09C 00000000 */  nop      
/* 800DD0A0 0c03cc75 */  jal      func_800F31D4
/* 800DD0A4 00000000 */  nop      
/* 800DD0A8 0c03b7ee */  jal      func_800EDFB8
/* 800DD0AC 24040003 */  li       $a0,3
/* 800DD0B0 0c03d0e0 */  jal      func_800F4380
/* 800DD0B4 24040002 */  li       $a0,2
/* 800DD0B8 2404000a */  li       $a0,10
/* 800DD0BC 240502c6 */  li       $a1,710
/* 800DD0C0 0c03b14f */  jal      func_800EC53C
/* 800DD0C4 24060030 */  li       $a2,48
/* 800DD0C8 8fbf0010 */  lw       $ra,16($sp)
/* 800DD0CC 00000000 */  nop      
/* 800DD0D0 03e00008 */  jr       $ra
/* 800DD0D4 27bd0018 */  addiu    $sp,$sp,24
