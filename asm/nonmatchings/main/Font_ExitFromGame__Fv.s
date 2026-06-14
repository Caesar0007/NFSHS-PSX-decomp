.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_ExitFromGame__Fv, 0x14

glabel Font_ExitFromGame__Fv
    /* BC0A8 800CB8A8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* BC0AC 800CB8AC 081382AF */  sw         $v0, %gp_rel(font_clutx)($gp)
    /* BC0B0 800CB8B0 0C1382AF */  sw         $v0, %gp_rel(font_cluty)($gp)
    /* BC0B4 800CB8B4 0800E003 */  jr         $ra
    /* BC0B8 800CB8B8 00000000 */   nop
endlabel Font_ExitFromGame__Fv
