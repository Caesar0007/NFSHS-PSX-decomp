.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Debug__Fv, 0x20

glabel CopSpeak_Debug__Fv
    /* 8B69C 8009AE9C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8B6A0 8009AEA0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8B6A4 8009AEA4 336B020C */  jal        CopSpeak_ShowQueue__Fv
    /* 8B6A8 8009AEA8 00000000 */   nop
    /* 8B6AC 8009AEAC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8B6B0 8009AEB0 00000000 */  nop
    /* 8B6B4 8009AEB4 0800E003 */  jr         $ra
    /* 8B6B8 8009AEB8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_Debug__Fv
