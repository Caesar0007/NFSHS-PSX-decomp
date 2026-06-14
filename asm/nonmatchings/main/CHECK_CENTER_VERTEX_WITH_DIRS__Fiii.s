.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CHECK_CENTER_VERTEX_WITH_DIRS__Fiii, 0x480

glabel CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
    /* 7C270 8008BA70 1480033C */  lui        $v1, %hi(D_8013E038)
    /* 7C274 8008BA74 38E0628C */  lw         $v0, %lo(D_8013E038)($v1)
    /* 7C278 8008BA78 21688000 */  addu       $t5, $a0, $zero
    /* 7C27C 8008BA7C 1800A201 */  mult       $t5, $v0
    /* 7C280 8008BA80 38E06324 */  addiu      $v1, $v1, %lo(D_8013E038)
    /* 7C284 8008BA84 12200000 */  mflo       $a0
    /* 7C288 8008BA88 0400628C */  lw         $v0, 0x4($v1)
    /* 7C28C 8008BA8C 00000000 */  nop
    /* 7C290 8008BA90 1800A200 */  mult       $a1, $v0
    /* 7C294 8008BA94 12780000 */  mflo       $t7
    /* 7C298 8008BA98 0800628C */  lw         $v0, 0x8($v1)
    /* 7C29C 8008BA9C 00000000 */  nop
    /* 7C2A0 8008BAA0 1800C200 */  mult       $a2, $v0
    /* 7C2A4 8008BAA4 12400000 */  mflo       $t0
    /* 7C2A8 8008BAA8 0C00628C */  lw         $v0, 0xC($v1)
    /* 7C2AC 8008BAAC 00000000 */  nop
    /* 7C2B0 8008BAB0 1800A201 */  mult       $t5, $v0
    /* 7C2B4 8008BAB4 12600000 */  mflo       $t4
    /* 7C2B8 8008BAB8 1000628C */  lw         $v0, 0x10($v1)
    /* 7C2BC 8008BABC 00000000 */  nop
    /* 7C2C0 8008BAC0 1800A200 */  mult       $a1, $v0
    /* 7C2C4 8008BAC4 12480000 */  mflo       $t1
    /* 7C2C8 8008BAC8 1400628C */  lw         $v0, 0x14($v1)
    /* 7C2CC 8008BACC 00000000 */  nop
    /* 7C2D0 8008BAD0 1800C200 */  mult       $a2, $v0
    /* 7C2D4 8008BAD4 12500000 */  mflo       $t2
    /* 7C2D8 8008BAD8 1800628C */  lw         $v0, 0x18($v1)
    /* 7C2DC 8008BADC 00000000 */  nop
    /* 7C2E0 8008BAE0 1800A201 */  mult       $t5, $v0
    /* 7C2E4 8008BAE4 12580000 */  mflo       $t3
    /* 7C2E8 8008BAE8 1C00628C */  lw         $v0, 0x1C($v1)
    /* 7C2EC 8008BAEC 00000000 */  nop
    /* 7C2F0 8008BAF0 1800A200 */  mult       $a1, $v0
    /* 7C2F4 8008BAF4 2000638C */  lw         $v1, 0x20($v1)
    /* 7C2F8 8008BAF8 21108F00 */  addu       $v0, $a0, $t7
    /* 7C2FC 8008BAFC 12380000 */  mflo       $a3
    /* 7C300 8008BB00 1480043C */  lui        $a0, %hi(D_8013E098)
    /* 7C304 8008BB04 21104800 */  addu       $v0, $v0, $t0
    /* 7C308 8008BB08 1800C300 */  mult       $a2, $v1
    /* 7C30C 8008BB0C 98E0838C */  lw         $v1, %lo(D_8013E098)($a0)
    /* 7C310 8008BB10 98E08424 */  addiu      $a0, $a0, %lo(D_8013E098)
    /* 7C314 8008BB14 21404300 */  addu       $t0, $v0, $v1
    /* 7C318 8008BB18 21108901 */  addu       $v0, $t4, $t1
    /* 7C31C 8008BB1C 0400838C */  lw         $v1, 0x4($a0)
    /* 7C320 8008BB20 21104A00 */  addu       $v0, $v0, $t2
    /* 7C324 8008BB24 21484300 */  addu       $t1, $v0, $v1
    /* 7C328 8008BB28 21106701 */  addu       $v0, $t3, $a3
    /* 7C32C 8008BB2C F002878F */  lw         $a3, %gp_rel(obj0)($gp)
    /* 7C330 8008BB30 0800838C */  lw         $v1, 0x8($a0)
    /* 7C334 8008BB34 4C1888AF */  sw         $t0, %gp_rel(D_8013DD98)($gp)
    /* 7C338 8008BB38 501889AF */  sw         $t1, %gp_rel(D_8013DD9C)($gp)
    /* 7C33C 8008BB3C 3C01E48C */  lw         $a0, 0x13C($a3)
    /* 7C340 8008BB40 12780000 */  mflo       $t7
    /* 7C344 8008BB44 21104F00 */  addu       $v0, $v0, $t7
    /* 7C348 8008BB48 21184300 */  addu       $v1, $v0, $v1
    /* 7C34C 8008BB4C 2A108300 */  slt        $v0, $a0, $v1
    /* 7C350 8008BB50 541883AF */  sw         $v1, %gp_rel(D_8013DDA0)($gp)
    /* 7C354 8008BB54 E4004014 */  bnez       $v0, .L8008BEE8
    /* 7C358 8008BB58 23100400 */   negu      $v0, $a0
    /* 7C35C 8008BB5C 2A106200 */  slt        $v0, $v1, $v0
    /* 7C360 8008BB60 E1004014 */  bnez       $v0, .L8008BEE8
    /* 7C364 8008BB64 00000000 */   nop
    /* 7C368 8008BB68 3401E38C */  lw         $v1, 0x134($a3)
    /* 7C36C 8008BB6C 00000000 */  nop
    /* 7C370 8008BB70 2A106800 */  slt        $v0, $v1, $t0
    /* 7C374 8008BB74 DC004014 */  bnez       $v0, .L8008BEE8
    /* 7C378 8008BB78 23100300 */   negu      $v0, $v1
    /* 7C37C 8008BB7C 2A100201 */  slt        $v0, $t0, $v0
    /* 7C380 8008BB80 D9004014 */  bnez       $v0, .L8008BEE8
    /* 7C384 8008BB84 00000000 */   nop
    /* 7C388 8008BB88 3801E38C */  lw         $v1, 0x138($a3)
    /* 7C38C 8008BB8C 00000000 */  nop
    /* 7C390 8008BB90 2A106900 */  slt        $v0, $v1, $t1
    /* 7C394 8008BB94 D4004014 */  bnez       $v0, .L8008BEE8
    /* 7C398 8008BB98 23100300 */   negu      $v0, $v1
    /* 7C39C 8008BB9C 2A102201 */  slt        $v0, $t1, $v0
    /* 7C3A0 8008BBA0 D1004014 */  bnez       $v0, .L8008BEE8
    /* 7C3A4 8008BBA4 00000000 */   nop
    /* 7C3A8 8008BBA8 F402848F */  lw         $a0, %gp_rel(obj1)($gp)
    /* 7C3AC 8008BBAC 00000000 */  nop
    /* 7C3B0 8008BBB0 F000828C */  lw         $v0, 0xF0($a0)
    /* 7C3B4 8008BBB4 00000000 */  nop
    /* 7C3B8 8008BBB8 1800A201 */  mult       $t5, $v0
    /* 7C3BC 8008BBBC 12180000 */  mflo       $v1
    /* 7C3C0 8008BBC0 FC00828C */  lw         $v0, 0xFC($a0)
    /* 7C3C4 8008BBC4 00000000 */  nop
    /* 7C3C8 8008BBC8 1800A200 */  mult       $a1, $v0
    /* 7C3CC 8008BBCC 12400000 */  mflo       $t0
    /* 7C3D0 8008BBD0 0801828C */  lw         $v0, 0x108($a0)
    /* 7C3D4 8008BBD4 00000000 */  nop
    /* 7C3D8 8008BBD8 1800C200 */  mult       $a2, $v0
    /* 7C3DC 8008BBDC 21106800 */  addu       $v0, $v1, $t0
    /* 7C3E0 8008BBE0 F802838F */  lw         $v1, %gp_rel(pNormal)($gp)
    /* 7C3E4 8008BBE4 12380000 */  mflo       $a3
    /* 7C3E8 8008BBE8 21104700 */  addu       $v0, $v0, $a3
    /* 7C3EC 8008BBEC 000062AC */  sw         $v0, 0x0($v1)
    /* 7C3F0 8008BBF0 F400828C */  lw         $v0, 0xF4($a0)
    /* 7C3F4 8008BBF4 00000000 */  nop
    /* 7C3F8 8008BBF8 1800A201 */  mult       $t5, $v0
    /* 7C3FC 8008BBFC 12400000 */  mflo       $t0
    /* 7C400 8008BC00 0001828C */  lw         $v0, 0x100($a0)
    /* 7C404 8008BC04 00000000 */  nop
    /* 7C408 8008BC08 1800A200 */  mult       $a1, $v0
    /* 7C40C 8008BC0C 12380000 */  mflo       $a3
    /* 7C410 8008BC10 0C01828C */  lw         $v0, 0x10C($a0)
    /* 7C414 8008BC14 00000000 */  nop
    /* 7C418 8008BC18 1800C200 */  mult       $a2, $v0
    /* 7C41C 8008BC1C 21100701 */  addu       $v0, $t0, $a3
    /* 7C420 8008BC20 12480000 */  mflo       $t1
    /* 7C424 8008BC24 21104900 */  addu       $v0, $v0, $t1
    /* 7C428 8008BC28 040062AC */  sw         $v0, 0x4($v1)
    /* 7C42C 8008BC2C F800828C */  lw         $v0, 0xF8($a0)
    /* 7C430 8008BC30 00000000 */  nop
    /* 7C434 8008BC34 1800A201 */  mult       $t5, $v0
    /* 7C438 8008BC38 12400000 */  mflo       $t0
    /* 7C43C 8008BC3C 0401828C */  lw         $v0, 0x104($a0)
    /* 7C440 8008BC40 00000000 */  nop
    /* 7C444 8008BC44 1800A200 */  mult       $a1, $v0
    /* 7C448 8008BC48 12380000 */  mflo       $a3
    /* 7C44C 8008BC4C 1001828C */  lw         $v0, 0x110($a0)
    /* 7C450 8008BC50 00000000 */  nop
    /* 7C454 8008BC54 1800C200 */  mult       $a2, $v0
    /* 7C458 8008BC58 21100701 */  addu       $v0, $t0, $a3
    /* 7C45C 8008BC5C 12480000 */  mflo       $t1
    /* 7C460 8008BC60 21104900 */  addu       $v0, $v0, $t1
    /* 7C464 8008BC64 080062AC */  sw         $v0, 0x8($v1)
    /* 7C468 8008BC68 F000838C */  lw         $v1, 0xF0($a0)
    /* 7C46C 8008BC6C FC02898F */  lw         $t1, %gp_rel(pP)($gp)
    /* 7C470 8008BC70 02006104 */  bgez       $v1, .L8008BC7C
    /* 7C474 8008BC74 00000000 */   nop
    /* 7C478 8008BC78 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BC7C:
    /* 7C47C 8008BC7C 3401828C */  lw         $v0, 0x134($a0)
    /* 7C480 8008BC80 00000000 */  nop
    /* 7C484 8008BC84 02004104 */  bgez       $v0, .L8008BC90
    /* 7C488 8008BC88 031A0300 */   sra       $v1, $v1, 8
    /* 7C48C 8008BC8C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BC90:
    /* 7C490 8008BC90 03120200 */  sra        $v0, $v0, 8
    /* 7C494 8008BC94 18006200 */  mult       $v1, $v0
    /* 7C498 8008BC98 12700000 */  mflo       $t6
    /* 7C49C 8008BC9C 00000000 */  nop
    /* 7C4A0 8008BCA0 00000000 */  nop
    /* 7C4A4 8008BCA4 1800AE01 */  mult       $t5, $t6
    /* 7C4A8 8008BCA8 A000828C */  lw         $v0, 0xA0($a0)
    /* 7C4AC 8008BCAC FC00838C */  lw         $v1, 0xFC($a0)
    /* 7C4B0 8008BCB0 12700000 */  mflo       $t6
    /* 7C4B4 8008BCB4 02006104 */  bgez       $v1, .L8008BCC0
    /* 7C4B8 8008BCB8 21384E00 */   addu      $a3, $v0, $t6
    /* 7C4BC 8008BCBC FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BCC0:
    /* 7C4C0 8008BCC0 3801828C */  lw         $v0, 0x138($a0)
    /* 7C4C4 8008BCC4 00000000 */  nop
    /* 7C4C8 8008BCC8 02004104 */  bgez       $v0, .L8008BCD4
    /* 7C4CC 8008BCCC 031A0300 */   sra       $v1, $v1, 8
    /* 7C4D0 8008BCD0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BCD4:
    /* 7C4D4 8008BCD4 03120200 */  sra        $v0, $v0, 8
    /* 7C4D8 8008BCD8 18006200 */  mult       $v1, $v0
    /* 7C4DC 8008BCDC 12700000 */  mflo       $t6
    /* 7C4E0 8008BCE0 00000000 */  nop
    /* 7C4E4 8008BCE4 00000000 */  nop
    /* 7C4E8 8008BCE8 1800AE00 */  mult       $a1, $t6
    /* 7C4EC 8008BCEC 0801838C */  lw         $v1, 0x108($a0)
    /* 7C4F0 8008BCF0 12700000 */  mflo       $t6
    /* 7C4F4 8008BCF4 02006104 */  bgez       $v1, .L8008BD00
    /* 7C4F8 8008BCF8 2138EE00 */   addu      $a3, $a3, $t6
    /* 7C4FC 8008BCFC FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BD00:
    /* 7C500 8008BD00 3C01828C */  lw         $v0, 0x13C($a0)
    /* 7C504 8008BD04 00000000 */  nop
    /* 7C508 8008BD08 02004104 */  bgez       $v0, .L8008BD14
    /* 7C50C 8008BD0C 031A0300 */   sra       $v1, $v1, 8
    /* 7C510 8008BD10 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BD14:
    /* 7C514 8008BD14 03120200 */  sra        $v0, $v0, 8
    /* 7C518 8008BD18 18006200 */  mult       $v1, $v0
    /* 7C51C 8008BD1C 12700000 */  mflo       $t6
    /* 7C520 8008BD20 00000000 */  nop
    /* 7C524 8008BD24 00000000 */  nop
    /* 7C528 8008BD28 1800CE00 */  mult       $a2, $t6
    /* 7C52C 8008BD2C 12700000 */  mflo       $t6
    /* 7C530 8008BD30 2110EE00 */  addu       $v0, $a3, $t6
    /* 7C534 8008BD34 000022AD */  sw         $v0, 0x0($t1)
    /* 7C538 8008BD38 F400838C */  lw         $v1, 0xF4($a0)
    /* 7C53C 8008BD3C 00000000 */  nop
    /* 7C540 8008BD40 02006104 */  bgez       $v1, .L8008BD4C
    /* 7C544 8008BD44 00000000 */   nop
    /* 7C548 8008BD48 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BD4C:
    /* 7C54C 8008BD4C 3401828C */  lw         $v0, 0x134($a0)
    /* 7C550 8008BD50 00000000 */  nop
    /* 7C554 8008BD54 02004104 */  bgez       $v0, .L8008BD60
    /* 7C558 8008BD58 031A0300 */   sra       $v1, $v1, 8
    /* 7C55C 8008BD5C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BD60:
    /* 7C560 8008BD60 03120200 */  sra        $v0, $v0, 8
    /* 7C564 8008BD64 18006200 */  mult       $v1, $v0
    /* 7C568 8008BD68 12700000 */  mflo       $t6
    /* 7C56C 8008BD6C 00000000 */  nop
    /* 7C570 8008BD70 00000000 */  nop
    /* 7C574 8008BD74 1800AE01 */  mult       $t5, $t6
    /* 7C578 8008BD78 A400828C */  lw         $v0, 0xA4($a0)
    /* 7C57C 8008BD7C 0001838C */  lw         $v1, 0x100($a0)
    /* 7C580 8008BD80 12700000 */  mflo       $t6
    /* 7C584 8008BD84 02006104 */  bgez       $v1, .L8008BD90
    /* 7C588 8008BD88 21384E00 */   addu      $a3, $v0, $t6
    /* 7C58C 8008BD8C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BD90:
    /* 7C590 8008BD90 3801828C */  lw         $v0, 0x138($a0)
    /* 7C594 8008BD94 00000000 */  nop
    /* 7C598 8008BD98 02004104 */  bgez       $v0, .L8008BDA4
    /* 7C59C 8008BD9C 031A0300 */   sra       $v1, $v1, 8
    /* 7C5A0 8008BDA0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BDA4:
    /* 7C5A4 8008BDA4 03120200 */  sra        $v0, $v0, 8
    /* 7C5A8 8008BDA8 18006200 */  mult       $v1, $v0
    /* 7C5AC 8008BDAC 12700000 */  mflo       $t6
    /* 7C5B0 8008BDB0 00000000 */  nop
    /* 7C5B4 8008BDB4 00000000 */  nop
    /* 7C5B8 8008BDB8 1800AE00 */  mult       $a1, $t6
    /* 7C5BC 8008BDBC F402888F */  lw         $t0, %gp_rel(obj1)($gp)
    /* 7C5C0 8008BDC0 00000000 */  nop
    /* 7C5C4 8008BDC4 0C01038D */  lw         $v1, 0x10C($t0)
    /* 7C5C8 8008BDC8 12700000 */  mflo       $t6
    /* 7C5CC 8008BDCC 02006104 */  bgez       $v1, .L8008BDD8
    /* 7C5D0 8008BDD0 2120EE00 */   addu      $a0, $a3, $t6
    /* 7C5D4 8008BDD4 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BDD8:
    /* 7C5D8 8008BDD8 3C01028D */  lw         $v0, 0x13C($t0)
    /* 7C5DC 8008BDDC 00000000 */  nop
    /* 7C5E0 8008BDE0 02004104 */  bgez       $v0, .L8008BDEC
    /* 7C5E4 8008BDE4 031A0300 */   sra       $v1, $v1, 8
    /* 7C5E8 8008BDE8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BDEC:
    /* 7C5EC 8008BDEC 03120200 */  sra        $v0, $v0, 8
    /* 7C5F0 8008BDF0 18006200 */  mult       $v1, $v0
    /* 7C5F4 8008BDF4 12700000 */  mflo       $t6
    /* 7C5F8 8008BDF8 00000000 */  nop
    /* 7C5FC 8008BDFC 00000000 */  nop
    /* 7C600 8008BE00 1800CE00 */  mult       $a2, $t6
    /* 7C604 8008BE04 12700000 */  mflo       $t6
    /* 7C608 8008BE08 21108E00 */  addu       $v0, $a0, $t6
    /* 7C60C 8008BE0C 040022AD */  sw         $v0, 0x4($t1)
    /* 7C610 8008BE10 F800038D */  lw         $v1, 0xF8($t0)
    /* 7C614 8008BE14 FC02848F */  lw         $a0, %gp_rel(pP)($gp)
    /* 7C618 8008BE18 02006104 */  bgez       $v1, .L8008BE24
    /* 7C61C 8008BE1C 00000000 */   nop
    /* 7C620 8008BE20 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008BE24:
    /* 7C624 8008BE24 3401028D */  lw         $v0, 0x134($t0)
    /* 7C628 8008BE28 00000000 */  nop
    /* 7C62C 8008BE2C 02004104 */  bgez       $v0, .L8008BE38
    /* 7C630 8008BE30 031A0300 */   sra       $v1, $v1, 8
    /* 7C634 8008BE34 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BE38:
    /* 7C638 8008BE38 03120200 */  sra        $v0, $v0, 8
    /* 7C63C 8008BE3C 18006200 */  mult       $v1, $v0
    /* 7C640 8008BE40 12700000 */  mflo       $t6
    /* 7C644 8008BE44 00000000 */  nop
    /* 7C648 8008BE48 00000000 */  nop
    /* 7C64C 8008BE4C 1800AE01 */  mult       $t5, $t6
    /* 7C650 8008BE50 A800028D */  lw         $v0, 0xA8($t0)
    /* 7C654 8008BE54 0401078D */  lw         $a3, 0x104($t0)
    /* 7C658 8008BE58 12700000 */  mflo       $t6
    /* 7C65C 8008BE5C 0200E104 */  bgez       $a3, .L8008BE68
    /* 7C660 8008BE60 21184E00 */   addu      $v1, $v0, $t6
    /* 7C664 8008BE64 FF00E724 */  addiu      $a3, $a3, 0xFF
  .L8008BE68:
    /* 7C668 8008BE68 3801028D */  lw         $v0, 0x138($t0)
    /* 7C66C 8008BE6C 00000000 */  nop
    /* 7C670 8008BE70 02004104 */  bgez       $v0, .L8008BE7C
    /* 7C674 8008BE74 033A0700 */   sra       $a3, $a3, 8
    /* 7C678 8008BE78 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BE7C:
    /* 7C67C 8008BE7C 03120200 */  sra        $v0, $v0, 8
    /* 7C680 8008BE80 1800E200 */  mult       $a3, $v0
    /* 7C684 8008BE84 12700000 */  mflo       $t6
    /* 7C688 8008BE88 00000000 */  nop
    /* 7C68C 8008BE8C 00000000 */  nop
    /* 7C690 8008BE90 1800AE00 */  mult       $a1, $t6
    /* 7C694 8008BE94 1001078D */  lw         $a3, 0x110($t0)
    /* 7C698 8008BE98 12700000 */  mflo       $t6
    /* 7C69C 8008BE9C 0200E104 */  bgez       $a3, .L8008BEA8
    /* 7C6A0 8008BEA0 21186E00 */   addu      $v1, $v1, $t6
    /* 7C6A4 8008BEA4 FF00E724 */  addiu      $a3, $a3, 0xFF
  .L8008BEA8:
    /* 7C6A8 8008BEA8 3C01028D */  lw         $v0, 0x13C($t0)
    /* 7C6AC 8008BEAC 00000000 */  nop
    /* 7C6B0 8008BEB0 02004104 */  bgez       $v0, .L8008BEBC
    /* 7C6B4 8008BEB4 033A0700 */   sra       $a3, $a3, 8
    /* 7C6B8 8008BEB8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008BEBC:
    /* 7C6BC 8008BEBC 03120200 */  sra        $v0, $v0, 8
    /* 7C6C0 8008BEC0 1800E200 */  mult       $a3, $v0
    /* 7C6C4 8008BEC4 12700000 */  mflo       $t6
    /* 7C6C8 8008BEC8 00000000 */  nop
    /* 7C6CC 8008BECC 00000000 */  nop
    /* 7C6D0 8008BED0 1800CE00 */  mult       $a2, $t6
    /* 7C6D4 8008BED4 01000224 */  addiu      $v0, $zero, 0x1
    /* 7C6D8 8008BED8 12700000 */  mflo       $t6
    /* 7C6DC 8008BEDC 21186E00 */  addu       $v1, $v1, $t6
    /* 7C6E0 8008BEE0 0800E003 */  jr         $ra
    /* 7C6E4 8008BEE4 080083AC */   sw        $v1, 0x8($a0)
  .L8008BEE8:
    /* 7C6E8 8008BEE8 0800E003 */  jr         $ra
    /* 7C6EC 8008BEEC 21100000 */   addu      $v0, $zero, $zero
endlabel CHECK_CENTER_VERTEX_WITH_DIRS__Fiii
