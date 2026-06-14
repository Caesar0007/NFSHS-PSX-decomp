.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching initgp, 0x10

glabel initgp
    /* DB880 800EB080 1280013C */  lui        $at, %hi(D_801234E8)
    /* DB884 800EB084 E8343CAC */  sw         $gp, %lo(D_801234E8)($at)
    /* DB888 800EB088 0800E003 */  jr         $ra
    /* DB88C 800EB08C 00000000 */   nop
endlabel initgp
