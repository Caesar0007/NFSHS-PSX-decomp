.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTopMostDialog__11tDialogBase, 0x10

glabel GetTopMostDialog__11tDialogBase
    /* 9030 80018830 0580023C */  lui        $v0, %hi(_front_data_orgend)
    /* 9034 80018834 382B428C */  lw         $v0, %lo(_front_data_orgend)($v0)
    /* 9038 80018838 0800E003 */  jr         $ra
    /* 903C 8001883C 00000000 */   nop
endlabel GetTopMostDialog__11tDialogBase
