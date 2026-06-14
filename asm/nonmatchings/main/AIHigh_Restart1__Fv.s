.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIHigh_Restart1__Fv, 0x20

glabel AIHigh_Restart1__Fv
    /* 4B93C 8005B13C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4B940 8005B140 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4B944 8005B144 616C010C */  jal        AIHigh_CleanUp__Fv
    /* 4B948 8005B148 00000000 */   nop
    /* 4B94C 8005B14C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4B950 8005B150 00000000 */  nop
    /* 4B954 8005B154 0800E003 */  jr         $ra
    /* 4B958 8005B158 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIHigh_Restart1__Fv
