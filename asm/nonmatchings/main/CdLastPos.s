.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdLastPos, 0xC

glabel CdLastPos
    /* E7FA0 800F77A0 1480023C */  lui        $v0, %hi(CD_pos)
    /* E7FA4 800F77A4 0800E003 */  jr         $ra
    /* E7FA8 800F77A8 60BF4224 */   addiu     $v0, $v0, %lo(CD_pos)
endlabel CdLastPos
