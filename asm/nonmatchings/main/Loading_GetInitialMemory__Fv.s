.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Loading_GetInitialMemory__Fv, 0x20

glabel Loading_GetInitialMemory__Fv
    /* CBAF8 800DB2F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CBAFC 800DB2FC 1000BFAF */  sw         $ra, 0x10($sp)
    /* CBB00 800DB300 A194030C */  jal        largestunused
    /* CBB04 800DB304 00000000 */   nop
    /* CBB08 800DB308 1000BF8F */  lw         $ra, 0x10($sp)
    /* CBB0C 800DB30C 901482AF */  sw         $v0, %gp_rel(totalAvailMem)($gp)
    /* CBB10 800DB310 0800E003 */  jr         $ra
    /* CBB14 800DB314 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Loading_GetInitialMemory__Fv
