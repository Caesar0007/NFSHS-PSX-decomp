.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ItemEnabledNum__6tPMenui, 0x48

glabel ItemEnabledNum__6tPMenui
    /* 98E50 800A8650 2130A000 */  addu       $a2, $a1, $zero
    /* 98E54 800A8654 21180000 */  addu       $v1, $zero, $zero
  .L800A8658:
    /* 98E58 800A8658 2A106600 */  slt        $v0, $v1, $a2
    /* 98E5C 800A865C 0C004010 */  beqz       $v0, .L800A8690
    /* 98E60 800A8660 00000000 */   nop
    /* 98E64 800A8664 0800828C */  lw         $v0, 0x8($a0)
    /* 98E68 800A8668 00000000 */  nop
    /* 98E6C 800A866C 0000428C */  lw         $v0, 0x0($v0)
    /* 98E70 800A8670 00000000 */  nop
    /* 98E74 800A8674 01004230 */  andi       $v0, $v0, 0x1
    /* 98E78 800A8678 02004010 */  beqz       $v0, .L800A8684
    /* 98E7C 800A867C 00000000 */   nop
    /* 98E80 800A8680 FFFFA524 */  addiu      $a1, $a1, -0x1
  .L800A8684:
    /* 98E84 800A8684 04008424 */  addiu      $a0, $a0, 0x4
    /* 98E88 800A8688 96A10208 */  j          .L800A8658
    /* 98E8C 800A868C 01006324 */   addiu     $v1, $v1, 0x1
  .L800A8690:
    /* 98E90 800A8690 0800E003 */  jr         $ra
    /* 98E94 800A8694 2110A000 */   addu      $v0, $a1, $zero
endlabel ItemEnabledNum__6tPMenui
