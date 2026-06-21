.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadfileadratomic, 0xF8

glabel loadfileadratomic
    /* D5EB0 800E56B0 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D5EB4 800E56B4 2000B0AF */  sw         $s0, 0x20($sp)
    /* D5EB8 800E56B8 21808000 */  addu       $s0, $a0, $zero
    /* D5EBC 800E56BC 2800B2AF */  sw         $s2, 0x28($sp)
    /* D5EC0 800E56C0 2190A000 */  addu       $s2, $a1, $zero
    /* D5EC4 800E56C4 01000524 */  addiu      $a1, $zero, 0x1
    /* D5EC8 800E56C8 21300002 */  addu       $a2, $s0, $zero
    /* D5ECC 800E56CC 3000BFAF */  sw         $ra, 0x30($sp)
    /* D5ED0 800E56D0 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D5ED4 800E56D4 2400B1AF */  sw         $s1, 0x24($sp)
    /* D5ED8 800E56D8 0000448E */  lw         $a0, 0x0($s2)
    /* D5EDC 800E56DC 2AAA030C */  jal        FILE_opensync
    /* D5EE0 800E56E0 1800A727 */   addiu     $a3, $sp, 0x18
    /* D5EE4 800E56E4 28004010 */  beqz       $v0, .L800E5788
    /* D5EE8 800E56E8 FFFF1126 */   addiu     $s1, $s0, -0x1
    /* D5EEC 800E56EC 1800A48F */  lw         $a0, 0x18($sp)
    /* D5EF0 800E56F0 69AA030C */  jal        FILE_sizesync
    /* D5EF4 800E56F4 21282002 */   addu      $a1, $s1, $zero
    /* D5EF8 800E56F8 21984000 */  addu       $s3, $v0, $zero
    /* D5EFC 800E56FC 0000448E */  lw         $a0, 0x0($s2)
    /* D5F00 800E5700 0800468E */  lw         $a2, 0x8($s2)
    /* D5F04 800E5704 CF94030C */  jal        reservememadr
    /* D5F08 800E5708 21286002 */   addu      $a1, $s3, $zero
    /* D5F0C 800E570C 21804000 */  addu       $s0, $v0, $zero
    /* D5F10 800E5710 1A000012 */  beqz       $s0, .L800E577C
    /* D5F14 800E5714 21280000 */   addu      $a1, $zero, $zero
    /* D5F18 800E5718 21300002 */  addu       $a2, $s0, $zero
    /* D5F1C 800E571C 1800A48F */  lw         $a0, 0x18($sp)
    /* D5F20 800E5720 21386002 */  addu       $a3, $s3, $zero
    /* D5F24 800E5724 48AA030C */  jal        FILE_readsync
    /* D5F28 800E5728 1000B1AF */   sw        $s1, 0x10($sp)
    /* D5F2C 800E572C 1800A48F */  lw         $a0, 0x18($sp)
    /* D5F30 800E5730 54AA030C */  jal        FILE_closesync
    /* D5F34 800E5734 21282002 */   addu      $a1, $s1, $zero
    /* D5F38 800E5738 1480023C */  lui        $v0, %hi(loadfilecallback)
    /* D5F3C 800E573C 60DD428C */  lw         $v0, %lo(loadfilecallback)($v0)
    /* D5F40 800E5740 00000000 */  nop
    /* D5F44 800E5744 0B004010 */  beqz       $v0, .L800E5774
    /* D5F48 800E5748 00000000 */   nop
    /* D5F4C 800E574C 0000458E */  lw         $a1, 0x0($s2)
    /* D5F50 800E5750 0800468E */  lw         $a2, 0x8($s2)
    /* D5F54 800E5754 09F84000 */  jalr       $v0
    /* D5F58 800E5758 21200002 */   addu      $a0, $s0, $zero
    /* D5F5C 800E575C 21884000 */  addu       $s1, $v0, $zero
    /* D5F60 800E5760 03002016 */  bnez       $s1, .L800E5770
    /* D5F64 800E5764 00000000 */   nop
    /* D5F68 800E5768 5095030C */  jal        purgememadr
    /* D5F6C 800E576C 21200002 */   addu      $a0, $s0, $zero
  .L800E5770:
    /* D5F70 800E5770 21802002 */  addu       $s0, $s1, $zero
  .L800E5774:
    /* D5F74 800E5774 E3950308 */  j          .L800E578C
    /* D5F78 800E5778 21100002 */   addu      $v0, $s0, $zero
  .L800E577C:
    /* D5F7C 800E577C 1800A48F */  lw         $a0, 0x18($sp)
    /* D5F80 800E5780 54AA030C */  jal        FILE_closesync
    /* D5F84 800E5784 21282002 */   addu      $a1, $s1, $zero
  .L800E5788:
    /* D5F88 800E5788 21100000 */  addu       $v0, $zero, $zero
  .L800E578C:
    /* D5F8C 800E578C 3000BF8F */  lw         $ra, 0x30($sp)
    /* D5F90 800E5790 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D5F94 800E5794 2800B28F */  lw         $s2, 0x28($sp)
    /* D5F98 800E5798 2400B18F */  lw         $s1, 0x24($sp)
    /* D5F9C 800E579C 2000B08F */  lw         $s0, 0x20($sp)
    /* D5FA0 800E57A0 0800E003 */  jr         $ra
    /* D5FA4 800E57A4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel loadfileadratomic
