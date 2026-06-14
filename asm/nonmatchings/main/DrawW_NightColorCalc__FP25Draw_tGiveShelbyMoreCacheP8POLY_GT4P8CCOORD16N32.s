.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32, 0x45C

glabel DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
    /* B689C 800C609C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* B68A0 800C60A0 2400B1AF */  sw         $s1, 0x24($sp)
    /* B68A4 800C60A4 21888000 */  addu       $s1, $a0, $zero
    /* B68A8 800C60A8 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B68AC 800C60AC 2198A000 */  addu       $s3, $a1, $zero
    /* B68B0 800C60B0 2800B2AF */  sw         $s2, 0x28($sp)
    /* B68B4 800C60B4 2190C000 */  addu       $s2, $a2, $zero
    /* B68B8 800C60B8 3000B4AF */  sw         $s4, 0x30($sp)
    /* B68BC 800C60BC 3800B6AF */  sw         $s6, 0x38($sp)
    /* B68C0 800C60C0 5000B68F */  lw         $s6, 0x50($sp)
    /* B68C4 800C60C4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* B68C8 800C60C8 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* B68CC 800C60CC 3400B5AF */  sw         $s5, 0x34($sp)
    /* B68D0 800C60D0 2000B0AF */  sw         $s0, 0x20($sp)
    /* B68D4 800C60D4 D8002286 */  lh         $v0, 0xD8($s1)
    /* B68D8 800C60D8 5400B58F */  lw         $s5, 0x54($sp)
    /* B68DC 800C60DC 9F004314 */  bne        $v0, $v1, .L800C635C
    /* B68E0 800C60E0 21A0E000 */   addu      $s4, $a3, $zero
    /* B68E4 800C60E4 06012292 */  lbu        $v0, 0x106($s1)
    /* B68E8 800C60E8 00000000 */  nop
    /* B68EC 800C60EC 01004230 */  andi       $v0, $v0, 0x1
    /* B68F0 800C60F0 42004010 */  beqz       $v0, .L800C61FC
    /* B68F4 800C60F4 34002226 */   addiu     $v0, $s1, 0x34
    /* B68F8 800C60F8 00004C8C */  lw         $t4, 0x0($v0)
    /* B68FC 800C60FC 04004D8C */  lw         $t5, 0x4($v0)
    /* B6900 800C6100 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B6904 800C6104 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B6908 800C6108 08004C8C */  lw         $t4, 0x8($v0)
    /* B690C 800C610C 0C004D8C */  lw         $t5, 0xC($v0)
    /* B6910 800C6110 10004E8C */  lw         $t6, 0x10($v0)
    /* B6914 800C6114 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B6918 800C6118 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B691C 800C611C 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B6920 800C6120 14004C8C */  lw         $t4, 0x14($v0)
    /* B6924 800C6124 18004D8C */  lw         $t5, 0x18($v0)
    /* B6928 800C6128 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B692C 800C612C 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B6930 800C6130 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B6934 800C6134 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B6938 800C6138 000040CA */  lwc2       $0, 0x0($s2)
    /* B693C 800C613C 040041CA */  lwc2       $1, 0x4($s2)
    /* B6940 800C6140 00000000 */  nop
    /* B6944 800C6144 00000000 */  nop
    /* B6948 800C6148 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B694C 800C614C 1000B027 */  addiu      $s0, $sp, 0x10
    /* B6950 800C6150 000019EA */  swc2       $25, 0x0($s0)
    /* B6954 800C6154 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B6958 800C6158 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B695C 800C615C 000080CA */  lwc2       $0, 0x0($s4)
    /* B6960 800C6160 040081CA */  lwc2       $1, 0x4($s4)
    /* B6964 800C6164 00000000 */  nop
    /* B6968 800C6168 00000000 */  nop
    /* B696C 800C616C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6970 800C6170 21200002 */  addu       $a0, $s0, $zero
    /* B6974 800C6174 06004526 */  addiu      $a1, $s2, 0x6
    /* B6978 800C6178 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* B697C 800C617C 21302002 */   addu      $a2, $s1, $zero
    /* B6980 800C6180 000019EA */  swc2       $25, 0x0($s0)
    /* B6984 800C6184 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B6988 800C6188 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B698C 800C618C 0000C0CA */  lwc2       $0, 0x0($s6)
    /* B6990 800C6190 0400C1CA */  lwc2       $1, 0x4($s6)
    /* B6994 800C6194 00000000 */  nop
    /* B6998 800C6198 00000000 */  nop
    /* B699C 800C619C 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B69A0 800C61A0 21200002 */  addu       $a0, $s0, $zero
    /* B69A4 800C61A4 06008526 */  addiu      $a1, $s4, 0x6
    /* B69A8 800C61A8 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* B69AC 800C61AC 21302002 */   addu      $a2, $s1, $zero
    /* B69B0 800C61B0 000019EA */  swc2       $25, 0x0($s0)
    /* B69B4 800C61B4 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B69B8 800C61B8 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B69BC 800C61BC 0000A0CA */  lwc2       $0, 0x0($s5)
    /* B69C0 800C61C0 0400A1CA */  lwc2       $1, 0x4($s5)
    /* B69C4 800C61C4 00000000 */  nop
    /* B69C8 800C61C8 00000000 */  nop
    /* B69CC 800C61CC 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B69D0 800C61D0 21200002 */  addu       $a0, $s0, $zero
    /* B69D4 800C61D4 0600C526 */  addiu      $a1, $s6, 0x6
    /* B69D8 800C61D8 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* B69DC 800C61DC 21302002 */   addu      $a2, $s1, $zero
    /* B69E0 800C61E0 000019EA */  swc2       $25, 0x0($s0)
    /* B69E4 800C61E4 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B69E8 800C61E8 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B69EC 800C61EC 21200002 */  addu       $a0, $s0, $zero
    /* B69F0 800C61F0 0600A526 */  addiu      $a1, $s5, 0x6
    /* B69F4 800C61F4 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* B69F8 800C61F8 21302002 */   addu      $a2, $s1, $zero
  .L800C61FC:
    /* B69FC 800C61FC 06012292 */  lbu        $v0, 0x106($s1)
    /* B6A00 800C6200 00000000 */  nop
    /* B6A04 800C6204 02004230 */  andi       $v0, $v0, 0x2
    /* B6A08 800C6208 3E004010 */  beqz       $v0, .L800C6304
    /* B6A0C 800C620C 54002226 */   addiu     $v0, $s1, 0x54
    /* B6A10 800C6210 00004C8C */  lw         $t4, 0x0($v0)
    /* B6A14 800C6214 04004D8C */  lw         $t5, 0x4($v0)
    /* B6A18 800C6218 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B6A1C 800C621C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B6A20 800C6220 08004C8C */  lw         $t4, 0x8($v0)
    /* B6A24 800C6224 0C004D8C */  lw         $t5, 0xC($v0)
    /* B6A28 800C6228 10004E8C */  lw         $t6, 0x10($v0)
    /* B6A2C 800C622C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B6A30 800C6230 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B6A34 800C6234 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B6A38 800C6238 14004C8C */  lw         $t4, 0x14($v0)
    /* B6A3C 800C623C 18004D8C */  lw         $t5, 0x18($v0)
    /* B6A40 800C6240 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B6A44 800C6244 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B6A48 800C6248 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B6A4C 800C624C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B6A50 800C6250 000040CA */  lwc2       $0, 0x0($s2)
    /* B6A54 800C6254 040041CA */  lwc2       $1, 0x4($s2)
    /* B6A58 800C6258 00000000 */  nop
    /* B6A5C 800C625C 00000000 */  nop
    /* B6A60 800C6260 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6A64 800C6264 1000B027 */  addiu      $s0, $sp, 0x10
    /* B6A68 800C6268 000019EA */  swc2       $25, 0x0($s0)
    /* B6A6C 800C626C 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B6A70 800C6270 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B6A74 800C6274 000080CA */  lwc2       $0, 0x0($s4)
    /* B6A78 800C6278 040081CA */  lwc2       $1, 0x4($s4)
    /* B6A7C 800C627C 00000000 */  nop
    /* B6A80 800C6280 00000000 */  nop
    /* B6A84 800C6284 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6A88 800C6288 21200002 */  addu       $a0, $s0, $zero
    /* B6A8C 800C628C C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* B6A90 800C6290 06004526 */   addiu     $a1, $s2, 0x6
    /* B6A94 800C6294 000019EA */  swc2       $25, 0x0($s0)
    /* B6A98 800C6298 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B6A9C 800C629C 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B6AA0 800C62A0 0000C0CA */  lwc2       $0, 0x0($s6)
    /* B6AA4 800C62A4 0400C1CA */  lwc2       $1, 0x4($s6)
    /* B6AA8 800C62A8 00000000 */  nop
    /* B6AAC 800C62AC 00000000 */  nop
    /* B6AB0 800C62B0 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6AB4 800C62B4 21200002 */  addu       $a0, $s0, $zero
    /* B6AB8 800C62B8 C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* B6ABC 800C62BC 06008526 */   addiu     $a1, $s4, 0x6
    /* B6AC0 800C62C0 000019EA */  swc2       $25, 0x0($s0)
    /* B6AC4 800C62C4 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B6AC8 800C62C8 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B6ACC 800C62CC 0000A0CA */  lwc2       $0, 0x0($s5)
    /* B6AD0 800C62D0 0400A1CA */  lwc2       $1, 0x4($s5)
    /* B6AD4 800C62D4 00000000 */  nop
    /* B6AD8 800C62D8 00000000 */  nop
    /* B6ADC 800C62DC 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6AE0 800C62E0 21200002 */  addu       $a0, $s0, $zero
    /* B6AE4 800C62E4 C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* B6AE8 800C62E8 0600C526 */   addiu     $a1, $s6, 0x6
    /* B6AEC 800C62EC 000019EA */  swc2       $25, 0x0($s0)
    /* B6AF0 800C62F0 04001AEA */  swc2       $26, 0x4($s0) /* handwritten instruction */
    /* B6AF4 800C62F4 08001BEA */  swc2       $27, 0x8($s0) /* handwritten instruction */
    /* B6AF8 800C62F8 21200002 */  addu       $a0, $s0, $zero
    /* B6AFC 800C62FC C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* B6B00 800C6300 0600A526 */   addiu     $a1, $s5, 0x6
  .L800C6304:
    /* B6B04 800C6304 06004686 */  lh         $a2, 0x6($s2)
    /* B6B08 800C6308 1480053C */  lui        $a1, %hi(Chunk_lightTable)
    /* B6B0C 800C630C 18C8A58C */  lw         $a1, %lo(Chunk_lightTable)($a1)
    /* B6B10 800C6310 06008486 */  lh         $a0, 0x6($s4)
    /* B6B14 800C6314 0600A386 */  lh         $v1, 0x6($s5)
    /* B6B18 800C6318 0600C286 */  lh         $v0, 0x6($s6)
    /* B6B1C 800C631C 80300600 */  sll        $a2, $a2, 2
    /* B6B20 800C6320 2130C500 */  addu       $a2, $a2, $a1
    /* B6B24 800C6324 80200400 */  sll        $a0, $a0, 2
    /* B6B28 800C6328 21208500 */  addu       $a0, $a0, $a1
    /* B6B2C 800C632C 80180300 */  sll        $v1, $v1, 2
    /* B6B30 800C6330 21186500 */  addu       $v1, $v1, $a1
    /* B6B34 800C6334 80100200 */  sll        $v0, $v0, 2
    /* B6B38 800C6338 21104500 */  addu       $v0, $v0, $a1
    /* B6B3C 800C633C 0000C58C */  lw         $a1, 0x0($a2)
    /* B6B40 800C6340 0000848C */  lw         $a0, 0x0($a0)
    /* B6B44 800C6344 0000638C */  lw         $v1, 0x0($v1)
    /* B6B48 800C6348 0000428C */  lw         $v0, 0x0($v0)
    /* B6B4C 800C634C 040065AE */  sw         $a1, 0x4($s3)
    /* B6B50 800C6350 100064AE */  sw         $a0, 0x10($s3)
    /* B6B54 800C6354 22190308 */  j          .L800C6488
    /* B6B58 800C6358 1C0063AE */   sw        $v1, 0x1C($s3)
  .L800C635C:
    /* B6B5C 800C635C 06012292 */  lbu        $v0, 0x106($s1)
    /* B6B60 800C6360 00000000 */  nop
    /* B6B64 800C6364 01004230 */  andi       $v0, $v0, 0x1
    /* B6B68 800C6368 1D004010 */  beqz       $v0, .L800C63E0
    /* B6B6C 800C636C 34002226 */   addiu     $v0, $s1, 0x34
    /* B6B70 800C6370 00004C8C */  lw         $t4, 0x0($v0)
    /* B6B74 800C6374 04004D8C */  lw         $t5, 0x4($v0)
    /* B6B78 800C6378 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B6B7C 800C637C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B6B80 800C6380 08004C8C */  lw         $t4, 0x8($v0)
    /* B6B84 800C6384 0C004D8C */  lw         $t5, 0xC($v0)
    /* B6B88 800C6388 10004E8C */  lw         $t6, 0x10($v0)
    /* B6B8C 800C638C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B6B90 800C6390 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B6B94 800C6394 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B6B98 800C6398 14004C8C */  lw         $t4, 0x14($v0)
    /* B6B9C 800C639C 18004D8C */  lw         $t5, 0x18($v0)
    /* B6BA0 800C63A0 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B6BA4 800C63A4 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B6BA8 800C63A8 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B6BAC 800C63AC 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B6BB0 800C63B0 000040CA */  lwc2       $0, 0x0($s2)
    /* B6BB4 800C63B4 040041CA */  lwc2       $1, 0x4($s2)
    /* B6BB8 800C63B8 00000000 */  nop
    /* B6BBC 800C63BC 00000000 */  nop
    /* B6BC0 800C63C0 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6BC4 800C63C4 1000A427 */  addiu      $a0, $sp, 0x10
    /* B6BC8 800C63C8 000099E8 */  swc2       $25, 0x0($a0)
    /* B6BCC 800C63CC 04009AE8 */  swc2       $26, 0x4($a0) /* handwritten instruction */
    /* B6BD0 800C63D0 08009BE8 */  swc2       $27, 0x8($a0) /* handwritten instruction */
    /* B6BD4 800C63D4 D8002526 */  addiu      $a1, $s1, 0xD8
    /* B6BD8 800C63D8 EE17030C */  jal        Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache
    /* B6BDC 800C63DC 21302002 */   addu      $a2, $s1, $zero
  .L800C63E0:
    /* B6BE0 800C63E0 06012292 */  lbu        $v0, 0x106($s1)
    /* B6BE4 800C63E4 00000000 */  nop
    /* B6BE8 800C63E8 02004230 */  andi       $v0, $v0, 0x2
    /* B6BEC 800C63EC 1C004010 */  beqz       $v0, .L800C6460
    /* B6BF0 800C63F0 54002226 */   addiu     $v0, $s1, 0x54
    /* B6BF4 800C63F4 00004C8C */  lw         $t4, 0x0($v0)
    /* B6BF8 800C63F8 04004D8C */  lw         $t5, 0x4($v0)
    /* B6BFC 800C63FC 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B6C00 800C6400 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B6C04 800C6404 08004C8C */  lw         $t4, 0x8($v0)
    /* B6C08 800C6408 0C004D8C */  lw         $t5, 0xC($v0)
    /* B6C0C 800C640C 10004E8C */  lw         $t6, 0x10($v0)
    /* B6C10 800C6410 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B6C14 800C6414 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B6C18 800C6418 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B6C1C 800C641C 14004C8C */  lw         $t4, 0x14($v0)
    /* B6C20 800C6420 18004D8C */  lw         $t5, 0x18($v0)
    /* B6C24 800C6424 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B6C28 800C6428 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B6C2C 800C642C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B6C30 800C6430 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B6C34 800C6434 000040CA */  lwc2       $0, 0x0($s2)
    /* B6C38 800C6438 040041CA */  lwc2       $1, 0x4($s2)
    /* B6C3C 800C643C 00000000 */  nop
    /* B6C40 800C6440 00000000 */  nop
    /* B6C44 800C6444 1200484A */  .word 0x4A480012  /* mvmva      1, 0, 0, 0, 0 */
    /* B6C48 800C6448 1000A427 */  addiu      $a0, $sp, 0x10
    /* B6C4C 800C644C 000099E8 */  swc2       $25, 0x0($a0)
    /* B6C50 800C6450 04009AE8 */  swc2       $26, 0x4($a0) /* handwritten instruction */
    /* B6C54 800C6454 08009BE8 */  swc2       $27, 0x8($a0) /* handwritten instruction */
    /* B6C58 800C6458 C617030C */  jal        Night_NightCopCalc__FP6VECTORPs
    /* B6C5C 800C645C D8002526 */   addiu     $a1, $s1, 0xD8
  .L800C6460:
    /* B6C60 800C6460 D8002286 */  lh         $v0, 0xD8($s1)
    /* B6C64 800C6464 1480033C */  lui        $v1, %hi(Chunk_lightTable)
    /* B6C68 800C6468 18C8638C */  lw         $v1, %lo(Chunk_lightTable)($v1)
    /* B6C6C 800C646C 80100200 */  sll        $v0, $v0, 2
    /* B6C70 800C6470 21104300 */  addu       $v0, $v0, $v1
    /* B6C74 800C6474 0000428C */  lw         $v0, 0x0($v0)
    /* B6C78 800C6478 00000000 */  nop
    /* B6C7C 800C647C 040062AE */  sw         $v0, 0x4($s3)
    /* B6C80 800C6480 100062AE */  sw         $v0, 0x10($s3)
    /* B6C84 800C6484 1C0062AE */  sw         $v0, 0x1C($s3)
  .L800C6488:
    /* B6C88 800C6488 280062AE */  sw         $v0, 0x28($s3)
    /* B6C8C 800C648C 14002226 */  addiu      $v0, $s1, 0x14
    /* B6C90 800C6490 00004C8C */  lw         $t4, 0x0($v0)
    /* B6C94 800C6494 04004D8C */  lw         $t5, 0x4($v0)
    /* B6C98 800C6498 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* B6C9C 800C649C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* B6CA0 800C64A0 08004C8C */  lw         $t4, 0x8($v0)
    /* B6CA4 800C64A4 0C004D8C */  lw         $t5, 0xC($v0)
    /* B6CA8 800C64A8 10004E8C */  lw         $t6, 0x10($v0)
    /* B6CAC 800C64AC 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* B6CB0 800C64B0 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* B6CB4 800C64B4 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* B6CB8 800C64B8 14004C8C */  lw         $t4, 0x14($v0)
    /* B6CBC 800C64BC 18004D8C */  lw         $t5, 0x18($v0)
    /* B6CC0 800C64C0 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B6CC4 800C64C4 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B6CC8 800C64C8 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B6CCC 800C64CC 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B6CD0 800C64D0 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* B6CD4 800C64D4 3800B68F */  lw         $s6, 0x38($sp)
    /* B6CD8 800C64D8 3400B58F */  lw         $s5, 0x34($sp)
    /* B6CDC 800C64DC 3000B48F */  lw         $s4, 0x30($sp)
    /* B6CE0 800C64E0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* B6CE4 800C64E4 2800B28F */  lw         $s2, 0x28($sp)
    /* B6CE8 800C64E8 2400B18F */  lw         $s1, 0x24($sp)
    /* B6CEC 800C64EC 2000B08F */  lw         $s0, 0x20($sp)
    /* B6CF0 800C64F0 0800E003 */  jr         $ra
    /* B6CF4 800C64F4 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32
