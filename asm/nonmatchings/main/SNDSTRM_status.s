.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_status, 0xF8

glabel SNDSTRM_status
    /* D8ED8 800E86D8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D8EDC 800E86DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* D8EE0 800E86E0 2188A000 */  addu       $s1, $a1, $zero
    /* D8EE4 800E86E4 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D8EE8 800E86E8 1800BFAF */  sw         $ra, 0x18($sp)
    /* D8EEC 800E86EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D8EF0 800E86F0 080020AE */  sw         $zero, 0x8($s1)
    /* D8EF4 800E86F4 040020AE */  sw         $zero, 0x4($s1)
    /* D8EF8 800E86F8 000020AE */  sw         $zero, 0x0($s1)
    /* D8EFC 800E86FC 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D8F00 800E8700 00000000 */  nop
    /* D8F04 800E8704 2D004010 */  beqz       $v0, .L800E87BC
    /* D8F08 800E8708 F6FF0224 */   addiu     $v0, $zero, -0xA
    /* D8F0C 800E870C 12A3030C */  jal        iSNDstreamgetstreamptr
    /* D8F10 800E8710 00000000 */   nop
    /* D8F14 800E8714 21804000 */  addu       $s0, $v0, $zero
    /* D8F18 800E8718 28000012 */  beqz       $s0, .L800E87BC
    /* D8F1C 800E871C F8FF0224 */   addiu     $v0, $zero, -0x8
    /* D8F20 800E8720 4DA9030C */  jal        iSNDenteraudio
    /* D8F24 800E8724 00000000 */   nop
    /* D8F28 800E8728 16000292 */  lbu        $v0, 0x16($s0)
    /* D8F2C 800E872C 00000000 */  nop
    /* D8F30 800E8730 00160200 */  sll        $v0, $v0, 24
    /* D8F34 800E8734 03160200 */  sra        $v0, $v0, 24
    /* D8F38 800E8738 000022AE */  sw         $v0, 0x0($s1)
    /* D8F3C 800E873C 16000292 */  lbu        $v0, 0x16($s0)
    /* D8F40 800E8740 00000000 */  nop
    /* D8F44 800E8744 1A004010 */  beqz       $v0, .L800E87B0
    /* D8F48 800E8748 00000000 */   nop
    /* D8F4C 800E874C 0000028E */  lw         $v0, 0x0($s0)
    /* D8F50 800E8750 00000000 */  nop
    /* D8F54 800E8754 0400428C */  lw         $v0, 0x4($v0)
    /* D8F58 800E8758 00000000 */  nop
    /* D8F5C 800E875C 040022AE */  sw         $v0, 0x4($s1)
    /* D8F60 800E8760 1C000296 */  lhu        $v0, 0x1C($s0)
    /* D8F64 800E8764 00000000 */  nop
    /* D8F68 800E8768 11004010 */  beqz       $v0, .L800E87B0
    /* D8F6C 800E876C 00000000 */   nop
    /* D8F70 800E8770 0C00048E */  lw         $a0, 0xC($s0)
    /* D8F74 800E8774 B10B040C */  jal        SNDPKTPLAY_unsafeframesoutstanding
    /* D8F78 800E8778 00000000 */   nop
    /* D8F7C 800E877C 40190200 */  sll        $v1, $v0, 5
    /* D8F80 800E8780 23186200 */  subu       $v1, $v1, $v0
    /* D8F84 800E8784 80180300 */  sll        $v1, $v1, 2
    /* D8F88 800E8788 21186200 */  addu       $v1, $v1, $v0
    /* D8F8C 800E878C 1C000296 */  lhu        $v0, 0x1C($s0)
    /* D8F90 800E8790 C0180300 */  sll        $v1, $v1, 3
    /* D8F94 800E8794 1B006200 */  divu       $zero, $v1, $v0
    /* D8F98 800E8798 02004014 */  bnez       $v0, .L800E87A4
    /* D8F9C 800E879C 00000000 */   nop
    /* D8FA0 800E87A0 0D000700 */  break      7
  .L800E87A4:
    /* D8FA4 800E87A4 12180000 */  mflo       $v1
    /* D8FA8 800E87A8 00000000 */  nop
    /* D8FAC 800E87AC 080023AE */  sw         $v1, 0x8($s1)
  .L800E87B0:
    /* D8FB0 800E87B0 5BA9030C */  jal        iSNDleaveaudio
    /* D8FB4 800E87B4 00000000 */   nop
    /* D8FB8 800E87B8 21100000 */  addu       $v0, $zero, $zero
  .L800E87BC:
    /* D8FBC 800E87BC 1800BF8F */  lw         $ra, 0x18($sp)
    /* D8FC0 800E87C0 1400B18F */  lw         $s1, 0x14($sp)
    /* D8FC4 800E87C4 1000B08F */  lw         $s0, 0x10($sp)
    /* D8FC8 800E87C8 0800E003 */  jr         $ra
    /* D8FCC 800E87CC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSTRM_status
