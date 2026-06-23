.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended, 0x12C

glabel ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3F288 8004EA88 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 3F28C 8004EA8C 4000B4AF */  sw         $s4, 0x40($sp)
    /* 3F290 8004EA90 5C00B48F */  lw         $s4, 0x5C($sp)
    /* 3F294 8004EA94 6000AA8F */  lw         $t2, 0x60($sp)
    /* 3F298 8004EA98 21488000 */  addu       $t1, $a0, $zero
    /* 3F29C 8004EA9C 3800B2AF */  sw         $s2, 0x38($sp)
    /* 3F2A0 8004EAA0 0200123C */  lui        $s2, (0x20000 >> 16)
    /* 3F2A4 8004EAA4 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 3F2A8 8004EAA8 0100133C */  lui        $s3, (0x10000 >> 16)
    /* 3F2AC 8004EAAC 4C00A5AF */  sw         $a1, 0x4C($sp)
    /* 3F2B0 8004EAB0 0800A530 */  andi       $a1, $a1, 0x8
    /* 3F2B4 8004EAB4 4400BFAF */  sw         $ra, 0x44($sp)
    /* 3F2B8 8004EAB8 3400B1AF */  sw         $s1, 0x34($sp)
    /* 3F2BC 8004EABC 3000B0AF */  sw         $s0, 0x30($sp)
    /* 3F2C0 8004EAC0 5000A6AF */  sw         $a2, 0x50($sp)
    /* 3F2C4 8004EAC4 0500A010 */  beqz       $a1, .L8004EADC
    /* 3F2C8 8004EAC8 5400A7AF */   sw        $a3, 0x54($sp)
    /* 3F2CC 8004EACC 0580023C */  lui        $v0, %hi(gHelpShapes)
    /* 3F2D0 8004EAD0 642A438C */  lw         $v1, %lo(gHelpShapes)($v0)
    /* 3F2D4 8004EAD4 BA3A0108 */  j          .L8004EAE8
    /* 3F2D8 8004EAD8 40110900 */   sll       $v0, $t1, 5
  .L8004EADC:
    /* 3F2DC 8004EADC 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 3F2E0 8004EAE0 CC17438C */  lw         $v1, %lo(gCurrentShapes)($v0)
    /* 3F2E4 8004EAE4 40110900 */  sll        $v0, $t1, 5
  .L8004EAE8:
    /* 3F2E8 8004EAE8 21806200 */  addu       $s0, $v1, $v0
    /* 3F2EC 8004EAEC 80000224 */  addiu      $v0, $zero, 0x80
    /* 3F2F0 8004EAF0 5800A48F */  lw         $a0, 0x58($sp)
    /* 3F2F4 8004EAF4 4C00A38F */  lw         $v1, 0x4C($sp)
    /* 3F2F8 8004EAF8 00000000 */  nop
    /* 3F2FC 8004EAFC 00026330 */  andi       $v1, $v1, 0x200
    /* 3F300 8004EB00 04006010 */  beqz       $v1, .L8004EB14
    /* 3F304 8004EB04 23404400 */   subu      $t0, $v0, $a0
    /* 3F308 8004EB08 1400438D */  lw         $v1, 0x14($t2)
    /* 3F30C 8004EB0C 40110900 */  sll        $v0, $t1, 5
    /* 3F310 8004EB10 21806200 */  addu       $s0, $v1, $v0
  .L8004EB14:
    /* 3F314 8004EB14 21200002 */  addu       $a0, $s0, $zero
    /* 3F318 8004EB18 5000A527 */  addiu      $a1, $sp, 0x50
    /* 3F31C 8004EB1C 5400A627 */  addiu      $a2, $sp, 0x54
    /* 3F320 8004EB20 4C00A727 */  addiu      $a3, $sp, 0x4C
    /* 3F324 8004EB24 00140800 */  sll        $v0, $t0, 16
    /* 3F328 8004EB28 03140200 */  sra        $v0, $v0, 16
    /* 3F32C 8004EB2C 2000B127 */  addiu      $s1, $sp, 0x20
    /* 3F330 8004EB30 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3F334 8004EB34 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3F338 8004EB38 CE37010C */  jal        AdjustShapeDrawing__FP18tTexture_ShapeInfoRiN21iPiP18tDrawShapeExtended
    /* 3F33C 8004EB3C 1800AAAF */   sw        $t2, 0x18($sp)
    /* 3F340 8004EB40 4C00A58F */  lw         $a1, 0x4C($sp)
    /* 3F344 8004EB44 00000000 */  nop
    /* 3F348 8004EB48 C000A230 */  andi       $v0, $a1, 0xC0
    /* 3F34C 8004EB4C 0A004010 */  beqz       $v0, .L8004EB78
    /* 3F350 8004EB50 21200002 */   addu      $a0, $s0, $zero
    /* 3F354 8004EB54 5000A68F */  lw         $a2, 0x50($sp)
    /* 3F358 8004EB58 5400A78F */  lw         $a3, 0x54($sp)
    /* 3F35C 8004EB5C 1000B2AF */  sw         $s2, 0x10($sp)
    /* 3F360 8004EB60 1400B3AF */  sw         $s3, 0x14($sp)
    /* 3F364 8004EB64 1800B1AF */  sw         $s1, 0x18($sp)
    /* 3F368 8004EB68 DF39010C */  jal        ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
    /* 3F36C 8004EB6C 1C00B4AF */   sw        $s4, 0x1C($sp)
    /* 3F370 8004EB70 E53A0108 */  j          .L8004EB94
    /* 3F374 8004EB74 00000000 */   nop
  .L8004EB78:
    /* 3F378 8004EB78 5000A68F */  lw         $a2, 0x50($sp)
    /* 3F37C 8004EB7C 5400A78F */  lw         $a3, 0x54($sp)
    /* 3F380 8004EB80 1000B2AF */  sw         $s2, 0x10($sp)
    /* 3F384 8004EB84 1400B3AF */  sw         $s3, 0x14($sp)
    /* 3F388 8004EB88 1800B1AF */  sw         $s1, 0x18($sp)
    /* 3F38C 8004EB8C 8E3A010C */  jal        ScaleFlatShape__FP18tTexture_ShapeInfoiiiiiPii
    /* 3F390 8004EB90 1C00B4AF */   sw        $s4, 0x1C($sp)
  .L8004EB94:
    /* 3F394 8004EB94 4400BF8F */  lw         $ra, 0x44($sp)
    /* 3F398 8004EB98 4000B48F */  lw         $s4, 0x40($sp)
    /* 3F39C 8004EB9C 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 3F3A0 8004EBA0 3800B28F */  lw         $s2, 0x38($sp)
    /* 3F3A4 8004EBA4 3400B18F */  lw         $s1, 0x34($sp)
    /* 3F3A8 8004EBA8 3000B08F */  lw         $s0, 0x30($sp)
    /* 3F3AC 8004EBAC 0800E003 */  jr         $ra
    /* 3F3B0 8004EBB0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
