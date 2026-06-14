.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PutDispEnv, 0x4F8

glabel PutDispEnv
    /* DE5E4 800EDDE4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE5E8 800EDDE8 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE5EC 800EDDEC 21888000 */  addu       $s1, $a0, $zero
    /* DE5F0 800EDDF0 1800B2AF */  sw         $s2, 0x18($sp)
    /* DE5F4 800EDDF4 1280123C */  lui        $s2, %hi(D_8012369E)
    /* DE5F8 800EDDF8 9E365226 */  addiu      $s2, $s2, %lo(D_8012369E)
    /* DE5FC 800EDDFC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DE600 800EDE00 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE604 800EDE04 00004292 */  lbu        $v0, 0x0($s2)
    /* DE608 800EDE08 00000000 */  nop
    /* DE60C 800EDE0C 0200422C */  sltiu      $v0, $v0, 0x2
    /* DE610 800EDE10 08004014 */  bnez       $v0, .L800EDE34
    /* DE614 800EDE14 0008103C */   lui       $s0, (0x8000008 >> 16)
    /* DE618 800EDE18 0580043C */  lui        $a0, %hi(D_80056EA0)
    /* DE61C 800EDE1C A06E8424 */  addiu      $a0, $a0, %lo(D_80056EA0)
    /* DE620 800EDE20 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE624 800EDE24 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE628 800EDE28 00000000 */  nop
    /* DE62C 800EDE2C 09F84000 */  jalr       $v0
    /* DE630 800EDE30 21282002 */   addu      $a1, $s1, $zero
  .L800EDE34:
    /* DE634 800EDE34 0005023C */  lui        $v0, (0x5000000 >> 16)
    /* DE638 800EDE38 02002396 */  lhu        $v1, 0x2($s1)
    /* DE63C 800EDE3C 00002496 */  lhu        $a0, 0x0($s1)
    /* DE640 800EDE40 1280053C */  lui        $a1, %hi(D_80123694)
    /* DE644 800EDE44 9436A58C */  lw         $a1, %lo(D_80123694)($a1)
    /* DE648 800EDE48 FF036330 */  andi       $v1, $v1, 0x3FF
    /* DE64C 800EDE4C 801A0300 */  sll        $v1, $v1, 10
    /* DE650 800EDE50 FF038430 */  andi       $a0, $a0, 0x3FF
    /* DE654 800EDE54 25208200 */  or         $a0, $a0, $v0
    /* DE658 800EDE58 1000A28C */  lw         $v0, 0x10($a1)
    /* DE65C 800EDE5C 00000000 */  nop
    /* DE660 800EDE60 09F84000 */  jalr       $v0
    /* DE664 800EDE64 25206400 */   or        $a0, $v1, $a0
    /* DE668 800EDE68 7A00438E */  lw         $v1, 0x7A($s2)
    /* DE66C 800EDE6C 1000228E */  lw         $v0, 0x10($s1)
    /* DE670 800EDE70 00000000 */  nop
    /* DE674 800EDE74 19006214 */  bne        $v1, $v0, .L800EDEDC
    /* DE678 800EDE78 6A004426 */   addiu     $a0, $s2, 0x6A
    /* DE67C 800EDE7C 6A004296 */  lhu        $v0, 0x6A($s2)
    /* DE680 800EDE80 00002386 */  lh         $v1, 0x0($s1)
    /* DE684 800EDE84 00140200 */  sll        $v0, $v0, 16
    /* DE688 800EDE88 03140200 */  sra        $v0, $v0, 16
    /* DE68C 800EDE8C 13004314 */  bne        $v0, $v1, .L800EDEDC
    /* DE690 800EDE90 00000000 */   nop
    /* DE694 800EDE94 02008294 */  lhu        $v0, 0x2($a0)
    /* DE698 800EDE98 02002386 */  lh         $v1, 0x2($s1)
    /* DE69C 800EDE9C 00140200 */  sll        $v0, $v0, 16
    /* DE6A0 800EDEA0 03140200 */  sra        $v0, $v0, 16
    /* DE6A4 800EDEA4 0D004314 */  bne        $v0, $v1, .L800EDEDC
    /* DE6A8 800EDEA8 00000000 */   nop
    /* DE6AC 800EDEAC 04008294 */  lhu        $v0, 0x4($a0)
    /* DE6B0 800EDEB0 04002386 */  lh         $v1, 0x4($s1)
    /* DE6B4 800EDEB4 00140200 */  sll        $v0, $v0, 16
    /* DE6B8 800EDEB8 03140200 */  sra        $v0, $v0, 16
    /* DE6BC 800EDEBC 07004314 */  bne        $v0, $v1, .L800EDEDC
    /* DE6C0 800EDEC0 00000000 */   nop
    /* DE6C4 800EDEC4 06008294 */  lhu        $v0, 0x6($a0)
    /* DE6C8 800EDEC8 06002386 */  lh         $v1, 0x6($s1)
    /* DE6CC 800EDECC 00140200 */  sll        $v0, $v0, 16
    /* DE6D0 800EDED0 03140200 */  sra        $v0, $v0, 16
    /* DE6D4 800EDED4 3C004310 */  beq        $v0, $v1, .L800EDFC8
    /* DE6D8 800EDED8 00000000 */   nop
  .L800EDEDC:
    /* DE6DC 800EDEDC E1C5030C */  jal        GetVideoMode
    /* DE6E0 800EDEE0 00000000 */   nop
    /* DE6E4 800EDEE4 120022A2 */  sb         $v0, 0x12($s1)
    /* DE6E8 800EDEE8 FF004230 */  andi       $v0, $v0, 0xFF
    /* DE6EC 800EDEEC 01000324 */  addiu      $v1, $zero, 0x1
    /* DE6F0 800EDEF0 02004314 */  bne        $v0, $v1, .L800EDEFC
    /* DE6F4 800EDEF4 00000000 */   nop
    /* DE6F8 800EDEF8 08001036 */  ori        $s0, $s0, (0x8000008 & 0xFFFF)
  .L800EDEFC:
    /* DE6FC 800EDEFC 11002292 */  lbu        $v0, 0x11($s1)
    /* DE700 800EDF00 00000000 */  nop
    /* DE704 800EDF04 02004010 */  beqz       $v0, .L800EDF10
    /* DE708 800EDF08 00000000 */   nop
    /* DE70C 800EDF0C 10001036 */  ori        $s0, $s0, (0x8000010 & 0xFFFF)
  .L800EDF10:
    /* DE710 800EDF10 10002292 */  lbu        $v0, 0x10($s1)
    /* DE714 800EDF14 00000000 */  nop
    /* DE718 800EDF18 02004010 */  beqz       $v0, .L800EDF24
    /* DE71C 800EDF1C 00000000 */   nop
    /* DE720 800EDF20 20001036 */  ori        $s0, $s0, (0x8000020 & 0xFFFF)
  .L800EDF24:
    /* DE724 800EDF24 1280023C */  lui        $v0, %hi(D_8012369F)
    /* DE728 800EDF28 9F364290 */  lbu        $v0, %lo(D_8012369F)($v0)
    /* DE72C 800EDF2C 00000000 */  nop
    /* DE730 800EDF30 02004010 */  beqz       $v0, .L800EDF3C
    /* DE734 800EDF34 00000000 */   nop
    /* DE738 800EDF38 80001036 */  ori        $s0, $s0, (0x8000080 & 0xFFFF)
  .L800EDF3C:
    /* DE73C 800EDF3C 04002386 */  lh         $v1, 0x4($s1)
    /* DE740 800EDF40 00000000 */  nop
    /* DE744 800EDF44 19016228 */  slti       $v0, $v1, 0x119
    /* DE748 800EDF48 0E004014 */  bnez       $v0, .L800EDF84
    /* DE74C 800EDF4C 61016228 */   slti      $v0, $v1, 0x161
    /* DE750 800EDF50 03004010 */  beqz       $v0, .L800EDF60
    /* DE754 800EDF54 91016228 */   slti      $v0, $v1, 0x191
    /* DE758 800EDF58 E1B70308 */  j          .L800EDF84
    /* DE75C 800EDF5C 01001036 */   ori       $s0, $s0, (0x8000001 & 0xFFFF)
  .L800EDF60:
    /* DE760 800EDF60 03004010 */  beqz       $v0, .L800EDF70
    /* DE764 800EDF64 31026228 */   slti      $v0, $v1, 0x231
    /* DE768 800EDF68 E1B70308 */  j          .L800EDF84
    /* DE76C 800EDF6C 40001036 */   ori       $s0, $s0, (0x8000040 & 0xFFFF)
  .L800EDF70:
    /* DE770 800EDF70 03004010 */  beqz       $v0, .L800EDF80
    /* DE774 800EDF74 00000000 */   nop
    /* DE778 800EDF78 E1B70308 */  j          .L800EDF84
    /* DE77C 800EDF7C 02001036 */   ori       $s0, $s0, (0x8000002 & 0xFFFF)
  .L800EDF80:
    /* DE780 800EDF80 03001036 */  ori        $s0, $s0, (0x8000003 & 0xFFFF)
  .L800EDF84:
    /* DE784 800EDF84 12002292 */  lbu        $v0, 0x12($s1)
    /* DE788 800EDF88 06002386 */  lh         $v1, 0x6($s1)
    /* DE78C 800EDF8C 02004014 */  bnez       $v0, .L800EDF98
    /* DE790 800EDF90 21016228 */   slti      $v0, $v1, 0x121
    /* DE794 800EDF94 01016228 */  slti       $v0, $v1, 0x101
  .L800EDF98:
    /* DE798 800EDF98 02004014 */  bnez       $v0, .L800EDFA4
    /* DE79C 800EDF9C 00000000 */   nop
    /* DE7A0 800EDFA0 24001036 */  ori        $s0, $s0, (0x8000024 & 0xFFFF)
  .L800EDFA4:
    /* DE7A4 800EDFA4 1280023C */  lui        $v0, %hi(D_80123694)
    /* DE7A8 800EDFA8 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DE7AC 800EDFAC 00000000 */  nop
    /* DE7B0 800EDFB0 1000428C */  lw         $v0, 0x10($v0)
    /* DE7B4 800EDFB4 00000000 */  nop
    /* DE7B8 800EDFB8 09F84000 */  jalr       $v0
    /* DE7BC 800EDFBC 21200002 */   addu      $a0, $s0, $zero
    /* DE7C0 800EDFC0 08000224 */  addiu      $v0, $zero, 0x8
    /* DE7C4 800EDFC4 120022A2 */  sb         $v0, 0x12($s1)
  .L800EDFC8:
    /* DE7C8 800EDFC8 1280043C */  lui        $a0, %hi(D_80123710)
    /* DE7CC 800EDFCC 10378424 */  addiu      $a0, $a0, %lo(D_80123710)
    /* DE7D0 800EDFD0 00008294 */  lhu        $v0, 0x0($a0)
    /* DE7D4 800EDFD4 08002386 */  lh         $v1, 0x8($s1)
    /* DE7D8 800EDFD8 00140200 */  sll        $v0, $v0, 16
    /* DE7DC 800EDFDC 03140200 */  sra        $v0, $v0, 16
    /* DE7E0 800EDFE0 17004314 */  bne        $v0, $v1, .L800EE040
    /* DE7E4 800EDFE4 00000000 */   nop
    /* DE7E8 800EDFE8 02008294 */  lhu        $v0, 0x2($a0)
    /* DE7EC 800EDFEC 0A002386 */  lh         $v1, 0xA($s1)
    /* DE7F0 800EDFF0 00140200 */  sll        $v0, $v0, 16
    /* DE7F4 800EDFF4 03140200 */  sra        $v0, $v0, 16
    /* DE7F8 800EDFF8 11004314 */  bne        $v0, $v1, .L800EE040
    /* DE7FC 800EDFFC 00000000 */   nop
    /* DE800 800EE000 04008294 */  lhu        $v0, 0x4($a0)
    /* DE804 800EE004 0C002386 */  lh         $v1, 0xC($s1)
    /* DE808 800EE008 00140200 */  sll        $v0, $v0, 16
    /* DE80C 800EE00C 03140200 */  sra        $v0, $v0, 16
    /* DE810 800EE010 0B004314 */  bne        $v0, $v1, .L800EE040
    /* DE814 800EE014 00000000 */   nop
    /* DE818 800EE018 06008294 */  lhu        $v0, 0x6($a0)
    /* DE81C 800EE01C 0E002386 */  lh         $v1, 0xE($s1)
    /* DE820 800EE020 00140200 */  sll        $v0, $v0, 16
    /* DE824 800EE024 03140200 */  sra        $v0, $v0, 16
    /* DE828 800EE028 05004314 */  bne        $v0, $v1, .L800EE040
    /* DE82C 800EE02C 08000224 */   addiu     $v0, $zero, 0x8
    /* DE830 800EE030 12002392 */  lbu        $v1, 0x12($s1)
    /* DE834 800EE034 00000000 */  nop
    /* DE838 800EE038 9C006214 */  bne        $v1, $v0, .L800EE2AC
    /* DE83C 800EE03C 00000000 */   nop
  .L800EE040:
    /* DE840 800EE040 E1C5030C */  jal        GetVideoMode
    /* DE844 800EE044 00000000 */   nop
    /* DE848 800EE048 120022A2 */  sb         $v0, 0x12($s1)
    /* DE84C 800EE04C FF004230 */  andi       $v0, $v0, 0xFF
    /* DE850 800EE050 0A002486 */  lh         $a0, 0xA($s1)
    /* DE854 800EE054 02004014 */  bnez       $v0, .L800EE060
    /* DE858 800EE058 13009024 */   addiu     $s0, $a0, 0x13
    /* DE85C 800EE05C 10009024 */  addiu      $s0, $a0, 0x10
  .L800EE060:
    /* DE860 800EE060 0E002286 */  lh         $v0, 0xE($s1)
    /* DE864 800EE064 00000000 */  nop
    /* DE868 800EE068 02004014 */  bnez       $v0, .L800EE074
    /* DE86C 800EE06C 21900202 */   addu      $s2, $s0, $v0
    /* DE870 800EE070 F0001226 */  addiu      $s2, $s0, 0xF0
  .L800EE074:
    /* DE874 800EE074 04002386 */  lh         $v1, 0x4($s1)
    /* DE878 800EE078 00000000 */  nop
    /* DE87C 800EE07C 19016228 */  slti       $v0, $v1, 0x119
    /* DE880 800EE080 0B004014 */  bnez       $v0, .L800EE0B0
    /* DE884 800EE084 21300000 */   addu      $a2, $zero, $zero
    /* DE888 800EE088 61016228 */  slti       $v0, $v1, 0x161
    /* DE88C 800EE08C 08004014 */  bnez       $v0, .L800EE0B0
    /* DE890 800EE090 01000624 */   addiu     $a2, $zero, 0x1
    /* DE894 800EE094 91016228 */  slti       $v0, $v1, 0x191
    /* DE898 800EE098 05004014 */  bnez       $v0, .L800EE0B0
    /* DE89C 800EE09C 02000624 */   addiu     $a2, $zero, 0x2
    /* DE8A0 800EE0A0 31026228 */  slti       $v0, $v1, 0x231
    /* DE8A4 800EE0A4 02004010 */  beqz       $v0, .L800EE0B0
    /* DE8A8 800EE0A8 04000624 */   addiu     $a2, $zero, 0x4
    /* DE8AC 800EE0AC 03000624 */  addiu      $a2, $zero, 0x3
  .L800EE0B0:
    /* DE8B0 800EE0B0 08002386 */  lh         $v1, 0x8($s1)
    /* DE8B4 800EE0B4 1280023C */  lui        $v0, %hi(D_80123798)
    /* DE8B8 800EE0B8 21104600 */  addu       $v0, $v0, $a2
    /* DE8BC 800EE0BC 98374290 */  lbu        $v0, %lo(D_80123798)($v0)
    /* DE8C0 800EE0C0 00000000 */  nop
    /* DE8C4 800EE0C4 18006200 */  mult       $v1, $v0
    /* DE8C8 800EE0C8 12002392 */  lbu        $v1, 0x12($s1)
    /* DE8CC 800EE0CC 00000000 */  nop
    /* DE8D0 800EE0D0 80100300 */  sll        $v0, $v1, 2
    /* DE8D4 800EE0D4 21104300 */  addu       $v0, $v0, $v1
    /* DE8D8 800EE0D8 21104600 */  addu       $v0, $v0, $a2
    /* DE8DC 800EE0DC 80100200 */  sll        $v0, $v0, 2
    /* DE8E0 800EE0E0 1280033C */  lui        $v1, %hi(D_80123770)
    /* DE8E4 800EE0E4 21186200 */  addu       $v1, $v1, $v0
    /* DE8E8 800EE0E8 70376394 */  lhu        $v1, %lo(D_80123770)($v1)
    /* DE8EC 800EE0EC 1280013C */  lui        $at, %hi(D_80123772)
    /* DE8F0 800EE0F0 21082200 */  addu       $at, $at, $v0
    /* DE8F4 800EE0F4 72372294 */  lhu        $v0, %lo(D_80123772)($at)
    /* DE8F8 800EE0F8 0C002586 */  lh         $a1, 0xC($s1)
    /* DE8FC 800EE0FC 23104300 */  subu       $v0, $v0, $v1
    /* DE900 800EE100 12380000 */  mflo       $a3
    /* DE904 800EE104 0400A010 */  beqz       $a1, .L800EE118
    /* DE908 800EE108 21206700 */   addu      $a0, $v1, $a3
    /* DE90C 800EE10C 18004500 */  mult       $v0, $a1
    /* DE910 800EE110 12380000 */  mflo       $a3
    /* DE914 800EE114 03120700 */  sra        $v0, $a3, 8
  .L800EE118:
    /* DE918 800EE118 21188200 */  addu       $v1, $a0, $v0
    /* DE91C 800EE11C 12002292 */  lbu        $v0, 0x12($s1)
    /* DE920 800EE120 00000000 */  nop
    /* DE924 800EE124 24004010 */  beqz       $v0, .L800EE1B8
    /* DE928 800EE128 1C028228 */   slti      $v0, $a0, 0x21C
    /* DE92C 800EE12C 05004014 */  bnez       $v0, .L800EE144
    /* DE930 800EE130 1C020524 */   addiu     $a1, $zero, 0x21C
    /* DE934 800EE134 950C8228 */  slti       $v0, $a0, 0xC95
    /* DE938 800EE138 02004010 */  beqz       $v0, .L800EE144
    /* DE93C 800EE13C 940C0524 */   addiu     $a1, $zero, 0xC94
    /* DE940 800EE140 21288000 */  addu       $a1, $a0, $zero
  .L800EE144:
    /* DE944 800EE144 1280023C */  lui        $v0, %hi(D_80123798)
    /* DE948 800EE148 21104600 */  addu       $v0, $v0, $a2
    /* DE94C 800EE14C 98374290 */  lbu        $v0, %lo(D_80123798)($v0)
    /* DE950 800EE150 2120A000 */  addu       $a0, $a1, $zero
    /* DE954 800EE154 80100200 */  sll        $v0, $v0, 2
    /* DE958 800EE158 21288200 */  addu       $a1, $a0, $v0
    /* DE95C 800EE15C 2A106500 */  slt        $v0, $v1, $a1
    /* DE960 800EE160 06004014 */  bnez       $v0, .L800EE17C
    /* DE964 800EE164 1300022A */   slti      $v0, $s0, 0x13
    /* DE968 800EE168 BD0C6228 */  slti       $v0, $v1, 0xCBD
    /* DE96C 800EE16C 02004010 */  beqz       $v0, .L800EE178
    /* DE970 800EE170 BC0C0524 */   addiu     $a1, $zero, 0xCBC
    /* DE974 800EE174 21286000 */  addu       $a1, $v1, $zero
  .L800EE178:
    /* DE978 800EE178 1300022A */  slti       $v0, $s0, 0x13
  .L800EE17C:
    /* DE97C 800EE17C 06004014 */  bnez       $v0, .L800EE198
    /* DE980 800EE180 2118A000 */   addu      $v1, $a1, $zero
    /* DE984 800EE184 3001022A */  slti       $v0, $s0, 0x130
    /* DE988 800EE188 04004010 */  beqz       $v0, .L800EE19C
    /* DE98C 800EE18C 2F010524 */   addiu     $a1, $zero, 0x12F
    /* DE990 800EE190 67B80308 */  j          .L800EE19C
    /* DE994 800EE194 21280002 */   addu      $a1, $s0, $zero
  .L800EE198:
    /* DE998 800EE198 13000524 */  addiu      $a1, $zero, 0x13
  .L800EE19C:
    /* DE99C 800EE19C 2180A000 */  addu       $s0, $a1, $zero
    /* DE9A0 800EE1A0 02000526 */  addiu      $a1, $s0, 0x2
    /* DE9A4 800EE1A4 2A104502 */  slt        $v0, $s2, $a1
    /* DE9A8 800EE1A8 29004014 */  bnez       $v0, .L800EE250
    /* DE9AC 800EE1AC 3201422A */   slti      $v0, $s2, 0x132
    /* DE9B0 800EE1B0 91B80308 */  j          .L800EE244
    /* DE9B4 800EE1B4 31010524 */   addiu     $a1, $zero, 0x131
  .L800EE1B8:
    /* DE9B8 800EE1B8 F4018228 */  slti       $v0, $a0, 0x1F4
    /* DE9BC 800EE1BC 05004014 */  bnez       $v0, .L800EE1D4
    /* DE9C0 800EE1C0 F4010524 */   addiu     $a1, $zero, 0x1F4
    /* DE9C4 800EE1C4 B30C8228 */  slti       $v0, $a0, 0xCB3
    /* DE9C8 800EE1C8 02004010 */  beqz       $v0, .L800EE1D4
    /* DE9CC 800EE1CC B20C0524 */   addiu     $a1, $zero, 0xCB2
    /* DE9D0 800EE1D0 21288000 */  addu       $a1, $a0, $zero
  .L800EE1D4:
    /* DE9D4 800EE1D4 1280023C */  lui        $v0, %hi(D_80123798)
    /* DE9D8 800EE1D8 21104600 */  addu       $v0, $v0, $a2
    /* DE9DC 800EE1DC 98374290 */  lbu        $v0, %lo(D_80123798)($v0)
    /* DE9E0 800EE1E0 2120A000 */  addu       $a0, $a1, $zero
    /* DE9E4 800EE1E4 80100200 */  sll        $v0, $v0, 2
    /* DE9E8 800EE1E8 21288200 */  addu       $a1, $a0, $v0
    /* DE9EC 800EE1EC 2A106500 */  slt        $v0, $v1, $a1
    /* DE9F0 800EE1F0 06004014 */  bnez       $v0, .L800EE20C
    /* DE9F4 800EE1F4 1000022A */   slti      $v0, $s0, 0x10
    /* DE9F8 800EE1F8 DB0C6228 */  slti       $v0, $v1, 0xCDB
    /* DE9FC 800EE1FC 02004010 */  beqz       $v0, .L800EE208
    /* DEA00 800EE200 DA0C0524 */   addiu     $a1, $zero, 0xCDA
    /* DEA04 800EE204 21286000 */  addu       $a1, $v1, $zero
  .L800EE208:
    /* DEA08 800EE208 1000022A */  slti       $v0, $s0, 0x10
  .L800EE20C:
    /* DEA0C 800EE20C 06004014 */  bnez       $v0, .L800EE228
    /* DEA10 800EE210 2118A000 */   addu      $v1, $a1, $zero
    /* DEA14 800EE214 0201022A */  slti       $v0, $s0, 0x102
    /* DEA18 800EE218 04004010 */  beqz       $v0, .L800EE22C
    /* DEA1C 800EE21C 01010524 */   addiu     $a1, $zero, 0x101
    /* DEA20 800EE220 8BB80308 */  j          .L800EE22C
    /* DEA24 800EE224 21280002 */   addu      $a1, $s0, $zero
  .L800EE228:
    /* DEA28 800EE228 10000524 */  addiu      $a1, $zero, 0x10
  .L800EE22C:
    /* DEA2C 800EE22C 2180A000 */  addu       $s0, $a1, $zero
    /* DEA30 800EE230 02000526 */  addiu      $a1, $s0, 0x2
    /* DEA34 800EE234 2A104502 */  slt        $v0, $s2, $a1
    /* DEA38 800EE238 05004014 */  bnez       $v0, .L800EE250
    /* DEA3C 800EE23C 0301422A */   slti      $v0, $s2, 0x103
    /* DEA40 800EE240 02010524 */  addiu      $a1, $zero, 0x102
  .L800EE244:
    /* DEA44 800EE244 02004010 */  beqz       $v0, .L800EE250
    /* DEA48 800EE248 00000000 */   nop
    /* DEA4C 800EE24C 21284002 */  addu       $a1, $s2, $zero
  .L800EE250:
    /* DEA50 800EE250 2190A000 */  addu       $s2, $a1, $zero
    /* DEA54 800EE254 FF0F6330 */  andi       $v1, $v1, 0xFFF
    /* DEA58 800EE258 001B0300 */  sll        $v1, $v1, 12
    /* DEA5C 800EE25C FF0F8430 */  andi       $a0, $a0, 0xFFF
    /* DEA60 800EE260 0006023C */  lui        $v0, (0x6000000 >> 16)
    /* DEA64 800EE264 1280053C */  lui        $a1, %hi(D_80123694)
    /* DEA68 800EE268 9436A58C */  lw         $a1, %lo(D_80123694)($a1)
    /* DEA6C 800EE26C 25208200 */  or         $a0, $a0, $v0
    /* DEA70 800EE270 1000A28C */  lw         $v0, 0x10($a1)
    /* DEA74 800EE274 00000000 */  nop
    /* DEA78 800EE278 09F84000 */  jalr       $v0
    /* DEA7C 800EE27C 25206400 */   or        $a0, $v1, $a0
    /* DEA80 800EE280 FF034332 */  andi       $v1, $s2, 0x3FF
    /* DEA84 800EE284 801A0300 */  sll        $v1, $v1, 10
    /* DEA88 800EE288 FF030432 */  andi       $a0, $s0, 0x3FF
    /* DEA8C 800EE28C 0007023C */  lui        $v0, (0x7000000 >> 16)
    /* DEA90 800EE290 1280053C */  lui        $a1, %hi(D_80123694)
    /* DEA94 800EE294 9436A58C */  lw         $a1, %lo(D_80123694)($a1)
    /* DEA98 800EE298 25208200 */  or         $a0, $a0, $v0
    /* DEA9C 800EE29C 1000A28C */  lw         $v0, 0x10($a1)
    /* DEAA0 800EE2A0 00000000 */  nop
    /* DEAA4 800EE2A4 09F84000 */  jalr       $v0
    /* DEAA8 800EE2A8 25206400 */   or        $a0, $v1, $a0
  .L800EE2AC:
    /* DEAAC 800EE2AC 1280043C */  lui        $a0, %hi(D_80123708)
    /* DEAB0 800EE2B0 08378424 */  addiu      $a0, $a0, %lo(D_80123708)
    /* DEAB4 800EE2B4 21282002 */  addu       $a1, $s1, $zero
    /* DEAB8 800EE2B8 B1AA030C */  jal        memcpy
    /* DEABC 800EE2BC 14000624 */   addiu     $a2, $zero, 0x14
    /* DEAC0 800EE2C0 21102002 */  addu       $v0, $s1, $zero
    /* DEAC4 800EE2C4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DEAC8 800EE2C8 1800B28F */  lw         $s2, 0x18($sp)
    /* DEACC 800EE2CC 1400B18F */  lw         $s1, 0x14($sp)
    /* DEAD0 800EE2D0 1000B08F */  lw         $s0, 0x10($sp)
    /* DEAD4 800EE2D4 0800E003 */  jr         $ra
    /* DEAD8 800EE2D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PutDispEnv
