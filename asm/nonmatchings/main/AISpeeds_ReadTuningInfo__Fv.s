.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_ReadTuningInfo__Fv, 0x284

glabel AISpeeds_ReadTuningInfo__Fv
    /* 5DDEC 8006D5EC 58FFBD27 */  addiu      $sp, $sp, -0xA8
    /* 5DDF0 8006D5F0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 5DDF4 8006D5F4 0580053C */  lui        $a1, %hi(D_800554D0)
    /* 5DDF8 8006D5F8 1180023C */  lui        $v0, %hi(D_80116470)
    /* 5DDFC 8006D5FC 7064468C */  lw         $a2, %lo(D_80116470)($v0)
    /* 5DE00 8006D600 D054A524 */  addiu      $a1, $a1, %lo(D_800554D0)
    /* 5DE04 8006D604 9800B2AF */  sw         $s2, 0x98($sp)
    /* 5DE08 8006D608 21900000 */  addu       $s2, $zero, $zero
    /* 5DE0C 8006D60C A000BFAF */  sw         $ra, 0xA0($sp)
    /* 5DE10 8006D610 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* 5DE14 8006D614 9400B1AF */  sw         $s1, 0x94($sp)
    /* 5DE18 8006D618 2F91030C */  jal        sprintf
    /* 5DE1C 8006D61C 9000B0AF */   sw        $s0, 0x90($sp)
    /* 5DE20 8006D620 1000A427 */  addiu      $a0, $sp, 0x10
    /* 5DE24 8006D624 21284002 */  addu       $a1, $s2, $zero
    /* 5DE28 8006D628 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 5DE2C 8006D62C 01000624 */   addiu     $a2, $zero, 0x1
    /* 5DE30 8006D630 21884000 */  addu       $s1, $v0, $zero
    /* 5DE34 8006D634 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DE38 8006D638 21202002 */   addu      $a0, $s1, $zero
    /* 5DE3C 8006D63C 1180023C */  lui        $v0, %hi(CaravanInfo)
    /* 5DE40 8006D640 B4DD5024 */  addiu      $s0, $v0, %lo(CaravanInfo)
  .L8006D644:
    /* 5DE44 8006D644 0600422A */  slti       $v0, $s2, 0x6
    /* 5DE48 8006D648 14004010 */  beqz       $v0, .L8006D69C
    /* 5DE4C 8006D64C 1180033C */   lui       $v1, %hi(GameSetup_gData)
    /* 5DE50 8006D650 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DE54 8006D654 21202002 */   addu      $a0, $s1, $zero
    /* 5DE58 8006D658 21202002 */  addu       $a0, $s1, $zero
    /* 5DE5C 8006D65C 40110200 */  sll        $v0, $v0, 5
    /* 5DE60 8006D660 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DE64 8006D664 000002AE */   sw        $v0, 0x0($s0)
    /* 5DE68 8006D668 21202002 */  addu       $a0, $s1, $zero
    /* 5DE6C 8006D66C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DE70 8006D670 040002AE */   sw        $v0, 0x4($s0)
    /* 5DE74 8006D674 21202002 */  addu       $a0, $s1, $zero
    /* 5DE78 8006D678 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DE7C 8006D67C 080002AE */   sw        $v0, 0x8($s0)
    /* 5DE80 8006D680 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 5DE84 8006D684 0191030C */  jal        rdiv
    /* 5DE88 8006D688 402D0200 */   sll       $a1, $v0, 21
    /* 5DE8C 8006D68C 0C0002AE */  sw         $v0, 0xC($s0)
    /* 5DE90 8006D690 10001026 */  addiu      $s0, $s0, 0x10
    /* 5DE94 8006D694 91B50108 */  j          .L8006D644
    /* 5DE98 8006D698 01005226 */   addiu     $s2, $s2, 0x1
  .L8006D69C:
    /* 5DE9C 8006D69C EC31628C */  lw         $v0, %lo(GameSetup_gData)($v1)
    /* 5DEA0 8006D6A0 00000000 */  nop
    /* 5DEA4 8006D6A4 22004014 */  bnez       $v0, .L8006D730
    /* 5DEA8 8006D6A8 21800000 */   addu      $s0, $zero, $zero
    /* 5DEAC 8006D6AC 1480023C */  lui        $v0, %hi(Cars_gNumAIRaceCars)
    /* 5DEB0 8006D6B0 04C8428C */  lw         $v0, %lo(Cars_gNumAIRaceCars)($v0)
    /* 5DEB4 8006D6B4 00000000 */  nop
    /* 5DEB8 8006D6B8 1D004018 */  blez       $v0, .L8006D730
    /* 5DEBC 8006D6BC 1180023C */   lui       $v0, %hi(Cars_gAIRaceCarList)
    /* 5DEC0 8006D6C0 6CFA428C */  lw         $v0, %lo(Cars_gAIRaceCarList)($v0)
    /* 5DEC4 8006D6C4 21800000 */  addu       $s0, $zero, $zero
    /* 5DEC8 8006D6C8 8802428C */  lw         $v0, 0x288($v0)
    /* 5DECC 8006D6CC EC317224 */  addiu      $s2, $v1, %lo(GameSetup_gData)
    /* 5DED0 8006D6D0 0000538C */  lw         $s3, 0x0($v0)
  .L8006D6D4:
    /* 5DED4 8006D6D4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DED8 8006D6D8 21202002 */   addu      $a0, $s1, $zero
    /* 5DEDC 8006D6DC 21202002 */  addu       $a0, $s1, $zero
    /* 5DEE0 8006D6E0 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DEE4 8006D6E4 8000A2AF */   sw        $v0, 0x80($sp)
    /* 5DEE8 8006D6E8 21202002 */  addu       $a0, $s1, $zero
    /* 5DEEC 8006D6EC C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DEF0 8006D6F0 8400A2AF */   sw        $v0, 0x84($sp)
    /* 5DEF4 8006D6F4 08001316 */  bne        $s0, $s3, .L8006D718
    /* 5DEF8 8006D6F8 8800A2AF */   sw        $v0, 0x88($sp)
    /* 5DEFC 8006D6FC 0800428E */  lw         $v0, 0x8($s2)
    /* 5DF00 8006D700 00000000 */  nop
    /* 5DF04 8006D704 80100200 */  sll        $v0, $v0, 2
    /* 5DF08 8006D708 2110A203 */  addu       $v0, $sp, $v0
    /* 5DF0C 8006D70C 8000428C */  lw         $v0, 0x80($v0)
    /* 5DF10 8006D710 00000000 */  nop
    /* 5DF14 8006D714 100042AE */  sw         $v0, 0x10($s2)
  .L8006D718:
    /* 5DF18 8006D718 01001026 */  addiu      $s0, $s0, 0x1
    /* 5DF1C 8006D71C 1600022A */  slti       $v0, $s0, 0x16
    /* 5DF20 8006D720 0D004010 */  beqz       $v0, .L8006D758
    /* 5DF24 8006D724 00000000 */   nop
    /* 5DF28 8006D728 B5B50108 */  j          .L8006D6D4
    /* 5DF2C 8006D72C 00000000 */   nop
  .L8006D730:
    /* 5DF30 8006D730 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DF34 8006D734 21202002 */   addu      $a0, $s1, $zero
    /* 5DF38 8006D738 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DF3C 8006D73C 21202002 */   addu      $a0, $s1, $zero
    /* 5DF40 8006D740 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DF44 8006D744 21202002 */   addu      $a0, $s1, $zero
    /* 5DF48 8006D748 01001026 */  addiu      $s0, $s0, 0x1
    /* 5DF4C 8006D74C 1600022A */  slti       $v0, $s0, 0x16
    /* 5DF50 8006D750 F7FF4014 */  bnez       $v0, .L8006D730
    /* 5DF54 8006D754 00000000 */   nop
  .L8006D758:
    /* 5DF58 8006D758 680080AF */  sw         $zero, %gp_rel(D_8013C5B4)($gp)
    /* 5DF5C 8006D75C 21800000 */  addu       $s0, $zero, $zero
    /* 5DF60 8006D760 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5DF64 8006D764 EC315324 */  addiu      $s3, $v0, %lo(GameSetup_gData)
  .L8006D768:
    /* 5DF68 8006D768 0C00022A */  slti       $v0, $s0, 0xC
    /* 5DF6C 8006D76C 16004010 */  beqz       $v0, .L8006D7C8
    /* 5DF70 8006D770 00000000 */   nop
    /* 5DF74 8006D774 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DF78 8006D778 21202002 */   addu      $a0, $s1, $zero
    /* 5DF7C 8006D77C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DF80 8006D780 21202002 */   addu      $a0, $s1, $zero
    /* 5DF84 8006D784 21202002 */  addu       $a0, $s1, $zero
    /* 5DF88 8006D788 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DF8C 8006D78C 21904000 */   addu      $s2, $v0, $zero
    /* 5DF90 8006D790 5400638E */  lw         $v1, 0x54($s3)
    /* 5DF94 8006D794 00000000 */  nop
    /* 5DF98 8006D798 02006014 */  bnez       $v1, .L8006D7A4
    /* 5DF9C 8006D79C 21284000 */   addu      $a1, $v0, $zero
    /* 5DFA0 8006D7A0 0100053C */  lui        $a1, (0x10000 >> 16)
  .L8006D7A4:
    /* 5DFA4 8006D7A4 3C00628E */  lw         $v0, 0x3C($s3)
    /* 5DFA8 8006D7A8 00000000 */  nop
    /* 5DFAC 8006D7AC 04000216 */  bne        $s0, $v0, .L8006D7C0
    /* 5DFB0 8006D7B0 00000000 */   nop
    /* 5DFB4 8006D7B4 CA90030C */  jal        fixedmult
    /* 5DFB8 8006D7B8 21204002 */   addu      $a0, $s2, $zero
    /* 5DFBC 8006D7BC 680082AF */  sw         $v0, %gp_rel(D_8013C5B4)($gp)
  .L8006D7C0:
    /* 5DFC0 8006D7C0 DAB50108 */  j          .L8006D768
    /* 5DFC4 8006D7C4 01001026 */   addiu     $s0, $s0, 0x1
  .L8006D7C8:
    /* 5DFC8 8006D7C8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5DFCC 8006D7CC 21202002 */   addu      $a0, $s1, $zero
    /* 5DFD0 8006D7D0 21304000 */  addu       $a2, $v0, $zero
    /* 5DFD4 8006D7D4 21280000 */  addu       $a1, $zero, $zero
    /* 5DFD8 8006D7D8 0100073C */  lui        $a3, (0x10000 >> 16)
    /* 5DFDC 8006D7DC 6400848F */  lw         $a0, %gp_rel(D_8013C5B0)($gp)
    /* 5DFE0 8006D7E0 2118A000 */  addu       $v1, $a1, $zero
  .L8006D7E4:
    /* 5DFE4 8006D7E4 02006104 */  bgez       $v1, .L8006D7F0
    /* 5DFE8 8006D7E8 21106000 */   addu      $v0, $v1, $zero
    /* 5DFEC 8006D7EC 3F006224 */  addiu      $v0, $v1, 0x3F
  .L8006D7F0:
    /* 5DFF0 8006D7F0 83110200 */  sra        $v0, $v0, 6
    /* 5DFF4 8006D7F4 2310E200 */  subu       $v0, $a3, $v0
    /* 5DFF8 8006D7F8 000082AC */  sw         $v0, 0x0($a0)
    /* 5DFFC 8006D7FC 04008424 */  addiu      $a0, $a0, 0x4
    /* 5E000 8006D800 0100A524 */  addiu      $a1, $a1, 0x1
    /* 5E004 8006D804 4100A228 */  slti       $v0, $a1, 0x41
    /* 5E008 8006D808 F6FF4014 */  bnez       $v0, .L8006D7E4
    /* 5E00C 8006D80C 21186600 */   addu      $v1, $v1, $a2
    /* 5E010 8006D810 21202002 */  addu       $a0, $s1, $zero
    /* 5E014 8006D814 1180053C */  lui        $a1, %hi(engineUpgrade)
    /* 5E018 8006D818 E0DCA524 */  addiu      $a1, $a1, %lo(engineUpgrade)
    /* 5E01C 8006D81C CFEE020C */  jal        Udff_GetBuffer__FP10Udff_tInfoPci
    /* 5E020 8006D820 10000624 */   addiu     $a2, $zero, 0x10
    /* 5E024 8006D824 21202002 */  addu       $a0, $s1, $zero
    /* 5E028 8006D828 1180053C */  lui        $a1, %hi(suspensionUpgrade)
    /* 5E02C 8006D82C F0DCA524 */  addiu      $a1, $a1, %lo(suspensionUpgrade)
    /* 5E030 8006D830 CFEE020C */  jal        Udff_GetBuffer__FP10Udff_tInfoPci
    /* 5E034 8006D834 10000624 */   addiu     $a2, $zero, 0x10
    /* 5E038 8006D838 21202002 */  addu       $a0, $s1, $zero
    /* 5E03C 8006D83C 1180053C */  lui        $a1, %hi(aeroUpgrade)
    /* 5E040 8006D840 00DDA524 */  addiu      $a1, $a1, %lo(aeroUpgrade)
    /* 5E044 8006D844 CFEE020C */  jal        Udff_GetBuffer__FP10Udff_tInfoPci
    /* 5E048 8006D848 10000624 */   addiu     $a2, $zero, 0x10
    /* 5E04C 8006D84C B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 5E050 8006D850 21202002 */   addu      $a0, $s1, $zero
    /* 5E054 8006D854 A000BF8F */  lw         $ra, 0xA0($sp)
    /* 5E058 8006D858 9C00B38F */  lw         $s3, 0x9C($sp)
    /* 5E05C 8006D85C 9800B28F */  lw         $s2, 0x98($sp)
    /* 5E060 8006D860 9400B18F */  lw         $s1, 0x94($sp)
    /* 5E064 8006D864 9000B08F */  lw         $s0, 0x90($sp)
    /* 5E068 8006D868 0800E003 */  jr         $ra
    /* 5E06C 8006D86C A800BD27 */   addiu     $sp, $sp, 0xA8
endlabel AISpeeds_ReadTuningInfo__Fv
