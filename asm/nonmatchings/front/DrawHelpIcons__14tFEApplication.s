.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawHelpIcons__14tFEApplication, 0x3F8

glabel DrawHelpIcons__14tFEApplication
    /* 3B44 80013344 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 3B48 80013348 5400B1AF */  sw         $s1, 0x54($sp)
    /* 3B4C 8001334C 21888000 */  addu       $s1, $a0, $zero
    /* 3B50 80013350 6400B5AF */  sw         $s5, 0x64($sp)
    /* 3B54 80013354 7800153C */  lui        $s5, (0x786E14 >> 16)
    /* 3B58 80013358 1480023C */  lui        $v0, %hi(screenheight)
    /* 3B5C 8001335C 8CDC428C */  lw         $v0, %lo(screenheight)($v0)
    /* 3B60 80013360 146EB536 */  ori        $s5, $s5, (0x786E14 & 0xFFFF)
    /* 3B64 80013364 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* 3B68 80013368 0E001324 */  addiu      $s3, $zero, 0xE
    /* 3B6C 8001336C 6800BFAF */  sw         $ra, 0x68($sp)
    /* 3B70 80013370 6000B4AF */  sw         $s4, 0x60($sp)
    /* 3B74 80013374 5800B2AF */  sw         $s2, 0x58($sp)
    /* 3B78 80013378 5000B0AF */  sw         $s0, 0x50($sp)
    /* 3B7C 8001337C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 3B80 80013380 0400238E */  lw         $v1, 0x4($s1)
    /* 3B84 80013384 00000000 */  nop
    /* 3B88 80013388 52006010 */  beqz       $v1, .L800134D4
    /* 3B8C 8001338C E7FF5224 */   addiu     $s2, $v0, -0x19
    /* 3B90 80013390 64006284 */  lh         $v0, 0x64($v1)
    /* 3B94 80013394 00000000 */  nop
    /* 3B98 80013398 4F004010 */  beqz       $v0, .L800134D8
    /* 3B9C 8001339C 1480023C */   lui       $v0, %hi(gPadinfo)
    /* 3BA0 800133A0 4900A0A3 */  sb         $zero, 0x49($sp)
    /* 3BA4 800133A4 94E4020C */  jal        TextSys_Word__Fi
    /* 3BA8 800133A8 FC000424 */   addiu     $a0, $zero, 0xFC
    /* 3BAC 800133AC 3800B127 */  addiu      $s1, $sp, 0x38
    /* 3BB0 800133B0 21202002 */  addu       $a0, $s1, $zero
    /* 3BB4 800133B4 2F91030C */  jal        sprintf
    /* 3BB8 800133B8 21284000 */   addu      $a1, $v0, $zero
    /* 3BBC 800133BC DDA7030C */  jal        strlen
    /* 3BC0 800133C0 21202002 */   addu      $a0, $s1, $zero
    /* 3BC4 800133C4 FFFF5024 */  addiu      $s0, $v0, -0x1
    /* 3BC8 800133C8 12000006 */  bltz       $s0, .L80013414
    /* 3BCC 800133CC 1480023C */   lui       $v0, %hi(gPadinfo)
    /* 3BD0 800133D0 0E00143C */  lui        $s4, (0xE0000 >> 16)
    /* 3BD4 800133D4 4800A427 */  addiu      $a0, $sp, 0x48
  .L800133D8:
    /* 3BD8 800133D8 032C1400 */  sra        $a1, $s4, 16
    /* 3BDC 800133DC 00341200 */  sll        $a2, $s2, 16
    /* 3BE0 800133E0 03340600 */  sra        $a2, $a2, 16
    /* 3BE4 800133E4 2138A002 */  addu       $a3, $s5, $zero
    /* 3BE8 800133E8 F8FF5226 */  addiu      $s2, $s2, -0x8
    /* 3BEC 800133EC 21103002 */  addu       $v0, $s1, $s0
    /* 3BF0 800133F0 00004290 */  lbu        $v0, 0x0($v0)
    /* 3BF4 800133F4 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* 3BF8 800133F8 4800A2A3 */  sb         $v0, 0x48($sp)
    /* 3BFC 800133FC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3C00 80013400 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3C04 80013404 1400A0AF */   sw        $zero, 0x14($sp)
    /* 3C08 80013408 F3FF0106 */  bgez       $s0, .L800133D8
    /* 3C0C 8001340C 4800A427 */   addiu     $a0, $sp, 0x48
    /* 3C10 80013410 1480023C */  lui        $v0, %hi(gPadinfo)
  .L80013414:
    /* 3C14 80013414 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* 3C18 80013418 04008290 */  lbu        $v0, 0x4($a0)
    /* 3C1C 8001341C 00000000 */  nop
    /* 3C20 80013420 05004014 */  bnez       $v0, .L80013438
    /* 3C24 80013424 08005226 */   addiu     $s2, $s2, 0x8
    /* 3C28 80013428 05008390 */  lbu        $v1, 0x5($a0)
    /* 3C2C 8001342C 23000224 */  addiu      $v0, $zero, 0x23
    /* 3C30 80013430 09006214 */  bne        $v1, $v0, .L80013458
    /* 3C34 80013434 00000000 */   nop
  .L80013438:
    /* 3C38 80013438 24008290 */  lbu        $v0, 0x24($a0)
    /* 3C3C 8001343C 00000000 */  nop
    /* 3C40 80013440 10004014 */  bnez       $v0, .L80013484
    /* 3C44 80013444 1480023C */   lui       $v0, %hi(gPadinfo)
    /* 3C48 80013448 25008390 */  lbu        $v1, 0x25($a0)
    /* 3C4C 8001344C 23000224 */  addiu      $v0, $zero, 0x23
    /* 3C50 80013450 0C006210 */  beq        $v1, $v0, .L80013484
    /* 3C54 80013454 1480023C */   lui       $v0, %hi(gPadinfo)
  .L80013458:
    /* 3C58 80013458 F8FF5226 */  addiu      $s2, $s2, -0x8
    /* 3C5C 8001345C 35000424 */  addiu      $a0, $zero, 0x35
    /* 3C60 80013460 18000524 */  addiu      $a1, $zero, 0x18
    /* 3C64 80013464 21306002 */  addu       $a2, $s3, $zero
    /* 3C68 80013468 21384002 */  addu       $a3, $s2, $zero
    /* 3C6C 8001346C 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3C70 80013470 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3C74 80013474 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3C78 80013478 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3C7C 8001347C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3C80 80013480 1480023C */  lui        $v0, %hi(gPadinfo)
  .L80013484:
    /* 3C84 80013484 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* 3C88 80013488 05008290 */  lbu        $v0, 0x5($a0)
    /* 3C8C 8001348C 23000324 */  addiu      $v1, $zero, 0x23
    /* 3C90 80013490 05004310 */  beq        $v0, $v1, .L800134A8
    /* 3C94 80013494 00000000 */   nop
    /* 3C98 80013498 25008290 */  lbu        $v0, 0x25($a0)
    /* 3C9C 8001349C 00000000 */  nop
    /* 3CA0 800134A0 9D004314 */  bne        $v0, $v1, .L80013718
    /* 3CA4 800134A4 00000000 */   nop
  .L800134A8:
    /* 3CA8 800134A8 36000424 */  addiu      $a0, $zero, 0x36
    /* 3CAC 800134AC 18000524 */  addiu      $a1, $zero, 0x18
    /* 3CB0 800134B0 FFFF6626 */  addiu      $a2, $s3, -0x1
    /* 3CB4 800134B4 F7FF4726 */  addiu      $a3, $s2, -0x9
    /* 3CB8 800134B8 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3CBC 800134BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3CC0 800134C0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3CC4 800134C4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3CC8 800134C8 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3CCC 800134CC C64D0008 */  j          .L80013718
    /* 3CD0 800134D0 00000000 */   nop
  .L800134D4:
    /* 3CD4 800134D4 1480023C */  lui        $v0, %hi(gPadinfo)
  .L800134D8:
    /* 3CD8 800134D8 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* 3CDC 800134DC 04008290 */  lbu        $v0, 0x4($a0)
    /* 3CE0 800134E0 00000000 */  nop
    /* 3CE4 800134E4 05004014 */  bnez       $v0, .L800134FC
    /* 3CE8 800134E8 23000224 */   addiu     $v0, $zero, 0x23
    /* 3CEC 800134EC 05008390 */  lbu        $v1, 0x5($a0)
    /* 3CF0 800134F0 00000000 */  nop
    /* 3CF4 800134F4 09006214 */  bne        $v1, $v0, .L8001351C
    /* 3CF8 800134F8 00000000 */   nop
  .L800134FC:
    /* 3CFC 800134FC 24008290 */  lbu        $v0, 0x24($a0)
    /* 3D00 80013500 00000000 */  nop
    /* 3D04 80013504 10004014 */  bnez       $v0, .L80013548
    /* 3D08 80013508 1480023C */   lui       $v0, %hi(gPadinfo)
    /* 3D0C 8001350C 25008390 */  lbu        $v1, 0x25($a0)
    /* 3D10 80013510 23000224 */  addiu      $v0, $zero, 0x23
    /* 3D14 80013514 0C006210 */  beq        $v1, $v0, .L80013548
    /* 3D18 80013518 1480023C */   lui       $v0, %hi(gPadinfo)
  .L8001351C:
    /* 3D1C 8001351C 35000424 */  addiu      $a0, $zero, 0x35
    /* 3D20 80013520 18000524 */  addiu      $a1, $zero, 0x18
    /* 3D24 80013524 21306002 */  addu       $a2, $s3, $zero
    /* 3D28 80013528 21384002 */  addu       $a3, $s2, $zero
    /* 3D2C 8001352C 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3D30 80013530 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3D34 80013534 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3D38 80013538 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3D3C 8001353C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3D40 80013540 0E007326 */  addiu      $s3, $s3, 0xE
    /* 3D44 80013544 1480023C */  lui        $v0, %hi(gPadinfo)
  .L80013548:
    /* 3D48 80013548 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* 3D4C 8001354C 05008290 */  lbu        $v0, 0x5($a0)
    /* 3D50 80013550 23000324 */  addiu      $v1, $zero, 0x23
    /* 3D54 80013554 05004310 */  beq        $v0, $v1, .L8001356C
    /* 3D58 80013558 00000000 */   nop
    /* 3D5C 8001355C 25008290 */  lbu        $v0, 0x25($a0)
    /* 3D60 80013560 00000000 */  nop
    /* 3D64 80013564 0B004314 */  bne        $v0, $v1, .L80013594
    /* 3D68 80013568 00000000 */   nop
  .L8001356C:
    /* 3D6C 8001356C 36000424 */  addiu      $a0, $zero, 0x36
    /* 3D70 80013570 18000524 */  addiu      $a1, $zero, 0x18
    /* 3D74 80013574 21306002 */  addu       $a2, $s3, $zero
    /* 3D78 80013578 21384002 */  addu       $a3, $s2, $zero
    /* 3D7C 8001357C 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3D80 80013580 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3D84 80013584 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3D88 80013588 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3D8C 8001358C 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3D90 80013590 0F007326 */  addiu      $s3, $s3, 0xF
  .L80013594:
    /* 3D94 80013594 94E4020C */  jal        TextSys_Word__Fi
    /* 3D98 80013598 FC000424 */   addiu     $a0, $zero, 0xFC
    /* 3D9C 8001359C 21204000 */  addu       $a0, $v0, $zero
    /* 3DA0 800135A0 002C1300 */  sll        $a1, $s3, 16
    /* 3DA4 800135A4 032C0500 */  sra        $a1, $a1, 16
    /* 3DA8 800135A8 00341200 */  sll        $a2, $s2, 16
    /* 3DAC 800135AC 03340600 */  sra        $a2, $a2, 16
    /* 3DB0 800135B0 2138A002 */  addu       $a3, $s5, $zero
    /* 3DB4 800135B4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3DB8 800135B8 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3DBC 800135BC 1400A0AF */   sw        $zero, 0x14($sp)
    /* 3DC0 800135C0 94E4020C */  jal        TextSys_Word__Fi
    /* 3DC4 800135C4 FC000424 */   addiu     $a0, $zero, 0xFC
    /* 3DC8 800135C8 888F030C */  jal        textpixels
    /* 3DCC 800135CC 21204000 */   addu      $a0, $v0, $zero
    /* 3DD0 800135D0 FC000424 */  addiu      $a0, $zero, 0xFC
    /* 3DD4 800135D4 94E4020C */  jal        TextSys_Word__Fi
    /* 3DD8 800135D8 21804000 */   addu      $s0, $v0, $zero
    /* 3DDC 800135DC DDA7030C */  jal        strlen
    /* 3DE0 800135E0 21204000 */   addu      $a0, $v0, $zero
    /* 3DE4 800135E4 05006326 */  addiu      $v1, $s3, 0x5
    /* 3DE8 800135E8 23800202 */  subu       $s0, $s0, $v0
    /* 3DEC 800135EC 0400228E */  lw         $v0, 0x4($s1)
    /* 3DF0 800135F0 21987000 */  addu       $s3, $v1, $s0
    /* 3DF4 800135F4 5C00428C */  lw         $v0, 0x5C($v0)
    /* 3DF8 800135F8 00000000 */  nop
    /* 3DFC 800135FC 09004014 */  bnez       $v0, .L80013624
    /* 3E00 80013600 21180000 */   addu      $v1, $zero, $zero
    /* 3E04 80013604 0800248E */  lw         $a0, 0x8($s1)
    /* 3E08 80013608 00000000 */  nop
    /* 3E0C 8001360C 06008010 */  beqz       $a0, .L80013628
    /* 3E10 80013610 00000000 */   nop
    /* 3E14 80013614 5C00828C */  lw         $v0, 0x5C($a0)
    /* 3E18 80013618 00000000 */  nop
    /* 3E1C 8001361C 02004010 */  beqz       $v0, .L80013628
    /* 3E20 80013620 00000000 */   nop
  .L80013624:
    /* 3E24 80013624 01000324 */  addiu      $v1, $zero, 0x1
  .L80013628:
    /* 3E28 80013628 3B006010 */  beqz       $v1, .L80013718
    /* 3E2C 8001362C 1480023C */   lui       $v0, %hi(gPadinfo)
    /* 3E30 80013630 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* 3E34 80013634 04008290 */  lbu        $v0, 0x4($a0)
    /* 3E38 80013638 00000000 */  nop
    /* 3E3C 8001363C 05004014 */  bnez       $v0, .L80013654
    /* 3E40 80013640 23000224 */   addiu     $v0, $zero, 0x23
    /* 3E44 80013644 05008390 */  lbu        $v1, 0x5($a0)
    /* 3E48 80013648 00000000 */  nop
    /* 3E4C 8001364C 09006214 */  bne        $v1, $v0, .L80013674
    /* 3E50 80013650 00000000 */   nop
  .L80013654:
    /* 3E54 80013654 24008290 */  lbu        $v0, 0x24($a0)
    /* 3E58 80013658 00000000 */  nop
    /* 3E5C 8001365C 10004014 */  bnez       $v0, .L800136A0
    /* 3E60 80013660 1480023C */   lui       $v0, %hi(gPadinfo)
    /* 3E64 80013664 25008390 */  lbu        $v1, 0x25($a0)
    /* 3E68 80013668 23000224 */  addiu      $v0, $zero, 0x23
    /* 3E6C 8001366C 0C006210 */  beq        $v1, $v0, .L800136A0
    /* 3E70 80013670 1480023C */   lui       $v0, %hi(gPadinfo)
  .L80013674:
    /* 3E74 80013674 37000424 */  addiu      $a0, $zero, 0x37
    /* 3E78 80013678 18000524 */  addiu      $a1, $zero, 0x18
    /* 3E7C 8001367C 21306002 */  addu       $a2, $s3, $zero
    /* 3E80 80013680 21384002 */  addu       $a3, $s2, $zero
    /* 3E84 80013684 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3E88 80013688 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3E8C 8001368C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3E90 80013690 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3E94 80013694 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3E98 80013698 0E007326 */  addiu      $s3, $s3, 0xE
    /* 3E9C 8001369C 1480023C */  lui        $v0, %hi(gPadinfo)
  .L800136A0:
    /* 3EA0 800136A0 9CE84424 */  addiu      $a0, $v0, %lo(gPadinfo)
    /* 3EA4 800136A4 05008290 */  lbu        $v0, 0x5($a0)
    /* 3EA8 800136A8 23000324 */  addiu      $v1, $zero, 0x23
    /* 3EAC 800136AC 05004310 */  beq        $v0, $v1, .L800136C4
    /* 3EB0 800136B0 00000000 */   nop
    /* 3EB4 800136B4 25008290 */  lbu        $v0, 0x25($a0)
    /* 3EB8 800136B8 00000000 */  nop
    /* 3EBC 800136BC 0B004314 */  bne        $v0, $v1, .L800136EC
    /* 3EC0 800136C0 00000000 */   nop
  .L800136C4:
    /* 3EC4 800136C4 38000424 */  addiu      $a0, $zero, 0x38
    /* 3EC8 800136C8 18000524 */  addiu      $a1, $zero, 0x18
    /* 3ECC 800136CC 21306002 */  addu       $a2, $s3, $zero
    /* 3ED0 800136D0 21384002 */  addu       $a3, $s2, $zero
    /* 3ED4 800136D4 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3ED8 800136D8 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3EDC 800136DC 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3EE0 800136E0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3EE4 800136E4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3EE8 800136E8 0F007326 */  addiu      $s3, $s3, 0xF
  .L800136EC:
    /* 3EEC 800136EC 94E4020C */  jal        TextSys_Word__Fi
    /* 3EF0 800136F0 FD000424 */   addiu     $a0, $zero, 0xFD
    /* 3EF4 800136F4 21204000 */  addu       $a0, $v0, $zero
    /* 3EF8 800136F8 002C1300 */  sll        $a1, $s3, 16
    /* 3EFC 800136FC 032C0500 */  sra        $a1, $a1, 16
    /* 3F00 80013700 00341200 */  sll        $a2, $s2, 16
    /* 3F04 80013704 03340600 */  sra        $a2, $a2, 16
    /* 3F08 80013708 2138A002 */  addu       $a3, $s5, $zero
    /* 3F0C 8001370C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3F10 80013710 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 3F14 80013714 1400A0AF */   sw        $zero, 0x14($sp)
  .L80013718:
    /* 3F18 80013718 6800BF8F */  lw         $ra, 0x68($sp)
    /* 3F1C 8001371C 6400B58F */  lw         $s5, 0x64($sp)
    /* 3F20 80013720 6000B48F */  lw         $s4, 0x60($sp)
    /* 3F24 80013724 5C00B38F */  lw         $s3, 0x5C($sp)
    /* 3F28 80013728 5800B28F */  lw         $s2, 0x58($sp)
    /* 3F2C 8001372C 5400B18F */  lw         $s1, 0x54($sp)
    /* 3F30 80013730 5000B08F */  lw         $s0, 0x50($sp)
    /* 3F34 80013734 0800E003 */  jr         $ra
    /* 3F38 80013738 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel DrawHelpIcons__14tFEApplication
