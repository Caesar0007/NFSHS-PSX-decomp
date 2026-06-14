.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckCallback, 0x10

glabel CheckCallback
    /* E3140 800F2940 1380023C */  lui        $v0, %hi(D_80134AFA)
    /* E3144 800F2944 FA4A4294 */  lhu        $v0, %lo(D_80134AFA)($v0)
    /* E3148 800F2948 0800E003 */  jr         $ra
    /* E314C 800F294C 00000000 */   nop
endlabel CheckCallback
