.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CleanUp__Fv, 0x8

glabel AIPhysic_CleanUp__Fv
    /* 5D444 8006CC44 0800E003 */  jr         $ra
    /* 5D448 8006CC48 00000000 */   nop
endlabel AIPhysic_CleanUp__Fv
