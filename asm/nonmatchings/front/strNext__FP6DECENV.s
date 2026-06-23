.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strNext__FP6DECENV, 0x208

glabel strNext__FP6DECENV
    /* 3DBD4 8004D3D4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3DBD8 8004D3D8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 3DBDC 8004D3DC 21888000 */  addu       $s1, $a0, $zero
    /* 3DBE0 8004D3E0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 3DBE4 8004D3E4 50C31034 */  ori        $s0, $zero, 0xC350
    /* 3DBE8 8004D3E8 2800BFAF */  sw         $ra, 0x28($sp)
    /* 3DBEC 8004D3EC 1800A427 */  addiu      $a0, $sp, 0x18
  .L8004D3F0:
    /* 3DBF0 8004D3F0 8AE6030C */  jal        StGetNext
    /* 3DBF4 8004D3F4 1C00A527 */   addiu     $a1, $sp, 0x1C
    /* 3DBF8 8004D3F8 05004010 */  beqz       $v0, .L8004D410
    /* 3DBFC 8004D3FC FFFF1026 */   addiu     $s0, $s0, -0x1
    /* 3DC00 8004D400 FBFF0016 */  bnez       $s0, .L8004D3F0
    /* 3DC04 8004D404 1800A427 */   addiu     $a0, $sp, 0x18
    /* 3DC08 8004D408 72350108 */  j          .L8004D5C8
    /* 3DC0C 8004D40C 21100000 */   addu      $v0, $zero, $zero
  .L8004D410:
    /* 3DC10 8004D410 1800A48F */  lw         $a0, 0x18($sp)
    /* 3DC14 8004D414 1C00A58F */  lw         $a1, 0x1C($sp)
    /* 3DC18 8004D418 0000838C */  lw         $v1, 0x0($a0)
    /* 3DC1C 8004D41C 1400A28C */  lw         $v0, 0x14($a1)
    /* 3DC20 8004D420 00000000 */  nop
    /* 3DC24 8004D424 06006214 */  bne        $v1, $v0, .L8004D440
    /* 3DC28 8004D428 00000000 */   nop
    /* 3DC2C 8004D42C 0400838C */  lw         $v1, 0x4($a0)
    /* 3DC30 8004D430 1800A28C */  lw         $v0, 0x18($a1)
    /* 3DC34 8004D434 00000000 */  nop
    /* 3DC38 8004D438 05006210 */  beq        $v1, $v0, .L8004D450
    /* 3DC3C 8004D43C 00000000 */   nop
  .L8004D440:
    /* 3DC40 8004D440 65EA030C */  jal        StFreeRing
    /* 3DC44 8004D444 00000000 */   nop
    /* 3DC48 8004D448 72350108 */  j          .L8004D5C8
    /* 3DC4C 8004D44C 21100000 */   addu      $v0, $zero, $zero
  .L8004D450:
    /* 3DC50 8004D450 0580043C */  lui        $a0, %hi(D_80052D0C)
    /* 3DC54 8004D454 0C2D828C */  lw         $v0, %lo(D_80052D0C)($a0)
    /* 3DC58 8004D458 0800A38C */  lw         $v1, 0x8($a1)
    /* 3DC5C 8004D45C 00000000 */  nop
    /* 3DC60 8004D460 2B106200 */  sltu       $v0, $v1, $v0
    /* 3DC64 8004D464 06004014 */  bnez       $v0, .L8004D480
    /* 3DC68 8004D468 0580023C */   lui       $v0, %hi(D_80052D10)
    /* 3DC6C 8004D46C 102D428C */  lw         $v0, %lo(D_80052D10)($v0)
    /* 3DC70 8004D470 00000000 */  nop
    /* 3DC74 8004D474 2B106200 */  sltu       $v0, $v1, $v0
    /* 3DC78 8004D478 05004014 */  bnez       $v0, .L8004D490
    /* 3DC7C 8004D47C 00000000 */   nop
  .L8004D480:
    /* 3DC80 8004D480 0580033C */  lui        $v1, %hi(D_80052D1C)
    /* 3DC84 8004D484 01000224 */  addiu      $v0, $zero, 0x1
    /* 3DC88 8004D488 25350108 */  j          .L8004D494
    /* 3DC8C 8004D48C 1C2D62AC */   sw        $v0, %lo(D_80052D1C)($v1)
  .L8004D490:
    /* 3DC90 8004D490 0C2D83AC */  sw         $v1, %lo(D_80052D0C)($a0)
  .L8004D494:
    /* 3DC94 8004D494 0580103C */  lui        $s0, %hi(D_80052A24)
    /* 3DC98 8004D498 1C00A48F */  lw         $a0, 0x1C($sp)
    /* 3DC9C 8004D49C 242A028E */  lw         $v0, %lo(D_80052A24)($s0)
    /* 3DCA0 8004D4A0 10008394 */  lhu        $v1, 0x10($a0)
    /* 3DCA4 8004D4A4 00000000 */  nop
    /* 3DCA8 8004D4A8 07004314 */  bne        $v0, $v1, .L8004D4C8
    /* 3DCAC 8004D4AC 0580023C */   lui       $v0, %hi(D_80052CFC)
    /* 3DCB0 8004D4B0 0580023C */  lui        $v0, %hi(D_80052A28)
    /* 3DCB4 8004D4B4 12008394 */  lhu        $v1, 0x12($a0)
    /* 3DCB8 8004D4B8 282A428C */  lw         $v0, %lo(D_80052A28)($v0)
    /* 3DCBC 8004D4BC 00000000 */  nop
    /* 3DCC0 8004D4C0 24004310 */  beq        $v0, $v1, .L8004D554
    /* 3DCC4 8004D4C4 0580023C */   lui       $v0, %hi(D_80052CFC)
  .L8004D4C8:
    /* 3DCC8 8004D4C8 FC2C4384 */  lh         $v1, %lo(D_80052CFC)($v0)
    /* 3DCCC 8004D4CC 00000000 */  nop
    /* 3DCD0 8004D4D0 80100300 */  sll        $v0, $v1, 2
    /* 3DCD4 8004D4D4 21104300 */  addu       $v0, $v0, $v1
    /* 3DCD8 8004D4D8 0580033C */  lui        $v1, %hi(D_80052CFE)
    /* 3DCDC 8004D4DC FE2C6384 */  lh         $v1, %lo(D_80052CFE)($v1)
    /* 3DCE0 8004D4E0 C0110200 */  sll        $v0, $v0, 7
    /* 3DCE4 8004D4E4 1A004300 */  div        $zero, $v0, $v1
    /* 3DCE8 8004D4E8 02006014 */  bnez       $v1, .L8004D4F4
    /* 3DCEC 8004D4EC 00000000 */   nop
    /* 3DCF0 8004D4F0 0D000700 */  break      7
  .L8004D4F4:
    /* 3DCF4 8004D4F4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3DCF8 8004D4F8 04006114 */  bne        $v1, $at, .L8004D50C
    /* 3DCFC 8004D4FC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3DD00 8004D500 02004114 */  bne        $v0, $at, .L8004D50C
    /* 3DD04 8004D504 00000000 */   nop
    /* 3DD08 8004D508 0D000600 */  break      6
  .L8004D50C:
    /* 3DD0C 8004D50C 12100000 */  mflo       $v0
    /* 3DD10 8004D510 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3DD14 8004D514 21280000 */  addu       $a1, $zero, $zero
    /* 3DD18 8004D518 2130A000 */  addu       $a2, $a1, $zero
    /* 3DD1C 8004D51C 2138A000 */  addu       $a3, $a1, $zero
    /* 3DD20 8004D520 1000A0A7 */  sh         $zero, 0x10($sp)
    /* 3DD24 8004D524 1200A0A7 */  sh         $zero, 0x12($sp)
    /* 3DD28 8004D528 E0010324 */  addiu      $v1, $zero, 0x1E0
    /* 3DD2C 8004D52C 1600A3A7 */  sh         $v1, 0x16($sp)
    /* 3DD30 8004D530 80B6030C */  jal        ClearImage
    /* 3DD34 8004D534 1400A2A7 */   sh        $v0, 0x14($sp)
    /* 3DD38 8004D538 1C00A38F */  lw         $v1, 0x1C($sp)
    /* 3DD3C 8004D53C 00000000 */  nop
    /* 3DD40 8004D540 10006294 */  lhu        $v0, 0x10($v1)
    /* 3DD44 8004D544 12006394 */  lhu        $v1, 0x12($v1)
    /* 3DD48 8004D548 242A02AE */  sw         $v0, %lo(D_80052A24)($s0)
    /* 3DD4C 8004D54C 0580023C */  lui        $v0, %hi(D_80052A28)
    /* 3DD50 8004D550 282A43AC */  sw         $v1, %lo(D_80052A28)($v0)
  .L8004D554:
    /* 3DD54 8004D554 0580043C */  lui        $a0, %hi(D_80052A24)
    /* 3DD58 8004D558 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3DD5C 8004D55C FC2C4384 */  lh         $v1, %lo(D_80052CFC)($v0)
    /* 3DD60 8004D560 242A828C */  lw         $v0, %lo(D_80052A24)($a0)
    /* 3DD64 8004D564 00000000 */  nop
    /* 3DD68 8004D568 18004300 */  mult       $v0, $v1
    /* 3DD6C 8004D56C 0580023C */  lui        $v0, %hi(D_80052CFE)
    /* 3DD70 8004D570 12180000 */  mflo       $v1
    /* 3DD74 8004D574 FE2C4484 */  lh         $a0, %lo(D_80052CFE)($v0)
    /* 3DD78 8004D578 00000000 */  nop
    /* 3DD7C 8004D57C 1A006400 */  div        $zero, $v1, $a0
    /* 3DD80 8004D580 02008014 */  bnez       $a0, .L8004D58C
    /* 3DD84 8004D584 00000000 */   nop
    /* 3DD88 8004D588 0D000700 */  break      7
  .L8004D58C:
    /* 3DD8C 8004D58C FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3DD90 8004D590 04008114 */  bne        $a0, $at, .L8004D5A4
    /* 3DD94 8004D594 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3DD98 8004D598 02006114 */  bne        $v1, $at, .L8004D5A4
    /* 3DD9C 8004D59C 00000000 */   nop
    /* 3DDA0 8004D5A0 0D000600 */  break      6
  .L8004D5A4:
    /* 3DDA4 8004D5A4 12200000 */  mflo       $a0
    /* 3DDA8 8004D5A8 0580033C */  lui        $v1, %hi(D_80052A28)
    /* 3DDAC 8004D5AC 282A6394 */  lhu        $v1, %lo(D_80052A28)($v1)
    /* 3DDB0 8004D5B0 1800A28F */  lw         $v0, 0x18($sp)
    /* 3DDB4 8004D5B4 1E0023A6 */  sh         $v1, 0x1E($s1)
    /* 3DDB8 8004D5B8 160023A6 */  sh         $v1, 0x16($s1)
    /* 3DDBC 8004D5BC 2A0023A6 */  sh         $v1, 0x2A($s1)
    /* 3DDC0 8004D5C0 1C0024A6 */  sh         $a0, 0x1C($s1)
    /* 3DDC4 8004D5C4 140024A6 */  sh         $a0, 0x14($s1)
  .L8004D5C8:
    /* 3DDC8 8004D5C8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 3DDCC 8004D5CC 2400B18F */  lw         $s1, 0x24($sp)
    /* 3DDD0 8004D5D0 2000B08F */  lw         $s0, 0x20($sp)
    /* 3DDD4 8004D5D4 0800E003 */  jr         $ra
    /* 3DDD8 8004D5D8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel strNext__FP6DECENV
