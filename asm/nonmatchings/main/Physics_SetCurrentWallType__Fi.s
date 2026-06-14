.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_SetCurrentWallType__Fi, 0xC

glabel Physics_SetCurrentWallType__Fi
    /* 99AD8 800A92D8 B00D84AF */  sw         $a0, %gp_rel(D_8013D2FC)($gp)
    /* 99ADC 800A92DC 0800E003 */  jr         $ra
    /* 99AE0 800A92E0 00000000 */   nop
endlabel Physics_SetCurrentWallType__Fi
