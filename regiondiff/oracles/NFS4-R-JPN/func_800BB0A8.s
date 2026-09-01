.set noat
.set noreorder

glabel func_800BB0A8
/* 800BB0A8 27bdff48 */  addiu    $sp,$sp,-184
/* 800BB0AC afbf00b0 */  sw       $ra,176($sp)
/* 800BB0B0 afb100ac */  sw       $s1,172($sp)
/* 800BB0B4 14800030 */  bnez     $a0,.L800BB178
/* 800BB0B8 afb000a8 */  sw       $s0,168($sp)
/* 800BB0BC 00002021 */  move     $a0,$zero
/* 800BB0C0 0c01fde2 */  jal      func_8007F788
/* 800BB0C4 27a50010 */  addiu    $a1,$sp,16
/* 800BB0C8 3c028012 */  lui      $v0,0x8012
/* 800BB0CC 2444f1fc */  addiu    $a0,$v0,-3588
/* 800BB0D0 8443f1fc */  lh       $v1,-3588($v0)
/* 800BB0D4 2402ffff */  li       $v0,-1
/* 800BB0D8 14620005 */  bne      $v1,$v0,.L800BB0F0
/* 800BB0DC 00008021 */  move     $s0,$zero
/* 800BB0E0 84820002 */  lh       $v0,2($a0)
/* 800BB0E4 00000000 */  nop      
/* 800BB0E8 10430023 */  beq      $v0,$v1,.L800BB178
/* 800BB0EC 00000000 */  nop      
.L800BB0F0:
/* 800BB0F0 3c028012 */  lui      $v0,0x8012
.L800BB0F4:
/* 800BB0F4 2451f1fc */  addiu    $s1,$v0,-3588
/* 800BB0F8 00101880 */  sll      $v1,$s0,0x2
/* 800BB0FC 00711821 */  addu     $v1,$v1,$s1
/* 800BB100 27a40098 */  addiu    $a0,$sp,152
/* 800BB104 84620000 */  lh       $v0,0($v1)
/* 800BB108 27a50010 */  addiu    $a1,$sp,16
/* 800BB10C afa0009c */  sw       $zero,156($sp)
/* 800BB110 00021400 */  sll      $v0,$v0,0x10
/* 800BB114 afa20098 */  sw       $v0,152($sp)
/* 800BB118 84620002 */  lh       $v0,2($v1)
/* 800BB11C 24060001 */  li       $a2,1
/* 800BB120 00021400 */  sll      $v0,$v0,0x10
/* 800BB124 0c02013a */  jal      func_800804E8
/* 800BB128 afa200a0 */  sw       $v0,160($sp)
/* 800BB12C 8fa30088 */  lw       $v1,136($sp)
/* 800BB130 00000000 */  nop      
/* 800BB134 10600005 */  beqz     $v1,.L800BB14C
/* 800BB138 00000000 */  nop      
/* 800BB13C 90620000 */  lbu      $v0,0($v1)
/* 800BB140 00000000 */  nop      
/* 800BB144 34420080 */  ori      $v0,$v0,0x80
/* 800BB148 a0620000 */  sb       $v0,0($v1)
.L800BB14C:
/* 800BB14C 26100001 */  addiu    $s0,$s0,1
/* 800BB150 00101080 */  sll      $v0,$s0,0x2
/* 800BB154 00511821 */  addu     $v1,$v0,$s1
/* 800BB158 84640000 */  lh       $a0,0($v1)
/* 800BB15C 2402ffff */  li       $v0,-1
/* 800BB160 1482ffe4 */  bne      $a0,$v0,.L800BB0F4
/* 800BB164 3c028012 */  lui      $v0,0x8012
/* 800BB168 84620002 */  lh       $v0,2($v1)
/* 800BB16C 00000000 */  nop      
/* 800BB170 1444ffe0 */  bne      $v0,$a0,.L800BB0F4
/* 800BB174 3c028012 */  lui      $v0,0x8012
.L800BB178:
/* 800BB178 8fbf00b0 */  lw       $ra,176($sp)
/* 800BB17C 8fb100ac */  lw       $s1,172($sp)
/* 800BB180 8fb000a8 */  lw       $s0,168($sp)
/* 800BB184 03e00008 */  jr       $ra
/* 800BB188 27bd00b8 */  addiu    $sp,$sp,184
