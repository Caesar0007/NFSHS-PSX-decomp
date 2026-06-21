.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__25tInsideBoxLeftRightSlideriiib, 0x184

glabel Draw__25tInsideBoxLeftRightSlideriiib
    /* FAF0 8001F2F0 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* FAF4 8001F2F4 3800B0AF */  sw         $s0, 0x38($sp)
    /* FAF8 8001F2F8 21808000 */  addu       $s0, $a0, $zero
    /* FAFC 8001F2FC 5500043C */  lui        $a0, (0x551E00 >> 16)
    /* FB00 8001F300 001E8434 */  ori        $a0, $a0, (0x551E00 & 0xFFFF)
    /* FB04 8001F304 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* FB08 8001F308 4800B4AF */  sw         $s4, 0x48($sp)
    /* FB0C 8001F30C 4400B3AF */  sw         $s3, 0x44($sp)
    /* FB10 8001F310 4000B2AF */  sw         $s2, 0x40($sp)
    /* FB14 8001F314 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* FB18 8001F318 200005A6 */  sh         $a1, 0x20($s0)
    /* FB1C 8001F31C C800053C */  lui        $a1, (0xC83C1E >> 16)
    /* FB20 8001F320 1E3CA534 */  ori        $a1, $a1, (0xC83C1E & 0xFFFF)
    /* FB24 8001F324 220006A6 */  sh         $a2, 0x22($s0)
    /* FB28 8001F328 08000686 */  lh         $a2, 0x8($s0)
    /* FB2C 8001F32C FE2D010C */  jal        CalcFadeVal__Fiii
    /* FB30 8001F330 2188E000 */   addu      $s1, $a3, $zero
    /* FB34 8001F334 06000424 */  addiu      $a0, $zero, 0x6
    /* FB38 8001F338 21300000 */  addu       $a2, $zero, $zero
    /* FB3C 8001F33C 08000586 */  lh         $a1, 0x8($s0)
    /* FB40 8001F340 382E010C */  jal        CalcTextFadeUnselToSel__F13tMenuTextTypess
    /* FB44 8001F344 21984000 */   addu      $s3, $v0, $zero
    /* FB48 8001F348 21206002 */  addu       $a0, $s3, $zero
    /* FB4C 8001F34C 21382002 */  addu       $a3, $s1, $zero
    /* FB50 8001F350 01001224 */  addiu      $s2, $zero, 0x1
    /* FB54 8001F354 20000586 */  lh         $a1, 0x20($s0)
    /* FB58 8001F358 22000686 */  lh         $a2, 0x22($s0)
    /* FB5C 8001F35C 21A04000 */  addu       $s4, $v0, $zero
    /* FB60 8001F360 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FB64 8001F364 1000B2AF */   sw        $s2, 0x10($sp)
    /* FB68 8001F368 21206002 */  addu       $a0, $s3, $zero
    /* FB6C 8001F36C 20000586 */  lh         $a1, 0x20($s0)
    /* FB70 8001F370 22000686 */  lh         $a2, 0x22($s0)
    /* FB74 8001F374 21382002 */  addu       $a3, $s1, $zero
    /* FB78 8001F378 1000B2AF */  sw         $s2, 0x10($sp)
    /* FB7C 8001F37C 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FB80 8001F380 0800C624 */   addiu     $a2, $a2, 0x8
    /* FB84 8001F384 0400048E */  lw         $a0, 0x4($s0)
    /* FB88 8001F388 94E4020C */  jal        TextSys_Word__Fi
    /* FB8C 8001F38C F8FF3126 */   addiu     $s1, $s1, -0x8
    /* FB90 8001F390 21204000 */  addu       $a0, $v0, $zero
    /* FB94 8001F394 20000596 */  lhu        $a1, 0x20($s0)
    /* FB98 8001F398 22000696 */  lhu        $a2, 0x22($s0)
    /* FB9C 8001F39C 21388002 */  addu       $a3, $s4, $zero
    /* FBA0 8001F3A0 1000A0AF */  sw         $zero, 0x10($sp)
    /* FBA4 8001F3A4 1400A0AF */  sw         $zero, 0x14($sp)
    /* FBA8 8001F3A8 0400A524 */  addiu      $a1, $a1, 0x4
    /* FBAC 8001F3AC 002C0500 */  sll        $a1, $a1, 16
    /* FBB0 8001F3B0 032C0500 */  sra        $a1, $a1, 16
    /* FBB4 8001F3B4 0A00C624 */  addiu      $a2, $a2, 0xA
    /* FBB8 8001F3B8 00340600 */  sll        $a2, $a2, 16
    /* FBBC 8001F3BC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* FBC0 8001F3C0 03340600 */   sra       $a2, $a2, 16
    /* FBC4 8001F3C4 1C00038E */  lw         $v1, 0x1C($s0)
    /* FBC8 8001F3C8 00000000 */  nop
    /* FBCC 8001F3CC 0C00628C */  lw         $v0, 0xC($v1)
    /* FBD0 8001F3D0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* FBD4 8001F3D4 10004484 */  lh         $a0, 0x10($v0)
    /* FBD8 8001F3D8 1400428C */  lw         $v0, 0x14($v0)
    /* FBDC 8001F3DC 00000000 */  nop
    /* FBE0 8001F3E0 09F84000 */  jalr       $v0
    /* FBE4 8001F3E4 21206400 */   addu      $a0, $v1, $a0
    /* FBE8 8001F3E8 FF004430 */  andi       $a0, $v0, 0xFF
    /* FBEC 8001F3EC 008C1100 */  sll        $s1, $s1, 16
    /* FBF0 8001F3F0 038C1100 */  sra        $s1, $s1, 16
    /* FBF4 8001F3F4 20000796 */  lhu        $a3, 0x20($s0)
    /* FBF8 8001F3F8 22000296 */  lhu        $v0, 0x22($s0)
    /* FBFC 8001F3FC 1C00038E */  lw         $v1, 0x1C($s0)
    /* FC00 8001F400 0400E724 */  addiu      $a3, $a3, 0x4
    /* FC04 8001F404 003C0700 */  sll        $a3, $a3, 16
    /* FC08 8001F408 02004224 */  addiu      $v0, $v0, 0x2
    /* FC0C 8001F40C 00140200 */  sll        $v0, $v0, 16
    /* FC10 8001F410 08006590 */  lbu        $a1, 0x8($v1)
    /* FC14 8001F414 09006690 */  lbu        $a2, 0x9($v1)
    /* FC18 8001F418 03140200 */  sra        $v0, $v0, 16
    /* FC1C 8001F41C 1000A2AF */  sw         $v0, 0x10($sp)
    /* FC20 8001F420 1400B1AF */  sw         $s1, 0x14($sp)
    /* FC24 8001F424 26000386 */  lh         $v1, 0x26($s0)
    /* FC28 8001F428 04000224 */  addiu      $v0, $zero, 0x4
    /* FC2C 8001F42C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* FC30 8001F430 2000A2AF */  sw         $v0, 0x20($sp)
    /* FC34 8001F434 2400A0AF */  sw         $zero, 0x24($sp)
    /* FC38 8001F438 2800A0AF */  sw         $zero, 0x28($sp)
    /* FC3C 8001F43C 1800A3AF */  sw         $v1, 0x18($sp)
    /* FC40 8001F440 08000286 */  lh         $v0, 0x8($s0)
    /* FC44 8001F444 033C0700 */  sra        $a3, $a3, 16
    /* FC48 8001F448 3000A0AF */  sw         $zero, 0x30($sp)
    /* FC4C 8001F44C 0B93000C */  jal        DrawSlider__FsssssssssbT9ss
    /* FC50 8001F450 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* FC54 8001F454 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* FC58 8001F458 4800B48F */  lw         $s4, 0x48($sp)
    /* FC5C 8001F45C 4400B38F */  lw         $s3, 0x44($sp)
    /* FC60 8001F460 4000B28F */  lw         $s2, 0x40($sp)
    /* FC64 8001F464 3C00B18F */  lw         $s1, 0x3C($sp)
    /* FC68 8001F468 3800B08F */  lw         $s0, 0x38($sp)
    /* FC6C 8001F46C 0800E003 */  jr         $ra
    /* FC70 8001F470 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Draw__25tInsideBoxLeftRightSlideriiib
