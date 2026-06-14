.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand, 0xB4

glabel ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand
    /* 985FC 800A7DFC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98600 800A7E00 1000B0AF */  sw         $s0, 0x10($sp)
    /* 98604 800A7E04 21808000 */  addu       $s0, $a0, $zero
    /* 98608 800A7E08 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9860C 800A7E0C 2190A000 */  addu       $s2, $a1, $zero
    /* 98610 800A7E10 1400B1AF */  sw         $s1, 0x14($sp)
    /* 98614 800A7E14 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 98618 800A7E18 0000438E */  lw         $v1, 0x0($s2)
    /* 9861C 800A7E1C 02000224 */  addiu      $v0, $zero, 0x2
    /* 98620 800A7E20 1D006214 */  bne        $v1, $v0, .L800A7E98
    /* 98624 800A7E24 2188C000 */   addu      $s1, $a2, $zero
    /* 98628 800A7E28 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 9862C 800A7E2C 04000424 */   addiu     $a0, $zero, 0x4
    /* 98630 800A7E30 0800028E */  lw         $v0, 0x8($s0)
    /* 98634 800A7E34 00000000 */  nop
    /* 98638 800A7E38 10004484 */  lh         $a0, 0x10($v0)
    /* 9863C 800A7E3C 1400428C */  lw         $v0, 0x14($v0)
    /* 98640 800A7E40 00000000 */  nop
    /* 98644 800A7E44 09F84000 */  jalr       $v0
    /* 98648 800A7E48 21200402 */   addu      $a0, $s0, $a0
    /* 9864C 800A7E4C 0A004010 */  beqz       $v0, .L800A7E78
    /* 98650 800A7E50 06000224 */   addiu     $v0, $zero, 0x6
    /* 98654 800A7E54 000022AE */  sw         $v0, 0x0($s1)
    /* 98658 800A7E58 0800028E */  lw         $v0, 0x8($s0)
    /* 9865C 800A7E5C 00000000 */  nop
    /* 98660 800A7E60 10004484 */  lh         $a0, 0x10($v0)
    /* 98664 800A7E64 1400428C */  lw         $v0, 0x14($v0)
    /* 98668 800A7E68 00000000 */  nop
    /* 9866C 800A7E6C 09F84000 */  jalr       $v0
    /* 98670 800A7E70 21200402 */   addu      $a0, $s0, $a0
    /* 98674 800A7E74 040022AE */  sw         $v0, 0x4($s1)
  .L800A7E78:
    /* 98678 800A7E78 1000028E */  lw         $v0, 0x10($s0)
    /* 9867C 800A7E7C 00000000 */  nop
    /* 98680 800A7E80 03004010 */  beqz       $v0, .L800A7E90
    /* 98684 800A7E84 00000000 */   nop
    /* 98688 800A7E88 09F84000 */  jalr       $v0
    /* 9868C 800A7E8C 21202002 */   addu      $a0, $s1, $zero
  .L800A7E90:
    /* 98690 800A7E90 01000224 */  addiu      $v0, $zero, 0x1
    /* 98694 800A7E94 000042AE */  sw         $v0, 0x0($s2)
  .L800A7E98:
    /* 98698 800A7E98 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 9869C 800A7E9C 1800B28F */  lw         $s2, 0x18($sp)
    /* 986A0 800A7EA0 1400B18F */  lw         $s1, 0x14($sp)
    /* 986A4 800A7EA4 1000B08F */  lw         $s0, 0x10($sp)
    /* 986A8 800A7EA8 0800E003 */  jr         $ra
    /* 986AC 800A7EAC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand
