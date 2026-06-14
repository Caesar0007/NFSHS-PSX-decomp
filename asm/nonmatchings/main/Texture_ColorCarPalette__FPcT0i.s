.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_ColorCarPalette__FPcT0i, 0x38

glabel Texture_ColorCarPalette__FPcT0i
    /* D0204 800DFA04 BC15828F */  lw         $v0, %gp_rel(Texture_CarColor)($gp)
    /* D0208 800DFA08 FFFFC324 */  addiu      $v1, $a2, -0x1
    /* D020C 800DFA0C 40110200 */  sll        $v0, $v0, 5
    /* D0210 800DFA10 0800C010 */  beqz       $a2, .L800DFA34
    /* D0214 800DFA14 21208200 */   addu      $a0, $a0, $v0
    /* D0218 800DFA18 FFFF0624 */  addiu      $a2, $zero, -0x1
  .L800DFA1C:
    /* D021C 800DFA1C 00008294 */  lhu        $v0, 0x0($a0)
    /* D0220 800DFA20 02008424 */  addiu      $a0, $a0, 0x2
    /* D0224 800DFA24 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* D0228 800DFA28 0000A2A4 */  sh         $v0, 0x0($a1)
    /* D022C 800DFA2C FBFF6614 */  bne        $v1, $a2, .L800DFA1C
    /* D0230 800DFA30 0200A524 */   addiu     $a1, $a1, 0x2
  .L800DFA34:
    /* D0234 800DFA34 0800E003 */  jr         $ra
    /* D0238 800DFA38 00000000 */   nop
endlabel Texture_ColorCarPalette__FPcT0i
