.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForWipeOut__10AIHigh_Cop, 0x178

glabel CheckForWipeOut__10AIHigh_Cop
    /* 55C30 80065430 21508000 */  addu       $t2, $a0, $zero
    /* 55C34 80065434 0800438D */  lw         $v1, 0x8($t2)
    /* 55C38 80065438 04000224 */  addiu      $v0, $zero, 0x4
    /* 55C3C 8006543C 58006214 */  bne        $v1, $v0, .L800655A0
    /* 55C40 80065440 00000000 */   nop
    /* 55C44 80065444 5800448D */  lw         $a0, 0x58($t2)
    /* 55C48 80065448 00000000 */  nop
    /* 55C4C 8006544C 19008010 */  beqz       $a0, .L800654B4
    /* 55C50 80065450 21280000 */   addu      $a1, $zero, $zero
    /* 55C54 80065454 0000828C */  lw         $v0, 0x0($a0)
    /* 55C58 80065458 00000000 */  nop
    /* 55C5C 8006545C 6002428C */  lw         $v0, 0x260($v0)
    /* 55C60 80065460 00000000 */  nop
    /* 55C64 80065464 08004230 */  andi       $v0, $v0, 0x8
    /* 55C68 80065468 12004010 */  beqz       $v0, .L800654B4
    /* 55C6C 8006546C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 55C70 80065470 0000438D */  lw         $v1, 0x0($t2)
    /* 55C74 80065474 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 55C78 80065478 4807638C */  lw         $v1, 0x748($v1)
    /* 55C7C 8006547C 00000000 */  nop
    /* 55C80 80065480 2A104300 */  slt        $v0, $v0, $v1
    /* 55C84 80065484 0B004014 */  bnez       $v0, .L800654B4
    /* 55C88 80065488 00000000 */   nop
    /* 55C8C 8006548C 8C00838C */  lw         $v1, 0x8C($a0)
    /* 55C90 80065490 00000000 */  nop
    /* 55C94 80065494 04006104 */  bgez       $v1, .L800654A8
    /* 55C98 80065498 03140300 */   sra       $v0, $v1, 16
    /* 55C9C 8006549C FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 55CA0 800654A0 21186200 */  addu       $v1, $v1, $v0
    /* 55CA4 800654A4 03140300 */  sra        $v0, $v1, 16
  .L800654A8:
    /* 55CA8 800654A8 02004228 */  slti       $v0, $v0, 0x2
    /* 55CAC 800654AC 02004014 */  bnez       $v0, .L800654B8
    /* 55CB0 800654B0 00000000 */   nop
  .L800654B4:
    /* 55CB4 800654B4 01000524 */  addiu      $a1, $zero, 0x1
  .L800654B8:
    /* 55CB8 800654B8 3900A014 */  bnez       $a1, .L800655A0
    /* 55CBC 800654BC 21380000 */   addu      $a3, $zero, $zero
    /* 55CC0 800654C0 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 55CC4 800654C4 38CD4D24 */  addiu      $t5, $v0, %lo(highLevelAIObjs)
    /* 55CC8 800654C8 1280043C */  lui        $a0, %hi(simGlobal)
    /* 55CCC 800654CC 1480033C */  lui        $v1, %hi(fastRandom)
    /* 55CD0 800654D0 FCD0638C */  lw         $v1, %lo(fastRandom)($v1)
    /* 55CD4 800654D4 1480023C */  lui        $v0, %hi(randSeed)
    /* 55CD8 800654D8 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 55CDC 800654DC ACE08C24 */  addiu      $t4, $a0, %lo(simGlobal)
    /* 55CE0 800654E0 18006200 */  mult       $v1, $v0
    /* 55CE4 800654E4 1480063C */  lui        $a2, %hi(AI_elapsedTime)
    /* 55CE8 800654E8 54C5C68C */  lw         $a2, %lo(AI_elapsedTime)($a2)
    /* 55CEC 800654EC 14800B3C */  lui        $t3, %hi(Cars_gNumHumanRaceCars)
    /* 55CF0 800654F0 00C86B8D */  lw         $t3, %lo(Cars_gNumHumanRaceCars)($t3)
    /* 55CF4 800654F4 5800448D */  lw         $a0, 0x58($t2)
    /* 55CF8 800654F8 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 55CFC 800654FC 48FA4524 */  addiu      $a1, $v0, %lo(Cars_gHumanRaceCarList)
    /* 55D00 80065500 40100600 */  sll        $v0, $a2, 1
    /* 55D04 80065504 21104600 */  addu       $v0, $v0, $a2
    /* 55D08 80065508 80100200 */  sll        $v0, $v0, 2
    /* 55D0C 8006550C 23104600 */  subu       $v0, $v0, $a2
    /* 55D10 80065510 C0480200 */  sll        $t1, $v0, 3
    /* 55D14 80065514 9400888C */  lw         $t0, 0x94($a0)
    /* 55D18 80065518 12180000 */  mflo       $v1
    /* 55D1C 8006551C 02120300 */  srl        $v0, $v1, 8
    /* 55D20 80065520 FFFF4430 */  andi       $a0, $v0, 0xFFFF
    /* 55D24 80065524 1480013C */  lui        $at, %hi(randtemp)
    /* 55D28 80065528 00D123AC */  sw         $v1, %lo(randtemp)($at)
    /* 55D2C 8006552C FFFF6330 */  andi       $v1, $v1, 0xFFFF
    /* 55D30 80065530 1480013C */  lui        $at, %hi(fastRandom)
    /* 55D34 80065534 FCD023AC */  sw         $v1, %lo(fastRandom)($at)
  .L80065538:
    /* 55D38 80065538 2A10EB00 */  slt        $v0, $a3, $t3
    /* 55D3C 8006553C 18004010 */  beqz       $v0, .L800655A0
    /* 55D40 80065540 00000000 */   nop
    /* 55D44 80065544 0000A28C */  lw         $v0, 0x0($a1)
    /* 55D48 80065548 00000000 */  nop
    /* 55D4C 8006554C 5402428C */  lw         $v0, 0x254($v0)
    /* 55D50 80065550 00000000 */  nop
    /* 55D54 80065554 80100200 */  sll        $v0, $v0, 2
    /* 55D58 80065558 21104D00 */  addu       $v0, $v0, $t5
    /* 55D5C 8006555C 0000428C */  lw         $v0, 0x0($v0)
    /* 55D60 80065560 00000000 */  nop
    /* 55D64 80065564 9400428C */  lw         $v0, 0x94($v0)
    /* 55D68 80065568 00000000 */  nop
    /* 55D6C 8006556C 2A100201 */  slt        $v0, $t0, $v0
    /* 55D70 80065570 08004010 */  beqz       $v0, .L80065594
    /* 55D74 80065574 21182601 */   addu      $v1, $t1, $a2
    /* 55D78 80065578 2A108300 */  slt        $v0, $a0, $v1
    /* 55D7C 8006557C 05004010 */  beqz       $v0, .L80065594
    /* 55D80 80065580 00000000 */   nop
    /* 55D84 80065584 0400828D */  lw         $v0, 0x4($t4)
    /* 55D88 80065588 0000438D */  lw         $v1, 0x0($t2)
    /* 55D8C 8006558C 80024224 */  addiu      $v0, $v0, 0x280
    /* 55D90 80065590 480762AC */  sw         $v0, 0x748($v1)
  .L80065594:
    /* 55D94 80065594 0400A524 */  addiu      $a1, $a1, 0x4
    /* 55D98 80065598 4E950108 */  j          .L80065538
    /* 55D9C 8006559C 0100E724 */   addiu     $a3, $a3, 0x1
  .L800655A0:
    /* 55DA0 800655A0 0800E003 */  jr         $ra
    /* 55DA4 800655A4 00000000 */   nop
endlabel CheckForWipeOut__10AIHigh_Cop
