.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14AIHigh_Traffic, 0x20

glabel ___14AIHigh_Traffic
    /* 5718C 8006698C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 57190 80066990 1000BFAF */  sw         $ra, 0x10($sp)
    /* 57194 80066994 F16C010C */  jal        ___11AIHigh_Base
    /* 57198 80066998 00000000 */   nop
    /* 5719C 8006699C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 571A0 800669A0 00000000 */  nop
    /* 571A4 800669A4 0800E003 */  jr         $ra
    /* 571A8 800669A8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14AIHigh_Traffic
