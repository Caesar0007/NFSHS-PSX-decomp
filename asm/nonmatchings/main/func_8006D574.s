.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8006D574, 0x20

glabel func_8006D574
    /* 5DD74 8006D574 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DD78 8006D578 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5DD7C 8006D57C 9BB3010C */  jal        ___14AIDataRecord_t
    /* 5DD80 8006D580 00000000 */   nop
    /* 5DD84 8006D584 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5DD88 8006D588 00000000 */  nop
    /* 5DD8C 8006D58C 0800E003 */  jr         $ra
    /* 5DD90 8006D590 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8006D574
