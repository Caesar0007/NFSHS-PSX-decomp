.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis, 0x358

glabel DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* B86BC 800C7EBC 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* B86C0 800C7EC0 6000B2AF */  sw         $s2, 0x60($sp)
    /* B86C4 800C7EC4 2190A000 */  addu       $s2, $a1, $zero
    /* B86C8 800C7EC8 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* B86CC 800C7ECC 21A8E000 */  addu       $s5, $a3, $zero
    /* B86D0 800C7ED0 0400A226 */  addiu      $v0, $s5, 0x4
    /* B86D4 800C7ED4 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* B86D8 800C7ED8 7800BEAF */  sw         $fp, 0x78($sp)
    /* B86DC 800C7EDC 7400B7AF */  sw         $s7, 0x74($sp)
    /* B86E0 800C7EE0 7000B6AF */  sw         $s6, 0x70($sp)
    /* B86E4 800C7EE4 6800B4AF */  sw         $s4, 0x68($sp)
    /* B86E8 800C7EE8 6400B3AF */  sw         $s3, 0x64($sp)
    /* B86EC 800C7EEC 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* B86F0 800C7EF0 5800B0AF */  sw         $s0, 0x58($sp)
    /* B86F4 800C7EF4 E00042AE */  sw         $v0, 0xE0($s2)
    /* B86F8 800C7EF8 0300A292 */  lbu        $v0, 0x3($s5)
    /* B86FC 800C7EFC 9000B18F */  lw         $s1, 0x90($sp)
    /* B8700 800C7F00 9400B78F */  lw         $s7, 0x94($sp)
    /* B8704 800C7F04 9800B697 */  lhu        $s6, 0x98($sp)
    /* B8708 800C7F08 21988000 */  addu       $s3, $a0, $zero
    /* B870C 800C7F0C E70042A2 */  sb         $v0, 0xE7($s2)
    /* B8710 800C7F10 0200A292 */  lbu        $v0, 0x2($s5)
    /* B8714 800C7F14 1480043C */  lui        $a0, %hi(Track_materials)
    /* B8718 800C7F18 D0D4848C */  lw         $a0, %lo(Track_materials)($a0)
    /* B871C 800C7F1C 060140A2 */  sb         $zero, 0x106($s2)
    /* B8720 800C7F20 1480033C */  lui        $v1, %hi(gNight_renderNight)
    /* B8724 800C7F24 28DA638C */  lw         $v1, %lo(gNight_renderNight)($v1)
    /* B8728 800C7F28 21F0C000 */  addu       $fp, $a2, $zero
    /* B872C 800C7F2C EC0057AE */  sw         $s7, 0xEC($s2)
    /* B8730 800C7F30 C0100200 */  sll        $v0, $v0, 3
    /* B8734 800C7F34 04004224 */  addiu      $v0, $v0, 0x4
    /* B8738 800C7F38 2110A202 */  addu       $v0, $s5, $v0
    /* B873C 800C7F3C E80042AE */  sw         $v0, 0xE8($s2)
    /* B8740 800C7F40 65006010 */  beqz       $v1, .L800C80D8
    /* B8744 800C7F44 F00044AE */   sw        $a0, 0xF0($s2)
    /* B8748 800C7F48 04000224 */  addiu      $v0, $zero, 0x4
    /* B874C 800C7F4C 1180033C */  lui        $v1, %hi(Cars_gList)
    /* B8750 800C7F50 060142A2 */  sb         $v0, 0x106($s2)
    /* B8754 800C7F54 0400628E */  lw         $v0, 0x4($s3)
    /* B8758 800C7F58 DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* B875C 800C7F5C 80100200 */  sll        $v0, $v0, 2
    /* B8760 800C7F60 21104300 */  addu       $v0, $v0, $v1
    /* B8764 800C7F64 0000428C */  lw         $v0, 0x0($v0)
    /* B8768 800C7F68 00000000 */  nop
    /* B876C 800C7F6C 47044290 */  lbu        $v0, 0x447($v0)
    /* B8770 800C7F70 00000000 */  nop
    /* B8774 800C7F74 06004230 */  andi       $v0, $v0, 0x6
    /* B8778 800C7F78 02004010 */  beqz       $v0, .L800C7F84
    /* B877C 800C7F7C 05000224 */   addiu     $v0, $zero, 0x5
    /* B8780 800C7F80 060142A2 */  sb         $v0, 0x106($s2)
  .L800C7F84:
    /* B8784 800C7F84 1180063C */  lui        $a2, %hi(Camera_gInfo)
    /* B8788 800C7F88 0400638E */  lw         $v1, 0x4($s3)
    /* B878C 800C7F8C ACF2C624 */  addiu      $a2, $a2, %lo(Camera_gInfo)
    /* B8790 800C7F90 00110300 */  sll        $v0, $v1, 4
    /* B8794 800C7F94 21104300 */  addu       $v0, $v0, $v1
    /* B8798 800C7F98 00110200 */  sll        $v0, $v0, 4
    /* B879C 800C7F9C 21104600 */  addu       $v0, $v0, $a2
    /* B87A0 800C7FA0 0400428C */  lw         $v0, 0x4($v0)
    /* B87A4 800C7FA4 00000000 */  nop
    /* B87A8 800C7FA8 A000438C */  lw         $v1, 0xA0($v0)
    /* B87AC 800C7FAC 0000228E */  lw         $v0, 0x0($s1)
    /* B87B0 800C7FB0 00000000 */  nop
    /* B87B4 800C7FB4 23104300 */  subu       $v0, $v0, $v1
    /* B87B8 800C7FB8 3800A2AF */  sw         $v0, 0x38($sp)
    /* B87BC 800C7FBC 0400638E */  lw         $v1, 0x4($s3)
    /* B87C0 800C7FC0 3800B427 */  addiu      $s4, $sp, 0x38
    /* B87C4 800C7FC4 00110300 */  sll        $v0, $v1, 4
    /* B87C8 800C7FC8 21104300 */  addu       $v0, $v0, $v1
    /* B87CC 800C7FCC 00110200 */  sll        $v0, $v0, 4
    /* B87D0 800C7FD0 21104600 */  addu       $v0, $v0, $a2
    /* B87D4 800C7FD4 0400428C */  lw         $v0, 0x4($v0)
    /* B87D8 800C7FD8 21208002 */  addu       $a0, $s4, $zero
    /* B87DC 800C7FDC A400438C */  lw         $v1, 0xA4($v0)
    /* B87E0 800C7FE0 0400228E */  lw         $v0, 0x4($s1)
    /* B87E4 800C7FE4 1180053C */  lui        $a1, %hi(gNightMat)
    /* B87E8 800C7FE8 23104300 */  subu       $v0, $v0, $v1
    /* B87EC 800C7FEC 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* B87F0 800C7FF0 0400638E */  lw         $v1, 0x4($s3)
    /* B87F4 800C7FF4 64EEA524 */  addiu      $a1, $a1, %lo(gNightMat)
    /* B87F8 800C7FF8 00110300 */  sll        $v0, $v1, 4
    /* B87FC 800C7FFC 21104300 */  addu       $v0, $v0, $v1
    /* B8800 800C8000 00110200 */  sll        $v0, $v0, 4
    /* B8804 800C8004 21104600 */  addu       $v0, $v0, $a2
    /* B8808 800C8008 0400428C */  lw         $v0, 0x4($v0)
    /* B880C 800C800C 4800B027 */  addiu      $s0, $sp, 0x48
    /* B8810 800C8010 A800438C */  lw         $v1, 0xA8($v0)
    /* B8814 800C8014 0800228E */  lw         $v0, 0x8($s1)
    /* B8818 800C8018 21300002 */  addu       $a2, $s0, $zero
    /* B881C 800C801C 23104300 */  subu       $v0, $v0, $v1
    /* B8820 800C8020 B6AB030C */  jal        transform
    /* B8824 800C8024 4000A2AF */   sw        $v0, 0x40($sp)
    /* B8828 800C8028 21200002 */  addu       $a0, $s0, $zero
    /* B882C 800C802C 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B8830 800C8030 34004526 */   addiu     $a1, $s2, 0x34
    /* B8834 800C8034 1480023C */  lui        $v0, %hi(BW_gCopCarObj)
    /* B8838 800C8038 B4C7428C */  lw         $v0, %lo(BW_gCopCarObj)($v0)
    /* B883C 800C803C 00000000 */  nop
    /* B8840 800C8040 1B004010 */  beqz       $v0, .L800C80B0
    /* B8844 800C8044 21208002 */   addu      $a0, $s4, $zero
    /* B8848 800C8048 06014292 */  lbu        $v0, 0x106($s2)
    /* B884C 800C804C 00000000 */  nop
    /* B8850 800C8050 02004234 */  ori        $v0, $v0, 0x2
    /* B8854 800C8054 060142A2 */  sb         $v0, 0x106($s2)
    /* B8858 800C8058 1480033C */  lui        $v1, %hi(BW_gCopCarObj)
    /* B885C 800C805C B4C7638C */  lw         $v1, %lo(BW_gCopCarObj)($v1)
    /* B8860 800C8060 0000228E */  lw         $v0, 0x0($s1)
    /* B8864 800C8064 A000658C */  lw         $a1, 0xA0($v1)
    /* B8868 800C8068 00000000 */  nop
    /* B886C 800C806C 23104500 */  subu       $v0, $v0, $a1
    /* B8870 800C8070 1180053C */  lui        $a1, %hi(gCopMat)
    /* B8874 800C8074 3800A2AF */  sw         $v0, 0x38($sp)
    /* B8878 800C8078 A400668C */  lw         $a2, 0xA4($v1)
    /* B887C 800C807C 0400228E */  lw         $v0, 0x4($s1)
    /* B8880 800C8080 88EEA524 */  addiu      $a1, $a1, %lo(gCopMat)
    /* B8884 800C8084 23104600 */  subu       $v0, $v0, $a2
    /* B8888 800C8088 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* B888C 800C808C A800638C */  lw         $v1, 0xA8($v1)
    /* B8890 800C8090 0800228E */  lw         $v0, 0x8($s1)
    /* B8894 800C8094 21300002 */  addu       $a2, $s0, $zero
    /* B8898 800C8098 23104300 */  subu       $v0, $v0, $v1
    /* B889C 800C809C B6AB030C */  jal        transform
    /* B88A0 800C80A0 4000A2AF */   sw        $v0, 0x40($sp)
    /* B88A4 800C80A4 21200002 */  addu       $a0, $s0, $zero
    /* B88A8 800C80A8 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B88AC 800C80AC 54004526 */   addiu     $a1, $s2, 0x54
  .L800C80B0:
    /* B88B0 800C80B0 14004226 */  addiu      $v0, $s2, 0x14
    /* B88B4 800C80B4 1C0040AC */  sw         $zero, 0x1C($v0)
    /* B88B8 800C80B8 180040AC */  sw         $zero, 0x18($v0)
    /* B88BC 800C80BC 280040AE */  sw         $zero, 0x28($s2)
    /* B88C0 800C80C0 14004C8C */  lw         $t4, 0x14($v0)
    /* B88C4 800C80C4 18004D8C */  lw         $t5, 0x18($v0)
    /* B88C8 800C80C8 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B88CC 800C80CC 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B88D0 800C80D0 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B88D4 800C80D4 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
  .L800C80D8:
    /* B88D8 800C80D8 0800638E */  lw         $v1, 0x8($s3)
    /* B88DC 800C80DC 0000228E */  lw         $v0, 0x0($s1)
    /* B88E0 800C80E0 00000000 */  nop
    /* B88E4 800C80E4 23104300 */  subu       $v0, $v0, $v1
    /* B88E8 800C80E8 3800A2AF */  sw         $v0, 0x38($sp)
    /* B88EC 800C80EC 0C00638E */  lw         $v1, 0xC($s3)
    /* B88F0 800C80F0 0400228E */  lw         $v0, 0x4($s1)
    /* B88F4 800C80F4 00000000 */  nop
    /* B88F8 800C80F8 23104300 */  subu       $v0, $v0, $v1
    /* B88FC 800C80FC 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* B8900 800C8100 1000638E */  lw         $v1, 0x10($s3)
    /* B8904 800C8104 0800228E */  lw         $v0, 0x8($s1)
    /* B8908 800C8108 00000000 */  nop
    /* B890C 800C810C 23104300 */  subu       $v0, $v0, $v1
    /* B8910 800C8110 E786030C */  jal        TrsProj_SetPsxTransZero__Fv
    /* B8914 800C8114 4000A2AF */   sw        $v0, 0x40($sp)
    /* B8918 800C8118 3800A427 */  addiu      $a0, $sp, 0x38
    /* B891C 800C811C 4800B327 */  addiu      $s3, $sp, 0x48
    /* B8920 800C8120 F386030C */  jal        TrsProj_TransPt__FP8coorddefT0
    /* B8924 800C8124 21286002 */   addu      $a1, $s3, $zero
    /* B8928 800C8128 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B892C 800C812C 0E00E216 */  bne        $s7, $v0, .L800C8168
    /* B8930 800C8130 2120C003 */   addu      $a0, $fp, $zero
    /* B8934 800C8134 1480023C */  lui        $v0, %hi(Draw_gMidGroundOtz)
    /* B8938 800C8138 BCD7428C */  lw         $v0, %lo(Draw_gMidGroundOtz)($v0)
    /* B893C 800C813C 00000000 */  nop
    /* B8940 800C8140 EC0042AE */  sw         $v0, 0xEC($s2)
    /* B8944 800C8144 4800A28F */  lw         $v0, 0x48($sp)
    /* B8948 800C8148 5000A38F */  lw         $v1, 0x50($sp)
    /* B894C 800C814C 83100200 */  sra        $v0, $v0, 2
    /* B8950 800C8150 4800A2AF */  sw         $v0, 0x48($sp)
    /* B8954 800C8154 4C00A28F */  lw         $v0, 0x4C($sp)
    /* B8958 800C8158 83180300 */  sra        $v1, $v1, 2
    /* B895C 800C815C 5000A3AF */  sw         $v1, 0x50($sp)
    /* B8960 800C8160 83100200 */  sra        $v0, $v0, 2
    /* B8964 800C8164 4C00A2AF */  sw         $v0, 0x4C($sp)
  .L800C8168:
    /* B8968 800C8168 1180113C */  lui        $s1, %hi(gWorldMat)
    /* B896C 800C816C 40EE3126 */  addiu      $s1, $s1, %lo(gWorldMat)
    /* B8970 800C8170 21282002 */  addu       $a1, $s1, $zero
    /* B8974 800C8174 1000A627 */  addiu      $a2, $sp, 0x10
    /* B8978 800C8178 F40040AE */  sw         $zero, 0xF4($s2)
    /* B897C 800C817C 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* B8980 800C8180 F80040A6 */   sh        $zero, 0xF8($s2)
    /* B8984 800C8184 1000A427 */  addiu      $a0, $sp, 0x10
    /* B8988 800C8188 14005026 */  addiu      $s0, $s2, 0x14
    /* B898C 800C818C 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* B8990 800C8190 21280002 */   addu      $a1, $s0, $zero
    /* B8994 800C8194 21206002 */  addu       $a0, $s3, $zero
    /* B8998 800C8198 761D030C */  jal        DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX
    /* B899C 800C819C 21280002 */   addu      $a1, $s0, $zero
    /* B89A0 800C81A0 21204002 */  addu       $a0, $s2, $zero
    /* B89A4 800C81A4 070140A2 */  sb         $zero, 0x107($s2)
    /* B89A8 800C81A8 8E1B030C */  jal        DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache
    /* B89AC 800C81AC D80056A6 */   sh        $s6, 0xD8($s2)
    /* B89B0 800C81B0 21202002 */  addu       $a0, $s1, $zero
    /* B89B4 800C81B4 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* B89B8 800C81B8 21280002 */   addu      $a1, $s0, $zero
    /* B89BC 800C81BC 1C0000AE */  sw         $zero, 0x1C($s0)
    /* B89C0 800C81C0 180000AE */  sw         $zero, 0x18($s0)
    /* B89C4 800C81C4 280040AE */  sw         $zero, 0x28($s2)
    /* B89C8 800C81C8 14000C8E */  lw         $t4, 0x14($s0)
    /* B89CC 800C81CC 18000D8E */  lw         $t5, 0x18($s0)
    /* B89D0 800C81D0 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B89D4 800C81D4 1C000E8E */  lw         $t6, 0x1C($s0)
    /* B89D8 800C81D8 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B89DC 800C81DC 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B89E0 800C81E0 0300A292 */  lbu        $v0, 0x3($s5)
    /* B89E4 800C81E4 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* B89E8 800C81E8 7800BE8F */  lw         $fp, 0x78($sp)
    /* B89EC 800C81EC 7400B78F */  lw         $s7, 0x74($sp)
    /* B89F0 800C81F0 7000B68F */  lw         $s6, 0x70($sp)
    /* B89F4 800C81F4 6C00B58F */  lw         $s5, 0x6C($sp)
    /* B89F8 800C81F8 6800B48F */  lw         $s4, 0x68($sp)
    /* B89FC 800C81FC 6400B38F */  lw         $s3, 0x64($sp)
    /* B8A00 800C8200 6000B28F */  lw         $s2, 0x60($sp)
    /* B8A04 800C8204 5C00B18F */  lw         $s1, 0x5C($sp)
    /* B8A08 800C8208 5800B08F */  lw         $s0, 0x58($sp)
    /* B8A0C 800C820C 0800E003 */  jr         $ra
    /* B8A10 800C8210 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
