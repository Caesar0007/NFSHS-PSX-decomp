.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Deny__Q26Speech15DispatchSpeaker, 0xF4

glabel Deny__Q26Speech15DispatchSpeaker
    /* 87B58 80097358 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 87B5C 8009735C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 87B60 80097360 21888000 */  addu       $s1, $a0, $zero
    /* 87B64 80097364 1800BFAF */  sw         $ra, 0x18($sp)
    /* 87B68 80097368 1000B0AF */  sw         $s0, 0x10($sp)
    /* 87B6C 8009736C 4800228E */  lw         $v0, 0x48($s1)
    /* 87B70 80097370 00000000 */  nop
    /* 87B74 80097374 30004010 */  beqz       $v0, .L80097438
    /* 87B78 80097378 00000000 */   nop
    /* 87B7C 8009737C 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 87B80 80097380 00000000 */  nop
    /* 87B84 80097384 8C0340AC */  sw         $zero, 0x38C($v0)
    /* 87B88 80097388 4C00228E */  lw         $v0, 0x4C($s1)
    /* 87B8C 8009738C 00000000 */  nop
    /* 87B90 80097390 F0004484 */  lh         $a0, 0xF0($v0)
    /* 87B94 80097394 F400428C */  lw         $v0, 0xF4($v0)
    /* 87B98 80097398 00000000 */  nop
    /* 87B9C 8009739C 09F84000 */  jalr       $v0
    /* 87BA0 800973A0 21202402 */   addu      $a0, $s1, $a0
    /* 87BA4 800973A4 4800238E */  lw         $v1, 0x48($s1)
    /* 87BA8 800973A8 00000000 */  nop
    /* 87BAC 800973AC 4C00658C */  lw         $a1, 0x4C($v1)
    /* 87BB0 800973B0 00000000 */  nop
    /* 87BB4 800973B4 8800A484 */  lh         $a0, 0x88($a1)
    /* 87BB8 800973B8 00000000 */  nop
    /* 87BBC 800973BC 21206400 */  addu       $a0, $v1, $a0
    /* 87BC0 800973C0 8C00A38C */  lw         $v1, 0x8C($a1)
    /* 87BC4 800973C4 00000000 */  nop
    /* 87BC8 800973C8 09F86000 */  jalr       $v1
    /* 87BCC 800973CC 21804000 */   addu      $s0, $v0, $zero
    /* 87BD0 800973D0 80100200 */  sll        $v0, $v0, 2
    /* 87BD4 800973D4 21800202 */  addu       $s0, $s0, $v0
    /* 87BD8 800973D8 0800048E */  lw         $a0, 0x8($s0)
    /* 87BDC 800973DC 3800258E */  lw         $a1, 0x38($s1)
    /* 87BE0 800973E0 18002626 */  addiu      $a2, $s1, 0x18
    /* 87BE4 800973E4 C54F020C */  jal        SPCHNFS_D_C_INTRO_CALL
    /* 87BE8 800973E8 3C0024AE */   sw        $a0, 0x3C($s1)
    /* 87BEC 800973EC 919D030C */  jal        SPCH_PlaySpeech
    /* 87BF0 800973F0 00000000 */   nop
    /* 87BF4 800973F4 4800228E */  lw         $v0, 0x48($s1)
    /* 87BF8 800973F8 00000000 */  nop
    /* 87BFC 800973FC 1400438C */  lw         $v1, 0x14($v0)
    /* 87C00 80097400 00000000 */  nop
    /* 87C04 80097404 05006010 */  beqz       $v1, .L8009741C
    /* 87C08 80097408 14004424 */   addiu     $a0, $v0, 0x14
    /* 87C0C 8009740C 3C4D020C */  jal        SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY
    /* 87C10 80097410 00000000 */   nop
    /* 87C14 80097414 095D0208 */  j          .L80097424
    /* 87C18 80097418 00000000 */   nop
  .L8009741C:
    /* 87C1C 8009741C C24D020C */  jal        SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY
    /* 87C20 80097420 00000000 */   nop
  .L80097424:
    /* 87C24 80097424 919D030C */  jal        SPCH_PlaySpeech
    /* 87C28 80097428 00000000 */   nop
    /* 87C2C 8009742C 4800228E */  lw         $v0, 0x48($s1)
    /* 87C30 80097430 00000000 */  nop
    /* 87C34 80097434 140040AC */  sw         $zero, 0x14($v0)
  .L80097438:
    /* 87C38 80097438 1800BF8F */  lw         $ra, 0x18($sp)
    /* 87C3C 8009743C 1400B18F */  lw         $s1, 0x14($sp)
    /* 87C40 80097440 1000B08F */  lw         $s0, 0x10($sp)
    /* 87C44 80097444 0800E003 */  jr         $ra
    /* 87C48 80097448 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Deny__Q26Speech15DispatchSpeaker
