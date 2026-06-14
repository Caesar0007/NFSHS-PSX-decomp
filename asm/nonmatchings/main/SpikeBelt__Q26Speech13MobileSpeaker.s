.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SpikeBelt__Q26Speech13MobileSpeaker, 0x114

glabel SpikeBelt__Q26Speech13MobileSpeaker
    /* 89360 80098B60 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 89364 80098B64 1400B1AF */  sw         $s1, 0x14($sp)
    /* 89368 80098B68 21888000 */  addu       $s1, $a0, $zero
    /* 8936C 80098B6C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 89370 80098B70 BC57020C */  jal        Dispatch__6Speech
    /* 89374 80098B74 1000B0AF */   sw        $s0, 0x10($sp)
    /* 89378 80098B78 4800428C */  lw         $v0, 0x48($v0)
    /* 8937C 80098B7C 00000000 */  nop
    /* 89380 80098B80 07004010 */  beqz       $v0, .L80098BA0
    /* 89384 80098B84 21800000 */   addu      $s0, $zero, $zero
    /* 89388 80098B88 BC57020C */  jal        Dispatch__6Speech
    /* 8938C 80098B8C 00000000 */   nop
    /* 89390 80098B90 4800428C */  lw         $v0, 0x48($v0)
    /* 89394 80098B94 00000000 */  nop
    /* 89398 80098B98 26105100 */  xor        $v0, $v0, $s1
    /* 8939C 80098B9C 2B800202 */  sltu       $s0, $s0, $v0
  .L80098BA0:
    /* 893A0 80098BA0 0E000012 */  beqz       $s0, .L80098BDC
    /* 893A4 80098BA4 00000000 */   nop
    /* 893A8 80098BA8 BC57020C */  jal        Dispatch__6Speech
    /* 893AC 80098BAC 00000000 */   nop
    /* 893B0 80098BB0 4800438C */  lw         $v1, 0x48($v0)
    /* 893B4 80098BB4 00000000 */  nop
    /* 893B8 80098BB8 4C00628C */  lw         $v0, 0x4C($v1)
    /* 893BC 80098BBC 00000000 */  nop
    /* 893C0 80098BC0 58004484 */  lh         $a0, 0x58($v0)
    /* 893C4 80098BC4 5C00428C */  lw         $v0, 0x5C($v0)
    /* 893C8 80098BC8 00000000 */  nop
    /* 893CC 80098BCC 09F84000 */  jalr       $v0
    /* 893D0 80098BD0 21206400 */   addu      $a0, $v1, $a0
    /* 893D4 80098BD4 18630208 */  j          .L80098C60
    /* 893D8 80098BD8 00000000 */   nop
  .L80098BDC:
    /* 893DC 80098BDC 6357020C */  jal        Promote__Q26Speech7Speaker
    /* 893E0 80098BE0 21202002 */   addu      $a0, $s1, $zero
    /* 893E4 80098BE4 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 893E8 80098BE8 00000000 */  nop
    /* 893EC 80098BEC 8803628C */  lw         $v0, 0x388($v1)
    /* 893F0 80098BF0 00000000 */  nop
    /* 893F4 80098BF4 19004014 */  bnez       $v0, .L80098C5C
    /* 893F8 80098BF8 01000224 */   addiu     $v0, $zero, 0x1
    /* 893FC 80098BFC 6000228E */  lw         $v0, 0x60($s1)
    /* 89400 80098C00 00000000 */  nop
    /* 89404 80098C04 8C0362AC */  sw         $v0, 0x38C($v1)
    /* 89408 80098C08 4C00228E */  lw         $v0, 0x4C($s1)
    /* 8940C 80098C0C 00000000 */  nop
    /* 89410 80098C10 F0004484 */  lh         $a0, 0xF0($v0)
    /* 89414 80098C14 F400428C */  lw         $v0, 0xF4($v0)
    /* 89418 80098C18 00000000 */  nop
    /* 8941C 80098C1C 09F84000 */  jalr       $v0
    /* 89420 80098C20 21202402 */   addu      $a0, $s1, $a0
    /* 89424 80098C24 50003026 */  addiu      $s0, $s1, 0x50
    /* 89428 80098C28 21200002 */  addu       $a0, $s0, $zero
    /* 8942C 80098C2C 0400458C */  lw         $a1, 0x4($v0)
    /* 89430 80098C30 3800268E */  lw         $a2, 0x38($s1)
    /* 89434 80098C34 18002726 */  addiu      $a3, $s1, 0x18
    /* 89438 80098C38 D94F020C */  jal        SPCHNFS_C_A_INTRO
    /* 8943C 80098C3C 3C0025AE */   sw        $a1, 0x3C($s1)
    /* 89440 80098C40 919D030C */  jal        SPCH_PlaySpeech
    /* 89444 80098C44 00000000 */   nop
    /* 89448 80098C48 1B50020C */  jal        SPCHNFS_C_D_REQ_SPBLT
    /* 8944C 80098C4C 21200002 */   addu      $a0, $s0, $zero
    /* 89450 80098C50 919D030C */  jal        SPCH_PlaySpeech
    /* 89454 80098C54 00000000 */   nop
    /* 89458 80098C58 01000224 */  addiu      $v0, $zero, 0x1
  .L80098C5C:
    /* 8945C 80098C5C 140022AE */  sw         $v0, 0x14($s1)
  .L80098C60:
    /* 89460 80098C60 1800BF8F */  lw         $ra, 0x18($sp)
    /* 89464 80098C64 1400B18F */  lw         $s1, 0x14($sp)
    /* 89468 80098C68 1000B08F */  lw         $s0, 0x10($sp)
    /* 8946C 80098C6C 0800E003 */  jr         $ra
    /* 89470 80098C70 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SpikeBelt__Q26Speech13MobileSpeaker
