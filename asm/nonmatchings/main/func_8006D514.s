.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8006D514, 0x20

glabel func_8006D514
    /* 5DD14 8006D514 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DD18 8006D518 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5DD1C 8006D51C 9BB3010C */  jal        ___14AIDataRecord_t
    /* 5DD20 8006D520 00000000 */   nop
    /* 5DD24 8006D524 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5DD28 8006D528 00000000 */  nop
    /* 5DD2C 8006D52C 0800E003 */  jr         $ra
    /* 5DD30 8006D530 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8006D514
