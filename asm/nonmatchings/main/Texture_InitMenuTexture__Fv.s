.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_InitMenuTexture__Fv, 0x28

glabel Texture_InitMenuTexture__Fv
    /* D0E10 800E0610 07000324 */  addiu      $v1, $zero, 0x7
    /* D0E14 800E0614 1280023C */  lui        $v0, %hi(gMenuPixmap)
    /* D0E18 800E0618 D00F4224 */  addiu      $v0, $v0, %lo(gMenuPixmap)
    /* D0E1C 800E061C 1C004224 */  addiu      $v0, $v0, 0x1C
  .L800E0620:
    /* D0E20 800E0620 000040AC */  sw         $zero, 0x0($v0)
    /* D0E24 800E0624 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* D0E28 800E0628 FDFF6104 */  bgez       $v1, .L800E0620
    /* D0E2C 800E062C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* D0E30 800E0630 0800E003 */  jr         $ra
    /* D0E34 800E0634 00000000 */   nop
endlabel Texture_InitMenuTexture__Fv
