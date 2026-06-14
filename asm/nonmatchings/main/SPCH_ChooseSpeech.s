.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_ChooseSpeech, 0x124

glabel SPCH_ChooseSpeech
    /* D7E84 800E7684 1580023C */  lui        $v0, %hi(gVoxEvents)
    /* D7E88 800E7688 6080438C */  lw         $v1, %lo(gVoxEvents)($v0)
    /* D7E8C 800E768C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D7E90 800E7690 1800B2AF */  sw         $s2, 0x18($sp)
    /* D7E94 800E7694 21900000 */  addu       $s2, $zero, $zero
    /* D7E98 800E7698 1000B0AF */  sw         $s0, 0x10($sp)
    /* D7E9C 800E769C 60805024 */  addiu      $s0, $v0, %lo(gVoxEvents)
    /* D7EA0 800E76A0 2800BFAF */  sw         $ra, 0x28($sp)
    /* D7EA4 800E76A4 2400B5AF */  sw         $s5, 0x24($sp)
    /* D7EA8 800E76A8 2000B4AF */  sw         $s4, 0x20($sp)
    /* D7EAC 800E76AC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D7EB0 800E76B0 33006010 */  beqz       $v1, .L800E7780
    /* D7EB4 800E76B4 1400B1AF */   sw        $s1, 0x14($sp)
    /* D7EB8 800E76B8 C09C030C */  jal        iSPCH_ChooseEvent
    /* D7EBC 800E76BC 00000000 */   nop
    /* D7EC0 800E76C0 21A04000 */  addu       $s4, $v0, $zero
    /* D7EC4 800E76C4 2F008006 */  bltz       $s4, .L800E7784
    /* D7EC8 800E76C8 21104002 */   addu      $v0, $s2, $zero
    /* D7ECC 800E76CC 4A9D030C */  jal        iSPCH_ClearOldEvents
    /* D7ED0 800E76D0 21208002 */   addu      $a0, $s4, $zero
    /* D7ED4 800E76D4 00111400 */  sll        $v0, $s4, 4
    /* D7ED8 800E76D8 23105400 */  subu       $v0, $v0, $s4
    /* D7EDC 800E76DC 80100200 */  sll        $v0, $v0, 2
    /* D7EE0 800E76E0 14000326 */  addiu      $v1, $s0, 0x14
    /* D7EE4 800E76E4 21984300 */  addu       $s3, $v0, $v1
    /* D7EE8 800E76E8 D505040C */  jal        iSPCH_ChooseSentence
    /* D7EEC 800E76EC 21206002 */   addu      $a0, $s3, $zero
    /* D7EF0 800E76F0 21904000 */  addu       $s2, $v0, $zero
    /* D7EF4 800E76F4 15004016 */  bnez       $s2, .L800E774C
    /* D7EF8 800E76F8 1380033C */   lui       $v1, %hi(gReparm)
    /* D7EFC 800E76FC A070628C */  lw         $v0, %lo(gReparm)($v1)
    /* D7F00 800E7700 00000000 */  nop
    /* D7F04 800E7704 11004010 */  beqz       $v0, .L800E774C
    /* D7F08 800E7708 21880000 */   addu      $s1, $zero, $zero
    /* D7F0C 800E770C 21A86000 */  addu       $s5, $v1, $zero
  .L800E7710:
    /* D7F10 800E7710 21202002 */  addu       $a0, $s1, $zero
    /* D7F14 800E7714 A070A28E */  lw         $v0, %lo(gReparm)($s5)
    /* D7F18 800E7718 00000000 */  nop
    /* D7F1C 800E771C 09F84000 */  jalr       $v0
    /* D7F20 800E7720 21286002 */   addu      $a1, $s3, $zero
    /* D7F24 800E7724 21804000 */  addu       $s0, $v0, $zero
    /* D7F28 800E7728 04000006 */  bltz       $s0, .L800E773C
    /* D7F2C 800E772C 00000000 */   nop
    /* D7F30 800E7730 D505040C */  jal        iSPCH_ChooseSentence
    /* D7F34 800E7734 21206002 */   addu      $a0, $s3, $zero
    /* D7F38 800E7738 21904000 */  addu       $s2, $v0, $zero
  .L800E773C:
    /* D7F3C 800E773C 03004016 */  bnez       $s2, .L800E774C
    /* D7F40 800E7740 01003126 */   addiu     $s1, $s1, 0x1
    /* D7F44 800E7744 F2FF001E */  bgtz       $s0, .L800E7710
    /* D7F48 800E7748 00000000 */   nop
  .L800E774C:
    /* D7F4C 800E774C 02004106 */  bgez       $s2, .L800E7758
    /* D7F50 800E7750 1580033C */   lui       $v1, %hi(gVoxEvents)
    /* D7F54 800E7754 21900000 */  addu       $s2, $zero, $zero
  .L800E7758:
    /* D7F58 800E7758 6080628C */  lw         $v0, %lo(gVoxEvents)($v1)
    /* D7F5C 800E775C 00000000 */  nop
    /* D7F60 800E7760 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D7F64 800E7764 608062AC */  sw         $v0, %lo(gVoxEvents)($v1)
    /* D7F68 800E7768 60806324 */  addiu      $v1, $v1, %lo(gVoxEvents)
    /* D7F6C 800E776C 00111400 */  sll        $v0, $s4, 4
    /* D7F70 800E7770 23105400 */  subu       $v0, $v0, $s4
    /* D7F74 800E7774 80100200 */  sll        $v0, $v0, 2
    /* D7F78 800E7778 21104300 */  addu       $v0, $v0, $v1
    /* D7F7C 800E777C 080040A4 */  sh         $zero, 0x8($v0)
  .L800E7780:
    /* D7F80 800E7780 21104002 */  addu       $v0, $s2, $zero
  .L800E7784:
    /* D7F84 800E7784 2800BF8F */  lw         $ra, 0x28($sp)
    /* D7F88 800E7788 2400B58F */  lw         $s5, 0x24($sp)
    /* D7F8C 800E778C 2000B48F */  lw         $s4, 0x20($sp)
    /* D7F90 800E7790 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D7F94 800E7794 1800B28F */  lw         $s2, 0x18($sp)
    /* D7F98 800E7798 1400B18F */  lw         $s1, 0x14($sp)
    /* D7F9C 800E779C 1000B08F */  lw         $s0, 0x10($sp)
    /* D7FA0 800E77A0 0800E003 */  jr         $ra
    /* D7FA4 800E77A4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SPCH_ChooseSpeech
