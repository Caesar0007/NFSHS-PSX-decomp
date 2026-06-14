.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef, 0x244

glabel Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
    /* 7A344 80089B44 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 7A348 80089B48 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7A34C 80089B4C 2188A000 */  addu       $s1, $a1, $zero
    /* 7A350 80089B50 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7A354 80089B54 2190C000 */  addu       $s2, $a2, $zero
    /* 7A358 80089B58 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 7A35C 80089B5C EC314624 */  addiu      $a2, $v0, %lo(GameSetup_gData)
    /* 7A360 80089B60 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 7A364 80089B64 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7A368 80089B68 3000C28C */  lw         $v0, 0x30($a2)
    /* 7A36C 80089B6C 00000000 */  nop
    /* 7A370 80089B70 02004010 */  beqz       $v0, .L80089B7C
    /* 7A374 80089B74 FFFF0524 */   addiu     $a1, $zero, -0x1
    /* 7A378 80089B78 01000524 */  addiu      $a1, $zero, 0x1
  .L80089B7C:
    /* 7A37C 80089B7C 5402828C */  lw         $v0, 0x254($a0)
    /* 7A380 80089B80 00000000 */  nop
    /* 7A384 80089B84 40180200 */  sll        $v1, $v0, 1
    /* 7A388 80089B88 21186200 */  addu       $v1, $v1, $v0
    /* 7A38C 80089B8C 00110300 */  sll        $v0, $v1, 4
    /* 7A390 80089B90 23104300 */  subu       $v0, $v0, $v1
    /* 7A394 80089B94 80100200 */  sll        $v0, $v0, 2
    /* 7A398 80089B98 21104600 */  addu       $v0, $v0, $a2
    /* 7A39C 80089B9C AC02838F */  lw         $v1, %gp_rel(Cars_gNumRaceCars)($gp)
    /* 7A3A0 80089BA0 2804478C */  lw         $a3, 0x428($v0)
    /* 7A3A4 80089BA4 03006328 */  slti       $v1, $v1, 0x3
    /* 7A3A8 80089BA8 15006014 */  bnez       $v1, .L80089C00
    /* 7A3AC 80089BAC 80100500 */   sll       $v0, $a1, 2
    /* 7A3B0 80089BB0 21104500 */  addu       $v0, $v0, $a1
    /* 7A3B4 80089BB4 40100200 */  sll        $v0, $v0, 1
    /* 7A3B8 80089BB8 18004700 */  mult       $v0, $a3
    /* 7A3BC 80089BBC 12400000 */  mflo       $t0
    /* 7A3C0 80089BC0 2118A800 */  addu       $v1, $a1, $t0
    /* 7A3C4 80089BC4 0A006004 */  bltz       $v1, .L80089BF0
    /* 7A3C8 80089BC8 00000000 */   nop
    /* 7A3CC 80089BCC 1480063C */  lui        $a2, %hi(gNumSlices)
    /* 7A3D0 80089BD0 C8C7C68C */  lw         $a2, %lo(gNumSlices)($a2)
    /* 7A3D4 80089BD4 00000000 */  nop
    /* 7A3D8 80089BD8 2A106600 */  slt        $v0, $v1, $a2
    /* 7A3DC 80089BDC 02004014 */  bnez       $v0, .L80089BE8
    /* 7A3E0 80089BE0 21286000 */   addu      $a1, $v1, $zero
    /* 7A3E4 80089BE4 23286600 */  subu       $a1, $v1, $a2
  .L80089BE8:
    /* 7A3E8 80089BE8 10270208 */  j          .L80089C40
    /* 7A3EC 80089BEC 000025AE */   sw        $a1, 0x0($s1)
  .L80089BF0:
    /* 7A3F0 80089BF0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 7A3F4 80089BF4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 7A3F8 80089BF8 0F270208 */  j          .L80089C3C
    /* 7A3FC 80089BFC 21106200 */   addu      $v0, $v1, $v0
  .L80089C00:
    /* 7A400 80089C00 0A00A004 */  bltz       $a1, .L80089C2C
    /* 7A404 80089C04 00000000 */   nop
    /* 7A408 80089C08 1480063C */  lui        $a2, %hi(gNumSlices)
    /* 7A40C 80089C0C C8C7C68C */  lw         $a2, %lo(gNumSlices)($a2)
    /* 7A410 80089C10 00000000 */  nop
    /* 7A414 80089C14 2A10A600 */  slt        $v0, $a1, $a2
    /* 7A418 80089C18 02004014 */  bnez       $v0, .L80089C24
    /* 7A41C 80089C1C 2118A000 */   addu      $v1, $a1, $zero
    /* 7A420 80089C20 2318A600 */  subu       $v1, $a1, $a2
  .L80089C24:
    /* 7A424 80089C24 10270208 */  j          .L80089C40
    /* 7A428 80089C28 000023AE */   sw        $v1, 0x0($s1)
  .L80089C2C:
    /* 7A42C 80089C2C 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 7A430 80089C30 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 7A434 80089C34 00000000 */  nop
    /* 7A438 80089C38 2110A200 */  addu       $v0, $a1, $v0
  .L80089C3C:
    /* 7A43C 80089C3C 000022AE */  sw         $v0, 0x0($s1)
  .L80089C40:
    /* 7A440 80089C40 5005838C */  lw         $v1, 0x550($a0)
    /* 7A444 80089C44 1480023C */  lui        $v0, %hi(AITune_driveSide)
    /* 7A448 80089C48 F4C5428C */  lw         $v0, %lo(AITune_driveSide)($v0)
    /* 7A44C 80089C4C 00000000 */  nop
    /* 7A450 80089C50 18006200 */  mult       $v1, $v0
    /* 7A454 80089C54 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 7A458 80089C58 12400000 */  mflo       $t0
    /* 7A45C 80089C5C 03000215 */  bne        $t0, $v0, .L80089C6C
    /* 7A460 80089C60 0100F030 */   andi      $s0, $a3, 0x1
    /* 7A464 80089C64 01000224 */  addiu      $v0, $zero, 0x1
    /* 7A468 80089C68 23805000 */  subu       $s0, $v0, $s0
  .L80089C6C:
    /* 7A46C 80089C6C 9ACB010C */  jal        AITune_GetOneWay__Fv
    /* 7A470 80089C70 00000000 */   nop
    /* 7A474 80089C74 24004010 */  beqz       $v0, .L80089D08
    /* 7A478 80089C78 00000000 */   nop
    /* 7A47C 80089C7C 0000228E */  lw         $v0, 0x0($s1)
    /* 7A480 80089C80 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 7A484 80089C84 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 7A488 80089C88 40110200 */  sll        $v0, $v0, 5
    /* 7A48C 80089C8C 21104300 */  addu       $v0, $v0, $v1
    /* 7A490 80089C90 1E004490 */  lbu        $a0, 0x1E($v0)
    /* 7A494 80089C94 1D004690 */  lbu        $a2, 0x1D($v0)
    /* 7A498 80089C98 C0230400 */  sll        $a0, $a0, 15
    /* 7A49C 80089C9C 02290600 */  srl        $a1, $a2, 4
    /* 7A4A0 80089CA0 18008500 */  mult       $a0, $a1
    /* 7A4A4 80089CA4 1F004290 */  lbu        $v0, 0x1F($v0)
    /* 7A4A8 80089CA8 12200000 */  mflo       $a0
    /* 7A4AC 80089CAC C0130200 */  sll        $v0, $v0, 15
    /* 7A4B0 80089CB0 0F00C630 */  andi       $a2, $a2, 0xF
    /* 7A4B4 80089CB4 18004600 */  mult       $v0, $a2
    /* 7A4B8 80089CB8 2128A600 */  addu       $a1, $a1, $a2
    /* 7A4BC 80089CBC 12180000 */  mflo       $v1
    /* 7A4C0 80089CC0 21108300 */  addu       $v0, $a0, $v1
    /* 7A4C4 80089CC4 42180200 */  srl        $v1, $v0, 1
    /* 7A4C8 80089CC8 23186400 */  subu       $v1, $v1, $a0
    /* 7A4CC 80089CCC 1A004500 */  div        $zero, $v0, $a1
    /* 7A4D0 80089CD0 0200A014 */  bnez       $a1, .L80089CDC
    /* 7A4D4 80089CD4 00000000 */   nop
    /* 7A4D8 80089CD8 0D000700 */  break      7
  .L80089CDC:
    /* 7A4DC 80089CDC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 7A4E0 80089CE0 0400A114 */  bne        $a1, $at, .L80089CF4
    /* 7A4E4 80089CE4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 7A4E8 80089CE8 02004114 */  bne        $v0, $at, .L80089CF4
    /* 7A4EC 80089CEC 00000000 */   nop
    /* 7A4F0 80089CF0 0D000600 */  break      6
  .L80089CF4:
    /* 7A4F4 80089CF4 12200000 */  mflo       $a0
    /* 7A4F8 80089CF8 19000016 */  bnez       $s0, .L80089D60
    /* 7A4FC 80089CFC 21106400 */   addu      $v0, $v1, $a0
    /* 7A500 80089D00 58270208 */  j          .L80089D60
    /* 7A504 80089D04 23106400 */   subu      $v0, $v1, $a0
  .L80089D08:
    /* 7A508 80089D08 09000012 */  beqz       $s0, .L80089D30
    /* 7A50C 80089D0C 00000000 */   nop
    /* 7A510 80089D10 0000228E */  lw         $v0, 0x0($s1)
    /* 7A514 80089D14 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 7A518 80089D18 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 7A51C 80089D1C 40110200 */  sll        $v0, $v0, 5
    /* 7A520 80089D20 21104300 */  addu       $v0, $v0, $v1
    /* 7A524 80089D24 1F004290 */  lbu        $v0, 0x1F($v0)
    /* 7A528 80089D28 58270208 */  j          .L80089D60
    /* 7A52C 80089D2C 80130200 */   sll       $v0, $v0, 14
  .L80089D30:
    /* 7A530 80089D30 0000228E */  lw         $v0, 0x0($s1)
    /* 7A534 80089D34 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 7A538 80089D38 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 7A53C 80089D3C 40110200 */  sll        $v0, $v0, 5
    /* 7A540 80089D40 21104300 */  addu       $v0, $v0, $v1
    /* 7A544 80089D44 1E004290 */  lbu        $v0, 0x1E($v0)
    /* 7A548 80089D48 00000000 */  nop
    /* 7A54C 80089D4C C0130200 */  sll        $v0, $v0, 15
    /* 7A550 80089D50 23100200 */  negu       $v0, $v0
    /* 7A554 80089D54 C21F0200 */  srl        $v1, $v0, 31
    /* 7A558 80089D58 21104300 */  addu       $v0, $v0, $v1
    /* 7A55C 80089D5C 43100200 */  sra        $v0, $v0, 1
  .L80089D60:
    /* 7A560 80089D60 000042AE */  sw         $v0, 0x0($s2)
    /* 7A564 80089D64 00800234 */  ori        $v0, $zero, 0x8000
    /* 7A568 80089D68 040042AE */  sw         $v0, 0x4($s2)
    /* 7A56C 80089D6C 080040AE */  sw         $zero, 0x8($s2)
    /* 7A570 80089D70 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 7A574 80089D74 1800B28F */  lw         $s2, 0x18($sp)
    /* 7A578 80089D78 1400B18F */  lw         $s1, 0x14($sp)
    /* 7A57C 80089D7C 1000B08F */  lw         $s0, 0x10($sp)
    /* 7A580 80089D80 0800E003 */  jr         $ra
    /* 7A584 80089D84 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef
