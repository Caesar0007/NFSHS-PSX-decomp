.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_Main__FP8Car_tObj, 0x290

glabel AIPhysic_Main__FP8Car_tObj
    /* 5A384 80069B84 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5A388 80069B88 2000B0AF */  sw         $s0, 0x20($sp)
    /* 5A38C 80069B8C 21808000 */  addu       $s0, $a0, $zero
    /* 5A390 80069B90 1480023C */  lui        $v0, %hi(AIPhysic_time)
    /* 5A394 80069B94 98C54224 */  addiu      $v0, $v0, %lo(AIPhysic_time)
    /* 5A398 80069B98 1000A2AF */  sw         $v0, 0x10($sp)
    /* 5A39C 80069B9C 1480023C */  lui        $v0, %hi(AIPhysic_elapsedTime)
    /* 5A3A0 80069BA0 9CC54224 */  addiu      $v0, $v0, %lo(AIPhysic_elapsedTime)
    /* 5A3A4 80069BA4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 5A3A8 80069BA8 1480023C */  lui        $v0, %hi(AIPhysic_iTime)
    /* 5A3AC 80069BAC 94C54224 */  addiu      $v0, $v0, %lo(AIPhysic_iTime)
    /* 5A3B0 80069BB0 2800BFAF */  sw         $ra, 0x28($sp)
    /* 5A3B4 80069BB4 2400B1AF */  sw         $s1, 0x24($sp)
    /* 5A3B8 80069BB8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 5A3BC 80069BBC 5C07028E */  lw         $v0, 0x75C($s0)
    /* 5A3C0 80069BC0 01000424 */  addiu      $a0, $zero, 0x1
    /* 5A3C4 80069BC4 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 5A3C8 80069BC8 8C00068E */  lw         $a2, 0x8C($s0)
    /* 5A3CC 80069BCC 0000078E */  lw         $a3, 0x0($s0)
    /* 5A3D0 80069BD0 6FD8020C */  jal        Sched_ExecuteCheck__FiiiiPiN24i
    /* 5A3D4 80069BD4 21288000 */   addu      $a1, $a0, $zero
    /* 5A3D8 80069BD8 89004010 */  beqz       $v0, .L80069E00
    /* 5A3DC 80069BDC 00000000 */   nop
    /* 5A3E0 80069BE0 6002028E */  lw         $v0, 0x260($s0)
    /* 5A3E4 80069BE4 00000000 */  nop
    /* 5A3E8 80069BE8 02004230 */  andi       $v0, $v0, 0x2
    /* 5A3EC 80069BEC 03004010 */  beqz       $v0, .L80069BFC
    /* 5A3F0 80069BF0 00000000 */   nop
    /* 5A3F4 80069BF4 35CE010C */  jal        AIWorld_CalcSpeed__FP8Car_tObj
    /* 5A3F8 80069BF8 21200002 */   addu      $a0, $s0, $zero
  .L80069BFC:
    /* 5A3FC 80069BFC 8DA6010C */  jal        AIPhysic_CheckDesiredDirection__FP8Car_tObj
    /* 5A400 80069C00 21200002 */   addu      $a0, $s0, $zero
    /* 5A404 80069C04 AAB2010C */  jal        AIPhysic_CheckForGripReduction__FP8Car_tObj
    /* 5A408 80069C08 21200002 */   addu      $a0, $s0, $zero
    /* 5A40C 80069C0C 9FA6010C */  jal        AIPhysic_HandleSignalling__FP8Car_tObj
    /* 5A410 80069C10 21200002 */   addu      $a0, $s0, $zero
    /* 5A414 80069C14 47CE010C */  jal        AIWorld_CalcLateralVelocity__FP8Car_tObj
    /* 5A418 80069C18 21200002 */   addu      $a0, $s0, $zero
    /* 5A41C 80069C1C 21200002 */  addu       $a0, $s0, $zero
    /* 5A420 80069C20 BBA7010C */  jal        AIPhysics_UseCoolPhysics__FP8Car_tObj
    /* 5A424 80069C24 040702AE */   sw        $v0, 0x704($s0)
    /* 5A428 80069C28 21200002 */  addu       $a0, $s0, $zero
    /* 5A42C 80069C2C 21884000 */  addu       $s1, $v0, $zero
    /* 5A430 80069C30 FF002532 */  andi       $a1, $s1, 0xFF
    /* 5A434 80069C34 DAB1010C */  jal        AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
    /* 5A438 80069C38 2B280500 */   sltu      $a1, $zero, $a1
    /* 5A43C 80069C3C 7005028E */  lw         $v0, 0x570($s0)
    /* 5A440 80069C40 00000000 */  nop
    /* 5A444 80069C44 04004230 */  andi       $v0, $v0, 0x4
    /* 5A448 80069C48 6D004014 */  bnez       $v0, .L80069E00
    /* 5A44C 80069C4C 00000000 */   nop
    /* 5A450 80069C50 91000292 */  lbu        $v0, 0x91($s0)
    /* 5A454 80069C54 00000000 */  nop
    /* 5A458 80069C58 69004010 */  beqz       $v0, .L80069E00
    /* 5A45C 80069C5C 1280023C */   lui       $v0, %hi(simGlobal)
    /* 5A460 80069C60 ACE0438C */  lw         $v1, %lo(simGlobal)($v0)
    /* 5A464 80069C64 01000224 */  addiu      $v0, $zero, 0x1
    /* 5A468 80069C68 05006210 */  beq        $v1, $v0, .L80069C80
    /* 5A46C 80069C6C 00000000 */   nop
    /* 5A470 80069C70 BFA4010C */  jal        AIPhysic_RevEngine__FP8Car_tObj
    /* 5A474 80069C74 21200002 */   addu      $a0, $s0, $zero
    /* 5A478 80069C78 80A70108 */  j          .L80069E00
    /* 5A47C 80069C7C 00000000 */   nop
  .L80069C80:
    /* 5A480 80069C80 F3A4010C */  jal        AIPhysic_HandleShifting__FP8Car_tObj
    /* 5A484 80069C84 21200002 */   addu      $a0, $s0, $zero
    /* 5A488 80069C88 7C010296 */  lhu        $v0, 0x17C($s0)
    /* 5A48C 80069C8C 00000000 */  nop
    /* 5A490 80069C90 08004010 */  beqz       $v0, .L80069CB4
    /* 5A494 80069C94 0300023C */   lui       $v0, (0x3FFFF >> 16)
    /* 5A498 80069C98 6002028E */  lw         $v0, 0x260($s0)
    /* 5A49C 80069C9C 00000000 */  nop
    /* 5A4A0 80069CA0 00044230 */  andi       $v0, $v0, 0x400
    /* 5A4A4 80069CA4 56004010 */  beqz       $v0, .L80069E00
    /* 5A4A8 80069CA8 E1FA0534 */   ori       $a1, $zero, 0xFAE1
    /* 5A4AC 80069CAC 70A70108 */  j          .L80069DC0
    /* 5A4B0 80069CB0 21200002 */   addu      $a0, $s0, $zero
  .L80069CB4:
    /* 5A4B4 80069CB4 6805038E */  lw         $v1, 0x568($s0)
    /* 5A4B8 80069CB8 FFFF4234 */  ori        $v0, $v0, (0x3FFFF & 0xFFFF)
    /* 5A4BC 80069CBC 2A104300 */  slt        $v0, $v0, $v1
    /* 5A4C0 80069CC0 04004014 */  bnez       $v0, .L80069CD4
    /* 5A4C4 80069CC4 00000000 */   nop
    /* 5A4C8 80069CC8 200400AE */  sw         $zero, 0x420($s0)
    /* 5A4CC 80069CCC 880400AE */  sw         $zero, 0x488($s0)
    /* 5A4D0 80069CD0 840400AE */  sw         $zero, 0x484($s0)
  .L80069CD4:
    /* 5A4D4 80069CD4 7C010296 */  lhu        $v0, 0x17C($s0)
    /* 5A4D8 80069CD8 00000000 */  nop
    /* 5A4DC 80069CDC 06004014 */  bnez       $v0, .L80069CF8
    /* 5A4E0 80069CE0 00000000 */   nop
    /* 5A4E4 80069CE4 0001028E */  lw         $v0, 0x100($s0)
    /* 5A4E8 80069CE8 00000000 */  nop
    /* 5A4EC 80069CEC CC4C4228 */  slti       $v0, $v0, 0x4CCC
    /* 5A4F0 80069CF0 32004014 */  bnez       $v0, .L80069DBC
    /* 5A4F4 80069CF4 21200002 */   addu      $a0, $s0, $zero
  .L80069CF8:
    /* 5A4F8 80069CF8 7402028E */  lw         $v0, 0x274($s0)
    /* 5A4FC 80069CFC 00000000 */  nop
    /* 5A500 80069D00 03004010 */  beqz       $v0, .L80069D10
    /* 5A504 80069D04 21200002 */   addu      $a0, $s0, $zero
    /* 5A508 80069D08 70A70108 */  j          .L80069DC0
    /* 5A50C 80069D0C 70FD0534 */   ori       $a1, $zero, 0xFD70
  .L80069D10:
    /* 5A510 80069D10 7802028E */  lw         $v0, 0x278($s0)
    /* 5A514 80069D14 00000000 */  nop
    /* 5A518 80069D18 12004010 */  beqz       $v0, .L80069D64
    /* 5A51C 80069D1C 0200023C */   lui       $v0, (0x238E2 >> 16)
    /* 5A520 80069D20 6805038E */  lw         $v1, 0x568($s0)
    /* 5A524 80069D24 E2384234 */  ori        $v0, $v0, (0x238E2 & 0xFFFF)
    /* 5A528 80069D28 2A104300 */  slt        $v0, $v0, $v1
    /* 5A52C 80069D2C 07004014 */  bnez       $v0, .L80069D4C
    /* 5A530 80069D30 0800023C */   lui       $v0, (0x8E38D >> 16)
    /* 5A534 80069D34 21200002 */  addu       $a0, $s0, $zero
    /* 5A538 80069D38 66E60534 */  ori        $a1, $zero, 0xE666
    /* 5A53C 80069D3C 8EA4010C */  jal        AIPhysic_StopCar__FP8Car_tObjii
    /* 5A540 80069D40 2130A000 */   addu      $a2, $a1, $zero
    /* 5A544 80069D44 80A70108 */  j          .L80069E00
    /* 5A548 80069D48 00000000 */   nop
  .L80069D4C:
    /* 5A54C 80069D4C 8DE34234 */  ori        $v0, $v0, (0x8E38D & 0xFFFF)
    /* 5A550 80069D50 2A104300 */  slt        $v0, $v0, $v1
    /* 5A554 80069D54 03004014 */  bnez       $v0, .L80069D64
    /* 5A558 80069D58 21200002 */   addu      $a0, $s0, $zero
    /* 5A55C 80069D5C 70A70108 */  j          .L80069DC0
    /* 5A560 80069D60 C2F50534 */   ori       $a1, $zero, 0xF5C2
  .L80069D64:
    /* 5A564 80069D64 6002028E */  lw         $v0, 0x260($s0)
    /* 5A568 80069D68 00000000 */  nop
    /* 5A56C 80069D6C 01004230 */  andi       $v0, $v0, 0x1
    /* 5A570 80069D70 0D004010 */  beqz       $v0, .L80069DA8
    /* 5A574 80069D74 02000224 */   addiu     $v0, $zero, 0x2
    /* 5A578 80069D78 9003038E */  lw         $v1, 0x390($s0)
    /* 5A57C 80069D7C 00000000 */  nop
    /* 5A580 80069D80 09006214 */  bne        $v1, $v0, .L80069DA8
    /* 5A584 80069D84 0100033C */   lui       $v1, (0x1FFFF >> 16)
    /* 5A588 80069D88 6405028E */  lw         $v0, 0x564($s0)
    /* 5A58C 80069D8C FFFF6334 */  ori        $v1, $v1, (0x1FFFF & 0xFFFF)
    /* 5A590 80069D90 02004104 */  bgez       $v0, .L80069D9C
    /* 5A594 80069D94 00000000 */   nop
    /* 5A598 80069D98 23100200 */  negu       $v0, $v0
  .L80069D9C:
    /* 5A59C 80069D9C 2A186200 */  slt        $v1, $v1, $v0
    /* 5A5A0 80069DA0 06006010 */  beqz       $v1, .L80069DBC
    /* 5A5A4 80069DA4 21200002 */   addu      $a0, $s0, $zero
  .L80069DA8:
    /* 5A5A8 80069DA8 5C05028E */  lw         $v0, 0x55C($s0)
    /* 5A5AC 80069DAC 00000000 */  nop
    /* 5A5B0 80069DB0 07004014 */  bnez       $v0, .L80069DD0
    /* 5A5B4 80069DB4 FF002232 */   andi      $v0, $s1, 0xFF
    /* 5A5B8 80069DB8 21200002 */  addu       $a0, $s0, $zero
  .L80069DBC:
    /* 5A5BC 80069DBC A3F00534 */  ori        $a1, $zero, 0xF0A3
  .L80069DC0:
    /* 5A5C0 80069DC0 8EA4010C */  jal        AIPhysic_StopCar__FP8Car_tObjii
    /* 5A5C4 80069DC4 E1FA0634 */   ori       $a2, $zero, 0xFAE1
    /* 5A5C8 80069DC8 80A70108 */  j          .L80069E00
    /* 5A5CC 80069DCC 00000000 */   nop
  .L80069DD0:
    /* 5A5D0 80069DD0 05004010 */  beqz       $v0, .L80069DE8
    /* 5A5D4 80069DD4 00000000 */   nop
    /* 5A5D8 80069DD8 C6A9010C */  jal        AIPhysic_CoolPhysics__FP8Car_tObj
    /* 5A5DC 80069DDC 21200002 */   addu      $a0, $s0, $zero
    /* 5A5E0 80069DE0 7CA70108 */  j          .L80069DF0
    /* 5A5E4 80069DE4 00000000 */   nop
  .L80069DE8:
    /* 5A5E8 80069DE8 CCA7010C */  jal        AIPhysic_SimplePhysics__FP8Car_tObj
    /* 5A5EC 80069DEC 21200002 */   addu      $a0, $s0, $zero
  .L80069DF0:
    /* 5A5F0 80069DF0 85A7010C */  jal        AIPhysic_CheckForBadPosition__FP8Car_tObj
    /* 5A5F4 80069DF4 21200002 */   addu      $a0, $s0, $zero
    /* 5A5F8 80069DF8 BCA6010C */  jal        AIPhysic_HandleWipeoutTimer__FP8Car_tObj
    /* 5A5FC 80069DFC 21200002 */   addu      $a0, $s0, $zero
  .L80069E00:
    /* 5A600 80069E00 2800BF8F */  lw         $ra, 0x28($sp)
    /* 5A604 80069E04 2400B18F */  lw         $s1, 0x24($sp)
    /* 5A608 80069E08 2000B08F */  lw         $s0, 0x20($sp)
    /* 5A60C 80069E0C 0800E003 */  jr         $ra
    /* 5A610 80069E10 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIPhysic_Main__FP8Car_tObj
