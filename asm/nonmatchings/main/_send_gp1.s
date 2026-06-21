.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _send_gp1, 0x24

glabel _send_gp1
    /* DFA48 800EF248 1280023C */  lui        $v0, %hi(D_801237A4)
    /* DFA4C 800EF24C A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* DFA50 800EF250 00000000 */  nop
    /* DFA54 800EF254 000044AC */  sw         $a0, 0x0($v0)
    /* DFA58 800EF258 02160400 */  srl        $v0, $a0, 24
    /* DFA5C 800EF25C 1480013C */  lui        $at, %hi(D_8013EAF8)
    /* DFA60 800EF260 21082200 */  addu       $at, $at, $v0
    /* DFA64 800EF264 0800E003 */  jr         $ra
    /* DFA68 800EF268 F8EA24A0 */   sb        $a0, %lo(D_8013EAF8)($at)
endlabel _send_gp1
