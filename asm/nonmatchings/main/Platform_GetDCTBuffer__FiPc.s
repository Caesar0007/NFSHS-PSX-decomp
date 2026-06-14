.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_GetDCTBuffer__FiPc, 0x18

glabel Platform_GetDCTBuffer__FiPc
    /* CCCB4 800DC4B4 6015828F */  lw         $v0, %gp_rel(D_8013DAAC)($gp)
    /* CCCB8 800DC4B8 00000000 */  nop
    /* CCCBC 800DC4BC 21204400 */  addu       $a0, $v0, $a0
    /* CCCC0 800DC4C0 601584AF */  sw         $a0, %gp_rel(D_8013DAAC)($gp)
    /* CCCC4 800DC4C4 0800E003 */  jr         $ra
    /* CCCC8 800DC4C8 00000000 */   nop
endlabel Platform_GetDCTBuffer__FiPc
