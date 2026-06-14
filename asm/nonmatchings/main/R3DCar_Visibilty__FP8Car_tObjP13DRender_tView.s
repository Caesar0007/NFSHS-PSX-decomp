.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_Visibilty__FP8Car_tObjP13DRender_tView, 0x3A8

glabel R3DCar_Visibilty__FP8Car_tObjP13DRender_tView
    /* 9FF4C 800AF74C 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 9FF50 800AF750 5400B1AF */  sw         $s1, 0x54($sp)
    /* 9FF54 800AF754 21888000 */  addu       $s1, $a0, $zero
    /* 9FF58 800AF758 5C00B3AF */  sw         $s3, 0x5C($sp)
    /* 9FF5C 800AF75C 2198A000 */  addu       $s3, $a1, $zero
    /* 9FF60 800AF760 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 9FF64 800AF764 5000B0AF */  sw         $s0, 0x50($sp)
    /* 9FF68 800AF768 ACF25024 */  addiu      $s0, $v0, %lo(Camera_gInfo)
    /* 9FF6C 800AF76C 6800BFAF */  sw         $ra, 0x68($sp)
    /* 9FF70 800AF770 6400B5AF */  sw         $s5, 0x64($sp)
    /* 9FF74 800AF774 6000B4AF */  sw         $s4, 0x60($sp)
    /* 9FF78 800AF778 5800B2AF */  sw         $s2, 0x58($sp)
    /* 9FF7C 800AF77C 0400648E */  lw         $a0, 0x4($s3)
    /* 9FF80 800AF780 21A80000 */  addu       $s5, $zero, $zero
    /* 9FF84 800AF784 00110400 */  sll        $v0, $a0, 4
    /* 9FF88 800AF788 21104400 */  addu       $v0, $v0, $a0
    /* 9FF8C 800AF78C 00110200 */  sll        $v0, $v0, 4
    /* 9FF90 800AF790 21105000 */  addu       $v0, $v0, $s0
    /* 9FF94 800AF794 7400458C */  lw         $a1, 0x74($v0)
    /* 9FF98 800AF798 0000428C */  lw         $v0, 0x0($v0)
    /* 9FF9C 800AF79C 421E0500 */  srl        $v1, $a1, 25
    /* 9FFA0 800AF7A0 23005114 */  bne        $v0, $s1, .L800AF830
    /* 9FFA4 800AF7A4 03007230 */   andi      $s2, $v1, 0x3
    /* 9FFA8 800AF7A8 6002228E */  lw         $v0, 0x260($s1)
    /* 9FFAC 800AF7AC 00000000 */  nop
    /* 9FFB0 800AF7B0 04004230 */  andi       $v0, $v0, 0x4
    /* 9FFB4 800AF7B4 1E004010 */  beqz       $v0, .L800AF830
    /* 9FFB8 800AF7B8 C2160500 */   srl       $v0, $a1, 27
    /* 9FFBC 800AF7BC 01004230 */  andi       $v0, $v0, 0x1
    /* 9FFC0 800AF7C0 1B004010 */  beqz       $v0, .L800AF830
    /* 9FFC4 800AF7C4 00000000 */   nop
    /* 9FFC8 800AF7C8 5A15020C */  jal        Camera_GetMode__Fi
    /* 9FFCC 800AF7CC 00000000 */   nop
    /* 9FFD0 800AF7D0 B8004010 */  beqz       $v0, .L800AFAB4
    /* 9FFD4 800AF7D4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 9FFD8 800AF7D8 0400648E */  lw         $a0, 0x4($s3)
    /* 9FFDC 800AF7DC 00000000 */  nop
    /* 9FFE0 800AF7E0 00110400 */  sll        $v0, $a0, 4
    /* 9FFE4 800AF7E4 21104400 */  addu       $v0, $v0, $a0
    /* 9FFE8 800AF7E8 00110200 */  sll        $v0, $v0, 4
    /* 9FFEC 800AF7EC 21105000 */  addu       $v0, $v0, $s0
    /* 9FFF0 800AF7F0 7400428C */  lw         $v0, 0x74($v0)
    /* 9FFF4 800AF7F4 00000000 */  nop
    /* 9FFF8 800AF7F8 C2160200 */  srl        $v0, $v0, 27
    /* 9FFFC 800AF7FC 01004230 */  andi       $v0, $v0, 0x1
    /* A0000 800AF800 0B004010 */  beqz       $v0, .L800AF830
    /* A0004 800AF804 00000000 */   nop
    /* A0008 800AF808 5A15020C */  jal        Camera_GetMode__Fi
    /* A000C 800AF80C 00000000 */   nop
    /* A0010 800AF810 01000324 */  addiu      $v1, $zero, 0x1
    /* A0014 800AF814 06004314 */  bne        $v0, $v1, .L800AF830
    /* A0018 800AF818 00000000 */   nop
    /* A001C 800AF81C C0082296 */  lhu        $v0, 0x8C0($s1)
    /* A0020 800AF820 00000000 */  nop
    /* A0024 800AF824 24104300 */  and        $v0, $v0, $v1
    /* A0028 800AF828 A1004010 */  beqz       $v0, .L800AFAB0
    /* A002C 800AF82C 01001524 */   addiu     $s5, $zero, 0x1
  .L800AF830:
    /* A0030 800AF830 91002292 */  lbu        $v0, 0x91($s1)
    /* A0034 800AF834 00000000 */  nop
    /* A0038 800AF838 9D004010 */  beqz       $v0, .L800AFAB0
    /* A003C 800AF83C 0C00103C */   lui       $s0, (0xC0000 >> 16)
    /* A0040 800AF840 3C00143C */  lui        $s4, (0x3C0000 >> 16)
    /* A0044 800AF844 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A0048 800AF848 F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A004C 800AF84C 02000224 */  addiu      $v0, $zero, 0x2
    /* A0050 800AF850 07006210 */  beq        $v1, $v0, .L800AF870
    /* A0054 800AF854 C20820A6 */   sh        $zero, 0x8C2($s1)
    /* A0058 800AF858 0400648E */  lw         $a0, 0x4($s3)
    /* A005C 800AF85C 5A15020C */  jal        Camera_GetMode__Fi
    /* A0060 800AF860 00000000 */   nop
    /* A0064 800AF864 0E000324 */  addiu      $v1, $zero, 0xE
    /* A0068 800AF868 03004314 */  bne        $v0, $v1, .L800AF878
    /* A006C 800AF86C 00000000 */   nop
  .L800AF870:
    /* A0070 800AF870 2400103C */  lui        $s0, (0x240000 >> 16)
    /* A0074 800AF874 7800143C */  lui        $s4, (0x780000 >> 16)
  .L800AF878:
    /* A0078 800AF878 09004012 */  beqz       $s2, .L800AF8A0
    /* A007C 800AF87C 18001202 */   mult      $s0, $s2
    /* A0080 800AF880 12800000 */  mflo       $s0
    /* A0084 800AF884 00000000 */  nop
    /* A0088 800AF888 00000000 */  nop
    /* A008C 800AF88C 18009202 */  mult       $s4, $s2
    /* A0090 800AF890 40101000 */  sll        $v0, $s0, 1
    /* A0094 800AF894 21800202 */  addu       $s0, $s0, $v0
    /* A0098 800AF898 12A00000 */  mflo       $s4
    /* A009C 800AF89C 40A01400 */  sll        $s4, $s4, 1
  .L800AF8A0:
    /* A00A0 800AF8A0 A000238E */  lw         $v1, 0xA0($s1)
    /* A00A4 800AF8A4 0800628E */  lw         $v0, 0x8($s3)
    /* A00A8 800AF8A8 00000000 */  nop
    /* A00AC 800AF8AC 23286200 */  subu       $a1, $v1, $v0
    /* A00B0 800AF8B0 4000A5AF */  sw         $a1, 0x40($sp)
    /* A00B4 800AF8B4 A400238E */  lw         $v1, 0xA4($s1)
    /* A00B8 800AF8B8 0C00628E */  lw         $v0, 0xC($s3)
    /* A00BC 800AF8BC 00000000 */  nop
    /* A00C0 800AF8C0 23306200 */  subu       $a2, $v1, $v0
    /* A00C4 800AF8C4 4400A6AF */  sw         $a2, 0x44($sp)
    /* A00C8 800AF8C8 A800238E */  lw         $v1, 0xA8($s1)
    /* A00CC 800AF8CC 1000628E */  lw         $v0, 0x10($s3)
    /* A00D0 800AF8D0 2120A000 */  addu       $a0, $a1, $zero
    /* A00D4 800AF8D4 23186200 */  subu       $v1, $v1, $v0
    /* A00D8 800AF8D8 0200A104 */  bgez       $a1, .L800AF8E4
    /* A00DC 800AF8DC 4800A3AF */   sw        $v1, 0x48($sp)
    /* A00E0 800AF8E0 FF00A424 */  addiu      $a0, $a1, 0xFF
  .L800AF8E4:
    /* A00E4 800AF8E4 1400628E */  lw         $v0, 0x14($s3)
    /* A00E8 800AF8E8 00000000 */  nop
    /* A00EC 800AF8EC 02004104 */  bgez       $v0, .L800AF8F8
    /* A00F0 800AF8F0 034A0400 */   sra       $t1, $a0, 8
    /* A00F4 800AF8F4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AF8F8:
    /* A00F8 800AF8F8 03120200 */  sra        $v0, $v0, 8
    /* A00FC 800AF8FC 18002201 */  mult       $t1, $v0
    /* A0100 800AF900 12380000 */  mflo       $a3
    /* A0104 800AF904 0200C104 */  bgez       $a2, .L800AF910
    /* A0108 800AF908 2120C000 */   addu      $a0, $a2, $zero
    /* A010C 800AF90C FF00C424 */  addiu      $a0, $a2, 0xFF
  .L800AF910:
    /* A0110 800AF910 1800628E */  lw         $v0, 0x18($s3)
    /* A0114 800AF914 00000000 */  nop
    /* A0118 800AF918 02004104 */  bgez       $v0, .L800AF924
    /* A011C 800AF91C 03420400 */   sra       $t0, $a0, 8
    /* A0120 800AF920 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AF924:
    /* A0124 800AF924 03120200 */  sra        $v0, $v0, 8
    /* A0128 800AF928 18000201 */  mult       $t0, $v0
    /* A012C 800AF92C 12500000 */  mflo       $t2
    /* A0130 800AF930 02006104 */  bgez       $v1, .L800AF93C
    /* A0134 800AF934 2120EA00 */   addu      $a0, $a3, $t2
    /* A0138 800AF938 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AF93C:
    /* A013C 800AF93C 1C00628E */  lw         $v0, 0x1C($s3)
    /* A0140 800AF940 00000000 */  nop
    /* A0144 800AF944 02004104 */  bgez       $v0, .L800AF950
    /* A0148 800AF948 031A0300 */   sra       $v1, $v1, 8
    /* A014C 800AF94C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AF950:
    /* A0150 800AF950 03120200 */  sra        $v0, $v0, 8
    /* A0154 800AF954 18006200 */  mult       $v1, $v0
    /* A0158 800AF958 12500000 */  mflo       $t2
    /* A015C 800AF95C 21108A00 */  addu       $v0, $a0, $t2
    /* A0160 800AF960 1000A2AF */  sw         $v0, 0x10($sp)
    /* A0164 800AF964 2C00628E */  lw         $v0, 0x2C($s3)
    /* A0168 800AF968 00000000 */  nop
    /* A016C 800AF96C 02004104 */  bgez       $v0, .L800AF978
    /* A0170 800AF970 00000000 */   nop
    /* A0174 800AF974 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AF978:
    /* A0178 800AF978 03120200 */  sra        $v0, $v0, 8
    /* A017C 800AF97C 18002201 */  mult       $t1, $v0
    /* A0180 800AF980 12180000 */  mflo       $v1
    /* A0184 800AF984 3000628E */  lw         $v0, 0x30($s3)
    /* A0188 800AF988 00000000 */  nop
    /* A018C 800AF98C 02004104 */  bgez       $v0, .L800AF998
    /* A0190 800AF990 00000000 */   nop
    /* A0194 800AF994 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AF998:
    /* A0198 800AF998 03120200 */  sra        $v0, $v0, 8
    /* A019C 800AF99C 18000201 */  mult       $t0, $v0
    /* A01A0 800AF9A0 4800A48F */  lw         $a0, 0x48($sp)
    /* A01A4 800AF9A4 12500000 */  mflo       $t2
    /* A01A8 800AF9A8 02008104 */  bgez       $a0, .L800AF9B4
    /* A01AC 800AF9AC 21186A00 */   addu      $v1, $v1, $t2
    /* A01B0 800AF9B0 FF008424 */  addiu      $a0, $a0, 0xFF
  .L800AF9B4:
    /* A01B4 800AF9B4 3400628E */  lw         $v0, 0x34($s3)
    /* A01B8 800AF9B8 00000000 */  nop
    /* A01BC 800AF9BC 02004104 */  bgez       $v0, .L800AF9C8
    /* A01C0 800AF9C0 03220400 */   sra       $a0, $a0, 8
    /* A01C4 800AF9C4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AF9C8:
    /* A01C8 800AF9C8 03120200 */  sra        $v0, $v0, 8
    /* A01CC 800AF9CC 18008200 */  mult       $a0, $v0
    /* A01D0 800AF9D0 CB00023C */  lui        $v0, (0xCB0000 >> 16)
    /* A01D4 800AF9D4 12500000 */  mflo       $t2
    /* A01D8 800AF9D8 21206A00 */  addu       $a0, $v1, $t2
    /* A01DC 800AF9DC 0300033C */  lui        $v1, (0x30000 >> 16)
    /* A01E0 800AF9E0 21188300 */  addu       $v1, $a0, $v1
    /* A01E4 800AF9E4 2B104300 */  sltu       $v0, $v0, $v1
    /* A01E8 800AF9E8 31004014 */  bnez       $v0, .L800AFAB0
    /* A01EC 800AF9EC 1800A4AF */   sw        $a0, 0x18($sp)
    /* A01F0 800AF9F0 21408000 */  addu       $t0, $a0, $zero
    /* A01F4 800AF9F4 2A100802 */  slt        $v0, $s0, $t0
    /* A01F8 800AF9F8 02004010 */  beqz       $v0, .L800AFA04
    /* A01FC 800AF9FC 01000224 */   addiu     $v0, $zero, 0x1
    /* A0200 800AFA00 C20822A6 */  sh         $v0, 0x8C2($s1)
  .L800AFA04:
    /* A0204 800AFA04 1800A28F */  lw         $v0, 0x18($sp)
    /* A0208 800AFA08 00000000 */  nop
    /* A020C 800AFA0C 2A108202 */  slt        $v0, $s4, $v0
    /* A0210 800AFA10 02004010 */  beqz       $v0, .L800AFA1C
    /* A0214 800AFA14 02000224 */   addiu     $v0, $zero, 0x2
    /* A0218 800AFA18 C20822A6 */  sh         $v0, 0x8C2($s1)
  .L800AFA1C:
    /* A021C 800AFA1C 1000A28F */  lw         $v0, 0x10($sp)
    /* A0220 800AFA20 1800A38F */  lw         $v1, 0x18($sp)
    /* A0224 800AFA24 3400A2AF */  sw         $v0, 0x34($sp)
    /* A0228 800AFA28 2800A2AF */  sw         $v0, 0x28($sp)
    /* A022C 800AFA2C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* A0230 800AFA30 3C00A3AF */  sw         $v1, 0x3C($sp)
    /* A0234 800AFA34 3000A3AF */  sw         $v1, 0x30($sp)
    /* A0238 800AFA38 2400A3AF */  sw         $v1, 0x24($sp)
    /* A023C 800AFA3C 3401258E */  lw         $a1, 0x134($s1)
    /* A0240 800AFA40 3C01268E */  lw         $a2, 0x13C($s1)
    /* A0244 800AFA44 23204500 */  subu       $a0, $v0, $a1
    /* A0248 800AFA48 21386600 */  addu       $a3, $v1, $a2
    /* A024C 800AFA4C 21284500 */  addu       $a1, $v0, $a1
    /* A0250 800AFA50 23186600 */  subu       $v1, $v1, $a2
    /* A0254 800AFA54 1000A4AF */  sw         $a0, 0x10($sp)
    /* A0258 800AFA58 2800A4AF */  sw         $a0, 0x28($sp)
    /* A025C 800AFA5C 02008104 */  bgez       $a0, .L800AFA68
    /* A0260 800AFA60 00000000 */   nop
    /* A0264 800AFA64 23200400 */  negu       $a0, $a0
  .L800AFA68:
    /* A0268 800AFA68 2A10E400 */  slt        $v0, $a3, $a0
    /* A026C 800AFA6C 1800A7AF */  sw         $a3, 0x18($sp)
    /* A0270 800AFA70 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* A0274 800AFA74 2400A7AF */  sw         $a3, 0x24($sp)
    /* A0278 800AFA78 3000A3AF */  sw         $v1, 0x30($sp)
    /* A027C 800AFA7C 3400A5AF */  sw         $a1, 0x34($sp)
    /* A0280 800AFA80 0F004010 */  beqz       $v0, .L800AFAC0
    /* A0284 800AFA84 3C00A3AF */   sw        $v1, 0x3C($sp)
    /* A0288 800AFA88 0200A104 */  bgez       $a1, .L800AFA94
    /* A028C 800AFA8C 00000000 */   nop
    /* A0290 800AFA90 23280500 */  negu       $a1, $a1
  .L800AFA94:
    /* A0294 800AFA94 2A10E500 */  slt        $v0, $a3, $a1
    /* A0298 800AFA98 09004010 */  beqz       $v0, .L800AFAC0
    /* A029C 800AFA9C 2A106400 */   slt       $v0, $v1, $a0
    /* A02A0 800AFAA0 07004010 */  beqz       $v0, .L800AFAC0
    /* A02A4 800AFAA4 2A106500 */   slt       $v0, $v1, $a1
    /* A02A8 800AFAA8 05004010 */  beqz       $v0, .L800AFAC0
    /* A02AC 800AFAAC 00000000 */   nop
  .L800AFAB0:
    /* A02B0 800AFAB0 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800AFAB4:
    /* A02B4 800AFAB4 C20822A6 */  sh         $v0, 0x8C2($s1)
    /* A02B8 800AFAB8 B4BE0208 */  j          .L800AFAD0
    /* A02BC 800AFABC 0080023C */   lui       $v0, (0x80000000 >> 16)
  .L800AFAC0:
    /* A02C0 800AFAC0 0200A012 */  beqz       $s5, .L800AFACC
    /* A02C4 800AFAC4 03000224 */   addiu     $v0, $zero, 0x3
    /* A02C8 800AFAC8 C20822A6 */  sh         $v0, 0x8C2($s1)
  .L800AFACC:
    /* A02CC 800AFACC 21100001 */  addu       $v0, $t0, $zero
  .L800AFAD0:
    /* A02D0 800AFAD0 6800BF8F */  lw         $ra, 0x68($sp)
    /* A02D4 800AFAD4 6400B58F */  lw         $s5, 0x64($sp)
    /* A02D8 800AFAD8 6000B48F */  lw         $s4, 0x60($sp)
    /* A02DC 800AFADC 5C00B38F */  lw         $s3, 0x5C($sp)
    /* A02E0 800AFAE0 5800B28F */  lw         $s2, 0x58($sp)
    /* A02E4 800AFAE4 5400B18F */  lw         $s1, 0x54($sp)
    /* A02E8 800AFAE8 5000B08F */  lw         $s0, 0x50($sp)
    /* A02EC 800AFAEC 0800E003 */  jr         $ra
    /* A02F0 800AFAF0 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel R3DCar_Visibilty__FP8Car_tObjP13DRender_tView
