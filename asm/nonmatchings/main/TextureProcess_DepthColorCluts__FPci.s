.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextureProcess_DepthColorCluts__FPci, 0xD8

glabel TextureProcess_DepthColorCluts__FPci
    /* D12C0 800E0AC0 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D12C4 800E0AC4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D12C8 800E0AC8 21988000 */  addu       $s3, $a0, $zero
    /* D12CC 800E0ACC 2400B1AF */  sw         $s1, 0x24($sp)
    /* D12D0 800E0AD0 2188A000 */  addu       $s1, $a1, $zero
    /* D12D4 800E0AD4 21200000 */  addu       $a0, $zero, $zero
    /* D12D8 800E0AD8 3000BFAF */  sw         $ra, 0x30($sp)
    /* D12DC 800E0ADC 2800B2AF */  sw         $s2, 0x28($sp)
    /* D12E0 800E0AE0 1FB6030C */  jal        DrawSync
    /* D12E4 800E0AE4 2000B0AF */   sw        $s0, 0x20($sp)
    /* D12E8 800E0AE8 21800000 */  addu       $s0, $zero, $zero
    /* D12EC 800E0AEC 1280023C */  lui        $v0, %hi(gClutDepth)
    /* D12F0 800E0AF0 7C105224 */  addiu      $s2, $v0, %lo(gClutDepth)
    /* D12F4 800E0AF4 1000022A */  slti       $v0, $s0, 0x10
  .L800E0AF8:
    /* D12F8 800E0AF8 1C004010 */  beqz       $v0, .L800E0B6C
    /* D12FC 800E0AFC 1100242A */   slti      $a0, $s1, 0x11
    /* D1300 800E0B00 01008438 */  xori       $a0, $a0, 0x1
    /* D1304 800E0B04 1800A527 */  addiu      $a1, $sp, 0x18
    /* D1308 800E0B08 4E7E030C */  jal        Texture_GetClutId__FiPiT1
    /* D130C 800E0B0C 1C00A627 */   addiu     $a2, $sp, 0x1C
    /* D1310 800E0B10 21200002 */  addu       $a0, $s0, $zero
    /* D1314 800E0B14 10000524 */  addiu      $a1, $zero, 0x10
    /* D1318 800E0B18 21306002 */  addu       $a2, $s3, $zero
    /* D131C 800E0B1C 40381000 */  sll        $a3, $s0, 1
    /* D1320 800E0B20 01001026 */  addiu      $s0, $s0, 0x1
    /* D1324 800E0B24 2C16828F */  lw         $v0, %gp_rel(TP_gZPaletteSystem)($gp)
    /* D1328 800E0B28 1C00A397 */  lhu        $v1, 0x1C($sp)
    /* D132C 800E0B2C 1800A88F */  lw         $t0, 0x18($sp)
    /* D1330 800E0B30 40110200 */  sll        $v0, $v0, 5
    /* D1334 800E0B34 2138E200 */  addu       $a3, $a3, $v0
    /* D1338 800E0B38 2138F200 */  addu       $a3, $a3, $s2
    /* D133C 800E0B3C 80190300 */  sll        $v1, $v1, 6
    /* D1340 800E0B40 03110800 */  sra        $v0, $t0, 4
    /* D1344 800E0B44 3F004230 */  andi       $v0, $v0, 0x3F
    /* D1348 800E0B48 25186200 */  or         $v1, $v1, $v0
    /* D134C 800E0B4C 0000E3A4 */  sh         $v1, 0x0($a3)
    /* D1350 800E0B50 1000A8AF */  sw         $t0, 0x10($sp)
    /* D1354 800E0B54 1C00A28F */  lw         $v0, 0x1C($sp)
    /* D1358 800E0B58 21382002 */  addu       $a3, $s1, $zero
    /* D135C 800E0B5C 2E82030C */  jal        TextureProcess_ColorClut__FiiPciii
    /* D1360 800E0B60 1400A2AF */   sw        $v0, 0x14($sp)
    /* D1364 800E0B64 BE820308 */  j          .L800E0AF8
    /* D1368 800E0B68 1000022A */   slti      $v0, $s0, 0x10
  .L800E0B6C:
    /* D136C 800E0B6C 2C16838F */  lw         $v1, %gp_rel(TP_gZPaletteSystem)($gp)
    /* D1370 800E0B70 3000BF8F */  lw         $ra, 0x30($sp)
    /* D1374 800E0B74 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D1378 800E0B78 2800B28F */  lw         $s2, 0x28($sp)
    /* D137C 800E0B7C 2400B18F */  lw         $s1, 0x24($sp)
    /* D1380 800E0B80 2000B08F */  lw         $s0, 0x20($sp)
    /* D1384 800E0B84 21106000 */  addu       $v0, $v1, $zero
    /* D1388 800E0B88 01006324 */  addiu      $v1, $v1, 0x1
    /* D138C 800E0B8C 2C1683AF */  sw         $v1, %gp_rel(TP_gZPaletteSystem)($gp)
    /* D1390 800E0B90 0800E003 */  jr         $ra
    /* D1394 800E0B94 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel TextureProcess_DepthColorCluts__FPci
