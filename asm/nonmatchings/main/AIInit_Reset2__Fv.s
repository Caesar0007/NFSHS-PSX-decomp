.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_Reset2__Fv, 0x104

glabel AIInit_Reset2__Fv
    /* 57508 80066D08 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5750C 80066D0C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 57510 80066D10 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 57514 80066D14 03000224 */  addiu      $v0, $zero, 0x3
    /* 57518 80066D18 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5751C 80066D1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 57520 80066D20 05006210 */  beq        $v1, $v0, .L80066D38
    /* 57524 80066D24 1000B0AF */   sw        $s0, 0x10($sp)
    /* 57528 80066D28 01000224 */  addiu      $v0, $zero, 0x1
    /* 5752C 80066D2C 340082AF */  sw         $v0, %gp_rel(AIInit_useSpreadForce)($gp)
    /* 57530 80066D30 4F9B0108 */  j          .L80066D3C
    /* 57534 80066D34 00000000 */   nop
  .L80066D38:
    /* 57538 80066D38 340080AF */  sw         $zero, %gp_rel(AIInit_useSpreadForce)($gp)
  .L80066D3C:
    /* 5753C 80066D3C 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 57540 80066D40 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 57544 80066D44 00000000 */  nop
    /* 57548 80066D48 0D004018 */  blez       $v0, .L80066D80
    /* 5754C 80066D4C 21800000 */   addu      $s0, $zero, $zero
    /* 57550 80066D50 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 57554 80066D54 DCF95124 */  addiu      $s1, $v0, %lo(Cars_gList)
  .L80066D58:
    /* 57558 80066D58 0000248E */  lw         $a0, 0x0($s1)
    /* 5755C 80066D5C 04003126 */  addiu      $s1, $s1, 0x4
    /* 57560 80066D60 C9BD010C */  jal        AIScript_Startup__FP10AIScript_t
    /* 57564 80066D64 F4048424 */   addiu     $a0, $a0, 0x4F4
    /* 57568 80066D68 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 5756C 80066D6C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 57570 80066D70 01001026 */  addiu      $s0, $s0, 0x1
    /* 57574 80066D74 2A100202 */  slt        $v0, $s0, $v0
    /* 57578 80066D78 F7FF4014 */  bnez       $v0, .L80066D58
    /* 5757C 80066D7C 00000000 */   nop
  .L80066D80:
    /* 57580 80066D80 1180053C */  lui        $a1, %hi(leaderBoard)
    /* 57584 80066D84 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 57588 80066D88 1180033C */  lui        $v1, %hi(Cars_gAIRaceCarList)
    /* 5758C 80066D8C 48FA448C */  lw         $a0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 57590 80066D90 6CFA638C */  lw         $v1, %lo(Cars_gAIRaceCarList)($v1)
    /* 57594 80066D94 A4DDA224 */  addiu      $v0, $a1, %lo(leaderBoard)
    /* 57598 80066D98 040044AC */  sw         $a0, 0x4($v0)
    /* 5759C 80066D9C A4DDA4AC */  sw         $a0, %lo(leaderBoard)($a1)
    /* 575A0 80066DA0 0C0043AC */  sw         $v1, 0xC($v0)
    /* 575A4 80066DA4 13B3010C */  jal        AIPhysic_Reset__Fv
    /* 575A8 80066DA8 080043AC */   sw        $v1, 0x8($v0)
    /* 575AC 80066DAC 1180033C */  lui        $v1, %hi(AI_Info)
    /* 575B0 80066DB0 F0CC6224 */  addiu      $v0, $v1, %lo(AI_Info)
    /* 575B4 80066DB4 080040AC */  sw         $zero, 0x8($v0)
    /* 575B8 80066DB8 040040AC */  sw         $zero, 0x4($v0)
    /* 575BC 80066DBC F0CC60AC */  sw         $zero, %lo(AI_Info)($v1)
    /* 575C0 80066DC0 140040AC */  sw         $zero, 0x14($v0)
    /* 575C4 80066DC4 100040AC */  sw         $zero, 0x10($v0)
    /* 575C8 80066DC8 0C0040AC */  sw         $zero, 0xC($v0)
    /* 575CC 80066DCC 200040AC */  sw         $zero, 0x20($v0)
    /* 575D0 80066DD0 1C0040AC */  sw         $zero, 0x1C($v0)
    /* 575D4 80066DD4 180040AC */  sw         $zero, 0x18($v0)
    /* 575D8 80066DD8 2C0040AC */  sw         $zero, 0x2C($v0)
    /* 575DC 80066DDC 280040AC */  sw         $zero, 0x28($v0)
    /* 575E0 80066DE0 240040AC */  sw         $zero, 0x24($v0)
    /* 575E4 80066DE4 380040AC */  sw         $zero, 0x38($v0)
    /* 575E8 80066DE8 340040AC */  sw         $zero, 0x34($v0)
    /* 575EC 80066DEC 300040AC */  sw         $zero, 0x30($v0)
    /* 575F0 80066DF0 3C0040AC */  sw         $zero, 0x3C($v0)
    /* 575F4 80066DF4 440040AC */  sw         $zero, 0x44($v0)
    /* 575F8 80066DF8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 575FC 80066DFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 57600 80066E00 1000B08F */  lw         $s0, 0x10($sp)
    /* 57604 80066E04 0800E003 */  jr         $ra
    /* 57608 80066E08 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIInit_Reset2__Fv
