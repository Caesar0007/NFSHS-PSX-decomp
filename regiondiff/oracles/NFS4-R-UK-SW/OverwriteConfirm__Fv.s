.set noat
.set noreorder

glabel func_800347EC
/* 800347EC 27bdffe8 */  addiu    $sp,$sp,-24
/* 800347F0 3c028005 */  lui      $v0,0x8005
/* 800347F4 8c4422b0 */  lw       $a0,8880($v0)
/* 800347F8 24050290 */  li       $a1,656
/* 800347FC afbf0010 */  sw       $ra,16($sp)
/* 80034800 0c00d18e */  jal      func_80034638
/* 80034804 24840324 */  addiu    $a0,$a0,804
/* 80034808 8fbf0010 */  lw       $ra,16($sp)
/* 8003480C 00000000 */  nop      
/* 80034810 03e00008 */  jr       $ra
/* 80034814 27bd0018 */  addiu    $sp,$sp,24
