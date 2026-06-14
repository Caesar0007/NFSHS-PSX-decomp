.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DashHUD_KillHUD__Fv, 0x20

glabel DashHUD_KillHUD__Fv
    /* 8B7F0 8009AFF0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8B7F4 8009AFF4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8B7F8 8009AFF8 A94A030C */  jal        Hud_Kill__Fv
    /* 8B7FC 8009AFFC 00000000 */   nop
    /* 8B800 8009B000 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8B804 8009B004 00000000 */  nop
    /* 8B808 8009B008 0800E003 */  jr         $ra
    /* 8B80C 8009B00C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DashHUD_KillHUD__Fv
