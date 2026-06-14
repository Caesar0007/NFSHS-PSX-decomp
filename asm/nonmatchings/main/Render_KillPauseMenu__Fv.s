.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_KillPauseMenu__Fv, 0x20

glabel Render_KillPauseMenu__Fv
    /* A3C88 800B3488 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3C8C 800B348C 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3C90 800B3490 BB7B020C */  jal        MPause_KillMPause__Fv
    /* A3C94 800B3494 00000000 */   nop
    /* A3C98 800B3498 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3C9C 800B349C 00000000 */  nop
    /* A3CA0 800B34A0 0800E003 */  jr         $ra
    /* A3CA4 800B34A4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_KillPauseMenu__Fv
