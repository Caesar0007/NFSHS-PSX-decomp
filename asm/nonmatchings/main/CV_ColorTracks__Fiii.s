.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CV_ColorTracks__Fiii, 0x208

glabel CV_ColorTracks__Fiii
    /* D1B08 800E1308 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D1B0C 800E130C 2000B2AF */  sw         $s2, 0x20($sp)
    /* D1B10 800E1310 21908000 */  addu       $s2, $a0, $zero
    /* D1B14 800E1314 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D1B18 800E1318 2188A000 */  addu       $s1, $a1, $zero
    /* D1B1C 800E131C 2400B3AF */  sw         $s3, 0x24($sp)
    /* D1B20 800E1320 2198C000 */  addu       $s3, $a2, $zero
    /* D1B24 800E1324 1800B0AF */  sw         $s0, 0x18($sp)
    /* D1B28 800E1328 21800000 */  addu       $s0, $zero, $zero
    /* D1B2C 800E132C 1000A427 */  addiu      $a0, $sp, 0x10
    /* D1B30 800E1330 21280002 */  addu       $a1, $s0, $zero
    /* D1B34 800E1334 2800BFAF */  sw         $ra, 0x28($sp)
    /* D1B38 800E1338 C690030C */  jal        memset
    /* D1B3C 800E133C 04000624 */   addiu     $a2, $zero, 0x4
    /* D1B40 800E1340 1180023C */  lui        $v0, %hi(D_801131F8)
    /* D1B44 800E1344 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* D1B48 800E1348 01000324 */  addiu      $v1, $zero, 0x1
    /* D1B4C 800E134C 5D004314 */  bne        $v0, $v1, .L800E14C4
    /* D1B50 800E1350 21300002 */   addu      $a2, $s0, $zero
    /* D1B54 800E1354 02000224 */  addiu      $v0, $zero, 0x2
    /* D1B58 800E1358 09004216 */  bne        $s2, $v0, .L800E1380
    /* D1B5C 800E135C 03000224 */   addiu     $v0, $zero, 0x3
    /* D1B60 800E1360 07002316 */  bne        $s1, $v1, .L800E1380
    /* D1B64 800E1364 00000000 */   nop
    /* D1B68 800E1368 05006316 */  bne        $s3, $v1, .L800E1380
    /* D1B6C 800E136C 00000000 */   nop
    /* D1B70 800E1370 FFFF103C */  lui        $s0, (0xFFFF6380 >> 16)
    /* D1B74 800E1374 80631036 */  ori        $s0, $s0, (0xFFFF6380 & 0xFFFF)
    /* D1B78 800E1378 08850308 */  j          .L800E1420
    /* D1B7C 800E137C 10000224 */   addiu     $v0, $zero, 0x10
  .L800E1380:
    /* D1B80 800E1380 15004216 */  bne        $s2, $v0, .L800E13D8
    /* D1B84 800E1384 04000224 */   addiu     $v0, $zero, 0x4
    /* D1B88 800E1388 07002016 */  bnez       $s1, .L800E13A8
    /* D1B8C 800E138C 03000224 */   addiu     $v0, $zero, 0x3
    /* D1B90 800E1390 01000224 */  addiu      $v0, $zero, 0x1
    /* D1B94 800E1394 04006216 */  bne        $s3, $v0, .L800E13A8
    /* D1B98 800E1398 03000224 */   addiu     $v0, $zero, 0x3
    /* D1B9C 800E139C FFFF103C */  lui        $s0, (0xFFFF0C00 >> 16)
    /* D1BA0 800E13A0 3A850308 */  j          .L800E14E8
    /* D1BA4 800E13A4 000C1036 */   ori       $s0, $s0, (0xFFFF0C00 & 0xFFFF)
  .L800E13A8:
    /* D1BA8 800E13A8 0B004216 */  bne        $s2, $v0, .L800E13D8
    /* D1BAC 800E13AC 04000224 */   addiu     $v0, $zero, 0x4
    /* D1BB0 800E13B0 01000224 */  addiu      $v0, $zero, 0x1
    /* D1BB4 800E13B4 08002216 */  bne        $s1, $v0, .L800E13D8
    /* D1BB8 800E13B8 04000224 */   addiu     $v0, $zero, 0x4
    /* D1BBC 800E13BC 06007116 */  bne        $s3, $s1, .L800E13D8
    /* D1BC0 800E13C0 00000000 */   nop
    /* D1BC4 800E13C4 008C1024 */  addiu      $s0, $zero, -0x7400
    /* D1BC8 800E13C8 10000224 */  addiu      $v0, $zero, 0x10
    /* D1BCC 800E13CC 1000A2AF */  sw         $v0, 0x10($sp)
    /* D1BD0 800E13D0 3A850308 */  j          .L800E14E8
    /* D1BD4 800E13D4 10000624 */   addiu     $a2, $zero, 0x10
  .L800E13D8:
    /* D1BD8 800E13D8 14004216 */  bne        $s2, $v0, .L800E142C
    /* D1BDC 800E13DC 06000224 */   addiu     $v0, $zero, 0x6
    /* D1BE0 800E13E0 06002016 */  bnez       $s1, .L800E13FC
    /* D1BE4 800E13E4 04000224 */   addiu     $v0, $zero, 0x4
    /* D1BE8 800E13E8 01000224 */  addiu      $v0, $zero, 0x1
    /* D1BEC 800E13EC 03006216 */  bne        $s3, $v0, .L800E13FC
    /* D1BF0 800E13F0 04000224 */   addiu     $v0, $zero, 0x4
    /* D1BF4 800E13F4 3A850308 */  j          .L800E14E8
    /* D1BF8 800E13F8 00881024 */   addiu     $s0, $zero, -0x7800
  .L800E13FC:
    /* D1BFC 800E13FC 0B004216 */  bne        $s2, $v0, .L800E142C
    /* D1C00 800E1400 06000224 */   addiu     $v0, $zero, 0x6
    /* D1C04 800E1404 01000224 */  addiu      $v0, $zero, 0x1
    /* D1C08 800E1408 08002216 */  bne        $s1, $v0, .L800E142C
    /* D1C0C 800E140C 06000224 */   addiu     $v0, $zero, 0x6
    /* D1C10 800E1410 06007116 */  bne        $s3, $s1, .L800E142C
    /* D1C14 800E1414 00000000 */   nop
    /* D1C18 800E1418 FFFF103C */  lui        $s0, (0xFFFF0000 >> 16)
    /* D1C1C 800E141C 18000224 */  addiu      $v0, $zero, 0x18
  .L800E1420:
    /* D1C20 800E1420 1100A2A3 */  sb         $v0, 0x11($sp)
    /* D1C24 800E1424 3A850308 */  j          .L800E14E8
    /* D1C28 800E1428 10000624 */   addiu     $a2, $zero, 0x10
  .L800E142C:
    /* D1C2C 800E142C 0A004216 */  bne        $s2, $v0, .L800E1458
    /* D1C30 800E1430 07000224 */   addiu     $v0, $zero, 0x7
    /* D1C34 800E1434 08002016 */  bnez       $s1, .L800E1458
    /* D1C38 800E1438 00000000 */   nop
    /* D1C3C 800E143C 01000224 */  addiu      $v0, $zero, 0x1
    /* D1C40 800E1440 05006216 */  bne        $s3, $v0, .L800E1458
    /* D1C44 800E1444 07000224 */   addiu     $v0, $zero, 0x7
    /* D1C48 800E1448 FFFF103C */  lui        $s0, (0xFFFF69F0 >> 16)
    /* D1C4C 800E144C F0691036 */  ori        $s0, $s0, (0xFFFF69F0 & 0xFFFF)
    /* D1C50 800E1450 3A850308 */  j          .L800E14E8
    /* D1C54 800E1454 31000624 */   addiu     $a2, $zero, 0x31
  .L800E1458:
    /* D1C58 800E1458 0A004216 */  bne        $s2, $v0, .L800E1484
    /* D1C5C 800E145C 08000224 */   addiu     $v0, $zero, 0x8
    /* D1C60 800E1460 08002016 */  bnez       $s1, .L800E1484
    /* D1C64 800E1464 00000000 */   nop
    /* D1C68 800E1468 01000224 */  addiu      $v0, $zero, 0x1
    /* D1C6C 800E146C 05006216 */  bne        $s3, $v0, .L800E1484
    /* D1C70 800E1470 08000224 */   addiu     $v0, $zero, 0x8
    /* D1C74 800E1474 FFFF103C */  lui        $s0, (0xFFFF4C00 >> 16)
    /* D1C78 800E1478 004C1036 */  ori        $s0, $s0, (0xFFFF4C00 & 0xFFFF)
    /* D1C7C 800E147C 3A850308 */  j          .L800E14E8
    /* D1C80 800E1480 14000624 */   addiu     $a2, $zero, 0x14
  .L800E1484:
    /* D1C84 800E1484 06004216 */  bne        $s2, $v0, .L800E14A0
    /* D1C88 800E1488 0A000224 */   addiu     $v0, $zero, 0xA
    /* D1C8C 800E148C 04002016 */  bnez       $s1, .L800E14A0
    /* D1C90 800E1490 00000000 */   nop
    /* D1C94 800E1494 01000224 */  addiu      $v0, $zero, 0x1
    /* D1C98 800E1498 11006212 */  beq        $s3, $v0, .L800E14E0
    /* D1C9C 800E149C 0A000224 */   addiu     $v0, $zero, 0xA
  .L800E14A0:
    /* D1CA0 800E14A0 12004216 */  bne        $s2, $v0, .L800E14EC
    /* D1CA4 800E14A4 21200002 */   addu      $a0, $s0, $zero
    /* D1CA8 800E14A8 01000224 */  addiu      $v0, $zero, 0x1
    /* D1CAC 800E14AC 0F002216 */  bne        $s1, $v0, .L800E14EC
    /* D1CB0 800E14B0 00000000 */   nop
    /* D1CB4 800E14B4 0D007116 */  bne        $s3, $s1, .L800E14EC
    /* D1CB8 800E14B8 00AC1024 */   addiu     $s0, $zero, -0x5400
    /* D1CBC 800E14BC 3B850308 */  j          .L800E14EC
    /* D1CC0 800E14C0 21200002 */   addu      $a0, $s0, $zero
  .L800E14C4:
    /* D1CC4 800E14C4 08000224 */  addiu      $v0, $zero, 0x8
    /* D1CC8 800E14C8 08004216 */  bne        $s2, $v0, .L800E14EC
    /* D1CCC 800E14CC 21200002 */   addu      $a0, $s0, $zero
    /* D1CD0 800E14D0 06002016 */  bnez       $s1, .L800E14EC
    /* D1CD4 800E14D4 00000000 */   nop
    /* D1CD8 800E14D8 04006316 */  bne        $s3, $v1, .L800E14EC
    /* D1CDC 800E14DC 00000000 */   nop
  .L800E14E0:
    /* D1CE0 800E14E0 00681024 */  addiu      $s0, $zero, 0x6800
    /* D1CE4 800E14E4 16000624 */  addiu      $a2, $zero, 0x16
  .L800E14E8:
    /* D1CE8 800E14E8 21200002 */  addu       $a0, $s0, $zero
  .L800E14EC:
    /* D1CEC 800E14EC 5284030C */  jal        CV_ProcessWorldColors_FINAL__FiP7CVECTORs
    /* D1CF0 800E14F0 1000A527 */   addiu     $a1, $sp, 0x10
    /* D1CF4 800E14F4 2800BF8F */  lw         $ra, 0x28($sp)
    /* D1CF8 800E14F8 2400B38F */  lw         $s3, 0x24($sp)
    /* D1CFC 800E14FC 2000B28F */  lw         $s2, 0x20($sp)
    /* D1D00 800E1500 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D1D04 800E1504 1800B08F */  lw         $s0, 0x18($sp)
    /* D1D08 800E1508 0800E003 */  jr         $ra
    /* D1D0C 800E150C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CV_ColorTracks__Fiii
