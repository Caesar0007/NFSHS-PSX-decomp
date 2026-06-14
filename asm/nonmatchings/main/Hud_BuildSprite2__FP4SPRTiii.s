.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildSprite2__FP4SPRTiii, 0x2C

glabel Hud_BuildSprite2__FP4SPRTiii
    /* C2844 800D2044 C818828F */  lw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C2848 800D2048 C4188393 */  lbu        $v1, %gp_rel(D_8013DE10)($gp)
    /* C284C 800D204C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C2850 800D2050 1800BFAF */  sw         $ra, 0x18($sp)
    /* C2854 800D2054 1000A2AF */  sw         $v0, 0x10($sp)
    /* C2858 800D2058 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C285C 800D205C 1400A3AF */   sw        $v1, 0x14($sp)
    /* C2860 800D2060 1800BF8F */  lw         $ra, 0x18($sp)
    /* C2864 800D2064 00000000 */  nop
    /* C2868 800D2068 0800E003 */  jr         $ra
    /* C286C 800D206C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_BuildSprite2__FP4SPRTiii
