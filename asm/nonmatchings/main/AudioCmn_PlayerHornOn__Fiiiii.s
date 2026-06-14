.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayerHornOn__Fiiiii, 0x104

glabel AudioCmn_PlayerHornOn__Fiiiii
    /* 69C44 80079444 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 69C48 80079448 F800828F */  lw         $v0, %gp_rel(AudioCmn_kAudioOn)($gp)
    /* 69C4C 8007944C 21408000 */  addu       $t0, $a0, $zero
    /* 69C50 80079450 2800B4AF */  sw         $s4, 0x28($sp)
    /* 69C54 80079454 21A0C000 */  addu       $s4, $a2, $zero
    /* 69C58 80079458 2400B3AF */  sw         $s3, 0x24($sp)
    /* 69C5C 8007945C 2198E000 */  addu       $s3, $a3, $zero
    /* 69C60 80079460 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 69C64 80079464 2000B2AF */  sw         $s2, 0x20($sp)
    /* 69C68 80079468 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 69C6C 8007946C 2E004010 */  beqz       $v0, .L80079528
    /* 69C70 80079470 1800B0AF */   sw        $s0, 0x18($sp)
    /* 69C74 80079474 2413A228 */  slti       $v0, $a1, 0x1324
    /* 69C78 80079478 0C004010 */  beqz       $v0, .L800794AC
    /* 69C7C 8007947C FF6A043C */   lui       $a0, (0x6AFF5F81 >> 16)
    /* 69C80 80079480 815F8434 */  ori        $a0, $a0, (0x6AFF5F81 & 0xFFFF)
    /* 69C84 80079484 24130224 */  addiu      $v0, $zero, 0x1324
    /* 69C88 80079488 23104500 */  subu       $v0, $v0, $a1
    /* 69C8C 8007948C C0190200 */  sll        $v1, $v0, 7
    /* 69C90 80079490 23186200 */  subu       $v1, $v1, $v0
    /* 69C94 80079494 18006400 */  mult       $v1, $a0
    /* 69C98 80079498 C31F0300 */  sra        $v1, $v1, 31
    /* 69C9C 8007949C 10480000 */  mfhi       $t1
    /* 69CA0 800794A0 C3120900 */  sra        $v0, $t1, 11
    /* 69CA4 800794A4 2CE50108 */  j          .L800794B0
    /* 69CA8 800794A8 23904300 */   subu      $s2, $v0, $v1
  .L800794AC:
    /* 69CAC 800794AC 21900000 */  addu       $s2, $zero, $zero
  .L800794B0:
    /* 69CB0 800794B0 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 69CB4 800794B4 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 69CB8 800794B8 01000224 */  addiu      $v0, $zero, 0x1
    /* 69CBC 800794BC 06006214 */  bne        $v1, $v0, .L800794D8
    /* 69CC0 800794C0 03001124 */   addiu     $s1, $zero, 0x3
    /* 69CC4 800794C4 0A001124 */  addiu      $s1, $zero, 0xA
    /* 69CC8 800794C8 04000015 */  bnez       $t0, .L800794DC
    /* 69CCC 800794CC 2A001024 */   addiu     $s0, $zero, 0x2A
    /* 69CD0 800794D0 37E50108 */  j          .L800794DC
    /* 69CD4 800794D4 29001024 */   addiu     $s0, $zero, 0x29
  .L800794D8:
    /* 69CD8 800794D8 29001024 */  addiu      $s0, $zero, 0x29
  .L800794DC:
    /* 69CDC 800794DC 1180023C */  lui        $v0, %hi(gaChannel)
    /* 69CE0 800794E0 FCE84224 */  addiu      $v0, $v0, %lo(gaChannel)
    /* 69CE4 800794E4 C0181000 */  sll        $v1, $s0, 3
    /* 69CE8 800794E8 21186200 */  addu       $v1, $v1, $v0
    /* 69CEC 800794EC 0000648C */  lw         $a0, 0x0($v1)
    /* 69CF0 800794F0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 69CF4 800794F4 05008210 */  beq        $a0, $v0, .L8007950C
    /* 69CF8 800794F8 00000000 */   nop
    /* 69CFC 800794FC C59E030C */  jal        SNDover
    /* 69D00 80079500 00000000 */   nop
    /* 69D04 80079504 08004014 */  bnez       $v0, .L80079528
    /* 69D08 80079508 00000000 */   nop
  .L8007950C:
    /* 69D0C 8007950C 21200002 */  addu       $a0, $s0, $zero
    /* 69D10 80079510 21282002 */  addu       $a1, $s1, $zero
    /* 69D14 80079514 4000A78F */  lw         $a3, 0x40($sp)
    /* 69D18 80079518 21308002 */  addu       $a2, $s4, $zero
    /* 69D1C 8007951C 1000B2AF */  sw         $s2, 0x10($sp)
    /* 69D20 80079520 F3E0010C */  jal        AudioCmn_PlaySFX__Fiiiiii
    /* 69D24 80079524 1400B3AF */   sw        $s3, 0x14($sp)
  .L80079528:
    /* 69D28 80079528 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 69D2C 8007952C 2800B48F */  lw         $s4, 0x28($sp)
    /* 69D30 80079530 2400B38F */  lw         $s3, 0x24($sp)
    /* 69D34 80079534 2000B28F */  lw         $s2, 0x20($sp)
    /* 69D38 80079538 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 69D3C 8007953C 1800B08F */  lw         $s0, 0x18($sp)
    /* 69D40 80079540 0800E003 */  jr         $ra
    /* 69D44 80079544 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AudioCmn_PlayerHornOn__Fiiiii
