.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_release, 0xFC

glabel STREAM_release
    /* EE2D0 800FDAD0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE2D4 800FDAD4 1800B0AF */  sw         $s0, 0x18($sp)
    /* EE2D8 800FDAD8 2180A000 */  addu       $s0, $a1, $zero
    /* EE2DC 800FDADC 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE2E0 800FDAE0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* EE2E4 800FDAE4 BEF0030C */  jal        validatehandle
    /* EE2E8 800FDAE8 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE2EC 800FDAEC 33004014 */  bnez       $v0, .L800FDBBC
    /* EE2F0 800FDAF0 00000000 */   nop
    /* EE2F4 800FDAF4 1000A48F */  lw         $a0, 0x10($sp)
    /* EE2F8 800FDAF8 00000000 */  nop
    /* EE2FC 800FDAFC 2000828C */  lw         $v0, 0x20($a0)
    /* EE300 800FDB00 00000000 */  nop
    /* EE304 800FDB04 2B100202 */  sltu       $v0, $s0, $v0
    /* EE308 800FDB08 2C004014 */  bnez       $v0, .L800FDBBC
    /* EE30C 800FDB0C 00000000 */   nop
    /* EE310 800FDB10 2400828C */  lw         $v0, 0x24($a0)
    /* EE314 800FDB14 00000000 */  nop
    /* EE318 800FDB18 F8FF4224 */  addiu      $v0, $v0, -0x8
    /* EE31C 800FDB1C 2B105000 */  sltu       $v0, $v0, $s0
    /* EE320 800FDB20 26004014 */  bnez       $v0, .L800FDBBC
    /* EE324 800FDB24 FEFF0324 */   addiu     $v1, $zero, -0x2
    /* EE328 800FDB28 0000028E */  lw         $v0, 0x0($s0)
    /* EE32C 800FDB2C 00000000 */  nop
    /* EE330 800FDB30 22004310 */  beq        $v0, $v1, .L800FDBBC
    /* EE334 800FDB34 00000000 */   nop
    /* EE338 800FDB38 0400058E */  lw         $a1, 0x4($s0)
    /* EE33C 800FDB3C DDF0030C */  jal        decbufferusage
    /* EE340 800FDB40 000003AE */   sw        $v1, 0x0($s0)
    /* EE344 800FDB44 00600540 */  mfc0       $a1, $12 /* handwritten instruction */
    /* EE348 800FDB48 00000000 */  nop
    /* EE34C 800FDB4C FEFB0124 */  addiu      $at, $zero, -0x402
    /* EE350 800FDB50 2440A100 */  and        $t0, $a1, $at
    /* EE354 800FDB54 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* EE358 800FDB58 00000000 */  nop
    /* EE35C 800FDB5C 00000000 */  nop
    /* EE360 800FDB60 00000000 */  nop
    /* EE364 800FDB64 1000A38F */  lw         $v1, 0x10($sp)
    /* EE368 800FDB68 00000000 */  nop
    /* EE36C 800FDB6C 2800648C */  lw         $a0, 0x28($v1)
    /* EE370 800FDB70 02000624 */  addiu      $a2, $zero, 0x2
    /* EE374 800FDB74 02008614 */  bne        $a0, $a2, .L800FDB80
    /* EE378 800FDB78 01000224 */   addiu     $v0, $zero, 0x1
    /* EE37C 800FDB7C 280062AC */  sw         $v0, 0x28($v1)
  .L800FDB80:
    /* EE380 800FDB80 00608540 */  mtc0       $a1, $12 /* handwritten instruction */
    /* EE384 800FDB84 0D008614 */  bne        $a0, $a2, .L800FDBBC
    /* EE388 800FDB88 00000000 */   nop
    /* EE38C 800FDB8C 1000A48F */  lw         $a0, 0x10($sp)
    /* EE390 800FDB90 00000000 */  nop
    /* EE394 800FDB94 3800828C */  lw         $v0, 0x38($a0)
    /* EE398 800FDB98 00000000 */  nop
    /* EE39C 800FDB9C 04004010 */  beqz       $v0, .L800FDBB0
    /* EE3A0 800FDBA0 00000000 */   nop
    /* EE3A4 800FDBA4 3000858C */  lw         $a1, 0x30($a0)
    /* EE3A8 800FDBA8 EDF60308 */  j          .L800FDBB4
    /* EE3AC 800FDBAC 00000000 */   nop
  .L800FDBB0:
    /* EE3B0 800FDBB0 2C00858C */  lw         $a1, 0x2C($a0)
  .L800FDBB4:
    /* EE3B4 800FDBB4 D1F2030C */  jal        restartstream
    /* EE3B8 800FDBB8 00000000 */   nop
  .L800FDBBC:
    /* EE3BC 800FDBBC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* EE3C0 800FDBC0 1800B08F */  lw         $s0, 0x18($sp)
    /* EE3C4 800FDBC4 0800E003 */  jr         $ra
    /* EE3C8 800FDBC8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_release
