.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sky_KillStars__Fv, 0x44

glabel Sky_KillStars__Fv
    /* C009C 800CF89C 2C13848F */  lw         $a0, %gp_rel(D_8013D878)($gp)
    /* C00A0 800CF8A0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C00A4 800CF8A4 03008010 */  beqz       $a0, .L800CF8B4
    /* C00A8 800CF8A8 1000BFAF */   sw        $ra, 0x10($sp)
    /* C00AC 800CF8AC 5095030C */  jal        purgememadr
    /* C00B0 800CF8B0 00000000 */   nop
  .L800CF8B4:
    /* C00B4 800CF8B4 3013848F */  lw         $a0, %gp_rel(D_8013D87C)($gp)
    /* C00B8 800CF8B8 00000000 */  nop
    /* C00BC 800CF8BC 03008010 */  beqz       $a0, .L800CF8CC
    /* C00C0 800CF8C0 00000000 */   nop
    /* C00C4 800CF8C4 5095030C */  jal        purgememadr
    /* C00C8 800CF8C8 00000000 */   nop
  .L800CF8CC:
    /* C00CC 800CF8CC 1000BF8F */  lw         $ra, 0x10($sp)
    /* C00D0 800CF8D0 2C1380AF */  sw         $zero, %gp_rel(D_8013D878)($gp)
    /* C00D4 800CF8D4 301380AF */  sw         $zero, %gp_rel(D_8013D87C)($gp)
    /* C00D8 800CF8D8 0800E003 */  jr         $ra
    /* C00DC 800CF8DC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sky_KillStars__Fv
