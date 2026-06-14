.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010073C, 0xC

glabel func_8010073C
    /* F0F3C 8010073C 0A008290 */  lbu        $v0, 0xA($a0)
    /* F0F40 80100740 0800E003 */  jr         $ra
    /* F0F44 80100744 01004230 */   andi      $v0, $v0, 0x1
endlabel func_8010073C
