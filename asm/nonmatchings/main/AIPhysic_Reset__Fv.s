.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_Reset__Fv, 0x8

glabel AIPhysic_Reset__Fv
    /* 5D44C 8006CC4C 0800E003 */  jr         $ra
    /* 5D450 8006CC50 00000000 */   nop
endlabel AIPhysic_Reset__Fv
