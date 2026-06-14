.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_SetEntry__FP19AudioMus_tSongEntry, 0x88

glabel AudioMus_SetEntry__FP19AudioMus_tSongEntry
    /* 6AB08 8007A308 0000868C */  lw         $a2, 0x0($a0)
    /* 6AB0C 8007A30C 21280000 */  addu       $a1, $zero, $zero
    /* 6AB10 8007A310 080080AC */  sw         $zero, 0x8($a0)
    /* 6AB14 8007A314 0C0080AC */  sw         $zero, 0xC($a0)
    /* 6AB18 8007A318 100080AC */  sw         $zero, 0x10($a0)
    /* 6AB1C 8007A31C 140080AC */  sw         $zero, 0x14($a0)
    /* 6AB20 8007A320 0000C390 */  lbu        $v1, 0x0($a2)
    /* 6AB24 8007A324 00000000 */  nop
    /* 6AB28 8007A328 14006010 */  beqz       $v1, .L8007A37C
    /* 6AB2C 8007A32C 2138A000 */   addu      $a3, $a1, $zero
    /* 6AB30 8007A330 2D000824 */  addiu      $t0, $zero, 0x2D
  .L8007A334:
    /* 6AB34 8007A334 08006814 */  bne        $v1, $t0, .L8007A358
    /* 6AB38 8007A338 1F00A228 */   slti      $v0, $a1, 0x1F
    /* 6AB3C 8007A33C 0400E014 */  bnez       $a3, .L8007A350
    /* 6AB40 8007A340 0100C224 */   addiu     $v0, $a2, 0x1
    /* 6AB44 8007A344 01000724 */  addiu      $a3, $zero, 0x1
    /* 6AB48 8007A348 DAE80108 */  j          .L8007A368
    /* 6AB4C 8007A34C 21280000 */   addu      $a1, $zero, $zero
  .L8007A350:
    /* 6AB50 8007A350 DFE80108 */  j          .L8007A37C
    /* 6AB54 8007A354 080082AC */   sw        $v0, 0x8($a0)
  .L8007A358:
    /* 6AB58 8007A358 03004010 */  beqz       $v0, .L8007A368
    /* 6AB5C 8007A35C 21108500 */   addu      $v0, $a0, $a1
    /* 6AB60 8007A360 200043A0 */  sb         $v1, 0x20($v0)
    /* 6AB64 8007A364 0100A524 */  addiu      $a1, $a1, 0x1
  .L8007A368:
    /* 6AB68 8007A368 0100C624 */  addiu      $a2, $a2, 0x1
    /* 6AB6C 8007A36C 0000C390 */  lbu        $v1, 0x0($a2)
    /* 6AB70 8007A370 00000000 */  nop
    /* 6AB74 8007A374 EFFF6014 */  bnez       $v1, .L8007A334
    /* 6AB78 8007A378 00000000 */   nop
  .L8007A37C:
    /* 6AB7C 8007A37C 21108500 */  addu       $v0, $a0, $a1
    /* 6AB80 8007A380 200040A0 */  sb         $zero, 0x20($v0)
    /* 6AB84 8007A384 20008224 */  addiu      $v0, $a0, 0x20
    /* 6AB88 8007A388 0800E003 */  jr         $ra
    /* 6AB8C 8007A38C 040082AC */   sw        $v0, 0x4($a0)
endlabel AudioMus_SetEntry__FP19AudioMus_tSongEntry
