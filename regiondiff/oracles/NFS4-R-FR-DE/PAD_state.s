.set noat
.set noreorder

glabel func_800E4D90
/* 800E4D90 27bdffe8 */  addiu    $sp,$sp,-24
/* 800E4D94 3c028014 */  lui      $v0,0x8014
/* 800E4D98 8c43fbd0 */  lw       $v1,-1072($v0)
/* 800E4D9C 2445fbd0 */  addiu    $a1,$v0,-1072
/* 800E4DA0 afbf0010 */  sw       $ra,16($sp)
/* 800E4DA4 1060000a */  beqz     $v1,.L800E4DD0
/* 800E4DA8 00001021 */  move     $v0,$zero
/* 800E4DAC 2c820008 */  sltiu    $v0,$a0,8
/* 800E4DB0 10400006 */  beqz     $v0,.L800E4DCC
/* 800E4DB4 000410c0 */  sll      $v0,$a0,0x3
/* 800E4DB8 24a40004 */  addiu    $a0,$a1,4
/* 800E4DBC 0c039378 */  jal      func_800E4DE0
/* 800E4DC0 00442021 */  addu     $a0,$v0,$a0
/* 800E4DC4 08039374 */  j        .L800E4DD0
/* 800E4DC8 3042ffff */  andi     $v0,$v0,0xffff
.L800E4DCC:
/* 800E4DCC 00001021 */  move     $v0,$zero
.L800E4DD0:
/* 800E4DD0 8fbf0010 */  lw       $ra,16($sp)
/* 800E4DD4 00000000 */  nop      
/* 800E4DD8 03e00008 */  jr       $ra
/* 800E4DDC 27bd0018 */  addiu    $sp,$sp,24
