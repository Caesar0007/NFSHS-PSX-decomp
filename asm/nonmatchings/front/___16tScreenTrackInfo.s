.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___16tScreenTrackInfo, 0x20

glabel ___16tScreenTrackInfo
    /* 32E28 80042628 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 32E2C 8004262C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 32E30 80042630 1E98000C */  jal        ___7tScreen
    /* 32E34 80042634 00000000 */   nop
    /* 32E38 80042638 1000BF8F */  lw         $ra, 0x10($sp)
    /* 32E3C 8004263C 00000000 */  nop
    /* 32E40 80042640 0800E003 */  jr         $ra
    /* 32E44 80042644 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___16tScreenTrackInfo
