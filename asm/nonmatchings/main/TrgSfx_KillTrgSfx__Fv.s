.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_KillTrgSfx__Fv, 0x8

glabel TrgSfx_KillTrgSfx__Fv
    /* AC200 800BBA00 0800E003 */  jr         $ra
    /* AC204 800BBA04 00000000 */   nop
endlabel TrgSfx_KillTrgSfx__Fv
