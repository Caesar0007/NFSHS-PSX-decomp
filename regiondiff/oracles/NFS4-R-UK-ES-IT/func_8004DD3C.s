.set noat
.set noreorder

glabel func_8004DD3C
/* 8004DD3C 27bdffe8 */  addiu    $sp,$sp,-24
/* 8004DD40 3c091f80 */  lui      $t1,0x1f80
/* 8004DD44 35290004 */  ori      $t1,$t1,0x4
/* 8004DD48 3c0600ff */  lui      $a2,0xff
/* 8004DD4C 34c6ffff */  ori      $a2,$a2,0xffff
/* 8004DD50 3c078005 */  lui      $a3,0x8005
/* 8004DD54 3c028014 */  lui      $v0,0x8014
/* 8004DD58 a4e432f4 */  sh       $a0,13044($a3)
/* 8004DD5C 24e732f4 */  addiu    $a3,$a3,13044
/* 8004DD60 8c42eac8 */  lw       $v0,-5432($v0)
/* 8004DD64 3c08ff00 */  lui      $t0,0xff00
/* 8004DD68 afbf0010 */  sw       $ra,16($sp)
/* 8004DD6C 00021200 */  sll      $v0,$v0,0x8
/* 8004DD70 00a22821 */  addu     $a1,$a1,$v0
/* 8004DD74 a4e50002 */  sh       $a1,2($a3)
/* 8004DD78 8d240000 */  lw       $a0,0($t1)
/* 8004DD7C 3c051f80 */  lui      $a1,0x1f80
/* 8004DD80 8ca50000 */  lw       $a1,0($a1)
/* 8004DD84 8c830000 */  lw       $v1,0($a0)
/* 8004DD88 8ca20000 */  lw       $v0,0($a1)
/* 8004DD8C 00681824 */  and      $v1,$v1,$t0
/* 8004DD90 00461024 */  and      $v0,$v0,$a2
/* 8004DD94 00621825 */  or       $v1,$v1,$v0
/* 8004DD98 ac830000 */  sw       $v1,0($a0)
/* 8004DD9C 2483000c */  addiu    $v1,$a0,12
/* 8004DDA0 8ca20000 */  lw       $v0,0($a1)
/* 8004DDA4 00863024 */  and      $a2,$a0,$a2
/* 8004DDA8 ad230000 */  sw       $v1,0($t1)
/* 8004DDAC 00481024 */  and      $v0,$v0,$t0
/* 8004DDB0 00461025 */  or       $v0,$v0,$a2
/* 8004DDB4 aca20000 */  sw       $v0,0($a1)
/* 8004DDB8 0c03bb37 */  jal      func_800EECDC
/* 8004DDBC 00e02821 */  move     $a1,$a3
/* 8004DDC0 8fbf0010 */  lw       $ra,16($sp)
/* 8004DDC4 00000000 */  nop      
/* 8004DDC8 03e00008 */  jr       $ra
/* 8004DDCC 27bd0018 */  addiu    $sp,$sp,24
