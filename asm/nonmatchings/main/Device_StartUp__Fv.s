.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_StartUp__Fv, 0x28

glabel Device_StartUp__Fv
    /* ADDB8 800BD5B8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* ADDBC 800BD5BC 341280AF */  sw         $zero, %gp_rel(Device_gPaused)($gp)
    /* ADDC0 800BD5C0 2C1280AF */  sw         $zero, %gp_rel(Device_gForcePause)($gp)
    /* ADDC4 800BD5C4 301282AF */  sw         $v0, %gp_rel(Device_gPausePort)($gp)
    /* ADDC8 800BD5C8 381280AF */  sw         $zero, %gp_rel(Device_gToggleTime)($gp)
    /* ADDCC 800BD5CC 3C1280AF */  sw         $zero, %gp_rel(D_8013D788)($gp)
    /* ADDD0 800BD5D0 401280AF */  sw         $zero, %gp_rel(Device_gPrev)($gp)
    /* ADDD4 800BD5D4 441280AF */  sw         $zero, %gp_rel(D_8013D790)($gp)
    /* ADDD8 800BD5D8 0800E003 */  jr         $ra
    /* ADDDC 800BD5DC 00000000 */   nop
endlabel Device_StartUp__Fv
