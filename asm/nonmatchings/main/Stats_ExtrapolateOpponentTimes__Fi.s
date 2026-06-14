.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_ExtrapolateOpponentTimes__Fi, 0x7B4

glabel Stats_ExtrapolateOpponentTimes__Fi
    /* A8E04 800B8604 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* A8E08 800B8608 2800B6AF */  sw         $s6, 0x28($sp)
    /* A8E0C 800B860C 21B08000 */  addu       $s6, $a0, $zero
    /* A8E10 800B8610 03000424 */  addiu      $a0, $zero, 0x3
    /* A8E14 800B8614 21280000 */  addu       $a1, $zero, $zero
    /* A8E18 800B8618 3000BFAF */  sw         $ra, 0x30($sp)
    /* A8E1C 800B861C 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* A8E20 800B8620 2400B5AF */  sw         $s5, 0x24($sp)
    /* A8E24 800B8624 2000B4AF */  sw         $s4, 0x20($sp)
    /* A8E28 800B8628 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A8E2C 800B862C 1800B2AF */  sw         $s2, 0x18($sp)
    /* A8E30 800B8630 1400B1AF */  sw         $s1, 0x14($sp)
    /* A8E34 800B8634 C674020C */  jal        Input_Interface__FUli
    /* A8E38 800B8638 1000B0AF */   sw        $s0, 0x10($sp)
    /* A8E3C 800B863C 2B980200 */  sltu       $s3, $zero, $v0
    /* A8E40 800B8640 21900000 */  addu       $s2, $zero, $zero
    /* A8E44 800B8644 02001424 */  addiu      $s4, $zero, 0x2
    /* A8E48 800B8648 1180173C */  lui        $s7, %hi(GameSetup_gData)
    /* A8E4C 800B864C EC31F526 */  addiu      $s5, $s7, %lo(GameSetup_gData)
    /* A8E50 800B8650 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* A8E54 800B8654 48FA5124 */  addiu      $s1, $v0, %lo(Cars_gHumanRaceCarList)
  .L800B8658:
    /* A8E58 800B8658 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* A8E5C 800B865C 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* A8E60 800B8660 00000000 */  nop
    /* A8E64 800B8664 2A104202 */  slt        $v0, $s2, $v0
    /* A8E68 800B8668 DE004010 */  beqz       $v0, .L800B89E4
    /* A8E6C 800B866C 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* A8E70 800B8670 0000258E */  lw         $a1, 0x0($s1)
    /* A8E74 800B8674 00000000 */  nop
    /* A8E78 800B8678 9003A28C */  lw         $v0, 0x390($a1)
    /* A8E7C 800B867C 00000000 */  nop
    /* A8E80 800B8680 41005410 */  beq        $v0, $s4, .L800B8788
    /* A8E84 800B8684 01000224 */   addiu     $v0, $zero, 0x1
    /* A8E88 800B8688 5003A48C */  lw         $a0, 0x350($a1)
    /* A8E8C 800B868C 00000000 */  nop
    /* A8E90 800B8690 0200801C */  bgtz       $a0, .L800B869C
    /* A8E94 800B8694 00000000 */   nop
    /* A8E98 800B8698 01000424 */  addiu      $a0, $zero, 0x1
  .L800B869C:
    /* A8E9C 800B869C 5403A28C */  lw         $v0, 0x354($a1)
    /* A8EA0 800B86A0 00000000 */  nop
    /* A8EA4 800B86A4 00FE4624 */  addiu      $a2, $v0, -0x200
    /* A8EA8 800B86A8 64008228 */  slti       $v0, $a0, 0x64
    /* A8EAC 800B86AC 04004010 */  beqz       $v0, .L800B86C0
    /* A8EB0 800B86B0 40100400 */   sll       $v0, $a0, 1
    /* A8EB4 800B86B4 21104400 */  addu       $v0, $v0, $a0
    /* A8EB8 800B86B8 80100200 */  sll        $v0, $v0, 2
    /* A8EBC 800B86BC 21304400 */  addu       $a2, $v0, $a0
  .L800B86C0:
    /* A8EC0 800B86C0 1480033C */  lui        $v1, %hi(gNumSlices)
    /* A8EC4 800B86C4 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* A8EC8 800B86C8 0400A28E */  lw         $v0, 0x4($s5)
    /* A8ECC 800B86CC 00000000 */  nop
    /* A8ED0 800B86D0 18006200 */  mult       $v1, $v0
    /* A8ED4 800B86D4 4C03A28C */  lw         $v0, 0x34C($a1)
    /* A8ED8 800B86D8 12180000 */  mflo       $v1
    /* A8EDC 800B86DC 21106200 */  addu       $v0, $v1, $v0
    /* A8EE0 800B86E0 00000000 */  nop
    /* A8EE4 800B86E4 1800C200 */  mult       $a2, $v0
    /* A8EE8 800B86E8 12180000 */  mflo       $v1
    /* A8EEC 800B86EC 00000000 */  nop
    /* A8EF0 800B86F0 00000000 */  nop
    /* A8EF4 800B86F4 1A006400 */  div        $zero, $v1, $a0
    /* A8EF8 800B86F8 02008014 */  bnez       $a0, .L800B8704
    /* A8EFC 800B86FC 00000000 */   nop
    /* A8F00 800B8700 0D000700 */  break      7
  .L800B8704:
    /* A8F04 800B8704 FFFF0124 */  addiu      $at, $zero, -0x1
    /* A8F08 800B8708 04008114 */  bne        $a0, $at, .L800B871C
    /* A8F0C 800B870C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* A8F10 800B8710 02006114 */  bne        $v1, $at, .L800B871C
    /* A8F14 800B8714 00000000 */   nop
    /* A8F18 800B8718 0D000600 */  break      6
  .L800B871C:
    /* A8F1C 800B871C 12800000 */  mflo       $s0
    /* A8F20 800B8720 03006012 */  beqz       $s3, .L800B8730
    /* A8F24 800B8724 40101000 */   sll       $v0, $s0, 1
    /* A8F28 800B8728 CDE10208 */  j          .L800B8734
    /* A8F2C 800B872C 6403B0AC */   sw        $s0, 0x364($a1)
  .L800B8730:
    /* A8F30 800B8730 6403A2AC */  sw         $v0, 0x364($a1)
  .L800B8734:
    /* A8F34 800B8734 EC31E28E */  lw         $v0, %lo(GameSetup_gData)($s7)
    /* A8F38 800B8738 00000000 */  nop
    /* A8F3C 800B873C 05005410 */  beq        $v0, $s4, .L800B8754
    /* A8F40 800B8740 00000000 */   nop
    /* A8F44 800B8744 0C006012 */  beqz       $s3, .L800B8778
    /* A8F48 800B8748 00000000 */   nop
    /* A8F4C 800B874C DBE10208 */  j          .L800B876C
    /* A8F50 800B8750 00000000 */   nop
  .L800B8754:
    /* A8F54 800B8754 1C00A28E */  lw         $v0, 0x1C($s5)
    /* A8F58 800B8758 00000000 */  nop
    /* A8F5C 800B875C 0A005214 */  bne        $v0, $s2, .L800B8788
    /* A8F60 800B8760 01000224 */   addiu     $v0, $zero, 0x1
    /* A8F64 800B8764 04006012 */  beqz       $s3, .L800B8778
    /* A8F68 800B8768 00000000 */   nop
  .L800B876C:
    /* A8F6C 800B876C 0000228E */  lw         $v0, 0x0($s1)
    /* A8F70 800B8770 E1E10208 */  j          .L800B8784
    /* A8F74 800B8774 900354AC */   sw        $s4, 0x390($v0)
  .L800B8778:
    /* A8F78 800B8778 0000238E */  lw         $v1, 0x0($s1)
    /* A8F7C 800B877C 01000224 */  addiu      $v0, $zero, 0x1
    /* A8F80 800B8780 900362AC */  sw         $v0, 0x390($v1)
  .L800B8784:
    /* A8F84 800B8784 01000224 */  addiu      $v0, $zero, 0x1
  .L800B8788:
    /* A8F88 800B8788 3E00C216 */  bne        $s6, $v0, .L800B8884
    /* A8F8C 800B878C 00000000 */   nop
    /* A8F90 800B8790 EC31E48E */  lw         $a0, %lo(GameSetup_gData)($s7)
    /* A8F94 800B8794 00000000 */  nop
    /* A8F98 800B8798 0E009410 */  beq        $a0, $s4, .L800B87D4
    /* A8F9C 800B879C 00000000 */   nop
    /* A8FA0 800B87A0 04006012 */  beqz       $s3, .L800B87B4
    /* A8FA4 800B87A4 00000000 */   nop
    /* A8FA8 800B87A8 0000228E */  lw         $v0, 0x0($s1)
    /* A8FAC 800B87AC 04E20208 */  j          .L800B8810
    /* A8FB0 800B87B0 900354AC */   sw        $s4, 0x390($v0)
  .L800B87B4:
    /* A8FB4 800B87B4 0000238E */  lw         $v1, 0x0($s1)
    /* A8FB8 800B87B8 00000000 */  nop
    /* A8FBC 800B87BC 9003628C */  lw         $v0, 0x390($v1)
    /* A8FC0 800B87C0 00000000 */  nop
    /* A8FC4 800B87C4 12005410 */  beq        $v0, $s4, .L800B8810
    /* A8FC8 800B87C8 00000000 */   nop
    /* A8FCC 800B87CC 04E20208 */  j          .L800B8810
    /* A8FD0 800B87D0 900376AC */   sw        $s6, 0x390($v1)
  .L800B87D4:
    /* A8FD4 800B87D4 0000238E */  lw         $v1, 0x0($s1)
    /* A8FD8 800B87D8 00000000 */  nop
    /* A8FDC 800B87DC 9003628C */  lw         $v0, 0x390($v1)
    /* A8FE0 800B87E0 00000000 */  nop
    /* A8FE4 800B87E4 0A004410 */  beq        $v0, $a0, .L800B8810
    /* A8FE8 800B87E8 00000000 */   nop
    /* A8FEC 800B87EC 1C00A28E */  lw         $v0, 0x1C($s5)
    /* A8FF0 800B87F0 00000000 */  nop
    /* A8FF4 800B87F4 06005214 */  bne        $v0, $s2, .L800B8810
    /* A8FF8 800B87F8 00000000 */   nop
    /* A8FFC 800B87FC 03006012 */  beqz       $s3, .L800B880C
    /* A9000 800B8800 00000000 */   nop
    /* A9004 800B8804 04E20208 */  j          .L800B8810
    /* A9008 800B8808 900364AC */   sw        $a0, 0x390($v1)
  .L800B880C:
    /* A900C 800B880C 900376AC */  sw         $s6, 0x390($v1)
  .L800B8810:
    /* A9010 800B8810 0000248E */  lw         $a0, 0x0($s1)
    /* A9014 800B8814 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A9018 800B8818 00000000 */   nop
    /* A901C 800B881C 0000238E */  lw         $v1, 0x0($s1)
    /* A9020 800B8820 00000000 */  nop
    /* A9024 800B8824 D00362AC */  sw         $v0, 0x3D0($v1)
    /* A9028 800B8828 0000238E */  lw         $v1, 0x0($s1)
    /* A902C 800B882C 00000000 */  nop
    /* A9030 800B8830 6403628C */  lw         $v0, 0x364($v1)
    /* A9034 800B8834 00000000 */  nop
    /* A9038 800B8838 D40362AC */  sw         $v0, 0x3D4($v1)
    /* A903C 800B883C 0400A28E */  lw         $v0, 0x4($s5)
    /* A9040 800B8840 00000000 */  nop
    /* A9044 800B8844 0F004018 */  blez       $v0, .L800B8884
    /* A9048 800B8848 21280000 */   addu      $a1, $zero, $zero
    /* A904C 800B884C 21202002 */  addu       $a0, $s1, $zero
    /* A9050 800B8850 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A9054 800B8854 EC314624 */  addiu      $a2, $v0, %lo(GameSetup_gData)
  .L800B8858:
    /* A9058 800B8858 0000838C */  lw         $v1, 0x0($a0)
    /* A905C 800B885C 80100500 */  sll        $v0, $a1, 2
    /* A9060 800B8860 21186200 */  addu       $v1, $v1, $v0
    /* A9064 800B8864 6803628C */  lw         $v0, 0x368($v1)
    /* A9068 800B8868 00000000 */  nop
    /* A906C 800B886C D80362AC */  sw         $v0, 0x3D8($v1)
    /* A9070 800B8870 0400C28C */  lw         $v0, 0x4($a2)
    /* A9074 800B8874 0100A524 */  addiu      $a1, $a1, 0x1
    /* A9078 800B8878 2A10A200 */  slt        $v0, $a1, $v0
    /* A907C 800B887C F6FF4014 */  bnez       $v0, .L800B8858
    /* A9080 800B8880 00000000 */   nop
  .L800B8884:
    /* A9084 800B8884 0000248E */  lw         $a0, 0x0($s1)
    /* A9088 800B8888 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A908C 800B888C 00000000 */   nop
    /* A9090 800B8890 0000238E */  lw         $v1, 0x0($s1)
    /* A9094 800B8894 00000000 */  nop
    /* A9098 800B8898 D00362AC */  sw         $v0, 0x3D0($v1)
    /* A909C 800B889C 0000248E */  lw         $a0, 0x0($s1)
    /* A90A0 800B88A0 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A90A4 800B88A4 00000000 */   nop
    /* A90A8 800B88A8 0000238E */  lw         $v1, 0x0($s1)
    /* A90AC 800B88AC 00000000 */  nop
    /* A90B0 800B88B0 D00362AC */  sw         $v0, 0x3D0($v1)
    /* A90B4 800B88B4 0000238E */  lw         $v1, 0x0($s1)
    /* A90B8 800B88B8 00000000 */  nop
    /* A90BC 800B88BC 6403628C */  lw         $v0, 0x364($v1)
    /* A90C0 800B88C0 00000000 */  nop
    /* A90C4 800B88C4 D40362AC */  sw         $v0, 0x3D4($v1)
    /* A90C8 800B88C8 0000238E */  lw         $v1, 0x0($s1)
    /* A90CC 800B88CC 00000000 */  nop
    /* A90D0 800B88D0 9003628C */  lw         $v0, 0x390($v1)
    /* A90D4 800B88D4 00000000 */  nop
    /* A90D8 800B88D8 CC0362AC */  sw         $v0, 0x3CC($v1)
    /* A90DC 800B88DC 0000238E */  lw         $v1, 0x0($s1)
    /* A90E0 800B88E0 00000000 */  nop
    /* A90E4 800B88E4 6803628C */  lw         $v0, 0x368($v1)
    /* A90E8 800B88E8 00000000 */  nop
    /* A90EC 800B88EC E80362AC */  sw         $v0, 0x3E8($v1)
    /* A90F0 800B88F0 0000238E */  lw         $v1, 0x0($s1)
    /* A90F4 800B88F4 00000000 */  nop
    /* A90F8 800B88F8 A003628C */  lw         $v0, 0x3A0($v1)
    /* A90FC 800B88FC 00000000 */  nop
    /* A9100 800B8900 C00362AC */  sw         $v0, 0x3C0($v1)
    /* A9104 800B8904 0000238E */  lw         $v1, 0x0($s1)
    /* A9108 800B8908 00000000 */  nop
    /* A910C 800B890C A403628C */  lw         $v0, 0x3A4($v1)
    /* A9110 800B8910 00000000 */  nop
    /* A9114 800B8914 C40362AC */  sw         $v0, 0x3C4($v1)
    /* A9118 800B8918 0000228E */  lw         $v0, 0x0($s1)
    /* A911C 800B891C 00000000 */  nop
    /* A9120 800B8920 A803438C */  lw         $v1, 0x3A8($v0)
    /* A9124 800B8924 21280000 */  addu       $a1, $zero, $zero
    /* A9128 800B8928 C80343AC */  sw         $v1, 0x3C8($v0)
    /* A912C 800B892C 0000228E */  lw         $v0, 0x0($s1)
    /* A9130 800B8930 21302002 */  addu       $a2, $s1, $zero
    /* A9134 800B8934 BC0340AC */  sw         $zero, 0x3BC($v0)
  .L800B8938:
    /* A9138 800B8938 0000C48C */  lw         $a0, 0x0($a2)
    /* A913C 800B893C 80100500 */  sll        $v0, $a1, 2
    /* A9140 800B8940 21108200 */  addu       $v0, $a0, $v0
    /* A9144 800B8944 BC03838C */  lw         $v1, 0x3BC($a0)
    /* A9148 800B8948 1802428C */  lw         $v0, 0x218($v0)
    /* A914C 800B894C 0100A524 */  addiu      $a1, $a1, 0x1
    /* A9150 800B8950 21186200 */  addu       $v1, $v1, $v0
    /* A9154 800B8954 0A00A228 */  slti       $v0, $a1, 0xA
    /* A9158 800B8958 F7FF4014 */  bnez       $v0, .L800B8938
    /* A915C 800B895C BC0383AC */   sw        $v1, 0x3BC($a0)
    /* A9160 800B8960 0400A28E */  lw         $v0, 0x4($s5)
    /* A9164 800B8964 00000000 */  nop
    /* A9168 800B8968 1B004018 */  blez       $v0, .L800B89D8
    /* A916C 800B896C 21280000 */   addu      $a1, $zero, $zero
    /* A9170 800B8970 21382002 */  addu       $a3, $s1, $zero
    /* A9174 800B8974 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A9178 800B8978 EC314824 */  addiu      $t0, $v0, %lo(GameSetup_gData)
  .L800B897C:
    /* A917C 800B897C 0000E38C */  lw         $v1, 0x0($a3)
    /* A9180 800B8980 80200500 */  sll        $a0, $a1, 2
    /* A9184 800B8984 21186400 */  addu       $v1, $v1, $a0
    /* A9188 800B8988 6803628C */  lw         $v0, 0x368($v1)
    /* A918C 800B898C 00000000 */  nop
    /* A9190 800B8990 D80362AC */  sw         $v0, 0x3D8($v1)
    /* A9194 800B8994 0000E68C */  lw         $a2, 0x0($a3)
    /* A9198 800B8998 00000000 */  nop
    /* A919C 800B899C 2120C400 */  addu       $a0, $a2, $a0
    /* A91A0 800B89A0 D803838C */  lw         $v1, 0x3D8($a0)
    /* A91A4 800B89A4 E803C28C */  lw         $v0, 0x3E8($a2)
    /* A91A8 800B89A8 00000000 */  nop
    /* A91AC 800B89AC 2A106200 */  slt        $v0, $v1, $v0
    /* A91B0 800B89B0 04004010 */  beqz       $v0, .L800B89C4
    /* A91B4 800B89B4 00000000 */   nop
    /* A91B8 800B89B8 02006010 */  beqz       $v1, .L800B89C4
    /* A91BC 800B89BC 00000000 */   nop
    /* A91C0 800B89C0 E803C3AC */  sw         $v1, 0x3E8($a2)
  .L800B89C4:
    /* A91C4 800B89C4 0400028D */  lw         $v0, 0x4($t0)
    /* A91C8 800B89C8 0100A524 */  addiu      $a1, $a1, 0x1
    /* A91CC 800B89CC 2A10A200 */  slt        $v0, $a1, $v0
    /* A91D0 800B89D0 EAFF4014 */  bnez       $v0, .L800B897C
    /* A91D4 800B89D4 00000000 */   nop
  .L800B89D8:
    /* A91D8 800B89D8 04003126 */  addiu      $s1, $s1, 0x4
    /* A91DC 800B89DC 96E10208 */  j          .L800B8658
    /* A91E0 800B89E0 01005226 */   addiu     $s2, $s2, 0x1
  .L800B89E4:
    /* A91E4 800B89E4 21900000 */  addu       $s2, $zero, $zero
    /* A91E8 800B89E8 02001524 */  addiu      $s5, $zero, 0x2
    /* A91EC 800B89EC EC315424 */  addiu      $s4, $v0, %lo(GameSetup_gData)
    /* A91F0 800B89F0 1180023C */  lui        $v0, %hi(Cars_gAIRaceCarList)
    /* A91F4 800B89F4 6CFA5124 */  addiu      $s1, $v0, %lo(Cars_gAIRaceCarList)
  .L800B89F8:
    /* A91F8 800B89F8 1480023C */  lui        $v0, %hi(Cars_gNumAIRaceCars)
    /* A91FC 800B89FC 04C8428C */  lw         $v0, %lo(Cars_gNumAIRaceCars)($v0)
    /* A9200 800B8A00 00000000 */  nop
    /* A9204 800B8A04 2A104202 */  slt        $v0, $s2, $v0
    /* A9208 800B8A08 B8004010 */  beqz       $v0, .L800B8CEC
    /* A920C 800B8A0C 00000000 */   nop
    /* A9210 800B8A10 0000258E */  lw         $a1, 0x0($s1)
    /* A9214 800B8A14 00000000 */  nop
    /* A9218 800B8A18 9003A28C */  lw         $v0, 0x390($a1)
    /* A921C 800B8A1C 00000000 */  nop
    /* A9220 800B8A20 43005510 */  beq        $v0, $s5, .L800B8B30
    /* A9224 800B8A24 00000000 */   nop
    /* A9228 800B8A28 5003A48C */  lw         $a0, 0x350($a1)
    /* A922C 800B8A2C 00000000 */  nop
    /* A9230 800B8A30 0200801C */  bgtz       $a0, .L800B8A3C
    /* A9234 800B8A34 00000000 */   nop
    /* A9238 800B8A38 01000424 */  addiu      $a0, $zero, 0x1
  .L800B8A3C:
    /* A923C 800B8A3C 5403A28C */  lw         $v0, 0x354($a1)
    /* A9240 800B8A40 00000000 */  nop
    /* A9244 800B8A44 00FE4624 */  addiu      $a2, $v0, -0x200
    /* A9248 800B8A48 64008228 */  slti       $v0, $a0, 0x64
    /* A924C 800B8A4C 04004010 */  beqz       $v0, .L800B8A60
    /* A9250 800B8A50 40100400 */   sll       $v0, $a0, 1
    /* A9254 800B8A54 21104400 */  addu       $v0, $v0, $a0
    /* A9258 800B8A58 80100200 */  sll        $v0, $v0, 2
    /* A925C 800B8A5C 21304400 */  addu       $a2, $v0, $a0
  .L800B8A60:
    /* A9260 800B8A60 1480033C */  lui        $v1, %hi(gNumSlices)
    /* A9264 800B8A64 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* A9268 800B8A68 0400828E */  lw         $v0, 0x4($s4)
    /* A926C 800B8A6C 00000000 */  nop
    /* A9270 800B8A70 18006200 */  mult       $v1, $v0
    /* A9274 800B8A74 4C03A28C */  lw         $v0, 0x34C($a1)
    /* A9278 800B8A78 12180000 */  mflo       $v1
    /* A927C 800B8A7C 21106200 */  addu       $v0, $v1, $v0
    /* A9280 800B8A80 00000000 */  nop
    /* A9284 800B8A84 1800C200 */  mult       $a2, $v0
    /* A9288 800B8A88 12180000 */  mflo       $v1
    /* A928C 800B8A8C 00000000 */  nop
    /* A9290 800B8A90 00000000 */  nop
    /* A9294 800B8A94 1A006400 */  div        $zero, $v1, $a0
    /* A9298 800B8A98 02008014 */  bnez       $a0, .L800B8AA4
    /* A929C 800B8A9C 00000000 */   nop
    /* A92A0 800B8AA0 0D000700 */  break      7
  .L800B8AA4:
    /* A92A4 800B8AA4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* A92A8 800B8AA8 04008114 */  bne        $a0, $at, .L800B8ABC
    /* A92AC 800B8AAC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* A92B0 800B8AB0 02006114 */  bne        $v1, $at, .L800B8ABC
    /* A92B4 800B8AB4 00000000 */   nop
    /* A92B8 800B8AB8 0D000600 */  break      6
  .L800B8ABC:
    /* A92BC 800B8ABC 12800000 */  mflo       $s0
    /* A92C0 800B8AC0 15006016 */  bnez       $s3, .L800B8B18
    /* A92C4 800B8AC4 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
    /* A92C8 800B8AC8 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* A92CC 800B8ACC 00000000 */  nop
    /* A92D0 800B8AD0 9003428C */  lw         $v0, 0x390($v0)
    /* A92D4 800B8AD4 00000000 */  nop
    /* A92D8 800B8AD8 0F005510 */  beq        $v0, $s5, .L800B8B18
    /* A92DC 800B8ADC 00000000 */   nop
    /* A92E0 800B8AE0 B5AA030C */  jal        rand
    /* A92E4 800B8AE4 00000000 */   nop
    /* A92E8 800B8AE8 0400838E */  lw         $v1, 0x4($s4)
    /* A92EC 800B8AEC 00000000 */  nop
    /* A92F0 800B8AF0 18006200 */  mult       $v1, $v0
    /* A92F4 800B8AF4 0000238E */  lw         $v1, 0x0($s1)
    /* A92F8 800B8AF8 12100000 */  mflo       $v0
    /* A92FC 800B8AFC 02004104 */  bgez       $v0, .L800B8B08
    /* A9300 800B8B00 00000000 */   nop
    /* A9304 800B8B04 7F004224 */  addiu      $v0, $v0, 0x7F
  .L800B8B08:
    /* A9308 800B8B08 C3110200 */  sra        $v0, $v0, 7
    /* A930C 800B8B0C 21100202 */  addu       $v0, $s0, $v0
    /* A9310 800B8B10 C9E20208 */  j          .L800B8B24
    /* A9314 800B8B14 640362AC */   sw        $v0, 0x364($v1)
  .L800B8B18:
    /* A9318 800B8B18 0000228E */  lw         $v0, 0x0($s1)
    /* A931C 800B8B1C 00000000 */  nop
    /* A9320 800B8B20 640350AC */  sw         $s0, 0x364($v0)
  .L800B8B24:
    /* A9324 800B8B24 0000228E */  lw         $v0, 0x0($s1)
    /* A9328 800B8B28 00000000 */  nop
    /* A932C 800B8B2C 900355AC */  sw         $s5, 0x390($v0)
  .L800B8B30:
    /* A9330 800B8B30 0000248E */  lw         $a0, 0x0($s1)
    /* A9334 800B8B34 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A9338 800B8B38 00000000 */   nop
    /* A933C 800B8B3C 0000238E */  lw         $v1, 0x0($s1)
    /* A9340 800B8B40 00000000 */  nop
    /* A9344 800B8B44 D00362AC */  sw         $v0, 0x3D0($v1)
    /* A9348 800B8B48 0000238E */  lw         $v1, 0x0($s1)
    /* A934C 800B8B4C 00000000 */  nop
    /* A9350 800B8B50 6403628C */  lw         $v0, 0x364($v1)
    /* A9354 800B8B54 00000000 */  nop
    /* A9358 800B8B58 D40362AC */  sw         $v0, 0x3D4($v1)
    /* A935C 800B8B5C 0000238E */  lw         $v1, 0x0($s1)
    /* A9360 800B8B60 00000000 */  nop
    /* A9364 800B8B64 9003628C */  lw         $v0, 0x390($v1)
    /* A9368 800B8B68 00000000 */  nop
    /* A936C 800B8B6C CC0362AC */  sw         $v0, 0x3CC($v1)
    /* A9370 800B8B70 0000228E */  lw         $v0, 0x0($s1)
    /* A9374 800B8B74 00000000 */  nop
    /* A9378 800B8B78 A803438C */  lw         $v1, 0x3A8($v0)
    /* A937C 800B8B7C 0100043C */  lui        $a0, (0x1869F >> 16)
    /* A9380 800B8B80 C80343AC */  sw         $v1, 0x3C8($v0)
    /* A9384 800B8B84 0000228E */  lw         $v0, 0x0($s1)
    /* A9388 800B8B88 9F868434 */  ori        $a0, $a0, (0x1869F & 0xFFFF)
    /* A938C 800B8B8C E80344AC */  sw         $a0, 0x3E8($v0)
    /* A9390 800B8B90 0400828E */  lw         $v0, 0x4($s4)
    /* A9394 800B8B94 00000000 */  nop
    /* A9398 800B8B98 15004018 */  blez       $v0, .L800B8BF0
    /* A939C 800B8B9C 21280000 */   addu      $a1, $zero, $zero
    /* A93A0 800B8BA0 21302002 */  addu       $a2, $s1, $zero
    /* A93A4 800B8BA4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A93A8 800B8BA8 EC314724 */  addiu      $a3, $v0, %lo(GameSetup_gData)
  .L800B8BAC:
    /* A93AC 800B8BAC 0000C48C */  lw         $a0, 0x0($a2)
    /* A93B0 800B8BB0 80100500 */  sll        $v0, $a1, 2
    /* A93B4 800B8BB4 21108200 */  addu       $v0, $a0, $v0
    /* A93B8 800B8BB8 E803838C */  lw         $v1, 0x3E8($a0)
    /* A93BC 800B8BBC 6803428C */  lw         $v0, 0x368($v0)
    /* A93C0 800B8BC0 00000000 */  nop
    /* A93C4 800B8BC4 2A184300 */  slt        $v1, $v0, $v1
    /* A93C8 800B8BC8 04006010 */  beqz       $v1, .L800B8BDC
    /* A93CC 800B8BCC 00000000 */   nop
    /* A93D0 800B8BD0 02004018 */  blez       $v0, .L800B8BDC
    /* A93D4 800B8BD4 00000000 */   nop
    /* A93D8 800B8BD8 E80382AC */  sw         $v0, 0x3E8($a0)
  .L800B8BDC:
    /* A93DC 800B8BDC 0400E28C */  lw         $v0, 0x4($a3)
    /* A93E0 800B8BE0 0100A524 */  addiu      $a1, $a1, 0x1
    /* A93E4 800B8BE4 2A10A200 */  slt        $v0, $a1, $v0
    /* A93E8 800B8BE8 F0FF4014 */  bnez       $v0, .L800B8BAC
    /* A93EC 800B8BEC 00000000 */   nop
  .L800B8BF0:
    /* A93F0 800B8BF0 B5AA030C */  jal        rand
    /* A93F4 800B8BF4 00000000 */   nop
    /* A93F8 800B8BF8 0000258E */  lw         $a1, 0x0($s1)
    /* A93FC 800B8BFC 0400838E */  lw         $v1, 0x4($s4)
    /* A9400 800B8C00 D403A48C */  lw         $a0, 0x3D4($a1)
    /* A9404 800B8C04 00000000 */  nop
    /* A9408 800B8C08 1A008300 */  div        $zero, $a0, $v1
    /* A940C 800B8C0C 02006014 */  bnez       $v1, .L800B8C18
    /* A9410 800B8C10 00000000 */   nop
    /* A9414 800B8C14 0D000700 */  break      7
  .L800B8C18:
    /* A9418 800B8C18 FFFF0124 */  addiu      $at, $zero, -0x1
    /* A941C 800B8C1C 04006114 */  bne        $v1, $at, .L800B8C30
    /* A9420 800B8C20 0080013C */   lui       $at, (0x80000000 >> 16)
    /* A9424 800B8C24 02008114 */  bne        $a0, $at, .L800B8C30
    /* A9428 800B8C28 00000000 */   nop
    /* A942C 800B8C2C 0D000600 */  break      6
  .L800B8C30:
    /* A9430 800B8C30 12200000 */  mflo       $a0
    /* A9434 800B8C34 AA2A033C */  lui        $v1, (0x2AAAAAAB >> 16)
    /* A9438 800B8C38 ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* A943C 800B8C3C 18004300 */  mult       $v0, $v1
    /* A9440 800B8C40 C3170200 */  sra        $v0, $v0, 31
    /* A9444 800B8C44 10180000 */  mfhi       $v1
    /* A9448 800B8C48 C3180300 */  sra        $v1, $v1, 3
    /* A944C 800B8C4C 23186200 */  subu       $v1, $v1, $v0
    /* A9450 800B8C50 E803A28C */  lw         $v0, 0x3E8($a1)
    /* A9454 800B8C54 23208300 */  subu       $a0, $a0, $v1
    /* A9458 800B8C58 2A108200 */  slt        $v0, $a0, $v0
    /* A945C 800B8C5C 02004010 */  beqz       $v0, .L800B8C68
    /* A9460 800B8C60 00000000 */   nop
    /* A9464 800B8C64 E803A4AC */  sw         $a0, 0x3E8($a1)
  .L800B8C68:
    /* A9468 800B8C68 0400828E */  lw         $v0, 0x4($s4)
    /* A946C 800B8C6C 00000000 */  nop
    /* A9470 800B8C70 1B004018 */  blez       $v0, .L800B8CE0
    /* A9474 800B8C74 21280000 */   addu      $a1, $zero, $zero
    /* A9478 800B8C78 21382002 */  addu       $a3, $s1, $zero
    /* A947C 800B8C7C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A9480 800B8C80 EC314824 */  addiu      $t0, $v0, %lo(GameSetup_gData)
  .L800B8C84:
    /* A9484 800B8C84 0000E38C */  lw         $v1, 0x0($a3)
    /* A9488 800B8C88 80200500 */  sll        $a0, $a1, 2
    /* A948C 800B8C8C 21186400 */  addu       $v1, $v1, $a0
    /* A9490 800B8C90 6803628C */  lw         $v0, 0x368($v1)
    /* A9494 800B8C94 00000000 */  nop
    /* A9498 800B8C98 D80362AC */  sw         $v0, 0x3D8($v1)
    /* A949C 800B8C9C 0000E68C */  lw         $a2, 0x0($a3)
    /* A94A0 800B8CA0 00000000 */  nop
    /* A94A4 800B8CA4 2120C400 */  addu       $a0, $a2, $a0
    /* A94A8 800B8CA8 D803838C */  lw         $v1, 0x3D8($a0)
    /* A94AC 800B8CAC E803C28C */  lw         $v0, 0x3E8($a2)
    /* A94B0 800B8CB0 00000000 */  nop
    /* A94B4 800B8CB4 2A106200 */  slt        $v0, $v1, $v0
    /* A94B8 800B8CB8 04004010 */  beqz       $v0, .L800B8CCC
    /* A94BC 800B8CBC 00000000 */   nop
    /* A94C0 800B8CC0 02006010 */  beqz       $v1, .L800B8CCC
    /* A94C4 800B8CC4 00000000 */   nop
    /* A94C8 800B8CC8 E803C3AC */  sw         $v1, 0x3E8($a2)
  .L800B8CCC:
    /* A94CC 800B8CCC 0400028D */  lw         $v0, 0x4($t0)
    /* A94D0 800B8CD0 0100A524 */  addiu      $a1, $a1, 0x1
    /* A94D4 800B8CD4 2A10A200 */  slt        $v0, $a1, $v0
    /* A94D8 800B8CD8 EAFF4014 */  bnez       $v0, .L800B8C84
    /* A94DC 800B8CDC 00000000 */   nop
  .L800B8CE0:
    /* A94E0 800B8CE0 04003126 */  addiu      $s1, $s1, 0x4
    /* A94E4 800B8CE4 7EE20208 */  j          .L800B89F8
    /* A94E8 800B8CE8 01005226 */   addiu     $s2, $s2, 0x1
  .L800B8CEC:
    /* A94EC 800B8CEC 27006016 */  bnez       $s3, .L800B8D8C
    /* A94F0 800B8CF0 21400000 */   addu      $t0, $zero, $zero
    /* A94F4 800B8CF4 14800C3C */  lui        $t4, %hi(Cars_gNumRaceCars)
    /* A94F8 800B8CF8 F8C78C8D */  lw         $t4, %lo(Cars_gNumRaceCars)($t4)
    /* A94FC 800B8CFC 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* A9500 800B8D00 00FA4924 */  addiu      $t1, $v0, %lo(Cars_gRaceCarList)
    /* A9504 800B8D04 21682001 */  addu       $t5, $t1, $zero
  .L800B8D08:
    /* A9508 800B8D08 2A100C01 */  slt        $v0, $t0, $t4
    /* A950C 800B8D0C 1F004010 */  beqz       $v0, .L800B8D8C
    /* A9510 800B8D10 01000624 */   addiu     $a2, $zero, 0x1
    /* A9514 800B8D14 18008019 */  blez       $t4, .L800B8D78
    /* A9518 800B8D18 21280000 */   addu      $a1, $zero, $zero
    /* A951C 800B8D1C 21582001 */  addu       $t3, $t1, $zero
    /* A9520 800B8D20 14800A3C */  lui        $t2, %hi(Cars_gNumRaceCars)
    /* A9524 800B8D24 F8C74A8D */  lw         $t2, %lo(Cars_gNumRaceCars)($t2)
    /* A9528 800B8D28 2138A001 */  addu       $a3, $t5, $zero
  .L800B8D2C:
    /* A952C 800B8D2C 0E000511 */  beq        $t0, $a1, .L800B8D68
    /* A9530 800B8D30 00000000 */   nop
    /* A9534 800B8D34 0000628D */  lw         $v0, 0x0($t3)
    /* A9538 800B8D38 0000E38C */  lw         $v1, 0x0($a3)
    /* A953C 800B8D3C D403448C */  lw         $a0, 0x3D4($v0)
    /* A9540 800B8D40 D403638C */  lw         $v1, 0x3D4($v1)
    /* A9544 800B8D44 00000000 */  nop
    /* A9548 800B8D48 2A106400 */  slt        $v0, $v1, $a0
    /* A954C 800B8D4C 05004014 */  bnez       $v0, .L800B8D64
    /* A9550 800B8D50 00000000 */   nop
    /* A9554 800B8D54 04008314 */  bne        $a0, $v1, .L800B8D68
    /* A9558 800B8D58 2A10A800 */   slt       $v0, $a1, $t0
    /* A955C 800B8D5C 02004010 */  beqz       $v0, .L800B8D68
    /* A9560 800B8D60 00000000 */   nop
  .L800B8D64:
    /* A9564 800B8D64 0100C624 */  addiu      $a2, $a2, 0x1
  .L800B8D68:
    /* A9568 800B8D68 0100A524 */  addiu      $a1, $a1, 0x1
    /* A956C 800B8D6C 2A10AA00 */  slt        $v0, $a1, $t2
    /* A9570 800B8D70 EEFF4014 */  bnez       $v0, .L800B8D2C
    /* A9574 800B8D74 0400E724 */   addiu     $a3, $a3, 0x4
  .L800B8D78:
    /* A9578 800B8D78 0000228D */  lw         $v0, 0x0($t1)
    /* A957C 800B8D7C 04002925 */  addiu      $t1, $t1, 0x4
    /* A9580 800B8D80 01000825 */  addiu      $t0, $t0, 0x1
    /* A9584 800B8D84 42E30208 */  j          .L800B8D08
    /* A9588 800B8D88 D00346AC */   sw        $a2, 0x3D0($v0)
  .L800B8D8C:
    /* A958C 800B8D8C 3000BF8F */  lw         $ra, 0x30($sp)
    /* A9590 800B8D90 2C00B78F */  lw         $s7, 0x2C($sp)
    /* A9594 800B8D94 2800B68F */  lw         $s6, 0x28($sp)
    /* A9598 800B8D98 2400B58F */  lw         $s5, 0x24($sp)
    /* A959C 800B8D9C 2000B48F */  lw         $s4, 0x20($sp)
    /* A95A0 800B8DA0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* A95A4 800B8DA4 1800B28F */  lw         $s2, 0x18($sp)
    /* A95A8 800B8DA8 1400B18F */  lw         $s1, 0x14($sp)
    /* A95AC 800B8DAC 1000B08F */  lw         $s0, 0x10($sp)
    /* A95B0 800B8DB0 0800E003 */  jr         $ra
    /* A95B4 800B8DB4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Stats_ExtrapolateOpponentTimes__Fi
