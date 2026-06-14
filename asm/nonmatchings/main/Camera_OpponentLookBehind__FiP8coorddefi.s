.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_OpponentLookBehind__FiP8coorddefi, 0x3D4

glabel Camera_OpponentLookBehind__FiP8coorddefi
    /* 75434 80084C34 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 75438 80084C38 5800BEAF */  sw         $fp, 0x58($sp)
    /* 7543C 80084C3C 21F08000 */  addu       $fp, $a0, $zero
    /* 75440 80084C40 5400B7AF */  sw         $s7, 0x54($sp)
    /* 75444 80084C44 21B8A000 */  addu       $s7, $a1, $zero
    /* 75448 80084C48 5000B6AF */  sw         $s6, 0x50($sp)
    /* 7544C 80084C4C 0B001624 */  addiu      $s6, $zero, 0xB
    /* 75450 80084C50 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 75454 80084C54 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 75458 80084C58 4800B4AF */  sw         $s4, 0x48($sp)
    /* 7545C 80084C5C 4400B3AF */  sw         $s3, 0x44($sp)
    /* 75460 80084C60 4000B2AF */  sw         $s2, 0x40($sp)
    /* 75464 80084C64 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 75468 80084C68 1400C010 */  beqz       $a2, .L80084CBC
    /* 7546C 80084C6C 3800B0AF */   sw        $s0, 0x38($sp)
    /* 75470 80084C70 1480053C */  lui        $a1, %hi(D_8013DFD0)
    /* 75474 80084C74 D0DFA524 */  addiu      $a1, $a1, %lo(D_8013DFD0)
    /* 75478 80084C78 40181E00 */  sll        $v1, $fp, 1
    /* 7547C 80084C7C 21187E00 */  addu       $v1, $v1, $fp
    /* 75480 80084C80 80180300 */  sll        $v1, $v1, 2
    /* 75484 80084C84 1180043C */  lui        $a0, %hi(Cars_gHumanRaceCarList)
    /* 75488 80084C88 48FA8424 */  addiu      $a0, $a0, %lo(Cars_gHumanRaceCarList)
    /* 7548C 80084C8C 80101E00 */  sll        $v0, $fp, 2
    /* 75490 80084C90 21104400 */  addu       $v0, $v0, $a0
    /* 75494 80084C94 0000428C */  lw         $v0, 0x0($v0)
    /* 75498 80084C98 21186500 */  addu       $v1, $v1, $a1
    /* 7549C 80084C9C 0801488C */  lw         $t0, 0x108($v0)
    /* 754A0 80084CA0 0C01498C */  lw         $t1, 0x10C($v0)
    /* 754A4 80084CA4 10014A8C */  lw         $t2, 0x110($v0)
    /* 754A8 80084CA8 000068AC */  sw         $t0, 0x0($v1)
    /* 754AC 80084CAC 040069AC */  sw         $t1, 0x4($v1)
    /* 754B0 80084CB0 08006AAC */  sw         $t2, 0x8($v1)
    /* 754B4 80084CB4 F6130208 */  j          .L80084FD8
    /* 754B8 80084CB8 00000000 */   nop
  .L80084CBC:
    /* 754BC 80084CBC 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 754C0 80084CC0 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 754C4 80084CC4 80181E00 */  sll        $v1, $fp, 2
    /* 754C8 80084CC8 21206200 */  addu       $a0, $v1, $v0
    /* 754CC 80084CCC 0000828C */  lw         $v0, 0x0($a0)
    /* 754D0 80084CD0 1480033C */  lui        $v1, %hi(Cars_gNumCars)
    /* 754D4 80084CD4 F4C7638C */  lw         $v1, %lo(Cars_gNumCars)($v1)
    /* 754D8 80084CD8 0801488C */  lw         $t0, 0x108($v0)
    /* 754DC 80084CDC 0C01498C */  lw         $t1, 0x10C($v0)
    /* 754E0 80084CE0 10014A8C */  lw         $t2, 0x110($v0)
    /* 754E4 80084CE4 1800A8AF */  sw         $t0, 0x18($sp)
    /* 754E8 80084CE8 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 754EC 80084CEC 2000AAAF */  sw         $t2, 0x20($sp)
    /* 754F0 80084CF0 5D006018 */  blez       $v1, .L80084E68
    /* 754F4 80084CF4 21A80000 */   addu      $s5, $zero, $zero
    /* 754F8 80084CF8 21A08000 */  addu       $s4, $a0, $zero
    /* 754FC 80084CFC 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 75500 80084D00 DCF95324 */  addiu      $s3, $v0, %lo(Cars_gList)
  .L80084D04:
    /* 75504 80084D04 0000658E */  lw         $a1, 0x0($s3)
    /* 75508 80084D08 0000828E */  lw         $v0, 0x0($s4)
    /* 7550C 80084D0C 00000000 */  nop
    /* 75510 80084D10 4F00A210 */  beq        $a1, $v0, .L80084E50
    /* 75514 80084D14 00000000 */   nop
    /* 75518 80084D18 0800A384 */  lh         $v1, 0x8($a1)
    /* 7551C 80084D1C 08004284 */  lh         $v0, 0x8($v0)
    /* 75520 80084D20 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 75524 80084D24 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 75528 80084D28 23906200 */  subu       $s2, $v1, $v0
    /* 7552C 80084D2C 02004106 */  bgez       $s2, .L80084D38
    /* 75530 80084D30 21104002 */   addu      $v0, $s2, $zero
    /* 75534 80084D34 23100200 */  negu       $v0, $v0
  .L80084D38:
    /* 75538 80084D38 21184000 */  addu       $v1, $v0, $zero
    /* 7553C 80084D3C C2170400 */  srl        $v0, $a0, 31
    /* 75540 80084D40 21108200 */  addu       $v0, $a0, $v0
    /* 75544 80084D44 43100200 */  sra        $v0, $v0, 1
    /* 75548 80084D48 2A104300 */  slt        $v0, $v0, $v1
    /* 7554C 80084D4C 03004010 */  beqz       $v0, .L80084D5C
    /* 75550 80084D50 21906000 */   addu      $s2, $v1, $zero
    /* 75554 80084D54 23188300 */  subu       $v1, $a0, $v1
    /* 75558 80084D58 21906000 */  addu       $s2, $v1, $zero
  .L80084D5C:
    /* 7555C 80084D5C 0B00422A */  slti       $v0, $s2, 0xB
    /* 75560 80084D60 3B004010 */  beqz       $v0, .L80084E50
    /* 75564 80084D64 00000000 */   nop
    /* 75568 80084D68 0000E28E */  lw         $v0, 0x0($s7)
    /* 7556C 80084D6C A000A38C */  lw         $v1, 0xA0($a1)
    /* 75570 80084D70 00000000 */  nop
    /* 75574 80084D74 23104300 */  subu       $v0, $v0, $v1
    /* 75578 80084D78 2800A2AF */  sw         $v0, 0x28($sp)
    /* 7557C 80084D7C 0000638E */  lw         $v1, 0x0($s3)
    /* 75580 80084D80 0400E28E */  lw         $v0, 0x4($s7)
    /* 75584 80084D84 A400638C */  lw         $v1, 0xA4($v1)
    /* 75588 80084D88 00000000 */  nop
    /* 7558C 80084D8C 23104300 */  subu       $v0, $v0, $v1
    /* 75590 80084D90 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 75594 80084D94 0000638E */  lw         $v1, 0x0($s3)
    /* 75598 80084D98 0800E28E */  lw         $v0, 0x8($s7)
    /* 7559C 80084D9C A800638C */  lw         $v1, 0xA8($v1)
    /* 755A0 80084DA0 2800A427 */  addiu      $a0, $sp, 0x28
    /* 755A4 80084DA4 23104300 */  subu       $v0, $v0, $v1
    /* 755A8 80084DA8 8776020C */  jal        Math_NormalizeVector__FP8coorddef
    /* 755AC 80084DAC 3000A2AF */   sw        $v0, 0x30($sp)
    /* 755B0 80084DB0 0000828E */  lw         $v0, 0x0($s4)
    /* 755B4 80084DB4 2800A58F */  lw         $a1, 0x28($sp)
    /* 755B8 80084DB8 0801448C */  lw         $a0, 0x108($v0)
    /* 755BC 80084DBC CA90030C */  jal        fixedmult
    /* 755C0 80084DC0 00000000 */   nop
    /* 755C4 80084DC4 0000838E */  lw         $v1, 0x0($s4)
    /* 755C8 80084DC8 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 755CC 80084DCC 0C01648C */  lw         $a0, 0x10C($v1)
    /* 755D0 80084DD0 CA90030C */  jal        fixedmult
    /* 755D4 80084DD4 21884000 */   addu      $s1, $v0, $zero
    /* 755D8 80084DD8 0000838E */  lw         $v1, 0x0($s4)
    /* 755DC 80084DDC 3000A58F */  lw         $a1, 0x30($sp)
    /* 755E0 80084DE0 1001648C */  lw         $a0, 0x110($v1)
    /* 755E4 80084DE4 CA90030C */  jal        fixedmult
    /* 755E8 80084DE8 21804000 */   addu      $s0, $v0, $zero
    /* 755EC 80084DEC 21883002 */  addu       $s1, $s1, $s0
    /* 755F0 80084DF0 21882202 */  addu       $s1, $s1, $v0
    /* 755F4 80084DF4 66AB030C */  jal        intarccos
    /* 755F8 80084DF8 21202002 */   addu      $a0, $s1, $zero
    /* 755FC 80084DFC 05004018 */  blez       $v0, .L80084E14
    /* 75600 80084E00 00000000 */   nop
    /* 75604 80084E04 66AB030C */  jal        intarccos
    /* 75608 80084E08 21202002 */   addu      $a0, $s1, $zero
    /* 7560C 80084E0C 89130208 */  j          .L80084E24
    /* 75610 80084E10 80004228 */   slti      $v0, $v0, 0x80
  .L80084E14:
    /* 75614 80084E14 66AB030C */  jal        intarccos
    /* 75618 80084E18 21202002 */   addu      $a0, $s1, $zero
    /* 7561C 80084E1C 23100200 */  negu       $v0, $v0
    /* 75620 80084E20 80004228 */  slti       $v0, $v0, 0x80
  .L80084E24:
    /* 75624 80084E24 0A004010 */  beqz       $v0, .L80084E50
    /* 75628 80084E28 2A105602 */   slt       $v0, $s2, $s6
    /* 7562C 80084E2C 08004010 */  beqz       $v0, .L80084E50
    /* 75630 80084E30 00000000 */   nop
    /* 75634 80084E34 2800A88F */  lw         $t0, 0x28($sp)
    /* 75638 80084E38 2C00A98F */  lw         $t1, 0x2C($sp)
    /* 7563C 80084E3C 3000AA8F */  lw         $t2, 0x30($sp)
    /* 75640 80084E40 1800A8AF */  sw         $t0, 0x18($sp)
    /* 75644 80084E44 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 75648 80084E48 2000AAAF */  sw         $t2, 0x20($sp)
    /* 7564C 80084E4C 21B04002 */  addu       $s6, $s2, $zero
  .L80084E50:
    /* 75650 80084E50 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 75654 80084E54 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 75658 80084E58 0100B526 */  addiu      $s5, $s5, 0x1
    /* 7565C 80084E5C 2A10A202 */  slt        $v0, $s5, $v0
    /* 75660 80084E60 A8FF4014 */  bnez       $v0, .L80084D04
    /* 75664 80084E64 04007326 */   addiu     $s3, $s3, 0x4
  .L80084E68:
    /* 75668 80084E68 1480023C */  lui        $v0, %hi(D_8013DFD0)
    /* 7566C 80084E6C D0DF4224 */  addiu      $v0, $v0, %lo(D_8013DFD0)
    /* 75670 80084E70 40801E00 */  sll        $s0, $fp, 1
    /* 75674 80084E74 21801E02 */  addu       $s0, $s0, $fp
    /* 75678 80084E78 80801000 */  sll        $s0, $s0, 2
    /* 7567C 80084E7C 21800202 */  addu       $s0, $s0, $v0
    /* 75680 80084E80 1800A28F */  lw         $v0, 0x18($sp)
    /* 75684 80084E84 0000048E */  lw         $a0, 0x0($s0)
    /* 75688 80084E88 CC4C0524 */  addiu      $a1, $zero, 0x4CCC
    /* 7568C 80084E8C CA90030C */  jal        fixedmult
    /* 75690 80084E90 23204400 */   subu      $a0, $v0, $a0
    /* 75694 80084E94 0000038E */  lw         $v1, 0x0($s0)
    /* 75698 80084E98 0400048E */  lw         $a0, 0x4($s0)
    /* 7569C 80084E9C 21186200 */  addu       $v1, $v1, $v0
    /* 756A0 80084EA0 000003AE */  sw         $v1, 0x0($s0)
    /* 756A4 80084EA4 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 756A8 80084EA8 CC4C0524 */  addiu      $a1, $zero, 0x4CCC
    /* 756AC 80084EAC CA90030C */  jal        fixedmult
    /* 756B0 80084EB0 23204400 */   subu      $a0, $v0, $a0
    /* 756B4 80084EB4 0400038E */  lw         $v1, 0x4($s0)
    /* 756B8 80084EB8 0800048E */  lw         $a0, 0x8($s0)
    /* 756BC 80084EBC 21186200 */  addu       $v1, $v1, $v0
    /* 756C0 80084EC0 040003AE */  sw         $v1, 0x4($s0)
    /* 756C4 80084EC4 2000A28F */  lw         $v0, 0x20($sp)
    /* 756C8 80084EC8 CC4C0524 */  addiu      $a1, $zero, 0x4CCC
    /* 756CC 80084ECC CA90030C */  jal        fixedmult
    /* 756D0 80084ED0 23204400 */   subu      $a0, $v0, $a0
    /* 756D4 80084ED4 0800038E */  lw         $v1, 0x8($s0)
    /* 756D8 80084ED8 00000000 */  nop
    /* 756DC 80084EDC 21186200 */  addu       $v1, $v1, $v0
    /* 756E0 80084EE0 080003AE */  sw         $v1, 0x8($s0)
    /* 756E4 80084EE4 0000E28E */  lw         $v0, 0x0($s7)
    /* 756E8 80084EE8 0000038E */  lw         $v1, 0x0($s0)
    /* 756EC 80084EEC 00000000 */  nop
    /* 756F0 80084EF0 23104300 */  subu       $v0, $v0, $v1
    /* 756F4 80084EF4 1800A2AF */  sw         $v0, 0x18($sp)
    /* 756F8 80084EF8 0400E28E */  lw         $v0, 0x4($s7)
    /* 756FC 80084EFC 0400038E */  lw         $v1, 0x4($s0)
    /* 75700 80084F00 00000000 */  nop
    /* 75704 80084F04 23104300 */  subu       $v0, $v0, $v1
    /* 75708 80084F08 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 7570C 80084F0C 0800E28E */  lw         $v0, 0x8($s7)
    /* 75710 80084F10 0800038E */  lw         $v1, 0x8($s0)
    /* 75714 80084F14 00000000 */  nop
    /* 75718 80084F18 23104300 */  subu       $v0, $v0, $v1
    /* 7571C 80084F1C 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 75720 80084F20 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 75724 80084F24 2000A2AF */  sw         $v0, 0x20($sp)
    /* 75728 80084F28 00111E00 */  sll        $v0, $fp, 4
    /* 7572C 80084F2C 21105E00 */  addu       $v0, $v0, $fp
    /* 75730 80084F30 00110200 */  sll        $v0, $v0, 4
    /* 75734 80084F34 21104300 */  addu       $v0, $v0, $v1
    /* 75738 80084F38 70004294 */  lhu        $v0, 0x70($v0)
    /* 7573C 80084F3C 00000000 */  nop
    /* 75740 80084F40 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 75744 80084F44 00140200 */  sll        $v0, $v0, 16
    /* 75748 80084F48 031C0200 */  sra        $v1, $v0, 16
    /* 7574C 80084F4C 0600622C */  sltiu      $v0, $v1, 0x6
    /* 75750 80084F50 15004010 */  beqz       $v0, .L80084FA8
    /* 75754 80084F54 0580023C */   lui       $v0, %hi(jtbl_80055918)
    /* 75758 80084F58 18594224 */  addiu      $v0, $v0, %lo(jtbl_80055918)
    /* 7575C 80084F5C 80180300 */  sll        $v1, $v1, 2
    /* 75760 80084F60 21186200 */  addu       $v1, $v1, $v0
    /* 75764 80084F64 0000628C */  lw         $v0, 0x0($v1)
    /* 75768 80084F68 00000000 */  nop
    /* 7576C 80084F6C 08004000 */  jr         $v0
    /* 75770 80084F70 00000000 */   nop
  jlabel .L80084F74
    /* 75774 80084F74 FEFF033C */  lui        $v1, (0xFFFEB334 >> 16)
    /* 75778 80084F78 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 7577C 80084F7C E8130208 */  j          .L80084FA0
    /* 75780 80084F80 34B36334 */   ori       $v1, $v1, (0xFFFEB334 & 0xFFFF)
  jlabel .L80084F84
    /* 75784 80084F84 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 75788 80084F88 00000000 */  nop
    /* 7578C 80084F8C 9A994224 */  addiu      $v0, $v0, -0x6666
    /* 75790 80084F90 1C00A2AF */  sw         $v0, 0x1C($sp)
  jlabel .L80084F94
    /* 75794 80084F94 FEFF033C */  lui        $v1, (0xFFFE6667 >> 16)
    /* 75798 80084F98 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 7579C 80084F9C 67666334 */  ori        $v1, $v1, (0xFFFE6667 & 0xFFFF)
  .L80084FA0:
    /* 757A0 80084FA0 21104300 */  addu       $v0, $v0, $v1
    /* 757A4 80084FA4 1C00A2AF */  sw         $v0, 0x1C($sp)
  .L80084FA8:
    /* 757A8 80084FA8 01000224 */  addiu      $v0, $zero, 0x1
    /* 757AC 80084FAC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 757B0 80084FB0 2120C003 */  addu       $a0, $fp, $zero
    /* 757B4 80084FB4 1800A527 */  addiu      $a1, $sp, 0x18
    /* 757B8 80084FB8 00110400 */  sll        $v0, $a0, 4
    /* 757BC 80084FBC 21104400 */  addu       $v0, $v0, $a0
    /* 757C0 80084FC0 00110200 */  sll        $v0, $v0, 4
    /* 757C4 80084FC4 1180073C */  lui        $a3, %hi(D_8010F2DC)
    /* 757C8 80084FC8 DCF2E724 */  addiu      $a3, $a3, %lo(D_8010F2DC)
    /* 757CC 80084FCC 2130E002 */  addu       $a2, $s7, $zero
    /* 757D0 80084FD0 2612020C */  jal        Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi
    /* 757D4 80084FD4 21384700 */   addu      $a3, $v0, $a3
  .L80084FD8:
    /* 757D8 80084FD8 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 757DC 80084FDC 5800BE8F */  lw         $fp, 0x58($sp)
    /* 757E0 80084FE0 5400B78F */  lw         $s7, 0x54($sp)
    /* 757E4 80084FE4 5000B68F */  lw         $s6, 0x50($sp)
    /* 757E8 80084FE8 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 757EC 80084FEC 4800B48F */  lw         $s4, 0x48($sp)
    /* 757F0 80084FF0 4400B38F */  lw         $s3, 0x44($sp)
    /* 757F4 80084FF4 4000B28F */  lw         $s2, 0x40($sp)
    /* 757F8 80084FF8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 757FC 80084FFC 3800B08F */  lw         $s0, 0x38($sp)
    /* 75800 80085000 0800E003 */  jr         $ra
    /* 75804 80085004 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel Camera_OpponentLookBehind__FiP8coorddefi
