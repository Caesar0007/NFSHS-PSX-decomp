.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Ready__Q26Speech15DispatchSpeakerP8Car_tObj, 0xAC

glabel Ready__Q26Speech15DispatchSpeakerP8Car_tObj
    /* 87CB0 800974B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 87CB4 800974B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 87CB8 800974B8 21888000 */  addu       $s1, $a0, $zero
    /* 87CBC 800974BC 2120A000 */  addu       $a0, $a1, $zero
    /* 87CC0 800974C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 87CC4 800974C4 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 87CC8 800974C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 87CCC 800974CC 21200000 */  addu       $a0, $zero, $zero
    /* 87CD0 800974D0 4800238E */  lw         $v1, 0x48($s1)
    /* 87CD4 800974D4 00000000 */  nop
    /* 87CD8 800974D8 03006010 */  beqz       $v1, .L800974E8
    /* 87CDC 800974DC 21804000 */   addu      $s0, $v0, $zero
    /* 87CE0 800974E0 26100302 */  xor        $v0, $s0, $v1
    /* 87CE4 800974E4 2B208200 */  sltu       $a0, $a0, $v0
  .L800974E8:
    /* 87CE8 800974E8 15008010 */  beqz       $a0, .L80097540
    /* 87CEC 800974EC 80000224 */   addiu     $v0, $zero, 0x80
    /* 87CF0 800974F0 1400628C */  lw         $v0, 0x14($v1)
    /* 87CF4 800974F4 00000000 */  nop
    /* 87CF8 800974F8 140002AE */  sw         $v0, 0x14($s0)
    /* 87CFC 800974FC 4800238E */  lw         $v1, 0x48($s1)
    /* 87D00 80097500 00000000 */  nop
    /* 87D04 80097504 4C00628C */  lw         $v0, 0x4C($v1)
    /* 87D08 80097508 00000000 */  nop
    /* 87D0C 8009750C D8004484 */  lh         $a0, 0xD8($v0)
    /* 87D10 80097510 DC00428C */  lw         $v0, 0xDC($v0)
    /* 87D14 80097514 00000000 */  nop
    /* 87D18 80097518 09F84000 */  jalr       $v0
    /* 87D1C 8009751C 21206400 */   addu      $a0, $v1, $a0
    /* 87D20 80097520 4C00038E */  lw         $v1, 0x4C($s0)
    /* 87D24 80097524 21284000 */  addu       $a1, $v0, $zero
    /* 87D28 80097528 30006484 */  lh         $a0, 0x30($v1)
    /* 87D2C 8009752C 3400638C */  lw         $v1, 0x34($v1)
    /* 87D30 80097530 00000000 */  nop
    /* 87D34 80097534 09F86000 */  jalr       $v1
    /* 87D38 80097538 21200402 */   addu      $a0, $s0, $a0
    /* 87D3C 8009753C 80000224 */  addiu      $v0, $zero, 0x80
  .L80097540:
    /* 87D40 80097540 540031AE */  sw         $s1, 0x54($s1)
    /* 87D44 80097544 500022AE */  sw         $v0, 0x50($s1)
    /* 87D48 80097548 1800BF8F */  lw         $ra, 0x18($sp)
    /* 87D4C 8009754C 1400B18F */  lw         $s1, 0x14($sp)
    /* 87D50 80097550 1000B08F */  lw         $s0, 0x10($sp)
    /* 87D54 80097554 0800E003 */  jr         $ra
    /* 87D58 80097558 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Ready__Q26Speech15DispatchSpeakerP8Car_tObj
