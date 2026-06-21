.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawShape_NFS4Rectangle__FR4RECT, 0x320

glabel DrawShape_NFS4Rectangle__FR4RECT
    /* 3C9BC 8004C1BC A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 3C9C0 8004C1C0 4000B0AF */  sw         $s0, 0x40($sp)
    /* 3C9C4 8004C1C4 21808000 */  addu       $s0, $a0, $zero
    /* 3C9C8 8004C1C8 7B00063C */  lui        $a2, (0x7B2908 >> 16)
    /* 3C9CC 8004C1CC 0829C634 */  ori        $a2, $a2, (0x7B2908 & 0xFFFF)
    /* 3C9D0 8004C1D0 1500053C */  lui        $a1, (0x150800 >> 16)
    /* 3C9D4 8004C1D4 0008A534 */  ori        $a1, $a1, (0x150800 & 0xFFFF)
    /* 3C9D8 8004C1D8 2900033C */  lui        $v1, (0x291000 >> 16)
    /* 3C9DC 8004C1DC 00106334 */  ori        $v1, $v1, (0x291000 & 0xFFFF)
    /* 3C9E0 8004C1E0 4A00023C */  lui        $v0, (0x4A1900 >> 16)
    /* 3C9E4 8004C1E4 00194234 */  ori        $v0, $v0, (0x4A1900 & 0xFFFF)
    /* 3C9E8 8004C1E8 2A000424 */  addiu      $a0, $zero, 0x2A
    /* 3C9EC 8004C1EC 3000A5AF */  sw         $a1, 0x30($sp)
    /* 3C9F0 8004C1F0 09000524 */  addiu      $a1, $zero, 0x9
    /* 3C9F4 8004C1F4 3800A2AF */  sw         $v0, 0x38($sp)
    /* 3C9F8 8004C1F8 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* 3C9FC 8004C1FC 5800BFAF */  sw         $ra, 0x58($sp)
    /* 3CA00 8004C200 5400B5AF */  sw         $s5, 0x54($sp)
    /* 3CA04 8004C204 5000B4AF */  sw         $s4, 0x50($sp)
    /* 3CA08 8004C208 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* 3CA0C 8004C20C 4800B2AF */  sw         $s2, 0x48($sp)
    /* 3CA10 8004C210 4400B1AF */  sw         $s1, 0x44($sp)
    /* 3CA14 8004C214 2C00A6AF */  sw         $a2, 0x2C($sp)
    /* 3CA18 8004C218 3400A3AF */  sw         $v1, 0x34($sp)
    /* 3CA1C 8004C21C 00000686 */  lh         $a2, 0x0($s0)
    /* 3CA20 8004C220 02000786 */  lh         $a3, 0x2($s0)
    /* 3CA24 8004C224 642A528C */  lw         $s2, %lo(gHelpShapes)($v0)
    /* 3CA28 8004C228 2800B127 */  addiu      $s1, $sp, 0x28
    /* 3CA2C 8004C22C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3CA30 8004C230 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3CA34 8004C234 1800B1AF */  sw         $s1, 0x18($sp)
    /* 3CA38 8004C238 40055526 */  addiu      $s5, $s2, 0x540
    /* 3CA3C 8004C23C 60055326 */  addiu      $s3, $s2, 0x560
    /* 3CA40 8004C240 80055426 */  addiu      $s4, $s2, 0x580
    /* 3CA44 8004C244 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3CA48 8004C248 A0055226 */   addiu     $s2, $s2, 0x5A0
    /* 3CA4C 8004C24C 2B000424 */  addiu      $a0, $zero, 0x2B
    /* 3CA50 8004C250 00000686 */  lh         $a2, 0x0($s0)
    /* 3CA54 8004C254 04000286 */  lh         $v0, 0x4($s0)
    /* 3CA58 8004C258 10006386 */  lh         $v1, 0x10($s3)
    /* 3CA5C 8004C25C 02000786 */  lh         $a3, 0x2($s0)
    /* 3CA60 8004C260 09000524 */  addiu      $a1, $zero, 0x9
    /* 3CA64 8004C264 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3CA68 8004C268 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3CA6C 8004C26C 1800B1AF */  sw         $s1, 0x18($sp)
    /* 3CA70 8004C270 2130C200 */  addu       $a2, $a2, $v0
    /* 3CA74 8004C274 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3CA78 8004C278 2330C300 */   subu      $a2, $a2, $v1
    /* 3CA7C 8004C27C 2C000424 */  addiu      $a0, $zero, 0x2C
    /* 3CA80 8004C280 00000686 */  lh         $a2, 0x0($s0)
    /* 3CA84 8004C284 02000786 */  lh         $a3, 0x2($s0)
    /* 3CA88 8004C288 06000286 */  lh         $v0, 0x6($s0)
    /* 3CA8C 8004C28C 12008386 */  lh         $v1, 0x12($s4)
    /* 3CA90 8004C290 09000524 */  addiu      $a1, $zero, 0x9
    /* 3CA94 8004C294 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3CA98 8004C298 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3CA9C 8004C29C 1800B1AF */  sw         $s1, 0x18($sp)
    /* 3CAA0 8004C2A0 2138E200 */  addu       $a3, $a3, $v0
    /* 3CAA4 8004C2A4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3CAA8 8004C2A8 2338E300 */   subu      $a3, $a3, $v1
    /* 3CAAC 8004C2AC 2D000424 */  addiu      $a0, $zero, 0x2D
    /* 3CAB0 8004C2B0 00000686 */  lh         $a2, 0x0($s0)
    /* 3CAB4 8004C2B4 04000886 */  lh         $t0, 0x4($s0)
    /* 3CAB8 8004C2B8 10004986 */  lh         $t1, 0x10($s2)
    /* 3CABC 8004C2BC 02000786 */  lh         $a3, 0x2($s0)
    /* 3CAC0 8004C2C0 06000286 */  lh         $v0, 0x6($s0)
    /* 3CAC4 8004C2C4 12004386 */  lh         $v1, 0x12($s2)
    /* 3CAC8 8004C2C8 09000524 */  addiu      $a1, $zero, 0x9
    /* 3CACC 8004C2CC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3CAD0 8004C2D0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 3CAD4 8004C2D4 1800B1AF */  sw         $s1, 0x18($sp)
    /* 3CAD8 8004C2D8 2130C800 */  addu       $a2, $a2, $t0
    /* 3CADC 8004C2DC 2330C900 */  subu       $a2, $a2, $t1
    /* 3CAE0 8004C2E0 2138E200 */  addu       $a3, $a3, $v0
    /* 3CAE4 8004C2E4 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3CAE8 8004C2E8 2338E300 */   subu      $a3, $a3, $v1
    /* 3CAEC 8004C2EC 00000586 */  lh         $a1, 0x0($s0)
    /* 3CAF0 8004C2F0 1000A286 */  lh         $v0, 0x10($s5)
    /* 3CAF4 8004C2F4 02000686 */  lh         $a2, 0x2($s0)
    /* 3CAF8 8004C2F8 04000786 */  lh         $a3, 0x4($s0)
    /* 3CAFC 8004C2FC 10006386 */  lh         $v1, 0x10($s3)
    /* 3CB00 8004C300 01001124 */  addiu      $s1, $zero, 0x1
    /* 3CB04 8004C304 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3CB08 8004C308 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CB0C 8004C30C 3000A48F */  lw         $a0, 0x30($sp)
    /* 3CB10 8004C310 2128A200 */  addu       $a1, $a1, $v0
    /* 3CB14 8004C314 2338E200 */  subu       $a3, $a3, $v0
    /* 3CB18 8004C318 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CB1C 8004C31C 2338E300 */   subu      $a3, $a3, $v1
    /* 3CB20 8004C320 00000586 */  lh         $a1, 0x0($s0)
    /* 3CB24 8004C324 10008386 */  lh         $v1, 0x10($s4)
    /* 3CB28 8004C328 02000686 */  lh         $a2, 0x2($s0)
    /* 3CB2C 8004C32C 06000286 */  lh         $v0, 0x6($s0)
    /* 3CB30 8004C330 04000786 */  lh         $a3, 0x4($s0)
    /* 3CB34 8004C334 10004886 */  lh         $t0, 0x10($s2)
    /* 3CB38 8004C338 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3CB3C 8004C33C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CB40 8004C340 2C00A48F */  lw         $a0, 0x2C($sp)
    /* 3CB44 8004C344 2128A300 */  addu       $a1, $a1, $v1
    /* 3CB48 8004C348 2130C200 */  addu       $a2, $a2, $v0
    /* 3CB4C 8004C34C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 3CB50 8004C350 2338E300 */  subu       $a3, $a3, $v1
    /* 3CB54 8004C354 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CB58 8004C358 2338E800 */   subu      $a3, $a3, $t0
    /* 3CB5C 8004C35C 00000486 */  lh         $a0, 0x0($s0)
    /* 3CB60 8004C360 02000586 */  lh         $a1, 0x2($s0)
    /* 3CB64 8004C364 1200A386 */  lh         $v1, 0x12($s5)
    /* 3CB68 8004C368 06000786 */  lh         $a3, 0x6($s0)
    /* 3CB6C 8004C36C 12008886 */  lh         $t0, 0x12($s4)
    /* 3CB70 8004C370 02000624 */  addiu      $a2, $zero, 0x2
    /* 3CB74 8004C374 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3CB78 8004C378 3400A28F */  lw         $v0, 0x34($sp)
    /* 3CB7C 8004C37C 2128A300 */  addu       $a1, $a1, $v1
    /* 3CB80 8004C380 2338E300 */  subu       $a3, $a3, $v1
    /* 3CB84 8004C384 1400A2AF */  sw         $v0, 0x14($sp)
    /* 3CB88 8004C388 1800A2AF */  sw         $v0, 0x18($sp)
    /* 3CB8C 8004C38C 3800A28F */  lw         $v0, 0x38($sp)
    /* 3CB90 8004C390 2338E800 */  subu       $a3, $a3, $t0
    /* 3CB94 8004C394 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 3CB98 8004C398 733B010C */  jal        PSXDrawTransGouraudSquare__Fiiiiiiiii
    /* 3CB9C 8004C39C 2000A2AF */   sw        $v0, 0x20($sp)
    /* 3CBA0 8004C3A0 00000486 */  lh         $a0, 0x0($s0)
    /* 3CBA4 8004C3A4 04000386 */  lh         $v1, 0x4($s0)
    /* 3CBA8 8004C3A8 02000586 */  lh         $a1, 0x2($s0)
    /* 3CBAC 8004C3AC 12006886 */  lh         $t0, 0x12($s3)
    /* 3CBB0 8004C3B0 06000786 */  lh         $a3, 0x6($s0)
    /* 3CBB4 8004C3B4 12004986 */  lh         $t1, 0x12($s2)
    /* 3CBB8 8004C3B8 02000624 */  addiu      $a2, $zero, 0x2
    /* 3CBBC 8004C3BC 1000B1AF */  sw         $s1, 0x10($sp)
    /* 3CBC0 8004C3C0 3400A28F */  lw         $v0, 0x34($sp)
    /* 3CBC4 8004C3C4 21208300 */  addu       $a0, $a0, $v1
    /* 3CBC8 8004C3C8 FEFF8424 */  addiu      $a0, $a0, -0x2
    /* 3CBCC 8004C3CC 2128A800 */  addu       $a1, $a1, $t0
    /* 3CBD0 8004C3D0 2338E800 */  subu       $a3, $a3, $t0
    /* 3CBD4 8004C3D4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 3CBD8 8004C3D8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 3CBDC 8004C3DC 3800A28F */  lw         $v0, 0x38($sp)
    /* 3CBE0 8004C3E0 2338E900 */  subu       $a3, $a3, $t1
    /* 3CBE4 8004C3E4 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 3CBE8 8004C3E8 733B010C */  jal        PSXDrawTransGouraudSquare__Fiiiiiiiii
    /* 3CBEC 8004C3EC 2000A2AF */   sw        $v0, 0x20($sp)
    /* 3CBF0 8004C3F0 00000586 */  lh         $a1, 0x0($s0)
    /* 3CBF4 8004C3F4 02000686 */  lh         $a2, 0x2($s0)
    /* 3CBF8 8004C3F8 1200A386 */  lh         $v1, 0x12($s5)
    /* 3CBFC 8004C3FC 1000A786 */  lh         $a3, 0x10($s5)
    /* 3CC00 8004C400 06000286 */  lh         $v0, 0x6($s0)
    /* 3CC04 8004C404 12008886 */  lh         $t0, 0x12($s4)
    /* 3CC08 8004C408 21200000 */  addu       $a0, $zero, $zero
    /* 3CC0C 8004C40C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CC10 8004C410 0200A524 */  addiu      $a1, $a1, 0x2
    /* 3CC14 8004C414 2130C300 */  addu       $a2, $a2, $v1
    /* 3CC18 8004C418 FEFFE724 */  addiu      $a3, $a3, -0x2
    /* 3CC1C 8004C41C 23104300 */  subu       $v0, $v0, $v1
    /* 3CC20 8004C420 23104800 */  subu       $v0, $v0, $t0
    /* 3CC24 8004C424 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CC28 8004C428 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3CC2C 8004C42C 00000586 */  lh         $a1, 0x0($s0)
    /* 3CC30 8004C430 04000886 */  lh         $t0, 0x4($s0)
    /* 3CC34 8004C434 02000686 */  lh         $a2, 0x2($s0)
    /* 3CC38 8004C438 12006386 */  lh         $v1, 0x12($s3)
    /* 3CC3C 8004C43C 10006786 */  lh         $a3, 0x10($s3)
    /* 3CC40 8004C440 06000286 */  lh         $v0, 0x6($s0)
    /* 3CC44 8004C444 12004986 */  lh         $t1, 0x12($s2)
    /* 3CC48 8004C448 21200000 */  addu       $a0, $zero, $zero
    /* 3CC4C 8004C44C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CC50 8004C450 2128A800 */  addu       $a1, $a1, $t0
    /* 3CC54 8004C454 FEFFA524 */  addiu      $a1, $a1, -0x2
    /* 3CC58 8004C458 2130C300 */  addu       $a2, $a2, $v1
    /* 3CC5C 8004C45C 23380700 */  negu       $a3, $a3
    /* 3CC60 8004C460 0200E724 */  addiu      $a3, $a3, 0x2
    /* 3CC64 8004C464 23104300 */  subu       $v0, $v0, $v1
    /* 3CC68 8004C468 23104900 */  subu       $v0, $v0, $t1
    /* 3CC6C 8004C46C B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CC70 8004C470 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3CC74 8004C474 00000586 */  lh         $a1, 0x0($s0)
    /* 3CC78 8004C478 1000A386 */  lh         $v1, 0x10($s5)
    /* 3CC7C 8004C47C 02000686 */  lh         $a2, 0x2($s0)
    /* 3CC80 8004C480 04000786 */  lh         $a3, 0x4($s0)
    /* 3CC84 8004C484 10006886 */  lh         $t0, 0x10($s3)
    /* 3CC88 8004C488 06000286 */  lh         $v0, 0x6($s0)
    /* 3CC8C 8004C48C 21200000 */  addu       $a0, $zero, $zero
    /* 3CC90 8004C490 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CC94 8004C494 2128A300 */  addu       $a1, $a1, $v1
    /* 3CC98 8004C498 2130D100 */  addu       $a2, $a2, $s1
    /* 3CC9C 8004C49C 2338E300 */  subu       $a3, $a3, $v1
    /* 3CCA0 8004C4A0 2338E800 */  subu       $a3, $a3, $t0
    /* 3CCA4 8004C4A4 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 3CCA8 8004C4A8 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CCAC 8004C4AC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3CCB0 8004C4B0 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 3CCB4 8004C4B4 21200000 */   addu      $a0, $zero, $zero
    /* 3CCB8 8004C4B8 5800BF8F */  lw         $ra, 0x58($sp)
    /* 3CCBC 8004C4BC 5400B58F */  lw         $s5, 0x54($sp)
    /* 3CCC0 8004C4C0 5000B48F */  lw         $s4, 0x50($sp)
    /* 3CCC4 8004C4C4 4C00B38F */  lw         $s3, 0x4C($sp)
    /* 3CCC8 8004C4C8 4800B28F */  lw         $s2, 0x48($sp)
    /* 3CCCC 8004C4CC 4400B18F */  lw         $s1, 0x44($sp)
    /* 3CCD0 8004C4D0 4000B08F */  lw         $s0, 0x40($sp)
    /* 3CCD4 8004C4D4 0800E003 */  jr         $ra
    /* 3CCD8 8004C4D8 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel DrawShape_NFS4Rectangle__FR4RECT
