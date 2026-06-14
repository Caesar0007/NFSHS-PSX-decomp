.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_KillHorizon__Fv, 0x2C

glabel Hrz_KillHorizon__Fv
    /* C0984 800D0184 4413848F */  lw         $a0, %gp_rel(gRngCoordTop)($gp)
    /* C0988 800D0188 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C098C 800D018C 1000BFAF */  sw         $ra, 0x10($sp)
    /* C0990 800D0190 5095030C */  jal        purgememadr
    /* C0994 800D0194 00000000 */   nop
    /* C0998 800D0198 273E030C */  jal        Sky_KillStars__Fv
    /* C099C 800D019C 00000000 */   nop
    /* C09A0 800D01A0 1000BF8F */  lw         $ra, 0x10($sp)
    /* C09A4 800D01A4 00000000 */  nop
    /* C09A8 800D01A8 0800E003 */  jr         $ra
    /* C09AC 800D01AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hrz_KillHorizon__Fv
