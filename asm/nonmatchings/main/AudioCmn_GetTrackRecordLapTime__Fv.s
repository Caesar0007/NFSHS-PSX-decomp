.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_GetTrackRecordLapTime__Fv, 0x10

glabel AudioCmn_GetTrackRecordLapTime__Fv
    /* 66C80 80076480 1180023C */  lui        $v0, %hi(D_801132D4)
    /* 66C84 80076484 D432428C */  lw         $v0, %lo(D_801132D4)($v0)
    /* 66C88 80076488 0800E003 */  jr         $ra
    /* 66C8C 8007648C 00000000 */   nop
endlabel AudioCmn_GetTrackRecordLapTime__Fv
