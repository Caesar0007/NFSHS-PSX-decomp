.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching NumEnabledItems__6tPMenu, 0x50

glabel NumEnabledItems__6tPMenu
    /* 98E00 800A8600 4C00858C */  lw         $a1, 0x4C($a0)
    /* 98E04 800A8604 01000324 */  addiu      $v1, $zero, 0x1
    /* 98E08 800A8608 04008424 */  addiu      $a0, $a0, 0x4
    /* 98E0C 800A860C 2130A000 */  addu       $a2, $a1, $zero
  .L800A8610:
    /* 98E10 800A8610 2A10C300 */  slt        $v0, $a2, $v1
    /* 98E14 800A8614 0C004014 */  bnez       $v0, .L800A8648
    /* 98E18 800A8618 00000000 */   nop
    /* 98E1C 800A861C 0800828C */  lw         $v0, 0x8($a0)
    /* 98E20 800A8620 00000000 */  nop
    /* 98E24 800A8624 0000428C */  lw         $v0, 0x0($v0)
    /* 98E28 800A8628 00000000 */  nop
    /* 98E2C 800A862C 01004230 */  andi       $v0, $v0, 0x1
    /* 98E30 800A8630 02004010 */  beqz       $v0, .L800A863C
    /* 98E34 800A8634 00000000 */   nop
    /* 98E38 800A8638 FFFFA524 */  addiu      $a1, $a1, -0x1
  .L800A863C:
    /* 98E3C 800A863C 04008424 */  addiu      $a0, $a0, 0x4
    /* 98E40 800A8640 84A10208 */  j          .L800A8610
    /* 98E44 800A8644 01006324 */   addiu     $v1, $v1, 0x1
  .L800A8648:
    /* 98E48 800A8648 0800E003 */  jr         $ra
    /* 98E4C 800A864C 2110A000 */   addu      $v0, $a1, $zero
endlabel NumEnabledItems__6tPMenu
