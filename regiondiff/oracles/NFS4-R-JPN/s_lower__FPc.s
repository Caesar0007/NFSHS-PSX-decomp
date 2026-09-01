.set noat
.set noreorder

glabel func_800265F8
/* 800265F8 27bdffe8 */  addiu    $sp,$sp,-24
/* 800265FC afbf0010 */  sw       $ra,16($sp)
/* 80026600 0c03a9af */  jal      func_800EA6BC
/* 80026604 00000000 */  nop      
/* 80026608 8fbf0010 */  lw       $ra,16($sp)
/* 8002660C 00000000 */  nop      
/* 80026610 03e00008 */  jr       $ra
/* 80026614 27bd0018 */  addiu    $sp,$sp,24
