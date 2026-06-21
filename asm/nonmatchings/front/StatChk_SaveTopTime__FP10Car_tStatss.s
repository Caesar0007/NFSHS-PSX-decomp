.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StatChk_SaveTopTime__FP10Car_tStatss, 0x680

glabel StatChk_SaveTopTime__FP10Car_tStatss
    /* 3A9B8 8004A1B8 50FFBD27 */  addiu      $sp, $sp, -0xB0
    /* 3A9BC 8004A1BC A800BEAF */  sw         $fp, 0xA8($sp)
    /* 3A9C0 8004A1C0 21F08000 */  addu       $fp, $a0, $zero
    /* 3A9C4 8004A1C4 A400B7AF */  sw         $s7, 0xA4($sp)
    /* 3A9C8 8004A1C8 21B80000 */  addu       $s7, $zero, $zero
    /* 3A9CC 8004A1CC 8800B0AF */  sw         $s0, 0x88($sp)
    /* 3A9D0 8004A1D0 2180E002 */  addu       $s0, $s7, $zero
    /* 3A9D4 8004A1D4 5800A327 */  addiu      $v1, $sp, 0x58
    /* 3A9D8 8004A1D8 AC00BFAF */  sw         $ra, 0xAC($sp)
    /* 3A9DC 8004A1DC A000B6AF */  sw         $s6, 0xA0($sp)
    /* 3A9E0 8004A1E0 9C00B5AF */  sw         $s5, 0x9C($sp)
    /* 3A9E4 8004A1E4 9800B4AF */  sw         $s4, 0x98($sp)
    /* 3A9E8 8004A1E8 9400B3AF */  sw         $s3, 0x94($sp)
    /* 3A9EC 8004A1EC 9000B2AF */  sw         $s2, 0x90($sp)
    /* 3A9F0 8004A1F0 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* 3A9F4 8004A1F4 6000A5A7 */  sh         $a1, 0x60($sp)
    /* 3A9F8 8004A1F8 6800A0AF */  sw         $zero, 0x68($sp)
    /* 3A9FC 8004A1FC 7800A0A7 */  sh         $zero, 0x78($sp)
    /* 3AA00 8004A200 00141000 */  sll        $v0, $s0, 16
  .L8004A204:
    /* 3AA04 8004A204 83130200 */  sra        $v0, $v0, 14
    /* 3AA08 8004A208 21106200 */  addu       $v0, $v1, $v0
    /* 3AA0C 8004A20C 000040AC */  sw         $zero, 0x0($v0)
    /* 3AA10 8004A210 01000226 */  addiu      $v0, $s0, 0x1
    /* 3AA14 8004A214 21804000 */  addu       $s0, $v0, $zero
    /* 3AA18 8004A218 00140200 */  sll        $v0, $v0, 16
    /* 3AA1C 8004A21C 03140200 */  sra        $v0, $v0, 16
    /* 3AA20 8004A220 02004228 */  slti       $v0, $v0, 0x2
    /* 3AA24 8004A224 F7FF4014 */  bnez       $v0, .L8004A204
    /* 3AA28 8004A228 00141000 */   sll       $v0, $s0, 16
    /* 3AA2C 8004A22C 0180043C */  lui        $a0, %hi(D_800124D8)
    /* 3AA30 8004A230 D8248424 */  addiu      $a0, $a0, %lo(D_800124D8)
    /* 3AA34 8004A234 14000824 */  addiu      $t0, $zero, 0x14
    /* 3AA38 8004A238 C0800800 */  sll        $s0, $t0, 3
    /* 3AA3C 8004A23C 21280802 */  addu       $a1, $s0, $t0
    /* 3AA40 8004A240 40280500 */  sll        $a1, $a1, 1
    /* 3AA44 8004A244 CF94030C */  jal        reservememadr
    /* 3AA48 8004A248 10000624 */   addiu     $a2, $zero, 0x10
    /* 3AA4C 8004A24C 0180043C */  lui        $a0, %hi(D_800124E4)
    /* 3AA50 8004A250 E4248424 */  addiu      $a0, $a0, %lo(D_800124E4)
    /* 3AA54 8004A254 10000624 */  addiu      $a2, $zero, 0x10
    /* 3AA58 8004A258 6000A997 */  lhu        $t1, 0x60($sp)
    /* 3AA5C 8004A25C 21B04000 */  addu       $s6, $v0, $zero
    /* 3AA60 8004A260 001C0900 */  sll        $v1, $t1, 16
    /* 3AA64 8004A264 038C0300 */  sra        $s1, $v1, 16
    /* 3AA68 8004A268 CF94030C */  jal        reservememadr
    /* 3AA6C 8004A26C 80281100 */   sll       $a1, $s1, 2
    /* 3AA70 8004A270 0180043C */  lui        $a0, %hi(D_800124F0)
    /* 3AA74 8004A274 F0248424 */  addiu      $a0, $a0, %lo(D_800124F0)
    /* 3AA78 8004A278 40281100 */  sll        $a1, $s1, 1
    /* 3AA7C 8004A27C 10000624 */  addiu      $a2, $zero, 0x10
    /* 3AA80 8004A280 CF94030C */  jal        reservememadr
    /* 3AA84 8004A284 8400A2AF */   sw        $v0, 0x84($sp)
    /* 3AA88 8004A288 0180043C */  lui        $a0, %hi(D_800124FC)
    /* 3AA8C 8004A28C FC248424 */  addiu      $a0, $a0, %lo(D_800124FC)
    /* 3AA90 8004A290 21280002 */  addu       $a1, $s0, $zero
    /* 3AA94 8004A294 10000624 */  addiu      $a2, $zero, 0x10
    /* 3AA98 8004A298 CF94030C */  jal        reservememadr
    /* 3AA9C 8004A29C 21A84000 */   addu      $s5, $v0, $zero
    /* 3AAA0 8004A2A0 21800000 */  addu       $s0, $zero, $zero
    /* 3AAA4 8004A2A4 1400201A */  blez       $s1, .L8004A2F8
    /* 3AAA8 8004A2A8 8000A2AF */   sw        $v0, 0x80($sp)
    /* 3AAAC 8004A2AC 21282002 */  addu       $a1, $s1, $zero
    /* 3AAB0 8004A2B0 001C1000 */  sll        $v1, $s0, 16
  .L8004A2B4:
    /* 3AAB4 8004A2B4 031C0300 */  sra        $v1, $v1, 16
    /* 3AAB8 8004A2B8 80100300 */  sll        $v0, $v1, 2
    /* 3AABC 8004A2BC 21104300 */  addu       $v0, $v0, $v1
    /* 3AAC0 8004A2C0 40110200 */  sll        $v0, $v0, 5
    /* 3AAC4 8004A2C4 21105E00 */  addu       $v0, $v0, $fp
    /* 3AAC8 8004A2C8 3C00428C */  lw         $v0, 0x3C($v0)
    /* 3AACC 8004A2CC 00000000 */  nop
    /* 3AAD0 8004A2D0 40100200 */  sll        $v0, $v0, 1
    /* 3AAD4 8004A2D4 21105500 */  addu       $v0, $v0, $s5
    /* 3AAD8 8004A2D8 FEFF50A4 */  sh         $s0, -0x2($v0)
    /* 3AADC 8004A2DC 01000226 */  addiu      $v0, $s0, 0x1
    /* 3AAE0 8004A2E0 21804000 */  addu       $s0, $v0, $zero
    /* 3AAE4 8004A2E4 00140200 */  sll        $v0, $v0, 16
    /* 3AAE8 8004A2E8 03140200 */  sra        $v0, $v0, 16
    /* 3AAEC 8004A2EC 2A104500 */  slt        $v0, $v0, $a1
    /* 3AAF0 8004A2F0 F0FF4014 */  bnez       $v0, .L8004A2B4
    /* 3AAF4 8004A2F4 001C1000 */   sll       $v1, $s0, 16
  .L8004A2F8:
    /* 3AAF8 8004A2F8 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 3AAFC 8004A2FC 00000000 */   nop
    /* 3AB00 8004A300 00140200 */  sll        $v0, $v0, 16
    /* 3AB04 8004A304 03240200 */  sra        $a0, $v0, 16
    /* 3AB08 8004A308 862B010C */  jal        Stattool_GetRecords__FsP13tRecordBuffer
    /* 3AB0C 8004A30C 2128C002 */   addu      $a1, $s6, $zero
    /* 3AB10 8004A310 F09F000C */  jal        Front_GetLapsForType__Fv
    /* 3AB14 8004A314 00000000 */   nop
    /* 3AB18 8004A318 09000A24 */  addiu      $t2, $zero, 0x9
    /* 3AB1C 8004A31C 02000324 */  addiu      $v1, $zero, 0x2
    /* 3AB20 8004A320 03004314 */  bne        $v0, $v1, .L8004A330
    /* 3AB24 8004A324 7000AAA7 */   sh        $t2, 0x70($sp)
    /* 3AB28 8004A328 01000B24 */  addiu      $t3, $zero, 0x1
    /* 3AB2C 8004A32C 7000ABA7 */  sh         $t3, 0x70($sp)
  .L8004A330:
    /* 3AB30 8004A330 6000A897 */  lhu        $t0, 0x60($sp)
    /* 3AB34 8004A334 00000000 */  nop
    /* 3AB38 8004A338 00140800 */  sll        $v0, $t0, 16
    /* 3AB3C 8004A33C F0004018 */  blez       $v0, .L8004A700
    /* 3AB40 8004A340 21900000 */   addu      $s2, $zero, $zero
    /* 3AB44 8004A344 7000A997 */  lhu        $t1, 0x70($sp)
    /* 3AB48 8004A348 3000B327 */  addiu      $s3, $sp, 0x30
    /* 3AB4C 8004A34C 21882001 */  addu       $s1, $t1, $zero
    /* 3AB50 8004A350 80101100 */  sll        $v0, $s1, 2
    /* 3AB54 8004A354 21105100 */  addu       $v0, $v0, $s1
    /* 3AB58 8004A358 80100200 */  sll        $v0, $v0, 2
    /* 3AB5C 8004A35C 21A05600 */  addu       $s4, $v0, $s6
    /* 3AB60 8004A360 00141200 */  sll        $v0, $s2, 16
  .L8004A364:
    /* 3AB64 8004A364 C3130200 */  sra        $v0, $v0, 15
    /* 3AB68 8004A368 21805500 */  addu       $s0, $v0, $s5
    /* 3AB6C 8004A36C 00000386 */  lh         $v1, 0x0($s0)
    /* 3AB70 8004A370 1180043C */  lui        $a0, %hi(carManager)
    /* 3AB74 8004A374 80100300 */  sll        $v0, $v1, 2
    /* 3AB78 8004A378 21104300 */  addu       $v0, $v0, $v1
    /* 3AB7C 8004A37C 40110200 */  sll        $v0, $v0, 5
    /* 3AB80 8004A380 21105E00 */  addu       $v0, $v0, $fp
    /* 3AB84 8004A384 60004584 */  lh         $a1, 0x60($v0)
    /* 3AB88 8004A388 A758000C */  jal        GetCarFromSimID__11tCarManagers
    /* 3AB8C 8004A38C 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 3AB90 8004A390 21304000 */  addu       $a2, $v0, $zero
    /* 3AB94 8004A394 0200C290 */  lbu        $v0, 0x2($a2)
    /* 3AB98 8004A398 00000000 */  nop
    /* 3AB9C 8004A39C F9FF4224 */  addiu      $v0, $v0, -0x7
    /* 3ABA0 8004A3A0 0200422C */  sltiu      $v0, $v0, 0x2
    /* 3ABA4 8004A3A4 CF004014 */  bnez       $v0, .L8004A6E4
    /* 3ABA8 8004A3A8 01004226 */   addiu     $v0, $s2, 0x1
    /* 3ABAC 8004A3AC 1180023C */  lui        $v0, %hi(D_80114603)
    /* 3ABB0 8004A3B0 03464290 */  lbu        $v0, %lo(D_80114603)($v0)
    /* 3ABB4 8004A3B4 00000000 */  nop
    /* 3ABB8 8004A3B8 0300422C */  sltiu      $v0, $v0, 0x3
    /* 3ABBC 8004A3BC 0E004010 */  beqz       $v0, .L8004A3F8
    /* 3ABC0 8004A3C0 1180023C */   lui       $v0, %hi(D_80113208)
    /* 3ABC4 8004A3C4 00000286 */  lh         $v0, 0x0($s0)
    /* 3ABC8 8004A3C8 00000000 */  nop
    /* 3ABCC 8004A3CC 80180200 */  sll        $v1, $v0, 2
    /* 3ABD0 8004A3D0 21186200 */  addu       $v1, $v1, $v0
    /* 3ABD4 8004A3D4 40190300 */  sll        $v1, $v1, 5
    /* 3ABD8 8004A3D8 07290108 */  j          .L8004A41C
    /* 3ABDC 8004A3DC 21187E00 */   addu      $v1, $v1, $fp
  .L8004A3E0:
    /* 3ABE0 8004A3E0 7800AA97 */  lhu        $t2, 0x78($sp)
    /* 3ABE4 8004A3E4 2118A203 */  addu       $v1, $sp, $v0
    /* 3ABE8 8004A3E8 00140A00 */  sll        $v0, $t2, 16
    /* 3ABEC 8004A3EC 03140200 */  sra        $v0, $v0, 16
    /* 3ABF0 8004A3F0 87290108 */  j          .L8004A61C
    /* 3ABF4 8004A3F4 580062AC */   sw        $v0, 0x58($v1)
  .L8004A3F8:
    /* 3ABF8 8004A3F8 00000386 */  lh         $v1, 0x0($s0)
    /* 3ABFC 8004A3FC 0832428C */  lw         $v0, %lo(D_80113208)($v0)
    /* 3AC00 8004A400 00000000 */  nop
    /* 3AC04 8004A404 10006214 */  bne        $v1, $v0, .L8004A448
    /* 3AC08 8004A408 01000224 */   addiu     $v0, $zero, 0x1
    /* 3AC0C 8004A40C 80100300 */  sll        $v0, $v1, 2
    /* 3AC10 8004A410 21104300 */  addu       $v0, $v0, $v1
    /* 3AC14 8004A414 40110200 */  sll        $v0, $v0, 5
    /* 3AC18 8004A418 21185E00 */  addu       $v1, $v0, $fp
  .L8004A41C:
    /* 3AC1C 8004A41C 6C00628C */  lw         $v0, 0x6C($v1)
    /* 3AC20 8004A420 00000000 */  nop
    /* 3AC24 8004A424 04004230 */  andi       $v0, $v0, 0x4
    /* 3AC28 8004A428 06004010 */  beqz       $v0, .L8004A444
    /* 3AC2C 8004A42C 02000224 */   addiu     $v0, $zero, 0x2
    /* 3AC30 8004A430 8000638C */  lw         $v1, 0x80($v1)
    /* 3AC34 8004A434 00000000 */  nop
    /* 3AC38 8004A438 03006214 */  bne        $v1, $v0, .L8004A448
    /* 3AC3C 8004A43C 01000224 */   addiu     $v0, $zero, 0x1
    /* 3AC40 8004A440 01001724 */  addiu      $s7, $zero, 0x1
  .L8004A444:
    /* 3AC44 8004A444 01000224 */  addiu      $v0, $zero, 0x1
  .L8004A448:
    /* 3AC48 8004A448 A600E216 */  bne        $s7, $v0, .L8004A6E4
    /* 3AC4C 8004A44C 01004226 */   addiu     $v0, $s2, 0x1
    /* 3AC50 8004A450 00141200 */  sll        $v0, $s2, 16
    /* 3AC54 8004A454 C3130200 */  sra        $v0, $v0, 15
    /* 3AC58 8004A458 21285500 */  addu       $a1, $v0, $s5
    /* 3AC5C 8004A45C 0000A384 */  lh         $v1, 0x0($a1)
    /* 3AC60 8004A460 9800848E */  lw         $a0, 0x98($s4)
    /* 3AC64 8004A464 80100300 */  sll        $v0, $v1, 2
    /* 3AC68 8004A468 21104300 */  addu       $v0, $v0, $v1
    /* 3AC6C 8004A46C 40110200 */  sll        $v0, $v0, 5
    /* 3AC70 8004A470 21105E00 */  addu       $v0, $v0, $fp
    /* 3AC74 8004A474 8800438C */  lw         $v1, 0x88($v0)
    /* 3AC78 8004A478 00000000 */  nop
    /* 3AC7C 8004A47C 2A106400 */  slt        $v0, $v1, $a0
    /* 3AC80 8004A480 05004014 */  bnez       $v0, .L8004A498
    /* 3AC84 8004A484 21B80000 */   addu      $s7, $zero, $zero
    /* 3AC88 8004A488 96008014 */  bnez       $a0, .L8004A6E4
    /* 3AC8C 8004A48C 01004226 */   addiu     $v0, $s2, 0x1
    /* 3AC90 8004A490 94006018 */  blez       $v1, .L8004A6E4
    /* 3AC94 8004A494 00000000 */   nop
  .L8004A498:
    /* 3AC98 8004A498 4C00A3AF */  sw         $v1, 0x4C($sp)
    /* 3AC9C 8004A49C 0000C280 */  lb         $v0, 0x0($a2)
    /* 3ACA0 8004A4A0 7000B097 */  lhu        $s0, 0x70($sp)
    /* 3ACA4 8004A4A4 4800A2AF */  sw         $v0, 0x48($sp)
    /* 3ACA8 8004A4A8 0000A384 */  lh         $v1, 0x0($a1)
    /* 3ACAC 8004A4AC 01000B24 */  addiu      $t3, $zero, 0x1
    /* 3ACB0 8004A4B0 6800ABAF */  sw         $t3, 0x68($sp)
    /* 3ACB4 8004A4B4 80100300 */  sll        $v0, $v1, 2
    /* 3ACB8 8004A4B8 21104300 */  addu       $v0, $v0, $v1
    /* 3ACBC 8004A4BC 40110200 */  sll        $v0, $v0, 5
    /* 3ACC0 8004A4C0 21105E00 */  addu       $v0, $v0, $fp
    /* 3ACC4 8004A4C4 9C00428C */  lw         $v0, 0x9C($v0)
    /* 3ACC8 8004A4C8 08002326 */  addiu      $v1, $s1, 0x8
    /* 3ACCC 8004A4CC 5000A2AF */  sw         $v0, 0x50($sp)
    /* 3ACD0 8004A4D0 2A102302 */  slt        $v0, $s1, $v1
    /* 3ACD4 8004A4D4 4000A88F */  lw         $t0, 0x40($sp)
    /* 3ACD8 8004A4D8 4400A98F */  lw         $t1, 0x44($sp)
    /* 3ACDC 8004A4DC 4800AA8F */  lw         $t2, 0x48($sp)
    /* 3ACE0 8004A4E0 4C00AB8F */  lw         $t3, 0x4C($sp)
    /* 3ACE4 8004A4E4 8C0088AE */  sw         $t0, 0x8C($s4)
    /* 3ACE8 8004A4E8 900089AE */  sw         $t1, 0x90($s4)
    /* 3ACEC 8004A4EC 94008AAE */  sw         $t2, 0x94($s4)
    /* 3ACF0 8004A4F0 98008BAE */  sw         $t3, 0x98($s4)
    /* 3ACF4 8004A4F4 5000A88F */  lw         $t0, 0x50($sp)
    /* 3ACF8 8004A4F8 00000000 */  nop
    /* 3ACFC 8004A4FC 9C0088AE */  sw         $t0, 0x9C($s4)
    /* 3AD00 8004A500 1E004010 */  beqz       $v0, .L8004A57C
    /* 3AD04 8004A504 1000A727 */   addiu     $a3, $sp, 0x10
    /* 3AD08 8004A508 21306000 */  addu       $a2, $v1, $zero
    /* 3AD0C 8004A50C 00141000 */  sll        $v0, $s0, 16
  .L8004A510:
    /* 3AD10 8004A510 03240200 */  sra        $a0, $v0, 16
    /* 3AD14 8004A514 23189100 */  subu       $v1, $a0, $s1
    /* 3AD18 8004A518 80180300 */  sll        $v1, $v1, 2
    /* 3AD1C 8004A51C 80100400 */  sll        $v0, $a0, 2
    /* 3AD20 8004A520 21104400 */  addu       $v0, $v0, $a0
    /* 3AD24 8004A524 80100200 */  sll        $v0, $v0, 2
    /* 3AD28 8004A528 21105600 */  addu       $v0, $v0, $s6
    /* 3AD2C 8004A52C 0C00428C */  lw         $v0, 0xC($v0)
    /* 3AD30 8004A530 2128E300 */  addu       $a1, $a3, $v1
    /* 3AD34 8004A534 0A004014 */  bnez       $v0, .L8004A560
    /* 3AD38 8004A538 0000A2AC */   sw        $v0, 0x0($a1)
    /* 3AD3C 8004A53C 01008324 */  addiu      $v1, $a0, 0x1
    /* 3AD40 8004A540 80100300 */  sll        $v0, $v1, 2
    /* 3AD44 8004A544 21104300 */  addu       $v0, $v0, $v1
    /* 3AD48 8004A548 00190200 */  sll        $v1, $v0, 4
    /* 3AD4C 8004A54C 23186200 */  subu       $v1, $v1, $v0
    /* 3AD50 8004A550 00110300 */  sll        $v0, $v1, 4
    /* 3AD54 8004A554 23104300 */  subu       $v0, $v0, $v1
    /* 3AD58 8004A558 C0110200 */  sll        $v0, $v0, 7
    /* 3AD5C 8004A55C 0000A2AC */  sw         $v0, 0x0($a1)
  .L8004A560:
    /* 3AD60 8004A560 01000226 */  addiu      $v0, $s0, 0x1
    /* 3AD64 8004A564 21804000 */  addu       $s0, $v0, $zero
    /* 3AD68 8004A568 00140200 */  sll        $v0, $v0, 16
    /* 3AD6C 8004A56C 03140200 */  sra        $v0, $v0, 16
    /* 3AD70 8004A570 2A104600 */  slt        $v0, $v0, $a2
    /* 3AD74 8004A574 E6FF4014 */  bnez       $v0, .L8004A510
    /* 3AD78 8004A578 00141000 */   sll       $v0, $s0, 16
  .L8004A57C:
    /* 3AD7C 8004A57C 08000424 */  addiu      $a0, $zero, 0x8
    /* 3AD80 8004A580 1000A527 */  addiu      $a1, $sp, 0x10
    /* 3AD84 8004A584 1A2A010C */  jal        Stattool_nCreateIndex__FiPiPs
    /* 3AD88 8004A588 3000A627 */   addiu     $a2, $sp, 0x30
    /* 3AD8C 8004A58C 21800000 */  addu       $s0, $zero, $zero
    /* 3AD90 8004A590 07000324 */  addiu      $v1, $zero, 0x7
    /* 3AD94 8004A594 00141000 */  sll        $v0, $s0, 16
  .L8004A598:
    /* 3AD98 8004A598 C3130200 */  sra        $v0, $v0, 15
    /* 3AD9C 8004A59C 21106202 */  addu       $v0, $s3, $v0
    /* 3ADA0 8004A5A0 00004284 */  lh         $v0, 0x0($v0)
    /* 3ADA4 8004A5A4 00000000 */  nop
    /* 3ADA8 8004A5A8 03004314 */  bne        $v0, $v1, .L8004A5B8
    /* 3ADAC 8004A5AC 01000226 */   addiu     $v0, $s0, 0x1
    /* 3ADB0 8004A5B0 01000826 */  addiu      $t0, $s0, 0x1
    /* 3ADB4 8004A5B4 7800A8A7 */  sh         $t0, 0x78($sp)
  .L8004A5B8:
    /* 3ADB8 8004A5B8 21804000 */  addu       $s0, $v0, $zero
    /* 3ADBC 8004A5BC 00140200 */  sll        $v0, $v0, 16
    /* 3ADC0 8004A5C0 03140200 */  sra        $v0, $v0, 16
    /* 3ADC4 8004A5C4 08004228 */  slti       $v0, $v0, 0x8
    /* 3ADC8 8004A5C8 F3FF4014 */  bnez       $v0, .L8004A598
    /* 3ADCC 8004A5CC 00141000 */   sll       $v0, $s0, 16
    /* 3ADD0 8004A5D0 21800000 */  addu       $s0, $zero, $zero
    /* 3ADD4 8004A5D4 00141200 */  sll        $v0, $s2, 16
    /* 3ADD8 8004A5D8 C3130200 */  sra        $v0, $v0, 15
    /* 3ADDC 8004A5DC 21105500 */  addu       $v0, $v0, $s5
    /* 3ADE0 8004A5E0 00004384 */  lh         $v1, 0x0($v0)
    /* 3ADE4 8004A5E4 00141000 */  sll        $v0, $s0, 16
  .L8004A5E8:
    /* 3ADE8 8004A5E8 C3130200 */  sra        $v0, $v0, 15
    /* 3ADEC 8004A5EC 21106202 */  addu       $v0, $s3, $v0
    /* 3ADF0 8004A5F0 00004284 */  lh         $v0, 0x0($v0)
    /* 3ADF4 8004A5F4 00000000 */  nop
    /* 3ADF8 8004A5F8 79FF4310 */  beq        $v0, $v1, .L8004A3E0
    /* 3ADFC 8004A5FC 80100200 */   sll       $v0, $v0, 2
    /* 3AE00 8004A600 01000226 */  addiu      $v0, $s0, 0x1
    /* 3AE04 8004A604 21804000 */  addu       $s0, $v0, $zero
    /* 3AE08 8004A608 00140200 */  sll        $v0, $v0, 16
    /* 3AE0C 8004A60C 03140200 */  sra        $v0, $v0, 16
    /* 3AE10 8004A610 08004228 */  slti       $v0, $v0, 0x8
    /* 3AE14 8004A614 F4FF4014 */  bnez       $v0, .L8004A5E8
    /* 3AE18 8004A618 00141000 */   sll       $v0, $s0, 16
  .L8004A61C:
    /* 3AE1C 8004A61C 00141200 */  sll        $v0, $s2, 16
    /* 3AE20 8004A620 C3130200 */  sra        $v0, $v0, 15
    /* 3AE24 8004A624 21105500 */  addu       $v0, $v0, $s5
    /* 3AE28 8004A628 00004484 */  lh         $a0, 0x0($v0)
    /* 3AE2C 8004A62C 7FAE000C */  jal        PlayerName__Fi
    /* 3AE30 8004A630 21800000 */   addu      $s0, $zero, $zero
    /* 3AE34 8004A634 4000A427 */  addiu      $a0, $sp, 0x40
    /* 3AE38 8004A638 CA96030C */  jal        strcpy
    /* 3AE3C 8004A63C 21284000 */   addu      $a1, $v0, $zero
    /* 3AE40 8004A640 14000924 */  addiu      $t1, $zero, 0x14
    /* 3AE44 8004A644 8000A48F */  lw         $a0, 0x80($sp)
    /* 3AE48 8004A648 C0300900 */  sll        $a2, $t1, 3
    /* 3AE4C 8004A64C 4000AA8F */  lw         $t2, 0x40($sp)
    /* 3AE50 8004A650 4400AB8F */  lw         $t3, 0x44($sp)
    /* 3AE54 8004A654 4800A88F */  lw         $t0, 0x48($sp)
    /* 3AE58 8004A658 4C00A98F */  lw         $t1, 0x4C($sp)
    /* 3AE5C 8004A65C 8C008AAE */  sw         $t2, 0x8C($s4)
    /* 3AE60 8004A660 90008BAE */  sw         $t3, 0x90($s4)
    /* 3AE64 8004A664 940088AE */  sw         $t0, 0x94($s4)
    /* 3AE68 8004A668 980089AE */  sw         $t1, 0x98($s4)
    /* 3AE6C 8004A66C 5000AA8F */  lw         $t2, 0x50($sp)
    /* 3AE70 8004A670 00000000 */  nop
    /* 3AE74 8004A674 9C008AAE */  sw         $t2, 0x9C($s4)
    /* 3AE78 8004A678 B1AA030C */  jal        memcpy
    /* 3AE7C 8004A67C 21288002 */   addu      $a1, $s4, $zero
    /* 3AE80 8004A680 001C1000 */  sll        $v1, $s0, 16
  .L8004A684:
    /* 3AE84 8004A684 031C0300 */  sra        $v1, $v1, 16
    /* 3AE88 8004A688 40100300 */  sll        $v0, $v1, 1
    /* 3AE8C 8004A68C 21106202 */  addu       $v0, $s3, $v0
    /* 3AE90 8004A690 00004284 */  lh         $v0, 0x0($v0)
    /* 3AE94 8004A694 14000824 */  addiu      $t0, $zero, 0x14
    /* 3AE98 8004A698 18004800 */  mult       $v0, $t0
    /* 3AE9C 8004A69C 21182302 */  addu       $v1, $s1, $v1
    /* 3AEA0 8004A6A0 80200300 */  sll        $a0, $v1, 2
    /* 3AEA4 8004A6A4 21208300 */  addu       $a0, $a0, $v1
    /* 3AEA8 8004A6A8 80200400 */  sll        $a0, $a0, 2
    /* 3AEAC 8004A6AC 21209600 */  addu       $a0, $a0, $s6
    /* 3AEB0 8004A6B0 21300001 */  addu       $a2, $t0, $zero
    /* 3AEB4 8004A6B4 8000A98F */  lw         $t1, 0x80($sp)
    /* 3AEB8 8004A6B8 12500000 */  mflo       $t2
    /* 3AEBC 8004A6BC B1AA030C */  jal        memcpy
    /* 3AEC0 8004A6C0 21282A01 */   addu      $a1, $t1, $t2
    /* 3AEC4 8004A6C4 01000226 */  addiu      $v0, $s0, 0x1
    /* 3AEC8 8004A6C8 21804000 */  addu       $s0, $v0, $zero
    /* 3AECC 8004A6CC 00140200 */  sll        $v0, $v0, 16
    /* 3AED0 8004A6D0 03140200 */  sra        $v0, $v0, 16
    /* 3AED4 8004A6D4 08004228 */  slti       $v0, $v0, 0x8
    /* 3AED8 8004A6D8 EAFF4014 */  bnez       $v0, .L8004A684
    /* 3AEDC 8004A6DC 001C1000 */   sll       $v1, $s0, 16
    /* 3AEE0 8004A6E0 01004226 */  addiu      $v0, $s2, 0x1
  .L8004A6E4:
    /* 3AEE4 8004A6E4 21904000 */  addu       $s2, $v0, $zero
    /* 3AEE8 8004A6E8 6000AB97 */  lhu        $t3, 0x60($sp)
    /* 3AEEC 8004A6EC 00140200 */  sll        $v0, $v0, 16
    /* 3AEF0 8004A6F0 001C0B00 */  sll        $v1, $t3, 16
    /* 3AEF4 8004A6F4 2A104300 */  slt        $v0, $v0, $v1
    /* 3AEF8 8004A6F8 1AFF4014 */  bnez       $v0, .L8004A364
    /* 3AEFC 8004A6FC 00141200 */   sll       $v0, $s2, 16
  .L8004A700:
    /* 3AF00 8004A700 6800A88F */  lw         $t0, 0x68($sp)
    /* 3AF04 8004A704 01000224 */  addiu      $v0, $zero, 0x1
    /* 3AF08 8004A708 10000215 */  bne        $t0, $v0, .L8004A74C
    /* 3AF0C 8004A70C 00000000 */   nop
    /* 3AF10 8004A710 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 3AF14 8004A714 00000000 */   nop
    /* 3AF18 8004A718 2120C002 */  addu       $a0, $s6, $zero
    /* 3AF1C 8004A71C 00140200 */  sll        $v0, $v0, 16
    /* 3AF20 8004A720 03140200 */  sra        $v0, $v0, 16
    /* 3AF24 8004A724 80180200 */  sll        $v1, $v0, 2
    /* 3AF28 8004A728 21186200 */  addu       $v1, $v1, $v0
    /* 3AF2C 8004A72C 00110300 */  sll        $v0, $v1, 4
    /* 3AF30 8004A730 21186200 */  addu       $v1, $v1, $v0
    /* 3AF34 8004A734 80180300 */  sll        $v1, $v1, 2
    /* 3AF38 8004A738 1180053C */  lui        $a1, %hi(Stats_gTrackRecords)
    /* 3AF3C 8004A73C 944DA524 */  addiu      $a1, $a1, %lo(Stats_gTrackRecords)
    /* 3AF40 8004A740 21286500 */  addu       $a1, $v1, $a1
    /* 3AF44 8004A744 B798030C */  jal        blockmove
    /* 3AF48 8004A748 54010624 */   addiu     $a2, $zero, 0x154
  .L8004A74C:
    /* 3AF4C 8004A74C 5800A38F */  lw         $v1, 0x58($sp)
    /* 3AF50 8004A750 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 3AF54 8004A754 00000000 */  nop
    /* 3AF58 8004A758 04006214 */  bne        $v1, $v0, .L8004A76C
    /* 3AF5C 8004A75C 00000000 */   nop
    /* 3AF60 8004A760 01006224 */  addiu      $v0, $v1, 0x1
    /* 3AF64 8004A764 E0290108 */  j          .L8004A780
    /* 3AF68 8004A768 5C00A2AF */   sw        $v0, 0x5C($sp)
  .L8004A76C:
    /* 3AF6C 8004A76C 04004010 */  beqz       $v0, .L8004A780
    /* 3AF70 8004A770 2A104300 */   slt       $v0, $v0, $v1
    /* 3AF74 8004A774 02004010 */  beqz       $v0, .L8004A780
    /* 3AF78 8004A778 01006224 */   addiu     $v0, $v1, 0x1
    /* 3AF7C 8004A77C 5800A2AF */  sw         $v0, 0x58($sp)
  .L8004A780:
    /* 3AF80 8004A780 21800000 */  addu       $s0, $zero, $zero
    /* 3AF84 8004A784 5800A427 */  addiu      $a0, $sp, 0x58
    /* 3AF88 8004A788 0580023C */  lui        $v0, %hi(NewRecords)
    /* 3AF8C 8004A78C 78294624 */  addiu      $a2, $v0, %lo(NewRecords)
    /* 3AF90 8004A790 01000524 */  addiu      $a1, $zero, 0x1
    /* 3AF94 8004A794 00141000 */  sll        $v0, $s0, 16
  .L8004A798:
    /* 3AF98 8004A798 83130200 */  sra        $v0, $v0, 14
    /* 3AF9C 8004A79C 21108200 */  addu       $v0, $a0, $v0
    /* 3AFA0 8004A7A0 0000438C */  lw         $v1, 0x0($v0)
    /* 3AFA4 8004A7A4 00000000 */  nop
    /* 3AFA8 8004A7A8 06006010 */  beqz       $v1, .L8004A7C4
    /* 3AFAC 8004A7AC 09006228 */   slti      $v0, $v1, 0x9
    /* 3AFB0 8004A7B0 04004010 */  beqz       $v0, .L8004A7C4
    /* 3AFB4 8004A7B4 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* 3AFB8 8004A7B8 80100200 */  sll        $v0, $v0, 2
    /* 3AFBC 8004A7BC 21104600 */  addu       $v0, $v0, $a2
    /* 3AFC0 8004A7C0 000045AC */  sw         $a1, 0x0($v0)
  .L8004A7C4:
    /* 3AFC4 8004A7C4 01000226 */  addiu      $v0, $s0, 0x1
    /* 3AFC8 8004A7C8 21804000 */  addu       $s0, $v0, $zero
    /* 3AFCC 8004A7CC 00140200 */  sll        $v0, $v0, 16
    /* 3AFD0 8004A7D0 03140200 */  sra        $v0, $v0, 16
    /* 3AFD4 8004A7D4 02004228 */  slti       $v0, $v0, 0x2
    /* 3AFD8 8004A7D8 EFFF4014 */  bnez       $v0, .L8004A798
    /* 3AFDC 8004A7DC 00141000 */   sll       $v0, $s0, 16
    /* 3AFE0 8004A7E0 8000A48F */  lw         $a0, 0x80($sp)
    /* 3AFE4 8004A7E4 5095030C */  jal        purgememadr
    /* 3AFE8 8004A7E8 00000000 */   nop
    /* 3AFEC 8004A7EC 5095030C */  jal        purgememadr
    /* 3AFF0 8004A7F0 2120C002 */   addu      $a0, $s6, $zero
    /* 3AFF4 8004A7F4 8400A48F */  lw         $a0, 0x84($sp)
    /* 3AFF8 8004A7F8 5095030C */  jal        purgememadr
    /* 3AFFC 8004A7FC 00000000 */   nop
    /* 3B000 8004A800 5095030C */  jal        purgememadr
    /* 3B004 8004A804 2120A002 */   addu      $a0, $s5, $zero
    /* 3B008 8004A808 AC00BF8F */  lw         $ra, 0xAC($sp)
    /* 3B00C 8004A80C A800BE8F */  lw         $fp, 0xA8($sp)
    /* 3B010 8004A810 A400B78F */  lw         $s7, 0xA4($sp)
    /* 3B014 8004A814 A000B68F */  lw         $s6, 0xA0($sp)
    /* 3B018 8004A818 9C00B58F */  lw         $s5, 0x9C($sp)
    /* 3B01C 8004A81C 9800B48F */  lw         $s4, 0x98($sp)
    /* 3B020 8004A820 9400B38F */  lw         $s3, 0x94($sp)
    /* 3B024 8004A824 9000B28F */  lw         $s2, 0x90($sp)
    /* 3B028 8004A828 8C00B18F */  lw         $s1, 0x8C($sp)
    /* 3B02C 8004A82C 8800B08F */  lw         $s0, 0x88($sp)
    /* 3B030 8004A830 0800E003 */  jr         $ra
    /* 3B034 8004A834 B000BD27 */   addiu     $sp, $sp, 0xB0
endlabel StatChk_SaveTopTime__FP10Car_tStatss
