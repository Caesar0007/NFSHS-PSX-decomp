.set noat
.set noreorder

glabel func_800347C8
/* 800347C8 27bdffe8 */  addiu    $sp,$sp,-24
/* 800347CC 3c028005 */  lui      $v0,0x8005
/* 800347D0 8c441fa8 */  lw       $a0,8104($v0)
/* 800347D4 24050291 */  li       $a1,657
/* 800347D8 afbf0010 */  sw       $ra,16($sp)
/* 800347DC 0c00d178 */  jal      func_800345E0
/* 800347E0 24840328 */  addiu    $a0,$a0,808
/* 800347E4 8fbf0010 */  lw       $ra,16($sp)
/* 800347E8 00000000 */  nop      
/* 800347EC 03e00008 */  jr       $ra
/* 800347F0 27bd0018 */  addiu    $sp,$sp,24
