.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_MATRIX3DT_Copy__FPiT0, 0x28

glabel R3DCar_MATRIX3DT_Copy__FPiT0
    /* A03A8 800AFBA8 08000324 */  addiu      $v1, $zero, 0x8
    /* A03AC 800AFBAC FFFF0624 */  addiu      $a2, $zero, -0x1
  .L800AFBB0:
    /* A03B0 800AFBB0 0000828C */  lw         $v0, 0x0($a0)
    /* A03B4 800AFBB4 04008424 */  addiu      $a0, $a0, 0x4
    /* A03B8 800AFBB8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* A03BC 800AFBBC 0000A2AC */  sw         $v0, 0x0($a1)
    /* A03C0 800AFBC0 FBFF6614 */  bne        $v1, $a2, .L800AFBB0
    /* A03C4 800AFBC4 0400A524 */   addiu     $a1, $a1, 0x4
    /* A03C8 800AFBC8 0800E003 */  jr         $ra
    /* A03CC 800AFBCC 00000000 */   nop
endlabel R3DCar_MATRIX3DT_Copy__FPiT0
