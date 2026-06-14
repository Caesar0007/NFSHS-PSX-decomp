.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_TextColor__Fi, 0x38

glabel Font_TextColor__Fi
    /* BBA0C 800CB20C 1280053C */  lui        $a1, %hi(shpfontclut)
    /* BBA10 800CB210 B0FDA524 */  addiu      $a1, $a1, %lo(shpfontclut)
    /* BBA14 800CB214 00210400 */  sll        $a0, $a0, 4
    /* BBA18 800CB218 08138297 */  lhu        $v0, %gp_rel(font_clutx)($gp)
    /* BBA1C 800CB21C 0E00A394 */  lhu        $v1, 0xE($a1)
    /* BBA20 800CB220 21104400 */  addu       $v0, $v0, $a0
    /* BBA24 800CB224 80190300 */  sll        $v1, $v1, 6
    /* BBA28 800CB228 0C00A2A4 */  sh         $v0, 0xC($a1)
    /* BBA2C 800CB22C 02110200 */  srl        $v0, $v0, 4
    /* BBA30 800CB230 3F004230 */  andi       $v0, $v0, 0x3F
    /* BBA34 800CB234 25186200 */  or         $v1, $v1, $v0
    /* BBA38 800CB238 181383A7 */  sh         $v1, %gp_rel(gFontClut)($gp)
    /* BBA3C 800CB23C 0800E003 */  jr         $ra
    /* BBA40 800CB240 00000000 */   nop
endlabel Font_TextColor__Fi
