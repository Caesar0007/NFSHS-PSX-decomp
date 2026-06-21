.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14tScreenMemcard, 0x20

glabel ___14tScreenMemcard
    /* 3863C 80047E3C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 38640 80047E40 1000BFAF */  sw         $ra, 0x10($sp)
    /* 38644 80047E44 1E98000C */  jal        ___7tScreen
    /* 38648 80047E48 00000000 */   nop
    /* 3864C 80047E4C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 38650 80047E50 00000000 */  nop
    /* 38654 80047E54 0800E003 */  jr         $ra
    /* 38658 80047E58 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14tScreenMemcard
    /* 3865C 80047E5C 00000000 */  nop
