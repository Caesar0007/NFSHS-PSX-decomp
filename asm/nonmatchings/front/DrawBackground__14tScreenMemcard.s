.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__14tScreenMemcard, 0x668

glabel DrawBackground__14tScreenMemcard
    /* 37C70 80047470 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 37C74 80047474 5400B7AF */  sw         $s7, 0x54($sp)
    /* 37C78 80047478 21B88000 */  addu       $s7, $a0, $zero
    /* 37C7C 8004747C 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 37C80 80047480 5800BEAF */  sw         $fp, 0x58($sp)
    /* 37C84 80047484 5000B6AF */  sw         $s6, 0x50($sp)
    /* 37C88 80047488 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 37C8C 8004748C 4800B4AF */  sw         $s4, 0x48($sp)
    /* 37C90 80047490 4400B3AF */  sw         $s3, 0x44($sp)
    /* 37C94 80047494 4000B2AF */  sw         $s2, 0x40($sp)
    /* 37C98 80047498 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 37C9C 8004749C 3800B0AF */  sw         $s0, 0x38($sp)
    /* 37CA0 800474A0 6400E28E */  lw         $v0, 0x64($s7)
    /* 37CA4 800474A4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 37CA8 800474A8 8005E3AE */  sw         $v1, 0x580($s7)
    /* 37CAC 800474AC 2110E202 */  addu       $v0, $s7, $v0
    /* 37CB0 800474B0 50024290 */  lbu        $v0, 0x250($v0)
    /* 37CB4 800474B4 00000000 */  nop
    /* 37CB8 800474B8 02004014 */  bnez       $v0, .L800474C4
    /* 37CBC 800474BC 00000000 */   nop
    /* 37CC0 800474C0 6400E3AE */  sw         $v1, 0x64($s7)
  .L800474C4:
    /* 37CC4 800474C4 019B030C */  jal        systemtask
    /* 37CC8 800474C8 21200000 */   addu      $a0, $zero, $zero
    /* 37CCC 800474CC 5C00E296 */  lhu        $v0, 0x5C($s7)
    /* 37CD0 800474D0 00000000 */  nop
    /* 37CD4 800474D4 40100200 */  sll        $v0, $v0, 1
    /* 37CD8 800474D8 21284000 */  addu       $a1, $v0, $zero
    /* 37CDC 800474DC 80FF4424 */  addiu      $a0, $v0, -0x80
    /* 37CE0 800474E0 00140400 */  sll        $v0, $a0, 16
    /* 37CE4 800474E4 031C0200 */  sra        $v1, $v0, 16
    /* 37CE8 800474E8 80006228 */  slti       $v0, $v1, 0x80
    /* 37CEC 800474EC 03004010 */  beqz       $v0, .L800474FC
    /* 37CF0 800474F0 81006228 */   slti      $v0, $v1, 0x81
    /* 37CF4 800474F4 05006018 */  blez       $v1, .L8004750C
    /* 37CF8 800474F8 00000000 */   nop
  .L800474FC:
    /* 37CFC 800474FC 04004014 */  bnez       $v0, .L80047510
    /* 37D00 80047500 00000000 */   nop
    /* 37D04 80047504 441D0108 */  j          .L80047510
    /* 37D08 80047508 80000424 */   addiu     $a0, $zero, 0x80
  .L8004750C:
    /* 37D0C 8004750C 21200000 */  addu       $a0, $zero, $zero
  .L80047510:
    /* 37D10 80047510 2800A4A7 */  sh         $a0, 0x28($sp)
    /* 37D14 80047514 00140500 */  sll        $v0, $a1, 16
    /* 37D18 80047518 43240200 */  sra        $a0, $v0, 17
    /* 37D1C 8004751C 21188000 */  addu       $v1, $a0, $zero
    /* 37D20 80047520 80006228 */  slti       $v0, $v1, 0x80
    /* 37D24 80047524 03004010 */  beqz       $v0, .L80047534
    /* 37D28 80047528 81006228 */   slti      $v0, $v1, 0x81
    /* 37D2C 8004752C 06006018 */  blez       $v1, .L80047548
    /* 37D30 80047530 00000000 */   nop
  .L80047534:
    /* 37D34 80047534 05004014 */  bnez       $v0, .L8004754C
    /* 37D38 80047538 3000A4A7 */   sh        $a0, 0x30($sp)
    /* 37D3C 8004753C 80000A24 */  addiu      $t2, $zero, 0x80
    /* 37D40 80047540 531D0108 */  j          .L8004754C
    /* 37D44 80047544 3000AAA7 */   sh        $t2, 0x30($sp)
  .L80047548:
    /* 37D48 80047548 3000A0A7 */  sh         $zero, 0x30($sp)
  .L8004754C:
    /* 37D4C 8004754C 00140500 */  sll        $v0, $a1, 16
    /* 37D50 80047550 C32B0200 */  sra        $a1, $v0, 15
    /* 37D54 80047554 8100A228 */  slti       $v0, $a1, 0x81
    /* 37D58 80047558 02004014 */  bnez       $v0, .L80047564
    /* 37D5C 8004755C 00000000 */   nop
    /* 37D60 80047560 80000524 */  addiu      $a1, $zero, 0x80
  .L80047564:
    /* 37D64 80047564 0200A104 */  bgez       $a1, .L80047570
    /* 37D68 80047568 00000000 */   nop
    /* 37D6C 8004756C 21280000 */  addu       $a1, $zero, $zero
  .L80047570:
    /* 37D70 80047570 5405E28E */  lw         $v0, 0x554($s7)
    /* 37D74 80047574 00000000 */  nop
    /* 37D78 80047578 29004014 */  bnez       $v0, .L80047620
    /* 37D7C 8004757C 2180A000 */   addu      $s0, $a1, $zero
    /* 37D80 80047580 5C00E386 */  lh         $v1, 0x5C($s7)
    /* 37D84 80047584 7C020224 */  addiu      $v0, $zero, 0x27C
    /* 37D88 80047588 1A006014 */  bnez       $v1, .L800475F4
    /* 37D8C 8004758C 8005E2AE */   sw        $v0, 0x580($s7)
    /* 37D90 80047590 1480023C */  lui        $v0, %hi(ticks)
    /* 37D94 80047594 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 37D98 80047598 9805E38E */  lw         $v1, 0x598($s7)
    /* 37D9C 8004759C 00000000 */  nop
    /* 37DA0 800475A0 23104300 */  subu       $v0, $v0, $v1
    /* 37DA4 800475A4 81004228 */  slti       $v0, $v0, 0x81
    /* 37DA8 800475A8 12004014 */  bnez       $v0, .L800475F4
    /* 37DAC 800475AC 01000424 */   addiu     $a0, $zero, 0x1
    /* 37DB0 800475B0 A9D1000C */  jal        Init_Memcard__FbT0
    /* 37DB4 800475B4 21280000 */   addu      $a1, $zero, $zero
    /* 37DB8 800475B8 21180000 */  addu       $v1, $zero, $zero
    /* 37DBC 800475BC 80000524 */  addiu      $a1, $zero, 0x80
    /* 37DC0 800475C0 2120E002 */  addu       $a0, $s7, $zero
  .L800475C4:
    /* 37DC4 800475C4 2110E302 */  addu       $v0, $s7, $v1
    /* 37DC8 800475C8 500240A0 */  sb         $zero, 0x250($v0)
    /* 37DCC 800475CC 5F0240A0 */  sb         $zero, 0x25F($v0)
    /* 37DD0 800475D0 6E0240A0 */  sb         $zero, 0x26E($v0)
    /* 37DD4 800475D4 320585A4 */  sh         $a1, 0x532($a0)
    /* 37DD8 800475D8 01006324 */  addiu      $v1, $v1, 0x1
    /* 37DDC 800475DC 0F006228 */  slti       $v0, $v1, 0xF
    /* 37DE0 800475E0 F8FF4014 */  bnez       $v0, .L800475C4
    /* 37DE4 800475E4 02008424 */   addiu     $a0, $a0, 0x2
    /* 37DE8 800475E8 01000224 */  addiu      $v0, $zero, 0x1
    /* 37DEC 800475EC 841D0108 */  j          .L80047610
    /* 37DF0 800475F0 5405E2AE */   sw        $v0, 0x554($s7)
  .L800475F4:
    /* 37DF4 800475F4 9805E28E */  lw         $v0, 0x598($s7)
    /* 37DF8 800475F8 00000000 */  nop
    /* 37DFC 800475FC 04004014 */  bnez       $v0, .L80047610
    /* 37E00 80047600 1480023C */   lui       $v0, %hi(ticks)
    /* 37E04 80047604 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 37E08 80047608 00000000 */  nop
    /* 37E0C 8004760C 9805E2AE */  sw         $v0, 0x598($s7)
  .L80047610:
    /* 37E10 80047610 5405E28E */  lw         $v0, 0x554($s7)
    /* 37E14 80047614 00000000 */  nop
    /* 37E18 80047618 0B004010 */  beqz       $v0, .L80047648
    /* 37E1C 8004761C 0580033C */   lui       $v1, %hi(kRGBVals)
  .L80047620:
    /* 37E20 80047620 2800AA97 */  lhu        $t2, 0x28($sp)
    /* 37E24 80047624 80000324 */  addiu      $v1, $zero, 0x80
    /* 37E28 80047628 00140A00 */  sll        $v0, $t2, 16
    /* 37E2C 8004762C 03140200 */  sra        $v0, $v0, 16
    /* 37E30 80047630 04004310 */  beq        $v0, $v1, .L80047644
    /* 37E34 80047634 2120E002 */   addu      $a0, $s7, $zero
    /* 37E38 80047638 002C1000 */  sll        $a1, $s0, 16
    /* 37E3C 8004763C 581B010C */  jal        DrawMemCardStuff__14tScreenMemcards
    /* 37E40 80047640 032C0500 */   sra       $a1, $a1, 16
  .L80047644:
    /* 37E44 80047644 0580033C */  lui        $v1, %hi(kRGBVals)
  .L80047648:
    /* 37E48 80047648 0580023C */  lui        $v0, %hi(D_800515E1)
    /* 37E4C 8004764C C8166324 */  addiu      $v1, $v1, %lo(kRGBVals)
    /* 37E50 80047650 E1154290 */  lbu        $v0, %lo(D_800515E1)($v0)
    /* 37E54 80047654 002C1000 */  sll        $a1, $s0, 16
    /* 37E58 80047658 80100200 */  sll        $v0, $v0, 2
    /* 37E5C 8004765C 21104300 */  addu       $v0, $v0, $v1
    /* 37E60 80047660 0000448C */  lw         $a0, 0x0($v0)
    /* 37E64 80047664 222E010C */  jal        CalcFadeVal__Fii
    /* 37E68 80047668 032C0500 */   sra       $a1, $a1, 16
    /* 37E6C 8004766C 21804000 */  addu       $s0, $v0, $zero
    /* 37E70 80047670 8405E28E */  lw         $v0, 0x584($s7)
    /* 37E74 80047674 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 37E78 80047678 02004310 */  beq        $v0, $v1, .L80047684
    /* 37E7C 8004767C 00000000 */   nop
    /* 37E80 80047680 8005E2AE */  sw         $v0, 0x580($s7)
  .L80047684:
    /* 37E84 80047684 8005E48E */  lw         $a0, 0x580($s7)
    /* 37E88 80047688 00000000 */  nop
    /* 37E8C 8004768C 06008310 */  beq        $a0, $v1, .L800476A8
    /* 37E90 80047690 00000000 */   nop
    /* 37E94 80047694 94E4020C */  jal        TextSys_Word__Fi
    /* 37E98 80047698 00000000 */   nop
    /* 37E9C 8004769C 5805E426 */  addiu      $a0, $s7, 0x558
    /* 37EA0 800476A0 2F91030C */  jal        sprintf
    /* 37EA4 800476A4 21284000 */   addu      $a1, $v0, $zero
  .L800476A8:
    /* 37EA8 800476A8 5805E426 */  addiu      $a0, $s7, 0x558
    /* 37EAC 800476AC 2000A527 */  addiu      $a1, $sp, 0x20
    /* 37EB0 800476B0 21300002 */  addu       $a2, $s0, $zero
    /* 37EB4 800476B4 02000724 */  addiu      $a3, $zero, 0x2
    /* 37EB8 800476B8 5000163C */  lui        $s6, (0x505050 >> 16)
    /* 37EBC 800476BC 5050D636 */  ori        $s6, $s6, (0x505050 & 0xFFFF)
    /* 37EC0 800476C0 0580023C */  lui        $v0, %hi(kMemCardMessageX)
    /* 37EC4 800476C4 0580033C */  lui        $v1, %hi(kMemCardMessageY)
    /* 37EC8 800476C8 30294894 */  lhu        $t0, %lo(kMemCardMessageX)($v0)
    /* 37ECC 800476CC 34296394 */  lhu        $v1, %lo(kMemCardMessageY)($v1)
    /* 37ED0 800476D0 BE000224 */  addiu      $v0, $zero, 0xBE
    /* 37ED4 800476D4 2400A2A7 */  sh         $v0, 0x24($sp)
    /* 37ED8 800476D8 2600A0A7 */  sh         $zero, 0x26($sp)
    /* 37EDC 800476DC 2000A8A7 */  sh         $t0, 0x20($sp)
    /* 37EE0 800476E0 2200A3A7 */  sh         $v1, 0x22($sp)
    /* 37EE4 800476E4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 37EE8 800476E8 A984000C */  jal        FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib
    /* 37EEC 800476EC 1400A0AF */   sw        $zero, 0x14($sp)
    /* 37EF0 800476F0 9C05E486 */  lh         $a0, 0x59C($s7)
    /* 37EF4 800476F4 0580023C */  lui        $v0, (0x80050000 >> 16)
    /* 37EF8 800476F8 94E4020C */  jal        TextSys_Word__Fi
    /* 37EFC 800476FC 93028424 */   addiu     $a0, $a0, 0x293
    /* 37F00 80047700 21204000 */  addu       $a0, $v0, $zero
    /* 37F04 80047704 02000224 */  addiu      $v0, $zero, 0x2
    /* 37F08 80047708 1400A2AF */  sw         $v0, 0x14($sp)
    /* 37F0C 8004770C 0580023C */  lui        $v0, %hi(kMemCardMessage1X)
    /* 37F10 80047710 05800A3C */  lui        $t2, %hi(kMemCardMessage1Y)
    /* 37F14 80047714 28294584 */  lh         $a1, %lo(kMemCardMessage1X)($v0)
    /* 37F18 80047718 2C294685 */  lh         $a2, %lo(kMemCardMessage1Y)($t2)
    /* 37F1C 8004771C 21380002 */  addu       $a3, $s0, $zero
    /* 37F20 80047720 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 37F24 80047724 1000A0AF */   sw        $zero, 0x10($sp)
    /* 37F28 80047728 0580153C */  lui        $s5, %hi(GRIDMEMCARD_STARTX)
    /* 37F2C 8004772C 0580023C */  lui        $v0, %hi(GRIDMEMCARDGOURAUDBIT_X)
    /* 37F30 80047730 0580033C */  lui        $v1, %hi(GRIDMEMCARDGOURAUDBIT_Y)
    /* 37F34 80047734 18294694 */  lhu        $a2, %lo(GRIDMEMCARDGOURAUDBIT_X)($v0)
    /* 37F38 80047738 0580023C */  lui        $v0, %hi(EXTRAYATTOP)
    /* 37F3C 8004773C 05800A3C */  lui        $t2, %hi(GRIDMEMCARD_STARTY)
    /* 37F40 80047740 0580143C */  lui        $s4, %hi(GRIDMEMCARD_WIDTH)
    /* 37F44 80047744 F428B396 */  lhu        $s3, %lo(GRIDMEMCARD_STARTX)($s5)
    /* 37F48 80047748 F8285295 */  lhu        $s2, %lo(GRIDMEMCARD_STARTY)($t2)
    /* 37F4C 8004774C 1C296394 */  lhu        $v1, %lo(GRIDMEMCARDGOURAUDBIT_Y)($v1)
    /* 37F50 80047750 0C294794 */  lhu        $a3, %lo(EXTRAYATTOP)($v0)
    /* 37F54 80047754 10299196 */  lhu        $s1, %lo(GRIDMEMCARD_WIDTH)($s4)
    /* 37F58 80047758 21F00000 */  addu       $fp, $zero, $zero
    /* 37F5C 8004775C 1000B6AF */  sw         $s6, 0x10($sp)
    /* 37F60 80047760 1400B6AF */  sw         $s6, 0x14($sp)
    /* 37F64 80047764 1800A0AF */  sw         $zero, 0x18($sp)
    /* 37F68 80047768 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 37F6C 8004776C 23986602 */  subu       $s3, $s3, $a2
    /* 37F70 80047770 009C1300 */  sll        $s3, $s3, 16
    /* 37F74 80047774 039C1300 */  sra        $s3, $s3, 16
    /* 37F78 80047778 21206002 */  addu       $a0, $s3, $zero
    /* 37F7C 8004777C 23904302 */  subu       $s2, $s2, $v1
    /* 37F80 80047780 0400E224 */  addiu      $v0, $a3, 0x4
    /* 37F84 80047784 23904202 */  subu       $s2, $s2, $v0
    /* 37F88 80047788 00941200 */  sll        $s2, $s2, 16
    /* 37F8C 8004778C 03941200 */  sra        $s2, $s2, 16
    /* 37F90 80047790 21284002 */  addu       $a1, $s2, $zero
    /* 37F94 80047794 40300600 */  sll        $a2, $a2, 1
    /* 37F98 80047798 21882602 */  addu       $s1, $s1, $a2
    /* 37F9C 8004779C 02003126 */  addiu      $s1, $s1, 0x2
    /* 37FA0 800477A0 008C1100 */  sll        $s1, $s1, 16
    /* 37FA4 800477A4 038C1100 */  sra        $s1, $s1, 16
    /* 37FA8 800477A8 21302002 */  addu       $a2, $s1, $zero
    /* 37FAC 800477AC 0580023C */  lui        $v0, %hi(GRIDMEMCARD_HEIGHT)
    /* 37FB0 800477B0 40180300 */  sll        $v1, $v1, 1
    /* 37FB4 800477B4 14294294 */  lhu        $v0, %lo(GRIDMEMCARD_HEIGHT)($v0)
    /* 37FB8 800477B8 0600E724 */  addiu      $a3, $a3, 0x6
    /* 37FBC 800477BC 21104300 */  addu       $v0, $v0, $v1
    /* 37FC0 800477C0 21104700 */  addu       $v0, $v0, $a3
    /* 37FC4 800477C4 00140200 */  sll        $v0, $v0, 16
    /* 37FC8 800477C8 03840200 */  sra        $s0, $v0, 16
    /* 37FCC 800477CC C2170200 */  srl        $v0, $v0, 31
    /* 37FD0 800477D0 21800202 */  addu       $s0, $s0, $v0
    /* 37FD4 800477D4 43801000 */  sra        $s0, $s0, 1
    /* 37FD8 800477D8 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* 37FDC 800477DC 21380002 */   addu      $a3, $s0, $zero
    /* 37FE0 800477E0 21206002 */  addu       $a0, $s3, $zero
    /* 37FE4 800477E4 21285002 */  addu       $a1, $s2, $s0
    /* 37FE8 800477E8 21302002 */  addu       $a2, $s1, $zero
    /* 37FEC 800477EC 21380002 */  addu       $a3, $s0, $zero
    /* 37FF0 800477F0 1000A0AF */  sw         $zero, 0x10($sp)
    /* 37FF4 800477F4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 37FF8 800477F8 1800B6AF */  sw         $s6, 0x18($sp)
    /* 37FFC 800477FC 3F70000C */  jal        SubtractiveBox__Fiiiiiiii
    /* 38000 80047800 1C00B6AF */   sw        $s6, 0x1C($sp)
    /* 38004 80047804 21200000 */  addu       $a0, $zero, $zero
    /* 38008 80047808 05800A3C */  lui        $t2, %hi(kMemCardMessage1Y)
    /* 3800C 8004780C 0580023C */  lui        $v0, %hi(kMemCardMessageH1)
    /* 38010 80047810 F428A58E */  lw         $a1, %lo(GRIDMEMCARD_STARTX)($s5)
    /* 38014 80047814 2C29468D */  lw         $a2, %lo(kMemCardMessage1Y)($t2)
    /* 38018 80047818 1029878E */  lw         $a3, %lo(GRIDMEMCARD_WIDTH)($s4)
    /* 3801C 8004781C 0829428C */  lw         $v0, %lo(kMemCardMessageH1)($v0)
    /* 38020 80047820 0200A524 */  addiu      $a1, $a1, 0x2
    /* 38024 80047824 FEFFC624 */  addiu      $a2, $a2, -0x2
    /* 38028 80047828 FCFFE724 */  addiu      $a3, $a3, -0x4
    /* 3802C 8004782C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 38030 80047830 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 38034 80047834 1000A2AF */   sw        $v0, 0x10($sp)
    /* 38038 80047838 21200000 */  addu       $a0, $zero, $zero
    /* 3803C 8004783C 0580023C */  lui        $v0, %hi(MEMCARD_DELTAY)
    /* 38040 80047840 05800A3C */  lui        $t2, %hi(GRIDMEMCARD_STARTY)
    /* 38044 80047844 F428A58E */  lw         $a1, %lo(GRIDMEMCARD_STARTX)($s5)
    /* 38048 80047848 0029438C */  lw         $v1, %lo(MEMCARD_DELTAY)($v0)
    /* 3804C 8004784C F828468D */  lw         $a2, %lo(GRIDMEMCARD_STARTY)($t2)
    /* 38050 80047850 1029878E */  lw         $a3, %lo(GRIDMEMCARD_WIDTH)($s4)
    /* 38054 80047854 0200A524 */  addiu      $a1, $a1, 0x2
    /* 38058 80047858 80100300 */  sll        $v0, $v1, 2
    /* 3805C 8004785C 21104300 */  addu       $v0, $v0, $v1
    /* 38060 80047860 2130C200 */  addu       $a2, $a2, $v0
    /* 38064 80047864 0100C624 */  addiu      $a2, $a2, 0x1
    /* 38068 80047868 0580023C */  lui        $v0, %hi(kMemCardMessageH)
    /* 3806C 8004786C 0429428C */  lw         $v0, %lo(kMemCardMessageH)($v0)
    /* 38070 80047870 FCFFE724 */  addiu      $a3, $a3, -0x4
    /* 38074 80047874 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 38078 80047878 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 3807C 8004787C 1000A2AF */   sw        $v0, 0x10($sp)
    /* 38080 80047880 F428B096 */  lhu        $s0, %lo(GRIDMEMCARD_STARTX)($s5)
  .L80047884:
    /* 38084 80047884 2120E002 */  addu       $a0, $s7, $zero
    /* 38088 80047888 002C1000 */  sll        $a1, $s0, 16
    /* 3808C 8004788C 032C0500 */  sra        $a1, $a1, 16
    /* 38090 80047890 00141E00 */  sll        $v0, $fp, 16
    /* 38094 80047894 031C0200 */  sra        $v1, $v0, 16
    /* 38098 80047898 C2170200 */  srl        $v0, $v0, 31
    /* 3809C 8004789C 21106200 */  addu       $v0, $v1, $v0
    /* 380A0 800478A0 43100200 */  sra        $v0, $v0, 1
    /* 380A4 800478A4 40100200 */  sll        $v0, $v0, 1
    /* 380A8 800478A8 23186200 */  subu       $v1, $v1, $v0
    /* 380AC 800478AC 001C0300 */  sll        $v1, $v1, 16
    /* 380B0 800478B0 031C0300 */  sra        $v1, $v1, 16
    /* 380B4 800478B4 3000AA97 */  lhu        $t2, 0x30($sp)
    /* 380B8 800478B8 0580123C */  lui        $s2, %hi(EXTRAYATTOP)
    /* 380BC 800478BC 1000A3AF */  sw         $v1, 0x10($sp)
    /* 380C0 800478C0 0C294396 */  lhu        $v1, %lo(EXTRAYATTOP)($s2)
    /* 380C4 800478C4 008C0A00 */  sll        $s1, $t2, 16
    /* 380C8 800478C8 05800A3C */  lui        $t2, %hi(GRIDMEMCARD_STARTY)
    /* 380CC 800478CC F8284695 */  lhu        $a2, %lo(GRIDMEMCARD_STARTY)($t2)
    /* 380D0 800478D0 05800A3C */  lui        $t2, %hi(GRIDMEMCARDGOURAUDBIT_Y)
    /* 380D4 800478D4 1C294295 */  lhu        $v0, %lo(GRIDMEMCARDGOURAUDBIT_Y)($t2)
    /* 380D8 800478D8 033C1100 */  sra        $a3, $s1, 16
    /* 380DC 800478DC 2330C200 */  subu       $a2, $a2, $v0
    /* 380E0 800478E0 2330C300 */  subu       $a2, $a2, $v1
    /* 380E4 800478E4 00340600 */  sll        $a2, $a2, 16
    /* 380E8 800478E8 261A010C */  jal        DrawVerticalLine__14tScreenMemcardssss
    /* 380EC 800478EC 03340600 */   sra       $a2, $a2, 16
    /* 380F0 800478F0 0580033C */  lui        $v1, %hi(MEMCARD_DELTAX)
    /* 380F4 800478F4 0100C227 */  addiu      $v0, $fp, 0x1
    /* 380F8 800478F8 21F04000 */  addu       $fp, $v0, $zero
    /* 380FC 800478FC 00140200 */  sll        $v0, $v0, 16
    /* 38100 80047900 03140200 */  sra        $v0, $v0, 16
    /* 38104 80047904 FC286394 */  lhu        $v1, %lo(MEMCARD_DELTAX)($v1)
    /* 38108 80047908 04004228 */  slti       $v0, $v0, 0x4
    /* 3810C 8004790C DDFF4014 */  bnez       $v0, .L80047884
    /* 38110 80047910 21800302 */   addu      $s0, $s0, $v1
    /* 38114 80047914 0580023C */  lui        $v0, %hi(GRIDMEMCARD_STARTY)
    /* 38118 80047918 0C29438E */  lw         $v1, %lo(EXTRAYATTOP)($s2)
    /* 3811C 8004791C F8285094 */  lhu        $s0, %lo(GRIDMEMCARD_STARTY)($v0)
    /* 38120 80047920 10006010 */  beqz       $v1, .L80047964
    /* 38124 80047924 2120E002 */   addu      $a0, $s7, $zero
    /* 38128 80047928 033C1100 */  sra        $a3, $s1, 16
    /* 3812C 8004792C 0580023C */  lui        $v0, %hi(GRIDMEMCARD_STARTX)
    /* 38130 80047930 0580033C */  lui        $v1, %hi(GRIDMEMCARDGOURAUDBIT_X)
    /* 38134 80047934 F4284594 */  lhu        $a1, %lo(GRIDMEMCARD_STARTX)($v0)
    /* 38138 80047938 18296394 */  lhu        $v1, %lo(GRIDMEMCARDGOURAUDBIT_X)($v1)
    /* 3813C 8004793C 0C294696 */  lhu        $a2, %lo(EXTRAYATTOP)($s2)
    /* 38140 80047940 01000224 */  addiu      $v0, $zero, 0x1
    /* 38144 80047944 1000A2AF */  sw         $v0, 0x10($sp)
    /* 38148 80047948 2328A300 */  subu       $a1, $a1, $v1
    /* 3814C 8004794C 002C0500 */  sll        $a1, $a1, 16
    /* 38150 80047950 032C0500 */  sra        $a1, $a1, 16
    /* 38154 80047954 23300602 */  subu       $a2, $s0, $a2
    /* 38158 80047958 00340600 */  sll        $a2, $a2, 16
    /* 3815C 8004795C 531A010C */  jal        DrawHorizontalLine__14tScreenMemcardssss
    /* 38160 80047960 03340600 */   sra       $a2, $a2, 16
  .L80047964:
    /* 38164 80047964 21F00000 */  addu       $fp, $zero, $zero
    /* 38168 80047968 0580133C */  lui        $s3, %hi(GRIDMEMCARD_STARTX)
    /* 3816C 8004796C 0580123C */  lui        $s2, %hi(GRIDMEMCARDGOURAUDBIT_X)
  .L80047970:
    /* 38170 80047970 2120E002 */  addu       $a0, $s7, $zero
    /* 38174 80047974 00341000 */  sll        $a2, $s0, 16
    /* 38178 80047978 03340600 */  sra        $a2, $a2, 16
    /* 3817C 8004797C 00141E00 */  sll        $v0, $fp, 16
    /* 38180 80047980 031C0200 */  sra        $v1, $v0, 16
    /* 38184 80047984 C2170200 */  srl        $v0, $v0, 31
    /* 38188 80047988 21106200 */  addu       $v0, $v1, $v0
    /* 3818C 8004798C 43100200 */  sra        $v0, $v0, 1
    /* 38190 80047990 40100200 */  sll        $v0, $v0, 1
    /* 38194 80047994 23186200 */  subu       $v1, $v1, $v0
    /* 38198 80047998 001C0300 */  sll        $v1, $v1, 16
    /* 3819C 8004799C 3000AA97 */  lhu        $t2, 0x30($sp)
    /* 381A0 800479A0 F4286596 */  lhu        $a1, %lo(GRIDMEMCARD_STARTX)($s3)
    /* 381A4 800479A4 18294296 */  lhu        $v0, %lo(GRIDMEMCARDGOURAUDBIT_X)($s2)
    /* 381A8 800479A8 031C0300 */  sra        $v1, $v1, 16
    /* 381AC 800479AC 1000A3AF */  sw         $v1, 0x10($sp)
    /* 381B0 800479B0 008C0A00 */  sll        $s1, $t2, 16
    /* 381B4 800479B4 033C1100 */  sra        $a3, $s1, 16
    /* 381B8 800479B8 2328A200 */  subu       $a1, $a1, $v0
    /* 381BC 800479BC 002C0500 */  sll        $a1, $a1, 16
    /* 381C0 800479C0 531A010C */  jal        DrawHorizontalLine__14tScreenMemcardssss
    /* 381C4 800479C4 032C0500 */   sra       $a1, $a1, 16
    /* 381C8 800479C8 0580023C */  lui        $v0, %hi(MEMCARD_DELTAY)
    /* 381CC 800479CC 0100C327 */  addiu      $v1, $fp, 0x1
    /* 381D0 800479D0 21F06000 */  addu       $fp, $v1, $zero
    /* 381D4 800479D4 001C0300 */  sll        $v1, $v1, 16
    /* 381D8 800479D8 032C0300 */  sra        $a1, $v1, 16
    /* 381DC 800479DC 00294994 */  lhu        $t1, %lo(MEMCARD_DELTAY)($v0)
    /* 381E0 800479E0 0600A228 */  slti       $v0, $a1, 0x6
    /* 381E4 800479E4 21400902 */  addu       $t0, $s0, $t1
    /* 381E8 800479E8 E1FF4014 */  bnez       $v0, .L80047970
    /* 381EC 800479EC 21800001 */   addu      $s0, $t0, $zero
    /* 381F0 800479F0 2120E002 */  addu       $a0, $s7, $zero
    /* 381F4 800479F4 033C1100 */  sra        $a3, $s1, 16
    /* 381F8 800479F8 C2170300 */  srl        $v0, $v1, 31
    /* 381FC 800479FC 2110A200 */  addu       $v0, $a1, $v0
    /* 38200 80047A00 43100200 */  sra        $v0, $v0, 1
    /* 38204 80047A04 40100200 */  sll        $v0, $v0, 1
    /* 38208 80047A08 2310A200 */  subu       $v0, $a1, $v0
    /* 3820C 80047A0C 00140200 */  sll        $v0, $v0, 16
    /* 38210 80047A10 03140200 */  sra        $v0, $v0, 16
    /* 38214 80047A14 1000A2AF */  sw         $v0, 0x10($sp)
    /* 38218 80047A18 0580023C */  lui        $v0, %hi(GRIDMEMCARD_STARTX)
    /* 3821C 80047A1C 0580033C */  lui        $v1, %hi(GRIDMEMCARDGOURAUDBIT_X)
    /* 38220 80047A20 F4284594 */  lhu        $a1, %lo(GRIDMEMCARD_STARTX)($v0)
    /* 38224 80047A24 18296294 */  lhu        $v0, %lo(GRIDMEMCARDGOURAUDBIT_X)($v1)
    /* 38228 80047A28 0580033C */  lui        $v1, %hi(kMemCardMessageH)
    /* 3822C 80047A2C 04296694 */  lhu        $a2, %lo(kMemCardMessageH)($v1)
    /* 38230 80047A30 2328A200 */  subu       $a1, $a1, $v0
    /* 38234 80047A34 002C0500 */  sll        $a1, $a1, 16
    /* 38238 80047A38 032C0500 */  sra        $a1, $a1, 16
    /* 3823C 80047A3C 2330C900 */  subu       $a2, $a2, $t1
    /* 38240 80047A40 21300601 */  addu       $a2, $t0, $a2
    /* 38244 80047A44 00340600 */  sll        $a2, $a2, 16
    /* 38248 80047A48 531A010C */  jal        DrawHorizontalLine__14tScreenMemcardssss
    /* 3824C 80047A4C 03340600 */   sra       $a2, $a2, 16
    /* 38250 80047A50 2800AA97 */  lhu        $t2, 0x28($sp)
    /* 38254 80047A54 21800000 */  addu       $s0, $zero, $zero
    /* 38258 80047A58 00140A00 */  sll        $v0, $t2, 16
    /* 3825C 80047A5C 038C0200 */  sra        $s1, $v0, 16
    /* 38260 80047A60 1E000426 */  addiu      $a0, $s0, 0x1E
  .L80047A64:
    /* 38264 80047A64 21280000 */  addu       $a1, $zero, $zero
    /* 38268 80047A68 2130A000 */  addu       $a2, $a1, $zero
    /* 3826C 80047A6C 2138A000 */  addu       $a3, $a1, $zero
    /* 38270 80047A70 1000B1AF */  sw         $s1, 0x10($sp)
    /* 38274 80047A74 1400A0AF */  sw         $zero, 0x14($sp)
    /* 38278 80047A78 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3827C 80047A7C 1800A0AF */   sw        $zero, 0x18($sp)
    /* 38280 80047A80 01001026 */  addiu      $s0, $s0, 0x1
    /* 38284 80047A84 1000022A */  slti       $v0, $s0, 0x10
    /* 38288 80047A88 F6FF4014 */  bnez       $v0, .L80047A64
    /* 3828C 80047A8C 1E000426 */   addiu     $a0, $s0, 0x1E
    /* 38290 80047A90 5405E28E */  lw         $v0, 0x554($s7)
    /* 38294 80047A94 00000000 */  nop
    /* 38298 80047A98 03004010 */  beqz       $v0, .L80047AA8
    /* 3829C 80047A9C 00000000 */   nop
    /* 382A0 80047AA0 AF1C010C */  jal        SetEnablings__14tScreenMemcard
    /* 382A4 80047AA4 2120E002 */   addu      $a0, $s7, $zero
  .L80047AA8:
    /* 382A8 80047AA8 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 382AC 80047AAC 5800BE8F */  lw         $fp, 0x58($sp)
    /* 382B0 80047AB0 5400B78F */  lw         $s7, 0x54($sp)
    /* 382B4 80047AB4 5000B68F */  lw         $s6, 0x50($sp)
    /* 382B8 80047AB8 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 382BC 80047ABC 4800B48F */  lw         $s4, 0x48($sp)
    /* 382C0 80047AC0 4400B38F */  lw         $s3, 0x44($sp)
    /* 382C4 80047AC4 4000B28F */  lw         $s2, 0x40($sp)
    /* 382C8 80047AC8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 382CC 80047ACC 3800B08F */  lw         $s0, 0x38($sp)
    /* 382D0 80047AD0 0800E003 */  jr         $ra
    /* 382D4 80047AD4 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel DrawBackground__14tScreenMemcard
