.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HandleCops__15AIHigh_BTC_Perp, 0x20

glabel HandleCops__15AIHigh_BTC_Perp
    /* 4FF78 8005F778 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4FF7C 8005F77C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4FF80 8005F780 967E010C */  jal        HandlePullOver__15AIHigh_BTC_Perp
    /* 4FF84 8005F784 00000000 */   nop
    /* 4FF88 8005F788 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4FF8C 8005F78C 00000000 */  nop
    /* 4FF90 8005F790 0800E003 */  jr         $ra
    /* 4FF94 8005F794 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel HandleCops__15AIHigh_BTC_Perp
