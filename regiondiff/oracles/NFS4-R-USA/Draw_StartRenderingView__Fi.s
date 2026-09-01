.set noat
.set noreorder

glabel func_800BEDAC
/* 800BEDAC 00804021 */  move     $t0,$a0
/* 800BEDB0 00081040 */  sll      $v0,$t0,0x1
/* 800BEDB4 00481021 */  addu     $v0,$v0,$t0
/* 800BEDB8 000210c0 */  sll      $v0,$v0,0x3
/* 800BEDBC 00481021 */  addu     $v0,$v0,$t0
/* 800BEDC0 000210c0 */  sll      $v0,$v0,0x3
/* 800BEDC4 3c038012 */  lui      $v1,0x8012
/* 800BEDC8 2463ff44 */  addiu    $v1,$v1,-188
/* 800BEDCC 00433021 */  addu     $a2,$v0,$v1
/* 800BEDD0 8cc20000 */  lw       $v0,0($a2)
/* 800BEDD4 00000000 */  nop      
/* 800BEDD8 000218c0 */  sll      $v1,$v0,0x3
/* 800BEDDC 00622823 */  subu     $a1,$v1,$v0
/* 800BEDE0 af82125c */  sw       $v0,4700($gp)
/* 800BEDE4 04a10002 */  bgez     $a1,.L800BEDF0
/* 800BEDE8 3c071f80 */  lui      $a3,0x1f80
/* 800BEDEC 24a50007 */  addiu    $a1,$a1,7
.L800BEDF0:
/* 800BEDF0 94c2000c */  lhu      $v0,12($a2)
/* 800BEDF4 3c048014 */  lui      $a0,0x8014
/* 800BEDF8 8c84e608 */  lw       $a0,-6648($a0)
/* 800BEDFC a4e20010 */  sh       $v0,16($a3)
/* 800BEE00 8f821260 */  lw       $v0,4704($gp)
/* 800BEE04 94c3000e */  lhu      $v1,14($a2)
/* 800BEE08 00021080 */  sll      $v0,$v0,0x2
/* 800BEE0C 00c21021 */  addu     $v0,$a2,$v0
/* 800BEE10 a4e30012 */  sh       $v1,18($a3)
/* 800BEE14 8c4300c0 */  lw       $v1,192($v0)
/* 800BEE18 000510c3 */  sra      $v0,$a1,0x3
/* 800BEE1C af821268 */  sw       $v0,4712($gp)
/* 800BEE20 10800007 */  beqz     $a0,.L800BEE40
/* 800BEE24 ace30000 */  sw       $v1,0($a3)
/* 800BEE28 8ce20004 */  lw       $v0,4($a3)
/* 800BEE2C 8cc30004 */  lw       $v1,4($a2)
/* 800BEE30 00000000 */  nop      
/* 800BEE34 00431021 */  addu     $v0,$v0,$v1
/* 800BEE38 0802fba5 */  j        .L800BEE94
/* 800BEE3C ace20008 */  sw       $v0,8($a3)
.L800BEE40:
/* 800BEE40 8f82126c */  lw       $v0,4716($gp)
/* 800BEE44 00000000 */  nop      
/* 800BEE48 2444fe60 */  addiu    $a0,$v0,-416
/* 800BEE4C 3c028011 */  lui      $v0,0x8011
/* 800BEE50 8c4344b0 */  lw       $v1,17584($v0)
/* 800BEE54 24020001 */  li       $v0,1
/* 800BEE58 1462000d */  bne      $v1,$v0,.L800BEE90
/* 800BEE5C 00000000 */  nop      
/* 800BEE60 3c028014 */  lui      $v0,0x8014
/* 800BEE64 8c42e6b0 */  lw       $v0,-6480($v0)
/* 800BEE68 00000000 */  nop      
/* 800BEE6C 15020008 */  bne      $t0,$v0,.L800BEE90
/* 800BEE70 00000000 */  nop      
/* 800BEE74 8ce30004 */  lw       $v1,4($a3)
/* 800BEE78 00000000 */  nop      
/* 800BEE7C 00831023 */  subu     $v0,$a0,$v1
/* 800BEE80 00021043 */  sra      $v0,$v0,0x1
/* 800BEE84 00621821 */  addu     $v1,$v1,$v0
/* 800BEE88 0802fba5 */  j        .L800BEE94
/* 800BEE8C ace30008 */  sw       $v1,8($a3)
.L800BEE90:
/* 800BEE90 ace40008 */  sw       $a0,8($a3)
.L800BEE94:
/* 800BEE94 03e00008 */  jr       $ra
/* 800BEE98 ace0000c */  sw       $zero,12($a3)
