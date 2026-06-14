.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_ReSetBlitter__Fv, 0x14

glabel Font_ReSetBlitter__Fv
    /* BBFD8 800CB7D8 0D80023C */  lui        $v0, %hi(Font_Blit__FiiPviiP12charactertbli)
    /* BBFDC 800CB7DC ACB24224 */  addiu      $v0, $v0, %lo(Font_Blit__FiiPviiP12charactertbli)
    /* BBFE0 800CB7E0 A01882AF */  sw         $v0, %gp_rel(D_8013DDEC)($gp)
    /* BBFE4 800CB7E4 0800E003 */  jr         $ra
    /* BBFE8 800CB7E8 00000000 */   nop
endlabel Font_ReSetBlitter__Fv
