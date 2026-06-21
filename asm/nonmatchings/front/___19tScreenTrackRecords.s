.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___19tScreenTrackRecords, 0x20

glabel ___19tScreenTrackRecords
    /* 338F8 800430F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 338FC 800430FC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 33900 80043100 1E98000C */  jal        ___7tScreen
    /* 33904 80043104 00000000 */   nop
    /* 33908 80043108 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3390C 8004310C 00000000 */  nop
    /* 33910 80043110 0800E003 */  jr         $ra
    /* 33914 80043114 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___19tScreenTrackRecords
