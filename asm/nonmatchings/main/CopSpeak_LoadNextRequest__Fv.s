.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_LoadNextRequest__Fv, 0x1F4

glabel CopSpeak_LoadNextRequest__Fv
    /* 8AE34 8009A634 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8AE38 8009A638 2000BFAF */  sw         $ra, 0x20($sp)
    /* 8AE3C 8009A63C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 8AE40 8009A640 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* 8AE44 8009A644 1800B0AF */   sw        $s0, 0x18($sp)
    /* 8AE48 8009A648 D6E7010C */  jal        AudioMus_Threshold__Fv
    /* 8AE4C 8009A64C 21804000 */   addu      $s0, $v0, $zero
    /* 8AE50 8009A650 2A800202 */  slt        $s0, $s0, $v0
    /* 8AE54 8009A654 6F000016 */  bnez       $s0, .L8009A814
    /* 8AE58 8009A658 FFFF1124 */   addiu     $s1, $zero, -0x1
  .L8009A65C:
    /* 8AE5C 8009A65C 8C0B858F */  lw         $a1, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8AE60 8009A660 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8AE64 8009A664 00000000 */  nop
    /* 8AE68 8009A668 6A00A210 */  beq        $a1, $v0, .L8009A814
    /* 8AE6C 8009A66C 00000000 */   nop
    /* 8AE70 8009A670 900B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8AE74 8009A674 00000000 */  nop
    /* 8AE78 8009A678 C0FF4224 */  addiu      $v0, $v0, -0x40
    /* 8AE7C 8009A67C 2310A200 */  subu       $v0, $a1, $v0
    /* 8AE80 8009A680 3F004230 */  andi       $v0, $v0, 0x3F
    /* 8AE84 8009A684 08004228 */  slti       $v0, $v0, 0x8
    /* 8AE88 8009A688 62004010 */  beqz       $v0, .L8009A814
    /* 8AE8C 8009A68C 40190500 */   sll       $v1, $a1, 5
    /* 8AE90 8009A690 1180023C */  lui        $v0, %hi(CopSpeak_gQueue)
    /* 8AE94 8009A694 241F4224 */  addiu      $v0, $v0, %lo(CopSpeak_gQueue)
    /* 8AE98 8009A698 21806200 */  addu       $s0, $v1, $v0
    /* 8AE9C 8009A69C 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8AEA0 8009A6A0 00000000 */  nop
    /* 8AEA4 8009A6A4 32008004 */  bltz       $a0, .L8009A770
    /* 8AEA8 8009A6A8 03000224 */   addiu     $v0, $zero, 0x3
    /* 8AEAC 8009A6AC 06008214 */  bne        $a0, $v0, .L8009A6C8
    /* 8AEB0 8009A6B0 3F00A228 */   slti      $v0, $a1, 0x3F
    /* 8AEB4 8009A6B4 040011AE */  sw         $s1, 0x4($s0)
    /* 8AEB8 8009A6B8 53004010 */  beqz       $v0, .L8009A808
    /* 8AEBC 8009A6BC 21180000 */   addu      $v1, $zero, $zero
    /* 8AEC0 8009A6C0 026A0208 */  j          .L8009A808
    /* 8AEC4 8009A6C4 0100A324 */   addiu     $v1, $a1, 0x1
  .L8009A6C8:
    /* 8AEC8 8009A6C8 1D000292 */  lbu        $v0, 0x1D($s0)
    /* 8AECC 8009A6CC 00000000 */  nop
    /* 8AED0 8009A6D0 19004014 */  bnez       $v0, .L8009A738
    /* 8AED4 8009A6D4 00000000 */   nop
    /* 8AED8 8009A6D8 1800058E */  lw         $a1, 0x18($s0)
    /* 8AEDC 8009A6DC 00000000 */  nop
    /* 8AEE0 8009A6E0 0900A004 */  bltz       $a1, .L8009A708
    /* 8AEE4 8009A6E4 00000000 */   nop
    /* 8AEE8 8009A6E8 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8AEEC 8009A6EC 01000624 */   addiu     $a2, $zero, 0x1
    /* 8AEF0 8009A6F0 04004004 */  bltz       $v0, .L8009A704
    /* 8AEF4 8009A6F4 21180000 */   addu      $v1, $zero, $zero
    /* 8AEF8 8009A6F8 8C0B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8AEFC 8009A6FC FD690208 */  j          .L8009A7F4
    /* 8AF00 8009A700 040011AE */   sw        $s1, 0x4($s0)
  .L8009A704:
    /* 8AF04 8009A704 1D000292 */  lbu        $v0, 0x1D($s0)
  .L8009A708:
    /* 8AF08 8009A708 00000000 */  nop
    /* 8AF0C 8009A70C 0A004014 */  bnez       $v0, .L8009A738
    /* 8AF10 8009A710 01000624 */   addiu     $a2, $zero, 0x1
    /* 8AF14 8009A714 0800058E */  lw         $a1, 0x8($s0)
    /* 8AF18 8009A718 1E000482 */  lb         $a0, 0x1E($s0)
    /* 8AF1C 8009A71C 40DA010C */  jal        AudioCmn_GetAsyncSfx__Fiib
    /* 8AF20 8009A720 0040A524 */   addiu     $a1, $a1, 0x4000
    /* 8AF24 8009A724 04004004 */  bltz       $v0, .L8009A738
    /* 8AF28 8009A728 21180000 */   addu      $v1, $zero, $zero
    /* 8AF2C 8009A72C 8C0B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8AF30 8009A730 FD690208 */  j          .L8009A7F4
    /* 8AF34 8009A734 040011AE */   sw        $s1, 0x4($s0)
  .L8009A738:
    /* 8AF38 8009A738 980B828F */  lw         $v0, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8AF3C 8009A73C 00000000 */  nop
    /* 8AF40 8009A740 0B004010 */  beqz       $v0, .L8009A770
    /* 8AF44 8009A744 00000000 */   nop
    /* 8AF48 8009A748 8169020C */  jal        CopSpeak_BankVolume__FP17CopSpeak_tRequest
    /* 8AF4C 8009A74C 21200002 */   addu      $a0, $s0, $zero
    /* 8AF50 8009A750 07004010 */  beqz       $v0, .L8009A770
    /* 8AF54 8009A754 00000000 */   nop
    /* 8AF58 8009A758 0C00028E */  lw         $v0, 0xC($s0)
    /* 8AF5C 8009A75C 00000000 */  nop
    /* 8AF60 8009A760 03004010 */  beqz       $v0, .L8009A770
    /* 8AF64 8009A764 FD7F4228 */   slti      $v0, $v0, 0x7FFD
    /* 8AF68 8009A768 05004014 */  bnez       $v0, .L8009A780
    /* 8AF6C 8009A76C 00000000 */   nop
  .L8009A770:
    /* 8AF70 8009A770 1769020C */  jal        CopSpeak_Skip__Fv
    /* 8AF74 8009A774 00000000 */   nop
    /* 8AF78 8009A778 97690208 */  j          .L8009A65C
    /* 8AF7C 8009A77C 00000000 */   nop
  .L8009A780:
    /* 8AF80 8009A780 A165020C */  jal        CopSpeak_Alloc__FP17CopSpeak_tRequest
    /* 8AF84 8009A784 21200002 */   addu      $a0, $s0, $zero
    /* 8AF88 8009A788 0400028E */  lw         $v0, 0x4($s0)
    /* 8AF8C 8009A78C 00000000 */  nop
    /* 8AF90 8009A790 20004004 */  bltz       $v0, .L8009A814
    /* 8AF94 8009A794 494C033C */   lui       $v1, (0x4C494146 >> 16)
    /* 8AF98 8009A798 980B888F */  lw         $t0, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8AF9C 8009A79C 46416334 */  ori        $v1, $v1, (0x4C494146 & 0xFFFF)
    /* 8AFA0 8009A7A0 21100201 */  addu       $v0, $t0, $v0
    /* 8AFA4 8009A7A4 000043AC */  sw         $v1, 0x0($v0)
    /* 8AFA8 8009A7A8 0400068E */  lw         $a2, 0x4($s0)
    /* 8AFAC 8009A7AC 64000224 */  addiu      $v0, $zero, 0x64
    /* 8AFB0 8009A7B0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8AFB4 8009A7B4 1400A0AF */  sw         $zero, 0x14($sp)
    /* 8AFB8 8009A7B8 1000048E */  lw         $a0, 0x10($s0)
    /* 8AFBC 8009A7BC 0800058E */  lw         $a1, 0x8($s0)
    /* 8AFC0 8009A7C0 0C00078E */  lw         $a3, 0xC($s0)
    /* 8AFC4 8009A7C4 3BB1030C */  jal        FILE_read
    /* 8AFC8 8009A7C8 21300601 */   addu      $a2, $t0, $a2
    /* 8AFCC 8009A7CC 140002AE */  sw         $v0, 0x14($s0)
    /* 8AFD0 8009A7D0 340B8293 */  lbu        $v0, %gp_rel(CopSpeak_gHandleCount)($gp)
    /* 8AFD4 8009A7D4 1400048E */  lw         $a0, 0x14($s0)
    /* 8AFD8 8009A7D8 01004224 */  addiu      $v0, $v0, 0x1
    /* 8AFDC 8009A7DC 340B82A3 */  sb         $v0, %gp_rel(CopSpeak_gHandleCount)($gp)
    /* 8AFE0 8009A7E0 87AF030C */  jal        FILE_operror
    /* 8AFE4 8009A7E4 00000000 */   nop
    /* 8AFE8 8009A7E8 9CFF401C */  bgtz       $v0, .L8009A65C
    /* 8AFEC 8009A7EC 21180000 */   addu      $v1, $zero, $zero
    /* 8AFF0 8009A7F0 8C0B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueLoad)($gp)
  .L8009A7F4:
    /* 8AFF4 8009A7F4 00000000 */  nop
    /* 8AFF8 8009A7F8 3F008228 */  slti       $v0, $a0, 0x3F
    /* 8AFFC 8009A7FC 02004010 */  beqz       $v0, .L8009A808
    /* 8B000 8009A800 00000000 */   nop
    /* 8B004 8009A804 01008324 */  addiu      $v1, $a0, 0x1
  .L8009A808:
    /* 8B008 8009A808 8C0B83AF */  sw         $v1, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8B00C 8009A80C 97690208 */  j          .L8009A65C
    /* 8B010 8009A810 00000000 */   nop
  .L8009A814:
    /* 8B014 8009A814 2000BF8F */  lw         $ra, 0x20($sp)
    /* 8B018 8009A818 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 8B01C 8009A81C 1800B08F */  lw         $s0, 0x18($sp)
    /* 8B020 8009A820 0800E003 */  jr         $ra
    /* 8B024 8009A824 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CopSpeak_LoadNextRequest__Fv
