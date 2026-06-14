.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching STREAM_queuefile, 0x114

glabel STREAM_queuefile
    /* EDB14 800FD314 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EDB18 800FD318 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EDB1C 800FD31C 2188A000 */  addu       $s1, $a1, $zero
    /* EDB20 800FD320 2000B2AF */  sw         $s2, 0x20($sp)
    /* EDB24 800FD324 2190C000 */  addu       $s2, $a2, $zero
    /* EDB28 800FD328 2400B3AF */  sw         $s3, 0x24($sp)
    /* EDB2C 800FD32C 2198E000 */  addu       $s3, $a3, $zero
    /* EDB30 800FD330 1000A527 */  addiu      $a1, $sp, 0x10
    /* EDB34 800FD334 1400A627 */  addiu      $a2, $sp, 0x14
    /* EDB38 800FD338 2800BFAF */  sw         $ra, 0x28($sp)
    /* EDB3C 800FD33C BEF0030C */  jal        func_800FC2F8
    /* EDB40 800FD340 1800B0AF */   sw        $s0, 0x18($sp)
    /* EDB44 800FD344 31004014 */  bnez       $v0, .L800FD40C
    /* EDB48 800FD348 21100000 */   addu      $v0, $zero, $zero
    /* EDB4C 800FD34C 1000A48F */  lw         $a0, 0x10($sp)
    /* EDB50 800FD350 00F1030C */  jal        func_800FC400
    /* EDB54 800FD354 00000000 */   nop
    /* EDB58 800FD358 21804000 */  addu       $s0, $v0, $zero
    /* EDB5C 800FD35C 03000016 */  bnez       $s0, .L800FD36C
    /* EDB60 800FD360 14000426 */   addiu     $a0, $s0, 0x14
    /* EDB64 800FD364 03F50308 */  j          .L800FD40C
    /* EDB68 800FD368 21100000 */   addu      $v0, $zero, $zero
  .L800FD36C:
    /* EDB6C 800FD36C 21282002 */  addu       $a1, $s1, $zero
    /* EDB70 800FD370 3F000624 */  addiu      $a2, $zero, 0x3F
    /* EDB74 800FD374 41D8030C */  jal        strncpy
    /* EDB78 800FD378 100000AE */   sw        $zero, 0x10($s0)
    /* EDB7C 800FD37C 1000A48F */  lw         $a0, 0x10($sp)
    /* EDB80 800FD380 21280002 */  addu       $a1, $s0, $zero
    /* EDB84 800FD384 580012AE */  sw         $s2, 0x58($s0)
    /* EDB88 800FD388 1EF1030C */  jal        func_800FC478
    /* EDB8C 800FD38C 5C0013AE */   sw        $s3, 0x5C($s0)
    /* EDB90 800FD390 00600540 */  mfc0       $a1, $12 /* handwritten instruction */
    /* EDB94 800FD394 00000000 */  nop
    /* EDB98 800FD398 FEFB0124 */  addiu      $at, $zero, -0x402
    /* EDB9C 800FD39C 2440A100 */  and        $t0, $a1, $at
    /* EDBA0 800FD3A0 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* EDBA4 800FD3A4 00000000 */  nop
    /* EDBA8 800FD3A8 00000000 */  nop
    /* EDBAC 800FD3AC 00000000 */  nop
    /* EDBB0 800FD3B0 1000A38F */  lw         $v1, 0x10($sp)
    /* EDBB4 800FD3B4 00000000 */  nop
    /* EDBB8 800FD3B8 2800648C */  lw         $a0, 0x28($v1)
    /* EDBBC 800FD3BC 00000000 */  nop
    /* EDBC0 800FD3C0 02008014 */  bnez       $a0, .L800FD3CC
    /* EDBC4 800FD3C4 01000224 */   addiu     $v0, $zero, 0x1
    /* EDBC8 800FD3C8 280062AC */  sw         $v0, 0x28($v1)
  .L800FD3CC:
    /* EDBCC 800FD3CC 00608540 */  mtc0       $a1, $12 /* handwritten instruction */
    /* EDBD0 800FD3D0 0D008014 */  bnez       $a0, .L800FD408
    /* EDBD4 800FD3D4 00000000 */   nop
    /* EDBD8 800FD3D8 1000A48F */  lw         $a0, 0x10($sp)
    /* EDBDC 800FD3DC 00000000 */  nop
    /* EDBE0 800FD3E0 3800828C */  lw         $v0, 0x38($a0)
    /* EDBE4 800FD3E4 00000000 */  nop
    /* EDBE8 800FD3E8 04004010 */  beqz       $v0, .L800FD3FC
    /* EDBEC 800FD3EC 00000000 */   nop
    /* EDBF0 800FD3F0 3000858C */  lw         $a1, 0x30($a0)
    /* EDBF4 800FD3F4 00F50308 */  j          .L800FD400
    /* EDBF8 800FD3F8 00000000 */   nop
  .L800FD3FC:
    /* EDBFC 800FD3FC 2C00858C */  lw         $a1, 0x2C($a0)
  .L800FD400:
    /* EDC00 800FD400 6DF2030C */  jal        func_800FC9B4
    /* EDC04 800FD404 00000000 */   nop
  .L800FD408:
    /* EDC08 800FD408 0000028E */  lw         $v0, 0x0($s0)
  .L800FD40C:
    /* EDC0C 800FD40C 2800BF8F */  lw         $ra, 0x28($sp)
    /* EDC10 800FD410 2400B38F */  lw         $s3, 0x24($sp)
    /* EDC14 800FD414 2000B28F */  lw         $s2, 0x20($sp)
    /* EDC18 800FD418 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EDC1C 800FD41C 1800B08F */  lw         $s0, 0x18($sp)
    /* EDC20 800FD420 0800E003 */  jr         $ra
    /* EDC24 800FD424 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel STREAM_queuefile
