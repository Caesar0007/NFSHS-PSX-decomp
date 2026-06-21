.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_GoToCarSelect__FR12tMenuCommand, 0x394

glabel MenuExtended_GoToCarSelect__FR12tMenuCommand
    /* 1CCFC 8002C4FC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 1CD00 8002C500 4800B2AF */  sw         $s2, 0x48($sp)
    /* 1CD04 8002C504 21908000 */  addu       $s2, $a0, $zero
    /* 1CD08 8002C508 1180043C */  lui        $a0, %hi(trackManager)
    /* 1CD0C 8002C50C 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 1CD10 8002C510 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CD14 8002C514 4000B0AF */  sw         $s0, 0x40($sp)
    /* 1CD18 8002C518 00465024 */  addiu      $s0, $v0, %lo(frontEnd)
    /* 1CD1C 8002C51C 0580033C */  lui        $v1, %hi(FEApp)
    /* 1CD20 8002C520 1000A627 */  addiu      $a2, $sp, 0x10
    /* 1CD24 8002C524 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 1CD28 8002C528 4400B1AF */  sw         $s1, 0x44($sp)
    /* 1CD2C 8002C52C 46000292 */  lbu        $v0, 0x46($s0)
    /* 1CD30 8002C530 C014638C */  lw         $v1, %lo(FEApp)($v1)
    /* 1CD34 8002C534 21105000 */  addu       $v0, $v0, $s0
    /* 1CD38 8002C538 23004590 */  lbu        $a1, 0x23($v0)
    /* 1CD3C 8002C53C A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 1CD40 8002C540 2C007124 */   addiu     $s1, $v1, 0x2C
    /* 1CD44 8002C544 1300A293 */  lbu        $v0, 0x13($sp)
    /* 1CD48 8002C548 00000000 */  nop
    /* 1CD4C 8002C54C 08004014 */  bnez       $v0, .L8002C570
    /* 1CD50 8002C550 01000324 */   addiu     $v1, $zero, 0x1
    /* 1CD54 8002C554 94E4020C */  jal        TextSys_Word__Fi
    /* 1CD58 8002C558 EB000424 */   addiu     $a0, $zero, 0xEB
    /* 1CD5C 8002C55C 900022AE */  sw         $v0, 0x90($s1)
    /* 1CD60 8002C560 1062000C */  jal        Display__11tDialogBase
    /* 1CD64 8002C564 21202002 */   addu      $a0, $s1, $zero
    /* 1CD68 8002C568 1EB20008 */  j          .L8002C878
    /* 1CD6C 8002C56C 00000000 */   nop
  .L8002C570:
    /* 1CD70 8002C570 03000292 */  lbu        $v0, 0x3($s0)
    /* 1CD74 8002C574 00000000 */  nop
    /* 1CD78 8002C578 19004314 */  bne        $v0, $v1, .L8002C5E0
    /* 1CD7C 8002C57C 03000224 */   addiu     $v0, $zero, 0x3
    /* 1CD80 8002C580 000042AE */  sw         $v0, 0x0($s2)
    /* 1CD84 8002C584 04000392 */  lbu        $v1, 0x4($s0)
    /* 1CD88 8002C588 06000224 */  addiu      $v0, $zero, 0x6
    /* 1CD8C 8002C58C 0F006210 */  beq        $v1, $v0, .L8002C5CC
    /* 1CD90 8002C590 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CD94 8002C594 2A010292 */  lbu        $v0, 0x12A($s0)
    /* 1CD98 8002C598 00000000 */  nop
    /* 1CD9C 8002C59C 06004014 */  bnez       $v0, .L8002C5B8
    /* 1CDA0 8002C5A0 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CDA4 8002C5A4 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CDA8 8002C5A8 00000000 */  nop
    /* 1CDAC 8002C5AC C0164224 */  addiu      $v0, $v0, 0x16C0
    /* 1CDB0 8002C5B0 A0B10008 */  j          .L8002C680
    /* 1CDB4 8002C5B4 040042AE */   sw        $v0, 0x4($s2)
  .L8002C5B8:
    /* 1CDB8 8002C5B8 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CDBC 8002C5BC 00000000 */  nop
    /* 1CDC0 8002C5C0 88184224 */  addiu      $v0, $v0, 0x1888
    /* 1CDC4 8002C5C4 A0B10008 */  j          .L8002C680
    /* 1CDC8 8002C5C8 040042AE */   sw        $v0, 0x4($s2)
  .L8002C5CC:
    /* 1CDCC 8002C5CC 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CDD0 8002C5D0 00000000 */  nop
    /* 1CDD4 8002C5D4 441A4224 */  addiu      $v0, $v0, 0x1A44
    /* 1CDD8 8002C5D8 A0B10008 */  j          .L8002C680
    /* 1CDDC 8002C5DC 040042AE */   sw        $v0, 0x4($s2)
  .L8002C5E0:
    /* 1CDE0 8002C5E0 1E030292 */  lbu        $v0, 0x31E($s0)
    /* 1CDE4 8002C5E4 00000000 */  nop
    /* 1CDE8 8002C5E8 11004314 */  bne        $v0, $v1, .L8002C630
    /* 1CDEC 8002C5EC 00000000 */   nop
    /* 1CDF0 8002C5F0 000043AE */  sw         $v1, 0x0($s2)
    /* 1CDF4 8002C5F4 04000292 */  lbu        $v0, 0x4($s0)
    /* 1CDF8 8002C5F8 00000000 */  nop
    /* 1CDFC 8002C5FC 04004314 */  bne        $v0, $v1, .L8002C610
    /* 1CE00 8002C600 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CE04 8002C604 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CE08 8002C608 87B10008 */  j          .L8002C61C
    /* 1CE0C 8002C60C C8154224 */   addiu     $v0, $v0, 0x15C8
  .L8002C610:
    /* 1CE10 8002C610 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CE14 8002C614 00000000 */  nop
    /* 1CE18 8002C618 4C154224 */  addiu      $v0, $v0, 0x154C
  .L8002C61C:
    /* 1CE1C 8002C61C 040042AE */  sw         $v0, 0x4($s2)
    /* 1CE20 8002C620 0580023C */  lui        $v0, %hi(screenCarSelectDuel)
    /* 1CE24 8002C624 4020448C */  lw         $a0, %lo(screenCarSelectDuel)($v0)
    /* 1CE28 8002C628 9EB10008 */  j          .L8002C678
    /* 1CE2C 8002C62C 07000524 */   addiu     $a1, $zero, 0x7
  .L8002C630:
    /* 1CE30 8002C630 000043AE */  sw         $v1, 0x0($s2)
    /* 1CE34 8002C634 2A010292 */  lbu        $v0, 0x12A($s0)
    /* 1CE38 8002C638 00000000 */  nop
    /* 1CE3C 8002C63C 08004014 */  bnez       $v0, .L8002C660
    /* 1CE40 8002C640 01000524 */   addiu     $a1, $zero, 0x1
    /* 1CE44 8002C644 21280000 */  addu       $a1, $zero, $zero
    /* 1CE48 8002C648 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1CE4C 8002C64C 0580033C */  lui        $v1, %hi(screenCarSelect)
    /* 1CE50 8002C650 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CE54 8002C654 3C20648C */  lw         $a0, %lo(screenCarSelect)($v1)
    /* 1CE58 8002C658 9DB10008 */  j          .L8002C674
    /* 1CE5C 8002C65C 50124224 */   addiu     $v0, $v0, 0x1250
  .L8002C660:
    /* 1CE60 8002C660 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1CE64 8002C664 0580033C */  lui        $v1, %hi(screenCarSelect)
    /* 1CE68 8002C668 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CE6C 8002C66C 3C20648C */  lw         $a0, %lo(screenCarSelect)($v1)
    /* 1CE70 8002C670 68134224 */  addiu      $v0, $v0, 0x1368
  .L8002C674:
    /* 1CE74 8002C674 040042AE */  sw         $v0, 0x4($s2)
  .L8002C678:
    /* 1CE78 8002C678 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1CE7C 8002C67C 00000000 */   nop
  .L8002C680:
    /* 1CE80 8002C680 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CE84 8002C684 00464424 */  addiu      $a0, $v0, %lo(frontEnd)
    /* 1CE88 8002C688 04008390 */  lbu        $v1, 0x4($a0)
    /* 1CE8C 8002C68C 01000224 */  addiu      $v0, $zero, 0x1
    /* 1CE90 8002C690 05006210 */  beq        $v1, $v0, .L8002C6A8
    /* 1CE94 8002C694 06000224 */   addiu     $v0, $zero, 0x6
    /* 1CE98 8002C698 12006210 */  beq        $v1, $v0, .L8002C6E4
    /* 1CE9C 8002C69C 1180023C */   lui       $v0, %hi(frontEnd)
    /* 1CEA0 8002C6A0 BEB10008 */  j          .L8002C6F8
    /* 1CEA4 8002C6A4 00464324 */   addiu     $v1, $v0, %lo(frontEnd)
  .L8002C6A8:
    /* 1CEA8 8002C6A8 1E038290 */  lbu        $v0, 0x31E($a0)
    /* 1CEAC 8002C6AC 00000000 */  nop
    /* 1CEB0 8002C6B0 05004010 */  beqz       $v0, .L8002C6C8
    /* 1CEB4 8002C6B4 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CEB8 8002C6B8 03008290 */  lbu        $v0, 0x3($a0)
    /* 1CEBC 8002C6BC 00000000 */  nop
    /* 1CEC0 8002C6C0 05004314 */  bne        $v0, $v1, .L8002C6D8
    /* 1CEC4 8002C6C4 0580023C */   lui       $v0, %hi(menuDefs)
  .L8002C6C8:
    /* 1CEC8 8002C6C8 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1CECC 8002C6CC 09000224 */  addiu      $v0, $zero, 0x9
    /* 1CED0 8002C6D0 D1B10008 */  j          .L8002C744
    /* 1CED4 8002C6D4 7C1162AC */   sw        $v0, 0x117C($v1)
  .L8002C6D8:
    /* 1CED8 8002C6D8 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CEDC 8002C6DC D1B10008 */  j          .L8002C744
    /* 1CEE0 8002C6E0 7C1143AC */   sw        $v1, 0x117C($v0)
  .L8002C6E4:
    /* 1CEE4 8002C6E4 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1CEE8 8002C6E8 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1CEEC 8002C6EC 20000224 */  addiu      $v0, $zero, 0x20
    /* 1CEF0 8002C6F0 D1B10008 */  j          .L8002C744
    /* 1CEF4 8002C6F4 E41962AC */   sw        $v0, 0x19E4($v1)
  .L8002C6F8:
    /* 1CEF8 8002C6F8 2A016290 */  lbu        $v0, 0x12A($v1)
    /* 1CEFC 8002C6FC 00000000 */  nop
    /* 1CF00 8002C700 05004014 */  bnez       $v0, .L8002C718
    /* 1CF04 8002C704 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CF08 8002C708 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1CF0C 8002C70C 01000224 */  addiu      $v0, $zero, 0x1
    /* 1CF10 8002C710 D1B10008 */  j          .L8002C744
    /* 1CF14 8002C714 7C1162AC */   sw        $v0, 0x117C($v1)
  .L8002C718:
    /* 1CF18 8002C718 04006290 */  lbu        $v0, 0x4($v1)
    /* 1CF1C 8002C71C 02000324 */  addiu      $v1, $zero, 0x2
    /* 1CF20 8002C720 05004314 */  bne        $v0, $v1, .L8002C738
    /* 1CF24 8002C724 0580023C */   lui       $v0, %hi(menuDefs)
    /* 1CF28 8002C728 581A438C */  lw         $v1, %lo(menuDefs)($v0)
    /* 1CF2C 8002C72C 40000224 */  addiu      $v0, $zero, 0x40
    /* 1CF30 8002C730 D1B10008 */  j          .L8002C744
    /* 1CF34 8002C734 DC1262AC */   sw        $v0, 0x12DC($v1)
  .L8002C738:
    /* 1CF38 8002C738 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1CF3C 8002C73C 00000000 */  nop
    /* 1CF40 8002C740 DC1243AC */  sw         $v1, 0x12DC($v0)
  .L8002C744:
    /* 1CF44 8002C744 1180023C */  lui        $v0, %hi(frontEnd)
    /* 1CF48 8002C748 00465124 */  addiu      $s1, $v0, %lo(frontEnd)
    /* 1CF4C 8002C74C 2A012292 */  lbu        $v0, 0x12A($s1)
    /* 1CF50 8002C750 00000000 */  nop
    /* 1CF54 8002C754 11004014 */  bnez       $v0, .L8002C79C
    /* 1CF58 8002C758 0580103C */   lui       $s0, %hi(menuDefs)
    /* 1CF5C 8002C75C 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CF60 8002C760 21280000 */  addu       $a1, $zero, $zero
    /* 1CF64 8002C764 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1CF68 8002C768 6C118424 */   addiu     $a0, $a0, 0x116C
    /* 1CF6C 8002C76C 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CF70 8002C770 21280000 */  addu       $a1, $zero, $zero
    /* 1CF74 8002C774 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1CF78 8002C778 6C118424 */   addiu     $a0, $a0, 0x116C
    /* 1CF7C 8002C77C 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CF80 8002C780 01000524 */  addiu      $a1, $zero, 0x1
    /* 1CF84 8002C784 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1CF88 8002C788 6C118424 */   addiu     $a0, $a0, 0x116C
    /* 1CF8C 8002C78C 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CF90 8002C790 01000524 */  addiu      $a1, $zero, 0x1
    /* 1CF94 8002C794 08B20008 */  j          .L8002C820
    /* 1CF98 8002C798 6C118424 */   addiu     $a0, $a0, 0x116C
  .L8002C79C:
    /* 1CF9C 8002C79C 1180043C */  lui        $a0, %hi(carManager)
    /* 1CFA0 8002C7A0 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 1CFA4 8002C7A4 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 1CFA8 8002C7A8 21280000 */   addu      $a1, $zero, $zero
    /* 1CFAC 8002C7AC 00140200 */  sll        $v0, $v0, 16
    /* 1CFB0 8002C7B0 0900401C */  bgtz       $v0, .L8002C7D8
    /* 1CFB4 8002C7B4 0580103C */   lui       $s0, %hi(menuDefs)
    /* 1CFB8 8002C7B8 04002392 */  lbu        $v1, 0x4($s1)
    /* 1CFBC 8002C7BC 01000224 */  addiu      $v0, $zero, 0x1
    /* 1CFC0 8002C7C0 1A006214 */  bne        $v1, $v0, .L8002C82C
    /* 1CFC4 8002C7C4 1180023C */   lui       $v0, %hi(D_8011491E)
    /* 1CFC8 8002C7C8 1E032292 */  lbu        $v0, 0x31E($s1)
    /* 1CFCC 8002C7CC 00000000 */  nop
    /* 1CFD0 8002C7D0 1A004310 */  beq        $v0, $v1, .L8002C83C
    /* 1CFD4 8002C7D4 1180023C */   lui       $v0, %hi(D_80114604)
  .L8002C7D8:
    /* 1CFD8 8002C7D8 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CFDC 8002C7DC 21280000 */  addu       $a1, $zero, $zero
    /* 1CFE0 8002C7E0 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1CFE4 8002C7E4 CC128424 */   addiu     $a0, $a0, 0x12CC
    /* 1CFE8 8002C7E8 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1CFEC 8002C7EC 21280000 */  addu       $a1, $zero, $zero
    /* 1CFF0 8002C7F0 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1CFF4 8002C7F4 CC128424 */   addiu     $a0, $a0, 0x12CC
    /* 1CFF8 8002C7F8 03002392 */  lbu        $v1, 0x3($s1)
    /* 1CFFC 8002C7FC 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D000 8002C800 09006214 */  bne        $v1, $v0, .L8002C828
    /* 1D004 8002C804 21284000 */   addu      $a1, $v0, $zero
    /* 1D008 8002C808 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D00C 8002C80C 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1D010 8002C810 CC128424 */   addiu     $a0, $a0, 0x12CC
    /* 1D014 8002C814 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D018 8002C818 01000524 */  addiu      $a1, $zero, 0x1
    /* 1D01C 8002C81C CC128424 */  addiu      $a0, $a0, 0x12CC
  .L8002C820:
    /* 1D020 8002C820 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1D024 8002C824 00000000 */   nop
  .L8002C828:
    /* 1D028 8002C828 1180023C */  lui        $v0, %hi(D_8011491E)
  .L8002C82C:
    /* 1D02C 8002C82C 1E494390 */  lbu        $v1, %lo(D_8011491E)($v0)
    /* 1D030 8002C830 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D034 8002C834 10006214 */  bne        $v1, $v0, .L8002C878
    /* 1D038 8002C838 1180023C */   lui       $v0, %hi(D_80114604)
  .L8002C83C:
    /* 1D03C 8002C83C 04464390 */  lbu        $v1, %lo(D_80114604)($v0)
    /* 1D040 8002C840 02000224 */  addiu      $v0, $zero, 0x2
    /* 1D044 8002C844 0C006210 */  beq        $v1, $v0, .L8002C878
    /* 1D048 8002C848 0580103C */   lui       $s0, %hi(menuDefs)
    /* 1D04C 8002C84C 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D050 8002C850 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1D054 8002C854 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 1D058 8002C858 60148424 */   addiu     $a0, $a0, 0x1460
    /* 1D05C 8002C85C 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 1D060 8002C860 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 1D064 8002C864 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 1D068 8002C868 60148424 */   addiu     $a0, $a0, 0x1460
    /* 1D06C 8002C86C 581A038E */  lw         $v1, %lo(menuDefs)($s0)
    /* 1D070 8002C870 01000224 */  addiu      $v0, $zero, 0x1
    /* 1D074 8002C874 701462AC */  sw         $v0, 0x1470($v1)
  .L8002C878:
    /* 1D078 8002C878 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 1D07C 8002C87C 4800B28F */  lw         $s2, 0x48($sp)
    /* 1D080 8002C880 4400B18F */  lw         $s1, 0x44($sp)
    /* 1D084 8002C884 4000B08F */  lw         $s0, 0x40($sp)
    /* 1D088 8002C888 0800E003 */  jr         $ra
    /* 1D08C 8002C88C 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel MenuExtended_GoToCarSelect__FR12tMenuCommand
