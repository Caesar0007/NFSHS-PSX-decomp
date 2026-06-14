.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_ResetDCTBuffer__Fv, 0x14

glabel Platform_ResetDCTBuffer__Fv
    /* CCCA0 800DC4A0 1280023C */  lui        $v0, %hi(CF_DVLC)
    /* CCCA4 800DC4A4 38404224 */  addiu      $v0, $v0, %lo(CF_DVLC)
    /* CCCA8 800DC4A8 601582AF */  sw         $v0, %gp_rel(D_8013DAAC)($gp)
    /* CCCAC 800DC4AC 0800E003 */  jr         $ra
    /* CCCB0 800DC4B0 00000000 */   nop
endlabel Platform_ResetDCTBuffer__Fv
