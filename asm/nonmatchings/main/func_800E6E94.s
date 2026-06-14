.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800E6E94, 0x14

glabel func_800E6E94
    /* D7694 800E6E94 0A008290 */  lbu        $v0, 0xA($a0)
    /* D7698 800E6E98 00000000 */  nop
    /* D769C 800E6E9C 82100200 */  srl        $v0, $v0, 2
    /* D76A0 800E6EA0 0800E003 */  jr         $ra
    /* D76A4 800E6EA4 01004230 */   andi      $v0, $v0, 0x1
endlabel func_800E6E94
