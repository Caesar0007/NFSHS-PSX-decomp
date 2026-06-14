.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Grant__Q26Speech15DispatchSpeaker, 0x64

glabel Grant__Q26Speech15DispatchSpeaker
    /* 87C4C 8009744C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 87C50 80097450 21288000 */  addu       $a1, $a0, $zero
    /* 87C54 80097454 1000BFAF */  sw         $ra, 0x10($sp)
    /* 87C58 80097458 4800A28C */  lw         $v0, 0x48($a1)
    /* 87C5C 8009745C 00000000 */  nop
    /* 87C60 80097460 0F004010 */  beqz       $v0, .L800974A0
    /* 87C64 80097464 14004224 */   addiu     $v0, $v0, 0x14
    /* 87C68 80097468 0D004010 */  beqz       $v0, .L800974A0
    /* 87C6C 8009746C 00000000 */   nop
    /* 87C70 80097470 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 87C74 80097474 00000000 */  nop
    /* 87C78 80097478 8803438C */  lw         $v1, 0x388($v0)
    /* 87C7C 8009747C 00000000 */  nop
    /* 87C80 80097480 07006014 */  bnez       $v1, .L800974A0
    /* 87C84 80097484 8C0340AC */   sw        $zero, 0x38C($v0)
    /* 87C88 80097488 4800A48C */  lw         $a0, 0x48($a1)
    /* 87C8C 8009748C 1C00A524 */  addiu      $a1, $a1, 0x1C
    /* 87C90 80097490 4E4D020C */  jal        SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY
    /* 87C94 80097494 14008424 */   addiu     $a0, $a0, 0x14
    /* 87C98 80097498 919D030C */  jal        SPCH_PlaySpeech
    /* 87C9C 8009749C 00000000 */   nop
  .L800974A0:
    /* 87CA0 800974A0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 87CA4 800974A4 00000000 */  nop
    /* 87CA8 800974A8 0800E003 */  jr         $ra
    /* 87CAC 800974AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Grant__Q26Speech15DispatchSpeaker
