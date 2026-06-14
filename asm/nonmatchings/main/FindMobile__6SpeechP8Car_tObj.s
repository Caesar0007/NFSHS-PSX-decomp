.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindMobile__6SpeechP8Car_tObj, 0xA4

glabel FindMobile__6SpeechP8Car_tObj
    /* 87FB8 800977B8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 87FBC 800977BC 21380000 */  addu       $a3, $zero, $zero
    /* 87FC0 800977C0 21308000 */  addu       $a2, $a0, $zero
    /* 87FC4 800977C4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 87FC8 800977C8 1000B0AF */  sw         $s0, 0x10($sp)
  .L800977CC:
    /* 87FCC 800977CC 0400E228 */  slti       $v0, $a3, 0x4
    /* 87FD0 800977D0 0B004010 */  beqz       $v0, .L80097800
    /* 87FD4 800977D4 21180000 */   addu      $v1, $zero, $zero
    /* 87FD8 800977D8 9003C38C */  lw         $v1, 0x390($a2)
    /* 87FDC 800977DC 00000000 */  nop
    /* 87FE0 800977E0 6000628C */  lw         $v0, 0x60($v1)
    /* 87FE4 800977E4 00000000 */  nop
    /* 87FE8 800977E8 0300A214 */  bne        $a1, $v0, .L800977F8
    /* 87FEC 800977EC 0400C624 */   addiu     $a2, $a2, 0x4
    /* 87FF0 800977F0 135E0208 */  j          .L8009784C
    /* 87FF4 800977F4 21106000 */   addu      $v0, $v1, $zero
  .L800977F8:
    /* 87FF8 800977F8 F35D0208 */  j          .L800977CC
    /* 87FFC 800977FC 0100E724 */   addiu     $a3, $a3, 0x1
  .L80097800:
    /* 88000 80097800 21808000 */  addu       $s0, $a0, $zero
  .L80097804:
    /* 88004 80097804 04006228 */  slti       $v0, $v1, 0x4
    /* 88008 80097808 0F004010 */  beqz       $v0, .L80097848
    /* 8800C 8009780C 00000000 */   nop
    /* 88010 80097810 9003048E */  lw         $a0, 0x390($s0)
    /* 88014 80097814 00000000 */  nop
    /* 88018 80097818 6000828C */  lw         $v0, 0x60($a0)
    /* 8801C 8009781C 00000000 */  nop
    /* 88020 80097820 06004014 */  bnez       $v0, .L8009783C
    /* 88024 80097824 00000000 */   nop
    /* 88028 80097828 885D020C */  jal        Activate__Q26Speech13MobileSpeakerP8Car_tObj
    /* 8802C 8009782C 00000000 */   nop
    /* 88030 80097830 9003028E */  lw         $v0, 0x390($s0)
    /* 88034 80097834 135E0208 */  j          .L8009784C
    /* 88038 80097838 00000000 */   nop
  .L8009783C:
    /* 8803C 8009783C 04001026 */  addiu      $s0, $s0, 0x4
    /* 88040 80097840 015E0208 */  j          .L80097804
    /* 88044 80097844 01006324 */   addiu     $v1, $v1, 0x1
  .L80097848:
    /* 88048 80097848 3C08828F */  lw         $v0, %gp_rel(_6Speech_fgUndefined)($gp)
  .L8009784C:
    /* 8804C 8009784C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 88050 80097850 1000B08F */  lw         $s0, 0x10($sp)
    /* 88054 80097854 0800E003 */  jr         $ra
    /* 88058 80097858 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FindMobile__6SpeechP8Car_tObj
