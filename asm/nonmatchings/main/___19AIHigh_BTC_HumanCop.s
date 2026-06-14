.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___19AIHigh_BTC_HumanCop, 0x20

glabel ___19AIHigh_BTC_HumanCop
    /* 4FDE4 8005F5E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4FDE8 8005F5E8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4FDEC 8005F5EC F16C010C */  jal        ___11AIHigh_Base
    /* 4FDF0 8005F5F0 00000000 */   nop
    /* 4FDF4 8005F5F4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4FDF8 8005F5F8 00000000 */  nop
    /* 4FDFC 8005F5FC 0800E003 */  jr         $ra
    /* 4FE00 8005F600 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___19AIHigh_BTC_HumanCop
