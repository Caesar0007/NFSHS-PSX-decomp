.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_TextXY__FPcii, 0x158

glabel Font_TextXY__FPcii
    /* BC290 800CBA90 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* BC294 800CBA94 2800B2AF */  sw         $s2, 0x28($sp)
    /* BC298 800CBA98 2190A000 */  addu       $s2, $a1, $zero
    /* BC29C 800CBA9C 3800B6AF */  sw         $s6, 0x38($sp)
    /* BC2A0 800CBAA0 21B0C000 */  addu       $s6, $a2, $zero
    /* BC2A4 800CBAA4 3000B4AF */  sw         $s4, 0x30($sp)
    /* BC2A8 800CBAA8 21A08000 */  addu       $s4, $a0, $zero
    /* BC2AC 800CBAAC 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* BC2B0 800CBAB0 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* BC2B4 800CBAB4 1380023C */  lui        $v0, %hi(currentfont)
    /* BC2B8 800CBAB8 3400B5AF */  sw         $s5, 0x34($sp)
    /* BC2BC 800CBABC A05B5524 */  addiu      $s5, $v0, %lo(currentfont)
    /* BC2C0 800CBAC0 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* BC2C4 800CBAC4 2400B1AF */  sw         $s1, 0x24($sp)
    /* BC2C8 800CBAC8 2000B0AF */  sw         $s0, 0x20($sp)
  .L800CBACC:
    /* BC2CC 800CBACC 23006012 */  beqz       $s3, .L800CBB5C
    /* BC2D0 800CBAD0 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* BC2D4 800CBAD4 00009392 */  lbu        $s3, 0x0($s4)
    /* BC2D8 800CBAD8 00000000 */  nop
    /* BC2DC 800CBADC 2100622A */  slti       $v0, $s3, 0x21
    /* BC2E0 800CBAE0 1B004014 */  bnez       $v0, .L800CBB50
    /* BC2E4 800CBAE4 01009426 */   addiu     $s4, $s4, 0x1
    /* BC2E8 800CBAE8 D02D030C */  jal        Font_Getcharacter__Fi
    /* BC2EC 800CBAEC 21206002 */   addu      $a0, $s3, $zero
    /* BC2F0 800CBAF0 21884000 */  addu       $s1, $v0, $zero
    /* BC2F4 800CBAF4 F5FF2012 */  beqz       $s1, .L800CBACC
    /* BC2F8 800CBAF8 04002426 */   addiu     $a0, $s1, 0x4
    /* BC2FC 800CBAFC 23CC030C */  jal        geti
    /* BC300 800CBB00 02000524 */   addiu     $a1, $zero, 0x2
    /* BC304 800CBB04 06002426 */  addiu      $a0, $s1, 0x6
    /* BC308 800CBB08 02000524 */  addiu      $a1, $zero, 0x2
    /* BC30C 800CBB0C 23CC030C */  jal        geti
    /* BC310 800CBB10 21804000 */   addu      $s0, $v0, $zero
    /* BC314 800CBB14 8800A68E */  lw         $a2, 0x88($s5)
    /* BC318 800CBB18 09002482 */  lb         $a0, 0x9($s1)
    /* BC31C 800CBB1C 0A002582 */  lb         $a1, 0xA($s1)
    /* BC320 800CBB20 21380002 */  addu       $a3, $s0, $zero
    /* BC324 800CBB24 1000A2AF */  sw         $v0, 0x10($sp)
    /* BC328 800CBB28 1400B1AF */  sw         $s1, 0x14($sp)
    /* BC32C 800CBB2C 7800A28E */  lw         $v0, 0x78($s5)
    /* BC330 800CBB30 A018838F */  lw         $v1, %gp_rel(D_8013DDEC)($gp)
    /* BC334 800CBB34 21204402 */  addu       $a0, $s2, $a0
    /* BC338 800CBB38 2128C502 */  addu       $a1, $s6, $a1
    /* BC33C 800CBB3C 09F86000 */  jalr       $v1
    /* BC340 800CBB40 1800A2AF */   sw        $v0, 0x18($sp)
    /* BC344 800CBB44 08002282 */  lb         $v0, 0x8($s1)
    /* BC348 800CBB48 B32E0308 */  j          .L800CBACC
    /* BC34C 800CBB4C 21904202 */   addu      $s2, $s2, $v0
  .L800CBB50:
    /* BC350 800CBB50 1A138293 */  lbu        $v0, %gp_rel(gFontSpaceWidth)($gp)
    /* BC354 800CBB54 B32E0308 */  j          .L800CBACC
    /* BC358 800CBB58 21904202 */   addu      $s2, $s2, $v0
  .L800CBB5C:
    /* BC35C 800CBB5C 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BC360 800CBB60 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BC364 800CBB64 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BC368 800CBB68 21280000 */  addu       $a1, $zero, $zero
    /* BC36C 800CBB6C 2130A000 */  addu       $a2, $a1, $zero
    /* BC370 800CBB70 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BC374 800CBB74 0000648D */  lw         $a0, 0x0($t3)
    /* BC378 800CBB78 1C138797 */  lhu        $a3, %gp_rel(font_currentTPage)($gp)
    /* BC37C 800CBB7C 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* BC380 800CBB80 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* BC384 800CBB84 0000838C */  lw         $v1, 0x0($a0)
    /* BC388 800CBB88 0000028D */  lw         $v0, 0x0($t0)
    /* BC38C 800CBB8C 24186A00 */  and        $v1, $v1, $t2
    /* BC390 800CBB90 24104900 */  and        $v0, $v0, $t1
    /* BC394 800CBB94 25186200 */  or         $v1, $v1, $v0
    /* BC398 800CBB98 000083AC */  sw         $v1, 0x0($a0)
    /* BC39C 800CBB9C 0000028D */  lw         $v0, 0x0($t0)
    /* BC3A0 800CBBA0 0C008324 */  addiu      $v1, $a0, 0xC
    /* BC3A4 800CBBA4 000063AD */  sw         $v1, 0x0($t3)
    /* BC3A8 800CBBA8 24188900 */  and        $v1, $a0, $t1
    /* BC3AC 800CBBAC 24104A00 */  and        $v0, $v0, $t2
    /* BC3B0 800CBBB0 25104300 */  or         $v0, $v0, $v1
    /* BC3B4 800CBBB4 000002AD */  sw         $v0, 0x0($t0)
    /* BC3B8 800CBBB8 EFB8030C */  jal        SetDrawMode
    /* BC3BC 800CBBBC 1000A0AF */   sw        $zero, 0x10($sp)
    /* BC3C0 800CBBC0 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* BC3C4 800CBBC4 3800B68F */  lw         $s6, 0x38($sp)
    /* BC3C8 800CBBC8 3400B58F */  lw         $s5, 0x34($sp)
    /* BC3CC 800CBBCC 3000B48F */  lw         $s4, 0x30($sp)
    /* BC3D0 800CBBD0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* BC3D4 800CBBD4 2800B28F */  lw         $s2, 0x28($sp)
    /* BC3D8 800CBBD8 2400B18F */  lw         $s1, 0x24($sp)
    /* BC3DC 800CBBDC 2000B08F */  lw         $s0, 0x20($sp)
    /* BC3E0 800CBBE0 0800E003 */  jr         $ra
    /* BC3E4 800CBBE4 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Font_TextXY__FPcii
