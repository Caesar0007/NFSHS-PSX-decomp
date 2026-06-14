.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadStopCom, 0x20

glabel PadStopCom
    /* E0680 800EFE80 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E0684 800EFE84 1000BFAF */  sw         $ra, 0x10($sp)
    /* E0688 800EFE88 3A13040C */  jal        _padStopCom
    /* E068C 800EFE8C 00000000 */   nop
    /* E0690 800EFE90 1000BF8F */  lw         $ra, 0x10($sp)
    /* E0694 800EFE94 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E0698 800EFE98 0800E003 */  jr         $ra
    /* E069C 800EFE9C 00000000 */   nop
endlabel PadStopCom
