.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t, 0x298

glabel SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
    /* 4CF90 8005C790 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 4CF94 8005C794 3000B4AF */  sw         $s4, 0x30($sp)
    /* 4CF98 8005C798 21A0A000 */  addu       $s4, $a1, $zero
    /* 4CF9C 8005C79C 3800BFAF */  sw         $ra, 0x38($sp)
    /* 4CFA0 8005C7A0 3400B5AF */  sw         $s5, 0x34($sp)
    /* 4CFA4 8005C7A4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 4CFA8 8005C7A8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 4CFAC 8005C7AC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 4CFB0 8005C7B0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4CFB4 8005C7B4 0800828E */  lw         $v0, 0x8($s4)
    /* 4CFB8 8005C7B8 00000000 */  nop
    /* 4CFBC 8005C7BC 91004010 */  beqz       $v0, .L8005CA04
    /* 4CFC0 8005C7C0 00000000 */   nop
    /* 4CFC4 8005C7C4 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* 4CFC8 8005C7C8 00000000 */   nop
    /* 4CFCC 8005C7CC 0800838E */  lw         $v1, 0x8($s4)
    /* 4CFD0 8005C7D0 1400938E */  lw         $s3, 0x14($s4)
    /* 4CFD4 8005C7D4 01006230 */  andi       $v0, $v1, 0x1
    /* 4CFD8 8005C7D8 1480013C */  lui        $at, %hi(Object_customSliceNum)
    /* 4CFDC 8005C7DC D4D233AC */  sw         $s3, %lo(Object_customSliceNum)($at)
    /* 4CFE0 8005C7E0 2E004010 */  beqz       $v0, .L8005C89C
    /* 4CFE4 8005C7E4 21800000 */   addu      $s0, $zero, $zero
    /* 4CFE8 8005C7E8 F0FF113C */  lui        $s1, (0xFFF00000 >> 16)
    /* 4CFEC 8005C7EC 40141000 */  sll        $v0, $s0, 17
  .L8005C7F0:
    /* 4CFF0 8005C7F0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4CFF4 8005C7F4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4CFF8 8005C7F8 1800828E */  lw         $v0, 0x18($s4)
    /* 4CFFC 8005C7FC 00000000 */  nop
    /* 4D000 8005C800 18005100 */  mult       $v0, $s1
    /* 4D004 8005C804 21206002 */  addu       $a0, $s3, $zero
    /* 4D008 8005C808 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D00C 8005C80C 01001026 */  addiu      $s0, $s0, 0x1
    /* 4D010 8005C810 12380000 */  mflo       $a3
    /* 4D014 8005C814 7971010C */  jal        PlacePointOnRoad__FiP8coorddef
    /* 4D018 8005C818 1800A7AF */   sw        $a3, 0x18($sp)
    /* 4D01C 8005C81C 0571010C */  jal        Blockade_AddRoadFlare__FP8coorddef
    /* 4D020 8005C820 1000A427 */   addiu     $a0, $sp, 0x10
    /* 4D024 8005C824 0400023C */  lui        $v0, (0x40000 >> 16)
    /* 4D028 8005C828 21882202 */  addu       $s1, $s1, $v0
    /* 4D02C 8005C82C 0500022A */  slti       $v0, $s0, 0x5
    /* 4D030 8005C830 EFFF4014 */  bnez       $v0, .L8005C7F0
    /* 4D034 8005C834 40141000 */   sll       $v0, $s0, 17
    /* 4D038 8005C838 01001224 */  addiu      $s2, $zero, 0x1
    /* 4D03C 8005C83C F4FF113C */  lui        $s1, (0xFFF40000 >> 16)
    /* 4D040 8005C840 FEFF103C */  lui        $s0, (0xFFFE0000 >> 16)
    /* 4D044 8005C844 1000B0AF */  sw         $s0, 0x10($sp)
  .L8005C848:
    /* 4D048 8005C848 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4D04C 8005C84C 1800828E */  lw         $v0, 0x18($s4)
    /* 4D050 8005C850 00000000 */  nop
    /* 4D054 8005C854 18005100 */  mult       $v0, $s1
    /* 4D058 8005C858 21206002 */  addu       $a0, $s3, $zero
    /* 4D05C 8005C85C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D060 8005C860 01005226 */  addiu      $s2, $s2, 0x1
    /* 4D064 8005C864 12380000 */  mflo       $a3
    /* 4D068 8005C868 7971010C */  jal        PlacePointOnRoad__FiP8coorddef
    /* 4D06C 8005C86C 1800A7AF */   sw        $a3, 0x18($sp)
    /* 4D070 8005C870 0571010C */  jal        Blockade_AddRoadFlare__FP8coorddef
    /* 4D074 8005C874 1000A427 */   addiu     $a0, $sp, 0x10
    /* 4D078 8005C878 0400023C */  lui        $v0, (0x40000 >> 16)
    /* 4D07C 8005C87C 21882202 */  addu       $s1, $s1, $v0
    /* 4D080 8005C880 FEFF023C */  lui        $v0, (0xFFFE0000 >> 16)
    /* 4D084 8005C884 21800202 */  addu       $s0, $s0, $v0
    /* 4D088 8005C888 0500422A */  slti       $v0, $s2, 0x5
    /* 4D08C 8005C88C 34004010 */  beqz       $v0, .L8005C960
    /* 4D090 8005C890 00000000 */   nop
    /* 4D094 8005C894 12720108 */  j          .L8005C848
    /* 4D098 8005C898 1000B0AF */   sw        $s0, 0x10($sp)
  .L8005C89C:
    /* 4D09C 8005C89C 02006230 */  andi       $v0, $v1, 0x2
    /* 4D0A0 8005C8A0 2F004010 */  beqz       $v0, .L8005C960
    /* 4D0A4 8005C8A4 FAFF103C */   lui       $s0, (0xFFFA0000 >> 16)
    /* 4D0A8 8005C8A8 21900000 */  addu       $s2, $zero, $zero
    /* 4D0AC 8005C8AC E8FF113C */  lui        $s1, (0xFFE80000 >> 16)
  .L8005C8B0:
    /* 4D0B0 8005C8B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D0B4 8005C8B4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4D0B8 8005C8B8 1800828E */  lw         $v0, 0x18($s4)
    /* 4D0BC 8005C8BC 00000000 */  nop
    /* 4D0C0 8005C8C0 18005100 */  mult       $v0, $s1
    /* 4D0C4 8005C8C4 21206002 */  addu       $a0, $s3, $zero
    /* 4D0C8 8005C8C8 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D0CC 8005C8CC 01005226 */  addiu      $s2, $s2, 0x1
    /* 4D0D0 8005C8D0 12380000 */  mflo       $a3
    /* 4D0D4 8005C8D4 7971010C */  jal        PlacePointOnRoad__FiP8coorddef
    /* 4D0D8 8005C8D8 1800A7AF */   sw        $a3, 0x18($sp)
    /* 4D0DC 8005C8DC 0571010C */  jal        Blockade_AddRoadFlare__FP8coorddef
    /* 4D0E0 8005C8E0 1000A427 */   addiu     $a0, $sp, 0x10
    /* 4D0E4 8005C8E4 0400023C */  lui        $v0, (0x40000 >> 16)
    /* 4D0E8 8005C8E8 21882202 */  addu       $s1, $s1, $v0
    /* 4D0EC 8005C8EC 0200023C */  lui        $v0, (0x20000 >> 16)
    /* 4D0F0 8005C8F0 21800202 */  addu       $s0, $s0, $v0
    /* 4D0F4 8005C8F4 0700422A */  slti       $v0, $s2, 0x7
    /* 4D0F8 8005C8F8 EDFF4014 */  bnez       $v0, .L8005C8B0
    /* 4D0FC 8005C8FC 03001524 */   addiu     $s5, $zero, 0x3
    /* 4D100 8005C900 21800000 */  addu       $s0, $zero, $zero
    /* 4D104 8005C904 E8FF123C */  lui        $s2, (0xFFE80000 >> 16)
    /* 4D108 8005C908 0600113C */  lui        $s1, (0x60000 >> 16)
  .L8005C90C:
    /* 4D10C 8005C90C 0C001512 */  beq        $s0, $s5, .L8005C940
    /* 4D110 8005C910 1000A527 */   addiu     $a1, $sp, 0x10
    /* 4D114 8005C914 1000B1AF */  sw         $s1, 0x10($sp)
    /* 4D118 8005C918 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4D11C 8005C91C 1800828E */  lw         $v0, 0x18($s4)
    /* 4D120 8005C920 00000000 */  nop
    /* 4D124 8005C924 18005200 */  mult       $v0, $s2
    /* 4D128 8005C928 21206002 */  addu       $a0, $s3, $zero
    /* 4D12C 8005C92C 12380000 */  mflo       $a3
    /* 4D130 8005C930 7971010C */  jal        PlacePointOnRoad__FiP8coorddef
    /* 4D134 8005C934 1800A7AF */   sw        $a3, 0x18($sp)
    /* 4D138 8005C938 0571010C */  jal        Blockade_AddRoadFlare__FP8coorddef
    /* 4D13C 8005C93C 1000A427 */   addiu     $a0, $sp, 0x10
  .L8005C940:
    /* 4D140 8005C940 0400023C */  lui        $v0, (0x40000 >> 16)
    /* 4D144 8005C944 21904202 */  addu       $s2, $s2, $v0
    /* 4D148 8005C948 FEFF023C */  lui        $v0, (0xFFFE0000 >> 16)
    /* 4D14C 8005C94C 21882202 */  addu       $s1, $s1, $v0
    /* 4D150 8005C950 01001026 */  addiu      $s0, $s0, 0x1
    /* 4D154 8005C954 0700022A */  slti       $v0, $s0, 0x7
    /* 4D158 8005C958 ECFF4014 */  bnez       $v0, .L8005C90C
    /* 4D15C 8005C95C 00000000 */   nop
  .L8005C960:
    /* 4D160 8005C960 0800828E */  lw         $v0, 0x8($s4)
    /* 4D164 8005C964 00000000 */  nop
    /* 4D168 8005C968 04004230 */  andi       $v0, $v0, 0x4
    /* 4D16C 8005C96C 24004010 */  beqz       $v0, .L8005CA00
    /* 4D170 8005C970 00000000 */   nop
    /* 4D174 8005C974 6B96020C */  jal        Object_FindDefWithThisID__Fi
    /* 4D178 8005C978 03000424 */   addiu     $a0, $zero, 0x3
    /* 4D17C 8005C97C 21804000 */  addu       $s0, $v0, $zero
    /* 4D180 8005C980 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 4D184 8005C984 1E000212 */  beq        $s0, $v0, .L8005CA00
    /* 4D188 8005C988 FDFF023C */   lui       $v0, (0xFFFD8000 >> 16)
    /* 4D18C 8005C98C 00804234 */  ori        $v0, $v0, (0xFFFD8000 & 0xFFFF)
    /* 4D190 8005C990 21206002 */  addu       $a0, $s3, $zero
    /* 4D194 8005C994 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4D198 8005C998 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4D19C 8005C99C 1800828E */  lw         $v0, 0x18($s4)
    /* 4D1A0 8005C9A0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D1A4 8005C9A4 80140200 */  sll        $v0, $v0, 18
    /* 4D1A8 8005C9A8 23100200 */  negu       $v0, $v0
    /* 4D1AC 8005C9AC 7971010C */  jal        PlacePointOnRoad__FiP8coorddef
    /* 4D1B0 8005C9B0 1800A2AF */   sw        $v0, 0x18($sp)
    /* 4D1B4 8005C9B4 21206002 */  addu       $a0, $s3, $zero
    /* 4D1B8 8005C9B8 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D1BC 8005C9BC 1A71010C */  jal        Blockade_AddObject__FiP8coorddefi
    /* 4D1C0 8005C9C0 21300002 */   addu      $a2, $s0, $zero
    /* 4D1C4 8005C9C4 0200023C */  lui        $v0, (0x28000 >> 16)
    /* 4D1C8 8005C9C8 00804234 */  ori        $v0, $v0, (0x28000 & 0xFFFF)
    /* 4D1CC 8005C9CC 21206002 */  addu       $a0, $s3, $zero
    /* 4D1D0 8005C9D0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 4D1D4 8005C9D4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4D1D8 8005C9D8 1800828E */  lw         $v0, 0x18($s4)
    /* 4D1DC 8005C9DC 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D1E0 8005C9E0 80140200 */  sll        $v0, $v0, 18
    /* 4D1E4 8005C9E4 23100200 */  negu       $v0, $v0
    /* 4D1E8 8005C9E8 7971010C */  jal        PlacePointOnRoad__FiP8coorddef
    /* 4D1EC 8005C9EC 1800A2AF */   sw        $v0, 0x18($sp)
    /* 4D1F0 8005C9F0 21206002 */  addu       $a0, $s3, $zero
    /* 4D1F4 8005C9F4 1000A527 */  addiu      $a1, $sp, 0x10
    /* 4D1F8 8005C9F8 1A71010C */  jal        Blockade_AddObject__FiP8coorddefi
    /* 4D1FC 8005C9FC 21300002 */   addu      $a2, $s0, $zero
  .L8005CA00:
    /* 4D200 8005CA00 080080AE */  sw         $zero, 0x8($s4)
  .L8005CA04:
    /* 4D204 8005CA04 3800BF8F */  lw         $ra, 0x38($sp)
    /* 4D208 8005CA08 3400B58F */  lw         $s5, 0x34($sp)
    /* 4D20C 8005CA0C 3000B48F */  lw         $s4, 0x30($sp)
    /* 4D210 8005CA10 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 4D214 8005CA14 2800B28F */  lw         $s2, 0x28($sp)
    /* 4D218 8005CA18 2400B18F */  lw         $s1, 0x24($sp)
    /* 4D21C 8005CA1C 2000B08F */  lw         $s0, 0x20($sp)
    /* 4D220 8005CA20 0800E003 */  jr         $ra
    /* 4D224 8005CA24 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t
