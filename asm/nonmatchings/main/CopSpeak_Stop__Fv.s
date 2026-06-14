.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Stop__Fv, 0x20

glabel CopSpeak_Stop__Fv
    /* 8A2BC 80099ABC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8A2C0 80099AC0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8A2C4 80099AC4 8766020C */  jal        CopSpeak_Cancel__Fv
    /* 8A2C8 80099AC8 00000000 */   nop
    /* 8A2CC 80099ACC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8A2D0 80099AD0 00000000 */  nop
    /* 8A2D4 80099AD4 0800E003 */  jr         $ra
    /* 8A2D8 80099AD8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_Stop__Fv
