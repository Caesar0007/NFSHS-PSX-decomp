.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_Decompress__FPc, 0x90

glabel Replay_Decompress__FPc
    /* A4510 800B3D10 00008990 */  lbu        $t1, 0x0($a0)
    /* A4514 800B3D14 01000824 */  addiu      $t0, $zero, 0x1
    /* A4518 800B3D18 2A100901 */  slt        $v0, $t0, $t1
    /* A451C 800B3D1C 1D004010 */  beqz       $v0, .L800B3D94
    /* A4520 800B3D20 FF000A24 */   addiu     $t2, $zero, 0xFF
    /* A4524 800B3D24 21208800 */  addu       $a0, $a0, $t0
    /* A4528 800B3D28 1280023C */  lui        $v0, %hi(uncompressed_data)
    /* A452C 800B3D2C BCDB4524 */  addiu      $a1, $v0, %lo(uncompressed_data)
  .L800B3D30:
    /* A4530 800B3D30 00008290 */  lbu        $v0, 0x0($a0)
    /* A4534 800B3D34 00000000 */  nop
    /* A4538 800B3D38 0F004A14 */  bne        $v0, $t2, .L800B3D78
    /* A453C 800B3D3C 00000000 */   nop
    /* A4540 800B3D40 01008790 */  lbu        $a3, 0x1($a0)
    /* A4544 800B3D44 00000000 */  nop
    /* A4548 800B3D48 0800E010 */  beqz       $a3, .L800B3D6C
    /* A454C 800B3D4C 21180000 */   addu      $v1, $zero, $zero
    /* A4550 800B3D50 21308000 */  addu       $a2, $a0, $zero
  .L800B3D54:
    /* A4554 800B3D54 0200C290 */  lbu        $v0, 0x2($a2)
    /* A4558 800B3D58 01006324 */  addiu      $v1, $v1, 0x1
    /* A455C 800B3D5C 0000A2A0 */  sb         $v0, 0x0($a1)
    /* A4560 800B3D60 2A106700 */  slt        $v0, $v1, $a3
    /* A4564 800B3D64 FBFF4014 */  bnez       $v0, .L800B3D54
    /* A4568 800B3D68 0100A524 */   addiu     $a1, $a1, 0x1
  .L800B3D6C:
    /* A456C 800B3D6C 03008424 */  addiu      $a0, $a0, 0x3
    /* A4570 800B3D70 62CF0208 */  j          .L800B3D88
    /* A4574 800B3D74 03000825 */   addiu     $t0, $t0, 0x3
  .L800B3D78:
    /* A4578 800B3D78 0000A2A0 */  sb         $v0, 0x0($a1)
    /* A457C 800B3D7C 0100A524 */  addiu      $a1, $a1, 0x1
    /* A4580 800B3D80 01008424 */  addiu      $a0, $a0, 0x1
    /* A4584 800B3D84 01000825 */  addiu      $t0, $t0, 0x1
  .L800B3D88:
    /* A4588 800B3D88 2A100901 */  slt        $v0, $t0, $t1
    /* A458C 800B3D8C E8FF4014 */  bnez       $v0, .L800B3D30
    /* A4590 800B3D90 00000000 */   nop
  .L800B3D94:
    /* A4594 800B3D94 1280023C */  lui        $v0, %hi(uncompressed_data)
    /* A4598 800B3D98 0800E003 */  jr         $ra
    /* A459C 800B3D9C BCDB4224 */   addiu     $v0, $v0, %lo(uncompressed_data)
endlabel Replay_Decompress__FPc
