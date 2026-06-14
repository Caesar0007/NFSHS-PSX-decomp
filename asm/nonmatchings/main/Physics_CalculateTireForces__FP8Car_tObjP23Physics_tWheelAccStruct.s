.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct, 0x568

glabel Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9C23C 800ABA3C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 9C240 800ABA40 2000B2AF */  sw         $s2, 0x20($sp)
    /* 9C244 800ABA44 21908000 */  addu       $s2, $a0, $zero
    /* 9C248 800ABA48 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 9C24C 800ABA4C 2188A000 */  addu       $s1, $a1, $zero
    /* 9C250 800ABA50 2800BFAF */  sw         $ra, 0x28($sp)
    /* 9C254 800ABA54 2400B3AF */  sw         $s3, 0x24($sp)
    /* 9C258 800ABA58 1800B0AF */  sw         $s0, 0x18($sp)
    /* 9C25C 800ABA5C 0C00228E */  lw         $v0, 0xC($s1)
    /* 9C260 800ABA60 0400338E */  lw         $s3, 0x4($s1)
    /* 9C264 800ABA64 21800000 */  addu       $s0, $zero, $zero
    /* 9C268 800ABA68 08004010 */  beqz       $v0, .L800ABA8C
    /* 9C26C 800ABA6C 2C0020AE */   sw        $zero, 0x2C($s1)
    /* 9C270 800ABA70 18002226 */  addiu      $v0, $s1, 0x18
    /* 9C274 800ABA74 1000A2AF */  sw         $v0, 0x10($sp)
    /* 9C278 800ABA78 1000248E */  lw         $a0, 0x10($s1)
    /* 9C27C 800ABA7C 1800258E */  lw         $a1, 0x18($s1)
    /* 9C280 800ABA80 0C00268E */  lw         $a2, 0xC($s1)
    /* 9C284 800ABA84 8A75020C */  jal        Math_ResolveRotatedVector__FiiiPiT3
    /* 9C288 800ABA88 10002726 */   addiu     $a3, $s1, 0x10
  .L800ABA8C:
    /* 9C28C 800ABA8C 0000248E */  lw         $a0, 0x0($s1)
    /* 9C290 800ABA90 00000000 */  nop
    /* 9C294 800ABA94 12008104 */  bgez       $a0, .L800ABAE0
    /* 9C298 800ABA98 00000000 */   nop
    /* 9C29C 800ABA9C 1800238E */  lw         $v1, 0x18($s1)
    /* 9C2A0 800ABAA0 00000000 */  nop
    /* 9C2A4 800ABAA4 0E006104 */  bgez       $v1, .L800ABAE0
    /* 9C2A8 800ABAA8 00000000 */   nop
    /* 9C2AC 800ABAAC A80D828F */  lw         $v0, %gp_rel(gGasRatio)($gp)
    /* 9C2B0 800ABAB0 00000000 */  nop
    /* 9C2B4 800ABAB4 01404228 */  slti       $v0, $v0, 0x4001
    /* 9C2B8 800ABAB8 05004014 */  bnez       $v0, .L800ABAD0
    /* 9C2BC 800ABABC 2A106400 */   slt       $v0, $v1, $a0
    /* 9C2C0 800ABAC0 42044292 */  lbu        $v0, 0x442($s2)
    /* 9C2C4 800ABAC4 00000000 */  nop
    /* 9C2C8 800ABAC8 1A004010 */  beqz       $v0, .L800ABB34
    /* 9C2CC 800ABACC 2A106400 */   slt       $v0, $v1, $a0
  .L800ABAD0:
    /* 9C2D0 800ABAD0 16004010 */  beqz       $v0, .L800ABB2C
    /* 9C2D4 800ABAD4 00000000 */   nop
    /* 9C2D8 800ABAD8 CBAE0208 */  j          .L800ABB2C
    /* 9C2DC 800ABADC 21188000 */   addu      $v1, $a0, $zero
  .L800ABAE0:
    /* 9C2E0 800ABAE0 14008018 */  blez       $a0, .L800ABB34
    /* 9C2E4 800ABAE4 00000000 */   nop
    /* 9C2E8 800ABAE8 1800238E */  lw         $v1, 0x18($s1)
    /* 9C2EC 800ABAEC 00000000 */  nop
    /* 9C2F0 800ABAF0 10006018 */  blez       $v1, .L800ABB34
    /* 9C2F4 800ABAF4 00000000 */   nop
    /* 9C2F8 800ABAF8 A80D828F */  lw         $v0, %gp_rel(gGasRatio)($gp)
    /* 9C2FC 800ABAFC 00000000 */  nop
    /* 9C300 800ABB00 01404228 */  slti       $v0, $v0, 0x4001
    /* 9C304 800ABB04 06004014 */  bnez       $v0, .L800ABB20
    /* 9C308 800ABB08 2A106400 */   slt       $v0, $v1, $a0
    /* 9C30C 800ABB0C 42044292 */  lbu        $v0, 0x442($s2)
    /* 9C310 800ABB10 00000000 */  nop
    /* 9C314 800ABB14 0200422C */  sltiu      $v0, $v0, 0x2
    /* 9C318 800ABB18 06004010 */  beqz       $v0, .L800ABB34
    /* 9C31C 800ABB1C 2A106400 */   slt       $v0, $v1, $a0
  .L800ABB20:
    /* 9C320 800ABB20 02004014 */  bnez       $v0, .L800ABB2C
    /* 9C324 800ABB24 00000000 */   nop
    /* 9C328 800ABB28 21188000 */  addu       $v1, $a0, $zero
  .L800ABB2C:
    /* 9C32C 800ABB2C 000023AE */  sw         $v1, 0x0($s1)
    /* 9C330 800ABB30 01001024 */  addiu      $s0, $zero, 0x1
  .L800ABB34:
    /* 9C334 800ABB34 6404428E */  lw         $v0, 0x464($s2)
    /* 9C338 800ABB38 0000248E */  lw         $a0, 0x0($s1)
    /* 9C33C 800ABB3C 1401458C */  lw         $a1, 0x114($v0)
    /* 9C340 800ABB40 CA90030C */  jal        fixedmult
    /* 9C344 800ABB44 00000000 */   nop
    /* 9C348 800ABB48 21184000 */  addu       $v1, $v0, $zero
    /* 9C34C 800ABB4C 08000012 */  beqz       $s0, .L800ABB70
    /* 9C350 800ABB50 000023AE */   sw        $v1, 0x0($s1)
    /* 9C354 800ABB54 0400228E */  lw         $v0, 0x4($s1)
    /* 9C358 800ABB58 02006104 */  bgez       $v1, .L800ABB64
    /* 9C35C 800ABB5C 00000000 */   nop
    /* 9C360 800ABB60 23180300 */  negu       $v1, $v1
  .L800ABB64:
    /* 9C364 800ABB64 2A104300 */  slt        $v0, $v0, $v1
    /* 9C368 800ABB68 11004014 */  bnez       $v0, .L800ABBB0
    /* 9C36C 800ABB6C 00000000 */   nop
  .L800ABB70:
    /* 9C370 800ABB70 45044292 */  lbu        $v0, 0x445($s2)
    /* 9C374 800ABB74 00000000 */  nop
    /* 9C378 800ABB78 5F004010 */  beqz       $v0, .L800ABCF8
    /* 9C37C 800ABB7C 00000000 */   nop
    /* 9C380 800ABB80 2800228E */  lw         $v0, 0x28($s1)
    /* 9C384 800ABB84 00000000 */  nop
    /* 9C388 800ABB88 5B004014 */  bnez       $v0, .L800ABCF8
    /* 9C38C 800ABB8C 00800234 */   ori       $v0, $zero, 0x8000
    /* 9C390 800ABB90 2004438E */  lw         $v1, 0x420($s2)
    /* 9C394 800ABB94 00000000 */  nop
    /* 9C398 800ABB98 02006104 */  bgez       $v1, .L800ABBA4
    /* 9C39C 800ABB9C 00000000 */   nop
    /* 9C3A0 800ABBA0 23180300 */  negu       $v1, $v1
  .L800ABBA4:
    /* 9C3A4 800ABBA4 2A104300 */  slt        $v0, $v0, $v1
    /* 9C3A8 800ABBA8 53004010 */  beqz       $v0, .L800ABCF8
    /* 9C3AC 800ABBAC 00000000 */   nop
  .L800ABBB0:
    /* 9C3B0 800ABBB0 45044292 */  lbu        $v0, 0x445($s2)
    /* 9C3B4 800ABBB4 00000000 */  nop
    /* 9C3B8 800ABBB8 3B004014 */  bnez       $v0, .L800ABCA8
    /* 9C3BC 800ABBBC 00000000 */   nop
    /* 9C3C0 800ABBC0 8802428E */  lw         $v0, 0x288($s2)
    /* 9C3C4 800ABBC4 00000000 */  nop
    /* 9C3C8 800ABBC8 4800428C */  lw         $v0, 0x48($v0)
    /* 9C3CC 800ABBCC 00000000 */  nop
    /* 9C3D0 800ABBD0 16004014 */  bnez       $v0, .L800ABC2C
    /* 9C3D4 800ABBD4 1900023C */   lui       $v0, (0x190000 >> 16)
    /* 9C3D8 800ABBD8 2004438E */  lw         $v1, 0x420($s2)
    /* 9C3DC 800ABBDC 00000000 */  nop
    /* 9C3E0 800ABBE0 2A104300 */  slt        $v0, $v0, $v1
    /* 9C3E4 800ABBE4 11004014 */  bnez       $v0, .L800ABC2C
    /* 9C3E8 800ABBE8 00000000 */   nop
    /* 9C3EC 800ABBEC 40044292 */  lbu        $v0, 0x440($s2)
    /* 9C3F0 800ABBF0 00000000 */  nop
    /* 9C3F4 800ABBF4 EC00422C */  sltiu      $v0, $v0, 0xEC
    /* 9C3F8 800ABBF8 0C004014 */  bnez       $v0, .L800ABC2C
    /* 9C3FC 800ABBFC 0400023C */   lui       $v0, (0x4FFFF >> 16)
    /* 9C400 800ABC00 FFFF4234 */  ori        $v0, $v0, (0x4FFFF & 0xFFFF)
    /* 9C404 800ABC04 02006104 */  bgez       $v1, .L800ABC10
    /* 9C408 800ABC08 00000000 */   nop
    /* 9C40C 800ABC0C 23180300 */  negu       $v1, $v1
  .L800ABC10:
    /* 9C410 800ABC10 2A104300 */  slt        $v0, $v0, $v1
    /* 9C414 800ABC14 24004014 */  bnez       $v0, .L800ABCA8
    /* 9C418 800ABC18 00000000 */   nop
    /* 9C41C 800ABC1C 6C04428E */  lw         $v0, 0x46C($s2)
    /* 9C420 800ABC20 00000000 */  nop
    /* 9C424 800ABC24 20004014 */  bnez       $v0, .L800ABCA8
    /* 9C428 800ABC28 00000000 */   nop
  .L800ABC2C:
    /* 9C42C 800ABC2C 0000248E */  lw         $a0, 0x0($s1)
    /* 9C430 800ABC30 0400238E */  lw         $v1, 0x4($s1)
    /* 9C434 800ABC34 00000000 */  nop
    /* 9C438 800ABC38 2A106400 */  slt        $v0, $v1, $a0
    /* 9C43C 800ABC3C 05004014 */  bnez       $v0, .L800ABC54
    /* 9C440 800ABC40 00000000 */   nop
    /* 9C444 800ABC44 23180300 */  negu       $v1, $v1
    /* 9C448 800ABC48 2A108300 */  slt        $v0, $a0, $v1
    /* 9C44C 800ABC4C 02004010 */  beqz       $v0, .L800ABC58
    /* 9C450 800ABC50 00000000 */   nop
  .L800ABC54:
    /* 9C454 800ABC54 000023AE */  sw         $v1, 0x0($s1)
  .L800ABC58:
    /* 9C458 800ABC58 8802428E */  lw         $v0, 0x288($s2)
    /* 9C45C 800ABC5C 00000000 */  nop
    /* 9C460 800ABC60 4800428C */  lw         $v0, 0x48($v0)
    /* 9C464 800ABC64 00000000 */  nop
    /* 9C468 800ABC68 23004010 */  beqz       $v0, .L800ABCF8
    /* 9C46C 800ABC6C 1800023C */   lui       $v0, (0x18FFFF >> 16)
    /* 9C470 800ABC70 2004438E */  lw         $v1, 0x420($s2)
    /* 9C474 800ABC74 FFFF4234 */  ori        $v0, $v0, (0x18FFFF & 0xFFFF)
    /* 9C478 800ABC78 2A104300 */  slt        $v0, $v0, $v1
    /* 9C47C 800ABC7C 1E004014 */  bnez       $v0, .L800ABCF8
    /* 9C480 800ABC80 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 9C484 800ABC84 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 9C488 800ABC88 00000000 */  nop
    /* 9C48C 800ABC8C 03004230 */  andi       $v0, $v0, 0x3
    /* 9C490 800ABC90 03004014 */  bnez       $v0, .L800ABCA0
    /* 9C494 800ABC94 0800023C */   lui       $v0, (0x80000 >> 16)
    /* 9C498 800ABC98 3EAF0208 */  j          .L800ABCF8
    /* 9C49C 800ABC9C 2C0022AE */   sw        $v0, 0x2C($s1)
  .L800ABCA0:
    /* 9C4A0 800ABCA0 3EAF0208 */  j          .L800ABCF8
    /* 9C4A4 800ABCA4 2C0020AE */   sw        $zero, 0x2C($s1)
  .L800ABCA8:
    /* 9C4A8 800ABCA8 2800228E */  lw         $v0, 0x28($s1)
    /* 9C4AC 800ABCAC 00000000 */  nop
    /* 9C4B0 800ABCB0 04004010 */  beqz       $v0, .L800ABCC4
    /* 9C4B4 800ABCB4 00000000 */   nop
    /* 9C4B8 800ABCB8 7404428E */  lw         $v0, 0x474($s2)
    /* 9C4BC 800ABCBC 34AF0208 */  j          .L800ABCD0
    /* 9C4C0 800ABCC0 01004224 */   addiu     $v0, $v0, 0x1
  .L800ABCC4:
    /* 9C4C4 800ABCC4 7404428E */  lw         $v0, 0x474($s2)
    /* 9C4C8 800ABCC8 00000000 */  nop
    /* 9C4CC 800ABCCC 02004224 */  addiu      $v0, $v0, 0x2
  .L800ABCD0:
    /* 9C4D0 800ABCD0 740442AE */  sw         $v0, 0x474($s2)
    /* 9C4D4 800ABCD4 21204002 */  addu       $a0, $s2, $zero
    /* 9C4D8 800ABCD8 27AD020C */  jal        Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9C4DC 800ABCDC 21282002 */   addu      $a1, $s1, $zero
    /* 9C4E0 800ABCE0 2800228E */  lw         $v0, 0x28($s1)
    /* 9C4E4 800ABCE4 00000000 */  nop
    /* 9C4E8 800ABCE8 A4004010 */  beqz       $v0, .L800ABF7C
    /* 9C4EC 800ABCEC 00000000 */   nop
    /* 9C4F0 800ABCF0 DCAF0208 */  j          .L800ABF70
    /* 9C4F4 800ABCF4 00000000 */   nop
  .L800ABCF8:
    /* 9C4F8 800ABCF8 1800258E */  lw         $a1, 0x18($s1)
    /* 9C4FC 800ABCFC 00000000 */  nop
    /* 9C500 800ABD00 1500A010 */  beqz       $a1, .L800ABD58
    /* 9C504 800ABD04 23280500 */   negu      $a1, $a1
    /* 9C508 800ABD08 C2170500 */  srl        $v0, $a1, 31
    /* 9C50C 800ABD0C 2128A200 */  addu       $a1, $a1, $v0
    /* 9C510 800ABD10 1000248E */  lw         $a0, 0x10($s1)
    /* 9C514 800ABD14 4AB5030C */  jal        fixedatan
    /* 9C518 800ABD18 43280500 */   sra       $a1, $a1, 1
    /* 9C51C 800ABD1C 1800238E */  lw         $v1, 0x18($s1)
    /* 9C520 800ABD20 00000000 */  nop
    /* 9C524 800ABD24 0A006018 */  blez       $v1, .L800ABD50
    /* 9C528 800ABD28 21804000 */   addu      $s0, $v0, $zero
    /* 9C52C 800ABD2C 1000228E */  lw         $v0, 0x10($s1)
    /* 9C530 800ABD30 00000000 */  nop
    /* 9C534 800ABD34 03004018 */  blez       $v0, .L800ABD44
    /* 9C538 800ABD38 00000000 */   nop
    /* 9C53C 800ABD3C 53AF0208 */  j          .L800ABD4C
    /* 9C540 800ABD40 00800234 */   ori       $v0, $zero, 0x8000
  .L800ABD44:
    /* 9C544 800ABD44 02004104 */  bgez       $v0, .L800ABD50
    /* 9C548 800ABD48 00800224 */   addiu     $v0, $zero, -0x8000
  .L800ABD4C:
    /* 9C54C 800ABD4C 23805000 */  subu       $s0, $v0, $s0
  .L800ABD50:
    /* 9C550 800ABD50 57AF0208 */  j          .L800ABD5C
    /* 9C554 800ABD54 00821000 */   sll       $s0, $s0, 8
  .L800ABD58:
    /* 9C558 800ABD58 21800000 */  addu       $s0, $zero, $zero
  .L800ABD5C:
    /* 9C55C 800ABD5C 2800228E */  lw         $v0, 0x28($s1)
    /* 9C560 800ABD60 00000000 */  nop
    /* 9C564 800ABD64 3B004010 */  beqz       $v0, .L800ABE54
    /* 9C568 800ABD68 1000043C */   lui       $a0, (0x100000 >> 16)
    /* 9C56C 800ABD6C 02000106 */  bgez       $s0, .L800ABD78
    /* 9C570 800ABD70 21180002 */   addu      $v1, $s0, $zero
    /* 9C574 800ABD74 23180300 */  negu       $v1, $v1
  .L800ABD78:
    /* 9C578 800ABD78 21108000 */  addu       $v0, $a0, $zero
    /* 9C57C 800ABD7C 2A104300 */  slt        $v0, $v0, $v1
    /* 9C580 800ABD80 02004014 */  bnez       $v0, .L800ABD8C
    /* 9C584 800ABD84 00000000 */   nop
    /* 9C588 800ABD88 21206000 */  addu       $a0, $v1, $zero
  .L800ABD8C:
    /* 9C58C 800ABD8C CA90030C */  jal        fixedmult
    /* 9C590 800ABD90 21286002 */   addu      $a1, $s3, $zero
    /* 9C594 800ABD94 21204000 */  addu       $a0, $v0, $zero
    /* 9C598 800ABD98 CA90030C */  jal        fixedmult
    /* 9C59C 800ABD9C 55150524 */   addiu     $a1, $zero, 0x1555
    /* 9C5A0 800ABDA0 02000106 */  bgez       $s0, .L800ABDAC
    /* 9C5A4 800ABDA4 21284000 */   addu      $a1, $v0, $zero
    /* 9C5A8 800ABDA8 23280500 */  negu       $a1, $a1
  .L800ABDAC:
    /* 9C5AC 800ABDAC 1F00043C */  lui        $a0, (0x1FFFFF >> 16)
    /* 9C5B0 800ABDB0 1180023C */  lui        $v0, %hi(gravity_ch)
    /* 9C5B4 800ABDB4 FFFF8434 */  ori        $a0, $a0, (0x1FFFFF & 0xFFFF)
    /* 9C5B8 800ABDB8 1C0025AE */  sw         $a1, 0x1C($s1)
    /* 9C5BC 800ABDBC D465428C */  lw         $v0, %lo(gravity_ch)($v0)
    /* 9C5C0 800ABDC0 1000268E */  lw         $a2, 0x10($s1)
    /* 9C5C4 800ABDC4 C21F0200 */  srl        $v1, $v0, 31
    /* 9C5C8 800ABDC8 21104300 */  addu       $v0, $v0, $v1
    /* 9C5CC 800ABDCC 43100200 */  sra        $v0, $v0, 1
    /* 9C5D0 800ABDD0 2110A200 */  addu       $v0, $a1, $v0
    /* 9C5D4 800ABDD4 1C0022AE */  sw         $v0, 0x1C($s1)
    /* 9C5D8 800ABDD8 1800228E */  lw         $v0, 0x18($s1)
    /* 9C5DC 800ABDDC 0200C104 */  bgez       $a2, .L800ABDE8
    /* 9C5E0 800ABDE0 2118C000 */   addu      $v1, $a2, $zero
    /* 9C5E4 800ABDE4 23180300 */  negu       $v1, $v1
  .L800ABDE8:
    /* 9C5E8 800ABDE8 02004104 */  bgez       $v0, .L800ABDF4
    /* 9C5EC 800ABDEC 00000000 */   nop
    /* 9C5F0 800ABDF0 23100200 */  negu       $v0, $v0
  .L800ABDF4:
    /* 9C5F4 800ABDF4 21186200 */  addu       $v1, $v1, $v0
    /* 9C5F8 800ABDF8 2A208300 */  slt        $a0, $a0, $v1
    /* 9C5FC 800ABDFC 48008014 */  bnez       $a0, .L800ABF20
    /* 9C600 800ABE00 00000000 */   nop
    /* 9C604 800ABE04 0A00C018 */  blez       $a2, .L800ABE30
    /* 9C608 800ABE08 00000000 */   nop
    /* 9C60C 800ABE0C 0200A104 */  bgez       $a1, .L800ABE18
    /* 9C610 800ABE10 2110A000 */   addu      $v0, $a1, $zero
    /* 9C614 800ABE14 23100200 */  negu       $v0, $v0
  .L800ABE18:
    /* 9C618 800ABE18 21184000 */  addu       $v1, $v0, $zero
    /* 9C61C 800ABE1C 2A106600 */  slt        $v0, $v1, $a2
    /* 9C620 800ABE20 3E004014 */  bnez       $v0, .L800ABF1C
    /* 9C624 800ABE24 00000000 */   nop
    /* 9C628 800ABE28 C7AF0208 */  j          .L800ABF1C
    /* 9C62C 800ABE2C 2118C000 */   addu      $v1, $a2, $zero
  .L800ABE30:
    /* 9C630 800ABE30 0200A104 */  bgez       $a1, .L800ABE3C
    /* 9C634 800ABE34 2110A000 */   addu      $v0, $a1, $zero
    /* 9C638 800ABE38 23100200 */  negu       $v0, $v0
  .L800ABE3C:
    /* 9C63C 800ABE3C 23180200 */  negu       $v1, $v0
    /* 9C640 800ABE40 2A106600 */  slt        $v0, $v1, $a2
    /* 9C644 800ABE44 35004010 */  beqz       $v0, .L800ABF1C
    /* 9C648 800ABE48 00000000 */   nop
    /* 9C64C 800ABE4C C7AF0208 */  j          .L800ABF1C
    /* 9C650 800ABE50 2118C000 */   addu      $v1, $a2, $zero
  .L800ABE54:
    /* 9C654 800ABE54 02000106 */  bgez       $s0, .L800ABE60
    /* 9C658 800ABE58 21180002 */   addu      $v1, $s0, $zero
    /* 9C65C 800ABE5C 23180300 */  negu       $v1, $v1
  .L800ABE60:
    /* 9C660 800ABE60 00800534 */  ori        $a1, $zero, 0x8000
    /* 9C664 800ABE64 2A106500 */  slt        $v0, $v1, $a1
    /* 9C668 800ABE68 02004010 */  beqz       $v0, .L800ABE74
    /* 9C66C 800ABE6C 0200023C */   lui       $v0, (0x20000 >> 16)
    /* 9C670 800ABE70 2118A000 */  addu       $v1, $a1, $zero
  .L800ABE74:
    /* 9C674 800ABE74 2A104300 */  slt        $v0, $v0, $v1
    /* 9C678 800ABE78 08004014 */  bnez       $v0, .L800ABE9C
    /* 9C67C 800ABE7C 0200043C */   lui       $a0, (0x20000 >> 16)
    /* 9C680 800ABE80 02000106 */  bgez       $s0, .L800ABE8C
    /* 9C684 800ABE84 21200002 */   addu      $a0, $s0, $zero
    /* 9C688 800ABE88 23200400 */  negu       $a0, $a0
  .L800ABE8C:
    /* 9C68C 800ABE8C 2A108500 */  slt        $v0, $a0, $a1
    /* 9C690 800ABE90 02004010 */  beqz       $v0, .L800ABE9C
    /* 9C694 800ABE94 00000000 */   nop
    /* 9C698 800ABE98 00800434 */  ori        $a0, $zero, 0x8000
  .L800ABE9C:
    /* 9C69C 800ABE9C CA90030C */  jal        fixedmult
    /* 9C6A0 800ABEA0 21286002 */   addu      $a1, $s3, $zero
    /* 9C6A4 800ABEA4 C21F0200 */  srl        $v1, $v0, 31
    /* 9C6A8 800ABEA8 21186200 */  addu       $v1, $v1, $v0
    /* 9C6AC 800ABEAC 02000106 */  bgez       $s0, .L800ABEB8
    /* 9C6B0 800ABEB0 43280300 */   sra       $a1, $v1, 1
    /* 9C6B4 800ABEB4 23280500 */  negu       $a1, $a1
  .L800ABEB8:
    /* 9C6B8 800ABEB8 1180023C */  lui        $v0, %hi(gravity_ch)
    /* 9C6BC 800ABEBC D465428C */  lw         $v0, %lo(gravity_ch)($v0)
    /* 9C6C0 800ABEC0 1000248E */  lw         $a0, 0x10($s1)
    /* 9C6C4 800ABEC4 C21F0200 */  srl        $v1, $v0, 31
    /* 9C6C8 800ABEC8 21104300 */  addu       $v0, $v0, $v1
    /* 9C6CC 800ABECC 43100200 */  sra        $v0, $v0, 1
    /* 9C6D0 800ABED0 0A008018 */  blez       $a0, .L800ABEFC
    /* 9C6D4 800ABED4 2128A200 */   addu      $a1, $a1, $v0
    /* 9C6D8 800ABED8 0200A104 */  bgez       $a1, .L800ABEE4
    /* 9C6DC 800ABEDC 2110A000 */   addu      $v0, $a1, $zero
    /* 9C6E0 800ABEE0 23100200 */  negu       $v0, $v0
  .L800ABEE4:
    /* 9C6E4 800ABEE4 21184000 */  addu       $v1, $v0, $zero
    /* 9C6E8 800ABEE8 2A106400 */  slt        $v0, $v1, $a0
    /* 9C6EC 800ABEEC 0B004014 */  bnez       $v0, .L800ABF1C
    /* 9C6F0 800ABEF0 00000000 */   nop
    /* 9C6F4 800ABEF4 C7AF0208 */  j          .L800ABF1C
    /* 9C6F8 800ABEF8 21188000 */   addu      $v1, $a0, $zero
  .L800ABEFC:
    /* 9C6FC 800ABEFC 0200A104 */  bgez       $a1, .L800ABF08
    /* 9C700 800ABF00 2110A000 */   addu      $v0, $a1, $zero
    /* 9C704 800ABF04 23100200 */  negu       $v0, $v0
  .L800ABF08:
    /* 9C708 800ABF08 23180200 */  negu       $v1, $v0
    /* 9C70C 800ABF0C 2A106400 */  slt        $v0, $v1, $a0
    /* 9C710 800ABF10 02004010 */  beqz       $v0, .L800ABF1C
    /* 9C714 800ABF14 00000000 */   nop
    /* 9C718 800ABF18 21188000 */  addu       $v1, $a0, $zero
  .L800ABF1C:
    /* 9C71C 800ABF1C 1C0023AE */  sw         $v1, 0x1C($s1)
  .L800ABF20:
    /* 9C720 800ABF20 21204002 */  addu       $a0, $s2, $zero
    /* 9C724 800ABF24 0000228E */  lw         $v0, 0x0($s1)
    /* 9C728 800ABF28 21282002 */  addu       $a1, $s1, $zero
    /* 9C72C 800ABF2C 200020AE */  sw         $zero, 0x20($s1)
    /* 9C730 800ABF30 A6AD020C */  jal        Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct
    /* 9C734 800ABF34 240022AE */   sw        $v0, 0x24($s1)
    /* 9C738 800ABF38 0C00268E */  lw         $a2, 0xC($s1)
    /* 9C73C 800ABF3C 00000000 */  nop
    /* 9C740 800ABF40 0700C010 */  beqz       $a2, .L800ABF60
    /* 9C744 800ABF44 23300600 */   negu      $a2, $a2
    /* 9C748 800ABF48 24002226 */  addiu      $v0, $s1, 0x24
    /* 9C74C 800ABF4C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 9C750 800ABF50 1C00248E */  lw         $a0, 0x1C($s1)
    /* 9C754 800ABF54 2400258E */  lw         $a1, 0x24($s1)
    /* 9C758 800ABF58 8A75020C */  jal        Math_ResolveRotatedVector__FiiiPiT3
    /* 9C75C 800ABF5C 1C002726 */   addiu     $a3, $s1, 0x1C
  .L800ABF60:
    /* 9C760 800ABF60 2800228E */  lw         $v0, 0x28($s1)
    /* 9C764 800ABF64 00000000 */  nop
    /* 9C768 800ABF68 04004010 */  beqz       $v0, .L800ABF7C
    /* 9C76C 800ABF6C 00000000 */   nop
  .L800ABF70:
    /* 9C770 800ABF70 2C00228E */  lw         $v0, 0x2C($s1)
    /* 9C774 800ABF74 E2AF0208 */  j          .L800ABF88
    /* 9C778 800ABF78 840442AE */   sw        $v0, 0x484($s2)
  .L800ABF7C:
    /* 9C77C 800ABF7C 2C00228E */  lw         $v0, 0x2C($s1)
    /* 9C780 800ABF80 00000000 */  nop
    /* 9C784 800ABF84 880442AE */  sw         $v0, 0x488($s2)
  .L800ABF88:
    /* 9C788 800ABF88 2800BF8F */  lw         $ra, 0x28($sp)
    /* 9C78C 800ABF8C 2400B38F */  lw         $s3, 0x24($sp)
    /* 9C790 800ABF90 2000B28F */  lw         $s2, 0x20($sp)
    /* 9C794 800ABF94 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 9C798 800ABF98 1800B08F */  lw         $s0, 0x18($sp)
    /* 9C79C 800ABF9C 0800E003 */  jr         $ra
    /* 9C7A0 800ABFA0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct
