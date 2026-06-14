.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VectorNormalS, 0x14

glabel VectorNormalS
    /* E22C8 800F1AC8 0000888C */  lw         $t0, 0x0($a0)
    /* E22CC 800F1ACC 0400898C */  lw         $t1, 0x4($a0)
    /* E22D0 800F1AD0 08008A8C */  lw         $t2, 0x8($a0)
    /* E22D4 800F1AD4 10000010 */  b          .L800F1B18
    /* E22D8 800F1AD8 00000000 */   nop
endlabel VectorNormalS
