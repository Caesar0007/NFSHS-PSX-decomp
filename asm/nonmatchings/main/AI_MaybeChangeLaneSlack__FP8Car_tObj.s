.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_MaybeChangeLaneSlack__FP8Car_tObj, 0x11C

glabel AI_MaybeChangeLaneSlack__FP8Car_tObj
    /* 4B0C0 8005A8C0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4B0C4 8005A8C4 21288000 */  addu       $a1, $a0, $zero
    /* 4B0C8 8005A8C8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4B0CC 8005A8CC 5402A28C */  lw         $v0, 0x254($a1)
    /* 4B0D0 8005A8D0 00000000 */  nop
    /* 4B0D4 8005A8D4 40180200 */  sll        $v1, $v0, 1
    /* 4B0D8 8005A8D8 0A006004 */  bltz       $v1, .L8005A904
    /* 4B0DC 8005A8DC 00000000 */   nop
    /* 4B0E0 8005A8E0 0800A284 */  lh         $v0, 0x8($a1)
    /* 4B0E4 8005A8E4 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 4B0E8 8005A8E8 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 4B0EC 8005A8EC 21184300 */  addu       $v1, $v0, $v1
    /* 4B0F0 8005A8F0 2A106400 */  slt        $v0, $v1, $a0
    /* 4B0F4 8005A8F4 0C004014 */  bnez       $v0, .L8005A928
    /* 4B0F8 8005A8F8 00000000 */   nop
    /* 4B0FC 8005A8FC 4A6A0108 */  j          .L8005A928
    /* 4B100 8005A900 23186400 */   subu      $v1, $v1, $a0
  .L8005A904:
    /* 4B104 8005A904 0800A284 */  lh         $v0, 0x8($a1)
    /* 4B108 8005A908 00000000 */  nop
    /* 4B10C 8005A90C 21184300 */  addu       $v1, $v0, $v1
    /* 4B110 8005A910 05006104 */  bgez       $v1, .L8005A928
    /* 4B114 8005A914 00000000 */   nop
    /* 4B118 8005A918 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 4B11C 8005A91C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 4B120 8005A920 00000000 */  nop
    /* 4B124 8005A924 21186200 */  addu       $v1, $v1, $v0
  .L8005A928:
    /* 4B128 8005A928 6002A48C */  lw         $a0, 0x260($a1)
    /* 4B12C 8005A92C 00000000 */  nop
    /* 4B130 8005A930 04008230 */  andi       $v0, $a0, 0x4
    /* 4B134 8005A934 25004014 */  bnez       $v0, .L8005A9CC
    /* 4B138 8005A938 08008230 */   andi      $v0, $a0, 0x8
    /* 4B13C 8005A93C 04004010 */  beqz       $v0, .L8005A950
    /* 4B140 8005A940 03110300 */   sra       $v0, $v1, 4
    /* 4B144 8005A944 00110200 */  sll        $v0, $v0, 4
    /* 4B148 8005A948 20004314 */  bne        $v0, $v1, .L8005A9CC
    /* 4B14C 8005A94C 00000000 */   nop
  .L8005A950:
    /* 4B150 8005A950 10008230 */  andi       $v0, $a0, 0x10
    /* 4B154 8005A954 04004010 */  beqz       $v0, .L8005A968
    /* 4B158 8005A958 43100300 */   sra       $v0, $v1, 1
    /* 4B15C 8005A95C 40100200 */  sll        $v0, $v0, 1
    /* 4B160 8005A960 1A004314 */  bne        $v0, $v1, .L8005A9CC
    /* 4B164 8005A964 00000000 */   nop
  .L8005A968:
    /* 4B168 8005A968 1480033C */  lui        $v1, %hi(fastRandom)
    /* 4B16C 8005A96C FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 4B170 8005A970 1480023C */  lui        $v0, %hi(randSeed)
    /* 4B174 8005A974 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4B178 8005A978 00000000 */  nop
    /* 4B17C 8005A97C 18006200 */  mult       $v1, $v0
    /* 4B180 8005A980 F004A48C */  lw         $a0, 0x4F0($a1)
    /* 4B184 8005A984 00000000 */  nop
    /* 4B188 8005A988 1C00848C */  lw         $a0, 0x1C($a0)
    /* 4B18C 8005A98C 12180000 */  mflo       $v1
    /* 4B190 8005A990 02120300 */  srl        $v0, $v1, 8
    /* 4B194 8005A994 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 4B198 8005A998 18008200 */  mult       $a0, $v0
    /* 4B19C 8005A99C 1480013C */  lui        $at, %hi(randtemp)
    /* 4B1A0 8005A9A0 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 4B1A4 8005A9A4 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 4B1A8 8005A9A8 1480013C */  lui        $at, %hi(fastRandom)
    /* 4B1AC 8005A9AC FCD023AC */  sw         $v1, %lo(fastRandom)($at)
    /* 4B1B0 8005A9B0 12100000 */  mflo       $v0
    /* 4B1B4 8005A9B4 021C0200 */  srl        $v1, $v0, 16
    /* 4B1B8 8005A9B8 01000224 */  addiu      $v0, $zero, 0x1
    /* 4B1BC 8005A9BC 03006214 */  bne        $v1, $v0, .L8005A9CC
    /* 4B1C0 8005A9C0 00000000 */   nop
    /* 4B1C4 8005A9C4 776A010C */  jal        AI_ChooseNewLaneSlack__FP8Car_tObj
    /* 4B1C8 8005A9C8 2120A000 */   addu      $a0, $a1, $zero
  .L8005A9CC:
    /* 4B1CC 8005A9CC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4B1D0 8005A9D0 00000000 */  nop
    /* 4B1D4 8005A9D4 0800E003 */  jr         $ra
    /* 4B1D8 8005A9D8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AI_MaybeChangeLaneSlack__FP8Car_tObj
