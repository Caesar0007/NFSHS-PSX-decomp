.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadStartCom, 0x20

glabel PadStartCom
    /* E0660 800EFE60 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E0664 800EFE64 1000BFAF */  sw         $ra, 0x10($sp)
    /* E0668 800EFE68 0713040C */  jal        _padStartCom
    /* E066C 800EFE6C 00000000 */   nop
    /* E0670 800EFE70 1000BF8F */  lw         $ra, 0x10($sp)
    /* E0674 800EFE74 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E0678 800EFE78 0800E003 */  jr         $ra
    /* E067C 800EFE7C 00000000 */   nop
endlabel PadStartCom
