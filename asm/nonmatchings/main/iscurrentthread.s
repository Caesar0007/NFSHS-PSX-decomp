.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iscurrentthread, 0x14

glabel iscurrentthread
    /* EEC08 800FE408 1018828F */  lw         $v0, %gp_rel(g_currentthread)($gp)
    /* EEC0C 800FE40C 00000000 */  nop
    /* EEC10 800FE410 26104400 */  xor        $v0, $v0, $a0
    /* EEC14 800FE414 0800E003 */  jr         $ra
    /* EEC18 800FE418 0100422C */   sltiu     $v0, $v0, 0x1
endlabel iscurrentthread
