.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010B100, 0xC

glabel func_8010B100
    /* FB900 8010B100 03008290 */  lbu        $v0, 0x3($a0)
    /* FB904 8010B104 0800E003 */  jr         $ra
    /* FB908 8010B108 82100200 */   srl       $v0, $v0, 2
endlabel func_8010B100
