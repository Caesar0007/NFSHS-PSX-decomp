.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__20tMenuItemSlidingMenuiib, 0x644

glabel Draw__20tMenuItemSlidingMenuiib
    /* DE3C 8001D63C 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* DE40 8001D640 6800B6AF */  sw         $s6, 0x68($sp)
    /* DE44 8001D644 21B08000 */  addu       $s6, $a0, $zero
    /* DE48 8001D648 5000B0AF */  sw         $s0, 0x50($sp)
    /* DE4C 8001D64C 2180A000 */  addu       $s0, $a1, $zero
    /* DE50 8001D650 5400B1AF */  sw         $s1, 0x54($sp)
    /* DE54 8001D654 2188C000 */  addu       $s1, $a2, $zero
    /* DE58 8001D658 7400BFAF */  sw         $ra, 0x74($sp)
    /* DE5C 8001D65C 7000BEAF */  sw         $fp, 0x70($sp)
    /* DE60 8001D660 6C00B7AF */  sw         $s7, 0x6C($sp)
    /* DE64 8001D664 6400B5AF */  sw         $s5, 0x64($sp)
    /* DE68 8001D668 6000B4AF */  sw         $s4, 0x60($sp)
    /* DE6C 8001D66C 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* DE70 8001D670 5800B2AF */  sw         $s2, 0x58($sp)
    /* DE74 8001D674 1800C28E */  lw         $v0, 0x18($s6)
    /* DE78 8001D678 2128E000 */  addu       $a1, $a3, $zero
    /* DE7C 8001D67C 58004484 */  lh         $a0, 0x58($v0)
    /* DE80 8001D680 5C00428C */  lw         $v0, 0x5C($v0)
    /* DE84 8001D684 00000000 */  nop
    /* DE88 8001D688 09F84000 */  jalr       $v0
    /* DE8C 8001D68C 2120C402 */   addu      $a0, $s6, $a0
    /* DE90 8001D690 0800C586 */  lh         $a1, 0x8($s6)
    /* DE94 8001D694 2C00C686 */  lh         $a2, 0x2C($s6)
    /* DE98 8001D698 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* DE9C 8001D69C 06000424 */   addiu     $a0, $zero, 0x6
    /* DEA0 8001D6A0 0400C48E */  lw         $a0, 0x4($s6)
    /* DEA4 8001D6A4 A4E4020C */  jal        TextSys_WordX__Fi
    /* DEA8 8001D6A8 3800A2AF */   sw        $v0, 0x38($sp)
    /* DEAC 8001D6AC 0400C48E */  lw         $a0, 0x4($s6)
    /* DEB0 8001D6B0 21105000 */  addu       $v0, $v0, $s0
    /* DEB4 8001D6B4 ACE4020C */  jal        TextSys_WordY__Fi
    /* DEB8 8001D6B8 3C00A2AF */   sw        $v0, 0x3C($sp)
    /* DEBC 8001D6BC 0580043C */  lui        $a0, %hi(fHelpText)
    /* DEC0 8001D6C0 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* DEC4 8001D6C4 B01583AC */  sw         $v1, %lo(fHelpText)($a0)
    /* DEC8 8001D6C8 0580033C */  lui        $v1, %hi(gHelpShapes)
    /* DECC 8001D6CC 21105100 */  addu       $v0, $v0, $s1
    /* DED0 8001D6D0 4000A2AF */  sw         $v0, 0x40($sp)
    /* DED4 8001D6D4 0580023C */  lui        $v0, %hi(menuDefs)
    /* DED8 8001D6D8 642A638C */  lw         $v1, %lo(gHelpShapes)($v1)
    /* DEDC 8001D6DC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* DEE0 8001D6E0 C0036324 */  addiu      $v1, $v1, 0x3C0
    /* DEE4 8001D6E4 4400A3AF */  sw         $v1, 0x44($sp)
    /* DEE8 8001D6E8 1C00C38E */  lw         $v1, 0x1C($s6)
    /* DEEC 8001D6EC 58274224 */  addiu      $v0, $v0, 0x2758
    /* DEF0 8001D6F0 26186200 */  xor        $v1, $v1, $v0
    /* DEF4 8001D6F4 0100632C */  sltiu      $v1, $v1, 0x1
    /* DEF8 8001D6F8 4800A3AF */  sw         $v1, 0x48($sp)
    /* DEFC 8001D6FC 2C00C686 */  lh         $a2, 0x2C($s6)
    /* DF00 8001D700 80000224 */  addiu      $v0, $zero, 0x80
    /* DF04 8001D704 0800C210 */  beq        $a2, $v0, .L8001D728
    /* DF08 8001D708 00000000 */   nop
    /* DF0C 8001D70C 06006010 */  beqz       $v1, .L8001D728
    /* DF10 8001D710 00000000 */   nop
    /* DF14 8001D714 0580073C */  lui        $a3, %hi(D_800515A8)
    /* DF18 8001D718 4000A48F */  lw         $a0, 0x40($sp)
    /* DF1C 8001D71C 0800C586 */  lh         $a1, 0x8($s6)
    /* DF20 8001D720 E86F000C */  jal        DrawLeftFlare__FiiiRi
    /* DF24 8001D724 A815E724 */   addiu     $a3, $a3, %lo(D_800515A8)
  .L8001D728:
    /* DF28 8001D728 1C00C28E */  lw         $v0, 0x1C($s6)
    /* DF2C 8001D72C 00000000 */  nop
    /* DF30 8001D730 05004014 */  bnez       $v0, .L8001D748
    /* DF34 8001D734 00000000 */   nop
    /* DF38 8001D738 4800AA8F */  lw         $t2, 0x48($sp)
    /* DF3C 8001D73C 00000000 */  nop
    /* DF40 8001D740 39004011 */  beqz       $t2, .L8001D828
    /* DF44 8001D744 00000000 */   nop
  .L8001D748:
    /* DF48 8001D748 4800AA8F */  lw         $t2, 0x48($sp)
    /* DF4C 8001D74C 00000000 */  nop
    /* DF50 8001D750 02004015 */  bnez       $t2, .L8001D75C
    /* DF54 8001D754 DC001024 */   addiu     $s0, $zero, 0xDC
    /* DF58 8001D758 2400D086 */  lh         $s0, 0x24($s6)
  .L8001D75C:
    /* DF5C 8001D75C 21200000 */  addu       $a0, $zero, $zero
    /* DF60 8001D760 0800C686 */  lh         $a2, 0x8($s6)
    /* DF64 8001D764 2C00C786 */  lh         $a3, 0x2C($s6)
    /* DF68 8001D768 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* DF6C 8001D76C BEBE0534 */   ori       $a1, $zero, 0xBEBE
    /* DF70 8001D770 4000AA8F */  lw         $t2, 0x40($sp)
    /* DF74 8001D774 00000000 */  nop
    /* DF78 8001D778 FEFF4725 */  addiu      $a3, $t2, -0x2
    /* DF7C 8001D77C 4400AA8F */  lw         $t2, 0x44($sp)
    /* DF80 8001D780 2400A2AF */  sw         $v0, 0x24($sp)
    /* DF84 8001D784 10004285 */  lh         $v0, 0x10($t2)
    /* DF88 8001D788 3C00AA8F */  lw         $t2, 0x3C($sp)
    /* DF8C 8001D78C 00000000 */  nop
    /* DF90 8001D790 21885001 */  addu       $s1, $t2, $s0
    /* DF94 8001D794 23102202 */  subu       $v0, $s1, $v0
    /* DF98 8001D798 4800AA8F */  lw         $t2, 0x48($sp)
    /* DF9C 8001D79C 00000000 */  nop
    /* DFA0 8001D7A0 04004011 */  beqz       $t2, .L8001D7B4
    /* DFA4 8001D7A4 F6FF4624 */   addiu     $a2, $v0, -0xA
    /* DFA8 8001D7A8 4000AA8F */  lw         $t2, 0x40($sp)
    /* DFAC 8001D7AC 00000000 */  nop
    /* DFB0 8001D7B0 FDFF4725 */  addiu      $a3, $t2, -0x3
  .L8001D7B4:
    /* DFB4 8001D7B4 39000424 */  addiu      $a0, $zero, 0x39
    /* DFB8 8001D7B8 18000524 */  addiu      $a1, $zero, 0x18
    /* DFBC 8001D7BC 01001224 */  addiu      $s2, $zero, 0x1
    /* DFC0 8001D7C0 2000B027 */  addiu      $s0, $sp, 0x20
    /* DFC4 8001D7C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* DFC8 8001D7C8 1400B2AF */  sw         $s2, 0x14($sp)
    /* DFCC 8001D7CC 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* DFD0 8001D7D0 1800B0AF */   sw        $s0, 0x18($sp)
    /* DFD4 8001D7D4 4400AA8F */  lw         $t2, 0x44($sp)
    /* DFD8 8001D7D8 00000000 */  nop
    /* DFDC 8001D7DC 10004285 */  lh         $v0, 0x10($t2)
    /* DFE0 8001D7E0 4000AA8F */  lw         $t2, 0x40($sp)
    /* DFE4 8001D7E4 00000000 */  nop
    /* DFE8 8001D7E8 04004725 */  addiu      $a3, $t2, 0x4
    /* DFEC 8001D7EC 23102202 */  subu       $v0, $s1, $v0
    /* DFF0 8001D7F0 4800AA8F */  lw         $t2, 0x48($sp)
    /* DFF4 8001D7F4 00000000 */  nop
    /* DFF8 8001D7F8 04004011 */  beqz       $t2, .L8001D80C
    /* DFFC 8001D7FC F6FF4624 */   addiu     $a2, $v0, -0xA
    /* E000 8001D800 4000AA8F */  lw         $t2, 0x40($sp)
    /* E004 8001D804 00000000 */  nop
    /* E008 8001D808 03004725 */  addiu      $a3, $t2, 0x3
  .L8001D80C:
    /* E00C 8001D80C 3A000424 */  addiu      $a0, $zero, 0x3A
    /* E010 8001D810 18000524 */  addiu      $a1, $zero, 0x18
    /* E014 8001D814 1000A0AF */  sw         $zero, 0x10($sp)
    /* E018 8001D818 1400B2AF */  sw         $s2, 0x14($sp)
    /* E01C 8001D81C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E020 8001D820 1800B0AF */   sw        $s0, 0x18($sp)
    /* E024 8001D824 1C00C28E */  lw         $v0, 0x1C($s6)
  .L8001D828:
    /* E028 8001D828 00000000 */  nop
    /* E02C 8001D82C 08014010 */  beqz       $v0, .L8001DC50
    /* E030 8001D830 5000113C */   lui       $s1, (0x505050 >> 16)
    /* E034 8001D834 50503136 */  ori        $s1, $s1, (0x505050 & 0xFFFF)
    /* E038 8001D838 1480023C */  lui        $v0, %hi(Draw_gPlayer1View)
    /* E03C 8001D83C CCD3448C */  lw         $a0, %lo(Draw_gPlayer1View)($v0)
    /* E040 8001D840 1480023C */  lui        $v0, %hi(gFlip)
    /* E044 8001D844 3C00C386 */  lh         $v1, 0x3C($s6)
    /* E048 8001D848 B4D7458C */  lw         $a1, %lo(gFlip)($v0)
    /* E04C 8001D84C 3C00AA8F */  lw         $t2, 0x3C($sp)
    /* E050 8001D850 3E00C286 */  lh         $v0, 0x3E($s6)
    /* E054 8001D854 2800D296 */  lhu        $s2, 0x28($s6)
    /* E058 8001D858 2400DE86 */  lh         $fp, 0x24($s6)
    /* E05C 8001D85C 21A04301 */  addu       $s4, $t2, $v1
    /* E060 8001D860 4000AA8F */  lw         $t2, 0x40($sp)
    /* E064 8001D864 00941200 */  sll        $s2, $s2, 16
    /* E068 8001D868 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* E06C 8001D86C 21A84201 */   addu      $s5, $t2, $v0
    /* E070 8001D870 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* E074 8001D874 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* E078 8001D878 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* E07C 8001D87C FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* E080 8001D880 0000248D */  lw         $a0, 0x0($t1)
    /* E084 8001D884 2000A527 */  addiu      $a1, $sp, 0x20
    /* E088 8001D888 2000A0A7 */  sh         $zero, 0x20($sp)
    /* E08C 8001D88C 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* E090 8001D890 02004394 */  lhu        $v1, 0x2($v0)
    /* E094 8001D894 00020224 */  addiu      $v0, $zero, 0x200
    /* E098 8001D898 2400A2A7 */  sh         $v0, 0x24($sp)
    /* E09C 8001D89C 1480023C */  lui        $v0, %hi(screenheight)
    /* E0A0 8001D8A0 8CDC4294 */  lhu        $v0, %lo(screenheight)($v0)
    /* E0A4 8001D8A4 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* E0A8 8001D8A8 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* E0AC 8001D8AC 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* E0B0 8001D8B0 2200A3A7 */  sh         $v1, 0x22($sp)
    /* E0B4 8001D8B4 2600A2A7 */  sh         $v0, 0x26($sp)
    /* E0B8 8001D8B8 0000838C */  lw         $v1, 0x0($a0)
    /* E0BC 8001D8BC 0000C28C */  lw         $v0, 0x0($a2)
    /* E0C0 8001D8C0 24186800 */  and        $v1, $v1, $t0
    /* E0C4 8001D8C4 24104700 */  and        $v0, $v0, $a3
    /* E0C8 8001D8C8 25186200 */  or         $v1, $v1, $v0
    /* E0CC 8001D8CC 000083AC */  sw         $v1, 0x0($a0)
    /* E0D0 8001D8D0 0000C28C */  lw         $v0, 0x0($a2)
    /* E0D4 8001D8D4 0C008324 */  addiu      $v1, $a0, 0xC
    /* E0D8 8001D8D8 000023AD */  sw         $v1, 0x0($t1)
    /* E0DC 8001D8DC 24188700 */  and        $v1, $a0, $a3
    /* E0E0 8001D8E0 24104800 */  and        $v0, $v0, $t0
    /* E0E4 8001D8E4 25104300 */  or         $v0, $v0, $v1
    /* E0E8 8001D8E8 C5B8030C */  jal        SetDrawArea
    /* E0EC 8001D8EC 0000C2AC */   sw        $v0, 0x0($a2)
    /* E0F0 8001D8F0 21208002 */  addu       $a0, $s4, $zero
    /* E0F4 8001D8F4 2128A002 */  addu       $a1, $s5, $zero
    /* E0F8 8001D8F8 2130C003 */  addu       $a2, $fp, $zero
    /* E0FC 8001D8FC 43841200 */  sra        $s0, $s2, 17
    /* E100 8001D900 21380002 */  addu       $a3, $s0, $zero
    /* E104 8001D904 1000B1AF */  sw         $s1, 0x10($sp)
    /* E108 8001D908 1400B1AF */  sw         $s1, 0x14($sp)
    /* E10C 8001D90C 1800A0AF */  sw         $zero, 0x18($sp)
    /* E110 8001D910 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* E114 8001D914 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* E118 8001D918 21208002 */  addu       $a0, $s4, $zero
    /* E11C 8001D91C 2128B002 */  addu       $a1, $s5, $s0
    /* E120 8001D920 2130C003 */  addu       $a2, $fp, $zero
    /* E124 8001D924 21380002 */  addu       $a3, $s0, $zero
    /* E128 8001D928 1000A0AF */  sw         $zero, 0x10($sp)
    /* E12C 8001D92C 1400A0AF */  sw         $zero, 0x14($sp)
    /* E130 8001D930 1800B1AF */  sw         $s1, 0x18($sp)
    /* E134 8001D934 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* E138 8001D938 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* E13C 8001D93C 002C1400 */  sll        $a1, $s4, 16
    /* E140 8001D940 032C0500 */  sra        $a1, $a1, 16
    /* E144 8001D944 00341500 */  sll        $a2, $s5, 16
    /* E148 8001D948 03340600 */  sra        $a2, $a2, 16
    /* E14C 8001D94C 2138C003 */  addu       $a3, $fp, $zero
    /* E150 8001D950 1C00C88E */  lw         $t0, 0x1C($s6)
    /* E154 8001D954 2A00C296 */  lhu        $v0, 0x2A($s6)
    /* E158 8001D958 6800098D */  lw         $t1, 0x68($t0)
    /* E15C 8001D95C 40140200 */  sll        $v0, $v0, 17
    /* E160 8001D960 58002485 */  lh         $a0, 0x58($t1)
    /* E164 8001D964 03140200 */  sra        $v0, $v0, 16
    /* E168 8001D968 1000A2AF */  sw         $v0, 0x10($sp)
    /* E16C 8001D96C 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* E170 8001D970 642A438C */  lw         $v1, %lo(gHelpShapes)($v0)
    /* E174 8001D974 2600C286 */  lh         $v0, 0x26($s6)
    /* E178 8001D978 21200401 */  addu       $a0, $t0, $a0
    /* E17C 8001D97C E0037724 */  addiu      $s7, $v1, 0x3E0
    /* E180 8001D980 1400A2AF */  sw         $v0, 0x14($sp)
    /* E184 8001D984 5C00228D */  lw         $v0, 0x5C($t1)
    /* E188 8001D988 00000000 */  nop
    /* E18C 8001D98C 09F84000 */  jalr       $v0
    /* E190 8001D990 00047324 */   addiu     $s3, $v1, 0x400
    /* E194 8001D994 4000C28E */  lw         $v0, 0x40($s6)
    /* E198 8001D998 00000000 */  nop
    /* E19C 8001D99C 2B004010 */  beqz       $v0, .L8001DA4C
    /* E1A0 8001D9A0 03941200 */   sra       $s2, $s2, 16
    /* E1A4 8001D9A4 1200E286 */  lh         $v0, 0x12($s7)
    /* E1A8 8001D9A8 00000000 */  nop
    /* E1AC 8001D9AC 2A105200 */  slt        $v0, $v0, $s2
    /* E1B0 8001D9B0 26004010 */  beqz       $v0, .L8001DA4C
    /* E1B4 8001D9B4 1F000424 */   addiu     $a0, $zero, 0x1F
    /* E1B8 8001D9B8 0C000524 */  addiu      $a1, $zero, 0xC
    /* E1BC 8001D9BC 21308002 */  addu       $a2, $s4, $zero
    /* E1C0 8001D9C0 2138A002 */  addu       $a3, $s5, $zero
    /* E1C4 8001D9C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* E1C8 8001D9C8 1400A0AF */  sw         $zero, 0x14($sp)
    /* E1CC 8001D9CC 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E1D0 8001D9D0 1800A0AF */   sw        $zero, 0x18($sp)
    /* E1D4 8001D9D4 1F000424 */  addiu      $a0, $zero, 0x1F
    /* E1D8 8001D9D8 08000524 */  addiu      $a1, $zero, 0x8
    /* E1DC 8001D9DC 2138A002 */  addu       $a3, $s5, $zero
    /* E1E0 8001D9E0 1000E686 */  lh         $a2, 0x10($s7)
    /* E1E4 8001D9E4 21889E02 */  addu       $s1, $s4, $fp
    /* E1E8 8001D9E8 1000A0AF */  sw         $zero, 0x10($sp)
    /* E1EC 8001D9EC 1400A0AF */  sw         $zero, 0x14($sp)
    /* E1F0 8001D9F0 1800A0AF */  sw         $zero, 0x18($sp)
    /* E1F4 8001D9F4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E1F8 8001D9F8 23302602 */   subu      $a2, $s1, $a2
    /* E1FC 8001D9FC 20000424 */  addiu      $a0, $zero, 0x20
    /* E200 8001DA00 0C000524 */  addiu      $a1, $zero, 0xC
    /* E204 8001DA04 21308002 */  addu       $a2, $s4, $zero
    /* E208 8001DA08 12006786 */  lh         $a3, 0x12($s3)
    /* E20C 8001DA0C 2180B202 */  addu       $s0, $s5, $s2
    /* E210 8001DA10 1000A0AF */  sw         $zero, 0x10($sp)
    /* E214 8001DA14 1400A0AF */  sw         $zero, 0x14($sp)
    /* E218 8001DA18 1800A0AF */  sw         $zero, 0x18($sp)
    /* E21C 8001DA1C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E220 8001DA20 23380702 */   subu      $a3, $s0, $a3
    /* E224 8001DA24 20000424 */  addiu      $a0, $zero, 0x20
    /* E228 8001DA28 10006686 */  lh         $a2, 0x10($s3)
    /* E22C 8001DA2C 12006786 */  lh         $a3, 0x12($s3)
    /* E230 8001DA30 08000524 */  addiu      $a1, $zero, 0x8
    /* E234 8001DA34 1000A0AF */  sw         $zero, 0x10($sp)
    /* E238 8001DA38 1400A0AF */  sw         $zero, 0x14($sp)
    /* E23C 8001DA3C 1800A0AF */  sw         $zero, 0x18($sp)
    /* E240 8001DA40 23302602 */  subu       $a2, $s1, $a2
    /* E244 8001DA44 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E248 8001DA48 23380702 */   subu      $a3, $s0, $a3
  .L8001DA4C:
    /* E24C 8001DA4C 21200000 */  addu       $a0, $zero, $zero
    /* E250 8001DA50 1000E786 */  lh         $a3, 0x10($s7)
    /* E254 8001DA54 10006286 */  lh         $v0, 0x10($s3)
    /* E258 8001DA58 2130A002 */  addu       $a2, $s5, $zero
    /* E25C 8001DA5C 1000B2AF */  sw         $s2, 0x10($sp)
    /* E260 8001DA60 21288702 */  addu       $a1, $s4, $a3
    /* E264 8001DA64 0500A524 */  addiu      $a1, $a1, 0x5
    /* E268 8001DA68 2338C703 */  subu       $a3, $fp, $a3
    /* E26C 8001DA6C 2338E200 */  subu       $a3, $a3, $v0
    /* E270 8001DA70 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* E274 8001DA74 F6FFE724 */   addiu     $a3, $a3, -0xA
    /* E278 8001DA78 1200E386 */  lh         $v1, 0x12($s7)
    /* E27C 8001DA7C 12006486 */  lh         $a0, 0x12($s3)
    /* E280 8001DA80 00000000 */  nop
    /* E284 8001DA84 21106400 */  addu       $v0, $v1, $a0
    /* E288 8001DA88 2A105200 */  slt        $v0, $v0, $s2
    /* E28C 8001DA8C 08004010 */  beqz       $v0, .L8001DAB0
    /* E290 8001DA90 23104302 */   subu      $v0, $s2, $v1
    /* E294 8001DA94 23104400 */  subu       $v0, $v0, $a0
    /* E298 8001DA98 1000A2AF */  sw         $v0, 0x10($sp)
    /* E29C 8001DA9C 21200000 */  addu       $a0, $zero, $zero
    /* E2A0 8001DAA0 21288002 */  addu       $a1, $s4, $zero
    /* E2A4 8001DAA4 2130A302 */  addu       $a2, $s5, $v1
    /* E2A8 8001DAA8 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* E2AC 8001DAAC 2138C003 */   addu      $a3, $fp, $zero
  .L8001DAB0:
    /* E2B0 8001DAB0 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* E2B4 8001DAB4 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* E2B8 8001DAB8 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* E2BC 8001DABC FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* E2C0 8001DAC0 0000248D */  lw         $a0, 0x0($t1)
    /* E2C4 8001DAC4 4C00AA8F */  lw         $t2, 0x4C($sp)
    /* E2C8 8001DAC8 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* E2CC 8001DACC 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* E2D0 8001DAD0 2800A527 */  addiu      $a1, $sp, 0x28
    /* E2D4 8001DAD4 2800B4A7 */  sh         $s4, 0x28($sp)
    /* E2D8 8001DAD8 02004295 */  lhu        $v0, 0x2($t2)
    /* E2DC 8001DADC 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* E2E0 8001DAE0 2C00BEA7 */  sh         $fp, 0x2C($sp)
    /* E2E4 8001DAE4 2E00B2A7 */  sh         $s2, 0x2E($sp)
    /* E2E8 8001DAE8 21105500 */  addu       $v0, $v0, $s5
    /* E2EC 8001DAEC 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* E2F0 8001DAF0 0000838C */  lw         $v1, 0x0($a0)
    /* E2F4 8001DAF4 0000C28C */  lw         $v0, 0x0($a2)
    /* E2F8 8001DAF8 24186800 */  and        $v1, $v1, $t0
    /* E2FC 8001DAFC 24104700 */  and        $v0, $v0, $a3
    /* E300 8001DB00 25186200 */  or         $v1, $v1, $v0
    /* E304 8001DB04 000083AC */  sw         $v1, 0x0($a0)
    /* E308 8001DB08 0000C28C */  lw         $v0, 0x0($a2)
    /* E30C 8001DB0C 0C008324 */  addiu      $v1, $a0, 0xC
    /* E310 8001DB10 000023AD */  sw         $v1, 0x0($t1)
    /* E314 8001DB14 24188700 */  and        $v1, $a0, $a3
    /* E318 8001DB18 24104800 */  and        $v0, $v0, $t0
    /* E31C 8001DB1C 25104300 */  or         $v0, $v0, $v1
    /* E320 8001DB20 C5B8030C */  jal        SetDrawArea
    /* E324 8001DB24 0000C2AC */   sw        $v0, 0x0($a2)
    /* E328 8001DB28 0580103C */  lui        $s0, %hi(fHelpText)
    /* E32C 8001DB2C B015048E */  lw         $a0, %lo(fHelpText)($s0)
    /* E330 8001DB30 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* E334 8001DB34 14008210 */  beq        $a0, $v0, .L8001DB88
    /* E338 8001DB38 00000000 */   nop
    /* E33C 8001DB3C 94E4020C */  jal        TextSys_Word__Fi
    /* E340 8001DB40 00000000 */   nop
    /* E344 8001DB44 B015048E */  lw         $a0, %lo(fHelpText)($s0)
    /* E348 8001DB48 A4E4020C */  jal        TextSys_WordX__Fi
    /* E34C 8001DB4C 21884000 */   addu      $s1, $v0, $zero
    /* E350 8001DB50 B015048E */  lw         $a0, %lo(fHelpText)($s0)
    /* E354 8001DB54 00840200 */  sll        $s0, $v0, 16
    /* E358 8001DB58 ACE4020C */  jal        TextSys_WordY__Fi
    /* E35C 8001DB5C 03841000 */   sra       $s0, $s0, 16
    /* E360 8001DB60 21202002 */  addu       $a0, $s1, $zero
    /* E364 8001DB64 21280002 */  addu       $a1, $s0, $zero
    /* E368 8001DB68 0580033C */  lui        $v1, %hi(PulsateYellow)
    /* E36C 8001DB6C 00140200 */  sll        $v0, $v0, 16
    /* E370 8001DB70 03340200 */  sra        $a2, $v0, 16
    /* E374 8001DB74 AC15678C */  lw         $a3, %lo(PulsateYellow)($v1)
    /* E378 8001DB78 02000224 */  addiu      $v0, $zero, 0x2
    /* E37C 8001DB7C 1000A0AF */  sw         $zero, 0x10($sp)
    /* E380 8001DB80 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* E384 8001DB84 1400A2AF */   sw        $v0, 0x14($sp)
  .L8001DB88:
    /* E388 8001DB88 0400C48E */  lw         $a0, 0x4($s6)
    /* E38C 8001DB8C 94E4020C */  jal        TextSys_Word__Fi
    /* E390 8001DB90 00000000 */   nop
    /* E394 8001DB94 3C00AA8F */  lw         $t2, 0x3C($sp)
    /* E398 8001DB98 21204000 */  addu       $a0, $v0, $zero
    /* E39C 8001DB9C 1000A0AF */  sw         $zero, 0x10($sp)
    /* E3A0 8001DBA0 00140A00 */  sll        $v0, $t2, 16
    /* E3A4 8001DBA4 4000AA8F */  lw         $t2, 0x40($sp)
    /* E3A8 8001DBA8 032C0200 */  sra        $a1, $v0, 16
    /* E3AC 8001DBAC 00140A00 */  sll        $v0, $t2, 16
    /* E3B0 8001DBB0 4800AA8F */  lw         $t2, 0x48($sp)
    /* E3B4 8001DBB4 00000000 */  nop
    /* E3B8 8001DBB8 04004011 */  beqz       $t2, .L8001DBCC
    /* E3BC 8001DBBC 03340200 */   sra       $a2, $v0, 16
    /* E3C0 8001DBC0 01000224 */  addiu      $v0, $zero, 0x1
    /* E3C4 8001DBC4 F4760008 */  j          .L8001DBD0
    /* E3C8 8001DBC8 1400A2AF */   sw        $v0, 0x14($sp)
  .L8001DBCC:
    /* E3CC 8001DBCC 1400A0AF */  sw         $zero, 0x14($sp)
  .L8001DBD0:
    /* E3D0 8001DBD0 3800A78F */  lw         $a3, 0x38($sp)
    /* E3D4 8001DBD4 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* E3D8 8001DBD8 00000000 */   nop
    /* E3DC 8001DBDC 1E000424 */  addiu      $a0, $zero, 0x1E
    /* E3E0 8001DBE0 08000524 */  addiu      $a1, $zero, 0x8
    /* E3E4 8001DBE4 4000AA8F */  lw         $t2, 0x40($sp)
    /* E3E8 8001DBE8 2400C686 */  lh         $a2, 0x24($s6)
    /* E3EC 8001DBEC FEFF5025 */  addiu      $s0, $t2, -0x2
    /* E3F0 8001DBF0 4400AA8F */  lw         $t2, 0x44($sp)
    /* E3F4 8001DBF4 2C00C386 */  lh         $v1, 0x2C($s6)
    /* E3F8 8001DBF8 10004285 */  lh         $v0, 0x10($t2)
    /* E3FC 8001DBFC 3C00AA8F */  lw         $t2, 0x3C($sp)
    /* E400 8001DC00 21380002 */  addu       $a3, $s0, $zero
    /* E404 8001DC04 1400A0AF */  sw         $zero, 0x14($sp)
    /* E408 8001DC08 1800A0AF */  sw         $zero, 0x18($sp)
    /* E40C 8001DC0C 1000A3AF */  sw         $v1, 0x10($sp)
    /* E410 8001DC10 21304601 */  addu       $a2, $t2, $a2
    /* E414 8001DC14 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* E418 8001DC18 2330C200 */   subu      $a2, $a2, $v0
    /* E41C 8001DC1C 4000C28E */  lw         $v0, 0x40($s6)
    /* E420 8001DC20 00000000 */  nop
    /* E424 8001DC24 0A004010 */  beqz       $v0, .L8001DC50
    /* E428 8001DC28 21200000 */   addu      $a0, $zero, $zero
    /* E42C 8001DC2C 21300002 */  addu       $a2, $s0, $zero
    /* E430 8001DC30 3C00A58F */  lw         $a1, 0x3C($sp)
    /* E434 8001DC34 4400AA8F */  lw         $t2, 0x44($sp)
    /* E438 8001DC38 2400C286 */  lh         $v0, 0x24($s6)
    /* E43C 8001DC3C 10004785 */  lh         $a3, 0x10($t2)
    /* E440 8001DC40 12004385 */  lh         $v1, 0x12($t2)
    /* E444 8001DC44 23384700 */  subu       $a3, $v0, $a3
    /* E448 8001DC48 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* E44C 8001DC4C 1000A3AF */   sw        $v1, 0x10($sp)
  .L8001DC50:
    /* E450 8001DC50 7400BF8F */  lw         $ra, 0x74($sp)
    /* E454 8001DC54 7000BE8F */  lw         $fp, 0x70($sp)
    /* E458 8001DC58 6C00B78F */  lw         $s7, 0x6C($sp)
    /* E45C 8001DC5C 6800B68F */  lw         $s6, 0x68($sp)
    /* E460 8001DC60 6400B58F */  lw         $s5, 0x64($sp)
    /* E464 8001DC64 6000B48F */  lw         $s4, 0x60($sp)
    /* E468 8001DC68 5C00B38F */  lw         $s3, 0x5C($sp)
    /* E46C 8001DC6C 5800B28F */  lw         $s2, 0x58($sp)
    /* E470 8001DC70 5400B18F */  lw         $s1, 0x54($sp)
    /* E474 8001DC74 5000B08F */  lw         $s0, 0x50($sp)
    /* E478 8001DC78 0800E003 */  jr         $ra
    /* E47C 8001DC7C 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel Draw__20tMenuItemSlidingMenuiib
