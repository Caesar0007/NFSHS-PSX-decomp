.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StopCARD, 0x28

glabel StopCARD
    /* FD028 8010C828 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FD02C 8010C82C 1000BFAF */  sw         $ra, 0x10($sp)
    /* FD030 8010C830 EC32040C */  jal        StopCARD2
    /* FD034 8010C834 00000000 */   nop
    /* FD038 8010C838 F032040C */  jal        _ExitCard
    /* FD03C 8010C83C 00000000 */   nop
    /* FD040 8010C840 1000BF8F */  lw         $ra, 0x10($sp)
    /* FD044 8010C844 1800BD27 */  addiu      $sp, $sp, 0x18
    /* FD048 8010C848 0800E003 */  jr         $ra
    /* FD04C 8010C84C 00000000 */   nop
endlabel StopCARD
    /* FD050 8010C850 00000000 */  nop
