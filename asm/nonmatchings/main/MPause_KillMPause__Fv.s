.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_KillMPause__Fv, 0x40

glabel MPause_KillMPause__Fv
    /* 8F6EC 8009EEEC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8F6F0 8009EEF0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8F6F4 8009EEF4 1FB6030C */  jal        DrawSync
    /* 8F6F8 8009EEF8 21200000 */   addu      $a0, $zero, $zero
    /* 8F6FC 8009EEFC 1C0D848F */  lw         $a0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8F700 8009EF00 00000000 */  nop
    /* 8F704 8009EF04 03008010 */  beqz       $a0, .L8009EF14
    /* 8F708 8009EF08 00000000 */   nop
    /* 8F70C 8009EF0C 8D78020C */  jal        ___14tPauseMenuDefs
    /* 8F710 8009EF10 03000524 */   addiu     $a1, $zero, 0x3
  .L8009EF14:
    /* 8F714 8009EF14 B4E4020C */  jal        TextSys_UnloadWords__Fv
    /* 8F718 8009EF18 00000000 */   nop
    /* 8F71C 8009EF1C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8F720 8009EF20 00000000 */  nop
    /* 8F724 8009EF24 0800E003 */  jr         $ra
    /* 8F728 8009EF28 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MPause_KillMPause__Fv
