.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___30AIDataRecord_CurveSpeedTable_t, 0x20

glabel ___30AIDataRecord_CurveSpeedTable_t
    /* 5DD34 8006D534 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DD38 8006D538 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5DD3C 8006D53C 9BB3010C */  jal        ___14AIDataRecord_t
    /* 5DD40 8006D540 00000000 */   nop
    /* 5DD44 8006D544 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5DD48 8006D548 00000000 */  nop
    /* 5DD4C 8006D54C 0800E003 */  jr         $ra
    /* 5DD50 8006D550 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___30AIDataRecord_CurveSpeedTable_t
