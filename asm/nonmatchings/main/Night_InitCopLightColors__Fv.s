.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_InitCopLightColors__Fv, 0x5C

glabel Night_InitCopLightColors__Fv
    /* CC174 800DB974 9C14828F */  lw         $v0, %gp_rel(Night_gCopLightingTableRed)($gp)
    /* CC178 800DB978 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CC17C 800DB97C 07004014 */  bnez       $v0, .L800DB99C
    /* CC180 800DB980 1000BFAF */   sw        $ra, 0x10($sp)
    /* CC184 800DB984 1480043C */  lui        $a0, %hi(D_8013DA08)
    /* CC188 800DB988 08DA8424 */  addiu      $a0, $a0, %lo(D_8013DA08)
    /* CC18C 800DB98C 00080524 */  addiu      $a1, $zero, 0x800
    /* CC190 800DB990 CF94030C */  jal        reservememadr
    /* CC194 800DB994 21300000 */   addu      $a2, $zero, $zero
    /* CC198 800DB998 9C1482AF */  sw         $v0, %gp_rel(Night_gCopLightingTableRed)($gp)
  .L800DB99C:
    /* CC19C 800DB99C A014828F */  lw         $v0, %gp_rel(Night_gCopLightingTableBlue)($gp)
    /* CC1A0 800DB9A0 00000000 */  nop
    /* CC1A4 800DB9A4 06004014 */  bnez       $v0, .L800DB9C0
    /* CC1A8 800DB9A8 1480043C */   lui       $a0, %hi(D_8013DA10)
    /* CC1AC 800DB9AC 10DA8424 */  addiu      $a0, $a0, %lo(D_8013DA10)
    /* CC1B0 800DB9B0 00080524 */  addiu      $a1, $zero, 0x800
    /* CC1B4 800DB9B4 CF94030C */  jal        reservememadr
    /* CC1B8 800DB9B8 21300000 */   addu      $a2, $zero, $zero
    /* CC1BC 800DB9BC A01482AF */  sw         $v0, %gp_rel(Night_gCopLightingTableBlue)($gp)
  .L800DB9C0:
    /* CC1C0 800DB9C0 1000BF8F */  lw         $ra, 0x10($sp)
    /* CC1C4 800DB9C4 00000000 */  nop
    /* CC1C8 800DB9C8 0800E003 */  jr         $ra
    /* CC1CC 800DB9CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_InitCopLightColors__Fv
