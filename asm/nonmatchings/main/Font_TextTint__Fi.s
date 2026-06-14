.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_TextTint__Fi, 0x20

glabel Font_TextTint__Fi
    /* BBA44 800CB244 FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* BBA48 800CB248 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* BBA4C 800CB24C 24208200 */  and        $a0, $a0, $v0
    /* BBA50 800CB250 0066023C */  lui        $v0, (0x66000000 >> 16)
    /* BBA54 800CB254 25208200 */  or         $a0, $a0, $v0
    /* BBA58 800CB258 101384AF */  sw         $a0, %gp_rel(font_tint)($gp)
    /* BBA5C 800CB25C 0800E003 */  jr         $ra
    /* BBA60 800CB260 00000000 */   nop
endlabel Font_TextTint__Fi
