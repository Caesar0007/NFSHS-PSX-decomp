.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo, 0x6C8

glabel DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
    /* B8D08 800C8508 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* B8D0C 800C850C 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* B8D10 800C8510 7800BEAF */  sw         $fp, 0x78($sp)
    /* B8D14 800C8514 7400B7AF */  sw         $s7, 0x74($sp)
    /* B8D18 800C8518 7000B6AF */  sw         $s6, 0x70($sp)
    /* B8D1C 800C851C 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* B8D20 800C8520 6800B4AF */  sw         $s4, 0x68($sp)
    /* B8D24 800C8524 6400B3AF */  sw         $s3, 0x64($sp)
    /* B8D28 800C8528 6000B2AF */  sw         $s2, 0x60($sp)
    /* B8D2C 800C852C 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* B8D30 800C8530 5800B0AF */  sw         $s0, 0x58($sp)
    /* B8D34 800C8534 8000A4AF */  sw         $a0, 0x80($sp)
    /* B8D38 800C8538 0400A28C */  lw         $v0, 0x4($a1)
    /* B8D3C 800C853C 0000A88C */  lw         $t0, 0x0($a1)
    /* B8D40 800C8540 04005424 */  addiu      $s4, $v0, 0x4
    /* B8D44 800C8544 4800A8AF */  sw         $t0, 0x48($sp)
    /* B8D48 800C8548 0000428C */  lw         $v0, 0x0($v0)
    /* B8D4C 800C854C 00000000 */  nop
    /* B8D50 800C8550 5000A2AF */  sw         $v0, 0x50($sp)
    /* B8D54 800C8554 0800A58C */  lw         $a1, 0x8($a1)
    /* B8D58 800C8558 21B80000 */  addu       $s7, $zero, $zero
    /* B8D5C 800C855C 8F014010 */  beqz       $v0, .L800C8B9C
    /* B8D60 800C8560 4C00A5AF */   sw        $a1, 0x4C($sp)
    /* B8D64 800C8564 801F023C */  lui        $v0, (0x1F800014 >> 16)
    /* B8D68 800C8568 14004234 */  ori        $v0, $v0, (0x1F800014 & 0xFFFF)
    /* B8D6C 800C856C 801F093C */  lui        $t1, (0x1F800014 >> 16)
    /* B8D70 800C8570 14002935 */  ori        $t1, $t1, (0x1F800014 & 0xFFFF)
    /* B8D74 800C8574 1C0040AC */  sw         $zero, 0x1C($v0)
    /* B8D78 800C8578 180040AC */  sw         $zero, 0x18($v0)
    /* B8D7C 800C857C 801F013C */  lui        $at, (0x1F800028 >> 16)
    /* B8D80 800C8580 280020AC */  sw         $zero, (0x1F800028 & 0xFFFF)($at)
    /* B8D84 800C8584 14002C8D */  lw         $t4, 0x14($t1)
    /* B8D88 800C8588 18002D8D */  lw         $t5, 0x18($t1)
    /* B8D8C 800C858C 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B8D90 800C8590 1C002E8D */  lw         $t6, 0x1C($t1)
    /* B8D94 800C8594 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B8D98 800C8598 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B8D9C 800C859C 5400A0AF */  sw         $zero, 0x54($sp)
  .L800C85A0:
    /* B8DA0 800C85A0 5400A88F */  lw         $t0, 0x54($sp)
    /* B8DA4 800C85A4 5000A98F */  lw         $t1, 0x50($sp)
    /* B8DA8 800C85A8 00000000 */  nop
    /* B8DAC 800C85AC 2A100901 */  slt        $v0, $t0, $t1
    /* B8DB0 800C85B0 7B014010 */  beqz       $v0, .L800C8BA0
    /* B8DB4 800C85B4 2110E002 */   addu      $v0, $s7, $zero
    /* B8DB8 800C85B8 1480023C */  lui        $v0, %hi(D_8013D820)
    /* B8DBC 800C85BC 20D84224 */  addiu      $v0, $v0, %lo(D_8013D820)
    /* B8DC0 800C85C0 04008392 */  lbu        $v1, 0x4($s4)
    /* B8DC4 800C85C4 02009092 */  lbu        $s0, 0x2($s4)
    /* B8DC8 800C85C8 21186200 */  addu       $v1, $v1, $v0
    /* B8DCC 800C85CC 80000232 */  andi       $v0, $s0, 0x80
    /* B8DD0 800C85D0 00007E80 */  lb         $fp, 0x0($v1)
    /* B8DD4 800C85D4 6C014014 */  bnez       $v0, .L800C8B88
    /* B8DD8 800C85D8 05000224 */   addiu     $v0, $zero, 0x5
    /* B8DDC 800C85DC 10000212 */  beq        $s0, $v0, .L800C8620
    /* B8DE0 800C85E0 00040224 */   addiu     $v0, $zero, 0x400
    /* B8DE4 800C85E4 4C00A88F */  lw         $t0, 0x4C($sp)
    /* B8DE8 800C85E8 00000000 */  nop
    /* B8DEC 800C85EC 0C000011 */  beqz       $t0, .L800C8620
    /* B8DF0 800C85F0 08008626 */   addiu     $a2, $s4, 0x8
    /* B8DF4 800C85F4 8000A48F */  lw         $a0, 0x80($sp)
    /* B8DF8 800C85F8 06008586 */  lh         $a1, 0x6($s4)
    /* B8DFC 800C85FC F422030C */  jal        ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
    /* B8E00 800C8600 801F073C */   lui       $a3, (0x1F800000 >> 16)
    /* B8E04 800C8604 05004010 */  beqz       $v0, .L800C861C
    /* B8E08 800C8608 02000224 */   addiu     $v0, $zero, 0x2
    /* B8E0C 800C860C 02008392 */  lbu        $v1, 0x2($s4)
    /* B8E10 800C8610 00000000 */  nop
    /* B8E14 800C8614 5B016214 */  bne        $v1, $v0, .L800C8B84
    /* B8E18 800C8618 00000000 */   nop
  .L800C861C:
    /* B8E1C 800C861C 00040224 */  addiu      $v0, $zero, 0x400
  .L800C8620:
    /* B8E20 800C8620 801F013C */  lui        $at, (0x1F800148 >> 16)
    /* B8E24 800C8624 480122A4 */  sh         $v0, (0x1F800148 & 0xFFFF)($at)
    /* B8E28 800C8628 05008292 */  lbu        $v0, 0x5($s4)
    /* B8E2C 800C862C 00000000 */  nop
    /* B8E30 800C8630 01004230 */  andi       $v0, $v0, 0x1
    /* B8E34 800C8634 52004010 */  beqz       $v0, .L800C8780
    /* B8E38 800C8638 FFFF1124 */   addiu     $s1, $zero, -0x1
    /* B8E3C 800C863C 0800838E */  lw         $v1, 0x8($s4)
    /* B8E40 800C8640 8000A98F */  lw         $t1, 0x80($sp)
    /* B8E44 800C8644 1000828E */  lw         $v0, 0x10($s4)
    /* B8E48 800C8648 0800248D */  lw         $a0, 0x8($t1)
    /* B8E4C 800C864C 1000258D */  lw         $a1, 0x10($t1)
    /* B8E50 800C8650 23206400 */  subu       $a0, $v1, $a0
    /* B8E54 800C8654 4AB5030C */  jal        fixedatan
    /* B8E58 800C8658 23284500 */   subu      $a1, $v0, $a1
    /* B8E5C 800C865C 2000A427 */  addiu      $a0, $sp, 0x20
    /* B8E60 800C8660 04AB030C */  jal        fixedxformy
    /* B8E64 800C8664 21284000 */   addu      $a1, $v0, $zero
    /* B8E68 800C8668 FF000332 */  andi       $v1, $s0, 0xFF
    /* B8E6C 800C866C 09000224 */  addiu      $v0, $zero, 0x9
    /* B8E70 800C8670 32006214 */  bne        $v1, $v0, .L800C873C
    /* B8E74 800C8674 00000000 */   nop
    /* B8E78 800C8678 18009086 */  lh         $s0, 0x18($s4)
    /* B8E7C 800C867C 2000A48F */  lw         $a0, 0x20($sp)
    /* B8E80 800C8680 16009186 */  lh         $s1, 0x16($s4)
    /* B8E84 800C8684 00821000 */  sll        $s0, $s0, 8
    /* B8E88 800C8688 21280002 */  addu       $a1, $s0, $zero
    /* B8E8C 800C868C CA90030C */  jal        fixedmult
    /* B8E90 800C8690 008A1100 */   sll       $s1, $s1, 8
    /* B8E94 800C8694 21984000 */  addu       $s3, $v0, $zero
    /* B8E98 800C8698 2C00A48F */  lw         $a0, 0x2C($sp)
    /* B8E9C 800C869C CA90030C */  jal        fixedmult
    /* B8EA0 800C86A0 21280002 */   addu      $a1, $s0, $zero
    /* B8EA4 800C86A4 21904000 */  addu       $s2, $v0, $zero
    /* B8EA8 800C86A8 3800A48F */  lw         $a0, 0x38($sp)
    /* B8EAC 800C86AC CA90030C */  jal        fixedmult
    /* B8EB0 800C86B0 21280002 */   addu      $a1, $s0, $zero
    /* B8EB4 800C86B4 2400A48F */  lw         $a0, 0x24($sp)
    /* B8EB8 800C86B8 21282002 */  addu       $a1, $s1, $zero
    /* B8EBC 800C86BC 2000B3AF */  sw         $s3, 0x20($sp)
    /* B8EC0 800C86C0 2C00B2AF */  sw         $s2, 0x2C($sp)
    /* B8EC4 800C86C4 CA90030C */  jal        fixedmult
    /* B8EC8 800C86C8 3800A2AF */   sw        $v0, 0x38($sp)
    /* B8ECC 800C86CC 21984000 */  addu       $s3, $v0, $zero
    /* B8ED0 800C86D0 3000A48F */  lw         $a0, 0x30($sp)
    /* B8ED4 800C86D4 CA90030C */  jal        fixedmult
    /* B8ED8 800C86D8 21282002 */   addu      $a1, $s1, $zero
    /* B8EDC 800C86DC 21904000 */  addu       $s2, $v0, $zero
    /* B8EE0 800C86E0 3C00A48F */  lw         $a0, 0x3C($sp)
    /* B8EE4 800C86E4 CA90030C */  jal        fixedmult
    /* B8EE8 800C86E8 21282002 */   addu      $a1, $s1, $zero
    /* B8EEC 800C86EC 2800A48F */  lw         $a0, 0x28($sp)
    /* B8EF0 800C86F0 21280002 */  addu       $a1, $s0, $zero
    /* B8EF4 800C86F4 2400B3AF */  sw         $s3, 0x24($sp)
    /* B8EF8 800C86F8 3000B2AF */  sw         $s2, 0x30($sp)
    /* B8EFC 800C86FC CA90030C */  jal        fixedmult
    /* B8F00 800C8700 3C00A2AF */   sw        $v0, 0x3C($sp)
    /* B8F04 800C8704 21984000 */  addu       $s3, $v0, $zero
    /* B8F08 800C8708 3400A48F */  lw         $a0, 0x34($sp)
    /* B8F0C 800C870C CA90030C */  jal        fixedmult
    /* B8F10 800C8710 21280002 */   addu      $a1, $s0, $zero
    /* B8F14 800C8714 21904000 */  addu       $s2, $v0, $zero
    /* B8F18 800C8718 4000A48F */  lw         $a0, 0x40($sp)
    /* B8F1C 800C871C CA90030C */  jal        fixedmult
    /* B8F20 800C8720 21280002 */   addu      $a1, $s0, $zero
    /* B8F24 800C8724 2800B3AF */  sw         $s3, 0x28($sp)
    /* B8F28 800C8728 3400B2AF */  sw         $s2, 0x34($sp)
    /* B8F2C 800C872C 4000A2AF */  sw         $v0, 0x40($sp)
    /* B8F30 800C8730 1A009196 */  lhu        $s1, 0x1A($s4)
    /* B8F34 800C8734 801F013C */  lui        $at, (0x1F800148 >> 16)
    /* B8F38 800C8738 480120A4 */  sh         $zero, (0x1F800148 & 0xFFFF)($at)
  .L800C873C:
    /* B8F3C 800C873C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* B8F40 800C8740 2000A627 */  addiu      $a2, $sp, 0x20
    /* B8F44 800C8744 8000A48F */  lw         $a0, 0x80($sp)
    /* B8F48 800C8748 06008286 */  lh         $v0, 0x6($s4)
    /* B8F4C 800C874C 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B8F50 800C8750 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B8F54 800C8754 80100200 */  sll        $v0, $v0, 2
    /* B8F58 800C8758 21104300 */  addu       $v0, $v0, $v1
    /* B8F5C 800C875C 0000568C */  lw         $s6, 0x0($v0)
    /* B8F60 800C8760 08008226 */  addiu      $v0, $s4, 0x8
    /* B8F64 800C8764 1000A2AF */  sw         $v0, 0x10($sp)
    /* B8F68 800C8768 00141100 */  sll        $v0, $s1, 16
    /* B8F6C 800C876C 03140200 */  sra        $v0, $v0, 16
    /* B8F70 800C8770 1400BEAF */  sw         $fp, 0x14($sp)
    /* B8F74 800C8774 1800A2AF */  sw         $v0, 0x18($sp)
    /* B8F78 800C8778 CD220308 */  j          .L800C8B34
    /* B8F7C 800C877C 2138C002 */   addu      $a3, $s6, $zero
  .L800C8780:
    /* B8F80 800C8780 FF000332 */  andi       $v1, $s0, 0xFF
    /* B8F84 800C8784 02000224 */  addiu      $v0, $zero, 0x2
    /* B8F88 800C8788 1B006210 */  beq        $v1, $v0, .L800C87F8
    /* B8F8C 800C878C 03006228 */   slti      $v0, $v1, 0x3
    /* B8F90 800C8790 05004010 */  beqz       $v0, .L800C87A8
    /* B8F94 800C8794 01000224 */   addiu     $v0, $zero, 0x1
    /* B8F98 800C8798 0A006210 */  beq        $v1, $v0, .L800C87C4
    /* B8F9C 800C879C 801F053C */   lui       $a1, (0x1F800000 >> 16)
    /* B8FA0 800C87A0 E1220308 */  j          .L800C8B84
    /* B8FA4 800C87A4 00000000 */   nop
  .L800C87A8:
    /* B8FA8 800C87A8 05000224 */  addiu      $v0, $zero, 0x5
    /* B8FAC 800C87AC 96006210 */  beq        $v1, $v0, .L800C8A08
    /* B8FB0 800C87B0 09000224 */   addiu     $v0, $zero, 0x9
    /* B8FB4 800C87B4 52006210 */  beq        $v1, $v0, .L800C8900
    /* B8FB8 800C87B8 00000000 */   nop
    /* B8FBC 800C87BC E1220308 */  j          .L800C8B84
    /* B8FC0 800C87C0 00000000 */   nop
  .L800C87C4:
    /* B8FC4 800C87C4 8000A48F */  lw         $a0, 0x80($sp)
    /* B8FC8 800C87C8 06008286 */  lh         $v0, 0x6($s4)
    /* B8FCC 800C87CC 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B8FD0 800C87D0 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B8FD4 800C87D4 80100200 */  sll        $v0, $v0, 2
    /* B8FD8 800C87D8 21104300 */  addu       $v0, $v0, $v1
    /* B8FDC 800C87DC 0000568C */  lw         $s6, 0x0($v0)
    /* B8FE0 800C87E0 08008726 */  addiu      $a3, $s4, 0x8
    /* B8FE4 800C87E4 1000BEAF */  sw         $fp, 0x10($sp)
    /* B8FE8 800C87E8 8520030C */  jal        DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi
    /* B8FEC 800C87EC 2130C002 */   addu      $a2, $s6, $zero
    /* B8FF0 800C87F0 E1220308 */  j          .L800C8B84
    /* B8FF4 800C87F4 21B8E202 */   addu      $s7, $s7, $v0
  .L800C87F8:
    /* B8FF8 800C87F8 14008426 */  addiu      $a0, $s4, 0x14
    /* B8FFC 800C87FC E0B5020C */  jal        Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* B9000 800C8800 2000A527 */   addiu     $a1, $sp, 0x20
    /* B9004 800C8804 1C009086 */  lh         $s0, 0x1C($s4)
    /* B9008 800C8808 2000A48F */  lw         $a0, 0x20($sp)
    /* B900C 800C880C 1E009186 */  lh         $s1, 0x1E($s4)
    /* B9010 800C8810 20009286 */  lh         $s2, 0x20($s4)
    /* B9014 800C8814 00821000 */  sll        $s0, $s0, 8
    /* B9018 800C8818 21280002 */  addu       $a1, $s0, $zero
    /* B901C 800C881C 008A1100 */  sll        $s1, $s1, 8
    /* B9020 800C8820 CA90030C */  jal        fixedmult
    /* B9024 800C8824 00921200 */   sll       $s2, $s2, 8
    /* B9028 800C8828 21A84000 */  addu       $s5, $v0, $zero
    /* B902C 800C882C 2C00A48F */  lw         $a0, 0x2C($sp)
    /* B9030 800C8830 CA90030C */  jal        fixedmult
    /* B9034 800C8834 21280002 */   addu      $a1, $s0, $zero
    /* B9038 800C8838 21984000 */  addu       $s3, $v0, $zero
    /* B903C 800C883C 3800A48F */  lw         $a0, 0x38($sp)
    /* B9040 800C8840 CA90030C */  jal        fixedmult
    /* B9044 800C8844 21280002 */   addu      $a1, $s0, $zero
    /* B9048 800C8848 2400A48F */  lw         $a0, 0x24($sp)
    /* B904C 800C884C 21282002 */  addu       $a1, $s1, $zero
    /* B9050 800C8850 2000B5AF */  sw         $s5, 0x20($sp)
    /* B9054 800C8854 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B9058 800C8858 CA90030C */  jal        fixedmult
    /* B905C 800C885C 3800A2AF */   sw        $v0, 0x38($sp)
    /* B9060 800C8860 21A84000 */  addu       $s5, $v0, $zero
    /* B9064 800C8864 3000A48F */  lw         $a0, 0x30($sp)
    /* B9068 800C8868 CA90030C */  jal        fixedmult
    /* B906C 800C886C 21282002 */   addu      $a1, $s1, $zero
    /* B9070 800C8870 21984000 */  addu       $s3, $v0, $zero
    /* B9074 800C8874 3C00A48F */  lw         $a0, 0x3C($sp)
    /* B9078 800C8878 CA90030C */  jal        fixedmult
    /* B907C 800C887C 21282002 */   addu      $a1, $s1, $zero
    /* B9080 800C8880 2800A48F */  lw         $a0, 0x28($sp)
    /* B9084 800C8884 21284002 */  addu       $a1, $s2, $zero
    /* B9088 800C8888 2400B5AF */  sw         $s5, 0x24($sp)
    /* B908C 800C888C 3000B3AF */  sw         $s3, 0x30($sp)
    /* B9090 800C8890 CA90030C */  jal        fixedmult
    /* B9094 800C8894 3C00A2AF */   sw        $v0, 0x3C($sp)
    /* B9098 800C8898 21A84000 */  addu       $s5, $v0, $zero
    /* B909C 800C889C 3400A48F */  lw         $a0, 0x34($sp)
    /* B90A0 800C88A0 CA90030C */  jal        fixedmult
    /* B90A4 800C88A4 21284002 */   addu      $a1, $s2, $zero
    /* B90A8 800C88A8 21984000 */  addu       $s3, $v0, $zero
    /* B90AC 800C88AC 4000A48F */  lw         $a0, 0x40($sp)
    /* B90B0 800C88B0 CA90030C */  jal        fixedmult
    /* B90B4 800C88B4 21284002 */   addu      $a1, $s2, $zero
    /* B90B8 800C88B8 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* B90BC 800C88BC 8000A48F */  lw         $a0, 0x80($sp)
    /* B90C0 800C88C0 2000A627 */  addiu      $a2, $sp, 0x20
    /* B90C4 800C88C4 2800B5AF */  sw         $s5, 0x28($sp)
    /* B90C8 800C88C8 3400B3AF */  sw         $s3, 0x34($sp)
    /* B90CC 800C88CC 4000A2AF */  sw         $v0, 0x40($sp)
    /* B90D0 800C88D0 06008286 */  lh         $v0, 0x6($s4)
    /* B90D4 800C88D4 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B90D8 800C88D8 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B90DC 800C88DC 80100200 */  sll        $v0, $v0, 2
    /* B90E0 800C88E0 21104300 */  addu       $v0, $v0, $v1
    /* B90E4 800C88E4 0000568C */  lw         $s6, 0x0($v0)
    /* B90E8 800C88E8 08008226 */  addiu      $v0, $s4, 0x8
    /* B90EC 800C88EC 1000A2AF */  sw         $v0, 0x10($sp)
    /* B90F0 800C88F0 1400BEAF */  sw         $fp, 0x14($sp)
    /* B90F4 800C88F4 22008286 */  lh         $v0, 0x22($s4)
    /* B90F8 800C88F8 CC220308 */  j          .L800C8B30
    /* B90FC 800C88FC 2138C002 */   addu      $a3, $s6, $zero
  .L800C8900:
    /* B9100 800C8900 14008586 */  lh         $a1, 0x14($s4)
    /* B9104 800C8904 B196030C */  jal        xformy
    /* B9108 800C8908 2000A427 */   addiu     $a0, $sp, 0x20
    /* B910C 800C890C 18009086 */  lh         $s0, 0x18($s4)
    /* B9110 800C8910 2000A48F */  lw         $a0, 0x20($sp)
    /* B9114 800C8914 16009186 */  lh         $s1, 0x16($s4)
    /* B9118 800C8918 00821000 */  sll        $s0, $s0, 8
    /* B911C 800C891C 21280002 */  addu       $a1, $s0, $zero
    /* B9120 800C8920 CA90030C */  jal        fixedmult
    /* B9124 800C8924 008A1100 */   sll       $s1, $s1, 8
    /* B9128 800C8928 21984000 */  addu       $s3, $v0, $zero
    /* B912C 800C892C 2C00A48F */  lw         $a0, 0x2C($sp)
    /* B9130 800C8930 CA90030C */  jal        fixedmult
    /* B9134 800C8934 21280002 */   addu      $a1, $s0, $zero
    /* B9138 800C8938 21904000 */  addu       $s2, $v0, $zero
    /* B913C 800C893C 3800A48F */  lw         $a0, 0x38($sp)
    /* B9140 800C8940 CA90030C */  jal        fixedmult
    /* B9144 800C8944 21280002 */   addu      $a1, $s0, $zero
    /* B9148 800C8948 2400A48F */  lw         $a0, 0x24($sp)
    /* B914C 800C894C 21282002 */  addu       $a1, $s1, $zero
    /* B9150 800C8950 2000B3AF */  sw         $s3, 0x20($sp)
    /* B9154 800C8954 2C00B2AF */  sw         $s2, 0x2C($sp)
    /* B9158 800C8958 CA90030C */  jal        fixedmult
    /* B915C 800C895C 3800A2AF */   sw        $v0, 0x38($sp)
    /* B9160 800C8960 21984000 */  addu       $s3, $v0, $zero
    /* B9164 800C8964 3000A48F */  lw         $a0, 0x30($sp)
    /* B9168 800C8968 CA90030C */  jal        fixedmult
    /* B916C 800C896C 21282002 */   addu      $a1, $s1, $zero
    /* B9170 800C8970 21904000 */  addu       $s2, $v0, $zero
    /* B9174 800C8974 3C00A48F */  lw         $a0, 0x3C($sp)
    /* B9178 800C8978 CA90030C */  jal        fixedmult
    /* B917C 800C897C 21282002 */   addu      $a1, $s1, $zero
    /* B9180 800C8980 2800A48F */  lw         $a0, 0x28($sp)
    /* B9184 800C8984 21280002 */  addu       $a1, $s0, $zero
    /* B9188 800C8988 2400B3AF */  sw         $s3, 0x24($sp)
    /* B918C 800C898C 3000B2AF */  sw         $s2, 0x30($sp)
    /* B9190 800C8990 CA90030C */  jal        fixedmult
    /* B9194 800C8994 3C00A2AF */   sw        $v0, 0x3C($sp)
    /* B9198 800C8998 21984000 */  addu       $s3, $v0, $zero
    /* B919C 800C899C 3400A48F */  lw         $a0, 0x34($sp)
    /* B91A0 800C89A0 CA90030C */  jal        fixedmult
    /* B91A4 800C89A4 21280002 */   addu      $a1, $s0, $zero
    /* B91A8 800C89A8 21904000 */  addu       $s2, $v0, $zero
    /* B91AC 800C89AC 4000A48F */  lw         $a0, 0x40($sp)
    /* B91B0 800C89B0 CA90030C */  jal        fixedmult
    /* B91B4 800C89B4 21280002 */   addu      $a1, $s0, $zero
    /* B91B8 800C89B8 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* B91BC 800C89BC 8000A48F */  lw         $a0, 0x80($sp)
    /* B91C0 800C89C0 2000A627 */  addiu      $a2, $sp, 0x20
    /* B91C4 800C89C4 2800B3AF */  sw         $s3, 0x28($sp)
    /* B91C8 800C89C8 3400B2AF */  sw         $s2, 0x34($sp)
    /* B91CC 800C89CC 4000A2AF */  sw         $v0, 0x40($sp)
    /* B91D0 800C89D0 801F013C */  lui        $at, (0x1F800148 >> 16)
    /* B91D4 800C89D4 480120A4 */  sh         $zero, (0x1F800148 & 0xFFFF)($at)
    /* B91D8 800C89D8 06008286 */  lh         $v0, 0x6($s4)
    /* B91DC 800C89DC 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B91E0 800C89E0 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B91E4 800C89E4 80100200 */  sll        $v0, $v0, 2
    /* B91E8 800C89E8 21104300 */  addu       $v0, $v0, $v1
    /* B91EC 800C89EC 0000568C */  lw         $s6, 0x0($v0)
    /* B91F0 800C89F0 08008226 */  addiu      $v0, $s4, 0x8
    /* B91F4 800C89F4 1000A2AF */  sw         $v0, 0x10($sp)
    /* B91F8 800C89F8 1400BEAF */  sw         $fp, 0x14($sp)
    /* B91FC 800C89FC 1A008286 */  lh         $v0, 0x1A($s4)
    /* B9200 800C8A00 CC220308 */  j          .L800C8B30
    /* B9204 800C8A04 2138C002 */   addu      $a3, $s6, $zero
  .L800C8A08:
    /* B9208 800C8A08 22008292 */  lbu        $v0, 0x22($s4)
    /* B920C 800C8A0C 4800A88F */  lw         $t0, 0x48($sp)
    /* B9210 800C8A10 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B9214 800C8A14 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B9218 800C8A18 80200200 */  sll        $a0, $v0, 2
    /* B921C 800C8A1C 21208200 */  addu       $a0, $a0, $v0
    /* B9220 800C8A20 80200400 */  sll        $a0, $a0, 2
    /* B9224 800C8A24 06008286 */  lh         $v0, 0x6($s4)
    /* B9228 800C8A28 00000000 */  nop
    /* B922C 800C8A2C 80100200 */  sll        $v0, $v0, 2
    /* B9230 800C8A30 21104300 */  addu       $v0, $v0, $v1
    /* B9234 800C8A34 0000568C */  lw         $s6, 0x0($v0)
    /* B9238 800C8A38 B194020C */  jal        Object_GetAnim__FP13Trk_SimObject
    /* B923C 800C8A3C 21200401 */   addu      $a0, $t0, $a0
    /* B9240 800C8A40 40004014 */  bnez       $v0, .L800C8B44
    /* B9244 800C8A44 14008426 */   addiu     $a0, $s4, 0x14
    /* B9248 800C8A48 E0B5020C */  jal        Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* B924C 800C8A4C 2000A527 */   addiu     $a1, $sp, 0x20
    /* B9250 800C8A50 1C009086 */  lh         $s0, 0x1C($s4)
    /* B9254 800C8A54 2000A48F */  lw         $a0, 0x20($sp)
    /* B9258 800C8A58 1E009186 */  lh         $s1, 0x1E($s4)
    /* B925C 800C8A5C 20009286 */  lh         $s2, 0x20($s4)
    /* B9260 800C8A60 00821000 */  sll        $s0, $s0, 8
    /* B9264 800C8A64 21280002 */  addu       $a1, $s0, $zero
    /* B9268 800C8A68 008A1100 */  sll        $s1, $s1, 8
    /* B926C 800C8A6C CA90030C */  jal        fixedmult
    /* B9270 800C8A70 00921200 */   sll       $s2, $s2, 8
    /* B9274 800C8A74 21A84000 */  addu       $s5, $v0, $zero
    /* B9278 800C8A78 2C00A48F */  lw         $a0, 0x2C($sp)
    /* B927C 800C8A7C CA90030C */  jal        fixedmult
    /* B9280 800C8A80 21280002 */   addu      $a1, $s0, $zero
    /* B9284 800C8A84 21984000 */  addu       $s3, $v0, $zero
    /* B9288 800C8A88 3800A48F */  lw         $a0, 0x38($sp)
    /* B928C 800C8A8C CA90030C */  jal        fixedmult
    /* B9290 800C8A90 21280002 */   addu      $a1, $s0, $zero
    /* B9294 800C8A94 2400A48F */  lw         $a0, 0x24($sp)
    /* B9298 800C8A98 21282002 */  addu       $a1, $s1, $zero
    /* B929C 800C8A9C 2000B5AF */  sw         $s5, 0x20($sp)
    /* B92A0 800C8AA0 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B92A4 800C8AA4 CA90030C */  jal        fixedmult
    /* B92A8 800C8AA8 3800A2AF */   sw        $v0, 0x38($sp)
    /* B92AC 800C8AAC 21A84000 */  addu       $s5, $v0, $zero
    /* B92B0 800C8AB0 3000A48F */  lw         $a0, 0x30($sp)
    /* B92B4 800C8AB4 CA90030C */  jal        fixedmult
    /* B92B8 800C8AB8 21282002 */   addu      $a1, $s1, $zero
    /* B92BC 800C8ABC 21984000 */  addu       $s3, $v0, $zero
    /* B92C0 800C8AC0 3C00A48F */  lw         $a0, 0x3C($sp)
    /* B92C4 800C8AC4 CA90030C */  jal        fixedmult
    /* B92C8 800C8AC8 21282002 */   addu      $a1, $s1, $zero
    /* B92CC 800C8ACC 2800A48F */  lw         $a0, 0x28($sp)
    /* B92D0 800C8AD0 21284002 */  addu       $a1, $s2, $zero
    /* B92D4 800C8AD4 2400B5AF */  sw         $s5, 0x24($sp)
    /* B92D8 800C8AD8 3000B3AF */  sw         $s3, 0x30($sp)
    /* B92DC 800C8ADC CA90030C */  jal        fixedmult
    /* B92E0 800C8AE0 3C00A2AF */   sw        $v0, 0x3C($sp)
    /* B92E4 800C8AE4 21A84000 */  addu       $s5, $v0, $zero
    /* B92E8 800C8AE8 3400A48F */  lw         $a0, 0x34($sp)
    /* B92EC 800C8AEC CA90030C */  jal        fixedmult
    /* B92F0 800C8AF0 21284002 */   addu      $a1, $s2, $zero
    /* B92F4 800C8AF4 21984000 */  addu       $s3, $v0, $zero
    /* B92F8 800C8AF8 4000A48F */  lw         $a0, 0x40($sp)
    /* B92FC 800C8AFC CA90030C */  jal        fixedmult
    /* B9300 800C8B00 21284002 */   addu      $a1, $s2, $zero
    /* B9304 800C8B04 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* B9308 800C8B08 2000A627 */  addiu      $a2, $sp, 0x20
    /* B930C 800C8B0C 8000A48F */  lw         $a0, 0x80($sp)
    /* B9310 800C8B10 2138C002 */  addu       $a3, $s6, $zero
    /* B9314 800C8B14 4000A2AF */  sw         $v0, 0x40($sp)
    /* B9318 800C8B18 08008226 */  addiu      $v0, $s4, 0x8
    /* B931C 800C8B1C 2800B5AF */  sw         $s5, 0x28($sp)
    /* B9320 800C8B20 3400B3AF */  sw         $s3, 0x34($sp)
    /* B9324 800C8B24 1000A2AF */  sw         $v0, 0x10($sp)
    /* B9328 800C8B28 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B932C 800C8B2C 1400BEAF */  sw         $fp, 0x14($sp)
  .L800C8B30:
    /* B9330 800C8B30 1800A2AF */  sw         $v0, 0x18($sp)
  .L800C8B34:
    /* B9334 800C8B34 AF1F030C */  jal        DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* B9338 800C8B38 00000000 */   nop
    /* B933C 800C8B3C E1220308 */  j          .L800C8B84
    /* B9340 800C8B40 21B8E202 */   addu      $s7, $s7, $v0
  .L800C8B44:
    /* B9344 800C8B44 22008292 */  lbu        $v0, 0x22($s4)
    /* B9348 800C8B48 4800A98F */  lw         $t1, 0x48($sp)
    /* B934C 800C8B4C 80200200 */  sll        $a0, $v0, 2
    /* B9350 800C8B50 21208200 */  addu       $a0, $a0, $v0
    /* B9354 800C8B54 80200400 */  sll        $a0, $a0, 2
    /* B9358 800C8B58 B194020C */  jal        Object_GetAnim__FP13Trk_SimObject
    /* B935C 800C8B5C 21202401 */   addu      $a0, $t1, $a0
    /* B9360 800C8B60 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* B9364 800C8B64 2138C003 */  addu       $a3, $fp, $zero
    /* B9368 800C8B68 0000438C */  lw         $v1, 0x0($v0)
    /* B936C 800C8B6C 8000A58F */  lw         $a1, 0x80($sp)
    /* B9370 800C8B70 10006484 */  lh         $a0, 0x10($v1)
    /* B9374 800C8B74 1400638C */  lw         $v1, 0x14($v1)
    /* B9378 800C8B78 00000000 */  nop
    /* B937C 800C8B7C 09F86000 */  jalr       $v1
    /* B9380 800C8B80 21204400 */   addu      $a0, $v0, $a0
  .L800C8B84:
    /* B9384 800C8B84 5400A88F */  lw         $t0, 0x54($sp)
  .L800C8B88:
    /* B9388 800C8B88 00008286 */  lh         $v0, 0x0($s4)
    /* B938C 800C8B8C 01000825 */  addiu      $t0, $t0, 0x1
    /* B9390 800C8B90 21A08202 */  addu       $s4, $s4, $v0
    /* B9394 800C8B94 68210308 */  j          .L800C85A0
    /* B9398 800C8B98 5400A8AF */   sw        $t0, 0x54($sp)
  .L800C8B9C:
    /* B939C 800C8B9C 2110E002 */  addu       $v0, $s7, $zero
  .L800C8BA0:
    /* B93A0 800C8BA0 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* B93A4 800C8BA4 7800BE8F */  lw         $fp, 0x78($sp)
    /* B93A8 800C8BA8 7400B78F */  lw         $s7, 0x74($sp)
    /* B93AC 800C8BAC 7000B68F */  lw         $s6, 0x70($sp)
    /* B93B0 800C8BB0 6C00B58F */  lw         $s5, 0x6C($sp)
    /* B93B4 800C8BB4 6800B48F */  lw         $s4, 0x68($sp)
    /* B93B8 800C8BB8 6400B38F */  lw         $s3, 0x64($sp)
    /* B93BC 800C8BBC 6000B28F */  lw         $s2, 0x60($sp)
    /* B93C0 800C8BC0 5C00B18F */  lw         $s1, 0x5C($sp)
    /* B93C4 800C8BC4 5800B08F */  lw         $s0, 0x58($sp)
    /* B93C8 800C8BC8 0800E003 */  jr         $ra
    /* B93CC 800C8BCC 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo
