.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_LoadReplay__Fv, 0x8

glabel Replay_LoadReplay__Fv
    /* A5824 800B5024 0800E003 */  jr         $ra
    /* A5828 800B5028 00000000 */   nop
endlabel Replay_LoadReplay__Fv
