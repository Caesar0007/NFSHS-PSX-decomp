.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___16tScreenPinkSlips, 0x20

glabel ___16tScreenPinkSlips
    /* 29FCC 800397CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 29FD0 800397D0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 29FD4 800397D4 1E98000C */  jal        ___7tScreen
    /* 29FD8 800397D8 00000000 */   nop
    /* 29FDC 800397DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 29FE0 800397E0 00000000 */  nop
    /* 29FE4 800397E4 0800E003 */  jr         $ra
    /* 29FE8 800397E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___16tScreenPinkSlips
    /* 29FEC 800397EC 00000000 */  nop
