.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_DeInitPaletteSharing__Fv, 0x48

glabel Texture_DeInitPaletteSharing__Fv
    /* CFE30 800DF630 D015848F */  lw         $a0, %gp_rel(Texture_gP4bitPmx)($gp)
    /* CFE34 800DF634 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CFE38 800DF638 1000BFAF */  sw         $ra, 0x10($sp)
    /* CFE3C 800DF63C 5095030C */  jal        purgememadr
    /* CFE40 800DF640 00000000 */   nop
    /* CFE44 800DF644 D415848F */  lw         $a0, %gp_rel(Texture_gP8bitPmx)($gp)
    /* CFE48 800DF648 5095030C */  jal        purgememadr
    /* CFE4C 800DF64C 00000000 */   nop
    /* CFE50 800DF650 D815848F */  lw         $a0, %gp_rel(Texture_gPalette4bit)($gp)
    /* CFE54 800DF654 5095030C */  jal        purgememadr
    /* CFE58 800DF658 00000000 */   nop
    /* CFE5C 800DF65C DC15848F */  lw         $a0, %gp_rel(Texture_gPalette8bit)($gp)
    /* CFE60 800DF660 5095030C */  jal        purgememadr
    /* CFE64 800DF664 00000000 */   nop
    /* CFE68 800DF668 1000BF8F */  lw         $ra, 0x10($sp)
    /* CFE6C 800DF66C 00000000 */  nop
    /* CFE70 800DF670 0800E003 */  jr         $ra
    /* CFE74 800DF674 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Texture_DeInitPaletteSharing__Fv
