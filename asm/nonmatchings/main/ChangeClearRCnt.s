.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ChangeClearRCnt, 0xC

glabel ChangeClearRCnt
    /* F6E64 80106664 C0000A24 */  addiu      $t2, $zero, 0xC0
    /* F6E68 80106668 08004001 */  jr         $t2
    /* F6E6C 8010666C 0A000924 */   addiu     $t1, $zero, 0xA
endlabel ChangeClearRCnt
    /* F6E70 80106670 00000000 */  nop
