.set noat
.set noreorder

glabel func_8004DD24
/* 8004DD24 27bdffe8 */  addiu    $sp,$sp,-24
/* 8004DD28 3c091f80 */  lui      $t1,0x1f80
/* 8004DD2C 35290004 */  ori      $t1,$t1,0x4
/* 8004DD30 3c0600ff */  lui      $a2,0xff
/* 8004DD34 34c6ffff */  ori      $a2,$a2,0xffff
/* 8004DD38 3c078005 */  lui      $a3,0x8005
/* 8004DD3C 3c028014 */  lui      $v0,0x8014
/* 8004DD40 a4e432b4 */  sh       $a0,12980($a3)
/* 8004DD44 24e732b4 */  addiu    $a3,$a3,12980
/* 8004DD48 8c42eac8 */  lw       $v0,-5432($v0)
/* 8004DD4C 3c08ff00 */  lui      $t0,0xff00
/* 8004DD50 afbf0010 */  sw       $ra,16($sp)
/* 8004DD54 00021200 */  sll      $v0,$v0,0x8
/* 8004DD58 00a22821 */  addu     $a1,$a1,$v0
/* 8004DD5C a4e50002 */  sh       $a1,2($a3)
/* 8004DD60 8d240000 */  lw       $a0,0($t1)
/* 8004DD64 3c051f80 */  lui      $a1,0x1f80
/* 8004DD68 8ca50000 */  lw       $a1,0($a1)
/* 8004DD6C 8c830000 */  lw       $v1,0($a0)
/* 8004DD70 8ca20000 */  lw       $v0,0($a1)
/* 8004DD74 00681824 */  and      $v1,$v1,$t0
/* 8004DD78 00461024 */  and      $v0,$v0,$a2
/* 8004DD7C 00621825 */  or       $v1,$v1,$v0
/* 8004DD80 ac830000 */  sw       $v1,0($a0)
/* 8004DD84 2483000c */  addiu    $v1,$a0,12
/* 8004DD88 8ca20000 */  lw       $v0,0($a1)
/* 8004DD8C 00863024 */  and      $a2,$a0,$a2
/* 8004DD90 ad230000 */  sw       $v1,0($t1)
/* 8004DD94 00481024 */  and      $v0,$v0,$t0
/* 8004DD98 00461025 */  or       $v0,$v0,$a2
/* 8004DD9C aca20000 */  sw       $v0,0($a1)
/* 8004DDA0 0c03bb37 */  jal      func_800EECDC
/* 8004DDA4 00e02821 */  move     $a1,$a3
/* 8004DDA8 8fbf0010 */  lw       $ra,16($sp)
/* 8004DDAC 00000000 */  nop      
/* 8004DDB0 03e00008 */  jr       $ra
/* 8004DDB4 27bd0018 */  addiu    $sp,$sp,24
