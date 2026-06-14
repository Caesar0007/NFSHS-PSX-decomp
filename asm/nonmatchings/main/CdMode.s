.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdMode, 0x10

glabel CdMode
    /* E7F90 800F7790 1480023C */  lui        $v0, %hi(CD_mode)
    /* E7F94 800F7794 64BF4290 */  lbu        $v0, %lo(CD_mode)($v0)
    /* E7F98 800F7798 0800E003 */  jr         $ra
    /* E7F9C 800F779C 00000000 */   nop
endlabel CdMode
