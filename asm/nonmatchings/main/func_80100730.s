.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80100730, 0xC

glabel func_80100730
    /* F0F30 80100730 03008290 */  lbu        $v0, 0x3($a0)
    /* F0F34 80100734 0800E003 */  jr         $ra
    /* F0F38 80100738 82100200 */   srl       $v0, $v0, 2
endlabel func_80100730
