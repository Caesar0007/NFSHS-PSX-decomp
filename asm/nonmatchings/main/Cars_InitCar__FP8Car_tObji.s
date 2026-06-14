.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cars_InitCar__FP8Car_tObji, 0x310

glabel Cars_InitCar__FP8Car_tObji
    /* 7A974 8008A174 1180023C */  lui        $v0, %hi(D_801135B0)
    /* 7A978 8008A178 B035428C */  lw         $v0, %lo(D_801135B0)($v0)
    /* 7A97C 8008A17C E8FEBD27 */  addiu      $sp, $sp, -0x118
    /* 7A980 8008A180 FC00B1AF */  sw         $s1, 0xFC($sp)
    /* 7A984 8008A184 21888000 */  addu       $s1, $a0, $zero
    /* 7A988 8008A188 0C01B5AF */  sw         $s5, 0x10C($sp)
    /* 7A98C 8008A18C 21A8A000 */  addu       $s5, $a1, $zero
    /* 7A990 8008A190 0001B2AF */  sw         $s2, 0x100($sp)
    /* 7A994 8008A194 21900000 */  addu       $s2, $zero, $zero
    /* 7A998 8008A198 0401B3AF */  sw         $s3, 0x104($sp)
    /* 7A99C 8008A19C 21984002 */  addu       $s3, $s2, $zero
    /* 7A9A0 8008A1A0 0801B4AF */  sw         $s4, 0x108($sp)
    /* 7A9A4 8008A1A4 21A04002 */  addu       $s4, $s2, $zero
    /* 7A9A8 8008A1A8 F800B0AF */  sw         $s0, 0xF8($sp)
    /* 7A9AC 8008A1AC 21804002 */  addu       $s0, $s2, $zero
    /* 7A9B0 8008A1B0 2A10A202 */  slt        $v0, $s5, $v0
    /* 7A9B4 8008A1B4 5E004010 */  beqz       $v0, .L8008A330
    /* 7A9B8 8008A1B8 1001BFAF */   sw        $ra, 0x110($sp)
    /* 7A9BC 8008A1BC 8802228E */  lw         $v0, 0x288($s1)
    /* 7A9C0 8008A1C0 00000000 */  nop
    /* 7A9C4 8008A1C4 0000448C */  lw         $a0, 0x0($v0)
    /* 7A9C8 8008A1C8 769D010C */  jal        AIInit_IsNonStandardCarFile__Fi
    /* 7A9CC 8008A1CC 00000000 */   nop
    /* 7A9D0 8008A1D0 09004010 */  beqz       $v0, .L8008A1F8
    /* 7A9D4 8008A1D4 1000A427 */   addiu     $a0, $sp, 0x10
    /* 7A9D8 8008A1D8 0580053C */  lui        $a1, %hi(D_80055988)
    /* 7A9DC 8008A1DC 8859A524 */  addiu      $a1, $a1, %lo(D_80055988)
    /* 7A9E0 8008A1E0 1180023C */  lui        $v0, %hi(D_80116478)
    /* 7A9E4 8008A1E4 7864468C */  lw         $a2, %lo(D_80116478)($v0)
    /* 7A9E8 8008A1E8 2F91030C */  jal        sprintf
    /* 7A9EC 8008A1EC 40022726 */   addiu     $a3, $s1, 0x240
    /* 7A9F0 8008A1F0 84280208 */  j          .L8008A210
    /* 7A9F4 8008A1F4 1000A427 */   addiu     $a0, $sp, 0x10
  .L8008A1F8:
    /* 7A9F8 8008A1F8 1180023C */  lui        $v0, %hi(D_80116478)
    /* 7A9FC 8008A1FC 7864468C */  lw         $a2, %lo(D_80116478)($v0)
    /* 7AA00 8008A200 0580053C */  lui        $a1, %hi(D_80055994)
    /* 7AA04 8008A204 2F91030C */  jal        sprintf
    /* 7AA08 8008A208 9459A524 */   addiu     $a1, $a1, %lo(D_80055994)
    /* 7AA0C 8008A20C 1000A427 */  addiu      $a0, $sp, 0x10
  .L8008A210:
    /* 7AA10 8008A210 5797030C */  jal        loadpackadr
    /* 7AA14 8008A214 10000524 */   addiu     $a1, $zero, 0x10
    /* 7AA18 8008A218 21984000 */  addu       $s3, $v0, $zero
    /* 7AA1C 8008A21C 21200000 */  addu       $a0, $zero, $zero
    /* 7AA20 8008A220 21286002 */  addu       $a1, $s3, $zero
    /* 7AA24 8008A224 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 7AA28 8008A228 01000624 */   addiu     $a2, $zero, 0x1
    /* 7AA2C 8008A22C 8802238E */  lw         $v1, 0x288($s1)
    /* 7AA30 8008A230 00000000 */  nop
    /* 7AA34 8008A234 0000638C */  lw         $v1, 0x0($v1)
    /* 7AA38 8008A238 21A04000 */  addu       $s4, $v0, $zero
    /* 7AA3C 8008A23C 1D006228 */  slti       $v0, $v1, 0x1D
    /* 7AA40 8008A240 0B004010 */  beqz       $v0, .L8008A270
    /* 7AA44 8008A244 E000A427 */   addiu     $a0, $sp, 0xE0
    /* 7AA48 8008A248 1480053C */  lui        $a1, %hi(D_8013C7EC)
    /* 7AA4C 8008A24C ECC7A524 */  addiu      $a1, $a1, %lo(D_8013C7EC)
    /* 7AA50 8008A250 80100300 */  sll        $v0, $v1, 2
    /* 7AA54 8008A254 21104300 */  addu       $v0, $v0, $v1
    /* 7AA58 8008A258 1180063C */  lui        $a2, %hi(GameSetup_gCarNames)
    /* 7AA5C 8008A25C 4430C624 */  addiu      $a2, $a2, %lo(GameSetup_gCarNames)
    /* 7AA60 8008A260 2F91030C */  jal        sprintf
    /* 7AA64 8008A264 21304600 */   addu      $a2, $v0, $a2
    /* 7AA68 8008A268 A0280208 */  j          .L8008A280
    /* 7AA6C 8008A26C 7800B027 */   addiu     $s0, $sp, 0x78
  .L8008A270:
    /* 7AA70 8008A270 0580053C */  lui        $a1, %hi(D_800559A0)
    /* 7AA74 8008A274 2F91030C */  jal        sprintf
    /* 7AA78 8008A278 A059A524 */   addiu     $a1, $a1, %lo(D_800559A0)
    /* 7AA7C 8008A27C 7800B027 */  addiu      $s0, $sp, 0x78
  .L8008A280:
    /* 7AA80 8008A280 21200002 */  addu       $a0, $s0, $zero
    /* 7AA84 8008A284 1180023C */  lui        $v0, %hi(D_80116474)
    /* 7AA88 8008A288 0580053C */  lui        $a1, %hi(D_800559AC)
    /* 7AA8C 8008A28C 7464468C */  lw         $a2, %lo(D_80116474)($v0)
    /* 7AA90 8008A290 2F91030C */  jal        sprintf
    /* 7AA94 8008A294 AC59A524 */   addiu     $a1, $a1, %lo(D_800559AC)
    /* 7AA98 8008A298 21200002 */  addu       $a0, $s0, $zero
    /* 7AA9C 8008A29C EA95030C */  jal        loadfileadrz
    /* 7AAA0 8008A2A0 10000524 */   addiu     $a1, $zero, 0x10
    /* 7AAA4 8008A2A4 21904000 */  addu       $s2, $v0, $zero
    /* 7AAA8 8008A2A8 21204002 */  addu       $a0, $s2, $zero
    /* 7AAAC 8008A2AC 8698030C */  jal        locatebig
    /* 7AAB0 8008A2B0 E000A527 */   addiu     $a1, $sp, 0xE0
    /* 7AAB4 8008A2B4 21200000 */  addu       $a0, $zero, $zero
    /* 7AAB8 8008A2B8 21284000 */  addu       $a1, $v0, $zero
    /* 7AABC 8008A2BC 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 7AAC0 8008A2C0 21308000 */   addu      $a2, $a0, $zero
    /* 7AAC4 8008A2C4 1180033C */  lui        $v1, %hi(D_801135B0)
    /* 7AAC8 8008A2C8 B035638C */  lw         $v1, %lo(D_801135B0)($v1)
    /* 7AACC 8008A2CC 00000000 */  nop
    /* 7AAD0 8008A2D0 2A18A302 */  slt        $v1, $s5, $v1
    /* 7AAD4 8008A2D4 16006010 */  beqz       $v1, .L8008A330
    /* 7AAD8 8008A2D8 21804000 */   addu      $s0, $v0, $zero
    /* 7AADC 8008A2DC 21202002 */  addu       $a0, $s1, $zero
    /* 7AAE0 8008A2E0 C59C010C */  jal        AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo
    /* 7AAE4 8008A2E4 21288002 */   addu      $a1, $s4, $zero
    /* 7AAE8 8008A2E8 7B9C010C */  jal        AIInit_RestartAICar__FP8Car_tObj
    /* 7AAEC 8008A2EC 21202002 */   addu      $a0, $s1, $zero
    /* 7AAF0 8008A2F0 0580043C */  lui        $a0, %hi(D_800559B8)
    /* 7AAF4 8008A2F4 B8598424 */  addiu      $a0, $a0, %lo(D_800559B8)
    /* 7AAF8 8008A2F8 D0010524 */  addiu      $a1, $zero, 0x1D0
    /* 7AAFC 8008A2FC CF94030C */  jal        reservememadr
    /* 7AB00 8008A300 21300000 */   addu      $a2, $zero, $zero
    /* 7AB04 8008A304 21202002 */  addu       $a0, $s1, $zero
    /* 7AB08 8008A308 21280002 */  addu       $a1, $s0, $zero
    /* 7AB0C 8008A30C B2A1020C */  jal        Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo
    /* 7AB10 8008A310 640422AE */   sw        $v0, 0x464($s1)
    /* 7AB14 8008A314 6002228E */  lw         $v0, 0x260($s1)
    /* 7AB18 8008A318 00000000 */  nop
    /* 7AB1C 8008A31C 04004230 */  andi       $v0, $v0, 0x4
    /* 7AB20 8008A320 04004010 */  beqz       $v0, .L8008A334
    /* 7AB24 8008A324 0A80023C */   lui       $v0, %hi(Newton_UpdateRoadInfo__FP13BO_tNewtonObj)
    /* 7AB28 8008A328 59A2020C */  jal        Physics_CalculateDerivedCarSpecs__FP8Car_tObj
    /* 7AB2C 8008A32C 21202002 */   addu      $a0, $s1, $zero
  .L8008A330:
    /* 7AB30 8008A330 0A80023C */  lui        $v0, %hi(Newton_UpdateRoadInfo__FP13BO_tNewtonObj)
  .L8008A334:
    /* 7AB34 8008A334 68154224 */  addiu      $v0, $v0, %lo(Newton_UpdateRoadInfo__FP13BO_tNewtonObj)
    /* 7AB38 8008A338 C40422AE */  sw         $v0, 0x4C4($s1)
    /* 7AB3C 8008A33C 0B80023C */  lui        $v0, %hi(Replay_DoReplay__FP8Car_tObj)
    /* 7AB40 8008A340 2C504224 */  addiu      $v0, $v0, %lo(Replay_DoReplay__FP8Car_tObj)
    /* 7AB44 8008A344 C80422AE */  sw         $v0, 0x4C8($s1)
    /* 7AB48 8008A348 0980023C */  lui        $v0, %hi(Control_Human__FP8Car_tObj)
    /* 7AB4C 8008A34C E41F4224 */  addiu      $v0, $v0, %lo(Control_Human__FP8Car_tObj)
    /* 7AB50 8008A350 CC0422AE */  sw         $v0, 0x4CC($s1)
    /* 7AB54 8008A354 0C80023C */  lui        $v0, %hi(Stats_TrackStats__FP8Car_tObj)
    /* 7AB58 8008A358 FC814224 */  addiu      $v0, $v0, %lo(Stats_TrackStats__FP8Car_tObj)
    /* 7AB5C 8008A35C D00422AE */  sw         $v0, 0x4D0($s1)
    /* 7AB60 8008A360 0B80023C */  lui        $v0, %hi(Physics_SimCar__FP8Car_tObj)
    /* 7AB64 8008A364 44D54224 */  addiu      $v0, $v0, %lo(Physics_SimCar__FP8Car_tObj)
    /* 7AB68 8008A368 D40422AE */  sw         $v0, 0x4D4($s1)
    /* 7AB6C 8008A36C 0A80023C */  lui        $v0, %hi(Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj)
    /* 7AB70 8008A370 74364224 */  addiu      $v0, $v0, %lo(Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj)
    /* 7AB74 8008A374 D80422AE */  sw         $v0, 0x4D8($s1)
    /* 7AB78 8008A378 0A80023C */  lui        $v0, %hi(Newton_QDUpdateVel__FP13BO_tNewtonObj)
    /* 7AB7C 8008A37C 681E4224 */  addiu      $v0, $v0, %lo(Newton_QDUpdateVel__FP13BO_tNewtonObj)
    /* 7AB80 8008A380 DC0422AE */  sw         $v0, 0x4DC($s1)
    /* 7AB84 8008A384 0A80023C */  lui        $v0, %hi(Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj)
    /* 7AB88 8008A388 E8204224 */  addiu      $v0, $v0, %lo(Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj)
    /* 7AB8C 8008A38C E00422AE */  sw         $v0, 0x4E0($s1)
    /* 7AB90 8008A390 0980023C */  lui        $v0, %hi(Collide_CheckMeForCollisions__FP13BO_tNewtonObj)
    /* 7AB94 8008A394 CC184224 */  addiu      $v0, $v0, %lo(Collide_CheckMeForCollisions__FP13BO_tNewtonObj)
    /* 7AB98 8008A398 E40422AE */  sw         $v0, 0x4E4($s1)
    /* 7AB9C 8008A39C 0980023C */  lui        $v0, %hi(Car_DoPostCollisionStuff__FP8Car_tObj)
    /* 7ABA0 8008A3A0 6002238E */  lw         $v1, 0x260($s1)
    /* 7ABA4 8008A3A4 DC984224 */  addiu      $v0, $v0, %lo(Car_DoPostCollisionStuff__FP8Car_tObj)
    /* 7ABA8 8008A3A8 02006330 */  andi       $v1, $v1, 0x2
    /* 7ABAC 8008A3AC 0B006010 */  beqz       $v1, .L8008A3DC
    /* 7ABB0 8008A3B0 E80422AE */   sw        $v0, 0x4E8($s1)
    /* 7ABB4 8008A3B4 0980023C */  lui        $v0, %hi(Control_AI__FP8Car_tObj)
    /* 7ABB8 8008A3B8 DC1F4224 */  addiu      $v0, $v0, %lo(Control_AI__FP8Car_tObj)
    /* 7ABBC 8008A3BC CC0422AE */  sw         $v0, 0x4CC($s1)
    /* 7ABC0 8008A3C0 0780023C */  lui        $v0, %hi(AIPhysic_Main__FP8Car_tObj)
    /* 7ABC4 8008A3C4 849B4224 */  addiu      $v0, $v0, %lo(AIPhysic_Main__FP8Car_tObj)
    /* 7ABC8 8008A3C8 D40422AE */  sw         $v0, 0x4D4($s1)
    /* 7ABCC 8008A3CC 0A80023C */  lui        $v0, %hi(Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj)
    /* 7ABD0 8008A3D0 F8214224 */  addiu      $v0, $v0, %lo(Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj)
    /* 7ABD4 8008A3D4 C80420AE */  sw         $zero, 0x4C8($s1)
    /* 7ABD8 8008A3D8 E00422AE */  sw         $v0, 0x4E0($s1)
  .L8008A3DC:
    /* 7ABDC 8008A3DC 6002228E */  lw         $v0, 0x260($s1)
    /* 7ABE0 8008A3E0 00000000 */  nop
    /* 7ABE4 8008A3E4 04004230 */  andi       $v0, $v0, 0x4
    /* 7ABE8 8008A3E8 0C004010 */  beqz       $v0, .L8008A41C
    /* 7ABEC 8008A3EC 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 7ABF0 8008A3F0 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* 7ABF4 8008A3F4 2000628C */  lw         $v0, 0x20($v1)
    /* 7ABF8 8008A3F8 00000000 */  nop
    /* 7ABFC 8008A3FC 08004010 */  beqz       $v0, .L8008A420
    /* 7AC00 8008A400 21202002 */   addu      $a0, $s1, $zero
    /* 7AC04 8008A404 0C00628C */  lw         $v0, 0xC($v1)
    /* 7AC08 8008A408 00000000 */  nop
    /* 7AC0C 8008A40C 04004018 */  blez       $v0, .L8008A420
    /* 7AC10 8008A410 0880023C */   lui       $v0, %hi(Cars_QDUpdateVelGlue__FP8Car_tObj)
    /* 7AC14 8008A414 E85E4224 */  addiu      $v0, $v0, %lo(Cars_QDUpdateVelGlue__FP8Car_tObj)
    /* 7AC18 8008A418 DC0422AE */  sw         $v0, 0x4DC($s1)
  .L8008A41C:
    /* 7AC1C 8008A41C 21202002 */  addu       $a0, $s1, $zero
  .L8008A420:
    /* 7AC20 8008A420 CBBB020C */  jal        R3DCar_Instantiate3DCar__FP8Car_tObji
    /* 7AC24 8008A424 2128A002 */   addu      $a1, $s5, $zero
    /* 7AC28 8008A428 1180023C */  lui        $v0, %hi(D_801135B0)
    /* 7AC2C 8008A42C B035428C */  lw         $v0, %lo(D_801135B0)($v0)
    /* 7AC30 8008A430 00000000 */  nop
    /* 7AC34 8008A434 2A10A202 */  slt        $v0, $s5, $v0
    /* 7AC38 8008A438 09004010 */  beqz       $v0, .L8008A460
    /* 7AC3C 8008A43C 00000000 */   nop
    /* 7AC40 8008A440 B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 7AC44 8008A444 21208002 */   addu      $a0, $s4, $zero
    /* 7AC48 8008A448 B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 7AC4C 8008A44C 21200002 */   addu      $a0, $s0, $zero
    /* 7AC50 8008A450 5095030C */  jal        purgememadr
    /* 7AC54 8008A454 21204002 */   addu      $a0, $s2, $zero
    /* 7AC58 8008A458 5095030C */  jal        purgememadr
    /* 7AC5C 8008A45C 21206002 */   addu      $a0, $s3, $zero
  .L8008A460:
    /* 7AC60 8008A460 1001BF8F */  lw         $ra, 0x110($sp)
    /* 7AC64 8008A464 0C01B58F */  lw         $s5, 0x10C($sp)
    /* 7AC68 8008A468 0801B48F */  lw         $s4, 0x108($sp)
    /* 7AC6C 8008A46C 0401B38F */  lw         $s3, 0x104($sp)
    /* 7AC70 8008A470 0001B28F */  lw         $s2, 0x100($sp)
    /* 7AC74 8008A474 FC00B18F */  lw         $s1, 0xFC($sp)
    /* 7AC78 8008A478 F800B08F */  lw         $s0, 0xF8($sp)
    /* 7AC7C 8008A47C 0800E003 */  jr         $ra
    /* 7AC80 8008A480 1801BD27 */   addiu     $sp, $sp, 0x118
endlabel Cars_InitCar__FP8Car_tObji
