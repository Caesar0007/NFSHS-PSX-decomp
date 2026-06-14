.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_GetTimePhrase__Fi, 0x50

glabel AudioCmn_GetTimePhrase__Fi
    /* 6786C 8007706C 03008004 */  bltz       $a0, .L8007707C
    /* 67870 80077070 FFFF8224 */   addiu     $v0, $a0, -0x1
    /* 67874 80077074 20DC0108 */  j          .L80077080
    /* 67878 80077078 83210400 */   sra       $a0, $a0, 6
  .L8007707C:
    /* 6787C 8007707C 83210200 */  sra        $a0, $v0, 6
  .L80077080:
    /* 67880 80077080 21180000 */  addu       $v1, $zero, $zero
    /* 67884 80077084 1180023C */  lui        $v0, %hi(D_8010E758)
    /* 67888 80077088 58E74524 */  addiu      $a1, $v0, %lo(D_8010E758)
    /* 6788C 8007708C 21106500 */  addu       $v0, $v1, $a1
  .L80077090:
    /* 67890 80077090 00004280 */  lb         $v0, 0x0($v0)
    /* 67894 80077094 00000000 */  nop
    /* 67898 80077098 2A108200 */  slt        $v0, $a0, $v0
    /* 6789C 8007709C 05004010 */  beqz       $v0, .L800770B4
    /* 678A0 800770A0 00000000 */   nop
    /* 678A4 800770A4 01006324 */  addiu      $v1, $v1, 0x1
    /* 678A8 800770A8 19006228 */  slti       $v0, $v1, 0x19
    /* 678AC 800770AC F8FF4014 */  bnez       $v0, .L80077090
    /* 678B0 800770B0 21106500 */   addu      $v0, $v1, $a1
  .L800770B4:
    /* 678B4 800770B4 0800E003 */  jr         $ra
    /* 678B8 800770B8 35006224 */   addiu     $v0, $v1, 0x35
endlabel AudioCmn_GetTimePhrase__Fi
