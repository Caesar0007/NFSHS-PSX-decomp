.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Activate__Q26Speech13MobileSpeakerP8Car_tObj, 0xEC

glabel Activate__Q26Speech13MobileSpeakerP8Car_tObj
    /* 87E20 80097620 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 87E24 80097624 1400B1AF */  sw         $s1, 0x14($sp)
    /* 87E28 80097628 21888000 */  addu       $s1, $a0, $zero
    /* 87E2C 8009762C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 87E30 80097630 2180A000 */  addu       $s0, $a1, $zero
    /* 87E34 80097634 21200002 */  addu       $a0, $s0, $zero
    /* 87E38 80097638 1800BFAF */  sw         $ra, 0x18($sp)
    /* 87E3C 8009763C 7E5D020C */  jal        GetVoice__6SpeechP8Car_tObj
    /* 87E40 80097640 600030AE */   sw        $s0, 0x60($s1)
    /* 87E44 80097644 21284000 */  addu       $a1, $v0, $zero
    /* 87E48 80097648 C0200500 */  sll        $a0, $a1, 3
    /* 87E4C 8009764C 1180023C */  lui        $v0, %hi(Speech_gCopAttr)
    /* 87E50 80097650 5C1E4224 */  addiu      $v0, $v0, %lo(Speech_gCopAttr)
    /* 87E54 80097654 5C0025AE */  sw         $a1, 0x5C($s1)
    /* 87E58 80097658 6002038E */  lw         $v1, 0x260($s0)
    /* 87E5C 8009765C 00000000 */  nop
    /* 87E60 80097660 40006330 */  andi       $v1, $v1, 0x40
    /* 87E64 80097664 05006010 */  beqz       $v1, .L8009767C
    /* 87E68 80097668 21108200 */   addu      $v0, $a0, $v0
    /* 87E6C 8009766C 0900A224 */  addiu      $v0, $a1, 0x9
    /* 87E70 80097670 5C0022AE */  sw         $v0, 0x5C($s1)
    /* 87E74 80097674 A05D0208 */  j          .L80097680
    /* 87E78 80097678 08000224 */   addiu     $v0, $zero, 0x8
  .L8009767C:
    /* 87E7C 8009767C 0000428C */  lw         $v0, 0x0($v0)
  .L80097680:
    /* 87E80 80097680 00000000 */  nop
    /* 87E84 80097684 500022AE */  sw         $v0, 0x50($s1)
    /* 87E88 80097688 4C00228E */  lw         $v0, 0x4C($s1)
    /* 87E8C 8009768C 00000000 */  nop
    /* 87E90 80097690 F0004484 */  lh         $a0, 0xF0($v0)
    /* 87E94 80097694 F400428C */  lw         $v0, 0xF4($v0)
    /* 87E98 80097698 00000000 */  nop
    /* 87E9C 8009769C 09F84000 */  jalr       $v0
    /* 87EA0 800976A0 21202402 */   addu      $a0, $s1, $a0
    /* 87EA4 800976A4 5C00238E */  lw         $v1, 0x5C($s1)
    /* 87EA8 800976A8 00000000 */  nop
    /* 87EAC 800976AC 80180300 */  sll        $v1, $v1, 2
    /* 87EB0 800976B0 21104300 */  addu       $v0, $v0, $v1
    /* 87EB4 800976B4 0800428C */  lw         $v0, 0x8($v0)
    /* 87EB8 800976B8 00000000 */  nop
    /* 87EBC 800976BC 380022AE */  sw         $v0, 0x38($s1)
    /* 87EC0 800976C0 1180023C */  lui        $v0, %hi(D_80113228)
    /* 87EC4 800976C4 2832438C */  lw         $v1, %lo(D_80113228)($v0)
    /* 87EC8 800976C8 FF000224 */  addiu      $v0, $zero, 0xFF
    /* 87ECC 800976CC 1C0022AE */  sw         $v0, 0x1C($s1)
    /* 87ED0 800976D0 0F000224 */  addiu      $v0, $zero, 0xF
    /* 87ED4 800976D4 200022AE */  sw         $v0, 0x20($s1)
    /* 87ED8 800976D8 140020AE */  sw         $zero, 0x14($s1)
    /* 87EDC 800976DC 2C0020AE */  sw         $zero, 0x2C($s1)
    /* 87EE0 800976E0 280020AE */  sw         $zero, 0x28($s1)
    /* 87EE4 800976E4 640020AE */  sw         $zero, 0x64($s1)
    /* 87EE8 800976E8 480020AE */  sw         $zero, 0x48($s1)
    /* 87EEC 800976EC 440020AE */  sw         $zero, 0x44($s1)
    /* 87EF0 800976F0 01006330 */  andi       $v1, $v1, 0x1
    /* 87EF4 800976F4 180023AE */  sw         $v1, 0x18($s1)
    /* 87EF8 800976F8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 87EFC 800976FC 1400B18F */  lw         $s1, 0x14($sp)
    /* 87F00 80097700 1000B08F */  lw         $s0, 0x10($sp)
    /* 87F04 80097704 0800E003 */  jr         $ra
    /* 87F08 80097708 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Activate__Q26Speech13MobileSpeakerP8Car_tObj
