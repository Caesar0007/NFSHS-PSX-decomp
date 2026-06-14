.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo, 0x1D4

glabel AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
    /* 57B14 80067314 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 57B18 80067318 1800B2AF */  sw         $s2, 0x18($sp)
    /* 57B1C 8006731C 21908000 */  addu       $s2, $a0, $zero
    /* 57B20 80067320 2000B4AF */  sw         $s4, 0x20($sp)
    /* 57B24 80067324 21A0A000 */  addu       $s4, $a1, $zero
    /* 57B28 80067328 2400B5AF */  sw         $s5, 0x24($sp)
    /* 57B2C 8006732C 0100153C */  lui        $s5, (0x10000 >> 16)
    /* 57B30 80067330 21208002 */  addu       $a0, $s4, $zero
    /* 57B34 80067334 2800BFAF */  sw         $ra, 0x28($sp)
    /* 57B38 80067338 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 57B3C 8006733C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 57B40 80067340 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57B44 80067344 1000B0AF */   sw        $s0, 0x10($sp)
    /* 57B48 80067348 21208002 */  addu       $a0, $s4, $zero
    /* 57B4C 8006734C 98054526 */  addiu      $a1, $s2, 0x598
    /* 57B50 80067350 1C000624 */  addiu      $a2, $zero, 0x1C
    /* 57B54 80067354 CFEE020C */  jal        Udff_GetBuffer__FP10Udff_tInfoPci
    /* 57B58 80067358 840542AE */   sw        $v0, 0x584($s2)
    /* 57B5C 8006735C 21880000 */  addu       $s1, $zero, $zero
    /* 57B60 80067360 FCFF1324 */  addiu      $s3, $zero, -0x4
    /* 57B64 80067364 21804002 */  addu       $s0, $s2, $zero
  .L80067368:
    /* 57B68 80067368 06002016 */  bnez       $s1, .L80067384
    /* 57B6C 8006736C 00000000 */   nop
    /* 57B70 80067370 9805458E */  lw         $a1, 0x598($s2)
    /* 57B74 80067374 0191030C */  jal        rdiv
    /* 57B78 80067378 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 57B7C 8006737C EC9C0108 */  j          .L800673B0
    /* 57B80 80067380 B40542AE */   sw        $v0, 0x5B4($s2)
  .L80067384:
    /* 57B84 80067384 9805038E */  lw         $v1, 0x598($s0)
    /* 57B88 80067388 00000000 */  nop
    /* 57B8C 8006738C 03006014 */  bnez       $v1, .L8006739C
    /* 57B90 80067390 21105302 */   addu      $v0, $s2, $s3
    /* 57B94 80067394 EC9C0108 */  j          .L800673B0
    /* 57B98 80067398 B40500AE */   sw        $zero, 0x5B4($s0)
  .L8006739C:
    /* 57B9C 8006739C 9805458C */  lw         $a1, 0x598($v0)
    /* 57BA0 800673A0 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 57BA4 800673A4 0191030C */  jal        rdiv
    /* 57BA8 800673A8 23286500 */   subu      $a1, $v1, $a1
    /* 57BAC 800673AC B40502AE */  sw         $v0, 0x5B4($s0)
  .L800673B0:
    /* 57BB0 800673B0 04007326 */  addiu      $s3, $s3, 0x4
    /* 57BB4 800673B4 01003126 */  addiu      $s1, $s1, 0x1
    /* 57BB8 800673B8 0700222A */  slti       $v0, $s1, 0x7
    /* 57BBC 800673BC EAFF4014 */  bnez       $v0, .L80067368
    /* 57BC0 800673C0 04001026 */   addiu     $s0, $s0, 0x4
    /* 57BC4 800673C4 21208002 */  addu       $a0, $s4, $zero
    /* 57BC8 800673C8 D0055026 */  addiu      $s0, $s2, 0x5D0
    /* 57BCC 800673CC 21280002 */  addu       $a1, $s0, $zero
    /* 57BD0 800673D0 CFEE020C */  jal        Udff_GetBuffer__FP10Udff_tInfoPci
    /* 57BD4 800673D4 E0000624 */   addiu     $a2, $zero, 0xE0
    /* 57BD8 800673D8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57BDC 800673DC 21208002 */   addu      $a0, $s4, $zero
    /* 57BE0 800673E0 21208002 */  addu       $a0, $s4, $zero
    /* 57BE4 800673E4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57BE8 800673E8 7C0542AE */   sw        $v0, 0x57C($s2)
    /* 57BEC 800673EC 21208002 */  addu       $a0, $s4, $zero
    /* 57BF0 800673F0 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57BF4 800673F4 280742AE */   sw        $v0, 0x728($s2)
    /* 57BF8 800673F8 6002438E */  lw         $v1, 0x260($s2)
    /* 57BFC 800673FC 00000000 */  nop
    /* 57C00 80067400 08006330 */  andi       $v1, $v1, 0x8
    /* 57C04 80067404 08006010 */  beqz       $v1, .L80067428
    /* 57C08 80067408 2C0742AE */   sw        $v0, 0x72C($s2)
    /* 57C0C 8006740C 8802428E */  lw         $v0, 0x288($s2)
    /* 57C10 80067410 1180033C */  lui        $v1, %hi(AITune_accelerationScale)
    /* 57C14 80067414 0000428C */  lw         $v0, 0x0($v0)
    /* 57C18 80067418 04DF6324 */  addiu      $v1, $v1, %lo(AITune_accelerationScale)
    /* 57C1C 8006741C 80100200 */  sll        $v0, $v0, 2
    /* 57C20 80067420 21104300 */  addu       $v0, $v0, $v1
    /* 57C24 80067424 0000558C */  lw         $s5, 0x0($v0)
  .L80067428:
    /* 57C28 80067428 578F020C */  jal        __builtin_new
    /* 57C2C 8006742C 5C000424 */   addiu     $a0, $zero, 0x5C
    /* 57C30 80067430 21204000 */  addu       $a0, $v0, $zero
    /* 57C34 80067434 21280002 */  addu       $a1, $s0, $zero
    /* 57C38 80067438 2130A002 */  addu       $a2, $s5, $zero
    /* 57C3C 8006743C 5CB4010C */  jal        __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t
    /* 57C40 80067440 03000724 */   addiu     $a3, $zero, 0x3
    /* 57C44 80067444 8802438E */  lw         $v1, 0x288($s2)
    /* 57C48 80067448 B00642AE */  sw         $v0, 0x6B0($s2)
    /* 57C4C 8006744C 0000648C */  lw         $a0, 0x0($v1)
    /* 57C50 80067450 769D010C */  jal        AIInit_IsNonStandardCarFile__Fi
    /* 57C54 80067454 00000000 */   nop
    /* 57C58 80067458 09004010 */  beqz       $v0, .L80067480
    /* 57C5C 8006745C 00000000 */   nop
    /* 57C60 80067460 578F020C */  jal        __builtin_new
    /* 57C64 80067464 58000424 */   addiu     $a0, $zero, 0x58
    /* 57C68 80067468 21204000 */  addu       $a0, $v0, $zero
    /* 57C6C 8006746C 40024526 */  addiu      $a1, $s2, 0x240
    /* 57C70 80067470 EFB4010C */  jal        __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t
    /* 57C74 80067474 07000624 */   addiu     $a2, $zero, 0x7
    /* 57C78 80067478 219D0108 */  j          .L80067484
    /* 57C7C 8006747C B40642AE */   sw        $v0, 0x6B4($s2)
  .L80067480:
    /* 57C80 80067480 B40640AE */  sw         $zero, 0x6B4($s2)
  .L80067484:
    /* 57C84 80067484 0100053C */  lui        $a1, (0x13333 >> 16)
    /* 57C88 80067488 2807448E */  lw         $a0, 0x728($s2)
    /* 57C8C 8006748C CA90030C */  jal        fixedmult
    /* 57C90 80067490 3333A534 */   ori       $a1, $a1, (0x13333 & 0xFFFF)
    /* 57C94 80067494 21208002 */  addu       $a0, $s4, $zero
    /* 57C98 80067498 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57C9C 8006749C 280742AE */   sw        $v0, 0x728($s2)
    /* 57CA0 800674A0 21208002 */  addu       $a0, $s4, $zero
    /* 57CA4 800674A4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57CA8 800674A8 BC0642AE */   sw        $v0, 0x6BC($s2)
    /* 57CAC 800674AC 380742AE */  sw         $v0, 0x738($s2)
    /* 57CB0 800674B0 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 57CB4 800674B4 600742AE */  sw         $v0, 0x760($s2)
    /* 57CB8 800674B8 7C0740AE */  sw         $zero, 0x77C($s2)
    /* 57CBC 800674BC 800740AE */  sw         $zero, 0x780($s2)
    /* 57CC0 800674C0 780742AE */  sw         $v0, 0x778($s2)
    /* 57CC4 800674C4 2800BF8F */  lw         $ra, 0x28($sp)
    /* 57CC8 800674C8 2400B58F */  lw         $s5, 0x24($sp)
    /* 57CCC 800674CC 2000B48F */  lw         $s4, 0x20($sp)
    /* 57CD0 800674D0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 57CD4 800674D4 1800B28F */  lw         $s2, 0x18($sp)
    /* 57CD8 800674D8 1400B18F */  lw         $s1, 0x14($sp)
    /* 57CDC 800674DC 1000B08F */  lw         $s0, 0x10($sp)
    /* 57CE0 800674E0 0800E003 */  jr         $ra
    /* 57CE4 800674E4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
