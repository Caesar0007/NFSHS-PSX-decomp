.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReleaseIcons__14tScreenMemcard, 0x78

glabel ReleaseIcons__14tScreenMemcard
    /* 383B8 80047BB8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 383BC 80047BBC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 383C0 80047BC0 21908000 */  addu       $s2, $a0, $zero
    /* 383C4 80047BC4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 383C8 80047BC8 21880000 */  addu       $s1, $zero, $zero
    /* 383CC 80047BCC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 383D0 80047BD0 21804002 */  addu       $s0, $s2, $zero
    /* 383D4 80047BD4 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L80047BD8:
    /* 383D8 80047BD8 21105102 */  addu       $v0, $s2, $s1
    /* 383DC 80047BDC 500240A0 */  sb         $zero, 0x250($v0)
    /* 383E0 80047BE0 5F0240A0 */  sb         $zero, 0x25F($v0)
    /* 383E4 80047BE4 6E0240A0 */  sb         $zero, 0x26E($v0)
    /* 383E8 80047BE8 14050496 */  lhu        $a0, 0x514($s0)
    /* 383EC 80047BEC 00000000 */  nop
    /* 383F0 80047BF0 05008010 */  beqz       $a0, .L80047C08
    /* 383F4 80047BF4 00000000 */   nop
    /* 383F8 80047BF8 00240400 */  sll        $a0, $a0, 16
    /* 383FC 80047BFC 697E030C */  jal        Texture_MenuReleaseClutId__Fs
    /* 38400 80047C00 03240400 */   sra       $a0, $a0, 16
    /* 38404 80047C04 140500A6 */  sh         $zero, 0x514($s0)
  .L80047C08:
    /* 38408 80047C08 01003126 */  addiu      $s1, $s1, 0x1
    /* 3840C 80047C0C 0F00222A */  slti       $v0, $s1, 0xF
    /* 38410 80047C10 F1FF4014 */  bnez       $v0, .L80047BD8
    /* 38414 80047C14 02001026 */   addiu     $s0, $s0, 0x2
    /* 38418 80047C18 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3841C 80047C1C 1800B28F */  lw         $s2, 0x18($sp)
    /* 38420 80047C20 1400B18F */  lw         $s1, 0x14($sp)
    /* 38424 80047C24 1000B08F */  lw         $s0, 0x10($sp)
    /* 38428 80047C28 0800E003 */  jr         $ra
    /* 3842C 80047C2C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ReleaseIcons__14tScreenMemcard
