.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_StartUp__Fv, 0x8

glabel AIPhysic_StartUp__Fv
    /* 5D43C 8006CC3C 0800E003 */  jr         $ra
    /* 5D440 8006CC40 00000000 */   nop
endlabel AIPhysic_StartUp__Fv
