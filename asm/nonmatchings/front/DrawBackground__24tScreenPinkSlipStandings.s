.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__24tScreenPinkSlipStandings, 0x424

glabel DrawBackground__24tScreenPinkSlipStandings
    /* 2AC48 8003A448 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 2AC4C 8003A44C C800BEAF */  sw         $fp, 0xC8($sp)
    /* 2AC50 8003A450 21F08000 */  addu       $fp, $a0, $zero
    /* 2AC54 8003A454 C000B6AF */  sw         $s6, 0xC0($sp)
    /* 2AC58 8003A458 0B001624 */  addiu      $s6, $zero, 0xB
    /* 2AC5C 8003A45C B000B2AF */  sw         $s2, 0xB0($sp)
    /* 2AC60 8003A460 21900000 */  addu       $s2, $zero, $zero
    /* 2AC64 8003A464 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2AC68 8003A468 B400B3AF */  sw         $s3, 0xB4($sp)
    /* 2AC6C 8003A46C 00465324 */  addiu      $s3, $v0, %lo(frontEnd)
    /* 2AC70 8003A470 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 2AC74 8003A474 FE021124 */  addiu      $s1, $zero, 0x2FE
    /* 2AC78 8003A478 CC00BFAF */  sw         $ra, 0xCC($sp)
    /* 2AC7C 8003A47C C400B7AF */  sw         $s7, 0xC4($sp)
    /* 2AC80 8003A480 BC00B5AF */  sw         $s5, 0xBC($sp)
    /* 2AC84 8003A484 B800B4AF */  sw         $s4, 0xB8($sp)
    /* 2AC88 8003A488 A800B0AF */  sw         $s0, 0xA8($sp)
    /* 2AC8C 8003A48C 5C00D587 */  lh         $s5, 0x5C($fp)
  .L8003A490:
    /* 2AC90 8003A490 47006292 */  lbu        $v0, 0x47($s3)
    /* 2AC94 8003A494 00000000 */  nop
    /* 2AC98 8003A498 2A104202 */  slt        $v0, $s2, $v0
    /* 2AC9C 8003A49C 42004010 */  beqz       $v0, .L8003A5A8
    /* 2ACA0 8003A4A0 02001424 */   addiu     $s4, $zero, 0x2
    /* 2ACA4 8003A4A4 46006292 */  lbu        $v0, 0x46($s3)
    /* 2ACA8 8003A4A8 00000000 */  nop
    /* 2ACAC 8003A4AC 02004212 */  beq        $s2, $v0, .L8003A4B8
    /* 2ACB0 8003A4B0 00000000 */   nop
    /* 2ACB4 8003A4B4 2AA04202 */  slt        $s4, $s2, $v0
  .L8003A4B8:
    /* 2ACB8 8003A4B8 1180043C */  lui        $a0, %hi(trackManager)
    /* 2ACBC 8003A4BC 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 2ACC0 8003A4C0 21105302 */  addu       $v0, $s2, $s3
    /* 2ACC4 8003A4C4 23004590 */  lbu        $a1, 0x23($v0)
    /* 2ACC8 8003A4C8 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 2ACCC 8003A4CC 5800A627 */   addiu     $a2, $sp, 0x58
    /* 2ACD0 8003A4D0 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2ACD4 8003A4D4 F7020424 */   addiu     $a0, $zero, 0x2F7
    /* 2ACD8 8003A4D8 21202002 */  addu       $a0, $s1, $zero
    /* 2ACDC 8003A4DC 00840200 */  sll        $s0, $v0, 16
    /* 2ACE0 8003A4E0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2ACE4 8003A4E4 03841000 */   sra       $s0, $s0, 16
    /* 2ACE8 8003A4E8 21300002 */  addu       $a2, $s0, $zero
    /* 2ACEC 8003A4EC 00140200 */  sll        $v0, $v0, 16
    /* 2ACF0 8003A4F0 5C00C487 */  lh         $a0, 0x5C($fp)
    /* 2ACF4 8003A4F4 5800A593 */  lbu        $a1, 0x58($sp)
    /* 2ACF8 8003A4F8 033C0200 */  sra        $a3, $v0, 16
    /* 2ACFC 8003A4FC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 2AD00 8003A500 1400B4AF */  sw         $s4, 0x14($sp)
    /* 2AD04 8003A504 1800B6AF */  sw         $s6, 0x18($sp)
    /* 2AD08 8003A508 002E0500 */  sll        $a1, $a1, 24
    /* 2AD0C 8003A50C 032E0500 */  sra        $a1, $a1, 24
    /* 2AD10 8003A510 D500A524 */  addiu      $a1, $a1, 0xD5
    /* 2AD14 8003A514 002C0500 */  sll        $a1, $a1, 16
    /* 2AD18 8003A518 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 2AD1C 8003A51C 032C0500 */   sra       $a1, $a1, 16
    /* 2AD20 8003A520 40101200 */  sll        $v0, $s2, 1
    /* 2AD24 8003A524 21105300 */  addu       $v0, $v0, $s3
    /* 2AD28 8003A528 0C004484 */  lh         $a0, 0xC($v0)
    /* 2AD2C 8003A52C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2AD30 8003A530 05008214 */  bne        $a0, $v0, .L8003A548
    /* 2AD34 8003A534 00000000 */   nop
    /* 2AD38 8003A538 94E4020C */  jal        TextSys_Word__Fi
    /* 2AD3C 8003A53C 0D030424 */   addiu     $a0, $zero, 0x30D
    /* 2AD40 8003A540 55E90008 */  j          .L8003A554
    /* 2AD44 8003A544 8800A427 */   addiu     $a0, $sp, 0x88
  .L8003A548:
    /* 2AD48 8003A548 7FAE000C */  jal        PlayerName__Fi
    /* 2AD4C 8003A54C 00000000 */   nop
    /* 2AD50 8003A550 8800A427 */  addiu      $a0, $sp, 0x88
  .L8003A554:
    /* 2AD54 8003A554 2F91030C */  jal        sprintf
    /* 2AD58 8003A558 21284000 */   addu      $a1, $v0, $zero
    /* 2AD5C 8003A55C A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AD60 8003A560 FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2AD64 8003A564 21202002 */  addu       $a0, $s1, $zero
    /* 2AD68 8003A568 00840200 */  sll        $s0, $v0, 16
    /* 2AD6C 8003A56C ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AD70 8003A570 03841000 */   sra       $s0, $s0, 16
    /* 2AD74 8003A574 2120A002 */  addu       $a0, $s5, $zero
    /* 2AD78 8003A578 8800A527 */  addiu      $a1, $sp, 0x88
    /* 2AD7C 8003A57C 21300002 */  addu       $a2, $s0, $zero
    /* 2AD80 8003A580 00140200 */  sll        $v0, $v0, 16
    /* 2AD84 8003A584 033C0200 */  sra        $a3, $v0, 16
    /* 2AD88 8003A588 01000224 */  addiu      $v0, $zero, 0x1
    /* 2AD8C 8003A58C 1000B6AF */  sw         $s6, 0x10($sp)
    /* 2AD90 8003A590 1400B4AF */  sw         $s4, 0x14($sp)
    /* 2AD94 8003A594 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2AD98 8003A598 1800A2AF */   sw        $v0, 0x18($sp)
    /* 2AD9C 8003A59C 01003126 */  addiu      $s1, $s1, 0x1
    /* 2ADA0 8003A5A0 24E90008 */  j          .L8003A490
    /* 2ADA4 8003A5A4 01005226 */   addiu     $s2, $s2, 0x1
  .L8003A5A8:
    /* 2ADA8 8003A5A8 21900000 */  addu       $s2, $zero, $zero
    /* 2ADAC 8003A5AC 01001724 */  addiu      $s7, $zero, 0x1
    /* 2ADB0 8003A5B0 13031324 */  addiu      $s3, $zero, 0x313
  .L8003A5B4:
    /* 2ADB4 8003A5B4 7FAE000C */  jal        PlayerName__Fi
    /* 2ADB8 8003A5B8 21204002 */   addu      $a0, $s2, $zero
    /* 2ADBC 8003A5BC F8020424 */  addiu      $a0, $zero, 0x2F8
    /* 2ADC0 8003A5C0 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2ADC4 8003A5C4 21884000 */   addu      $s1, $v0, $zero
    /* 2ADC8 8003A5C8 21206002 */  addu       $a0, $s3, $zero
    /* 2ADCC 8003A5CC 00840200 */  sll        $s0, $v0, 16
    /* 2ADD0 8003A5D0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2ADD4 8003A5D4 03841000 */   sra       $s0, $s0, 16
    /* 2ADD8 8003A5D8 2120A002 */  addu       $a0, $s5, $zero
    /* 2ADDC 8003A5DC 21282002 */  addu       $a1, $s1, $zero
    /* 2ADE0 8003A5E0 21300002 */  addu       $a2, $s0, $zero
    /* 2ADE4 8003A5E4 00140200 */  sll        $v0, $v0, 16
    /* 2ADE8 8003A5E8 033C0200 */  sra        $a3, $v0, 16
    /* 2ADEC 8003A5EC 1000B6AF */  sw         $s6, 0x10($sp)
    /* 2ADF0 8003A5F0 1400B4AF */  sw         $s4, 0x14($sp)
    /* 2ADF4 8003A5F4 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2ADF8 8003A5F8 1800A0AF */   sw        $zero, 0x18($sp)
    /* 2ADFC 8003A5FC 1180083C */  lui        $t0, %hi(frontEnd)
    /* 2AE00 8003A600 00460825 */  addiu      $t0, $t0, %lo(frontEnd)
    /* 2AE04 8003A604 21804802 */  addu       $s0, $s2, $t0
    /* 2AE08 8003A608 48000292 */  lbu        $v0, 0x48($s0)
    /* 2AE0C 8003A60C 00000000 */  nop
    /* 2AE10 8003A610 08005714 */  bne        $v0, $s7, .L8003A634
    /* 2AE14 8003A614 00000000 */   nop
    /* 2AE18 8003A618 94E4020C */  jal        TextSys_Word__Fi
    /* 2AE1C 8003A61C 1F030424 */   addiu     $a0, $zero, 0x31F
    /* 2AE20 8003A620 2000A427 */  addiu      $a0, $sp, 0x20
    /* 2AE24 8003A624 2F91030C */  jal        sprintf
    /* 2AE28 8003A628 21284000 */   addu      $a1, $v0, $zero
    /* 2AE2C 8003A62C 93E90008 */  j          .L8003A64C
    /* 2AE30 8003A630 00000000 */   nop
  .L8003A634:
    /* 2AE34 8003A634 94E4020C */  jal        TextSys_Word__Fi
    /* 2AE38 8003A638 1E030424 */   addiu     $a0, $zero, 0x31E
    /* 2AE3C 8003A63C 2000A427 */  addiu      $a0, $sp, 0x20
    /* 2AE40 8003A640 48000692 */  lbu        $a2, 0x48($s0)
    /* 2AE44 8003A644 2F91030C */  jal        sprintf
    /* 2AE48 8003A648 21284000 */   addu      $a1, $v0, $zero
  .L8003A64C:
    /* 2AE4C 8003A64C A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AE50 8003A650 FB020424 */   addiu     $a0, $zero, 0x2FB
    /* 2AE54 8003A654 21206002 */  addu       $a0, $s3, $zero
    /* 2AE58 8003A658 00840200 */  sll        $s0, $v0, 16
    /* 2AE5C 8003A65C ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AE60 8003A660 03841000 */   sra       $s0, $s0, 16
    /* 2AE64 8003A664 2120A002 */  addu       $a0, $s5, $zero
    /* 2AE68 8003A668 2000A527 */  addiu      $a1, $sp, 0x20
    /* 2AE6C 8003A66C 21300002 */  addu       $a2, $s0, $zero
    /* 2AE70 8003A670 00140200 */  sll        $v0, $v0, 16
    /* 2AE74 8003A674 033C0200 */  sra        $a3, $v0, 16
    /* 2AE78 8003A678 1000B6AF */  sw         $s6, 0x10($sp)
    /* 2AE7C 8003A67C 1400B4AF */  sw         $s4, 0x14($sp)
    /* 2AE80 8003A680 D183000C */  jal        FETextRender_FullTextFade__FiPcss13tMenuTextType14tMenuTextStates
    /* 2AE84 8003A684 1800B7AF */   sw        $s7, 0x18($sp)
    /* 2AE88 8003A688 01005226 */  addiu      $s2, $s2, 0x1
    /* 2AE8C 8003A68C 0200422A */  slti       $v0, $s2, 0x2
    /* 2AE90 8003A690 C8FF4014 */  bnez       $v0, .L8003A5B4
    /* 2AE94 8003A694 01007326 */   addiu     $s3, $s3, 0x1
    /* 2AE98 8003A698 A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AE9C 8003A69C F6020424 */   addiu     $a0, $zero, 0x2F6
    /* 2AEA0 8003A6A0 FC020424 */  addiu      $a0, $zero, 0x2FC
    /* 2AEA4 8003A6A4 00840200 */  sll        $s0, $v0, 16
    /* 2AEA8 8003A6A8 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AEAC 8003A6AC 03841000 */   sra       $s0, $s0, 16
    /* 2AEB0 8003A6B0 2120A002 */  addu       $a0, $s5, $zero
    /* 2AEB4 8003A6B4 C1020524 */  addiu      $a1, $zero, 0x2C1
    /* 2AEB8 8003A6B8 21300002 */  addu       $a2, $s0, $zero
    /* 2AEBC 8003A6BC 00140200 */  sll        $v0, $v0, 16
    /* 2AEC0 8003A6C0 033C0200 */  sra        $a3, $v0, 16
    /* 2AEC4 8003A6C4 02000224 */  addiu      $v0, $zero, 0x2
    /* 2AEC8 8003A6C8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2AECC 8003A6CC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 2AED0 8003A6D0 7584000C */  jal        FETextRender_MenuTextPositionedJustifyFade__Fissss14tMenuTextState13tMenuTextType
    /* 2AED4 8003A6D4 1800B6AF */   sw        $s6, 0x18($sp)
    /* 2AED8 8003A6D8 94E4020C */  jal        TextSys_Word__Fi
    /* 2AEDC 8003A6DC C1020424 */   addiu     $a0, $zero, 0x2C1
    /* 2AEE0 8003A6E0 888F030C */  jal        textpixels
    /* 2AEE4 8003A6E4 21204000 */   addu      $a0, $v0, $zero
    /* 2AEE8 8003A6E8 F6020424 */  addiu      $a0, $zero, 0x2F6
    /* 2AEEC 8003A6EC A4E4020C */  jal        TextSys_WordX__Fi
    /* 2AEF0 8003A6F0 21884000 */   addu      $s1, $v0, $zero
    /* 2AEF4 8003A6F4 FC020424 */  addiu      $a0, $zero, 0x2FC
    /* 2AEF8 8003A6F8 43181100 */  sra        $v1, $s1, 1
    /* 2AEFC 8003A6FC ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AF00 8003A700 23804300 */   subu      $s0, $v0, $v1
    /* 2AF04 8003A704 21200000 */  addu       $a0, $zero, $zero
    /* 2AF08 8003A708 21280002 */  addu       $a1, $s0, $zero
    /* 2AF0C 8003A70C FFFF4624 */  addiu      $a2, $v0, -0x1
    /* 2AF10 8003A710 21382002 */  addu       $a3, $s1, $zero
    /* 2AF14 8003A714 09000224 */  addiu      $v0, $zero, 0x9
    /* 2AF18 8003A718 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 2AF1C 8003A71C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2AF20 8003A720 0580133C */  lui        $s3, %hi(gCurrentShapes)
    /* 2AF24 8003A724 CC17648E */  lw         $a0, %lo(gCurrentShapes)($s3)
    /* 2AF28 8003A728 1480023C */  lui        $v0, %hi(ticks)
    /* 2AF2C 8003A72C E0048424 */  addiu      $a0, $a0, 0x4E0
    /* 2AF30 8003A730 10008394 */  lhu        $v1, 0x10($a0)
    /* 2AF34 8003A734 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 2AF38 8003A738 001C0300 */  sll        $v1, $v1, 16
    /* 2AF3C 8003A73C 032C0300 */  sra        $a1, $v1, 16
    /* 2AF40 8003A740 1A004500 */  div        $zero, $v0, $a1
    /* 2AF44 8003A744 0200A014 */  bnez       $a1, .L8003A750
    /* 2AF48 8003A748 00000000 */   nop
    /* 2AF4C 8003A74C 0D000700 */  break      7
  .L8003A750:
    /* 2AF50 8003A750 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 2AF54 8003A754 0400A114 */  bne        $a1, $at, .L8003A768
    /* 2AF58 8003A758 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 2AF5C 8003A75C 02004114 */  bne        $v0, $at, .L8003A768
    /* 2AF60 8003A760 00000000 */   nop
    /* 2AF64 8003A764 0D000600 */  break      6
  .L8003A768:
    /* 2AF68 8003A768 10880000 */  mfhi       $s1
    /* 2AF6C 8003A76C 14008484 */  lh         $a0, 0x14($a0)
    /* 2AF70 8003A770 43140300 */  sra        $v0, $v1, 17
    /* 2AF74 8003A774 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 2AF78 8003A778 C21F0300 */  srl        $v1, $v1, 31
    /* 2AF7C 8003A77C 2118A300 */  addu       $v1, $a1, $v1
    /* 2AF80 8003A780 43180300 */  sra        $v1, $v1, 1
    /* 2AF84 8003A784 2A187100 */  slt        $v1, $v1, $s1
    /* 2AF88 8003A788 02006010 */  beqz       $v1, .L8003A794
    /* 2AF8C 8003A78C 23904400 */   subu      $s2, $v0, $a0
    /* 2AF90 8003A790 2388B100 */  subu       $s1, $a1, $s1
  .L8003A794:
    /* 2AF94 8003A794 2800023C */  lui        $v0, (0x282828 >> 16)
    /* 2AF98 8003A798 28284234 */  ori        $v0, $v0, (0x282828 & 0xFFFF)
    /* 2AF9C 8003A79C FC020424 */  addiu      $a0, $zero, 0x2FC
    /* 2AFA0 8003A7A0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AFA4 8003A7A4 5C00A2AF */   sw        $v0, 0x5C($sp)
    /* 2AFA8 8003A7A8 28000424 */  addiu      $a0, $zero, 0x28
    /* 2AFAC 8003A7AC 21280000 */  addu       $a1, $zero, $zero
    /* 2AFB0 8003A7B0 21305102 */  addu       $a2, $s2, $s1
    /* 2AFB4 8003A7B4 01004724 */  addiu      $a3, $v0, 0x1
    /* 2AFB8 8003A7B8 5C00C287 */  lh         $v0, 0x5C($fp)
    /* 2AFBC 8003A7BC 01001024 */  addiu      $s0, $zero, 0x1
    /* 2AFC0 8003A7C0 1400B0AF */  sw         $s0, 0x14($sp)
    /* 2AFC4 8003A7C4 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2AFC8 8003A7C8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2AFCC 8003A7CC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 2AFD0 8003A7D0 ACE4020C */  jal        TextSys_WordY__Fi
    /* 2AFD4 8003A7D4 FC020424 */   addiu     $a0, $zero, 0x2FC
    /* 2AFD8 8003A7D8 28000424 */  addiu      $a0, $zero, 0x28
    /* 2AFDC 8003A7DC 21280000 */  addu       $a1, $zero, $zero
    /* 2AFE0 8003A7E0 23305102 */  subu       $a2, $s2, $s1
    /* 2AFE4 8003A7E4 5C00C387 */  lh         $v1, 0x5C($fp)
    /* 2AFE8 8003A7E8 21385000 */  addu       $a3, $v0, $s0
    /* 2AFEC 8003A7EC 1400B0AF */  sw         $s0, 0x14($sp)
    /* 2AFF0 8003A7F0 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2AFF4 8003A7F4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2AFF8 8003A7F8 1000A3AF */   sw        $v1, 0x10($sp)
    /* 2AFFC 8003A7FC 27000424 */  addiu      $a0, $zero, 0x27
    /* 2B000 8003A800 00040524 */  addiu      $a1, $zero, 0x400
    /* 2B004 8003A804 21300000 */  addu       $a2, $zero, $zero
    /* 2B008 8003A808 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 2B00C 8003A80C 5C00C387 */  lh         $v1, 0x5C($fp)
    /* 2B010 8003A810 5800A227 */  addiu      $v0, $sp, 0x58
    /* 2B014 8003A814 1400A0AF */  sw         $zero, 0x14($sp)
    /* 2B018 8003A818 1800A2AF */  sw         $v0, 0x18($sp)
    /* 2B01C 8003A81C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 2B020 8003A820 1000A3AF */   sw        $v1, 0x10($sp)
    /* 2B024 8003A824 2120C003 */  addu       $a0, $fp, $zero
    /* 2B028 8003A828 0A000524 */  addiu      $a1, $zero, 0xA
    /* 2B02C 8003A82C CC17678E */  lw         $a3, %lo(gCurrentShapes)($s3)
    /* 2B030 8003A830 1D000624 */  addiu      $a2, $zero, 0x1D
    /* 2B034 8003A834 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 2B038 8003A838 1000A0AF */   sw        $zero, 0x10($sp)
    /* 2B03C 8003A83C CC00BF8F */  lw         $ra, 0xCC($sp)
    /* 2B040 8003A840 C800BE8F */  lw         $fp, 0xC8($sp)
    /* 2B044 8003A844 C400B78F */  lw         $s7, 0xC4($sp)
    /* 2B048 8003A848 C000B68F */  lw         $s6, 0xC0($sp)
    /* 2B04C 8003A84C BC00B58F */  lw         $s5, 0xBC($sp)
    /* 2B050 8003A850 B800B48F */  lw         $s4, 0xB8($sp)
    /* 2B054 8003A854 B400B38F */  lw         $s3, 0xB4($sp)
    /* 2B058 8003A858 B000B28F */  lw         $s2, 0xB0($sp)
    /* 2B05C 8003A85C AC00B18F */  lw         $s1, 0xAC($sp)
    /* 2B060 8003A860 A800B08F */  lw         $s0, 0xA8($sp)
    /* 2B064 8003A864 0800E003 */  jr         $ra
    /* 2B068 8003A868 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel DrawBackground__24tScreenPinkSlipStandings
