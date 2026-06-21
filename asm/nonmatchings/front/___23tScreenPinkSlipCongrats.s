.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tScreenPinkSlipCongrats, 0x20

glabel ___23tScreenPinkSlipCongrats
    /* 39FE0 800497E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39FE4 800497E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 39FE8 800497E8 1E98000C */  jal        ___7tScreen
    /* 39FEC 800497EC 00000000 */   nop
    /* 39FF0 800497F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 39FF4 800497F4 00000000 */  nop
    /* 39FF8 800497F8 0800E003 */  jr         $ra
    /* 39FFC 800497FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23tScreenPinkSlipCongrats
