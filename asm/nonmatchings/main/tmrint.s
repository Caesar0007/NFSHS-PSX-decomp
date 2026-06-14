.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching tmrint, 0xAC

glabel tmrint
    /* E4B28 800F4328 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E4B2C 800F432C 1000A427 */  addiu      $a0, $sp, 0x10
    /* E4B30 800F4330 2000BFAF */  sw         $ra, 0x20($sp)
    /* E4B34 800F4334 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* E4B38 800F4338 24AC030C */  jal        savegp
    /* E4B3C 800F433C 1800B0AF */   sw        $s0, 0x18($sp)
    /* E4B40 800F4340 21880000 */  addu       $s1, $zero, $zero
    /* E4B44 800F4344 1280033C */  lui        $v1, %hi(tmrsub)
    /* E4B48 800F4348 1480023C */  lui        $v0, %hi(ticks)
    /* E4B4C 800F434C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* E4B50 800F4350 0C367024 */  addiu      $s0, $v1, %lo(tmrsub)
    /* E4B54 800F4354 01004224 */  addiu      $v0, $v0, 0x1
    /* E4B58 800F4358 1480013C */  lui        $at, %hi(ticks)
    /* E4B5C 800F435C ACDC22AC */  sw         $v0, %lo(ticks)($at)
    /* E4B60 800F4360 1480023C */  lui        $v0, %hi(libticks)
    /* E4B64 800F4364 B0DC428C */  lw         $v0, %lo(libticks)($v0)
    /* E4B68 800F4368 01000324 */  addiu      $v1, $zero, 0x1
    /* E4B6C 800F436C 1480013C */  lui        $at, %hi(g_currentthread)
    /* E4B70 800F4370 5CDD23AC */  sw         $v1, %lo(g_currentthread)($at)
    /* E4B74 800F4374 21104300 */  addu       $v0, $v0, $v1
    /* E4B78 800F4378 1480013C */  lui        $at, %hi(libticks)
    /* E4B7C 800F437C B0DC22AC */  sw         $v0, %lo(libticks)($at)
  .L800F4380:
    /* E4B80 800F4380 0000028E */  lw         $v0, 0x0($s0)
    /* E4B84 800F4384 00000000 */  nop
    /* E4B88 800F4388 03004010 */  beqz       $v0, .L800F4398
    /* E4B8C 800F438C 00000000 */   nop
    /* E4B90 800F4390 09F84000 */  jalr       $v0
    /* E4B94 800F4394 00000000 */   nop
  .L800F4398:
    /* E4B98 800F4398 01003126 */  addiu      $s1, $s1, 0x1
    /* E4B9C 800F439C 0800222A */  slti       $v0, $s1, 0x8
    /* E4BA0 800F43A0 F7FF4014 */  bnez       $v0, .L800F4380
    /* E4BA4 800F43A4 04001026 */   addiu     $s0, $s0, 0x4
    /* E4BA8 800F43A8 1000A48F */  lw         $a0, 0x10($sp)
    /* E4BAC 800F43AC 1480013C */  lui        $at, %hi(g_currentthread)
    /* E4BB0 800F43B0 5CDD20AC */  sw         $zero, %lo(g_currentthread)($at)
    /* E4BB4 800F43B4 29AC030C */  jal        restoregp
    /* E4BB8 800F43B8 00000000 */   nop
    /* E4BBC 800F43BC 2000BF8F */  lw         $ra, 0x20($sp)
    /* E4BC0 800F43C0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* E4BC4 800F43C4 1800B08F */  lw         $s0, 0x18($sp)
    /* E4BC8 800F43C8 21100000 */  addu       $v0, $zero, $zero
    /* E4BCC 800F43CC 0800E003 */  jr         $ra
    /* E4BD0 800F43D0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel tmrint
