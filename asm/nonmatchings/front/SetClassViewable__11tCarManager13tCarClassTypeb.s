.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetClassViewable__11tCarManager13tCarClassTypeb, 0x6C

glabel SetClassViewable__11tCarManager13tCarClassTypeb
    /* 7608 80016E08 0000828C */  lw         $v0, 0x0($a0)
    /* 760C 80016E0C 00000000 */  nop
    /* 7610 80016E10 16004010 */  beqz       $v0, .L80016E6C
    /* 7614 80016E14 21380000 */   addu      $a3, $zero, $zero
    /* 7618 80016E18 2140E000 */  addu       $t0, $a3, $zero
  .L80016E1C:
    /* 761C 80016E1C 0400828C */  lw         $v0, 0x4($a0)
    /* 7620 80016E20 00000000 */  nop
    /* 7624 80016E24 21100201 */  addu       $v0, $t0, $v0
    /* 7628 80016E28 00004380 */  lb         $v1, 0x0($v0)
    /* 762C 80016E2C 00000000 */  nop
    /* 7630 80016E30 07006004 */  bltz       $v1, .L80016E50
    /* 7634 80016E34 00000000 */   nop
    /* 7638 80016E38 02004290 */  lbu        $v0, 0x2($v0)
    /* 763C 80016E3C 00000000 */  nop
    /* 7640 80016E40 05004514 */  bne        $v0, $a1, .L80016E58
    /* 7644 80016E44 21108300 */   addu      $v0, $a0, $v1
    /* 7648 80016E48 965B0008 */  j          .L80016E58
    /* 764C 80016E4C 380246A0 */   sb        $a2, 0x238($v0)
  .L80016E50:
    /* 7650 80016E50 21108300 */  addu       $v0, $a0, $v1
    /* 7654 80016E54 380240A0 */  sb         $zero, 0x238($v0)
  .L80016E58:
    /* 7658 80016E58 0000828C */  lw         $v0, 0x0($a0)
    /* 765C 80016E5C 0100E724 */  addiu      $a3, $a3, 0x1
    /* 7660 80016E60 2B10E200 */  sltu       $v0, $a3, $v0
    /* 7664 80016E64 EDFF4014 */  bnez       $v0, .L80016E1C
    /* 7668 80016E68 CC000825 */   addiu     $t0, $t0, 0xCC
  .L80016E6C:
    /* 766C 80016E6C 0800E003 */  jr         $ra
    /* 7670 80016E70 00000000 */   nop
endlabel SetClassViewable__11tCarManager13tCarClassTypeb
