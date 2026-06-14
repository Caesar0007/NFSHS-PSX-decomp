.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SubmitRequest__6Speechlll, 0xF4

glabel SubmitRequest__6Speechlll
    /* 86420 80095C20 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 86424 80095C24 1800B0AF */  sw         $s0, 0x18($sp)
    /* 86428 80095C28 21808000 */  addu       $s0, $a0, $zero
    /* 8642C 80095C2C 3808848F */  lw         $a0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 86430 80095C30 2000B2AF */  sw         $s2, 0x20($sp)
    /* 86434 80095C34 2190A000 */  addu       $s2, $a1, $zero
    /* 86438 80095C38 2400B3AF */  sw         $s3, 0x24($sp)
    /* 8643C 80095C3C 2198C000 */  addu       $s3, $a2, $zero
    /* 86440 80095C40 2800BFAF */  sw         $ra, 0x28($sp)
    /* 86444 80095C44 2B008010 */  beqz       $a0, .L80095CF4
    /* 86448 80095C48 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8644C 80095C4C A003828C */  lw         $v0, 0x3A0($a0)
    /* 86450 80095C50 00000000 */  nop
    /* 86454 80095C54 540040AC */  sw         $zero, 0x54($v0)
    /* 86458 80095C58 A003838C */  lw         $v1, 0x3A0($a0)
    /* 8645C 80095C5C 00020224 */  addiu      $v0, $zero, 0x200
    /* 86460 80095C60 500062AC */  sw         $v0, 0x50($v1)
    /* 86464 80095C64 8C03918C */  lw         $s1, 0x38C($a0)
    /* 86468 80095C68 21280002 */  addu       $a1, $s0, $zero
    /* 8646C 80095C6C F956020C */  jal        BankPatch__6SpeechlP8Car_tObj
    /* 86470 80095C70 21302002 */   addu      $a2, $s1, $zero
    /* 86474 80095C74 3808838F */  lw         $v1, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 86478 80095C78 0C000006 */  bltz       $s0, .L80095CAC
    /* 8647C 80095C7C 21204000 */   addu      $a0, $v0, $zero
    /* 86480 80095C80 7003628C */  lw         $v0, 0x370($v1)
    /* 86484 80095C84 00000000 */  nop
    /* 86488 80095C88 2A100202 */  slt        $v0, $s0, $v0
    /* 8648C 80095C8C 07004010 */  beqz       $v0, .L80095CAC
    /* 86490 80095C90 80101000 */   sll       $v0, $s0, 2
    /* 86494 80095C94 6C03638C */  lw         $v1, 0x36C($v1)
    /* 86498 80095C98 00000000 */  nop
    /* 8649C 80095C9C 21104300 */  addu       $v0, $v0, $v1
    /* 864A0 80095CA0 0000428C */  lw         $v0, 0x0($v0)
    /* 864A4 80095CA4 2D570208 */  j          .L80095CB4
    /* 864A8 80095CA8 21804000 */   addu      $s0, $v0, $zero
  .L80095CAC:
    /* 864AC 80095CAC 21100000 */  addu       $v0, $zero, $zero
    /* 864B0 80095CB0 21804000 */  addu       $s0, $v0, $zero
  .L80095CB4:
    /* 864B4 80095CB4 05008004 */  bltz       $a0, .L80095CCC
    /* 864B8 80095CB8 00000000 */   nop
    /* 864BC 80095CBC 2667020C */  jal        CopSpeak_GenericBankRequest__FiP8Car_tObj
    /* 864C0 80095CC0 21282002 */   addu      $a1, $s1, $zero
    /* 864C4 80095CC4 3E570208 */  j          .L80095CF8
    /* 864C8 80095CC8 21101202 */   addu      $v0, $s0, $s2
  .L80095CCC:
    /* 864CC 80095CCC 07000012 */  beqz       $s0, .L80095CEC
    /* 864D0 80095CD0 21281202 */   addu      $a1, $s0, $s2
    /* 864D4 80095CD4 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 864D8 80095CD8 21306002 */  addu       $a2, $s3, $zero
    /* 864DC 80095CDC 6803448C */  lw         $a0, 0x368($v0)
    /* 864E0 80095CE0 21382002 */  addu       $a3, $s1, $zero
    /* 864E4 80095CE4 FB66020C */  jal        CopSpeak_DirectRequest__FillP8Car_tObjPc
    /* 864E8 80095CE8 1000A0AF */   sw        $zero, 0x10($sp)
  .L80095CEC:
    /* 864EC 80095CEC 3E570208 */  j          .L80095CF8
    /* 864F0 80095CF0 21101202 */   addu      $v0, $s0, $s2
  .L80095CF4:
    /* 864F4 80095CF4 21100000 */  addu       $v0, $zero, $zero
  .L80095CF8:
    /* 864F8 80095CF8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 864FC 80095CFC 2400B38F */  lw         $s3, 0x24($sp)
    /* 86500 80095D00 2000B28F */  lw         $s2, 0x20($sp)
    /* 86504 80095D04 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 86508 80095D08 1800B08F */  lw         $s0, 0x18($sp)
    /* 8650C 80095D0C 0800E003 */  jr         $ra
    /* 86510 80095D10 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SubmitRequest__6Speechlll
