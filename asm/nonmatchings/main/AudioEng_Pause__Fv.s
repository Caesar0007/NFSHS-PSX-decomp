.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_Pause__Fv, 0xB0

glabel AudioEng_Pause__Fv
    /* 6CC7C 8007C47C 21300000 */  addu       $a2, $zero, $zero
    /* 6CC80 8007C480 0F000824 */  addiu      $t0, $zero, 0xF
    /* 6CC84 8007C484 00100724 */  addiu      $a3, $zero, 0x1000
    /* 6CC88 8007C488 1480053C */  lui        $a1, %hi(AudioEng_g)
    /* 6CC8C 8007C48C 34C7A524 */  addiu      $a1, $a1, %lo(AudioEng_g)
  .L8007C490:
    /* 6CC90 8007C490 0200C228 */  slti       $v0, $a2, 0x2
    /* 6CC94 8007C494 23004010 */  beqz       $v0, .L8007C524
    /* 6CC98 8007C498 00000000 */   nop
    /* 6CC9C 8007C49C 0000A48C */  lw         $a0, 0x0($a1)
    /* 6CCA0 8007C4A0 00000000 */  nop
    /* 6CCA4 8007C4A4 1F008010 */  beqz       $a0, .L8007C524
    /* 6CCA8 8007C4A8 00000000 */   nop
    /* 6CCAC 8007C4AC 1B018290 */  lbu        $v0, 0x11B($a0)
    /* 6CCB0 8007C4B0 00000000 */  nop
    /* 6CCB4 8007C4B4 07004814 */  bne        $v0, $t0, .L8007C4D4
    /* 6CCB8 8007C4B8 00000000 */   nop
    /* 6CCBC 8007C4BC 1A018290 */  lbu        $v0, 0x11A($a0)
    /* 6CCC0 8007C4C0 00000000 */  nop
    /* 6CCC4 8007C4C4 01004224 */  addiu      $v0, $v0, 0x1
    /* 6CCC8 8007C4C8 01004230 */  andi       $v0, $v0, 0x1
    /* 6CCCC 8007C4CC 15004014 */  bnez       $v0, .L8007C524
    /* 6CCD0 8007C4D0 00000000 */   nop
  .L8007C4D4:
    /* 6CCD4 8007C4D4 1A018290 */  lbu        $v0, 0x11A($a0)
    /* 6CCD8 8007C4D8 0400A524 */  addiu      $a1, $a1, 0x4
    /* 6CCDC 8007C4DC 40180200 */  sll        $v1, $v0, 1
    /* 6CCE0 8007C4E0 21186200 */  addu       $v1, $v1, $v0
    /* 6CCE4 8007C4E4 80180300 */  sll        $v1, $v1, 2
    /* 6CCE8 8007C4E8 5A006324 */  addiu      $v1, $v1, 0x5A
    /* 6CCEC 8007C4EC 21188300 */  addu       $v1, $a0, $v1
    /* 6CCF0 8007C4F0 000060A4 */  sh         $zero, 0x0($v1)
    /* 6CCF4 8007C4F4 080060A4 */  sh         $zero, 0x8($v1)
    /* 6CCF8 8007C4F8 020067A4 */  sh         $a3, 0x2($v1)
    /* 6CCFC 8007C4FC 0B0060A0 */  sb         $zero, 0xB($v1)
    /* 6CD00 8007C500 0A0060A0 */  sb         $zero, 0xA($v1)
    /* 6CD04 8007C504 060060A4 */  sh         $zero, 0x6($v1)
    /* 6CD08 8007C508 040060A4 */  sh         $zero, 0x4($v1)
    /* 6CD0C 8007C50C 1A018290 */  lbu        $v0, 0x11A($a0)
    /* 6CD10 8007C510 0100C624 */  addiu      $a2, $a2, 0x1
    /* 6CD14 8007C514 01004224 */  addiu      $v0, $v0, 0x1
    /* 6CD18 8007C518 0F004230 */  andi       $v0, $v0, 0xF
    /* 6CD1C 8007C51C 24F10108 */  j          .L8007C490
    /* 6CD20 8007C520 1A0182A0 */   sb        $v0, 0x11A($a0)
  .L8007C524:
    /* 6CD24 8007C524 0800E003 */  jr         $ra
    /* 6CD28 8007C528 00000000 */   nop
endlabel AudioEng_Pause__Fv
