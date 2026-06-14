.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HighExecute__12AIHigh_Human, 0x3C

glabel HighExecute__12AIHigh_Human
    /* 53A70 80063270 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 53A74 80063274 1000B0AF */  sw         $s0, 0x10($sp)
    /* 53A78 80063278 1400BFAF */  sw         $ra, 0x14($sp)
    /* 53A7C 8006327C B18A010C */  jal        HandleCops__13AIHigh_Player
    /* 53A80 80063280 21808000 */   addu      $s0, $a0, $zero
    /* 53A84 80063284 0000038E */  lw         $v1, 0x0($s0)
    /* 53A88 80063288 01000224 */  addiu      $v0, $zero, 0x1
    /* 53A8C 8006328C 910062A0 */  sb         $v0, 0x91($v1)
    /* 53A90 80063290 0400048E */  lw         $a0, 0x4($s0)
    /* 53A94 80063294 7BBE010C */  jal        StateExecute__12AIState_Base
    /* 53A98 80063298 00000000 */   nop
    /* 53A9C 8006329C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 53AA0 800632A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 53AA4 800632A4 0800E003 */  jr         $ra
    /* 53AA8 800632A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HighExecute__12AIHigh_Human
