.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView, 0x11E0

glabel R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView
    /* A03D0 800AFBD0 18FEBD27 */  addiu      $sp, $sp, -0x1E8
    /* A03D4 800AFBD4 D401B5AF */  sw         $s5, 0x1D4($sp)
    /* A03D8 800AFBD8 21A88000 */  addu       $s5, $a0, $zero
    /* A03DC 800AFBDC E401BFAF */  sw         $ra, 0x1E4($sp)
    /* A03E0 800AFBE0 E001BEAF */  sw         $fp, 0x1E0($sp)
    /* A03E4 800AFBE4 DC01B7AF */  sw         $s7, 0x1DC($sp)
    /* A03E8 800AFBE8 D801B6AF */  sw         $s6, 0x1D8($sp)
    /* A03EC 800AFBEC D001B4AF */  sw         $s4, 0x1D0($sp)
    /* A03F0 800AFBF0 CC01B3AF */  sw         $s3, 0x1CC($sp)
    /* A03F4 800AFBF4 C801B2AF */  sw         $s2, 0x1C8($sp)
    /* A03F8 800AFBF8 C401B1AF */  sw         $s1, 0x1C4($sp)
    /* A03FC 800AFBFC C001B0AF */  sw         $s0, 0x1C0($sp)
    /* A0400 800AFC00 EC01A5AF */  sw         $a1, 0x1EC($sp)
    /* A0404 800AFC04 B801A0AF */  sw         $zero, 0x1B8($sp)
    /* A0408 800AFC08 D008AB8E */  lw         $t3, 0x8D0($s5)
    /* A040C 800AFC0C 00000000 */  nop
    /* A0410 800AFC10 B001ABAF */  sw         $t3, 0x1B0($sp)
    /* A0414 800AFC14 4208A292 */  lbu        $v0, 0x842($s5)
    /* A0418 800AFC18 BC08B786 */  lh         $s7, 0x8BC($s5)
    /* A041C 800AFC1C C2110200 */  srl        $v0, $v0, 7
    /* A0420 800AFC20 B401A2AF */  sw         $v0, 0x1B4($sp)
    /* A0424 800AFC24 1C00E22A */  slti       $v0, $s7, 0x1C
    /* A0428 800AFC28 15004010 */  beqz       $v0, .L800AFC80
    /* A042C 800AFC2C 1180023C */   lui       $v0, %hi(R3DCar_ForceDriveSide)
    /* A0430 800AFC30 44684224 */  addiu      $v0, $v0, %lo(R3DCar_ForceDriveSide)
    /* A0434 800AFC34 2110E202 */  addu       $v0, $s7, $v0
    /* A0438 800AFC38 00004280 */  lb         $v0, 0x0($v0)
    /* A043C 800AFC3C 00000000 */  nop
    /* A0440 800AFC40 0F004104 */  bgez       $v0, .L800AFC80
    /* A0444 800AFC44 B801A2AF */   sw        $v0, 0x1B8($sp)
    /* A0448 800AFC48 1180033C */  lui        $v1, %hi(AITune_trackInfo)
    /* A044C 800AFC4C 1180023C */  lui        $v0, %hi(D_80113228)
    /* A0450 800AFC50 2832448C */  lw         $a0, %lo(D_80113228)($v0)
    /* A0454 800AFC54 74DE6324 */  addiu      $v1, $v1, %lo(AITune_trackInfo)
    /* A0458 800AFC58 40100400 */  sll        $v0, $a0, 1
    /* A045C 800AFC5C 21104400 */  addu       $v0, $v0, $a0
    /* A0460 800AFC60 80100200 */  sll        $v0, $v0, 2
    /* A0464 800AFC64 21104300 */  addu       $v0, $v0, $v1
    /* A0468 800AFC68 0400428C */  lw         $v0, 0x4($v0)
    /* A046C 800AFC6C 00000000 */  nop
    /* A0470 800AFC70 01004224 */  addiu      $v0, $v0, 0x1
    /* A0474 800AFC74 43100200 */  sra        $v0, $v0, 1
    /* A0478 800AFC78 01004238 */  xori       $v0, $v0, 0x1
    /* A047C 800AFC7C B801A2AF */  sw         $v0, 0x1B8($sp)
  .L800AFC80:
    /* A0480 800AFC80 1180023C */  lui        $v0, %hi(D_80113218)
    /* A0484 800AFC84 1832428C */  lw         $v0, %lo(D_80113218)($v0)
    /* A0488 800AFC88 00000000 */  nop
    /* A048C 800AFC8C 05004010 */  beqz       $v0, .L800AFCA4
    /* A0490 800AFC90 EAFFE226 */   addiu     $v0, $s7, -0x16
    /* A0494 800AFC94 B801AB8F */  lw         $t3, 0x1B8($sp)
    /* A0498 800AFC98 00000000 */  nop
    /* A049C 800AFC9C 01006B39 */  xori       $t3, $t3, 0x1
    /* A04A0 800AFCA0 B801ABAF */  sw         $t3, 0x1B8($sp)
  .L800AFCA4:
    /* A04A4 800AFCA4 B801AB8F */  lw         $t3, 0x1B8($sp)
    /* A04A8 800AFCA8 C208A386 */  lh         $v1, 0x8C2($s5)
    /* A04AC 800AFCAC 700E8BAF */  sw         $t3, %gp_rel(R3DCar_rightHandDrive)($gp)
    /* A04B0 800AFCB0 33046004 */  bltz       $v1, .L800B0D80
    /* A04B4 800AFCB4 0600562C */   sltiu     $s6, $v0, 0x6
    /* A04B8 800AFCB8 B408A496 */  lhu        $a0, 0x8B4($s5)
    /* A04BC 800AFCBC 00000000 */  nop
    /* A04C0 800AFCC0 08008230 */  andi       $v0, $a0, 0x8
    /* A04C4 800AFCC4 10004014 */  bnez       $v0, .L800AFD08
    /* A04C8 800AFCC8 80008230 */   andi      $v0, $a0, 0x80
    /* A04CC 800AFCCC 1802A38E */  lw         $v1, 0x218($s5)
    /* A04D0 800AFCD0 1E00023C */  lui        $v0, (0x1E0000 >> 16)
    /* A04D4 800AFCD4 2A104300 */  slt        $v0, $v0, $v1
    /* A04D8 800AFCD8 09004010 */  beqz       $v0, .L800AFD00
    /* A04DC 800AFCDC 44008230 */   andi      $v0, $a0, 0x44
    /* A04E0 800AFCE0 03004014 */  bnez       $v0, .L800AFCF0
    /* A04E4 800AFCE4 02008230 */   andi      $v0, $a0, 0x2
    /* A04E8 800AFCE8 3EBF0208 */  j          .L800AFCF8
    /* A04EC 800AFCEC 0C008234 */   ori       $v0, $a0, 0xC
  .L800AFCF0:
    /* A04F0 800AFCF0 02004010 */  beqz       $v0, .L800AFCFC
    /* A04F4 800AFCF4 08008234 */   ori       $v0, $a0, 0x8
  .L800AFCF8:
    /* A04F8 800AFCF8 B408A2A6 */  sh         $v0, 0x8B4($s5)
  .L800AFCFC:
    /* A04FC 800AFCFC B408A496 */  lhu        $a0, 0x8B4($s5)
  .L800AFD00:
    /* A0500 800AFD00 00000000 */  nop
    /* A0504 800AFD04 80008230 */  andi       $v0, $a0, 0x80
  .L800AFD08:
    /* A0508 800AFD08 0D004014 */  bnez       $v0, .L800AFD40
    /* A050C 800AFD0C 1E00023C */   lui       $v0, (0x1E0000 >> 16)
    /* A0510 800AFD10 2002A38E */  lw         $v1, 0x220($s5)
    /* A0514 800AFD14 00000000 */  nop
    /* A0518 800AFD18 2A104300 */  slt        $v0, $v0, $v1
    /* A051C 800AFD1C 08004010 */  beqz       $v0, .L800AFD40
    /* A0520 800AFD20 44008230 */   andi      $v0, $a0, 0x44
    /* A0524 800AFD24 03004014 */  bnez       $v0, .L800AFD34
    /* A0528 800AFD28 20008230 */   andi      $v0, $a0, 0x20
    /* A052C 800AFD2C 4FBF0208 */  j          .L800AFD3C
    /* A0530 800AFD30 C0008234 */   ori       $v0, $a0, 0xC0
  .L800AFD34:
    /* A0534 800AFD34 02004010 */  beqz       $v0, .L800AFD40
    /* A0538 800AFD38 80008234 */   ori       $v0, $a0, 0x80
  .L800AFD3C:
    /* A053C 800AFD3C B408A2A6 */  sh         $v0, 0x8B4($s5)
  .L800AFD40:
    /* A0540 800AFD40 2400C012 */  beqz       $s6, .L800AFDD4
    /* A0544 800AFD44 00000000 */   nop
    /* A0548 800AFD48 7005A28E */  lw         $v0, 0x570($s5)
    /* A054C 800AFD4C 00000000 */  nop
    /* A0550 800AFD50 02004230 */  andi       $v0, $v0, 0x2
    /* A0554 800AFD54 11004010 */  beqz       $v0, .L800AFD9C
    /* A0558 800AFD58 00000000 */   nop
    /* A055C 800AFD5C B808A296 */  lhu        $v0, 0x8B8($s5)
    /* A0560 800AFD60 00000000 */  nop
    /* A0564 800AFD64 80004230 */  andi       $v0, $v0, 0x80
    /* A0568 800AFD68 1A004014 */  bnez       $v0, .L800AFDD4
    /* A056C 800AFD6C 80000224 */   addiu     $v0, $zero, 0x80
    /* A0570 800AFD70 B808A2A6 */  sh         $v0, 0x8B8($s5)
    /* A0574 800AFD74 4704A292 */  lbu        $v0, 0x447($s5)
    /* A0578 800AFD78 88000324 */  addiu      $v1, $zero, 0x88
    /* A057C 800AFD7C 02004230 */  andi       $v0, $v0, 0x2
    /* A0580 800AFD80 14004014 */  bnez       $v0, .L800AFDD4
    /* A0584 800AFD84 BA08A3A6 */   sh        $v1, 0x8BA($s5)
    /* A0588 800AFD88 2120A002 */  addu       $a0, $s5, $zero
    /* A058C 800AFD8C BDBE020C */  jal        R3DCar_TurnHeadLightOn__FP8Car_tObji
    /* A0590 800AFD90 01000524 */   addiu     $a1, $zero, 0x1
    /* A0594 800AFD94 75BF0208 */  j          .L800AFDD4
    /* A0598 800AFD98 00000000 */   nop
  .L800AFD9C:
    /* A059C 800AFD9C B808A296 */  lhu        $v0, 0x8B8($s5)
    /* A05A0 800AFDA0 00000000 */  nop
    /* A05A4 800AFDA4 80004230 */  andi       $v0, $v0, 0x80
    /* A05A8 800AFDA8 0A004010 */  beqz       $v0, .L800AFDD4
    /* A05AC 800AFDAC 00000000 */   nop
    /* A05B0 800AFDB0 4704A592 */  lbu        $a1, 0x447($s5)
    /* A05B4 800AFDB4 B808A0A6 */  sh         $zero, 0x8B8($s5)
    /* A05B8 800AFDB8 0200A230 */  andi       $v0, $a1, 0x2
    /* A05BC 800AFDBC 05004014 */  bnez       $v0, .L800AFDD4
    /* A05C0 800AFDC0 BA08A0A6 */   sh        $zero, 0x8BA($s5)
    /* A05C4 800AFDC4 2120A002 */  addu       $a0, $s5, $zero
    /* A05C8 800AFDC8 0400A530 */  andi       $a1, $a1, 0x4
    /* A05CC 800AFDCC D5BE020C */  jal        R3DCar_TurnHeadLightOff__FP8Car_tObji
    /* A05D0 800AFDD0 0100A52C */   sltiu     $a1, $a1, 0x1
  .L800AFDD4:
    /* A05D4 800AFDD4 5C0E828F */  lw         $v0, %gp_rel(R3DCar_Clock)($gp)
    /* A05D8 800AFDD8 00000000 */  nop
    /* A05DC 800AFDDC 10004010 */  beqz       $v0, .L800AFE20
    /* A05E0 800AFDE0 1C00E22A */   slti      $v0, $s7, 0x1C
    /* A05E4 800AFDE4 B808A396 */  lhu        $v1, 0x8B8($s5)
    /* A05E8 800AFDE8 00000000 */  nop
    /* A05EC 800AFDEC 80006230 */  andi       $v0, $v1, 0x80
    /* A05F0 800AFDF0 03004010 */  beqz       $v0, .L800AFE00
    /* A05F4 800AFDF4 01006224 */   addiu     $v0, $v1, 0x1
    /* A05F8 800AFDF8 8F004230 */  andi       $v0, $v0, 0x8F
    /* A05FC 800AFDFC B808A2A6 */  sh         $v0, 0x8B8($s5)
  .L800AFE00:
    /* A0600 800AFE00 BA08A396 */  lhu        $v1, 0x8BA($s5)
    /* A0604 800AFE04 00000000 */  nop
    /* A0608 800AFE08 80006230 */  andi       $v0, $v1, 0x80
    /* A060C 800AFE0C 03004010 */  beqz       $v0, .L800AFE1C
    /* A0610 800AFE10 01006224 */   addiu     $v0, $v1, 0x1
    /* A0614 800AFE14 8F004230 */  andi       $v0, $v0, 0x8F
    /* A0618 800AFE18 BA08A2A6 */  sh         $v0, 0x8BA($s5)
  .L800AFE1C:
    /* A061C 800AFE1C 1C00E22A */  slti       $v0, $s7, 0x1C
  .L800AFE20:
    /* A0620 800AFE20 03004014 */  bnez       $v0, .L800AFE30
    /* A0624 800AFE24 00000000 */   nop
    /* A0628 800AFE28 94BF0208 */  j          .L800AFE50
    /* A062C 800AFE2C B001A0AF */   sw        $zero, 0x1B0($sp)
  .L800AFE30:
    /* A0630 800AFE30 B308A292 */  lbu        $v0, 0x8B3($s5)
    /* A0634 800AFE34 00000000 */  nop
    /* A0638 800AFE38 02004230 */  andi       $v0, $v0, 0x2
    /* A063C 800AFE3C 04004010 */  beqz       $v0, .L800AFE50
    /* A0640 800AFE40 00000000 */   nop
    /* A0644 800AFE44 D408AB8E */  lw         $t3, 0x8D4($s5)
    /* A0648 800AFE48 00000000 */  nop
    /* A064C 800AFE4C B001ABAF */  sw         $t3, 0x1B0($sp)
  .L800AFE50:
    /* A0650 800AFE50 C208A286 */  lh         $v0, 0x8C2($s5)
    /* A0654 800AFE54 00000000 */  nop
    /* A0658 800AFE58 08004014 */  bnez       $v0, .L800AFE7C
    /* A065C 800AFE5C 1C00E22A */   slti      $v0, $s7, 0x1C
    /* A0660 800AFE60 05004010 */  beqz       $v0, .L800AFE78
    /* A0664 800AFE64 01000224 */   addiu     $v0, $zero, 0x1
    /* A0668 800AFE68 B208A292 */  lbu        $v0, 0x8B2($s5)
    /* A066C 800AFE6C 00000000 */  nop
    /* A0670 800AFE70 02004010 */  beqz       $v0, .L800AFE7C
    /* A0674 800AFE74 01000224 */   addiu     $v0, $zero, 0x1
  .L800AFE78:
    /* A0678 800AFE78 C208A2A6 */  sh         $v0, 0x8C2($s5)
  .L800AFE7C:
    /* A067C 800AFE7C C208A386 */  lh         $v1, 0x8C2($s5)
    /* A0680 800AFE80 02000224 */  addiu      $v0, $zero, 0x2
    /* A0684 800AFE84 04006214 */  bne        $v1, $v0, .L800AFE98
    /* A0688 800AFE88 1C000224 */   addiu     $v0, $zero, 0x1C
    /* A068C 800AFE8C 0200E216 */  bne        $s7, $v0, .L800AFE98
    /* A0690 800AFE90 01000224 */   addiu     $v0, $zero, 0x1
    /* A0694 800AFE94 C208A2A6 */  sh         $v0, 0x8C2($s5)
  .L800AFE98:
    /* A0698 800AFE98 EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A069C 800AFE9C A000A38E */  lw         $v1, 0xA0($s5)
    /* A06A0 800AFEA0 0800628D */  lw         $v0, 0x8($t3)
    /* A06A4 800AFEA4 C208A486 */  lh         $a0, 0x8C2($s5)
    /* A06A8 800AFEA8 23306200 */  subu       $a2, $v1, $v0
    /* A06AC 800AFEAC F000A6AF */  sw         $a2, 0xF0($sp)
    /* A06B0 800AFEB0 A400A38E */  lw         $v1, 0xA4($s5)
    /* A06B4 800AFEB4 0C00628D */  lw         $v0, 0xC($t3)
    /* A06B8 800AFEB8 02009E24 */  addiu      $fp, $a0, 0x2
    /* A06BC 800AFEBC 23386200 */  subu       $a3, $v1, $v0
    /* A06C0 800AFEC0 F400A7AF */  sw         $a3, 0xF4($sp)
    /* A06C4 800AFEC4 A800A38E */  lw         $v1, 0xA8($s5)
    /* A06C8 800AFEC8 1000628D */  lw         $v0, 0x10($t3)
    /* A06CC 800AFECC 2128C000 */  addu       $a1, $a2, $zero
    /* A06D0 800AFED0 23186200 */  subu       $v1, $v1, $v0
    /* A06D4 800AFED4 0200C104 */  bgez       $a2, .L800AFEE0
    /* A06D8 800AFED8 F800A3AF */   sw        $v1, 0xF8($sp)
    /* A06DC 800AFEDC FF00C524 */  addiu      $a1, $a2, 0xFF
  .L800AFEE0:
    /* A06E0 800AFEE0 F000A28E */  lw         $v0, 0xF0($s5)
    /* A06E4 800AFEE4 00000000 */  nop
    /* A06E8 800AFEE8 02004104 */  bgez       $v0, .L800AFEF4
    /* A06EC 800AFEEC 034A0500 */   sra       $t1, $a1, 8
    /* A06F0 800AFEF0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AFEF4:
    /* A06F4 800AFEF4 03120200 */  sra        $v0, $v0, 8
    /* A06F8 800AFEF8 18002201 */  mult       $t1, $v0
    /* A06FC 800AFEFC 12280000 */  mflo       $a1
    /* A0700 800AFF00 0200E104 */  bgez       $a3, .L800AFF0C
    /* A0704 800AFF04 2120E000 */   addu      $a0, $a3, $zero
    /* A0708 800AFF08 FF00E424 */  addiu      $a0, $a3, 0xFF
  .L800AFF0C:
    /* A070C 800AFF0C F400A28E */  lw         $v0, 0xF4($s5)
    /* A0710 800AFF10 00000000 */  nop
    /* A0714 800AFF14 02004104 */  bgez       $v0, .L800AFF20
    /* A0718 800AFF18 03420400 */   sra       $t0, $a0, 8
    /* A071C 800AFF1C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AFF20:
    /* A0720 800AFF20 03120200 */  sra        $v0, $v0, 8
    /* A0724 800AFF24 18000201 */  mult       $t0, $v0
    /* A0728 800AFF28 12580000 */  mflo       $t3
    /* A072C 800AFF2C 02006104 */  bgez       $v1, .L800AFF38
    /* A0730 800AFF30 2120AB00 */   addu      $a0, $a1, $t3
    /* A0734 800AFF34 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800AFF38:
    /* A0738 800AFF38 F800A28E */  lw         $v0, 0xF8($s5)
    /* A073C 800AFF3C 00000000 */  nop
    /* A0740 800AFF40 02004104 */  bgez       $v0, .L800AFF4C
    /* A0744 800AFF44 031A0300 */   sra       $v1, $v1, 8
    /* A0748 800AFF48 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AFF4C:
    /* A074C 800AFF4C 03120200 */  sra        $v0, $v0, 8
    /* A0750 800AFF50 18006200 */  mult       $v1, $v0
    /* A0754 800AFF54 12580000 */  mflo       $t3
    /* A0758 800AFF58 21208B00 */  addu       $a0, $a0, $t3
    /* A075C 800AFF5C 0001A4AF */  sw         $a0, 0x100($sp)
    /* A0760 800AFF60 0801A28E */  lw         $v0, 0x108($s5)
    /* A0764 800AFF64 00000000 */  nop
    /* A0768 800AFF68 02004104 */  bgez       $v0, .L800AFF74
    /* A076C 800AFF6C 00000000 */   nop
    /* A0770 800AFF70 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AFF74:
    /* A0774 800AFF74 03120200 */  sra        $v0, $v0, 8
    /* A0778 800AFF78 18002201 */  mult       $t1, $v0
    /* A077C 800AFF7C 12280000 */  mflo       $a1
    /* A0780 800AFF80 0C01A28E */  lw         $v0, 0x10C($s5)
    /* A0784 800AFF84 00000000 */  nop
    /* A0788 800AFF88 02004104 */  bgez       $v0, .L800AFF94
    /* A078C 800AFF8C 00000000 */   nop
    /* A0790 800AFF90 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AFF94:
    /* A0794 800AFF94 03120200 */  sra        $v0, $v0, 8
    /* A0798 800AFF98 18000201 */  mult       $t0, $v0
    /* A079C 800AFF9C F800A68F */  lw         $a2, 0xF8($sp)
    /* A07A0 800AFFA0 12580000 */  mflo       $t3
    /* A07A4 800AFFA4 0200C104 */  bgez       $a2, .L800AFFB0
    /* A07A8 800AFFA8 2128AB00 */   addu      $a1, $a1, $t3
    /* A07AC 800AFFAC FF00C624 */  addiu      $a2, $a2, 0xFF
  .L800AFFB0:
    /* A07B0 800AFFB0 1001A28E */  lw         $v0, 0x110($s5)
    /* A07B4 800AFFB4 00000000 */  nop
    /* A07B8 800AFFB8 02004104 */  bgez       $v0, .L800AFFC4
    /* A07BC 800AFFBC 03320600 */   sra       $a2, $a2, 8
    /* A07C0 800AFFC0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800AFFC4:
    /* A07C4 800AFFC4 03120200 */  sra        $v0, $v0, 8
    /* A07C8 800AFFC8 1800C200 */  mult       $a2, $v0
    /* A07CC 800AFFCC 12580000 */  mflo       $t3
    /* A07D0 800AFFD0 2128AB00 */  addu       $a1, $a1, $t3
    /* A07D4 800AFFD4 4AB5030C */  jal        fixedatan
    /* A07D8 800AFFD8 0801A5AF */   sw        $a1, 0x108($sp)
    /* A07DC 800AFFDC 03110200 */  sra        $v0, $v0, 4
    /* A07E0 800AFFE0 00100324 */  addiu      $v1, $zero, 0x1000
    /* A07E4 800AFFE4 23186200 */  subu       $v1, $v1, $v0
    /* A07E8 800AFFE8 1C00E22A */  slti       $v0, $s7, 0x1C
    /* A07EC 800AFFEC 580E83A7 */  sh         $v1, %gp_rel(R3DCar_yawCam)($gp)
    /* A07F0 800AFFF0 3D004010 */  beqz       $v0, .L800B00E8
    /* A07F4 800AFFF4 F000B026 */   addiu     $s0, $s5, 0xF0
    /* A07F8 800AFFF8 21200002 */  addu       $a0, $s0, $zero
    /* A07FC 800AFFFC 7800B427 */  addiu      $s4, $sp, 0x78
    /* A0800 800B0000 EABE020C */  jal        R3DCar_MATRIX3DT_Copy__FPiT0
    /* A0804 800B0004 21288002 */   addu      $a1, $s4, $zero
    /* A0808 800B0008 B801AB8F */  lw         $t3, 0x1B8($sp)
    /* A080C 800B000C 00000000 */  nop
    /* A0810 800B0010 0B006011 */  beqz       $t3, .L800B0040
    /* A0814 800B0014 00000000 */   nop
    /* A0818 800B0018 7800A28F */  lw         $v0, 0x78($sp)
    /* A081C 800B001C 8000A38F */  lw         $v1, 0x80($sp)
    /* A0820 800B0020 23100200 */  negu       $v0, $v0
    /* A0824 800B0024 7800A2AF */  sw         $v0, 0x78($sp)
    /* A0828 800B0028 7C00A28F */  lw         $v0, 0x7C($sp)
    /* A082C 800B002C 23180300 */  negu       $v1, $v1
    /* A0830 800B0030 8000A3AF */  sw         $v1, 0x80($sp)
    /* A0834 800B0034 23100200 */  negu       $v0, $v0
    /* A0838 800B0038 7C00A2AF */  sw         $v0, 0x7C($sp)
    /* A083C 800B003C B801AB8F */  lw         $t3, 0x1B8($sp)
  .L800B0040:
    /* A0840 800B0040 4C08B38E */  lw         $s3, 0x84C($s5)
    /* A0844 800B0044 02006011 */  beqz       $t3, .L800B0050
    /* A0848 800B0048 2800B127 */   addiu     $s1, $sp, 0x28
    /* A084C 800B004C 23981300 */  negu       $s3, $s3
  .L800B0050:
    /* A0850 800B0050 4C08A58E */  lw         $a1, 0x84C($s5)
    /* A0854 800B0054 1DAB030C */  jal        fixedxformz
    /* A0858 800B0058 21202002 */   addu      $a0, $s1, $zero
    /* A085C 800B005C 3801B227 */  addiu      $s2, $sp, 0x138
    /* A0860 800B0060 4808A58E */  lw         $a1, 0x848($s5)
    /* A0864 800B0064 21204002 */  addu       $a0, $s2, $zero
    /* A0868 800B0068 EBAA030C */  jal        fixedxformx
    /* A086C 800B006C 6400A524 */   addiu     $a1, $a1, 0x64
    /* A0870 800B0070 21202002 */  addu       $a0, $s1, $zero
    /* A0874 800B0074 21284002 */  addu       $a1, $s2, $zero
    /* A0878 800B0078 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A087C 800B007C 21302002 */   addu      $a2, $s1, $zero
    /* A0880 800B0080 21202002 */  addu       $a0, $s1, $zero
    /* A0884 800B0084 21280002 */  addu       $a1, $s0, $zero
    /* A0888 800B0088 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A088C 800B008C 21302002 */   addu      $a2, $s1, $zero
    /* A0890 800B0090 1001B027 */  addiu      $s0, $sp, 0x110
    /* A0894 800B0094 21200002 */  addu       $a0, $s0, $zero
    /* A0898 800B0098 1DAB030C */  jal        fixedxformz
    /* A089C 800B009C 21286002 */   addu      $a1, $s3, $zero
    /* A08A0 800B00A0 21200002 */  addu       $a0, $s0, $zero
    /* A08A4 800B00A4 21284002 */  addu       $a1, $s2, $zero
    /* A08A8 800B00A8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A08AC 800B00AC 21300002 */   addu      $a2, $s0, $zero
    /* A08B0 800B00B0 21200002 */  addu       $a0, $s0, $zero
    /* A08B4 800B00B4 21288002 */  addu       $a1, $s4, $zero
    /* A08B8 800B00B8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A08BC 800B00BC 21308002 */   addu      $a2, $s4, $zero
    /* A08C0 800B00C0 21202002 */  addu       $a0, $s1, $zero
    /* A08C4 800B00C4 EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A08C8 800B00C8 5000A627 */  addiu      $a2, $sp, 0x50
    /* A08CC 800B00CC 44007025 */  addiu      $s0, $t3, 0x44
    /* A08D0 800B00D0 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A08D4 800B00D4 21280002 */   addu      $a1, $s0, $zero
    /* A08D8 800B00D8 21208002 */  addu       $a0, $s4, $zero
    /* A08DC 800B00DC 21280002 */  addu       $a1, $s0, $zero
    /* A08E0 800B00E0 4EC00208 */  j          .L800B0138
    /* A08E4 800B00E4 A000A627 */   addiu     $a2, $sp, 0xA0
  .L800B00E8:
    /* A08E8 800B00E8 2800B027 */  addiu      $s0, $sp, 0x28
    /* A08EC 800B00EC 4C08A58E */  lw         $a1, 0x84C($s5)
    /* A08F0 800B00F0 1DAB030C */  jal        fixedxformz
    /* A08F4 800B00F4 21200002 */   addu      $a0, $s0, $zero
    /* A08F8 800B00F8 F000B127 */  addiu      $s1, $sp, 0xF0
    /* A08FC 800B00FC 4808A58E */  lw         $a1, 0x848($s5)
    /* A0900 800B0100 EBAA030C */  jal        fixedxformx
    /* A0904 800B0104 21202002 */   addu      $a0, $s1, $zero
    /* A0908 800B0108 21200002 */  addu       $a0, $s0, $zero
    /* A090C 800B010C 21282002 */  addu       $a1, $s1, $zero
    /* A0910 800B0110 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A0914 800B0114 21300002 */   addu      $a2, $s0, $zero
    /* A0918 800B0118 21200002 */  addu       $a0, $s0, $zero
    /* A091C 800B011C F000A526 */  addiu      $a1, $s5, 0xF0
    /* A0920 800B0120 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A0924 800B0124 21300002 */   addu      $a2, $s0, $zero
    /* A0928 800B0128 21200002 */  addu       $a0, $s0, $zero
    /* A092C 800B012C EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A0930 800B0130 5000A627 */  addiu      $a2, $sp, 0x50
    /* A0934 800B0134 44006525 */  addiu      $a1, $t3, 0x44
  .L800B0138:
    /* A0938 800B0138 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A093C 800B013C 00000000 */   nop
    /* A0940 800B0140 1280023C */  lui        $v0, %hi(simVar)
    /* A0944 800B0144 C4E04324 */  addiu      $v1, $v0, %lo(simVar)
    /* A0948 800B0148 0800628C */  lw         $v0, 0x8($v1)
    /* A094C 800B014C 00000000 */  nop
    /* A0950 800B0150 68004014 */  bnez       $v0, .L800B02F4
    /* A0954 800B0154 1E00023C */   lui       $v0, (0x1E0000 >> 16)
    /* A0958 800B0158 1000628C */  lw         $v0, 0x10($v1)
    /* A095C 800B015C 00000000 */  nop
    /* A0960 800B0160 64004014 */  bnez       $v0, .L800B02F4
    /* A0964 800B0164 1E00023C */   lui       $v0, (0x1E0000 >> 16)
    /* A0968 800B0168 1C000224 */  addiu      $v0, $zero, 0x1C
    /* A096C 800B016C 0A00E216 */  bne        $s7, $v0, .L800B0198
    /* A0970 800B0170 21280000 */   addu      $a1, $zero, $zero
    /* A0974 800B0174 D000A28E */  lw         $v0, 0xD0($s5)
    /* A0978 800B0178 D400A38E */  lw         $v1, 0xD4($s5)
    /* A097C 800B017C 00184224 */  addiu      $v0, $v0, 0x1800
    /* A0980 800B0180 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* A0984 800B0184 00186324 */  addiu      $v1, $v1, 0x1800
    /* A0988 800B0188 FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* A098C 800B018C D000A2AE */  sw         $v0, 0xD0($s5)
    /* A0990 800B0190 BCC00208 */  j          .L800B02F0
    /* A0994 800B0194 D400A3AE */   sw        $v1, 0xD4($s5)
  .L800B0198:
    /* A0998 800B0198 02000924 */  addiu      $t1, $zero, 0x2
    /* A099C 800B019C 1180023C */  lui        $v0, %hi(Replay_ReplayInterface)
    /* A09A0 800B01A0 2C704824 */  addiu      $t0, $v0, %lo(Replay_ReplayInterface)
    /* A09A4 800B01A4 2130A002 */  addu       $a2, $s5, $zero
    /* A09A8 800B01A8 6C04A28E */  lw         $v0, 0x46C($s5)
    /* A09AC 800B01AC 1480073C */  lui        $a3, %hi(Replay_ReplayMode)
    /* A09B0 800B01B0 F4D3E78C */  lw         $a3, %lo(Replay_ReplayMode)($a3)
    /* A09B4 800B01B4 02004104 */  bgez       $v0, .L800B01C0
    /* A09B8 800B01B8 00000000 */   nop
    /* A09BC 800B01BC 23100200 */  negu       $v0, $v0
  .L800B01C0:
    /* A09C0 800B01C0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A09C4 800B01C4 2B504900 */  sltu       $t2, $v0, $t1
  .L800B01C8:
    /* A09C8 800B01C8 0200A228 */  slti       $v0, $a1, 0x2
    /* A09CC 800B01CC 49004010 */  beqz       $v0, .L800B02F4
    /* A09D0 800B01D0 1E00023C */   lui       $v0, (0x1E0000 >> 16)
    /* A09D4 800B01D4 0400E910 */  beq        $a3, $t1, .L800B01E8
    /* A09D8 800B01D8 08000224 */   addiu     $v0, $zero, 0x8
    /* A09DC 800B01DC 2004A28E */  lw         $v0, 0x420($s5)
    /* A09E0 800B01E0 7EC00208 */  j          .L800B01F8
    /* A09E4 800B01E4 83210200 */   sra       $a0, $v0, 6
  .L800B01E8:
    /* A09E8 800B01E8 0400038D */  lw         $v1, 0x4($t0)
    /* A09EC 800B01EC 2004A48E */  lw         $a0, 0x420($s5)
    /* A09F0 800B01F0 23104300 */  subu       $v0, $v0, $v1
    /* A09F4 800B01F4 07204400 */  srav       $a0, $a0, $v0
  .L800B01F8:
    /* A09F8 800B01F8 0500A010 */  beqz       $a1, .L800B0210
    /* A09FC 800B01FC 00000000 */   nop
    /* A0A00 800B0200 24004011 */  beqz       $t2, .L800B0294
    /* A0A04 800B0204 00000000 */   nop
    /* A0A08 800B0208 88C00208 */  j          .L800B0220
    /* A0A0C 800B020C 00000000 */   nop
  .L800B0210:
    /* A0A10 800B0210 7004A28E */  lw         $v0, 0x470($s5)
    /* A0A14 800B0214 00000000 */  nop
    /* A0A18 800B0218 1E004010 */  beqz       $v0, .L800B0294
    /* A0A1C 800B021C 00000000 */   nop
  .L800B0220:
    /* A0A20 800B0220 4204A392 */  lbu        $v1, 0x442($s5)
    /* A0A24 800B0224 01000224 */  addiu      $v0, $zero, 0x1
    /* A0A28 800B0228 1A006210 */  beq        $v1, $v0, .L800B0294
    /* A0A2C 800B022C 21106000 */   addu      $v0, $v1, $zero
    /* A0A30 800B0230 6404A38E */  lw         $v1, 0x464($s5)
    /* A0A34 800B0234 80100200 */  sll        $v0, $v0, 2
    /* A0A38 800B0238 21186200 */  addu       $v1, $v1, $v0
    /* A0A3C 800B023C 6804A28E */  lw         $v0, 0x468($s5)
    /* A0A40 800B0240 0C00638C */  lw         $v1, 0xC($v1)
    /* A0A44 800B0244 00140200 */  sll        $v0, $v0, 16
    /* A0A48 800B0248 1A004300 */  div        $zero, $v0, $v1
    /* A0A4C 800B024C 02006014 */  bnez       $v1, .L800B0258
    /* A0A50 800B0250 00000000 */   nop
    /* A0A54 800B0254 0D000700 */  break      7
  .L800B0258:
    /* A0A58 800B0258 FFFF0124 */  addiu      $at, $zero, -0x1
    /* A0A5C 800B025C 04006114 */  bne        $v1, $at, .L800B0270
    /* A0A60 800B0260 0080013C */   lui       $at, (0x80000000 >> 16)
    /* A0A64 800B0264 02004114 */  bne        $v0, $at, .L800B0270
    /* A0A68 800B0268 00000000 */   nop
    /* A0A6C 800B026C 0D000600 */  break      6
  .L800B0270:
    /* A0A70 800B0270 12200000 */  mflo       $a0
    /* A0A74 800B0274 0300E910 */  beq        $a3, $t1, .L800B0284
    /* A0A78 800B0278 00000000 */   nop
    /* A0A7C 800B027C A5C00208 */  j          .L800B0294
    /* A0A80 800B0280 40220400 */   sll       $a0, $a0, 9
  .L800B0284:
    /* A0A84 800B0284 0400028D */  lw         $v0, 0x4($t0)
    /* A0A88 800B0288 00000000 */  nop
    /* A0A8C 800B028C 07004224 */  addiu      $v0, $v0, 0x7
    /* A0A90 800B0290 04204400 */  sllv       $a0, $a0, $v0
  .L800B0294:
    /* A0A94 800B0294 7404A38E */  lw         $v1, 0x474($s5)
    /* A0A98 800B0298 00000000 */  nop
    /* A0A9C 800B029C 05006010 */  beqz       $v1, .L800B02B4
    /* A0AA0 800B02A0 0100A224 */   addiu     $v0, $a1, 0x1
    /* A0AA4 800B02A4 24106200 */  and        $v0, $v1, $v0
    /* A0AA8 800B02A8 03004010 */  beqz       $v0, .L800B02B8
    /* A0AAC 800B02AC 00E88228 */   slti      $v0, $a0, -0x1800
    /* A0AB0 800B02B0 21200000 */  addu       $a0, $zero, $zero
  .L800B02B4:
    /* A0AB4 800B02B4 00E88228 */  slti       $v0, $a0, -0x1800
  .L800B02B8:
    /* A0AB8 800B02B8 03004010 */  beqz       $v0, .L800B02C8
    /* A0ABC 800B02BC 01188228 */   slti      $v0, $a0, 0x1801
    /* A0AC0 800B02C0 00E80424 */  addiu      $a0, $zero, -0x1800
    /* A0AC4 800B02C4 01188228 */  slti       $v0, $a0, 0x1801
  .L800B02C8:
    /* A0AC8 800B02C8 02004014 */  bnez       $v0, .L800B02D4
    /* A0ACC 800B02CC 00000000 */   nop
    /* A0AD0 800B02D0 00180424 */  addiu      $a0, $zero, 0x1800
  .L800B02D4:
    /* A0AD4 800B02D4 D000C28C */  lw         $v0, 0xD0($a2)
    /* A0AD8 800B02D8 0100A524 */  addiu      $a1, $a1, 0x1
    /* A0ADC 800B02DC 21104400 */  addu       $v0, $v0, $a0
    /* A0AE0 800B02E0 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* A0AE4 800B02E4 D000C2AC */  sw         $v0, 0xD0($a2)
    /* A0AE8 800B02E8 72C00208 */  j          .L800B01C8
    /* A0AEC 800B02EC 0400C624 */   addiu     $a2, $a2, 0x4
  .L800B02F0:
    /* A0AF0 800B02F0 1E00023C */  lui        $v0, (0x1E0000 >> 16)
  .L800B02F4:
    /* A0AF4 800B02F4 2004A48E */  lw         $a0, 0x420($s5)
    /* A0AF8 800B02F8 5004B08E */  lw         $s0, 0x450($s5)
    /* A0AFC 800B02FC 2A104400 */  slt        $v0, $v0, $a0
    /* A0B00 800B0300 0C004010 */  beqz       $v0, .L800B0334
    /* A0B04 800B0304 00000000 */   nop
    /* A0B08 800B0308 CA90030C */  jal        fixedmult
    /* A0B0C 800B030C 88080524 */   addiu     $a1, $zero, 0x888
    /* A0B10 800B0310 00241000 */  sll        $a0, $s0, 16
    /* A0B14 800B0314 0191030C */  jal        rdiv
    /* A0B18 800B0318 21284000 */   addu      $a1, $v0, $zero
    /* A0B1C 800B031C 21204000 */  addu       $a0, $v0, $zero
    /* A0B20 800B0320 04008104 */  bgez       $a0, .L800B0334
    /* A0B24 800B0324 03840400 */   sra       $s0, $a0, 16
    /* A0B28 800B0328 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* A0B2C 800B032C 21208200 */  addu       $a0, $a0, $v0
    /* A0B30 800B0330 03840400 */  sra        $s0, $a0, 16
  .L800B0334:
    /* A0B34 800B0334 C800A427 */  addiu      $a0, $sp, 0xC8
    /* A0B38 800B0338 04AB030C */  jal        fixedxformy
    /* A0B3C 800B033C 40291000 */   sll       $a1, $s0, 5
    /* A0B40 800B0340 3D04A292 */  lbu        $v0, 0x43D($s5)
    /* A0B44 800B0344 00000000 */  nop
    /* A0B48 800B0348 08004010 */  beqz       $v0, .L800B036C
    /* A0B4C 800B034C 00000000 */   nop
    /* A0B50 800B0350 5404A28E */  lw         $v0, 0x454($s5)
    /* A0B54 800B0354 00000000 */  nop
    /* A0B58 800B0358 04004014 */  bnez       $v0, .L800B036C
    /* A0B5C 800B035C 00000000 */   nop
    /* A0B60 800B0360 B608A296 */  lhu        $v0, 0x8B6($s5)
    /* A0B64 800B0364 DEC00208 */  j          .L800B0378
    /* A0B68 800B0368 01004234 */   ori       $v0, $v0, 0x1
  .L800B036C:
    /* A0B6C 800B036C B608A296 */  lhu        $v0, 0x8B6($s5)
    /* A0B70 800B0370 00000000 */  nop
    /* A0B74 800B0374 FE004230 */  andi       $v0, $v0, 0xFE
  .L800B0378:
    /* A0B78 800B0378 B608A2A6 */  sh         $v0, 0x8B6($s5)
    /* A0B7C 800B037C 1C00E22A */  slti       $v0, $s7, 0x1C
    /* A0B80 800B0380 BE004010 */  beqz       $v0, .L800B067C
    /* A0B84 800B0384 21A00000 */   addu      $s4, $zero, $zero
    /* A0B88 800B0388 1180023C */  lui        $v0, %hi(R3DCar_ObjectInfo)
    /* A0B8C 800B038C E0654924 */  addiu      $t1, $v0, %lo(R3DCar_ObjectInfo)
    /* A0B90 800B0390 0580023C */  lui        $v0, %hi(jtbl_80056418)
    /* A0B94 800B0394 18644824 */  addiu      $t0, $v0, %lo(jtbl_80056418)
    /* A0B98 800B0398 8000063C */  lui        $a2, (0x800080 >> 16)
    /* A0B9C 800B039C 8000C634 */  ori        $a2, $a2, (0x800080 & 0xFFFF)
    /* A0BA0 800B03A0 0580023C */  lui        $v0, %hi(jtbl_80056470)
    /* A0BA4 800B03A4 70644724 */  addiu      $a3, $v0, %lo(jtbl_80056470)
    /* A0BA8 800B03A8 2120C003 */  addu       $a0, $fp, $zero
  .L800B03AC:
    /* A0BAC 800B03AC 3900822A */  slti       $v0, $s4, 0x39
    /* A0BB0 800B03B0 DE004010 */  beqz       $v0, .L800B072C
    /* A0BB4 800B03B4 21108900 */   addu      $v0, $a0, $t1
    /* A0BB8 800B03B8 00004290 */  lbu        $v0, 0x0($v0)
    /* A0BBC 800B03BC 00000000 */  nop
    /* A0BC0 800B03C0 00160200 */  sll        $v0, $v0, 24
    /* A0BC4 800B03C4 032E0200 */  sra        $a1, $v0, 24
    /* A0BC8 800B03C8 FEFFA224 */  addiu      $v0, $a1, -0x2
    /* A0BCC 800B03CC 00140200 */  sll        $v0, $v0, 16
    /* A0BD0 800B03D0 031C0200 */  sra        $v1, $v0, 16
    /* A0BD4 800B03D4 1500622C */  sltiu      $v0, $v1, 0x15
    /* A0BD8 800B03D8 7D004010 */  beqz       $v0, .L800B05D0
    /* A0BDC 800B03DC 80100300 */   sll       $v0, $v1, 2
    /* A0BE0 800B03E0 21104800 */  addu       $v0, $v0, $t0
    /* A0BE4 800B03E4 0000428C */  lw         $v0, 0x0($v0)
    /* A0BE8 800B03E8 00000000 */  nop
    /* A0BEC 800B03EC 08004000 */  jr         $v0
    /* A0BF0 800B03F0 00000000 */   nop
  jlabel .L800B03F4
    /* A0BF4 800B03F4 C008A296 */  lhu        $v0, 0x8C0($s5)
    /* A0BF8 800B03F8 71C10208 */  j          .L800B05C4
    /* A0BFC 800B03FC 01004230 */   andi      $v0, $v0, 0x1
  jlabel .L800B0400
    /* A0C00 800B0400 C008A286 */  lh         $v0, 0x8C0($s5)
    /* A0C04 800B0404 00000000 */  nop
    /* A0C08 800B0408 72004014 */  bnez       $v0, .L800B05D4
    /* A0C0C 800B040C FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0C10 800B0410 75C10208 */  j          .L800B05D4
    /* A0C14 800B0414 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B0418
    /* A0C18 800B0418 B308A292 */  lbu        $v0, 0x8B3($s5)
    /* A0C1C 800B041C 71C10208 */  j          .L800B05C4
    /* A0C20 800B0420 04004230 */   andi      $v0, $v0, 0x4
  jlabel .L800B0424
    /* A0C24 800B0424 B308A292 */  lbu        $v0, 0x8B3($s5)
    /* A0C28 800B0428 00000000 */  nop
    /* A0C2C 800B042C 04004230 */  andi       $v0, $v0, 0x4
    /* A0C30 800B0430 68004014 */  bnez       $v0, .L800B05D4
    /* A0C34 800B0434 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0C38 800B0438 75C10208 */  j          .L800B05D4
    /* A0C3C 800B043C 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B0440
    /* A0C40 800B0440 B408A296 */  lhu        $v0, 0x8B4($s5)
    /* A0C44 800B0444 40C10208 */  j          .L800B0500
    /* A0C48 800B0448 02004230 */   andi      $v0, $v0, 0x2
  jlabel .L800B044C
    /* A0C4C 800B044C B408A296 */  lhu        $v0, 0x8B4($s5)
    /* A0C50 800B0450 00000000 */  nop
    /* A0C54 800B0454 20004230 */  andi       $v0, $v0, 0x20
    /* A0C58 800B0458 5E004014 */  bnez       $v0, .L800B05D4
    /* A0C5C 800B045C FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0C60 800B0460 75C10208 */  j          .L800B05D4
    /* A0C64 800B0464 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B0468
    /* A0C68 800B0468 B408A296 */  lhu        $v0, 0x8B4($s5)
    /* A0C6C 800B046C 00000000 */  nop
    /* A0C70 800B0470 11004230 */  andi       $v0, $v0, 0x11
    /* A0C74 800B0474 57004014 */  bnez       $v0, .L800B05D4
    /* A0C78 800B0478 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0C7C 800B047C 75C10208 */  j          .L800B05D4
    /* A0C80 800B0480 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B0484
    /* A0C84 800B0484 B308A292 */  lbu        $v0, 0x8B3($s5)
    /* A0C88 800B0488 00000000 */  nop
    /* A0C8C 800B048C 01004230 */  andi       $v0, $v0, 0x1
    /* A0C90 800B0490 50004014 */  bnez       $v0, .L800B05D4
    /* A0C94 800B0494 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0C98 800B0498 75C10208 */  j          .L800B05D4
    /* A0C9C 800B049C 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B04A0
    /* A0CA0 800B04A0 B308A292 */  lbu        $v0, 0x8B3($s5)
    /* A0CA4 800B04A4 71C10208 */  j          .L800B05C4
    /* A0CA8 800B04A8 01004230 */   andi      $v0, $v0, 0x1
  jlabel .L800B04AC
    /* A0CAC 800B04AC 7E08A296 */  lhu        $v0, 0x87E($s5)
    /* A0CB0 800B04B0 71C10208 */  j          .L800B05C4
    /* A0CB4 800B04B4 01004230 */   andi      $v0, $v0, 0x1
  jlabel .L800B04B8
    /* A0CB8 800B04B8 7E08A296 */  lhu        $v0, 0x87E($s5)
    /* A0CBC 800B04BC 71C10208 */  j          .L800B05C4
    /* A0CC0 800B04C0 02004230 */   andi      $v0, $v0, 0x2
  jlabel .L800B04C4
    /* A0CC4 800B04C4 B608A286 */  lh         $v0, 0x8B6($s5)
    /* A0CC8 800B04C8 00000000 */  nop
    /* A0CCC 800B04CC 41004014 */  bnez       $v0, .L800B05D4
    /* A0CD0 800B04D0 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0CD4 800B04D4 3BC10208 */  j          .L800B04EC
    /* A0CD8 800B04D8 00000000 */   nop
  jlabel .L800B04DC
    /* A0CDC 800B04DC 4204A292 */  lbu        $v0, 0x442($s5)
    /* A0CE0 800B04E0 00000000 */  nop
    /* A0CE4 800B04E4 3B004010 */  beqz       $v0, .L800B05D4
    /* A0CE8 800B04E8 FAFF8326 */   addiu     $v1, $s4, -0x6
  .L800B04EC:
    /* A0CEC 800B04EC 3700C012 */  beqz       $s6, .L800B05CC
    /* A0CF0 800B04F0 00000000 */   nop
    /* A0CF4 800B04F4 7005A28E */  lw         $v0, 0x570($s5)
    /* A0CF8 800B04F8 00000000 */  nop
    /* A0CFC 800B04FC 02004230 */  andi       $v0, $v0, 0x2
  .L800B0500:
    /* A0D00 800B0500 34004014 */  bnez       $v0, .L800B05D4
    /* A0D04 800B0504 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0D08 800B0508 75C10208 */  j          .L800B05D4
    /* A0D0C 800B050C 21280000 */   addu      $a1, $zero, $zero
  jlabel .L800B0510
    /* A0D10 800B0510 B808A28E */  lw         $v0, 0x8B8($s5)
    /* A0D14 800B0514 00000000 */  nop
    /* A0D18 800B0518 24104600 */  and        $v0, $v0, $a2
    /* A0D1C 800B051C 2B004010 */  beqz       $v0, .L800B05CC
    /* A0D20 800B0520 00000000 */   nop
    /* A0D24 800B0524 2B00C012 */  beqz       $s6, .L800B05D4
    /* A0D28 800B0528 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0D2C 800B052C 6EC10208 */  j          .L800B05B8
    /* A0D30 800B0530 00000000 */   nop
  jlabel .L800B0534
    /* A0D34 800B0534 1300C016 */  bnez       $s6, .L800B0584
    /* A0D38 800B0538 00000000 */   nop
    /* A0D3C 800B053C B808A28E */  lw         $v0, 0x8B8($s5)
    /* A0D40 800B0540 00000000 */  nop
    /* A0D44 800B0544 24104600 */  and        $v0, $v0, $a2
    /* A0D48 800B0548 22004014 */  bnez       $v0, .L800B05D4
    /* A0D4C 800B054C FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0D50 800B0550 1180023C */  lui        $v0, %hi(R3DCar_SignalBrakeFlare)
    /* A0D54 800B0554 0C684224 */  addiu      $v0, $v0, %lo(R3DCar_SignalBrakeFlare)
    /* A0D58 800B0558 2110E202 */  addu       $v0, $s7, $v0
    /* A0D5C 800B055C 00004290 */  lbu        $v0, 0x0($v0)
    /* A0D60 800B0560 00000000 */  nop
    /* A0D64 800B0564 19004010 */  beqz       $v0, .L800B05CC
    /* A0D68 800B0568 00000000 */   nop
    /* A0D6C 800B056C B608A286 */  lh         $v0, 0x8B6($s5)
    /* A0D70 800B0570 00000000 */  nop
    /* A0D74 800B0574 18004014 */  bnez       $v0, .L800B05D8
    /* A0D78 800B0578 0600622C */   sltiu     $v0, $v1, 0x6
    /* A0D7C 800B057C 76C10208 */  j          .L800B05D8
    /* A0D80 800B0580 21280000 */   addu      $a1, $zero, $zero
  .L800B0584:
    /* A0D84 800B0584 B808A28E */  lw         $v0, 0x8B8($s5)
    /* A0D88 800B0588 00000000 */  nop
    /* A0D8C 800B058C 24104600 */  and        $v0, $v0, $a2
    /* A0D90 800B0590 0E004010 */  beqz       $v0, .L800B05CC
    /* A0D94 800B0594 00000000 */   nop
    /* A0D98 800B0598 6EC10208 */  j          .L800B05B8
    /* A0D9C 800B059C 00000000 */   nop
  jlabel .L800B05A0
    /* A0DA0 800B05A0 0C00C012 */  beqz       $s6, .L800B05D4
    /* A0DA4 800B05A4 FAFF8326 */   addiu     $v1, $s4, -0x6
    /* A0DA8 800B05A8 6EC10208 */  j          .L800B05B8
    /* A0DAC 800B05AC 00000000 */   nop
  jlabel .L800B05B0
    /* A0DB0 800B05B0 0600C012 */  beqz       $s6, .L800B05CC
    /* A0DB4 800B05B4 00000000 */   nop
  .L800B05B8:
    /* A0DB8 800B05B8 7E08A296 */  lhu        $v0, 0x87E($s5)
    /* A0DBC 800B05BC 00000000 */  nop
    /* A0DC0 800B05C0 04004230 */  andi       $v0, $v0, 0x4
  .L800B05C4:
    /* A0DC4 800B05C4 03004010 */  beqz       $v0, .L800B05D4
    /* A0DC8 800B05C8 FAFF8326 */   addiu     $v1, $s4, -0x6
  jlabel .L800B05CC
    /* A0DCC 800B05CC 21280000 */  addu       $a1, $zero, $zero
  jlabel .L800B05D0
    /* A0DD0 800B05D0 FAFF8326 */  addiu      $v1, $s4, -0x6
  .L800B05D4:
    /* A0DD4 800B05D4 0600622C */  sltiu      $v0, $v1, 0x6
  .L800B05D8:
    /* A0DD8 800B05D8 21004010 */  beqz       $v0, .L800B0660
    /* A0DDC 800B05DC 80100300 */   sll       $v0, $v1, 2
    /* A0DE0 800B05E0 21104700 */  addu       $v0, $v0, $a3
    /* A0DE4 800B05E4 0000428C */  lw         $v0, 0x0($v0)
    /* A0DE8 800B05E8 00000000 */  nop
    /* A0DEC 800B05EC 08004000 */  jr         $v0
    /* A0DF0 800B05F0 00000000 */   nop
  jlabel .L800B05F4
    /* A0DF4 800B05F4 7E08A296 */  lhu        $v0, 0x87E($s5)
    /* A0DF8 800B05F8 95C10208 */  j          .L800B0654
    /* A0DFC 800B05FC 18004230 */   andi      $v0, $v0, 0x18
  jlabel .L800B0600
    /* A0E00 800B0600 7E08A296 */  lhu        $v0, 0x87E($s5)
    /* A0E04 800B0604 00000000 */  nop
    /* A0E08 800B0608 04004230 */  andi       $v0, $v0, 0x4
    /* A0E0C 800B060C 14004010 */  beqz       $v0, .L800B0660
    /* A0E10 800B0610 1180023C */   lui       $v0, %hi(R3DCar_DamageSpoiler)
    /* A0E14 800B0614 60684224 */  addiu      $v0, $v0, %lo(R3DCar_DamageSpoiler)
    /* A0E18 800B0618 2110E202 */  addu       $v0, $s7, $v0
    /* A0E1C 800B061C B308A392 */  lbu        $v1, 0x8B3($s5)
    /* A0E20 800B0620 00004290 */  lbu        $v0, 0x0($v0)
    /* A0E24 800B0624 04006330 */  andi       $v1, $v1, 0x4
    /* A0E28 800B0628 02006014 */  bnez       $v1, .L800B0634
    /* A0E2C 800B062C 01004530 */   andi      $a1, $v0, 0x1
    /* A0E30 800B0630 80004530 */  andi       $a1, $v0, 0x80
  .L800B0634:
    /* A0E34 800B0634 00140500 */  sll        $v0, $a1, 16
    /* A0E38 800B0638 0A004010 */  beqz       $v0, .L800B0664
    /* A0E3C 800B063C 1180023C */   lui       $v0, %hi(R3DCar_ObjectVisible)
    /* A0E40 800B0640 99C10208 */  j          .L800B0664
    /* A0E44 800B0644 0B000524 */   addiu     $a1, $zero, 0xB
  jlabel .L800B0648
    /* A0E48 800B0648 7E08A296 */  lhu        $v0, 0x87E($s5)
    /* A0E4C 800B064C 00000000 */  nop
    /* A0E50 800B0650 04004230 */  andi       $v0, $v0, 0x4
  .L800B0654:
    /* A0E54 800B0654 03004010 */  beqz       $v0, .L800B0664
    /* A0E58 800B0658 1180023C */   lui       $v0, %hi(R3DCar_ObjectVisible)
    /* A0E5C 800B065C 21280000 */  addu       $a1, $zero, $zero
  .L800B0660:
    /* A0E60 800B0660 1180023C */  lui        $v0, %hi(R3DCar_ObjectVisible)
  .L800B0664:
    /* A0E64 800B0664 AC684224 */  addiu      $v0, $v0, %lo(R3DCar_ObjectVisible)
    /* A0E68 800B0668 21108202 */  addu       $v0, $s4, $v0
    /* A0E6C 800B066C 000045A0 */  sb         $a1, 0x0($v0)
    /* A0E70 800B0670 06008424 */  addiu      $a0, $a0, 0x6
    /* A0E74 800B0674 EBC00208 */  j          .L800B03AC
    /* A0E78 800B0678 01009426 */   addiu     $s4, $s4, 0x1
  .L800B067C:
    /* A0E7C 800B067C 1180023C */  lui        $v0, %hi(R3DCar_ObjectInfo)
    /* A0E80 800B0680 E0654924 */  addiu      $t1, $v0, %lo(R3DCar_ObjectInfo)
    /* A0E84 800B0684 12000824 */  addiu      $t0, $zero, 0x12
    /* A0E88 800B0688 01000724 */  addiu      $a3, $zero, 0x1
    /* A0E8C 800B068C 1180023C */  lui        $v0, %hi(R3DCar_ObjectVisible)
    /* A0E90 800B0690 AC684624 */  addiu      $a2, $v0, %lo(R3DCar_ObjectVisible)
    /* A0E94 800B0694 2120C003 */  addu       $a0, $fp, $zero
  .L800B0698:
    /* A0E98 800B0698 3900822A */  slti       $v0, $s4, 0x39
    /* A0E9C 800B069C 23004010 */  beqz       $v0, .L800B072C
    /* A0EA0 800B06A0 21108900 */   addu      $v0, $a0, $t1
    /* A0EA4 800B06A4 00004290 */  lbu        $v0, 0x0($v0)
    /* A0EA8 800B06A8 00000000 */  nop
    /* A0EAC 800B06AC 00160200 */  sll        $v0, $v0, 24
    /* A0EB0 800B06B0 032E0200 */  sra        $a1, $v0, 24
    /* A0EB4 800B06B4 2118A000 */  addu       $v1, $a1, $zero
    /* A0EB8 800B06B8 0C006810 */  beq        $v1, $t0, .L800B06EC
    /* A0EBC 800B06BC 13006228 */   slti      $v0, $v1, 0x13
    /* A0EC0 800B06C0 05004010 */  beqz       $v0, .L800B06D8
    /* A0EC4 800B06C4 16000224 */   addiu     $v0, $zero, 0x16
    /* A0EC8 800B06C8 0E006710 */  beq        $v1, $a3, .L800B0704
    /* A0ECC 800B06CC 1C000224 */   addiu     $v0, $zero, 0x1C
    /* A0ED0 800B06D0 C1C10208 */  j          .L800B0704
    /* A0ED4 800B06D4 21280000 */   addu      $a1, $zero, $zero
  .L800B06D8:
    /* A0ED8 800B06D8 08006214 */  bne        $v1, $v0, .L800B06FC
    /* A0EDC 800B06DC 00000000 */   nop
    /* A0EE0 800B06E0 B408A296 */  lhu        $v0, 0x8B4($s5)
    /* A0EE4 800B06E4 BCC10208 */  j          .L800B06F0
    /* A0EE8 800B06E8 11004230 */   andi      $v0, $v0, 0x11
  .L800B06EC:
    /* A0EEC 800B06EC B608A286 */  lh         $v0, 0x8B6($s5)
  .L800B06F0:
    /* A0EF0 800B06F0 00000000 */  nop
    /* A0EF4 800B06F4 03004014 */  bnez       $v0, .L800B0704
    /* A0EF8 800B06F8 1C000224 */   addiu     $v0, $zero, 0x1C
  .L800B06FC:
    /* A0EFC 800B06FC 21280000 */  addu       $a1, $zero, $zero
    /* A0F00 800B0700 1C000224 */  addiu      $v0, $zero, 0x1C
  .L800B0704:
    /* A0F04 800B0704 0500E216 */  bne        $s7, $v0, .L800B071C
    /* A0F08 800B0708 21108602 */   addu      $v0, $s4, $a2
    /* A0F0C 800B070C 20000224 */  addiu      $v0, $zero, 0x20
    /* A0F10 800B0710 02008216 */  bne        $s4, $v0, .L800B071C
    /* A0F14 800B0714 21108602 */   addu      $v0, $s4, $a2
    /* A0F18 800B0718 01000524 */  addiu      $a1, $zero, 0x1
  .L800B071C:
    /* A0F1C 800B071C 000045A0 */  sb         $a1, 0x0($v0)
    /* A0F20 800B0720 06008424 */  addiu      $a0, $a0, 0x6
    /* A0F24 800B0724 A6C10208 */  j          .L800B0698
    /* A0F28 800B0728 01009426 */   addiu     $s4, $s4, 0x1
  .L800B072C:
    /* A0F2C 800B072C 21A00000 */  addu       $s4, $zero, $zero
    /* A0F30 800B0730 1180043C */  lui        $a0, %hi(R3DCar_LoadedScenePointer)
    /* A0F34 800B0734 08698424 */  addiu      $a0, $a0, %lo(R3DCar_LoadedScenePointer)
    /* A0F38 800B0738 B401AB8F */  lw         $t3, 0x1B4($sp)
    /* A0F3C 800B073C 80181700 */  sll        $v1, $s7, 2
    /* A0F40 800B0740 40100B00 */  sll        $v0, $t3, 1
    /* A0F44 800B0744 21104B00 */  addu       $v0, $v0, $t3
    /* A0F48 800B0748 C0100200 */  sll        $v0, $v0, 3
    /* A0F4C 800B074C 21104B00 */  addu       $v0, $v0, $t3
    /* A0F50 800B0750 C0100200 */  sll        $v0, $v0, 3
    /* A0F54 800B0754 21186200 */  addu       $v1, $v1, $v0
    /* A0F58 800B0758 21186400 */  addu       $v1, $v1, $a0
    /* A0F5C 800B075C 0000628C */  lw         $v0, 0x0($v1)
    /* A0F60 800B0760 EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A0F64 800B0764 0000458C */  lw         $a1, 0x0($v0)
    /* A0F68 800B0768 44006B25 */  addiu      $t3, $t3, 0x44
    /* A0F6C 800B076C BC01ABAF */  sw         $t3, 0x1BC($sp)
    /* A0F70 800B0770 0400A28C */  lw         $v0, 0x4($a1)
    /* A0F74 800B0774 F000B227 */  addiu      $s2, $sp, 0xF0
    /* A0F78 800B0778 1800A2AF */  sw         $v0, 0x18($sp)
    /* A0F7C 800B077C 0800A28C */  lw         $v0, 0x8($a1)
    /* A0F80 800B0780 6001BE27 */  addiu      $fp, $sp, 0x160
    /* A0F84 800B0784 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* A0F88 800B0788 0C00A28C */  lw         $v0, 0xC($a1)
    /* A0F8C 800B078C 21B08002 */  addu       $s6, $s4, $zero
    /* A0F90 800B0790 2000A2AF */  sw         $v0, 0x20($sp)
  .L800B0794:
    /* A0F94 800B0794 3900822A */  slti       $v0, $s4, 0x39
    /* A0F98 800B0798 14014010 */  beqz       $v0, .L800B0BEC
    /* A0F9C 800B079C 80181700 */   sll       $v1, $s7, 2
    /* A0FA0 800B07A0 B401AB8F */  lw         $t3, 0x1B4($sp)
    /* A0FA4 800B07A4 00000000 */  nop
    /* A0FA8 800B07A8 40100B00 */  sll        $v0, $t3, 1
    /* A0FAC 800B07AC 21104B00 */  addu       $v0, $v0, $t3
    /* A0FB0 800B07B0 C0100200 */  sll        $v0, $v0, 3
    /* A0FB4 800B07B4 21104B00 */  addu       $v0, $v0, $t3
    /* A0FB8 800B07B8 C0100200 */  sll        $v0, $v0, 3
    /* A0FBC 800B07BC 21186200 */  addu       $v1, $v1, $v0
    /* A0FC0 800B07C0 11800B3C */  lui        $t3, %hi(R3DCar_LoadedScenePointer)
    /* A0FC4 800B07C4 08696B25 */  addiu      $t3, $t3, %lo(R3DCar_LoadedScenePointer)
    /* A0FC8 800B07C8 21186B00 */  addu       $v1, $v1, $t3
    /* A0FCC 800B07CC 0000628C */  lw         $v0, 0x0($v1)
    /* A0FD0 800B07D0 80181400 */  sll        $v1, $s4, 2
    /* A0FD4 800B07D4 21104300 */  addu       $v0, $v0, $v1
    /* A0FD8 800B07D8 0000458C */  lw         $a1, 0x0($v0)
    /* A0FDC 800B07DC 00000000 */  nop
    /* A0FE0 800B07E0 0200A294 */  lhu        $v0, 0x2($a1)
    /* A0FE4 800B07E4 00000000 */  nop
    /* A0FE8 800B07E8 FD004010 */  beqz       $v0, .L800B0BE0
    /* A0FEC 800B07EC 1180023C */   lui       $v0, %hi(R3DCar_ObjectVisible)
    /* A0FF0 800B07F0 AC684224 */  addiu      $v0, $v0, %lo(R3DCar_ObjectVisible)
    /* A0FF4 800B07F4 21108202 */  addu       $v0, $s4, $v0
    /* A0FF8 800B07F8 00004290 */  lbu        $v0, 0x0($v0)
    /* A0FFC 800B07FC 00000000 */  nop
    /* A1000 800B0800 F7004010 */  beqz       $v0, .L800B0BE0
    /* A1004 800B0804 2F00822A */   slti      $v0, $s4, 0x2F
    /* A1008 800B0808 1A004014 */  bnez       $v0, .L800B0874
    /* A100C 800B080C 1180033C */   lui       $v1, %hi(R3DCar_Suspension)
    /* A1010 800B0810 38676324 */  addiu      $v1, $v1, %lo(R3DCar_Suspension)
    /* A1014 800B0814 D1FF8226 */  addiu      $v0, $s4, -0x2F
    /* A1018 800B0818 40100200 */  sll        $v0, $v0, 1
    /* A101C 800B081C 21104300 */  addu       $v0, $v0, $v1
    /* A1020 800B0820 00004384 */  lh         $v1, 0x0($v0)
    /* A1024 800B0824 00000000 */  nop
    /* A1028 800B0828 40100300 */  sll        $v0, $v1, 1
    /* A102C 800B082C 21104300 */  addu       $v0, $v0, $v1
    /* A1030 800B0830 00110200 */  sll        $v0, $v0, 4
    /* A1034 800B0834 2110A202 */  addu       $v0, $s5, $v0
    /* A1038 800B0838 B402448C */  lw         $a0, 0x2B4($v0)
    /* A103C 800B083C 00000000 */  nop
    /* A1040 800B0840 05008018 */  blez       $a0, .L800B0858
    /* A1044 800B0844 B91E8228 */   slti      $v0, $a0, 0x1EB9
    /* A1048 800B0848 0E004014 */  bnez       $v0, .L800B0884
    /* A104C 800B084C 00000000 */   nop
    /* A1050 800B0850 21C20208 */  j          .L800B0884
    /* A1054 800B0854 B81E0424 */   addiu     $a0, $zero, 0x1EB8
  .L800B0858:
    /* A1058 800B0858 48E10324 */  addiu      $v1, $zero, -0x1EB8
    /* A105C 800B085C 2A108300 */  slt        $v0, $a0, $v1
    /* A1060 800B0860 02004014 */  bnez       $v0, .L800B086C
    /* A1064 800B0864 00000000 */   nop
    /* A1068 800B0868 21188000 */  addu       $v1, $a0, $zero
  .L800B086C:
    /* A106C 800B086C 21C20208 */  j          .L800B0884
    /* A1070 800B0870 21206000 */   addu      $a0, $v1, $zero
  .L800B0874:
    /* A1074 800B0874 5808A28E */  lw         $v0, 0x858($s5)
    /* A1078 800B0878 B001AB8F */  lw         $t3, 0x1B0($sp)
    /* A107C 800B087C 00000000 */  nop
    /* A1080 800B0880 23206201 */  subu       $a0, $t3, $v0
  .L800B0884:
    /* A1084 800B0884 0400A28C */  lw         $v0, 0x4($a1)
    /* A1088 800B0888 1800A38F */  lw         $v1, 0x18($sp)
    /* A108C 800B088C 00000000 */  nop
    /* A1090 800B0890 23104300 */  subu       $v0, $v0, $v1
    /* A1094 800B0894 2801A2AF */  sw         $v0, 0x128($sp)
    /* A1098 800B0898 0800A28C */  lw         $v0, 0x8($a1)
    /* A109C 800B089C 1C00A38F */  lw         $v1, 0x1C($sp)
    /* A10A0 800B08A0 00000000 */  nop
    /* A10A4 800B08A4 23104300 */  subu       $v0, $v0, $v1
    /* A10A8 800B08A8 23104400 */  subu       $v0, $v0, $a0
    /* A10AC 800B08AC 2C01A2AF */  sw         $v0, 0x12C($sp)
    /* A10B0 800B08B0 0C00A28C */  lw         $v0, 0xC($a1)
    /* A10B4 800B08B4 2000A38F */  lw         $v1, 0x20($sp)
    /* A10B8 800B08B8 00000000 */  nop
    /* A10BC 800B08BC 23104300 */  subu       $v0, $v0, $v1
    /* A10C0 800B08C0 3001A2AF */  sw         $v0, 0x130($sp)
    /* A10C4 800B08C4 2F00822A */  slti       $v0, $s4, 0x2F
    /* A10C8 800B08C8 0D004010 */  beqz       $v0, .L800B0900
    /* A10CC 800B08CC 1C00E22A */   slti      $v0, $s7, 0x1C
    /* A10D0 800B08D0 08004010 */  beqz       $v0, .L800B08F4
    /* A10D4 800B08D4 2300822A */   slti      $v0, $s4, 0x23
    /* A10D8 800B08D8 07004014 */  bnez       $v0, .L800B08F8
    /* A10DC 800B08DC 2801A427 */   addiu     $a0, $sp, 0x128
    /* A10E0 800B08E0 2900822A */  slti       $v0, $s4, 0x29
    /* A10E4 800B08E4 04004010 */  beqz       $v0, .L800B08F8
    /* A10E8 800B08E8 7800A527 */   addiu     $a1, $sp, 0x78
    /* A10EC 800B08EC 42C20208 */  j          .L800B0908
    /* A10F0 800B08F0 00000000 */   nop
  .L800B08F4:
    /* A10F4 800B08F4 2801A427 */  addiu      $a0, $sp, 0x128
  .L800B08F8:
    /* A10F8 800B08F8 42C20208 */  j          .L800B0908
    /* A10FC 800B08FC 2800A527 */   addiu     $a1, $sp, 0x28
  .L800B0900:
    /* A1100 800B0900 2801A427 */  addiu      $a0, $sp, 0x128
    /* A1104 800B0904 F000A526 */  addiu      $a1, $s5, 0xF0
  .L800B0908:
    /* A1108 800B0908 B6AB030C */  jal        transform
    /* A110C 800B090C 1801A627 */   addiu     $a2, $sp, 0x118
    /* A1110 800B0910 2801A427 */  addiu      $a0, $sp, 0x128
    /* A1114 800B0914 40301400 */  sll        $a2, $s4, 1
    /* A1118 800B0918 2130D400 */  addu       $a2, $a2, $s4
    /* A111C 800B091C 80300600 */  sll        $a2, $a2, 2
    /* A1120 800B0920 BC01A58F */  lw         $a1, 0x1BC($sp)
    /* A1124 800B0924 400E828F */  lw         $v0, %gp_rel(R3DCar_position)($gp)
    /* A1128 800B0928 1801A38F */  lw         $v1, 0x118($sp)
    /* A112C 800B092C EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A1130 800B0930 21304600 */  addu       $a2, $v0, $a2
    /* A1134 800B0934 A000A28E */  lw         $v0, 0xA0($s5)
    /* A1138 800B0938 0800678D */  lw         $a3, 0x8($t3)
    /* A113C 800B093C 21104300 */  addu       $v0, $v0, $v1
    /* A1140 800B0940 23104700 */  subu       $v0, $v0, $a3
    /* A1144 800B0944 2801A2AF */  sw         $v0, 0x128($sp)
    /* A1148 800B0948 A400A28E */  lw         $v0, 0xA4($s5)
    /* A114C 800B094C 1C01A38F */  lw         $v1, 0x11C($sp)
    /* A1150 800B0950 0C00678D */  lw         $a3, 0xC($t3)
    /* A1154 800B0954 21104300 */  addu       $v0, $v0, $v1
    /* A1158 800B0958 23104700 */  subu       $v0, $v0, $a3
    /* A115C 800B095C 2C01A2AF */  sw         $v0, 0x12C($sp)
    /* A1160 800B0960 A800A28E */  lw         $v0, 0xA8($s5)
    /* A1164 800B0964 2001A38F */  lw         $v1, 0x120($sp)
    /* A1168 800B0968 1000678D */  lw         $a3, 0x10($t3)
    /* A116C 800B096C 21104300 */  addu       $v0, $v0, $v1
    /* A1170 800B0970 23104700 */  subu       $v0, $v0, $a3
    /* A1174 800B0974 B6AB030C */  jal        transform
    /* A1178 800B0978 3001A2AF */   sw        $v0, 0x130($sp)
    /* A117C 800B097C 1C000224 */  addiu      $v0, $zero, 0x1C
    /* A1180 800B0980 2400E216 */  bne        $s7, $v0, .L800B0A14
    /* A1184 800B0984 DDFF8326 */   addiu     $v1, $s4, -0x23
    /* A1188 800B0988 1F000224 */  addiu      $v0, $zero, 0x1F
    /* A118C 800B098C 05008212 */  beq        $s4, $v0, .L800B09A4
    /* A1190 800B0990 23000224 */   addiu     $v0, $zero, 0x23
    /* A1194 800B0994 11008212 */  beq        $s4, $v0, .L800B09DC
    /* A1198 800B0998 00000000 */   nop
    /* A119C 800B099C F4C20208 */  j          .L800B0BD0
    /* A11A0 800B09A0 00000000 */   nop
  .L800B09A4:
    /* A11A4 800B09A4 D000A58E */  lw         $a1, 0xD0($s5)
    /* A11A8 800B09A8 04AB030C */  jal        fixedxformy
    /* A11AC 800B09AC 21204002 */   addu      $a0, $s2, $zero
    /* A11B0 800B09B0 21204002 */  addu       $a0, $s2, $zero
    /* A11B4 800B09B4 2800A527 */  addiu      $a1, $sp, 0x28
    /* A11B8 800B09B8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A11BC 800B09BC 21304002 */   addu      $a2, $s2, $zero
    /* A11C0 800B09C0 21204002 */  addu       $a0, $s2, $zero
    /* A11C4 800B09C4 3C0E868F */  lw         $a2, %gp_rel(R3DCar_orientMat)($gp)
    /* A11C8 800B09C8 BC01A58F */  lw         $a1, 0x1BC($sp)
    /* A11CC 800B09CC 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A11D0 800B09D0 5C04C624 */   addiu     $a2, $a2, 0x45C
    /* A11D4 800B09D4 F9C20208 */  j          .L800B0BE4
    /* A11D8 800B09D8 2400D626 */   addiu     $s6, $s6, 0x24
  .L800B09DC:
    /* A11DC 800B09DC D400A58E */  lw         $a1, 0xD4($s5)
    /* A11E0 800B09E0 EBAA030C */  jal        fixedxformx
    /* A11E4 800B09E4 21204002 */   addu      $a0, $s2, $zero
    /* A11E8 800B09E8 21204002 */  addu       $a0, $s2, $zero
    /* A11EC 800B09EC 2800A527 */  addiu      $a1, $sp, 0x28
    /* A11F0 800B09F0 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A11F4 800B09F4 21304002 */   addu      $a2, $s2, $zero
    /* A11F8 800B09F8 21204002 */  addu       $a0, $s2, $zero
    /* A11FC 800B09FC 3C0E868F */  lw         $a2, %gp_rel(R3DCar_orientMat)($gp)
    /* A1200 800B0A00 BC01A58F */  lw         $a1, 0x1BC($sp)
    /* A1204 800B0A04 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A1208 800B0A08 EC04C624 */   addiu     $a2, $a2, 0x4EC
    /* A120C 800B0A0C F9C20208 */  j          .L800B0BE4
    /* A1210 800B0A10 2400D626 */   addiu     $s6, $s6, 0x24
  .L800B0A14:
    /* A1214 800B0A14 1600622C */  sltiu      $v0, $v1, 0x16
    /* A1218 800B0A18 6D004010 */  beqz       $v0, .L800B0BD0
    /* A121C 800B0A1C 0580023C */   lui       $v0, %hi(jtbl_80056488)
    /* A1220 800B0A20 88644224 */  addiu      $v0, $v0, %lo(jtbl_80056488)
    /* A1224 800B0A24 80180300 */  sll        $v1, $v1, 2
    /* A1228 800B0A28 21186200 */  addu       $v1, $v1, $v0
    /* A122C 800B0A2C 0000628C */  lw         $v0, 0x0($v1)
    /* A1230 800B0A30 00000000 */  nop
    /* A1234 800B0A34 08004000 */  jr         $v0
    /* A1238 800B0A38 00000000 */   nop
  jlabel .L800B0A3C
    /* A123C 800B0A3C D000A58E */  lw         $a1, 0xD0($s5)
    /* A1240 800B0A40 EBAA030C */  jal        fixedxformx
    /* A1244 800B0A44 21204002 */   addu      $a0, $s2, $zero
    /* A1248 800B0A48 21204002 */  addu       $a0, $s2, $zero
    /* A124C 800B0A4C C800A527 */  addiu      $a1, $sp, 0xC8
    /* A1250 800B0A50 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A1254 800B0A54 21304002 */   addu      $a2, $s2, $zero
    /* A1258 800B0A58 21204002 */  addu       $a0, $s2, $zero
    /* A125C 800B0A5C EAC20208 */  j          .L800B0BA8
    /* A1260 800B0A60 F000A526 */   addiu     $a1, $s5, 0xF0
  jlabel .L800B0A64
    /* A1264 800B0A64 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A1268 800B0A68 F6C20208 */  j          .L800B0BD8
    /* A126C 800B0A6C 9C06A424 */   addiu     $a0, $a1, 0x69C
  jlabel .L800B0A70
    /* A1270 800B0A70 D400A58E */  lw         $a1, 0xD4($s5)
    /* A1274 800B0A74 EBAA030C */  jal        fixedxformx
    /* A1278 800B0A78 21204002 */   addu      $a0, $s2, $zero
    /* A127C 800B0A7C 21204002 */  addu       $a0, $s2, $zero
    /* A1280 800B0A80 EAC20208 */  j          .L800B0BA8
    /* A1284 800B0A84 F000A526 */   addiu     $a1, $s5, 0xF0
  jlabel .L800B0A88
    /* A1288 800B0A88 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A128C 800B0A8C F6C20208 */  j          .L800B0BD8
    /* A1290 800B0A90 7407A424 */   addiu     $a0, $a1, 0x774
  jlabel .L800B0A94
    /* A1294 800B0A94 D400A58E */  lw         $a1, 0xD4($s5)
    /* A1298 800B0A98 EBAA030C */  jal        fixedxformx
    /* A129C 800B0A9C 21204002 */   addu      $a0, $s2, $zero
    /* A12A0 800B0AA0 21204002 */  addu       $a0, $s2, $zero
    /* A12A4 800B0AA4 EAC20208 */  j          .L800B0BA8
    /* A12A8 800B0AA8 F000A526 */   addiu     $a1, $s5, 0xF0
  jlabel .L800B0AAC
    /* A12AC 800B0AAC 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A12B0 800B0AB0 F6C20208 */  j          .L800B0BD8
    /* A12B4 800B0AB4 BC07A424 */   addiu     $a0, $a1, 0x7BC
  jlabel .L800B0AB8
    /* A12B8 800B0AB8 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A12BC 800B0ABC F6C20208 */  j          .L800B0BD8
    /* A12C0 800B0AC0 A000A427 */   addiu     $a0, $sp, 0xA0
  jlabel .L800B0AC4
    /* A12C4 800B0AC4 B801AB8F */  lw         $t3, 0x1B8($sp)
    /* A12C8 800B0AC8 5004A28E */  lw         $v0, 0x450($s5)
    /* A12CC 800B0ACC 02006011 */  beqz       $t3, .L800B0AD8
    /* A12D0 800B0AD0 21204002 */   addu      $a0, $s2, $zero
    /* A12D4 800B0AD4 23100200 */  negu       $v0, $v0
  .L800B0AD8:
    /* A12D8 800B0AD8 C0280200 */  sll        $a1, $v0, 3
    /* A12DC 800B0ADC 2328A200 */  subu       $a1, $a1, $v0
    /* A12E0 800B0AE0 C0280500 */  sll        $a1, $a1, 3
    /* A12E4 800B0AE4 1DAB030C */  jal        fixedxformz
    /* A12E8 800B0AE8 23280500 */   negu      $a1, $a1
    /* A12EC 800B0AEC E9C20208 */  j          .L800B0BA4
    /* A12F0 800B0AF0 21204002 */   addu      $a0, $s2, $zero
  jlabel .L800B0AF4
    /* A12F4 800B0AF4 4C08A28E */  lw         $v0, 0x84C($s5)
    /* A12F8 800B0AF8 B801AB8F */  lw         $t3, 0x1B8($sp)
    /* A12FC 800B0AFC 40180200 */  sll        $v1, $v0, 1
    /* A1300 800B0B00 21186200 */  addu       $v1, $v1, $v0
    /* A1304 800B0B04 4808A28E */  lw         $v0, 0x848($s5)
    /* A1308 800B0B08 43280300 */  sra        $a1, $v1, 1
    /* A130C 800B0B0C 02006011 */  beqz       $t3, .L800B0B18
    /* A1310 800B0B10 C0880200 */   sll       $s1, $v0, 3
    /* A1314 800B0B14 23280500 */  negu       $a1, $a1
  .L800B0B18:
    /* A1318 800B0B18 1DAB030C */  jal        fixedxformz
    /* A131C 800B0B1C 2120C003 */   addu      $a0, $fp, $zero
    /* A1320 800B0B20 8801B027 */  addiu      $s0, $sp, 0x188
    /* A1324 800B0B24 21200002 */  addu       $a0, $s0, $zero
    /* A1328 800B0B28 EBAA030C */  jal        fixedxformx
    /* A132C 800B0B2C 21282002 */   addu      $a1, $s1, $zero
    /* A1330 800B0B30 2120C003 */  addu       $a0, $fp, $zero
    /* A1334 800B0B34 E6C20208 */  j          .L800B0B98
    /* A1338 800B0B38 21280002 */   addu      $a1, $s0, $zero
  jlabel .L800B0B3C
    /* A133C 800B0B3C B801AB8F */  lw         $t3, 0x1B8($sp)
    /* A1340 800B0B40 5004B08E */  lw         $s0, 0x450($s5)
    /* A1344 800B0B44 02006011 */  beqz       $t3, .L800B0B50
    /* A1348 800B0B48 F4FF1124 */   addiu     $s1, $zero, -0xC
    /* A134C 800B0B4C 23801000 */  negu       $s0, $s0
  .L800B0B50:
    /* A1350 800B0B50 27000224 */  addiu      $v0, $zero, 0x27
    /* A1354 800B0B54 03008216 */  bne        $s4, $v0, .L800B0B64
    /* A1358 800B0B58 18001102 */   mult      $s0, $s1
    /* A135C 800B0B5C 0C001124 */  addiu      $s1, $zero, 0xC
    /* A1360 800B0B60 18001102 */  mult       $s0, $s1
  .L800B0B64:
    /* A1364 800B0B64 3801B327 */  addiu      $s3, $sp, 0x138
    /* A1368 800B0B68 12280000 */  mflo       $a1
    /* A136C 800B0B6C EBAA030C */  jal        fixedxformx
    /* A1370 800B0B70 21206002 */   addu      $a0, $s3, $zero
    /* A1374 800B0B74 0200001A */  blez       $s0, .L800B0B80
    /* A1378 800B0B78 43281100 */   sra       $a1, $s1, 1
    /* A137C 800B0B7C 23801000 */  negu       $s0, $s0
  .L800B0B80:
    /* A1380 800B0B80 18000502 */  mult       $s0, $a1
    /* A1384 800B0B84 12280000 */  mflo       $a1
    /* A1388 800B0B88 04AB030C */  jal        fixedxformy
    /* A138C 800B0B8C 2120C003 */   addu      $a0, $fp, $zero
    /* A1390 800B0B90 21206002 */  addu       $a0, $s3, $zero
    /* A1394 800B0B94 2128C003 */  addu       $a1, $fp, $zero
  .L800B0B98:
    /* A1398 800B0B98 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A139C 800B0B9C 21304002 */   addu      $a2, $s2, $zero
    /* A13A0 800B0BA0 21204002 */  addu       $a0, $s2, $zero
  .L800B0BA4:
    /* A13A4 800B0BA4 7800A527 */  addiu      $a1, $sp, 0x78
  .L800B0BA8:
    /* A13A8 800B0BA8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A13AC 800B0BAC 21304002 */   addu      $a2, $s2, $zero
    /* A13B0 800B0BB0 21204002 */  addu       $a0, $s2, $zero
    /* A13B4 800B0BB4 EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A13B8 800B0BB8 3C0E868F */  lw         $a2, %gp_rel(R3DCar_orientMat)($gp)
    /* A13BC 800B0BBC 44006525 */  addiu      $a1, $t3, 0x44
    /* A13C0 800B0BC0 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* A13C4 800B0BC4 2130D600 */   addu      $a2, $a2, $s6
    /* A13C8 800B0BC8 F9C20208 */  j          .L800B0BE4
    /* A13CC 800B0BCC 2400D626 */   addiu     $s6, $s6, 0x24
  jlabel .L800B0BD0
    /* A13D0 800B0BD0 3C0E858F */  lw         $a1, %gp_rel(R3DCar_orientMat)($gp)
    /* A13D4 800B0BD4 5000A427 */  addiu      $a0, $sp, 0x50
  .L800B0BD8:
    /* A13D8 800B0BD8 EABE020C */  jal        R3DCar_MATRIX3DT_Copy__FPiT0
    /* A13DC 800B0BDC 2128B600 */   addu      $a1, $a1, $s6
  .L800B0BE0:
    /* A13E0 800B0BE0 2400D626 */  addiu      $s6, $s6, 0x24
  .L800B0BE4:
    /* A13E4 800B0BE4 E5C10208 */  j          .L800B0794
    /* A13E8 800B0BE8 01009426 */   addiu     $s4, $s4, 0x1
  .L800B0BEC:
    /* A13EC 800B0BEC 01000624 */  addiu      $a2, $zero, 0x1
    /* A13F0 800B0BF0 A000A726 */  addiu      $a3, $s5, 0xA0
    /* A13F4 800B0BF4 EC01AB8F */  lw         $t3, 0x1EC($sp)
    /* A13F8 800B0BF8 1480023C */  lui        $v0, %hi(R3DCar_center)
    /* A13FC 800B0BFC 90D34224 */  addiu      $v0, $v0, %lo(R3DCar_center)
    /* A1400 800B0C00 1000A2AF */  sw         $v0, 0x10($sp)
    /* A1404 800B0C04 44007125 */  addiu      $s1, $t3, 0x44
    /* A1408 800B0C08 21202002 */  addu       $a0, $s1, $zero
    /* A140C 800B0C0C 38007025 */  addiu      $s0, $t3, 0x38
    /* A1410 800B0C10 3887030C */  jal        TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
    /* A1414 800B0C14 21280002 */   addu      $a1, $s0, $zero
    /* A1418 800B0C18 500E8293 */  lbu        $v0, %gp_rel(R3DCar_shadowColour)($gp)
    /* A141C 800B0C1C 00000000 */  nop
    /* A1420 800B0C20 14004010 */  beqz       $v0, .L800B0C74
    /* A1424 800B0C24 00000000 */   nop
    /* A1428 800B0C28 9000A292 */  lbu        $v0, 0x90($s5)
    /* A142C 800B0C2C 00000000 */  nop
    /* A1430 800B0C30 10004014 */  bnez       $v0, .L800B0C74
    /* A1434 800B0C34 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* A1438 800B0C38 B0E0458C */  lw         $a1, %lo(D_8011E0B0)($v0)
    /* A143C 800B0C3C A389020C */  jal        Newton_CalcRealShadowCoordinates__FP8Car_tObji
    /* A1440 800B0C40 2120A002 */   addu      $a0, $s5, $zero
    /* A1444 800B0C44 21202002 */  addu       $a0, $s1, $zero
    /* A1448 800B0C48 21280002 */  addu       $a1, $s0, $zero
    /* A144C 800B0C4C 04000624 */  addiu      $a2, $zero, 0x4
    /* A1450 800B0C50 E801A726 */  addiu      $a3, $s5, 0x1E8
    /* A1454 800B0C54 1180023C */  lui        $v0, %hi(R3DCar_shadowVertex)
    /* A1458 800B0C58 E8684224 */  addiu      $v0, $v0, %lo(R3DCar_shadowVertex)
    /* A145C 800B0C5C 3887030C */  jal        TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex
    /* A1460 800B0C60 1000A2AF */   sw        $v0, 0x10($sp)
    /* A1464 800B0C64 01000224 */  addiu      $v0, $zero, 0x1
    /* A1468 800B0C68 4C0E82AF */  sw         $v0, %gp_rel(R3DCar_shadowFlag)($gp)
    /* A146C 800B0C6C 1FC30208 */  j          .L800B0C7C
    /* A1470 800B0C70 1280023C */   lui       $v0, %hi(simVar)
  .L800B0C74:
    /* A1474 800B0C74 4C0E80AF */  sw         $zero, %gp_rel(R3DCar_shadowFlag)($gp)
    /* A1478 800B0C78 1280023C */  lui        $v0, %hi(simVar)
  .L800B0C7C:
    /* A147C 800B0C7C C4E04324 */  addiu      $v1, $v0, %lo(simVar)
    /* A1480 800B0C80 0800628C */  lw         $v0, 0x8($v1)
    /* A1484 800B0C84 00000000 */  nop
    /* A1488 800B0C88 18004014 */  bnez       $v0, .L800B0CEC
    /* A148C 800B0C8C 00000000 */   nop
    /* A1490 800B0C90 1000628C */  lw         $v0, 0x10($v1)
    /* A1494 800B0C94 00000000 */  nop
    /* A1498 800B0C98 14004014 */  bnez       $v0, .L800B0CEC
    /* A149C 800B0C9C 02000224 */   addiu     $v0, $zero, 0x2
    /* A14A0 800B0CA0 1480033C */  lui        $v1, %hi(Replay_ReplayMode)
    /* A14A4 800B0CA4 F4D3638C */  lw         $v1, %lo(Replay_ReplayMode)($v1)
    /* A14A8 800B0CA8 00000000 */  nop
    /* A14AC 800B0CAC 07006210 */  beq        $v1, $v0, .L800B0CCC
    /* A14B0 800B0CB0 1180023C */   lui       $v0, %hi(D_80117030)
    /* A14B4 800B0CB4 2204A386 */  lh         $v1, 0x422($s5)
    /* A14B8 800B0CB8 C800A296 */  lhu        $v0, 0xC8($s5)
    /* A14BC 800B0CBC 00000000 */  nop
    /* A14C0 800B0CC0 21104300 */  addu       $v0, $v0, $v1
    /* A14C4 800B0CC4 3BC30208 */  j          .L800B0CEC
    /* A14C8 800B0CC8 C800A2A6 */   sh        $v0, 0xC8($s5)
  .L800B0CCC:
    /* A14CC 800B0CCC 3070428C */  lw         $v0, %lo(D_80117030)($v0)
    /* A14D0 800B0CD0 12000424 */  addiu      $a0, $zero, 0x12
    /* A14D4 800B0CD4 23208200 */  subu       $a0, $a0, $v0
    /* A14D8 800B0CD8 2004A28E */  lw         $v0, 0x420($s5)
    /* A14DC 800B0CDC C800A396 */  lhu        $v1, 0xC8($s5)
    /* A14E0 800B0CE0 07108200 */  srav       $v0, $v0, $a0
    /* A14E4 800B0CE4 21186200 */  addu       $v1, $v1, $v0
    /* A14E8 800B0CE8 C800A3A6 */  sh         $v1, 0xC8($s5)
  .L800B0CEC:
    /* A14EC 800B0CEC 1480043C */  lui        $a0, %hi(DrawC_gEnvMapMax)
    /* A14F0 800B0CF0 F8D7848C */  lw         $a0, %lo(DrawC_gEnvMapMax)($a0)
    /* A14F4 800B0CF4 00000000 */  nop
    /* A14F8 800B0CF8 0E008018 */  blez       $a0, .L800B0D34
    /* A14FC 800B0CFC 21A00000 */   addu      $s4, $zero, $zero
    /* A1500 800B0D00 0800A586 */  lh         $a1, 0x8($s5)
    /* A1504 800B0D04 1480033C */  lui        $v1, %hi(DrawC_gEnvMap)
    /* A1508 800B0D08 F0D7638C */  lw         $v1, %lo(DrawC_gEnvMap)($v1)
  .L800B0D0C:
    /* A150C 800B0D0C 00000000 */  nop
    /* A1510 800B0D10 00006284 */  lh         $v0, 0x0($v1)
    /* A1514 800B0D14 00000000 */  nop
    /* A1518 800B0D18 2A10A200 */  slt        $v0, $a1, $v0
    /* A151C 800B0D1C 05004014 */  bnez       $v0, .L800B0D34
    /* A1520 800B0D20 00000000 */   nop
    /* A1524 800B0D24 01009426 */  addiu      $s4, $s4, 0x1
    /* A1528 800B0D28 2A108402 */  slt        $v0, $s4, $a0
    /* A152C 800B0D2C F7FF4014 */  bnez       $v0, .L800B0D0C
    /* A1530 800B0D30 06006324 */   addiu     $v1, $v1, 0x6
  .L800B0D34:
    /* A1534 800B0D34 1480043C */  lui        $a0, %hi(DrawC_gShadowMax)
    /* A1538 800B0D38 FCD7848C */  lw         $a0, %lo(DrawC_gShadowMax)($a0)
    /* A153C 800B0D3C CA00B4A6 */  sh         $s4, 0xCA($s5)
    /* A1540 800B0D40 0E008018 */  blez       $a0, .L800B0D7C
    /* A1544 800B0D44 21A00000 */   addu      $s4, $zero, $zero
    /* A1548 800B0D48 0800A586 */  lh         $a1, 0x8($s5)
    /* A154C 800B0D4C 1480033C */  lui        $v1, %hi(DrawC_gShadow)
    /* A1550 800B0D50 F4D7638C */  lw         $v1, %lo(DrawC_gShadow)($v1)
  .L800B0D54:
    /* A1554 800B0D54 00000000 */  nop
    /* A1558 800B0D58 00006284 */  lh         $v0, 0x0($v1)
    /* A155C 800B0D5C 00000000 */  nop
    /* A1560 800B0D60 2A10A200 */  slt        $v0, $a1, $v0
    /* A1564 800B0D64 05004014 */  bnez       $v0, .L800B0D7C
    /* A1568 800B0D68 00000000 */   nop
    /* A156C 800B0D6C 01009426 */  addiu      $s4, $s4, 0x1
    /* A1570 800B0D70 2A108402 */  slt        $v0, $s4, $a0
    /* A1574 800B0D74 F7FF4014 */  bnez       $v0, .L800B0D54
    /* A1578 800B0D78 06006324 */   addiu     $v1, $v1, 0x6
  .L800B0D7C:
    /* A157C 800B0D7C CC00B4A6 */  sh         $s4, 0xCC($s5)
  .L800B0D80:
    /* A1580 800B0D80 E401BF8F */  lw         $ra, 0x1E4($sp)
    /* A1584 800B0D84 E001BE8F */  lw         $fp, 0x1E0($sp)
    /* A1588 800B0D88 DC01B78F */  lw         $s7, 0x1DC($sp)
    /* A158C 800B0D8C D801B68F */  lw         $s6, 0x1D8($sp)
    /* A1590 800B0D90 D401B58F */  lw         $s5, 0x1D4($sp)
    /* A1594 800B0D94 D001B48F */  lw         $s4, 0x1D0($sp)
    /* A1598 800B0D98 CC01B38F */  lw         $s3, 0x1CC($sp)
    /* A159C 800B0D9C C801B28F */  lw         $s2, 0x1C8($sp)
    /* A15A0 800B0DA0 C401B18F */  lw         $s1, 0x1C4($sp)
    /* A15A4 800B0DA4 C001B08F */  lw         $s0, 0x1C0($sp)
    /* A15A8 800B0DA8 0800E003 */  jr         $ra
    /* A15AC 800B0DAC E801BD27 */   addiu     $sp, $sp, 0x1E8
endlabel R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView
