.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioTrk_SoundTrack__FP8Car_tObji, 0x598

glabel AudioTrk_SoundTrack__FP8Car_tObji
    /* 6D5C4 8007CDC4 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 6D5C8 8007CDC8 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 6D5CC 8007CDCC F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 6D5D0 8007CDD0 01000224 */  addiu      $v0, $zero, 0x1
    /* 6D5D4 8007CDD4 7400BFAF */  sw         $ra, 0x74($sp)
    /* 6D5D8 8007CDD8 7000BEAF */  sw         $fp, 0x70($sp)
    /* 6D5DC 8007CDDC 6C00B7AF */  sw         $s7, 0x6C($sp)
    /* 6D5E0 8007CDE0 6800B6AF */  sw         $s6, 0x68($sp)
    /* 6D5E4 8007CDE4 6400B5AF */  sw         $s5, 0x64($sp)
    /* 6D5E8 8007CDE8 6000B4AF */  sw         $s4, 0x60($sp)
    /* 6D5EC 8007CDEC 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* 6D5F0 8007CDF0 5800B2AF */  sw         $s2, 0x58($sp)
    /* 6D5F4 8007CDF4 5400B1AF */  sw         $s1, 0x54($sp)
    /* 6D5F8 8007CDF8 5000B0AF */  sw         $s0, 0x50($sp)
    /* 6D5FC 8007CDFC 7800A4AF */  sw         $a0, 0x78($sp)
    /* 6D600 8007CE00 4A016210 */  beq        $v1, $v0, .L8007D32C
    /* 6D604 8007CE04 7C00A5AF */   sw        $a1, 0x7C($sp)
    /* 6D608 8007CE08 1480023C */  lui        $v0, %hi(gMasterAmbientLevel)
    /* 6D60C 8007CE0C 60C6428C */  lw         $v0, %lo(gMasterAmbientLevel)($v0)
    /* 6D610 8007CE10 00000000 */  nop
    /* 6D614 8007CE14 45014010 */  beqz       $v0, .L8007D32C
    /* 6D618 8007CE18 00000000 */   nop
    /* 6D61C 8007CE1C 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6D620 8007CE20 00000000 */  nop
    /* 6D624 8007CE24 41014010 */  beqz       $v0, .L8007D32C
    /* 6D628 8007CE28 00000000 */   nop
    /* 6D62C 8007CE2C 1480043C */  lui        $a0, %hi(gGameAudioList)
    /* 6D630 8007CE30 30C7848C */  lw         $a0, %lo(gGameAudioList)($a0)
    /* 6D634 8007CE34 00000000 */  nop
    /* 6D638 8007CE38 3C018010 */  beqz       $a0, .L8007D32C
    /* 6D63C 8007CE3C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 6D640 8007CE40 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 6D644 8007CE44 0400878C */  lw         $a3, 0x4($a0)
    /* 6D648 8007CE48 43280300 */  sra        $a1, $v1, 1
    /* 6D64C 8007CE4C 83100700 */  sra        $v0, $a3, 2
    /* 6D650 8007CE50 01004624 */  addiu      $a2, $v0, 0x1
    /* 6D654 8007CE54 C3180300 */  sra        $v1, $v1, 3
    /* 6D658 8007CE58 1180023C */  lui        $v0, %hi(AudioClc_gRenderView)
    /* 6D65C 8007CE5C 4000A3AF */  sw         $v1, 0x40($sp)
    /* 6D660 8007CE60 28E44324 */  addiu      $v1, $v0, %lo(AudioClc_gRenderView)
    /* 6D664 8007CE64 28E4428C */  lw         $v0, %lo(AudioClc_gRenderView)($v0)
    /* 6D668 8007CE68 10009524 */  addiu      $s5, $a0, 0x10
    /* 6D66C 8007CE6C 4400A2AF */  sw         $v0, 0x44($sp)
    /* 6D670 8007CE70 0800638C */  lw         $v1, 0x8($v1)
    /* 6D674 8007CE74 2120A000 */  addu       $a0, $a1, $zero
    /* 6D678 8007CE78 0200A104 */  bgez       $a1, .L8007CE84
    /* 6D67C 8007CE7C 4800A3AF */   sw        $v1, 0x48($sp)
    /* 6D680 8007CE80 0300A424 */  addiu      $a0, $a1, 0x3
  .L8007CE84:
    /* 6D684 8007CE84 83100400 */  sra        $v0, $a0, 2
    /* 6D688 8007CE88 80100200 */  sll        $v0, $v0, 2
    /* 6D68C 8007CE8C 2310A200 */  subu       $v0, $a1, $v0
    /* 6D690 8007CE90 18004600 */  mult       $v0, $a2
    /* 6D694 8007CE94 21F0E000 */  addu       $fp, $a3, $zero
    /* 6D698 8007CE98 12180000 */  mflo       $v1
    /* 6D69C 8007CE9C 21206600 */  addu       $a0, $v1, $a2
    /* 6D6A0 8007CEA0 2A10C403 */  slt        $v0, $fp, $a0
    /* 6D6A4 8007CEA4 02004014 */  bnez       $v0, .L8007CEB0
    /* 6D6A8 8007CEA8 40100300 */   sll       $v0, $v1, 1
    /* 6D6AC 8007CEAC 21F08000 */  addu       $fp, $a0, $zero
  .L8007CEB0:
    /* 6D6B0 8007CEB0 21104300 */  addu       $v0, $v0, $v1
    /* 6D6B4 8007CEB4 C0100200 */  sll        $v0, $v0, 3
    /* 6D6B8 8007CEB8 21A8A202 */  addu       $s5, $s5, $v0
    /* 6D6BC 8007CEBC 21B86000 */  addu       $s7, $v1, $zero
    /* 6D6C0 8007CEC0 1400B126 */  addiu      $s1, $s5, 0x14
  .L8007CEC4:
    /* 6D6C4 8007CEC4 2A10FE02 */  slt        $v0, $s7, $fp
    /* 6D6C8 8007CEC8 18014010 */  beqz       $v0, .L8007D32C
    /* 6D6CC 8007CECC FFFF0824 */   addiu     $t0, $zero, -0x1
    /* 6D6D0 8007CED0 01002382 */  lb         $v1, 0x1($s1)
    /* 6D6D4 8007CED4 00000000 */  nop
    /* 6D6D8 8007CED8 09006810 */  beq        $v1, $t0, .L8007CF00
    /* 6D6DC 8007CEDC 00190300 */   sll       $v1, $v1, 4
    /* 6D6E0 8007CEE0 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6D6E4 8007CEE4 00000000 */  nop
    /* 6D6E8 8007CEE8 21104300 */  addu       $v0, $v0, $v1
    /* 6D6EC 8007CEEC 0000428C */  lw         $v0, 0x0($v0)
    /* 6D6F0 8007CEF0 00000000 */  nop
    /* 6D6F4 8007CEF4 02005510 */  beq        $v0, $s5, .L8007CF00
    /* 6D6F8 8007CEF8 00000000 */   nop
    /* 6D6FC 8007CEFC 010028A2 */  sb         $t0, 0x1($s1)
  .L8007CF00:
    /* 6D700 8007CF00 00002292 */  lbu        $v0, 0x0($s1)
    /* 6D704 8007CF04 4000B28F */  lw         $s2, 0x40($sp)
    /* 6D708 8007CF08 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 6D70C 8007CF0C 2000422C */  sltiu      $v0, $v0, 0x20
    /* 6D710 8007CF10 1C004010 */  beqz       $v0, .L8007CF84
    /* 6D714 8007CF14 21A00000 */   addu      $s4, $zero, $zero
    /* 6D718 8007CF18 1180083C */  lui        $t0, %hi(Anim_gInstanceFromIndex)
    /* 6D71C 8007CF1C 2000A0AF */  sw         $zero, 0x20($sp)
    /* 6D720 8007CF20 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 6D724 8007CF24 1800A0AF */  sw         $zero, 0x18($sp)
    /* 6D728 8007CF28 00002292 */  lbu        $v0, 0x0($s1)
    /* 6D72C 8007CF2C CCE10825 */  addiu      $t0, $t0, %lo(Anim_gInstanceFromIndex)
    /* 6D730 8007CF30 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 6D734 8007CF34 80100200 */  sll        $v0, $v0, 2
    /* 6D738 8007CF38 21104800 */  addu       $v0, $v0, $t0
    /* 6D73C 8007CF3C 0000548C */  lw         $s4, 0x0($v0)
    /* 6D740 8007CF40 00000000 */  nop
    /* 6D744 8007CF44 30008012 */  beqz       $s4, .L8007D008
    /* 6D748 8007CF48 00000000 */   nop
    /* 6D74C 8007CF4C 911D030C */  jal        DrawW_GetAnimationTime__FP15Trk_AnimateInst
    /* 6D750 8007CF50 21208002 */   addu      $a0, $s4, $zero
    /* 6D754 8007CF54 21904000 */  addu       $s2, $v0, $zero
    /* 6D758 8007CF58 21208002 */  addu       $a0, $s4, $zero
    /* 6D75C 8007CF5C 01000524 */  addiu      $a1, $zero, 0x1
    /* 6D760 8007CF60 21304002 */  addu       $a2, $s2, $zero
    /* 6D764 8007CF64 2138A002 */  addu       $a3, $s5, $zero
    /* 6D768 8007CF68 3800A227 */  addiu      $v0, $sp, 0x38
    /* 6D76C 8007CF6C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6D770 8007CF70 3C00A227 */  addiu      $v0, $sp, 0x3C
    /* 6D774 8007CF74 4BD0010C */  jal        Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
    /* 6D778 8007CF78 1400A2AF */   sw        $v0, 0x14($sp)
    /* 6D77C 8007CF7C 02F40108 */  j          .L8007D008
    /* 6D780 8007CF80 00000000 */   nop
  .L8007CF84:
    /* 6D784 8007CF84 FCFF228E */  lw         $v0, -0x4($s1)
    /* 6D788 8007CF88 FFFF033C */  lui        $v1, (0xFFFF0000 >> 16)
    /* 6D78C 8007CF8C 24104300 */  and        $v0, $v0, $v1
    /* 6D790 8007CF90 1D004010 */  beqz       $v0, .L8007D008
    /* 6D794 8007CF94 00000000 */   nop
    /* 6D798 8007CF98 F8FF2296 */  lhu        $v0, -0x8($s1)
    /* 6D79C 8007CF9C 00000000 */  nop
    /* 6D7A0 8007CFA0 2A105200 */  slt        $v0, $v0, $s2
    /* 6D7A4 8007CFA4 18004010 */  beqz       $v0, .L8007D008
    /* 6D7A8 8007CFA8 FFFF0824 */   addiu     $t0, $zero, -0x1
    /* 6D7AC 8007CFAC 01002282 */  lb         $v0, 0x1($s1)
    /* 6D7B0 8007CFB0 00000000 */  nop
    /* 6D7B4 8007CFB4 14004814 */  bne        $v0, $t0, .L8007D008
    /* 6D7B8 8007CFB8 00000000 */   nop
    /* 6D7BC 8007CFBC FFFF2292 */  lbu        $v0, -0x1($s1)
    /* 6D7C0 8007CFC0 00000000 */  nop
    /* 6D7C4 8007CFC4 0200422C */  sltiu      $v0, $v0, 0x2
    /* 6D7C8 8007CFC8 0A004014 */  bnez       $v0, .L8007CFF4
    /* 6D7CC 8007CFCC 21180000 */   addu      $v1, $zero, $zero
    /* 6D7D0 8007CFD0 EA9D030C */  jal        random
    /* 6D7D4 8007CFD4 00000000 */   nop
    /* 6D7D8 8007CFD8 FFFF2392 */  lbu        $v1, -0x1($s1)
    /* 6D7DC 8007CFDC 00000000 */  nop
    /* 6D7E0 8007CFE0 1B004300 */  divu       $zero, $v0, $v1
    /* 6D7E4 8007CFE4 02006014 */  bnez       $v1, .L8007CFF0
    /* 6D7E8 8007CFE8 00000000 */   nop
    /* 6D7EC 8007CFEC 0D000700 */  break      7
  .L8007CFF0:
    /* 6D7F0 8007CFF0 10180000 */  mfhi       $v1
  .L8007CFF4:
    /* 6D7F4 8007CFF4 FEFF2292 */  lbu        $v0, -0x2($s1)
    /* 6D7F8 8007CFF8 00000000 */  nop
    /* 6D7FC 8007CFFC 21105200 */  addu       $v0, $v0, $s2
    /* 6D800 8007D000 21104300 */  addu       $v0, $v0, $v1
    /* 6D804 8007D004 F8FF22A6 */  sh         $v0, -0x8($s1)
  .L8007D008:
    /* 6D808 8007D008 0000A28E */  lw         $v0, 0x0($s5)
    /* 6D80C 8007D00C 4400A88F */  lw         $t0, 0x44($sp)
    /* 6D810 8007D010 00000000 */  nop
    /* 6D814 8007D014 23204800 */  subu       $a0, $v0, $t0
    /* 6D818 8007D018 0200801C */  bgtz       $a0, .L8007D024
    /* 6D81C 8007D01C 00000000 */   nop
    /* 6D820 8007D020 23200201 */  subu       $a0, $t0, $v0
  .L8007D024:
    /* 6D824 8007D024 F4FF228E */  lw         $v0, -0xC($s1)
    /* 6D828 8007D028 4800A88F */  lw         $t0, 0x48($sp)
    /* 6D82C 8007D02C 00000000 */  nop
    /* 6D830 8007D030 23184800 */  subu       $v1, $v0, $t0
    /* 6D834 8007D034 0200601C */  bgtz       $v1, .L8007D040
    /* 6D838 8007D038 00000000 */   nop
    /* 6D83C 8007D03C 23180201 */  subu       $v1, $t0, $v0
  .L8007D040:
    /* 6D840 8007D040 2A106400 */  slt        $v0, $v1, $a0
    /* 6D844 8007D044 03004010 */  beqz       $v0, .L8007D054
    /* 6D848 8007D048 83100300 */   sra       $v0, $v1, 2
    /* 6D84C 8007D04C 17F40108 */  j          .L8007D05C
    /* 6D850 8007D050 21188200 */   addu      $v1, $a0, $v0
  .L8007D054:
    /* 6D854 8007D054 83100400 */  sra        $v0, $a0, 2
    /* 6D858 8007D058 21186200 */  addu       $v1, $v1, $v0
  .L8007D05C:
    /* 6D85C 8007D05C FCFF2286 */  lh         $v0, -0x4($s1)
    /* 6D860 8007D060 00000000 */  nop
    /* 6D864 8007D064 64004224 */  addiu      $v0, $v0, 0x64
    /* 6D868 8007D068 00140200 */  sll        $v0, $v0, 16
    /* 6D86C 8007D06C 2A106200 */  slt        $v0, $v1, $v0
    /* 6D870 8007D070 05004014 */  bnez       $v0, .L8007D088
    /* 6D874 8007D074 21B00000 */   addu      $s6, $zero, $zero
    /* 6D878 8007D078 01002282 */  lb         $v0, 0x1($s1)
    /* 6D87C 8007D07C 00000000 */  nop
    /* 6D880 8007D080 A6004004 */  bltz       $v0, .L8007D31C
    /* 6D884 8007D084 00000000 */   nop
  .L8007D088:
    /* 6D888 8007D088 00002292 */  lbu        $v0, 0x0($s1)
    /* 6D88C 8007D08C 00000000 */  nop
    /* 6D890 8007D090 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 6D894 8007D094 2000422C */  sltiu      $v0, $v0, 0x20
    /* 6D898 8007D098 97004010 */  beqz       $v0, .L8007D2F8
    /* 6D89C 8007D09C 80001324 */   addiu     $s3, $zero, 0x80
    /* 6D8A0 8007D0A0 8D008012 */  beqz       $s4, .L8007D2D8
    /* 6D8A4 8007D0A4 00000000 */   nop
    /* 6D8A8 8007D0A8 FEFF2292 */  lbu        $v0, -0x2($s1)
    /* 6D8AC 8007D0AC 00000000 */  nop
    /* 6D8B0 8007D0B0 F8FF22A6 */  sh         $v0, -0x8($s1)
    /* 6D8B4 8007D0B4 FBFF2292 */  lbu        $v0, -0x5($s1)
    /* 6D8B8 8007D0B8 3800A48F */  lw         $a0, 0x38($sp)
    /* 6D8BC 8007D0BC C0180200 */  sll        $v1, $v0, 3
    /* 6D8C0 8007D0C0 2A108300 */  slt        $v0, $a0, $v1
    /* 6D8C4 8007D0C4 03004010 */  beqz       $v0, .L8007D0D4
    /* 6D8C8 8007D0C8 80006224 */   addiu     $v0, $v1, 0x80
    /* 6D8CC 8007D0CC 39F40108 */  j          .L8007D0E4
    /* 6D8D0 8007D0D0 2198C002 */   addu      $s3, $s6, $zero
  .L8007D0D4:
    /* 6D8D4 8007D0D4 2A108200 */  slt        $v0, $a0, $v0
    /* 6D8D8 8007D0D8 02004010 */  beqz       $v0, .L8007D0E4
    /* 6D8DC 8007D0DC 00000000 */   nop
    /* 6D8E0 8007D0E0 23988300 */  subu       $s3, $a0, $v1
  .L8007D0E4:
    /* 6D8E4 8007D0E4 FFFF2292 */  lbu        $v0, -0x1($s1)
    /* 6D8E8 8007D0E8 00000000 */  nop
    /* 6D8EC 8007D0EC C0200200 */  sll        $a0, $v0, 3
    /* 6D8F0 8007D0F0 0B008010 */  beqz       $a0, .L8007D120
    /* 6D8F4 8007D0F4 80008224 */   addiu     $v0, $a0, 0x80
    /* 6D8F8 8007D0F8 3800A38F */  lw         $v1, 0x38($sp)
    /* 6D8FC 8007D0FC 00000000 */  nop
    /* 6D900 8007D100 2A104300 */  slt        $v0, $v0, $v1
    /* 6D904 8007D104 03004010 */  beqz       $v0, .L8007D114
    /* 6D908 8007D108 2A108300 */   slt       $v0, $a0, $v1
    /* 6D90C 8007D10C 48F40108 */  j          .L8007D120
    /* 6D910 8007D110 21980000 */   addu      $s3, $zero, $zero
  .L8007D114:
    /* 6D914 8007D114 02004010 */  beqz       $v0, .L8007D120
    /* 6D918 8007D118 80FF6224 */   addiu     $v0, $v1, -0x80
    /* 6D91C 8007D11C 23988200 */  subu       $s3, $a0, $v0
  .L8007D120:
    /* 6D920 8007D120 5C00601A */  blez       $s3, .L8007D294
    /* 6D924 8007D124 20004326 */   addiu     $v1, $s2, 0x20
    /* 6D928 8007D128 3C00A28F */  lw         $v0, 0x3C($sp)
    /* 6D92C 8007D12C 00000000 */  nop
    /* 6D930 8007D130 FFFF5024 */  addiu      $s0, $v0, -0x1
    /* 6D934 8007D134 2A107000 */  slt        $v0, $v1, $s0
    /* 6D938 8007D138 02004010 */  beqz       $v0, .L8007D144
    /* 6D93C 8007D13C 21208002 */   addu      $a0, $s4, $zero
    /* 6D940 8007D140 21806000 */  addu       $s0, $v1, $zero
  .L8007D144:
    /* 6D944 8007D144 01000524 */  addiu      $a1, $zero, 0x1
    /* 6D948 8007D148 21300002 */  addu       $a2, $s0, $zero
    /* 6D94C 8007D14C 2800A727 */  addiu      $a3, $sp, 0x28
    /* 6D950 8007D150 1000A0AF */  sw         $zero, 0x10($sp)
    /* 6D954 8007D154 4BD0010C */  jal        Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4
    /* 6D958 8007D158 1400A0AF */   sw        $zero, 0x14($sp)
    /* 6D95C 8007D15C 23301202 */  subu       $a2, $s0, $s2
    /* 6D960 8007D160 20000224 */  addiu      $v0, $zero, 0x20
    /* 6D964 8007D164 1300C214 */  bne        $a2, $v0, .L8007D1B4
    /* 6D968 8007D168 00000000 */   nop
    /* 6D96C 8007D16C 2800A28F */  lw         $v0, 0x28($sp)
    /* 6D970 8007D170 0000A38E */  lw         $v1, 0x0($s5)
    /* 6D974 8007D174 00000000 */  nop
    /* 6D978 8007D178 23104300 */  subu       $v0, $v0, $v1
    /* 6D97C 8007D17C 40100200 */  sll        $v0, $v0, 1
    /* 6D980 8007D180 1800A2AF */  sw         $v0, 0x18($sp)
    /* 6D984 8007D184 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 6D988 8007D188 F0FF238E */  lw         $v1, -0x10($s1)
    /* 6D98C 8007D18C 00000000 */  nop
    /* 6D990 8007D190 23104300 */  subu       $v0, $v0, $v1
    /* 6D994 8007D194 40100200 */  sll        $v0, $v0, 1
    /* 6D998 8007D198 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 6D99C 8007D19C 3000A28F */  lw         $v0, 0x30($sp)
    /* 6D9A0 8007D1A0 F4FF238E */  lw         $v1, -0xC($s1)
    /* 6D9A4 8007D1A4 1800B627 */  addiu      $s6, $sp, 0x18
    /* 6D9A8 8007D1A8 23104300 */  subu       $v0, $v0, $v1
    /* 6D9AC 8007D1AC A4F40108 */  j          .L8007D290
    /* 6D9B0 8007D1B0 40100200 */   sll       $v0, $v0, 1
  .L8007D1B4:
    /* 6D9B4 8007D1B4 3700C010 */  beqz       $a2, .L8007D294
    /* 6D9B8 8007D1B8 00000000 */   nop
    /* 6D9BC 8007D1BC 2800A28F */  lw         $v0, 0x28($sp)
    /* 6D9C0 8007D1C0 0000A38E */  lw         $v1, 0x0($s5)
    /* 6D9C4 8007D1C4 00000000 */  nop
    /* 6D9C8 8007D1C8 23104300 */  subu       $v0, $v0, $v1
    /* 6D9CC 8007D1CC 80110200 */  sll        $v0, $v0, 6
    /* 6D9D0 8007D1D0 1A004600 */  div        $zero, $v0, $a2
    /* 6D9D4 8007D1D4 0200C014 */  bnez       $a2, .L8007D1E0
    /* 6D9D8 8007D1D8 00000000 */   nop
    /* 6D9DC 8007D1DC 0D000700 */  break      7
  .L8007D1E0:
    /* 6D9E0 8007D1E0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6D9E4 8007D1E4 0400C114 */  bne        $a2, $at, .L8007D1F8
    /* 6D9E8 8007D1E8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6D9EC 8007D1EC 02004114 */  bne        $v0, $at, .L8007D1F8
    /* 6D9F0 8007D1F0 00000000 */   nop
    /* 6D9F4 8007D1F4 0D000600 */  break      6
  .L8007D1F8:
    /* 6D9F8 8007D1F8 12100000 */  mflo       $v0
    /* 6D9FC 8007D1FC 00000000 */  nop
    /* 6DA00 8007D200 1800A2AF */  sw         $v0, 0x18($sp)
    /* 6DA04 8007D204 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 6DA08 8007D208 F0FF238E */  lw         $v1, -0x10($s1)
    /* 6DA0C 8007D20C 00000000 */  nop
    /* 6DA10 8007D210 23104300 */  subu       $v0, $v0, $v1
    /* 6DA14 8007D214 80110200 */  sll        $v0, $v0, 6
    /* 6DA18 8007D218 1A004600 */  div        $zero, $v0, $a2
    /* 6DA1C 8007D21C 0200C014 */  bnez       $a2, .L8007D228
    /* 6DA20 8007D220 00000000 */   nop
    /* 6DA24 8007D224 0D000700 */  break      7
  .L8007D228:
    /* 6DA28 8007D228 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6DA2C 8007D22C 0400C114 */  bne        $a2, $at, .L8007D240
    /* 6DA30 8007D230 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6DA34 8007D234 02004114 */  bne        $v0, $at, .L8007D240
    /* 6DA38 8007D238 00000000 */   nop
    /* 6DA3C 8007D23C 0D000600 */  break      6
  .L8007D240:
    /* 6DA40 8007D240 12100000 */  mflo       $v0
    /* 6DA44 8007D244 00000000 */  nop
    /* 6DA48 8007D248 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 6DA4C 8007D24C 3000A28F */  lw         $v0, 0x30($sp)
    /* 6DA50 8007D250 F4FF238E */  lw         $v1, -0xC($s1)
    /* 6DA54 8007D254 00000000 */  nop
    /* 6DA58 8007D258 23104300 */  subu       $v0, $v0, $v1
    /* 6DA5C 8007D25C 80110200 */  sll        $v0, $v0, 6
    /* 6DA60 8007D260 1A004600 */  div        $zero, $v0, $a2
    /* 6DA64 8007D264 0200C014 */  bnez       $a2, .L8007D270
    /* 6DA68 8007D268 00000000 */   nop
    /* 6DA6C 8007D26C 0D000700 */  break      7
  .L8007D270:
    /* 6DA70 8007D270 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6DA74 8007D274 0400C114 */  bne        $a2, $at, .L8007D288
    /* 6DA78 8007D278 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6DA7C 8007D27C 02004114 */  bne        $v0, $at, .L8007D288
    /* 6DA80 8007D280 00000000 */   nop
    /* 6DA84 8007D284 0D000600 */  break      6
  .L8007D288:
    /* 6DA88 8007D288 12100000 */  mflo       $v0
    /* 6DA8C 8007D28C 1800B627 */  addiu      $s6, $sp, 0x18
  .L8007D290:
    /* 6DA90 8007D290 2000A2AF */  sw         $v0, 0x20($sp)
  .L8007D294:
    /* 6DA94 8007D294 3C00A28F */  lw         $v0, 0x3C($sp)
    /* 6DA98 8007D298 00000000 */  nop
    /* 6DA9C 8007D29C 0C004018 */  blez       $v0, .L8007D2D0
    /* 6DAA0 8007D2A0 00000000 */   nop
    /* 6DAA4 8007D2A4 1A004202 */  div        $zero, $s2, $v0
    /* 6DAA8 8007D2A8 02004014 */  bnez       $v0, .L8007D2B4
    /* 6DAAC 8007D2AC 00000000 */   nop
    /* 6DAB0 8007D2B0 0D000700 */  break      7
  .L8007D2B4:
    /* 6DAB4 8007D2B4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6DAB8 8007D2B8 04004114 */  bne        $v0, $at, .L8007D2CC
    /* 6DABC 8007D2BC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6DAC0 8007D2C0 02004116 */  bne        $s2, $at, .L8007D2CC
    /* 6DAC4 8007D2C4 00000000 */   nop
    /* 6DAC8 8007D2C8 0D000600 */  break      6
  .L8007D2CC:
    /* 6DACC 8007D2CC 10900000 */  mfhi       $s2
  .L8007D2D0:
    /* 6DAD0 8007D2D0 00000000 */  nop
    /* 6DAD4 8007D2D4 C3901200 */  sra        $s2, $s2, 3
  .L8007D2D8:
    /* 6DAD8 8007D2D8 00002292 */  lbu        $v0, 0x0($s1)
    /* 6DADC 8007D2DC 00000000 */  nop
    /* 6DAE0 8007D2E0 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 6DAE4 8007D2E4 2000422C */  sltiu      $v0, $v0, 0x20
    /* 6DAE8 8007D2E8 04004010 */  beqz       $v0, .L8007D2FC
    /* 6DAEC 8007D2EC 2120A002 */   addu      $a0, $s5, $zero
    /* 6DAF0 8007D2F0 0A008012 */  beqz       $s4, .L8007D31C
    /* 6DAF4 8007D2F4 00000000 */   nop
  .L8007D2F8:
    /* 6DAF8 8007D2F8 2120A002 */  addu       $a0, $s5, $zero
  .L8007D2FC:
    /* 6DAFC 8007D2FC 21284002 */  addu       $a1, $s2, $zero
    /* 6DB00 8007D300 7800A88F */  lw         $t0, 0x78($sp)
    /* 6DB04 8007D304 2130C002 */  addu       $a2, $s6, $zero
    /* 6DB08 8007D308 1000A8AF */  sw         $t0, 0x10($sp)
    /* 6DB0C 8007D30C 7C00A88F */  lw         $t0, 0x7C($sp)
    /* 6DB10 8007D310 21386002 */  addu       $a3, $s3, $zero
    /* 6DB14 8007D314 D4F1010C */  jal        AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
    /* 6DB18 8007D318 1400A8AF */   sw        $t0, 0x14($sp)
  .L8007D31C:
    /* 6DB1C 8007D31C 18003126 */  addiu      $s1, $s1, 0x18
    /* 6DB20 8007D320 1800B526 */  addiu      $s5, $s5, 0x18
    /* 6DB24 8007D324 B1F30108 */  j          .L8007CEC4
    /* 6DB28 8007D328 0100F726 */   addiu     $s7, $s7, 0x1
  .L8007D32C:
    /* 6DB2C 8007D32C 7400BF8F */  lw         $ra, 0x74($sp)
    /* 6DB30 8007D330 7000BE8F */  lw         $fp, 0x70($sp)
    /* 6DB34 8007D334 6C00B78F */  lw         $s7, 0x6C($sp)
    /* 6DB38 8007D338 6800B68F */  lw         $s6, 0x68($sp)
    /* 6DB3C 8007D33C 6400B58F */  lw         $s5, 0x64($sp)
    /* 6DB40 8007D340 6000B48F */  lw         $s4, 0x60($sp)
    /* 6DB44 8007D344 5C00B38F */  lw         $s3, 0x5C($sp)
    /* 6DB48 8007D348 5800B28F */  lw         $s2, 0x58($sp)
    /* 6DB4C 8007D34C 5400B18F */  lw         $s1, 0x54($sp)
    /* 6DB50 8007D350 5000B08F */  lw         $s0, 0x50($sp)
    /* 6DB54 8007D354 0800E003 */  jr         $ra
    /* 6DB58 8007D358 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel AudioTrk_SoundTrack__FP8Car_tObji
