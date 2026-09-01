.set noat
.set noreorder

glabel func_800701BC
/* 800701BC 27bdffe8 */  addiu    $sp,$sp,-24
/* 800701C0 afbf0010 */  sw       $ra,16($sp)
/* 800701C4 24030009 */  li       $v1,9
/* 800701C8 3c028011 */  lui      $v0,0x8011
/* 800701CC 2442f0dc */  addiu    $v0,$v0,-3876
/* 800701D0 24420024 */  addiu    $v0,$v0,36
.L800701D4:
/* 800701D4 ac400000 */  sw       $zero,0($v0)
/* 800701D8 2463ffff */  addiu    $v1,$v1,-1
/* 800701DC 0461fffd */  bgez     $v1,.L800701D4
/* 800701E0 2442fffc */  addiu    $v0,$v0,-4
/* 800701E4 0c01c848 */  jal      func_80072120
/* 800701E8 00000000 */  nop      
/* 800701EC 8fbf0010 */  lw       $ra,16($sp)
/* 800701F0 00000000 */  nop      
/* 800701F4 03e00008 */  jr       $ra
/* 800701F8 27bd0018 */  addiu    $sp,$sp,24
