.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIHigh_Restart2__Fv, 0x28

glabel AIHigh_Restart2__Fv
    /* 4B95C 8005B15C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4B960 8005B160 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4B964 8005B164 71BE010C */  jal        AIState_Restart__Fv
    /* 4B968 8005B168 00000000 */   nop
    /* 4B96C 8005B16C 656B010C */  jal        AIHigh_StartUp__Fv
    /* 4B970 8005B170 00000000 */   nop
    /* 4B974 8005B174 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4B978 8005B178 00000000 */  nop
    /* 4B97C 8005B17C 0800E003 */  jr         $ra
    /* 4B980 8005B180 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIHigh_Restart2__Fv
