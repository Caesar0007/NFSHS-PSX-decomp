.set noat
.set noreorder

glabel func_800FA3E0
/* 800FA3E0 27bdffe8 */  addiu    $sp,$sp,-24
/* 800FA3E4 3c028014 */  lui      $v0,0x8014
/* 800FA3E8 24437dec */  addiu    $v1,$v0,32236
/* 800FA3EC afbf0010 */  sw       $ra,16($sp)
/* 800FA3F0 8c620018 */  lw       $v0,24($v1)
/* 800FA3F4 00000000 */  nop      
/* 800FA3F8 1040000d */  beqz     $v0,.L800FA430
/* 800FA3FC 2442ffff */  addiu    $v0,$v0,-1
/* 800FA400 1440000b */  bnez     $v0,.L800FA430
/* 800FA404 ac620018 */  sw       $v0,24($v1)
/* 800FA408 0c03dffa */  jal      func_800F7FE8
/* 800FA40C 00002021 */  move     $a0,$zero
/* 800FA410 3c048010 */  lui      $a0,0x8010
/* 800FA414 2484a230 */  addiu    $a0,$a0,-24016
/* 800FA418 00002821 */  move     $a1,$zero
/* 800FA41C 0c039d33 */  jal      func_800E74CC
/* 800FA420 00a03021 */  move     $a2,$a1
/* 800FA424 3c048010 */  lui      $a0,0x8010
/* 800FA428 0c03ade4 */  jal      func_800EB790
/* 800FA42C 2484a3e0 */  addiu    $a0,$a0,-23584
.L800FA430:
/* 800FA430 8fbf0010 */  lw       $ra,16($sp)
/* 800FA434 00000000 */  nop      
/* 800FA438 03e00008 */  jr       $ra
/* 800FA43C 27bd0018 */  addiu    $sp,$sp,24
