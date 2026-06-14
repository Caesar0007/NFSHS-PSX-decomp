.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef, 0x120

glabel Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
    /* 90660 8009FE60 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 90664 8009FE64 1000B0AF */  sw         $s0, 0x10($sp)
    /* 90668 8009FE68 21808000 */  addu       $s0, $a0, $zero
    /* 9066C 8009FE6C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 90670 8009FE70 1400B1AF */  sw         $s1, 0x14($sp)
    /* 90674 8009FE74 5401028E */  lw         $v0, 0x154($s0)
    /* 90678 8009FE78 5001038E */  lw         $v1, 0x150($s0)
    /* 9067C 8009FE7C 5801048E */  lw         $a0, 0x158($s0)
    /* 90680 8009FE80 2188A000 */  addu       $s1, $a1, $zero
    /* 90684 8009FE84 040022AE */  sw         $v0, 0x4($s1)
    /* 90688 8009FE88 9A194228 */  slti       $v0, $v0, 0x199A
    /* 9068C 8009FE8C 000023AE */  sw         $v1, 0x0($s1)
    /* 90690 8009FE90 34004014 */  bnez       $v0, .L8009FF64
    /* 90694 8009FE94 080024AE */   sw        $a0, 0x8($s1)
    /* 90698 8009FE98 A0000426 */  addiu      $a0, $s0, 0xA0
    /* 9069C 8009FE9C CC7E020C */  jal        Newton_FindGroundElevationGeneral__FP8coorddefN20
    /* 906A0 8009FEA0 68010626 */   addiu     $a2, $s0, 0x168
    /* 906A4 8009FEA4 A000048E */  lw         $a0, 0xA0($s0)
    /* 906A8 8009FEA8 A800058E */  lw         $a1, 0xA8($s0)
    /* 906AC 8009FEAC 21304000 */  addu       $a2, $v0, $zero
    /* 906B0 8009FEB0 AC0200AE */  sw         $zero, 0x2AC($s0)
    /* 906B4 8009FEB4 DC0200AE */  sw         $zero, 0x2DC($s0)
    /* 906B8 8009FEB8 0C0300AE */  sw         $zero, 0x30C($s0)
    /* 906BC 8009FEBC 3C0300AE */  sw         $zero, 0x33C($s0)
    /* 906C0 8009FEC0 B00200AE */  sw         $zero, 0x2B0($s0)
    /* 906C4 8009FEC4 E00200AE */  sw         $zero, 0x2E0($s0)
    /* 906C8 8009FEC8 100300AE */  sw         $zero, 0x310($s0)
    /* 906CC 8009FECC 400300AE */  sw         $zero, 0x340($s0)
    /* 906D0 8009FED0 900206AE */  sw         $a2, 0x290($s0)
    /* 906D4 8009FED4 C00206AE */  sw         $a2, 0x2C0($s0)
    /* 906D8 8009FED8 F00206AE */  sw         $a2, 0x2F0($s0)
    /* 906DC 8009FEDC 200306AE */  sw         $a2, 0x320($s0)
    /* 906E0 8009FEE0 A40206AE */  sw         $a2, 0x2A4($s0)
    /* 906E4 8009FEE4 D40206AE */  sw         $a2, 0x2D4($s0)
    /* 906E8 8009FEE8 040306AE */  sw         $a2, 0x304($s0)
    /* 906EC 8009FEEC 340306AE */  sw         $a2, 0x334($s0)
    /* 906F0 8009FEF0 8C0204AE */  sw         $a0, 0x28C($s0)
    /* 906F4 8009FEF4 BC0204AE */  sw         $a0, 0x2BC($s0)
    /* 906F8 8009FEF8 EC0204AE */  sw         $a0, 0x2EC($s0)
    /* 906FC 8009FEFC 1C0304AE */  sw         $a0, 0x31C($s0)
    /* 90700 8009FF00 940205AE */  sw         $a1, 0x294($s0)
    /* 90704 8009FF04 C40205AE */  sw         $a1, 0x2C4($s0)
    /* 90708 8009FF08 F40205AE */  sw         $a1, 0x2F4($s0)
    /* 9070C 8009FF0C 240305AE */  sw         $a1, 0x324($s0)
    /* 90710 8009FF10 0000248E */  lw         $a0, 0x0($s1)
    /* 90714 8009FF14 0400258E */  lw         $a1, 0x4($s1)
    /* 90718 8009FF18 0800238E */  lw         $v1, 0x8($s1)
    /* 9071C 8009FF1C 01000224 */  addiu      $v0, $zero, 0x1
    /* 90720 8009FF20 B80202AE */  sw         $v0, 0x2B8($s0)
    /* 90724 8009FF24 E80202AE */  sw         $v0, 0x2E8($s0)
    /* 90728 8009FF28 180302AE */  sw         $v0, 0x318($s0)
    /* 9072C 8009FF2C 480302AE */  sw         $v0, 0x348($s0)
    /* 90730 8009FF30 980204AE */  sw         $a0, 0x298($s0)
    /* 90734 8009FF34 C80204AE */  sw         $a0, 0x2C8($s0)
    /* 90738 8009FF38 F80204AE */  sw         $a0, 0x2F8($s0)
    /* 9073C 8009FF3C 280304AE */  sw         $a0, 0x328($s0)
    /* 90740 8009FF40 9C0205AE */  sw         $a1, 0x29C($s0)
    /* 90744 8009FF44 CC0205AE */  sw         $a1, 0x2CC($s0)
    /* 90748 8009FF48 FC0205AE */  sw         $a1, 0x2FC($s0)
    /* 9074C 8009FF4C 2C0305AE */  sw         $a1, 0x32C($s0)
    /* 90750 8009FF50 A00203AE */  sw         $v1, 0x2A0($s0)
    /* 90754 8009FF54 D00203AE */  sw         $v1, 0x2D0($s0)
    /* 90758 8009FF58 000303AE */  sw         $v1, 0x300($s0)
    /* 9075C 8009FF5C DA7F0208 */  j          .L8009FF68
    /* 90760 8009FF60 300303AE */   sw        $v1, 0x330($s0)
  .L8009FF64:
    /* 90764 8009FF64 0083063C */  lui        $a2, (0x83000000 >> 16)
  .L8009FF68:
    /* 90768 8009FF68 1800BF8F */  lw         $ra, 0x18($sp)
    /* 9076C 8009FF6C 1400B18F */  lw         $s1, 0x14($sp)
    /* 90770 8009FF70 1000B08F */  lw         $s0, 0x10($sp)
    /* 90774 8009FF74 2110C000 */  addu       $v0, $a2, $zero
    /* 90778 8009FF78 0800E003 */  jr         $ra
    /* 9077C 8009FF7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef
