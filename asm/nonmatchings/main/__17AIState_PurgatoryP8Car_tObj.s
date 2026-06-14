.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __17AIState_PurgatoryP8Car_tObj, 0x1B0

glabel __17AIState_PurgatoryP8Car_tObj
    /* 61C8C 8007148C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 61C90 80071490 2400B1AF */  sw         $s1, 0x24($sp)
    /* 61C94 80071494 21888000 */  addu       $s1, $a0, $zero
    /* 61C98 80071498 2000B0AF */  sw         $s0, 0x20($sp)
    /* 61C9C 8007149C 2800BFAF */  sw         $ra, 0x28($sp)
    /* 61CA0 800714A0 9DBE010C */  jal        __12AIState_BaseP8Car_tObj
    /* 61CA4 800714A4 2180A000 */   addu      $s0, $a1, $zero
    /* 61CA8 800714A8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 61CAC 800714AC 21280000 */  addu       $a1, $zero, $zero
    /* 61CB0 800714B0 0C000624 */  addiu      $a2, $zero, 0xC
    /* 61CB4 800714B4 0580023C */  lui        $v0, %hi(D_800555A0)
    /* 61CB8 800714B8 A0554224 */  addiu      $v0, $v0, %lo(D_800555A0)
    /* 61CBC 800714BC C690030C */  jal        memset
    /* 61CC0 800714C0 040022AE */   sw        $v0, 0x4($s1)
    /* 61CC4 800714C4 21280000 */  addu       $a1, $zero, $zero
    /* 61CC8 800714C8 5402038E */  lw         $v1, 0x254($s0)
    /* 61CCC 800714CC 1000A627 */  addiu      $a2, $sp, 0x10
    /* 61CD0 800714D0 80100300 */  sll        $v0, $v1, 2
    /* 61CD4 800714D4 21104300 */  addu       $v0, $v0, $v1
    /* 61CD8 800714D8 40140200 */  sll        $v0, $v0, 17
    /* 61CDC 800714DC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 61CE0 800714E0 0000248E */  lw         $a0, 0x0($s1)
    /* 61CE4 800714E4 E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 61CE8 800714E8 01000724 */   addiu     $a3, $zero, 0x1
    /* 61CEC 800714EC 0000228E */  lw         $v0, 0x0($s1)
    /* 61CF0 800714F0 00000000 */  nop
    /* 61CF4 800714F4 910040A0 */  sb         $zero, 0x91($v0)
    /* 61CF8 800714F8 0580023C */  lui        $v0, %hi(_vt_17AIState_Purgatory)
    /* 61CFC 800714FC 1480063C */  lui        $a2, %hi(fastRandom)
    /* 61D00 80071500 FCD0C68C */  lw         $a2, %lo(fastRandom)($a2)
    /* 61D04 80071504 1480033C */  lui        $v1, %hi(randSeed)
    /* 61D08 80071508 04D1638C */  lw         $v1, %lo(randSeed)($v1)
    /* 61D0C 8007150C 80554224 */  addiu      $v0, $v0, %lo(_vt_17AIState_Purgatory)
    /* 61D10 80071510 040022AE */  sw         $v0, 0x4($s1)
    /* 61D14 80071514 1800C300 */  mult       $a2, $v1
    /* 61D18 80071518 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 61D1C 8007151C DCF9428C */  lw         $v0, %lo(Cars_gList)($v0)
    /* 61D20 80071520 0000238E */  lw         $v1, 0x0($s1)
    /* 61D24 80071524 00000000 */  nop
    /* 61D28 80071528 780562AC */  sw         $v0, 0x578($v1)
    /* 61D2C 8007152C 1180023C */  lui        $v0, %hi(AITune_LifeTimer)
    /* 61D30 80071530 1480033C */  lui        $v1, %hi(Cars_gNumTrafficCars)
    /* 61D34 80071534 08C8638C */  lw         $v1, %lo(Cars_gNumTrafficCars)($v1)
    /* 61D38 80071538 DCDF4224 */  addiu      $v0, $v0, %lo(AITune_LifeTimer)
    /* 61D3C 8007153C 80180300 */  sll        $v1, $v1, 2
    /* 61D40 80071540 21186200 */  addu       $v1, $v1, $v0
    /* 61D44 80071544 0000638C */  lw         $v1, 0x0($v1)
    /* 61D48 80071548 12300000 */  mflo       $a2
    /* 61D4C 8007154C 02120600 */  srl        $v0, $a2, 8
    /* 61D50 80071550 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 61D54 80071554 18006200 */  mult       $v1, $v0
    /* 61D58 80071558 21800000 */  addu       $s0, $zero, $zero
    /* 61D5C 8007155C 1480053C */  lui        $a1, %hi(D_8013C5D8)
    /* 61D60 80071560 D8C5A524 */  addiu      $a1, $a1, %lo(D_8013C5D8)
    /* 61D64 80071564 1480013C */  lui        $at, %hi(randtemp)
    /* 61D68 80071568 00D126AC */  sw         $a2, %lo(randtemp)($at)
    /* 61D6C 8007156C 12180000 */  mflo       $v1
    /* 61D70 80071570 02140300 */  srl        $v0, $v1, 16
    /* 61D74 80071574 0000238E */  lw         $v1, 0x0($s1)
    /* 61D78 80071578 01004224 */  addiu      $v0, $v0, 0x1
    /* 61D7C 8007157C 8C0562AC */  sw         $v0, 0x58C($v1)
    /* 61D80 80071580 0000248E */  lw         $a0, 0x0($s1)
    /* 61D84 80071584 FFFFC630 */  andi       $a2, $a2, 0xFFFF
    /* 61D88 80071588 1480013C */  lui        $at, %hi(fastRandom)
    /* 61D8C 8007158C FCD026AC */  sw         $a2, %lo(fastRandom)($at)
    /* 61D90 80071590 5F97030C */  jal        strcmp
    /* 61D94 80071594 40028424 */   addiu     $a0, $a0, 0x240
    /* 61D98 80071598 07004010 */  beqz       $v0, .L800715B8
    /* 61D9C 8007159C 1480053C */   lui       $a1, %hi(D_8013C5E0)
    /* 61DA0 800715A0 0000248E */  lw         $a0, 0x0($s1)
    /* 61DA4 800715A4 E0C5A524 */  addiu      $a1, $a1, %lo(D_8013C5E0)
    /* 61DA8 800715A8 5F97030C */  jal        strcmp
    /* 61DAC 800715AC 40028424 */   addiu     $a0, $a0, 0x240
    /* 61DB0 800715B0 02004014 */  bnez       $v0, .L800715BC
    /* 61DB4 800715B4 00000000 */   nop
  .L800715B8:
    /* 61DB8 800715B8 01001024 */  addiu      $s0, $zero, 0x1
  .L800715BC:
    /* 61DBC 800715BC 08000012 */  beqz       $s0, .L800715E0
    /* 61DC0 800715C0 00000000 */   nop
    /* 61DC4 800715C4 0000248E */  lw         $a0, 0x0($s1)
    /* 61DC8 800715C8 00000000 */  nop
    /* 61DCC 800715CC 8C05838C */  lw         $v1, 0x58C($a0)
    /* 61DD0 800715D0 00000000 */  nop
    /* 61DD4 800715D4 80100300 */  sll        $v0, $v1, 2
    /* 61DD8 800715D8 21104300 */  addu       $v0, $v0, $v1
    /* 61DDC 800715DC 8C0582AC */  sw         $v0, 0x58C($a0)
  .L800715E0:
    /* 61DE0 800715E0 0000238E */  lw         $v1, 0x0($s1)
    /* 61DE4 800715E4 00000000 */  nop
    /* 61DE8 800715E8 7005628C */  lw         $v0, 0x570($v1)
    /* 61DEC 800715EC 00000000 */  nop
    /* 61DF0 800715F0 04004234 */  ori        $v0, $v0, 0x4
    /* 61DF4 800715F4 700562AC */  sw         $v0, 0x570($v1)
    /* 61DF8 800715F8 0000228E */  lw         $v0, 0x0($s1)
    /* 61DFC 800715FC 00000000 */  nop
    /* 61E00 80071600 6002428C */  lw         $v0, 0x260($v0)
    /* 61E04 80071604 00000000 */  nop
    /* 61E08 80071608 10004230 */  andi       $v0, $v0, 0x10
    /* 61E0C 8007160C 06004010 */  beqz       $v0, .L80071628
    /* 61E10 80071610 21102002 */   addu      $v0, $s1, $zero
    /* 61E14 80071614 3018828F */  lw         $v0, %gp_rel(_bss_obj)($gp)
    /* 61E18 80071618 00000000 */  nop
    /* 61E1C 8007161C 01004224 */  addiu      $v0, $v0, 0x1
    /* 61E20 80071620 301882AF */  sw         $v0, %gp_rel(_bss_obj)($gp)
    /* 61E24 80071624 21102002 */  addu       $v0, $s1, $zero
  .L80071628:
    /* 61E28 80071628 2800BF8F */  lw         $ra, 0x28($sp)
    /* 61E2C 8007162C 2400B18F */  lw         $s1, 0x24($sp)
    /* 61E30 80071630 2000B08F */  lw         $s0, 0x20($sp)
    /* 61E34 80071634 0800E003 */  jr         $ra
    /* 61E38 80071638 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel __17AIState_PurgatoryP8Car_tObj
