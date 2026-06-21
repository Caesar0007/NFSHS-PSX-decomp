.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___20tScreenCarSelectDuel, 0x20

glabel ___20tScreenCarSelectDuel
    /* 2FF58 8003F758 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2FF5C 8003F75C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2FF60 8003F760 24EB000C */  jal        ___16tScreenCarSelect
    /* 2FF64 8003F764 00000000 */   nop
    /* 2FF68 8003F768 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2FF6C 8003F76C 00000000 */  nop
    /* 2FF70 8003F770 0800E003 */  jr         $ra
    /* 2FF74 8003F774 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___20tScreenCarSelectDuel
