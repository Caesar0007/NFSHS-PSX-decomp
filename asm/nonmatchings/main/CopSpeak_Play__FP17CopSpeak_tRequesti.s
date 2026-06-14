.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Play__FP17CopSpeak_tRequesti, 0x158

glabel CopSpeak_Play__FP17CopSpeak_tRequesti
    /* 8AB04 8009A304 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 8AB08 8009A308 2800B0AF */  sw         $s0, 0x28($sp)
    /* 8AB0C 8009A30C 21808000 */  addu       $s0, $a0, $zero
    /* 8AB10 8009A310 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 8AB14 8009A314 2188A000 */  addu       $s1, $a1, $zero
    /* 8AB18 8009A318 1000A427 */  addiu      $a0, $sp, 0x10
    /* 8AB1C 8009A31C 3400BFAF */  sw         $ra, 0x34($sp)
    /* 8AB20 8009A320 0D9A030C */  jal        SNDplaysetdef
    /* 8AB24 8009A324 3000B2AF */   sw        $s2, 0x30($sp)
    /* 8AB28 8009A328 1E000382 */  lb         $v1, 0x1E($s0)
    /* 8AB2C 8009A32C 03000224 */  addiu      $v0, $zero, 0x3
    /* 8AB30 8009A330 08006214 */  bne        $v1, $v0, .L8009A354
    /* 8AB34 8009A334 21900000 */   addu      $s2, $zero, $zero
    /* 8AB38 8009A338 1180023C */  lui        $v0, %hi(D_8010E8CC)
    /* 8AB3C 8009A33C CCE84290 */  lbu        $v0, %lo(D_8010E8CC)($v0)
    /* 8AB40 8009A340 00000000 */  nop
    /* 8AB44 8009A344 1400A2A3 */  sb         $v0, 0x14($sp)
    /* 8AB48 8009A348 1800028E */  lw         $v0, 0x18($s0)
    /* 8AB4C 8009A34C D7680208 */  j          .L8009A35C
    /* 8AB50 8009A350 1000A2AF */   sw        $v0, 0x10($sp)
  .L8009A354:
    /* 8AB54 8009A354 1400B1A3 */  sb         $s1, 0x14($sp)
    /* 8AB58 8009A358 1000A0AF */  sw         $zero, 0x10($sp)
  .L8009A35C:
    /* 8AB5C 8009A35C 0000028E */  lw         $v0, 0x0($s0)
    /* 8AB60 8009A360 00000000 */  nop
    /* 8AB64 8009A364 08004010 */  beqz       $v0, .L8009A388
    /* 8AB68 8009A368 30000424 */   addiu     $a0, $zero, 0x30
    /* 8AB6C 8009A36C 8E004284 */  lh         $v0, 0x8E($v0)
    /* 8AB70 8009A370 00000000 */  nop
    /* 8AB74 8009A374 20004324 */  addiu      $v1, $v0, 0x20
    /* 8AB78 8009A378 80006228 */  slti       $v0, $v1, 0x80
    /* 8AB7C 8009A37C 02004010 */  beqz       $v0, .L8009A388
    /* 8AB80 8009A380 7F000424 */   addiu     $a0, $zero, 0x7F
    /* 8AB84 8009A384 21206000 */  addu       $a0, $v1, $zero
  .L8009A388:
    /* 8AB88 8009A388 1180023C */  lui        $v0, %hi(D_80111EC4)
    /* 8AB8C 8009A38C 1000038E */  lw         $v1, 0x10($s0)
    /* 8AB90 8009A390 C41E428C */  lw         $v0, %lo(D_80111EC4)($v0)
    /* 8AB94 8009A394 00000000 */  nop
    /* 8AB98 8009A398 0D006214 */  bne        $v1, $v0, .L8009A3D0
    /* 8AB9C 8009A39C 83100400 */   sra       $v0, $a0, 2
    /* 8ABA0 8009A3A0 1480023C */  lui        $v0, %hi(gMasterFENarrationLevel)
    /* 8ABA4 8009A3A4 5CC6428C */  lw         $v0, %lo(gMasterFENarrationLevel)($v0)
    /* 8ABA8 8009A3A8 00000000 */  nop
    /* 8ABAC 8009A3AC C0190200 */  sll        $v1, $v0, 7
    /* 8ABB0 8009A3B0 21186200 */  addu       $v1, $v1, $v0
    /* 8ABB4 8009A3B4 C3190300 */  sra        $v1, $v1, 7
    /* 8ABB8 8009A3B8 40180300 */  sll        $v1, $v1, 1
    /* 8ABBC 8009A3BC 80006228 */  slti       $v0, $v1, 0x80
    /* 8ABC0 8009A3C0 0C004010 */  beqz       $v0, .L8009A3F4
    /* 8ABC4 8009A3C4 7F000424 */   addiu     $a0, $zero, 0x7F
    /* 8ABC8 8009A3C8 FD680208 */  j          .L8009A3F4
    /* 8ABCC 8009A3CC 21206000 */   addu      $a0, $v1, $zero
  .L8009A3D0:
    /* 8ABD0 8009A3D0 80000324 */  addiu      $v1, $zero, 0x80
    /* 8ABD4 8009A3D4 23186200 */  subu       $v1, $v1, $v0
    /* 8ABD8 8009A3D8 C0110300 */  sll        $v0, $v1, 7
    /* 8ABDC 8009A3DC 1480043C */  lui        $a0, %hi(gMasterFENarrationLevel)
    /* 8ABE0 8009A3E0 5CC6848C */  lw         $a0, %lo(gMasterFENarrationLevel)($a0)
    /* 8ABE4 8009A3E4 21104300 */  addu       $v0, $v0, $v1
    /* 8ABE8 8009A3E8 18008200 */  mult       $a0, $v0
    /* 8ABEC 8009A3EC 12300000 */  mflo       $a2
    /* 8ABF0 8009A3F0 83230600 */  sra        $a0, $a2, 14
  .L8009A3F4:
    /* 8ABF4 8009A3F4 1480033C */  lui        $v1, %hi(Audio_direct3davail)
    /* 8ABF8 8009A3F8 FCD4638C */  lw         $v1, %lo(Audio_direct3davail)($v1)
    /* 8ABFC 8009A3FC 40000524 */  addiu      $a1, $zero, 0x40
    /* 8AC00 8009A400 1900A5A3 */  sb         $a1, 0x19($sp)
    /* 8AC04 8009A404 1800A4A3 */  sb         $a0, 0x18($sp)
    /* 8AC08 8009A408 2B100300 */  sltu       $v0, $zero, $v1
    /* 8AC0C 8009A40C 03006010 */  beqz       $v1, .L8009A41C
    /* 8AC10 8009A410 1B00A2A3 */   sb        $v0, 0x1B($sp)
    /* 8AC14 8009A414 0F690208 */  j          .L8009A43C
    /* 8AC18 8009A418 2000B2A7 */   sh        $s2, 0x20($sp)
  .L8009A41C:
    /* 8AC1C 8009A41C 1480023C */  lui        $v0, %hi(gStereoMode)
    /* 8AC20 8009A420 74C6428C */  lw         $v0, %lo(gStereoMode)($v0)
    /* 8AC24 8009A424 00000000 */  nop
    /* 8AC28 8009A428 03004010 */  beqz       $v0, .L8009A438
    /* 8AC2C 8009A42C 40000224 */   addiu     $v0, $zero, 0x40
    /* 8AC30 8009A430 0F690208 */  j          .L8009A43C
    /* 8AC34 8009A434 1700A2A3 */   sb        $v0, 0x17($sp)
  .L8009A438:
    /* 8AC38 8009A438 1700A5A3 */  sb         $a1, 0x17($sp)
  .L8009A43C:
    /* 8AC3C 8009A43C 8C9E030C */  jal        SNDplay
    /* 8AC40 8009A440 1000A427 */   addiu     $a0, $sp, 0x10
    /* 8AC44 8009A444 3400BF8F */  lw         $ra, 0x34($sp)
    /* 8AC48 8009A448 3000B28F */  lw         $s2, 0x30($sp)
    /* 8AC4C 8009A44C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 8AC50 8009A450 2800B08F */  lw         $s0, 0x28($sp)
    /* 8AC54 8009A454 0800E003 */  jr         $ra
    /* 8AC58 8009A458 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CopSpeak_Play__FP17CopSpeak_tRequesti
