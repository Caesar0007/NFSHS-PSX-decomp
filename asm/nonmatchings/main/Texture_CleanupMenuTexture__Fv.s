.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_CleanupMenuTexture__Fv, 0x60

glabel Texture_CleanupMenuTexture__Fv
    /* D0E38 800E0638 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D0E3C 800E063C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D0E40 800E0640 21880000 */  addu       $s1, $zero, $zero
    /* D0E44 800E0644 1280023C */  lui        $v0, %hi(gMenuPixmap)
    /* D0E48 800E0648 1000B0AF */  sw         $s0, 0x10($sp)
    /* D0E4C 800E064C D00F5024 */  addiu      $s0, $v0, %lo(gMenuPixmap)
    /* D0E50 800E0650 1800BFAF */  sw         $ra, 0x18($sp)
  .L800E0654:
    /* D0E54 800E0654 0000028E */  lw         $v0, 0x0($s0)
    /* D0E58 800E0658 00000000 */  nop
    /* D0E5C 800E065C 04004010 */  beqz       $v0, .L800E0670
    /* D0E60 800E0660 00000000 */   nop
    /* D0E64 800E0664 02004484 */  lh         $a0, 0x2($v0)
    /* D0E68 800E0668 697E030C */  jal        Texture_MenuReleaseClutId__Fs
    /* D0E6C 800E066C 00000000 */   nop
  .L800E0670:
    /* D0E70 800E0670 000000AE */  sw         $zero, 0x0($s0)
    /* D0E74 800E0674 01003126 */  addiu      $s1, $s1, 0x1
    /* D0E78 800E0678 0800222A */  slti       $v0, $s1, 0x8
    /* D0E7C 800E067C F5FF4014 */  bnez       $v0, .L800E0654
    /* D0E80 800E0680 04001026 */   addiu     $s0, $s0, 0x4
    /* D0E84 800E0684 1800BF8F */  lw         $ra, 0x18($sp)
    /* D0E88 800E0688 1400B18F */  lw         $s1, 0x14($sp)
    /* D0E8C 800E068C 1000B08F */  lw         $s0, 0x10($sp)
    /* D0E90 800E0690 0800E003 */  jr         $ra
    /* D0E94 800E0694 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Texture_CleanupMenuTexture__Fv
