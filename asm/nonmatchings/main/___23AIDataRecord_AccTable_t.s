.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23AIDataRecord_AccTable_t, 0x20

glabel ___23AIDataRecord_AccTable_t
    /* 5DD94 8006D594 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DD98 8006D598 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5DD9C 8006D59C 9BB3010C */  jal        ___14AIDataRecord_t
    /* 5DDA0 8006D5A0 00000000 */   nop
    /* 5DDA4 8006D5A4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5DDA8 8006D5A8 00000000 */  nop
    /* 5DDAC 8006D5AC 0800E003 */  jr         $ra
    /* 5DDB0 8006D5B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23AIDataRecord_AccTable_t
