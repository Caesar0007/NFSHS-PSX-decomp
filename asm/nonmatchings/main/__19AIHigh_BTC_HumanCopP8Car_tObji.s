.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __19AIHigh_BTC_HumanCopP8Car_tObji, 0x21C

glabel __19AIHigh_BTC_HumanCopP8Car_tObji
    /* 4D734 8005CF34 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 4D738 8005CF38 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 4D73C 8005CF3C 21888000 */  addu       $s1, $a0, $zero
    /* 4D740 8005CF40 1800B0AF */  sw         $s0, 0x18($sp)
    /* 4D744 8005CF44 2180C000 */  addu       $s0, $a2, $zero
    /* 4D748 8005CF48 2400BFAF */  sw         $ra, 0x24($sp)
    /* 4D74C 8005CF4C DB72010C */  jal        __14AIHigh_BTC_CopP8Car_tObji
    /* 4D750 8005CF50 2000B2AF */   sw        $s2, 0x20($sp)
    /* 4D754 8005CF54 21280000 */  addu       $a1, $zero, $zero
    /* 4D758 8005CF58 0580023C */  lui        $v0, %hi(_vt_19AIHigh_BTC_HumanCop)
    /* 4D75C 8005CF5C E44E4224 */  addiu      $v0, $v0, %lo(_vt_19AIHigh_BTC_HumanCop)
    /* 4D760 8005CF60 140022AE */  sw         $v0, 0x14($s1)
    /* 4D764 8005CF64 01000224 */  addiu      $v0, $zero, 0x1
    /* 4D768 8005CF68 840022AE */  sw         $v0, 0x84($s1)
    /* 4D76C 8005CF6C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 4D770 8005CF70 640022AE */  sw         $v0, 0x64($s1)
    /* 4D774 8005CF74 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 4D778 8005CF78 1180033C */  lui        $v1, %hi(AITune_BTC)
    /* 4D77C 8005CF7C 6C0022AE */  sw         $v0, 0x6C($s1)
    /* 4D780 8005CF80 1180023C */  lui        $v0, %hi(D_801131F4)
    /* 4D784 8005CF84 7C0020AE */  sw         $zero, 0x7C($s1)
    /* 4D788 8005CF88 800020AE */  sw         $zero, 0x80($s1)
    /* 4D78C 8005CF8C 880020AE */  sw         $zero, 0x88($s1)
    /* 4D790 8005CF90 680020AE */  sw         $zero, 0x68($s1)
    /* 4D794 8005CF94 F431448C */  lw         $a0, %lo(D_801131F4)($v0)
    /* 4D798 8005CF98 14DE6324 */  addiu      $v1, $v1, %lo(AITune_BTC)
    /* 4D79C 8005CF9C C0100400 */  sll        $v0, $a0, 3
    /* 4D7A0 8005CFA0 23104400 */  subu       $v0, $v0, $a0
    /* 4D7A4 8005CFA4 80100200 */  sll        $v0, $v0, 2
    /* 4D7A8 8005CFA8 21104300 */  addu       $v0, $v0, $v1
    /* 4D7AC 8005CFAC 0C00428C */  lw         $v0, 0xC($v0)
    /* 4D7B0 8005CFB0 0000238E */  lw         $v1, 0x0($s1)
    /* 4D7B4 8005CFB4 2130A000 */  addu       $a2, $a1, $zero
    /* 4D7B8 8005CFB8 700022AE */  sw         $v0, 0x70($s1)
    /* 4D7BC 8005CFBC 680260AC */  sw         $zero, 0x268($v1)
    /* 4D7C0 8005CFC0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 4D7C4 8005CFC4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 4D7C8 8005CFC8 0000248E */  lw         $a0, 0x0($s1)
    /* 4D7CC 8005CFCC 140080AF */  sw         $zero, %gp_rel(_19AIHigh_BTC_HumanCop_lastInputRequestTick_)($gp)
    /* 4D7D0 8005CFD0 149F010C */  jal        AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
    /* 4D7D4 8005CFD4 01000724 */   addiu     $a3, $zero, 0x1
    /* 4D7D8 8005CFD8 57000016 */  bnez       $s0, .L8005D138
    /* 4D7DC 8005CFDC 21102002 */   addu      $v0, $s1, $zero
    /* 4D7E0 8005CFE0 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4D7E4 8005CFE4 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4D7E8 8005CFE8 1480053C */  lui        $a1, %hi(randSeed)
    /* 4D7EC 8005CFEC 04D1A58C */  lw         $a1, %lo(randSeed)($a1)
    /* 4D7F0 8005CFF0 00000000 */  nop
    /* 4D7F4 8005CFF4 18006500 */  mult       $v1, $a1
    /* 4D7F8 8005CFF8 FF00063C */  lui        $a2, (0xFFFF00 >> 16)
    /* 4D7FC 8005CFFC 00FFC634 */  ori        $a2, $a2, (0xFFFF00 & 0xFFFF)
    /* 4D800 8005D000 12180000 */  mflo       $v1
    /* 4D804 8005D004 FFFF6430 */  andi       $a0, $v1, 0xFFFF
    /* 4D808 8005D008 1480013C */  lui        $at, %hi(randtemp)
    /* 4D80C 8005D00C 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4D810 8005D010 24186600 */  and        $v1, $v1, $a2
    /* 4D814 8005D014 021A0300 */  srl        $v1, $v1, 8
    /* 4D818 8005D018 40110300 */  sll        $v0, $v1, 5
    /* 4D81C 8005D01C 23104300 */  subu       $v0, $v0, $v1
    /* 4D820 8005D020 80100200 */  sll        $v0, $v0, 2
    /* 4D824 8005D024 21104300 */  addu       $v0, $v0, $v1
    /* 4D828 8005D028 C0100200 */  sll        $v0, $v0, 3
    /* 4D82C 8005D02C 02140200 */  srl        $v0, $v0, 16
    /* 4D830 8005D030 F401422C */  sltiu      $v0, $v0, 0x1F4
    /* 4D834 8005D034 1480013C */  lui        $at, %hi(fastRandom)
    /* 4D838 8005D038 FCD024AC */  sw         $a0, %lo(fastRandom)($at)
    /* 4D83C 8005D03C 02004010 */  beqz       $v0, .L8005D048
    /* 4D840 8005D040 FFFF1024 */   addiu     $s0, $zero, -0x1
    /* 4D844 8005D044 01001024 */  addiu      $s0, $zero, 0x1
  .L8005D048:
    /* 4D848 8005D048 18008500 */  mult       $a0, $a1
    /* 4D84C 8005D04C 12180000 */  mflo       $v1
    /* 4D850 8005D050 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 4D854 8005D054 1480013C */  lui        $at, %hi(randtemp)
    /* 4D858 8005D058 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4D85C 8005D05C 24186600 */  and        $v1, $v1, $a2
    /* 4D860 8005D060 021A0300 */  srl        $v1, $v1, 8
    /* 4D864 8005D064 1480013C */  lui        $at, %hi(fastRandom)
    /* 4D868 8005D068 FCD022AC */  sw         $v0, %lo(fastRandom)($at)
    /* 4D86C 8005D06C 40110300 */  sll        $v0, $v1, 5
    /* 4D870 8005D070 23104300 */  subu       $v0, $v0, $v1
    /* 4D874 8005D074 80100200 */  sll        $v0, $v0, 2
    /* 4D878 8005D078 21104300 */  addu       $v0, $v0, $v1
    /* 4D87C 8005D07C C0100200 */  sll        $v0, $v0, 3
    /* 4D880 8005D080 02140200 */  srl        $v0, $v0, 16
    /* 4D884 8005D084 EE02422C */  sltiu      $v0, $v0, 0x2EE
    /* 4D888 8005D088 06004010 */  beqz       $v0, .L8005D0A4
    /* 4D88C 8005D08C 21900000 */   addu      $s2, $zero, $zero
    /* 4D890 8005D090 1480023C */  lui        $v0, %hi(AIHigh_CopGameType)
    /* 4D894 8005D094 5CC5428C */  lw         $v0, %lo(AIHigh_CopGameType)($v0)
    /* 4D898 8005D098 00000000 */  nop
    /* 4D89C 8005D09C 04004238 */  xori       $v0, $v0, 0x4
    /* 4D8A0 8005D0A0 2B904202 */  sltu       $s2, $s2, $v0
  .L8005D0A4:
    /* 4D8A4 8005D0A4 21202002 */  addu       $a0, $s1, $zero
    /* 4D8A8 8005D0A8 21280000 */  addu       $a1, $zero, $zero
    /* 4D8AC 8005D0AC 64000624 */  addiu      $a2, $zero, 0x64
    /* 4D8B0 8005D0B0 5474010C */  jal        FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii
    /* 4D8B4 8005D0B4 F4010724 */   addiu     $a3, $zero, 0x1F4
    /* 4D8B8 8005D0B8 6400238E */  lw         $v1, 0x64($s1)
    /* 4D8BC 8005D0BC 00000000 */  nop
    /* 4D8C0 8005D0C0 01006324 */  addiu      $v1, $v1, 0x1
    /* 4D8C4 8005D0C4 01006330 */  andi       $v1, $v1, 0x1
    /* 4D8C8 8005D0C8 04006014 */  bnez       $v1, .L8005D0DC
    /* 4D8CC 8005D0CC 21204000 */   addu      $a0, $v0, $zero
    /* 4D8D0 8005D0D0 C0101000 */  sll        $v0, $s0, 3
    /* 4D8D4 8005D0D4 39740108 */  j          .L8005D0E4
    /* 4D8D8 8005D0D8 23105000 */   subu      $v0, $v0, $s0
  .L8005D0DC:
    /* 4D8DC 8005D0DC C0101000 */  sll        $v0, $s0, 3
    /* 4D8E0 8005D0E0 23100202 */  subu       $v0, $s0, $v0
  .L8005D0E4:
    /* 4D8E4 8005D0E4 0000248E */  lw         $a0, 0x0($s1)
    /* 4D8E8 8005D0E8 B8CD010C */  jal        AIWorld_CalcRoadBend__FP8Car_tObji
    /* 4D8EC 8005D0EC 03000524 */   addiu     $a1, $zero, 0x3
    /* 4D8F0 8005D0F0 02004104 */  bgez       $v0, .L8005D0FC
    /* 4D8F4 8005D0F4 00000000 */   nop
    /* 4D8F8 8005D0F8 23100200 */  negu       $v0, $v0
  .L8005D0FC:
    /* 4D8FC 8005D0FC B95E4228 */  slti       $v0, $v0, 0x5EB9
    /* 4D900 8005D100 07004014 */  bnez       $v0, .L8005D120
    /* 4D904 8005D104 21202002 */   addu      $a0, $s1, $zero
    /* 4D908 8005D108 1480033C */  lui        $v1, %hi(AIHigh_CopGameType)
    /* 4D90C 8005D10C 5CC5638C */  lw         $v1, %lo(AIHigh_CopGameType)($v1)
    /* 4D910 8005D110 04000224 */  addiu      $v0, $zero, 0x4
    /* 4D914 8005D114 02006210 */  beq        $v1, $v0, .L8005D120
    /* 4D918 8005D118 00000000 */   nop
    /* 4D91C 8005D11C 01001224 */  addiu      $s2, $zero, 0x1
  .L8005D120:
    /* 4D920 8005D120 0000228E */  lw         $v0, 0x0($s1)
    /* 4D924 8005D124 21300002 */  addu       $a2, $s0, $zero
    /* 4D928 8005D128 08004584 */  lh         $a1, 0x8($v0)
    /* 4D92C 8005D12C 9475010C */  jal        NewStage__19AIHigh_BTC_HumanCopiii
    /* 4D930 8005D130 21384002 */   addu      $a3, $s2, $zero
    /* 4D934 8005D134 21102002 */  addu       $v0, $s1, $zero
  .L8005D138:
    /* 4D938 8005D138 2400BF8F */  lw         $ra, 0x24($sp)
    /* 4D93C 8005D13C 2000B28F */  lw         $s2, 0x20($sp)
    /* 4D940 8005D140 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 4D944 8005D144 1800B08F */  lw         $s0, 0x18($sp)
    /* 4D948 8005D148 0800E003 */  jr         $ra
    /* 4D94C 8005D14C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __19AIHigh_BTC_HumanCopP8Car_tObji
