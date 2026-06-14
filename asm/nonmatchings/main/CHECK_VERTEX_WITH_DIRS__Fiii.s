.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CHECK_VERTEX_WITH_DIRS__Fiii, 0x3C8

glabel CHECK_VERTEX_WITH_DIRS__Fiii
    /* 7CB7C 8008C37C 1480033C */  lui        $v1, %hi(D_8013E038)
    /* 7CB80 8008C380 38E0628C */  lw         $v0, %lo(D_8013E038)($v1)
    /* 7CB84 8008C384 21688000 */  addu       $t5, $a0, $zero
    /* 7CB88 8008C388 1800A201 */  mult       $t5, $v0
    /* 7CB8C 8008C38C 38E06324 */  addiu      $v1, $v1, %lo(D_8013E038)
    /* 7CB90 8008C390 12200000 */  mflo       $a0
    /* 7CB94 8008C394 0400628C */  lw         $v0, 0x4($v1)
    /* 7CB98 8008C398 00000000 */  nop
    /* 7CB9C 8008C39C 1800A200 */  mult       $a1, $v0
    /* 7CBA0 8008C3A0 12780000 */  mflo       $t7
    /* 7CBA4 8008C3A4 0800628C */  lw         $v0, 0x8($v1)
    /* 7CBA8 8008C3A8 00000000 */  nop
    /* 7CBAC 8008C3AC 1800C200 */  mult       $a2, $v0
    /* 7CBB0 8008C3B0 12400000 */  mflo       $t0
    /* 7CBB4 8008C3B4 0C00628C */  lw         $v0, 0xC($v1)
    /* 7CBB8 8008C3B8 00000000 */  nop
    /* 7CBBC 8008C3BC 1800A201 */  mult       $t5, $v0
    /* 7CBC0 8008C3C0 12600000 */  mflo       $t4
    /* 7CBC4 8008C3C4 1000628C */  lw         $v0, 0x10($v1)
    /* 7CBC8 8008C3C8 00000000 */  nop
    /* 7CBCC 8008C3CC 1800A200 */  mult       $a1, $v0
    /* 7CBD0 8008C3D0 12480000 */  mflo       $t1
    /* 7CBD4 8008C3D4 1400628C */  lw         $v0, 0x14($v1)
    /* 7CBD8 8008C3D8 00000000 */  nop
    /* 7CBDC 8008C3DC 1800C200 */  mult       $a2, $v0
    /* 7CBE0 8008C3E0 12500000 */  mflo       $t2
    /* 7CBE4 8008C3E4 1800628C */  lw         $v0, 0x18($v1)
    /* 7CBE8 8008C3E8 00000000 */  nop
    /* 7CBEC 8008C3EC 1800A201 */  mult       $t5, $v0
    /* 7CBF0 8008C3F0 12580000 */  mflo       $t3
    /* 7CBF4 8008C3F4 1C00628C */  lw         $v0, 0x1C($v1)
    /* 7CBF8 8008C3F8 00000000 */  nop
    /* 7CBFC 8008C3FC 1800A200 */  mult       $a1, $v0
    /* 7CC00 8008C400 2000638C */  lw         $v1, 0x20($v1)
    /* 7CC04 8008C404 21108F00 */  addu       $v0, $a0, $t7
    /* 7CC08 8008C408 12380000 */  mflo       $a3
    /* 7CC0C 8008C40C 1480043C */  lui        $a0, %hi(D_8013E098)
    /* 7CC10 8008C410 21104800 */  addu       $v0, $v0, $t0
    /* 7CC14 8008C414 1800C300 */  mult       $a2, $v1
    /* 7CC18 8008C418 98E0838C */  lw         $v1, %lo(D_8013E098)($a0)
    /* 7CC1C 8008C41C 98E08424 */  addiu      $a0, $a0, %lo(D_8013E098)
    /* 7CC20 8008C420 21404300 */  addu       $t0, $v0, $v1
    /* 7CC24 8008C424 21108901 */  addu       $v0, $t4, $t1
    /* 7CC28 8008C428 0400838C */  lw         $v1, 0x4($a0)
    /* 7CC2C 8008C42C 21104A00 */  addu       $v0, $v0, $t2
    /* 7CC30 8008C430 21484300 */  addu       $t1, $v0, $v1
    /* 7CC34 8008C434 21106701 */  addu       $v0, $t3, $a3
    /* 7CC38 8008C438 F002878F */  lw         $a3, %gp_rel(obj0)($gp)
    /* 7CC3C 8008C43C 0800838C */  lw         $v1, 0x8($a0)
    /* 7CC40 8008C440 4C1888AF */  sw         $t0, %gp_rel(D_8013DD98)($gp)
    /* 7CC44 8008C444 501889AF */  sw         $t1, %gp_rel(D_8013DD9C)($gp)
    /* 7CC48 8008C448 3C01E48C */  lw         $a0, 0x13C($a3)
    /* 7CC4C 8008C44C 12780000 */  mflo       $t7
    /* 7CC50 8008C450 21104F00 */  addu       $v0, $v0, $t7
    /* 7CC54 8008C454 21184300 */  addu       $v1, $v0, $v1
    /* 7CC58 8008C458 2A108300 */  slt        $v0, $a0, $v1
    /* 7CC5C 8008C45C 541883AF */  sw         $v1, %gp_rel(D_8013DDA0)($gp)
    /* 7CC60 8008C460 B6004014 */  bnez       $v0, .L8008C73C
    /* 7CC64 8008C464 23100400 */   negu      $v0, $a0
    /* 7CC68 8008C468 2A106200 */  slt        $v0, $v1, $v0
    /* 7CC6C 8008C46C B3004014 */  bnez       $v0, .L8008C73C
    /* 7CC70 8008C470 00000000 */   nop
    /* 7CC74 8008C474 3401E38C */  lw         $v1, 0x134($a3)
    /* 7CC78 8008C478 00000000 */  nop
    /* 7CC7C 8008C47C 2A106800 */  slt        $v0, $v1, $t0
    /* 7CC80 8008C480 AE004014 */  bnez       $v0, .L8008C73C
    /* 7CC84 8008C484 23100300 */   negu      $v0, $v1
    /* 7CC88 8008C488 2A100201 */  slt        $v0, $t0, $v0
    /* 7CC8C 8008C48C AB004014 */  bnez       $v0, .L8008C73C
    /* 7CC90 8008C490 00000000 */   nop
    /* 7CC94 8008C494 3801E38C */  lw         $v1, 0x138($a3)
    /* 7CC98 8008C498 00000000 */  nop
    /* 7CC9C 8008C49C 2A106900 */  slt        $v0, $v1, $t1
    /* 7CCA0 8008C4A0 A6004014 */  bnez       $v0, .L8008C73C
    /* 7CCA4 8008C4A4 23100300 */   negu      $v0, $v1
    /* 7CCA8 8008C4A8 2A102201 */  slt        $v0, $t1, $v0
    /* 7CCAC 8008C4AC A3004014 */  bnez       $v0, .L8008C73C
    /* 7CCB0 8008C4B0 00000000 */   nop
    /* 7CCB4 8008C4B4 F402848F */  lw         $a0, %gp_rel(obj1)($gp)
    /* 7CCB8 8008C4B8 00000000 */  nop
    /* 7CCBC 8008C4BC F000838C */  lw         $v1, 0xF0($a0)
    /* 7CCC0 8008C4C0 FC02898F */  lw         $t1, %gp_rel(pP)($gp)
    /* 7CCC4 8008C4C4 02006104 */  bgez       $v1, .L8008C4D0
    /* 7CCC8 8008C4C8 00000000 */   nop
    /* 7CCCC 8008C4CC FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C4D0:
    /* 7CCD0 8008C4D0 3401828C */  lw         $v0, 0x134($a0)
    /* 7CCD4 8008C4D4 00000000 */  nop
    /* 7CCD8 8008C4D8 02004104 */  bgez       $v0, .L8008C4E4
    /* 7CCDC 8008C4DC 031A0300 */   sra       $v1, $v1, 8
    /* 7CCE0 8008C4E0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C4E4:
    /* 7CCE4 8008C4E4 03120200 */  sra        $v0, $v0, 8
    /* 7CCE8 8008C4E8 18006200 */  mult       $v1, $v0
    /* 7CCEC 8008C4EC 12700000 */  mflo       $t6
    /* 7CCF0 8008C4F0 00000000 */  nop
    /* 7CCF4 8008C4F4 00000000 */  nop
    /* 7CCF8 8008C4F8 1800AE01 */  mult       $t5, $t6
    /* 7CCFC 8008C4FC A000828C */  lw         $v0, 0xA0($a0)
    /* 7CD00 8008C500 FC00838C */  lw         $v1, 0xFC($a0)
    /* 7CD04 8008C504 12700000 */  mflo       $t6
    /* 7CD08 8008C508 02006104 */  bgez       $v1, .L8008C514
    /* 7CD0C 8008C50C 21384E00 */   addu      $a3, $v0, $t6
    /* 7CD10 8008C510 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C514:
    /* 7CD14 8008C514 3801828C */  lw         $v0, 0x138($a0)
    /* 7CD18 8008C518 00000000 */  nop
    /* 7CD1C 8008C51C 02004104 */  bgez       $v0, .L8008C528
    /* 7CD20 8008C520 031A0300 */   sra       $v1, $v1, 8
    /* 7CD24 8008C524 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C528:
    /* 7CD28 8008C528 03120200 */  sra        $v0, $v0, 8
    /* 7CD2C 8008C52C 18006200 */  mult       $v1, $v0
    /* 7CD30 8008C530 12700000 */  mflo       $t6
    /* 7CD34 8008C534 00000000 */  nop
    /* 7CD38 8008C538 00000000 */  nop
    /* 7CD3C 8008C53C 1800AE00 */  mult       $a1, $t6
    /* 7CD40 8008C540 0801838C */  lw         $v1, 0x108($a0)
    /* 7CD44 8008C544 12700000 */  mflo       $t6
    /* 7CD48 8008C548 02006104 */  bgez       $v1, .L8008C554
    /* 7CD4C 8008C54C 2138EE00 */   addu      $a3, $a3, $t6
    /* 7CD50 8008C550 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C554:
    /* 7CD54 8008C554 3C01828C */  lw         $v0, 0x13C($a0)
    /* 7CD58 8008C558 00000000 */  nop
    /* 7CD5C 8008C55C 02004104 */  bgez       $v0, .L8008C568
    /* 7CD60 8008C560 031A0300 */   sra       $v1, $v1, 8
    /* 7CD64 8008C564 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C568:
    /* 7CD68 8008C568 03120200 */  sra        $v0, $v0, 8
    /* 7CD6C 8008C56C 18006200 */  mult       $v1, $v0
    /* 7CD70 8008C570 12700000 */  mflo       $t6
    /* 7CD74 8008C574 00000000 */  nop
    /* 7CD78 8008C578 00000000 */  nop
    /* 7CD7C 8008C57C 1800CE00 */  mult       $a2, $t6
    /* 7CD80 8008C580 12700000 */  mflo       $t6
    /* 7CD84 8008C584 2110EE00 */  addu       $v0, $a3, $t6
    /* 7CD88 8008C588 000022AD */  sw         $v0, 0x0($t1)
    /* 7CD8C 8008C58C F400838C */  lw         $v1, 0xF4($a0)
    /* 7CD90 8008C590 00000000 */  nop
    /* 7CD94 8008C594 02006104 */  bgez       $v1, .L8008C5A0
    /* 7CD98 8008C598 00000000 */   nop
    /* 7CD9C 8008C59C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C5A0:
    /* 7CDA0 8008C5A0 3401828C */  lw         $v0, 0x134($a0)
    /* 7CDA4 8008C5A4 00000000 */  nop
    /* 7CDA8 8008C5A8 02004104 */  bgez       $v0, .L8008C5B4
    /* 7CDAC 8008C5AC 031A0300 */   sra       $v1, $v1, 8
    /* 7CDB0 8008C5B0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C5B4:
    /* 7CDB4 8008C5B4 03120200 */  sra        $v0, $v0, 8
    /* 7CDB8 8008C5B8 18006200 */  mult       $v1, $v0
    /* 7CDBC 8008C5BC 12700000 */  mflo       $t6
    /* 7CDC0 8008C5C0 00000000 */  nop
    /* 7CDC4 8008C5C4 00000000 */  nop
    /* 7CDC8 8008C5C8 1800AE01 */  mult       $t5, $t6
    /* 7CDCC 8008C5CC A400828C */  lw         $v0, 0xA4($a0)
    /* 7CDD0 8008C5D0 0001838C */  lw         $v1, 0x100($a0)
    /* 7CDD4 8008C5D4 12700000 */  mflo       $t6
    /* 7CDD8 8008C5D8 02006104 */  bgez       $v1, .L8008C5E4
    /* 7CDDC 8008C5DC 21384E00 */   addu      $a3, $v0, $t6
    /* 7CDE0 8008C5E0 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C5E4:
    /* 7CDE4 8008C5E4 3801828C */  lw         $v0, 0x138($a0)
    /* 7CDE8 8008C5E8 00000000 */  nop
    /* 7CDEC 8008C5EC 02004104 */  bgez       $v0, .L8008C5F8
    /* 7CDF0 8008C5F0 031A0300 */   sra       $v1, $v1, 8
    /* 7CDF4 8008C5F4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C5F8:
    /* 7CDF8 8008C5F8 03120200 */  sra        $v0, $v0, 8
    /* 7CDFC 8008C5FC 18006200 */  mult       $v1, $v0
    /* 7CE00 8008C600 12700000 */  mflo       $t6
    /* 7CE04 8008C604 00000000 */  nop
    /* 7CE08 8008C608 00000000 */  nop
    /* 7CE0C 8008C60C 1800AE00 */  mult       $a1, $t6
    /* 7CE10 8008C610 F402888F */  lw         $t0, %gp_rel(obj1)($gp)
    /* 7CE14 8008C614 00000000 */  nop
    /* 7CE18 8008C618 0C01038D */  lw         $v1, 0x10C($t0)
    /* 7CE1C 8008C61C 12700000 */  mflo       $t6
    /* 7CE20 8008C620 02006104 */  bgez       $v1, .L8008C62C
    /* 7CE24 8008C624 2120EE00 */   addu      $a0, $a3, $t6
    /* 7CE28 8008C628 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C62C:
    /* 7CE2C 8008C62C 3C01028D */  lw         $v0, 0x13C($t0)
    /* 7CE30 8008C630 00000000 */  nop
    /* 7CE34 8008C634 02004104 */  bgez       $v0, .L8008C640
    /* 7CE38 8008C638 031A0300 */   sra       $v1, $v1, 8
    /* 7CE3C 8008C63C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C640:
    /* 7CE40 8008C640 03120200 */  sra        $v0, $v0, 8
    /* 7CE44 8008C644 18006200 */  mult       $v1, $v0
    /* 7CE48 8008C648 12700000 */  mflo       $t6
    /* 7CE4C 8008C64C 00000000 */  nop
    /* 7CE50 8008C650 00000000 */  nop
    /* 7CE54 8008C654 1800CE00 */  mult       $a2, $t6
    /* 7CE58 8008C658 12700000 */  mflo       $t6
    /* 7CE5C 8008C65C 21108E00 */  addu       $v0, $a0, $t6
    /* 7CE60 8008C660 040022AD */  sw         $v0, 0x4($t1)
    /* 7CE64 8008C664 F800038D */  lw         $v1, 0xF8($t0)
    /* 7CE68 8008C668 FC02848F */  lw         $a0, %gp_rel(pP)($gp)
    /* 7CE6C 8008C66C 02006104 */  bgez       $v1, .L8008C678
    /* 7CE70 8008C670 00000000 */   nop
    /* 7CE74 8008C674 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8008C678:
    /* 7CE78 8008C678 3401028D */  lw         $v0, 0x134($t0)
    /* 7CE7C 8008C67C 00000000 */  nop
    /* 7CE80 8008C680 02004104 */  bgez       $v0, .L8008C68C
    /* 7CE84 8008C684 031A0300 */   sra       $v1, $v1, 8
    /* 7CE88 8008C688 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C68C:
    /* 7CE8C 8008C68C 03120200 */  sra        $v0, $v0, 8
    /* 7CE90 8008C690 18006200 */  mult       $v1, $v0
    /* 7CE94 8008C694 12700000 */  mflo       $t6
    /* 7CE98 8008C698 00000000 */  nop
    /* 7CE9C 8008C69C 00000000 */  nop
    /* 7CEA0 8008C6A0 1800AE01 */  mult       $t5, $t6
    /* 7CEA4 8008C6A4 A800028D */  lw         $v0, 0xA8($t0)
    /* 7CEA8 8008C6A8 0401078D */  lw         $a3, 0x104($t0)
    /* 7CEAC 8008C6AC 12700000 */  mflo       $t6
    /* 7CEB0 8008C6B0 0200E104 */  bgez       $a3, .L8008C6BC
    /* 7CEB4 8008C6B4 21184E00 */   addu      $v1, $v0, $t6
    /* 7CEB8 8008C6B8 FF00E724 */  addiu      $a3, $a3, 0xFF
  .L8008C6BC:
    /* 7CEBC 8008C6BC 3801028D */  lw         $v0, 0x138($t0)
    /* 7CEC0 8008C6C0 00000000 */  nop
    /* 7CEC4 8008C6C4 02004104 */  bgez       $v0, .L8008C6D0
    /* 7CEC8 8008C6C8 033A0700 */   sra       $a3, $a3, 8
    /* 7CECC 8008C6CC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C6D0:
    /* 7CED0 8008C6D0 03120200 */  sra        $v0, $v0, 8
    /* 7CED4 8008C6D4 1800E200 */  mult       $a3, $v0
    /* 7CED8 8008C6D8 12700000 */  mflo       $t6
    /* 7CEDC 8008C6DC 00000000 */  nop
    /* 7CEE0 8008C6E0 00000000 */  nop
    /* 7CEE4 8008C6E4 1800AE00 */  mult       $a1, $t6
    /* 7CEE8 8008C6E8 1001078D */  lw         $a3, 0x110($t0)
    /* 7CEEC 8008C6EC 12700000 */  mflo       $t6
    /* 7CEF0 8008C6F0 0200E104 */  bgez       $a3, .L8008C6FC
    /* 7CEF4 8008C6F4 21186E00 */   addu      $v1, $v1, $t6
    /* 7CEF8 8008C6F8 FF00E724 */  addiu      $a3, $a3, 0xFF
  .L8008C6FC:
    /* 7CEFC 8008C6FC 3C01028D */  lw         $v0, 0x13C($t0)
    /* 7CF00 8008C700 00000000 */  nop
    /* 7CF04 8008C704 02004104 */  bgez       $v0, .L8008C710
    /* 7CF08 8008C708 033A0700 */   sra       $a3, $a3, 8
    /* 7CF0C 8008C70C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8008C710:
    /* 7CF10 8008C710 03120200 */  sra        $v0, $v0, 8
    /* 7CF14 8008C714 1800E200 */  mult       $a3, $v0
    /* 7CF18 8008C718 12700000 */  mflo       $t6
    /* 7CF1C 8008C71C 00000000 */  nop
    /* 7CF20 8008C720 00000000 */  nop
    /* 7CF24 8008C724 1800CE00 */  mult       $a2, $t6
    /* 7CF28 8008C728 01000224 */  addiu      $v0, $zero, 0x1
    /* 7CF2C 8008C72C 12700000 */  mflo       $t6
    /* 7CF30 8008C730 21186E00 */  addu       $v1, $v1, $t6
    /* 7CF34 8008C734 0800E003 */  jr         $ra
    /* 7CF38 8008C738 080083AC */   sw        $v1, 0x8($a0)
  .L8008C73C:
    /* 7CF3C 8008C73C 0800E003 */  jr         $ra
    /* 7CF40 8008C740 21100000 */   addu      $v0, $zero, $zero
endlabel CHECK_VERTEX_WITH_DIRS__Fiii
