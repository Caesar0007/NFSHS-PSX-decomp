.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Car_DoSkiddingStuff__FP8Car_tObj, 0x110

glabel Car_DoSkiddingStuff__FP8Car_tObj
    /* 79FCC 800897CC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 79FD0 800897D0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 79FD4 800897D4 21808000 */  addu       $s0, $a0, $zero
    /* 79FD8 800897D8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 79FDC 800897DC 2C01028E */  lw         $v0, 0x12C($s0)
    /* 79FE0 800897E0 00000000 */  nop
    /* 79FE4 800897E4 34334228 */  slti       $v0, $v0, 0x3334
    /* 79FE8 800897E8 14004014 */  bnez       $v0, .L8008983C
    /* 79FEC 800897EC 1180023C */   lui       $v0, %hi(D_8010F940)
    /* 79FF0 800897F0 C004028E */  lw         $v0, 0x4C0($s0)
    /* 79FF4 800897F4 00000000 */  nop
    /* 79FF8 800897F8 04004230 */  andi       $v0, $v0, 0x4
    /* 79FFC 800897FC 0B004010 */  beqz       $v0, .L8008982C
    /* 7A000 80089800 05000524 */   addiu     $a1, $zero, 0x5
    /* 7A004 80089804 14000624 */  addiu      $a2, $zero, 0x14
    /* 7A008 80089808 01000724 */  addiu      $a3, $zero, 0x1
    /* 7A00C 8008980C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 7A010 80089810 1400A0AF */  sw         $zero, 0x14($sp)
    /* 7A014 80089814 E317020C */  jal        Cars_SetAudioCalls__FP8Car_tObjiiiiii
    /* 7A018 80089818 1800A0AF */   sw        $zero, 0x18($sp)
    /* 7A01C 8008981C C004028E */  lw         $v0, 0x4C0($s0)
    /* 7A020 80089820 00000000 */  nop
    /* 7A024 80089824 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 7A028 80089828 C00402AE */  sw         $v0, 0x4C0($s0)
  .L8008982C:
    /* 7A02C 8008982C 331E020C */  jal        Car_TireSkiddingStuff__FP8Car_tObj
    /* 7A030 80089830 21200002 */   addu      $a0, $s0, $zero
    /* 7A034 80089834 33260208 */  j          .L800898CC
    /* 7A038 80089838 00000000 */   nop
  .L8008983C:
    /* 7A03C 8008983C 40F94224 */  addiu      $v0, $v0, %lo(D_8010F940)
    /* 7A040 80089840 C001038E */  lw         $v1, 0x1C0($s0)
    /* 7A044 80089844 8801048E */  lw         $a0, 0x188($s0)
    /* 7A048 80089848 C000058E */  lw         $a1, 0xC0($s0)
    /* 7A04C 8008984C 80180300 */  sll        $v1, $v1, 2
    /* 7A050 80089850 21186200 */  addu       $v1, $v1, $v0
    /* 7A054 80089854 33338428 */  slti       $a0, $a0, 0x3333
    /* 7A058 80089858 0000638C */  lw         $v1, 0x0($v1)
    /* 7A05C 8008985C 0F008010 */  beqz       $a0, .L8008989C
    /* 7A060 80089860 0200023C */   lui       $v0, (0x20000 >> 16)
    /* 7A064 80089864 2A104500 */  slt        $v0, $v0, $a1
    /* 7A068 80089868 0C004010 */  beqz       $v0, .L8008989C
    /* 7A06C 8008986C 21200002 */   addu      $a0, $s0, $zero
    /* 7A070 80089870 04000524 */  addiu      $a1, $zero, 0x4
    /* 7A074 80089874 14000624 */  addiu      $a2, $zero, 0x14
    /* 7A078 80089878 01000724 */  addiu      $a3, $zero, 0x1
    /* 7A07C 8008987C 0A00023C */  lui        $v0, (0xA0000 >> 16)
    /* 7A080 80089880 1000A3AF */  sw         $v1, 0x10($sp)
    /* 7A084 80089884 1400A2AF */  sw         $v0, 0x14($sp)
    /* 7A088 80089888 E317020C */  jal        Cars_SetAudioCalls__FP8Car_tObjiiiiii
    /* 7A08C 8008988C 1800A0AF */   sw        $zero, 0x18($sp)
    /* 7A090 80089890 C004028E */  lw         $v0, 0x4C0($s0)
    /* 7A094 80089894 32260208 */  j          .L800898C8
    /* 7A098 80089898 04004234 */   ori       $v0, $v0, 0x4
  .L8008989C:
    /* 7A09C 8008989C 21200002 */  addu       $a0, $s0, $zero
    /* 7A0A0 800898A0 05000524 */  addiu      $a1, $zero, 0x5
    /* 7A0A4 800898A4 14000624 */  addiu      $a2, $zero, 0x14
    /* 7A0A8 800898A8 01000724 */  addiu      $a3, $zero, 0x1
    /* 7A0AC 800898AC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 7A0B0 800898B0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 7A0B4 800898B4 E317020C */  jal        Cars_SetAudioCalls__FP8Car_tObjiiiiii
    /* 7A0B8 800898B8 1800A0AF */   sw        $zero, 0x18($sp)
    /* 7A0BC 800898BC C004028E */  lw         $v0, 0x4C0($s0)
    /* 7A0C0 800898C0 00000000 */  nop
    /* 7A0C4 800898C4 FCFF4224 */  addiu      $v0, $v0, -0x4
  .L800898C8:
    /* 7A0C8 800898C8 C00402AE */  sw         $v0, 0x4C0($s0)
  .L800898CC:
    /* 7A0CC 800898CC 2400BF8F */  lw         $ra, 0x24($sp)
    /* 7A0D0 800898D0 2000B08F */  lw         $s0, 0x20($sp)
    /* 7A0D4 800898D4 0800E003 */  jr         $ra
    /* 7A0D8 800898D8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Car_DoSkiddingStuff__FP8Car_tObj
