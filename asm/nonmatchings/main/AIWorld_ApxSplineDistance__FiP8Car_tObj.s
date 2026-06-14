.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_ApxSplineDistance__FiP8Car_tObj, 0x28

glabel AIWorld_ApxSplineDistance__FiP8Car_tObj
    /* 63994 80073194 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 63998 80073198 21108000 */  addu       $v0, $a0, $zero
    /* 6399C 8007319C 2120A000 */  addu       $a0, $a1, $zero
    /* 639A0 800731A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 639A4 800731A4 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 639A8 800731A8 21284000 */   addu      $a1, $v0, $zero
    /* 639AC 800731AC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 639B0 800731B0 23100200 */  negu       $v0, $v0
    /* 639B4 800731B4 0800E003 */  jr         $ra
    /* 639B8 800731B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIWorld_ApxSplineDistance__FiP8Car_tObj
