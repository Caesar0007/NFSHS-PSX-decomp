.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CalculateDesiredLatPosition__FP8Car_tObj, 0x234

glabel AI_CalculateDesiredLatPosition__FP8Car_tObj
    /* 4A95C 8005A15C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 4A960 8005A160 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4A964 8005A164 21808000 */  addu       $s0, $a0, $zero
    /* 4A968 8005A168 1180023C */  lui        $v0, %hi(AI_Info)
    /* 4A96C 8005A16C F0CC4224 */  addiu      $v0, $v0, %lo(AI_Info)
    /* 4A970 8005A170 2000BFAF */  sw         $ra, 0x20($sp)
    /* 4A974 8005A174 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4A978 8005A178 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4A97C 8005A17C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4A980 8005A180 4000438C */  lw         $v1, 0x40($v0)
    /* 4A984 8005A184 08001386 */  lh         $s3, 0x8($s0)
    /* 4A988 8005A188 80180300 */  sll        $v1, $v1, 2
    /* 4A98C 8005A18C 21186200 */  addu       $v1, $v1, $v0
    /* 4A990 8005A190 2007028E */  lw         $v0, 0x720($s0)
    /* 4A994 8005A194 0000718C */  lw         $s1, 0x0($v1)
    /* 4A998 8005A198 06004018 */  blez       $v0, .L8005A1B4
    /* 4A99C 8005A19C 00000000 */   nop
    /* 4A9A0 8005A1A0 AB67010C */  jal        AI_CheckPreferredLateralPosition__FP8Car_tObj
    /* 4A9A4 8005A1A4 00000000 */   nop
    /* 4A9A8 8005A1A8 01000324 */  addiu      $v1, $zero, 0x1
    /* 4A9AC 8005A1AC 71004310 */  beq        $v0, $v1, .L8005A374
    /* 4A9B0 8005A1B0 00000000 */   nop
  .L8005A1B4:
    /* 4A9B4 8005A1B4 1C002012 */  beqz       $s1, .L8005A228
    /* 4A9B8 8005A1B8 21900000 */   addu      $s2, $zero, $zero
    /* 4A9BC 8005A1BC 21202002 */  addu       $a0, $s1, $zero
    /* 4A9C0 8005A1C0 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4A9C4 8005A1C4 21280002 */   addu      $a1, $s0, $zero
    /* 4A9C8 8005A1C8 0A004018 */  blez       $v0, .L8005A1F4
    /* 4A9CC 8005A1CC 21202002 */   addu      $a0, $s1, $zero
    /* 4A9D0 8005A1D0 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4A9D4 8005A1D4 21280002 */   addu      $a1, $s0, $zero
    /* 4A9D8 8005A1D8 1300033C */  lui        $v1, (0x13FFFF >> 16)
    /* 4A9DC 8005A1DC FFFF6334 */  ori        $v1, $v1, (0x13FFFF & 0xFFFF)
    /* 4A9E0 8005A1E0 2A186200 */  slt        $v1, $v1, $v0
    /* 4A9E4 8005A1E4 0B006010 */  beqz       $v1, .L8005A214
    /* 4A9E8 8005A1E8 21200002 */   addu      $a0, $s0, $zero
    /* 4A9EC 8005A1EC 8A680108 */  j          .L8005A228
    /* 4A9F0 8005A1F0 00000000 */   nop
  .L8005A1F4:
    /* 4A9F4 8005A1F4 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4A9F8 8005A1F8 21280002 */   addu      $a1, $s0, $zero
    /* 4A9FC 8005A1FC 1300033C */  lui        $v1, (0x13FFFF >> 16)
    /* 4AA00 8005A200 FFFF6334 */  ori        $v1, $v1, (0x13FFFF & 0xFFFF)
    /* 4AA04 8005A204 23100200 */  negu       $v0, $v0
    /* 4AA08 8005A208 2A186200 */  slt        $v1, $v1, $v0
    /* 4AA0C 8005A20C 06006014 */  bnez       $v1, .L8005A228
    /* 4AA10 8005A210 21200002 */   addu      $a0, $s0, $zero
  .L8005A214:
    /* 4AA14 8005A214 8A69010C */  jal        AI_IsMellowZone__FP8Car_tObji
    /* 4AA18 8005A218 E803053C */   lui       $a1, (0x3E80000 >> 16)
    /* 4AA1C 8005A21C 02004014 */  bnez       $v0, .L8005A228
    /* 4AA20 8005A220 00000000 */   nop
    /* 4AA24 8005A224 01001224 */  addiu      $s2, $zero, 0x1
  .L8005A228:
    /* 4AA28 8005A228 06004012 */  beqz       $s2, .L8005A244
    /* 4AA2C 8005A22C 21200002 */   addu      $a0, $s0, $zero
    /* 4AA30 8005A230 1868010C */  jal        AI_TryToShareLanes__FP8Car_tObjT0
    /* 4AA34 8005A234 21282002 */   addu      $a1, $s1, $zero
    /* 4AA38 8005A238 01000324 */  addiu      $v1, $zero, 0x1
    /* 4AA3C 8005A23C 4D004310 */  beq        $v0, $v1, .L8005A374
    /* 4AA40 8005A240 00000000 */   nop
  .L8005A244:
    /* 4AA44 8005A244 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4AA48 8005A248 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4AA4C 8005A24C 40111300 */  sll        $v0, $s3, 5
    /* 4AA50 8005A250 21284300 */  addu       $a1, $v0, $v1
    /* 4AA54 8005A254 1180033C */  lui        $v1, %hi(D_8010CD2C)
    /* 4AA58 8005A258 06000224 */  addiu      $v0, $zero, 0x6
    /* 4AA5C 8005A25C 1D00A690 */  lbu        $a2, 0x1D($a1)
    /* 4AA60 8005A260 2CCD638C */  lw         $v1, %lo(D_8010CD2C)($v1)
    /* 4AA64 8005A264 02210600 */  srl        $a0, $a2, 4
    /* 4AA68 8005A268 23104400 */  subu       $v0, $v0, $a0
    /* 4AA6C 8005A26C 04006210 */  beq        $v1, $v0, .L8005A280
    /* 4AA70 8005A270 0F00C230 */   andi      $v0, $a2, 0xF
    /* 4AA74 8005A274 07004224 */  addiu      $v0, $v0, 0x7
    /* 4AA78 8005A278 13006214 */  bne        $v1, $v0, .L8005A2C8
    /* 4AA7C 8005A27C 07006228 */   slti      $v0, $v1, 0x7
  .L8005A280:
    /* 4AA80 8005A280 07006228 */  slti       $v0, $v1, 0x7
    /* 4AA84 8005A284 09004010 */  beqz       $v0, .L8005A2AC
    /* 4AA88 8005A288 00000000 */   nop
    /* 4AA8C 8005A28C 1E00A290 */  lbu        $v0, 0x1E($a1)
    /* 4AA90 8005A290 FAFF6324 */  addiu      $v1, $v1, -0x6
    /* 4AA94 8005A294 C0130200 */  sll        $v0, $v0, 15
    /* 4AA98 8005A298 18006200 */  mult       $v1, $v0
    /* 4AA9C 8005A29C 3401028E */  lw         $v0, 0x134($s0)
    /* 4AAA0 8005A2A0 12380000 */  mflo       $a3
    /* 4AAA4 8005A2A4 C3680108 */  j          .L8005A30C
    /* 4AAA8 8005A2A8 2310E200 */   subu      $v0, $a3, $v0
  .L8005A2AC:
    /* 4AAAC 8005A2AC 1F00A290 */  lbu        $v0, 0x1F($a1)
    /* 4AAB0 8005A2B0 F9FF6324 */  addiu      $v1, $v1, -0x7
    /* 4AAB4 8005A2B4 C0130200 */  sll        $v0, $v0, 15
    /* 4AAB8 8005A2B8 18006200 */  mult       $v1, $v0
    /* 4AABC 8005A2BC 3401028E */  lw         $v0, 0x134($s0)
    /* 4AAC0 8005A2C0 C1680108 */  j          .L8005A304
    /* 4AAC4 8005A2C4 00000000 */   nop
  .L8005A2C8:
    /* 4AAC8 8005A2C8 09004010 */  beqz       $v0, .L8005A2F0
    /* 4AACC 8005A2CC 00000000 */   nop
    /* 4AAD0 8005A2D0 1E00A290 */  lbu        $v0, 0x1E($a1)
    /* 4AAD4 8005A2D4 FAFF6324 */  addiu      $v1, $v1, -0x6
    /* 4AAD8 8005A2D8 C0130200 */  sll        $v0, $v0, 15
    /* 4AADC 8005A2DC 18006200 */  mult       $v1, $v0
    /* 4AAE0 8005A2E0 42100200 */  srl        $v0, $v0, 1
    /* 4AAE4 8005A2E4 12380000 */  mflo       $a3
    /* 4AAE8 8005A2E8 C3680108 */  j          .L8005A30C
    /* 4AAEC 8005A2EC 2310E200 */   subu      $v0, $a3, $v0
  .L8005A2F0:
    /* 4AAF0 8005A2F0 1F00A290 */  lbu        $v0, 0x1F($a1)
    /* 4AAF4 8005A2F4 F9FF6324 */  addiu      $v1, $v1, -0x7
    /* 4AAF8 8005A2F8 C0130200 */  sll        $v0, $v0, 15
    /* 4AAFC 8005A2FC 18006200 */  mult       $v1, $v0
    /* 4AB00 8005A300 42100200 */  srl        $v0, $v0, 1
  .L8005A304:
    /* 4AB04 8005A304 12380000 */  mflo       $a3
    /* 4AB08 8005A308 2110E200 */  addu       $v0, $a3, $v0
  .L8005A30C:
    /* 4AB0C 8005A30C 580502AE */  sw         $v0, 0x558($s0)
    /* 4AB10 8005A310 40291300 */  sll        $a1, $s3, 5
    /* 4AB14 8005A314 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 4AB18 8005A318 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 4AB1C 8005A31C 3401048E */  lw         $a0, 0x134($s0)
    /* 4AB20 8005A320 2110A200 */  addu       $v0, $a1, $v0
    /* 4AB24 8005A324 1A004384 */  lh         $v1, 0x1A($v0)
    /* 4AB28 8005A328 5805028E */  lw         $v0, 0x558($s0)
    /* 4AB2C 8005A32C 001A0300 */  sll        $v1, $v1, 8
    /* 4AB30 8005A330 23186400 */  subu       $v1, $v1, $a0
    /* 4AB34 8005A334 2A106200 */  slt        $v0, $v1, $v0
    /* 4AB38 8005A338 02004010 */  beqz       $v0, .L8005A344
    /* 4AB3C 8005A33C 00000000 */   nop
    /* 4AB40 8005A340 580503AE */  sw         $v1, 0x558($s0)
  .L8005A344:
    /* 4AB44 8005A344 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 4AB48 8005A348 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 4AB4C 8005A34C 3401048E */  lw         $a0, 0x134($s0)
    /* 4AB50 8005A350 2110A200 */  addu       $v0, $a1, $v0
    /* 4AB54 8005A354 18004384 */  lh         $v1, 0x18($v0)
    /* 4AB58 8005A358 5805028E */  lw         $v0, 0x558($s0)
    /* 4AB5C 8005A35C 001A0300 */  sll        $v1, $v1, 8
    /* 4AB60 8005A360 23208300 */  subu       $a0, $a0, $v1
    /* 4AB64 8005A364 2A104400 */  slt        $v0, $v0, $a0
    /* 4AB68 8005A368 02004010 */  beqz       $v0, .L8005A374
    /* 4AB6C 8005A36C 00000000 */   nop
    /* 4AB70 8005A370 580504AE */  sw         $a0, 0x558($s0)
  .L8005A374:
    /* 4AB74 8005A374 2000BF8F */  lw         $ra, 0x20($sp)
    /* 4AB78 8005A378 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4AB7C 8005A37C 1800B28F */  lw         $s2, 0x18($sp)
    /* 4AB80 8005A380 1400B18F */  lw         $s1, 0x14($sp)
    /* 4AB84 8005A384 1000B08F */  lw         $s0, 0x10($sp)
    /* 4AB88 8005A388 0800E003 */  jr         $ra
    /* 4AB8C 8005A38C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AI_CalculateDesiredLatPosition__FP8Car_tObj
