.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei, 0x528

glabel R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei
    /* 9EF50 800AE750 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 9EF54 800AE754 3000B0AF */  sw         $s0, 0x30($sp)
    /* 9EF58 800AE758 21808000 */  addu       $s0, $a0, $zero
    /* 9EF5C 800AE75C 21C00000 */  addu       $t8, $zero, $zero
    /* 9EF60 800AE760 1180023C */  lui        $v0, %hi(R3DCar_ObjectInfo)
    /* 9EF64 800AE764 E0655924 */  addiu      $t9, $v0, %lo(R3DCar_ObjectInfo)
    /* 9EF68 800AE768 6300023C */  lui        $v0, (0x630000 >> 16)
    /* 9EF6C 800AE76C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 9EF70 800AE770 1400A2AF */  sw         $v0, 0x14($sp)
    /* 9EF74 800AE774 1800A2AF */  sw         $v0, 0x18($sp)
    /* 9EF78 800AE778 9DFF023C */  lui        $v0, (0xFF9D0000 >> 16)
    /* 9EF7C 800AE77C 3800BFAF */  sw         $ra, 0x38($sp)
    /* 9EF80 800AE780 3400B1AF */  sw         $s1, 0x34($sp)
    /* 9EF84 800AE784 2000A2AF */  sw         $v0, 0x20($sp)
    /* 9EF88 800AE788 2400A2AF */  sw         $v0, 0x24($sp)
    /* 9EF8C 800AE78C 2800A2AF */  sw         $v0, 0x28($sp)
  .L800AE790:
    /* 9EF90 800AE790 3900022B */  slti       $v0, $t8, 0x39
    /* 9EF94 800AE794 F2004010 */  beqz       $v0, .L800AEB60
    /* 9EF98 800AE798 80101800 */   sll       $v0, $t8, 2
    /* 9EF9C 800AE79C 2110A200 */  addu       $v0, $a1, $v0
    /* 9EFA0 800AE7A0 01000424 */  addiu      $a0, $zero, 0x1
    /* 9EFA4 800AE7A4 03002383 */  lb         $v1, 0x3($t9)
    /* 9EFA8 800AE7A8 0000488C */  lw         $t0, 0x0($v0)
    /* 9EFAC 800AE7AC E9006414 */  bne        $v1, $a0, .L800AEB54
    /* 9EFB0 800AE7B0 00000000 */   nop
    /* 9EFB4 800AE7B4 00000295 */  lhu        $v0, 0x0($t0)
    /* 9EFB8 800AE7B8 00000000 */  nop
    /* 9EFBC 800AE7BC E5004010 */  beqz       $v0, .L800AEB54
    /* 9EFC0 800AE7C0 00000000 */   nop
    /* 9EFC4 800AE7C4 08000013 */  beqz       $t8, .L800AE7E8
    /* 9EFC8 800AE7C8 2F00022B */   slti      $v0, $t8, 0x2F
    /* 9EFCC 800AE7CC 06004010 */  beqz       $v0, .L800AE7E8
    /* 9EFD0 800AE7D0 02000224 */   addiu     $v0, $zero, 0x2
    /* 9EFD4 800AE7D4 6C000217 */  bne        $t8, $v0, .L800AE988
    /* 9EFD8 800AE7D8 2F00022B */   slti      $v0, $t8, 0x2F
    /* 9EFDC 800AE7DC 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 9EFE0 800AE7E0 6900C214 */  bne        $a2, $v0, .L800AE988
    /* 9EFE4 800AE7E4 2F00022B */   slti      $v0, $t8, 0x2F
  .L800AE7E8:
    /* 9EFE8 800AE7E8 00000295 */  lhu        $v0, 0x0($t0)
    /* 9EFEC 800AE7EC 00000000 */  nop
    /* 9EFF0 800AE7F0 64004010 */  beqz       $v0, .L800AE984
    /* 9EFF4 800AE7F4 21600000 */   addu      $t4, $zero, $zero
    /* 9EFF8 800AE7F8 21508001 */  addu       $t2, $t4, $zero
  .L800AE7FC:
    /* 9EFFC 800AE7FC 0400078D */  lw         $a3, 0x4($t0)
    /* 9F000 800AE800 1000028D */  lw         $v0, 0x10($t0)
    /* 9F004 800AE804 00000000 */  nop
    /* 9F008 800AE808 21104201 */  addu       $v0, $t2, $v0
    /* 9F00C 800AE80C 00004984 */  lh         $t1, 0x0($v0)
    /* 9F010 800AE810 0200E104 */  bgez       $a3, .L800AE81C
    /* 9F014 800AE814 2118E000 */   addu      $v1, $a3, $zero
    /* 9F018 800AE818 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L800AE81C:
    /* 9F01C 800AE81C 03120300 */  sra        $v0, $v1, 8
    /* 9F020 800AE820 1000A48F */  lw         $a0, 0x10($sp)
    /* 9F024 800AE824 21182201 */  addu       $v1, $t1, $v0
    /* 9F028 800AE828 2A106400 */  slt        $v0, $v1, $a0
    /* 9F02C 800AE82C 02004014 */  bnez       $v0, .L800AE838
    /* 9F030 800AE830 21106000 */   addu      $v0, $v1, $zero
    /* 9F034 800AE834 21108000 */  addu       $v0, $a0, $zero
  .L800AE838:
    /* 9F038 800AE838 1000A2AF */  sw         $v0, 0x10($sp)
    /* 9F03C 800AE83C 0800078D */  lw         $a3, 0x8($t0)
    /* 9F040 800AE840 1000028D */  lw         $v0, 0x10($t0)
    /* 9F044 800AE844 00000000 */  nop
    /* 9F048 800AE848 21104201 */  addu       $v0, $t2, $v0
    /* 9F04C 800AE84C 02004984 */  lh         $t1, 0x2($v0)
    /* 9F050 800AE850 0200E104 */  bgez       $a3, .L800AE85C
    /* 9F054 800AE854 2118E000 */   addu      $v1, $a3, $zero
    /* 9F058 800AE858 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L800AE85C:
    /* 9F05C 800AE85C 03120300 */  sra        $v0, $v1, 8
    /* 9F060 800AE860 1400A48F */  lw         $a0, 0x14($sp)
    /* 9F064 800AE864 21182201 */  addu       $v1, $t1, $v0
    /* 9F068 800AE868 2A106400 */  slt        $v0, $v1, $a0
    /* 9F06C 800AE86C 02004014 */  bnez       $v0, .L800AE878
    /* 9F070 800AE870 21106000 */   addu      $v0, $v1, $zero
    /* 9F074 800AE874 21108000 */  addu       $v0, $a0, $zero
  .L800AE878:
    /* 9F078 800AE878 1400A2AF */  sw         $v0, 0x14($sp)
    /* 9F07C 800AE87C 0C00078D */  lw         $a3, 0xC($t0)
    /* 9F080 800AE880 1000028D */  lw         $v0, 0x10($t0)
    /* 9F084 800AE884 00000000 */  nop
    /* 9F088 800AE888 21104201 */  addu       $v0, $t2, $v0
    /* 9F08C 800AE88C 04004984 */  lh         $t1, 0x4($v0)
    /* 9F090 800AE890 0200E104 */  bgez       $a3, .L800AE89C
    /* 9F094 800AE894 2118E000 */   addu      $v1, $a3, $zero
    /* 9F098 800AE898 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L800AE89C:
    /* 9F09C 800AE89C 03120300 */  sra        $v0, $v1, 8
    /* 9F0A0 800AE8A0 1800A48F */  lw         $a0, 0x18($sp)
    /* 9F0A4 800AE8A4 21182201 */  addu       $v1, $t1, $v0
    /* 9F0A8 800AE8A8 2A106400 */  slt        $v0, $v1, $a0
    /* 9F0AC 800AE8AC 02004014 */  bnez       $v0, .L800AE8B8
    /* 9F0B0 800AE8B0 21106000 */   addu      $v0, $v1, $zero
    /* 9F0B4 800AE8B4 21108000 */  addu       $v0, $a0, $zero
  .L800AE8B8:
    /* 9F0B8 800AE8B8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 9F0BC 800AE8BC 1000028D */  lw         $v0, 0x10($t0)
    /* 9F0C0 800AE8C0 0400038D */  lw         $v1, 0x4($t0)
    /* 9F0C4 800AE8C4 21104201 */  addu       $v0, $t2, $v0
    /* 9F0C8 800AE8C8 00004784 */  lh         $a3, 0x0($v0)
    /* 9F0CC 800AE8CC 03006104 */  bgez       $v1, .L800AE8DC
    /* 9F0D0 800AE8D0 03120300 */   sra       $v0, $v1, 8
    /* 9F0D4 800AE8D4 FF006324 */  addiu      $v1, $v1, 0xFF
    /* 9F0D8 800AE8D8 03120300 */  sra        $v0, $v1, 8
  .L800AE8DC:
    /* 9F0DC 800AE8DC 2000A48F */  lw         $a0, 0x20($sp)
    /* 9F0E0 800AE8E0 2118E200 */  addu       $v1, $a3, $v0
    /* 9F0E4 800AE8E4 2A106400 */  slt        $v0, $v1, $a0
    /* 9F0E8 800AE8E8 02004010 */  beqz       $v0, .L800AE8F4
    /* 9F0EC 800AE8EC 00000000 */   nop
    /* 9F0F0 800AE8F0 21188000 */  addu       $v1, $a0, $zero
  .L800AE8F4:
    /* 9F0F4 800AE8F4 2000A3AF */  sw         $v1, 0x20($sp)
    /* 9F0F8 800AE8F8 1000028D */  lw         $v0, 0x10($t0)
    /* 9F0FC 800AE8FC 0800038D */  lw         $v1, 0x8($t0)
    /* 9F100 800AE900 21104201 */  addu       $v0, $t2, $v0
    /* 9F104 800AE904 02004784 */  lh         $a3, 0x2($v0)
    /* 9F108 800AE908 03006104 */  bgez       $v1, .L800AE918
    /* 9F10C 800AE90C 03120300 */   sra       $v0, $v1, 8
    /* 9F110 800AE910 FF006324 */  addiu      $v1, $v1, 0xFF
    /* 9F114 800AE914 03120300 */  sra        $v0, $v1, 8
  .L800AE918:
    /* 9F118 800AE918 2400A48F */  lw         $a0, 0x24($sp)
    /* 9F11C 800AE91C 2118E200 */  addu       $v1, $a3, $v0
    /* 9F120 800AE920 2A106400 */  slt        $v0, $v1, $a0
    /* 9F124 800AE924 02004010 */  beqz       $v0, .L800AE930
    /* 9F128 800AE928 00000000 */   nop
    /* 9F12C 800AE92C 21188000 */  addu       $v1, $a0, $zero
  .L800AE930:
    /* 9F130 800AE930 2400A3AF */  sw         $v1, 0x24($sp)
    /* 9F134 800AE934 1000028D */  lw         $v0, 0x10($t0)
    /* 9F138 800AE938 0C00038D */  lw         $v1, 0xC($t0)
    /* 9F13C 800AE93C 21104201 */  addu       $v0, $t2, $v0
    /* 9F140 800AE940 04004784 */  lh         $a3, 0x4($v0)
    /* 9F144 800AE944 03006104 */  bgez       $v1, .L800AE954
    /* 9F148 800AE948 03120300 */   sra       $v0, $v1, 8
    /* 9F14C 800AE94C FF006324 */  addiu      $v1, $v1, 0xFF
    /* 9F150 800AE950 03120300 */  sra        $v0, $v1, 8
  .L800AE954:
    /* 9F154 800AE954 2800A48F */  lw         $a0, 0x28($sp)
    /* 9F158 800AE958 2118E200 */  addu       $v1, $a3, $v0
    /* 9F15C 800AE95C 2A106400 */  slt        $v0, $v1, $a0
    /* 9F160 800AE960 02004010 */  beqz       $v0, .L800AE96C
    /* 9F164 800AE964 00000000 */   nop
    /* 9F168 800AE968 21188000 */  addu       $v1, $a0, $zero
  .L800AE96C:
    /* 9F16C 800AE96C 2800A3AF */  sw         $v1, 0x28($sp)
    /* 9F170 800AE970 00000295 */  lhu        $v0, 0x0($t0)
    /* 9F174 800AE974 01008C25 */  addiu      $t4, $t4, 0x1
    /* 9F178 800AE978 2A108201 */  slt        $v0, $t4, $v0
    /* 9F17C 800AE97C 9FFF4014 */  bnez       $v0, .L800AE7FC
    /* 9F180 800AE980 06004A25 */   addiu     $t2, $t2, 0x6
  .L800AE984:
    /* 9F184 800AE984 2F00022B */  slti       $v0, $t8, 0x2F
  .L800AE988:
    /* 9F188 800AE988 72004014 */  bnez       $v0, .L800AEB54
    /* 9F18C 800AE98C 6300093C */   lui       $t1, (0x630000 >> 16)
    /* 9F190 800AE990 21682001 */  addu       $t5, $t1, $zero
    /* 9F194 800AE994 9DFF0A3C */  lui        $t2, %hi(D_FF9D0001)
    /* 9F198 800AE998 21704001 */  addu       $t6, $t2, $zero
    /* 9F19C 800AE99C 00000295 */  lhu        $v0, 0x0($t0)
    /* 9F1A0 800AE9A0 00000000 */  nop
    /* 9F1A4 800AE9A4 4A004010 */  beqz       $v0, .L800AEAD0
    /* 9F1A8 800AE9A8 21600000 */   addu      $t4, $zero, $zero
    /* 9F1AC 800AE9AC 21588001 */  addu       $t3, $t4, $zero
    /* 9F1B0 800AE9B0 10000F8D */  lw         $t7, 0x10($t0)
  .L800AE9B4:
    /* 9F1B4 800AE9B4 0400048D */  lw         $a0, 0x4($t0)
    /* 9F1B8 800AE9B8 0000E385 */  lh         $v1, 0x0($t7)
    /* 9F1BC 800AE9BC 02008104 */  bgez       $a0, .L800AE9C8
    /* 9F1C0 800AE9C0 21108000 */   addu      $v0, $a0, $zero
    /* 9F1C4 800AE9C4 FF008224 */  addiu      $v0, $a0, 0xFF
  .L800AE9C8:
    /* 9F1C8 800AE9C8 03120200 */  sra        $v0, $v0, 8
    /* 9F1CC 800AE9CC 21106200 */  addu       $v0, $v1, $v0
    /* 9F1D0 800AE9D0 02004104 */  bgez       $v0, .L800AE9DC
    /* 9F1D4 800AE9D4 21184000 */   addu      $v1, $v0, $zero
    /* 9F1D8 800AE9D8 23180300 */  negu       $v1, $v1
  .L800AE9DC:
    /* 9F1DC 800AE9DC 2A106900 */  slt        $v0, $v1, $t1
    /* 9F1E0 800AE9E0 02004014 */  bnez       $v0, .L800AE9EC
    /* 9F1E4 800AE9E4 21106000 */   addu      $v0, $v1, $zero
    /* 9F1E8 800AE9E8 21102001 */  addu       $v0, $t1, $zero
  .L800AE9EC:
    /* 9F1EC 800AE9EC 21484000 */  addu       $t1, $v0, $zero
    /* 9F1F0 800AE9F0 0C00048D */  lw         $a0, 0xC($t0)
    /* 9F1F4 800AE9F4 1000028D */  lw         $v0, 0x10($t0)
    /* 9F1F8 800AE9F8 00000000 */  nop
    /* 9F1FC 800AE9FC 21106201 */  addu       $v0, $t3, $v0
    /* 9F200 800AEA00 04004784 */  lh         $a3, 0x4($v0)
    /* 9F204 800AEA04 02008104 */  bgez       $a0, .L800AEA10
    /* 9F208 800AEA08 21188000 */   addu      $v1, $a0, $zero
    /* 9F20C 800AEA0C FF008324 */  addiu      $v1, $a0, 0xFF
  .L800AEA10:
    /* 9F210 800AEA10 03120300 */  sra        $v0, $v1, 8
    /* 9F214 800AEA14 2110E200 */  addu       $v0, $a3, $v0
    /* 9F218 800AEA18 02004104 */  bgez       $v0, .L800AEA24
    /* 9F21C 800AEA1C 21184000 */   addu      $v1, $v0, $zero
    /* 9F220 800AEA20 23180300 */  negu       $v1, $v1
  .L800AEA24:
    /* 9F224 800AEA24 2A106D00 */  slt        $v0, $v1, $t5
    /* 9F228 800AEA28 02004014 */  bnez       $v0, .L800AEA34
    /* 9F22C 800AEA2C 21106000 */   addu      $v0, $v1, $zero
    /* 9F230 800AEA30 2110A001 */  addu       $v0, $t5, $zero
  .L800AEA34:
    /* 9F234 800AEA34 21684000 */  addu       $t5, $v0, $zero
    /* 9F238 800AEA38 1000028D */  lw         $v0, 0x10($t0)
    /* 9F23C 800AEA3C 0400038D */  lw         $v1, 0x4($t0)
    /* 9F240 800AEA40 21386201 */  addu       $a3, $t3, $v0
    /* 9F244 800AEA44 0000E484 */  lh         $a0, 0x0($a3)
    /* 9F248 800AEA48 03006104 */  bgez       $v1, .L800AEA58
    /* 9F24C 800AEA4C 03120300 */   sra       $v0, $v1, 8
    /* 9F250 800AEA50 FF006324 */  addiu      $v1, $v1, 0xFF
    /* 9F254 800AEA54 03120300 */  sra        $v0, $v1, 8
  .L800AEA58:
    /* 9F258 800AEA58 21108200 */  addu       $v0, $a0, $v0
    /* 9F25C 800AEA5C 02004104 */  bgez       $v0, .L800AEA68
    /* 9F260 800AEA60 21184000 */   addu      $v1, $v0, $zero
    /* 9F264 800AEA64 23180300 */  negu       $v1, $v1
  .L800AEA68:
    /* 9F268 800AEA68 2A106A00 */  slt        $v0, $v1, $t2
    /* 9F26C 800AEA6C 02004010 */  beqz       $v0, .L800AEA78
    /* 9F270 800AEA70 00000000 */   nop
    /* 9F274 800AEA74 21184001 */  addu       $v1, $t2, $zero
  .L800AEA78:
    /* 9F278 800AEA78 21506000 */  addu       $t2, $v1, $zero
    /* 9F27C 800AEA7C 0C00028D */  lw         $v0, 0xC($t0)
    /* 9F280 800AEA80 0400E384 */  lh         $v1, 0x4($a3)
    /* 9F284 800AEA84 02004104 */  bgez       $v0, .L800AEA90
    /* 9F288 800AEA88 00000000 */   nop
    /* 9F28C 800AEA8C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AEA90:
    /* 9F290 800AEA90 03120200 */  sra        $v0, $v0, 8
    /* 9F294 800AEA94 21106200 */  addu       $v0, $v1, $v0
    /* 9F298 800AEA98 02004104 */  bgez       $v0, .L800AEAA4
    /* 9F29C 800AEA9C 21184000 */   addu      $v1, $v0, $zero
    /* 9F2A0 800AEAA0 23180300 */  negu       $v1, $v1
  .L800AEAA4:
    /* 9F2A4 800AEAA4 2A106E00 */  slt        $v0, $v1, $t6
    /* 9F2A8 800AEAA8 02004010 */  beqz       $v0, .L800AEAB4
    /* 9F2AC 800AEAAC 00000000 */   nop
    /* 9F2B0 800AEAB0 2118C001 */  addu       $v1, $t6, $zero
  .L800AEAB4:
    /* 9F2B4 800AEAB4 21706000 */  addu       $t6, $v1, $zero
    /* 9F2B8 800AEAB8 06006B25 */  addiu      $t3, $t3, 0x6
    /* 9F2BC 800AEABC 00000295 */  lhu        $v0, 0x0($t0)
    /* 9F2C0 800AEAC0 01008C25 */  addiu      $t4, $t4, 0x1
    /* 9F2C4 800AEAC4 2A108201 */  slt        $v0, $t4, $v0
    /* 9F2C8 800AEAC8 BAFF4014 */  bnez       $v0, .L800AE9B4
    /* 9F2CC 800AEACC 0600EF25 */   addiu     $t7, $t7, 0x6
  .L800AEAD0:
    /* 9F2D0 800AEAD0 3500022B */  slti       $v0, $t8, 0x35
    /* 9F2D4 800AEAD4 10004014 */  bnez       $v0, .L800AEB18
    /* 9F2D8 800AEAD8 2F00022B */   slti      $v0, $t8, 0x2F
    /* 9F2DC 800AEADC 21102A01 */  addu       $v0, $t1, $t2
    /* 9F2E0 800AEAE0 01004224 */  addiu      $v0, $v0, %lo(D_FF9D0001)
    /* 9F2E4 800AEAE4 43100200 */  sra        $v0, $v0, 1
    /* 9F2E8 800AEAE8 00120200 */  sll        $v0, $v0, 8
    /* 9F2EC 800AEAEC E00002AE */  sw         $v0, 0xE0($s0)
    /* 9F2F0 800AEAF0 2110AE01 */  addu       $v0, $t5, $t6
    /* 9F2F4 800AEAF4 01004224 */  addiu      $v0, $v0, %lo(D_FF9D0001)
    /* 9F2F8 800AEAF8 43100200 */  sra        $v0, $v0, 1
    /* 9F2FC 800AEAFC 00120200 */  sll        $v0, $v0, 8
    /* 9F300 800AEB00 E40002AE */  sw         $v0, 0xE4($s0)
    /* 9F304 800AEB04 23104901 */  subu       $v0, $t2, $t1
    /* 9F308 800AEB08 00120200 */  sll        $v0, $v0, 8
    /* 9F30C 800AEB0C CC0C4224 */  addiu      $v0, $v0, 0xCCC
    /* 9F310 800AEB10 D5BA0208 */  j          .L800AEB54
    /* 9F314 800AEB14 EC0002AE */   sw        $v0, 0xEC($s0)
  .L800AEB18:
    /* 9F318 800AEB18 0E004014 */  bnez       $v0, .L800AEB54
    /* 9F31C 800AEB1C 21102A01 */   addu      $v0, $t1, $t2
    /* 9F320 800AEB20 01004224 */  addiu      $v0, $v0, 0x1
    /* 9F324 800AEB24 43100200 */  sra        $v0, $v0, 1
    /* 9F328 800AEB28 00120200 */  sll        $v0, $v0, 8
    /* 9F32C 800AEB2C D80002AE */  sw         $v0, 0xD8($s0)
    /* 9F330 800AEB30 2110AE01 */  addu       $v0, $t5, $t6
    /* 9F334 800AEB34 01004224 */  addiu      $v0, $v0, 0x1
    /* 9F338 800AEB38 43100200 */  sra        $v0, $v0, 1
    /* 9F33C 800AEB3C 00120200 */  sll        $v0, $v0, 8
    /* 9F340 800AEB40 DC0002AE */  sw         $v0, 0xDC($s0)
    /* 9F344 800AEB44 23104901 */  subu       $v0, $t2, $t1
    /* 9F348 800AEB48 00120200 */  sll        $v0, $v0, 8
    /* 9F34C 800AEB4C CC0C4224 */  addiu      $v0, $v0, 0xCCC
    /* 9F350 800AEB50 E80002AE */  sw         $v0, 0xE8($s0)
  .L800AEB54:
    /* 9F354 800AEB54 06003927 */  addiu      $t9, $t9, 0x6
    /* 9F358 800AEB58 E4B90208 */  j          .L800AE790
    /* 9F35C 800AEB5C 01001827 */   addiu     $t8, $t8, 0x1
  .L800AEB60:
    /* 9F360 800AEB60 2000A28F */  lw         $v0, 0x20($sp)
    /* 9F364 800AEB64 1000A38F */  lw         $v1, 0x10($sp)
    /* 9F368 800AEB68 00000000 */  nop
    /* 9F36C 800AEB6C 23104300 */  subu       $v0, $v0, $v1
    /* 9F370 800AEB70 C21F0200 */  srl        $v1, $v0, 31
    /* 9F374 800AEB74 21104300 */  addu       $v0, $v0, $v1
    /* 9F378 800AEB78 43100200 */  sra        $v0, $v0, 1
    /* 9F37C 800AEB7C 00120200 */  sll        $v0, $v0, 8
    /* 9F380 800AEB80 340102AE */  sw         $v0, 0x134($s0)
    /* 9F384 800AEB84 2400A28F */  lw         $v0, 0x24($sp)
    /* 9F388 800AEB88 1400A38F */  lw         $v1, 0x14($sp)
    /* 9F38C 800AEB8C 00000000 */  nop
    /* 9F390 800AEB90 23104300 */  subu       $v0, $v0, $v1
    /* 9F394 800AEB94 C21F0200 */  srl        $v1, $v0, 31
    /* 9F398 800AEB98 21104300 */  addu       $v0, $v0, $v1
    /* 9F39C 800AEB9C 43100200 */  sra        $v0, $v0, 1
    /* 9F3A0 800AEBA0 00120200 */  sll        $v0, $v0, 8
    /* 9F3A4 800AEBA4 380102AE */  sw         $v0, 0x138($s0)
    /* 9F3A8 800AEBA8 2800A28F */  lw         $v0, 0x28($sp)
    /* 9F3AC 800AEBAC 1800A38F */  lw         $v1, 0x18($sp)
    /* 9F3B0 800AEBB0 00000000 */  nop
    /* 9F3B4 800AEBB4 23104300 */  subu       $v0, $v0, $v1
    /* 9F3B8 800AEBB8 C21F0200 */  srl        $v1, $v0, 31
    /* 9F3BC 800AEBBC 21104300 */  addu       $v0, $v0, $v1
    /* 9F3C0 800AEBC0 43100200 */  sra        $v0, $v0, 1
    /* 9F3C4 800AEBC4 001A0200 */  sll        $v1, $v0, 8
    /* 9F3C8 800AEBC8 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 9F3CC 800AEBCC 0300C214 */  bne        $a2, $v0, .L800AEBDC
    /* 9F3D0 800AEBD0 3C0103AE */   sw        $v1, 0x13C($s0)
    /* 9F3D4 800AEBD4 43100300 */  sra        $v0, $v1, 1
    /* 9F3D8 800AEBD8 3C0102AE */  sw         $v0, 0x13C($s0)
  .L800AEBDC:
    /* 9F3DC 800AEBDC 3401028E */  lw         $v0, 0x134($s0)
    /* 9F3E0 800AEBE0 00000000 */  nop
    /* 9F3E4 800AEBE4 02004104 */  bgez       $v0, .L800AEBF0
    /* 9F3E8 800AEBE8 21184000 */   addu      $v1, $v0, $zero
    /* 9F3EC 800AEBEC FF004324 */  addiu      $v1, $v0, 0xFF
  .L800AEBF0:
    /* 9F3F0 800AEBF0 03220300 */  sra        $a0, $v1, 8
    /* 9F3F4 800AEBF4 18008400 */  mult       $a0, $a0
    /* 9F3F8 800AEBF8 3801028E */  lw         $v0, 0x138($s0)
    /* 9F3FC 800AEBFC 12200000 */  mflo       $a0
    /* 9F400 800AEC00 02004104 */  bgez       $v0, .L800AEC0C
    /* 9F404 800AEC04 21184000 */   addu      $v1, $v0, $zero
    /* 9F408 800AEC08 FF004324 */  addiu      $v1, $v0, 0xFF
  .L800AEC0C:
    /* 9F40C 800AEC0C 031A0300 */  sra        $v1, $v1, 8
    /* 9F410 800AEC10 18006300 */  mult       $v1, $v1
    /* 9F414 800AEC14 12880000 */  mflo       $s1
    /* 9F418 800AEC18 2BAC030C */  jal        fixedsqrt
    /* 9F41C 800AEC1C 21209100 */   addu      $a0, $a0, $s1
    /* 9F420 800AEC20 400102AE */  sw         $v0, 0x140($s0)
    /* 9F424 800AEC24 02004104 */  bgez       $v0, .L800AEC30
    /* 9F428 800AEC28 21184000 */   addu      $v1, $v0, $zero
    /* 9F42C 800AEC2C FF004324 */  addiu      $v1, $v0, 0xFF
  .L800AEC30:
    /* 9F430 800AEC30 03220300 */  sra        $a0, $v1, 8
    /* 9F434 800AEC34 18008400 */  mult       $a0, $a0
    /* 9F438 800AEC38 3C01028E */  lw         $v0, 0x13C($s0)
    /* 9F43C 800AEC3C 12200000 */  mflo       $a0
    /* 9F440 800AEC40 02004104 */  bgez       $v0, .L800AEC4C
    /* 9F444 800AEC44 21184000 */   addu      $v1, $v0, $zero
    /* 9F448 800AEC48 FF004324 */  addiu      $v1, $v0, 0xFF
  .L800AEC4C:
    /* 9F44C 800AEC4C 031A0300 */  sra        $v1, $v1, 8
    /* 9F450 800AEC50 18006300 */  mult       $v1, $v1
    /* 9F454 800AEC54 12880000 */  mflo       $s1
    /* 9F458 800AEC58 2BAC030C */  jal        fixedsqrt
    /* 9F45C 800AEC5C 21209100 */   addu      $a0, $a0, $s1
    /* 9F460 800AEC60 400102AE */  sw         $v0, 0x140($s0)
    /* 9F464 800AEC64 3800BF8F */  lw         $ra, 0x38($sp)
    /* 9F468 800AEC68 3400B18F */  lw         $s1, 0x34($sp)
    /* 9F46C 800AEC6C 3000B08F */  lw         $s0, 0x30($sp)
    /* 9F470 800AEC70 0800E003 */  jr         $ra
    /* 9F474 800AEC74 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei
