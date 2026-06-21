.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __17tScreenTrophyRoom, 0x40

glabel __17tScreenTrophyRoom
    /* 30D70 80040570 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 30D74 80040574 1000B0AF */  sw         $s0, 0x10($sp)
    /* 30D78 80040578 1400BFAF */  sw         $ra, 0x14($sp)
    /* 30D7C 8004057C 0898000C */  jal        __7tScreen
    /* 30D80 80040580 21808000 */   addu      $s0, $a0, $zero
    /* 30D84 80040584 21100002 */  addu       $v0, $s0, $zero
    /* 30D88 80040588 0180033C */  lui        $v1, %hi(_vt_17tScreenTrophyRoom)
    /* 30D8C 8004058C 281E6324 */  addiu      $v1, $v1, %lo(_vt_17tScreenTrophyRoom)
    /* 30D90 80040590 600043AC */  sw         $v1, 0x60($v0)
    /* 30D94 80040594 9C0040A0 */  sb         $zero, 0x9C($v0)
    /* 30D98 80040598 D40040A4 */  sh         $zero, 0xD4($v0)
    /* 30D9C 8004059C D60040A4 */  sh         $zero, 0xD6($v0)
    /* 30DA0 800405A0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 30DA4 800405A4 1000B08F */  lw         $s0, 0x10($sp)
    /* 30DA8 800405A8 0800E003 */  jr         $ra
    /* 30DAC 800405AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __17tScreenTrophyRoom
