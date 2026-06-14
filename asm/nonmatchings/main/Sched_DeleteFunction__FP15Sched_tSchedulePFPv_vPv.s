.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv, 0xCC

glabel Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
    /* A6C34 800B6434 0400888C */  lw         $t0, 0x4($a0)
    /* A6C38 800B6438 00000000 */  nop
    /* A6C3C 800B643C 2E000011 */  beqz       $t0, .L800B64F8
    /* A6C40 800B6440 00000000 */   nop
    /* A6C44 800B6444 23000019 */  blez       $t0, .L800B64D4
    /* A6C48 800B6448 21180000 */   addu      $v1, $zero, $zero
    /* A6C4C 800B644C 21388000 */  addu       $a3, $a0, $zero
  .L800B6450:
    /* A6C50 800B6450 0C00E28C */  lw         $v0, 0xC($a3)
    /* A6C54 800B6454 00000000 */  nop
    /* A6C58 800B6458 19004514 */  bne        $v0, $a1, .L800B64C0
    /* A6C5C 800B645C 00490300 */   sll       $t1, $v1, 4
    /* A6C60 800B6460 1000E28C */  lw         $v0, 0x10($a3)
    /* A6C64 800B6464 00000000 */  nop
    /* A6C68 800B6468 15004614 */  bne        $v0, $a2, .L800B64C0
    /* A6C6C 800B646C FFFF0225 */   addiu     $v0, $t0, -0x1
    /* A6C70 800B6470 21286000 */  addu       $a1, $v1, $zero
    /* A6C74 800B6474 2A10A200 */  slt        $v0, $a1, $v0
    /* A6C78 800B6478 16004010 */  beqz       $v0, .L800B64D4
    /* A6C7C 800B647C 21182401 */   addu      $v1, $t1, $a0
  .L800B6480:
    /* A6C80 800B6480 18006A8C */  lw         $t2, 0x18($v1)
    /* A6C84 800B6484 1C006B8C */  lw         $t3, 0x1C($v1)
    /* A6C88 800B6488 20006C8C */  lw         $t4, 0x20($v1)
    /* A6C8C 800B648C 24006D8C */  lw         $t5, 0x24($v1)
    /* A6C90 800B6490 08006AAC */  sw         $t2, 0x8($v1)
    /* A6C94 800B6494 0C006BAC */  sw         $t3, 0xC($v1)
    /* A6C98 800B6498 10006CAC */  sw         $t4, 0x10($v1)
    /* A6C9C 800B649C 14006DAC */  sw         $t5, 0x14($v1)
    /* A6CA0 800B64A0 0400828C */  lw         $v0, 0x4($a0)
    /* A6CA4 800B64A4 0100A524 */  addiu      $a1, $a1, 0x1
    /* A6CA8 800B64A8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A6CAC 800B64AC 2A10A200 */  slt        $v0, $a1, $v0
    /* A6CB0 800B64B0 F3FF4014 */  bnez       $v0, .L800B6480
    /* A6CB4 800B64B4 10006324 */   addiu     $v1, $v1, 0x10
    /* A6CB8 800B64B8 35D90208 */  j          .L800B64D4
    /* A6CBC 800B64BC 00000000 */   nop
  .L800B64C0:
    /* A6CC0 800B64C0 0400888C */  lw         $t0, 0x4($a0)
    /* A6CC4 800B64C4 01006324 */  addiu      $v1, $v1, 0x1
    /* A6CC8 800B64C8 2A106800 */  slt        $v0, $v1, $t0
    /* A6CCC 800B64CC E0FF4014 */  bnez       $v0, .L800B6450
    /* A6CD0 800B64D0 1000E724 */   addiu     $a3, $a3, 0x10
  .L800B64D4:
    /* A6CD4 800B64D4 0400828C */  lw         $v0, 0x4($a0)
    /* A6CD8 800B64D8 FE7F0324 */  addiu      $v1, $zero, 0x7FFE
    /* A6CDC 800B64DC 00110200 */  sll        $v0, $v0, 4
    /* A6CE0 800B64E0 21108200 */  addu       $v0, $a0, $v0
    /* A6CE4 800B64E4 080043AC */  sw         $v1, 0x8($v0)
    /* A6CE8 800B64E8 0400828C */  lw         $v0, 0x4($a0)
    /* A6CEC 800B64EC 00000000 */  nop
    /* A6CF0 800B64F0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* A6CF4 800B64F4 040082AC */  sw         $v0, 0x4($a0)
  .L800B64F8:
    /* A6CF8 800B64F8 0800E003 */  jr         $ra
    /* A6CFC 800B64FC 00000000 */   nop
endlabel Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv
