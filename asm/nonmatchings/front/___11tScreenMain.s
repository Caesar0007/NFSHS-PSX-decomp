.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___11tScreenMain, 0x20

glabel ___11tScreenMain
    /* 29344 80038B44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 29348 80038B48 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2934C 80038B4C 1E98000C */  jal        ___7tScreen
    /* 29350 80038B50 00000000 */   nop
    /* 29354 80038B54 1000BF8F */  lw         $ra, 0x10($sp)
    /* 29358 80038B58 00000000 */  nop
    /* 2935C 80038B5C 0800E003 */  jr         $ra
    /* 29360 80038B60 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___11tScreenMain
    /* 29364 80038B64 00000000 */  nop
