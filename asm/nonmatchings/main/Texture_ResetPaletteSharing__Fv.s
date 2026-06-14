.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_ResetPaletteSharing__Fv, 0x10

glabel Texture_ResetPaletteSharing__Fv
    /* CFE78 800DF678 C81580AF */  sw         $zero, %gp_rel(Texture_gNum4bitPal)($gp)
    /* CFE7C 800DF67C CC1580AF */  sw         $zero, %gp_rel(Texture_gNum8bitPal)($gp)
    /* CFE80 800DF680 0800E003 */  jr         $ra
    /* CFE84 800DF684 00000000 */   nop
endlabel Texture_ResetPaletteSharing__Fv
