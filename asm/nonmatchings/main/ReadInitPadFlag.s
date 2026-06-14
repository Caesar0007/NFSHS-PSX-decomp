.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReadInitPadFlag, 0x10

glabel ReadInitPadFlag
    /* FD1B0 8010C9B0 1480023C */  lui        $v0, %hi(D_8013C338)
    /* FD1B4 8010C9B4 38C3428C */  lw         $v0, %lo(D_8013C338)($v0)
    /* FD1B8 8010C9B8 0800E003 */  jr         $ra
    /* FD1BC 8010C9BC 00000000 */   nop
endlabel ReadInitPadFlag
