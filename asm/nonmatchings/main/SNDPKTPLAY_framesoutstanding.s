.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_framesoutstanding, 0x50

glabel SNDPKTPLAY_framesoutstanding
    /* F36EC 80102EEC 1480023C */  lui        $v0, %hi(D_8014789C)
    /* F36F0 80102EF0 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* F36F4 80102EF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F36F8 80102EF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* F36FC 80102EFC 21808000 */  addu       $s0, $a0, $zero
    /* F3700 80102F00 09004010 */  beqz       $v0, .L80102F28
    /* F3704 80102F04 1400BFAF */   sw        $ra, 0x14($sp)
    /* F3708 80102F08 4DA9030C */  jal        iSNDenteraudio
    /* F370C 80102F0C 00000000 */   nop
    /* F3710 80102F10 B10B040C */  jal        SNDPKTPLAY_unsafeframesoutstanding
    /* F3714 80102F14 21200002 */   addu      $a0, $s0, $zero
    /* F3718 80102F18 5BA9030C */  jal        iSNDleaveaudio
    /* F371C 80102F1C 21804000 */   addu      $s0, $v0, $zero
    /* F3720 80102F20 CB0B0408 */  j          .L80102F2C
    /* F3724 80102F24 21100002 */   addu      $v0, $s0, $zero
  .L80102F28:
    /* F3728 80102F28 F6FF0224 */  addiu      $v0, $zero, -0xA
  .L80102F2C:
    /* F372C 80102F2C 1400BF8F */  lw         $ra, 0x14($sp)
    /* F3730 80102F30 1000B08F */  lw         $s0, 0x10($sp)
    /* F3734 80102F34 0800E003 */  jr         $ra
    /* F3738 80102F38 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDPKTPLAY_framesoutstanding
