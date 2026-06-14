.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Kill__Fv, 0x50

glabel Hud_Kill__Fv
    /* C32A4 800D2AA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C32A8 800D2AA8 1000BFAF */  sw         $ra, 0x10($sp)
    /* C32AC 800D2AAC CC4B020C */  jal        HudPmx_Kill__Fv
    /* C32B0 800D2AB0 00000000 */   nop
    /* C32B4 800D2AB4 BC18848F */  lw         $a0, %gp_rel(D_8013DE08)($gp)
    /* C32B8 800D2AB8 00000000 */  nop
    /* C32BC 800D2ABC 03008010 */  beqz       $a0, .L800D2ACC
    /* C32C0 800D2AC0 00000000 */   nop
    /* C32C4 800D2AC4 5095030C */  jal        purgememadr
    /* C32C8 800D2AC8 00000000 */   nop
  .L800D2ACC:
    /* C32CC 800D2ACC C018848F */  lw         $a0, %gp_rel(D_8013DE0C)($gp)
    /* C32D0 800D2AD0 BC1880AF */  sw         $zero, %gp_rel(D_8013DE08)($gp)
    /* C32D4 800D2AD4 03008010 */  beqz       $a0, .L800D2AE4
    /* C32D8 800D2AD8 00000000 */   nop
    /* C32DC 800D2ADC 5095030C */  jal        purgememadr
    /* C32E0 800D2AE0 00000000 */   nop
  .L800D2AE4:
    /* C32E4 800D2AE4 1000BF8F */  lw         $ra, 0x10($sp)
    /* C32E8 800D2AE8 C01880AF */  sw         $zero, %gp_rel(D_8013DE0C)($gp)
    /* C32EC 800D2AEC 0800E003 */  jr         $ra
    /* C32F0 800D2AF0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hud_Kill__Fv
