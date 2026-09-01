.set noat
.set noreorder

glabel func_800E4DA4
/* 800E4DA4 27bdffe8 */  addiu    $sp,$sp,-24
/* 800E4DA8 3c028014 */  lui      $v0,0x8014
/* 800E4DAC 8c43fba4 */  lw       $v1,-1116($v0)
/* 800E4DB0 2445fba4 */  addiu    $a1,$v0,-1116
/* 800E4DB4 afbf0010 */  sw       $ra,16($sp)
/* 800E4DB8 1060000a */  beqz     $v1,.L800E4DE4
/* 800E4DBC 00001021 */  move     $v0,$zero
/* 800E4DC0 2c820008 */  sltiu    $v0,$a0,8
/* 800E4DC4 10400006 */  beqz     $v0,.L800E4DE0
/* 800E4DC8 000410c0 */  sll      $v0,$a0,0x3
/* 800E4DCC 24a40004 */  addiu    $a0,$a1,4
/* 800E4DD0 0c03937d */  jal      func_800E4DF4
/* 800E4DD4 00442021 */  addu     $a0,$v0,$a0
/* 800E4DD8 08039379 */  j        .L800E4DE4
/* 800E4DDC 3042ffff */  andi     $v0,$v0,0xffff
.L800E4DE0:
/* 800E4DE0 00001021 */  move     $v0,$zero
.L800E4DE4:
/* 800E4DE4 8fbf0010 */  lw       $ra,16($sp)
/* 800E4DE8 00000000 */  nop      
/* 800E4DEC 03e00008 */  jr       $ra
/* 800E4DF0 27bd0018 */  addiu    $sp,$sp,24
