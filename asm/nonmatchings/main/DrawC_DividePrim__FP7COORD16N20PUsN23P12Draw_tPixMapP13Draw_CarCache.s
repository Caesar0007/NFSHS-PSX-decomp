.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache, 0x264

glabel DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
    /* B1AF8 800C12F8 1C00A88F */  lw         $t0, 0x1C($sp)
    /* B1AFC 800C12FC 00000000 */  nop
    /* B1B00 800C1300 0400028D */  lw         $v0, 0x4($t0)
    /* B1B04 800C1304 0800038D */  lw         $v1, 0x8($t0)
    /* B1B08 800C1308 1800AA8F */  lw         $t2, 0x18($sp)
    /* B1B0C 800C130C 2B104300 */  sltu       $v0, $v0, $v1
    /* B1B10 800C1310 90004010 */  beqz       $v0, .L800C1554
    /* B1B14 800C1314 00000000 */   nop
    /* B1B18 800C1318 000080C8 */  lwc2       $0, 0x0($a0)
    /* B1B1C 800C131C 040081C8 */  lwc2       $1, 0x4($a0)
    /* B1B20 800C1320 0000A2C8 */  lwc2       $2, 0x0($a1)
    /* B1B24 800C1324 0400A3C8 */  lwc2       $3, 0x4($a1)
    /* B1B28 800C1328 0000C4C8 */  lwc2       $4, 0x0($a2)
    /* B1B2C 800C132C 0400C5C8 */  lwc2       $5, 0x4($a2)
    /* B1B30 800C1330 00000000 */  nop
    /* B1B34 800C1334 00000000 */  nop
    /* B1B38 800C1338 3000284A */  .word 0x4A280030  /* rtpt */
    /* B1B3C 800C133C 00000000 */  nop
    /* B1B40 800C1340 00000000 */  nop
    /* B1B44 800C1344 0600404B */  .word 0x4B400006  /* nclip */
    /* B1B48 800C1348 440018E9 */  swc2       $24, 0x44($t0)
    /* B1B4C 800C134C 0C00028D */  lw         $v0, 0xC($t0)
    /* B1B50 800C1350 4400038D */  lw         $v1, 0x44($t0)
    /* B1B54 800C1354 02004010 */  beqz       $v0, .L800C1360
    /* B1B58 800C1358 00000000 */   nop
    /* B1B5C 800C135C 23180300 */  negu       $v1, $v1
  .L800C1360:
    /* B1B60 800C1360 7C006018 */  blez       $v1, .L800C1554
    /* B1B64 800C1364 00000000 */   nop
    /* B1B68 800C1368 C4000CE9 */  swc2       $12, 0xC4($t0)
    /* B1B6C 800C136C C8000DE9 */  swc2       $13, 0xC8($t0)
    /* B1B70 800C1370 CC000EE9 */  swc2       $14, 0xCC($t0)
    /* B1B74 800C1374 10000385 */  lh         $v1, 0x10($t0)
    /* B1B78 800C1378 C4000285 */  lh         $v0, 0xC4($t0)
    /* B1B7C 800C137C 12000985 */  lh         $t1, 0x12($t0)
    /* B1B80 800C1380 2A106200 */  slt        $v0, $v1, $v0
    /* B1B84 800C1384 0B004010 */  beqz       $v0, .L800C13B4
    /* B1B88 800C1388 00000000 */   nop
    /* B1B8C 800C138C C8000285 */  lh         $v0, 0xC8($t0)
    /* B1B90 800C1390 00000000 */  nop
    /* B1B94 800C1394 2A106200 */  slt        $v0, $v1, $v0
    /* B1B98 800C1398 06004010 */  beqz       $v0, .L800C13B4
    /* B1B9C 800C139C 00000000 */   nop
    /* B1BA0 800C13A0 CC000285 */  lh         $v0, 0xCC($t0)
    /* B1BA4 800C13A4 00000000 */  nop
    /* B1BA8 800C13A8 2A106200 */  slt        $v0, $v1, $v0
    /* B1BAC 800C13AC 69004014 */  bnez       $v0, .L800C1554
    /* B1BB0 800C13B0 00000000 */   nop
  .L800C13B4:
    /* B1BB4 800C13B4 C4000285 */  lh         $v0, 0xC4($t0)
    /* B1BB8 800C13B8 00000000 */  nop
    /* B1BBC 800C13BC 09004104 */  bgez       $v0, .L800C13E4
    /* B1BC0 800C13C0 00000000 */   nop
    /* B1BC4 800C13C4 C8000285 */  lh         $v0, 0xC8($t0)
    /* B1BC8 800C13C8 00000000 */  nop
    /* B1BCC 800C13CC 05004104 */  bgez       $v0, .L800C13E4
    /* B1BD0 800C13D0 00000000 */   nop
    /* B1BD4 800C13D4 CC000285 */  lh         $v0, 0xCC($t0)
    /* B1BD8 800C13D8 00000000 */  nop
    /* B1BDC 800C13DC 5D004004 */  bltz       $v0, .L800C1554
    /* B1BE0 800C13E0 00000000 */   nop
  .L800C13E4:
    /* B1BE4 800C13E4 C6000285 */  lh         $v0, 0xC6($t0)
    /* B1BE8 800C13E8 00000000 */  nop
    /* B1BEC 800C13EC 2A102201 */  slt        $v0, $t1, $v0
    /* B1BF0 800C13F0 0B004010 */  beqz       $v0, .L800C1420
    /* B1BF4 800C13F4 00000000 */   nop
    /* B1BF8 800C13F8 CA000285 */  lh         $v0, 0xCA($t0)
    /* B1BFC 800C13FC 00000000 */  nop
    /* B1C00 800C1400 2A102201 */  slt        $v0, $t1, $v0
    /* B1C04 800C1404 06004010 */  beqz       $v0, .L800C1420
    /* B1C08 800C1408 00000000 */   nop
    /* B1C0C 800C140C CE000285 */  lh         $v0, 0xCE($t0)
    /* B1C10 800C1410 00000000 */  nop
    /* B1C14 800C1414 2A102201 */  slt        $v0, $t1, $v0
    /* B1C18 800C1418 4E004014 */  bnez       $v0, .L800C1554
    /* B1C1C 800C141C 00000000 */   nop
  .L800C1420:
    /* B1C20 800C1420 C6000285 */  lh         $v0, 0xC6($t0)
    /* B1C24 800C1424 00000000 */  nop
    /* B1C28 800C1428 09004104 */  bgez       $v0, .L800C1450
    /* B1C2C 800C142C 00000000 */   nop
    /* B1C30 800C1430 CA000285 */  lh         $v0, 0xCA($t0)
    /* B1C34 800C1434 00000000 */  nop
    /* B1C38 800C1438 05004104 */  bgez       $v0, .L800C1450
    /* B1C3C 800C143C 00000000 */   nop
    /* B1C40 800C1440 CE000285 */  lh         $v0, 0xCE($t0)
    /* B1C44 800C1444 00000000 */  nop
    /* B1C48 800C1448 42004004 */  bltz       $v0, .L800C1554
    /* B1C4C 800C144C 00000000 */   nop
  .L800C1450:
    /* B1C50 800C1450 04008284 */  lh         $v0, 0x4($a0)
    /* B1C54 800C1454 00000000 */  nop
    /* B1C58 800C1458 09004104 */  bgez       $v0, .L800C1480
    /* B1C5C 800C145C 00000000 */   nop
    /* B1C60 800C1460 0400A284 */  lh         $v0, 0x4($a1)
    /* B1C64 800C1464 00000000 */  nop
    /* B1C68 800C1468 05004104 */  bgez       $v0, .L800C1480
    /* B1C6C 800C146C 00000000 */   nop
    /* B1C70 800C1470 0400C284 */  lh         $v0, 0x4($a2)
    /* B1C74 800C1474 00000000 */  nop
    /* B1C78 800C1478 36004004 */  bltz       $v0, .L800C1554
    /* B1C7C 800C147C 00000000 */   nop
  .L800C1480:
    /* B1C80 800C1480 00000000 */  nop
    /* B1C84 800C1484 00000000 */  nop
    /* B1C88 800C1488 2D00584B */  .word 0x4B58002D  /* avsz3 */
    /* B1C8C 800C148C 3C0007E9 */  swc2       $7, 0x3C($t0)
    /* B1C90 800C1490 3C00038D */  lw         $v1, 0x3C($t0)
    /* B1C94 800C1494 4000028D */  lw         $v0, 0x40($t0)
    /* B1C98 800C1498 00000000 */  nop
    /* B1C9C 800C149C 21186200 */  addu       $v1, $v1, $v0
    /* B1CA0 800C14A0 2C006004 */  bltz       $v1, .L800C1554
    /* B1CA4 800C14A4 3C0003AD */   sw        $v1, 0x3C($t0)
    /* B1CA8 800C14A8 8800028D */  lw         $v0, 0x88($t0)
    /* B1CAC 800C14AC 00000000 */  nop
    /* B1CB0 800C14B0 2A104300 */  slt        $v0, $v0, $v1
    /* B1CB4 800C14B4 27004014 */  bnez       $v0, .L800C1554
    /* B1CB8 800C14B8 00000000 */   nop
    /* B1CBC 800C14BC 0400038D */  lw         $v1, 0x4($t0)
    /* B1CC0 800C14C0 3C000C8D */  lw         $t4, 0x3C($t0)
    /* B1CC4 800C14C4 38000D8D */  lw         $t5, 0x38($t0)
    /* B1CC8 800C14C8 20006E24 */  addiu      $t6, $v1, 0x20
    /* B1CCC 800C14CC 80600C00 */  sll        $t4, $t4, 2
    /* B1CD0 800C14D0 2168AC01 */  addu       $t5, $t5, $t4
    /* B1CD4 800C14D4 04000EAD */  sw         $t6, 0x4($t0)
    /* B1CD8 800C14D8 0200AE89 */  lwl        $t6, 0x2($t5)
    /* B1CDC 800C14DC 00070C3C */  lui        $t4, (0x7000000 >> 16)
    /* B1CE0 800C14E0 02720E00 */  srl        $t6, $t6, 8
    /* B1CE4 800C14E4 2570CC01 */  or         $t6, $t6, $t4
    /* B1CE8 800C14E8 00620300 */  sll        $t4, $v1, 8
    /* B1CEC 800C14EC 00006EAC */  sw         $t6, 0x0($v1)
    /* B1CF0 800C14F0 0200ACA9 */  swl        $t4, 0x2($t5)
    /* B1CF4 800C14F4 C400028D */  lw         $v0, 0xC4($t0)
    /* B1CF8 800C14F8 C800048D */  lw         $a0, 0xC8($t0)
    /* B1CFC 800C14FC CC00058D */  lw         $a1, 0xCC($t0)
    /* B1D00 800C1500 080062AC */  sw         $v0, 0x8($v1)
    /* B1D04 800C1504 100064AC */  sw         $a0, 0x10($v1)
    /* B1D08 800C1508 180065AC */  sw         $a1, 0x18($v1)
    /* B1D0C 800C150C 8C00028D */  lw         $v0, 0x8C($t0)
    /* B1D10 800C1510 00000000 */  nop
    /* B1D14 800C1514 040062AC */  sw         $v0, 0x4($v1)
    /* B1D18 800C1518 24000224 */  addiu      $v0, $zero, 0x24
    /* B1D1C 800C151C 070062A0 */  sb         $v0, 0x7($v1)
    /* B1D20 800C1520 02004295 */  lhu        $v0, 0x2($t2)
    /* B1D24 800C1524 06004495 */  lhu        $a0, 0x6($t2)
    /* B1D28 800C1528 0E0062A4 */  sh         $v0, 0xE($v1)
    /* B1D2C 800C152C 160064A4 */  sh         $a0, 0x16($v1)
    /* B1D30 800C1530 1000A28F */  lw         $v0, 0x10($sp)
    /* B1D34 800C1534 00000000 */  nop
    /* B1D38 800C1538 00004494 */  lhu        $a0, 0x0($v0)
    /* B1D3C 800C153C 1400A28F */  lw         $v0, 0x14($sp)
    /* B1D40 800C1540 0000E594 */  lhu        $a1, 0x0($a3)
    /* B1D44 800C1544 00004294 */  lhu        $v0, 0x0($v0)
    /* B1D48 800C1548 0C0065A4 */  sh         $a1, 0xC($v1)
    /* B1D4C 800C154C 140064A4 */  sh         $a0, 0x14($v1)
    /* B1D50 800C1550 1C0062A4 */  sh         $v0, 0x1C($v1)
  .L800C1554:
    /* B1D54 800C1554 0800E003 */  jr         $ra
    /* B1D58 800C1558 00000000 */   nop
endlabel DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache
