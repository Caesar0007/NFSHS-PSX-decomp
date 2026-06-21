.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15tScreenCongrats, 0x20

glabel ___15tScreenCongrats
    /* 3A020 80049820 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3A024 80049824 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3A028 80049828 1E98000C */  jal        ___7tScreen
    /* 3A02C 8004982C 00000000 */   nop
    /* 3A030 80049830 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3A034 80049834 00000000 */  nop
    /* 3A038 80049838 0800E003 */  jr         $ra
    /* 3A03C 8004983C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15tScreenCongrats
