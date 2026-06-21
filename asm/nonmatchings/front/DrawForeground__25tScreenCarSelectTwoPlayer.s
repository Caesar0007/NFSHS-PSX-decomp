.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawForeground__25tScreenCarSelectTwoPlayer, 0x23C

glabel DrawForeground__25tScreenCarSelectTwoPlayer
    /* 2F214 8003EA14 D8FEBD27 */  addiu      $sp, $sp, -0x128
    /* 2F218 8003EA18 0801B0AF */  sw         $s0, 0x108($sp)
    /* 2F21C 8003EA1C 0580103C */  lui        $s0, %hi(FEApp)
    /* 2F220 8003EA20 C014028E */  lw         $v0, %lo(FEApp)($s0)
    /* 2F224 8003EA24 21308000 */  addu       $a2, $a0, $zero
    /* 2F228 8003EA28 0C01B1AF */  sw         $s1, 0x10C($sp)
    /* 2F22C 8003EA2C 2401BFAF */  sw         $ra, 0x124($sp)
    /* 2F230 8003EA30 2001B6AF */  sw         $s6, 0x120($sp)
    /* 2F234 8003EA34 1C01B5AF */  sw         $s5, 0x11C($sp)
    /* 2F238 8003EA38 1801B4AF */  sw         $s4, 0x118($sp)
    /* 2F23C 8003EA3C 1401B3AF */  sw         $s3, 0x114($sp)
    /* 2F240 8003EA40 1001B2AF */  sw         $s2, 0x110($sp)
    /* 2F244 8003EA44 2C024390 */  lbu        $v1, 0x22C($v0)
    /* 2F248 8003EA48 01000224 */  addiu      $v0, $zero, 0x1
    /* 2F24C 8003EA4C 02006214 */  bne        $v1, $v0, .L8003EA58
    /* 2F250 8003EA50 2D001124 */   addiu     $s1, $zero, 0x2D
    /* 2F254 8003EA54 96001124 */  addiu      $s1, $zero, 0x96
  .L8003EA58:
    /* 2F258 8003EA58 6000C28C */  lw         $v0, 0x60($a2)
    /* 2F25C 8003EA5C 3800A527 */  addiu      $a1, $sp, 0x38
    /* 2F260 8003EA60 68004484 */  lh         $a0, 0x68($v0)
    /* 2F264 8003EA64 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2F268 8003EA68 00000000 */  nop
    /* 2F26C 8003EA6C 09F84000 */  jalr       $v0
    /* 2F270 8003EA70 2120C400 */   addu      $a0, $a2, $a0
    /* 2F274 8003EA74 C014038E */  lw         $v1, %lo(FEApp)($s0)
    /* 2F278 8003EA78 00000000 */  nop
    /* 2F27C 8003EA7C 2C026390 */  lbu        $v1, 0x22C($v1)
    /* 2F280 8003EA80 00000000 */  nop
    /* 2F284 8003EA84 10006014 */  bnez       $v1, .L8003EAC8
    /* 2F288 8003EA88 21A04000 */   addu      $s4, $v0, $zero
    /* 2F28C 8003EA8C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2F290 8003EA90 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2F294 8003EA94 00000000 */  nop
    /* 2F298 8003EA98 9816838C */  lw         $v1, 0x1698($a0)
    /* 2F29C 8003EA9C FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 2F2A0 8003EAA0 24286200 */  and        $a1, $v1, $v0
    /* 2F2A4 8003EAA4 05008012 */  beqz       $s4, .L8003EABC
    /* 2F2A8 8003EAA8 981685AC */   sw        $a1, 0x1698($a0)
    /* 2F2AC 8003EAAC 3A00A393 */  lbu        $v1, 0x3A($sp)
    /* 2F2B0 8003EAB0 07000224 */  addiu      $v0, $zero, 0x7
    /* 2F2B4 8003EAB4 13006214 */  bne        $v1, $v0, .L8003EB04
    /* 2F2B8 8003EAB8 21900000 */   addu      $s2, $zero, $zero
  .L8003EABC:
    /* 2F2BC 8003EABC 0100A234 */  ori        $v0, $a1, 0x1
    /* 2F2C0 8003EAC0 C0FA0008 */  j          .L8003EB00
    /* 2F2C4 8003EAC4 981682AC */   sw        $v0, 0x1698($a0)
  .L8003EAC8:
    /* 2F2C8 8003EAC8 0580023C */  lui        $v0, %hi(menuDefs)
    /* 2F2CC 8003EACC 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 2F2D0 8003EAD0 00000000 */  nop
    /* 2F2D4 8003EAD4 9017838C */  lw         $v1, 0x1790($a0)
    /* 2F2D8 8003EAD8 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 2F2DC 8003EADC 24286200 */  and        $a1, $v1, $v0
    /* 2F2E0 8003EAE0 05008012 */  beqz       $s4, .L8003EAF8
    /* 2F2E4 8003EAE4 901785AC */   sw        $a1, 0x1790($a0)
    /* 2F2E8 8003EAE8 3A00A393 */  lbu        $v1, 0x3A($sp)
    /* 2F2EC 8003EAEC 07000224 */  addiu      $v0, $zero, 0x7
    /* 2F2F0 8003EAF0 04006214 */  bne        $v1, $v0, .L8003EB04
    /* 2F2F4 8003EAF4 21900000 */   addu      $s2, $zero, $zero
  .L8003EAF8:
    /* 2F2F8 8003EAF8 0100A234 */  ori        $v0, $a1, 0x1
    /* 2F2FC 8003EAFC 901782AC */  sw         $v0, 0x1790($a0)
  .L8003EB00:
    /* 2F300 8003EB00 21900000 */  addu       $s2, $zero, $zero
  .L8003EB04:
    /* 2F304 8003EB04 0580023C */  lui        $v0, %hi(D_80051F78)
    /* 2F308 8003EB08 781F5624 */  addiu      $s6, $v0, %lo(D_80051F78)
    /* 2F30C 8003EB0C 0580023C */  lui        $v0, %hi(D_80051F58)
    /* 2F310 8003EB10 581F5524 */  addiu      $s5, $v0, %lo(D_80051F58)
    /* 2F314 8003EB14 3800B327 */  addiu      $s3, $sp, 0x38
  .L8003EB18:
    /* 2F318 8003EB18 00141200 */  sll        $v0, $s2, 16
    /* 2F31C 8003EB1C 03840200 */  sra        $s0, $v0, 16
    /* 2F320 8003EB20 0500022A */  slti       $v0, $s0, 0x5
    /* 2F324 8003EB24 40004010 */  beqz       $v0, .L8003EC28
    /* 2F328 8003EB28 F4010524 */   addiu     $a1, $zero, 0x1F4
    /* 2F32C 8003EB2C 04002626 */  addiu      $a2, $s1, 0x4
    /* 2F330 8003EB30 00340600 */  sll        $a2, $a2, 16
    /* 2F334 8003EB34 03340600 */  sra        $a2, $a2, 16
    /* 2F338 8003EB38 40101000 */  sll        $v0, $s0, 1
    /* 2F33C 8003EB3C 21105600 */  addu       $v0, $v0, $s6
    /* 2F340 8003EB40 01000724 */  addiu      $a3, $zero, 0x1
    /* 2F344 8003EB44 00004484 */  lh         $a0, 0x0($v0)
    /* 2F348 8003EB48 0E000224 */  addiu      $v0, $zero, 0xE
    /* 2F34C 8003EB4C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2F350 8003EB50 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 2F354 8003EB54 1400A2AF */   sw        $v0, 0x14($sp)
    /* 2F358 8003EB58 1B008012 */  beqz       $s4, .L8003EBC8
    /* 2F35C 8003EB5C 80101000 */   sll       $v0, $s0, 2
    /* 2F360 8003EB60 21105500 */  addu       $v0, $v0, $s5
    /* 2F364 8003EB64 0000428C */  lw         $v0, 0x0($v0)
    /* 2F368 8003EB68 C4006492 */  lbu        $a0, 0xC4($s3)
    /* 2F36C 8003EB6C 21286202 */  addu       $a1, $s3, $v0
    /* 2F370 8003EB70 01008230 */  andi       $v0, $a0, 0x1
    /* 2F374 8003EB74 3000A390 */  lbu        $v1, 0x30($a1)
    /* 2F378 8003EB78 05004010 */  beqz       $v0, .L8003EB90
    /* 2F37C 8003EB7C 02008230 */   andi      $v0, $a0, 0x2
    /* 2F380 8003EB80 3500A290 */  lbu        $v0, 0x35($a1)
    /* 2F384 8003EB84 00000000 */  nop
    /* 2F388 8003EB88 21186200 */  addu       $v1, $v1, $v0
    /* 2F38C 8003EB8C 02008230 */  andi       $v0, $a0, 0x2
  .L8003EB90:
    /* 2F390 8003EB90 05004010 */  beqz       $v0, .L8003EBA8
    /* 2F394 8003EB94 04008230 */   andi      $v0, $a0, 0x4
    /* 2F398 8003EB98 3A00A290 */  lbu        $v0, 0x3A($a1)
    /* 2F39C 8003EB9C 00000000 */  nop
    /* 2F3A0 8003EBA0 21186200 */  addu       $v1, $v1, $v0
    /* 2F3A4 8003EBA4 04008230 */  andi       $v0, $a0, 0x4
  .L8003EBA8:
    /* 2F3A8 8003EBA8 05004010 */  beqz       $v0, .L8003EBC0
    /* 2F3AC 8003EBAC 00140300 */   sll       $v0, $v1, 16
    /* 2F3B0 8003EBB0 3F00A290 */  lbu        $v0, 0x3F($a1)
    /* 2F3B4 8003EBB4 00000000 */  nop
    /* 2F3B8 8003EBB8 21186200 */  addu       $v1, $v1, $v0
    /* 2F3BC 8003EBBC 00140300 */  sll        $v0, $v1, 16
  .L8003EBC0:
    /* 2F3C0 8003EBC0 F3FA0008 */  j          .L8003EBCC
    /* 2F3C4 8003EBC4 03240200 */   sra       $a0, $v0, 16
  .L8003EBC8:
    /* 2F3C8 8003EBC8 21200000 */  addu       $a0, $zero, $zero
  .L8003EBCC:
    /* 2F3CC 8003EBCC 21280000 */  addu       $a1, $zero, $zero
    /* 2F3D0 8003EBD0 0B000624 */  addiu      $a2, $zero, 0xB
    /* 2F3D4 8003EBD4 A1010724 */  addiu      $a3, $zero, 0x1A1
    /* 2F3D8 8003EBD8 00141100 */  sll        $v0, $s1, 16
    /* 2F3DC 8003EBDC 03140200 */  sra        $v0, $v0, 16
    /* 2F3E0 8003EBE0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2F3E4 8003EBE4 49000224 */  addiu      $v0, $zero, 0x49
    /* 2F3E8 8003EBE8 03000324 */  addiu      $v1, $zero, 0x3
    /* 2F3EC 8003EBEC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2F3F0 8003EBF0 04000224 */  addiu      $v0, $zero, 0x4
    /* 2F3F4 8003EBF4 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 2F3F8 8003EBF8 01000224 */  addiu      $v0, $zero, 0x1
    /* 2F3FC 8003EBFC 2400A2AF */  sw         $v0, 0x24($sp)
    /* 2F400 8003EC00 80000224 */  addiu      $v0, $zero, 0x80
    /* 2F404 8003EC04 1800A3AF */  sw         $v1, 0x18($sp)
    /* 2F408 8003EC08 2000A3AF */  sw         $v1, 0x20($sp)
    /* 2F40C 8003EC0C 2800A0AF */  sw         $zero, 0x28($sp)
    /* 2F410 8003EC10 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 2F414 8003EC14 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* 2F418 8003EC18 3000A0AF */   sw        $zero, 0x30($sp)
    /* 2F41C 8003EC1C 0F003126 */  addiu      $s1, $s1, 0xF
    /* 2F420 8003EC20 C6FA0008 */  j          .L8003EB18
    /* 2F424 8003EC24 01005226 */   addiu     $s2, $s2, 0x1
  .L8003EC28:
    /* 2F428 8003EC28 2401BF8F */  lw         $ra, 0x124($sp)
    /* 2F42C 8003EC2C 2001B68F */  lw         $s6, 0x120($sp)
    /* 2F430 8003EC30 1C01B58F */  lw         $s5, 0x11C($sp)
    /* 2F434 8003EC34 1801B48F */  lw         $s4, 0x118($sp)
    /* 2F438 8003EC38 1401B38F */  lw         $s3, 0x114($sp)
    /* 2F43C 8003EC3C 1001B28F */  lw         $s2, 0x110($sp)
    /* 2F440 8003EC40 0C01B18F */  lw         $s1, 0x10C($sp)
    /* 2F444 8003EC44 0801B08F */  lw         $s0, 0x108($sp)
    /* 2F448 8003EC48 0800E003 */  jr         $ra
    /* 2F44C 8003EC4C 2801BD27 */   addiu     $sp, $sp, 0x128
endlabel DrawForeground__25tScreenCarSelectTwoPlayer
