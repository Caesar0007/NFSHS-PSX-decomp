.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_TrackEndGame__Fv, 0x3A0

glabel Stats_TrackEndGame__Fv
    /* A95B8 800B8DB8 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* A95BC 800B8DBC F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* A95C0 800B8DC0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* A95C4 800B8DC4 4400BFAF */  sw         $ra, 0x44($sp)
    /* A95C8 800B8DC8 4000BEAF */  sw         $fp, 0x40($sp)
    /* A95CC 800B8DCC 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* A95D0 800B8DD0 3800B6AF */  sw         $s6, 0x38($sp)
    /* A95D4 800B8DD4 3400B5AF */  sw         $s5, 0x34($sp)
    /* A95D8 800B8DD8 3000B4AF */  sw         $s4, 0x30($sp)
    /* A95DC 800B8DDC 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* A95E0 800B8DE0 2800B2AF */  sw         $s2, 0x28($sp)
    /* A95E4 800B8DE4 2400B1AF */  sw         $s1, 0x24($sp)
    /* A95E8 800B8DE8 2000B0AF */  sw         $s0, 0x20($sp)
    /* A95EC 800B8DEC 02004228 */  slti       $v0, $v0, 0x2
    /* A95F0 800B8DF0 91004014 */  bnez       $v0, .L800B9038
    /* A95F4 800B8DF4 1000A0AF */   sw        $zero, 0x10($sp)
    /* A95F8 800B8DF8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* A95FC 800B8DFC B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* A9600 800B8E00 00000000 */  nop
    /* A9604 800B8E04 02006104 */  bgez       $v1, .L800B8E10
    /* A9608 800B8E08 21106000 */   addu      $v0, $v1, $zero
    /* A960C 800B8E0C 3F006224 */  addiu      $v0, $v1, 0x3F
  .L800B8E10:
    /* A9610 800B8E10 83110200 */  sra        $v0, $v0, 6
    /* A9614 800B8E14 80110200 */  sll        $v0, $v0, 6
    /* A9618 800B8E18 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* A961C 800B8E1C 87004314 */  bne        $v0, $v1, .L800B903C
    /* A9620 800B8E20 1280023C */   lui       $v0, %hi(D_8011E0C8)
    /* A9624 800B8E24 1180023C */  lui        $v0, %hi(D_801131F0)
    /* A9628 800B8E28 F031448C */  lw         $a0, %lo(D_801131F0)($v0)
    /* A962C 800B8E2C 1480023C */  lui        $v0, %hi(gNumSlices)
    /* A9630 800B8E30 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* A9634 800B8E34 00000000 */  nop
    /* A9638 800B8E38 18008200 */  mult       $a0, $v0
    /* A963C 800B8E3C 21300000 */  addu       $a2, $zero, $zero
    /* A9640 800B8E40 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* A9644 800B8E44 48FA7324 */  addiu      $s3, $v1, %lo(Cars_gHumanRaceCarList)
    /* A9648 800B8E48 12280000 */  mflo       $a1
  .L800B8E4C:
    /* A964C 800B8E4C 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* A9650 800B8E50 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* A9654 800B8E54 00000000 */  nop
    /* A9658 800B8E58 2A10C200 */  slt        $v0, $a2, $v0
    /* A965C 800B8E5C 77004010 */  beqz       $v0, .L800B903C
    /* A9660 800B8E60 1280023C */   lui       $v0, %hi(D_8011E0C8)
    /* A9664 800B8E64 0000648E */  lw         $a0, 0x0($s3)
    /* A9668 800B8E68 00000000 */  nop
    /* A966C 800B8E6C 5003838C */  lw         $v1, 0x350($a0)
    /* A9670 800B8E70 00000000 */  nop
    /* A9674 800B8E74 2A10A300 */  slt        $v0, $a1, $v1
    /* A9678 800B8E78 02004014 */  bnez       $v0, .L800B8E84
    /* A967C 800B8E7C 1400A5AF */   sw        $a1, 0x14($sp)
    /* A9680 800B8E80 1400A3AF */  sw         $v1, 0x14($sp)
  .L800B8E84:
    /* A9684 800B8E84 1800A5AF */  sw         $a1, 0x18($sp)
    /* A9688 800B8E88 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A968C 800B8E8C 1C00A6AF */   sw        $a2, 0x1C($sp)
    /* A9690 800B8E90 21B80000 */  addu       $s7, $zero, $zero
    /* A9694 800B8E94 21A84000 */  addu       $s5, $v0, $zero
    /* A9698 800B8E98 01000D24 */  addiu      $t5, $zero, 0x1
    /* A969C 800B8E9C 1800A58F */  lw         $a1, 0x18($sp)
    /* A96A0 800B8EA0 1C00A68F */  lw         $a2, 0x1C($sp)
    /* A96A4 800B8EA4 0E00AD16 */  bne        $s5, $t5, .L800B8EE0
    /* A96A8 800B8EA8 21A0E002 */   addu      $s4, $s7, $zero
    /* A96AC 800B8EAC BEE30208 */  j          .L800B8EF8
    /* A96B0 800B8EB0 02001224 */   addiu     $s2, $zero, 0x2
  .L800B8EB4:
    /* A96B4 800B8EB4 00FAAD25 */  addiu      $t5, $t5, %lo(Cars_gRaceCarList)
    /* A96B8 800B8EB8 2110CD02 */  addu       $v0, $s6, $t5
    /* A96BC 800B8EBC 0000428C */  lw         $v0, 0x0($v0)
    /* A96C0 800B8EC0 00000000 */  nop
    /* A96C4 800B8EC4 2004428C */  lw         $v0, 0x420($v0)
    /* A96C8 800B8EC8 00000000 */  nop
    /* A96CC 800B8ECC 02004104 */  bgez       $v0, .L800B8ED8
    /* A96D0 800B8ED0 00000000 */   nop
    /* A96D4 800B8ED4 23100200 */  negu       $v0, $v0
  .L800B8ED8:
    /* A96D8 800B8ED8 E3E30208 */  j          .L800B8F8C
    /* A96DC 800B8EDC 03A40200 */   sra       $s4, $v0, 16
  .L800B8EE0:
    /* A96E0 800B8EE0 1180023C */  lui        $v0, %hi(D_801132A8)
    /* A96E4 800B8EE4 A832428C */  lw         $v0, %lo(D_801132A8)($v0)
    /* A96E8 800B8EE8 01001224 */  addiu      $s2, $zero, 0x1
    /* A96EC 800B8EEC 03005210 */  beq        $v0, $s2, .L800B8EFC
    /* A96F0 800B8EF0 21880000 */   addu      $s1, $zero, $zero
    /* A96F4 800B8EF4 FFFFB226 */  addiu      $s2, $s5, -0x1
  .L800B8EF8:
    /* A96F8 800B8EF8 21880000 */  addu       $s1, $zero, $zero
  .L800B8EFC:
    /* A96FC 800B8EFC 21F06002 */  addu       $fp, $s3, $zero
    /* A9700 800B8F00 1180103C */  lui        $s0, %hi(Cars_gRaceCarList)
    /* A9704 800B8F04 00FA1026 */  addiu      $s0, $s0, %lo(Cars_gRaceCarList)
  .L800B8F08:
    /* A9708 800B8F08 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* A970C 800B8F0C F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* A9710 800B8F10 00000000 */  nop
    /* A9714 800B8F14 2A102202 */  slt        $v0, $s1, $v0
    /* A9718 800B8F18 1C004010 */  beqz       $v0, .L800B8F8C
    /* A971C 800B8F1C 80B01100 */   sll       $s6, $s1, 2
    /* A9720 800B8F20 0000048E */  lw         $a0, 0x0($s0)
    /* A9724 800B8F24 1800A5AF */  sw         $a1, 0x18($sp)
    /* A9728 800B8F28 55E0020C */  jal        Stats_GetPosition__FP8Car_tObj
    /* A972C 800B8F2C 1C00A6AF */   sw        $a2, 0x1C($sp)
    /* A9730 800B8F30 1800A58F */  lw         $a1, 0x18($sp)
    /* A9734 800B8F34 1C00A68F */  lw         $a2, 0x1C($sp)
    /* A9738 800B8F38 11005214 */  bne        $v0, $s2, .L800B8F80
    /* A973C 800B8F3C 00000000 */   nop
    /* A9740 800B8F40 0000028E */  lw         $v0, 0x0($s0)
    /* A9744 800B8F44 00000000 */  nop
    /* A9748 800B8F48 5003438C */  lw         $v1, 0x350($v0)
    /* A974C 800B8F4C 00000000 */  nop
    /* A9750 800B8F50 2A10A300 */  slt        $v0, $a1, $v1
    /* A9754 800B8F54 02004014 */  bnez       $v0, .L800B8F60
    /* A9758 800B8F58 21B8A000 */   addu      $s7, $a1, $zero
    /* A975C 800B8F5C 21B86000 */  addu       $s7, $v1, $zero
  .L800B8F60:
    /* A9760 800B8F60 01000D24 */  addiu      $t5, $zero, 0x1
    /* A9764 800B8F64 D3FFAD12 */  beq        $s5, $t5, .L800B8EB4
    /* A9768 800B8F68 11800D3C */   lui       $t5, %hi(Cars_gRaceCarList)
    /* A976C 800B8F6C 0000C28F */  lw         $v0, 0x0($fp)
    /* A9770 800B8F70 00000000 */  nop
    /* A9774 800B8F74 22045484 */  lh         $s4, 0x422($v0)
    /* A9778 800B8F78 E3E30208 */  j          .L800B8F8C
    /* A977C 800B8F7C 00000000 */   nop
  .L800B8F80:
    /* A9780 800B8F80 04001026 */  addiu      $s0, $s0, 0x4
    /* A9784 800B8F84 C2E30208 */  j          .L800B8F08
    /* A9788 800B8F88 01003126 */   addiu     $s1, $s1, 0x1
  .L800B8F8C:
    /* A978C 800B8F8C 1400AD8F */  lw         $t5, 0x14($sp)
    /* A9790 800B8F90 0000628E */  lw         $v0, 0x0($s3)
    /* A9794 800B8F94 2318ED02 */  subu       $v1, $s7, $t5
    /* A9798 800B8F98 980343AC */  sw         $v1, 0x398($v0)
    /* A979C 800B8F9C 1000822A */  slti       $v0, $s4, 0x10
    /* A97A0 800B8FA0 1C004014 */  bnez       $v0, .L800B9014
    /* A97A4 800B8FA4 02000224 */   addiu     $v0, $zero, 0x2
    /* A97A8 800B8FA8 0000648E */  lw         $a0, 0x0($s3)
    /* A97AC 800B8FAC 00000000 */  nop
    /* A97B0 800B8FB0 9003838C */  lw         $v1, 0x390($a0)
    /* A97B4 800B8FB4 00000000 */  nop
    /* A97B8 800B8FB8 16006210 */  beq        $v1, $v0, .L800B9014
    /* A97BC 800B8FBC 01000D24 */   addiu     $t5, $zero, 0x1
    /* A97C0 800B8FC0 9803838C */  lw         $v1, 0x398($a0)
    /* A97C4 800B8FC4 00000000 */  nop
    /* A97C8 800B8FC8 40100300 */  sll        $v0, $v1, 1
    /* A97CC 800B8FCC 21104300 */  addu       $v0, $v0, $v1
    /* A97D0 800B8FD0 C0110200 */  sll        $v0, $v0, 7
    /* A97D4 800B8FD4 1A005400 */  div        $zero, $v0, $s4
    /* A97D8 800B8FD8 02008016 */  bnez       $s4, .L800B8FE4
    /* A97DC 800B8FDC 00000000 */   nop
    /* A97E0 800B8FE0 0D000700 */  break      7
  .L800B8FE4:
    /* A97E4 800B8FE4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* A97E8 800B8FE8 04008116 */  bne        $s4, $at, .L800B8FFC
    /* A97EC 800B8FEC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* A97F0 800B8FF0 02004114 */  bne        $v0, $at, .L800B8FFC
    /* A97F4 800B8FF4 00000000 */   nop
    /* A97F8 800B8FF8 0D000600 */  break      6
  .L800B8FFC:
    /* A97FC 800B8FFC 12100000 */  mflo       $v0
    /* A9800 800B9000 00000000 */  nop
    /* A9804 800B9004 940382AC */  sw         $v0, 0x394($a0)
    /* A9808 800B9008 0000628E */  lw         $v0, 0x0($s3)
    /* A980C 800B900C 0BE40208 */  j          .L800B902C
    /* A9810 800B9010 9C034DAC */   sw        $t5, 0x39C($v0)
  .L800B9014:
    /* A9814 800B9014 0000628E */  lw         $v0, 0x0($s3)
    /* A9818 800B9018 00000000 */  nop
    /* A981C 800B901C 940340AC */  sw         $zero, 0x394($v0)
    /* A9820 800B9020 0000628E */  lw         $v0, 0x0($s3)
    /* A9824 800B9024 00000000 */  nop
    /* A9828 800B9028 9C0340AC */  sw         $zero, 0x39C($v0)
  .L800B902C:
    /* A982C 800B902C 04007326 */  addiu      $s3, $s3, 0x4
    /* A9830 800B9030 93E30208 */  j          .L800B8E4C
    /* A9834 800B9034 0100C624 */   addiu     $a2, $a2, 0x1
  .L800B9038:
    /* A9838 800B9038 1280023C */  lui        $v0, %hi(D_8011E0C8)
  .L800B903C:
    /* A983C 800B903C C8E0428C */  lw         $v0, %lo(D_8011E0C8)($v0)
    /* A9840 800B9040 00000000 */  nop
    /* A9844 800B9044 38004014 */  bnez       $v0, .L800B9128
    /* A9848 800B9048 00000000 */   nop
    /* A984C 800B904C 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* A9850 800B9050 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* A9854 800B9054 00000000 */  nop
    /* A9858 800B9058 29006018 */  blez       $v1, .L800B9100
    /* A985C 800B905C 21300000 */   addu      $a2, $zero, $zero
    /* A9860 800B9060 1280023C */  lui        $v0, %hi(simGlobal)
    /* A9864 800B9064 ACE04C24 */  addiu      $t4, $v0, %lo(simGlobal)
    /* A9868 800B9068 FFFF0B24 */  addiu      $t3, $zero, -0x1
    /* A986C 800B906C 21506000 */  addu       $t2, $v1, $zero
    /* A9870 800B9070 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* A9874 800B9074 48FA4524 */  addiu      $a1, $v0, %lo(Cars_gHumanRaceCarList)
    /* A9878 800B9078 1480093C */  lui        $t1, %hi(CopSpeak_gQueuePlay)
    /* A987C 800B907C CCD0298D */  lw         $t1, %lo(CopSpeak_gQueuePlay)($t1)
    /* A9880 800B9080 1480083C */  lui        $t0, %hi(CopSpeak_gQueueHead)
    /* A9884 800B9084 C8D0088D */  lw         $t0, %lo(CopSpeak_gQueueHead)($t0)
    /* A9888 800B9088 1480073C */  lui        $a3, %hi(CopSpeak_gSpchHandle)
    /* A988C 800B908C D0D0E78C */  lw         $a3, %lo(CopSpeak_gSpchHandle)($a3)
  .L800B9090:
    /* A9890 800B9090 0000A38C */  lw         $v1, 0x0($a1)
    /* A9894 800B9094 00000000 */  nop
    /* A9898 800B9098 9003628C */  lw         $v0, 0x390($v1)
    /* A989C 800B909C 00000000 */  nop
    /* A98A0 800B90A0 02004228 */  slti       $v0, $v0, 0x2
    /* A98A4 800B90A4 12004014 */  bnez       $v0, .L800B90F0
    /* A98A8 800B90A8 00000000 */   nop
    /* A98AC 800B90AC 5403638C */  lw         $v1, 0x354($v1)
    /* A98B0 800B90B0 0400848D */  lw         $a0, 0x4($t4)
    /* A98B4 800B90B4 40016224 */  addiu      $v0, $v1, 0x140
    /* A98B8 800B90B8 2A104400 */  slt        $v0, $v0, $a0
    /* A98BC 800B90BC 0C004010 */  beqz       $v0, .L800B90F0
    /* A98C0 800B90C0 00000000 */   nop
    /* A98C4 800B90C4 03002815 */  bne        $t1, $t0, .L800B90D4
    /* A98C8 800B90C8 80026224 */   addiu     $v0, $v1, 0x280
    /* A98CC 800B90CC 0400EB10 */  beq        $a3, $t3, .L800B90E0
    /* A98D0 800B90D0 00000000 */   nop
  .L800B90D4:
    /* A98D4 800B90D4 2A104400 */  slt        $v0, $v0, $a0
    /* A98D8 800B90D8 05004010 */  beqz       $v0, .L800B90F0
    /* A98DC 800B90DC 00000000 */   nop
  .L800B90E0:
    /* A98E0 800B90E0 1000AD8F */  lw         $t5, 0x10($sp)
    /* A98E4 800B90E4 00000000 */  nop
    /* A98E8 800B90E8 0100AD25 */  addiu      $t5, $t5, 0x1
    /* A98EC 800B90EC 1000ADAF */  sw         $t5, 0x10($sp)
  .L800B90F0:
    /* A98F0 800B90F0 0100C624 */  addiu      $a2, $a2, 0x1
    /* A98F4 800B90F4 2A10CA00 */  slt        $v0, $a2, $t2
    /* A98F8 800B90F8 E5FF4014 */  bnez       $v0, .L800B9090
    /* A98FC 800B90FC 0400A524 */   addiu     $a1, $a1, 0x4
  .L800B9100:
    /* A9900 800B9100 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* A9904 800B9104 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* A9908 800B9108 1000AD8F */  lw         $t5, 0x10($sp)
    /* A990C 800B910C 00000000 */  nop
    /* A9910 800B9110 0500A215 */  bne        $t5, $v0, .L800B9128
    /* A9914 800B9114 1280033C */   lui       $v1, %hi(D_8011E0C8)
    /* A9918 800B9118 01000224 */  addiu      $v0, $zero, 0x1
    /* A991C 800B911C C8E062AC */  sw         $v0, %lo(D_8011E0C8)($v1)
    /* A9920 800B9120 81E1020C */  jal        Stats_ExtrapolateOpponentTimes__Fi
    /* A9924 800B9124 02000424 */   addiu     $a0, $zero, 0x2
  .L800B9128:
    /* A9928 800B9128 4400BF8F */  lw         $ra, 0x44($sp)
    /* A992C 800B912C 4000BE8F */  lw         $fp, 0x40($sp)
    /* A9930 800B9130 3C00B78F */  lw         $s7, 0x3C($sp)
    /* A9934 800B9134 3800B68F */  lw         $s6, 0x38($sp)
    /* A9938 800B9138 3400B58F */  lw         $s5, 0x34($sp)
    /* A993C 800B913C 3000B48F */  lw         $s4, 0x30($sp)
    /* A9940 800B9140 2C00B38F */  lw         $s3, 0x2C($sp)
    /* A9944 800B9144 2800B28F */  lw         $s2, 0x28($sp)
    /* A9948 800B9148 2400B18F */  lw         $s1, 0x24($sp)
    /* A994C 800B914C 2000B08F */  lw         $s0, 0x20($sp)
    /* A9950 800B9150 0800E003 */  jr         $ra
    /* A9954 800B9154 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Stats_TrackEndGame__Fv
