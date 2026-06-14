.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi, 0x1F8

glabel Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
    /* 81ED4 800916D4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 81ED8 800916D8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 81EDC 800916DC 21908000 */  addu       $s2, $a0, $zero
    /* 81EE0 800916E0 3000BFAF */  sw         $ra, 0x30($sp)
    /* 81EE4 800916E4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 81EE8 800916E8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 81EEC 800916EC 2000B0AF */  sw         $s0, 0x20($sp)
    /* 81EF0 800916F0 0000A48C */  lw         $a0, 0x0($a1)
    /* 81EF4 800916F4 A000428E */  lw         $v0, 0xA0($s2)
    /* 81EF8 800916F8 00000000 */  nop
    /* 81EFC 800916FC 23208200 */  subu       $a0, $a0, $v0
    /* 81F00 80091700 1000A4AF */  sw         $a0, 0x10($sp)
    /* 81F04 80091704 0800A28C */  lw         $v0, 0x8($a1)
    /* 81F08 80091708 A800438E */  lw         $v1, 0xA8($s2)
    /* 81F0C 8009170C 1400A0AF */  sw         $zero, 0x14($sp)
    /* 81F10 80091710 23104300 */  subu       $v0, $v0, $v1
    /* 81F14 80091714 1800A2AF */  sw         $v0, 0x18($sp)
    /* 81F18 80091718 F000458E */  lw         $a1, 0xF0($s2)
    /* 81F1C 8009171C CA90030C */  jal        fixedmult
    /* 81F20 80091720 2198C000 */   addu      $s3, $a2, $zero
    /* 81F24 80091724 1400A48F */  lw         $a0, 0x14($sp)
    /* 81F28 80091728 F400458E */  lw         $a1, 0xF4($s2)
    /* 81F2C 8009172C CA90030C */  jal        fixedmult
    /* 81F30 80091730 21804000 */   addu      $s0, $v0, $zero
    /* 81F34 80091734 1800A48F */  lw         $a0, 0x18($sp)
    /* 81F38 80091738 F800458E */  lw         $a1, 0xF8($s2)
    /* 81F3C 8009173C CA90030C */  jal        fixedmult
    /* 81F40 80091740 21884000 */   addu      $s1, $v0, $zero
    /* 81F44 80091744 21801102 */  addu       $s0, $s0, $s1
    /* 81F48 80091748 21800202 */  addu       $s0, $s0, $v0
    /* 81F4C 8009174C 1000001A */  blez       $s0, .L80091790
    /* 81F50 80091750 00000000 */   nop
    /* 81F54 80091754 1000A48F */  lw         $a0, 0x10($sp)
    /* 81F58 80091758 F000458E */  lw         $a1, 0xF0($s2)
    /* 81F5C 8009175C CA90030C */  jal        fixedmult
    /* 81F60 80091760 00000000 */   nop
    /* 81F64 80091764 1400A48F */  lw         $a0, 0x14($sp)
    /* 81F68 80091768 F400458E */  lw         $a1, 0xF4($s2)
    /* 81F6C 8009176C CA90030C */  jal        fixedmult
    /* 81F70 80091770 21804000 */   addu      $s0, $v0, $zero
    /* 81F74 80091774 1800A48F */  lw         $a0, 0x18($sp)
    /* 81F78 80091778 F800458E */  lw         $a1, 0xF8($s2)
    /* 81F7C 8009177C CA90030C */  jal        fixedmult
    /* 81F80 80091780 21884000 */   addu      $s1, $v0, $zero
    /* 81F84 80091784 21801102 */  addu       $s0, $s0, $s1
    /* 81F88 80091788 F3450208 */  j          .L800917CC
    /* 81F8C 8009178C 21800202 */   addu      $s0, $s0, $v0
  .L80091790:
    /* 81F90 80091790 1000A48F */  lw         $a0, 0x10($sp)
    /* 81F94 80091794 F000458E */  lw         $a1, 0xF0($s2)
    /* 81F98 80091798 CA90030C */  jal        fixedmult
    /* 81F9C 8009179C 00000000 */   nop
    /* 81FA0 800917A0 1400A48F */  lw         $a0, 0x14($sp)
    /* 81FA4 800917A4 F400458E */  lw         $a1, 0xF4($s2)
    /* 81FA8 800917A8 CA90030C */  jal        fixedmult
    /* 81FAC 800917AC 21804000 */   addu      $s0, $v0, $zero
    /* 81FB0 800917B0 1800A48F */  lw         $a0, 0x18($sp)
    /* 81FB4 800917B4 F800458E */  lw         $a1, 0xF8($s2)
    /* 81FB8 800917B8 CA90030C */  jal        fixedmult
    /* 81FBC 800917BC 21884000 */   addu      $s1, $v0, $zero
    /* 81FC0 800917C0 21801102 */  addu       $s0, $s0, $s1
    /* 81FC4 800917C4 21800202 */  addu       $s0, $s0, $v0
    /* 81FC8 800917C8 23801000 */  negu       $s0, $s0
  .L800917CC:
    /* 81FCC 800917CC 3401428E */  lw         $v0, 0x134($s2)
    /* 81FD0 800917D0 00000000 */  nop
    /* 81FD4 800917D4 21105300 */  addu       $v0, $v0, $s3
    /* 81FD8 800917D8 2A105000 */  slt        $v0, $v0, $s0
    /* 81FDC 800917DC 34004014 */  bnez       $v0, .L800918B0
    /* 81FE0 800917E0 21100000 */   addu      $v0, $zero, $zero
    /* 81FE4 800917E4 1000A48F */  lw         $a0, 0x10($sp)
    /* 81FE8 800917E8 0801458E */  lw         $a1, 0x108($s2)
    /* 81FEC 800917EC CA90030C */  jal        fixedmult
    /* 81FF0 800917F0 00000000 */   nop
    /* 81FF4 800917F4 1400A48F */  lw         $a0, 0x14($sp)
    /* 81FF8 800917F8 0C01458E */  lw         $a1, 0x10C($s2)
    /* 81FFC 800917FC CA90030C */  jal        fixedmult
    /* 82000 80091800 21804000 */   addu      $s0, $v0, $zero
    /* 82004 80091804 1800A48F */  lw         $a0, 0x18($sp)
    /* 82008 80091808 1001458E */  lw         $a1, 0x110($s2)
    /* 8200C 8009180C CA90030C */  jal        fixedmult
    /* 82010 80091810 21884000 */   addu      $s1, $v0, $zero
    /* 82014 80091814 21801102 */  addu       $s0, $s0, $s1
    /* 82018 80091818 21800202 */  addu       $s0, $s0, $v0
    /* 8201C 8009181C 1000001A */  blez       $s0, .L80091860
    /* 82020 80091820 00000000 */   nop
    /* 82024 80091824 1000A48F */  lw         $a0, 0x10($sp)
    /* 82028 80091828 0801458E */  lw         $a1, 0x108($s2)
    /* 8202C 8009182C CA90030C */  jal        fixedmult
    /* 82030 80091830 00000000 */   nop
    /* 82034 80091834 1400A48F */  lw         $a0, 0x14($sp)
    /* 82038 80091838 0C01458E */  lw         $a1, 0x10C($s2)
    /* 8203C 8009183C CA90030C */  jal        fixedmult
    /* 82040 80091840 21804000 */   addu      $s0, $v0, $zero
    /* 82044 80091844 1800A48F */  lw         $a0, 0x18($sp)
    /* 82048 80091848 1001458E */  lw         $a1, 0x110($s2)
    /* 8204C 8009184C CA90030C */  jal        fixedmult
    /* 82050 80091850 21884000 */   addu      $s1, $v0, $zero
    /* 82054 80091854 21801102 */  addu       $s0, $s0, $s1
    /* 82058 80091858 27460208 */  j          .L8009189C
    /* 8205C 8009185C 21800202 */   addu      $s0, $s0, $v0
  .L80091860:
    /* 82060 80091860 1000A48F */  lw         $a0, 0x10($sp)
    /* 82064 80091864 0801458E */  lw         $a1, 0x108($s2)
    /* 82068 80091868 CA90030C */  jal        fixedmult
    /* 8206C 8009186C 00000000 */   nop
    /* 82070 80091870 1400A48F */  lw         $a0, 0x14($sp)
    /* 82074 80091874 0C01458E */  lw         $a1, 0x10C($s2)
    /* 82078 80091878 CA90030C */  jal        fixedmult
    /* 8207C 8009187C 21804000 */   addu      $s0, $v0, $zero
    /* 82080 80091880 1800A48F */  lw         $a0, 0x18($sp)
    /* 82084 80091884 1001458E */  lw         $a1, 0x110($s2)
    /* 82088 80091888 CA90030C */  jal        fixedmult
    /* 8208C 8009188C 21884000 */   addu      $s1, $v0, $zero
    /* 82090 80091890 21801102 */  addu       $s0, $s0, $s1
    /* 82094 80091894 21800202 */  addu       $s0, $s0, $v0
    /* 82098 80091898 23801000 */  negu       $s0, $s0
  .L8009189C:
    /* 8209C 8009189C 3C01428E */  lw         $v0, 0x13C($s2)
    /* 820A0 800918A0 00000000 */  nop
    /* 820A4 800918A4 21105300 */  addu       $v0, $v0, $s3
    /* 820A8 800918A8 2A105000 */  slt        $v0, $v0, $s0
    /* 820AC 800918AC 01004238 */  xori       $v0, $v0, 0x1
  .L800918B0:
    /* 820B0 800918B0 3000BF8F */  lw         $ra, 0x30($sp)
    /* 820B4 800918B4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 820B8 800918B8 2800B28F */  lw         $s2, 0x28($sp)
    /* 820BC 800918BC 2400B18F */  lw         $s1, 0x24($sp)
    /* 820C0 800918C0 2000B08F */  lw         $s0, 0x20($sp)
    /* 820C4 800918C4 0800E003 */  jr         $ra
    /* 820C8 800918C8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi
