.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _set_draw_offset, 0x1C

glabel _set_draw_offset
    /* DF1C8 800EE9C8 FF07A530 */  andi       $a1, $a1, 0x7FF
    /* DF1CC 800EE9CC C02A0500 */  sll        $a1, $a1, 11
    /* DF1D0 800EE9D0 FF078230 */  andi       $v0, $a0, 0x7FF
    /* DF1D4 800EE9D4 00E5033C */  lui        $v1, (0xE5000000 >> 16)
    /* DF1D8 800EE9D8 25104300 */  or         $v0, $v0, $v1
    /* DF1DC 800EE9DC 0800E003 */  jr         $ra
    /* DF1E0 800EE9E0 2510A200 */   or        $v0, $a1, $v0
endlabel _set_draw_offset
