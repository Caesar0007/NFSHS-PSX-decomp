.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UserFuncComplete, 0x10

glabel UserFuncComplete
    /* FA4F8 80109CF8 1480023C */  lui        $v0, %hi(D_8013C2E0)
    /* FA4FC 80109CFC E0C2428C */  lw         $v0, %lo(D_8013C2E0)($v0)
    /* FA500 80109D00 0800E003 */  jr         $ra
    /* FA504 80109D04 C2170200 */   srl       $v0, $v0, 31
endlabel UserFuncComplete
    /* FA508 80109D08 00000000 */  nop
    /* FA50C 80109D0C 00000000 */  nop
