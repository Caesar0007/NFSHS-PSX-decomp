.set noat
.set noreorder

glabel func_800BEDB0
/* 800BEDB0 00804021 */  move     $t0,$a0
/* 800BEDB4 00081040 */  sll      $v0,$t0,0x1
/* 800BEDB8 00481021 */  addu     $v0,$v0,$t0
/* 800BEDBC 000210c0 */  sll      $v0,$v0,0x3
/* 800BEDC0 00481021 */  addu     $v0,$v0,$t0
/* 800BEDC4 000210c0 */  sll      $v0,$v0,0x3
/* 800BEDC8 3c038012 */  lui      $v1,0x8012
/* 800BEDCC 2463ff70 */  addiu    $v1,$v1,-144
/* 800BEDD0 00433021 */  addu     $a2,$v0,$v1
/* 800BEDD4 8cc20000 */  lw       $v0,0($a2)
/* 800BEDD8 00000000 */  nop      
/* 800BEDDC 000218c0 */  sll      $v1,$v0,0x3
/* 800BEDE0 00622823 */  subu     $a1,$v1,$v0
/* 800BEDE4 af82125c */  sw       $v0,4700($gp)
/* 800BEDE8 04a10002 */  bgez     $a1,.L800BEDF4
/* 800BEDEC 3c071f80 */  lui      $a3,0x1f80
/* 800BEDF0 24a50007 */  addiu    $a1,$a1,7
.L800BEDF4:
/* 800BEDF4 94c2000c */  lhu      $v0,12($a2)
/* 800BEDF8 3c048014 */  lui      $a0,0x8014
/* 800BEDFC 8c84e634 */  lw       $a0,-6604($a0)
/* 800BEE00 a4e20010 */  sh       $v0,16($a3)
/* 800BEE04 8f821260 */  lw       $v0,4704($gp)
/* 800BEE08 94c3000e */  lhu      $v1,14($a2)
/* 800BEE0C 00021080 */  sll      $v0,$v0,0x2
/* 800BEE10 00c21021 */  addu     $v0,$a2,$v0
/* 800BEE14 a4e30012 */  sh       $v1,18($a3)
/* 800BEE18 8c4300c0 */  lw       $v1,192($v0)
/* 800BEE1C 000510c3 */  sra      $v0,$a1,0x3
/* 800BEE20 af821268 */  sw       $v0,4712($gp)
/* 800BEE24 10800007 */  beqz     $a0,.L800BEE44
/* 800BEE28 ace30000 */  sw       $v1,0($a3)
/* 800BEE2C 8ce20004 */  lw       $v0,4($a3)
/* 800BEE30 8cc30004 */  lw       $v1,4($a2)
/* 800BEE34 00000000 */  nop      
/* 800BEE38 00431021 */  addu     $v0,$v0,$v1
/* 800BEE3C 0802fba6 */  j        .L800BEE98
/* 800BEE40 ace20008 */  sw       $v0,8($a3)
.L800BEE44:
/* 800BEE44 8f82126c */  lw       $v0,4716($gp)
/* 800BEE48 00000000 */  nop      
/* 800BEE4C 2444fe60 */  addiu    $a0,$v0,-416
/* 800BEE50 3c028011 */  lui      $v0,0x8011
/* 800BEE54 8c4344dc */  lw       $v1,17628($v0)
/* 800BEE58 24020001 */  li       $v0,1
/* 800BEE5C 1462000d */  bne      $v1,$v0,.L800BEE94
/* 800BEE60 00000000 */  nop      
/* 800BEE64 3c028014 */  lui      $v0,0x8014
/* 800BEE68 8c42e6dc */  lw       $v0,-6436($v0)
/* 800BEE6C 00000000 */  nop      
/* 800BEE70 15020008 */  bne      $t0,$v0,.L800BEE94
/* 800BEE74 00000000 */  nop      
/* 800BEE78 8ce30004 */  lw       $v1,4($a3)
/* 800BEE7C 00000000 */  nop      
/* 800BEE80 00831023 */  subu     $v0,$a0,$v1
/* 800BEE84 00021043 */  sra      $v0,$v0,0x1
/* 800BEE88 00621821 */  addu     $v1,$v1,$v0
/* 800BEE8C 0802fba6 */  j        .L800BEE98
/* 800BEE90 ace30008 */  sw       $v1,8($a3)
.L800BEE94:
/* 800BEE94 ace40008 */  sw       $a0,8($a3)
.L800BEE98:
/* 800BEE98 03e00008 */  jr       $ra
/* 800BEE9C ace0000c */  sw       $zero,12($a3)
