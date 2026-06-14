.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InGame_GetDevice__Fi, 0x8

glabel InGame_GetDevice__Fi
    /* CD534 800DCD34 0800E003 */  jr         $ra
    /* CD538 800DCD38 FF008230 */   andi      $v0, $a0, 0xFF
endlabel InGame_GetDevice__Fi
