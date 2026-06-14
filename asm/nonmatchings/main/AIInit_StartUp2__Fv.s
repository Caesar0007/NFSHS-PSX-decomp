.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_StartUp2__Fv, 0xD8

glabel AIInit_StartUp2__Fv
    /* 57424 80066C24 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 57428 80066C28 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 5742C 80066C2C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 57430 80066C30 1400B1AF */  sw         $s1, 0x14($sp)
    /* 57434 80066C34 6DB5010C */  jal        AISpeeds_StartUp__Fv
    /* 57438 80066C38 1000B0AF */   sw        $s0, 0x10($sp)
    /* 5743C 80066C3C FE9B010C */  jal        AIInit_LoadConfigs__Fv
    /* 57440 80066C40 21800000 */   addu      $s0, $zero, $zero
    /* 57444 80066C44 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 57448 80066C48 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 5744C 80066C4C 00000000 */  nop
    /* 57450 80066C50 0C004018 */  blez       $v0, .L80066C84
    /* 57454 80066C54 1180023C */   lui       $v0, %hi(Cars_gList)
    /* 57458 80066C58 DCF95124 */  addiu      $s1, $v0, %lo(Cars_gList)
  .L80066C5C:
    /* 5745C 80066C5C 0000248E */  lw         $a0, 0x0($s1)
    /* 57460 80066C60 04003126 */  addiu      $s1, $s1, 0x4
    /* 57464 80066C64 C9BD010C */  jal        AIScript_Startup__FP10AIScript_t
    /* 57468 80066C68 F4048424 */   addiu     $a0, $a0, 0x4F4
    /* 5746C 80066C6C 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 57470 80066C70 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 57474 80066C74 01001026 */  addiu      $s0, $s0, 0x1
    /* 57478 80066C78 2A100202 */  slt        $v0, $s0, $v0
    /* 5747C 80066C7C F7FF4014 */  bnez       $v0, .L80066C5C
    /* 57480 80066C80 00000000 */   nop
  .L80066C84:
    /* 57484 80066C84 23A4010C */  jal        AIPerson_Startup__Fv
    /* 57488 80066C88 21900000 */   addu      $s2, $zero, $zero
    /* 5748C 80066C8C EAB3010C */  jal        StartUp2__14AIDataRecord_t
    /* 57490 80066C90 00000000 */   nop
    /* 57494 80066C94 0FB3010C */  jal        AIPhysic_StartUp__Fv
    /* 57498 80066C98 00000000 */   nop
    /* 5749C 80066C9C DECB010C */  jal        AITune_StartUp2__Fv
    /* 574A0 80066CA0 00000000 */   nop
    /* 574A4 80066CA4 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 574A8 80066CA8 DCF95124 */  addiu      $s1, $v0, %lo(Cars_gList)
  .L80066CAC:
    /* 574AC 80066CAC 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 574B0 80066CB0 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 574B4 80066CB4 00000000 */  nop
    /* 574B8 80066CB8 2A104202 */  slt        $v0, $s2, $v0
    /* 574BC 80066CBC 09004010 */  beqz       $v0, .L80066CE4
    /* 574C0 80066CC0 01005226 */   addiu     $s2, $s2, 0x1
    /* 574C4 80066CC4 0000308E */  lw         $s0, 0x0($s1)
    /* 574C8 80066CC8 04003126 */  addiu      $s1, $s1, 0x4
    /* 574CC 80066CCC 18B3010C */  jal        AIPhysic_InitCar__FP8Car_tObj
    /* 574D0 80066CD0 21200002 */   addu      $a0, $s0, $zero
    /* 574D4 80066CD4 5A9D010C */  jal        AIInit_InitAICar2__FP8Car_tObj
    /* 574D8 80066CD8 21200002 */   addu      $a0, $s0, $zero
    /* 574DC 80066CDC 2B9B0108 */  j          .L80066CAC
    /* 574E0 80066CE0 00000000 */   nop
  .L80066CE4:
    /* 574E4 80066CE4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 574E8 80066CE8 1800B28F */  lw         $s2, 0x18($sp)
    /* 574EC 80066CEC 1400B18F */  lw         $s1, 0x14($sp)
    /* 574F0 80066CF0 1000B08F */  lw         $s0, 0x10($sp)
    /* 574F4 80066CF4 0800E003 */  jr         $ra
    /* 574F8 80066CF8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIInit_StartUp2__Fv
