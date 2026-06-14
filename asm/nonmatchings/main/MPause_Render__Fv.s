.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_Render__Fv, 0x1A8

glabel MPause_Render__Fv
    /* 8F2A0 8009EAA0 6C188287 */  lh         $v0, %gp_rel(D_8013DDB8)($gp)
    /* 8F2A4 8009EAA4 6C188397 */  lhu        $v1, %gp_rel(D_8013DDB8)($gp)
    /* 8F2A8 8009EAA8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8F2AC 8009EAAC 2400BFAF */  sw         $ra, 0x24($sp)
    /* 8F2B0 8009EAB0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 8F2B4 8009EAB4 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8F2B8 8009EAB8 ECD220AC */  sw         $zero, %lo(ChangedEnabling)($at)
    /* 8F2BC 8009EABC 0A004018 */  blez       $v0, .L8009EAE8
    /* 8F2C0 8009EAC0 00000000 */   nop
    /* 8F2C4 8009EAC4 6E188297 */  lhu        $v0, %gp_rel(D_8013DDBA)($gp)
    /* 8F2C8 8009EAC8 00000000 */  nop
    /* 8F2CC 8009EACC 21106200 */  addu       $v0, $v1, $v0
    /* 8F2D0 8009EAD0 6C1882A7 */  sh         $v0, %gp_rel(D_8013DDB8)($gp)
    /* 8F2D4 8009EAD4 00140200 */  sll        $v0, $v0, 16
    /* 8F2D8 8009EAD8 0C004004 */  bltz       $v0, .L8009EB0C
    /* 8F2DC 8009EADC 00000000 */   nop
    /* 8F2E0 8009EAE0 C47A0208 */  j          .L8009EB10
    /* 8F2E4 8009EAE4 00000000 */   nop
  .L8009EAE8:
    /* 8F2E8 8009EAE8 09004104 */  bgez       $v0, .L8009EB10
    /* 8F2EC 8009EAEC 00000000 */   nop
    /* 8F2F0 8009EAF0 6E188297 */  lhu        $v0, %gp_rel(D_8013DDBA)($gp)
    /* 8F2F4 8009EAF4 00000000 */  nop
    /* 8F2F8 8009EAF8 21106200 */  addu       $v0, $v1, $v0
    /* 8F2FC 8009EAFC 6C1882A7 */  sh         $v0, %gp_rel(D_8013DDB8)($gp)
    /* 8F300 8009EB00 00140200 */  sll        $v0, $v0, 16
    /* 8F304 8009EB04 02004018 */  blez       $v0, .L8009EB10
    /* 8F308 8009EB08 00000000 */   nop
  .L8009EB0C:
    /* 8F30C 8009EB0C 6C1880A7 */  sh         $zero, %gp_rel(D_8013DDB8)($gp)
  .L8009EB10:
    /* 8F310 8009EB10 6C188287 */  lh         $v0, %gp_rel(D_8013DDB8)($gp)
    /* 8F314 8009EB14 00000000 */  nop
    /* 8F318 8009EB18 04004010 */  beqz       $v0, .L8009EB2C
    /* 8F31C 8009EB1C 01000224 */   addiu     $v0, $zero, 0x1
    /* 8F320 8009EB20 7418828F */  lw         $v0, %gp_rel(D_8013DDC0)($gp)
    /* 8F324 8009EB24 CE7A0208 */  j          .L8009EB38
    /* 8F328 8009EB28 040040AC */   sw        $zero, 0x4($v0)
  .L8009EB2C:
    /* 8F32C 8009EB2C 7418838F */  lw         $v1, %gp_rel(D_8013DDC0)($gp)
    /* 8F330 8009EB30 00000000 */  nop
    /* 8F334 8009EB34 040062AC */  sw         $v0, 0x4($v1)
  .L8009EB38:
    /* 8F338 8009EB38 7418838F */  lw         $v1, %gp_rel(D_8013DDC0)($gp)
    /* 8F33C 8009EB3C 00000000 */  nop
    /* 8F340 8009EB40 5000628C */  lw         $v0, 0x50($v1)
    /* 8F344 8009EB44 00000000 */  nop
    /* 8F348 8009EB48 20004484 */  lh         $a0, 0x20($v0)
    /* 8F34C 8009EB4C 2400428C */  lw         $v0, 0x24($v0)
    /* 8F350 8009EB50 00000000 */  nop
    /* 8F354 8009EB54 09F84000 */  jalr       $v0
    /* 8F358 8009EB58 21206400 */   addu      $a0, $v1, $a0
    /* 8F35C 8009EB5C 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F360 8009EB60 80A1020C */  jal        NumEnabledItems__6tPMenu
    /* 8F364 8009EB64 00000000 */   nop
    /* 8F368 8009EB68 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8F36C 8009EB6C 21804000 */  addu       $s0, $v0, $zero
    /* 8F370 8009EB70 0000838C */  lw         $v1, 0x0($a0)
    /* 8F374 8009EB74 6C188287 */  lh         $v0, %gp_rel(D_8013DDB8)($gp)
    /* 8F378 8009EB78 00000000 */  nop
    /* 8F37C 8009EB7C 13004010 */  beqz       $v0, .L8009EBCC
    /* 8F380 8009EB80 21286000 */   addu      $a1, $v1, $zero
    /* 8F384 8009EB84 94A1020C */  jal        ItemEnabledNum__6tPMenui
    /* 8F388 8009EB88 00000000 */   nop
    /* 8F38C 8009EB8C 01000424 */  addiu      $a0, $zero, 0x1
    /* 8F390 8009EB90 50000524 */  addiu      $a1, $zero, 0x50
    /* 8F394 8009EB94 A0000724 */  addiu      $a3, $zero, 0xA0
    /* 8F398 8009EB98 0D000324 */  addiu      $v1, $zero, 0xD
    /* 8F39C 8009EB9C 04308200 */  sllv       $a2, $v0, $a0
    /* 8F3A0 8009EBA0 2130C200 */  addu       $a2, $a2, $v0
    /* 8F3A4 8009EBA4 80300600 */  sll        $a2, $a2, 2
    /* 8F3A8 8009EBA8 1000A3AF */  sw         $v1, 0x10($sp)
    /* 8F3AC 8009EBAC 6C188387 */  lh         $v1, %gp_rel(D_8013DDB8)($gp)
    /* 8F3B0 8009EBB0 2130C200 */  addu       $a2, $a2, $v0
    /* 8F3B4 8009EBB4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 8F3B8 8009EBB8 1800A0AF */  sw         $zero, 0x18($sp)
    /* 8F3BC 8009EBBC 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 8F3C0 8009EBC0 6A006324 */  addiu      $v1, $v1, 0x6A
    /* 8F3C4 8009EBC4 027B0208 */  j          .L8009EC08
    /* 8F3C8 8009EBC8 2130C300 */   addu      $a2, $a2, $v1
  .L8009EBCC:
    /* 8F3CC 8009EBCC 94A1020C */  jal        ItemEnabledNum__6tPMenui
    /* 8F3D0 8009EBD0 00000000 */   nop
    /* 8F3D4 8009EBD4 01000424 */  addiu      $a0, $zero, 0x1
    /* 8F3D8 8009EBD8 50000524 */  addiu      $a1, $zero, 0x50
    /* 8F3DC 8009EBDC 04308200 */  sllv       $a2, $v0, $a0
    /* 8F3E0 8009EBE0 2130C200 */  addu       $a2, $a2, $v0
    /* 8F3E4 8009EBE4 80300600 */  sll        $a2, $a2, 2
    /* 8F3E8 8009EBE8 2130C200 */  addu       $a2, $a2, $v0
    /* 8F3EC 8009EBEC 6A00C624 */  addiu      $a2, $a2, 0x6A
    /* 8F3F0 8009EBF0 A0000724 */  addiu      $a3, $zero, 0xA0
    /* 8F3F4 8009EBF4 0D000224 */  addiu      $v0, $zero, 0xD
    /* 8F3F8 8009EBF8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8F3FC 8009EBFC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 8F400 8009EC00 1800A0AF */  sw         $zero, 0x18($sp)
    /* 8F404 8009EC04 1C00A0AF */  sw         $zero, 0x1C($sp)
  .L8009EC08:
    /* 8F408 8009EC08 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* 8F40C 8009EC0C 00000000 */   nop
    /* 8F410 8009EC10 50000424 */  addiu      $a0, $zero, 0x50
    /* 8F414 8009EC14 64000524 */  addiu      $a1, $zero, 0x64
    /* 8F418 8009EC18 A0000624 */  addiu      $a2, $zero, 0xA0
    /* 8F41C 8009EC1C 01000226 */  addiu      $v0, $s0, 0x1
    /* 8F420 8009EC20 40380200 */  sll        $a3, $v0, 1
    /* 8F424 8009EC24 2138E200 */  addu       $a3, $a3, $v0
    /* 8F428 8009EC28 80380700 */  sll        $a3, $a3, 2
    /* 8F42C 8009EC2C 2138E200 */  addu       $a3, $a3, $v0
    /* 8F430 8009EC30 B463030C */  jal        Hud_RenderPauseBox__Fiiii
    /* 8F434 8009EC34 1400E724 */   addiu     $a3, $a3, 0x14
    /* 8F438 8009EC38 2400BF8F */  lw         $ra, 0x24($sp)
    /* 8F43C 8009EC3C 2000B08F */  lw         $s0, 0x20($sp)
    /* 8F440 8009EC40 0800E003 */  jr         $ra
    /* 8F444 8009EC44 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MPause_Render__Fv
