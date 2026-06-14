.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _card_close, 0x20

glabel _card_close
    /* F9FFC 801097FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA000 80109800 1000BFAF */  sw         $ra, 0x10($sp)
    /* FA004 80109804 0A32040C */  jal        StopCARD
    /* FA008 80109808 00000000 */   nop
    /* FA00C 8010980C 1000BF8F */  lw         $ra, 0x10($sp)
    /* FA010 80109810 1800BD27 */  addiu      $sp, $sp, 0x18
    /* FA014 80109814 0800E003 */  jr         $ra
    /* FA018 80109818 00000000 */   nop
endlabel _card_close
