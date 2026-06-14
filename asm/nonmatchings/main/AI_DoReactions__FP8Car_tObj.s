.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_DoReactions__FP8Car_tObj, 0x240

glabel AI_DoReactions__FP8Car_tObj
    /* 48394 80057B94 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 48398 80057B98 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4839C 80057B9C 21888000 */  addu       $s1, $a0, $zero
    /* 483A0 80057BA0 F4042426 */  addiu      $a0, $s1, 0x4F4
    /* 483A4 80057BA4 08000524 */  addiu      $a1, $zero, 0x8
    /* 483A8 80057BA8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 483AC 80057BAC 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 483B0 80057BB0 1000B0AF */   sw        $s0, 0x10($sp)
    /* 483B4 80057BB4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 483B8 80057BB8 07004310 */  beq        $v0, $v1, .L80057BD8
    /* 483BC 80057BBC 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 483C0 80057BC0 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 483C4 80057BC4 01000224 */  addiu      $v0, $zero, 0x1
    /* 483C8 80057BC8 03006210 */  beq        $v1, $v0, .L80057BD8
    /* 483CC 80057BCC 21202002 */   addu      $a0, $s1, $zero
    /* 483D0 80057BD0 FB5E0108 */  j          .L80057BEC
    /* 483D4 80057BD4 21284000 */   addu      $a1, $v0, $zero
  .L80057BD8:
    /* 483D8 80057BD8 46042292 */  lbu        $v0, 0x446($s1)
    /* 483DC 80057BDC 00000000 */  nop
    /* 483E0 80057BE0 04004010 */  beqz       $v0, .L80057BF4
    /* 483E4 80057BE4 21202002 */   addu      $a0, $s1, $zero
    /* 483E8 80057BE8 21280000 */  addu       $a1, $zero, $zero
  .L80057BEC:
    /* 483EC 80057BEC CED1010C */  jal        AudioClc_SetHorn__FP8Car_tObji
    /* 483F0 80057BF0 00000000 */   nop
  .L80057BF4:
    /* 483F4 80057BF4 F4042426 */  addiu      $a0, $s1, 0x4F4
    /* 483F8 80057BF8 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 483FC 80057BFC 00100524 */   addiu     $a1, $zero, 0x1000
    /* 48400 80057C00 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 48404 80057C04 2C004310 */  beq        $v0, $v1, .L80057CB8
    /* 48408 80057C08 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 4840C 80057C0C EC31428C */  lw         $v0, %lo(GameSetup_gData)($v0)
    /* 48410 80057C10 01000424 */  addiu      $a0, $zero, 0x1
    /* 48414 80057C14 28004410 */  beq        $v0, $a0, .L80057CB8
    /* 48418 80057C18 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4841C 80057C1C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 48420 80057C20 00000000 */  nop
    /* 48424 80057C24 18004230 */  andi       $v0, $v0, 0x18
    /* 48428 80057C28 C3180200 */  sra        $v1, $v0, 3
    /* 4842C 80057C2C 12006410 */  beq        $v1, $a0, .L80057C78
    /* 48430 80057C30 02006228 */   slti      $v0, $v1, 0x2
    /* 48434 80057C34 05004010 */  beqz       $v0, .L80057C4C
    /* 48438 80057C38 02000224 */   addiu     $v0, $zero, 0x2
    /* 4843C 80057C3C 09006010 */  beqz       $v1, .L80057C64
    /* 48440 80057C40 F4043026 */   addiu     $s0, $s1, 0x4F4
    /* 48444 80057C44 305F0108 */  j          .L80057CC0
    /* 48448 80057C48 21200002 */   addu      $a0, $s0, $zero
  .L80057C4C:
    /* 4844C 80057C4C 0F006210 */  beq        $v1, $v0, .L80057C8C
    /* 48450 80057C50 03000224 */   addiu     $v0, $zero, 0x3
    /* 48454 80057C54 12006210 */  beq        $v1, $v0, .L80057CA0
    /* 48458 80057C58 F4043026 */   addiu     $s0, $s1, 0x4F4
    /* 4845C 80057C5C 305F0108 */  j          .L80057CC0
    /* 48460 80057C60 21200002 */   addu      $a0, $s0, $zero
  .L80057C64:
    /* 48464 80057C64 21202002 */  addu       $a0, $s1, $zero
    /* 48468 80057C68 04000524 */  addiu      $a1, $zero, 0x4
    /* 4846C 80057C6C 10000624 */  addiu      $a2, $zero, 0x10
    /* 48470 80057C70 2C5F0108 */  j          .L80057CB0
    /* 48474 80057C74 08000724 */   addiu     $a3, $zero, 0x8
  .L80057C78:
    /* 48478 80057C78 21202002 */  addu       $a0, $s1, $zero
    /* 4847C 80057C7C 02000524 */  addiu      $a1, $zero, 0x2
    /* 48480 80057C80 20000624 */  addiu      $a2, $zero, 0x20
    /* 48484 80057C84 2C5F0108 */  j          .L80057CB0
    /* 48488 80057C88 0C000724 */   addiu     $a3, $zero, 0xC
  .L80057C8C:
    /* 4848C 80057C8C 21202002 */  addu       $a0, $s1, $zero
    /* 48490 80057C90 07000524 */  addiu      $a1, $zero, 0x7
    /* 48494 80057C94 28000624 */  addiu      $a2, $zero, 0x28
    /* 48498 80057C98 2C5F0108 */  j          .L80057CB0
    /* 4849C 80057C9C 10000724 */   addiu     $a3, $zero, 0x10
  .L80057CA0:
    /* 484A0 80057CA0 21202002 */  addu       $a0, $s1, $zero
    /* 484A4 80057CA4 01000524 */  addiu      $a1, $zero, 0x1
    /* 484A8 80057CA8 20000624 */  addiu      $a2, $zero, 0x20
    /* 484AC 80057CAC 21380000 */  addu       $a3, $zero, $zero
  .L80057CB0:
    /* 484B0 80057CB0 EAD1010C */  jal        AudioClc_HonkHorn__FP8Car_tObjiii
    /* 484B4 80057CB4 00000000 */   nop
  .L80057CB8:
    /* 484B8 80057CB8 F4043026 */  addiu      $s0, $s1, 0x4F4
    /* 484BC 80057CBC 21200002 */  addu       $a0, $s0, $zero
  .L80057CC0:
    /* 484C0 80057CC0 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 484C4 80057CC4 00020524 */   addiu     $a1, $zero, 0x200
    /* 484C8 80057CC8 21204000 */  addu       $a0, $v0, $zero
    /* 484CC 80057CCC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 484D0 80057CD0 21008210 */  beq        $a0, $v0, .L80057D58
    /* 484D4 80057CD4 1180033C */   lui       $v1, %hi(Cars_gList)
    /* 484D8 80057CD8 DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* 484DC 80057CDC 80100400 */  sll        $v0, $a0, 2
    /* 484E0 80057CE0 21104300 */  addu       $v0, $v0, $v1
    /* 484E4 80057CE4 0000458C */  lw         $a1, 0x0($v0)
    /* 484E8 80057CE8 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 484EC 80057CEC 21202002 */   addu      $a0, $s1, $zero
    /* 484F0 80057CF0 02004104 */  bgez       $v0, .L80057CFC
    /* 484F4 80057CF4 00000000 */   nop
    /* 484F8 80057CF8 23100200 */  negu       $v0, $v0
  .L80057CFC:
    /* 484FC 80057CFC 0C00033C */  lui        $v1, (0xC0000 >> 16)
    /* 48500 80057D00 2A186200 */  slt        $v1, $v1, $v0
    /* 48504 80057D04 15006010 */  beqz       $v1, .L80057D5C
    /* 48508 80057D08 F4042426 */   addiu     $a0, $s1, 0x4F4
    /* 4850C 80057D0C 62BE010C */  jal        AIScript_GetReactionTicksLeft__FP10AIScript_t
    /* 48510 80057D10 21200002 */   addu      $a0, $s0, $zero
    /* 48514 80057D14 02004104 */  bgez       $v0, .L80057D20
    /* 48518 80057D18 00000000 */   nop
    /* 4851C 80057D1C 1F004224 */  addiu      $v0, $v0, 0x1F
  .L80057D20:
    /* 48520 80057D20 43110200 */  sra        $v0, $v0, 5
    /* 48524 80057D24 01004230 */  andi       $v0, $v0, 0x1
    /* 48528 80057D28 06004010 */  beqz       $v0, .L80057D44
    /* 4852C 80057D2C 1180023C */   lui       $v0, %hi(CarLogic_gObs)
    /* 48530 80057D30 E4CC438C */  lw         $v1, %lo(CarLogic_gObs)($v0)
    /* 48534 80057D34 1E00043C */  lui        $a0, (0x1E0000 >> 16)
    /* 48538 80057D38 21186400 */  addu       $v1, $v1, $a0
    /* 4853C 80057D3C 565F0108 */  j          .L80057D58
    /* 48540 80057D40 E4CC43AC */   sw        $v1, %lo(CarLogic_gObs)($v0)
  .L80057D44:
    /* 48544 80057D44 E4CC4224 */  addiu      $v0, $v0, %lo(CarLogic_gObs)
    /* 48548 80057D48 0800438C */  lw         $v1, 0x8($v0)
    /* 4854C 80057D4C 1E00043C */  lui        $a0, (0x1E0000 >> 16)
    /* 48550 80057D50 21186400 */  addu       $v1, $v1, $a0
    /* 48554 80057D54 080043AC */  sw         $v1, 0x8($v0)
  .L80057D58:
    /* 48558 80057D58 F4042426 */  addiu      $a0, $s1, 0x4F4
  .L80057D5C:
    /* 4855C 80057D5C 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 48560 80057D60 20000524 */   addiu     $a1, $zero, 0x20
    /* 48564 80057D64 21204000 */  addu       $a0, $v0, $zero
    /* 48568 80057D68 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 4856C 80057D6C 14008210 */  beq        $a0, $v0, .L80057DC0
    /* 48570 80057D70 1180033C */   lui       $v1, %hi(Cars_gList)
    /* 48574 80057D74 DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* 48578 80057D78 80100400 */  sll        $v0, $a0, 2
    /* 4857C 80057D7C 21104300 */  addu       $v0, $v0, $v1
    /* 48580 80057D80 0000508C */  lw         $s0, 0x0($v0)
    /* 48584 80057D84 21202002 */  addu       $a0, $s1, $zero
    /* 48588 80057D88 89CC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjT0
    /* 4858C 80057D8C 21280002 */   addu      $a1, $s0, $zero
    /* 48590 80057D90 5405238E */  lw         $v1, 0x554($s1)
    /* 48594 80057D94 00000000 */  nop
    /* 48598 80057D98 18004300 */  mult       $v0, $v1
    /* 4859C 80057D9C 0300023C */  lui        $v0, (0x3FFFF >> 16)
    /* 485A0 80057DA0 FFFF4234 */  ori        $v0, $v0, (0x3FFFF & 0xFFFF)
    /* 485A4 80057DA4 12400000 */  mflo       $t0
    /* 485A8 80057DA8 2A104800 */  slt        $v0, $v0, $t0
    /* 485AC 80057DAC 04004014 */  bnez       $v0, .L80057DC0
    /* 485B0 80057DB0 00000000 */   nop
    /* 485B4 80057DB4 C406058E */  lw         $a1, 0x6C4($s0)
    /* 485B8 80057DB8 C75E010C */  jal        AI_TargetLane__FP8Car_tObji
    /* 485BC 80057DBC 21202002 */   addu      $a0, $s1, $zero
  .L80057DC0:
    /* 485C0 80057DC0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 485C4 80057DC4 1400B18F */  lw         $s1, 0x14($sp)
    /* 485C8 80057DC8 1000B08F */  lw         $s0, 0x10($sp)
    /* 485CC 80057DCC 0800E003 */  jr         $ra
    /* 485D0 80057DD0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AI_DoReactions__FP8Car_tObj
