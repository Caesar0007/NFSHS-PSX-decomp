.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_InitPauseMenu__Fv, 0x20

glabel Render_InitPauseMenu__Fv
    /* A3C10 800B3410 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3C14 800B3414 1000BFAF */  sw         $ra, 0x10($sp)
    /* A3C18 800B3418 127B020C */  jal        MPause_InitMPause__Fv
    /* A3C1C 800B341C 00000000 */   nop
    /* A3C20 800B3420 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3C24 800B3424 00000000 */  nop
    /* A3C28 800B3428 0800E003 */  jr         $ra
    /* A3C2C 800B342C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_InitPauseMenu__Fv
