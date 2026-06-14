.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RoadBlock__Q26Speech13MobileSpeaker, 0x114

glabel RoadBlock__Q26Speech13MobileSpeaker
    /* 8924C 80098A4C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 89250 80098A50 1400B1AF */  sw         $s1, 0x14($sp)
    /* 89254 80098A54 21888000 */  addu       $s1, $a0, $zero
    /* 89258 80098A58 1800BFAF */  sw         $ra, 0x18($sp)
    /* 8925C 80098A5C BC57020C */  jal        Dispatch__6Speech
    /* 89260 80098A60 1000B0AF */   sw        $s0, 0x10($sp)
    /* 89264 80098A64 4800428C */  lw         $v0, 0x48($v0)
    /* 89268 80098A68 00000000 */  nop
    /* 8926C 80098A6C 07004010 */  beqz       $v0, .L80098A8C
    /* 89270 80098A70 21800000 */   addu      $s0, $zero, $zero
    /* 89274 80098A74 BC57020C */  jal        Dispatch__6Speech
    /* 89278 80098A78 00000000 */   nop
    /* 8927C 80098A7C 4800428C */  lw         $v0, 0x48($v0)
    /* 89280 80098A80 00000000 */  nop
    /* 89284 80098A84 26105100 */  xor        $v0, $v0, $s1
    /* 89288 80098A88 2B800202 */  sltu       $s0, $s0, $v0
  .L80098A8C:
    /* 8928C 80098A8C 0E000012 */  beqz       $s0, .L80098AC8
    /* 89290 80098A90 00000000 */   nop
    /* 89294 80098A94 BC57020C */  jal        Dispatch__6Speech
    /* 89298 80098A98 00000000 */   nop
    /* 8929C 80098A9C 4800438C */  lw         $v1, 0x48($v0)
    /* 892A0 80098AA0 00000000 */  nop
    /* 892A4 80098AA4 4C00628C */  lw         $v0, 0x4C($v1)
    /* 892A8 80098AA8 00000000 */  nop
    /* 892AC 80098AAC 50004484 */  lh         $a0, 0x50($v0)
    /* 892B0 80098AB0 5400428C */  lw         $v0, 0x54($v0)
    /* 892B4 80098AB4 00000000 */  nop
    /* 892B8 80098AB8 09F84000 */  jalr       $v0
    /* 892BC 80098ABC 21206400 */   addu      $a0, $v1, $a0
    /* 892C0 80098AC0 D3620208 */  j          .L80098B4C
    /* 892C4 80098AC4 00000000 */   nop
  .L80098AC8:
    /* 892C8 80098AC8 6357020C */  jal        Promote__Q26Speech7Speaker
    /* 892CC 80098ACC 21202002 */   addu      $a0, $s1, $zero
    /* 892D0 80098AD0 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 892D4 80098AD4 00000000 */  nop
    /* 892D8 80098AD8 8803628C */  lw         $v0, 0x388($v1)
    /* 892DC 80098ADC 00000000 */  nop
    /* 892E0 80098AE0 19004014 */  bnez       $v0, .L80098B48
    /* 892E4 80098AE4 02000224 */   addiu     $v0, $zero, 0x2
    /* 892E8 80098AE8 6000228E */  lw         $v0, 0x60($s1)
    /* 892EC 80098AEC 00000000 */  nop
    /* 892F0 80098AF0 8C0362AC */  sw         $v0, 0x38C($v1)
    /* 892F4 80098AF4 4C00228E */  lw         $v0, 0x4C($s1)
    /* 892F8 80098AF8 00000000 */  nop
    /* 892FC 80098AFC F0004484 */  lh         $a0, 0xF0($v0)
    /* 89300 80098B00 F400428C */  lw         $v0, 0xF4($v0)
    /* 89304 80098B04 00000000 */  nop
    /* 89308 80098B08 09F84000 */  jalr       $v0
    /* 8930C 80098B0C 21202402 */   addu      $a0, $s1, $a0
    /* 89310 80098B10 50003026 */  addiu      $s0, $s1, 0x50
    /* 89314 80098B14 21200002 */  addu       $a0, $s0, $zero
    /* 89318 80098B18 0400458C */  lw         $a1, 0x4($v0)
    /* 8931C 80098B1C 3800268E */  lw         $a2, 0x38($s1)
    /* 89320 80098B20 18002726 */  addiu      $a3, $s1, 0x18
    /* 89324 80098B24 D94F020C */  jal        SPCHNFS_C_A_INTRO
    /* 89328 80098B28 3C0025AE */   sw        $a1, 0x3C($s1)
    /* 8932C 80098B2C 919D030C */  jal        SPCH_PlaySpeech
    /* 89330 80098B30 00000000 */   nop
    /* 89334 80098B34 2A4D020C */  jal        SPCHNFS_C_D_REQ_RDBLK
    /* 89338 80098B38 21200002 */   addu      $a0, $s0, $zero
    /* 8933C 80098B3C 919D030C */  jal        SPCH_PlaySpeech
    /* 89340 80098B40 00000000 */   nop
    /* 89344 80098B44 02000224 */  addiu      $v0, $zero, 0x2
  .L80098B48:
    /* 89348 80098B48 140022AE */  sw         $v0, 0x14($s1)
  .L80098B4C:
    /* 8934C 80098B4C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 89350 80098B50 1400B18F */  lw         $s1, 0x14($sp)
    /* 89354 80098B54 1000B08F */  lw         $s0, 0x10($sp)
    /* 89358 80098B58 0800E003 */  jr         $ra
    /* 8935C 80098B5C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel RoadBlock__Q26Speech13MobileSpeaker
