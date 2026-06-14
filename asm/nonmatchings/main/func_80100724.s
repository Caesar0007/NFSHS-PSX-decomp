.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80100724, 0xC

glabel func_80100724
    /* F0F24 80100724 03008290 */  lbu        $v0, 0x3($a0)
    /* F0F28 80100728 0800E003 */  jr         $ra
    /* F0F2C 8010072C 03004230 */   andi      $v0, $v0, 0x3
endlabel func_80100724
