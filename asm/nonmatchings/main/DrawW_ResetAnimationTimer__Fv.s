.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_ResetAnimationTimer__Fv, 0x28

glabel DrawW_ResetAnimationTimer__Fv
    /* B7E1C 800C761C 0B000324 */  addiu      $v1, $zero, 0xB
    /* B7E20 800C7620 1280023C */  lui        $v0, %hi(animation_timer)
    /* B7E24 800C7624 18F74224 */  addiu      $v0, $v0, %lo(animation_timer)
    /* B7E28 800C7628 2C004224 */  addiu      $v0, $v0, 0x2C
  .L800C762C:
    /* B7E2C 800C762C 000040AC */  sw         $zero, 0x0($v0)
    /* B7E30 800C7630 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* B7E34 800C7634 FDFF6104 */  bgez       $v1, .L800C762C
    /* B7E38 800C7638 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* B7E3C 800C763C 0800E003 */  jr         $ra
    /* B7E40 800C7640 00000000 */   nop
endlabel DrawW_ResetAnimationTimer__Fv
