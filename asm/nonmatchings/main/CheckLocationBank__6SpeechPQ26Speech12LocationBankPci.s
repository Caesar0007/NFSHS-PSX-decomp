.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckLocationBank__6SpeechPQ26Speech12LocationBankPci, 0x104

glabel CheckLocationBank__6SpeechPQ26Speech12LocationBankPci
    /* 84F68 80094768 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 84F6C 8009476C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 84F70 80094770 21A88000 */  addu       $s5, $a0, $zero
    /* 84F74 80094774 2800B6AF */  sw         $s6, 0x28($sp)
    /* 84F78 80094778 21B0C000 */  addu       $s6, $a2, $zero
    /* 84F7C 8009477C 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 84F80 80094780 21B8E000 */  addu       $s7, $a3, $zero
    /* 84F84 80094784 1180033C */  lui        $v1, %hi(Speech_gLocationDescription)
    /* 84F88 80094788 1180023C */  lui        $v0, %hi(D_80113228)
    /* 84F8C 8009478C 2832428C */  lw         $v0, %lo(D_80113228)($v0)
    /* 84F90 80094790 DC1D6324 */  addiu      $v1, $v1, %lo(Speech_gLocationDescription)
    /* 84F94 80094794 3000BFAF */  sw         $ra, 0x30($sp)
    /* 84F98 80094798 2000B4AF */  sw         $s4, 0x20($sp)
    /* 84F9C 8009479C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 84FA0 800947A0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 84FA4 800947A4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 84FA8 800947A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 84FAC 800947AC 80100200 */  sll        $v0, $v0, 2
    /* 84FB0 800947B0 21104300 */  addu       $v0, $v0, $v1
    /* 84FB4 800947B4 0000518C */  lw         $s1, 0x0($v0)
    /* 84FB8 800947B8 00000000 */  nop
    /* 84FBC 800947BC 1F002012 */  beqz       $s1, .L8009483C
    /* 84FC0 800947C0 21A00000 */   addu      $s4, $zero, $zero
    /* 84FC4 800947C4 21988002 */  addu       $s3, $s4, $zero
    /* 84FC8 800947C8 2180A000 */  addu       $s0, $a1, $zero
    /* 84FCC 800947CC 06003226 */  addiu      $s2, $s1, 0x6
  .L800947D0:
    /* 84FD0 800947D0 6003A28E */  lw         $v0, 0x360($s5)
    /* 84FD4 800947D4 00000000 */  nop
    /* 84FD8 800947D8 2A106202 */  slt        $v0, $s3, $v0
    /* 84FDC 800947DC 18004010 */  beqz       $v0, .L80094840
    /* 84FE0 800947E0 21108002 */   addu      $v0, $s4, $zero
    /* 84FE4 800947E4 0000248E */  lw         $a0, 0x0($s1)
    /* 84FE8 800947E8 DDA7030C */  jal        strlen
    /* 84FEC 800947EC 00000000 */   nop
    /* 84FF0 800947F0 2120C002 */  addu       $a0, $s6, $zero
    /* 84FF4 800947F4 0000258E */  lw         $a1, 0x0($s1)
    /* 84FF8 800947F8 74AC030C */  jal        strncmp
    /* 84FFC 800947FC 21304000 */   addu      $a2, $v0, $zero
    /* 85000 80094800 09004014 */  bnez       $v0, .L80094828
    /* 85004 80094804 00000000 */   nop
    /* 85008 80094808 FEFF4286 */  lh         $v0, -0x2($s2)
    /* 8500C 8009480C 00004386 */  lh         $v1, 0x0($s2)
    /* 85010 80094810 0000248E */  lw         $a0, 0x0($s1)
    /* 85014 80094814 01001424 */  addiu      $s4, $zero, 0x1
    /* 85018 80094818 080017AE */  sw         $s7, 0x8($s0)
    /* 8501C 8009481C 000002AE */  sw         $v0, 0x0($s0)
    /* 85020 80094820 040003AE */  sw         $v1, 0x4($s0)
    /* 85024 80094824 0C0004AE */  sw         $a0, 0xC($s0)
  .L80094828:
    /* 85028 80094828 08005226 */  addiu      $s2, $s2, 0x8
    /* 8502C 8009482C 08003126 */  addiu      $s1, $s1, 0x8
    /* 85030 80094830 10001026 */  addiu      $s0, $s0, 0x10
    /* 85034 80094834 F4510208 */  j          .L800947D0
    /* 85038 80094838 01007326 */   addiu     $s3, $s3, 0x1
  .L8009483C:
    /* 8503C 8009483C 21108002 */  addu       $v0, $s4, $zero
  .L80094840:
    /* 85040 80094840 3000BF8F */  lw         $ra, 0x30($sp)
    /* 85044 80094844 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 85048 80094848 2800B68F */  lw         $s6, 0x28($sp)
    /* 8504C 8009484C 2400B58F */  lw         $s5, 0x24($sp)
    /* 85050 80094850 2000B48F */  lw         $s4, 0x20($sp)
    /* 85054 80094854 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 85058 80094858 1800B28F */  lw         $s2, 0x18($sp)
    /* 8505C 8009485C 1400B18F */  lw         $s1, 0x14($sp)
    /* 85060 80094860 1000B08F */  lw         $s0, 0x10($sp)
    /* 85064 80094864 0800E003 */  jr         $ra
    /* 85068 80094868 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CheckLocationBank__6SpeechPQ26Speech12LocationBankPci
