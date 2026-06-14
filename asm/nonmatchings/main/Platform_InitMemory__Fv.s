.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Platform_InitMemory__Fv, 0x30

glabel Platform_InitMemory__Fv
    /* CCAB8 800DC2B8 0180033C */  lui        $v1, (0x80010080 >> 16)
    /* CCABC 800DC2BC 80006334 */  ori        $v1, $v1, (0x80010080 & 0xFFFF)
    /* CCAC0 800DC2C0 0580023C */  lui        $v0, %hi(D_80054D10)
    /* CCAC4 800DC2C4 104D4224 */  addiu      $v0, $v0, %lo(D_80054D10)
    /* CCAC8 800DC2C8 23104300 */  subu       $v0, $v0, $v1
    /* CCACC 800DC2CC 701582AF */  sw         $v0, %gp_rel(gTotalMemory)($gp)
    /* CCAD0 800DC2D0 21104300 */  addu       $v0, $v0, $v1
    /* CCAD4 800DC2D4 641583AF */  sw         $v1, %gp_rel(gLowMemory)($gp)
    /* CCAD8 800DC2D8 681582AF */  sw         $v0, %gp_rel(gHighMemory)($gp)
    /* CCADC 800DC2DC 6C1583AF */  sw         $v1, %gp_rel(gCurrentMemory)($gp)
    /* CCAE0 800DC2E0 0800E003 */  jr         $ra
    /* CCAE4 800DC2E4 00000000 */   nop
endlabel Platform_InitMemory__Fv
