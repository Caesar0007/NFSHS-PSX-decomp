.set noat
.set noreorder

glabel func_800BB2F8
/* 800BB2F8 27bdff48 */  addiu    $sp,$sp,-184
/* 800BB2FC afbf00b0 */  sw       $ra,176($sp)
/* 800BB300 afb100ac */  sw       $s1,172($sp)
/* 800BB304 14800030 */  bnez     $a0,.L800BB3C8
/* 800BB308 afb000a8 */  sw       $s0,168($sp)
/* 800BB30C 00002021 */  move     $a0,$zero
/* 800BB310 0c01fde2 */  jal      func_8007F788
/* 800BB314 27a50010 */  addiu    $a1,$sp,16
/* 800BB318 3c028012 */  lui      $v0,0x8012
/* 800BB31C 2444f43c */  addiu    $a0,$v0,-3012
/* 800BB320 8443f43c */  lh       $v1,-3012($v0)
/* 800BB324 2402ffff */  li       $v0,-1
/* 800BB328 14620005 */  bne      $v1,$v0,.L800BB340
/* 800BB32C 00008021 */  move     $s0,$zero
/* 800BB330 84820002 */  lh       $v0,2($a0)
/* 800BB334 00000000 */  nop      
/* 800BB338 10430023 */  beq      $v0,$v1,.L800BB3C8
/* 800BB33C 00000000 */  nop      
.L800BB340:
/* 800BB340 3c028012 */  lui      $v0,0x8012
.L800BB344:
/* 800BB344 2451f43c */  addiu    $s1,$v0,-3012
/* 800BB348 00101880 */  sll      $v1,$s0,0x2
/* 800BB34C 00711821 */  addu     $v1,$v1,$s1
/* 800BB350 27a40098 */  addiu    $a0,$sp,152
/* 800BB354 84620000 */  lh       $v0,0($v1)
/* 800BB358 27a50010 */  addiu    $a1,$sp,16
/* 800BB35C afa0009c */  sw       $zero,156($sp)
/* 800BB360 00021400 */  sll      $v0,$v0,0x10
/* 800BB364 afa20098 */  sw       $v0,152($sp)
/* 800BB368 84620002 */  lh       $v0,2($v1)
/* 800BB36C 24060001 */  li       $a2,1
/* 800BB370 00021400 */  sll      $v0,$v0,0x10
/* 800BB374 0c02013a */  jal      func_800804E8
/* 800BB378 afa200a0 */  sw       $v0,160($sp)
/* 800BB37C 8fa30088 */  lw       $v1,136($sp)
/* 800BB380 00000000 */  nop      
/* 800BB384 10600005 */  beqz     $v1,.L800BB39C
/* 800BB388 00000000 */  nop      
/* 800BB38C 90620000 */  lbu      $v0,0($v1)
/* 800BB390 00000000 */  nop      
/* 800BB394 34420080 */  ori      $v0,$v0,0x80
/* 800BB398 a0620000 */  sb       $v0,0($v1)
.L800BB39C:
/* 800BB39C 26100001 */  addiu    $s0,$s0,1
/* 800BB3A0 00101080 */  sll      $v0,$s0,0x2
/* 800BB3A4 00511821 */  addu     $v1,$v0,$s1
/* 800BB3A8 84640000 */  lh       $a0,0($v1)
/* 800BB3AC 2402ffff */  li       $v0,-1
/* 800BB3B0 1482ffe4 */  bne      $a0,$v0,.L800BB344
/* 800BB3B4 3c028012 */  lui      $v0,0x8012
/* 800BB3B8 84620002 */  lh       $v0,2($v1)
/* 800BB3BC 00000000 */  nop      
/* 800BB3C0 1444ffe0 */  bne      $v0,$a0,.L800BB344
/* 800BB3C4 3c028012 */  lui      $v0,0x8012
.L800BB3C8:
/* 800BB3C8 8fbf00b0 */  lw       $ra,176($sp)
/* 800BB3CC 8fb100ac */  lw       $s1,172($sp)
/* 800BB3D0 8fb000a8 */  lw       $s0,168($sp)
/* 800BB3D4 03e00008 */  jr       $ra
/* 800BB3D8 27bd00b8 */  addiu    $sp,$sp,184
