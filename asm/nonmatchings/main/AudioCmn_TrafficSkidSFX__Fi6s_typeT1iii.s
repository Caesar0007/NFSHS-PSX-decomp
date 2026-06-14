.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii, 0xB4

glabel AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii
    /* 69B90 80079390 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 69B94 80079394 3000A88F */  lw         $t0, 0x30($sp)
    /* 69B98 80079398 F800828F */  lw         $v0, %gp_rel(AudioCmn_kAudioOn)($gp)
    /* 69B9C 8007939C 21488000 */  addu       $t1, $a0, $zero
    /* 69BA0 800793A0 24004010 */  beqz       $v0, .L80079434
    /* 69BA4 800793A4 1800BFAF */   sw        $ra, 0x18($sp)
    /* 69BA8 800793A8 24130229 */  slti       $v0, $t0, 0x1324
    /* 69BAC 800793AC 0C004010 */  beqz       $v0, .L800793E0
    /* 69BB0 800793B0 FF6A043C */   lui       $a0, (0x6AFF5F81 >> 16)
    /* 69BB4 800793B4 815F8434 */  ori        $a0, $a0, (0x6AFF5F81 & 0xFFFF)
    /* 69BB8 800793B8 24130224 */  addiu      $v0, $zero, 0x1324
    /* 69BBC 800793BC 23104800 */  subu       $v0, $v0, $t0
    /* 69BC0 800793C0 C0190200 */  sll        $v1, $v0, 7
    /* 69BC4 800793C4 23186200 */  subu       $v1, $v1, $v0
    /* 69BC8 800793C8 18006400 */  mult       $v1, $a0
    /* 69BCC 800793CC C31F0300 */  sra        $v1, $v1, 31
    /* 69BD0 800793D0 10500000 */  mfhi       $t2
    /* 69BD4 800793D4 C3120A00 */  sra        $v0, $t2, 11
    /* 69BD8 800793D8 F9E40108 */  j          .L800793E4
    /* 69BDC 800793DC 23104300 */   subu      $v0, $v0, $v1
  .L800793E0:
    /* 69BE0 800793E0 21100000 */  addu       $v0, $zero, $zero
  .L800793E4:
    /* 69BE4 800793E4 0E004014 */  bnez       $v0, .L80079420
    /* 69BE8 800793E8 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* 69BEC 800793EC 0C002411 */  beq        $t1, $a0, .L80079420
    /* 69BF0 800793F0 1180023C */   lui       $v0, %hi(gaChannel)
    /* 69BF4 800793F4 FCE84224 */  addiu      $v0, $v0, %lo(gaChannel)
    /* 69BF8 800793F8 C0180900 */  sll        $v1, $t1, 3
    /* 69BFC 800793FC 21186200 */  addu       $v1, $v1, $v0
    /* 69C00 80079400 0000628C */  lw         $v0, 0x0($v1)
    /* 69C04 80079404 00000000 */  nop
    /* 69C08 80079408 0A004410 */  beq        $v0, $a0, .L80079434
    /* 69C0C 8007940C 00000000 */   nop
    /* 69C10 80079410 34E0010C */  jal        freeVoiceChannel__Fi
    /* 69C14 80079414 21202001 */   addu      $a0, $t1, $zero
    /* 69C18 80079418 0DE50108 */  j          .L80079434
    /* 69C1C 8007941C 00000000 */   nop
  .L80079420:
    /* 69C20 80079420 3400A28F */  lw         $v0, 0x34($sp)
    /* 69C24 80079424 21202001 */  addu       $a0, $t1, $zero
    /* 69C28 80079428 1000A8AF */  sw         $t0, 0x10($sp)
    /* 69C2C 8007942C 54DF010C */  jal        AudioCmn_SFX__Fi6s_typeT1iii
    /* 69C30 80079430 1400A2AF */   sw        $v0, 0x14($sp)
  .L80079434:
    /* 69C34 80079434 1800BF8F */  lw         $ra, 0x18($sp)
    /* 69C38 80079438 00000000 */  nop
    /* 69C3C 8007943C 0800E003 */  jr         $ra
    /* 69C40 80079440 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii
