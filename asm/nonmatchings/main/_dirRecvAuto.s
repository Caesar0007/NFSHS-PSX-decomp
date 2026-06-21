.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _dirRecvAuto, 0x250

glabel _dirRecvAuto
    /* FA9E4 8010A1E4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FA9E8 8010A1E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* FA9EC 8010A1EC 21808000 */  addu       $s0, $a0, $zero
    /* FA9F0 8010A1F0 1800BFAF */  sw         $ra, 0x18($sp)
    /* FA9F4 8010A1F4 1400B1AF */  sw         $s1, 0x14($sp)
    /* FA9F8 8010A1F8 3C00028E */  lw         $v0, 0x3C($s0)
    /* FA9FC 8010A1FC 0F000324 */  addiu      $v1, $zero, 0xF
    /* FAA00 8010A200 00004290 */  lbu        $v0, 0x0($v0)
    /* FAA04 8010A204 E8001192 */  lbu        $s1, 0xE8($s0)
    /* FAA08 8010A208 02110200 */  srl        $v0, $v0, 4
    /* FAA0C 8010A20C 03004314 */  bne        $v0, $v1, .L8010A21C
    /* FAA10 8010A210 E80002A2 */   sb        $v0, 0xE8($s0)
    /* FAA14 8010A214 9F280408 */  j          .L8010A27C
    /* FAA18 8010A218 E80011A2 */   sb        $s1, 0xE8($s0)
  .L8010A21C:
    /* FAA1C 8010A21C 3000028E */  lw         $v0, 0x30($s0)
    /* FAA20 8010A220 00000000 */  nop
    /* FAA24 8010A224 000040A0 */  sb         $zero, 0x0($v0)
    /* FAA28 8010A228 3C00028E */  lw         $v0, 0x3C($s0)
    /* FAA2C 8010A22C 3000038E */  lw         $v1, 0x30($s0)
    /* FAA30 8010A230 00004290 */  lbu        $v0, 0x0($v0)
    /* FAA34 8010A234 00000000 */  nop
    /* FAA38 8010A238 010062A0 */  sb         $v0, 0x1($v1)
    /* FAA3C 8010A23C 44000292 */  lbu        $v0, 0x44($s0)
    /* FAA40 8010A240 02000424 */  addiu      $a0, $zero, 0x2
    /* FAA44 8010A244 2A108200 */  slt        $v0, $a0, $v0
    /* FAA48 8010A248 0C004010 */  beqz       $v0, .L8010A27C
    /* FAA4C 8010A24C 00000000 */   nop
  .L8010A250:
    /* FAA50 8010A250 3C00028E */  lw         $v0, 0x3C($s0)
    /* FAA54 8010A254 3000038E */  lw         $v1, 0x30($s0)
    /* FAA58 8010A258 21104400 */  addu       $v0, $v0, $a0
    /* FAA5C 8010A25C 00004290 */  lbu        $v0, 0x0($v0)
    /* FAA60 8010A260 21186400 */  addu       $v1, $v1, $a0
    /* FAA64 8010A264 000062A0 */  sb         $v0, 0x0($v1)
    /* FAA68 8010A268 44000292 */  lbu        $v0, 0x44($s0)
    /* FAA6C 8010A26C 01008424 */  addiu      $a0, $a0, 0x1
    /* FAA70 8010A270 2A108200 */  slt        $v0, $a0, $v0
    /* FAA74 8010A274 F6FF4014 */  bnez       $v0, .L8010A250
    /* FAA78 8010A278 00000000 */   nop
  .L8010A27C:
    /* FAA7C 8010A27C 3C00028E */  lw         $v0, 0x3C($s0)
    /* FAA80 8010A280 00000000 */  nop
    /* FAA84 8010A284 01004290 */  lbu        $v0, 0x1($v0)
    /* FAA88 8010A288 00000000 */  nop
    /* FAA8C 8010A28C 0D004014 */  bnez       $v0, .L8010A2C4
    /* FAA90 8010A290 01000224 */   addiu     $v0, $zero, 0x1
    /* FAA94 8010A294 46000392 */  lbu        $v1, 0x46($s0)
    /* FAA98 8010A298 00000000 */  nop
    /* FAA9C 8010A29C 05006214 */  bne        $v1, $v0, .L8010A2B4
    /* FAAA0 8010A2A0 00000000 */   nop
    /* FAAA4 8010A2A4 1400028E */  lw         $v0, 0x14($s0)
    /* FAAA8 8010A2A8 00000000 */  nop
    /* FAAAC 8010A2AC 05004010 */  beqz       $v0, .L8010A2C4
    /* FAAB0 8010A2B0 00000000 */   nop
  .L8010A2B4:
    /* FAAB4 8010A2B4 50000292 */  lbu        $v0, 0x50($s0)
    /* FAAB8 8010A2B8 00000000 */  nop
    /* FAABC 8010A2BC 11004010 */  beqz       $v0, .L8010A304
    /* FAAC0 8010A2C0 00000000 */   nop
  .L8010A2C4:
    /* FAAC4 8010A2C4 4429040C */  jal        _dirCheck
    /* FAAC8 8010A2C8 21200002 */   addu      $a0, $s0, $zero
    /* FAACC 8010A2CC 12004014 */  bnez       $v0, .L8010A318
    /* FAAD0 8010A2D0 00000000 */   nop
    /* FAAD4 8010A2D4 37000292 */  lbu        $v0, 0x37($s0)
    /* FAAD8 8010A2D8 00000000 */  nop
    /* FAADC 8010A2DC 0E004014 */  bnez       $v0, .L8010A318
    /* FAAE0 8010A2E0 00000000 */   nop
    /* FAAE4 8010A2E4 4A000292 */  lbu        $v0, 0x4A($s0)
    /* FAAE8 8010A2E8 00000000 */  nop
    /* FAAEC 8010A2EC 0A004014 */  bnez       $v0, .L8010A318
    /* FAAF0 8010A2F0 00000000 */   nop
    /* FAAF4 8010A2F4 E8000292 */  lbu        $v0, 0xE8($s0)
    /* FAAF8 8010A2F8 00000000 */  nop
    /* FAAFC 8010A2FC 06005110 */  beq        $v0, $s1, .L8010A318
    /* FAB00 8010A300 00000000 */   nop
  .L8010A304:
    /* FAB04 8010A304 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* FAB08 8010A308 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* FAB0C 8010A30C 00000000 */  nop
    /* FAB10 8010A310 09F84000 */  jalr       $v0
    /* FAB14 8010A314 21200002 */   addu      $a0, $s0, $zero
  .L8010A318:
    /* FAB18 8010A318 46000392 */  lbu        $v1, 0x46($s0)
    /* FAB1C 8010A31C FF000224 */  addiu      $v0, $zero, 0xFF
    /* FAB20 8010A320 3F006210 */  beq        $v1, $v0, .L8010A420
    /* FAB24 8010A324 4A0000A2 */   sb        $zero, 0x4A($s0)
    /* FAB28 8010A328 FEFF6224 */  addiu      $v0, $v1, -0x2
    /* FAB2C 8010A32C FF004230 */  andi       $v0, $v0, 0xFF
    /* FAB30 8010A330 FC00422C */  sltiu      $v0, $v0, 0xFC
    /* FAB34 8010A334 0C004010 */  beqz       $v0, .L8010A368
    /* FAB38 8010A338 00000000 */   nop
    /* FAB3C 8010A33C 3C00028E */  lw         $v0, 0x3C($s0)
    /* FAB40 8010A340 00000000 */  nop
    /* FAB44 8010A344 00004390 */  lbu        $v1, 0x0($v0)
    /* FAB48 8010A348 F3000224 */  addiu      $v0, $zero, 0xF3
    /* FAB4C 8010A34C 06006210 */  beq        $v1, $v0, .L8010A368
    /* FAB50 8010A350 00000000 */   nop
    /* FAB54 8010A354 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* FAB58 8010A358 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* FAB5C 8010A35C 00000000 */  nop
    /* FAB60 8010A360 09F84000 */  jalr       $v0
    /* FAB64 8010A364 21200002 */   addu      $a0, $s0, $zero
  .L8010A368:
    /* FAB68 8010A368 46000292 */  lbu        $v0, 0x46($s0)
    /* FAB6C 8010A36C 00000000 */  nop
    /* FAB70 8010A370 05004010 */  beqz       $v0, .L8010A388
    /* FAB74 8010A374 00000000 */   nop
    /* FAB78 8010A378 36000292 */  lbu        $v0, 0x36($s0)
    /* FAB7C 8010A37C 00000000 */  nop
    /* FAB80 8010A380 27004010 */  beqz       $v0, .L8010A420
    /* FAB84 8010A384 00000000 */   nop
  .L8010A388:
    /* FAB88 8010A388 46000392 */  lbu        $v1, 0x46($s0)
    /* FAB8C 8010A38C 01000424 */  addiu      $a0, $zero, 0x1
    /* FAB90 8010A390 0E006410 */  beq        $v1, $a0, .L8010A3CC
    /* FAB94 8010A394 02006228 */   slti      $v0, $v1, 0x2
    /* FAB98 8010A398 05004010 */  beqz       $v0, .L8010A3B0
    /* FAB9C 8010A39C FE000224 */   addiu     $v0, $zero, 0xFE
    /* FABA0 8010A3A0 07006010 */  beqz       $v1, .L8010A3C0
    /* FABA4 8010A3A4 00000000 */   nop
    /* FABA8 8010A3A8 FA280408 */  j          .L8010A3E8
    /* FABAC 8010A3AC 00000000 */   nop
  .L8010A3B0:
    /* FABB0 8010A3B0 0B006210 */  beq        $v1, $v0, .L8010A3E0
    /* FABB4 8010A3B4 FF000224 */   addiu     $v0, $zero, 0xFF
    /* FABB8 8010A3B8 FA280408 */  j          .L8010A3E8
    /* FABBC 8010A3BC 00000000 */   nop
  .L8010A3C0:
    /* FABC0 8010A3C0 46000292 */  lbu        $v0, 0x46($s0)
    /* FABC4 8010A3C4 F5280408 */  j          .L8010A3D4
    /* FABC8 8010A3C8 490004A2 */   sb        $a0, 0x49($s0)
  .L8010A3CC:
    /* FABCC 8010A3CC 46000292 */  lbu        $v0, 0x46($s0)
    /* FABD0 8010A3D0 470000A2 */  sb         $zero, 0x47($s0)
  .L8010A3D4:
    /* FABD4 8010A3D4 01004224 */  addiu      $v0, $v0, 0x1
    /* FABD8 8010A3D8 08290408 */  j          .L8010A420
    /* FABDC 8010A3DC 460002A2 */   sb        $v0, 0x46($s0)
  .L8010A3E0:
    /* FABE0 8010A3E0 08290408 */  j          .L8010A420
    /* FABE4 8010A3E4 460002A2 */   sb        $v0, 0x46($s0)
  .L8010A3E8:
    /* FABE8 8010A3E8 1800028E */  lw         $v0, 0x18($s0)
    /* FABEC 8010A3EC 00000000 */  nop
    /* FABF0 8010A3F0 05004010 */  beqz       $v0, .L8010A408
    /* FABF4 8010A3F4 00000000 */   nop
    /* FABF8 8010A3F8 09F84000 */  jalr       $v0
    /* FABFC 8010A3FC 21200002 */   addu      $a0, $s0, $zero
    /* FAC00 8010A400 04290408 */  j          .L8010A410
    /* FAC04 8010A404 00000000 */   nop
  .L8010A408:
    /* FAC08 8010A408 A015040C */  jal        _padRecvAtLoadInfo
    /* FAC0C 8010A40C 21200002 */   addu      $a0, $s0, $zero
  .L8010A410:
    /* FAC10 8010A410 46000392 */  lbu        $v1, 0x46($s0)
    /* FAC14 8010A414 00000000 */  nop
    /* FAC18 8010A418 21186200 */  addu       $v1, $v1, $v0
    /* FAC1C 8010A41C 460003A2 */  sb         $v1, 0x46($s0)
  .L8010A420:
    /* FAC20 8010A420 1800BF8F */  lw         $ra, 0x18($sp)
    /* FAC24 8010A424 1400B18F */  lw         $s1, 0x14($sp)
    /* FAC28 8010A428 1000B08F */  lw         $s0, 0x10($sp)
    /* FAC2C 8010A42C 0800E003 */  jr         $ra
    /* FAC30 8010A430 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _dirRecvAuto
