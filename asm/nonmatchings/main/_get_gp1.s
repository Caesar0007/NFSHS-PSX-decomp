.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _get_gp1, 0x14

glabel _get_gp1
    /* DFA6C 800EF26C 1480023C */  lui        $v0, %hi(D_8013EAF8)
    /* DFA70 800EF270 21104400 */  addu       $v0, $v0, $a0
    /* DFA74 800EF274 F8EA4290 */  lbu        $v0, %lo(D_8013EAF8)($v0)
    /* DFA78 800EF278 0800E003 */  jr         $ra
    /* DFA7C 800EF27C 00000000 */   nop
endlabel _get_gp1
