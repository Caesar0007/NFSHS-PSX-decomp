.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_InitThunder__Fv, 0x14

glabel AudioCmn_InitThunder__Fv
    /* 66C90 80076490 C80180AF */  sw         $zero, %gp_rel(AudioCmn_ThunderAmp)($gp)
    /* 66C94 80076494 CC0180AF */  sw         $zero, %gp_rel(AudioCmn_ThunderAzi)($gp)
    /* 66C98 80076498 D00180AF */  sw         $zero, %gp_rel(AudioCmn_ThunderDel)($gp)
    /* 66C9C 8007649C 0800E003 */  jr         $ra
    /* 66CA0 800764A0 00000000 */   nop
endlabel AudioCmn_InitThunder__Fv
