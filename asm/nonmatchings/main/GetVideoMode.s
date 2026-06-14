.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetVideoMode, 0x10

glabel GetVideoMode
    /* E1F84 800F1784 1380023C */  lui        $v0, %hi(D_80134838)
    /* E1F88 800F1788 3848428C */  lw         $v0, %lo(D_80134838)($v0)
    /* E1F8C 800F178C 0800E003 */  jr         $ra
    /* E1F90 800F1790 00000000 */   nop
endlabel GetVideoMode
    /* E1F94 800F1794 00000000 */  nop
    /* E1F98 800F1798 00000000 */  nop
    /* E1F9C 800F179C 00000000 */  nop
