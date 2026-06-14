.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdStatus, 0x10

glabel CdStatus
    /* E7F80 800F7780 1480023C */  lui        $v0, %hi(CD_status)
    /* E7F84 800F7784 54BF4290 */  lbu        $v0, %lo(CD_status)($v0)
    /* E7F88 800F7788 0800E003 */  jr         $ra
    /* E7F8C 800F778C 00000000 */   nop
endlabel CdStatus
