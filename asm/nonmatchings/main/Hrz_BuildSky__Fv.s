.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_BuildSky__Fv, 0x728

glabel Hrz_BuildSky__Fv
    /* C1238 800D0A38 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C123C 800D0A3C 3000B0AF */  sw         $s0, 0x30($sp)
    /* C1240 800D0A40 78001024 */  addiu      $s0, $zero, 0x78
    /* C1244 800D0A44 1180023C */  lui        $v0, %hi(D_801131F8)
    /* C1248 800D0A48 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* C124C 800D0A4C 01000224 */  addiu      $v0, $zero, 0x1
    /* C1250 800D0A50 4400BFAF */  sw         $ra, 0x44($sp)
    /* C1254 800D0A54 4000B4AF */  sw         $s4, 0x40($sp)
    /* C1258 800D0A58 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* C125C 800D0A5C 3800B2AF */  sw         $s2, 0x38($sp)
    /* C1260 800D0A60 02006214 */  bne        $v1, $v0, .L800D0A6C
    /* C1264 800D0A64 3400B1AF */   sw        $s1, 0x34($sp)
    /* C1268 800D0A68 3C001024 */  addiu      $s0, $zero, 0x3C
  .L800D0A6C:
    /* C126C 800D0A6C 801F113C */  lui        $s1, (0x1F800014 >> 16)
    /* C1270 800D0A70 14003136 */  ori        $s1, $s1, (0x1F800014 & 0xFFFF)
    /* C1274 800D0A74 801F143C */  lui        $s4, (0x1F800168 >> 16)
    /* C1278 800D0A78 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C127C 800D0A7C 68019436 */  ori        $s4, $s4, (0x1F800168 & 0xFFFF)
    /* C1280 800D0A80 0400428C */  lw         $v0, 0x4($v0)
    /* C1284 800D0A84 00000000 */  nop
    /* C1288 800D0A88 01004230 */  andi       $v0, $v0, 0x1
    /* C128C 800D0A8C 3D004010 */  beqz       $v0, .L800D0B84
    /* C1290 800D0A90 801F123C */   lui       $s2, (0x1F80015C >> 16)
    /* C1294 800D0A94 1000A427 */  addiu      $a0, $sp, 0x10
    /* C1298 800D0A98 21280000 */  addu       $a1, $zero, $zero
    /* C129C 800D0A9C C690030C */  jal        memset
    /* C12A0 800D0AA0 0C000624 */   addiu     $a2, $zero, 0xC
    /* C12A4 800D0AA4 4742030C */  jal        HrzSetPsxTranslation__FP8coorddef
    /* C12A8 800D0AA8 1000A427 */   addiu     $a0, $sp, 0x10
    /* C12AC 800D0AAC 1280023C */  lui        $v0, %hi(gSkyMesh)
    /* C12B0 800D0AB0 78034624 */  addiu      $a2, $v0, %lo(gSkyMesh)
    /* C12B4 800D0AB4 55000724 */  addiu      $a3, $zero, 0x55
    /* C12B8 800D0AB8 21284002 */  addu       $a1, $s2, $zero
    /* C12BC 800D0ABC 0800A534 */  ori        $a1, $a1, (0x1F800008 & 0xFFFF)
    /* C12C0 800D0AC0 21204002 */  addu       $a0, $s2, $zero
    /* C12C4 800D0AC4 5C018434 */  ori        $a0, $a0, (0x1F80015C & 0xFFFF)
  .L800D0AC8:
    /* C12C8 800D0AC8 0800C324 */  addiu      $v1, $a2, 0x8
    /* C12CC 800D0ACC 1000C224 */  addiu      $v0, $a2, 0x10
    /* C12D0 800D0AD0 0000C0C8 */  lwc2       $0, 0x0($a2)
    /* C12D4 800D0AD4 0400C1C8 */  lwc2       $1, 0x4($a2)
    /* C12D8 800D0AD8 000062C8 */  lwc2       $2, 0x0($v1)
    /* C12DC 800D0ADC 040063C8 */  lwc2       $3, 0x4($v1)
    /* C12E0 800D0AE0 000044C8 */  lwc2       $4, 0x0($v0)
    /* C12E4 800D0AE4 040045C8 */  lwc2       $5, 0x4($v0)
    /* C12E8 800D0AE8 00000000 */  nop
    /* C12EC 800D0AEC 00000000 */  nop
    /* C12F0 800D0AF0 3000284A */  .word 0x4A280030  /* rtpt */
    /* C12F4 800D0AF4 1800C624 */  addiu      $a2, $a2, 0x18
    /* C12F8 800D0AF8 FDFFE724 */  addiu      $a3, $a3, -0x3
    /* C12FC 800D0AFC 0C00A524 */  addiu      $a1, $a1, 0xC
    /* C1300 800D0B00 0C008424 */  addiu      $a0, $a0, 0xC
    /* C1304 800D0B04 0400A224 */  addiu      $v0, $a1, 0x4
    /* C1308 800D0B08 0800A824 */  addiu      $t0, $a1, 0x8
    /* C130C 800D0B0C 0000ACE8 */  swc2       $12, 0x0($a1)
    /* C1310 800D0B10 00004DE8 */  swc2       $13, 0x0($v0)
    /* C1314 800D0B14 00000EE9 */  swc2       $14, 0x0($t0)
    /* C1318 800D0B18 04008224 */  addiu      $v0, $a0, 0x4
    /* C131C 800D0B1C 08008324 */  addiu      $v1, $a0, 0x8
    /* C1320 800D0B20 000091E8 */  swc2       $17, 0x0($a0)
    /* C1324 800D0B24 000052E8 */  swc2       $18, 0x0($v0)
    /* C1328 800D0B28 000073E8 */  swc2       $19, 0x0($v1)
    /* C132C 800D0B2C 0300E228 */  slti       $v0, $a3, 0x3
    /* C1330 800D0B30 E5FF4010 */  beqz       $v0, .L800D0AC8
    /* C1334 800D0B34 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* C1338 800D0B38 21280001 */  addu       $a1, $t0, $zero
    /* C133C 800D0B3C FFFFE724 */  addiu      $a3, $a3, -0x1
    /* C1340 800D0B40 3400E210 */  beq        $a3, $v0, .L800D0C14
    /* C1344 800D0B44 21206000 */   addu      $a0, $v1, $zero
  .L800D0B48:
    /* C1348 800D0B48 0000C0C8 */  lwc2       $0, 0x0($a2)
    /* C134C 800D0B4C 0400C1C8 */  lwc2       $1, 0x4($a2)
    /* C1350 800D0B50 00000000 */  nop
    /* C1354 800D0B54 00000000 */  nop
    /* C1358 800D0B58 0100184A */  .word 0x4A180001  /* rtps */
    /* C135C 800D0B5C 0800C624 */  addiu      $a2, $a2, 0x8
    /* C1360 800D0B60 0400A524 */  addiu      $a1, $a1, 0x4
    /* C1364 800D0B64 04008424 */  addiu      $a0, $a0, 0x4
    /* C1368 800D0B68 0000AEE8 */  swc2       $14, 0x0($a1)
    /* C136C 800D0B6C 000093E8 */  swc2       $19, 0x0($a0)
    /* C1370 800D0B70 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* C1374 800D0B74 2700E210 */  beq        $a3, $v0, .L800D0C14
    /* C1378 800D0B78 00000000 */   nop
    /* C137C 800D0B7C D2420308 */  j          .L800D0B48
    /* C1380 800D0B80 00000000 */   nop
  .L800D0B84:
    /* C1384 800D0B84 1000A427 */  addiu      $a0, $sp, 0x10
    /* C1388 800D0B88 21280000 */  addu       $a1, $zero, $zero
    /* C138C 800D0B8C C690030C */  jal        memset
    /* C1390 800D0B90 0C000624 */   addiu     $a2, $zero, 0xC
    /* C1394 800D0B94 4742030C */  jal        HrzSetPsxTranslation__FP8coorddef
    /* C1398 800D0B98 1000A427 */   addiu     $a0, $sp, 0x10
    /* C139C 800D0B9C 1280023C */  lui        $v0, %hi(gSkyMesh)
    /* C13A0 800D0BA0 78034624 */  addiu      $a2, $v0, %lo(gSkyMesh)
    /* C13A4 800D0BA4 801F033C */  lui        $v1, (0x1F800010 >> 16)
    /* C13A8 800D0BA8 10006334 */  ori        $v1, $v1, (0x1F800010 & 0xFFFF)
    /* C13AC 800D0BAC 801F053C */  lui        $a1, (0x1F800164 >> 16)
    /* C13B0 800D0BB0 6401A534 */  ori        $a1, $a1, (0x1F800164 & 0xFFFF)
    /* C13B4 800D0BB4 54000424 */  addiu      $a0, $zero, 0x54
    /* C13B8 800D0BB8 2000A727 */  addiu      $a3, $sp, 0x20
    /* C13BC 800D0BBC FFFF0824 */  addiu      $t0, $zero, -0x1
  .L800D0BC0:
    /* C13C0 800D0BC0 0000C0C8 */  lwc2       $0, 0x0($a2)
    /* C13C4 800D0BC4 0400C1C8 */  lwc2       $1, 0x4($a2)
    /* C13C8 800D0BC8 00000000 */  nop
    /* C13CC 800D0BCC 00000000 */  nop
    /* C13D0 800D0BD0 0100184A */  .word 0x4A180001  /* rtps */
    /* C13D4 800D0BD4 0800C624 */  addiu      $a2, $a2, 0x8
    /* C13D8 800D0BD8 04006324 */  addiu      $v1, $v1, 0x4
    /* C13DC 800D0BDC 0400A524 */  addiu      $a1, $a1, 0x4
    /* C13E0 800D0BE0 0000F9E8 */  swc2       $25, 0x0($a3)
    /* C13E4 800D0BE4 0400FAE8 */  swc2       $26, 0x4($a3) /* handwritten instruction */
    /* C13E8 800D0BE8 0800FBE8 */  swc2       $27, 0x8($a3) /* handwritten instruction */
    /* C13EC 800D0BEC 00006EE8 */  swc2       $14, 0x0($v1)
    /* C13F0 800D0BF0 2400A28F */  lw         $v0, 0x24($sp)
    /* C13F4 800D0BF4 00000000 */  nop
    /* C13F8 800D0BF8 83100200 */  sra        $v0, $v0, 2
    /* C13FC 800D0BFC 21105000 */  addu       $v0, $v0, $s0
    /* C1400 800D0C00 020062A4 */  sh         $v0, 0x2($v1)
    /* C1404 800D0C04 0000B3E8 */  swc2       $19, 0x0($a1)
    /* C1408 800D0C08 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* C140C 800D0C0C ECFF8814 */  bne        $a0, $t0, .L800D0BC0
    /* C1410 800D0C10 00000000 */   nop
  .L800D0C14:
    /* C1414 800D0C14 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C1418 800D0C18 00000000 */  nop
    /* C141C 800D0C1C 0400428C */  lw         $v0, 0x4($v0)
    /* C1420 800D0C20 00000000 */  nop
    /* C1424 800D0C24 40004230 */  andi       $v0, $v0, 0x40
    /* C1428 800D0C28 05004010 */  beqz       $v0, .L800D0C40
    /* C142C 800D0C2C 21200000 */   addu      $a0, $zero, $zero
    /* C1430 800D0C30 1480053C */  lui        $a1, %hi(Draw_gViewOtSize)
    /* C1434 800D0C34 B0D7A58C */  lw         $a1, %lo(Draw_gViewOtSize)($a1)
    /* C1438 800D0C38 6C42030C */  jal        Hrz_SetDitheringPrim__Fii
    /* C143C 800D0C3C FEFFA524 */   addiu     $a1, $a1, -0x2
  .L800D0C40:
    /* C1440 800D0C40 1280023C */  lui        $v0, %hi(D_801232D8)
    /* C1444 800D0C44 D832428C */  lw         $v0, %lo(D_801232D8)($v0)
    /* C1448 800D0C48 00000000 */  nop
    /* C144C 800D0C4C 04004230 */  andi       $v0, $v0, 0x4
    /* C1450 800D0C50 08004010 */  beqz       $v0, .L800D0C74
    /* C1454 800D0C54 21600000 */   addu      $t4, $zero, $zero
    /* C1458 800D0C58 1480043C */  lui        $a0, %hi(D_8013DDF0)
    /* C145C 800D0C5C F0DD8424 */  addiu      $a0, $a0, %lo(D_8013DDF0)
    /* C1460 800D0C60 9400508E */  lw         $s0, (0x1F800094 & 0xFFFF)($s2)
    /* C1464 800D0C64 743C030C */  jal        Flare_Sun__FP7SVECTORP15Draw_FlareCache
    /* C1468 800D0C68 21284002 */   addu      $a1, $s2, $zero
    /* C146C 800D0C6C 940050AE */  sw         $s0, (0x1F800094 & 0xFFFF)($s2)
    /* C1470 800D0C70 21600000 */  addu       $t4, $zero, $zero
  .L800D0C74:
    /* C1474 800D0C74 1280023C */  lui        $v0, %hi(gHorizonPixmap)
    /* C1478 800D0C78 F8025324 */  addiu      $s3, $v0, %lo(gHorizonPixmap)
    /* C147C 800D0C7C 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* C1480 800D0C80 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* C1484 800D0C84 801F103C */  lui        $s0, (0x1F800000 >> 16)
    /* C1488 800D0C88 FF000A3C */  lui        $t2, (0xFFFFFF >> 16)
    /* C148C 800D0C8C FFFF4A35 */  ori        $t2, $t2, (0xFFFFFF & 0xFFFF)
    /* C1490 800D0C90 00FF0E3C */  lui        $t6, (0xFF000000 >> 16)
    /* C1494 800D0C94 1280023C */  lui        $v0, %hi(D_80120664)
    /* C1498 800D0C98 64064F24 */  addiu      $t7, $v0, %lo(D_80120664)
    /* C149C 800D0C9C BCFFF925 */  addiu      $t9, $t7, -0x44
    /* C14A0 800D0CA0 C0FFF825 */  addiu      $t8, $t7, -0x40
    /* C14A4 800D0CA4 1280023C */  lui        $v0, %hi(gSkyPixmapIndex)
    /* C14A8 800D0CA8 74074D24 */  addiu      $t5, $v0, %lo(gSkyPixmapIndex)
  .L800D0CAC:
    /* C14AC 800D0CAC 40008229 */  slti       $v0, $t4, 0x40
    /* C14B0 800D0CB0 18014010 */  beqz       $v0, .L800D1114
    /* C14B4 800D0CB4 00110C00 */   sll       $v0, $t4, 4
    /* C14B8 800D0CB8 21104C00 */  addu       $v0, $v0, $t4
    /* C14BC 800D0CBC 03004104 */  bgez       $v0, .L800D0CCC
    /* C14C0 800D0CC0 03490200 */   sra       $t1, $v0, 4
    /* C14C4 800D0CC4 0F004224 */  addiu      $v0, $v0, 0xF
    /* C14C8 800D0CC8 03490200 */  sra        $t1, $v0, 4
  .L800D0CCC:
    /* C14CC 800D0CCC 80100900 */  sll        $v0, $t1, 2
    /* C14D0 800D0CD0 21185400 */  addu       $v1, $v0, $s4
    /* C14D4 800D0CD4 4400628C */  lw         $v0, 0x44($v1)
    /* C14D8 800D0CD8 00000000 */  nop
    /* C14DC 800D0CDC 0D004014 */  bnez       $v0, .L800D0D14
    /* C14E0 800D0CE0 80100900 */   sll       $v0, $t1, 2
    /* C14E4 800D0CE4 4800628C */  lw         $v0, 0x48($v1)
    /* C14E8 800D0CE8 00000000 */  nop
    /* C14EC 800D0CEC 09004014 */  bnez       $v0, .L800D0D14
    /* C14F0 800D0CF0 80100900 */   sll       $v0, $t1, 2
    /* C14F4 800D0CF4 0400628C */  lw         $v0, 0x4($v1)
    /* C14F8 800D0CF8 00000000 */  nop
    /* C14FC 800D0CFC 05004014 */  bnez       $v0, .L800D0D14
    /* C1500 800D0D00 80100900 */   sll       $v0, $t1, 2
    /* C1504 800D0D04 0000628C */  lw         $v0, 0x0($v1)
    /* C1508 800D0D08 00000000 */  nop
    /* C150C 800D0D0C FE004010 */  beqz       $v0, .L800D1108
    /* C1510 800D0D10 80100900 */   sll       $v0, $t1, 2
  .L800D0D14:
    /* C1514 800D0D14 21205100 */  addu       $a0, $v0, $s1
    /* C1518 800D0D18 10004396 */  lhu        $v1, (0x1F800010 & 0xFFFF)($s2)
    /* C151C 800D0D1C 44008284 */  lh         $v0, 0x44($a0)
    /* C1520 800D0D20 001C0300 */  sll        $v1, $v1, 16
    /* C1524 800D0D24 031C0300 */  sra        $v1, $v1, 16
    /* C1528 800D0D28 2A106200 */  slt        $v0, $v1, $v0
    /* C152C 800D0D2C 10004010 */  beqz       $v0, .L800D0D70
    /* C1530 800D0D30 80100900 */   sll       $v0, $t1, 2
    /* C1534 800D0D34 48008284 */  lh         $v0, 0x48($a0)
    /* C1538 800D0D38 00000000 */  nop
    /* C153C 800D0D3C 2A106200 */  slt        $v0, $v1, $v0
    /* C1540 800D0D40 0B004010 */  beqz       $v0, .L800D0D70
    /* C1544 800D0D44 80100900 */   sll       $v0, $t1, 2
    /* C1548 800D0D48 04008284 */  lh         $v0, 0x4($a0)
    /* C154C 800D0D4C 00000000 */  nop
    /* C1550 800D0D50 2A106200 */  slt        $v0, $v1, $v0
    /* C1554 800D0D54 06004010 */  beqz       $v0, .L800D0D70
    /* C1558 800D0D58 80100900 */   sll       $v0, $t1, 2
    /* C155C 800D0D5C 00008284 */  lh         $v0, 0x0($a0)
    /* C1560 800D0D60 00000000 */  nop
    /* C1564 800D0D64 2A106200 */  slt        $v0, $v1, $v0
    /* C1568 800D0D68 E7004014 */  bnez       $v0, .L800D1108
    /* C156C 800D0D6C 80100900 */   sll       $v0, $t1, 2
  .L800D0D70:
    /* C1570 800D0D70 21185100 */  addu       $v1, $v0, $s1
    /* C1574 800D0D74 44006284 */  lh         $v0, 0x44($v1)
    /* C1578 800D0D78 00000000 */  nop
    /* C157C 800D0D7C 0D004104 */  bgez       $v0, .L800D0DB4
    /* C1580 800D0D80 80100900 */   sll       $v0, $t1, 2
    /* C1584 800D0D84 48006284 */  lh         $v0, 0x48($v1)
    /* C1588 800D0D88 00000000 */  nop
    /* C158C 800D0D8C 09004104 */  bgez       $v0, .L800D0DB4
    /* C1590 800D0D90 80100900 */   sll       $v0, $t1, 2
    /* C1594 800D0D94 04006284 */  lh         $v0, 0x4($v1)
    /* C1598 800D0D98 00000000 */  nop
    /* C159C 800D0D9C 05004104 */  bgez       $v0, .L800D0DB4
    /* C15A0 800D0DA0 80100900 */   sll       $v0, $t1, 2
    /* C15A4 800D0DA4 00006284 */  lh         $v0, 0x0($v1)
    /* C15A8 800D0DA8 00000000 */  nop
    /* C15AC 800D0DAC D6004004 */  bltz       $v0, .L800D1108
    /* C15B0 800D0DB0 80100900 */   sll       $v0, $t1, 2
  .L800D0DB4:
    /* C15B4 800D0DB4 21205100 */  addu       $a0, $v0, $s1
    /* C15B8 800D0DB8 12004396 */  lhu        $v1, (0x1F800012 & 0xFFFF)($s2)
    /* C15BC 800D0DBC 46008284 */  lh         $v0, 0x46($a0)
    /* C15C0 800D0DC0 001C0300 */  sll        $v1, $v1, 16
    /* C15C4 800D0DC4 031C0300 */  sra        $v1, $v1, 16
    /* C15C8 800D0DC8 2A106200 */  slt        $v0, $v1, $v0
    /* C15CC 800D0DCC 12004010 */  beqz       $v0, .L800D0E18
    /* C15D0 800D0DD0 80100900 */   sll       $v0, $t1, 2
    /* C15D4 800D0DD4 4A008284 */  lh         $v0, 0x4A($a0)
    /* C15D8 800D0DD8 00000000 */  nop
    /* C15DC 800D0DDC 2A106200 */  slt        $v0, $v1, $v0
    /* C15E0 800D0DE0 0D004010 */  beqz       $v0, .L800D0E18
    /* C15E4 800D0DE4 80100900 */   sll       $v0, $t1, 2
    /* C15E8 800D0DE8 06008284 */  lh         $v0, 0x6($a0)
    /* C15EC 800D0DEC 00000000 */  nop
    /* C15F0 800D0DF0 2A106200 */  slt        $v0, $v1, $v0
    /* C15F4 800D0DF4 08004010 */  beqz       $v0, .L800D0E18
    /* C15F8 800D0DF8 80100900 */   sll       $v0, $t1, 2
    /* C15FC 800D0DFC 02008294 */  lhu        $v0, 0x2($a0)
    /* C1600 800D0E00 00000000 */  nop
    /* C1604 800D0E04 00140200 */  sll        $v0, $v0, 16
    /* C1608 800D0E08 03140200 */  sra        $v0, $v0, 16
    /* C160C 800D0E0C 2A106200 */  slt        $v0, $v1, $v0
    /* C1610 800D0E10 BD004014 */  bnez       $v0, .L800D1108
    /* C1614 800D0E14 80100900 */   sll       $v0, $t1, 2
  .L800D0E18:
    /* C1618 800D0E18 21185100 */  addu       $v1, $v0, $s1
    /* C161C 800D0E1C 46006284 */  lh         $v0, 0x46($v1)
    /* C1620 800D0E20 00000000 */  nop
    /* C1624 800D0E24 0E004104 */  bgez       $v0, .L800D0E60
    /* C1628 800D0E28 00000000 */   nop
    /* C162C 800D0E2C 4A006284 */  lh         $v0, 0x4A($v1)
    /* C1630 800D0E30 00000000 */  nop
    /* C1634 800D0E34 0A004104 */  bgez       $v0, .L800D0E60
    /* C1638 800D0E38 00000000 */   nop
    /* C163C 800D0E3C 06006284 */  lh         $v0, 0x6($v1)
    /* C1640 800D0E40 00000000 */  nop
    /* C1644 800D0E44 06004104 */  bgez       $v0, .L800D0E60
    /* C1648 800D0E48 00000000 */   nop
    /* C164C 800D0E4C 02006294 */  lhu        $v0, 0x2($v1)
    /* C1650 800D0E50 00000000 */  nop
    /* C1654 800D0E54 00140200 */  sll        $v0, $v0, 16
    /* C1658 800D0E58 AB004004 */  bltz       $v0, .L800D1108
    /* C165C 800D0E5C 00000000 */   nop
  .L800D0E60:
    /* C1660 800D0E60 4013888F */  lw         $t0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C1664 800D0E64 00000000 */  nop
    /* C1668 800D0E68 0000038D */  lw         $v1, 0x0($t0)
    /* C166C 800D0E6C 01000224 */  addiu      $v0, $zero, 0x1
    /* C1670 800D0E70 72006214 */  bne        $v1, $v0, .L800D103C
    /* C1674 800D0E74 00000000 */   nop
    /* C1678 800D0E78 0400028D */  lw         $v0, 0x4($t0)
    /* C167C 800D0E7C 00000000 */  nop
    /* C1680 800D0E80 20004230 */  andi       $v0, $v0, 0x20
    /* C1684 800D0E84 43004010 */  beqz       $v0, .L800D0F94
    /* C1688 800D0E88 00000000 */   nop
    /* C168C 800D0E8C 0000658D */  lw         $a1, 0x0($t3)
    /* C1690 800D0E90 0000A391 */  lbu        $v1, 0x0($t5)
    /* C1694 800D0E94 1480043C */  lui        $a0, %hi(Draw_gViewOtSize)
    /* C1698 800D0E98 B0D7848C */  lw         $a0, %lo(Draw_gViewOtSize)($a0)
    /* C169C 800D0E9C 0000028E */  lw         $v0, (0x1F800000 & 0xFFFF)($s0)
    /* C16A0 800D0EA0 80180300 */  sll        $v1, $v1, 2
    /* C16A4 800D0EA4 80200400 */  sll        $a0, $a0, 2
    /* C16A8 800D0EA8 21208200 */  addu       $a0, $a0, $v0
    /* C16AC 800D0EAC 21187300 */  addu       $v1, $v1, $s3
    /* C16B0 800D0EB0 0000A68C */  lw         $a2, 0x0($a1)
    /* C16B4 800D0EB4 F8FF828C */  lw         $v0, -0x8($a0)
    /* C16B8 800D0EB8 0000678C */  lw         $a3, 0x0($v1)
    /* C16BC 800D0EBC 2430CE00 */  and        $a2, $a2, $t6
    /* C16C0 800D0EC0 24104A00 */  and        $v0, $v0, $t2
    /* C16C4 800D0EC4 2530C200 */  or         $a2, $a2, $v0
    /* C16C8 800D0EC8 0000A6AC */  sw         $a2, 0x0($a1)
    /* C16CC 800D0ECC F8FF828C */  lw         $v0, -0x8($a0)
    /* C16D0 800D0ED0 2418AA00 */  and        $v1, $a1, $t2
    /* C16D4 800D0ED4 24104E00 */  and        $v0, $v0, $t6
    /* C16D8 800D0ED8 25104300 */  or         $v0, $v0, $v1
    /* C16DC 800D0EDC F8FF82AC */  sw         $v0, -0x8($a0)
    /* C16E0 800D0EE0 80200900 */  sll        $a0, $t1, 2
    /* C16E4 800D0EE4 21108F00 */  addu       $v0, $a0, $t7
    /* C16E8 800D0EE8 0000438C */  lw         $v1, 0x0($v0)
    /* C16EC 800D0EEC 3400A224 */  addiu      $v0, $a1, 0x34
    /* C16F0 800D0EF0 000062AD */  sw         $v0, 0x0($t3)
    /* C16F4 800D0EF4 2110E401 */  addu       $v0, $t7, $a0
    /* C16F8 800D0EF8 0400A3AC */  sw         $v1, 0x4($a1)
    /* C16FC 800D0EFC 0400428C */  lw         $v0, 0x4($v0)
    /* C1700 800D0F00 00000000 */  nop
    /* C1704 800D0F04 1000A2AC */  sw         $v0, 0x10($a1)
    /* C1708 800D0F08 21109900 */  addu       $v0, $a0, $t9
    /* C170C 800D0F0C 0000428C */  lw         $v0, 0x0($v0)
    /* C1710 800D0F10 00000000 */  nop
    /* C1714 800D0F14 1C00A2AC */  sw         $v0, 0x1C($a1)
    /* C1718 800D0F18 21109800 */  addu       $v0, $a0, $t8
    /* C171C 800D0F1C 0000438C */  lw         $v1, 0x0($v0)
    /* C1720 800D0F20 0C000224 */  addiu      $v0, $zero, 0xC
    /* C1724 800D0F24 0300A2A0 */  sb         $v0, 0x3($a1)
    /* C1728 800D0F28 3C000224 */  addiu      $v0, $zero, 0x3C
    /* C172C 800D0F2C 0700A2A0 */  sb         $v0, 0x7($a1)
    /* C1730 800D0F30 2800A3AC */  sw         $v1, 0x28($a1)
    /* C1734 800D0F34 0000E28C */  lw         $v0, 0x0($a3)
    /* C1738 800D0F38 00000000 */  nop
    /* C173C 800D0F3C 0C00A2AC */  sw         $v0, 0xC($a1)
    /* C1740 800D0F40 0400E28C */  lw         $v0, 0x4($a3)
    /* C1744 800D0F44 00000000 */  nop
    /* C1748 800D0F48 1800A2AC */  sw         $v0, 0x18($a1)
    /* C174C 800D0F4C 0800E28C */  lw         $v0, 0x8($a3)
    /* C1750 800D0F50 00000000 */  nop
    /* C1754 800D0F54 2400A2AC */  sw         $v0, 0x24($a1)
    /* C1758 800D0F58 0C00E28C */  lw         $v0, 0xC($a3)
    /* C175C 800D0F5C 21209100 */  addu       $a0, $a0, $s1
    /* C1760 800D0F60 3000A2AC */  sw         $v0, 0x30($a1)
    /* C1764 800D0F64 4400828C */  lw         $v0, 0x44($a0)
    /* C1768 800D0F68 00000000 */  nop
    /* C176C 800D0F6C 0800A2AC */  sw         $v0, 0x8($a1)
    /* C1770 800D0F70 4800828C */  lw         $v0, 0x48($a0)
    /* C1774 800D0F74 00000000 */  nop
    /* C1778 800D0F78 1400A2AC */  sw         $v0, 0x14($a1)
    /* C177C 800D0F7C 0000828C */  lw         $v0, 0x0($a0)
    /* C1780 800D0F80 00000000 */  nop
    /* C1784 800D0F84 2000A2AC */  sw         $v0, 0x20($a1)
    /* C1788 800D0F88 0400828C */  lw         $v0, 0x4($a0)
    /* C178C 800D0F8C 42440308 */  j          .L800D1108
    /* C1790 800D0F90 2C00A2AC */   sw        $v0, 0x2C($a1)
  .L800D0F94:
    /* C1794 800D0F94 0000658D */  lw         $a1, 0x0($t3)
    /* C1798 800D0F98 0000A391 */  lbu        $v1, 0x0($t5)
    /* C179C 800D0F9C 1480043C */  lui        $a0, %hi(Draw_gViewOtSize)
    /* C17A0 800D0FA0 B0D7848C */  lw         $a0, %lo(Draw_gViewOtSize)($a0)
    /* C17A4 800D0FA4 0000028E */  lw         $v0, (0x1F800000 & 0xFFFF)($s0)
    /* C17A8 800D0FA8 80180300 */  sll        $v1, $v1, 2
    /* C17AC 800D0FAC 80200400 */  sll        $a0, $a0, 2
    /* C17B0 800D0FB0 21208200 */  addu       $a0, $a0, $v0
    /* C17B4 800D0FB4 21187300 */  addu       $v1, $v1, $s3
    /* C17B8 800D0FB8 0000A68C */  lw         $a2, 0x0($a1)
    /* C17BC 800D0FBC F8FF828C */  lw         $v0, -0x8($a0)
    /* C17C0 800D0FC0 0000678C */  lw         $a3, 0x0($v1)
    /* C17C4 800D0FC4 2430CE00 */  and        $a2, $a2, $t6
    /* C17C8 800D0FC8 24104A00 */  and        $v0, $v0, $t2
    /* C17CC 800D0FCC 2530C200 */  or         $a2, $a2, $v0
    /* C17D0 800D0FD0 0000A6AC */  sw         $a2, 0x0($a1)
    /* C17D4 800D0FD4 F8FF838C */  lw         $v1, -0x8($a0)
    /* C17D8 800D0FD8 2800A224 */  addiu      $v0, $a1, 0x28
    /* C17DC 800D0FDC 000062AD */  sw         $v0, 0x0($t3)
    /* C17E0 800D0FE0 2410AA00 */  and        $v0, $a1, $t2
    /* C17E4 800D0FE4 24186E00 */  and        $v1, $v1, $t6
    /* C17E8 800D0FE8 25186200 */  or         $v1, $v1, $v0
    /* C17EC 800D0FEC F8FF83AC */  sw         $v1, -0x8($a0)
    /* C17F0 800D0FF0 0800038D */  lw         $v1, 0x8($t0)
    /* C17F4 800D0FF4 09000224 */  addiu      $v0, $zero, 0x9
    /* C17F8 800D0FF8 0300A2A0 */  sb         $v0, 0x3($a1)
    /* C17FC 800D0FFC 2C000224 */  addiu      $v0, $zero, 0x2C
    /* C1800 800D1000 0400A3AC */  sw         $v1, 0x4($a1)
    /* C1804 800D1004 0700A2A0 */  sb         $v0, 0x7($a1)
    /* C1808 800D1008 0000E28C */  lw         $v0, 0x0($a3)
    /* C180C 800D100C 00000000 */  nop
    /* C1810 800D1010 0C00A2AC */  sw         $v0, 0xC($a1)
    /* C1814 800D1014 0400E28C */  lw         $v0, 0x4($a3)
    /* C1818 800D1018 00000000 */  nop
    /* C181C 800D101C 1400A2AC */  sw         $v0, 0x14($a1)
    /* C1820 800D1020 0800E28C */  lw         $v0, 0x8($a3)
    /* C1824 800D1024 80180900 */  sll        $v1, $t1, 2
    /* C1828 800D1028 1C00A2AC */  sw         $v0, 0x1C($a1)
    /* C182C 800D102C 0C00E28C */  lw         $v0, 0xC($a3)
    /* C1830 800D1030 21187100 */  addu       $v1, $v1, $s1
    /* C1834 800D1034 36440308 */  j          .L800D10D8
    /* C1838 800D1038 2400A2AC */   sw        $v0, 0x24($a1)
  .L800D103C:
    /* C183C 800D103C 1480043C */  lui        $a0, %hi(Draw_gViewOtSize)
    /* C1840 800D1040 B0D7848C */  lw         $a0, %lo(Draw_gViewOtSize)($a0)
    /* C1844 800D1044 0000028E */  lw         $v0, (0x1F800000 & 0xFFFF)($s0)
    /* C1848 800D1048 0000658D */  lw         $a1, 0x0($t3)
    /* C184C 800D104C 80200400 */  sll        $a0, $a0, 2
    /* C1850 800D1050 21208200 */  addu       $a0, $a0, $v0
    /* C1854 800D1054 0000A38C */  lw         $v1, 0x0($a1)
    /* C1858 800D1058 F8FF828C */  lw         $v0, -0x8($a0)
    /* C185C 800D105C 24186E00 */  and        $v1, $v1, $t6
    /* C1860 800D1060 24104A00 */  and        $v0, $v0, $t2
    /* C1864 800D1064 25186200 */  or         $v1, $v1, $v0
    /* C1868 800D1068 0000A3AC */  sw         $v1, 0x0($a1)
    /* C186C 800D106C F8FF828C */  lw         $v0, -0x8($a0)
    /* C1870 800D1070 2418AA00 */  and        $v1, $a1, $t2
    /* C1874 800D1074 24104E00 */  and        $v0, $v0, $t6
    /* C1878 800D1078 25104300 */  or         $v0, $v0, $v1
    /* C187C 800D107C 80180900 */  sll        $v1, $t1, 2
    /* C1880 800D1080 F8FF82AC */  sw         $v0, -0x8($a0)
    /* C1884 800D1084 21106F00 */  addu       $v0, $v1, $t7
    /* C1888 800D1088 0000448C */  lw         $a0, 0x0($v0)
    /* C188C 800D108C 2400A224 */  addiu      $v0, $a1, 0x24
    /* C1890 800D1090 000062AD */  sw         $v0, 0x0($t3)
    /* C1894 800D1094 2110E301 */  addu       $v0, $t7, $v1
    /* C1898 800D1098 0400A4AC */  sw         $a0, 0x4($a1)
    /* C189C 800D109C 0400428C */  lw         $v0, 0x4($v0)
    /* C18A0 800D10A0 00000000 */  nop
    /* C18A4 800D10A4 0C00A2AC */  sw         $v0, 0xC($a1)
    /* C18A8 800D10A8 21107900 */  addu       $v0, $v1, $t9
    /* C18AC 800D10AC 0000428C */  lw         $v0, 0x0($v0)
    /* C18B0 800D10B0 00000000 */  nop
    /* C18B4 800D10B4 1400A2AC */  sw         $v0, 0x14($a1)
    /* C18B8 800D10B8 21107800 */  addu       $v0, $v1, $t8
    /* C18BC 800D10BC 0000448C */  lw         $a0, 0x0($v0)
    /* C18C0 800D10C0 08000224 */  addiu      $v0, $zero, 0x8
    /* C18C4 800D10C4 0300A2A0 */  sb         $v0, 0x3($a1)
    /* C18C8 800D10C8 38000224 */  addiu      $v0, $zero, 0x38
    /* C18CC 800D10CC 21187100 */  addu       $v1, $v1, $s1
    /* C18D0 800D10D0 0700A2A0 */  sb         $v0, 0x7($a1)
    /* C18D4 800D10D4 1C00A4AC */  sw         $a0, 0x1C($a1)
  .L800D10D8:
    /* C18D8 800D10D8 4400628C */  lw         $v0, 0x44($v1)
    /* C18DC 800D10DC 00000000 */  nop
    /* C18E0 800D10E0 0800A2AC */  sw         $v0, 0x8($a1)
    /* C18E4 800D10E4 4800628C */  lw         $v0, 0x48($v1)
    /* C18E8 800D10E8 00000000 */  nop
    /* C18EC 800D10EC 1000A2AC */  sw         $v0, 0x10($a1)
    /* C18F0 800D10F0 0000628C */  lw         $v0, 0x0($v1)
    /* C18F4 800D10F4 00000000 */  nop
    /* C18F8 800D10F8 1800A2AC */  sw         $v0, 0x18($a1)
    /* C18FC 800D10FC 0400628C */  lw         $v0, 0x4($v1)
    /* C1900 800D1100 00000000 */  nop
    /* C1904 800D1104 2000A2AC */  sw         $v0, 0x20($a1)
  .L800D1108:
    /* C1908 800D1108 0100AD25 */  addiu      $t5, $t5, 0x1
    /* C190C 800D110C 2B430308 */  j          .L800D0CAC
    /* C1910 800D1110 01008C25 */   addiu     $t4, $t4, 0x1
  .L800D1114:
    /* C1914 800D1114 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C1918 800D1118 00000000 */  nop
    /* C191C 800D111C 0400428C */  lw         $v0, 0x4($v0)
    /* C1920 800D1120 00000000 */  nop
    /* C1924 800D1124 40004230 */  andi       $v0, $v0, 0x40
    /* C1928 800D1128 05004010 */  beqz       $v0, .L800D1140
    /* C192C 800D112C 01000424 */   addiu     $a0, $zero, 0x1
    /* C1930 800D1130 1480053C */  lui        $a1, %hi(Draw_gViewOtSize)
    /* C1934 800D1134 B0D7A58C */  lw         $a1, %lo(Draw_gViewOtSize)($a1)
    /* C1938 800D1138 6C42030C */  jal        Hrz_SetDitheringPrim__Fii
    /* C193C 800D113C FEFFA524 */   addiu     $a1, $a1, -0x2
  .L800D1140:
    /* C1940 800D1140 4400BF8F */  lw         $ra, 0x44($sp)
    /* C1944 800D1144 4000B48F */  lw         $s4, 0x40($sp)
    /* C1948 800D1148 3C00B38F */  lw         $s3, 0x3C($sp)
    /* C194C 800D114C 3800B28F */  lw         $s2, 0x38($sp)
    /* C1950 800D1150 3400B18F */  lw         $s1, 0x34($sp)
    /* C1954 800D1154 3000B08F */  lw         $s0, 0x30($sp)
    /* C1958 800D1158 0800E003 */  jr         $ra
    /* C195C 800D115C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hrz_BuildSky__Fv
