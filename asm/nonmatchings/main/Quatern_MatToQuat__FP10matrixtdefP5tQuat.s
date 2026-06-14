.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Quatern_MatToQuat__FP10matrixtdefP5tQuat, 0x39C

glabel Quatern_MatToQuat__FP10matrixtdefP5tQuat
    /* 9E090 800AD890 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9E094 800AD894 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9E098 800AD898 21888000 */  addu       $s1, $a0, $zero
    /* 9E09C 800AD89C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9E0A0 800AD8A0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 9E0A4 800AD8A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9E0A8 800AD8A8 0000248E */  lw         $a0, 0x0($s1)
    /* 9E0AC 800AD8AC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 9E0B0 800AD8B0 26008214 */  bne        $a0, $v0, .L800AD94C
    /* 9E0B4 800AD8B4 2190A000 */   addu      $s2, $a1, $zero
    /* 9E0B8 800AD8B8 0400228E */  lw         $v0, 0x4($s1)
    /* 9E0BC 800AD8BC 00000000 */  nop
    /* 9E0C0 800AD8C0 22004014 */  bnez       $v0, .L800AD94C
    /* 9E0C4 800AD8C4 00000000 */   nop
    /* 9E0C8 800AD8C8 0800228E */  lw         $v0, 0x8($s1)
    /* 9E0CC 800AD8CC 00000000 */  nop
    /* 9E0D0 800AD8D0 1E004014 */  bnez       $v0, .L800AD94C
    /* 9E0D4 800AD8D4 00000000 */   nop
    /* 9E0D8 800AD8D8 0C00228E */  lw         $v0, 0xC($s1)
    /* 9E0DC 800AD8DC 00000000 */  nop
    /* 9E0E0 800AD8E0 1A004014 */  bnez       $v0, .L800AD94C
    /* 9E0E4 800AD8E4 00000000 */   nop
    /* 9E0E8 800AD8E8 1000238E */  lw         $v1, 0x10($s1)
    /* 9E0EC 800AD8EC 00000000 */  nop
    /* 9E0F0 800AD8F0 16006414 */  bne        $v1, $a0, .L800AD94C
    /* 9E0F4 800AD8F4 00000000 */   nop
    /* 9E0F8 800AD8F8 1400228E */  lw         $v0, 0x14($s1)
    /* 9E0FC 800AD8FC 00000000 */  nop
    /* 9E100 800AD900 12004014 */  bnez       $v0, .L800AD94C
    /* 9E104 800AD904 00000000 */   nop
    /* 9E108 800AD908 1800228E */  lw         $v0, 0x18($s1)
    /* 9E10C 800AD90C 00000000 */  nop
    /* 9E110 800AD910 0E004014 */  bnez       $v0, .L800AD94C
    /* 9E114 800AD914 00000000 */   nop
    /* 9E118 800AD918 1C00228E */  lw         $v0, 0x1C($s1)
    /* 9E11C 800AD91C 00000000 */  nop
    /* 9E120 800AD920 0A004014 */  bnez       $v0, .L800AD94C
    /* 9E124 800AD924 00000000 */   nop
    /* 9E128 800AD928 2000228E */  lw         $v0, 0x20($s1)
    /* 9E12C 800AD92C 00000000 */  nop
    /* 9E130 800AD930 06004314 */  bne        $v0, $v1, .L800AD94C
    /* 9E134 800AD934 00400224 */   addiu     $v0, $zero, 0x4000
    /* 9E138 800AD938 060042A6 */  sh         $v0, 0x6($s2)
    /* 9E13C 800AD93C 000040A6 */  sh         $zero, 0x0($s2)
    /* 9E140 800AD940 020040A6 */  sh         $zero, 0x2($s2)
    /* 9E144 800AD944 05B70208 */  j          .L800ADC14
    /* 9E148 800AD948 040040A6 */   sh        $zero, 0x4($s2)
  .L800AD94C:
    /* 9E14C 800AD94C 0000258E */  lw         $a1, 0x0($s1)
    /* 9E150 800AD950 1000248E */  lw         $a0, 0x10($s1)
    /* 9E154 800AD954 2000268E */  lw         $a2, 0x20($s1)
    /* 9E158 800AD958 2110A400 */  addu       $v0, $a1, $a0
    /* 9E15C 800AD95C 21104600 */  addu       $v0, $v0, $a2
    /* 9E160 800AD960 20004018 */  blez       $v0, .L800AD9E4
    /* 9E164 800AD964 00000000 */   nop
    /* 9E168 800AD968 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 9E16C 800AD96C 2BAC030C */  jal        fixedsqrt
    /* 9E170 800AD970 21204400 */   addu      $a0, $v0, $a0
    /* 9E174 800AD974 21804000 */  addu       $s0, $v0, $zero
    /* 9E178 800AD978 00800434 */  ori        $a0, $zero, 0x8000
    /* 9E17C 800AD97C 21280002 */  addu       $a1, $s0, $zero
    /* 9E180 800AD980 C2170500 */  srl        $v0, $a1, 31
    /* 9E184 800AD984 2110A200 */  addu       $v0, $a1, $v0
    /* 9E188 800AD988 C3100200 */  sra        $v0, $v0, 3
    /* 9E18C 800AD98C 0191030C */  jal        rdiv
    /* 9E190 800AD990 060042A6 */   sh        $v0, 0x6($s2)
    /* 9E194 800AD994 21804000 */  addu       $s0, $v0, $zero
    /* 9E198 800AD998 1C00228E */  lw         $v0, 0x1C($s1)
    /* 9E19C 800AD99C 1400248E */  lw         $a0, 0x14($s1)
    /* 9E1A0 800AD9A0 21280002 */  addu       $a1, $s0, $zero
    /* 9E1A4 800AD9A4 CA90030C */  jal        fixedmult
    /* 9E1A8 800AD9A8 23204400 */   subu      $a0, $v0, $a0
    /* 9E1AC 800AD9AC 83100200 */  sra        $v0, $v0, 2
    /* 9E1B0 800AD9B0 000042A6 */  sh         $v0, 0x0($s2)
    /* 9E1B4 800AD9B4 0800228E */  lw         $v0, 0x8($s1)
    /* 9E1B8 800AD9B8 1800248E */  lw         $a0, 0x18($s1)
    /* 9E1BC 800AD9BC 21280002 */  addu       $a1, $s0, $zero
    /* 9E1C0 800AD9C0 CA90030C */  jal        fixedmult
    /* 9E1C4 800AD9C4 23204400 */   subu      $a0, $v0, $a0
    /* 9E1C8 800AD9C8 83100200 */  sra        $v0, $v0, 2
    /* 9E1CC 800AD9CC 020042A6 */  sh         $v0, 0x2($s2)
    /* 9E1D0 800AD9D0 0C00228E */  lw         $v0, 0xC($s1)
    /* 9E1D4 800AD9D4 0400248E */  lw         $a0, 0x4($s1)
    /* 9E1D8 800AD9D8 21280002 */  addu       $a1, $s0, $zero
    /* 9E1DC 800AD9DC B5B60208 */  j          .L800ADAD4
    /* 9E1E0 800AD9E0 23204400 */   subu      $a0, $v0, $a0
  .L800AD9E4:
    /* 9E1E4 800AD9E4 2A10A400 */  slt        $v0, $a1, $a0
    /* 9E1E8 800AD9E8 05004010 */  beqz       $v0, .L800ADA00
    /* 9E1EC 800AD9EC 21180000 */   addu      $v1, $zero, $zero
    /* 9E1F0 800AD9F0 2A108600 */  slt        $v0, $a0, $a2
    /* 9E1F4 800AD9F4 02004010 */  beqz       $v0, .L800ADA00
    /* 9E1F8 800AD9F8 01000324 */   addiu     $v1, $zero, 0x1
    /* 9E1FC 800AD9FC 02000324 */  addiu      $v1, $zero, 0x2
  .L800ADA00:
    /* 9E200 800ADA00 2000268E */  lw         $a2, 0x20($s1)
    /* 9E204 800ADA04 0000258E */  lw         $a1, 0x0($s1)
    /* 9E208 800ADA08 00000000 */  nop
    /* 9E20C 800ADA0C 2A10A600 */  slt        $v0, $a1, $a2
    /* 9E210 800ADA10 02004010 */  beqz       $v0, .L800ADA1C
    /* 9E214 800ADA14 01000224 */   addiu     $v0, $zero, 0x1
    /* 9E218 800ADA18 02000324 */  addiu      $v1, $zero, 0x2
  .L800ADA1C:
    /* 9E21C 800ADA1C 32006210 */  beq        $v1, $v0, .L800ADAE8
    /* 9E220 800ADA20 02006228 */   slti      $v0, $v1, 0x2
    /* 9E224 800ADA24 05004010 */  beqz       $v0, .L800ADA3C
    /* 9E228 800ADA28 02000224 */   addiu     $v0, $zero, 0x2
    /* 9E22C 800ADA2C 07006010 */  beqz       $v1, .L800ADA4C
    /* 9E230 800ADA30 0100023C */   lui       $v0, (0x10000 >> 16)
    /* 9E234 800ADA34 05B70208 */  j          .L800ADC14
    /* 9E238 800ADA38 00000000 */   nop
  .L800ADA3C:
    /* 9E23C 800ADA3C 50006210 */  beq        $v1, $v0, .L800ADB80
    /* 9E240 800ADA40 0100023C */   lui       $v0, (0x10000 >> 16)
    /* 9E244 800ADA44 05B70208 */  j          .L800ADC14
    /* 9E248 800ADA48 00000000 */   nop
  .L800ADA4C:
    /* 9E24C 800ADA4C 1000248E */  lw         $a0, 0x10($s1)
    /* 9E250 800ADA50 00000000 */  nop
    /* 9E254 800ADA54 21208600 */  addu       $a0, $a0, $a2
    /* 9E258 800ADA58 2320A400 */  subu       $a0, $a1, $a0
    /* 9E25C 800ADA5C 2BAC030C */  jal        fixedsqrt
    /* 9E260 800ADA60 21208200 */   addu      $a0, $a0, $v0
    /* 9E264 800ADA64 21804000 */  addu       $s0, $v0, $zero
    /* 9E268 800ADA68 C2171000 */  srl        $v0, $s0, 31
    /* 9E26C 800ADA6C 21100202 */  addu       $v0, $s0, $v0
    /* 9E270 800ADA70 C3100200 */  sra        $v0, $v0, 3
    /* 9E274 800ADA74 05000012 */  beqz       $s0, .L800ADA8C
    /* 9E278 800ADA78 000042A6 */   sh        $v0, 0x0($s2)
    /* 9E27C 800ADA7C 00800434 */  ori        $a0, $zero, 0x8000
    /* 9E280 800ADA80 0191030C */  jal        rdiv
    /* 9E284 800ADA84 21280002 */   addu      $a1, $s0, $zero
    /* 9E288 800ADA88 21804000 */  addu       $s0, $v0, $zero
  .L800ADA8C:
    /* 9E28C 800ADA8C 1C00228E */  lw         $v0, 0x1C($s1)
    /* 9E290 800ADA90 1400248E */  lw         $a0, 0x14($s1)
    /* 9E294 800ADA94 21280002 */  addu       $a1, $s0, $zero
    /* 9E298 800ADA98 CA90030C */  jal        fixedmult
    /* 9E29C 800ADA9C 23204400 */   subu      $a0, $v0, $a0
    /* 9E2A0 800ADAA0 83100200 */  sra        $v0, $v0, 2
    /* 9E2A4 800ADAA4 060042A6 */  sh         $v0, 0x6($s2)
    /* 9E2A8 800ADAA8 0C00228E */  lw         $v0, 0xC($s1)
    /* 9E2AC 800ADAAC 0400248E */  lw         $a0, 0x4($s1)
    /* 9E2B0 800ADAB0 21280002 */  addu       $a1, $s0, $zero
    /* 9E2B4 800ADAB4 CA90030C */  jal        fixedmult
    /* 9E2B8 800ADAB8 21204400 */   addu      $a0, $v0, $a0
    /* 9E2BC 800ADABC 83100200 */  sra        $v0, $v0, 2
    /* 9E2C0 800ADAC0 020042A6 */  sh         $v0, 0x2($s2)
    /* 9E2C4 800ADAC4 0800228E */  lw         $v0, 0x8($s1)
    /* 9E2C8 800ADAC8 1800248E */  lw         $a0, 0x18($s1)
    /* 9E2CC 800ADACC 21280002 */  addu       $a1, $s0, $zero
    /* 9E2D0 800ADAD0 21204400 */  addu       $a0, $v0, $a0
  .L800ADAD4:
    /* 9E2D4 800ADAD4 CA90030C */  jal        fixedmult
    /* 9E2D8 800ADAD8 00000000 */   nop
    /* 9E2DC 800ADADC 83100200 */  sra        $v0, $v0, 2
    /* 9E2E0 800ADAE0 05B70208 */  j          .L800ADC14
    /* 9E2E4 800ADAE4 040042A6 */   sh        $v0, 0x4($s2)
  .L800ADAE8:
    /* 9E2E8 800ADAE8 1000248E */  lw         $a0, 0x10($s1)
    /* 9E2EC 800ADAEC 2110C500 */  addu       $v0, $a2, $a1
    /* 9E2F0 800ADAF0 23208200 */  subu       $a0, $a0, $v0
    /* 9E2F4 800ADAF4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 9E2F8 800ADAF8 2BAC030C */  jal        fixedsqrt
    /* 9E2FC 800ADAFC 21208200 */   addu      $a0, $a0, $v0
    /* 9E300 800ADB00 21804000 */  addu       $s0, $v0, $zero
    /* 9E304 800ADB04 C2171000 */  srl        $v0, $s0, 31
    /* 9E308 800ADB08 21100202 */  addu       $v0, $s0, $v0
    /* 9E30C 800ADB0C C3100200 */  sra        $v0, $v0, 3
    /* 9E310 800ADB10 05000012 */  beqz       $s0, .L800ADB28
    /* 9E314 800ADB14 020042A6 */   sh        $v0, 0x2($s2)
    /* 9E318 800ADB18 00800434 */  ori        $a0, $zero, 0x8000
    /* 9E31C 800ADB1C 0191030C */  jal        rdiv
    /* 9E320 800ADB20 21280002 */   addu      $a1, $s0, $zero
    /* 9E324 800ADB24 21804000 */  addu       $s0, $v0, $zero
  .L800ADB28:
    /* 9E328 800ADB28 0800228E */  lw         $v0, 0x8($s1)
    /* 9E32C 800ADB2C 1800248E */  lw         $a0, 0x18($s1)
    /* 9E330 800ADB30 21280002 */  addu       $a1, $s0, $zero
    /* 9E334 800ADB34 CA90030C */  jal        fixedmult
    /* 9E338 800ADB38 23204400 */   subu      $a0, $v0, $a0
    /* 9E33C 800ADB3C 83100200 */  sra        $v0, $v0, 2
    /* 9E340 800ADB40 060042A6 */  sh         $v0, 0x6($s2)
    /* 9E344 800ADB44 1C00228E */  lw         $v0, 0x1C($s1)
    /* 9E348 800ADB48 1400248E */  lw         $a0, 0x14($s1)
    /* 9E34C 800ADB4C 21280002 */  addu       $a1, $s0, $zero
    /* 9E350 800ADB50 CA90030C */  jal        fixedmult
    /* 9E354 800ADB54 21204400 */   addu      $a0, $v0, $a0
    /* 9E358 800ADB58 83100200 */  sra        $v0, $v0, 2
    /* 9E35C 800ADB5C 040042A6 */  sh         $v0, 0x4($s2)
    /* 9E360 800ADB60 0C00228E */  lw         $v0, 0xC($s1)
    /* 9E364 800ADB64 0400248E */  lw         $a0, 0x4($s1)
    /* 9E368 800ADB68 21280002 */  addu       $a1, $s0, $zero
    /* 9E36C 800ADB6C CA90030C */  jal        fixedmult
    /* 9E370 800ADB70 21204400 */   addu      $a0, $v0, $a0
    /* 9E374 800ADB74 83100200 */  sra        $v0, $v0, 2
    /* 9E378 800ADB78 05B70208 */  j          .L800ADC14
    /* 9E37C 800ADB7C 000042A6 */   sh        $v0, 0x0($s2)
  .L800ADB80:
    /* 9E380 800ADB80 1000248E */  lw         $a0, 0x10($s1)
    /* 9E384 800ADB84 00000000 */  nop
    /* 9E388 800ADB88 2120A400 */  addu       $a0, $a1, $a0
    /* 9E38C 800ADB8C 2320C400 */  subu       $a0, $a2, $a0
    /* 9E390 800ADB90 2BAC030C */  jal        fixedsqrt
    /* 9E394 800ADB94 21208200 */   addu      $a0, $a0, $v0
    /* 9E398 800ADB98 21804000 */  addu       $s0, $v0, $zero
    /* 9E39C 800ADB9C C2171000 */  srl        $v0, $s0, 31
    /* 9E3A0 800ADBA0 21100202 */  addu       $v0, $s0, $v0
    /* 9E3A4 800ADBA4 C3100200 */  sra        $v0, $v0, 3
    /* 9E3A8 800ADBA8 05000012 */  beqz       $s0, .L800ADBC0
    /* 9E3AC 800ADBAC 040042A6 */   sh        $v0, 0x4($s2)
    /* 9E3B0 800ADBB0 00800434 */  ori        $a0, $zero, 0x8000
    /* 9E3B4 800ADBB4 0191030C */  jal        rdiv
    /* 9E3B8 800ADBB8 21280002 */   addu      $a1, $s0, $zero
    /* 9E3BC 800ADBBC 21804000 */  addu       $s0, $v0, $zero
  .L800ADBC0:
    /* 9E3C0 800ADBC0 0C00228E */  lw         $v0, 0xC($s1)
    /* 9E3C4 800ADBC4 0400248E */  lw         $a0, 0x4($s1)
    /* 9E3C8 800ADBC8 21280002 */  addu       $a1, $s0, $zero
    /* 9E3CC 800ADBCC CA90030C */  jal        fixedmult
    /* 9E3D0 800ADBD0 23204400 */   subu      $a0, $v0, $a0
    /* 9E3D4 800ADBD4 83100200 */  sra        $v0, $v0, 2
    /* 9E3D8 800ADBD8 060042A6 */  sh         $v0, 0x6($s2)
    /* 9E3DC 800ADBDC 0800228E */  lw         $v0, 0x8($s1)
    /* 9E3E0 800ADBE0 1800248E */  lw         $a0, 0x18($s1)
    /* 9E3E4 800ADBE4 21280002 */  addu       $a1, $s0, $zero
    /* 9E3E8 800ADBE8 CA90030C */  jal        fixedmult
    /* 9E3EC 800ADBEC 21204400 */   addu      $a0, $v0, $a0
    /* 9E3F0 800ADBF0 83100200 */  sra        $v0, $v0, 2
    /* 9E3F4 800ADBF4 000042A6 */  sh         $v0, 0x0($s2)
    /* 9E3F8 800ADBF8 1400228E */  lw         $v0, 0x14($s1)
    /* 9E3FC 800ADBFC 1C00248E */  lw         $a0, 0x1C($s1)
    /* 9E400 800ADC00 21280002 */  addu       $a1, $s0, $zero
    /* 9E404 800ADC04 CA90030C */  jal        fixedmult
    /* 9E408 800ADC08 21204400 */   addu      $a0, $v0, $a0
    /* 9E40C 800ADC0C 83100200 */  sra        $v0, $v0, 2
    /* 9E410 800ADC10 020042A6 */  sh         $v0, 0x2($s2)
  .L800ADC14:
    /* 9E414 800ADC14 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 9E418 800ADC18 1800B28F */  lw         $s2, 0x18($sp)
    /* 9E41C 800ADC1C 1400B18F */  lw         $s1, 0x14($sp)
    /* 9E420 800ADC20 1000B08F */  lw         $s0, 0x10($sp)
    /* 9E424 800ADC24 0800E003 */  jr         $ra
    /* 9E428 800ADC28 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Quatern_MatToQuat__FP10matrixtdefP5tQuat
