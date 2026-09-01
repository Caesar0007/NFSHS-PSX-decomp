.set noat
.set noreorder

glabel func_800A77C0
/* 800A77C0 8f840d80 */  lw       $a0,3456($gp)
/* 800A77C4 27bdffe8 */  addiu    $sp,$sp,-24
/* 800A77C8 afbf0010 */  sw       $ra,16($sp)
/* 800A77CC 0c03984b */  jal      func_800E612C
/* 800A77D0 00000000 */  nop      
/* 800A77D4 8fbf0010 */  lw       $ra,16($sp)
/* 800A77D8 af800d84 */  sw       $zero,3460($gp)
/* 800A77DC 03e00008 */  jr       $ra
/* 800A77E0 27bd0018 */  addiu    $sp,$sp,24
