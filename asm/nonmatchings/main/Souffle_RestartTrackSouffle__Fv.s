.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Souffle_RestartTrackSouffle__Fv, 0x1C

glabel Souffle_RestartTrackSouffle__Fv
    /* A8714 800B7F14 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A8718 800B7F18 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* A871C 800B7F1C 080F80AF */  sw         $zero, %gp_rel(gWindDir)($gp)
    /* A8720 800B7F20 000F80AF */  sw         $zero, %gp_rel(gCISouffle)($gp)
    /* A8724 800B7F24 040F82AF */  sw         $v0, %gp_rel(gTMoveSouffle)($gp)
    /* A8728 800B7F28 0800E003 */  jr         $ra
    /* A872C 800B7F2C 00000000 */   nop
endlabel Souffle_RestartTrackSouffle__Fv
