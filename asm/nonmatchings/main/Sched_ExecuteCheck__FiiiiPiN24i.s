.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sched_ExecuteCheck__FiiiiPiN24i, 0x134

glabel Sched_ExecuteCheck__FiiiiPiN24i
    /* A69BC 800B61BC 1280023C */  lui        $v0, %hi(simGlobal)
    /* A69C0 800B61C0 ACE04A24 */  addiu      $t2, $v0, %lo(simGlobal)
    /* A69C4 800B61C4 0400428D */  lw         $v0, 0x4($t2)
    /* A69C8 800B61C8 1000A88F */  lw         $t0, 0x10($sp)
    /* A69CC 800B61CC 1400AB8F */  lw         $t3, 0x14($sp)
    /* A69D0 800B61D0 1800A98F */  lw         $t1, 0x18($sp)
    /* A69D4 800B61D4 1C00A38F */  lw         $v1, 0x1C($sp)
    /* A69D8 800B61D8 10004228 */  slti       $v0, $v0, 0x10
    /* A69DC 800B61DC 37004014 */  bnez       $v0, .L800B62BC
    /* A69E0 800B61E0 21608000 */   addu      $t4, $a0, $zero
    /* A69E4 800B61E4 0200C104 */  bgez       $a2, .L800B61F0
    /* A69E8 800B61E8 00000000 */   nop
    /* A69EC 800B61EC 0F00C624 */  addiu      $a2, $a2, 0xF
  .L800B61F0:
    /* A69F0 800B61F0 03310600 */  sra        $a2, $a2, 4
    /* A69F4 800B61F4 0300C104 */  bgez       $a2, .L800B6204
    /* A69F8 800B61F8 2110C000 */   addu      $v0, $a2, $zero
    /* A69FC 800B61FC FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* A6A00 800B6200 2110C200 */  addu       $v0, $a2, $v0
  .L800B6204:
    /* A6A04 800B6204 03340200 */  sra        $a2, $v0, 16
    /* A6A08 800B6208 1400C228 */  slti       $v0, $a2, 0x14
    /* A6A0C 800B620C 02004014 */  bnez       $v0, .L800B6218
    /* A6A10 800B6210 00000000 */   nop
    /* A6A14 800B6214 13000624 */  addiu      $a2, $zero, 0x13
  .L800B6218:
    /* A6A18 800B6218 02006010 */  beqz       $v1, .L800B6224
    /* A6A1C 800B621C 1280033C */   lui       $v1, %hi(Sched_gExecuteInfo)
    /* A6A20 800B6220 21300000 */  addu       $a2, $zero, $zero
  .L800B6224:
    /* A6A24 800B6224 4CE06324 */  addiu      $v1, $v1, %lo(Sched_gExecuteInfo)
    /* A6A28 800B6228 80100500 */  sll        $v0, $a1, 2
    /* A6A2C 800B622C 21104500 */  addu       $v0, $v0, $a1
    /* A6A30 800B6230 80100200 */  sll        $v0, $v0, 2
    /* A6A34 800B6234 2110C200 */  addu       $v0, $a2, $v0
    /* A6A38 800B6238 21104300 */  addu       $v0, $v0, $v1
    /* A6A3C 800B623C 1280033C */  lui        $v1, %hi(Sched_ExecuteTimes)
    /* A6A40 800B6240 00004490 */  lbu        $a0, 0x0($v0)
    /* A6A44 800B6244 DCDF6324 */  addiu      $v1, $v1, %lo(Sched_ExecuteTimes)
    /* A6A48 800B6248 80200400 */  sll        $a0, $a0, 2
    /* A6A4C 800B624C 21188300 */  addu       $v1, $a0, $v1
    /* A6A50 800B6250 0000628C */  lw         $v0, 0x0($v1)
    /* A6A54 800B6254 1800EC00 */  mult       $a3, $t4
    /* A6A58 800B6258 000002AD */  sw         $v0, 0x0($t0)
    /* A6A5C 800B625C 1280023C */  lui        $v0, %hi(Sched_ExecuteiTimes)
    /* A6A60 800B6260 14E04224 */  addiu      $v0, $v0, %lo(Sched_ExecuteiTimes)
    /* A6A64 800B6264 21108200 */  addu       $v0, $a0, $v0
    /* A6A68 800B6268 0000428C */  lw         $v0, 0x0($v0)
    /* A6A6C 800B626C 1280033C */  lui        $v1, %hi(Sched_ExecuteMasks)
    /* A6A70 800B6270 000022AD */  sw         $v0, 0x0($t1)
    /* A6A74 800B6274 1280023C */  lui        $v0, %hi(Sched_ExecuteElapsedTimes)
    /* A6A78 800B6278 F8DF4224 */  addiu      $v0, $v0, %lo(Sched_ExecuteElapsedTimes)
    /* A6A7C 800B627C 21108200 */  addu       $v0, $a0, $v0
    /* A6A80 800B6280 0000428C */  lw         $v0, 0x0($v0)
    /* A6A84 800B6284 30E06324 */  addiu      $v1, $v1, %lo(Sched_ExecuteMasks)
    /* A6A88 800B6288 000062AD */  sw         $v0, 0x0($t3)
    /* A6A8C 800B628C 0400428D */  lw         $v0, 0x4($t2)
    /* A6A90 800B6290 21208300 */  addu       $a0, $a0, $v1
    /* A6A94 800B6294 C21F0200 */  srl        $v1, $v0, 31
    /* A6A98 800B6298 21104300 */  addu       $v0, $v0, $v1
    /* A6A9C 800B629C 43100200 */  sra        $v0, $v0, 1
    /* A6AA0 800B62A0 0000838C */  lw         $v1, 0x0($a0)
    /* A6AA4 800B62A4 12680000 */  mflo       $t5
    /* A6AA8 800B62A8 21104D00 */  addu       $v0, $v0, $t5
    /* A6AAC 800B62AC 24104300 */  and        $v0, $v0, $v1
    /* A6AB0 800B62B0 26104300 */  xor        $v0, $v0, $v1
    /* A6AB4 800B62B4 0800E003 */  jr         $ra
    /* A6AB8 800B62B8 0100422C */   sltiu     $v0, $v0, 0x1
  .L800B62BC:
    /* A6ABC 800B62BC 1280023C */  lui        $v0, %hi(D_8011DFF4)
    /* A6AC0 800B62C0 F4DF428C */  lw         $v0, %lo(D_8011DFF4)($v0)
    /* A6AC4 800B62C4 00000000 */  nop
    /* A6AC8 800B62C8 000002AD */  sw         $v0, 0x0($t0)
    /* A6ACC 800B62CC 1280023C */  lui        $v0, %hi(D_8011E02C)
    /* A6AD0 800B62D0 2CE0428C */  lw         $v0, %lo(D_8011E02C)($v0)
    /* A6AD4 800B62D4 00000000 */  nop
    /* A6AD8 800B62D8 000022AD */  sw         $v0, 0x0($t1)
    /* A6ADC 800B62DC 1280023C */  lui        $v0, %hi(D_8011E010)
    /* A6AE0 800B62E0 10E0438C */  lw         $v1, %lo(D_8011E010)($v0)
    /* A6AE4 800B62E4 01000224 */  addiu      $v0, $zero, 0x1
    /* A6AE8 800B62E8 0800E003 */  jr         $ra
    /* A6AEC 800B62EC 000063AD */   sw        $v1, 0x0($t3)
endlabel Sched_ExecuteCheck__FiiiiPiN24i
