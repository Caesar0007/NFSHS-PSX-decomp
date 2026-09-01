.set noat
.set noreorder

glabel func_800BEA38
/* 800BEA38 27bdffe8 */  addiu    $sp,$sp,-24
/* 800BEA3C 3c028011 */  lui      $v0,0x8011
/* 800BEA40 8c43429c */  lw       $v1,17052($v0)
/* 800BEA44 24020001 */  li       $v0,1
/* 800BEA48 afbf0014 */  sw       $ra,20($sp)
/* 800BEA4C 14620005 */  bne      $v1,$v0,.L800BEA64
/* 800BEA50 afb00010 */  sw       $s0,16($sp)
/* 800BEA54 0c02f9ed */  jal      func_800BE7B4
/* 800BEA58 00000000 */  nop      
/* 800BEA5C 0802fa9c */  j        .L800BEA70
/* 800BEA60 3c028011 */  lui      $v0,0x8011
.L800BEA64:
/* 800BEA64 0c02fa0e */  jal      func_800BE838
/* 800BEA68 00000000 */  nop      
/* 800BEA6C 3c028011 */  lui      $v0,0x8011
.L800BEA70:
/* 800BEA70 8c43429c */  lw       $v1,17052($v0)
/* 800BEA74 24020001 */  li       $v0,1
/* 800BEA78 14620003 */  bne      $v1,$v0,.L800BEA88
/* 800BEA7C 3c020002 */  lui      $v0,0x2
/* 800BEA80 0802faa4 */  j        .L800BEA90
/* 800BEA84 344228e8 */  ori      $v0,$v0,0x28e8
.L800BEA88:
/* 800BEA88 3c020001 */  lui      $v0,0x1
/* 800BEA8C 3442f9e8 */  ori      $v0,$v0,0xf9e8
.L800BEA90:
/* 800BEA90 af821270 */  sw       $v0,4720($gp)
/* 800BEA94 3c058014 */  lui      $a1,0x8014
/* 800BEA98 8f841270 */  lw       $a0,4720($gp)
/* 800BEA9C 0c037334 */  jal      func_800DCCD0
/* 800BEAA0 24a5e874 */  addiu    $a1,$a1,-6028
/* 800BEAA4 3c058014 */  lui      $a1,0x8014
/* 800BEAA8 24a5e878 */  addiu    $a1,$a1,-6024
/* 800BEAAC 3c108012 */  lui      $s0,0x8012
/* 800BEAB0 8f841270 */  lw       $a0,4720($gp)
/* 800BEAB4 26100500 */  addiu    $s0,$s0,1280
/* 800BEAB8 0c037334 */  jal      func_800DCCD0
/* 800BEABC ae020014 */  sw       $v0,20($s0)
/* 800BEAC0 ae02002c */  sw       $v0,44($s0)
/* 800BEAC4 8fbf0014 */  lw       $ra,20($sp)
/* 800BEAC8 8fb00010 */  lw       $s0,16($sp)
/* 800BEACC 03e00008 */  jr       $ra
/* 800BEAD0 27bd0018 */  addiu    $sp,$sp,24
