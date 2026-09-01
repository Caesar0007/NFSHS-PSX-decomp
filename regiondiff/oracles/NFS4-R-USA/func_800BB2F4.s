.set noat
.set noreorder

glabel func_800BB2F4
/* 800BB2F4 27bdff48 */  addiu    $sp,$sp,-184
/* 800BB2F8 afbf00b0 */  sw       $ra,176($sp)
/* 800BB2FC afb100ac */  sw       $s1,172($sp)
/* 800BB300 14800030 */  bnez     $a0,.L800BB3C4
/* 800BB304 afb000a8 */  sw       $s0,168($sp)
/* 800BB308 00002021 */  move     $a0,$zero
/* 800BB30C 0c01fde2 */  jal      func_8007F788
/* 800BB310 27a50010 */  addiu    $a1,$sp,16
/* 800BB314 3c028012 */  lui      $v0,0x8012
/* 800BB318 2444f410 */  addiu    $a0,$v0,-3056
/* 800BB31C 8443f410 */  lh       $v1,-3056($v0)
/* 800BB320 2402ffff */  li       $v0,-1
/* 800BB324 14620005 */  bne      $v1,$v0,.L800BB33C
/* 800BB328 00008021 */  move     $s0,$zero
/* 800BB32C 84820002 */  lh       $v0,2($a0)
/* 800BB330 00000000 */  nop      
/* 800BB334 10430023 */  beq      $v0,$v1,.L800BB3C4
/* 800BB338 00000000 */  nop      
.L800BB33C:
/* 800BB33C 3c028012 */  lui      $v0,0x8012
.L800BB340:
/* 800BB340 2451f410 */  addiu    $s1,$v0,-3056
/* 800BB344 00101880 */  sll      $v1,$s0,0x2
/* 800BB348 00711821 */  addu     $v1,$v1,$s1
/* 800BB34C 27a40098 */  addiu    $a0,$sp,152
/* 800BB350 84620000 */  lh       $v0,0($v1)
/* 800BB354 27a50010 */  addiu    $a1,$sp,16
/* 800BB358 afa0009c */  sw       $zero,156($sp)
/* 800BB35C 00021400 */  sll      $v0,$v0,0x10
/* 800BB360 afa20098 */  sw       $v0,152($sp)
/* 800BB364 84620002 */  lh       $v0,2($v1)
/* 800BB368 24060001 */  li       $a2,1
/* 800BB36C 00021400 */  sll      $v0,$v0,0x10
/* 800BB370 0c02013a */  jal      func_800804E8
/* 800BB374 afa200a0 */  sw       $v0,160($sp)
/* 800BB378 8fa30088 */  lw       $v1,136($sp)
/* 800BB37C 00000000 */  nop      
/* 800BB380 10600005 */  beqz     $v1,.L800BB398
/* 800BB384 00000000 */  nop      
/* 800BB388 90620000 */  lbu      $v0,0($v1)
/* 800BB38C 00000000 */  nop      
/* 800BB390 34420080 */  ori      $v0,$v0,0x80
/* 800BB394 a0620000 */  sb       $v0,0($v1)
.L800BB398:
/* 800BB398 26100001 */  addiu    $s0,$s0,1
/* 800BB39C 00101080 */  sll      $v0,$s0,0x2
/* 800BB3A0 00511821 */  addu     $v1,$v0,$s1
/* 800BB3A4 84640000 */  lh       $a0,0($v1)
/* 800BB3A8 2402ffff */  li       $v0,-1
/* 800BB3AC 1482ffe4 */  bne      $a0,$v0,.L800BB340
/* 800BB3B0 3c028012 */  lui      $v0,0x8012
/* 800BB3B4 84620002 */  lh       $v0,2($v1)
/* 800BB3B8 00000000 */  nop      
/* 800BB3BC 1444ffe0 */  bne      $v0,$a0,.L800BB340
/* 800BB3C0 3c028012 */  lui      $v0,0x8012
.L800BB3C4:
/* 800BB3C4 8fbf00b0 */  lw       $ra,176($sp)
/* 800BB3C8 8fb100ac */  lw       $s1,172($sp)
/* 800BB3CC 8fb000a8 */  lw       $s0,168($sp)
/* 800BB3D0 03e00008 */  jr       $ra
/* 800BB3D4 27bd00b8 */  addiu    $sp,$sp,184
