.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800E6E88, 0xC

glabel func_800E6E88
    /* D7688 800E6E88 0A008290 */  lbu        $v0, 0xA($a0)
    /* D768C 800E6E8C 0800E003 */  jr         $ra
    /* D7690 800E6E90 01004230 */   andi      $v0, $v0, 0x1
endlabel func_800E6E88
