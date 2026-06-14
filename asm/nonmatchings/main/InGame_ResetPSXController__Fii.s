.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InGame_ResetPSXController__Fii, 0x4C4

glabel InGame_ResetPSXController__Fii
    /* CCCCC 800DC4CC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* CCCD0 800DC4D0 1800B2AF */  sw         $s2, 0x18($sp)
    /* CCCD4 800DC4D4 21908000 */  addu       $s2, $a0, $zero
    /* CCCD8 800DC4D8 2800B6AF */  sw         $s6, 0x28($sp)
    /* CCCDC 800DC4DC 1480033C */  lui        $v1, %hi(gPadinfo)
    /* CCCE0 800DC4E0 9CE86324 */  addiu      $v1, $v1, %lo(gPadinfo)
    /* CCCE4 800DC4E4 40111200 */  sll        $v0, $s2, 5
    /* CCCE8 800DC4E8 21104300 */  addu       $v0, $v0, $v1
    /* CCCEC 800DC4EC 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* CCCF0 800DC4F0 2400B5AF */  sw         $s5, 0x24($sp)
    /* CCCF4 800DC4F4 2000B4AF */  sw         $s4, 0x20($sp)
    /* CCCF8 800DC4F8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CCCFC 800DC4FC 1400B1AF */  sw         $s1, 0x14($sp)
    /* CCD00 800DC500 1000B0AF */  sw         $s0, 0x10($sp)
    /* CCD04 800DC504 05005390 */  lbu        $s3, 0x5($v0)
    /* CCD08 800DC508 1180023C */  lui        $v0, %hi(Input_gHandler)
    /* CCD0C 800DC50C 143C5424 */  addiu      $s4, $v0, %lo(Input_gHandler)
    /* CCD10 800DC510 23000224 */  addiu      $v0, $zero, 0x23
    /* CCD14 800DC514 08006212 */  beq        $s3, $v0, .L800DC538
    /* CCD18 800DC518 21B0A000 */   addu      $s6, $a1, $zero
    /* CCD1C 800DC51C 53000224 */  addiu      $v0, $zero, 0x53
    /* CCD20 800DC520 03006212 */  beq        $s3, $v0, .L800DC530
    /* CCD24 800DC524 73000224 */   addiu     $v0, $zero, 0x73
    /* CCD28 800DC528 04006216 */  bne        $s3, $v0, .L800DC53C
    /* CCD2C 800DC52C 02000224 */   addiu     $v0, $zero, 0x2
  .L800DC530:
    /* CCD30 800DC530 4F710308 */  j          .L800DC53C
    /* CCD34 800DC534 01000224 */   addiu     $v0, $zero, 0x1
  .L800DC538:
    /* CCD38 800DC538 21100000 */  addu       $v0, $zero, $zero
  .L800DC53C:
    /* CCD3C 800DC53C 21984000 */  addu       $s3, $v0, $zero
    /* CCD40 800DC540 1180023C */  lui        $v0, %hi(frontEnd)
    /* CCD44 800DC544 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* CCD48 800DC548 40181200 */  sll        $v1, $s2, 1
    /* CCD4C 800DC54C 21286200 */  addu       $a1, $v1, $v0
    /* CCD50 800DC550 1480023C */  lui        $v0, %hi(gPadinfo)
    /* CCD54 800DC554 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* CCD58 800DC558 40191200 */  sll        $v1, $s2, 5
    /* CCD5C 800DC55C 21206200 */  addu       $a0, $v1, $v0
    /* CCD60 800DC560 5E03A384 */  lh         $v1, 0x35E($a1)
    /* CCD64 800DC564 05008290 */  lbu        $v0, 0x5($a0)
    /* CCD68 800DC568 00000000 */  nop
    /* CCD6C 800DC56C 04006210 */  beq        $v1, $v0, .L800DC580
    /* CCD70 800DC570 80A81200 */   sll       $s5, $s2, 2
    /* CCD74 800DC574 05008290 */  lbu        $v0, 0x5($a0)
    /* CCD78 800DC578 00000000 */  nop
    /* CCD7C 800DC57C 5E03A2A4 */  sh         $v0, 0x35E($a1)
  .L800DC580:
    /* CCD80 800DC580 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CCD84 800DC584 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CCD88 800DC588 2110A202 */  addu       $v0, $s5, $v0
    /* CCD8C 800DC58C 1280033C */  lui        $v1, %hi(mappings)
    /* CCD90 800DC590 FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* CCD94 800DC594 600056AC */  sw         $s6, 0x60($v0)
    /* CCD98 800DC598 80101600 */  sll        $v0, $s6, 2
    /* CCD9C 800DC59C 21105600 */  addu       $v0, $v0, $s6
    /* CCDA0 800DC5A0 C0100200 */  sll        $v0, $v0, 3
    /* CCDA4 800DC5A4 23105600 */  subu       $v0, $v0, $s6
    /* CCDA8 800DC5A8 21105300 */  addu       $v0, $v0, $s3
    /* CCDAC 800DC5AC 80100200 */  sll        $v0, $v0, 2
    /* CCDB0 800DC5B0 21804300 */  addu       $s0, $v0, $v1
    /* CCDB4 800DC5B4 0000048E */  lw         $a0, 0x0($s0)
    /* CCDB8 800DC5B8 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCDBC 800DC5BC 21284002 */   addu      $a1, $s2, $zero
    /* CCDC0 800DC5C0 1480033C */  lui        $v1, %hi(D_8013DAC0)
    /* CCDC4 800DC5C4 C0DA6324 */  addiu      $v1, $v1, %lo(D_8013DAC0)
    /* CCDC8 800DC5C8 2188A302 */  addu       $s1, $s5, $v1
    /* CCDCC 800DC5CC 0000248E */  lw         $a0, 0x0($s1)
    /* CCDD0 800DC5D0 4F000324 */  addiu      $v1, $zero, 0x4F
    /* CCDD4 800DC5D4 23186400 */  subu       $v1, $v1, $a0
    /* CCDD8 800DC5D8 80180300 */  sll        $v1, $v1, 2
    /* CCDDC 800DC5DC 21187400 */  addu       $v1, $v1, $s4
    /* CCDE0 800DC5E0 000062AC */  sw         $v0, 0x0($v1)
    /* CCDE4 800DC5E4 0C00048E */  lw         $a0, 0xC($s0)
    /* CCDE8 800DC5E8 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCDEC 800DC5EC 21284002 */   addu      $a1, $s2, $zero
    /* CCDF0 800DC5F0 0000248E */  lw         $a0, 0x0($s1)
    /* CCDF4 800DC5F4 50000324 */  addiu      $v1, $zero, 0x50
    /* CCDF8 800DC5F8 23186400 */  subu       $v1, $v1, $a0
    /* CCDFC 800DC5FC 80180300 */  sll        $v1, $v1, 2
    /* CCE00 800DC600 21187400 */  addu       $v1, $v1, $s4
    /* CCE04 800DC604 000062AC */  sw         $v0, 0x0($v1)
    /* CCE08 800DC608 1800048E */  lw         $a0, 0x18($s0)
    /* CCE0C 800DC60C 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCE10 800DC610 21284002 */   addu      $a1, $s2, $zero
    /* CCE14 800DC614 0000248E */  lw         $a0, 0x0($s1)
    /* CCE18 800DC618 51000324 */  addiu      $v1, $zero, 0x51
    /* CCE1C 800DC61C 23186400 */  subu       $v1, $v1, $a0
    /* CCE20 800DC620 80180300 */  sll        $v1, $v1, 2
    /* CCE24 800DC624 21187400 */  addu       $v1, $v1, $s4
    /* CCE28 800DC628 000062AC */  sw         $v0, 0x0($v1)
    /* CCE2C 800DC62C 2400048E */  lw         $a0, 0x24($s0)
    /* CCE30 800DC630 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCE34 800DC634 21284002 */   addu      $a1, $s2, $zero
    /* CCE38 800DC638 0000248E */  lw         $a0, 0x0($s1)
    /* CCE3C 800DC63C 52000324 */  addiu      $v1, $zero, 0x52
    /* CCE40 800DC640 23186400 */  subu       $v1, $v1, $a0
    /* CCE44 800DC644 80180300 */  sll        $v1, $v1, 2
    /* CCE48 800DC648 21187400 */  addu       $v1, $v1, $s4
    /* CCE4C 800DC64C 000062AC */  sw         $v0, 0x0($v1)
    /* CCE50 800DC650 6000048E */  lw         $a0, 0x60($s0)
    /* CCE54 800DC654 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCE58 800DC658 21284002 */   addu      $a1, $s2, $zero
    /* CCE5C 800DC65C 2118B402 */  addu       $v1, $s5, $s4
    /* CCE60 800DC660 B80262AC */  sw         $v0, 0x2B8($v1)
    /* CCE64 800DC664 5400048E */  lw         $a0, 0x54($s0)
    /* CCE68 800DC668 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCE6C 800DC66C 21284002 */   addu      $a1, $s2, $zero
    /* CCE70 800DC670 0000248E */  lw         $a0, 0x0($s1)
    /* CCE74 800DC674 75000324 */  addiu      $v1, $zero, 0x75
    /* CCE78 800DC678 23186400 */  subu       $v1, $v1, $a0
    /* CCE7C 800DC67C 80180300 */  sll        $v1, $v1, 2
    /* CCE80 800DC680 21187400 */  addu       $v1, $v1, $s4
    /* CCE84 800DC684 000062AC */  sw         $v0, 0x0($v1)
    /* CCE88 800DC688 5400048E */  lw         $a0, 0x54($s0)
    /* CCE8C 800DC68C 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCE90 800DC690 21284002 */   addu      $a1, $s2, $zero
    /* CCE94 800DC694 0000248E */  lw         $a0, 0x0($s1)
    /* CCE98 800DC698 65000324 */  addiu      $v1, $zero, 0x65
    /* CCE9C 800DC69C 23186400 */  subu       $v1, $v1, $a0
    /* CCEA0 800DC6A0 80180300 */  sll        $v1, $v1, 2
    /* CCEA4 800DC6A4 21187400 */  addu       $v1, $v1, $s4
    /* CCEA8 800DC6A8 000062AC */  sw         $v0, 0x0($v1)
    /* CCEAC 800DC6AC 3000048E */  lw         $a0, 0x30($s0)
    /* CCEB0 800DC6B0 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCEB4 800DC6B4 21284002 */   addu      $a1, $s2, $zero
    /* CCEB8 800DC6B8 0000248E */  lw         $a0, 0x0($s1)
    /* CCEBC 800DC6BC 53000324 */  addiu      $v1, $zero, 0x53
    /* CCEC0 800DC6C0 23186400 */  subu       $v1, $v1, $a0
    /* CCEC4 800DC6C4 80180300 */  sll        $v1, $v1, 2
    /* CCEC8 800DC6C8 21187400 */  addu       $v1, $v1, $s4
    /* CCECC 800DC6CC 000062AC */  sw         $v0, 0x0($v1)
    /* CCED0 800DC6D0 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* CCED4 800DC6D4 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* CCED8 800DC6D8 2110A202 */  addu       $v0, $s5, $v0
    /* CCEDC 800DC6DC 0000428C */  lw         $v0, 0x0($v0)
    /* CCEE0 800DC6E0 00000000 */  nop
    /* CCEE4 800DC6E4 6002428C */  lw         $v0, 0x260($v0)
    /* CCEE8 800DC6E8 00000000 */  nop
    /* CCEEC 800DC6EC 00024230 */  andi       $v0, $v0, 0x200
    /* CCEF0 800DC6F0 0A004010 */  beqz       $v0, .L800DC71C
    /* CCEF4 800DC6F4 01000224 */   addiu     $v0, $zero, 0x1
    /* CCEF8 800DC6F8 7800048E */  lw         $a0, 0x78($s0)
    /* CCEFC 800DC6FC 02006216 */  bne        $s3, $v0, .L800DC708
    /* CCF00 800DC700 00000000 */   nop
    /* CCF04 800DC704 06008434 */  ori        $a0, $a0, 0x6
  .L800DC708:
    /* CCF08 800DC708 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCF0C 800DC70C 21284002 */   addu      $a1, $s2, $zero
    /* CCF10 800DC710 0000248E */  lw         $a0, 0x0($s1)
    /* CCF14 800DC714 E2710308 */  j          .L800DC788
    /* CCF18 800DC718 81000324 */   addiu     $v1, $zero, 0x81
  .L800DC71C:
    /* CCF1C 800DC71C 0000048E */  lw         $a0, 0x0($s0)
    /* CCF20 800DC720 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCF24 800DC724 21280000 */   addu      $a1, $zero, $zero
    /* CCF28 800DC728 0000248E */  lw         $a0, 0x0($s1)
    /* CCF2C 800DC72C 7D000324 */  addiu      $v1, $zero, 0x7D
    /* CCF30 800DC730 23186400 */  subu       $v1, $v1, $a0
    /* CCF34 800DC734 80180300 */  sll        $v1, $v1, 2
    /* CCF38 800DC738 21187400 */  addu       $v1, $v1, $s4
    /* CCF3C 800DC73C 000062AC */  sw         $v0, 0x0($v1)
    /* CCF40 800DC740 0C00048E */  lw         $a0, 0xC($s0)
    /* CCF44 800DC744 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCF48 800DC748 21280000 */   addu      $a1, $zero, $zero
    /* CCF4C 800DC74C 0000248E */  lw         $a0, 0x0($s1)
    /* CCF50 800DC750 7E000324 */  addiu      $v1, $zero, 0x7E
    /* CCF54 800DC754 23186400 */  subu       $v1, $v1, $a0
    /* CCF58 800DC758 80180300 */  sll        $v1, $v1, 2
    /* CCF5C 800DC75C 21187400 */  addu       $v1, $v1, $s4
    /* CCF60 800DC760 000062AC */  sw         $v0, 0x0($v1)
    /* CCF64 800DC764 01000224 */  addiu      $v0, $zero, 0x1
    /* CCF68 800DC768 7800048E */  lw         $a0, 0x78($s0)
    /* CCF6C 800DC76C 02006216 */  bne        $s3, $v0, .L800DC778
    /* CCF70 800DC770 00000000 */   nop
    /* CCF74 800DC774 06008434 */  ori        $a0, $a0, 0x6
  .L800DC778:
    /* CCF78 800DC778 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCF7C 800DC77C 21284002 */   addu      $a1, $s2, $zero
    /* CCF80 800DC780 0000248E */  lw         $a0, 0x0($s1)
    /* CCF84 800DC784 82000324 */  addiu      $v1, $zero, 0x82
  .L800DC788:
    /* CCF88 800DC788 23186400 */  subu       $v1, $v1, $a0
    /* CCF8C 800DC78C 80180300 */  sll        $v1, $v1, 2
    /* CCF90 800DC790 21187400 */  addu       $v1, $v1, $s4
    /* CCF94 800DC794 000062AC */  sw         $v0, 0x0($v1)
    /* CCF98 800DC798 1180023C */  lui        $v0, %hi(D_80113240)
    /* CCF9C 800DC79C 4032428C */  lw         $v0, %lo(D_80113240)($v0)
    /* CCFA0 800DC7A0 00000000 */  nop
    /* CCFA4 800DC7A4 1C004010 */  beqz       $v0, .L800DC818
    /* CCFA8 800DC7A8 1280033C */   lui       $v1, %hi(mappings)
    /* CCFAC 800DC7AC FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* CCFB0 800DC7B0 80101600 */  sll        $v0, $s6, 2
    /* CCFB4 800DC7B4 21105600 */  addu       $v0, $v0, $s6
    /* CCFB8 800DC7B8 C0100200 */  sll        $v0, $v0, 3
    /* CCFBC 800DC7BC 23105600 */  subu       $v0, $v0, $s6
    /* CCFC0 800DC7C0 21105300 */  addu       $v0, $v0, $s3
    /* CCFC4 800DC7C4 80100200 */  sll        $v0, $v0, 2
    /* CCFC8 800DC7C8 21104300 */  addu       $v0, $v0, $v1
    /* CCFCC 800DC7CC 6C00448C */  lw         $a0, 0x6C($v0)
    /* CCFD0 800DC7D0 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CCFD4 800DC7D4 21284002 */   addu      $a1, $s2, $zero
    /* CCFD8 800DC7D8 80201200 */  sll        $a0, $s2, 2
    /* CCFDC 800DC7DC 1480033C */  lui        $v1, %hi(D_8013DAC0)
    /* CCFE0 800DC7E0 C0DA6324 */  addiu      $v1, $v1, %lo(D_8013DAC0)
    /* CCFE4 800DC7E4 21808300 */  addu       $s0, $a0, $v1
    /* CCFE8 800DC7E8 0000048E */  lw         $a0, 0x0($s0)
    /* CCFEC 800DC7EC 73000324 */  addiu      $v1, $zero, 0x73
    /* CCFF0 800DC7F0 23186400 */  subu       $v1, $v1, $a0
    /* CCFF4 800DC7F4 80180300 */  sll        $v1, $v1, 2
    /* CCFF8 800DC7F8 21187400 */  addu       $v1, $v1, $s4
    /* CCFFC 800DC7FC 000062AC */  sw         $v0, 0x0($v1)
    /* CD000 800DC800 01000224 */  addiu      $v0, $zero, 0x1
    /* CD004 800DC804 02006216 */  bne        $s3, $v0, .L800DC810
    /* CD008 800DC808 21280000 */   addu      $a1, $zero, $zero
    /* CD00C 800DC80C 06000524 */  addiu      $a1, $zero, 0x6
  .L800DC810:
    /* CD010 800DC810 21720308 */  j          .L800DC884
    /* CD014 800DC814 2120A000 */   addu      $a0, $a1, $zero
  .L800DC818:
    /* CD018 800DC818 21200000 */  addu       $a0, $zero, $zero
    /* CD01C 800DC81C 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CD020 800DC820 21284002 */   addu      $a1, $s2, $zero
    /* CD024 800DC824 80201200 */  sll        $a0, $s2, 2
    /* CD028 800DC828 1480033C */  lui        $v1, %hi(D_8013DAC0)
    /* CD02C 800DC82C C0DA6324 */  addiu      $v1, $v1, %lo(D_8013DAC0)
    /* CD030 800DC830 21808300 */  addu       $s0, $a0, $v1
    /* CD034 800DC834 0000048E */  lw         $a0, 0x0($s0)
    /* CD038 800DC838 73000324 */  addiu      $v1, $zero, 0x73
    /* CD03C 800DC83C 23186400 */  subu       $v1, $v1, $a0
    /* CD040 800DC840 80180300 */  sll        $v1, $v1, 2
    /* CD044 800DC844 21187400 */  addu       $v1, $v1, $s4
    /* CD048 800DC848 000062AC */  sw         $v0, 0x0($v1)
    /* CD04C 800DC84C 1280033C */  lui        $v1, %hi(mappings)
    /* CD050 800DC850 FC0D6324 */  addiu      $v1, $v1, %lo(mappings)
    /* CD054 800DC854 80101600 */  sll        $v0, $s6, 2
    /* CD058 800DC858 21105600 */  addu       $v0, $v0, $s6
    /* CD05C 800DC85C C0100200 */  sll        $v0, $v0, 3
    /* CD060 800DC860 23105600 */  subu       $v0, $v0, $s6
    /* CD064 800DC864 21105300 */  addu       $v0, $v0, $s3
    /* CD068 800DC868 80100200 */  sll        $v0, $v0, 2
    /* CD06C 800DC86C 21104300 */  addu       $v0, $v0, $v1
    /* CD070 800DC870 6C00448C */  lw         $a0, 0x6C($v0)
    /* CD074 800DC874 01000224 */  addiu      $v0, $zero, 0x1
    /* CD078 800DC878 02006216 */  bne        $s3, $v0, .L800DC884
    /* CD07C 800DC87C 00000000 */   nop
    /* CD080 800DC880 06008434 */  ori        $a0, $a0, 0x6
  .L800DC884:
    /* CD084 800DC884 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CD088 800DC888 21284002 */   addu      $a1, $s2, $zero
    /* CD08C 800DC88C 0000048E */  lw         $a0, 0x0($s0)
    /* CD090 800DC890 54000324 */  addiu      $v1, $zero, 0x54
    /* CD094 800DC894 23186400 */  subu       $v1, $v1, $a0
    /* CD098 800DC898 80180300 */  sll        $v1, $v1, 2
    /* CD09C 800DC89C 21187400 */  addu       $v1, $v1, $s4
    /* CD0A0 800DC8A0 000062AC */  sw         $v0, 0x0($v1)
    /* CD0A4 800DC8A4 1280023C */  lui        $v0, %hi(mappings)
    /* CD0A8 800DC8A8 FC0D4224 */  addiu      $v0, $v0, %lo(mappings)
    /* CD0AC 800DC8AC 80801600 */  sll        $s0, $s6, 2
    /* CD0B0 800DC8B0 21801602 */  addu       $s0, $s0, $s6
    /* CD0B4 800DC8B4 C0801000 */  sll        $s0, $s0, 3
    /* CD0B8 800DC8B8 23801602 */  subu       $s0, $s0, $s6
    /* CD0BC 800DC8BC 21801302 */  addu       $s0, $s0, $s3
    /* CD0C0 800DC8C0 80801000 */  sll        $s0, $s0, 2
    /* CD0C4 800DC8C4 21800202 */  addu       $s0, $s0, $v0
    /* CD0C8 800DC8C8 3C00048E */  lw         $a0, 0x3C($s0)
    /* CD0CC 800DC8CC 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CD0D0 800DC8D0 21284002 */   addu      $a1, $s2, $zero
    /* CD0D4 800DC8D4 80881200 */  sll        $s1, $s2, 2
    /* CD0D8 800DC8D8 1480033C */  lui        $v1, %hi(D_8013DAC0)
    /* CD0DC 800DC8DC C0DA6324 */  addiu      $v1, $v1, %lo(D_8013DAC0)
    /* CD0E0 800DC8E0 21882302 */  addu       $s1, $s1, $v1
    /* CD0E4 800DC8E4 0000248E */  lw         $a0, 0x0($s1)
    /* CD0E8 800DC8E8 66000324 */  addiu      $v1, $zero, 0x66
    /* CD0EC 800DC8EC 23186400 */  subu       $v1, $v1, $a0
    /* CD0F0 800DC8F0 80180300 */  sll        $v1, $v1, 2
    /* CD0F4 800DC8F4 21187400 */  addu       $v1, $v1, $s4
    /* CD0F8 800DC8F8 000062AC */  sw         $v0, 0x0($v1)
    /* CD0FC 800DC8FC 4800048E */  lw         $a0, 0x48($s0)
    /* CD100 800DC900 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CD104 800DC904 21284002 */   addu      $a1, $s2, $zero
    /* CD108 800DC908 0000248E */  lw         $a0, 0x0($s1)
    /* CD10C 800DC90C 67000324 */  addiu      $v1, $zero, 0x67
    /* CD110 800DC910 23186400 */  subu       $v1, $v1, $a0
    /* CD114 800DC914 80180300 */  sll        $v1, $v1, 2
    /* CD118 800DC918 21187400 */  addu       $v1, $v1, $s4
    /* CD11C 800DC91C 000062AC */  sw         $v0, 0x0($v1)
    /* CD120 800DC920 9000048E */  lw         $a0, 0x90($s0)
    /* CD124 800DC924 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CD128 800DC928 21284002 */   addu      $a1, $s2, $zero
    /* CD12C 800DC92C 0000248E */  lw         $a0, 0x0($s1)
    /* CD130 800DC930 68000324 */  addiu      $v1, $zero, 0x68
    /* CD134 800DC934 23186400 */  subu       $v1, $v1, $a0
    /* CD138 800DC938 80180300 */  sll        $v1, $v1, 2
    /* CD13C 800DC93C 21187400 */  addu       $v1, $v1, $s4
    /* CD140 800DC940 000062AC */  sw         $v0, 0x0($v1)
    /* CD144 800DC944 8400048E */  lw         $a0, 0x84($s0)
    /* CD148 800DC948 6472030C */  jal        InGame_GetPSXPadValue__Fii
    /* CD14C 800DC94C 21284002 */   addu      $a1, $s2, $zero
    /* CD150 800DC950 0000248E */  lw         $a0, 0x0($s1)
    /* CD154 800DC954 4D000324 */  addiu      $v1, $zero, 0x4D
    /* CD158 800DC958 23186400 */  subu       $v1, $v1, $a0
    /* CD15C 800DC95C 80180300 */  sll        $v1, $v1, 2
    /* CD160 800DC960 21187400 */  addu       $v1, $v1, $s4
    /* CD164 800DC964 000062AC */  sw         $v0, 0x0($v1)
    /* CD168 800DC968 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* CD16C 800DC96C 2800B68F */  lw         $s6, 0x28($sp)
    /* CD170 800DC970 2400B58F */  lw         $s5, 0x24($sp)
    /* CD174 800DC974 2000B48F */  lw         $s4, 0x20($sp)
    /* CD178 800DC978 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CD17C 800DC97C 1800B28F */  lw         $s2, 0x18($sp)
    /* CD180 800DC980 1400B18F */  lw         $s1, 0x14($sp)
    /* CD184 800DC984 1000B08F */  lw         $s0, 0x10($sp)
    /* CD188 800DC988 0800E003 */  jr         $ra
    /* CD18C 800DC98C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel InGame_ResetPSXController__Fii
