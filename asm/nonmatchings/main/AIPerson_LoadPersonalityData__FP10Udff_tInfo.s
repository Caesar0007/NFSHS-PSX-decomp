.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_LoadPersonalityData__FP10Udff_tInfo, 0x344

glabel AIPerson_LoadPersonalityData__FP10Udff_tInfo
    /* 59360 80068B60 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 59364 80068B64 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 59368 80068B68 4800BEAF */  sw         $fp, 0x48($sp)
    /* 5936C 80068B6C 4400B7AF */  sw         $s7, 0x44($sp)
    /* 59370 80068B70 4000B6AF */  sw         $s6, 0x40($sp)
    /* 59374 80068B74 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* 59378 80068B78 3800B4AF */  sw         $s4, 0x38($sp)
    /* 5937C 80068B7C 3400B3AF */  sw         $s3, 0x34($sp)
    /* 59380 80068B80 3000B2AF */  sw         $s2, 0x30($sp)
    /* 59384 80068B84 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 59388 80068B88 2800B0AF */  sw         $s0, 0x28($sp)
    /* 5938C 80068B8C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59390 80068B90 5000A4AF */   sw        $a0, 0x50($sp)
    /* 59394 80068B94 1180023C */  lui        $v0, %hi(AIPerson_PersonalityData)
    /* 59398 80068B98 68D75E24 */  addiu      $fp, $v0, %lo(AIPerson_PersonalityData)
    /* 5939C 80068B9C 1000A0AF */  sw         $zero, 0x10($sp)
  .L80068BA0:
    /* 593A0 80068BA0 1000A78F */  lw         $a3, 0x10($sp)
    /* 593A4 80068BA4 00000000 */  nop
    /* 593A8 80068BA8 0900E228 */  slti       $v0, $a3, 0x9
    /* 593AC 80068BAC B1004010 */  beqz       $v0, .L80068E74
    /* 593B0 80068BB0 00000000 */   nop
    /* 593B4 80068BB4 5000A48F */  lw         $a0, 0x50($sp)
    /* 593B8 80068BB8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 593BC 80068BBC 00000000 */   nop
    /* 593C0 80068BC0 5000A48F */  lw         $a0, 0x50($sp)
    /* 593C4 80068BC4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 593C8 80068BC8 21804000 */   addu      $s0, $v0, $zero
    /* 593CC 80068BCC 5000A48F */  lw         $a0, 0x50($sp)
    /* 593D0 80068BD0 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 593D4 80068BD4 21904000 */   addu      $s2, $v0, $zero
    /* 593D8 80068BD8 5000A48F */  lw         $a0, 0x50($sp)
    /* 593DC 80068BDC C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 593E0 80068BE0 21984000 */   addu      $s3, $v0, $zero
    /* 593E4 80068BE4 5000A48F */  lw         $a0, 0x50($sp)
    /* 593E8 80068BE8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 593EC 80068BEC 21A04000 */   addu      $s4, $v0, $zero
    /* 593F0 80068BF0 5000A48F */  lw         $a0, 0x50($sp)
    /* 593F4 80068BF4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 593F8 80068BF8 21B84000 */   addu      $s7, $v0, $zero
    /* 593FC 80068BFC 5000A48F */  lw         $a0, 0x50($sp)
    /* 59400 80068C00 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59404 80068C04 21B04000 */   addu      $s6, $v0, $zero
    /* 59408 80068C08 5000A48F */  lw         $a0, 0x50($sp)
    /* 5940C 80068C0C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59410 80068C10 1400A2AF */   sw        $v0, 0x14($sp)
    /* 59414 80068C14 5000A48F */  lw         $a0, 0x50($sp)
    /* 59418 80068C18 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5941C 80068C1C 80801000 */   sll       $s0, $s0, 2
    /* 59420 80068C20 5000A48F */  lw         $a0, 0x50($sp)
    /* 59424 80068C24 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59428 80068C28 21884000 */   addu      $s1, $v0, $zero
    /* 5942C 80068C2C 5000A48F */  lw         $a0, 0x50($sp)
    /* 59430 80068C30 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59434 80068C34 21A84000 */   addu      $s5, $v0, $zero
    /* 59438 80068C38 5000A48F */  lw         $a0, 0x50($sp)
    /* 5943C 80068C3C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59440 80068C40 1800A2AF */   sw        $v0, 0x18($sp)
    /* 59444 80068C44 5000A48F */  lw         $a0, 0x50($sp)
    /* 59448 80068C48 21284000 */  addu       $a1, $v0, $zero
    /* 5944C 80068C4C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59450 80068C50 2000A5AF */   sw        $a1, 0x20($sp)
    /* 59454 80068C54 5000A48F */  lw         $a0, 0x50($sp)
    /* 59458 80068C58 21304000 */  addu       $a2, $v0, $zero
    /* 5945C 80068C5C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59460 80068C60 2400A6AF */   sw        $a2, 0x24($sp)
    /* 59464 80068C64 1180033C */  lui        $v1, %hi(AIPerson_blockMaxDistance)
    /* 59468 80068C68 CCD56324 */  addiu      $v1, $v1, %lo(AIPerson_blockMaxDistance)
    /* 5946C 80068C6C 21800302 */  addu       $s0, $s0, $v1
    /* 59470 80068C70 0000038E */  lw         $v1, 0x0($s0)
    /* 59474 80068C74 80901200 */  sll        $s2, $s2, 2
    /* 59478 80068C78 0000C3AF */  sw         $v1, 0x0($fp)
    /* 5947C 80068C7C 1180033C */  lui        $v1, %hi(AIPerson_blockMinDistance)
    /* 59480 80068C80 DCD56324 */  addiu      $v1, $v1, %lo(AIPerson_blockMinDistance)
    /* 59484 80068C84 21904302 */  addu       $s2, $s2, $v1
    /* 59488 80068C88 0000438E */  lw         $v1, 0x0($s2)
    /* 5948C 80068C8C 80981300 */  sll        $s3, $s3, 2
    /* 59490 80068C90 0400C3AF */  sw         $v1, 0x4($fp)
    /* 59494 80068C94 1180033C */  lui        $v1, %hi(AIPerson_oncomingLookAhead)
    /* 59498 80068C98 ECD56324 */  addiu      $v1, $v1, %lo(AIPerson_oncomingLookAhead)
    /* 5949C 80068C9C 21986302 */  addu       $s3, $s3, $v1
    /* 594A0 80068CA0 0000638E */  lw         $v1, 0x0($s3)
    /* 594A4 80068CA4 00211400 */  sll        $a0, $s4, 4
    /* 594A8 80068CA8 0800C3AF */  sw         $v1, 0x8($fp)
    /* 594AC 80068CAC 1180033C */  lui        $v1, %hi(AIPerson_laneSwerve)
    /* 594B0 80068CB0 FCD56324 */  addiu      $v1, $v1, %lo(AIPerson_laneSwerve)
    /* 594B4 80068CB4 21208300 */  addu       $a0, $a0, $v1
    /* 594B8 80068CB8 0000838C */  lw         $v1, 0x0($a0)
    /* 594BC 80068CBC 00000000 */  nop
    /* 594C0 80068CC0 0C00C3AF */  sw         $v1, 0xC($fp)
    /* 594C4 80068CC4 0400838C */  lw         $v1, 0x4($a0)
    /* 594C8 80068CC8 00000000 */  nop
    /* 594CC 80068CCC 1000C3AF */  sw         $v1, 0x10($fp)
    /* 594D0 80068CD0 0800838C */  lw         $v1, 0x8($a0)
    /* 594D4 80068CD4 00000000 */  nop
    /* 594D8 80068CD8 1400C3AF */  sw         $v1, 0x14($fp)
    /* 594DC 80068CDC 0C00838C */  lw         $v1, 0xC($a0)
    /* 594E0 80068CE0 80A01400 */  sll        $s4, $s4, 2
    /* 594E4 80068CE4 1800C3AF */  sw         $v1, 0x18($fp)
    /* 594E8 80068CE8 1180033C */  lui        $v1, %hi(AIPerson_swerveChangeProb)
    /* 594EC 80068CEC 3CD66324 */  addiu      $v1, $v1, %lo(AIPerson_swerveChangeProb)
    /* 594F0 80068CF0 21A08302 */  addu       $s4, $s4, $v1
    /* 594F4 80068CF4 0000838E */  lw         $v1, 0x0($s4)
    /* 594F8 80068CF8 80B81700 */  sll        $s7, $s7, 2
    /* 594FC 80068CFC 1C00C3AF */  sw         $v1, 0x1C($fp)
    /* 59500 80068D00 1180033C */  lui        $v1, %hi(AIPerson_brakeMultiplier)
    /* 59504 80068D04 4CD66324 */  addiu      $v1, $v1, %lo(AIPerson_brakeMultiplier)
    /* 59508 80068D08 21B8E302 */  addu       $s7, $s7, $v1
    /* 5950C 80068D0C 0000E38E */  lw         $v1, 0x0($s7)
    /* 59510 80068D10 80B01600 */  sll        $s6, $s6, 2
    /* 59514 80068D14 2000C3AF */  sw         $v1, 0x20($fp)
    /* 59518 80068D18 1180033C */  lui        $v1, %hi(AIPerson_attackActivationHits)
    /* 5951C 80068D1C 5CD66324 */  addiu      $v1, $v1, %lo(AIPerson_attackActivationHits)
    /* 59520 80068D20 2118C302 */  addu       $v1, $s6, $v1
    /* 59524 80068D24 0000638C */  lw         $v1, 0x0($v1)
    /* 59528 80068D28 00000000 */  nop
    /* 5952C 80068D2C 2400C3AF */  sw         $v1, 0x24($fp)
    /* 59530 80068D30 1180033C */  lui        $v1, %hi(AIPerson_attackTimes)
    /* 59534 80068D34 6CD66324 */  addiu      $v1, $v1, %lo(AIPerson_attackTimes)
    /* 59538 80068D38 21B0C302 */  addu       $s6, $s6, $v1
    /* 5953C 80068D3C 0000C38E */  lw         $v1, 0x0($s6)
    /* 59540 80068D40 00000000 */  nop
    /* 59544 80068D44 2800C3AF */  sw         $v1, 0x28($fp)
    /* 59548 80068D48 1180033C */  lui        $v1, %hi(AIPerson_fishtailAngles)
    /* 5954C 80068D4C 1400A78F */  lw         $a3, 0x14($sp)
    /* 59550 80068D50 7CD66324 */  addiu      $v1, $v1, %lo(AIPerson_fishtailAngles)
    /* 59554 80068D54 80200700 */  sll        $a0, $a3, 2
    /* 59558 80068D58 21188300 */  addu       $v1, $a0, $v1
    /* 5955C 80068D5C 1180073C */  lui        $a3, %hi(GameSetup_gData)
    /* 59560 80068D60 0000638C */  lw         $v1, 0x0($v1)
    /* 59564 80068D64 EC31E724 */  addiu      $a3, $a3, %lo(GameSetup_gData)
    /* 59568 80068D68 2C00C3AF */  sw         $v1, 0x2C($fp)
    /* 5956C 80068D6C 4800E38C */  lw         $v1, 0x48($a3)
    /* 59570 80068D70 1180073C */  lui        $a3, %hi(AIPerson_minimumWipeOutTicks)
    /* 59574 80068D74 BCD6E724 */  addiu      $a3, $a3, %lo(AIPerson_minimumWipeOutTicks)
    /* 59578 80068D78 21182302 */  addu       $v1, $s1, $v1
    /* 5957C 80068D7C 80180300 */  sll        $v1, $v1, 2
    /* 59580 80068D80 21186700 */  addu       $v1, $v1, $a3
    /* 59584 80068D84 1180073C */  lui        $a3, %hi(GameSetup_gData)
    /* 59588 80068D88 0000638C */  lw         $v1, 0x0($v1)
    /* 5958C 80068D8C EC31E724 */  addiu      $a3, $a3, %lo(GameSetup_gData)
    /* 59590 80068D90 3000C3AF */  sw         $v1, 0x30($fp)
    /* 59594 80068D94 1180033C */  lui        $v1, %hi(AIPerson_randomWipeOutTicks)
    /* 59598 80068D98 4800E48C */  lw         $a0, 0x48($a3)
    /* 5959C 80068D9C D0D66324 */  addiu      $v1, $v1, %lo(AIPerson_randomWipeOutTicks)
    /* 595A0 80068DA0 21882402 */  addu       $s1, $s1, $a0
    /* 595A4 80068DA4 80881100 */  sll        $s1, $s1, 2
    /* 595A8 80068DA8 21882302 */  addu       $s1, $s1, $v1
    /* 595AC 80068DAC 0000238E */  lw         $v1, 0x0($s1)
    /* 595B0 80068DB0 80A81500 */  sll        $s5, $s5, 2
    /* 595B4 80068DB4 3400C3AF */  sw         $v1, 0x34($fp)
    /* 595B8 80068DB8 1180033C */  lui        $v1, %hi(AIPerson_gripLossProbPerSecond)
    /* 595BC 80068DBC 8CD66324 */  addiu      $v1, $v1, %lo(AIPerson_gripLossProbPerSecond)
    /* 595C0 80068DC0 2118A302 */  addu       $v1, $s5, $v1
    /* 595C4 80068DC4 0000638C */  lw         $v1, 0x0($v1)
    /* 595C8 80068DC8 00000000 */  nop
    /* 595CC 80068DCC 3800C3AF */  sw         $v1, 0x38($fp)
    /* 595D0 80068DD0 1180033C */  lui        $v1, %hi(AIPerson_gripLossMinFactor)
    /* 595D4 80068DD4 9CD66324 */  addiu      $v1, $v1, %lo(AIPerson_gripLossMinFactor)
    /* 595D8 80068DD8 2118A302 */  addu       $v1, $s5, $v1
    /* 595DC 80068DDC 0000638C */  lw         $v1, 0x0($v1)
    /* 595E0 80068DE0 00000000 */  nop
    /* 595E4 80068DE4 3C00C3AF */  sw         $v1, 0x3C($fp)
    /* 595E8 80068DE8 1180033C */  lui        $v1, %hi(AIPerson_gripLossRecoveryPerTick)
    /* 595EC 80068DEC ACD66324 */  addiu      $v1, $v1, %lo(AIPerson_gripLossRecoveryPerTick)
    /* 595F0 80068DF0 21A8A302 */  addu       $s5, $s5, $v1
    /* 595F4 80068DF4 0000A38E */  lw         $v1, 0x0($s5)
    /* 595F8 80068DF8 00000000 */  nop
    /* 595FC 80068DFC 4000C3AF */  sw         $v1, 0x40($fp)
    /* 59600 80068E00 1180033C */  lui        $v1, %hi(AIPerson_bestLineAbilities)
    /* 59604 80068E04 1800A78F */  lw         $a3, 0x18($sp)
    /* 59608 80068E08 04D76324 */  addiu      $v1, $v1, %lo(AIPerson_bestLineAbilities)
    /* 5960C 80068E0C 80200700 */  sll        $a0, $a3, 2
    /* 59610 80068E10 21188300 */  addu       $v1, $a0, $v1
    /* 59614 80068E14 0000638C */  lw         $v1, 0x0($v1)
    /* 59618 80068E18 00000000 */  nop
    /* 5961C 80068E1C 4400C3AF */  sw         $v1, 0x44($fp)
    /* 59620 80068E20 1180033C */  lui        $v1, %hi(AIPerson_rearEndProbMask)
    /* 59624 80068E24 2000A58F */  lw         $a1, 0x20($sp)
    /* 59628 80068E28 E4D66324 */  addiu      $v1, $v1, %lo(AIPerson_rearEndProbMask)
    /* 5962C 80068E2C 80280500 */  sll        $a1, $a1, 2
    /* 59630 80068E30 2128A300 */  addu       $a1, $a1, $v1
    /* 59634 80068E34 0000A38C */  lw         $v1, 0x0($a1)
    /* 59638 80068E38 00000000 */  nop
    /* 5963C 80068E3C 4800C3AF */  sw         $v1, 0x48($fp)
    /* 59640 80068E40 1180033C */  lui        $v1, %hi(AIPerson_smackProbMask)
    /* 59644 80068E44 F4D66324 */  addiu      $v1, $v1, %lo(AIPerson_smackProbMask)
    /* 59648 80068E48 2400A68F */  lw         $a2, 0x24($sp)
    /* 5964C 80068E4C 1000A78F */  lw         $a3, 0x10($sp)
    /* 59650 80068E50 80300600 */  sll        $a2, $a2, 2
    /* 59654 80068E54 2130C300 */  addu       $a2, $a2, $v1
    /* 59658 80068E58 0000C38C */  lw         $v1, 0x0($a2)
    /* 5965C 80068E5C 0100E724 */  addiu      $a3, $a3, 0x1
    /* 59660 80068E60 1000A7AF */  sw         $a3, 0x10($sp)
    /* 59664 80068E64 5000C2AF */  sw         $v0, 0x50($fp)
    /* 59668 80068E68 4C00C3AF */  sw         $v1, 0x4C($fp)
    /* 5966C 80068E6C E8A20108 */  j          .L80068BA0
    /* 59670 80068E70 5400DE27 */   addiu     $fp, $fp, 0x54
  .L80068E74:
    /* 59674 80068E74 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 59678 80068E78 4800BE8F */  lw         $fp, 0x48($sp)
    /* 5967C 80068E7C 4400B78F */  lw         $s7, 0x44($sp)
    /* 59680 80068E80 4000B68F */  lw         $s6, 0x40($sp)
    /* 59684 80068E84 3C00B58F */  lw         $s5, 0x3C($sp)
    /* 59688 80068E88 3800B48F */  lw         $s4, 0x38($sp)
    /* 5968C 80068E8C 3400B38F */  lw         $s3, 0x34($sp)
    /* 59690 80068E90 3000B28F */  lw         $s2, 0x30($sp)
    /* 59694 80068E94 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 59698 80068E98 2800B08F */  lw         $s0, 0x28($sp)
    /* 5969C 80068E9C 0800E003 */  jr         $ra
    /* 596A0 80068EA0 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel AIPerson_LoadPersonalityData__FP10Udff_tInfo
