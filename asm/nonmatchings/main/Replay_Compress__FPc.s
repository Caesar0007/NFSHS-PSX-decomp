.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Replay_Compress__FPc, 0xC4

glabel Replay_Compress__FPc
    /* A444C 800B3C4C 21480000 */  addu       $t1, $zero, $zero
    /* A4450 800B3C50 01000724 */  addiu      $a3, $zero, 0x1
    /* A4454 800B3C54 FF000D24 */  addiu      $t5, $zero, 0xFF
    /* A4458 800B3C58 1280023C */  lui        $v0, %hi(compressed_data)
    /* A445C 800B3C5C 98DB4C24 */  addiu      $t4, $v0, %lo(compressed_data)
    /* A4460 800B3C60 21308701 */  addu       $a2, $t4, $a3
    /* A4464 800B3C64 20008B24 */  addiu      $t3, $a0, 0x20
    /* A4468 800B3C68 21506001 */  addu       $t2, $t3, $zero
  .L800B3C6C:
    /* A446C 800B3C6C 00008890 */  lbu        $t0, 0x0($a0)
    /* A4470 800B3C70 21280000 */  addu       $a1, $zero, $zero
    /* A4474 800B3C74 FF000331 */  andi       $v1, $t0, 0xFF
    /* A4478 800B3C78 01008424 */  addiu      $a0, $a0, 0x1
  .L800B3C7C:
    /* A447C 800B3C7C 00008290 */  lbu        $v0, 0x0($a0)
    /* A4480 800B3C80 00000000 */  nop
    /* A4484 800B3C84 05004314 */  bne        $v0, $v1, .L800B3C9C
    /* A4488 800B3C88 0100A524 */   addiu     $a1, $a1, 0x1
    /* A448C 800B3C8C 2A108A00 */  slt        $v0, $a0, $t2
    /* A4490 800B3C90 FAFF4014 */  bnez       $v0, .L800B3C7C
    /* A4494 800B3C94 01008424 */   addiu     $a0, $a0, 0x1
    /* A4498 800B3C98 FFFF8424 */  addiu      $a0, $a0, -0x1
  .L800B3C9C:
    /* A449C 800B3C9C 0300A228 */  slti       $v0, $a1, 0x3
    /* A44A0 800B3CA0 08004014 */  bnez       $v0, .L800B3CC4
    /* A44A4 800B3CA4 2110EC00 */   addu      $v0, $a3, $t4
    /* A44A8 800B3CA8 0000CDA0 */  sb         $t5, 0x0($a2)
    /* A44AC 800B3CAC 0300C624 */  addiu      $a2, $a2, 0x3
    /* A44B0 800B3CB0 21184000 */  addu       $v1, $v0, $zero
    /* A44B4 800B3CB4 0300E724 */  addiu      $a3, $a3, 0x3
    /* A44B8 800B3CB8 010045A0 */  sb         $a1, 0x1($v0)
    /* A44BC 800B3CBC 39CF0208 */  j          .L800B3CE4
    /* A44C0 800B3CC0 020068A0 */   sb        $t0, 0x2($v1)
  .L800B3CC4:
    /* A44C4 800B3CC4 0700A018 */  blez       $a1, .L800B3CE4
    /* A44C8 800B3CC8 21180000 */   addu      $v1, $zero, $zero
  .L800B3CCC:
    /* A44CC 800B3CCC 0000C8A0 */  sb         $t0, 0x0($a2)
    /* A44D0 800B3CD0 0100C624 */  addiu      $a2, $a2, 0x1
    /* A44D4 800B3CD4 01006324 */  addiu      $v1, $v1, 0x1
    /* A44D8 800B3CD8 2A106500 */  slt        $v0, $v1, $a1
    /* A44DC 800B3CDC FBFF4014 */  bnez       $v0, .L800B3CCC
    /* A44E0 800B3CE0 0100E724 */   addiu     $a3, $a3, 0x1
  .L800B3CE4:
    /* A44E4 800B3CE4 2A108B00 */  slt        $v0, $a0, $t3
    /* A44E8 800B3CE8 02004014 */  bnez       $v0, .L800B3CF4
    /* A44EC 800B3CEC 00000000 */   nop
    /* A44F0 800B3CF0 01000924 */  addiu      $t1, $zero, 0x1
  .L800B3CF4:
    /* A44F4 800B3CF4 DDFF2011 */  beqz       $t1, .L800B3C6C
    /* A44F8 800B3CF8 1280023C */   lui       $v0, %hi(compressed_data)
    /* A44FC 800B3CFC 98DB47A0 */  sb         $a3, %lo(compressed_data)($v0)
    /* A4500 800B3D00 98DB4224 */  addiu      $v0, $v0, %lo(compressed_data)
    /* A4504 800B3D04 2118E200 */  addu       $v1, $a3, $v0
    /* A4508 800B3D08 0800E003 */  jr         $ra
    /* A450C 800B3D0C 000060A0 */   sb        $zero, 0x0($v1)
endlabel Replay_Compress__FPc
