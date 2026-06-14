.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReActivate__Q26Speech13MobileSpeaker, 0xAC

glabel ReActivate__Q26Speech13MobileSpeaker
    /* 87F0C 8009770C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 87F10 80097710 1000B0AF */  sw         $s0, 0x10($sp)
    /* 87F14 80097714 21808000 */  addu       $s0, $a0, $zero
    /* 87F18 80097718 1400BFAF */  sw         $ra, 0x14($sp)
    /* 87F1C 8009771C 6000048E */  lw         $a0, 0x60($s0)
    /* 87F20 80097720 7E5D020C */  jal        GetVoice__6SpeechP8Car_tObj
    /* 87F24 80097724 00000000 */   nop
    /* 87F28 80097728 21284000 */  addu       $a1, $v0, $zero
    /* 87F2C 8009772C C0200500 */  sll        $a0, $a1, 3
    /* 87F30 80097730 1180033C */  lui        $v1, %hi(Speech_gCopAttr)
    /* 87F34 80097734 6000028E */  lw         $v0, 0x60($s0)
    /* 87F38 80097738 5C1E6324 */  addiu      $v1, $v1, %lo(Speech_gCopAttr)
    /* 87F3C 8009773C 5C0005AE */  sw         $a1, 0x5C($s0)
    /* 87F40 80097740 6002428C */  lw         $v0, 0x260($v0)
    /* 87F44 80097744 00000000 */  nop
    /* 87F48 80097748 40004230 */  andi       $v0, $v0, 0x40
    /* 87F4C 8009774C 05004010 */  beqz       $v0, .L80097764
    /* 87F50 80097750 21208300 */   addu      $a0, $a0, $v1
    /* 87F54 80097754 0900A224 */  addiu      $v0, $a1, 0x9
    /* 87F58 80097758 5C0002AE */  sw         $v0, 0x5C($s0)
    /* 87F5C 8009775C DA5D0208 */  j          .L80097768
    /* 87F60 80097760 08000224 */   addiu     $v0, $zero, 0x8
  .L80097764:
    /* 87F64 80097764 0000828C */  lw         $v0, 0x0($a0)
  .L80097768:
    /* 87F68 80097768 00000000 */  nop
    /* 87F6C 8009776C 500002AE */  sw         $v0, 0x50($s0)
    /* 87F70 80097770 4C00028E */  lw         $v0, 0x4C($s0)
    /* 87F74 80097774 00000000 */  nop
    /* 87F78 80097778 F0004484 */  lh         $a0, 0xF0($v0)
    /* 87F7C 8009777C F400428C */  lw         $v0, 0xF4($v0)
    /* 87F80 80097780 00000000 */  nop
    /* 87F84 80097784 09F84000 */  jalr       $v0
    /* 87F88 80097788 21200402 */   addu      $a0, $s0, $a0
    /* 87F8C 8009778C 5C00038E */  lw         $v1, 0x5C($s0)
    /* 87F90 80097790 00000000 */  nop
    /* 87F94 80097794 80180300 */  sll        $v1, $v1, 2
    /* 87F98 80097798 21104300 */  addu       $v0, $v0, $v1
    /* 87F9C 8009779C 0800428C */  lw         $v0, 0x8($v0)
    /* 87FA0 800977A0 00000000 */  nop
    /* 87FA4 800977A4 380002AE */  sw         $v0, 0x38($s0)
    /* 87FA8 800977A8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 87FAC 800977AC 1000B08F */  lw         $s0, 0x10($sp)
    /* 87FB0 800977B0 0800E003 */  jr         $ra
    /* 87FB4 800977B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ReActivate__Q26Speech13MobileSpeaker
