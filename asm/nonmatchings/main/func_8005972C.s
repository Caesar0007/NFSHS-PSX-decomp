.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005972C, 0x1FC

glabel func_8005972C
    /* 49F2C 8005972C 00008293 */  lbu        $v0, %gp_rel(__sdata_org)($gp)
    /* 49F30 80059730 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 49F34 80059734 4C00B1AF */  sw         $s1, 0x4C($sp)
    /* 49F38 80059738 21888000 */  addu       $s1, $a0, $zero
    /* 49F3C 8005973C 5800B4AF */  sw         $s4, 0x58($sp)
    /* 49F40 80059740 21A0A000 */  addu       $s4, $a1, $zero
    /* 49F44 80059744 4800B0AF */  sw         $s0, 0x48($sp)
    /* 49F48 80059748 04009026 */  addiu      $s0, $s4, 0x4
    /* 49F4C 8005974C 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 49F50 80059750 5400B3AF */  sw         $s3, 0x54($sp)
    /* 49F54 80059754 06004010 */  beqz       $v0, .L80059770
    /* 49F58 80059758 5000B2AF */   sw        $s2, 0x50($sp)
    /* 49F5C 8005975C 000080A3 */  sb         $zero, %gp_rel(__sdata_org)($gp)
    /* 49F60 80059760 21200000 */  addu       $a0, $zero, $zero
    /* 49F64 80059764 1480053C */  lui        $a1, %hi(__bss_org)
    /* 49F68 80059768 59FB010C */  jal        BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* 49F6C 8005976C E0DEA524 */   addiu     $a1, $a1, %lo(__bss_org)
  .L80059770:
    /* 49F70 80059770 21900000 */  addu       $s2, $zero, $zero
    /* 49F74 80059774 1480133C */  lui        $s3, %hi(__bss_org)
  .L80059778:
    /* 49F78 80059778 0000828E */  lw         $v0, 0x0($s4)
    /* 49F7C 8005977C 00000000 */  nop
    /* 49F80 80059780 2A104202 */  slt        $v0, $s2, $v0
    /* 49F84 80059784 60004010 */  beqz       $v0, .L80059908
    /* 49F88 80059788 1800A427 */   addiu     $a0, $sp, 0x18
    /* 49F8C 8005978C 0000028E */  lw         $v0, 0x0($s0)
    /* 49F90 80059790 00000000 */  nop
    /* 49F94 80059794 1800A2AF */  sw         $v0, 0x18($sp)
    /* 49F98 80059798 0400028E */  lw         $v0, 0x4($s0)
    /* 49F9C 8005979C 00000000 */  nop
    /* 49FA0 800597A0 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 49FA4 800597A4 0800028E */  lw         $v0, 0x8($s0)
    /* 49FA8 800597A8 E0DE6526 */  addiu      $a1, $s3, %lo(__bss_org)
    /* 49FAC 800597AC 85FA010C */  jal        BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 49FB0 800597B0 2000A2AF */   sw        $v0, 0x20($sp)
    /* 49FB4 800597B4 E0DE6486 */  lh         $a0, %lo(__bss_org)($s3)
    /* 49FB8 800597B8 65CC010C */  jal        AIWorld_ApxSplineDistance__FiP8Car_tObj
    /* 49FBC 800597BC 21282002 */   addu      $a1, $s1, $zero
    /* 49FC0 800597C0 5405238E */  lw         $v1, 0x554($s1)
    /* 49FC4 800597C4 00000000 */  nop
    /* 49FC8 800597C8 18004300 */  mult       $v0, $v1
    /* 49FCC 800597CC 6300033C */  lui        $v1, (0x63FFFE >> 16)
    /* 49FD0 800597D0 FEFF6334 */  ori        $v1, $v1, (0x63FFFE & 0xFFFF)
    /* 49FD4 800597D4 12480000 */  mflo       $t1
    /* 49FD8 800597D8 FFFF2225 */  addiu      $v0, $t1, -0x1
    /* 49FDC 800597DC 2B186200 */  sltu       $v1, $v1, $v0
    /* 49FE0 800597E0 46006014 */  bnez       $v1, .L800598FC
    /* 49FE4 800597E4 00000000 */   nop
    /* 49FE8 800597E8 08002286 */  lh         $v0, 0x8($s1)
    /* 49FEC 800597EC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 49FF0 800597F0 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 49FF4 800597F4 40110200 */  sll        $v0, $v0, 5
    /* 49FF8 800597F8 21104300 */  addu       $v0, $v0, $v1
    /* 49FFC 800597FC 00004A8C */  lw         $t2, 0x0($v0)
    /* 4A000 80059800 04004B8C */  lw         $t3, 0x4($v0)
    /* 4A004 80059804 08004C8C */  lw         $t4, 0x8($v0)
    /* 4A008 80059808 2800AAAF */  sw         $t2, 0x28($sp)
    /* 4A00C 8005980C 2C00ABAF */  sw         $t3, 0x2C($sp)
    /* 4A010 80059810 3000ACAF */  sw         $t4, 0x30($sp)
    /* 4A014 80059814 1800A38F */  lw         $v1, 0x18($sp)
    /* 4A018 80059818 2800A28F */  lw         $v0, 0x28($sp)
    /* 4A01C 8005981C 1C00A48F */  lw         $a0, 0x1C($sp)
    /* 4A020 80059820 2000A58F */  lw         $a1, 0x20($sp)
    /* 4A024 80059824 23386200 */  subu       $a3, $v1, $v0
    /* 4A028 80059828 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 4A02C 8005982C 3000A38F */  lw         $v1, 0x30($sp)
    /* 4A030 80059830 3800A7AF */  sw         $a3, 0x38($sp)
    /* 4A034 80059834 23208200 */  subu       $a0, $a0, $v0
    /* 4A038 80059838 2328A300 */  subu       $a1, $a1, $v1
    /* 4A03C 8005983C 3C00A4AF */  sw         $a0, 0x3C($sp)
    /* 4A040 80059840 4000A5AF */  sw         $a1, 0x40($sp)
    /* 4A044 80059844 4401268E */  lw         $a2, 0x144($s1)
    /* 4A048 80059848 00000000 */  nop
    /* 4A04C 8005984C 0200C104 */  bgez       $a2, .L80059858
    /* 4A050 80059850 2110E000 */   addu      $v0, $a3, $zero
    /* 4A054 80059854 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L80059858:
    /* 4A058 80059858 02004104 */  bgez       $v0, .L80059864
    /* 4A05C 8005985C 03320600 */   sra       $a2, $a2, 8
    /* 4A060 80059860 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80059864:
    /* 4A064 80059864 03120200 */  sra        $v0, $v0, 8
    /* 4A068 80059868 1800C200 */  mult       $a2, $v0
    /* 4A06C 8005986C 4801238E */  lw         $v1, 0x148($s1)
    /* 4A070 80059870 12300000 */  mflo       $a2
    /* 4A074 80059874 02006104 */  bgez       $v1, .L80059880
    /* 4A078 80059878 21108000 */   addu      $v0, $a0, $zero
    /* 4A07C 8005987C FF006324 */  addiu      $v1, $v1, 0xFF
  .L80059880:
    /* 4A080 80059880 02004104 */  bgez       $v0, .L8005988C
    /* 4A084 80059884 031A0300 */   sra       $v1, $v1, 8
    /* 4A088 80059888 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8005988C:
    /* 4A08C 8005988C 03120200 */  sra        $v0, $v0, 8
    /* 4A090 80059890 18006200 */  mult       $v1, $v0
    /* 4A094 80059894 4C01238E */  lw         $v1, 0x14C($s1)
    /* 4A098 80059898 12480000 */  mflo       $t1
    /* 4A09C 8005989C 02006104 */  bgez       $v1, .L800598A8
    /* 4A0A0 800598A0 2130C900 */   addu      $a2, $a2, $t1
    /* 4A0A4 800598A4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800598A8:
    /* 4A0A8 800598A8 2110A000 */  addu       $v0, $a1, $zero
    /* 4A0AC 800598AC 02004104 */  bgez       $v0, .L800598B8
    /* 4A0B0 800598B0 031A0300 */   sra       $v1, $v1, 8
    /* 4A0B4 800598B4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800598B8:
    /* 4A0B8 800598B8 03120200 */  sra        $v0, $v0, 8
    /* 4A0BC 800598BC 18006200 */  mult       $v1, $v0
    /* 4A0C0 800598C0 F3FF053C */  lui        $a1, (0xFFF30000 >> 16)
    /* 4A0C4 800598C4 13000392 */  lbu        $v1, 0x13($s0)
    /* 4A0C8 800598C8 01000224 */  addiu      $v0, $zero, 0x1
    /* 4A0CC 800598CC 12480000 */  mflo       $t1
    /* 4A0D0 800598D0 02006214 */  bne        $v1, $v0, .L800598DC
    /* 4A0D4 800598D4 2140C900 */   addu      $t0, $a2, $t1
    /* 4A0D8 800598D8 D8FF053C */  lui        $a1, (0xFFD80000 >> 16)
  .L800598DC:
    /* 4A0DC 800598DC 21202002 */  addu       $a0, $s1, $zero
    /* 4A0E0 800598E0 0C000786 */  lh         $a3, 0xC($s0)
    /* 4A0E4 800598E4 E0DE6286 */  lh         $v0, %lo(__bss_org)($s3)
    /* 4A0E8 800598E8 403A0700 */  sll        $a3, $a3, 9
    /* 4A0EC 800598EC 23300701 */  subu       $a2, $t0, $a3
    /* 4A0F0 800598F0 21380701 */  addu       $a3, $t0, $a3
    /* 4A0F4 800598F4 7966010C */  jal        AI_SubmitObstacle__FP8Car_tObjiiii
    /* 4A0F8 800598F8 1000A2AF */   sw        $v0, 0x10($sp)
  .L800598FC:
    /* 4A0FC 800598FC 14001026 */  addiu      $s0, $s0, 0x14
    /* 4A100 80059900 DE650108 */  j          .L80059778
    /* 4A104 80059904 01005226 */   addiu     $s2, $s2, 0x1
  .L80059908:
    /* 4A108 80059908 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 4A10C 8005990C 5800B48F */  lw         $s4, 0x58($sp)
    /* 4A110 80059910 5400B38F */  lw         $s3, 0x54($sp)
    /* 4A114 80059914 5000B28F */  lw         $s2, 0x50($sp)
    /* 4A118 80059918 4C00B18F */  lw         $s1, 0x4C($sp)
    /* 4A11C 8005991C 4800B08F */  lw         $s0, 0x48($sp)
    /* 4A120 80059920 0800E003 */  jr         $ra
    /* 4A124 80059924 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel func_8005972C
