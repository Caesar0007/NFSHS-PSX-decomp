.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching func_800FCB44, 0x29C

glabel func_800FCB44
    /* ED344 800FCB44 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* ED348 800FCB48 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* ED34C 800FCB4C 21888000 */  addu       $s1, $a0, $zero
    /* ED350 800FCB50 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* ED354 800FCB54 2800B4AF */  sw         $s4, 0x28($sp)
    /* ED358 800FCB58 2400B3AF */  sw         $s3, 0x24($sp)
    /* ED35C 800FCB5C 2000B2AF */  sw         $s2, 0x20($sp)
    /* ED360 800FCB60 1800B0AF */  sw         $s0, 0x18($sp)
    /* ED364 800FCB64 4000228E */  lw         $v0, 0x40($s1)
    /* ED368 800FCB68 4400238E */  lw         $v1, 0x44($s1)
    /* ED36C 800FCB6C 00000000 */  nop
    /* ED370 800FCB70 17004310 */  beq        $v0, $v1, .L800FCBD0
    /* ED374 800FCB74 21A0A000 */   addu      $s4, $a1, $zero
    /* ED378 800FCB78 FFFF0624 */  addiu      $a2, $zero, -0x1
    /* ED37C 800FCB7C FEFF0524 */  addiu      $a1, $zero, -0x2
    /* ED380 800FCB80 21206000 */  addu       $a0, $v1, $zero
  .L800FCB84:
    /* ED384 800FCB84 4000238E */  lw         $v1, 0x40($s1)
    /* ED388 800FCB88 00000000 */  nop
    /* ED38C 800FCB8C 0000628C */  lw         $v0, 0x0($v1)
    /* ED390 800FCB90 00000000 */  nop
    /* ED394 800FCB94 04004614 */  bne        $v0, $a2, .L800FCBA8
    /* ED398 800FCB98 00000000 */   nop
    /* ED39C 800FCB9C 2000228E */  lw         $v0, 0x20($s1)
    /* ED3A0 800FCBA0 F0F20308 */  j          .L800FCBC0
    /* ED3A4 800FCBA4 400022AE */   sw        $v0, 0x40($s1)
  .L800FCBA8:
    /* ED3A8 800FCBA8 09004514 */  bne        $v0, $a1, .L800FCBD0
    /* ED3AC 800FCBAC 00000000 */   nop
    /* ED3B0 800FCBB0 0400628C */  lw         $v0, 0x4($v1)
    /* ED3B4 800FCBB4 00000000 */  nop
    /* ED3B8 800FCBB8 21106200 */  addu       $v0, $v1, $v0
    /* ED3BC 800FCBBC 400022AE */  sw         $v0, 0x40($s1)
  .L800FCBC0:
    /* ED3C0 800FCBC0 4000228E */  lw         $v0, 0x40($s1)
    /* ED3C4 800FCBC4 00000000 */  nop
    /* ED3C8 800FCBC8 EEFF4414 */  bne        $v0, $a0, .L800FCB84
    /* ED3CC 800FCBCC 00000000 */   nop
  .L800FCBD0:
    /* ED3D0 800FCBD0 00601240 */  mfc0       $s2, $12 /* handwritten instruction */
    /* ED3D4 800FCBD4 00000000 */  nop
    /* ED3D8 800FCBD8 FEFB0124 */  addiu      $at, $zero, -0x402
    /* ED3DC 800FCBDC 24404102 */  and        $t0, $s2, $at
    /* ED3E0 800FCBE0 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* ED3E4 800FCBE4 00000000 */  nop
    /* ED3E8 800FCBE8 00000000 */  nop
    /* ED3EC 800FCBEC 00000000 */  nop
    /* ED3F0 800FCBF0 4C00308E */  lw         $s0, 0x4C($s1)
    /* ED3F4 800FCBF4 00000000 */  nop
    /* ED3F8 800FCBF8 0C00028E */  lw         $v0, 0xC($s0)
    /* ED3FC 800FCBFC 00000000 */  nop
    /* ED400 800FCC00 17004010 */  beqz       $v0, .L800FCC60
    /* ED404 800FCC04 00000000 */   nop
    /* ED408 800FCC08 01001324 */  addiu      $s3, $zero, 0x1
  .L800FCC0C:
    /* ED40C 800FCC0C 0C00038E */  lw         $v1, 0xC($s0)
    /* ED410 800FCC10 00000000 */  nop
    /* ED414 800FCC14 0400628C */  lw         $v0, 0x4($v1)
    /* ED418 800FCC18 00000000 */  nop
    /* ED41C 800FCC1C 10005310 */  beq        $v0, $s3, .L800FCC60
    /* ED420 800FCC20 00000000 */   nop
    /* ED424 800FCC24 4000248E */  lw         $a0, 0x40($s1)
    /* ED428 800FCC28 6000668C */  lw         $a2, 0x60($v1)
    /* ED42C 800FCC2C 4800258E */  lw         $a1, 0x48($s1)
    /* ED430 800FCC30 CDF0030C */  jal        func_800FC334
    /* ED434 800FCC34 FFFFC624 */   addiu     $a2, $a2, -0x1
    /* ED438 800FCC38 09004014 */  bnez       $v0, .L800FCC60
    /* ED43C 800FCC3C 21202002 */   addu      $a0, $s1, $zero
    /* ED440 800FCC40 52F1030C */  jal        func_800FC548
    /* ED444 800FCC44 21280002 */   addu      $a1, $s0, $zero
    /* ED448 800FCC48 4C00308E */  lw         $s0, 0x4C($s1)
    /* ED44C 800FCC4C 00000000 */  nop
    /* ED450 800FCC50 0C00028E */  lw         $v0, 0xC($s0)
    /* ED454 800FCC54 00000000 */  nop
    /* ED458 800FCC58 ECFF4014 */  bnez       $v0, .L800FCC0C
    /* ED45C 800FCC5C 00000000 */   nop
  .L800FCC60:
    /* ED460 800FCC60 00609240 */  mtc0       $s2, $12 /* handwritten instruction */
    /* ED464 800FCC64 4000268E */  lw         $a2, 0x40($s1)
    /* ED468 800FCC68 4800238E */  lw         $v1, 0x48($s1)
    /* ED46C 800FCC6C 00000000 */  nop
    /* ED470 800FCC70 2B106600 */  sltu       $v0, $v1, $a2
    /* ED474 800FCC74 03004010 */  beqz       $v0, .L800FCC84
    /* ED478 800FCC78 2310C300 */   subu      $v0, $a2, $v1
    /* ED47C 800FCC7C 3EF30308 */  j          .L800FCCF8
    /* ED480 800FCC80 FFFF4524 */   addiu     $a1, $v0, -0x1
  .L800FCC84:
    /* ED484 800FCC84 2400228E */  lw         $v0, 0x24($s1)
    /* ED488 800FCC88 00000000 */  nop
    /* ED48C 800FCC8C 23104300 */  subu       $v0, $v0, $v1
    /* ED490 800FCC90 F8FF4524 */  addiu      $a1, $v0, -0x8
    /* ED494 800FCC94 0020A228 */  slti       $v0, $a1, 0x2000
    /* ED498 800FCC98 1C004010 */  beqz       $v0, .L800FCD0C
    /* ED49C 800FCC9C 00000000 */   nop
    /* ED4A0 800FCCA0 4400258E */  lw         $a1, 0x44($s1)
    /* ED4A4 800FCCA4 2000248E */  lw         $a0, 0x20($s1)
    /* ED4A8 800FCCA8 23806500 */  subu       $s0, $v1, $a1
    /* ED4AC 800FCCAC 2310C400 */  subu       $v0, $a2, $a0
    /* ED4B0 800FCCB0 01000326 */  addiu      $v1, $s0, 0x1
    /* ED4B4 800FCCB4 2A104300 */  slt        $v0, $v0, $v1
    /* ED4B8 800FCCB8 12004014 */  bnez       $v0, .L800FCD04
    /* ED4BC 800FCCBC 02000224 */   addiu     $v0, $zero, 0x2
    /* ED4C0 800FCCC0 B1AA030C */  jal        memcpy
    /* ED4C4 800FCCC4 21300002 */   addu      $a2, $s0, $zero
    /* ED4C8 800FCCC8 4400238E */  lw         $v1, 0x44($s1)
    /* ED4CC 800FCCCC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* ED4D0 800FCCD0 000062AC */  sw         $v0, 0x0($v1)
    /* ED4D4 800FCCD4 08000224 */  addiu      $v0, $zero, 0x8
    /* ED4D8 800FCCD8 040062AC */  sw         $v0, 0x4($v1)
    /* ED4DC 800FCCDC 2000248E */  lw         $a0, 0x20($s1)
    /* ED4E0 800FCCE0 4000228E */  lw         $v0, 0x40($s1)
    /* ED4E4 800FCCE4 21189000 */  addu       $v1, $a0, $s0
    /* ED4E8 800FCCE8 23104300 */  subu       $v0, $v0, $v1
    /* ED4EC 800FCCEC FFFF4524 */  addiu      $a1, $v0, -0x1
    /* ED4F0 800FCCF0 440024AE */  sw         $a0, 0x44($s1)
    /* ED4F4 800FCCF4 480023AE */  sw         $v1, 0x48($s1)
  .L800FCCF8:
    /* ED4F8 800FCCF8 0020A228 */  slti       $v0, $a1, 0x2000
    /* ED4FC 800FCCFC 03004010 */  beqz       $v0, .L800FCD0C
    /* ED500 800FCD00 02000224 */   addiu     $v0, $zero, 0x2
  .L800FCD04:
    /* ED504 800FCD04 70F30308 */  j          .L800FCDC0
    /* ED508 800FCD08 280022AE */   sw        $v0, 0x28($s1)
  .L800FCD0C:
    /* ED50C 800FCD0C 5000308E */  lw         $s0, 0x50($s1)
    /* ED510 800FCD10 00000000 */  nop
    /* ED514 800FCD14 1000038E */  lw         $v1, 0x10($s0)
    /* ED518 800FCD18 01000224 */  addiu      $v0, $zero, 0x1
    /* ED51C 800FCD1C 19006214 */  bne        $v1, $v0, .L800FCD84
    /* ED520 800FCD20 00200224 */   addiu     $v0, $zero, 0x2000
    /* ED524 800FCD24 A000248E */  lw         $a0, 0xA0($s1)
    /* ED528 800FCD28 5800038E */  lw         $v1, 0x58($s0)
    /* ED52C 800FCD2C 21108500 */  addu       $v0, $a0, $a1
    /* ED530 800FCD30 2A106200 */  slt        $v0, $v1, $v0
    /* ED534 800FCD34 03004010 */  beqz       $v0, .L800FCD44
    /* ED538 800FCD38 23106400 */   subu      $v0, $v1, $a0
    /* ED53C 800FCD3C 52F30308 */  j          .L800FCD48
    /* ED540 800FCD40 A80022AE */   sw        $v0, 0xA8($s1)
  .L800FCD44:
    /* ED544 800FCD44 A80025AE */  sw         $a1, 0xA8($s1)
  .L800FCD48:
    /* ED548 800FCD48 4800248E */  lw         $a0, 0x48($s1)
    /* ED54C 800FCD4C 5400058E */  lw         $a1, 0x54($s0)
    /* ED550 800FCD50 A800268E */  lw         $a2, 0xA8($s1)
    /* ED554 800FCD54 B1AA030C */  jal        memcpy
    /* ED558 800FCD58 00000000 */   nop
    /* ED55C 800FCD5C 21200000 */  addu       $a0, $zero, $zero
    /* ED560 800FCD60 21288000 */  addu       $a1, $a0, $zero
    /* ED564 800FCD64 5400028E */  lw         $v0, 0x54($s0)
    /* ED568 800FCD68 A800238E */  lw         $v1, 0xA8($s1)
    /* ED56C 800FCD6C 21302002 */  addu       $a2, $s1, $zero
    /* ED570 800FCD70 21104300 */  addu       $v0, $v0, $v1
    /* ED574 800FCD74 2AF2030C */  jal        func_800FC8A8
    /* ED578 800FCD78 540002AE */   sw        $v0, 0x54($s0)
    /* ED57C 800FCD7C 70F30308 */  j          .L800FCDC0
    /* ED580 800FCD80 00000000 */   nop
  .L800FCD84:
    /* ED584 800FCD84 A80022AE */  sw         $v0, 0xA8($s1)
    /* ED588 800FCD88 1000B4AF */  sw         $s4, 0x10($sp)
    /* ED58C 800FCD8C 1400B1AF */  sw         $s1, 0x14($sp)
    /* ED590 800FCD90 9C00248E */  lw         $a0, 0x9C($s1)
    /* ED594 800FCD94 A000258E */  lw         $a1, 0xA0($s1)
    /* ED598 800FCD98 4800268E */  lw         $a2, 0x48($s1)
    /* ED59C 800FCD9C A800278E */  lw         $a3, 0xA8($s1)
    /* ED5A0 800FCDA0 3BB1030C */  jal        FILE_read
    /* ED5A4 800FCDA4 00000000 */   nop
    /* ED5A8 800FCDA8 05004010 */  beqz       $v0, .L800FCDC0
    /* ED5AC 800FCDAC A40022AE */   sw        $v0, 0xA4($s1)
    /* ED5B0 800FCDB0 21204000 */  addu       $a0, $v0, $zero
    /* ED5B4 800FCDB4 1080053C */  lui        $a1, %hi(func_800FC8A8)
    /* ED5B8 800FCDB8 93AF030C */  jal        FILE_callbackop
    /* ED5BC 800FCDBC A8C8A524 */   addiu     $a1, $a1, %lo(func_800FC8A8)
  .L800FCDC0:
    /* ED5C0 800FCDC0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* ED5C4 800FCDC4 2800B48F */  lw         $s4, 0x28($sp)
    /* ED5C8 800FCDC8 2400B38F */  lw         $s3, 0x24($sp)
    /* ED5CC 800FCDCC 2000B28F */  lw         $s2, 0x20($sp)
    /* ED5D0 800FCDD0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* ED5D4 800FCDD4 1800B08F */  lw         $s0, 0x18($sp)
    /* ED5D8 800FCDD8 0800E003 */  jr         $ra
    /* ED5DC 800FCDDC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel func_800FCB44
