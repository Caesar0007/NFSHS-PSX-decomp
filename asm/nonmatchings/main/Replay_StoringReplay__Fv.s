.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_StoringReplay__Fv, 0x20

glabel Replay_StoringReplay__Fv
    /* A489C 800B409C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A48A0 800B40A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* A48A4 800B40A4 E6D3020C */  jal        Replay_SaveReplay__Fv
    /* A48A8 800B40A8 00000000 */   nop
    /* A48AC 800B40AC 1000BF8F */  lw         $ra, 0x10($sp)
    /* A48B0 800B40B0 A40E80AF */  sw         $zero, %gp_rel(numValidCams)($gp)
    /* A48B4 800B40B4 0800E003 */  jr         $ra
    /* A48B8 800B40B8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Replay_StoringReplay__Fv
