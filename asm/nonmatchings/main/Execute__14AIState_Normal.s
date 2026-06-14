.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__14AIState_Normal, 0x50

glabel Execute__14AIState_Normal
    /* 6028C 8006FA8C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 60290 8006FA90 1000B0AF */  sw         $s0, 0x10($sp)
    /* 60294 8006FA94 21808000 */  addu       $s0, $a0, $zero
    /* 60298 8006FA98 1400BFAF */  sw         $ra, 0x14($sp)
    /* 6029C 8006FA9C 0000048E */  lw         $a0, 0x0($s0)
    /* 602A0 8006FAA0 77BB010C */  jal        AISpeeds_CalcDesiredSpeed__FP8Car_tObj
    /* 602A4 8006FAA4 00000000 */   nop
    /* 602A8 8006FAA8 0000048E */  lw         $a0, 0x0($s0)
    /* 602AC 8006FAAC 9B5E010C */  jal        AI_GenericBeginCycle__FP8Car_tObj
    /* 602B0 8006FAB0 00000000 */   nop
    /* 602B4 8006FAB4 0000048E */  lw         $a0, 0x0($s0)
    /* 602B8 8006FAB8 A55E010C */  jal        AI_GenericCycle__FP8Car_tObj
    /* 602BC 8006FABC 00000000 */   nop
    /* 602C0 8006FAC0 0000048E */  lw         $a0, 0x0($s0)
    /* 602C4 8006FAC4 BA5E010C */  jal        AI_GenericEndCycle__FP8Car_tObj
    /* 602C8 8006FAC8 00000000 */   nop
    /* 602CC 8006FACC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 602D0 8006FAD0 1000B08F */  lw         $s0, 0x10($sp)
    /* 602D4 8006FAD4 0800E003 */  jr         $ra
    /* 602D8 8006FAD8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Execute__14AIState_Normal
