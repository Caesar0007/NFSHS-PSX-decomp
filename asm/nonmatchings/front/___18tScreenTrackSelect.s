.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18tScreenTrackSelect, 0x20

glabel ___18tScreenTrackSelect
    /* 329D4 800421D4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 329D8 800421D8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 329DC 800421DC 1E98000C */  jal        ___7tScreen
    /* 329E0 800421E0 00000000 */   nop
    /* 329E4 800421E4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 329E8 800421E8 00000000 */  nop
    /* 329EC 800421EC 0800E003 */  jr         $ra
    /* 329F0 800421F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18tScreenTrackSelect
    /* 329F4 800421F4 00000000 */  nop
