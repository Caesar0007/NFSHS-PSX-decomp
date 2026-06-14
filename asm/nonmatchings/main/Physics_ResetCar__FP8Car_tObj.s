.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_ResetCar__FP8Car_tObj, 0x9C

glabel Physics_ResetCar__FP8Car_tObj
    /* 9AE3C 800AA63C 8802828C */  lw         $v0, 0x288($a0)
    /* 9AE40 800AA640 00000000 */  nop
    /* 9AE44 800AA644 0800428C */  lw         $v0, 0x8($v0)
    /* 9AE48 800AA648 01000324 */  addiu      $v1, $zero, 0x1
    /* 9AE4C 800AA64C 04004314 */  bne        $v0, $v1, .L800AA660
    /* 9AE50 800AA650 02000224 */   addiu     $v0, $zero, 0x2
    /* 9AE54 800AA654 3E0482A0 */  sb         $v0, 0x43E($a0)
    /* 9AE58 800AA658 9AA90208 */  j          .L800AA668
    /* 9AE5C 800AA65C 420482A0 */   sb        $v0, 0x442($a0)
  .L800AA660:
    /* 9AE60 800AA660 3E0483A0 */  sb         $v1, 0x43E($a0)
    /* 9AE64 800AA664 420483A0 */  sb         $v1, 0x442($a0)
  .L800AA668:
    /* 9AE68 800AA668 21180000 */  addu       $v1, $zero, $zero
    /* 9AE6C 800AA66C 000480AC */  sw         $zero, 0x400($a0)
    /* 9AE70 800AA670 040480AC */  sw         $zero, 0x404($a0)
    /* 9AE74 800AA674 080480AC */  sw         $zero, 0x408($a0)
    /* 9AE78 800AA678 F40380AC */  sw         $zero, 0x3F4($a0)
    /* 9AE7C 800AA67C F80380AC */  sw         $zero, 0x3F8($a0)
    /* 9AE80 800AA680 FC0380AC */  sw         $zero, 0x3FC($a0)
    /* 9AE84 800AA684 180480AC */  sw         $zero, 0x418($a0)
    /* 9AE88 800AA688 1C0480AC */  sw         $zero, 0x41C($a0)
    /* 9AE8C 800AA68C 200480AC */  sw         $zero, 0x420($a0)
    /* 9AE90 800AA690 240480AC */  sw         $zero, 0x424($a0)
    /* 9AE94 800AA694 280480AC */  sw         $zero, 0x428($a0)
    /* 9AE98 800AA698 2C0480AC */  sw         $zero, 0x42C($a0)
    /* 9AE9C 800AA69C 6C0480AC */  sw         $zero, 0x46C($a0)
    /* 9AEA0 800AA6A0 780480AC */  sw         $zero, 0x478($a0)
    /* 9AEA4 800AA6A4 840480AC */  sw         $zero, 0x484($a0)
    /* 9AEA8 800AA6A8 880480AC */  sw         $zero, 0x488($a0)
    /* 9AEAC 800AA6AC EC0380AC */  sw         $zero, 0x3EC($a0)
    /* 9AEB0 800AA6B0 740280AC */  sw         $zero, 0x274($a0)
    /* 9AEB4 800AA6B4 540480AC */  sw         $zero, 0x454($a0)
  .L800AA6B8:
    /* 9AEB8 800AA6B8 AC0280AC */  sw         $zero, 0x2AC($a0)
    /* 9AEBC 800AA6BC B00280AC */  sw         $zero, 0x2B0($a0)
    /* 9AEC0 800AA6C0 01006324 */  addiu      $v1, $v1, 0x1
    /* 9AEC4 800AA6C4 04006228 */  slti       $v0, $v1, 0x4
    /* 9AEC8 800AA6C8 FBFF4014 */  bnez       $v0, .L800AA6B8
    /* 9AECC 800AA6CC 30008424 */   addiu     $a0, $a0, 0x30
    /* 9AED0 800AA6D0 0800E003 */  jr         $ra
    /* 9AED4 800AA6D4 00000000 */   nop
endlabel Physics_ResetCar__FP8Car_tObj
