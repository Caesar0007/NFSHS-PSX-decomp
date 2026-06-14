.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDallocchan, 0x4A8

glabel iSNDallocchan
    /* EEF64 800FE764 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* EEF68 800FE768 2140A000 */  addu       $t0, $a1, $zero
    /* EEF6C 800FE76C F7FF0924 */  addiu      $t1, $zero, -0x9
    /* EEF70 800FE770 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* EEF74 800FE774 21980000 */  addu       $s3, $zero, $zero
    /* EEF78 800FE778 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* EEF7C 800FE77C 21B86002 */  addu       $s7, $s3, $zero
    /* EEF80 800FE780 4400BFAF */  sw         $ra, 0x44($sp)
    /* EEF84 800FE784 4000BEAF */  sw         $fp, 0x40($sp)
    /* EEF88 800FE788 3800B6AF */  sw         $s6, 0x38($sp)
    /* EEF8C 800FE78C 3400B5AF */  sw         $s5, 0x34($sp)
    /* EEF90 800FE790 3000B4AF */  sw         $s4, 0x30($sp)
    /* EEF94 800FE794 2800B2AF */  sw         $s2, 0x28($sp)
    /* EEF98 800FE798 2400B1AF */  sw         $s1, 0x24($sp)
    /* EEF9C 800FE79C 2000B0AF */  sw         $s0, 0x20($sp)
    /* EEFA0 800FE7A0 4800A4AF */  sw         $a0, 0x48($sp)
    /* EEFA4 800FE7A4 5000A6AF */  sw         $a2, 0x50($sp)
    /* EEFA8 800FE7A8 5400A7AF */  sw         $a3, 0x54($sp)
    /* EEFAC 800FE7AC 0A000019 */  blez       $t0, .L800FE7D8
    /* EEFB0 800FE7B0 1000A9AF */   sw        $t1, 0x10($sp)
    /* EEFB4 800FE7B4 1480023C */  lui        $v0, %hi(sndchanreserved)
    /* EEFB8 800FE7B8 14794424 */  addiu      $a0, $v0, %lo(sndchanreserved)
    /* EEFBC 800FE7BC FFFF0324 */  addiu      $v1, $zero, -0x1
    /* EEFC0 800FE7C0 21106402 */  addu       $v0, $s3, $a0
  .L800FE7C4:
    /* EEFC4 800FE7C4 000043A0 */  sb         $v1, 0x0($v0)
    /* EEFC8 800FE7C8 01007326 */  addiu      $s3, $s3, 0x1
    /* EEFCC 800FE7CC 2A106802 */  slt        $v0, $s3, $t0
    /* EEFD0 800FE7D0 FCFF4014 */  bnez       $v0, .L800FE7C4
    /* EEFD4 800FE7D4 21106402 */   addu      $v0, $s3, $a0
  .L800FE7D8:
    /* EEFD8 800FE7D8 1380033C */  lui        $v1, %hi(D_80136DEC)
    /* EEFDC 800FE7DC EC6D628C */  lw         $v0, %lo(D_80136DEC)($v1)
    /* EEFE0 800FE7E0 00000000 */  nop
    /* EEFE4 800FE7E4 20004224 */  addiu      $v0, $v0, 0x20
    /* EEFE8 800FE7E8 02004104 */  bgez       $v0, .L800FE7F4
    /* EEFEC 800FE7EC EC6D62AC */   sw        $v0, %lo(D_80136DEC)($v1)
    /* EEFF0 800FE7F0 EC6D60AC */  sw         $zero, %lo(D_80136DEC)($v1)
  .L800FE7F4:
    /* EEFF4 800FE7F4 2A10E802 */  slt        $v0, $s7, $t0
    /* EEFF8 800FE7F8 77004010 */  beqz       $v0, .L800FE9D8
    /* EEFFC 800FE7FC 2198E002 */   addu      $s3, $s7, $zero
    /* EF000 800FE800 1480023C */  lui        $v0, %hi(sndgs)
    /* EF004 800FE804 60785624 */  addiu      $s6, $v0, %lo(sndgs)
    /* EF008 800FE808 1480023C */  lui        $v0, %hi(sndchanreserved)
    /* EF00C 800FE80C 14795E24 */  addiu      $fp, $v0, %lo(sndchanreserved)
    /* EF010 800FE810 FFFF1424 */  addiu      $s4, $zero, -0x1
  .L800FE814:
    /* EF014 800FE814 21A88002 */  addu       $s5, $s4, $zero
    /* EF018 800FE818 1100C292 */  lbu        $v0, 0x11($s6)
    /* EF01C 800FE81C 00000000 */  nop
    /* EF020 800FE820 21004010 */  beqz       $v0, .L800FE8A8
    /* EF024 800FE824 21880000 */   addu      $s1, $zero, $zero
    /* EF028 800FE828 21902002 */  addu       $s2, $s1, $zero
  .L800FE82C:
    /* EF02C 800FE82C 01000224 */  addiu      $v0, $zero, 0x1
    /* EF030 800FE830 4800A98F */  lw         $t1, 0x48($sp)
    /* EF034 800FE834 04102202 */  sllv       $v0, $v0, $s1
    /* EF038 800FE838 24102201 */  and        $v0, $t1, $v0
    /* EF03C 800FE83C 15004010 */  beqz       $v0, .L800FE894
    /* EF040 800FE840 00000000 */   nop
    /* EF044 800FE844 9400C28E */  lw         $v0, 0x94($s6)
    /* EF048 800FE848 00000000 */  nop
    /* EF04C 800FE84C 21805200 */  addu       $s0, $v0, $s2
    /* EF050 800FE850 0B000282 */  lb         $v0, 0xB($s0)
    /* EF054 800FE854 00000000 */  nop
    /* EF058 800FE858 0E004014 */  bnez       $v0, .L800FE894
    /* EF05C 800FE85C 21202002 */   addu      $a0, $s1, $zero
    /* EF060 800FE860 2128E002 */  addu       $a1, $s7, $zero
    /* EF064 800FE864 C9F9030C */  jal        iSNDischanreserved
    /* EF068 800FE868 1800A8AF */   sw        $t0, 0x18($sp)
    /* EF06C 800FE86C 1800A88F */  lw         $t0, 0x18($sp)
    /* EF070 800FE870 08004014 */  bnez       $v0, .L800FE894
    /* EF074 800FE874 00000000 */   nop
    /* EF078 800FE878 1000038E */  lw         $v1, 0x10($s0)
    /* EF07C 800FE87C 00000000 */  nop
    /* EF080 800FE880 2B107500 */  sltu       $v0, $v1, $s5
    /* EF084 800FE884 03004010 */  beqz       $v0, .L800FE894
    /* EF088 800FE888 00000000 */   nop
    /* EF08C 800FE88C 21A86000 */  addu       $s5, $v1, $zero
    /* EF090 800FE890 21A02002 */  addu       $s4, $s1, $zero
  .L800FE894:
    /* EF094 800FE894 1100C292 */  lbu        $v0, 0x11($s6)
    /* EF098 800FE898 01003126 */  addiu      $s1, $s1, 0x1
    /* EF09C 800FE89C 2A102202 */  slt        $v0, $s1, $v0
    /* EF0A0 800FE8A0 E2FF4014 */  bnez       $v0, .L800FE82C
    /* EF0A4 800FE8A4 64005226 */   addiu     $s2, $s2, 0x64
  .L800FE8A8:
    /* EF0A8 800FE8A8 03008006 */  bltz       $s4, .L800FE8B8
    /* EF0AC 800FE8AC 2110FE02 */   addu      $v0, $s7, $fp
    /* EF0B0 800FE8B0 000054A0 */  sb         $s4, 0x0($v0)
    /* EF0B4 800FE8B4 0100F726 */  addiu      $s7, $s7, 0x1
  .L800FE8B8:
    /* EF0B8 800FE8B8 01007326 */  addiu      $s3, $s3, 0x1
    /* EF0BC 800FE8BC 2A106802 */  slt        $v0, $s3, $t0
    /* EF0C0 800FE8C0 D4FF4014 */  bnez       $v0, .L800FE814
    /* EF0C4 800FE8C4 FFFF1424 */   addiu     $s4, $zero, -0x1
    /* EF0C8 800FE8C8 2A10E802 */  slt        $v0, $s7, $t0
    /* EF0CC 800FE8CC 42004010 */  beqz       $v0, .L800FE9D8
    /* EF0D0 800FE8D0 2198E002 */   addu      $s3, $s7, $zero
    /* EF0D4 800FE8D4 1480023C */  lui        $v0, %hi(sndgs)
    /* EF0D8 800FE8D8 60785E24 */  addiu      $fp, $v0, %lo(sndgs)
  .L800FE8DC:
    /* EF0DC 800FE8DC 66001624 */  addiu      $s6, $zero, 0x66
    /* EF0E0 800FE8E0 FFFF1424 */  addiu      $s4, $zero, -0x1
    /* EF0E4 800FE8E4 21A88002 */  addu       $s5, $s4, $zero
    /* EF0E8 800FE8E8 1100C293 */  lbu        $v0, 0x11($fp)
    /* EF0EC 800FE8EC 00000000 */  nop
    /* EF0F0 800FE8F0 2C004010 */  beqz       $v0, .L800FE9A4
    /* EF0F4 800FE8F4 21880000 */   addu      $s1, $zero, $zero
    /* EF0F8 800FE8F8 21902002 */  addu       $s2, $s1, $zero
  .L800FE8FC:
    /* EF0FC 800FE8FC 01000224 */  addiu      $v0, $zero, 0x1
    /* EF100 800FE900 4800A98F */  lw         $t1, 0x48($sp)
    /* EF104 800FE904 04102202 */  sllv       $v0, $v0, $s1
    /* EF108 800FE908 24102201 */  and        $v0, $t1, $v0
    /* EF10C 800FE90C 20004010 */  beqz       $v0, .L800FE990
    /* EF110 800FE910 21202002 */   addu      $a0, $s1, $zero
    /* EF114 800FE914 2128E002 */  addu       $a1, $s7, $zero
    /* EF118 800FE918 C9F9030C */  jal        iSNDischanreserved
    /* EF11C 800FE91C 1800A8AF */   sw        $t0, 0x18($sp)
    /* EF120 800FE920 1800A88F */  lw         $t0, 0x18($sp)
    /* EF124 800FE924 1A004014 */  bnez       $v0, .L800FE990
    /* EF128 800FE928 00000000 */   nop
    /* EF12C 800FE92C 9400C28F */  lw         $v0, 0x94($fp)
    /* EF130 800FE930 00000000 */  nop
    /* EF134 800FE934 21805200 */  addu       $s0, $v0, $s2
    /* EF138 800FE938 0C000292 */  lbu        $v0, 0xC($s0)
    /* EF13C 800FE93C 00000000 */  nop
    /* EF140 800FE940 6500422C */  sltiu      $v0, $v0, 0x65
    /* EF144 800FE944 12004010 */  beqz       $v0, .L800FE990
    /* EF148 800FE948 00000000 */   nop
    /* EF14C 800FE94C 0C000392 */  lbu        $v1, 0xC($s0)
    /* EF150 800FE950 00000000 */  nop
    /* EF154 800FE954 2A107600 */  slt        $v0, $v1, $s6
    /* EF158 800FE958 04004010 */  beqz       $v0, .L800FE96C
    /* EF15C 800FE95C 00000000 */   nop
    /* EF160 800FE960 1000158E */  lw         $s5, 0x10($s0)
    /* EF164 800FE964 63FA0308 */  j          .L800FE98C
    /* EF168 800FE968 21B06000 */   addu      $s6, $v1, $zero
  .L800FE96C:
    /* EF16C 800FE96C 08007614 */  bne        $v1, $s6, .L800FE990
    /* EF170 800FE970 00000000 */   nop
    /* EF174 800FE974 1000038E */  lw         $v1, 0x10($s0)
    /* EF178 800FE978 00000000 */  nop
    /* EF17C 800FE97C 2B107500 */  sltu       $v0, $v1, $s5
    /* EF180 800FE980 03004010 */  beqz       $v0, .L800FE990
    /* EF184 800FE984 00000000 */   nop
    /* EF188 800FE988 21A86000 */  addu       $s5, $v1, $zero
  .L800FE98C:
    /* EF18C 800FE98C 21A02002 */  addu       $s4, $s1, $zero
  .L800FE990:
    /* EF190 800FE990 1100C293 */  lbu        $v0, 0x11($fp)
    /* EF194 800FE994 01003126 */  addiu      $s1, $s1, 0x1
    /* EF198 800FE998 2A102202 */  slt        $v0, $s1, $v0
    /* EF19C 800FE99C D7FF4014 */  bnez       $v0, .L800FE8FC
    /* EF1A0 800FE9A0 64005226 */   addiu     $s2, $s2, 0x64
  .L800FE9A4:
    /* EF1A4 800FE9A4 08008006 */  bltz       $s4, .L800FE9C8
    /* EF1A8 800FE9A8 1480093C */   lui       $t1, %hi(sndchanreserved)
    /* EF1AC 800FE9AC 14792925 */  addiu      $t1, $t1, %lo(sndchanreserved)
    /* EF1B0 800FE9B0 2110E902 */  addu       $v0, $s7, $t1
    /* EF1B4 800FE9B4 000054A0 */  sb         $s4, 0x0($v0)
    /* EF1B8 800FE9B8 0100F726 */  addiu      $s7, $s7, 0x1
    /* EF1BC 800FE9BC 2A10E802 */  slt        $v0, $s7, $t0
    /* EF1C0 800FE9C0 05004010 */  beqz       $v0, .L800FE9D8
    /* EF1C4 800FE9C4 00000000 */   nop
  .L800FE9C8:
    /* EF1C8 800FE9C8 01007326 */  addiu      $s3, $s3, 0x1
    /* EF1CC 800FE9CC 2A106802 */  slt        $v0, $s3, $t0
    /* EF1D0 800FE9D0 C2FF4014 */  bnez       $v0, .L800FE8DC
    /* EF1D4 800FE9D4 00000000 */   nop
  .L800FE9D8:
    /* EF1D8 800FE9D8 7F00E816 */  bne        $s7, $t0, .L800FEBD8
    /* EF1DC 800FE9DC 1380023C */   lui       $v0, %hi(D_80136DEC)
    /* EF1E0 800FE9E0 1480043C */  lui        $a0, %hi(sndchanreserved)
    /* EF1E4 800FE9E4 14798380 */  lb         $v1, %lo(sndchanreserved)($a0)
    /* EF1E8 800FE9E8 EC6D428C */  lw         $v0, %lo(D_80136DEC)($v0)
    /* EF1EC 800FE9EC 5400A98F */  lw         $t1, 0x54($sp)
    /* EF1F0 800FE9F0 25104300 */  or         $v0, $v0, $v1
    /* EF1F4 800FE9F4 000022AD */  sw         $v0, 0x0($t1)
    /* EF1F8 800FE9F8 14798980 */  lb         $t1, %lo(sndchanreserved)($a0)
    /* EF1FC 800FE9FC 21980000 */  addu       $s3, $zero, $zero
    /* EF200 800FEA00 3E00E01A */  blez       $s7, .L800FEAFC
    /* EF204 800FEA04 1000A9AF */   sw        $t1, 0x10($sp)
    /* EF208 800FEA08 1480023C */  lui        $v0, %hi(sndgs)
    /* EF20C 800FEA0C 60785524 */  addiu      $s5, $v0, %lo(sndgs)
    /* EF210 800FEA10 14799224 */  addiu      $s2, $a0, %lo(sndchanreserved)
  .L800FEA14:
    /* EF214 800FEA14 00004282 */  lb         $v0, 0x0($s2)
    /* EF218 800FEA18 9400A48E */  lw         $a0, 0x94($s5)
    /* EF21C 800FEA1C 40180200 */  sll        $v1, $v0, 1
    /* EF220 800FEA20 21186200 */  addu       $v1, $v1, $v0
    /* EF224 800FEA24 C0180300 */  sll        $v1, $v1, 3
    /* EF228 800FEA28 21186200 */  addu       $v1, $v1, $v0
    /* EF22C 800FEA2C 80180300 */  sll        $v1, $v1, 2
    /* EF230 800FEA30 21808300 */  addu       $s0, $a0, $v1
    /* EF234 800FEA34 01000224 */  addiu      $v0, $zero, 0x1
    /* EF238 800FEA38 0B001482 */  lb         $s4, 0xB($s0)
    /* EF23C 800FEA3C 0000118E */  lw         $s1, 0x0($s0)
    /* EF240 800FEA40 24008216 */  bne        $s4, $v0, .L800FEAD4
    /* EF244 800FEA44 00000000 */   nop
    /* EF248 800FEA48 0A002106 */  bgez       $s1, .L800FEA74
    /* EF24C 800FEA4C 00000000 */   nop
    /* EF250 800FEA50 3C000382 */  lb         $v1, 0x3C($s0)
    /* EF254 800FEA54 00000000 */  nop
    /* EF258 800FEA58 04104300 */  sllv       $v0, $v1, $v0
    /* EF25C 800FEA5C 21104300 */  addu       $v0, $v0, $v1
    /* EF260 800FEA60 C0100200 */  sll        $v0, $v0, 3
    /* EF264 800FEA64 21104300 */  addu       $v0, $v0, $v1
    /* EF268 800FEA68 80100200 */  sll        $v0, $v0, 2
    /* EF26C 800FEA6C 21104400 */  addu       $v0, $v0, $a0
    /* EF270 800FEA70 0000518C */  lw         $s1, 0x0($v0)
  .L800FEA74:
    /* EF274 800FEA74 A09F030C */  jal        SNDstop
    /* EF278 800FEA78 21202002 */   addu      $a0, $s1, $zero
    /* EF27C 800FEA7C C59E030C */  jal        SNDover
    /* EF280 800FEA80 21202002 */   addu      $a0, $s1, $zero
    /* EF284 800FEA84 13005410 */  beq        $v0, $s4, .L800FEAD4
    /* EF288 800FEA88 00000000 */   nop
    /* EF28C 800FEA8C FFFF7326 */  addiu      $s3, $s3, -0x1
    /* EF290 800FEA90 0D006006 */  bltz       $s3, .L800FEAC8
    /* EF294 800FEA94 FFFF5226 */   addiu     $s2, $s2, -0x1
  .L800FEA98:
    /* EF298 800FEA98 00004282 */  lb         $v0, 0x0($s2)
    /* EF29C 800FEA9C FFFF5226 */  addiu      $s2, $s2, -0x1
    /* EF2A0 800FEAA0 FFFF7326 */  addiu      $s3, $s3, -0x1
    /* EF2A4 800FEAA4 40180200 */  sll        $v1, $v0, 1
    /* EF2A8 800FEAA8 21186200 */  addu       $v1, $v1, $v0
    /* EF2AC 800FEAAC C0180300 */  sll        $v1, $v1, 3
    /* EF2B0 800FEAB0 21186200 */  addu       $v1, $v1, $v0
    /* EF2B4 800FEAB4 9400A28E */  lw         $v0, 0x94($s5)
    /* EF2B8 800FEAB8 80180300 */  sll        $v1, $v1, 2
    /* EF2BC 800FEABC 21804300 */  addu       $s0, $v0, $v1
    /* EF2C0 800FEAC0 F5FF6106 */  bgez       $s3, .L800FEA98
    /* EF2C4 800FEAC4 0B0000A2 */   sb        $zero, 0xB($s0)
  .L800FEAC8:
    /* EF2C8 800FEAC8 F7FF0924 */  addiu      $t1, $zero, -0x9
    /* EF2CC 800FEACC F6FA0308 */  j          .L800FEBD8
    /* EF2D0 800FEAD0 1000A9AF */   sw        $t1, 0x10($sp)
  .L800FEAD4:
    /* EF2D4 800FEAD4 01005226 */  addiu      $s2, $s2, 0x1
    /* EF2D8 800FEAD8 01000224 */  addiu      $v0, $zero, 0x1
    /* EF2DC 800FEADC 01007326 */  addiu      $s3, $s3, 0x1
    /* EF2E0 800FEAE0 0B0002A2 */  sb         $v0, 0xB($s0)
    /* EF2E4 800FEAE4 4400A28E */  lw         $v0, 0x44($s5)
    /* EF2E8 800FEAE8 5000A993 */  lbu        $t1, 0x50($sp)
    /* EF2EC 800FEAEC 100002AE */  sw         $v0, 0x10($s0)
    /* EF2F0 800FEAF0 2A107702 */  slt        $v0, $s3, $s7
    /* EF2F4 800FEAF4 C7FF4014 */  bnez       $v0, .L800FEA14
    /* EF2F8 800FEAF8 0C0009A2 */   sb        $t1, 0xC($s0)
  .L800FEAFC:
    /* EF2FC 800FEAFC 01001324 */  addiu      $s3, $zero, 0x1
    /* EF300 800FEB00 1480023C */  lui        $v0, %hi(sndgs)
    /* EF304 800FEB04 1480063C */  lui        $a2, %hi(sndchanreserved)
    /* EF308 800FEB08 60784524 */  addiu      $a1, $v0, %lo(sndgs)
    /* EF30C 800FEB0C 1479C380 */  lb         $v1, %lo(sndchanreserved)($a2)
    /* EF310 800FEB10 5400A98F */  lw         $t1, 0x54($sp)
    /* EF314 800FEB14 04106302 */  sllv       $v0, $v1, $s3
    /* EF318 800FEB18 21104300 */  addu       $v0, $v0, $v1
    /* EF31C 800FEB1C C0100200 */  sll        $v0, $v0, 3
    /* EF320 800FEB20 21104300 */  addu       $v0, $v0, $v1
    /* EF324 800FEB24 80100200 */  sll        $v0, $v0, 2
    /* EF328 800FEB28 9400A38C */  lw         $v1, 0x94($a1)
    /* EF32C 800FEB2C 0000248D */  lw         $a0, 0x0($t1)
    /* EF330 800FEB30 21104300 */  addu       $v0, $v0, $v1
    /* EF334 800FEB34 000044AC */  sw         $a0, 0x0($v0)
    /* EF338 800FEB38 2A107702 */  slt        $v0, $s3, $s7
    /* EF33C 800FEB3C 26004010 */  beqz       $v0, .L800FEBD8
    /* EF340 800FEB40 00000000 */   nop
    /* EF344 800FEB44 1479C824 */  addiu      $t0, $a2, %lo(sndchanreserved)
    /* EF348 800FEB48 FFFF0724 */  addiu      $a3, $zero, -0x1
  .L800FEB4C:
    /* EF34C 800FEB4C 1479C380 */  lb         $v1, %lo(sndchanreserved)($a2)
    /* EF350 800FEB50 21206802 */  addu       $a0, $s3, $t0
    /* EF354 800FEB54 40100300 */  sll        $v0, $v1, 1
    /* EF358 800FEB58 21104300 */  addu       $v0, $v0, $v1
    /* EF35C 800FEB5C C0100200 */  sll        $v0, $v0, 3
    /* EF360 800FEB60 21104300 */  addu       $v0, $v0, $v1
    /* EF364 800FEB64 9400A38C */  lw         $v1, 0x94($a1)
    /* EF368 800FEB68 80100200 */  sll        $v0, $v0, 2
    /* EF36C 800FEB6C 21104300 */  addu       $v0, $v0, $v1
    /* EF370 800FEB70 00008390 */  lbu        $v1, 0x0($a0)
    /* EF374 800FEB74 21106202 */  addu       $v0, $s3, $v0
    /* EF378 800FEB78 030043A0 */  sb         $v1, 0x3($v0)
    /* EF37C 800FEB7C 00008380 */  lb         $v1, 0x0($a0)
    /* EF380 800FEB80 01007326 */  addiu      $s3, $s3, 0x1
    /* EF384 800FEB84 40100300 */  sll        $v0, $v1, 1
    /* EF388 800FEB88 21104300 */  addu       $v0, $v0, $v1
    /* EF38C 800FEB8C C0100200 */  sll        $v0, $v0, 3
    /* EF390 800FEB90 21104300 */  addu       $v0, $v0, $v1
    /* EF394 800FEB94 9400A38C */  lw         $v1, 0x94($a1)
    /* EF398 800FEB98 80100200 */  sll        $v0, $v0, 2
    /* EF39C 800FEB9C 21104300 */  addu       $v0, $v0, $v1
    /* EF3A0 800FEBA0 000047AC */  sw         $a3, 0x0($v0)
    /* EF3A4 800FEBA4 00008380 */  lb         $v1, 0x0($a0)
    /* EF3A8 800FEBA8 1479C490 */  lbu        $a0, %lo(sndchanreserved)($a2)
    /* EF3AC 800FEBAC 40100300 */  sll        $v0, $v1, 1
    /* EF3B0 800FEBB0 21104300 */  addu       $v0, $v0, $v1
    /* EF3B4 800FEBB4 C0100200 */  sll        $v0, $v0, 3
    /* EF3B8 800FEBB8 21104300 */  addu       $v0, $v0, $v1
    /* EF3BC 800FEBBC 9400A38C */  lw         $v1, 0x94($a1)
    /* EF3C0 800FEBC0 80100200 */  sll        $v0, $v0, 2
    /* EF3C4 800FEBC4 21104300 */  addu       $v0, $v0, $v1
    /* EF3C8 800FEBC8 3C0044A0 */  sb         $a0, 0x3C($v0)
    /* EF3CC 800FEBCC 2A107702 */  slt        $v0, $s3, $s7
    /* EF3D0 800FEBD0 DEFF4014 */  bnez       $v0, .L800FEB4C
    /* EF3D4 800FEBD4 00000000 */   nop
  .L800FEBD8:
    /* EF3D8 800FEBD8 1000A28F */  lw         $v0, 0x10($sp)
    /* EF3DC 800FEBDC 4400BF8F */  lw         $ra, 0x44($sp)
    /* EF3E0 800FEBE0 4000BE8F */  lw         $fp, 0x40($sp)
    /* EF3E4 800FEBE4 3C00B78F */  lw         $s7, 0x3C($sp)
    /* EF3E8 800FEBE8 3800B68F */  lw         $s6, 0x38($sp)
    /* EF3EC 800FEBEC 3400B58F */  lw         $s5, 0x34($sp)
    /* EF3F0 800FEBF0 3000B48F */  lw         $s4, 0x30($sp)
    /* EF3F4 800FEBF4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* EF3F8 800FEBF8 2800B28F */  lw         $s2, 0x28($sp)
    /* EF3FC 800FEBFC 2400B18F */  lw         $s1, 0x24($sp)
    /* EF400 800FEC00 2000B08F */  lw         $s0, 0x20($sp)
    /* EF404 800FEC04 0800E003 */  jr         $ra
    /* EF408 800FEC08 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel iSNDallocchan
