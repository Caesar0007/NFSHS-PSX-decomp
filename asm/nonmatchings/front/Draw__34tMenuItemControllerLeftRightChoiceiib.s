.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__34tMenuItemControllerLeftRightChoiceiib, 0x204

glabel Draw__34tMenuItemControllerLeftRightChoiceiib
    /* F884 8001F084 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* F888 8001F088 4800B4AF */  sw         $s4, 0x48($sp)
    /* F88C 8001F08C 21A08000 */  addu       $s4, $a0, $zero
    /* F890 8001F090 3800B0AF */  sw         $s0, 0x38($sp)
    /* F894 8001F094 2180A000 */  addu       $s0, $a1, $zero
    /* F898 8001F098 5000BFAF */  sw         $ra, 0x50($sp)
    /* F89C 8001F09C 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* F8A0 8001F0A0 4400B3AF */  sw         $s3, 0x44($sp)
    /* F8A4 8001F0A4 4000B2AF */  sw         $s2, 0x40($sp)
    /* F8A8 8001F0A8 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* F8AC 8001F0AC 0400848E */  lw         $a0, 0x4($s4)
    /* F8B0 8001F0B0 A4E4020C */  jal        TextSys_WordX__Fi
    /* F8B4 8001F0B4 2188C000 */   addu      $s1, $a2, $zero
    /* F8B8 8001F0B8 0400848E */  lw         $a0, 0x4($s4)
    /* F8BC 8001F0BC ACE4020C */  jal        TextSys_WordY__Fi
    /* F8C0 8001F0C0 21905000 */   addu      $s2, $v0, $s0
    /* F8C4 8001F0C4 C800043C */  lui        $a0, (0xC83C1E >> 16)
    /* F8C8 8001F0C8 1E3C8434 */  ori        $a0, $a0, (0xC83C1E & 0xFFFF)
    /* F8CC 8001F0CC BEBE0534 */  ori        $a1, $zero, 0xBEBE
    /* F8D0 8001F0D0 0580033C */  lui        $v1, %hi(gHelpShapes)
    /* F8D4 8001F0D4 21985100 */  addu       $s3, $v0, $s1
    /* F8D8 8001F0D8 08008686 */  lh         $a2, 0x8($s4)
    /* F8DC 8001F0DC 642A638C */  lw         $v1, %lo(gHelpShapes)($v1)
    /* F8E0 8001F0E0 20008786 */  lh         $a3, 0x20($s4)
    /* F8E4 8001F0E4 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* F8E8 8001F0E8 C0037524 */   addiu     $s5, $v1, 0x3C0
    /* F8EC 8001F0EC 06000424 */  addiu      $a0, $zero, 0x6
    /* F8F0 8001F0F0 08008586 */  lh         $a1, 0x8($s4)
    /* F8F4 8001F0F4 20008686 */  lh         $a2, 0x20($s4)
    /* F8F8 8001F0F8 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* F8FC 8001F0FC 21804000 */   addu      $s0, $v0, $zero
    /* F900 8001F100 21884000 */  addu       $s1, $v0, $zero
    /* F904 8001F104 20008386 */  lh         $v1, 0x20($s4)
    /* F908 8001F108 80000224 */  addiu      $v0, $zero, 0x80
    /* F90C 8001F10C 24006210 */  beq        $v1, $v0, .L8001F1A0
    /* F910 8001F110 00000000 */   nop
    /* F914 8001F114 2400B0AF */  sw         $s0, 0x24($sp)
    /* F918 8001F118 0400848E */  lw         $a0, 0x4($s4)
    /* F91C 8001F11C 94E4020C */  jal        TextSys_Word__Fi
    /* F920 8001F120 00841300 */   sll       $s0, $s3, 16
    /* F924 8001F124 21204000 */  addu       $a0, $v0, $zero
    /* F928 8001F128 002C1200 */  sll        $a1, $s2, 16
    /* F92C 8001F12C 032C0500 */  sra        $a1, $a1, 16
    /* F930 8001F130 03841000 */  sra        $s0, $s0, 16
    /* F934 8001F134 21300002 */  addu       $a2, $s0, $zero
    /* F938 8001F138 21382002 */  addu       $a3, $s1, $zero
    /* F93C 8001F13C 1000A0AF */  sw         $zero, 0x10($sp)
    /* F940 8001F140 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* F944 8001F144 1400A0AF */   sw        $zero, 0x14($sp)
    /* F948 8001F148 1C00868E */  lw         $a2, 0x1C($s4)
    /* F94C 8001F14C 0580023C */  lui        $v0, %hi(gMenu_SubMenuPlayer)
    /* F950 8001F150 0C00C38C */  lw         $v1, 0xC($a2)
    /* F954 8001F154 C017458C */  lw         $a1, %lo(gMenu_SubMenuPlayer)($v0)
    /* F958 8001F158 18006484 */  lh         $a0, 0x18($v1)
    /* F95C 8001F15C 1C00628C */  lw         $v0, 0x1C($v1)
    /* F960 8001F160 00000000 */  nop
    /* F964 8001F164 09F84000 */  jalr       $v0
    /* F968 8001F168 2120C400 */   addu      $a0, $a2, $a0
    /* F96C 8001F16C 00140200 */  sll        $v0, $v0, 16
    /* F970 8001F170 94E4020C */  jal        TextSys_Word__Fi
    /* F974 8001F174 03240200 */   sra       $a0, $v0, 16
    /* F978 8001F178 21204000 */  addu       $a0, $v0, $zero
    /* F97C 8001F17C 97004526 */  addiu      $a1, $s2, 0x97
    /* F980 8001F180 002C0500 */  sll        $a1, $a1, 16
    /* F984 8001F184 032C0500 */  sra        $a1, $a1, 16
    /* F988 8001F188 21300002 */  addu       $a2, $s0, $zero
    /* F98C 8001F18C 21382002 */  addu       $a3, $s1, $zero
    /* F990 8001F190 02000224 */  addiu      $v0, $zero, 0x2
    /* F994 8001F194 1000A0AF */  sw         $zero, 0x10($sp)
    /* F998 8001F198 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* F99C 8001F19C 1400A2AF */   sw        $v0, 0x14($sp)
  .L8001F1A0:
    /* F9A0 8001F1A0 21200000 */  addu       $a0, $zero, $zero
    /* F9A4 8001F1A4 08008686 */  lh         $a2, 0x8($s4)
    /* F9A8 8001F1A8 20008786 */  lh         $a3, 0x20($s4)
    /* F9AC 8001F1AC 2B2E010C */  jal        CalcFadeVal__Fiiii
    /* F9B0 8001F1B0 BEBE0534 */   ori       $a1, $zero, 0xBEBE
    /* F9B4 8001F1B4 0A000424 */  addiu      $a0, $zero, 0xA
    /* F9B8 8001F1B8 18000524 */  addiu      $a1, $zero, 0x18
    /* F9BC 8001F1BC 008C1200 */  sll        $s1, $s2, 16
    /* F9C0 8001F1C0 038C1100 */  sra        $s1, $s1, 16
    /* F9C4 8001F1C4 83002626 */  addiu      $a2, $s1, 0x83
    /* F9C8 8001F1C8 00841300 */  sll        $s0, $s3, 16
    /* F9CC 8001F1CC 03841000 */  sra        $s0, $s0, 16
    /* F9D0 8001F1D0 21380002 */  addu       $a3, $s0, $zero
    /* F9D4 8001F1D4 01001324 */  addiu      $s3, $zero, 0x1
    /* F9D8 8001F1D8 2000B227 */  addiu      $s2, $sp, 0x20
    /* F9DC 8001F1DC 2400A2AF */  sw         $v0, 0x24($sp)
    /* F9E0 8001F1E0 1000A0AF */  sw         $zero, 0x10($sp)
    /* F9E4 8001F1E4 1400B3AF */  sw         $s3, 0x14($sp)
    /* F9E8 8001F1E8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* F9EC 8001F1EC 1800B2AF */   sw        $s2, 0x18($sp)
    /* F9F0 8001F1F0 0B000424 */  addiu      $a0, $zero, 0xB
    /* F9F4 8001F1F4 18000524 */  addiu      $a1, $zero, 0x18
    /* F9F8 8001F1F8 A1002626 */  addiu      $a2, $s1, 0xA1
    /* F9FC 8001F1FC 21380002 */  addu       $a3, $s0, $zero
    /* FA00 8001F200 1000A0AF */  sw         $zero, 0x10($sp)
    /* FA04 8001F204 1400B3AF */  sw         $s3, 0x14($sp)
    /* FA08 8001F208 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* FA0C 8001F20C 1800B2AF */   sw        $s2, 0x18($sp)
    /* FA10 8001F210 1E000424 */  addiu      $a0, $zero, 0x1E
    /* FA14 8001F214 08000524 */  addiu      $a1, $zero, 0x8
    /* FA18 8001F218 FDFF1026 */  addiu      $s0, $s0, -0x3
    /* FA1C 8001F21C 1000A686 */  lh         $a2, 0x10($s5)
    /* FA20 8001F220 20008286 */  lh         $v0, 0x20($s4)
    /* FA24 8001F224 21380002 */  addu       $a3, $s0, $zero
    /* FA28 8001F228 1400A0AF */  sw         $zero, 0x14($sp)
    /* FA2C 8001F22C 1800A0AF */  sw         $zero, 0x18($sp)
    /* FA30 8001F230 50FFC624 */  addiu      $a2, $a2, -0xB0
    /* FA34 8001F234 23302602 */  subu       $a2, $s1, $a2
    /* FA38 8001F238 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* FA3C 8001F23C 1000A2AF */   sw        $v0, 0x10($sp)
    /* FA40 8001F240 21200000 */  addu       $a0, $zero, $zero
    /* FA44 8001F244 21282002 */  addu       $a1, $s1, $zero
    /* FA48 8001F248 21300002 */  addu       $a2, $s0, $zero
    /* FA4C 8001F24C B0000324 */  addiu      $v1, $zero, 0xB0
    /* FA50 8001F250 1000A786 */  lh         $a3, 0x10($s5)
    /* FA54 8001F254 1200A286 */  lh         $v0, 0x12($s5)
    /* FA58 8001F258 23386700 */  subu       $a3, $v1, $a3
    /* FA5C 8001F25C 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* FA60 8001F260 1000A2AF */   sw        $v0, 0x10($sp)
    /* FA64 8001F264 5000BF8F */  lw         $ra, 0x50($sp)
    /* FA68 8001F268 4C00B58F */  lw         $s5, 0x4C($sp)
    /* FA6C 8001F26C 4800B48F */  lw         $s4, 0x48($sp)
    /* FA70 8001F270 4400B38F */  lw         $s3, 0x44($sp)
    /* FA74 8001F274 4000B28F */  lw         $s2, 0x40($sp)
    /* FA78 8001F278 3C00B18F */  lw         $s1, 0x3C($sp)
    /* FA7C 8001F27C 3800B08F */  lw         $s0, 0x38($sp)
    /* FA80 8001F280 0800E003 */  jr         $ra
    /* FA84 8001F284 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Draw__34tMenuItemControllerLeftRightChoiceiib
