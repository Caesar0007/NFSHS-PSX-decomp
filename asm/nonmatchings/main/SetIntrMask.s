.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetIntrMask, 0x18

glabel SetIntrMask
    /* E3150 800F2950 1380033C */  lui        $v1, %hi(D_80135B88)
    /* E3154 800F2954 885B638C */  lw         $v1, %lo(D_80135B88)($v1)
    /* E3158 800F2958 00000000 */  nop
    /* E315C 800F295C 00006294 */  lhu        $v0, 0x0($v1)
    /* E3160 800F2960 0800E003 */  jr         $ra
    /* E3164 800F2964 000064A4 */   sh        $a0, 0x0($v1)
endlabel SetIntrMask
