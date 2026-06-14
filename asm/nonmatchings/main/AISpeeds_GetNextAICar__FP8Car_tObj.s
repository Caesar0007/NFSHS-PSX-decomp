.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetNextAICar__FP8Car_tObj, 0xC

glabel AISpeeds_GetNextAICar__FP8Car_tObj
    /* 5EA58 8006E258 6807828C */  lw         $v0, 0x768($a0)
    /* 5EA5C 8006E25C 0800E003 */  jr         $ra
    /* 5EA60 8006E260 00000000 */   nop
endlabel AISpeeds_GetNextAICar__FP8Car_tObj
