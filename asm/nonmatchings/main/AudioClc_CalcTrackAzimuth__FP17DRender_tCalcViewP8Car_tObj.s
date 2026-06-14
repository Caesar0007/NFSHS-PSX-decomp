.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj, 0x138

glabel AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj
    /* 65624 80074E24 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 65628 80074E28 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6562C 80074E2C 5C01A78C */  lw         $a3, 0x15C($a1)
    /* 65630 80074E30 21488000 */  addu       $t1, $a0, $zero
    /* 65634 80074E34 0200E104 */  bgez       $a3, .L80074E40
    /* 65638 80074E38 2118E000 */   addu      $v1, $a3, $zero
    /* 6563C 80074E3C FF00E324 */  addiu      $v1, $a3, 0xFF
  .L80074E40:
    /* 65640 80074E40 0C00228D */  lw         $v0, 0xC($t1)
    /* 65644 80074E44 00000000 */  nop
    /* 65648 80074E48 02004104 */  bgez       $v0, .L80074E54
    /* 6564C 80074E4C 035A0300 */   sra       $t3, $v1, 8
    /* 65650 80074E50 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074E54:
    /* 65654 80074E54 03120200 */  sra        $v0, $v0, 8
    /* 65658 80074E58 18006201 */  mult       $t3, $v0
    /* 6565C 80074E5C 6001A68C */  lw         $a2, 0x160($a1)
    /* 65660 80074E60 12400000 */  mflo       $t0
    /* 65664 80074E64 0200C104 */  bgez       $a2, .L80074E70
    /* 65668 80074E68 2118C000 */   addu      $v1, $a2, $zero
    /* 6566C 80074E6C FF00C324 */  addiu      $v1, $a2, 0xFF
  .L80074E70:
    /* 65670 80074E70 1000228D */  lw         $v0, 0x10($t1)
    /* 65674 80074E74 00000000 */  nop
    /* 65678 80074E78 02004104 */  bgez       $v0, .L80074E84
    /* 6567C 80074E7C 03520300 */   sra       $t2, $v1, 8
    /* 65680 80074E80 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074E84:
    /* 65684 80074E84 03120200 */  sra        $v0, $v0, 8
    /* 65688 80074E88 18004201 */  mult       $t2, $v0
    /* 6568C 80074E8C 6401A58C */  lw         $a1, 0x164($a1)
    /* 65690 80074E90 00000000 */  nop
    /* 65694 80074E94 2118A000 */  addu       $v1, $a1, $zero
    /* 65698 80074E98 12600000 */  mflo       $t4
    /* 6569C 80074E9C 0200A104 */  bgez       $a1, .L80074EA8
    /* 656A0 80074EA0 21200C01 */   addu      $a0, $t0, $t4
    /* 656A4 80074EA4 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L80074EA8:
    /* 656A8 80074EA8 1400228D */  lw         $v0, 0x14($t1)
    /* 656AC 80074EAC 00000000 */  nop
    /* 656B0 80074EB0 02004104 */  bgez       $v0, .L80074EBC
    /* 656B4 80074EB4 03420300 */   sra       $t0, $v1, 8
    /* 656B8 80074EB8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074EBC:
    /* 656BC 80074EBC 03120200 */  sra        $v0, $v0, 8
    /* 656C0 80074EC0 18000201 */  mult       $t0, $v0
    /* 656C4 80074EC4 12600000 */  mflo       $t4
    /* 656C8 80074EC8 2400228D */  lw         $v0, 0x24($t1)
    /* 656CC 80074ECC 00000000 */  nop
    /* 656D0 80074ED0 02004104 */  bgez       $v0, .L80074EDC
    /* 656D4 80074ED4 21208C00 */   addu      $a0, $a0, $t4
    /* 656D8 80074ED8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074EDC:
    /* 656DC 80074EDC 03120200 */  sra        $v0, $v0, 8
    /* 656E0 80074EE0 18006201 */  mult       $t3, $v0
    /* 656E4 80074EE4 12180000 */  mflo       $v1
    /* 656E8 80074EE8 2800228D */  lw         $v0, 0x28($t1)
    /* 656EC 80074EEC 00000000 */  nop
    /* 656F0 80074EF0 02004104 */  bgez       $v0, .L80074EFC
    /* 656F4 80074EF4 00000000 */   nop
    /* 656F8 80074EF8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074EFC:
    /* 656FC 80074EFC 03120200 */  sra        $v0, $v0, 8
    /* 65700 80074F00 18004201 */  mult       $t2, $v0
    /* 65704 80074F04 12600000 */  mflo       $t4
    /* 65708 80074F08 2C00228D */  lw         $v0, 0x2C($t1)
    /* 6570C 80074F0C 00000000 */  nop
    /* 65710 80074F10 02004104 */  bgez       $v0, .L80074F1C
    /* 65714 80074F14 21186C00 */   addu      $v1, $v1, $t4
    /* 65718 80074F18 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80074F1C:
    /* 6571C 80074F1C 03120200 */  sra        $v0, $v0, 8
    /* 65720 80074F20 18000201 */  mult       $t0, $v0
    /* 65724 80074F24 1180023C */  lui        $v0, %hi(D_80113218)
    /* 65728 80074F28 1832428C */  lw         $v0, %lo(D_80113218)($v0)
    /* 6572C 80074F2C 12600000 */  mflo       $t4
    /* 65730 80074F30 02004010 */  beqz       $v0, .L80074F3C
    /* 65734 80074F34 21286C00 */   addu      $a1, $v1, $t4
    /* 65738 80074F38 23200400 */  negu       $a0, $a0
  .L80074F3C:
    /* 6573C 80074F3C 03220400 */  sra        $a0, $a0, 8
    /* 65740 80074F40 CE96030C */  jal        intatan
    /* 65744 80074F44 032A0500 */   sra       $a1, $a1, 8
    /* 65748 80074F48 80110200 */  sll        $v0, $v0, 6
    /* 6574C 80074F4C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 65750 80074F50 C0FF4230 */  andi       $v0, $v0, 0xFFC0
    /* 65754 80074F54 0800E003 */  jr         $ra
    /* 65758 80074F58 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj
