.set noat
.set noreorder

glabel func_80034794
/* 80034794 27bdffe8 */  addiu    $sp,$sp,-24
/* 80034798 3c028005 */  lui      $v0,0x8005
/* 8003479C 8c441fa8 */  lw       $a0,8104($v0)
/* 800347A0 24050290 */  li       $a1,656
/* 800347A4 afbf0010 */  sw       $ra,16($sp)
/* 800347A8 0c00d178 */  jal      func_800345E0
/* 800347AC 24840324 */  addiu    $a0,$a0,804
/* 800347B0 8fbf0010 */  lw       $ra,16($sp)
/* 800347B4 00000000 */  nop      
/* 800347B8 03e00008 */  jr       $ra
/* 800347BC 27bd0018 */  addiu    $sp,$sp,24
