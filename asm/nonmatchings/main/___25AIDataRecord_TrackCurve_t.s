.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25AIDataRecord_TrackCurve_t, 0x20

glabel ___25AIDataRecord_TrackCurve_t
    /* 5DD54 8006D554 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DD58 8006D558 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5DD5C 8006D55C 9BB3010C */  jal        ___14AIDataRecord_t
    /* 5DD60 8006D560 00000000 */   nop
    /* 5DD64 8006D564 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5DD68 8006D568 00000000 */  nop
    /* 5DD6C 8006D56C 0800E003 */  jr         $ra
    /* 5DD70 8006D570 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25AIDataRecord_TrackCurve_t
