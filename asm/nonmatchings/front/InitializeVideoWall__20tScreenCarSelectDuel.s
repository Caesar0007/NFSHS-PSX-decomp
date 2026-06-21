.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitializeVideoWall__20tScreenCarSelectDuel, 0x11C

glabel InitializeVideoWall__20tScreenCarSelectDuel
    /* 2D9E8 8003D1E8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 2D9EC 8003D1EC 2800B2AF */  sw         $s2, 0x28($sp)
    /* 2D9F0 8003D1F0 21908000 */  addu       $s2, $a0, $zero
    /* 2D9F4 8003D1F4 2400B1AF */  sw         $s1, 0x24($sp)
    /* 2D9F8 8003D1F8 04035126 */  addiu      $s1, $s2, 0x304
    /* 2D9FC 8003D1FC 21202002 */  addu       $a0, $s1, $zero
    /* 2DA00 8003D200 24014526 */  addiu      $a1, $s2, 0x124
    /* 2DA04 8003D204 3000B4AF */  sw         $s4, 0x30($sp)
    /* 2DA08 8003D208 05001424 */  addiu      $s4, $zero, 0x5
    /* 2DA0C 8003D20C 0580023C */  lui        $v0, %hi(D_80051F98)
    /* 2DA10 8003D210 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 2DA14 8003D214 981F5324 */  addiu      $s3, $v0, %lo(D_80051F98)
    /* 2DA18 8003D218 3400BFAF */  sw         $ra, 0x34($sp)
    /* 2DA1C 8003D21C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 2DA20 8003D220 1000B4AF */  sw         $s4, 0x10($sp)
    /* 2DA24 8003D224 1400B3AF */  sw         $s3, 0x14($sp)
    /* 2DA28 8003D228 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2DA2C 8003D22C 2800468E */  lw         $a2, 0x28($s2)
    /* 2DA30 8003D230 E4D9000C */  jal        Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 2DA34 8003D234 21380000 */   addu      $a3, $zero, $zero
    /* 2DA38 8003D238 21202002 */  addu       $a0, $s1, $zero
    /* 2DA3C 8003D23C F8000524 */  addiu      $a1, $zero, 0xF8
    /* 2DA40 8003D240 0E010624 */  addiu      $a2, $zero, 0x10E
    /* 2DA44 8003D244 63DA000C */  jal        SetAvailableText__10tVideoWallsss
    /* 2DA48 8003D248 2D000724 */   addiu     $a3, $zero, 0x2D
    /* 2DA4C 8003D24C 3A004296 */  lhu        $v0, 0x3A($s2)
    /* 2DA50 8003D250 00000000 */  nop
    /* 2DA54 8003D254 01004230 */  andi       $v0, $v0, 0x1
    /* 2DA58 8003D258 08004010 */  beqz       $v0, .L8003D27C
    /* 2DA5C 8003D25C 21202002 */   addu      $a0, $s1, $zero
    /* 2DA60 8003D260 06000524 */  addiu      $a1, $zero, 0x6
    /* 2DA64 8003D264 72DA000C */  jal        SetOffset__10tVideoWallss
    /* 2DA68 8003D268 21300000 */   addu      $a2, $zero, $zero
    /* 2DA6C 8003D26C 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2DA70 8003D270 21202002 */   addu      $a0, $s1, $zero
    /* 2DA74 8003D274 01000224 */  addiu      $v0, $zero, 0x1
    /* 2DA78 8003D278 840342AE */  sw         $v0, 0x384($s2)
  .L8003D27C:
    /* 2DA7C 8003D27C 3C035026 */  addiu      $s0, $s2, 0x33C
    /* 2DA80 8003D280 21200002 */  addu       $a0, $s0, $zero
    /* 2DA84 8003D284 14024526 */  addiu      $a1, $s2, 0x214
    /* 2DA88 8003D288 1000B4AF */  sw         $s4, 0x10($sp)
    /* 2DA8C 8003D28C 1400B3AF */  sw         $s3, 0x14($sp)
    /* 2DA90 8003D290 1800A0AF */  sw         $zero, 0x18($sp)
    /* 2DA94 8003D294 A803468E */  lw         $a2, 0x3A8($s2)
    /* 2DA98 8003D298 E4D9000C */  jal        Initialize__10tVideoWallP9tTVConfigP18tTexture_ShapeInfossPss
    /* 2DA9C 8003D29C 21380000 */   addu      $a3, $zero, $zero
    /* 2DAA0 8003D2A0 21202002 */  addu       $a0, $s1, $zero
    /* 2DAA4 8003D2A4 F8000524 */  addiu      $a1, $zero, 0xF8
    /* 2DAA8 8003D2A8 0E010624 */  addiu      $a2, $zero, 0x10E
    /* 2DAAC 8003D2AC 63DA000C */  jal        SetAvailableText__10tVideoWallsss
    /* 2DAB0 8003D2B0 96000724 */   addiu     $a3, $zero, 0x96
    /* 2DAB4 8003D2B4 BA034296 */  lhu        $v0, 0x3BA($s2)
    /* 2DAB8 8003D2B8 00000000 */  nop
    /* 2DABC 8003D2BC 01004230 */  andi       $v0, $v0, 0x1
    /* 2DAC0 8003D2C0 08004010 */  beqz       $v0, .L8003D2E4
    /* 2DAC4 8003D2C4 06000524 */   addiu     $a1, $zero, 0x6
    /* 2DAC8 8003D2C8 21200002 */  addu       $a0, $s0, $zero
    /* 2DACC 8003D2CC 72DA000C */  jal        SetOffset__10tVideoWallss
    /* 2DAD0 8003D2D0 69000624 */   addiu     $a2, $zero, 0x69
    /* 2DAD4 8003D2D4 10DA000C */  jal        UpdateImages__10tVideoWall
    /* 2DAD8 8003D2D8 21200002 */   addu      $a0, $s0, $zero
    /* 2DADC 8003D2DC 01000224 */  addiu      $v0, $zero, 0x1
    /* 2DAE0 8003D2E0 840342AE */  sw         $v0, 0x384($s2)
  .L8003D2E4:
    /* 2DAE4 8003D2E4 3400BF8F */  lw         $ra, 0x34($sp)
    /* 2DAE8 8003D2E8 3000B48F */  lw         $s4, 0x30($sp)
    /* 2DAEC 8003D2EC 2C00B38F */  lw         $s3, 0x2C($sp)
    /* 2DAF0 8003D2F0 2800B28F */  lw         $s2, 0x28($sp)
    /* 2DAF4 8003D2F4 2400B18F */  lw         $s1, 0x24($sp)
    /* 2DAF8 8003D2F8 2000B08F */  lw         $s0, 0x20($sp)
    /* 2DAFC 8003D2FC 0800E003 */  jr         $ra
    /* 2DB00 8003D300 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel InitializeVideoWall__20tScreenCarSelectDuel
