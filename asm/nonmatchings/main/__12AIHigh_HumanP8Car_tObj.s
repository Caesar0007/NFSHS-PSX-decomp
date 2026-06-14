.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __12AIHigh_HumanP8Car_tObj, 0x34

glabel __12AIHigh_HumanP8Car_tObj
    /* 53AAC 800632AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 53AB0 800632B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 53AB4 800632B4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 53AB8 800632B8 308A010C */  jal        __13AIHigh_PlayerP8Car_tObj
    /* 53ABC 800632BC 21808000 */   addu      $s0, $a0, $zero
    /* 53AC0 800632C0 0580023C */  lui        $v0, %hi(_vt_12AIHigh_Human)
    /* 53AC4 800632C4 C8504224 */  addiu      $v0, $v0, %lo(_vt_12AIHigh_Human)
    /* 53AC8 800632C8 140002AE */  sw         $v0, 0x14($s0)
    /* 53ACC 800632CC 21100002 */  addu       $v0, $s0, $zero
    /* 53AD0 800632D0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 53AD4 800632D4 1000B08F */  lw         $s0, 0x10($sp)
    /* 53AD8 800632D8 0800E003 */  jr         $ra
    /* 53ADC 800632DC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __12AIHigh_HumanP8Car_tObj
