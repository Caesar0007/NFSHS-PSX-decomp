.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_IsMellowZone__FP8Car_tObji, 0xEC

glabel AI_IsMellowZone__FP8Car_tObji
    /* 4AE28 8005A628 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4AE2C 8005A62C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4AE30 8005A630 21808000 */  addu       $s0, $a0, $zero
    /* 4AE34 8005A634 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4AE38 8005A638 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4AE3C 8005A63C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4AE40 8005A640 5C02118E */  lw         $s1, 0x25C($s0)
    /* 4AE44 8005A644 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 4AE48 8005A648 2190A000 */   addu      $s2, $a1, $zero
    /* 4AE4C 8005A64C 6002038E */  lw         $v1, 0x260($s0)
    /* 4AE50 8005A650 00000000 */  nop
    /* 4AE54 8005A654 08006330 */  andi       $v1, $v1, 0x8
    /* 4AE58 8005A658 10006010 */  beqz       $v1, .L8005A69C
    /* 4AE5C 8005A65C 21304000 */   addu      $a2, $v0, $zero
    /* 4AE60 8005A660 08000286 */  lh         $v0, 0x8($s0)
    /* 4AE64 8005A664 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4AE68 8005A668 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4AE6C 8005A66C C406048E */  lw         $a0, 0x6C4($s0)
    /* 4AE70 8005A670 40110200 */  sll        $v0, $v0, 5
    /* 4AE74 8005A674 21104300 */  addu       $v0, $v0, $v1
    /* 4AE78 8005A678 1D004590 */  lbu        $a1, 0x1D($v0)
    /* 4AE7C 8005A67C 06000224 */  addiu      $v0, $zero, 0x6
    /* 4AE80 8005A680 02190500 */  srl        $v1, $a1, 4
    /* 4AE84 8005A684 23104300 */  subu       $v0, $v0, $v1
    /* 4AE88 8005A688 04008210 */  beq        $a0, $v0, .L8005A69C
    /* 4AE8C 8005A68C 0F00A230 */   andi      $v0, $a1, 0xF
    /* 4AE90 8005A690 07004224 */  addiu      $v0, $v0, 0x7
    /* 4AE94 8005A694 03008214 */  bne        $a0, $v0, .L8005A6A4
    /* 4AE98 8005A698 00000000 */   nop
  .L8005A69C:
    /* 4AE9C 8005A69C BF690108 */  j          .L8005A6FC
    /* 4AEA0 8005A6A0 21100000 */   addu      $v0, $zero, $zero
  .L8005A6A4:
    /* 4AEA4 8005A6A4 1480033C */  lui        $v1, %hi(Cars_gNumAIRaceCars)
    /* 4AEA8 8005A6A8 04C8638C */  lw         $v1, %lo(Cars_gNumAIRaceCars)($v1)
    /* 4AEAC 8005A6AC 00000000 */  nop
    /* 4AEB0 8005A6B0 05006228 */  slti       $v0, $v1, 0x5
    /* 4AEB4 8005A6B4 02004010 */  beqz       $v0, .L8005A6C0
    /* 4AEB8 8005A6B8 4006043C */   lui       $a0, (0x6400000 >> 16)
    /* 4AEBC 8005A6BC 2003043C */  lui        $a0, (0x3200000 >> 16)
  .L8005A6C0:
    /* 4AEC0 8005A6C0 02006228 */  slti       $v0, $v1, 0x2
    /* 4AEC4 8005A6C4 02004010 */  beqz       $v0, .L8005A6D0
    /* 4AEC8 8005A6C8 00000000 */   nop
    /* 4AECC 8005A6CC C800043C */  lui        $a0, (0xC80000 >> 16)
  .L8005A6D0:
    /* 4AED0 8005A6D0 02006014 */  bnez       $v1, .L8005A6DC
    /* 4AED4 8005A6D4 80181100 */   sll       $v1, $s1, 2
    /* 4AED8 8005A6D8 21200000 */  addu       $a0, $zero, $zero
  .L8005A6DC:
    /* 4AEDC 8005A6DC 21187100 */  addu       $v1, $v1, $s1
    /* 4AEE0 8005A6E0 80180300 */  sll        $v1, $v1, 2
    /* 4AEE4 8005A6E4 21187100 */  addu       $v1, $v1, $s1
    /* 4AEE8 8005A6E8 801C0300 */  sll        $v1, $v1, 18
    /* 4AEEC 8005A6EC 2118C300 */  addu       $v1, $a2, $v1
    /* 4AEF0 8005A6F0 21109200 */  addu       $v0, $a0, $s2
    /* 4AEF4 8005A6F4 2A104300 */  slt        $v0, $v0, $v1
    /* 4AEF8 8005A6F8 01004238 */  xori       $v0, $v0, 0x1
  .L8005A6FC:
    /* 4AEFC 8005A6FC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4AF00 8005A700 1800B28F */  lw         $s2, 0x18($sp)
    /* 4AF04 8005A704 1400B18F */  lw         $s1, 0x14($sp)
    /* 4AF08 8005A708 1000B08F */  lw         $s0, 0x10($sp)
    /* 4AF0C 8005A70C 0800E003 */  jr         $ra
    /* 4AF10 8005A710 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AI_IsMellowZone__FP8Car_tObji
