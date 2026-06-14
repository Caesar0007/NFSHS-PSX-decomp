.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsCarInAnyVisibleArea__FP8Car_tObj, 0x20

glabel AILife_IsCarInAnyVisibleArea__FP8Car_tObj
    /* 58FEC 800687EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 58FF0 800687F0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 58FF4 800687F4 53A2010C */  jal        AILife_IsPositionInAnyVisibleArea__FP8coorddef
    /* 58FF8 800687F8 A0008424 */   addiu     $a0, $a0, 0xA0
    /* 58FFC 800687FC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 59000 80068800 00000000 */  nop
    /* 59004 80068804 0800E003 */  jr         $ra
    /* 59008 80068808 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_IsCarInAnyVisibleArea__FP8Car_tObj
