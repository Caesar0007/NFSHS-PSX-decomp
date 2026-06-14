.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioTrk_CleanUp__Fv, 0x98

glabel AudioTrk_CleanUp__Fv
    /* 6DD2C 8007D52C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6DD30 8007D530 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6DD34 8007D534 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6DD38 8007D538 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6DD3C 8007D53C 85F1010C */  jal        AudioTrk_Reset__Fv
    /* 6DD40 8007D540 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6DD44 8007D544 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6DD48 8007D548 00000000 */  nop
    /* 6DD4C 8007D54C 17004010 */  beqz       $v0, .L8007D5AC
    /* 6DD50 8007D550 21800000 */   addu      $s0, $zero, $zero
    /* 6DD54 8007D554 FFFF1224 */  addiu      $s2, $zero, -0x1
  .L8007D558:
    /* 6DD58 8007D558 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6DD5C 8007D55C 00891000 */  sll        $s1, $s0, 4
    /* 6DD60 8007D560 21105100 */  addu       $v0, $v0, $s1
    /* 6DD64 8007D564 0400428C */  lw         $v0, 0x4($v0)
    /* 6DD68 8007D568 00000000 */  nop
    /* 6DD6C 8007D56C 07005210 */  beq        $v0, $s2, .L8007D58C
    /* 6DD70 8007D570 00000000 */   nop
    /* 6DD74 8007D574 34E0010C */  jal        freeVoiceChannel__Fi
    /* 6DD78 8007D578 37000426 */   addiu     $a0, $s0, 0x37
    /* 6DD7C 8007D57C 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6DD80 8007D580 00000000 */  nop
    /* 6DD84 8007D584 21105100 */  addu       $v0, $v0, $s1
    /* 6DD88 8007D588 040052AC */  sw         $s2, 0x4($v0)
  .L8007D58C:
    /* 6DD8C 8007D58C 01001026 */  addiu      $s0, $s0, 0x1
    /* 6DD90 8007D590 1000022A */  slti       $v0, $s0, 0x10
    /* 6DD94 8007D594 F0FF4014 */  bnez       $v0, .L8007D558
    /* 6DD98 8007D598 00000000 */   nop
    /* 6DD9C 8007D59C 0802848F */  lw         $a0, %gp_rel(AudioTrk_g)($gp)
    /* 6DDA0 8007D5A0 5095030C */  jal        purgememadr
    /* 6DDA4 8007D5A4 00000000 */   nop
    /* 6DDA8 8007D5A8 080280AF */  sw         $zero, %gp_rel(AudioTrk_g)($gp)
  .L8007D5AC:
    /* 6DDAC 8007D5AC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6DDB0 8007D5B0 1800B28F */  lw         $s2, 0x18($sp)
    /* 6DDB4 8007D5B4 1400B18F */  lw         $s1, 0x14($sp)
    /* 6DDB8 8007D5B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 6DDBC 8007D5BC 0800E003 */  jr         $ra
    /* 6DDC0 8007D5C0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioTrk_CleanUp__Fv
