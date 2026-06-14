.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_InitSky__Fv, 0x344

glabel Hrz_InitSky__Fv
    /* C023C 800CFA3C 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0240 800CFA40 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C0244 800CFA44 3000BFAF */  sw         $ra, 0x30($sp)
    /* C0248 800CFA48 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* C024C 800CFA4C 2800B6AF */  sw         $s6, 0x28($sp)
    /* C0250 800CFA50 2400B5AF */  sw         $s5, 0x24($sp)
    /* C0254 800CFA54 2000B4AF */  sw         $s4, 0x20($sp)
    /* C0258 800CFA58 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C025C 800CFA5C 1800B2AF */  sw         $s2, 0x18($sp)
    /* C0260 800CFA60 1400B1AF */  sw         $s1, 0x14($sp)
    /* C0264 800CFA64 1000B0AF */  sw         $s0, 0x10($sp)
    /* C0268 800CFA68 3400448C */  lw         $a0, 0x34($v0)
    /* C026C 800CFA6C 29B5030C */  jal        fixedcos
    /* C0270 800CFA70 1280103C */   lui       $s0, %hi(TrackSpec_gSpec)
    /* C0274 800CFA74 21204000 */  addu       $a0, $v0, $zero
    /* C0278 800CFA78 CA90030C */  jal        fixedmult
    /* C027C 800CFA7C E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C0280 800CFA80 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0284 800CFA84 A41882A7 */  sh         $v0, %gp_rel(D_8013DDF0)($gp)
    /* C0288 800CFA88 3400648C */  lw         $a0, 0x34($v1)
    /* C028C 800CFA8C 09B5030C */  jal        fixedsin
    /* C0290 800CFA90 7C321026 */   addiu     $s0, $s0, %lo(TrackSpec_gSpec)
    /* C0294 800CFA94 21204000 */  addu       $a0, $v0, $zero
    /* C0298 800CFA98 CA90030C */  jal        fixedmult
    /* C029C 800CFA9C E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C02A0 800CFAA0 A81882A7 */  sh         $v0, %gp_rel(D_8013DDF4)($gp)
    /* C02A4 800CFAA4 90000296 */  lhu        $v0, 0x90($s0)
    /* C02A8 800CFAA8 C0000396 */  lhu        $v1, 0xC0($s0)
    /* C02AC 800CFAAC 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C02B0 800CFAB0 21104300 */  addu       $v0, $v0, $v1
    /* C02B4 800CFAB4 A61882A7 */  sh         $v0, %gp_rel(D_8013DDF2)($gp)
    /* C02B8 800CFAB8 3C00848C */  lw         $a0, 0x3C($a0)
    /* C02BC 800CFABC 29B5030C */  jal        fixedcos
    /* C02C0 800CFAC0 00000000 */   nop
    /* C02C4 800CFAC4 21204000 */  addu       $a0, $v0, $zero
    /* C02C8 800CFAC8 CA90030C */  jal        fixedmult
    /* C02CC 800CFACC E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C02D0 800CFAD0 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* C02D4 800CFAD4 AC1882A7 */  sh         $v0, %gp_rel(D_8013DDF8)($gp)
    /* C02D8 800CFAD8 3C00648C */  lw         $a0, 0x3C($v1)
    /* C02DC 800CFADC 09B5030C */  jal        fixedsin
    /* C02E0 800CFAE0 00000000 */   nop
    /* C02E4 800CFAE4 21204000 */  addu       $a0, $v0, $zero
    /* C02E8 800CFAE8 CA90030C */  jal        fixedmult
    /* C02EC 800CFAEC E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C02F0 800CFAF0 98000396 */  lhu        $v1, 0x98($s0)
    /* C02F4 800CFAF4 C0000496 */  lhu        $a0, 0xC0($s0)
    /* C02F8 800CFAF8 B01882A7 */  sh         $v0, %gp_rel(D_8013DDFC)($gp)
    /* C02FC 800CFAFC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* C0300 800CFB00 21186400 */  addu       $v1, $v1, $a0
    /* C0304 800CFB04 AE1883A7 */  sh         $v1, %gp_rel(D_8013DDFA)($gp)
    /* C0308 800CFB08 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* C030C 800CFB0C 01000224 */  addiu      $v0, $zero, 0x1
    /* C0310 800CFB10 0E006214 */  bne        $v1, $v0, .L800CFB4C
    /* C0314 800CFB14 00000000 */   nop
    /* C0318 800CFB18 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C031C 800CFB1C 1480043C */  lui        $a0, %hi(Draw_gPlayer1View)
    /* C0320 800CFB20 CCD3848C */  lw         $a0, %lo(Draw_gPlayer1View)($a0)
    /* C0324 800CFB24 30004590 */  lbu        $a1, 0x30($v0)
    /* C0328 800CFB28 31004690 */  lbu        $a2, 0x31($v0)
    /* C032C 800CFB2C 32004790 */  lbu        $a3, 0x32($v0)
    /* C0330 800CFB30 80F7020C */  jal        Draw_SetViewColor__Fiiii
    /* C0334 800CFB34 00000000 */   nop
    /* C0338 800CFB38 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C033C 800CFB3C 1480043C */  lui        $a0, %hi(Draw_gPlayer2View)
    /* C0340 800CFB40 D0D3848C */  lw         $a0, %lo(Draw_gPlayer2View)($a0)
    /* C0344 800CFB44 D63E0308 */  j          .L800CFB58
    /* C0348 800CFB48 00000000 */   nop
  .L800CFB4C:
    /* C034C 800CFB4C 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0350 800CFB50 1480043C */  lui        $a0, %hi(Draw_gPlayer1View)
    /* C0354 800CFB54 CCD3848C */  lw         $a0, %lo(Draw_gPlayer1View)($a0)
  .L800CFB58:
    /* C0358 800CFB58 30004590 */  lbu        $a1, 0x30($v0)
    /* C035C 800CFB5C 31004690 */  lbu        $a2, 0x31($v0)
    /* C0360 800CFB60 32004790 */  lbu        $a3, 0x32($v0)
    /* C0364 800CFB64 80F7020C */  jal        Draw_SetViewColor__Fiiii
    /* C0368 800CFB68 21980000 */   addu      $s3, $zero, $zero
    /* C036C 800CFB6C 21B06002 */  addu       $s6, $s3, $zero
    /* C0370 800CFB70 1280023C */  lui        $v0, %hi(gSkyMesh)
    /* C0374 800CFB74 78035724 */  addiu      $s7, $v0, %lo(gSkyMesh)
  .L800CFB78:
    /* C0378 800CFB78 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C037C 800CFB7C 00000000 */  nop
    /* C0380 800CFB80 0400838C */  lw         $v1, 0x4($a0)
    /* C0384 800CFB84 00000000 */  nop
    /* C0388 800CFB88 80006230 */  andi       $v0, $v1, 0x80
    /* C038C 800CFB8C 0E004010 */  beqz       $v0, .L800CFBC8
    /* C0390 800CFB90 80801300 */   sll       $s0, $s3, 2
    /* C0394 800CFB94 21109000 */  addu       $v0, $a0, $s0
    /* C0398 800CFB98 8000448C */  lw         $a0, 0x80($v0)
    /* C039C 800CFB9C 29B5030C */  jal        fixedcos
    /* C03A0 800CFBA0 00000000 */   nop
    /* C03A4 800CFBA4 21204000 */  addu       $a0, $v0, $zero
    /* C03A8 800CFBA8 CA90030C */  jal        fixedmult
    /* C03AC 800CFBAC E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C03B0 800CFBB0 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* C03B4 800CFBB4 00000000 */  nop
    /* C03B8 800CFBB8 21187000 */  addu       $v1, $v1, $s0
    /* C03BC 800CFBBC 8000648C */  lw         $a0, 0x80($v1)
    /* C03C0 800CFBC0 FF3E0308 */  j          .L800CFBFC
    /* C03C4 800CFBC4 21A84000 */   addu      $s5, $v0, $zero
  .L800CFBC8:
    /* C03C8 800CFBC8 02006230 */  andi       $v0, $v1, 0x2
    /* C03CC 800CFBCC 03004010 */  beqz       $v0, .L800CFBDC
    /* C03D0 800CFBD0 0400622A */   slti      $v0, $s3, 0x4
    /* C03D4 800CFBD4 02004014 */  bnez       $v0, .L800CFBE0
    /* C03D8 800CFBD8 C0821300 */   sll       $s0, $s3, 11
  .L800CFBDC:
    /* C03DC 800CFBDC 00831300 */  sll        $s0, $s3, 12
  .L800CFBE0:
    /* C03E0 800CFBE0 29B5030C */  jal        fixedcos
    /* C03E4 800CFBE4 21200002 */   addu      $a0, $s0, $zero
    /* C03E8 800CFBE8 21204000 */  addu       $a0, $v0, $zero
    /* C03EC 800CFBEC CA90030C */  jal        fixedmult
    /* C03F0 800CFBF0 E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C03F4 800CFBF4 21A84000 */  addu       $s5, $v0, $zero
    /* C03F8 800CFBF8 21200002 */  addu       $a0, $s0, $zero
  .L800CFBFC:
    /* C03FC 800CFBFC 09B5030C */  jal        fixedsin
    /* C0400 800CFC00 21880000 */   addu      $s1, $zero, $zero
    /* C0404 800CFC04 21204000 */  addu       $a0, $v0, $zero
    /* C0408 800CFC08 CA90030C */  jal        fixedmult
    /* C040C 800CFC0C E8030524 */   addiu     $a1, $zero, 0x3E8
    /* C0410 800CFC10 21A04000 */  addu       $s4, $v0, $zero
    /* C0414 800CFC14 C0101600 */  sll        $v0, $s6, 3
    /* C0418 800CFC18 21905700 */  addu       $s2, $v0, $s7
  .L800CFC1C:
    /* C041C 800CFC1C 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0420 800CFC20 00831100 */  sll        $s0, $s1, 12
    /* C0424 800CFC24 3400428C */  lw         $v0, 0x34($v0)
    /* C0428 800CFC28 01003126 */  addiu      $s1, $s1, 0x1
    /* C042C 800CFC2C 23800202 */  subu       $s0, $s0, $v0
    /* C0430 800CFC30 00401026 */  addiu      $s0, $s0, 0x4000
    /* C0434 800CFC34 09B5030C */  jal        fixedsin
    /* C0438 800CFC38 21200002 */   addu      $a0, $s0, $zero
    /* C043C 800CFC3C 21204000 */  addu       $a0, $v0, $zero
    /* C0440 800CFC40 CA90030C */  jal        fixedmult
    /* C0444 800CFC44 2128A002 */   addu      $a1, $s5, $zero
    /* C0448 800CFC48 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* C044C 800CFC4C 0100D626 */  addiu      $s6, $s6, 0x1
    /* C0450 800CFC50 000042A6 */  sh         $v0, 0x0($s2)
    /* C0454 800CFC54 68006294 */  lhu        $v0, 0x68($v1)
    /* C0458 800CFC58 21200002 */  addu       $a0, $s0, $zero
    /* C045C 800CFC5C 21105400 */  addu       $v0, $v0, $s4
    /* C0460 800CFC60 29B5030C */  jal        fixedcos
    /* C0464 800CFC64 020042A6 */   sh        $v0, 0x2($s2)
    /* C0468 800CFC68 21204000 */  addu       $a0, $v0, $zero
    /* C046C 800CFC6C CA90030C */  jal        fixedmult
    /* C0470 800CFC70 2128A002 */   addu      $a1, $s5, $zero
    /* C0474 800CFC74 040042A6 */  sh         $v0, 0x4($s2)
    /* C0478 800CFC78 1100222A */  slti       $v0, $s1, 0x11
    /* C047C 800CFC7C E7FF4014 */  bnez       $v0, .L800CFC1C
    /* C0480 800CFC80 08005226 */   addiu     $s2, $s2, 0x8
    /* C0484 800CFC84 01007326 */  addiu      $s3, $s3, 0x1
    /* C0488 800CFC88 0500622A */  slti       $v0, $s3, 0x5
    /* C048C 800CFC8C BAFF4014 */  bnez       $v0, .L800CFB78
    /* C0490 800CFC90 00000000 */   nop
    /* C0494 800CFC94 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0498 800CFC98 00000000 */  nop
    /* C049C 800CFC9C 0000438C */  lw         $v1, 0x0($v0)
    /* C04A0 800CFCA0 01000224 */  addiu      $v0, $zero, 0x1
    /* C04A4 800CFCA4 27006214 */  bne        $v1, $v0, .L800CFD44
    /* C04A8 800CFCA8 21980000 */   addu      $s3, $zero, $zero
    /* C04AC 800CFCAC 21B06002 */  addu       $s6, $s3, $zero
    /* C04B0 800CFCB0 1280023C */  lui        $v0, %hi(gSkyPixmapIndex)
    /* C04B4 800CFCB4 74074624 */  addiu      $a2, $v0, %lo(gSkyPixmapIndex)
  .L800CFCB8:
    /* C04B8 800CFCB8 21880000 */  addu       $s1, $zero, $zero
    /* C04BC 800CFCBC 80281300 */  sll        $a1, $s3, 2
  .L800CFCC0:
    /* C04C0 800CFCC0 21102002 */  addu       $v0, $s1, $zero
    /* C04C4 800CFCC4 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* C04C8 800CFCC8 02002106 */  bgez       $s1, .L800CFCD4
    /* C04CC 800CFCCC 2120C602 */   addu      $a0, $s6, $a2
    /* C04D0 800CFCD0 03002226 */  addiu      $v0, $s1, 0x3
  .L800CFCD4:
    /* C04D4 800CFCD4 83100200 */  sra        $v0, $v0, 2
    /* C04D8 800CFCD8 80100200 */  sll        $v0, $v0, 2
    /* C04DC 800CFCDC 23102202 */  subu       $v0, $s1, $v0
    /* C04E0 800CFCE0 01003126 */  addiu      $s1, $s1, 0x1
    /* C04E4 800CFCE4 21104500 */  addu       $v0, $v0, $a1
    /* C04E8 800CFCE8 21106200 */  addu       $v0, $v1, $v0
    /* C04EC 800CFCEC 6C004290 */  lbu        $v0, 0x6C($v0)
    /* C04F0 800CFCF0 00000000 */  nop
    /* C04F4 800CFCF4 08004224 */  addiu      $v0, $v0, 0x8
    /* C04F8 800CFCF8 000082A0 */  sb         $v0, 0x0($a0)
    /* C04FC 800CFCFC 1000222A */  slti       $v0, $s1, 0x10
    /* C0500 800CFD00 EFFF4014 */  bnez       $v0, .L800CFCC0
    /* C0504 800CFD04 0100D626 */   addiu     $s6, $s6, 0x1
    /* C0508 800CFD08 01007326 */  addiu      $s3, $s3, 0x1
    /* C050C 800CFD0C 0400622A */  slti       $v0, $s3, 0x4
    /* C0510 800CFD10 E9FF4014 */  bnez       $v0, .L800CFCB8
    /* C0514 800CFD14 01000224 */   addiu     $v0, $zero, 0x1
    /* C0518 800CFD18 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C051C 800CFD1C 00000000 */  nop
    /* C0520 800CFD20 0000838C */  lw         $v1, 0x0($a0)
    /* C0524 800CFD24 00000000 */  nop
    /* C0528 800CFD28 06006214 */  bne        $v1, $v0, .L800CFD44
    /* C052C 800CFD2C 00000000 */   nop
    /* C0530 800CFD30 0400828C */  lw         $v0, 0x4($a0)
    /* C0534 800CFD34 00000000 */  nop
    /* C0538 800CFD38 20004230 */  andi       $v0, $v0, 0x20
    /* C053C 800CFD3C 03004010 */  beqz       $v0, .L800CFD4C
    /* C0540 800CFD40 00000000 */   nop
  .L800CFD44:
    /* C0544 800CFD44 383E030C */  jal        Hrz_InitSkyColor__Fv
    /* C0548 800CFD48 00000000 */   nop
  .L800CFD4C:
    /* C054C 800CFD4C D13A030C */  jal        Flare_InitLensFlare__Fv
    /* C0550 800CFD50 00000000 */   nop
    /* C0554 800CFD54 3000BF8F */  lw         $ra, 0x30($sp)
    /* C0558 800CFD58 2C00B78F */  lw         $s7, 0x2C($sp)
    /* C055C 800CFD5C 2800B68F */  lw         $s6, 0x28($sp)
    /* C0560 800CFD60 2400B58F */  lw         $s5, 0x24($sp)
    /* C0564 800CFD64 2000B48F */  lw         $s4, 0x20($sp)
    /* C0568 800CFD68 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C056C 800CFD6C 1800B28F */  lw         $s2, 0x18($sp)
    /* C0570 800CFD70 1400B18F */  lw         $s1, 0x14($sp)
    /* C0574 800CFD74 1000B08F */  lw         $s0, 0x10($sp)
    /* C0578 800CFD78 0800E003 */  jr         $ra
    /* C057C 800CFD7C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Hrz_InitSky__Fv
