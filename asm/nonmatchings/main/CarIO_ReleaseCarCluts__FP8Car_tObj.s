.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_ReleaseCarCluts__FP8Car_tObj, 0x68

glabel CarIO_ReleaseCarCluts__FP8Car_tObj
    /* ADB58 800BD358 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ADB5C 800BD35C 1000B0AF */  sw         $s0, 0x10($sp)
    /* ADB60 800BD360 21800000 */  addu       $s0, $zero, $zero
    /* ADB64 800BD364 1800BFAF */  sw         $ra, 0x18($sp)
    /* ADB68 800BD368 1400B1AF */  sw         $s1, 0x14($sp)
    /* ADB6C 800BD36C 4408918C */  lw         $s1, 0x844($a0)
  .L800BD370:
    /* ADB70 800BD370 D011838F */  lw         $v1, %gp_rel(CarIO_carPixMap)($gp)
    /* ADB74 800BD374 00111100 */  sll        $v0, $s1, 4
    /* ADB78 800BD378 21184300 */  addu       $v1, $v0, $v1
    /* ADB7C 800BD37C 0E006294 */  lhu        $v0, 0xE($v1)
    /* ADB80 800BD380 00000000 */  nop
    /* ADB84 800BD384 80004230 */  andi       $v0, $v0, 0x80
    /* ADB88 800BD388 04004010 */  beqz       $v0, .L800BD39C
    /* ADB8C 800BD38C 00000000 */   nop
    /* ADB90 800BD390 02006484 */  lh         $a0, 0x2($v1)
    /* ADB94 800BD394 697E030C */  jal        Texture_MenuReleaseClutId__Fs
    /* ADB98 800BD398 0E0060A4 */   sh        $zero, 0xE($v1)
  .L800BD39C:
    /* ADB9C 800BD39C 01001026 */  addiu      $s0, $s0, 0x1
    /* ADBA0 800BD3A0 3300022A */  slti       $v0, $s0, 0x33
    /* ADBA4 800BD3A4 F2FF4014 */  bnez       $v0, .L800BD370
    /* ADBA8 800BD3A8 01003126 */   addiu     $s1, $s1, 0x1
    /* ADBAC 800BD3AC 1800BF8F */  lw         $ra, 0x18($sp)
    /* ADBB0 800BD3B0 1400B18F */  lw         $s1, 0x14($sp)
    /* ADBB4 800BD3B4 1000B08F */  lw         $s0, 0x10($sp)
    /* ADBB8 800BD3B8 0800E003 */  jr         $ra
    /* ADBBC 800BD3BC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CarIO_ReleaseCarCluts__FP8Car_tObj
