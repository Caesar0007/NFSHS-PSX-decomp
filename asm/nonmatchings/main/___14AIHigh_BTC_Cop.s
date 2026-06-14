.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14AIHigh_BTC_Cop, 0x20

glabel ___14AIHigh_BTC_Cop
    /* 4FE04 8005F604 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4FE08 8005F608 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4FE0C 8005F60C F16C010C */  jal        ___11AIHigh_Base
    /* 4FE10 8005F610 00000000 */   nop
    /* 4FE14 8005F614 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4FE18 8005F618 00000000 */  nop
    /* 4FE1C 8005F61C 0800E003 */  jr         $ra
    /* 4FE20 8005F620 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14AIHigh_BTC_Cop
