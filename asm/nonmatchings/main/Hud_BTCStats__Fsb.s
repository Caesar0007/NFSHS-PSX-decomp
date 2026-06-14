.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BTCStats__Fsb, 0x764

glabel Hud_BTCStats__Fsb
    /* CAF28 800DA728 58FFBD27 */  addiu      $sp, $sp, -0xA8
    /* CAF2C 800DA72C 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* CAF30 800DA730 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* CAF34 800DA734 21188000 */  addu       $v1, $a0, $zero
    /* CAF38 800DA738 A000BEAF */  sw         $fp, 0xA0($sp)
    /* CAF3C 800DA73C 21F00000 */  addu       $fp, $zero, $zero
    /* CAF40 800DA740 9000B4AF */  sw         $s4, 0x90($sp)
    /* CAF44 800DA744 21A0C003 */  addu       $s4, $fp, $zero
    /* CAF48 800DA748 A400BFAF */  sw         $ra, 0xA4($sp)
    /* CAF4C 800DA74C 9C00B7AF */  sw         $s7, 0x9C($sp)
    /* CAF50 800DA750 9800B6AF */  sw         $s6, 0x98($sp)
    /* CAF54 800DA754 9400B5AF */  sw         $s5, 0x94($sp)
    /* CAF58 800DA758 8C00B3AF */  sw         $s3, 0x8C($sp)
    /* CAF5C 800DA75C 8800B2AF */  sw         $s2, 0x88($sp)
    /* CAF60 800DA760 8400B1AF */  sw         $s1, 0x84($sp)
    /* CAF64 800DA764 8000B0AF */  sw         $s0, 0x80($sp)
    /* CAF68 800DA768 AC00A5AF */  sw         $a1, 0xAC($sp)
    /* CAF6C 800DA76C 02004228 */  slti       $v0, $v0, 0x2
    /* CAF70 800DA770 13004014 */  bnez       $v0, .L800DA7C0
    /* CAF74 800DA774 5000A3A7 */   sh        $v1, 0x50($sp)
    /* CAF78 800DA778 1180043C */  lui        $a0, %hi(Cars_gHumanRaceCarList)
    /* CAF7C 800DA77C 48FA8424 */  addiu      $a0, $a0, %lo(Cars_gHumanRaceCarList)
    /* CAF80 800DA780 001C0300 */  sll        $v1, $v1, 16
    /* CAF84 800DA784 031C0300 */  sra        $v1, $v1, 16
    /* CAF88 800DA788 01000224 */  addiu      $v0, $zero, 0x1
    /* CAF8C 800DA78C 23104300 */  subu       $v0, $v0, $v1
    /* CAF90 800DA790 80100200 */  sll        $v0, $v0, 2
    /* CAF94 800DA794 21104400 */  addu       $v0, $v0, $a0
    /* CAF98 800DA798 0000428C */  lw         $v0, 0x0($v0)
    /* CAF9C 800DA79C 00000000 */  nop
    /* CAFA0 800DA7A0 6002428C */  lw         $v0, 0x260($v0)
    /* CAFA4 800DA7A4 00000000 */  nop
    /* CAFA8 800DA7A8 00024230 */  andi       $v0, $v0, 0x200
    /* CAFAC 800DA7AC 03004014 */  bnez       $v0, .L800DA7BC
    /* CAFB0 800DA7B0 00000000 */   nop
    /* CAFB4 800DA7B4 F0690308 */  j          .L800DA7C0
    /* CAFB8 800DA7B8 01001E24 */   addiu     $fp, $zero, 0x1
  .L800DA7BC:
    /* CAFBC 800DA7BC 01001424 */  addiu      $s4, $zero, 0x1
  .L800DA7C0:
    /* CAFC0 800DA7C0 0200C013 */  beqz       $fp, .L800DA7CC
    /* CAFC4 800DA7C4 E7000624 */   addiu     $a2, $zero, 0xE7
    /* CAFC8 800DA7C8 A1000624 */  addiu      $a2, $zero, 0xA1
  .L800DA7CC:
    /* CAFCC 800DA7CC AC00A88F */  lw         $t0, 0xAC($sp)
    /* CAFD0 800DA7D0 00000000 */  nop
    /* CAFD4 800DA7D4 16000011 */  beqz       $t0, .L800DA830
    /* CAFD8 800DA7D8 5800A0AF */   sw        $zero, 0x58($sp)
    /* CAFDC 800DA7DC 1280053C */  lui        $a1, %hi(BTCPerpInfo)
    /* CAFE0 800DA7E0 1480033C */  lui        $v1, %hi(Hud_NextPerp)
    /* CAFE4 800DA7E4 94D96324 */  addiu      $v1, $v1, %lo(Hud_NextPerp)
    /* CAFE8 800DA7E8 5000A897 */  lhu        $t0, 0x50($sp)
    /* CAFEC 800DA7EC C00BA524 */  addiu      $a1, $a1, %lo(BTCPerpInfo)
    /* CAFF0 800DA7F0 00240800 */  sll        $a0, $t0, 16
    /* CAFF4 800DA7F4 03240400 */  sra        $a0, $a0, 16
    /* CAFF8 800DA7F8 40100400 */  sll        $v0, $a0, 1
    /* CAFFC 800DA7FC 21104300 */  addu       $v0, $v0, $v1
    /* CB000 800DA800 00004384 */  lh         $v1, 0x0($v0)
    /* CB004 800DA804 80100400 */  sll        $v0, $a0, 2
    /* CB008 800DA808 21104400 */  addu       $v0, $v0, $a0
    /* CB00C 800DA80C 40110200 */  sll        $v0, $v0, 5
    /* CB010 800DA810 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* CB014 800DA814 00190300 */  sll        $v1, $v1, 4
    /* CB018 800DA818 21186200 */  addu       $v1, $v1, $v0
    /* CB01C 800DA81C 21186500 */  addu       $v1, $v1, $a1
    /* CB020 800DA820 0C00628C */  lw         $v0, 0xC($v1)
    /* CB024 800DA824 00000000 */  nop
    /* CB028 800DA828 03004010 */  beqz       $v0, .L800DA838
    /* CB02C 800DA82C 00000000 */   nop
  .L800DA830:
    /* CB030 800DA830 01000824 */  addiu      $t0, $zero, 0x1
    /* CB034 800DA834 5800A8AF */  sw         $t0, 0x58($sp)
  .L800DA838:
    /* CB038 800DA838 1480033C */  lui        $v1, %hi(Hud_NextPerp)
    /* CB03C 800DA83C 94D96324 */  addiu      $v1, $v1, %lo(Hud_NextPerp)
    /* CB040 800DA840 5000A897 */  lhu        $t0, 0x50($sp)
    /* CB044 800DA844 A0001524 */  addiu      $s5, $zero, 0xA0
    /* CB048 800DA848 00140800 */  sll        $v0, $t0, 16
    /* CB04C 800DA84C C3130200 */  sra        $v0, $v0, 15
    /* CB050 800DA850 21104300 */  addu       $v0, $v0, $v1
    /* CB054 800DA854 00004384 */  lh         $v1, 0x0($v0)
    /* CB058 800DA858 0600C824 */  addiu      $t0, $a2, 0x6
    /* CB05C 800DA85C 6800A8A7 */  sh         $t0, 0x68($sp)
    /* CB060 800DA860 5800A88F */  lw         $t0, 0x58($sp)
    /* CB064 800DA864 01006324 */  addiu      $v1, $v1, 0x1
    /* CB068 800DA868 40100300 */  sll        $v0, $v1, 1
    /* CB06C 800DA86C 21104300 */  addu       $v0, $v0, $v1
    /* CB070 800DA870 80180200 */  sll        $v1, $v0, 2
    /* CB074 800DA874 16007724 */  addiu      $s7, $v1, 0x16
    /* CB078 800DA878 42100600 */  srl        $v0, $a2, 1
    /* CB07C 800DA87C 2388A202 */  subu       $s1, $s5, $v0
    /* CB080 800DA880 02000011 */  beqz       $t0, .L800DA88C
    /* CB084 800DA884 6000B1A7 */   sh        $s1, 0x60($sp)
    /* CB088 800DA888 22007724 */  addiu      $s7, $v1, 0x22
  .L800DA88C:
    /* CB08C 800DA88C AC00A88F */  lw         $t0, 0xAC($sp)
    /* CB090 800DA890 00000000 */  nop
    /* CB094 800DA894 02000011 */  beqz       $t0, .L800DA8A0
    /* CB098 800DA898 00000000 */   nop
    /* CB09C 800DA89C 0800F726 */  addiu      $s7, $s7, 0x8
  .L800DA8A0:
    /* CB0A0 800DA8A0 03008012 */  beqz       $s4, .L800DA8B0
    /* CB0A4 800DA8A4 00141700 */   sll       $v0, $s7, 16
    /* CB0A8 800DA8A8 0C00F726 */  addiu      $s7, $s7, 0xC
    /* CB0AC 800DA8AC 00141700 */  sll        $v0, $s7, 16
  .L800DA8B0:
    /* CB0B0 800DA8B0 43840200 */  sra        $s0, $v0, 17
    /* CB0B4 800DA8B4 78000224 */  addiu      $v0, $zero, 0x78
    /* CB0B8 800DA8B8 23105000 */  subu       $v0, $v0, $s0
    /* CB0BC 800DA8BC 47000424 */  addiu      $a0, $zero, 0x47
    /* CB0C0 800DA8C0 07003226 */  addiu      $s2, $s1, 0x7
    /* CB0C4 800DA8C4 AC00A88F */  lw         $t0, 0xAC($sp)
    /* CB0C8 800DA8C8 21984002 */  addu       $s3, $s2, $zero
    /* CB0CC 800DA8CC 02000011 */  beqz       $t0, .L800DA8D8
    /* CB0D0 800DA8D0 7000A2A7 */   sh        $v0, 0x70($sp)
    /* CB0D4 800DA8D4 48000424 */  addiu      $a0, $zero, 0x48
  .L800DA8D8:
    /* CB0D8 800DA8D8 94E4020C */  jal        TextSys_Word__Fi
    /* CB0DC 800DA8DC 00000000 */   nop
    /* CB0E0 800DA8E0 888F030C */  jal        textpixels
    /* CB0E4 800DA8E4 21204000 */   addu      $a0, $v0, $zero
    /* CB0E8 800DA8E8 43100200 */  sra        $v0, $v0, 1
    /* CB0EC 800DA8EC 23A8A202 */  subu       $s5, $s5, $v0
    /* CB0F0 800DA8F0 76000224 */  addiu      $v0, $zero, 0x76
    /* CB0F4 800DA8F4 23105000 */  subu       $v0, $v0, $s0
    /* CB0F8 800DA8F8 0F004624 */  addiu      $a2, $v0, 0xF
    /* CB0FC 800DA8FC 03002326 */  addiu      $v1, $s1, 0x3
    /* CB100 800DA900 2000A3A7 */  sh         $v1, 0x20($sp)
    /* CB104 800DA904 21804000 */  addu       $s0, $v0, $zero
    /* CB108 800DA908 0300C013 */  beqz       $fp, .L800DA918
    /* CB10C 800DA90C 21104002 */   addu      $v0, $s2, $zero
    /* CB110 800DA910 476A0308 */  j          .L800DA91C
    /* CB114 800DA914 0C004224 */   addiu     $v0, $v0, 0xC
  .L800DA918:
    /* CB118 800DA918 0F004224 */  addiu      $v0, $v0, 0xF
  .L800DA91C:
    /* CB11C 800DA91C 2200A2A7 */  sh         $v0, 0x22($sp)
    /* CB120 800DA920 00141300 */  sll        $v0, $s3, 16
    /* CB124 800DA924 0300C013 */  beqz       $fp, .L800DA934
    /* CB128 800DA928 03140200 */   sra       $v0, $v0, 16
    /* CB12C 800DA92C 4E6A0308 */  j          .L800DA938
    /* CB130 800DA930 0C004224 */   addiu     $v0, $v0, 0xC
  .L800DA934:
    /* CB134 800DA934 50004224 */  addiu      $v0, $v0, 0x50
  .L800DA938:
    /* CB138 800DA938 2400A2A7 */  sh         $v0, 0x24($sp)
    /* CB13C 800DA93C 00141300 */  sll        $v0, $s3, 16
    /* CB140 800DA940 0300C013 */  beqz       $fp, .L800DA950
    /* CB144 800DA944 03140200 */   sra       $v0, $v0, 16
    /* CB148 800DA948 556A0308 */  j          .L800DA954
    /* CB14C 800DA94C 50004224 */   addiu     $v0, $v0, 0x50
  .L800DA950:
    /* CB150 800DA950 96004224 */  addiu      $v0, $v0, 0x96
  .L800DA954:
    /* CB154 800DA954 21B0C000 */  addu       $s6, $a2, $zero
    /* CB158 800DA958 06000424 */  addiu      $a0, $zero, 0x6
    /* CB15C 800DA95C 832C030C */  jal        Font_TextColor__Fi
    /* CB160 800DA960 2600A2A7 */   sh        $v0, 0x26($sp)
    /* CB164 800DA964 AC00A88F */  lw         $t0, 0xAC($sp)
    /* CB168 800DA968 00000000 */  nop
    /* CB16C 800DA96C 02000011 */  beqz       $t0, .L800DA978
    /* CB170 800DA970 47000424 */   addiu     $a0, $zero, 0x47
    /* CB174 800DA974 48000424 */  addiu      $a0, $zero, 0x48
  .L800DA978:
    /* CB178 800DA978 94E4020C */  jal        TextSys_Word__Fi
    /* CB17C 800DA97C 00000000 */   nop
    /* CB180 800DA980 21204000 */  addu       $a0, $v0, $zero
    /* CB184 800DA984 002C1500 */  sll        $a1, $s5, 16
    /* CB188 800DA988 032C0500 */  sra        $a1, $a1, 16
    /* CB18C 800DA98C 00341000 */  sll        $a2, $s0, 16
    /* CB190 800DA990 A42E030C */  jal        Font_TextXY__FPcii
    /* CB194 800DA994 03340600 */   sra       $a2, $a2, 16
    /* CB198 800DA998 11008012 */  beqz       $s4, .L800DA9E0
    /* CB19C 800DA99C 00000000 */   nop
    /* CB1A0 800DA9A0 832C030C */  jal        Font_TextColor__Fi
    /* CB1A4 800DA9A4 04000424 */   addiu     $a0, $zero, 0x4
    /* CB1A8 800DA9A8 00341600 */  sll        $a2, $s6, 16
    /* CB1AC 800DA9AC 03340600 */  sra        $a2, $a2, 16
    /* CB1B0 800DA9B0 1180033C */  lui        $v1, %hi(Cars_gRaceCarList)
    /* CB1B4 800DA9B4 5000A897 */  lhu        $t0, 0x50($sp)
    /* CB1B8 800DA9B8 00FA6324 */  addiu      $v1, $v1, %lo(Cars_gRaceCarList)
    /* CB1BC 800DA9BC 00140800 */  sll        $v0, $t0, 16
    /* CB1C0 800DA9C0 83130200 */  sra        $v0, $v0, 14
    /* CB1C4 800DA9C4 21104300 */  addu       $v0, $v0, $v1
    /* CB1C8 800DA9C8 0000428C */  lw         $v0, 0x0($v0)
    /* CB1CC 800DA9CC 0C00D626 */  addiu      $s6, $s6, 0xC
    /* CB1D0 800DA9D0 8802448C */  lw         $a0, 0x288($v0)
    /* CB1D4 800DA9D4 2400A587 */  lh         $a1, 0x24($sp)
    /* CB1D8 800DA9D8 A42E030C */  jal        Font_TextXY__FPcii
    /* CB1DC 800DA9DC 5C008424 */   addiu     $a0, $a0, 0x5C
  .L800DA9E0:
    /* CB1E0 800DA9E0 832C030C */  jal        Font_TextColor__Fi
    /* CB1E4 800DA9E4 03000424 */   addiu     $a0, $zero, 0x3
    /* CB1E8 800DA9E8 0800C017 */  bnez       $fp, .L800DAA0C
    /* CB1EC 800DA9EC 00000000 */   nop
    /* CB1F0 800DA9F0 94E4020C */  jal        TextSys_Word__Fi
    /* CB1F4 800DA9F4 4A000424 */   addiu     $a0, $zero, 0x4A
    /* CB1F8 800DA9F8 21204000 */  addu       $a0, $v0, $zero
    /* CB1FC 800DA9FC 2200A587 */  lh         $a1, 0x22($sp)
    /* CB200 800DAA00 00341600 */  sll        $a2, $s6, 16
    /* CB204 800DAA04 A42E030C */  jal        Font_TextXY__FPcii
    /* CB208 800DAA08 03340600 */   sra       $a2, $a2, 16
  .L800DAA0C:
    /* CB20C 800DAA0C 94E4020C */  jal        TextSys_Word__Fi
    /* CB210 800DAA10 4B000424 */   addiu     $a0, $zero, 0x4B
    /* CB214 800DAA14 21204000 */  addu       $a0, $v0, $zero
    /* CB218 800DAA18 00841600 */  sll        $s0, $s6, 16
    /* CB21C 800DAA1C 03841000 */  sra        $s0, $s0, 16
    /* CB220 800DAA20 21300002 */  addu       $a2, $s0, $zero
    /* CB224 800DAA24 2400A587 */  lh         $a1, 0x24($sp)
    /* CB228 800DAA28 A42E030C */  jal        Font_TextXY__FPcii
    /* CB22C 800DAA2C 01001524 */   addiu     $s5, $zero, 0x1
    /* CB230 800DAA30 94E4020C */  jal        TextSys_Word__Fi
    /* CB234 800DAA34 4C000424 */   addiu     $a0, $zero, 0x4C
    /* CB238 800DAA38 21204000 */  addu       $a0, $v0, $zero
    /* CB23C 800DAA3C 2600A587 */  lh         $a1, 0x26($sp)
    /* CB240 800DAA40 A42E030C */  jal        Font_TextXY__FPcii
    /* CB244 800DAA44 21300002 */   addu      $a2, $s0, $zero
    /* CB248 800DAA48 21200000 */  addu       $a0, $zero, $zero
    /* CB24C 800DAA4C 0F001026 */  addiu      $s0, $s0, 0xF
    /* CB250 800DAA50 21300002 */  addu       $a2, $s0, $zero
    /* CB254 800DAA54 6000A897 */  lhu        $t0, 0x60($sp)
    /* CB258 800DAA58 01000224 */  addiu      $v0, $zero, 0x1
    /* CB25C 800DAA5C 1000A2AF */  sw         $v0, 0x10($sp)
    /* CB260 800DAA60 1400A0AF */  sw         $zero, 0x14($sp)
    /* CB264 800DAA64 1800A0AF */  sw         $zero, 0x18($sp)
    /* CB268 800DAA68 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* CB26C 800DAA6C 002C0800 */  sll        $a1, $t0, 16
    /* CB270 800DAA70 6800A897 */  lhu        $t0, 0x68($sp)
    /* CB274 800DAA74 032C0500 */  sra        $a1, $a1, 16
    /* CB278 800DAA78 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CB27C 800DAA7C 21380001 */   addu      $a3, $t0, $zero
    /* CB280 800DAA80 00141700 */  sll        $v0, $s7, 16
    /* CB284 800DAA84 7000A897 */  lhu        $t0, 0x70($sp)
    /* CB288 800DAA88 03940200 */  sra        $s2, $v0, 16
    /* CB28C 800DAA8C 00140800 */  sll        $v0, $t0, 16
    /* CB290 800DAA90 03140200 */  sra        $v0, $v0, 16
    /* CB294 800DAA94 23880202 */  subu       $s1, $s0, $v0
    /* CB298 800DAA98 00141500 */  sll        $v0, $s5, 16
  .L800DAA9C:
    /* CB29C 800DAA9C C3130200 */  sra        $v0, $v0, 15
    /* CB2A0 800DAAA0 2110A203 */  addu       $v0, $sp, $v0
    /* CB2A4 800DAAA4 20004284 */  lh         $v0, 0x20($v0)
    /* CB2A8 800DAAA8 AC00A88F */  lw         $t0, 0xAC($sp)
    /* CB2AC 800DAAAC 00000000 */  nop
    /* CB2B0 800DAAB0 04000011 */  beqz       $t0, .L800DAAC4
    /* CB2B4 800DAAB4 FEFF4524 */   addiu     $a1, $v0, -0x2
    /* CB2B8 800DAAB8 08002226 */  addiu      $v0, $s1, 0x8
    /* CB2BC 800DAABC B26A0308 */  j          .L800DAAC8
    /* CB2C0 800DAAC0 23104202 */   subu      $v0, $s2, $v0
  .L800DAAC4:
    /* CB2C4 800DAAC4 23105102 */  subu       $v0, $s2, $s1
  .L800DAAC8:
    /* CB2C8 800DAAC8 5800A88F */  lw         $t0, 0x58($sp)
    /* CB2CC 800DAACC 00000000 */  nop
    /* CB2D0 800DAAD0 02000011 */  beqz       $t0, .L800DAADC
    /* CB2D4 800DAAD4 21200000 */   addu      $a0, $zero, $zero
    /* CB2D8 800DAAD8 F0FF4224 */  addiu      $v0, $v0, -0x10
  .L800DAADC:
    /* CB2DC 800DAADC 21300002 */  addu       $a2, $s0, $zero
    /* CB2E0 800DAAE0 01000724 */  addiu      $a3, $zero, 0x1
    /* CB2E4 800DAAE4 1000A2AF */  sw         $v0, 0x10($sp)
    /* CB2E8 800DAAE8 1400A0AF */  sw         $zero, 0x14($sp)
    /* CB2EC 800DAAEC 1800A0AF */  sw         $zero, 0x18($sp)
    /* CB2F0 800DAAF0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CB2F4 800DAAF4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CB2F8 800DAAF8 0100A226 */  addiu      $v0, $s5, 0x1
    /* CB2FC 800DAAFC 21A84000 */  addu       $s5, $v0, $zero
    /* CB300 800DAB00 00140200 */  sll        $v0, $v0, 16
    /* CB304 800DAB04 03140200 */  sra        $v0, $v0, 16
    /* CB308 800DAB08 04004228 */  slti       $v0, $v0, 0x4
    /* CB30C 800DAB0C E3FF4014 */  bnez       $v0, .L800DAA9C
    /* CB310 800DAB10 00141500 */   sll       $v0, $s5, 16
    /* CB314 800DAB14 5800A88F */  lw         $t0, 0x58($sp)
    /* CB318 800DAB18 00000000 */  nop
    /* CB31C 800DAB1C 1F000011 */  beqz       $t0, .L800DAB9C
    /* CB320 800DAB20 001C1600 */   sll       $v1, $s6, 16
    /* CB324 800DAB24 6000A897 */  lhu        $t0, 0x60($sp)
    /* CB328 800DAB28 00000000 */  nop
    /* CB32C 800DAB2C 00140800 */  sll        $v0, $t0, 16
    /* CB330 800DAB30 032C0200 */  sra        $a1, $v0, 16
    /* CB334 800DAB34 031C0300 */  sra        $v1, $v1, 16
    /* CB338 800DAB38 0F006324 */  addiu      $v1, $v1, 0xF
    /* CB33C 800DAB3C 00141700 */  sll        $v0, $s7, 16
    /* CB340 800DAB40 03140200 */  sra        $v0, $v0, 16
    /* CB344 800DAB44 7000A897 */  lhu        $t0, 0x70($sp)
    /* CB348 800DAB48 21206200 */  addu       $a0, $v1, $v0
    /* CB34C 800DAB4C 00140800 */  sll        $v0, $t0, 16
    /* CB350 800DAB50 03140200 */  sra        $v0, $v0, 16
    /* CB354 800DAB54 AC00A88F */  lw         $t0, 0xAC($sp)
    /* CB358 800DAB58 00000000 */  nop
    /* CB35C 800DAB5C 04000011 */  beqz       $t0, .L800DAB70
    /* CB360 800DAB60 23186200 */   subu      $v1, $v1, $v0
    /* CB364 800DAB64 23108300 */  subu       $v0, $a0, $v1
    /* CB368 800DAB68 DE6A0308 */  j          .L800DAB78
    /* CB36C 800DAB6C E8FF4624 */   addiu     $a2, $v0, -0x18
  .L800DAB70:
    /* CB370 800DAB70 23108300 */  subu       $v0, $a0, $v1
    /* CB374 800DAB74 F0FF4624 */  addiu      $a2, $v0, -0x10
  .L800DAB78:
    /* CB378 800DAB78 21200000 */  addu       $a0, $zero, $zero
    /* CB37C 800DAB7C 6800A897 */  lhu        $t0, 0x68($sp)
    /* CB380 800DAB80 01000224 */  addiu      $v0, $zero, 0x1
    /* CB384 800DAB84 1000A2AF */  sw         $v0, 0x10($sp)
    /* CB388 800DAB88 1400A0AF */  sw         $zero, 0x14($sp)
    /* CB38C 800DAB8C 1800A0AF */  sw         $zero, 0x18($sp)
    /* CB390 800DAB90 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* CB394 800DAB94 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CB398 800DAB98 21380001 */   addu      $a3, $t0, $zero
  .L800DAB9C:
    /* CB39C 800DAB9C 0F00C426 */  addiu      $a0, $s6, 0xF
    /* CB3A0 800DABA0 21B08000 */  addu       $s6, $a0, $zero
    /* CB3A4 800DABA4 5000A897 */  lhu        $t0, 0x50($sp)
    /* CB3A8 800DABA8 1480033C */  lui        $v1, %hi(Hud_NextPerp)
    /* CB3AC 800DABAC 94D96324 */  addiu      $v1, $v1, %lo(Hud_NextPerp)
    /* CB3B0 800DABB0 002C0800 */  sll        $a1, $t0, 16
    /* CB3B4 800DABB4 C3130500 */  sra        $v0, $a1, 15
    /* CB3B8 800DABB8 21104300 */  addu       $v0, $v0, $v1
    /* CB3BC 800DABBC 00004284 */  lh         $v0, 0x0($v0)
    /* CB3C0 800DABC0 00000000 */  nop
    /* CB3C4 800DABC4 58004018 */  blez       $v0, .L800DAD28
    /* CB3C8 800DABC8 21A80000 */   addu      $s5, $zero, $zero
    /* CB3CC 800DABCC 2800B427 */  addiu      $s4, $sp, 0x28
    /* CB3D0 800DABD0 00140400 */  sll        $v0, $a0, 16
    /* CB3D4 800DABD4 03140200 */  sra        $v0, $v0, 16
    /* CB3D8 800DABD8 7800A2AF */  sw         $v0, 0x78($sp)
    /* CB3DC 800DABDC 039C0500 */  sra        $s3, $a1, 16
  .L800DABE0:
    /* CB3E0 800DABE0 80901300 */  sll        $s2, $s3, 2
    /* CB3E4 800DABE4 1480033C */  lui        $v1, %hi(StatsTimer)
    /* CB3E8 800DABE8 98D96324 */  addiu      $v1, $v1, %lo(StatsTimer)
    /* CB3EC 800DABEC 21184302 */  addu       $v1, $s2, $v1
    /* CB3F0 800DABF0 00141500 */  sll        $v0, $s5, 16
    /* CB3F4 800DABF4 03840200 */  sra        $s0, $v0, 16
    /* CB3F8 800DABF8 40881000 */  sll        $s1, $s0, 1
    /* CB3FC 800DABFC 0000638C */  lw         $v1, 0x0($v1)
    /* CB400 800DAC00 04002226 */  addiu      $v0, $s1, 0x4
    /* CB404 800DAC04 2A104300 */  slt        $v0, $v0, $v1
    /* CB408 800DAC08 3A004010 */  beqz       $v0, .L800DACF4
    /* CB40C 800DAC0C 0100A326 */   addiu     $v1, $s5, 0x1
    /* CB410 800DAC10 832C030C */  jal        Font_TextColor__Fi
    /* CB414 800DAC14 04000424 */   addiu     $a0, $zero, 0x4
    /* CB418 800DAC18 21208002 */  addu       $a0, $s4, $zero
    /* CB41C 800DAC1C 1480053C */  lui        $a1, %hi(D_8013D98C)
    /* CB420 800DAC20 8CD9A524 */  addiu      $a1, $a1, %lo(D_8013D98C)
    /* CB424 800DAC24 2F91030C */  jal        sprintf
    /* CB428 800DAC28 01000626 */   addiu     $a2, $s0, 0x1
    /* CB42C 800DAC2C 21208002 */  addu       $a0, $s4, $zero
    /* CB430 800DAC30 21103002 */  addu       $v0, $s1, $s0
    /* CB434 800DAC34 80100200 */  sll        $v0, $v0, 2
    /* CB438 800DAC38 7800A88F */  lw         $t0, 0x78($sp)
    /* CB43C 800DAC3C 2000A587 */  lh         $a1, 0x20($sp)
    /* CB440 800DAC40 21880201 */  addu       $s1, $t0, $v0
    /* CB444 800DAC44 A42E030C */  jal        Font_TextXY__FPcii
    /* CB448 800DAC48 21302002 */   addu      $a2, $s1, $zero
    /* CB44C 800DAC4C 0F00C017 */  bnez       $fp, .L800DAC8C
    /* CB450 800DAC50 1480053C */   lui       $a1, %hi(D_8013D990)
    /* CB454 800DAC54 21208002 */  addu       $a0, $s4, $zero
    /* CB458 800DAC58 90D9A524 */  addiu      $a1, $a1, %lo(D_8013D990)
    /* CB45C 800DAC5C 21105302 */  addu       $v0, $s2, $s3
    /* CB460 800DAC60 40110200 */  sll        $v0, $v0, 5
    /* CB464 800DAC64 00311000 */  sll        $a2, $s0, 4
    /* CB468 800DAC68 1280083C */  lui        $t0, %hi(BTCPerpInfo)
    /* CB46C 800DAC6C C00B0825 */  addiu      $t0, $t0, %lo(BTCPerpInfo)
    /* CB470 800DAC70 2130C800 */  addu       $a2, $a2, $t0
    /* CB474 800DAC74 2F91030C */  jal        sprintf
    /* CB478 800DAC78 21304600 */   addu      $a2, $v0, $a2
    /* CB47C 800DAC7C 21208002 */  addu       $a0, $s4, $zero
    /* CB480 800DAC80 2200A587 */  lh         $a1, 0x22($sp)
    /* CB484 800DAC84 A42E030C */  jal        Font_TextXY__FPcii
    /* CB488 800DAC88 21302002 */   addu      $a2, $s1, $zero
  .L800DAC8C:
    /* CB48C 800DAC8C 00811000 */  sll        $s0, $s0, 4
    /* CB490 800DAC90 21105302 */  addu       $v0, $s2, $s3
    /* CB494 800DAC94 40110200 */  sll        $v0, $v0, 5
    /* CB498 800DAC98 21800202 */  addu       $s0, $s0, $v0
    /* CB49C 800DAC9C 1280083C */  lui        $t0, %hi(BTCPerpInfo)
    /* CB4A0 800DACA0 C00B0825 */  addiu      $t0, $t0, %lo(BTCPerpInfo)
    /* CB4A4 800DACA4 21800802 */  addu       $s0, $s0, $t0
    /* CB4A8 800DACA8 0800048E */  lw         $a0, 0x8($s0)
    /* CB4AC 800DACAC 5963030C */  jal        Hud_ParseTime__FiPc
    /* CB4B0 800DACB0 21288002 */   addu      $a1, $s4, $zero
    /* CB4B4 800DACB4 21208002 */  addu       $a0, $s4, $zero
    /* CB4B8 800DACB8 2400A587 */  lh         $a1, 0x24($sp)
    /* CB4BC 800DACBC A42E030C */  jal        Font_TextXY__FPcii
    /* CB4C0 800DACC0 21302002 */   addu      $a2, $s1, $zero
    /* CB4C4 800DACC4 0C00028E */  lw         $v0, 0xC($s0)
    /* CB4C8 800DACC8 00000000 */  nop
    /* CB4CC 800DACCC 02004010 */  beqz       $v0, .L800DACD8
    /* CB4D0 800DACD0 49000424 */   addiu     $a0, $zero, 0x49
    /* CB4D4 800DACD4 3D000424 */  addiu      $a0, $zero, 0x3D
  .L800DACD8:
    /* CB4D8 800DACD8 94E4020C */  jal        TextSys_Word__Fi
    /* CB4DC 800DACDC 00000000 */   nop
    /* CB4E0 800DACE0 21204000 */  addu       $a0, $v0, $zero
    /* CB4E4 800DACE4 2600A587 */  lh         $a1, 0x26($sp)
    /* CB4E8 800DACE8 A42E030C */  jal        Font_TextXY__FPcii
    /* CB4EC 800DACEC 21302002 */   addu      $a2, $s1, $zero
    /* CB4F0 800DACF0 0100A326 */  addiu      $v1, $s5, 0x1
  .L800DACF4:
    /* CB4F4 800DACF4 21A86000 */  addu       $s5, $v1, $zero
    /* CB4F8 800DACF8 1480023C */  lui        $v0, %hi(Hud_NextPerp)
    /* CB4FC 800DACFC 94D94224 */  addiu      $v0, $v0, %lo(Hud_NextPerp)
    /* CB500 800DAD00 5000A897 */  lhu        $t0, 0x50($sp)
    /* CB504 800DAD04 001C0300 */  sll        $v1, $v1, 16
    /* CB508 800DAD08 002C0800 */  sll        $a1, $t0, 16
    /* CB50C 800DAD0C C3230500 */  sra        $a0, $a1, 15
    /* CB510 800DAD10 21208200 */  addu       $a0, $a0, $v0
    /* CB514 800DAD14 00008284 */  lh         $v0, 0x0($a0)
    /* CB518 800DAD18 031C0300 */  sra        $v1, $v1, 16
    /* CB51C 800DAD1C 2A186200 */  slt        $v1, $v1, $v0
    /* CB520 800DAD20 AFFF6014 */  bnez       $v1, .L800DABE0
    /* CB524 800DAD24 039C0500 */   sra       $s3, $a1, 16
  .L800DAD28:
    /* CB528 800DAD28 5800A88F */  lw         $t0, 0x58($sp)
    /* CB52C 800DAD2C 00000000 */  nop
    /* CB530 800DAD30 31000011 */  beqz       $t0, .L800DADF8
    /* CB534 800DAD34 00000000 */   nop
    /* CB538 800DAD38 5000A897 */  lhu        $t0, 0x50($sp)
    /* CB53C 800DAD3C 1480023C */  lui        $v0, %hi(StatsTimer)
    /* CB540 800DAD40 98D94224 */  addiu      $v0, $v0, %lo(StatsTimer)
    /* CB544 800DAD44 001C0800 */  sll        $v1, $t0, 16
    /* CB548 800DAD48 831B0300 */  sra        $v1, $v1, 14
    /* CB54C 800DAD4C 21186200 */  addu       $v1, $v1, $v0
    /* CB550 800DAD50 00141500 */  sll        $v0, $s5, 16
    /* CB554 800DAD54 03940200 */  sra        $s2, $v0, 16
    /* CB558 800DAD58 40881200 */  sll        $s1, $s2, 1
    /* CB55C 800DAD5C 0000638C */  lw         $v1, 0x0($v1)
    /* CB560 800DAD60 04002226 */  addiu      $v0, $s1, 0x4
    /* CB564 800DAD64 2A104300 */  slt        $v0, $v0, $v1
    /* CB568 800DAD68 23004010 */  beqz       $v0, .L800DADF8
    /* CB56C 800DAD6C 00000000 */   nop
    /* CB570 800DAD70 832C030C */  jal        Font_TextColor__Fi
    /* CB574 800DAD74 03000424 */   addiu     $a0, $zero, 0x3
    /* CB578 800DAD78 2800B027 */  addiu      $s0, $sp, 0x28
    /* CB57C 800DAD7C 1480043C */  lui        $a0, %hi(FinalBTC_Countdown)
    /* CB580 800DAD80 38D9848C */  lw         $a0, %lo(FinalBTC_Countdown)($a0)
    /* CB584 800DAD84 5963030C */  jal        Hud_ParseTime__FiPc
    /* CB588 800DAD88 21280002 */   addu      $a1, $s0, $zero
    /* CB58C 800DAD8C 94E4020C */  jal        TextSys_Word__Fi
    /* CB590 800DAD90 4D000424 */   addiu     $a0, $zero, 0x4D
    /* CB594 800DAD94 21204000 */  addu       $a0, $v0, $zero
    /* CB598 800DAD98 00341600 */  sll        $a2, $s6, 16
    /* CB59C 800DAD9C 03340600 */  sra        $a2, $a2, 16
    /* CB5A0 800DADA0 21103202 */  addu       $v0, $s1, $s2
    /* CB5A4 800DADA4 80100200 */  sll        $v0, $v0, 2
    /* CB5A8 800DADA8 2130C200 */  addu       $a2, $a2, $v0
    /* CB5AC 800DADAC 2000A587 */  lh         $a1, 0x20($sp)
    /* CB5B0 800DADB0 A42E030C */  jal        Font_TextXY__FPcii
    /* CB5B4 800DADB4 0200C624 */   addiu     $a2, $a2, 0x2
    /* CB5B8 800DADB8 0400C013 */  beqz       $fp, .L800DADCC
    /* CB5BC 800DADBC 21200002 */   addu      $a0, $s0, $zero
    /* CB5C0 800DADC0 2600A587 */  lh         $a1, 0x26($sp)
    /* CB5C4 800DADC4 756B0308 */  j          .L800DADD4
    /* CB5C8 800DADC8 00341600 */   sll       $a2, $s6, 16
  .L800DADCC:
    /* CB5CC 800DADCC 2400A587 */  lh         $a1, 0x24($sp)
    /* CB5D0 800DADD0 00341600 */  sll        $a2, $s6, 16
  .L800DADD4:
    /* CB5D4 800DADD4 03340600 */  sra        $a2, $a2, 16
    /* CB5D8 800DADD8 001C1500 */  sll        $v1, $s5, 16
    /* CB5DC 800DADDC 031C0300 */  sra        $v1, $v1, 16
    /* CB5E0 800DADE0 40100300 */  sll        $v0, $v1, 1
    /* CB5E4 800DADE4 21104300 */  addu       $v0, $v0, $v1
    /* CB5E8 800DADE8 80100200 */  sll        $v0, $v0, 2
    /* CB5EC 800DADEC 2130C200 */  addu       $a2, $a2, $v0
    /* CB5F0 800DADF0 A42E030C */  jal        Font_TextXY__FPcii
    /* CB5F4 800DADF4 0200C624 */   addiu     $a2, $a2, 0x2
  .L800DADF8:
    /* CB5F8 800DADF8 AC00A88F */  lw         $t0, 0xAC($sp)
    /* CB5FC 800DADFC 00000000 */  nop
    /* CB600 800DAE00 0B000011 */  beqz       $t0, .L800DAE30
    /* CB604 800DAE04 003C1700 */   sll       $a3, $s7, 16
    /* CB608 800DAE08 6000A897 */  lhu        $t0, 0x60($sp)
    /* CB60C 800DAE0C 033C0700 */  sra        $a3, $a3, 16
    /* CB610 800DAE10 00240800 */  sll        $a0, $t0, 16
    /* CB614 800DAE14 7000A897 */  lhu        $t0, 0x70($sp)
    /* CB618 800DAE18 03240400 */  sra        $a0, $a0, 16
    /* CB61C 800DAE1C 002C0800 */  sll        $a1, $t0, 16
    /* CB620 800DAE20 6800A897 */  lhu        $t0, 0x68($sp)
    /* CB624 800DAE24 032C0500 */  sra        $a1, $a1, 16
    /* CB628 800DAE28 5A66030C */  jal        OptionsBarThing__Fiiii
    /* CB62C 800DAE2C 21300001 */   addu      $a2, $t0, $zero
  .L800DAE30:
    /* CB630 800DAE30 003C1700 */  sll        $a3, $s7, 16
    /* CB634 800DAE34 6000A897 */  lhu        $t0, 0x60($sp)
    /* CB638 800DAE38 033C0700 */  sra        $a3, $a3, 16
    /* CB63C 800DAE3C 00240800 */  sll        $a0, $t0, 16
    /* CB640 800DAE40 7000A897 */  lhu        $t0, 0x70($sp)
    /* CB644 800DAE44 03240400 */  sra        $a0, $a0, 16
    /* CB648 800DAE48 002C0800 */  sll        $a1, $t0, 16
    /* CB64C 800DAE4C 6800A897 */  lhu        $t0, 0x68($sp)
    /* CB650 800DAE50 032C0500 */  sra        $a1, $a1, 16
    /* CB654 800DAE54 B463030C */  jal        Hud_RenderPauseBox__Fiiii
    /* CB658 800DAE58 21300001 */   addu      $a2, $t0, $zero
    /* CB65C 800DAE5C A400BF8F */  lw         $ra, 0xA4($sp)
    /* CB660 800DAE60 A000BE8F */  lw         $fp, 0xA0($sp)
    /* CB664 800DAE64 9C00B78F */  lw         $s7, 0x9C($sp)
    /* CB668 800DAE68 9800B68F */  lw         $s6, 0x98($sp)
    /* CB66C 800DAE6C 9400B58F */  lw         $s5, 0x94($sp)
    /* CB670 800DAE70 9000B48F */  lw         $s4, 0x90($sp)
    /* CB674 800DAE74 8C00B38F */  lw         $s3, 0x8C($sp)
    /* CB678 800DAE78 8800B28F */  lw         $s2, 0x88($sp)
    /* CB67C 800DAE7C 8400B18F */  lw         $s1, 0x84($sp)
    /* CB680 800DAE80 8000B08F */  lw         $s0, 0x80($sp)
    /* CB684 800DAE84 0800E003 */  jr         $ra
    /* CB688 800DAE88 A800BD27 */   addiu     $sp, $sp, 0xA8
endlabel Hud_BTCStats__Fsb
