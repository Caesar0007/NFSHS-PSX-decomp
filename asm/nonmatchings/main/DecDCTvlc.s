.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DecDCTvlc, 0x350

glabel DecDCTvlc
    /* E7C30 800F7430 1380083C */  lui        $t0, %hi(D_801369E8)
    /* E7C34 800F7434 E8690825 */  addiu      $t0, $t0, %lo(D_801369E8)
    /* E7C38 800F7438 1280063C */  lui        $a2, %hi(CF_DVLC)
    /* E7C3C 800F743C 3840C624 */  addiu      $a2, $a2, %lo(CF_DVLC)
    /* E7C40 800F7440 1380073C */  lui        $a3, %hi(CF2_DVLC)
    /* E7C44 800F7444 3840E724 */  addiu      $a3, $a3, %lo(CF2_DVLC)
    /* E7C48 800F7448 0F008014 */  bnez       $a0, .L800F7488
    /* E7C4C 800F744C 0000098D */   lw        $t1, 0x0($t0)
    /* E7C50 800F7450 1380083C */  lui        $t0, %hi(D_801369EC)
    /* E7C54 800F7454 EC690825 */  addiu      $t0, $t0, %lo(D_801369EC)
    /* E7C58 800F7458 0000048D */  lw         $a0, 0x0($t0)
    /* E7C5C 800F745C 0400058D */  lw         $a1, 0x4($t0)
    /* E7C60 800F7460 0800028D */  lw         $v0, 0x8($t0)
    /* E7C64 800F7464 0C00038D */  lw         $v1, 0xC($t0)
    /* E7C68 800F7468 10000C8D */  lw         $t4, 0x10($t0)
    /* E7C6C 800F746C 14000D8D */  lw         $t5, 0x14($t0)
    /* E7C70 800F7470 18000F8D */  lw         $t7, 0x18($t0)
    /* E7C74 800F7474 1C00188D */  lw         $t8, 0x1C($t0)
    /* E7C78 800F7478 2000198D */  lw         $t9, 0x20($t0)
    /* E7C7C 800F747C 20482901 */  add        $t1, $t1, $t1 /* handwritten instruction */
    /* E7C80 800F7480 64000010 */  b          .L800F7614
    /* E7C84 800F7484 2070A900 */   add       $t6, $a1, $t1 /* handwritten instruction */
  .L800F7488:
    /* E7C88 800F7488 20680000 */  add        $t5, $zero, $zero /* handwritten instruction */
    /* E7C8C 800F748C 20780000 */  add        $t7, $zero, $zero /* handwritten instruction */
    /* E7C90 800F7490 20C00000 */  add        $t8, $zero, $zero /* handwritten instruction */
    /* E7C94 800F7494 20C80000 */  add        $t9, $zero, $zero /* handwritten instruction */
    /* E7C98 800F7498 20482901 */  add        $t1, $t1, $t1 /* handwritten instruction */
    /* E7C9C 800F749C 2070A900 */  add        $t6, $a1, $t1 /* handwritten instruction */
    /* E7CA0 800F74A0 0000898C */  lw         $t1, 0x0($a0)
    /* E7CA4 800F74A4 04008C94 */  lhu        $t4, 0x4($a0)
    /* E7CA8 800F74A8 06008A94 */  lhu        $t2, 0x6($a0)
    /* E7CAC 800F74AC 08008294 */  lhu        $v0, 0x8($a0)
    /* E7CB0 800F74B0 0A008394 */  lhu        $v1, 0xA($a0)
    /* E7CB4 800F74B4 FDFF4A21 */  addi       $t2, $t2, -0x3 /* handwritten instruction */
    /* E7CB8 800F74B8 02004005 */  bltz       $t2, .L800F74C4
    /* E7CBC 800F74BC 80620C00 */   sll       $t4, $t4, 10
    /* E7CC0 800F74C0 01000D20 */  addi       $t5, $zero, 0x1 /* handwritten instruction */
  .L800F74C4:
    /* E7CC4 800F74C4 0C008420 */  addi       $a0, $a0, 0xC /* handwritten instruction */
    /* E7CC8 800F74C8 00140200 */  sll        $v0, $v0, 16
    /* E7CCC 800F74CC 25104300 */  or         $v0, $v0, $v1
    /* E7CD0 800F74D0 25180000 */  or         $v1, $zero, $zero
    /* E7CD4 800F74D4 0000A9AC */  sw         $t1, 0x0($a1)
    /* E7CD8 800F74D8 FFFF2931 */  andi       $t1, $t1, 0xFFFF
    /* E7CDC 800F74DC 80480900 */  sll        $t1, $t1, 2
    /* E7CE0 800F74E0 04002925 */  addiu      $t1, $t1, 0x4
    /* E7CE4 800F74E4 20482501 */  add        $t1, $t1, $a1 /* handwritten instruction */
    /* E7CE8 800F74E8 1380083C */  lui        $t0, %hi(D_80136A10)
    /* E7CEC 800F74EC 106A0825 */  addiu      $t0, $t0, %lo(D_80136A10)
    /* E7CF0 800F74F0 000009AD */  sw         $t1, 0x0($t0)
    /* E7CF4 800F74F4 0200A520 */  addi       $a1, $a1, 0x2 /* handwritten instruction */
  .L800F74F8:
    /* E7CF8 800F74F8 3500A011 */  beqz       $t5, .L800F75D0
    /* E7CFC 800F74FC 82450200 */   srl       $t0, $v0, 22
    /* E7D00 800F7500 FF030139 */  xori       $at, $t0, 0x3FF
    /* E7D04 800F7504 85002010 */  beqz       $at, .L800F771C
    /* E7D08 800F7508 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
    /* E7D0C 800F750C FDFFA121 */  addi       $at, $t5, -0x3 /* handwritten instruction */
    /* E7D10 800F7510 02002004 */  bltz       $at, .L800F751C
    /* E7D14 800F7514 00FCC120 */   addi      $at, $a2, -0x400 /* handwritten instruction */
    /* E7D18 800F7518 00FC2120 */  addi       $at, $at, -0x400 /* handwritten instruction */
  .L800F751C:
    /* E7D1C 800F751C 02460200 */  srl        $t0, $v0, 24
    /* E7D20 800F7520 80400800 */  sll        $t0, $t0, 2
    /* E7D24 800F7524 20400101 */  add        $t0, $t0, $at /* handwritten instruction */
    /* E7D28 800F7528 00000995 */  lhu        $t1, 0x0($t0)
    /* E7D2C 800F752C 02000A95 */  lhu        $t2, 0x2($t0)
    /* E7D30 800F7530 24400000 */  and        $t0, $zero, $zero
    /* E7D34 800F7534 0A004011 */  beqz       $t2, .L800F7560
    /* E7D38 800F7538 04102201 */   sllv      $v0, $v0, $t1
    /* E7D3C 800F753C 20000120 */  addi       $at, $zero, 0x20 /* handwritten instruction */
    /* E7D40 800F7540 22082A00 */  sub        $at, $at, $t2 /* handwritten instruction */
    /* E7D44 800F7544 06402200 */  srlv       $t0, $v0, $at
    /* E7D48 800F7548 04004004 */  bltz       $v0, .L800F755C
    /* E7D4C 800F754C 04104201 */   sllv      $v0, $v0, $t2
    /* E7D50 800F7550 FFFF0B20 */  addi       $t3, $zero, -0x1 /* handwritten instruction */
    /* E7D54 800F7554 06582B00 */  srlv       $t3, $t3, $at
    /* E7D58 800F7558 22400B01 */  sub        $t0, $t0, $t3 /* handwritten instruction */
  .L800F755C:
    /* E7D5C 800F755C 20186A00 */  add        $v1, $v1, $t2 /* handwritten instruction */
  .L800F7560:
    /* E7D60 800F7560 20186900 */  add        $v1, $v1, $t1 /* handwritten instruction */
    /* E7D64 800F7564 10006130 */  andi       $at, $v1, 0x10
    /* E7D68 800F7568 05002010 */  beqz       $at, .L800F7580
    /* E7D6C 800F756C 0F006330 */   andi      $v1, $v1, 0xF
    /* E7D70 800F7570 00008994 */  lhu        $t1, 0x0($a0)
    /* E7D74 800F7574 02008420 */  addi       $a0, $a0, 0x2 /* handwritten instruction */
    /* E7D78 800F7578 04486900 */  sllv       $t1, $t1, $v1
    /* E7D7C 800F757C 25104900 */  or         $v0, $v0, $t1
  .L800F7580:
    /* E7D80 800F7580 FEFFA121 */  addi       $at, $t5, -0x2 /* handwritten instruction */
    /* E7D84 800F7584 0800201C */  bgtz       $at, .L800F75A8
    /* E7D88 800F7588 20482803 */   add       $t1, $t9, $t0 /* handwritten instruction */
    /* E7D8C 800F758C 04002010 */  beqz       $at, .L800F75A0
    /* E7D90 800F7590 20480803 */   add       $t1, $t8, $t0 /* handwritten instruction */
    /* E7D94 800F7594 2048E801 */  add        $t1, $t7, $t0 /* handwritten instruction */
    /* E7D98 800F7598 04000010 */  b          .L800F75AC
    /* E7D9C 800F759C 2078E801 */   add       $t7, $t7, $t0 /* handwritten instruction */
  .L800F75A0:
    /* E7DA0 800F75A0 02000010 */  b          .L800F75AC
    /* E7DA4 800F75A4 20C00803 */   add       $t8, $t8, $t0 /* handwritten instruction */
  .L800F75A8:
    /* E7DA8 800F75A8 20C82803 */  add        $t9, $t9, $t0 /* handwritten instruction */
  .L800F75AC:
    /* E7DAC 800F75AC 80480900 */  sll        $t1, $t1, 2
    /* E7DB0 800F75B0 FF032931 */  andi       $t1, $t1, 0x3FF
    /* E7DB4 800F75B4 25488901 */  or         $t1, $t4, $t1
    /* E7DB8 800F75B8 0100AD21 */  addi       $t5, $t5, 0x1 /* handwritten instruction */
    /* E7DBC 800F75BC F9FFA121 */  addi       $at, $t5, -0x7 /* handwritten instruction */
    /* E7DC0 800F75C0 11002014 */  bnez       $at, .L800F7608
    /* E7DC4 800F75C4 0000A9A4 */   sh        $t1, 0x0($a1)
    /* E7DC8 800F75C8 0F000010 */  b          .L800F7608
    /* E7DCC 800F75CC FAFFAD21 */   addi      $t5, $t5, -0x6 /* handwritten instruction */
  .L800F75D0:
    /* E7DD0 800F75D0 FF010139 */  xori       $at, $t0, 0x1FF
    /* E7DD4 800F75D4 51002010 */  beqz       $at, .L800F771C
    /* E7DD8 800F75D8 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
    /* E7DDC 800F75DC 80120200 */  sll        $v0, $v0, 10
    /* E7DE0 800F75E0 0A006320 */  addi       $v1, $v1, 0xA /* handwritten instruction */
    /* E7DE4 800F75E4 10006130 */  andi       $at, $v1, 0x10
    /* E7DE8 800F75E8 05002010 */  beqz       $at, .L800F7600
    /* E7DEC 800F75EC 0F006330 */   andi      $v1, $v1, 0xF
    /* E7DF0 800F75F0 00008994 */  lhu        $t1, 0x0($a0)
    /* E7DF4 800F75F4 02008420 */  addi       $a0, $a0, 0x2 /* handwritten instruction */
    /* E7DF8 800F75F8 04486900 */  sllv       $t1, $t1, $v1
    /* E7DFC 800F75FC 25104900 */  or         $v0, $v0, $t1
  .L800F7600:
    /* E7E00 800F7600 25408801 */  or         $t0, $t4, $t0
    /* E7E04 800F7604 0000A8A4 */  sh         $t0, 0x0($a1)
  .L800F7608:
    /* E7E08 800F7608 2308AE00 */  subu       $at, $a1, $t6
    /* E7E0C 800F760C 4F002104 */  bgez       $at, .L800F774C
    /* E7E10 800F7610 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
  .L800F7614:
    /* E7E14 800F7614 C2440200 */  srl        $t0, $v0, 19
    /* E7E18 800F7618 C0400800 */  sll        $t0, $t0, 3
    /* E7E1C 800F761C 20400601 */  add        $t0, $t0, $a2 /* handwritten instruction */
    /* E7E20 800F7620 0000098D */  lw         $t1, 0x0($t0)
    /* E7E24 800F7624 00000000 */  nop
    /* E7E28 800F7628 11002015 */  bnez       $t1, .L800F7670
    /* E7E2C 800F762C FF002131 */   andi      $at, $t1, 0xFF
    /* E7E30 800F7630 00120200 */  sll        $v0, $v0, 8
    /* E7E34 800F7634 08006320 */  addi       $v1, $v1, 0x8 /* handwritten instruction */
    /* E7E38 800F7638 10006130 */  andi       $at, $v1, 0x10
    /* E7E3C 800F763C 05002010 */  beqz       $at, .L800F7654
    /* E7E40 800F7640 0F006330 */   andi      $v1, $v1, 0xF
    /* E7E44 800F7644 00008894 */  lhu        $t0, 0x0($a0)
    /* E7E48 800F7648 02008420 */  addi       $a0, $a0, 0x2 /* handwritten instruction */
    /* E7E4C 800F764C 04406800 */  sllv       $t0, $t0, $v1
    /* E7E50 800F7650 25104800 */  or         $v0, $v0, $t0
  .L800F7654:
    /* E7E54 800F7654 C2450200 */  srl        $t0, $v0, 23
    /* E7E58 800F7658 80400800 */  sll        $t0, $t0, 2
    /* E7E5C 800F765C 20400701 */  add        $t0, $t0, $a3 /* handwritten instruction */
    /* E7E60 800F7660 0000098D */  lw         $t1, 0x0($t0)
    /* E7E64 800F7664 20580000 */  add        $t3, $zero, $zero /* handwritten instruction */
    /* E7E68 800F7668 02000010 */  b          .L800F7674
    /* E7E6C 800F766C FF002131 */   andi      $at, $t1, 0xFF
  .L800F7670:
    /* E7E70 800F7670 04000B8D */  lw         $t3, 0x4($t0)
  .L800F7674:
    /* E7E74 800F7674 04102200 */  sllv       $v0, $v0, $at
    /* E7E78 800F7678 20186100 */  add        $v1, $v1, $at /* handwritten instruction */
    /* E7E7C 800F767C 10006130 */  andi       $at, $v1, 0x10
    /* E7E80 800F7680 05002010 */  beqz       $at, .L800F7698
    /* E7E84 800F7684 0F006330 */   andi      $v1, $v1, 0xF
    /* E7E88 800F7688 00008894 */  lhu        $t0, 0x0($a0)
    /* E7E8C 800F768C 02008420 */  addi       $a0, $a0, 0x2 /* handwritten instruction */
    /* E7E90 800F7690 04406800 */  sllv       $t0, $t0, $v1
    /* E7E94 800F7694 25104800 */  or         $v0, $v0, $t0
  .L800F7698:
    /* E7E98 800F7698 024C0900 */  srl        $t1, $t1, 16
    /* E7E9C 800F769C 1F7C2139 */  xori       $at, $t1, 0x7C1F
    /* E7EA0 800F76A0 15002010 */  beqz       $at, .L800F76F8
    /* E7EA4 800F76A4 00FE2139 */   xori      $at, $t1, 0xFE00
    /* E7EA8 800F76A8 93FF2010 */  beqz       $at, .L800F74F8
    /* E7EAC 800F76AC 0000A9A4 */   sh        $t1, 0x0($a1)
    /* E7EB0 800F76B0 D8FF6011 */  beqz       $t3, .L800F7614
    /* E7EB4 800F76B4 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
    /* E7EB8 800F76B8 FFFF6A31 */  andi       $t2, $t3, 0xFFFF
    /* E7EBC 800F76BC 1F7C4139 */  xori       $at, $t2, 0x7C1F
    /* E7EC0 800F76C0 0D002010 */  beqz       $at, .L800F76F8
    /* E7EC4 800F76C4 00FE4139 */   xori      $at, $t2, 0xFE00
    /* E7EC8 800F76C8 8BFF2010 */  beqz       $at, .L800F74F8
    /* E7ECC 800F76CC 0000AAA4 */   sh        $t2, 0x0($a1)
    /* E7ED0 800F76D0 02540B00 */  srl        $t2, $t3, 16
    /* E7ED4 800F76D4 CFFF4011 */  beqz       $t2, .L800F7614
    /* E7ED8 800F76D8 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
    /* E7EDC 800F76DC 1F7C4139 */  xori       $at, $t2, 0x7C1F
    /* E7EE0 800F76E0 05002010 */  beqz       $at, .L800F76F8
    /* E7EE4 800F76E4 00FE4139 */   xori      $at, $t2, 0xFE00
    /* E7EE8 800F76E8 83FF2010 */  beqz       $at, .L800F74F8
    /* E7EEC 800F76EC 0000AAA4 */   sh        $t2, 0x0($a1)
    /* E7EF0 800F76F0 C8FF0010 */  b          .L800F7614
    /* E7EF4 800F76F4 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
  .L800F76F8:
    /* E7EF8 800F76F8 02440200 */  srl        $t0, $v0, 16
    /* E7EFC 800F76FC 0000A8A4 */  sh         $t0, 0x0($a1)
    /* E7F00 800F7700 0200A520 */  addi       $a1, $a1, 0x2 /* handwritten instruction */
    /* E7F04 800F7704 00008894 */  lhu        $t0, 0x0($a0)
    /* E7F08 800F7708 02008420 */  addi       $a0, $a0, 0x2 /* handwritten instruction */
    /* E7F0C 800F770C 00140200 */  sll        $v0, $v0, 16
    /* E7F10 800F7710 04406800 */  sllv       $t0, $t0, $v1
    /* E7F14 800F7714 BFFF0010 */  b          .L800F7614
    /* E7F18 800F7718 25104800 */   or        $v0, $v0, $t0
  .L800F771C:
    /* E7F1C 800F771C 1380083C */  lui        $t0, %hi(D_80136A10)
    /* E7F20 800F7720 106A0825 */  addiu      $t0, $t0, %lo(D_80136A10)
    /* E7F24 800F7724 0000098D */  lw         $t1, 0x0($t0)
    /* E7F28 800F7728 00FE0834 */  ori        $t0, $zero, 0xFE00
  .L800F772C:
    /* E7F2C 800F772C 2308A900 */  subu       $at, $a1, $t1
    /* E7F30 800F7730 04002104 */  bgez       $at, .L800F7744
    /* E7F34 800F7734 00000000 */   nop
    /* E7F38 800F7738 0000A8A4 */  sh         $t0, 0x0($a1)
    /* E7F3C 800F773C FBFF0010 */  b          .L800F772C
    /* E7F40 800F7740 0200A520 */   addi      $a1, $a1, 0x2 /* handwritten instruction */
  .L800F7744:
    /* E7F44 800F7744 0800E003 */  jr         $ra
    /* E7F48 800F7748 20100000 */   add       $v0, $zero, $zero /* handwritten instruction */
  .L800F774C:
    /* E7F4C 800F774C 1380083C */  lui        $t0, %hi(D_801369EC)
    /* E7F50 800F7750 EC690825 */  addiu      $t0, $t0, %lo(D_801369EC)
    /* E7F54 800F7754 000004AD */  sw         $a0, 0x0($t0)
    /* E7F58 800F7758 040005AD */  sw         $a1, 0x4($t0)
    /* E7F5C 800F775C 080002AD */  sw         $v0, 0x8($t0)
    /* E7F60 800F7760 0C0003AD */  sw         $v1, 0xC($t0)
    /* E7F64 800F7764 10000CAD */  sw         $t4, 0x10($t0)
    /* E7F68 800F7768 14000DAD */  sw         $t5, 0x14($t0)
    /* E7F6C 800F776C 18000FAD */  sw         $t7, 0x18($t0)
    /* E7F70 800F7770 1C0018AD */  sw         $t8, 0x1C($t0)
    /* E7F74 800F7774 200019AD */  sw         $t9, 0x20($t0)
    /* E7F78 800F7778 0800E003 */  jr         $ra
    /* E7F7C 800F777C 01000220 */   addi      $v0, $zero, 0x1 /* handwritten instruction */
endlabel DecDCTvlc
