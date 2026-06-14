.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckMultiBank__6SpeechPciPQ26Speech11CarBankName, 0x1A0

glabel CheckMultiBank__6SpeechPciPQ26Speech11CarBankName
    /* 85608 80094E08 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8560C 80094E0C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 85610 80094E10 21888000 */  addu       $s1, $a0, $zero
    /* 85614 80094E14 1800B0AF */  sw         $s0, 0x18($sp)
    /* 85618 80094E18 2180A000 */  addu       $s0, $a1, $zero
    /* 8561C 80094E1C 2000B2AF */  sw         $s2, 0x20($sp)
    /* 85620 80094E20 2190C000 */  addu       $s2, $a2, $zero
    /* 85624 80094E24 2400B3AF */  sw         $s3, 0x24($sp)
    /* 85628 80094E28 2198E000 */  addu       $s3, $a3, $zero
    /* 8562C 80094E2C 21200002 */  addu       $a0, $s0, $zero
    /* 85630 80094E30 1480053C */  lui        $a1, %hi(D_8013D04C)
    /* 85634 80094E34 4CD0A524 */  addiu      $a1, $a1, %lo(D_8013D04C)
    /* 85638 80094E38 2800BFAF */  sw         $ra, 0x28($sp)
    /* 8563C 80094E3C 74AC030C */  jal        strncmp
    /* 85640 80094E40 05000624 */   addiu     $a2, $zero, 0x5
    /* 85644 80094E44 05004014 */  bnez       $v0, .L80094E5C
    /* 85648 80094E48 21200002 */   addu      $a0, $s0, $zero
    /* 8564C 80094E4C 21202002 */  addu       $a0, $s1, $zero
    /* 85650 80094E50 1C038524 */  addiu      $a1, $a0, 0x31C
    /* 85654 80094E54 B4530208 */  j          .L80094ED0
    /* 85658 80094E58 05000626 */   addiu     $a2, $s0, 0x5
  .L80094E5C:
    /* 8565C 80094E5C 1480053C */  lui        $a1, %hi(D_8013D054)
    /* 85660 80094E60 54D0A524 */  addiu      $a1, $a1, %lo(D_8013D054)
    /* 85664 80094E64 74AC030C */  jal        strncmp
    /* 85668 80094E68 07000624 */   addiu     $a2, $zero, 0x7
    /* 8566C 80094E6C 06004014 */  bnez       $v0, .L80094E88
    /* 85670 80094E70 21200002 */   addu      $a0, $s0, $zero
    /* 85674 80094E74 1000B3AF */  sw         $s3, 0x10($sp)
    /* 85678 80094E78 21202002 */  addu       $a0, $s1, $zero
    /* 8567C 80094E7C 6C008524 */  addiu      $a1, $a0, 0x6C
    /* 85680 80094E80 C2530208 */  j          .L80094F08
    /* 85684 80094E84 07000626 */   addiu     $a2, $s0, 0x7
  .L80094E88:
    /* 85688 80094E88 0580053C */  lui        $a1, %hi(D_80055B60)
    /* 8568C 80094E8C 605BA524 */  addiu      $a1, $a1, %lo(D_80055B60)
    /* 85690 80094E90 74AC030C */  jal        strncmp
    /* 85694 80094E94 0B000624 */   addiu     $a2, $zero, 0xB
    /* 85698 80094E98 04004014 */  bnez       $v0, .L80094EAC
    /* 8569C 80094E9C 21200002 */   addu      $a0, $s0, $zero
    /* 856A0 80094EA0 21202002 */  addu       $a0, $s1, $zero
    /* 856A4 80094EA4 CE530208 */  j          .L80094F38
    /* 856A8 80094EA8 D8018524 */   addiu     $a1, $a0, 0x1D8
  .L80094EAC:
    /* 856AC 80094EAC 1480053C */  lui        $a1, %hi(D_8013D05C)
    /* 856B0 80094EB0 5CD0A524 */  addiu      $a1, $a1, %lo(D_8013D05C)
    /* 856B4 80094EB4 74AC030C */  jal        strncmp
    /* 856B8 80094EB8 06000624 */   addiu     $a2, $zero, 0x6
    /* 856BC 80094EBC 08004014 */  bnez       $v0, .L80094EE0
    /* 856C0 80094EC0 21200002 */   addu      $a0, $s0, $zero
    /* 856C4 80094EC4 21202002 */  addu       $a0, $s1, $zero
    /* 856C8 80094EC8 D8028524 */  addiu      $a1, $a0, 0x2D8
    /* 856CC 80094ECC 06000626 */  addiu      $a2, $s0, 0x6
  .L80094ED0:
    /* 856D0 80094ED0 3453020C */  jal        CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci
    /* 856D4 80094ED4 21384002 */   addu      $a3, $s2, $zero
    /* 856D8 80094ED8 E3530208 */  j          .L80094F8C
    /* 856DC 80094EDC 00000000 */   nop
  .L80094EE0:
    /* 856E0 80094EE0 0580053C */  lui        $a1, %hi(D_80055B6C)
    /* 856E4 80094EE4 6C5BA524 */  addiu      $a1, $a1, %lo(D_80055B6C)
    /* 856E8 80094EE8 74AC030C */  jal        strncmp
    /* 856EC 80094EEC 08000624 */   addiu     $a2, $zero, 0x8
    /* 856F0 80094EF0 09004014 */  bnez       $v0, .L80094F18
    /* 856F4 80094EF4 21200002 */   addu      $a0, $s0, $zero
    /* 856F8 80094EF8 1000B3AF */  sw         $s3, 0x10($sp)
    /* 856FC 80094EFC 21202002 */  addu       $a0, $s1, $zero
    /* 85700 80094F00 21288000 */  addu       $a1, $a0, $zero
    /* 85704 80094F04 08000626 */  addiu      $a2, $s0, 0x8
  .L80094F08:
    /* 85708 80094F08 4951020C */  jal        CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName
    /* 8570C 80094F0C 21384002 */   addu      $a3, $s2, $zero
    /* 85710 80094F10 E3530208 */  j          .L80094F8C
    /* 85714 80094F14 00000000 */   nop
  .L80094F18:
    /* 85718 80094F18 0580053C */  lui        $a1, %hi(D_80055B78)
    /* 8571C 80094F1C 785BA524 */  addiu      $a1, $a1, %lo(D_80055B78)
    /* 85720 80094F20 74AC030C */  jal        strncmp
    /* 85724 80094F24 0B000624 */   addiu     $a2, $zero, 0xB
    /* 85728 80094F28 08004014 */  bnez       $v0, .L80094F4C
    /* 8572C 80094F2C 21200002 */   addu      $a0, $s0, $zero
    /* 85730 80094F30 21202002 */  addu       $a0, $s1, $zero
    /* 85734 80094F34 D8008524 */  addiu      $a1, $a0, 0xD8
  .L80094F38:
    /* 85738 80094F38 0B000626 */  addiu      $a2, $s0, 0xB
    /* 8573C 80094F3C DA51020C */  jal        CheckLocationBank__6SpeechPQ26Speech12LocationBankPci
    /* 85740 80094F40 21384002 */   addu      $a3, $s2, $zero
    /* 85744 80094F44 E3530208 */  j          .L80094F8C
    /* 85748 80094F48 00000000 */   nop
  .L80094F4C:
    /* 8574C 80094F4C 1480053C */  lui        $a1, %hi(D_8013D064)
    /* 85750 80094F50 64D0A524 */  addiu      $a1, $a1, %lo(D_8013D064)
    /* 85754 80094F54 74AC030C */  jal        strncmp
    /* 85758 80094F58 07000624 */   addiu     $a2, $zero, 0x7
    /* 8575C 80094F5C 03004014 */  bnez       $v0, .L80094F6C
    /* 85760 80094F60 21200002 */   addu      $a0, $s0, $zero
    /* 85764 80094F64 E2530208 */  j          .L80094F88
    /* 85768 80094F68 740332AE */   sw        $s2, 0x374($s1)
  .L80094F6C:
    /* 8576C 80094F6C 0580053C */  lui        $a1, %hi(D_80055B84)
    /* 85770 80094F70 845BA524 */  addiu      $a1, $a1, %lo(D_80055B84)
    /* 85774 80094F74 74AC030C */  jal        strncmp
    /* 85778 80094F78 09000624 */   addiu     $a2, $zero, 0x9
    /* 8577C 80094F7C 03004014 */  bnez       $v0, .L80094F8C
    /* 85780 80094F80 01000224 */   addiu     $v0, $zero, 0x1
    /* 85784 80094F84 780332AE */  sw         $s2, 0x378($s1)
  .L80094F88:
    /* 85788 80094F88 01000224 */  addiu      $v0, $zero, 0x1
  .L80094F8C:
    /* 8578C 80094F8C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 85790 80094F90 2400B38F */  lw         $s3, 0x24($sp)
    /* 85794 80094F94 2000B28F */  lw         $s2, 0x20($sp)
    /* 85798 80094F98 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 8579C 80094F9C 1800B08F */  lw         $s0, 0x18($sp)
    /* 857A0 80094FA0 0800E003 */  jr         $ra
    /* 857A4 80094FA4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CheckMultiBank__6SpeechPciPQ26Speech11CarBankName
