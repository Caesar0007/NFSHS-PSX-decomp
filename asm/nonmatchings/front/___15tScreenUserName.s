.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15tScreenUserName, 0x20

glabel ___15tScreenUserName
    /* 3BFD4 8004B7D4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3BFD8 8004B7D8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3BFDC 8004B7DC 1E98000C */  jal        ___7tScreen
    /* 3BFE0 8004B7E0 00000000 */   nop
    /* 3BFE4 8004B7E4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3BFE8 8004B7E8 00000000 */  nop
    /* 3BFEC 8004B7EC 0800E003 */  jr         $ra
    /* 3BFF0 8004B7F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15tScreenUserName
    /* 3BFF4 8004B7F4 00000000 */  nop
