.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_Real__FP8Car_tObj, 0x13E0

glabel Physics_Real__FP8Car_tObj
    /* 9C964 800AC164 E8FEBD27 */  addiu      $sp, $sp, -0x118
    /* 9C968 800AC168 0C01B5AF */  sw         $s5, 0x10C($sp)
    /* 9C96C 800AC16C 21A88000 */  addu       $s5, $a0, $zero
    /* 9C970 800AC170 1180023C */  lui        $v0, %hi(D_80113234)
    /* 9C974 800AC174 1401BFAF */  sw         $ra, 0x114($sp)
    /* 9C978 800AC178 1001B6AF */  sw         $s6, 0x110($sp)
    /* 9C97C 800AC17C 0801B4AF */  sw         $s4, 0x108($sp)
    /* 9C980 800AC180 0401B3AF */  sw         $s3, 0x104($sp)
    /* 9C984 800AC184 0001B2AF */  sw         $s2, 0x100($sp)
    /* 9C988 800AC188 FC00B1AF */  sw         $s1, 0xFC($sp)
    /* 9C98C 800AC18C F800B0AF */  sw         $s0, 0xF8($sp)
    /* 9C990 800AC190 0C04A0AE */  sw         $zero, 0x40C($s5)
    /* 9C994 800AC194 1004A0AE */  sw         $zero, 0x410($s5)
    /* 9C998 800AC198 1404A0AE */  sw         $zero, 0x414($s5)
    /* 9C99C 800AC19C 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* 9C9A0 800AC1A0 6404B68E */  lw         $s6, 0x464($s5)
    /* 9C9A4 800AC1A4 01001024 */  addiu      $s0, $zero, 0x1
    /* 9C9A8 800AC1A8 D00D90AF */  sw         $s0, %gp_rel(steeringControl)($gp)
    /* 9C9AC 800AC1AC D40D90AF */  sw         $s0, %gp_rel(powerControl)($gp)
    /* 9C9B0 800AC1B0 09004010 */  beqz       $v0, .L800AC1D8
    /* 9C9B4 800AC1B4 00000000 */   nop
    /* 9C9B8 800AC1B8 F5FF010C */  jal        BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* 9C9BC 800AC1BC 0800A426 */   addiu     $a0, $s5, 0x8
    /* 9C9C0 800AC1C0 26105000 */  xor        $v0, $v0, $s0
    /* 9C9C4 800AC1C4 04004010 */  beqz       $v0, .L800AC1D8
    /* 9C9C8 800AC1C8 00000000 */   nop
    /* 9C9CC 800AC1CC CC0D90AF */  sw         $s0, %gp_rel(slippery)($gp)
    /* 9C9D0 800AC1D0 77B00208 */  j          .L800AC1DC
    /* 9C9D4 800AC1D4 00000000 */   nop
  .L800AC1D8:
    /* 9C9D8 800AC1D8 CC0D80AF */  sw         $zero, %gp_rel(slippery)($gp)
  .L800AC1DC:
    /* 9C9DC 800AC1DC AC02A28E */  lw         $v0, 0x2AC($s5)
    /* 9C9E0 800AC1E0 00000000 */  nop
    /* 9C9E4 800AC1E4 0B004010 */  beqz       $v0, .L800AC214
    /* 9C9E8 800AC1E8 00000000 */   nop
    /* 9C9EC 800AC1EC DC02A28E */  lw         $v0, 0x2DC($s5)
    /* 9C9F0 800AC1F0 00000000 */  nop
    /* 9C9F4 800AC1F4 07004010 */  beqz       $v0, .L800AC214
    /* 9C9F8 800AC1F8 00000000 */   nop
    /* 9C9FC 800AC1FC 8801A28E */  lw         $v0, 0x188($s5)
    /* 9CA00 800AC200 00000000 */  nop
    /* 9CA04 800AC204 CD0C4228 */  slti       $v0, $v0, 0xCCD
    /* 9CA08 800AC208 02004014 */  bnez       $v0, .L800AC214
    /* 9CA0C 800AC20C 00000000 */   nop
    /* 9CA10 800AC210 D00D80AF */  sw         $zero, %gp_rel(steeringControl)($gp)
  .L800AC214:
    /* 9CA14 800AC214 0C03A28E */  lw         $v0, 0x30C($s5)
    /* 9CA18 800AC218 00000000 */  nop
    /* 9CA1C 800AC21C 0B004010 */  beqz       $v0, .L800AC24C
    /* 9CA20 800AC220 00000000 */   nop
    /* 9CA24 800AC224 3C03A28E */  lw         $v0, 0x33C($s5)
    /* 9CA28 800AC228 00000000 */  nop
    /* 9CA2C 800AC22C 07004010 */  beqz       $v0, .L800AC24C
    /* 9CA30 800AC230 00000000 */   nop
    /* 9CA34 800AC234 8801A28E */  lw         $v0, 0x188($s5)
    /* 9CA38 800AC238 00000000 */  nop
    /* 9CA3C 800AC23C CD0C4228 */  slti       $v0, $v0, 0xCCD
    /* 9CA40 800AC240 02004014 */  bnez       $v0, .L800AC24C
    /* 9CA44 800AC244 00000000 */   nop
    /* 9CA48 800AC248 D40D80AF */  sw         $zero, %gp_rel(powerControl)($gp)
  .L800AC24C:
    /* 9CA4C 800AC24C AC00A48E */  lw         $a0, 0xAC($s5)
    /* 9CA50 800AC250 C401A58E */  lw         $a1, 0x1C4($s5)
    /* 9CA54 800AC254 CA90030C */  jal        fixedmult
    /* 9CA58 800AC258 00000000 */   nop
    /* 9CA5C 800AC25C B000A48E */  lw         $a0, 0xB0($s5)
    /* 9CA60 800AC260 C801A58E */  lw         $a1, 0x1C8($s5)
    /* 9CA64 800AC264 CA90030C */  jal        fixedmult
    /* 9CA68 800AC268 21804000 */   addu      $s0, $v0, $zero
    /* 9CA6C 800AC26C B400A48E */  lw         $a0, 0xB4($s5)
    /* 9CA70 800AC270 CC01A58E */  lw         $a1, 0x1CC($s5)
    /* 9CA74 800AC274 CA90030C */  jal        fixedmult
    /* 9CA78 800AC278 21884000 */   addu      $s1, $v0, $zero
    /* 9CA7C 800AC27C 21801102 */  addu       $s0, $s0, $s1
    /* 9CA80 800AC280 AC00A48E */  lw         $a0, 0xAC($s5)
    /* 9CA84 800AC284 D001A58E */  lw         $a1, 0x1D0($s5)
    /* 9CA88 800AC288 21800202 */  addu       $s0, $s0, $v0
    /* 9CA8C 800AC28C CA90030C */  jal        fixedmult
    /* 9CA90 800AC290 1804B0AE */   sw        $s0, 0x418($s5)
    /* 9CA94 800AC294 B000A48E */  lw         $a0, 0xB0($s5)
    /* 9CA98 800AC298 D401A58E */  lw         $a1, 0x1D4($s5)
    /* 9CA9C 800AC29C CA90030C */  jal        fixedmult
    /* 9CAA0 800AC2A0 21804000 */   addu      $s0, $v0, $zero
    /* 9CAA4 800AC2A4 B400A48E */  lw         $a0, 0xB4($s5)
    /* 9CAA8 800AC2A8 D801A58E */  lw         $a1, 0x1D8($s5)
    /* 9CAAC 800AC2AC CA90030C */  jal        fixedmult
    /* 9CAB0 800AC2B0 21884000 */   addu      $s1, $v0, $zero
    /* 9CAB4 800AC2B4 21801102 */  addu       $s0, $s0, $s1
    /* 9CAB8 800AC2B8 AC00A48E */  lw         $a0, 0xAC($s5)
    /* 9CABC 800AC2BC DC01A58E */  lw         $a1, 0x1DC($s5)
    /* 9CAC0 800AC2C0 21800202 */  addu       $s0, $s0, $v0
    /* 9CAC4 800AC2C4 CA90030C */  jal        fixedmult
    /* 9CAC8 800AC2C8 1C04B0AE */   sw        $s0, 0x41C($s5)
    /* 9CACC 800AC2CC B000A48E */  lw         $a0, 0xB0($s5)
    /* 9CAD0 800AC2D0 E001A58E */  lw         $a1, 0x1E0($s5)
    /* 9CAD4 800AC2D4 CA90030C */  jal        fixedmult
    /* 9CAD8 800AC2D8 21804000 */   addu      $s0, $v0, $zero
    /* 9CADC 800AC2DC B400A48E */  lw         $a0, 0xB4($s5)
    /* 9CAE0 800AC2E0 E401A58E */  lw         $a1, 0x1E4($s5)
    /* 9CAE4 800AC2E4 CA90030C */  jal        fixedmult
    /* 9CAE8 800AC2E8 21884000 */   addu      $s1, $v0, $zero
    /* 9CAEC 800AC2EC 21801102 */  addu       $s0, $s0, $s1
    /* 9CAF0 800AC2F0 1401A48E */  lw         $a0, 0x114($s5)
    /* 9CAF4 800AC2F4 C401A58E */  lw         $a1, 0x1C4($s5)
    /* 9CAF8 800AC2F8 21800202 */  addu       $s0, $s0, $v0
    /* 9CAFC 800AC2FC CA90030C */  jal        fixedmult
    /* 9CB00 800AC300 2004B0AE */   sw        $s0, 0x420($s5)
    /* 9CB04 800AC304 1801A48E */  lw         $a0, 0x118($s5)
    /* 9CB08 800AC308 C801A58E */  lw         $a1, 0x1C8($s5)
    /* 9CB0C 800AC30C CA90030C */  jal        fixedmult
    /* 9CB10 800AC310 21804000 */   addu      $s0, $v0, $zero
    /* 9CB14 800AC314 1C01A48E */  lw         $a0, 0x11C($s5)
    /* 9CB18 800AC318 CC01A58E */  lw         $a1, 0x1CC($s5)
    /* 9CB1C 800AC31C CA90030C */  jal        fixedmult
    /* 9CB20 800AC320 21884000 */   addu      $s1, $v0, $zero
    /* 9CB24 800AC324 21801102 */  addu       $s0, $s0, $s1
    /* 9CB28 800AC328 1401A48E */  lw         $a0, 0x114($s5)
    /* 9CB2C 800AC32C D001A58E */  lw         $a1, 0x1D0($s5)
    /* 9CB30 800AC330 21800202 */  addu       $s0, $s0, $v0
    /* 9CB34 800AC334 CA90030C */  jal        fixedmult
    /* 9CB38 800AC338 2404B0AE */   sw        $s0, 0x424($s5)
    /* 9CB3C 800AC33C 1801A48E */  lw         $a0, 0x118($s5)
    /* 9CB40 800AC340 D401A58E */  lw         $a1, 0x1D4($s5)
    /* 9CB44 800AC344 CA90030C */  jal        fixedmult
    /* 9CB48 800AC348 21804000 */   addu      $s0, $v0, $zero
    /* 9CB4C 800AC34C 1C01A48E */  lw         $a0, 0x11C($s5)
    /* 9CB50 800AC350 D801A58E */  lw         $a1, 0x1D8($s5)
    /* 9CB54 800AC354 CA90030C */  jal        fixedmult
    /* 9CB58 800AC358 21884000 */   addu      $s1, $v0, $zero
    /* 9CB5C 800AC35C 21801102 */  addu       $s0, $s0, $s1
    /* 9CB60 800AC360 1401A48E */  lw         $a0, 0x114($s5)
    /* 9CB64 800AC364 DC01A58E */  lw         $a1, 0x1DC($s5)
    /* 9CB68 800AC368 21800202 */  addu       $s0, $s0, $v0
    /* 9CB6C 800AC36C CA90030C */  jal        fixedmult
    /* 9CB70 800AC370 2804B0AE */   sw        $s0, 0x428($s5)
    /* 9CB74 800AC374 1801A48E */  lw         $a0, 0x118($s5)
    /* 9CB78 800AC378 E001A58E */  lw         $a1, 0x1E0($s5)
    /* 9CB7C 800AC37C CA90030C */  jal        fixedmult
    /* 9CB80 800AC380 21804000 */   addu      $s0, $v0, $zero
    /* 9CB84 800AC384 1C01A48E */  lw         $a0, 0x11C($s5)
    /* 9CB88 800AC388 E401A58E */  lw         $a1, 0x1E4($s5)
    /* 9CB8C 800AC38C CA90030C */  jal        fixedmult
    /* 9CB90 800AC390 21884000 */   addu      $s1, $v0, $zero
    /* 9CB94 800AC394 21801102 */  addu       $s0, $s0, $s1
    /* 9CB98 800AC398 21800202 */  addu       $s0, $s0, $v0
    /* 9CB9C 800AC39C 2004A58E */  lw         $a1, 0x420($s5)
    /* 9CBA0 800AC3A0 0500023C */  lui        $v0, (0x50000 >> 16)
    /* 9CBA4 800AC3A4 2A104500 */  slt        $v0, $v0, $a1
    /* 9CBA8 800AC3A8 06004010 */  beqz       $v0, .L800AC3C4
    /* 9CBAC 800AC3AC 2C04B0AE */   sw        $s0, 0x42C($s5)
    /* 9CBB0 800AC3B0 1804A48E */  lw         $a0, 0x418($s5)
    /* 9CBB4 800AC3B4 0191030C */  jal        rdiv
    /* 9CBB8 800AC3B8 00000000 */   nop
    /* 9CBBC 800AC3BC F2B00208 */  j          .L800AC3C8
    /* 9CBC0 800AC3C0 7804A2AE */   sw        $v0, 0x478($s5)
  .L800AC3C4:
    /* 9CBC4 800AC3C4 7804A0AE */  sw         $zero, 0x478($s5)
  .L800AC3C8:
    /* 9CBC8 800AC3C8 1804A28E */  lw         $v0, 0x418($s5)
    /* 9CBCC 800AC3CC 00000000 */  nop
    /* 9CBD0 800AC3D0 40110200 */  sll        $v0, $v0, 5
    /* 9CBD4 800AC3D4 23100200 */  negu       $v0, $v0
    /* 9CBD8 800AC3D8 C21F0200 */  srl        $v1, $v0, 31
    /* 9CBDC 800AC3DC 21104300 */  addu       $v0, $v0, $v1
    /* 9CBE0 800AC3E0 43100200 */  sra        $v0, $v0, 1
    /* 9CBE4 800AC3E4 9000A2AF */  sw         $v0, 0x90($sp)
    /* 9CBE8 800AC3E8 1C04A28E */  lw         $v0, 0x41C($s5)
    /* 9CBEC 800AC3EC 00000000 */  nop
    /* 9CBF0 800AC3F0 40110200 */  sll        $v0, $v0, 5
    /* 9CBF4 800AC3F4 23100200 */  negu       $v0, $v0
    /* 9CBF8 800AC3F8 C21F0200 */  srl        $v1, $v0, 31
    /* 9CBFC 800AC3FC 21104300 */  addu       $v0, $v0, $v1
    /* 9CC00 800AC400 43100200 */  sra        $v0, $v0, 1
    /* 9CC04 800AC404 9400A2AF */  sw         $v0, 0x94($sp)
    /* 9CC08 800AC408 2004A28E */  lw         $v0, 0x420($s5)
    /* 9CC0C 800AC40C 00000000 */  nop
    /* 9CC10 800AC410 40110200 */  sll        $v0, $v0, 5
    /* 9CC14 800AC414 23100200 */  negu       $v0, $v0
    /* 9CC18 800AC418 C21F0200 */  srl        $v1, $v0, 31
    /* 9CC1C 800AC41C 21104300 */  addu       $v0, $v0, $v1
    /* 9CC20 800AC420 43100200 */  sra        $v0, $v0, 1
    /* 9CC24 800AC424 9800A2AF */  sw         $v0, 0x98($sp)
    /* 9CC28 800AC428 1801A48E */  lw         $a0, 0x118($s5)
    /* 9CC2C 800AC42C C401C58E */  lw         $a1, 0x1C4($s6)
    /* 9CC30 800AC430 CA90030C */  jal        fixedmult
    /* 9CC34 800AC434 40210400 */   sll       $a0, $a0, 5
    /* 9CC38 800AC438 21200000 */  addu       $a0, $zero, $zero
    /* 9CC3C 800AC43C F6FF033C */  lui        $v1, (0xFFF60000 >> 16)
    /* 9CC40 800AC440 23900200 */  negu       $s2, $v0
    /* 9CC44 800AC444 C2171200 */  srl        $v0, $s2, 31
    /* 9CC48 800AC448 21904202 */  addu       $s2, $s2, $v0
    /* 9CC4C 800AC44C 7000A0AF */  sw         $zero, 0x70($sp)
    /* 9CC50 800AC450 7400A3AF */  sw         $v1, 0x74($sp)
    /* 9CC54 800AC454 7800A0AF */  sw         $zero, 0x78($sp)
    /* 9CC58 800AC458 C401A58E */  lw         $a1, 0x1C4($s5)
    /* 9CC5C 800AC45C CA90030C */  jal        fixedmult
    /* 9CC60 800AC460 43901200 */   sra       $s2, $s2, 1
    /* 9CC64 800AC464 7400A48F */  lw         $a0, 0x74($sp)
    /* 9CC68 800AC468 C801A58E */  lw         $a1, 0x1C8($s5)
    /* 9CC6C 800AC46C CA90030C */  jal        fixedmult
    /* 9CC70 800AC470 21804000 */   addu      $s0, $v0, $zero
    /* 9CC74 800AC474 7800A48F */  lw         $a0, 0x78($sp)
    /* 9CC78 800AC478 CC01A58E */  lw         $a1, 0x1CC($s5)
    /* 9CC7C 800AC47C CA90030C */  jal        fixedmult
    /* 9CC80 800AC480 21884000 */   addu      $s1, $v0, $zero
    /* 9CC84 800AC484 1180133C */  lui        $s3, %hi(gravity_ch)
    /* 9CC88 800AC488 21801102 */  addu       $s0, $s0, $s1
    /* 9CC8C 800AC48C 7000A48F */  lw         $a0, 0x70($sp)
    /* 9CC90 800AC490 21800202 */  addu       $s0, $s0, $v0
    /* 9CC94 800AC494 D46570AE */  sw         $s0, %lo(gravity_ch)($s3)
    /* 9CC98 800AC498 D001A58E */  lw         $a1, 0x1D0($s5)
    /* 9CC9C 800AC49C CA90030C */  jal        fixedmult
    /* 9CCA0 800AC4A0 D4657426 */   addiu     $s4, $s3, %lo(gravity_ch)
    /* 9CCA4 800AC4A4 7400A48F */  lw         $a0, 0x74($sp)
    /* 9CCA8 800AC4A8 D401A58E */  lw         $a1, 0x1D4($s5)
    /* 9CCAC 800AC4AC CA90030C */  jal        fixedmult
    /* 9CCB0 800AC4B0 21804000 */   addu      $s0, $v0, $zero
    /* 9CCB4 800AC4B4 7800A48F */  lw         $a0, 0x78($sp)
    /* 9CCB8 800AC4B8 D801A58E */  lw         $a1, 0x1D8($s5)
    /* 9CCBC 800AC4BC CA90030C */  jal        fixedmult
    /* 9CCC0 800AC4C0 21884000 */   addu      $s1, $v0, $zero
    /* 9CCC4 800AC4C4 21801102 */  addu       $s0, $s0, $s1
    /* 9CCC8 800AC4C8 7000A48F */  lw         $a0, 0x70($sp)
    /* 9CCCC 800AC4CC 21800202 */  addu       $s0, $s0, $v0
    /* 9CCD0 800AC4D0 040090AE */  sw         $s0, 0x4($s4)
    /* 9CCD4 800AC4D4 DC01A58E */  lw         $a1, 0x1DC($s5)
    /* 9CCD8 800AC4D8 CA90030C */  jal        fixedmult
    /* 9CCDC 800AC4DC 00000000 */   nop
    /* 9CCE0 800AC4E0 7400A48F */  lw         $a0, 0x74($sp)
    /* 9CCE4 800AC4E4 E001A58E */  lw         $a1, 0x1E0($s5)
    /* 9CCE8 800AC4E8 CA90030C */  jal        fixedmult
    /* 9CCEC 800AC4EC 21804000 */   addu      $s0, $v0, $zero
    /* 9CCF0 800AC4F0 7800A48F */  lw         $a0, 0x78($sp)
    /* 9CCF4 800AC4F4 E401A58E */  lw         $a1, 0x1E4($s5)
    /* 9CCF8 800AC4F8 CA90030C */  jal        fixedmult
    /* 9CCFC 800AC4FC 21884000 */   addu      $s1, $v0, $zero
    /* 9CD00 800AC500 2120A002 */  addu       $a0, $s5, $zero
    /* 9CD04 800AC504 21801102 */  addu       $s0, $s0, $s1
    /* 9CD08 800AC508 21800202 */  addu       $s0, $s0, $v0
    /* 9CD0C 800AC50C 080090AE */  sw         $s0, 0x8($s4)
    /* 9CD10 800AC510 9000A38F */  lw         $v1, 0x90($sp)
    /* 9CD14 800AC514 9400A58F */  lw         $a1, 0x94($sp)
    /* 9CD18 800AC518 9800A68F */  lw         $a2, 0x98($sp)
    /* 9CD1C 800AC51C 21107200 */  addu       $v0, $v1, $s2
    /* 9CD20 800AC520 23187200 */  subu       $v1, $v1, $s2
    /* 9CD24 800AC524 2000A2AF */  sw         $v0, 0x20($sp)
    /* 9CD28 800AC528 2400A5AF */  sw         $a1, 0x24($sp)
    /* 9CD2C 800AC52C 2800A6AF */  sw         $a2, 0x28($sp)
    /* 9CD30 800AC530 5000A3AF */  sw         $v1, 0x50($sp)
    /* 9CD34 800AC534 5400A5AF */  sw         $a1, 0x54($sp)
    /* 9CD38 800AC538 43A7020C */  jal        Physics_RampCarControlValues__FP8Car_tObj
    /* 9CD3C 800AC53C 5800A6AF */   sw        $a2, 0x58($sp)
    /* 9CD40 800AC540 D465638E */  lw         $v1, %lo(gravity_ch)($s3)
    /* 9CD44 800AC544 00000000 */  nop
    /* 9CD48 800AC548 02006104 */  bgez       $v1, .L800AC554
    /* 9CD4C 800AC54C 00000000 */   nop
    /* 9CD50 800AC550 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AC554:
    /* 9CD54 800AC554 031A0300 */  sra        $v1, $v1, 8
    /* 9CD58 800AC558 40100300 */  sll        $v0, $v1, 1
    /* 9CD5C 800AC55C 21104300 */  addu       $v0, $v0, $v1
    /* 9CD60 800AC560 001A0200 */  sll        $v1, $v0, 8
    /* 9CD64 800AC564 02006104 */  bgez       $v1, .L800AC570
    /* 9CD68 800AC568 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9CD6C 800AC56C 21186200 */  addu       $v1, $v1, $v0
  .L800AC570:
    /* 9CD70 800AC570 5004A28E */  lw         $v0, 0x450($s5)
    /* 9CD74 800AC574 03840300 */  sra        $s0, $v1, 16
    /* 9CD78 800AC578 21185000 */  addu       $v1, $v0, $s0
    /* 9CD7C 800AC57C 80006228 */  slti       $v0, $v1, 0x80
    /* 9CD80 800AC580 03004014 */  bnez       $v0, .L800AC590
    /* 9CD84 800AC584 81FF6228 */   slti      $v0, $v1, -0x7F
    /* 9CD88 800AC588 67B10208 */  j          .L800AC59C
    /* 9CD8C 800AC58C 7F000324 */   addiu     $v1, $zero, 0x7F
  .L800AC590:
    /* 9CD90 800AC590 02004010 */  beqz       $v0, .L800AC59C
    /* 9CD94 800AC594 00000000 */   nop
    /* 9CD98 800AC598 81FF0324 */  addiu      $v1, $zero, -0x7F
  .L800AC59C:
    /* 9CD9C 800AC59C 0C01C28E */  lw         $v0, 0x10C($s6)
    /* 9CDA0 800AC5A0 00000000 */  nop
    /* 9CDA4 800AC5A4 18006200 */  mult       $v1, $v0
    /* 9CDA8 800AC5A8 12100000 */  mflo       $v0
    /* 9CDAC 800AC5AC 03004104 */  bgez       $v0, .L800AC5BC
    /* 9CDB0 800AC5B0 C3290200 */   sra       $a1, $v0, 7
    /* 9CDB4 800AC5B4 7F004224 */  addiu      $v0, $v0, 0x7F
    /* 9CDB8 800AC5B8 C3290200 */  sra        $a1, $v0, 7
  .L800AC5BC:
    /* 9CDBC 800AC5BC 1C00A5AF */  sw         $a1, 0x1C($sp)
    /* 9CDC0 800AC5C0 1802A28E */  lw         $v0, 0x218($s5)
    /* 9CDC4 800AC5C4 1C02A38E */  lw         $v1, 0x21C($s5)
    /* 9CDC8 800AC5C8 00000000 */  nop
    /* 9CDCC 800AC5CC 21104300 */  addu       $v0, $v0, $v1
    /* 9CDD0 800AC5D0 2002A38E */  lw         $v1, 0x220($s5)
    /* 9CDD4 800AC5D4 3C02A48E */  lw         $a0, 0x23C($s5)
    /* 9CDD8 800AC5D8 21104300 */  addu       $v0, $v0, $v1
    /* 9CDDC 800AC5DC 21184400 */  addu       $v1, $v0, $a0
    /* 9CDE0 800AC5E0 02006104 */  bgez       $v1, .L800AC5EC
    /* 9CDE4 800AC5E4 21106000 */   addu      $v0, $v1, $zero
    /* 9CDE8 800AC5E8 FF016224 */  addiu      $v0, $v1, 0x1FF
  .L800AC5EC:
    /* 9CDEC 800AC5EC 431A0200 */  sra        $v1, $v0, 9
    /* 9CDF0 800AC5F0 2120A000 */  addu       $a0, $a1, $zero
    /* 9CDF4 800AC5F4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 9CDF8 800AC5F8 02008104 */  bgez       $a0, .L800AC604
    /* 9CDFC 800AC5FC 23104300 */   subu      $v0, $v0, $v1
    /* 9CE00 800AC600 FF008424 */  addiu      $a0, $a0, 0xFF
  .L800AC604:
    /* 9CE04 800AC604 02004104 */  bgez       $v0, .L800AC610
    /* 9CE08 800AC608 031A0400 */   sra       $v1, $a0, 8
    /* 9CE0C 800AC60C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC610:
    /* 9CE10 800AC610 03120200 */  sra        $v0, $v0, 8
    /* 9CE14 800AC614 18006200 */  mult       $v1, $v0
    /* 9CE18 800AC618 12400000 */  mflo       $t0
    /* 9CE1C 800AC61C 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 9CE20 800AC620 2004A48E */  lw         $a0, 0x420($s5)
    /* 9CE24 800AC624 3C00023C */  lui        $v0, (0x3C0000 >> 16)
    /* 9CE28 800AC628 2A104400 */  slt        $v0, $v0, $a0
    /* 9CE2C 800AC62C 08004010 */  beqz       $v0, .L800AC650
    /* 9CE30 800AC630 1A00023C */   lui       $v0, (0x1AB333 >> 16)
    /* 9CE34 800AC634 CA90030C */  jal        fixedmult
    /* 9CE38 800AC638 44040524 */   addiu     $a1, $zero, 0x444
    /* 9CE3C 800AC63C 1C00A48F */  lw         $a0, 0x1C($sp)
    /* 9CE40 800AC640 0191030C */  jal        rdiv
    /* 9CE44 800AC644 21284000 */   addu      $a1, $v0, $zero
    /* 9CE48 800AC648 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 9CE4C 800AC64C 1A00023C */  lui        $v0, (0x1AB333 >> 16)
  .L800AC650:
    /* 9CE50 800AC650 2004A38E */  lw         $v1, 0x420($s5)
    /* 9CE54 800AC654 33B34234 */  ori        $v0, $v0, (0x1AB333 & 0xFFFF)
    /* 9CE58 800AC658 2A104300 */  slt        $v0, $v0, $v1
    /* 9CE5C 800AC65C 0C004010 */  beqz       $v0, .L800AC690
    /* 9CE60 800AC660 0D00023C */   lui       $v0, (0xD6666 >> 16)
    /* 9CE64 800AC664 7804A38E */  lw         $v1, 0x478($s5)
    /* 9CE68 800AC668 00000000 */  nop
    /* 9CE6C 800AC66C CD0C6228 */  slti       $v0, $v1, 0xCCD
    /* 9CE70 800AC670 14004014 */  bnez       $v0, .L800AC6C4
    /* 9CE74 800AC674 34F36228 */   slti      $v0, $v1, -0xCCC
    /* 9CE78 800AC678 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 9CE7C 800AC67C 00000000 */  nop
    /* 9CE80 800AC680 1600401C */  bgtz       $v0, .L800AC6DC
    /* 9CE84 800AC684 34F36228 */   slti      $v0, $v1, -0xCCC
    /* 9CE88 800AC688 B1B10208 */  j          .L800AC6C4
    /* 9CE8C 800AC68C 00000000 */   nop
  .L800AC690:
    /* 9CE90 800AC690 66664234 */  ori        $v0, $v0, (0xD6666 & 0xFFFF)
    /* 9CE94 800AC694 2A104300 */  slt        $v0, $v0, $v1
    /* 9CE98 800AC698 20004010 */  beqz       $v0, .L800AC71C
    /* 9CE9C 800AC69C 2120A002 */   addu      $a0, $s5, $zero
    /* 9CEA0 800AC6A0 7804A38E */  lw         $v1, 0x478($s5)
    /* 9CEA4 800AC6A4 00000000 */  nop
    /* 9CEA8 800AC6A8 67266228 */  slti       $v0, $v1, 0x2667
    /* 9CEAC 800AC6AC 05004014 */  bnez       $v0, .L800AC6C4
    /* 9CEB0 800AC6B0 9AD96228 */   slti      $v0, $v1, -0x2666
    /* 9CEB4 800AC6B4 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 9CEB8 800AC6B8 00000000 */  nop
    /* 9CEBC 800AC6BC 0700401C */  bgtz       $v0, .L800AC6DC
    /* 9CEC0 800AC6C0 9AD96228 */   slti      $v0, $v1, -0x2666
  .L800AC6C4:
    /* 9CEC4 800AC6C4 15004010 */  beqz       $v0, .L800AC71C
    /* 9CEC8 800AC6C8 2120A002 */   addu      $a0, $s5, $zero
    /* 9CECC 800AC6CC 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 9CED0 800AC6D0 00000000 */  nop
    /* 9CED4 800AC6D4 12004104 */  bgez       $v0, .L800AC720
    /* 9CED8 800AC6D8 01000224 */   addiu     $v0, $zero, 0x1
  .L800AC6DC:
    /* 9CEDC 800AC6DC 7804A28E */  lw         $v0, 0x478($s5)
    /* 9CEE0 800AC6E0 0100053C */  lui        $a1, (0x10000 >> 16)
    /* 9CEE4 800AC6E4 02004104 */  bgez       $v0, .L800AC6F0
    /* 9CEE8 800AC6E8 00000000 */   nop
    /* 9CEEC 800AC6EC 23100200 */  negu       $v0, $v0
  .L800AC6F0:
    /* 9CEF0 800AC6F0 40180200 */  sll        $v1, $v0, 1
    /* 9CEF4 800AC6F4 2110A000 */  addu       $v0, $a1, $zero
    /* 9CEF8 800AC6F8 2A104300 */  slt        $v0, $v0, $v1
    /* 9CEFC 800AC6FC 02004014 */  bnez       $v0, .L800AC708
    /* 9CF00 800AC700 00000000 */   nop
    /* 9CF04 800AC704 21286000 */  addu       $a1, $v1, $zero
  .L800AC708:
    /* 9CF08 800AC708 1C00A48F */  lw         $a0, 0x1C($sp)
    /* 9CF0C 800AC70C CA90030C */  jal        fixedmult
    /* 9CF10 800AC710 00000000 */   nop
    /* 9CF14 800AC714 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 9CF18 800AC718 2120A002 */  addu       $a0, $s5, $zero
  .L800AC71C:
    /* 9CF1C 800AC71C 01000224 */  addiu      $v0, $zero, 0x1
  .L800AC720:
    /* 9CF20 800AC720 4C00A0AF */  sw         $zero, 0x4C($sp)
    /* 9CF24 800AC724 3800A2AF */  sw         $v0, 0x38($sp)
    /* 9CF28 800AC728 61AA020C */  jal        Physics_CalculateCarAcceleration__FP8Car_tObj
    /* 9CF2C 800AC72C 6800A0AF */   sw        $zero, 0x68($sp)
    /* 9CF30 800AC730 21204000 */  addu       $a0, $v0, $zero
    /* 9CF34 800AC734 02008104 */  bgez       $a0, .L800AC740
    /* 9CF38 800AC738 21188000 */   addu      $v1, $a0, $zero
    /* 9CF3C 800AC73C FF008324 */  addiu      $v1, $a0, 0xFF
  .L800AC740:
    /* 9CF40 800AC740 F800C28E */  lw         $v0, 0xF8($s6)
    /* 9CF44 800AC744 00000000 */  nop
    /* 9CF48 800AC748 02004104 */  bgez       $v0, .L800AC754
    /* 9CF4C 800AC74C 031A0300 */   sra       $v1, $v1, 8
    /* 9CF50 800AC750 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC754:
    /* 9CF54 800AC754 03120200 */  sra        $v0, $v0, 8
    /* 9CF58 800AC758 18006200 */  mult       $v1, $v0
    /* 9CF5C 800AC75C D00D838F */  lw         $v1, %gp_rel(steeringControl)($gp)
    /* 9CF60 800AC760 12100000 */  mflo       $v0
    /* 9CF64 800AC764 1000A2AF */  sw         $v0, 0x10($sp)
    /* 9CF68 800AC768 23108200 */  subu       $v0, $a0, $v0
    /* 9CF6C 800AC76C 08006014 */  bnez       $v1, .L800AC790
    /* 9CF70 800AC770 4000A2AF */   sw        $v0, 0x40($sp)
    /* 9CF74 800AC774 D40D828F */  lw         $v0, %gp_rel(powerControl)($gp)
    /* 9CF78 800AC778 00000000 */  nop
    /* 9CF7C 800AC77C 04004014 */  bnez       $v0, .L800AC790
    /* 9CF80 800AC780 00000000 */   nop
    /* 9CF84 800AC784 8404A0AE */  sw         $zero, 0x484($s5)
    /* 9CF88 800AC788 47B50208 */  j          .L800AD51C
    /* 9CF8C 800AC78C 8804A0AE */   sw        $zero, 0x488($s5)
  .L800AC790:
    /* 9CF90 800AC790 A40D838F */  lw         $v1, %gp_rel(gBrakeRatio)($gp)
    /* 9CF94 800AC794 00000000 */  nop
    /* 9CF98 800AC798 02006104 */  bgez       $v1, .L800AC7A4
    /* 9CF9C 800AC79C EC03A0AE */   sw        $zero, 0x3EC($s5)
    /* 9CFA0 800AC7A0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AC7A4:
    /* 9CFA4 800AC7A4 FC00C28E */  lw         $v0, 0xFC($s6)
    /* 9CFA8 800AC7A8 00000000 */  nop
    /* 9CFAC 800AC7AC 02004104 */  bgez       $v0, .L800AC7B8
    /* 9CFB0 800AC7B0 03220300 */   sra       $a0, $v1, 8
    /* 9CFB4 800AC7B4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC7B8:
    /* 9CFB8 800AC7B8 03120200 */  sra        $v0, $v0, 8
    /* 9CFBC 800AC7BC 18008200 */  mult       $a0, $v0
    /* 9CFC0 800AC7C0 2004A28E */  lw         $v0, 0x420($s5)
    /* 9CFC4 800AC7C4 00000000 */  nop
    /* 9CFC8 800AC7C8 02004104 */  bgez       $v0, .L800AC7D4
    /* 9CFCC 800AC7CC 00000000 */   nop
    /* 9CFD0 800AC7D0 23100200 */  negu       $v0, $v0
  .L800AC7D4:
    /* 9CFD4 800AC7D4 40110200 */  sll        $v0, $v0, 5
    /* 9CFD8 800AC7D8 21204000 */  addu       $a0, $v0, $zero
    /* 9CFDC 800AC7DC 12800000 */  mflo       $s0
    /* 9CFE0 800AC7E0 2A109000 */  slt        $v0, $a0, $s0
    /* 9CFE4 800AC7E4 02004014 */  bnez       $v0, .L800AC7F0
    /* 9CFE8 800AC7E8 00000000 */   nop
    /* 9CFEC 800AC7EC 21200002 */  addu       $a0, $s0, $zero
  .L800AC7F0:
    /* 9CFF0 800AC7F0 3C02A38E */  lw         $v1, 0x23C($s5)
    /* 9CFF4 800AC7F4 00000000 */  nop
    /* 9CFF8 800AC7F8 0F006010 */  beqz       $v1, .L800AC838
    /* 9CFFC 800AC7FC 21808000 */   addu      $s0, $a0, $zero
    /* 9D000 800AC800 02006104 */  bgez       $v1, .L800AC80C
    /* 9D004 800AC804 21200002 */   addu      $a0, $s0, $zero
    /* 9D008 800AC808 7F006324 */  addiu      $v1, $v1, 0x7F
  .L800AC80C:
    /* 9D00C 800AC80C C3190300 */  sra        $v1, $v1, 7
    /* 9D010 800AC810 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 9D014 800AC814 02000106 */  bgez       $s0, .L800AC820
    /* 9D018 800AC818 23104300 */   subu      $v0, $v0, $v1
    /* 9D01C 800AC81C FF000426 */  addiu      $a0, $s0, 0xFF
  .L800AC820:
    /* 9D020 800AC820 02004104 */  bgez       $v0, .L800AC82C
    /* 9D024 800AC824 03220400 */   sra       $a0, $a0, 8
    /* 9D028 800AC828 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC82C:
    /* 9D02C 800AC82C 03120200 */  sra        $v0, $v0, 8
    /* 9D030 800AC830 18008200 */  mult       $a0, $v0
    /* 9D034 800AC834 12800000 */  mflo       $s0
  .L800AC838:
    /* 9D038 800AC838 2004A28E */  lw         $v0, 0x420($s5)
    /* 9D03C 800AC83C 00000000 */  nop
    /* 9D040 800AC840 02004018 */  blez       $v0, .L800AC84C
    /* 9D044 800AC844 00000000 */   nop
    /* 9D048 800AC848 23801000 */  negu       $s0, $s0
  .L800AC84C:
    /* 9D04C 800AC84C 0001C58E */  lw         $a1, 0x100($s6)
    /* 9D050 800AC850 CA90030C */  jal        fixedmult
    /* 9D054 800AC854 21200002 */   addu      $a0, $s0, $zero
    /* 9D058 800AC858 1000A38F */  lw         $v1, 0x10($sp)
    /* 9D05C 800AC85C 00000000 */  nop
    /* 9D060 800AC860 21186200 */  addu       $v1, $v1, $v0
    /* 9D064 800AC864 1000A3AF */  sw         $v1, 0x10($sp)
    /* 9D068 800AC868 4000A38F */  lw         $v1, 0x40($sp)
    /* 9D06C 800AC86C 23100202 */  subu       $v0, $s0, $v0
    /* 9D070 800AC870 21186200 */  addu       $v1, $v1, $v0
    /* 9D074 800AC874 1180023C */  lui        $v0, %hi(D_801165D8)
    /* 9D078 800AC878 D865448C */  lw         $a0, %lo(D_801165D8)($v0)
    /* 9D07C 800AC87C 4000A3AF */  sw         $v1, 0x40($sp)
    /* 9D080 800AC880 1401C58E */  lw         $a1, 0x114($s6)
    /* 9D084 800AC884 CA90030C */  jal        fixedmult
    /* 9D088 800AC888 23200400 */   negu      $a0, $a0
    /* 9D08C 800AC88C 21884000 */  addu       $s1, $v0, $zero
    /* 9D090 800AC890 02AA020C */  jal        Physics_CalculateRoadGripModifiers__FP8Car_tObj
    /* 9D094 800AC894 2120A002 */   addu      $a0, $s5, $zero
    /* 9D098 800AC898 02002106 */  bgez       $s1, .L800AC8A4
    /* 9D09C 800AC89C 21182002 */   addu      $v1, $s1, $zero
    /* 9D0A0 800AC8A0 FF002326 */  addiu      $v1, $s1, 0xFF
  .L800AC8A4:
    /* 9D0A4 800AC8A4 B80D828F */  lw         $v0, %gp_rel(roadMult)($gp)
    /* 9D0A8 800AC8A8 00000000 */  nop
    /* 9D0AC 800AC8AC 02004104 */  bgez       $v0, .L800AC8B8
    /* 9D0B0 800AC8B0 03220300 */   sra       $a0, $v1, 8
    /* 9D0B4 800AC8B4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC8B8:
    /* 9D0B8 800AC8B8 03120200 */  sra        $v0, $v0, 8
    /* 9D0BC 800AC8BC 18008200 */  mult       $a0, $v0
    /* 9D0C0 800AC8C0 12880000 */  mflo       $s1
    /* 9D0C4 800AC8C4 15032006 */  bltz       $s1, .L800AD51C
    /* 9D0C8 800AC8C8 00000000 */   nop
    /* 9D0CC 800AC8CC CC0D828F */  lw         $v0, %gp_rel(slippery)($gp)
    /* 9D0D0 800AC8D0 00000000 */  nop
    /* 9D0D4 800AC8D4 04004010 */  beqz       $v0, .L800AC8E8
    /* 9D0D8 800AC8D8 21202002 */   addu      $a0, $s1, $zero
    /* 9D0DC 800AC8DC 0801C58E */  lw         $a1, 0x108($s6)
    /* 9D0E0 800AC8E0 3BB20208 */  j          .L800AC8EC
    /* 9D0E4 800AC8E4 8F02A524 */   addiu     $a1, $a1, 0x28F
  .L800AC8E8:
    /* 9D0E8 800AC8E8 0801C58E */  lw         $a1, 0x108($s6)
  .L800AC8EC:
    /* 9D0EC 800AC8EC CA90030C */  jal        fixedmult
    /* 9D0F0 800AC8F0 00000000 */   nop
    /* 9D0F4 800AC8F4 21904000 */  addu       $s2, $v0, $zero
    /* 9D0F8 800AC8F8 2802A28E */  lw         $v0, 0x228($s5)
    /* 9D0FC 800AC8FC 2C02A38E */  lw         $v1, 0x22C($s5)
    /* 9D100 800AC900 00000000 */  nop
    /* 9D104 800AC904 21104300 */  addu       $v0, $v0, $v1
    /* 9D108 800AC908 3002A38E */  lw         $v1, 0x230($s5)
    /* 9D10C 800AC90C 3C02A48E */  lw         $a0, 0x23C($s5)
    /* 9D110 800AC910 21104300 */  addu       $v0, $v0, $v1
    /* 9D114 800AC914 21104400 */  addu       $v0, $v0, $a0
    /* 9D118 800AC918 03004104 */  bgez       $v0, .L800AC928
    /* 9D11C 800AC91C 431A0200 */   sra       $v1, $v0, 9
    /* 9D120 800AC920 FF014224 */  addiu      $v0, $v0, 0x1FF
    /* 9D124 800AC924 431A0200 */  sra        $v1, $v0, 9
  .L800AC928:
    /* 9D128 800AC928 00C00234 */  ori        $v0, $zero, 0xC000
    /* 9D12C 800AC92C 21806200 */  addu       $s0, $v1, $v0
    /* 9D130 800AC930 7C04A48E */  lw         $a0, 0x47C($s5)
    /* 9D134 800AC934 CA90030C */  jal        fixedmult
    /* 9D138 800AC938 21280002 */   addu      $a1, $s0, $zero
    /* 9D13C 800AC93C 21204000 */  addu       $a0, $v0, $zero
    /* 9D140 800AC940 0B008104 */  bgez       $a0, .L800AC970
    /* 9D144 800AC944 7C04A4AE */   sw        $a0, 0x47C($s5)
    /* 9D148 800AC948 21280002 */  addu       $a1, $s0, $zero
    /* 9D14C 800AC94C FF008224 */  addiu      $v0, $a0, 0xFF
    /* 9D150 800AC950 0200A104 */  bgez       $a1, .L800AC95C
    /* 9D154 800AC954 031A0200 */   sra       $v1, $v0, 8
    /* 9D158 800AC958 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L800AC95C:
    /* 9D15C 800AC95C 03120500 */  sra        $v0, $a1, 8
    /* 9D160 800AC960 18006200 */  mult       $v1, $v0
    /* 9D164 800AC964 12400000 */  mflo       $t0
    /* 9D168 800AC968 64B20208 */  j          .L800AC990
    /* 9D16C 800AC96C 7C04A8AE */   sw        $t0, 0x47C($s5)
  .L800AC970:
    /* 9D170 800AC970 07008018 */  blez       $a0, .L800AC990
    /* 9D174 800AC974 40100400 */   sll       $v0, $a0, 1
    /* 9D178 800AC978 21104400 */  addu       $v0, $v0, $a0
    /* 9D17C 800AC97C 02004104 */  bgez       $v0, .L800AC988
    /* 9D180 800AC980 00000000 */   nop
    /* 9D184 800AC984 03004224 */  addiu      $v0, $v0, 0x3
  .L800AC988:
    /* 9D188 800AC988 83100200 */  sra        $v0, $v0, 2
    /* 9D18C 800AC98C 7C04A2AE */  sw         $v0, 0x47C($s5)
  .L800AC990:
    /* 9D190 800AC990 7C04A28E */  lw         $v0, 0x47C($s5)
    /* 9D194 800AC994 BC0D838F */  lw         $v1, %gp_rel(frontMult)($gp)
    /* 9D198 800AC998 23104202 */  subu       $v0, $s2, $v0
    /* 9D19C 800AC99C 02006104 */  bgez       $v1, .L800AC9A8
    /* 9D1A0 800AC9A0 1400A2AF */   sw        $v0, 0x14($sp)
    /* 9D1A4 800AC9A4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AC9A8:
    /* 9D1A8 800AC9A8 02004104 */  bgez       $v0, .L800AC9B4
    /* 9D1AC 800AC9AC 031A0300 */   sra       $v1, $v1, 8
    /* 9D1B0 800AC9B0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC9B4:
    /* 9D1B4 800AC9B4 03120200 */  sra        $v0, $v0, 8
    /* 9D1B8 800AC9B8 18006200 */  mult       $v1, $v0
    /* 9D1BC 800AC9BC 23103202 */  subu       $v0, $s1, $s2
    /* 9D1C0 800AC9C0 12400000 */  mflo       $t0
    /* 9D1C4 800AC9C4 1400A8AF */  sw         $t0, 0x14($sp)
    /* 9D1C8 800AC9C8 7C04A38E */  lw         $v1, 0x47C($s5)
    /* 9D1CC 800AC9CC C00D848F */  lw         $a0, %gp_rel(rearMult)($gp)
    /* 9D1D0 800AC9D0 21104300 */  addu       $v0, $v0, $v1
    /* 9D1D4 800AC9D4 02008104 */  bgez       $a0, .L800AC9E0
    /* 9D1D8 800AC9D8 4400A2AF */   sw        $v0, 0x44($sp)
    /* 9D1DC 800AC9DC FF008424 */  addiu      $a0, $a0, 0xFF
  .L800AC9E0:
    /* 9D1E0 800AC9E0 02004104 */  bgez       $v0, .L800AC9EC
    /* 9D1E4 800AC9E4 031A0400 */   sra       $v1, $a0, 8
    /* 9D1E8 800AC9E8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AC9EC:
    /* 9D1EC 800AC9EC 03120200 */  sra        $v0, $v0, 8
    /* 9D1F0 800AC9F0 18006200 */  mult       $v1, $v0
    /* 9D1F4 800AC9F4 D00D828F */  lw         $v0, %gp_rel(steeringControl)($gp)
    /* 9D1F8 800AC9F8 12400000 */  mflo       $t0
    /* 9D1FC 800AC9FC 4400A8AF */  sw         $t0, 0x44($sp)
    /* 9D200 800ACA00 7404A0AE */  sw         $zero, 0x474($s5)
    /* 9D204 800ACA04 2C00A0AF */  sw         $zero, 0x2C($sp)
    /* 9D208 800ACA08 3400A0AF */  sw         $zero, 0x34($sp)
    /* 9D20C 800ACA0C 5C00A0AF */  sw         $zero, 0x5C($sp)
    /* 9D210 800ACA10 04004010 */  beqz       $v0, .L800ACA24
    /* 9D214 800ACA14 6400A0AF */   sw        $zero, 0x64($sp)
    /* 9D218 800ACA18 2120A002 */  addu       $a0, $s5, $zero
    /* 9D21C 800ACA1C 8FAE020C */  jal        Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9D220 800ACA20 1000A527 */   addiu     $a1, $sp, 0x10
  .L800ACA24:
    /* 9D224 800ACA24 D40D828F */  lw         $v0, %gp_rel(powerControl)($gp)
    /* 9D228 800ACA28 00000000 */  nop
    /* 9D22C 800ACA2C 03004010 */  beqz       $v0, .L800ACA3C
    /* 9D230 800ACA30 2120A002 */   addu      $a0, $s5, $zero
    /* 9D234 800ACA34 8FAE020C */  jal        Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9D238 800ACA38 4000A527 */   addiu     $a1, $sp, 0x40
  .L800ACA3C:
    /* 9D23C 800ACA3C 3400A28F */  lw         $v0, 0x34($sp)
    /* 9D240 800ACA40 6400A38F */  lw         $v1, 0x64($sp)
    /* 9D244 800ACA44 00000000 */  nop
    /* 9D248 800ACA48 21104300 */  addu       $v0, $v0, $v1
    /* 9D24C 800ACA4C 1404A2AE */  sw         $v0, 0x414($s5)
    /* 9D250 800ACA50 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 9D254 800ACA54 5C00A38F */  lw         $v1, 0x5C($sp)
    /* 9D258 800ACA58 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D25C 800ACA5C 21104300 */  addu       $v0, $v0, $v1
    /* 9D260 800ACA60 0C04A2AE */  sw         $v0, 0x40C($s5)
    /* 9D264 800ACA64 CC01C58E */  lw         $a1, 0x1CC($s6)
    /* 9D268 800ACA68 CA90030C */  jal        fixedmult
    /* 9D26C 800ACA6C 00000000 */   nop
    /* 9D270 800ACA70 21204000 */  addu       $a0, $v0, $zero
    /* 9D274 800ACA74 1180023C */  lui        $v0, %hi(D_80113224)
    /* 9D278 800ACA78 1404A4AE */  sw         $a0, 0x414($s5)
    /* 9D27C 800ACA7C 2432438C */  lw         $v1, %lo(D_80113224)($v0)
    /* 9D280 800ACA80 80000224 */  addiu      $v0, $zero, 0x80
    /* 9D284 800ACA84 08006214 */  bne        $v1, $v0, .L800ACAA8
    /* 9D288 800ACA88 00000000 */   nop
    /* 9D28C 800ACA8C 06008018 */  blez       $a0, .L800ACAA8
    /* 9D290 800ACA90 00000000 */   nop
    /* 9D294 800ACA94 4604A292 */  lbu        $v0, 0x446($s5)
    /* 9D298 800ACA98 00000000 */  nop
    /* 9D29C 800ACA9C 02004010 */  beqz       $v0, .L800ACAA8
    /* 9D2A0 800ACAA0 80100400 */   sll       $v0, $a0, 2
    /* 9D2A4 800ACAA4 1404A2AE */  sw         $v0, 0x414($s5)
  .L800ACAA8:
    /* 9D2A8 800ACAA8 CC0D828F */  lw         $v0, %gp_rel(slippery)($gp)
    /* 9D2AC 800ACAAC 00000000 */  nop
    /* 9D2B0 800ACAB0 15004014 */  bnez       $v0, .L800ACB08
    /* 9D2B4 800ACAB4 1180023C */   lui       $v0, %hi(D_801165DC)
    /* 9D2B8 800ACAB8 8802A28E */  lw         $v0, 0x288($s5)
    /* 9D2BC 800ACABC 00000000 */  nop
    /* 9D2C0 800ACAC0 3800438C */  lw         $v1, 0x38($v0)
    /* 9D2C4 800ACAC4 02000224 */  addiu      $v0, $zero, 0x2
    /* 9D2C8 800ACAC8 09006214 */  bne        $v1, $v0, .L800ACAF0
    /* 9D2CC 800ACACC 0100053C */   lui       $a1, (0x12666 >> 16)
    /* 9D2D0 800ACAD0 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D2D4 800ACAD4 00000000 */  nop
    /* 9D2D8 800ACAD8 0400422C */  sltiu      $v0, $v0, 0x4
    /* 9D2DC 800ACADC 04004010 */  beqz       $v0, .L800ACAF0
    /* 9D2E0 800ACAE0 00000000 */   nop
    /* 9D2E4 800ACAE4 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D2E8 800ACAE8 BEB20208 */  j          .L800ACAF8
    /* 9D2EC 800ACAEC 6626A534 */   ori       $a1, $a1, (0x12666 & 0xFFFF)
  .L800ACAF0:
    /* 9D2F0 800ACAF0 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D2F4 800ACAF4 9919A534 */  ori        $a1, $a1, (0x11999 & 0xFFFF)
  .L800ACAF8:
    /* 9D2F8 800ACAF8 CA90030C */  jal        fixedmult
    /* 9D2FC 800ACAFC 00000000 */   nop
    /* 9D300 800ACB00 1404A2AE */  sw         $v0, 0x414($s5)
    /* 9D304 800ACB04 1180023C */  lui        $v0, %hi(D_801165DC)
  .L800ACB08:
    /* 9D308 800ACB08 1004A0AE */  sw         $zero, 0x410($s5)
    /* 9D30C 800ACB0C DC65448C */  lw         $a0, %lo(D_801165DC)($v0)
    /* 9D310 800ACB10 CA90030C */  jal        fixedmult
    /* 9D314 800ACB14 99190524 */   addiu     $a1, $zero, 0x1999
    /* 9D318 800ACB18 0C04A48E */  lw         $a0, 0x40C($s5)
    /* 9D31C 800ACB1C 00000000 */  nop
    /* 9D320 800ACB20 02008104 */  bgez       $a0, .L800ACB2C
    /* 9D324 800ACB24 23800200 */   negu      $s0, $v0
    /* 9D328 800ACB28 07008424 */  addiu      $a0, $a0, 0x7
  .L800ACB2C:
    /* 9D32C 800ACB2C 2401C58E */  lw         $a1, 0x124($s6)
    /* 9D330 800ACB30 CA90030C */  jal        fixedmult
    /* 9D334 800ACB34 C3200400 */   sra       $a0, $a0, 3
    /* 9D338 800ACB38 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D33C 800ACB3C 23100200 */  negu       $v0, $v0
    /* 9D340 800ACB40 8004A2AE */  sw         $v0, 0x480($s5)
    /* 9D344 800ACB44 2401C58E */  lw         $a1, 0x124($s6)
    /* 9D348 800ACB48 CA90030C */  jal        fixedmult
    /* 9D34C 800ACB4C 00000000 */   nop
    /* 9D350 800ACB50 21105000 */  addu       $v0, $v0, $s0
    /* 9D354 800ACB54 7C04A2AE */  sw         $v0, 0x47C($s5)
    /* 9D358 800ACB58 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 9D35C 800ACB5C 5C00A48F */  lw         $a0, 0x5C($sp)
    /* 9D360 800ACB60 C801C58E */  lw         $a1, 0x1C8($s6)
    /* 9D364 800ACB64 CA90030C */  jal        fixedmult
    /* 9D368 800ACB68 23204400 */   subu      $a0, $v0, $a0
    /* 9D36C 800ACB6C 21804000 */  addu       $s0, $v0, $zero
    /* 9D370 800ACB70 3400A68F */  lw         $a2, 0x34($sp)
    /* 9D374 800ACB74 6400A48F */  lw         $a0, 0x64($sp)
    /* 9D378 800ACB78 C40D838F */  lw         $v1, %gp_rel(leftMult)($gp)
    /* 9D37C 800ACB7C C80D858F */  lw         $a1, %gp_rel(rightMult)($gp)
    /* 9D380 800ACB80 2120C400 */  addu       $a0, $a2, $a0
    /* 9D384 800ACB84 CA90030C */  jal        fixedmult
    /* 9D388 800ACB88 23286500 */   subu      $a1, $v1, $a1
    /* 9D38C 800ACB8C C801C58E */  lw         $a1, 0x1C8($s6)
    /* 9D390 800ACB90 CA90030C */  jal        fixedmult
    /* 9D394 800ACB94 21204000 */   addu      $a0, $v0, $zero
    /* 9D398 800ACB98 40100200 */  sll        $v0, $v0, 1
    /* 9D39C 800ACB9C 21800202 */  addu       $s0, $s0, $v0
    /* 9D3A0 800ACBA0 8400B0AF */  sw         $s0, 0x84($sp)
    /* 9D3A4 800ACBA4 1801A28E */  lw         $v0, 0x118($s5)
    /* 9D3A8 800ACBA8 00000000 */  nop
    /* 9D3AC 800ACBAC 03004018 */  blez       $v0, .L800ACBBC
    /* 9D3B0 800ACBB0 00000000 */   nop
    /* 9D3B4 800ACBB4 0500001E */  bgtz       $s0, .L800ACBCC
    /* 9D3B8 800ACBB8 00000000 */   nop
  .L800ACBBC:
    /* 9D3BC 800ACBBC 2F004104 */  bgez       $v0, .L800ACC7C
    /* 9D3C0 800ACBC0 00000000 */   nop
    /* 9D3C4 800ACBC4 2D000106 */  bgez       $s0, .L800ACC7C
    /* 9D3C8 800ACBC8 00000000 */   nop
  .L800ACBCC:
    /* 9D3CC 800ACBCC 4504A292 */  lbu        $v0, 0x445($s5)
    /* 9D3D0 800ACBD0 00000000 */  nop
    /* 9D3D4 800ACBD4 0C004010 */  beqz       $v0, .L800ACC08
    /* 9D3D8 800ACBD8 1180023C */   lui       $v0, %hi(D_80113224)
    /* 9D3DC 800ACBDC 2432428C */  lw         $v0, %lo(D_80113224)($v0)
    /* 9D3E0 800ACBE0 00000000 */  nop
    /* 9D3E4 800ACBE4 08004230 */  andi       $v0, $v0, 0x8
    /* 9D3E8 800ACBE8 07004014 */  bnez       $v0, .L800ACC08
    /* 9D3EC 800ACBEC 00000000 */   nop
    /* 9D3F0 800ACBF0 8400A28F */  lw         $v0, 0x84($sp)
    /* 9D3F4 800ACBF4 00000000 */  nop
    /* 9D3F8 800ACBF8 C21F0200 */  srl        $v1, $v0, 31
    /* 9D3FC 800ACBFC 21104300 */  addu       $v0, $v0, $v1
    /* 9D400 800ACC00 1EB30208 */  j          .L800ACC78
    /* 9D404 800ACC04 43100200 */   sra       $v0, $v0, 1
  .L800ACC08:
    /* 9D408 800ACC08 4C04A38E */  lw         $v1, 0x44C($s5)
    /* 9D40C 800ACC0C 00000000 */  nop
    /* 9D410 800ACC10 06006104 */  bgez       $v1, .L800ACC2C
    /* 9D414 800ACC14 00000000 */   nop
    /* 9D418 800ACC18 1801A28E */  lw         $v0, 0x118($s5)
    /* 9D41C 800ACC1C 00000000 */  nop
    /* 9D420 800ACC20 34334228 */  slti       $v0, $v0, 0x3334
    /* 9D424 800ACC24 08004010 */  beqz       $v0, .L800ACC48
    /* 9D428 800ACC28 00000000 */   nop
  .L800ACC2C:
    /* 9D42C 800ACC2C 0D006018 */  blez       $v1, .L800ACC64
    /* 9D430 800ACC30 00000000 */   nop
    /* 9D434 800ACC34 1801A28E */  lw         $v0, 0x118($s5)
    /* 9D438 800ACC38 00000000 */  nop
    /* 9D43C 800ACC3C CDCC4228 */  slti       $v0, $v0, -0x3333
    /* 9D440 800ACC40 08004010 */  beqz       $v0, .L800ACC64
    /* 9D444 800ACC44 00000000 */   nop
  .L800ACC48:
    /* 9D448 800ACC48 6C04A38E */  lw         $v1, 0x46C($s5)
    /* 9D44C 800ACC4C 01000224 */  addiu      $v0, $zero, 0x1
    /* 9D450 800ACC50 04006214 */  bne        $v1, $v0, .L800ACC64
    /* 9D454 800ACC54 00000000 */   nop
    /* 9D458 800ACC58 1801A28E */  lw         $v0, 0x118($s5)
    /* 9D45C 800ACC5C 1EB30208 */  j          .L800ACC78
    /* 9D460 800ACC60 23100200 */   negu      $v0, $v0
  .L800ACC64:
    /* 9D464 800ACC64 6404A28E */  lw         $v0, 0x464($s5)
    /* 9D468 800ACC68 8400A48F */  lw         $a0, 0x84($sp)
    /* 9D46C 800ACC6C 2C01458C */  lw         $a1, 0x12C($v0)
    /* 9D470 800ACC70 CA90030C */  jal        fixedmult
    /* 9D474 800ACC74 00000000 */   nop
  .L800ACC78:
    /* 9D478 800ACC78 8400A2AF */  sw         $v0, 0x84($sp)
  .L800ACC7C:
    /* 9D47C 800ACC7C C401A426 */  addiu      $a0, $s5, 0x1C4
    /* 9D480 800ACC80 A000A527 */  addiu      $a1, $sp, 0xA0
    /* 9D484 800ACC84 8000A0AF */  sw         $zero, 0x80($sp)
    /* 9D488 800ACC88 D690030C */  jal        transpose
    /* 9D48C 800ACC8C 8800A0AF */   sw        $zero, 0x88($sp)
    /* 9D490 800ACC90 2120A002 */  addu       $a0, $s5, $zero
    /* 9D494 800ACC94 6117020C */  jal        Cars_DoGravityEffectsOnAcc__FP8Car_tObji
    /* 9D498 800ACC98 21280000 */   addu      $a1, $zero, $zero
    /* 9D49C 800ACC9C 0C04A48E */  lw         $a0, 0x40C($s5)
    /* 9D4A0 800ACCA0 A000A58F */  lw         $a1, 0xA0($sp)
    /* 9D4A4 800ACCA4 CA90030C */  jal        fixedmult
    /* 9D4A8 800ACCA8 00000000 */   nop
    /* 9D4AC 800ACCAC 1004A48E */  lw         $a0, 0x410($s5)
    /* 9D4B0 800ACCB0 A400A58F */  lw         $a1, 0xA4($sp)
    /* 9D4B4 800ACCB4 CA90030C */  jal        fixedmult
    /* 9D4B8 800ACCB8 21804000 */   addu      $s0, $v0, $zero
    /* 9D4BC 800ACCBC 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D4C0 800ACCC0 A800A58F */  lw         $a1, 0xA8($sp)
    /* 9D4C4 800ACCC4 CA90030C */  jal        fixedmult
    /* 9D4C8 800ACCC8 21884000 */   addu      $s1, $v0, $zero
    /* 9D4CC 800ACCCC 21801102 */  addu       $s0, $s0, $s1
    /* 9D4D0 800ACCD0 0C04A48E */  lw         $a0, 0x40C($s5)
    /* 9D4D4 800ACCD4 21800202 */  addu       $s0, $s0, $v0
    /* 9D4D8 800ACCD8 0004B0AE */  sw         $s0, 0x400($s5)
    /* 9D4DC 800ACCDC AC00A58F */  lw         $a1, 0xAC($sp)
    /* 9D4E0 800ACCE0 CA90030C */  jal        fixedmult
    /* 9D4E4 800ACCE4 00000000 */   nop
    /* 9D4E8 800ACCE8 1004A48E */  lw         $a0, 0x410($s5)
    /* 9D4EC 800ACCEC B000A58F */  lw         $a1, 0xB0($sp)
    /* 9D4F0 800ACCF0 CA90030C */  jal        fixedmult
    /* 9D4F4 800ACCF4 21804000 */   addu      $s0, $v0, $zero
    /* 9D4F8 800ACCF8 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D4FC 800ACCFC B400A58F */  lw         $a1, 0xB4($sp)
    /* 9D500 800ACD00 CA90030C */  jal        fixedmult
    /* 9D504 800ACD04 21884000 */   addu      $s1, $v0, $zero
    /* 9D508 800ACD08 21801102 */  addu       $s0, $s0, $s1
    /* 9D50C 800ACD0C 0C04A48E */  lw         $a0, 0x40C($s5)
    /* 9D510 800ACD10 21800202 */  addu       $s0, $s0, $v0
    /* 9D514 800ACD14 0404B0AE */  sw         $s0, 0x404($s5)
    /* 9D518 800ACD18 B800A58F */  lw         $a1, 0xB8($sp)
    /* 9D51C 800ACD1C CA90030C */  jal        fixedmult
    /* 9D520 800ACD20 00000000 */   nop
    /* 9D524 800ACD24 1004A48E */  lw         $a0, 0x410($s5)
    /* 9D528 800ACD28 BC00A58F */  lw         $a1, 0xBC($sp)
    /* 9D52C 800ACD2C CA90030C */  jal        fixedmult
    /* 9D530 800ACD30 21804000 */   addu      $s0, $v0, $zero
    /* 9D534 800ACD34 1404A48E */  lw         $a0, 0x414($s5)
    /* 9D538 800ACD38 C000A58F */  lw         $a1, 0xC0($sp)
    /* 9D53C 800ACD3C CA90030C */  jal        fixedmult
    /* 9D540 800ACD40 21884000 */   addu      $s1, $v0, $zero
    /* 9D544 800ACD44 21801102 */  addu       $s0, $s0, $s1
    /* 9D548 800ACD48 21800202 */  addu       $s0, $s0, $v0
    /* 9D54C 800ACD4C 0804B0AE */  sw         $s0, 0x408($s5)
    /* 9D550 800ACD50 8000A48F */  lw         $a0, 0x80($sp)
    /* 9D554 800ACD54 A000A58F */  lw         $a1, 0xA0($sp)
    /* 9D558 800ACD58 CA90030C */  jal        fixedmult
    /* 9D55C 800ACD5C 00000000 */   nop
    /* 9D560 800ACD60 8400A48F */  lw         $a0, 0x84($sp)
    /* 9D564 800ACD64 A400A58F */  lw         $a1, 0xA4($sp)
    /* 9D568 800ACD68 CA90030C */  jal        fixedmult
    /* 9D56C 800ACD6C 21804000 */   addu      $s0, $v0, $zero
    /* 9D570 800ACD70 8800A48F */  lw         $a0, 0x88($sp)
    /* 9D574 800ACD74 A800A58F */  lw         $a1, 0xA8($sp)
    /* 9D578 800ACD78 CA90030C */  jal        fixedmult
    /* 9D57C 800ACD7C 21884000 */   addu      $s1, $v0, $zero
    /* 9D580 800ACD80 21801102 */  addu       $s0, $s0, $s1
    /* 9D584 800ACD84 21800202 */  addu       $s0, $s0, $v0
    /* 9D588 800ACD88 F403B0AE */  sw         $s0, 0x3F4($s5)
    /* 9D58C 800ACD8C 8000A48F */  lw         $a0, 0x80($sp)
    /* 9D590 800ACD90 AC00A58F */  lw         $a1, 0xAC($sp)
    /* 9D594 800ACD94 CA90030C */  jal        fixedmult
    /* 9D598 800ACD98 00000000 */   nop
    /* 9D59C 800ACD9C 8400A48F */  lw         $a0, 0x84($sp)
    /* 9D5A0 800ACDA0 B000A58F */  lw         $a1, 0xB0($sp)
    /* 9D5A4 800ACDA4 CA90030C */  jal        fixedmult
    /* 9D5A8 800ACDA8 21804000 */   addu      $s0, $v0, $zero
    /* 9D5AC 800ACDAC 8800A48F */  lw         $a0, 0x88($sp)
    /* 9D5B0 800ACDB0 B400A58F */  lw         $a1, 0xB4($sp)
    /* 9D5B4 800ACDB4 CA90030C */  jal        fixedmult
    /* 9D5B8 800ACDB8 21884000 */   addu      $s1, $v0, $zero
    /* 9D5BC 800ACDBC 21801102 */  addu       $s0, $s0, $s1
    /* 9D5C0 800ACDC0 21800202 */  addu       $s0, $s0, $v0
    /* 9D5C4 800ACDC4 F803B0AE */  sw         $s0, 0x3F8($s5)
    /* 9D5C8 800ACDC8 8000A48F */  lw         $a0, 0x80($sp)
    /* 9D5CC 800ACDCC B800A58F */  lw         $a1, 0xB8($sp)
    /* 9D5D0 800ACDD0 CA90030C */  jal        fixedmult
    /* 9D5D4 800ACDD4 00000000 */   nop
    /* 9D5D8 800ACDD8 8400A48F */  lw         $a0, 0x84($sp)
    /* 9D5DC 800ACDDC BC00A58F */  lw         $a1, 0xBC($sp)
    /* 9D5E0 800ACDE0 CA90030C */  jal        fixedmult
    /* 9D5E4 800ACDE4 21804000 */   addu      $s0, $v0, $zero
    /* 9D5E8 800ACDE8 8800A48F */  lw         $a0, 0x88($sp)
    /* 9D5EC 800ACDEC C000A58F */  lw         $a1, 0xC0($sp)
    /* 9D5F0 800ACDF0 CA90030C */  jal        fixedmult
    /* 9D5F4 800ACDF4 21884000 */   addu      $s1, $v0, $zero
    /* 9D5F8 800ACDF8 21801102 */  addu       $s0, $s0, $s1
    /* 9D5FC 800ACDFC 0004A38E */  lw         $v1, 0x400($s5)
    /* 9D600 800ACE00 21800202 */  addu       $s0, $s0, $v0
    /* 9D604 800ACE04 02006104 */  bgez       $v1, .L800ACE10
    /* 9D608 800ACE08 FC03B0AE */   sw        $s0, 0x3FC($s5)
    /* 9D60C 800ACE0C 1F006324 */  addiu      $v1, $v1, 0x1F
  .L800ACE10:
    /* 9D610 800ACE10 43190300 */  sra        $v1, $v1, 5
    /* 9D614 800ACE14 AC00A28E */  lw         $v0, 0xAC($s5)
    /* 9D618 800ACE18 0404A48E */  lw         $a0, 0x404($s5)
    /* 9D61C 800ACE1C 21104300 */  addu       $v0, $v0, $v1
    /* 9D620 800ACE20 02008104 */  bgez       $a0, .L800ACE2C
    /* 9D624 800ACE24 AC00A2AE */   sw        $v0, 0xAC($s5)
    /* 9D628 800ACE28 1F008424 */  addiu      $a0, $a0, 0x1F
  .L800ACE2C:
    /* 9D62C 800ACE2C 43190400 */  sra        $v1, $a0, 5
    /* 9D630 800ACE30 B000A28E */  lw         $v0, 0xB0($s5)
    /* 9D634 800ACE34 0804A58E */  lw         $a1, 0x408($s5)
    /* 9D638 800ACE38 21104300 */  addu       $v0, $v0, $v1
    /* 9D63C 800ACE3C 0200A104 */  bgez       $a1, .L800ACE48
    /* 9D640 800ACE40 B000A2AE */   sw        $v0, 0xB0($s5)
    /* 9D644 800ACE44 1F00A524 */  addiu      $a1, $a1, 0x1F
  .L800ACE48:
    /* 9D648 800ACE48 43190500 */  sra        $v1, $a1, 5
    /* 9D64C 800ACE4C B400A28E */  lw         $v0, 0xB4($s5)
    /* 9D650 800ACE50 F403A48E */  lw         $a0, 0x3F4($s5)
    /* 9D654 800ACE54 21104300 */  addu       $v0, $v0, $v1
    /* 9D658 800ACE58 02008104 */  bgez       $a0, .L800ACE64
    /* 9D65C 800ACE5C B400A2AE */   sw        $v0, 0xB4($s5)
    /* 9D660 800ACE60 1F008424 */  addiu      $a0, $a0, 0x1F
  .L800ACE64:
    /* 9D664 800ACE64 43190400 */  sra        $v1, $a0, 5
    /* 9D668 800ACE68 1401A28E */  lw         $v0, 0x114($s5)
    /* 9D66C 800ACE6C F803A58E */  lw         $a1, 0x3F8($s5)
    /* 9D670 800ACE70 21104300 */  addu       $v0, $v0, $v1
    /* 9D674 800ACE74 0200A104 */  bgez       $a1, .L800ACE80
    /* 9D678 800ACE78 1401A2AE */   sw        $v0, 0x114($s5)
    /* 9D67C 800ACE7C 3F00A524 */  addiu      $a1, $a1, 0x3F
  .L800ACE80:
    /* 9D680 800ACE80 83190500 */  sra        $v1, $a1, 6
    /* 9D684 800ACE84 1801A28E */  lw         $v0, 0x118($s5)
    /* 9D688 800ACE88 FC03A48E */  lw         $a0, 0x3FC($s5)
    /* 9D68C 800ACE8C 21104300 */  addu       $v0, $v0, $v1
    /* 9D690 800ACE90 02008104 */  bgez       $a0, .L800ACE9C
    /* 9D694 800ACE94 1801A2AE */   sw        $v0, 0x118($s5)
    /* 9D698 800ACE98 1F008424 */  addiu      $a0, $a0, 0x1F
  .L800ACE9C:
    /* 9D69C 800ACE9C 43110400 */  sra        $v0, $a0, 5
    /* 9D6A0 800ACEA0 1C01A38E */  lw         $v1, 0x11C($s5)
    /* 9D6A4 800ACEA4 6004A48E */  lw         $a0, 0x460($s5)
    /* 9D6A8 800ACEA8 21186200 */  addu       $v1, $v1, $v0
    /* 9D6AC 800ACEAC 19018010 */  beqz       $a0, .L800AD314
    /* 9D6B0 800ACEB0 1C01A3AE */   sw        $v1, 0x11C($s5)
    /* 9D6B4 800ACEB4 0400023C */  lui        $v0, (0x471C6 >> 16)
    /* 9D6B8 800ACEB8 5C05A38E */  lw         $v1, 0x55C($s5)
    /* 9D6BC 800ACEBC C6714234 */  ori        $v0, $v0, (0x471C6 & 0xFFFF)
    /* 9D6C0 800ACEC0 2A104300 */  slt        $v0, $v0, $v1
    /* 9D6C4 800ACEC4 0F004014 */  bnez       $v0, .L800ACF04
    /* 9D6C8 800ACEC8 00000000 */   nop
    /* 9D6CC 800ACECC 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D6D0 800ACED0 00000000 */  nop
    /* 9D6D4 800ACED4 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9D6D8 800ACED8 04004014 */  bnez       $v0, .L800ACEEC
    /* 9D6DC 800ACEDC 00000000 */   nop
    /* 9D6E0 800ACEE0 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D6E4 800ACEE4 BCB30208 */  j          .L800ACEF0
    /* 9D6E8 800ACEE8 80100200 */   sll       $v0, $v0, 2
  .L800ACEEC:
    /* 9D6EC 800ACEEC 08000224 */  addiu      $v0, $zero, 0x8
  .L800ACEF0:
    /* 9D6F0 800ACEF0 1800043C */  lui        $a0, (0x188000 >> 16)
    /* 9D6F4 800ACEF4 2110C202 */  addu       $v0, $s6, $v0
    /* 9D6F8 800ACEF8 0C00458C */  lw         $a1, 0xC($v0)
    /* 9D6FC 800ACEFC CDB30208 */  j          .L800ACF34
    /* 9D700 800ACF00 00808434 */   ori       $a0, $a0, (0x188000 & 0xFFFF)
  .L800ACF04:
    /* 9D704 800ACF04 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D708 800ACF08 00000000 */  nop
    /* 9D70C 800ACF0C 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9D710 800ACF10 04004014 */  bnez       $v0, .L800ACF24
    /* 9D714 800ACF14 00000000 */   nop
    /* 9D718 800ACF18 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D71C 800ACF1C CAB30208 */  j          .L800ACF28
    /* 9D720 800ACF20 80100200 */   sll       $v0, $v0, 2
  .L800ACF24:
    /* 9D724 800ACF24 08000224 */  addiu      $v0, $zero, 0x8
  .L800ACF28:
    /* 9D728 800ACF28 2110C202 */  addu       $v0, $s6, $v0
    /* 9D72C 800ACF2C 5C05A48E */  lw         $a0, 0x55C($s5)
    /* 9D730 800ACF30 0C00458C */  lw         $a1, 0xC($v0)
  .L800ACF34:
    /* 9D734 800ACF34 CA90030C */  jal        fixedmult
    /* 9D738 800ACF38 00000000 */   nop
    /* 9D73C 800ACF3C 21184000 */  addu       $v1, $v0, $zero
    /* 9D740 800ACF40 02006104 */  bgez       $v1, .L800ACF4C
    /* 9D744 800ACF44 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9D748 800ACF48 21186200 */  addu       $v1, $v1, $v0
  .L800ACF4C:
    /* 9D74C 800ACF4C 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D750 800ACF50 00000000 */  nop
    /* 9D754 800ACF54 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9D758 800ACF58 04004014 */  bnez       $v0, .L800ACF6C
    /* 9D75C 800ACF5C 03840300 */   sra       $s0, $v1, 16
    /* 9D760 800ACF60 4204A292 */  lbu        $v0, 0x442($s5)
    /* 9D764 800ACF64 DCB30208 */  j          .L800ACF70
    /* 9D768 800ACF68 80100200 */   sll       $v0, $v0, 2
  .L800ACF6C:
    /* 9D76C 800ACF6C 08000224 */  addiu      $v0, $zero, 0x8
  .L800ACF70:
    /* 9D770 800ACF70 2110C202 */  addu       $v0, $s6, $v0
    /* 9D774 800ACF74 2004A48E */  lw         $a0, 0x420($s5)
    /* 9D778 800ACF78 0C00458C */  lw         $a1, 0xC($v0)
    /* 9D77C 800ACF7C CA90030C */  jal        fixedmult
    /* 9D780 800ACF80 00000000 */   nop
    /* 9D784 800ACF84 21284000 */  addu       $a1, $v0, $zero
    /* 9D788 800ACF88 0200A104 */  bgez       $a1, .L800ACF94
    /* 9D78C 800ACF8C FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9D790 800ACF90 2128A200 */  addu       $a1, $a1, $v0
  .L800ACF94:
    /* 9D794 800ACF94 F000C38E */  lw         $v1, 0xF0($s6)
    /* 9D798 800ACF98 00121000 */  sll        $v0, $s0, 8
    /* 9D79C 800ACF9C 1A004300 */  div        $zero, $v0, $v1
    /* 9D7A0 800ACFA0 02006014 */  bnez       $v1, .L800ACFAC
    /* 9D7A4 800ACFA4 00000000 */   nop
    /* 9D7A8 800ACFA8 0D000700 */  break      7
  .L800ACFAC:
    /* 9D7AC 800ACFAC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9D7B0 800ACFB0 04006114 */  bne        $v1, $at, .L800ACFC4
    /* 9D7B4 800ACFB4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9D7B8 800ACFB8 02004114 */  bne        $v0, $at, .L800ACFC4
    /* 9D7BC 800ACFBC 00000000 */   nop
    /* 9D7C0 800ACFC0 0D000600 */  break      6
  .L800ACFC4:
    /* 9D7C4 800ACFC4 12200000 */  mflo       $a0
    /* 9D7C8 800ACFC8 03140500 */  sra        $v0, $a1, 16
    /* 9D7CC 800ACFCC 23280202 */  subu       $a1, $s0, $v0
    /* 9D7D0 800ACFD0 C900A228 */  slti       $v0, $a1, 0xC9
    /* 9D7D4 800ACFD4 16004014 */  bnez       $v0, .L800AD030
    /* 9D7D8 800ACFD8 C800A228 */   slti      $v0, $a1, 0xC8
    /* 9D7DC 800ACFDC C0110500 */  sll        $v0, $a1, 7
    /* 9D7E0 800ACFE0 1A005000 */  div        $zero, $v0, $s0
    /* 9D7E4 800ACFE4 02000016 */  bnez       $s0, .L800ACFF0
    /* 9D7E8 800ACFE8 00000000 */   nop
    /* 9D7EC 800ACFEC 0D000700 */  break      7
  .L800ACFF0:
    /* 9D7F0 800ACFF0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9D7F4 800ACFF4 04000116 */  bne        $s0, $at, .L800AD008
    /* 9D7F8 800ACFF8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9D7FC 800ACFFC 02004114 */  bne        $v0, $at, .L800AD008
    /* 9D800 800AD000 00000000 */   nop
    /* 9D804 800AD004 0D000600 */  break      6
  .L800AD008:
    /* 9D808 800AD008 12100000 */  mflo       $v0
    /* 9D80C 800AD00C 00000000 */  nop
    /* 9D810 800AD010 21208200 */  addu       $a0, $a0, $v0
    /* 9D814 800AD014 21188000 */  addu       $v1, $a0, $zero
    /* 9D818 800AD018 E1006228 */  slti       $v0, $v1, 0xE1
    /* 9D81C 800AD01C 02004014 */  bnez       $v0, .L800AD028
    /* 9D820 800AD020 00000000 */   nop
    /* 9D824 800AD024 E0000324 */  addiu      $v1, $zero, 0xE0
  .L800AD028:
    /* 9D828 800AD028 3CB40208 */  j          .L800AD0F0
    /* 9D82C 800AD02C 5804A3A2 */   sb        $v1, 0x458($s5)
  .L800AD030:
    /* 9D830 800AD030 2F004010 */  beqz       $v0, .L800AD0F0
    /* 9D834 800AD034 C0110500 */   sll       $v0, $a1, 7
    /* 9D838 800AD038 1A005000 */  div        $zero, $v0, $s0
    /* 9D83C 800AD03C 02000016 */  bnez       $s0, .L800AD048
    /* 9D840 800AD040 00000000 */   nop
    /* 9D844 800AD044 0D000700 */  break      7
  .L800AD048:
    /* 9D848 800AD048 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9D84C 800AD04C 04000116 */  bne        $s0, $at, .L800AD060
    /* 9D850 800AD050 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9D854 800AD054 02004114 */  bne        $v0, $at, .L800AD060
    /* 9D858 800AD058 00000000 */   nop
    /* 9D85C 800AD05C 0D000600 */  break      6
  .L800AD060:
    /* 9D860 800AD060 12100000 */  mflo       $v0
    /* 9D864 800AD064 00000000 */  nop
    /* 9D868 800AD068 21208200 */  addu       $a0, $a0, $v0
    /* 9D86C 800AD06C 03008004 */  bltz       $a0, .L800AD07C
    /* 9D870 800AD070 00000000 */   nop
    /* 9D874 800AD074 20B40208 */  j          .L800AD080
    /* 9D878 800AD078 5804A4A2 */   sb        $a0, 0x458($s5)
  .L800AD07C:
    /* 9D87C 800AD07C 5804A0A2 */  sb         $zero, 0x458($s5)
  .L800AD080:
    /* 9D880 800AD080 1C00A104 */  bgez       $a1, .L800AD0F4
    /* 9D884 800AD084 AA2A033C */   lui       $v1, (0x2AAAAAAB >> 16)
    /* 9D888 800AD088 40120500 */  sll        $v0, $a1, 9
    /* 9D88C 800AD08C F000C38E */  lw         $v1, 0xF0($s6)
    /* 9D890 800AD090 02004104 */  bgez       $v0, .L800AD09C
    /* 9D894 800AD094 00000000 */   nop
    /* 9D898 800AD098 23100200 */  negu       $v0, $v0
  .L800AD09C:
    /* 9D89C 800AD09C 1A004300 */  div        $zero, $v0, $v1
    /* 9D8A0 800AD0A0 02006014 */  bnez       $v1, .L800AD0AC
    /* 9D8A4 800AD0A4 00000000 */   nop
    /* 9D8A8 800AD0A8 0D000700 */  break      7
  .L800AD0AC:
    /* 9D8AC 800AD0AC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 9D8B0 800AD0B0 04006114 */  bne        $v1, $at, .L800AD0C4
    /* 9D8B4 800AD0B4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 9D8B8 800AD0B8 02004114 */  bne        $v0, $at, .L800AD0C4
    /* 9D8BC 800AD0BC 00000000 */   nop
    /* 9D8C0 800AD0C0 0D000600 */  break      6
  .L800AD0C4:
    /* 9D8C4 800AD0C4 12180000 */  mflo       $v1
    /* 9D8C8 800AD0C8 00000000 */  nop
    /* 9D8CC 800AD0CC 00016228 */  slti       $v0, $v1, 0x100
    /* 9D8D0 800AD0D0 03004014 */  bnez       $v0, .L800AD0E0
    /* 9D8D4 800AD0D4 FF006230 */   andi      $v0, $v1, 0xFF
    /* 9D8D8 800AD0D8 FF000324 */  addiu      $v1, $zero, 0xFF
    /* 9D8DC 800AD0DC FF006230 */  andi       $v0, $v1, 0xFF
  .L800AD0E0:
    /* 9D8E0 800AD0E0 8100422C */  sltiu      $v0, $v0, 0x81
    /* 9D8E4 800AD0E4 02004014 */  bnez       $v0, .L800AD0F0
    /* 9D8E8 800AD0E8 5904A3A2 */   sb        $v1, 0x459($s5)
    /* 9D8EC 800AD0EC 5804A0A2 */  sb         $zero, 0x458($s5)
  .L800AD0F0:
    /* 9D8F0 800AD0F0 AA2A033C */  lui        $v1, (0x2AAAAAAB >> 16)
  .L800AD0F4:
    /* 9D8F4 800AD0F4 6405A28E */  lw         $v0, 0x564($s5)
    /* 9D8F8 800AD0F8 ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* 9D8FC 800AD0FC 02004104 */  bgez       $v0, .L800AD108
    /* 9D900 800AD100 00000000 */   nop
    /* 9D904 800AD104 23100200 */  negu       $v0, $v0
  .L800AD108:
    /* 9D908 800AD108 18004300 */  mult       $v0, $v1
    /* 9D90C 800AD10C C3170200 */  sra        $v0, $v0, 31
    /* 9D910 800AD110 10400000 */  mfhi       $t0
    /* 9D914 800AD114 031C0800 */  sra        $v1, $t0, 16
    /* 9D918 800AD118 23306200 */  subu       $a2, $v1, $v0
    /* 9D91C 800AD11C 0300C228 */  slti       $v0, $a2, 0x3
    /* 9D920 800AD120 6004A38E */  lw         $v1, 0x460($s5)
    /* 9D924 800AD124 05004014 */  bnez       $v0, .L800AD13C
    /* 9D928 800AD128 40100300 */   sll       $v0, $v1, 1
    /* 9D92C 800AD12C 18006600 */  mult       $v1, $a2
    /* 9D930 800AD130 12180000 */  mflo       $v1
    /* 9D934 800AD134 50B40208 */  j          .L800AD140
    /* 9D938 800AD138 00000000 */   nop
  .L800AD13C:
    /* 9D93C 800AD13C 21184300 */  addu       $v1, $v0, $v1
  .L800AD140:
    /* 9D940 800AD140 0A006004 */  bltz       $v1, .L800AD16C
    /* 9D944 800AD144 00000000 */   nop
    /* 9D948 800AD148 0800A286 */  lh         $v0, 0x8($s5)
    /* 9D94C 800AD14C 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 9D950 800AD150 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 9D954 800AD154 21284300 */  addu       $a1, $v0, $v1
    /* 9D958 800AD158 2A10A400 */  slt        $v0, $a1, $a0
    /* 9D95C 800AD15C 0C004014 */  bnez       $v0, .L800AD190
    /* 9D960 800AD160 00000000 */   nop
    /* 9D964 800AD164 64B40208 */  j          .L800AD190
    /* 9D968 800AD168 2328A400 */   subu      $a1, $a1, $a0
  .L800AD16C:
    /* 9D96C 800AD16C 0800A286 */  lh         $v0, 0x8($s5)
    /* 9D970 800AD170 00000000 */  nop
    /* 9D974 800AD174 21284300 */  addu       $a1, $v0, $v1
    /* 9D978 800AD178 0500A104 */  bgez       $a1, .L800AD190
    /* 9D97C 800AD17C 00000000 */   nop
    /* 9D980 800AD180 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 9D984 800AD184 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 9D988 800AD188 00000000 */  nop
    /* 9D98C 800AD18C 2128A200 */  addu       $a1, $a1, $v0
  .L800AD190:
    /* 9D990 800AD190 40810500 */  sll        $s0, $a1, 5
    /* 9D994 800AD194 40300300 */  sll        $a2, $v1, 1
    /* 9D998 800AD198 2130C300 */  addu       $a2, $a2, $v1
    /* 9D99C 800AD19C 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 9D9A0 800AD1A0 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 9D9A4 800AD1A4 0200C104 */  bgez       $a2, .L800AD1B0
    /* 9D9A8 800AD1A8 00000000 */   nop
    /* 9D9AC 800AD1AC 23300600 */  negu       $a2, $a2
  .L800AD1B0:
    /* 9D9B0 800AD1B0 A000A88E */  lw         $t0, 0xA0($s5)
    /* 9D9B4 800AD1B4 A400A98E */  lw         $t1, 0xA4($s5)
    /* 9D9B8 800AD1B8 A800AA8E */  lw         $t2, 0xA8($s5)
    /* 9D9BC 800AD1BC C800A8AF */  sw         $t0, 0xC8($sp)
    /* 9D9C0 800AD1C0 CC00A9AF */  sw         $t1, 0xCC($sp)
    /* 9D9C4 800AD1C4 D000AAAF */  sw         $t2, 0xD0($sp)
    /* 9D9C8 800AD1C8 21100202 */  addu       $v0, $s0, $v0
    /* 9D9CC 800AD1CC 0000488C */  lw         $t0, 0x0($v0)
    /* 9D9D0 800AD1D0 0400498C */  lw         $t1, 0x4($v0)
    /* 9D9D4 800AD1D4 08004A8C */  lw         $t2, 0x8($v0)
    /* 9D9D8 800AD1D8 D800A8AF */  sw         $t0, 0xD8($sp)
    /* 9D9DC 800AD1DC DC00A9AF */  sw         $t1, 0xDC($sp)
    /* 9D9E0 800AD1E0 E000AAAF */  sw         $t2, 0xE0($sp)
    /* 9D9E4 800AD1E4 E9AF020C */  jal        Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii
    /* 9D9E8 800AD1E8 2120A002 */   addu      $a0, $s5, $zero
    /* 9D9EC 800AD1EC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 9D9F0 800AD1F0 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 9D9F4 800AD1F4 21884000 */  addu       $s1, $v0, $zero
    /* 9D9F8 800AD1F8 21180302 */  addu       $v1, $s0, $v1
    /* 9D9FC 800AD1FC 12006480 */  lb         $a0, 0x12($v1)
    /* 9DA00 800AD200 21282002 */  addu       $a1, $s1, $zero
    /* 9DA04 800AD204 CA90030C */  jal        fixedmult
    /* 9DA08 800AD208 40220400 */   sll       $a0, $a0, 9
    /* 9DA0C 800AD20C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 9DA10 800AD210 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 9DA14 800AD214 E800A2AF */  sw         $v0, 0xE8($sp)
    /* 9DA18 800AD218 21180302 */  addu       $v1, $s0, $v1
    /* 9DA1C 800AD21C 13006480 */  lb         $a0, 0x13($v1)
    /* 9DA20 800AD220 21282002 */  addu       $a1, $s1, $zero
    /* 9DA24 800AD224 CA90030C */  jal        fixedmult
    /* 9DA28 800AD228 40220400 */   sll       $a0, $a0, 9
    /* 9DA2C 800AD22C 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 9DA30 800AD230 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 9DA34 800AD234 EC00A2AF */  sw         $v0, 0xEC($sp)
    /* 9DA38 800AD238 21800302 */  addu       $s0, $s0, $v1
    /* 9DA3C 800AD23C 14000482 */  lb         $a0, 0x14($s0)
    /* 9DA40 800AD240 21282002 */  addu       $a1, $s1, $zero
    /* 9DA44 800AD244 CA90030C */  jal        fixedmult
    /* 9DA48 800AD248 40220400 */   sll       $a0, $a0, 9
    /* 9DA4C 800AD24C D800A58F */  lw         $a1, 0xD8($sp)
    /* 9DA50 800AD250 E800A38F */  lw         $v1, 0xE8($sp)
    /* 9DA54 800AD254 DC00A68F */  lw         $a2, 0xDC($sp)
    /* 9DA58 800AD258 EC00A78F */  lw         $a3, 0xEC($sp)
    /* 9DA5C 800AD25C 2128A300 */  addu       $a1, $a1, $v1
    /* 9DA60 800AD260 2130C700 */  addu       $a2, $a2, $a3
    /* 9DA64 800AD264 E000A38F */  lw         $v1, 0xE0($sp)
    /* 9DA68 800AD268 C800A78F */  lw         $a3, 0xC8($sp)
    /* 9DA6C 800AD26C F000A2AF */  sw         $v0, 0xF0($sp)
    /* 9DA70 800AD270 D800A5AF */  sw         $a1, 0xD8($sp)
    /* 9DA74 800AD274 21186200 */  addu       $v1, $v1, $v0
    /* 9DA78 800AD278 CC00A28F */  lw         $v0, 0xCC($sp)
    /* 9DA7C 800AD27C 2328A700 */  subu       $a1, $a1, $a3
    /* 9DA80 800AD280 D800A5AF */  sw         $a1, 0xD8($sp)
    /* 9DA84 800AD284 D000A58F */  lw         $a1, 0xD0($sp)
    /* 9DA88 800AD288 D800A427 */  addiu      $a0, $sp, 0xD8
    /* 9DA8C 800AD28C DC00A6AF */  sw         $a2, 0xDC($sp)
    /* 9DA90 800AD290 E000A3AF */  sw         $v1, 0xE0($sp)
    /* 9DA94 800AD294 2330C200 */  subu       $a2, $a2, $v0
    /* 9DA98 800AD298 23186500 */  subu       $v1, $v1, $a1
    /* 9DA9C 800AD29C DC00A6AF */  sw         $a2, 0xDC($sp)
    /* 9DAA0 800AD2A0 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* 9DAA4 800AD2A4 E000A3AF */   sw        $v1, 0xE0($sp)
    /* 9DAA8 800AD2A8 D800A48F */  lw         $a0, 0xD8($sp)
    /* 9DAAC 800AD2AC F000A58E */  lw         $a1, 0xF0($s5)
    /* 9DAB0 800AD2B0 CA90030C */  jal        fixedmult
    /* 9DAB4 800AD2B4 00000000 */   nop
    /* 9DAB8 800AD2B8 DC00A48F */  lw         $a0, 0xDC($sp)
    /* 9DABC 800AD2BC F400A58E */  lw         $a1, 0xF4($s5)
    /* 9DAC0 800AD2C0 CA90030C */  jal        fixedmult
    /* 9DAC4 800AD2C4 21804000 */   addu      $s0, $v0, $zero
    /* 9DAC8 800AD2C8 E000A48F */  lw         $a0, 0xE0($sp)
    /* 9DACC 800AD2CC F800A58E */  lw         $a1, 0xF8($s5)
    /* 9DAD0 800AD2D0 CA90030C */  jal        fixedmult
    /* 9DAD4 800AD2D4 21884000 */   addu      $s1, $v0, $zero
    /* 9DAD8 800AD2D8 21801102 */  addu       $s0, $s0, $s1
    /* 9DADC 800AD2DC 21100202 */  addu       $v0, $s0, $v0
    /* 9DAE0 800AD2E0 03004104 */  bgez       $v0, .L800AD2F0
    /* 9DAE4 800AD2E4 03820200 */   sra       $s0, $v0, 8
    /* 9DAE8 800AD2E8 FF004224 */  addiu      $v0, $v0, 0xFF
    /* 9DAEC 800AD2EC 03820200 */  sra        $s0, $v0, 8
  .L800AD2F0:
    /* 9DAF0 800AD2F0 8000022A */  slti       $v0, $s0, 0x80
    /* 9DAF4 800AD2F4 03004014 */  bnez       $v0, .L800AD304
    /* 9DAF8 800AD2F8 5C04B0AE */   sw        $s0, 0x45C($s5)
    /* 9DAFC 800AD2FC C4B40208 */  j          .L800AD310
    /* 9DB00 800AD300 7F000224 */   addiu     $v0, $zero, 0x7F
  .L800AD304:
    /* 9DB04 800AD304 81FF022A */  slti       $v0, $s0, -0x7F
    /* 9DB08 800AD308 02004010 */  beqz       $v0, .L800AD314
    /* 9DB0C 800AD30C 81FF0224 */   addiu     $v0, $zero, -0x7F
  .L800AD310:
    /* 9DB10 800AD310 5C04A2AE */  sw         $v0, 0x45C($s5)
  .L800AD314:
    /* 9DB14 800AD314 1180023C */  lui        $v0, %hi(D_80113224)
    /* 9DB18 800AD318 2432428C */  lw         $v0, %lo(D_80113224)($v0)
    /* 9DB1C 800AD31C 00000000 */  nop
    /* 9DB20 800AD320 08004230 */  andi       $v0, $v0, 0x8
    /* 9DB24 800AD324 1F004014 */  bnez       $v0, .L800AD3A4
    /* 9DB28 800AD328 00000000 */   nop
    /* 9DB2C 800AD32C 3F04A292 */  lbu        $v0, 0x43F($s5)
    /* 9DB30 800AD330 00000000 */  nop
    /* 9DB34 800AD334 09004010 */  beqz       $v0, .L800AD35C
    /* 9DB38 800AD338 00000000 */   nop
    /* 9DB3C 800AD33C 7804A28E */  lw         $v0, 0x478($s5)
    /* 9DB40 800AD340 00000000 */  nop
    /* 9DB44 800AD344 02004104 */  bgez       $v0, .L800AD350
    /* 9DB48 800AD348 00000000 */   nop
    /* 9DB4C 800AD34C 23100200 */  negu       $v0, $v0
  .L800AD350:
    /* 9DB50 800AD350 9A194228 */  slti       $v0, $v0, 0x199A
    /* 9DB54 800AD354 13004014 */  bnez       $v0, .L800AD3A4
    /* 9DB58 800AD358 00000000 */   nop
  .L800AD35C:
    /* 9DB5C 800AD35C 6404A28E */  lw         $v0, 0x464($s5)
    /* 9DB60 800AD360 AC00A58E */  lw         $a1, 0xAC($s5)
    /* 9DB64 800AD364 5801448C */  lw         $a0, 0x158($v0)
    /* 9DB68 800AD368 CA90030C */  jal        fixedmult
    /* 9DB6C 800AD36C 00000000 */   nop
    /* 9DB70 800AD370 B000A58E */  lw         $a1, 0xB0($s5)
    /* 9DB74 800AD374 6404A38E */  lw         $v1, 0x464($s5)
    /* 9DB78 800AD378 AC00A2AE */  sw         $v0, 0xAC($s5)
    /* 9DB7C 800AD37C 5801648C */  lw         $a0, 0x158($v1)
    /* 9DB80 800AD380 CA90030C */  jal        fixedmult
    /* 9DB84 800AD384 00000000 */   nop
    /* 9DB88 800AD388 B400A58E */  lw         $a1, 0xB4($s5)
    /* 9DB8C 800AD38C 6404A38E */  lw         $v1, 0x464($s5)
    /* 9DB90 800AD390 B000A2AE */  sw         $v0, 0xB0($s5)
    /* 9DB94 800AD394 5801648C */  lw         $a0, 0x158($v1)
    /* 9DB98 800AD398 CA90030C */  jal        fixedmult
    /* 9DB9C 800AD39C 00000000 */   nop
    /* 9DBA0 800AD3A0 B400A2AE */  sw         $v0, 0xB4($s5)
  .L800AD3A4:
    /* 9DBA4 800AD3A4 C001A38E */  lw         $v1, 0x1C0($s5)
    /* 9DBA8 800AD3A8 03000224 */  addiu      $v0, $zero, 0x3
    /* 9DBAC 800AD3AC 10006214 */  bne        $v1, $v0, .L800AD3F0
    /* 9DBB0 800AD3B0 2C00023C */   lui       $v0, (0x2CA3D7 >> 16)
    /* 9DBB4 800AD3B4 C000A38E */  lw         $v1, 0xC0($s5)
    /* 9DBB8 800AD3B8 D7A34234 */  ori        $v0, $v0, (0x2CA3D7 & 0xFFFF)
    /* 9DBBC 800AD3BC 2A104300 */  slt        $v0, $v0, $v1
    /* 9DBC0 800AD3C0 0B004010 */  beqz       $v0, .L800AD3F0
    /* 9DBC4 800AD3C4 00000000 */   nop
    /* 9DBC8 800AD3C8 AC00A58E */  lw         $a1, 0xAC($s5)
    /* 9DBCC 800AD3CC CA90030C */  jal        fixedmult
    /* 9DBD0 800AD3D0 B8FE0434 */   ori       $a0, $zero, 0xFEB8
    /* 9DBD4 800AD3D4 B000A58E */  lw         $a1, 0xB0($s5)
    /* 9DBD8 800AD3D8 B8FE0434 */  ori        $a0, $zero, 0xFEB8
    /* 9DBDC 800AD3DC CA90030C */  jal        fixedmult
    /* 9DBE0 800AD3E0 AC00A2AE */   sw        $v0, 0xAC($s5)
    /* 9DBE4 800AD3E4 B400A58E */  lw         $a1, 0xB4($s5)
    /* 9DBE8 800AD3E8 44B50208 */  j          .L800AD510
    /* 9DBEC 800AD3EC B8FE0434 */   ori       $a0, $zero, 0xFEB8
  .L800AD3F0:
    /* 9DBF0 800AD3F0 4204A392 */  lbu        $v1, 0x442($s5)
    /* 9DBF4 800AD3F4 01000224 */  addiu      $v0, $zero, 0x1
    /* 9DBF8 800AD3F8 33006214 */  bne        $v1, $v0, .L800AD4C8
    /* 9DBFC 800AD3FC 1180023C */   lui       $v0, %hi(D_801165DC)
    /* 9DC00 800AD400 DC65438C */  lw         $v1, %lo(D_801165DC)($v0)
    /* 9DC04 800AD404 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* 9DC08 800AD408 02006104 */  bgez       $v1, .L800AD414
    /* 9DC0C 800AD40C 00000000 */   nop
    /* 9DC10 800AD410 23180300 */  negu       $v1, $v1
  .L800AD414:
    /* 9DC14 800AD414 2A104300 */  slt        $v0, $v0, $v1
    /* 9DC18 800AD418 2B004014 */  bnez       $v0, .L800AD4C8
    /* 9DC1C 800AD41C 1300033C */   lui       $v1, (0x13FFFF >> 16)
    /* 9DC20 800AD420 2004A28E */  lw         $v0, 0x420($s5)
    /* 9DC24 800AD424 FFFF6334 */  ori        $v1, $v1, (0x13FFFF & 0xFFFF)
    /* 9DC28 800AD428 02004104 */  bgez       $v0, .L800AD434
    /* 9DC2C 800AD42C 00000000 */   nop
    /* 9DC30 800AD430 23100200 */  negu       $v0, $v0
  .L800AD434:
    /* 9DC34 800AD434 2A186200 */  slt        $v1, $v1, $v0
    /* 9DC38 800AD438 0A006010 */  beqz       $v1, .L800AD464
    /* 9DC3C 800AD43C 70FD1034 */   ori       $s0, $zero, 0xFD70
    /* 9DC40 800AD440 5004A28E */  lw         $v0, 0x450($s5)
    /* 9DC44 800AD444 00000000 */  nop
    /* 9DC48 800AD448 02004104 */  bgez       $v0, .L800AD454
    /* 9DC4C 800AD44C 00000000 */   nop
    /* 9DC50 800AD450 23100200 */  negu       $v0, $v0
  .L800AD454:
    /* 9DC54 800AD454 21004228 */  slti       $v0, $v0, 0x21
    /* 9DC58 800AD458 02004014 */  bnez       $v0, .L800AD464
    /* 9DC5C 800AD45C 7CFF1034 */   ori       $s0, $zero, 0xFF7C
    /* 9DC60 800AD460 70FD1034 */  ori        $s0, $zero, 0xFD70
  .L800AD464:
    /* 9DC64 800AD464 AC00A58E */  lw         $a1, 0xAC($s5)
    /* 9DC68 800AD468 CA90030C */  jal        fixedmult
    /* 9DC6C 800AD46C 21200002 */   addu      $a0, $s0, $zero
    /* 9DC70 800AD470 B000A58E */  lw         $a1, 0xB0($s5)
    /* 9DC74 800AD474 21200002 */  addu       $a0, $s0, $zero
    /* 9DC78 800AD478 CA90030C */  jal        fixedmult
    /* 9DC7C 800AD47C AC00A2AE */   sw        $v0, 0xAC($s5)
    /* 9DC80 800AD480 B400A58E */  lw         $a1, 0xB4($s5)
    /* 9DC84 800AD484 21200002 */  addu       $a0, $s0, $zero
    /* 9DC88 800AD488 CA90030C */  jal        fixedmult
    /* 9DC8C 800AD48C B000A2AE */   sw        $v0, 0xB0($s5)
    /* 9DC90 800AD490 1401A58E */  lw         $a1, 0x114($s5)
    /* 9DC94 800AD494 21200002 */  addu       $a0, $s0, $zero
    /* 9DC98 800AD498 CA90030C */  jal        fixedmult
    /* 9DC9C 800AD49C B400A2AE */   sw        $v0, 0xB4($s5)
    /* 9DCA0 800AD4A0 1801A58E */  lw         $a1, 0x118($s5)
    /* 9DCA4 800AD4A4 21200002 */  addu       $a0, $s0, $zero
    /* 9DCA8 800AD4A8 CA90030C */  jal        fixedmult
    /* 9DCAC 800AD4AC 1401A2AE */   sw        $v0, 0x114($s5)
    /* 9DCB0 800AD4B0 1C01A58E */  lw         $a1, 0x11C($s5)
    /* 9DCB4 800AD4B4 21200002 */  addu       $a0, $s0, $zero
    /* 9DCB8 800AD4B8 CA90030C */  jal        fixedmult
    /* 9DCBC 800AD4BC 1801A2AE */   sw        $v0, 0x118($s5)
    /* 9DCC0 800AD4C0 47B50208 */  j          .L800AD51C
    /* 9DCC4 800AD4C4 1C01A2AE */   sw        $v0, 0x11C($s5)
  .L800AD4C8:
    /* 9DCC8 800AD4C8 4504A292 */  lbu        $v0, 0x445($s5)
    /* 9DCCC 800AD4CC 00000000 */  nop
    /* 9DCD0 800AD4D0 12004010 */  beqz       $v0, .L800AD51C
    /* 9DCD4 800AD4D4 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 9DCD8 800AD4D8 C000A38E */  lw         $v1, 0xC0($s5)
    /* 9DCDC 800AD4DC 00000000 */  nop
    /* 9DCE0 800AD4E0 2A104300 */  slt        $v0, $v0, $v1
    /* 9DCE4 800AD4E4 0D004014 */  bnez       $v0, .L800AD51C
    /* 9DCE8 800AD4E8 00000000 */   nop
    /* 9DCEC 800AD4EC AC00A58E */  lw         $a1, 0xAC($s5)
    /* 9DCF0 800AD4F0 CA90030C */  jal        fixedmult
    /* 9DCF4 800AD4F4 00800434 */   ori       $a0, $zero, 0x8000
    /* 9DCF8 800AD4F8 B000A58E */  lw         $a1, 0xB0($s5)
    /* 9DCFC 800AD4FC 00800434 */  ori        $a0, $zero, 0x8000
    /* 9DD00 800AD500 CA90030C */  jal        fixedmult
    /* 9DD04 800AD504 AC00A2AE */   sw        $v0, 0xAC($s5)
    /* 9DD08 800AD508 B400A58E */  lw         $a1, 0xB4($s5)
    /* 9DD0C 800AD50C 00800434 */  ori        $a0, $zero, 0x8000
  .L800AD510:
    /* 9DD10 800AD510 CA90030C */  jal        fixedmult
    /* 9DD14 800AD514 B000A2AE */   sw        $v0, 0xB0($s5)
    /* 9DD18 800AD518 B400A2AE */  sw         $v0, 0xB4($s5)
  .L800AD51C:
    /* 9DD1C 800AD51C 1401BF8F */  lw         $ra, 0x114($sp)
    /* 9DD20 800AD520 1001B68F */  lw         $s6, 0x110($sp)
    /* 9DD24 800AD524 0C01B58F */  lw         $s5, 0x10C($sp)
    /* 9DD28 800AD528 0801B48F */  lw         $s4, 0x108($sp)
    /* 9DD2C 800AD52C 0401B38F */  lw         $s3, 0x104($sp)
    /* 9DD30 800AD530 0001B28F */  lw         $s2, 0x100($sp)
    /* 9DD34 800AD534 FC00B18F */  lw         $s1, 0xFC($sp)
    /* 9DD38 800AD538 F800B08F */  lw         $s0, 0xF8($sp)
    /* 9DD3C 800AD53C 0800E003 */  jr         $ra
    /* 9DD40 800AD540 1801BD27 */   addiu     $sp, $sp, 0x118
endlabel Physics_Real__FP8Car_tObj
