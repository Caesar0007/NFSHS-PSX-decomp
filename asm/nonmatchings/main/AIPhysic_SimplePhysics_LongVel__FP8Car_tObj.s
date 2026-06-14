.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_SimplePhysics_LongVel__FP8Car_tObj, 0x358

glabel AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
    /* 5AA9C 8006A29C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5AAA0 8006A2A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5AAA4 8006A2A4 21808000 */  addu       $s0, $a0, $zero
    /* 5AAA8 8006A2A8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5AAAC 8006A2AC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5AAB0 8006A2B0 6405058E */  lw         $a1, 0x564($s0)
    /* 5AAB4 8006A2B4 ACA5010C */  jal        AIPhysic_CalcAcceleration__FP8Car_tObji
    /* 5AAB8 8006A2B8 00000000 */   nop
    /* 5AABC 8006A2BC 21200002 */  addu       $a0, $s0, $zero
    /* 5AAC0 8006A2C0 7AA6010C */  jal        AIPhysic_CalcDeceleration__FP8Car_tObj
    /* 5AAC4 8006A2C4 21884000 */   addu      $s1, $v0, $zero
    /* 5AAC8 8006A2C8 7802038E */  lw         $v1, 0x278($s0)
    /* 5AACC 8006A2CC 00000000 */  nop
    /* 5AAD0 8006A2D0 02006010 */  beqz       $v1, .L8006A2DC
    /* 5AAD4 8006A2D4 21284000 */   addu      $a1, $v0, $zero
    /* 5AAD8 8006A2D8 5C0500AE */  sw         $zero, 0x55C($s0)
  .L8006A2DC:
    /* 5AADC 8006A2DC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 5AAE0 8006A2E0 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 5AAE4 8006A2E4 4807038E */  lw         $v1, 0x748($s0)
    /* 5AAE8 8006A2E8 00000000 */  nop
    /* 5AAEC 8006A2EC 2A104300 */  slt        $v0, $v0, $v1
    /* 5AAF0 8006A2F0 08004010 */  beqz       $v0, .L8006A314
    /* 5AAF4 8006A2F4 00000000 */   nop
    /* 5AAF8 8006A2F8 5C05028E */  lw         $v0, 0x55C($s0)
    /* 5AAFC 8006A2FC 00000000 */  nop
    /* 5AB00 8006A300 02004104 */  bgez       $v0, .L8006A30C
    /* 5AB04 8006A304 00000000 */   nop
    /* 5AB08 8006A308 03004224 */  addiu      $v0, $v0, 0x3
  .L8006A30C:
    /* 5AB0C 8006A30C 83100200 */  sra        $v0, $v0, 2
    /* 5AB10 8006A310 5C0502AE */  sw         $v0, 0x55C($s0)
  .L8006A314:
    /* 5AB14 8006A314 5405048E */  lw         $a0, 0x554($s0)
    /* 5AB18 8006A318 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 5AB1C 8006A31C 57008214 */  bne        $a0, $v0, .L8006A47C
    /* 5AB20 8006A320 00000000 */   nop
    /* 5AB24 8006A324 5C05028E */  lw         $v0, 0x55C($s0)
    /* 5AB28 8006A328 6405038E */  lw         $v1, 0x564($s0)
    /* 5AB2C 8006A32C 00000000 */  nop
    /* 5AB30 8006A330 2A106200 */  slt        $v0, $v1, $v0
    /* 5AB34 8006A334 05004014 */  bnez       $v0, .L8006A34C
    /* 5AB38 8006A338 00000000 */   nop
    /* 5AB3C 8006A33C 5005028E */  lw         $v0, 0x550($s0)
    /* 5AB40 8006A340 00000000 */  nop
    /* 5AB44 8006A344 2B004410 */  beq        $v0, $a0, .L8006A3F4
    /* 5AB48 8006A348 00000000 */   nop
  .L8006A34C:
    /* 5AB4C 8006A34C 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5AB50 8006A350 40040392 */  lbu        $v1, 0x440($s0)
    /* 5AB54 8006A354 80100200 */  sll        $v0, $v0, 2
    /* 5AB58 8006A358 21186200 */  addu       $v1, $v1, $v0
    /* 5AB5C 8006A35C FF006228 */  slti       $v0, $v1, 0xFF
    /* 5AB60 8006A360 03004010 */  beqz       $v0, .L8006A370
    /* 5AB64 8006A364 140405AE */   sw        $a1, 0x414($s0)
    /* 5AB68 8006A368 DEA80108 */  j          .L8006A378
    /* 5AB6C 8006A36C 400403A2 */   sb        $v1, 0x440($s0)
  .L8006A370:
    /* 5AB70 8006A370 FF000224 */  addiu      $v0, $zero, 0xFF
    /* 5AB74 8006A374 400402A2 */  sb         $v0, 0x440($s0)
  .L8006A378:
    /* 5AB78 8006A378 40040292 */  lbu        $v0, 0x440($s0)
    /* 5AB7C 8006A37C 00000000 */  nop
    /* 5AB80 8006A380 0400422C */  sltiu      $v0, $v0, 0x4
    /* 5AB84 8006A384 02004014 */  bnez       $v0, .L8006A390
    /* 5AB88 8006A388 01000224 */   addiu     $v0, $zero, 0x1
    /* 5AB8C 8006A38C 3D0402A2 */  sb         $v0, 0x43D($s0)
  .L8006A390:
    /* 5AB90 8006A390 0200A104 */  bgez       $a1, .L8006A39C
    /* 5AB94 8006A394 2118A000 */   addu      $v1, $a1, $zero
    /* 5AB98 8006A398 FF00A324 */  addiu      $v1, $a1, 0xFF
  .L8006A39C:
    /* 5AB9C 8006A39C 4800828F */  lw         $v0, %gp_rel(AIPhysic_iTime)($gp)
    /* 5ABA0 8006A3A0 00000000 */  nop
    /* 5ABA4 8006A3A4 02004104 */  bgez       $v0, .L8006A3B0
    /* 5ABA8 8006A3A8 031A0300 */   sra       $v1, $v1, 8
    /* 5ABAC 8006A3AC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006A3B0:
    /* 5ABB0 8006A3B0 03120200 */  sra        $v0, $v0, 8
    /* 5ABB4 8006A3B4 18006200 */  mult       $v1, $v0
    /* 5ABB8 8006A3B8 6405028E */  lw         $v0, 0x564($s0)
    /* 5ABBC 8006A3BC 5405048E */  lw         $a0, 0x554($s0)
    /* 5ABC0 8006A3C0 5005038E */  lw         $v1, 0x550($s0)
    /* 5ABC4 8006A3C4 12300000 */  mflo       $a2
    /* 5ABC8 8006A3C8 21284600 */  addu       $a1, $v0, $a2
    /* 5ABCC 8006A3CC 84008314 */  bne        $a0, $v1, .L8006A5E0
    /* 5ABD0 8006A3D0 640505AE */   sw        $a1, 0x564($s0)
    /* 5ABD4 8006A3D4 5C05028E */  lw         $v0, 0x55C($s0)
    /* 5ABD8 8006A3D8 00000000 */  nop
    /* 5ABDC 8006A3DC 21184000 */  addu       $v1, $v0, $zero
    /* 5ABE0 8006A3E0 2A106500 */  slt        $v0, $v1, $a1
    /* 5ABE4 8006A3E4 7D004014 */  bnez       $v0, .L8006A5DC
    /* 5ABE8 8006A3E8 00000000 */   nop
    /* 5ABEC 8006A3EC 77A90108 */  j          .L8006A5DC
    /* 5ABF0 8006A3F0 2118A000 */   addu      $v1, $a1, $zero
  .L8006A3F4:
    /* 5ABF4 8006A3F4 02002106 */  bgez       $s1, .L8006A400
    /* 5ABF8 8006A3F8 21202002 */   addu      $a0, $s1, $zero
    /* 5ABFC 8006A3FC FF002426 */  addiu      $a0, $s1, 0xFF
  .L8006A400:
    /* 5AC00 8006A400 4800828F */  lw         $v0, %gp_rel(AIPhysic_iTime)($gp)
    /* 5AC04 8006A404 00000000 */  nop
    /* 5AC08 8006A408 02004104 */  bgez       $v0, .L8006A414
    /* 5AC0C 8006A40C 03220400 */   sra       $a0, $a0, 8
    /* 5AC10 8006A410 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006A414:
    /* 5AC14 8006A414 03120200 */  sra        $v0, $v0, 8
    /* 5AC18 8006A418 18008200 */  mult       $a0, $v0
    /* 5AC1C 8006A41C 40040492 */  lbu        $a0, 0x440($s0)
    /* 5AC20 8006A420 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5AC24 8006A424 00000000 */  nop
    /* 5AC28 8006A428 2A104400 */  slt        $v0, $v0, $a0
    /* 5AC2C 8006A42C 12300000 */  mflo       $a2
    /* 5AC30 8006A430 23186600 */  subu       $v1, $v1, $a2
    /* 5AC34 8006A434 06004010 */  beqz       $v0, .L8006A450
    /* 5AC38 8006A438 640503AE */   sw        $v1, 0x564($s0)
    /* 5AC3C 8006A43C 50008293 */  lbu        $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5AC40 8006A440 00000000 */  nop
    /* 5AC44 8006A444 23108200 */  subu       $v0, $a0, $v0
    /* 5AC48 8006A448 15A90108 */  j          .L8006A454
    /* 5AC4C 8006A44C 400402A2 */   sb        $v0, 0x440($s0)
  .L8006A450:
    /* 5AC50 8006A450 400400A2 */  sb         $zero, 0x440($s0)
  .L8006A454:
    /* 5AC54 8006A454 40040292 */  lbu        $v0, 0x440($s0)
    /* 5AC58 8006A458 00000000 */  nop
    /* 5AC5C 8006A45C 02004014 */  bnez       $v0, .L8006A468
    /* 5AC60 8006A460 00000000 */   nop
    /* 5AC64 8006A464 3D0400A2 */  sb         $zero, 0x43D($s0)
  .L8006A468:
    /* 5AC68 8006A468 6405028E */  lw         $v0, 0x564($s0)
    /* 5AC6C 8006A46C 5C05038E */  lw         $v1, 0x55C($s0)
    /* 5AC70 8006A470 140411AE */  sw         $s1, 0x414($s0)
    /* 5AC74 8006A474 75A90108 */  j          .L8006A5D4
    /* 5AC78 8006A478 2A104300 */   slt       $v0, $v0, $v1
  .L8006A47C:
    /* 5AC7C 8006A47C 5C05028E */  lw         $v0, 0x55C($s0)
    /* 5AC80 8006A480 6405038E */  lw         $v1, 0x564($s0)
    /* 5AC84 8006A484 00000000 */  nop
    /* 5AC88 8006A488 2A104300 */  slt        $v0, $v0, $v1
    /* 5AC8C 8006A48C 05004014 */  bnez       $v0, .L8006A4A4
    /* 5AC90 8006A490 00000000 */   nop
    /* 5AC94 8006A494 5005028E */  lw         $v0, 0x550($s0)
    /* 5AC98 8006A498 00000000 */  nop
    /* 5AC9C 8006A49C 2C008210 */  beq        $a0, $v0, .L8006A550
    /* 5ACA0 8006A4A0 00000000 */   nop
  .L8006A4A4:
    /* 5ACA4 8006A4A4 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5ACA8 8006A4A8 40040392 */  lbu        $v1, 0x440($s0)
    /* 5ACAC 8006A4AC 80100200 */  sll        $v0, $v0, 2
    /* 5ACB0 8006A4B0 21186200 */  addu       $v1, $v1, $v0
    /* 5ACB4 8006A4B4 FF006228 */  slti       $v0, $v1, 0xFF
    /* 5ACB8 8006A4B8 03004010 */  beqz       $v0, .L8006A4C8
    /* 5ACBC 8006A4BC 140405AE */   sw        $a1, 0x414($s0)
    /* 5ACC0 8006A4C0 34A90108 */  j          .L8006A4D0
    /* 5ACC4 8006A4C4 400403A2 */   sb        $v1, 0x440($s0)
  .L8006A4C8:
    /* 5ACC8 8006A4C8 FF000224 */  addiu      $v0, $zero, 0xFF
    /* 5ACCC 8006A4CC 400402A2 */  sb         $v0, 0x440($s0)
  .L8006A4D0:
    /* 5ACD0 8006A4D0 40040292 */  lbu        $v0, 0x440($s0)
    /* 5ACD4 8006A4D4 00000000 */  nop
    /* 5ACD8 8006A4D8 0400422C */  sltiu      $v0, $v0, 0x4
    /* 5ACDC 8006A4DC 04004014 */  bnez       $v0, .L8006A4F0
    /* 5ACE0 8006A4E0 2110A000 */   addu      $v0, $a1, $zero
    /* 5ACE4 8006A4E4 01000224 */  addiu      $v0, $zero, 0x1
    /* 5ACE8 8006A4E8 3D0402A2 */  sb         $v0, 0x43D($s0)
    /* 5ACEC 8006A4EC 2110A000 */  addu       $v0, $a1, $zero
  .L8006A4F0:
    /* 5ACF0 8006A4F0 02004104 */  bgez       $v0, .L8006A4FC
    /* 5ACF4 8006A4F4 00000000 */   nop
    /* 5ACF8 8006A4F8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006A4FC:
    /* 5ACFC 8006A4FC 4800838F */  lw         $v1, %gp_rel(AIPhysic_iTime)($gp)
    /* 5AD00 8006A500 00000000 */  nop
    /* 5AD04 8006A504 02006104 */  bgez       $v1, .L8006A510
    /* 5AD08 8006A508 03220200 */   sra       $a0, $v0, 8
    /* 5AD0C 8006A50C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006A510:
    /* 5AD10 8006A510 03120300 */  sra        $v0, $v1, 8
    /* 5AD14 8006A514 18008200 */  mult       $a0, $v0
    /* 5AD18 8006A518 6405028E */  lw         $v0, 0x564($s0)
    /* 5AD1C 8006A51C 5405048E */  lw         $a0, 0x554($s0)
    /* 5AD20 8006A520 5005038E */  lw         $v1, 0x550($s0)
    /* 5AD24 8006A524 12300000 */  mflo       $a2
    /* 5AD28 8006A528 23284600 */  subu       $a1, $v0, $a2
    /* 5AD2C 8006A52C 2C008314 */  bne        $a0, $v1, .L8006A5E0
    /* 5AD30 8006A530 640505AE */   sw        $a1, 0x564($s0)
    /* 5AD34 8006A534 5C05038E */  lw         $v1, 0x55C($s0)
    /* 5AD38 8006A538 00000000 */  nop
    /* 5AD3C 8006A53C 2A106500 */  slt        $v0, $v1, $a1
    /* 5AD40 8006A540 26004010 */  beqz       $v0, .L8006A5DC
    /* 5AD44 8006A544 00000000 */   nop
    /* 5AD48 8006A548 77A90108 */  j          .L8006A5DC
    /* 5AD4C 8006A54C 2118A000 */   addu      $v1, $a1, $zero
  .L8006A550:
    /* 5AD50 8006A550 02002106 */  bgez       $s1, .L8006A55C
    /* 5AD54 8006A554 21202002 */   addu      $a0, $s1, $zero
    /* 5AD58 8006A558 FF002426 */  addiu      $a0, $s1, 0xFF
  .L8006A55C:
    /* 5AD5C 8006A55C 4800828F */  lw         $v0, %gp_rel(AIPhysic_iTime)($gp)
    /* 5AD60 8006A560 00000000 */  nop
    /* 5AD64 8006A564 02004104 */  bgez       $v0, .L8006A570
    /* 5AD68 8006A568 03220400 */   sra       $a0, $a0, 8
    /* 5AD6C 8006A56C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006A570:
    /* 5AD70 8006A570 03120200 */  sra        $v0, $v0, 8
    /* 5AD74 8006A574 18008200 */  mult       $a0, $v0
    /* 5AD78 8006A578 40040492 */  lbu        $a0, 0x440($s0)
    /* 5AD7C 8006A57C 5000828F */  lw         $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5AD80 8006A580 00000000 */  nop
    /* 5AD84 8006A584 2A104400 */  slt        $v0, $v0, $a0
    /* 5AD88 8006A588 12300000 */  mflo       $a2
    /* 5AD8C 8006A58C 21186600 */  addu       $v1, $v1, $a2
    /* 5AD90 8006A590 06004010 */  beqz       $v0, .L8006A5AC
    /* 5AD94 8006A594 640503AE */   sw        $v1, 0x564($s0)
    /* 5AD98 8006A598 50008293 */  lbu        $v0, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5AD9C 8006A59C 00000000 */  nop
    /* 5ADA0 8006A5A0 23108200 */  subu       $v0, $a0, $v0
    /* 5ADA4 8006A5A4 6CA90108 */  j          .L8006A5B0
    /* 5ADA8 8006A5A8 400402A2 */   sb        $v0, 0x440($s0)
  .L8006A5AC:
    /* 5ADAC 8006A5AC 400400A2 */  sb         $zero, 0x440($s0)
  .L8006A5B0:
    /* 5ADB0 8006A5B0 40040292 */  lbu        $v0, 0x440($s0)
    /* 5ADB4 8006A5B4 00000000 */  nop
    /* 5ADB8 8006A5B8 02004014 */  bnez       $v0, .L8006A5C4
    /* 5ADBC 8006A5BC 00000000 */   nop
    /* 5ADC0 8006A5C0 3D0400A2 */  sb         $zero, 0x43D($s0)
  .L8006A5C4:
    /* 5ADC4 8006A5C4 6405028E */  lw         $v0, 0x564($s0)
    /* 5ADC8 8006A5C8 5C05038E */  lw         $v1, 0x55C($s0)
    /* 5ADCC 8006A5CC 140411AE */  sw         $s1, 0x414($s0)
    /* 5ADD0 8006A5D0 2A106200 */  slt        $v0, $v1, $v0
  .L8006A5D4:
    /* 5ADD4 8006A5D4 02004010 */  beqz       $v0, .L8006A5E0
    /* 5ADD8 8006A5D8 00000000 */   nop
  .L8006A5DC:
    /* 5ADDC 8006A5DC 640503AE */  sw         $v1, 0x564($s0)
  .L8006A5E0:
    /* 5ADE0 8006A5E0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5ADE4 8006A5E4 1400B18F */  lw         $s1, 0x14($sp)
    /* 5ADE8 8006A5E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 5ADEC 8006A5EC 0800E003 */  jr         $ra
    /* 5ADF0 8006A5F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIPhysic_SimplePhysics_LongVel__FP8Car_tObj
