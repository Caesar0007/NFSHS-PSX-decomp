.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Free__FP17CopSpeak_tRequest, 0x90

glabel CopSpeak_Free__FP17CopSpeak_tRequest
    /* 89F1C 8009971C 0400828C */  lw         $v0, 0x4($a0)
    /* 89F20 80099720 00000000 */  nop
    /* 89F24 80099724 1F004004 */  bltz       $v0, .L800997A4
    /* 89F28 80099728 00000000 */   nop
    /* 89F2C 8009972C 0C00858C */  lw         $a1, 0xC($a0)
    /* 89F30 80099730 00000000 */  nop
    /* 89F34 80099734 1B00A018 */  blez       $a1, .L800997A4
    /* 89F38 80099738 00000000 */   nop
    /* 89F3C 8009973C A20B8387 */  lh         $v1, %gp_rel(CopSpeak_gBufferHigh)($gp)
    /* 89F40 80099740 00000000 */  nop
    /* 89F44 80099744 09006010 */  beqz       $v1, .L8009976C
    /* 89F48 80099748 00000000 */   nop
    /* 89F4C 8009974C 21104500 */  addu       $v0, $v0, $a1
    /* 89F50 80099750 13004314 */  bne        $v0, $v1, .L800997A0
    /* 89F54 80099754 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 89F58 80099758 FC7F0224 */  addiu      $v0, $zero, 0x7FFC
    /* 89F5C 8009975C A20B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferHigh)($gp)
    /* 89F60 80099760 A00B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferEnd)($gp)
    /* 89F64 80099764 E8650208 */  j          .L800997A0
    /* 89F68 80099768 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L8009976C:
    /* 89F6C 8009976C 9E0B8387 */  lh         $v1, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89F70 80099770 21104500 */  addu       $v0, $v0, $a1
    /* 89F74 80099774 04004314 */  bne        $v0, $v1, .L80099788
    /* 89F78 80099778 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 89F7C 8009977C 9E0B80A7 */  sh         $zero, %gp_rel(CopSpeak_gBufferStart)($gp)
    /* 89F80 80099780 0800E003 */  jr         $ra
    /* 89F84 80099784 040082AC */   sw        $v0, 0x4($a0)
  .L80099788:
    /* 89F88 80099788 04008294 */  lhu        $v0, 0x4($a0)
    /* 89F8C 8009978C 0C008394 */  lhu        $v1, 0xC($a0)
    /* 89F90 80099790 00000000 */  nop
    /* 89F94 80099794 21104300 */  addu       $v0, $v0, $v1
    /* 89F98 80099798 9C0B82A7 */  sh         $v0, %gp_rel(CopSpeak_gBufferLow)($gp)
    /* 89F9C 8009979C FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800997A0:
    /* 89FA0 800997A0 040082AC */  sw         $v0, 0x4($a0)
  .L800997A4:
    /* 89FA4 800997A4 0800E003 */  jr         $ra
    /* 89FA8 800997A8 00000000 */   nop
endlabel CopSpeak_Free__FP17CopSpeak_tRequest
