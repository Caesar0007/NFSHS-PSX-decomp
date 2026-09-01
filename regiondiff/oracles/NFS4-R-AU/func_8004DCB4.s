.set noat
.set noreorder

glabel func_8004DCB4
/* 8004DCB4 27bdffe8 */  addiu    $sp,$sp,-24
/* 8004DCB8 3c091f80 */  lui      $t1,0x1f80
/* 8004DCBC 35290004 */  ori      $t1,$t1,0x4
/* 8004DCC0 3c0600ff */  lui      $a2,0xff
/* 8004DCC4 34c6ffff */  ori      $a2,$a2,0xffff
/* 8004DCC8 3c078005 */  lui      $a3,0x8005
/* 8004DCCC 3c028014 */  lui      $v0,0x8014
/* 8004DCD0 a4e42fac */  sh       $a0,12204($a3)
/* 8004DCD4 24e72fac */  addiu    $a3,$a3,12204
/* 8004DCD8 8c42eac8 */  lw       $v0,-5432($v0)
/* 8004DCDC 3c08ff00 */  lui      $t0,0xff00
/* 8004DCE0 afbf0010 */  sw       $ra,16($sp)
/* 8004DCE4 00021200 */  sll      $v0,$v0,0x8
/* 8004DCE8 00a22821 */  addu     $a1,$a1,$v0
/* 8004DCEC a4e50002 */  sh       $a1,2($a3)
/* 8004DCF0 8d240000 */  lw       $a0,0($t1)
/* 8004DCF4 3c051f80 */  lui      $a1,0x1f80
/* 8004DCF8 8ca50000 */  lw       $a1,0($a1)
/* 8004DCFC 8c830000 */  lw       $v1,0($a0)
/* 8004DD00 8ca20000 */  lw       $v0,0($a1)
/* 8004DD04 00681824 */  and      $v1,$v1,$t0
/* 8004DD08 00461024 */  and      $v0,$v0,$a2
/* 8004DD0C 00621825 */  or       $v1,$v1,$v0
/* 8004DD10 ac830000 */  sw       $v1,0($a0)
/* 8004DD14 2483000c */  addiu    $v1,$a0,12
/* 8004DD18 8ca20000 */  lw       $v0,0($a1)
/* 8004DD1C 00863024 */  and      $a2,$a0,$a2
/* 8004DD20 ad230000 */  sw       $v1,0($t1)
/* 8004DD24 00481024 */  and      $v0,$v0,$t0
/* 8004DD28 00461025 */  or       $v0,$v0,$a2
/* 8004DD2C aca20000 */  sw       $v0,0($a1)
/* 8004DD30 0c03bb37 */  jal      func_800EECDC
/* 8004DD34 00e02821 */  move     $a1,$a3
/* 8004DD38 8fbf0010 */  lw       $ra,16($sp)
/* 8004DD3C 00000000 */  nop      
/* 8004DD40 03e00008 */  jr       $ra
/* 8004DD44 27bd0018 */  addiu    $sp,$sp,24
