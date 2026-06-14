.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18AIHigh_BTC_Wingman, 0x20

glabel ___18AIHigh_BTC_Wingman
    /* 4FDC4 8005F5C4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4FDC8 8005F5C8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4FDCC 8005F5CC F16C010C */  jal        ___11AIHigh_Base
    /* 4FDD0 8005F5D0 00000000 */   nop
    /* 4FDD4 8005F5D4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4FDD8 8005F5D8 00000000 */  nop
    /* 4FDDC 8005F5DC 0800E003 */  jr         $ra
    /* 4FDE0 8005F5E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18AIHigh_BTC_Wingman
