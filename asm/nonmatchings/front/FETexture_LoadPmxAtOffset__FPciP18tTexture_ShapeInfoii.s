.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii, 0x2B8

glabel FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
    /* 3F900 8004F100 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 3F904 8004F104 5000B6AF */  sw         $s6, 0x50($sp)
    /* 3F908 8004F108 6800B68F */  lw         $s6, 0x68($sp)
    /* 3F90C 8004F10C 4400B3AF */  sw         $s3, 0x44($sp)
    /* 3F910 8004F110 2198C000 */  addu       $s3, $a2, $zero
    /* 3F914 8004F114 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 3F918 8004F118 21A8E000 */  addu       $s5, $a3, $zero
    /* 3F91C 8004F11C 5400BFAF */  sw         $ra, 0x54($sp)
    /* 3F920 8004F120 4800B4AF */  sw         $s4, 0x48($sp)
    /* 3F924 8004F124 4000B2AF */  sw         $s2, 0x40($sp)
    /* 3F928 8004F128 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 3F92C 8004F12C 3800B0AF */  sw         $s0, 0x38($sp)
    /* 3F930 8004F130 3000A0AF */  sw         $zero, 0x30($sp)
    /* 3F934 8004F134 AEC2030C */  jal        shapepointer
    /* 3F938 8004F138 3400A0AF */   sw        $zero, 0x34($sp)
    /* 3F93C 8004F13C 21904000 */  addu       $s2, $v0, $zero
    /* 3F940 8004F140 93004012 */  beqz       $s2, .L8004F390
    /* 3F944 8004F144 00000000 */   nop
    /* 3F948 8004F148 00004292 */  lbu        $v0, 0x0($s2)
    /* 3F94C 8004F14C 00000000 */  nop
    /* 3F950 8004F150 80005430 */  andi       $s4, $v0, 0x80
    /* 3F954 8004F154 1D008012 */  beqz       $s4, .L8004F1CC
    /* 3F958 8004F158 10005026 */   addiu     $s0, $s2, 0x10
    /* 3F95C 8004F15C 0190030C */  jal        unpacksize
    /* 3F960 8004F160 21200002 */   addu      $a0, $s0, $zero
    /* 3F964 8004F164 0180043C */  lui        $a0, %hi(D_80012848)
    /* 3F968 8004F168 48288424 */  addiu      $a0, $a0, %lo(D_80012848)
    /* 3F96C 8004F16C 10004524 */  addiu      $a1, $v0, 0x10
    /* 3F970 8004F170 CF94030C */  jal        reservememadr
    /* 3F974 8004F174 21300000 */   addu      $a2, $zero, $zero
    /* 3F978 8004F178 21884000 */  addu       $s1, $v0, $zero
    /* 3F97C 8004F17C 21204002 */  addu       $a0, $s2, $zero
    /* 3F980 8004F180 21282002 */  addu       $a1, $s1, $zero
    /* 3F984 8004F184 B798030C */  jal        blockmove
    /* 3F988 8004F188 10000624 */   addiu     $a2, $zero, 0x10
    /* 3F98C 8004F18C 21200002 */  addu       $a0, $s0, $zero
    /* 3F990 8004F190 C78F030C */  jal        unpack
    /* 3F994 8004F194 10002526 */   addiu     $a1, $s1, 0x10
    /* 3F998 8004F198 00002292 */  lbu        $v0, 0x0($s1)
    /* 3F99C 8004F19C 00000000 */  nop
    /* 3F9A0 8004F1A0 7F004230 */  andi       $v0, $v0, 0x7F
    /* 3F9A4 8004F1A4 000022A2 */  sb         $v0, 0x0($s1)
    /* 3F9A8 8004F1A8 0000428E */  lw         $v0, 0x0($s2)
    /* 3F9AC 8004F1AC 00002392 */  lbu        $v1, 0x0($s1)
    /* 3F9B0 8004F1B0 03120200 */  sra        $v0, $v0, 8
    /* 3F9B4 8004F1B4 21104202 */  addu       $v0, $s2, $v0
    /* 3F9B8 8004F1B8 23105100 */  subu       $v0, $v0, $s1
    /* 3F9BC 8004F1BC 00120200 */  sll        $v0, $v0, 8
    /* 3F9C0 8004F1C0 25186200 */  or         $v1, $v1, $v0
    /* 3F9C4 8004F1C4 743C0108 */  j          .L8004F1D0
    /* 3F9C8 8004F1C8 000023AE */   sw        $v1, 0x0($s1)
  .L8004F1CC:
    /* 3F9CC 8004F1CC 21884002 */  addu       $s1, $s2, $zero
  .L8004F1D0:
    /* 3F9D0 8004F1D0 00002292 */  lbu        $v0, 0x0($s1)
    /* 3F9D4 8004F1D4 00000000 */  nop
    /* 3F9D8 8004F1D8 03004430 */  andi       $a0, $v0, 0x3
    /* 3F9DC 8004F1DC 02000224 */  addiu      $v0, $zero, 0x2
    /* 3F9E0 8004F1E0 0A008210 */  beq        $a0, $v0, .L8004F20C
    /* 3F9E4 8004F1E4 3000A527 */   addiu     $a1, $sp, 0x30
    /* 3F9E8 8004F1E8 4E7E030C */  jal        Texture_GetClutId__FiPiT1
    /* 3F9EC 8004F1EC 3400A627 */   addiu     $a2, $sp, 0x34
    /* 3F9F0 8004F1F0 3400A38F */  lw         $v1, 0x34($sp)
    /* 3F9F4 8004F1F4 3000A28F */  lw         $v0, 0x30($sp)
    /* 3F9F8 8004F1F8 80190300 */  sll        $v1, $v1, 6
    /* 3F9FC 8004F1FC 03110200 */  sra        $v0, $v0, 4
    /* 3FA00 8004F200 3F004230 */  andi       $v0, $v0, 0x3F
    /* 3FA04 8004F204 25186200 */  or         $v1, $v1, $v0
    /* 3FA08 8004F208 040063AE */  sw         $v1, 0x4($s3)
  .L8004F20C:
    /* 3FA0C 8004F20C 21202002 */  addu       $a0, $s1, $zero
    /* 3FA10 8004F210 0000288E */  lw         $t0, 0x0($s1)
    /* 3FA14 8004F214 0400298E */  lw         $t1, 0x4($s1)
    /* 3FA18 8004F218 08002A8E */  lw         $t2, 0x8($s1)
    /* 3FA1C 8004F21C 0C002B8E */  lw         $t3, 0xC($s1)
    /* 3FA20 8004F220 1800A8AF */  sw         $t0, 0x18($sp)
    /* 3FA24 8004F224 1C00A9AF */  sw         $t1, 0x1C($sp)
    /* 3FA28 8004F228 2000AAAF */  sw         $t2, 0x20($sp)
    /* 3FA2C 8004F22C 2400ABAF */  sw         $t3, 0x24($sp)
    /* 3FA30 8004F230 1000288E */  lw         $t0, 0x10($s1)
    /* 3FA34 8004F234 00000000 */  nop
    /* 3FA38 8004F238 2800A8AF */  sw         $t0, 0x28($sp)
    /* 3FA3C 8004F23C 0C00268E */  lw         $a2, 0xC($s1)
    /* 3FA40 8004F240 3000A78F */  lw         $a3, 0x30($sp)
    /* 3FA44 8004F244 3400A28F */  lw         $v0, 0x34($sp)
    /* 3FA48 8004F248 002D0600 */  sll        $a1, $a2, 20
    /* 3FA4C 8004F24C 032D0500 */  sra        $a1, $a1, 20
    /* 3FA50 8004F250 2128B600 */  addu       $a1, $a1, $s6
    /* 3FA54 8004F254 00310600 */  sll        $a2, $a2, 4
    /* 3FA58 8004F258 03350600 */  sra        $a2, $a2, 20
    /* 3FA5C 8004F25C 2130D500 */  addu       $a2, $a2, $s5
    /* 3FA60 8004F260 6ADA030C */  jal        vramfxya
    /* 3FA64 8004F264 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3FA68 8004F268 000072AE */  sw         $s2, 0x0($s3)
    /* 3FA6C 8004F26C 00002292 */  lbu        $v0, 0x0($s1)
    /* 3FA70 8004F270 0C00638E */  lw         $v1, 0xC($s3)
    /* 3FA74 8004F274 00FF043C */  lui        $a0, (0xFF000000 >> 16)
    /* 3FA78 8004F278 090062A2 */  sb         $v0, 0x9($s3)
    /* 3FA7C 8004F27C 0000228E */  lw         $v0, 0x0($s1)
    /* 3FA80 8004F280 24186400 */  and        $v1, $v1, $a0
    /* 3FA84 8004F284 02120200 */  srl        $v0, $v0, 8
    /* 3FA88 8004F288 25186200 */  or         $v1, $v1, $v0
    /* 3FA8C 8004F28C 0C0063AE */  sw         $v1, 0xC($s3)
    /* 3FA90 8004F290 04002296 */  lhu        $v0, 0x4($s1)
    /* 3FA94 8004F294 00000000 */  nop
    /* 3FA98 8004F298 100062A6 */  sh         $v0, 0x10($s3)
    /* 3FA9C 8004F29C 06002296 */  lhu        $v0, 0x6($s1)
    /* 3FAA0 8004F2A0 00000000 */  nop
    /* 3FAA4 8004F2A4 120062A6 */  sh         $v0, 0x12($s3)
    /* 3FAA8 8004F2A8 08002296 */  lhu        $v0, 0x8($s1)
    /* 3FAAC 8004F2AC 00000000 */  nop
    /* 3FAB0 8004F2B0 140062A6 */  sh         $v0, 0x14($s3)
    /* 3FAB4 8004F2B4 0A002296 */  lhu        $v0, 0xA($s1)
    /* 3FAB8 8004F2B8 00000000 */  nop
    /* 3FABC 8004F2BC 160062A6 */  sh         $v0, 0x16($s3)
    /* 3FAC0 8004F2C0 0C00228E */  lw         $v0, 0xC($s1)
    /* 3FAC4 8004F2C4 00000000 */  nop
    /* 3FAC8 8004F2C8 00150200 */  sll        $v0, $v0, 20
    /* 3FACC 8004F2CC 03150200 */  sra        $v0, $v0, 20
    /* 3FAD0 8004F2D0 180062A6 */  sh         $v0, 0x18($s3)
    /* 3FAD4 8004F2D4 0C00228E */  lw         $v0, 0xC($s1)
    /* 3FAD8 8004F2D8 21202002 */  addu       $a0, $s1, $zero
    /* 3FADC 8004F2DC 00110200 */  sll        $v0, $v0, 4
    /* 3FAE0 8004F2E0 03150200 */  sra        $v0, $v0, 20
    /* 3FAE4 8004F2E4 F9D0030C */  jal        shapedepth
    /* 3FAE8 8004F2E8 1A0062A6 */   sh        $v0, 0x1A($s3)
    /* 3FAEC 8004F2EC 0400658E */  lw         $a1, 0x4($s3)
    /* 3FAF0 8004F2F0 09006692 */  lbu        $a2, 0x9($s3)
    /* 3FAF4 8004F2F4 1A006796 */  lhu        $a3, 0x1A($s3)
    /* 3FAF8 8004F2F8 18006396 */  lhu        $v1, 0x18($s3)
    /* 3FAFC 8004F2FC 080062A2 */  sb         $v0, 0x8($s3)
    /* 3FB00 8004F300 3F00A430 */  andi       $a0, $a1, 0x3F
    /* 3FB04 8004F304 00210400 */  sll        $a0, $a0, 4
    /* 3FB08 8004F308 83290500 */  sra        $a1, $a1, 6
    /* 3FB0C 8004F30C 0300C630 */  andi       $a2, $a2, 0x3
    /* 3FB10 8004F310 C0310600 */  sll        $a2, $a2, 7
    /* 3FB14 8004F314 0001E230 */  andi       $v0, $a3, 0x100
    /* 3FB18 8004F318 00140200 */  sll        $v0, $v0, 16
    /* 3FB1C 8004F31C 03150200 */  sra        $v0, $v0, 20
    /* 3FB20 8004F320 2530C200 */  or         $a2, $a2, $v0
    /* 3FB24 8004F324 FF036330 */  andi       $v1, $v1, 0x3FF
    /* 3FB28 8004F328 82190300 */  srl        $v1, $v1, 6
    /* 3FB2C 8004F32C 2530C300 */  or         $a2, $a2, $v1
    /* 3FB30 8004F330 0002E730 */  andi       $a3, $a3, 0x200
    /* 3FB34 8004F334 80380700 */  sll        $a3, $a3, 2
    /* 3FB38 8004F338 2530C700 */  or         $a2, $a2, $a3
    /* 3FB3C 8004F33C 14D1030C */  jal        GetClut
    /* 3FB40 8004F340 1C0066A6 */   sh        $a2, 0x1C($s3)
    /* 3FB44 8004F344 0300A016 */  bnez       $s5, .L8004F354
    /* 3FB48 8004F348 1E0062A6 */   sh        $v0, 0x1E($s3)
    /* 3FB4C 8004F34C 0C00C012 */  beqz       $s6, .L8004F380
    /* 3FB50 8004F350 00000000 */   nop
  .L8004F354:
    /* 3FB54 8004F354 1800A88F */  lw         $t0, 0x18($sp)
    /* 3FB58 8004F358 1C00A98F */  lw         $t1, 0x1C($sp)
    /* 3FB5C 8004F35C 2000AA8F */  lw         $t2, 0x20($sp)
    /* 3FB60 8004F360 2400AB8F */  lw         $t3, 0x24($sp)
    /* 3FB64 8004F364 000028AE */  sw         $t0, 0x0($s1)
    /* 3FB68 8004F368 040029AE */  sw         $t1, 0x4($s1)
    /* 3FB6C 8004F36C 08002AAE */  sw         $t2, 0x8($s1)
    /* 3FB70 8004F370 0C002BAE */  sw         $t3, 0xC($s1)
    /* 3FB74 8004F374 2800A88F */  lw         $t0, 0x28($sp)
    /* 3FB78 8004F378 00000000 */  nop
    /* 3FB7C 8004F37C 100028AE */  sw         $t0, 0x10($s1)
  .L8004F380:
    /* 3FB80 8004F380 03008012 */  beqz       $s4, .L8004F390
    /* 3FB84 8004F384 00000000 */   nop
    /* 3FB88 8004F388 5095030C */  jal        purgememadr
    /* 3FB8C 8004F38C 21202002 */   addu      $a0, $s1, $zero
  .L8004F390:
    /* 3FB90 8004F390 5400BF8F */  lw         $ra, 0x54($sp)
    /* 3FB94 8004F394 5000B68F */  lw         $s6, 0x50($sp)
    /* 3FB98 8004F398 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 3FB9C 8004F39C 4800B48F */  lw         $s4, 0x48($sp)
    /* 3FBA0 8004F3A0 4400B38F */  lw         $s3, 0x44($sp)
    /* 3FBA4 8004F3A4 4000B28F */  lw         $s2, 0x40($sp)
    /* 3FBA8 8004F3A8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 3FBAC 8004F3AC 3800B08F */  lw         $s0, 0x38($sp)
    /* 3FBB0 8004F3B0 0800E003 */  jr         $ra
    /* 3FBB4 8004F3B4 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel FETexture_LoadPmxAtOffset__FPciP18tTexture_ShapeInfoii
