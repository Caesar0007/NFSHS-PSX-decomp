.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_GetInGameVars__Fv, 0xF4

glabel Front_GetInGameVars__Fv
    /* 1BED8 8002B6D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1BEDC 8002B6DC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1BEE0 8002B6E0 1180103C */  lui        $s0, %hi(frontEnd)
    /* 1BEE4 8002B6E4 1480023C */  lui        $v0, %hi(gMasterMusicLevel)
    /* 1BEE8 8002B6E8 50C64290 */  lbu        $v0, %lo(gMasterMusicLevel)($v0)
    /* 1BEEC 8002B6EC 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 1BEF0 8002B6F0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 1BEF4 8002B6F4 410302A2 */  sb         $v0, 0x341($s0)
    /* 1BEF8 8002B6F8 FF004230 */  andi       $v0, $v0, 0xFF
    /* 1BEFC 8002B6FC C0200200 */  sll        $a0, $v0, 3
    /* 1BF00 8002B700 21208200 */  addu       $a0, $a0, $v0
    /* 1BF04 8002B704 80200400 */  sll        $a0, $a0, 2
    /* 1BF08 8002B708 23208200 */  subu       $a0, $a0, $v0
    /* 1BF0C 8002B70C ACEC010C */  jal        AudioMus_Volume__Fi
    /* 1BF10 8002B710 83210400 */   sra       $a0, $a0, 6
    /* 1BF14 8002B714 21480000 */  addu       $t1, $zero, $zero
    /* 1BF18 8002B718 1480033C */  lui        $v1, %hi(gMasterSFXLevel)
    /* 1BF1C 8002B71C 1480043C */  lui        $a0, %hi(gMasterEngineLevel)
    /* 1BF20 8002B720 1480053C */  lui        $a1, %hi(gMasterFENarrationLevel)
    /* 1BF24 8002B724 1480063C */  lui        $a2, %hi(gMasterAmbientLevel)
    /* 1BF28 8002B728 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 1BF2C 8002B72C EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* 1BF30 8002B730 54C66390 */  lbu        $v1, %lo(gMasterSFXLevel)($v1)
    /* 1BF34 8002B734 58C68490 */  lbu        $a0, %lo(gMasterEngineLevel)($a0)
    /* 1BF38 8002B738 5CC6A590 */  lbu        $a1, %lo(gMasterFENarrationLevel)($a1)
    /* 1BF3C 8002B73C 60C6C690 */  lbu        $a2, %lo(gMasterAmbientLevel)($a2)
    /* 1BF40 8002B740 B8004794 */  lhu        $a3, 0xB8($v0)
    /* 1BF44 8002B744 21404000 */  addu       $t0, $v0, $zero
    /* 1BF48 8002B748 420303A2 */  sb         $v1, 0x342($s0)
    /* 1BF4C 8002B74C 440304A2 */  sb         $a0, 0x344($s0)
    /* 1BF50 8002B750 430305A2 */  sb         $a1, 0x343($s0)
    /* 1BF54 8002B754 450306A2 */  sb         $a2, 0x345($s0)
    /* 1BF58 8002B758 5A0007A6 */  sh         $a3, 0x5A($s0)
  .L8002B75C:
    /* 1BF5C 8002B75C 60000291 */  lbu        $v0, 0x60($t0)
    /* 1BF60 8002B760 21183001 */  addu       $v1, $t1, $s0
    /* 1BF64 8002B764 620362A0 */  sb         $v0, 0x362($v1)
    /* 1BF68 8002B768 68000291 */  lbu        $v0, 0x68($t0)
    /* 1BF6C 8002B76C 00000000 */  nop
    /* 1BF70 8002B770 4B0362A0 */  sb         $v0, 0x34B($v1)
    /* 1BF74 8002B774 70000291 */  lbu        $v0, 0x70($t0)
    /* 1BF78 8002B778 00000000 */  nop
    /* 1BF7C 8002B77C 490362A0 */  sb         $v0, 0x349($v1)
    /* 1BF80 8002B780 78000291 */  lbu        $v0, 0x78($t0)
    /* 1BF84 8002B784 00000000 */  nop
    /* 1BF88 8002B788 4F0362A0 */  sb         $v0, 0x34F($v1)
    /* 1BF8C 8002B78C 80000291 */  lbu        $v0, 0x80($t0)
    /* 1BF90 8002B790 00000000 */  nop
    /* 1BF94 8002B794 4D0362A0 */  sb         $v0, 0x34D($v1)
    /* 1BF98 8002B798 A8000291 */  lbu        $v0, 0xA8($t0)
    /* 1BF9C 8002B79C 01002925 */  addiu      $t1, $t1, 0x1
    /* 1BFA0 8002B7A0 590362A0 */  sb         $v0, 0x359($v1)
    /* 1BFA4 8002B7A4 B0000291 */  lbu        $v0, 0xB0($t0)
    /* 1BFA8 8002B7A8 00000000 */  nop
    /* 1BFAC 8002B7AC 5B0362A0 */  sb         $v0, 0x35B($v1)
    /* 1BFB0 8002B7B0 02002229 */  slti       $v0, $t1, 0x2
    /* 1BFB4 8002B7B4 E9FF4014 */  bnez       $v0, .L8002B75C
    /* 1BFB8 8002B7B8 04000825 */   addiu     $t0, $t0, 0x4
    /* 1BFBC 8002B7BC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 1BFC0 8002B7C0 1000B08F */  lw         $s0, 0x10($sp)
    /* 1BFC4 8002B7C4 0800E003 */  jr         $ra
    /* 1BFC8 8002B7C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Front_GetInGameVars__Fv
