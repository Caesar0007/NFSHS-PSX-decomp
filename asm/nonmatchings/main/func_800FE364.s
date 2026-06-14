.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FE364, 0x20

glabel func_800FE364
    /* EEB64 800FE364 1480023C */  lui        $v0, %hi(D_80147600)
    /* EEB68 800FE368 00764224 */  addiu      $v0, $v0, %lo(D_80147600)
    /* EEB6C 800FE36C F0008430 */  andi       $a0, $a0, 0xF0
    /* EEB70 800FE370 02008010 */  beqz       $a0, .L800FE37C
    /* EEB74 800FE374 00000000 */   nop
    /* EEB78 800FE378 F0004224 */  addiu      $v0, $v0, 0xF0
  .L800FE37C:
    /* EEB7C 800FE37C 0800E003 */  jr         $ra
    /* EEB80 800FE380 00000000 */   nop
endlabel func_800FE364
    /* EEB84 800FE384 00000000 */  nop
