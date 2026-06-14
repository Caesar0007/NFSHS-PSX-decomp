.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi, 0x44C

glabel Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 91F9C 800A179C 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 91FA0 800A17A0 6800B4AF */  sw         $s4, 0x68($sp)
    /* 91FA4 800A17A4 21A08000 */  addu       $s4, $a0, $zero
    /* 91FA8 800A17A8 7000B6AF */  sw         $s6, 0x70($sp)
    /* 91FAC 800A17AC 21B0A000 */  addu       $s6, $a1, $zero
    /* 91FB0 800A17B0 6000B2AF */  sw         $s2, 0x60($sp)
    /* 91FB4 800A17B4 2190C000 */  addu       $s2, $a2, $zero
    /* 91FB8 800A17B8 2120C002 */  addu       $a0, $s6, $zero
    /* 91FBC 800A17BC 08008526 */  addiu      $a1, $s4, 0x8
    /* 91FC0 800A17C0 0100E738 */  xori       $a3, $a3, 0x1
    /* 91FC4 800A17C4 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* 91FC8 800A17C8 2BA80700 */  sltu       $s5, $zero, $a3
    /* 91FCC 800A17CC 7400BFAF */  sw         $ra, 0x74($sp)
    /* 91FD0 800A17D0 6400B3AF */  sw         $s3, 0x64($sp)
    /* 91FD4 800A17D4 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 91FD8 800A17D8 59FB010C */  jal        BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* 91FDC 800A17DC 5800B0AF */   sw        $s0, 0x58($sp)
    /* 91FE0 800A17E0 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 91FE4 800A17E4 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 91FE8 800A17E8 40991600 */  sll        $s3, $s6, 5
    /* 91FEC 800A17EC 060096A6 */  sh         $s6, 0x6($s4)
    /* 91FF0 800A17F0 21186302 */  addu       $v1, $s3, $v1
    /* 91FF4 800A17F4 12006280 */  lb         $v0, 0x12($v1)
    /* 91FF8 800A17F8 00000000 */  nop
    /* 91FFC 800A17FC 40120200 */  sll        $v0, $v0, 9
    /* 92000 800A1800 440182AE */  sw         $v0, 0x144($s4)
    /* 92004 800A1804 13006280 */  lb         $v0, 0x13($v1)
    /* 92008 800A1808 00000000 */  nop
    /* 9200C 800A180C 40120200 */  sll        $v0, $v0, 9
    /* 92010 800A1810 480182AE */  sw         $v0, 0x148($s4)
    /* 92014 800A1814 14006280 */  lb         $v0, 0x14($v1)
    /* 92018 800A1818 00000000 */  nop
    /* 9201C 800A181C 40120200 */  sll        $v0, $v0, 9
    /* 92020 800A1820 4C0182AE */  sw         $v0, 0x14C($s4)
    /* 92024 800A1824 0C006280 */  lb         $v0, 0xC($v1)
    /* 92028 800A1828 00000000 */  nop
    /* 9202C 800A182C 40120200 */  sll        $v0, $v0, 9
    /* 92030 800A1830 500182AE */  sw         $v0, 0x150($s4)
    /* 92034 800A1834 0D006280 */  lb         $v0, 0xD($v1)
    /* 92038 800A1838 00000000 */  nop
    /* 9203C 800A183C 40120200 */  sll        $v0, $v0, 9
    /* 92040 800A1840 540182AE */  sw         $v0, 0x154($s4)
    /* 92044 800A1844 0E006280 */  lb         $v0, 0xE($v1)
    /* 92048 800A1848 00000000 */  nop
    /* 9204C 800A184C 40120200 */  sll        $v0, $v0, 9
    /* 92050 800A1850 580182AE */  sw         $v0, 0x158($s4)
    /* 92054 800A1854 0F006280 */  lb         $v0, 0xF($v1)
    /* 92058 800A1858 00000000 */  nop
    /* 9205C 800A185C 40120200 */  sll        $v0, $v0, 9
    /* 92060 800A1860 5C0182AE */  sw         $v0, 0x15C($s4)
    /* 92064 800A1864 10006280 */  lb         $v0, 0x10($v1)
    /* 92068 800A1868 44019026 */  addiu      $s0, $s4, 0x144
    /* 9206C 800A186C 40120200 */  sll        $v0, $v0, 9
    /* 92070 800A1870 600182AE */  sw         $v0, 0x160($s4)
    /* 92074 800A1874 11006280 */  lb         $v0, 0x11($v1)
    /* 92078 800A1878 21200002 */  addu       $a0, $s0, $zero
    /* 9207C 800A187C 40120200 */  sll        $v0, $v0, 9
    /* 92080 800A1880 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 92084 800A1884 640182AE */   sw        $v0, 0x164($s4)
    /* 92088 800A1888 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 9208C 800A188C 50018426 */   addiu     $a0, $s4, 0x150
    /* 92090 800A1890 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 92094 800A1894 5C018426 */   addiu     $a0, $s4, 0x15C
    /* 92098 800A1898 21200002 */  addu       $a0, $s0, $zero
    /* 9209C 800A189C D690030C */  jal        transpose
    /* 920A0 800A18A0 2000A527 */   addiu     $a1, $sp, 0x20
    /* 920A4 800A18A4 21208002 */  addu       $a0, $s4, $zero
    /* 920A8 800A18A8 7D85020C */  jal        Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
    /* 920AC 800A18AC 2128A002 */   addu      $a1, $s5, $zero
    /* 920B0 800A18B0 21208002 */  addu       $a0, $s4, $zero
    /* 920B4 800A18B4 B285020C */  jal        Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
    /* 920B8 800A18B8 2128A002 */   addu      $a1, $s5, $zero
    /* 920BC 800A18BC 0000448E */  lw         $a0, 0x0($s2)
    /* 920C0 800A18C0 2000A58F */  lw         $a1, 0x20($sp)
    /* 920C4 800A18C4 CA90030C */  jal        fixedmult
    /* 920C8 800A18C8 00000000 */   nop
    /* 920CC 800A18CC 0400448E */  lw         $a0, 0x4($s2)
    /* 920D0 800A18D0 2400A58F */  lw         $a1, 0x24($sp)
    /* 920D4 800A18D4 CA90030C */  jal        fixedmult
    /* 920D8 800A18D8 21804000 */   addu      $s0, $v0, $zero
    /* 920DC 800A18DC 0800448E */  lw         $a0, 0x8($s2)
    /* 920E0 800A18E0 2800A58F */  lw         $a1, 0x28($sp)
    /* 920E4 800A18E4 CA90030C */  jal        fixedmult
    /* 920E8 800A18E8 21884000 */   addu      $s1, $v0, $zero
    /* 920EC 800A18EC 21801102 */  addu       $s0, $s0, $s1
    /* 920F0 800A18F0 21800202 */  addu       $s0, $s0, $v0
    /* 920F4 800A18F4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 920F8 800A18F8 0000448E */  lw         $a0, 0x0($s2)
    /* 920FC 800A18FC 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 92100 800A1900 CA90030C */  jal        fixedmult
    /* 92104 800A1904 00000000 */   nop
    /* 92108 800A1908 0400448E */  lw         $a0, 0x4($s2)
    /* 9210C 800A190C 3000A58F */  lw         $a1, 0x30($sp)
    /* 92110 800A1910 CA90030C */  jal        fixedmult
    /* 92114 800A1914 21804000 */   addu      $s0, $v0, $zero
    /* 92118 800A1918 0800448E */  lw         $a0, 0x8($s2)
    /* 9211C 800A191C 3400A58F */  lw         $a1, 0x34($sp)
    /* 92120 800A1920 CA90030C */  jal        fixedmult
    /* 92124 800A1924 21884000 */   addu      $s1, $v0, $zero
    /* 92128 800A1928 21801102 */  addu       $s0, $s0, $s1
    /* 9212C 800A192C 21800202 */  addu       $s0, $s0, $v0
    /* 92130 800A1930 1400B0AF */  sw         $s0, 0x14($sp)
    /* 92134 800A1934 0000448E */  lw         $a0, 0x0($s2)
    /* 92138 800A1938 3800A58F */  lw         $a1, 0x38($sp)
    /* 9213C 800A193C CA90030C */  jal        fixedmult
    /* 92140 800A1940 00000000 */   nop
    /* 92144 800A1944 0400448E */  lw         $a0, 0x4($s2)
    /* 92148 800A1948 3C00A58F */  lw         $a1, 0x3C($sp)
    /* 9214C 800A194C CA90030C */  jal        fixedmult
    /* 92150 800A1950 21804000 */   addu      $s0, $v0, $zero
    /* 92154 800A1954 0800448E */  lw         $a0, 0x8($s2)
    /* 92158 800A1958 4000A58F */  lw         $a1, 0x40($sp)
    /* 9215C 800A195C CA90030C */  jal        fixedmult
    /* 92160 800A1960 21884000 */   addu      $s1, $v0, $zero
    /* 92164 800A1964 21801102 */  addu       $s0, $s0, $s1
    /* 92168 800A1968 21800202 */  addu       $s0, $s0, $v0
    /* 9216C 800A196C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 92170 800A1970 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 92174 800A1974 1000A28F */  lw         $v0, 0x10($sp)
    /* 92178 800A1978 1800B0AF */  sw         $s0, 0x18($sp)
    /* 9217C 800A197C 21986302 */  addu       $s3, $s3, $v1
    /* 92180 800A1980 0000638E */  lw         $v1, 0x0($s3)
    /* 92184 800A1984 00000000 */  nop
    /* 92188 800A1988 21104300 */  addu       $v0, $v0, $v1
    /* 9218C 800A198C A00082AE */  sw         $v0, 0xA0($s4)
    /* 92190 800A1990 1400A28F */  lw         $v0, 0x14($sp)
    /* 92194 800A1994 0400638E */  lw         $v1, 0x4($s3)
    /* 92198 800A1998 00000000 */  nop
    /* 9219C 800A199C 21104300 */  addu       $v0, $v0, $v1
    /* 921A0 800A19A0 A40082AE */  sw         $v0, 0xA4($s4)
    /* 921A4 800A19A4 1800A28F */  lw         $v0, 0x18($sp)
    /* 921A8 800A19A8 0800648E */  lw         $a0, 0x8($s3)
    /* 921AC 800A19AC 6002838E */  lw         $v1, 0x260($s4)
    /* 921B0 800A19B0 21104400 */  addu       $v0, $v0, $a0
    /* 921B4 800A19B4 04006330 */  andi       $v1, $v1, 0x4
    /* 921B8 800A19B8 03006010 */  beqz       $v1, .L800A19C8
    /* 921BC 800A19BC A80082AE */   sw        $v0, 0xA8($s4)
    /* 921C0 800A19C0 74860208 */  j          .L800A19D0
    /* 921C4 800A19C4 900080A2 */   sb        $zero, 0x90($s4)
  .L800A19C8:
    /* 921C8 800A19C8 02000224 */  addiu      $v0, $zero, 0x2
    /* 921CC 800A19CC 900082A2 */  sb         $v0, 0x90($s4)
  .L800A19D0:
    /* 921D0 800A19D0 C17D020C */  jal        Newton_FindClosestQuad__FP13BO_tNewtonObj
    /* 921D4 800A19D4 21208002 */   addu      $a0, $s4, $zero
    /* 921D8 800A19D8 5A85020C */  jal        Newton_UpdateRoadInfo__FP13BO_tNewtonObj
    /* 921DC 800A19DC 21208002 */   addu      $a0, $s4, $zero
    /* 921E0 800A19E0 E87D020C */  jal        Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
    /* 921E4 800A19E4 21208002 */   addu      $a0, $s4, $zero
    /* 921E8 800A19E8 21208002 */  addu       $a0, $s4, $zero
    /* 921EC 800A19EC 7D85020C */  jal        Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji
    /* 921F0 800A19F0 2128A002 */   addu      $a1, $s5, $zero
    /* 921F4 800A19F4 21208002 */  addu       $a0, $s4, $zero
    /* 921F8 800A19F8 B285020C */  jal        Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji
    /* 921FC 800A19FC 2128A002 */   addu      $a1, $s5, $zero
    /* 92200 800A1A00 90008392 */  lbu        $v1, 0x90($s4)
    /* 92204 800A1A04 02000224 */  addiu      $v0, $zero, 0x2
    /* 92208 800A1A08 08006214 */  bne        $v1, $v0, .L800A1A2C
    /* 9220C 800A1A0C 01001024 */   addiu     $s0, $zero, 0x1
    /* 92210 800A1A10 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 92214 800A1A14 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 92218 800A1A18 40191600 */  sll        $v1, $s6, 5
    /* 9221C 800A1A1C 21186200 */  addu       $v1, $v1, $v0
    /* 92220 800A1A20 0400628C */  lw         $v0, 0x4($v1)
    /* 92224 800A1A24 D8860208 */  j          .L800A1B60
    /* 92228 800A1A28 800182AE */   sw        $v0, 0x180($s4)
  .L800A1A2C:
    /* 9222C 800A1A2C 28007014 */  bne        $v1, $s0, .L800A1AD0
    /* 92230 800A1A30 21200000 */   addu      $a0, $zero, $zero
    /* 92234 800A1A34 21308000 */  addu       $a2, $a0, $zero
    /* 92238 800A1A38 21288002 */  addu       $a1, $s4, $zero
  .L800A1A3C:
    /* 9223C 800A1A3C 0400C228 */  slti       $v0, $a2, 0x4
    /* 92240 800A1A40 1D004010 */  beqz       $v0, .L800A1AB8
    /* 92244 800A1A44 00000000 */   nop
    /* 92248 800A1A48 8000828E */  lw         $v0, 0x80($s4)
    /* 9224C 800A1A4C 00000000 */  nop
    /* 92250 800A1A50 09004010 */  beqz       $v0, .L800A1A78
    /* 92254 800A1A54 00000000 */   nop
    /* 92258 800A1A58 1000A88C */  lw         $t0, 0x10($a1)
    /* 9225C 800A1A5C 1400A98C */  lw         $t1, 0x14($a1)
    /* 92260 800A1A60 1800AA8C */  lw         $t2, 0x18($a1)
    /* 92264 800A1A64 4800A8AF */  sw         $t0, 0x48($sp)
    /* 92268 800A1A68 4C00A9AF */  sw         $t1, 0x4C($sp)
    /* 9226C 800A1A6C 5000AAAF */  sw         $t2, 0x50($sp)
    /* 92270 800A1A70 AA860208 */  j          .L800A1AA8
    /* 92274 800A1A74 0C00A524 */   addiu     $a1, $a1, 0xC
  .L800A1A78:
    /* 92278 800A1A78 08008286 */  lh         $v0, 0x8($s4)
    /* 9227C 800A1A7C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 92280 800A1A80 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 92284 800A1A84 40110200 */  sll        $v0, $v0, 5
    /* 92288 800A1A88 21104300 */  addu       $v0, $v0, $v1
    /* 9228C 800A1A8C 0000488C */  lw         $t0, 0x0($v0)
    /* 92290 800A1A90 0400498C */  lw         $t1, 0x4($v0)
    /* 92294 800A1A94 08004A8C */  lw         $t2, 0x8($v0)
    /* 92298 800A1A98 4800A8AF */  sw         $t0, 0x48($sp)
    /* 9229C 800A1A9C 4C00A9AF */  sw         $t1, 0x4C($sp)
    /* 922A0 800A1AA0 5000AAAF */  sw         $t2, 0x50($sp)
    /* 922A4 800A1AA4 0C00A524 */  addiu      $a1, $a1, 0xC
  .L800A1AA8:
    /* 922A8 800A1AA8 4C00A28F */  lw         $v0, 0x4C($sp)
    /* 922AC 800A1AAC 0100C624 */  addiu      $a2, $a2, 0x1
    /* 922B0 800A1AB0 8F860208 */  j          .L800A1A3C
    /* 922B4 800A1AB4 21208200 */   addu      $a0, $a0, $v0
  .L800A1AB8:
    /* 922B8 800A1AB8 02008104 */  bgez       $a0, .L800A1AC4
    /* 922BC 800A1ABC 21108000 */   addu      $v0, $a0, $zero
    /* 922C0 800A1AC0 03008224 */  addiu      $v0, $a0, 0x3
  .L800A1AC4:
    /* 922C4 800A1AC4 83200200 */  sra        $a0, $v0, 2
    /* 922C8 800A1AC8 D8860208 */  j          .L800A1B60
    /* 922CC 800A1ACC 800184AE */   sw        $a0, 0x180($s4)
  .L800A1AD0:
    /* 922D0 800A1AD0 1480023C */  lui        $v0, %hi(stackSpeedUpEnbabledFlag)
    /* 922D4 800A1AD4 1CD8428C */  lw         $v0, %lo(stackSpeedUpEnbabledFlag)($v0)
    /* 922D8 800A1AD8 00000000 */  nop
    /* 922DC 800A1ADC 17004010 */  beqz       $v0, .L800A1B3C
    /* 922E0 800A1AE0 21208002 */   addu      $a0, $s4, $zero
    /* 922E4 800A1AE4 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 922E8 800A1AE8 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 922EC 800A1AEC 2B91030C */  jal        SetSp
    /* 922F0 800A1AF0 00000000 */   nop
    /* 922F4 800A1AF4 21208002 */  addu       $a0, $s4, $zero
    /* 922F8 800A1AF8 1480053C */  lui        $a1, %hi(D_8013E0E8)
    /* 922FC 800A1AFC 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 92300 800A1B00 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 92304 800A1B04 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 92308 800A1B08 1CD820AC */  sw         $zero, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 9230C 800A1B0C E07F020C */  jal        Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
    /* 92310 800A1B10 E8E0A524 */   addiu     $a1, $a1, %lo(D_8013E0E8)
    /* 92314 800A1B14 1480043C */  lui        $a0, %hi(gWSavePtr)
    /* 92318 800A1B18 30D8848C */  lw         $a0, %lo(gWSavePtr)($a0)
    /* 9231C 800A1B1C 2B91030C */  jal        SetSp
    /* 92320 800A1B20 800182AE */   sw        $v0, 0x180($s4)
    /* 92324 800A1B24 1480013C */  lui        $at, %hi(gWSavePtr)
    /* 92328 800A1B28 30D822AC */  sw         $v0, %lo(gWSavePtr)($at)
    /* 9232C 800A1B2C 1480013C */  lui        $at, %hi(stackSpeedUpEnbabledFlag)
    /* 92330 800A1B30 1CD830AC */  sw         $s0, %lo(stackSpeedUpEnbabledFlag)($at)
    /* 92334 800A1B34 D3860208 */  j          .L800A1B4C
    /* 92338 800A1B38 00000000 */   nop
  .L800A1B3C:
    /* 9233C 800A1B3C 1480053C */  lui        $a1, %hi(D_8013E0E8)
    /* 92340 800A1B40 E07F020C */  jal        Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef
    /* 92344 800A1B44 E8E0A524 */   addiu     $a1, $a1, %lo(D_8013E0E8)
    /* 92348 800A1B48 800182AE */  sw         $v0, 0x180($s4)
  .L800A1B4C:
    /* 9234C 800A1B4C 8001828E */  lw         $v0, 0x180($s4)
    /* 92350 800A1B50 3801838E */  lw         $v1, 0x138($s4)
    /* 92354 800A1B54 00000000 */  nop
    /* 92358 800A1B58 21104300 */  addu       $v0, $v0, $v1
    /* 9235C 800A1B5C A40082AE */  sw         $v0, 0xA4($s4)
  .L800A1B60:
    /* 92360 800A1B60 21208002 */  addu       $a0, $s4, $zero
    /* 92364 800A1B64 50018526 */  addiu      $a1, $s4, 0x150
    /* 92368 800A1B68 7A83020C */  jal        Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1
    /* 9236C 800A1B6C 68018626 */   addiu     $a2, $s4, 0x168
    /* 92370 800A1B70 A400838E */  lw         $v1, 0xA4($s4)
    /* 92374 800A1B74 90008492 */  lbu        $a0, 0x90($s4)
    /* 92378 800A1B78 880182AE */  sw         $v0, 0x188($s4)
    /* 9237C 800A1B7C 880180AE */  sw         $zero, 0x188($s4)
    /* 92380 800A1B80 23186200 */  subu       $v1, $v1, $v0
    /* 92384 800A1B84 08008014 */  bnez       $a0, .L800A1BA8
    /* 92388 800A1B88 A40083AE */   sw        $v1, 0xA4($s4)
    /* 9238C 800A1B8C 8000838E */  lw         $v1, 0x80($s4)
    /* 92390 800A1B90 00000000 */  nop
    /* 92394 800A1B94 05006010 */  beqz       $v1, .L800A1BAC
    /* 92398 800A1B98 0E000224 */   addiu     $v0, $zero, 0xE
    /* 9239C 800A1B9C 00006290 */  lbu        $v0, 0x0($v1)
    /* 923A0 800A1BA0 EC860208 */  j          .L800A1BB0
    /* 923A4 800A1BA4 BC0182AE */   sw        $v0, 0x1BC($s4)
  .L800A1BA8:
    /* 923A8 800A1BA8 01000224 */  addiu      $v0, $zero, 0x1
  .L800A1BAC:
    /* 923AC 800A1BAC BC0182AE */  sw         $v0, 0x1BC($s4)
  .L800A1BB0:
    /* 923B0 800A1BB0 BC01828E */  lw         $v0, 0x1BC($s4)
    /* 923B4 800A1BB4 00000000 */  nop
    /* 923B8 800A1BB8 0F004230 */  andi       $v0, $v0, 0xF
    /* 923BC 800A1BBC C00182AE */  sw         $v0, 0x1C0($s4)
    /* 923C0 800A1BC0 7400BF8F */  lw         $ra, 0x74($sp)
    /* 923C4 800A1BC4 7000B68F */  lw         $s6, 0x70($sp)
    /* 923C8 800A1BC8 6C00B58F */  lw         $s5, 0x6C($sp)
    /* 923CC 800A1BCC 6800B48F */  lw         $s4, 0x68($sp)
    /* 923D0 800A1BD0 6400B38F */  lw         $s3, 0x64($sp)
    /* 923D4 800A1BD4 6000B28F */  lw         $s2, 0x60($sp)
    /* 923D8 800A1BD8 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 923DC 800A1BDC 5800B08F */  lw         $s0, 0x58($sp)
    /* 923E0 800A1BE0 0800E003 */  jr         $ra
    /* 923E4 800A1BE4 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
