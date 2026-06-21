.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawVideoWall__18tScreenTournSelect, 0x290

glabel DrawVideoWall__18tScreenTournSelect
    /* 303CC 8003FBCC B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 303D0 8003FBD0 4000B2AF */  sw         $s2, 0x40($sp)
    /* 303D4 8003FBD4 21908000 */  addu       $s2, $a0, $zero
    /* 303D8 8003FBD8 21280000 */  addu       $a1, $zero, $zero
    /* 303DC 8003FBDC 22000624 */  addiu      $a2, $zero, 0x22
    /* 303E0 8003FBE0 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 303E4 8003FBE4 F4001124 */  addiu      $s1, $zero, 0xF4
    /* 303E8 8003FBE8 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 303EC 8003FBEC 4800B4AF */  sw         $s4, 0x48($sp)
    /* 303F0 8003FBF0 4400B3AF */  sw         $s3, 0x44($sp)
    /* 303F4 8003FBF4 3800B0AF */  sw         $s0, 0x38($sp)
    /* 303F8 8003FBF8 2800428E */  lw         $v0, 0x28($s2)
    /* 303FC 8003FBFC 61001324 */  addiu      $s3, $zero, 0x61
    /* 30400 8003FC00 3400A2AF */  sw         $v0, 0x34($sp)
    /* 30404 8003FC04 1000A0AF */  sw         $zero, 0x10($sp)
    /* 30408 8003FC08 0000478E */  lw         $a3, 0x0($s2)
    /* 3040C 8003FC0C 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 30410 8003FC10 01001024 */   addiu     $s0, $zero, 0x1
    /* 30414 8003FC14 2000043C */  lui        $a0, (0x202020 >> 16)
  .L8003FC18:
    /* 30418 8003FC18 20208434 */  ori        $a0, $a0, (0x202020 & 0xFFFF)
    /* 3041C 8003FC1C 21282002 */  addu       $a1, $s1, $zero
    /* 30420 8003FC20 29000624 */  addiu      $a2, $zero, 0x29
    /* 30424 8003FC24 02000724 */  addiu      $a3, $zero, 0x2
    /* 30428 8003FC28 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3042C 8003FC2C B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 30430 8003FC30 1400B0AF */   sw        $s0, 0x14($sp)
    /* 30434 8003FC34 50003126 */  addiu      $s1, $s1, 0x50
    /* 30438 8003FC38 E501222A */  slti       $v0, $s1, 0x1E5
    /* 3043C 8003FC3C F6FF4014 */  bnez       $v0, .L8003FC18
    /* 30440 8003FC40 2000043C */   lui       $a0, (0x202020 >> 16)
    /* 30444 8003FC44 59001124 */  addiu      $s1, $zero, 0x59
    /* 30448 8003FC48 01001024 */  addiu      $s0, $zero, 0x1
    /* 3044C 8003FC4C 1400043C */  lui        $a0, (0x141414 >> 16)
  .L8003FC50:
    /* 30450 8003FC50 14148434 */  ori        $a0, $a0, (0x141414 & 0xFFFF)
    /* 30454 8003FC54 A5000524 */  addiu      $a1, $zero, 0xA5
    /* 30458 8003FC58 21302002 */  addu       $a2, $s1, $zero
    /* 3045C 8003FC5C 41010724 */  addiu      $a3, $zero, 0x141
    /* 30460 8003FC60 1000B0AF */  sw         $s0, 0x10($sp)
    /* 30464 8003FC64 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 30468 8003FC68 1400B0AF */   sw        $s0, 0x14($sp)
    /* 3046C 8003FC6C 30003126 */  addiu      $s1, $s1, 0x30
    /* 30470 8003FC70 8900222A */  slti       $v0, $s1, 0x89
    /* 30474 8003FC74 F6FF4014 */  bnez       $v0, .L8003FC50
    /* 30478 8003FC78 1400043C */   lui       $a0, (0x141414 >> 16)
    /* 3047C 8003FC7C B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 30480 8003FC80 02000424 */   addiu     $a0, $zero, 0x2
    /* 30484 8003FC84 1480023C */  lui        $v0, %hi(ticks)
    /* 30488 8003FC88 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 3048C 8003FC8C B402438E */  lw         $v1, 0x2B4($s2)
    /* 30490 8003FC90 00000000 */  nop
    /* 30494 8003FC94 23104300 */  subu       $v0, $v0, $v1
    /* 30498 8003FC98 B8024386 */  lh         $v1, 0x2B8($s2)
    /* 3049C 8003FC9C 00000000 */  nop
    /* 304A0 8003FCA0 1B006018 */  blez       $v1, .L8003FD10
    /* 304A4 8003FCA4 82880200 */   srl       $s1, $v0, 2
    /* 304A8 8003FCA8 36002012 */  beqz       $s1, .L8003FD84
    /* 304AC 8003FCAC 21800000 */   addu      $s0, $zero, $zero
    /* 304B0 8003FCB0 0580023C */  lui        $v0, %hi(D_80052058)
    /* 304B4 8003FCB4 58205324 */  addiu      $s3, $v0, %lo(D_80052058)
    /* 304B8 8003FCB8 0400022A */  slti       $v0, $s0, 0x4
  .L8003FCBC:
    /* 304BC 8003FCBC 31004010 */  beqz       $v0, .L8003FD84
    /* 304C0 8003FCC0 21101302 */   addu      $v0, $s0, $s3
    /* 304C4 8003FCC4 00004390 */  lbu        $v1, 0x0($v0)
    /* 304C8 8003FCC8 00000000 */  nop
    /* 304CC 8003FCCC 40100300 */  sll        $v0, $v1, 1
    /* 304D0 8003FCD0 21104300 */  addu       $v0, $v0, $v1
    /* 304D4 8003FCD4 00210200 */  sll        $a0, $v0, 4
    /* 304D8 8003FCD8 21104402 */  addu       $v0, $s2, $a0
    /* 304DC 8003FCDC EC01428C */  lw         $v0, 0x1EC($v0)
    /* 304E0 8003FCE0 00000000 */  nop
    /* 304E4 8003FCE4 04004014 */  bnez       $v0, .L8003FCF8
    /* 304E8 8003FCE8 00000000 */   nop
    /* 304EC 8003FCEC EC018424 */  addiu      $a0, $a0, 0x1EC
    /* 304F0 8003FCF0 8A8C000C */  jal        TurnOnTV__FR9tTVConfig
    /* 304F4 8003FCF4 21204402 */   addu      $a0, $s2, $a0
  .L8003FCF8:
    /* 304F8 8003FCF8 01001026 */  addiu      $s0, $s0, 0x1
    /* 304FC 8003FCFC 2A101102 */  slt        $v0, $s0, $s1
    /* 30500 8003FD00 20004010 */  beqz       $v0, .L8003FD84
    /* 30504 8003FD04 0400022A */   slti      $v0, $s0, 0x4
    /* 30508 8003FD08 2FFF0008 */  j          .L8003FCBC
    /* 3050C 8003FD0C 00000000 */   nop
  .L8003FD10:
    /* 30510 8003FD10 1800201A */  blez       $s1, .L8003FD74
    /* 30514 8003FD14 21800000 */   addu      $s0, $zero, $zero
    /* 30518 8003FD18 0580023C */  lui        $v0, %hi(D_80052058)
    /* 3051C 8003FD1C 58205424 */  addiu      $s4, $v0, %lo(D_80052058)
    /* 30520 8003FD20 01001324 */  addiu      $s3, $zero, 0x1
    /* 30524 8003FD24 0400022A */  slti       $v0, $s0, 0x4
  .L8003FD28:
    /* 30528 8003FD28 12004010 */  beqz       $v0, .L8003FD74
    /* 3052C 8003FD2C 21101402 */   addu      $v0, $s0, $s4
    /* 30530 8003FD30 00004390 */  lbu        $v1, 0x0($v0)
    /* 30534 8003FD34 00000000 */  nop
    /* 30538 8003FD38 40100300 */  sll        $v0, $v1, 1
    /* 3053C 8003FD3C 21104300 */  addu       $v0, $v0, $v1
    /* 30540 8003FD40 00210200 */  sll        $a0, $v0, 4
    /* 30544 8003FD44 21104402 */  addu       $v0, $s2, $a0
    /* 30548 8003FD48 EC01428C */  lw         $v0, 0x1EC($v0)
    /* 3054C 8003FD4C 00000000 */  nop
    /* 30550 8003FD50 04005314 */  bne        $v0, $s3, .L8003FD64
    /* 30554 8003FD54 00000000 */   nop
    /* 30558 8003FD58 EC018424 */  addiu      $a0, $a0, 0x1EC
    /* 3055C 8003FD5C 868C000C */  jal        TurnOffTV__FR9tTVConfig
    /* 30560 8003FD60 21204402 */   addu      $a0, $s2, $a0
  .L8003FD64:
    /* 30564 8003FD64 01001026 */  addiu      $s0, $s0, 0x1
    /* 30568 8003FD68 2A101102 */  slt        $v0, $s0, $s1
    /* 3056C 8003FD6C EEFF4014 */  bnez       $v0, .L8003FD28
    /* 30570 8003FD70 0400022A */   slti      $v0, $s0, 0x4
  .L8003FD74:
    /* 30574 8003FD74 0400222A */  slti       $v0, $s1, 0x4
    /* 30578 8003FD78 02004014 */  bnez       $v0, .L8003FD84
    /* 3057C 8003FD7C 00000000 */   nop
    /* 30580 8003FD80 B80240A6 */  sh         $zero, 0x2B8($s2)
  .L8003FD84:
    /* 30584 8003FD84 3000043C */  lui        $a0, (0x303030 >> 16)
    /* 30588 8003FD88 30308434 */  ori        $a0, $a0, (0x303030 & 0xFFFF)
    /* 3058C 8003FD8C F1000524 */  addiu      $a1, $zero, 0xF1
    /* 30590 8003FD90 8E000624 */  addiu      $a2, $zero, 0x8E
    /* 30594 8003FD94 02000724 */  addiu      $a3, $zero, 0x2
    /* 30598 8003FD98 4A000224 */  addiu      $v0, $zero, 0x4A
    /* 3059C 8003FD9C 01001024 */  addiu      $s0, $zero, 0x1
    /* 305A0 8003FDA0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 305A4 8003FDA4 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 305A8 8003FDA8 1400B0AF */   sw        $s0, 0x14($sp)
    /* 305AC 8003FDAC 2000043C */  lui        $a0, (0x202020 >> 16)
    /* 305B0 8003FDB0 20208434 */  ori        $a0, $a0, (0x202020 & 0xFFFF)
    /* 305B4 8003FDB4 A5000524 */  addiu      $a1, $zero, 0xA5
    /* 305B8 8003FDB8 B3000624 */  addiu      $a2, $zero, 0xB3
    /* 305BC 8003FDBC 98000724 */  addiu      $a3, $zero, 0x98
    /* 305C0 8003FDC0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 305C4 8003FDC4 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 305C8 8003FDC8 1400B0AF */   sw        $s0, 0x14($sp)
    /* 305CC 8003FDCC B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 305D0 8003FDD0 02000424 */   addiu     $a0, $zero, 0x2
    /* 305D4 8003FDD4 21880000 */  addu       $s1, $zero, $zero
    /* 305D8 8003FDD8 EC011024 */  addiu      $s0, $zero, 0x1EC
  .L8003FDDC:
    /* 305DC 8003FDDC D388000C */  jal        DrawTV__FR9tTVConfig
    /* 305E0 8003FDE0 21205002 */   addu      $a0, $s2, $s0
    /* 305E4 8003FDE4 01003126 */  addiu      $s1, $s1, 0x1
    /* 305E8 8003FDE8 0400222A */  slti       $v0, $s1, 0x4
    /* 305EC 8003FDEC FBFF4014 */  bnez       $v0, .L8003FDDC
    /* 305F0 8003FDF0 30001026 */   addiu     $s0, $s0, 0x30
    /* 305F4 8003FDF4 1480023C */  lui        $v0, %hi(ticks)
    /* 305F8 8003FDF8 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 305FC 8003FDFC 00000000 */  nop
    /* 30600 8003FE00 03110200 */  sra        $v0, $v0, 4
    /* 30604 8003FE04 02004104 */  bgez       $v0, .L8003FE10
    /* 30608 8003FE08 21204000 */   addu      $a0, $v0, $zero
    /* 3060C 8003FE0C 1F004424 */  addiu      $a0, $v0, 0x1F
  .L8003FE10:
    /* 30610 8003FE10 43210400 */  sra        $a0, $a0, 5
    /* 30614 8003FE14 40210400 */  sll        $a0, $a0, 5
    /* 30618 8003FE18 23204400 */  subu       $a0, $v0, $a0
    /* 3061C 8003FE1C 00060524 */  addiu      $a1, $zero, 0x600
    /* 30620 8003FE20 B6000624 */  addiu      $a2, $zero, 0xB6
    /* 30624 8003FE24 93000724 */  addiu      $a3, $zero, 0x93
    /* 30628 8003FE28 2000A227 */  addiu      $v0, $sp, 0x20
    /* 3062C 8003FE2C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 30630 8003FE30 1400A0AF */  sw         $zero, 0x14($sp)
    /* 30634 8003FE34 A23A010C */  jal        ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 30638 8003FE38 1800A2AF */   sw        $v0, 0x18($sp)
    /* 3063C 8003FE3C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 30640 8003FE40 4800B48F */  lw         $s4, 0x48($sp)
    /* 30644 8003FE44 4400B38F */  lw         $s3, 0x44($sp)
    /* 30648 8003FE48 4000B28F */  lw         $s2, 0x40($sp)
    /* 3064C 8003FE4C 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 30650 8003FE50 3800B08F */  lw         $s0, 0x38($sp)
    /* 30654 8003FE54 0800E003 */  jr         $ra
    /* 30658 8003FE58 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel DrawVideoWall__18tScreenTournSelect
