.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800EF280, 0x40

glabel func_800EF280
    /* DFA80 800EF280 FFFFA624 */  addiu      $a2, $a1, -0x1
    /* DFA84 800EF284 1280033C */  lui        $v1, %hi(D_801237A4)
    /* DFA88 800EF288 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* DFA8C 800EF28C 0004023C */  lui        $v0, (0x4000000 >> 16)
    /* DFA90 800EF290 0900A010 */  beqz       $a1, .L800EF2B8
    /* DFA94 800EF294 000062AC */   sw        $v0, 0x0($v1)
    /* DFA98 800EF298 FFFF0524 */  addiu      $a1, $zero, -0x1
  .L800EF29C:
    /* DFA9C 800EF29C 0000838C */  lw         $v1, 0x0($a0)
    /* DFAA0 800EF2A0 04008424 */  addiu      $a0, $a0, 0x4
    /* DFAA4 800EF2A4 1280023C */  lui        $v0, %hi(D_801237A0)
    /* DFAA8 800EF2A8 A037428C */  lw         $v0, %lo(D_801237A0)($v0)
    /* DFAAC 800EF2AC FFFFC624 */  addiu      $a2, $a2, -0x1
    /* DFAB0 800EF2B0 FAFFC514 */  bne        $a2, $a1, .L800EF29C
    /* DFAB4 800EF2B4 000043AC */   sw        $v1, 0x0($v0)
  .L800EF2B8:
    /* DFAB8 800EF2B8 0800E003 */  jr         $ra
    /* DFABC 800EF2BC 21100000 */   addu      $v0, $zero, $zero
endlabel func_800EF280
