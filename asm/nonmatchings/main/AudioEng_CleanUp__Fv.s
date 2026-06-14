.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_CleanUp__Fv, 0xE0

glabel AudioEng_CleanUp__Fv
    /* 6CD34 8007C534 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6CD38 8007C538 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6CD3C 8007C53C FFFF1424 */  addiu      $s4, $zero, -0x1
    /* 6CD40 8007C540 2400B5AF */  sw         $s5, 0x24($sp)
    /* 6CD44 8007C544 1480153C */  lui        $s5, %hi(AudioEng_g)
    /* 6CD48 8007C548 34C7B526 */  addiu      $s5, $s5, %lo(AudioEng_g)
    /* 6CD4C 8007C54C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6CD50 8007C550 2198A002 */  addu       $s3, $s5, $zero
    /* 6CD54 8007C554 2800BFAF */  sw         $ra, 0x28($sp)
    /* 6CD58 8007C558 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6CD5C 8007C55C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6CD60 8007C560 1000B0AF */  sw         $s0, 0x10($sp)
  .L8007C564:
    /* 6CD64 8007C564 0800A226 */  addiu      $v0, $s5, 0x8
    /* 6CD68 8007C568 2A106202 */  slt        $v0, $s3, $v0
    /* 6CD6C 8007C56C 20004010 */  beqz       $v0, .L8007C5F0
    /* 6CD70 8007C570 00000000 */   nop
    /* 6CD74 8007C574 0000728E */  lw         $s2, 0x0($s3)
    /* 6CD78 8007C578 00000000 */  nop
    /* 6CD7C 8007C57C 1C004012 */  beqz       $s2, .L8007C5F0
    /* 6CD80 8007C580 21880000 */   addu      $s1, $zero, $zero
    /* 6CD84 8007C584 21804002 */  addu       $s0, $s2, $zero
  .L8007C588:
    /* 6CD88 8007C588 E401048E */  lw         $a0, 0x1E4($s0)
    /* 6CD8C 8007C58C 00000000 */  nop
    /* 6CD90 8007C590 0B009410 */  beq        $a0, $s4, .L8007C5C0
    /* 6CD94 8007C594 00000000 */   nop
    /* 6CD98 8007C598 A09F030C */  jal        SNDstop
    /* 6CD9C 8007C59C 00000000 */   nop
    /* 6CDA0 8007C5A0 A402048E */  lw         $a0, 0x2A4($s0)
    /* 6CDA4 8007C5A4 00000000 */  nop
    /* 6CDA8 8007C5A8 03009410 */  beq        $a0, $s4, .L8007C5B8
    /* 6CDAC 8007C5AC 00000000 */   nop
    /* 6CDB0 8007C5B0 A09F030C */  jal        SNDstop
    /* 6CDB4 8007C5B4 00000000 */   nop
  .L8007C5B8:
    /* 6CDB8 8007C5B8 E40114AE */  sw         $s4, 0x1E4($s0)
    /* 6CDBC 8007C5BC A40214AE */  sw         $s4, 0x2A4($s0)
  .L8007C5C0:
    /* 6CDC0 8007C5C0 01003126 */  addiu      $s1, $s1, 0x1
    /* 6CDC4 8007C5C4 1000222A */  slti       $v0, $s1, 0x10
    /* 6CDC8 8007C5C8 EFFF4014 */  bnez       $v0, .L8007C588
    /* 6CDCC 8007C5CC 0C001026 */   addiu     $s0, $s0, 0xC
    /* 6CDD0 8007C5D0 6C03448E */  lw         $a0, 0x36C($s2)
    /* 6CDD4 8007C5D4 5095030C */  jal        purgememadr
    /* 6CDD8 8007C5D8 00000000 */   nop
    /* 6CDDC 8007C5DC 5095030C */  jal        purgememadr
    /* 6CDE0 8007C5E0 21204002 */   addu      $a0, $s2, $zero
    /* 6CDE4 8007C5E4 000060AE */  sw         $zero, 0x0($s3)
    /* 6CDE8 8007C5E8 59F10108 */  j          .L8007C564
    /* 6CDEC 8007C5EC 04007326 */   addiu     $s3, $s3, 0x4
  .L8007C5F0:
    /* 6CDF0 8007C5F0 2800BF8F */  lw         $ra, 0x28($sp)
    /* 6CDF4 8007C5F4 2400B58F */  lw         $s5, 0x24($sp)
    /* 6CDF8 8007C5F8 2000B48F */  lw         $s4, 0x20($sp)
    /* 6CDFC 8007C5FC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6CE00 8007C600 1800B28F */  lw         $s2, 0x18($sp)
    /* 6CE04 8007C604 1400B18F */  lw         $s1, 0x14($sp)
    /* 6CE08 8007C608 1000B08F */  lw         $s0, 0x10($sp)
    /* 6CE0C 8007C60C 0800E003 */  jr         $ra
    /* 6CE10 8007C610 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AudioEng_CleanUp__Fv
