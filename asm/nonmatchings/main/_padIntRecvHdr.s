.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padIntRecvHdr, 0x8C

glabel _padIntRecvHdr
    /* FCA88 8010C288 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FCA8C 8010C28C 1000B0AF */  sw         $s0, 0x10($sp)
    /* FCA90 8010C290 21808000 */  addu       $s0, $a0, $zero
    /* FCA94 8010C294 1400BFAF */  sw         $ra, 0x14($sp)
    /* FCA98 8010C298 3C00028E */  lw         $v0, 0x3C($s0)
    /* FCA9C 8010C29C 00000000 */  nop
    /* FCAA0 8010C2A0 00004290 */  lbu        $v0, 0x0($v0)
    /* FCAA4 8010C2A4 08000324 */  addiu      $v1, $zero, 0x8
    /* FCAA8 8010C2A8 02110200 */  srl        $v0, $v0, 4
    /* FCAAC 8010C2AC 04004314 */  bne        $v0, $v1, .L8010C2C0
    /* FCAB0 8010C2B0 21280000 */   addu      $a1, $zero, $zero
    /* FCAB4 8010C2B4 36000292 */  lbu        $v0, 0x36($s0)
    /* FCAB8 8010C2B8 00000000 */  nop
    /* FCABC 8010C2BC 0100452C */  sltiu      $a1, $v0, 0x1
  .L8010C2C0:
    /* FCAC0 8010C2C0 1380023C */  lui        $v0, %hi(_padFuncGetTxd)
    /* FCAC4 8010C2C4 807C428C */  lw         $v0, %lo(_padFuncGetTxd)($v0)
    /* FCAC8 8010C2C8 00000000 */  nop
    /* FCACC 8010C2CC 09F84000 */  jalr       $v0
    /* FCAD0 8010C2D0 21200002 */   addu      $a0, $s0, $zero
    /* FCAD4 8010C2D4 21200002 */  addu       $a0, $s0, $zero
    /* FCAD8 8010C2D8 C014040C */  jal        _padSioRW2
    /* FCADC 8010C2DC FF004530 */   andi      $a1, $v0, 0xFF
    /* FCAE0 8010C2E0 21184000 */  addu       $v1, $v0, $zero
    /* FCAE4 8010C2E4 5A000224 */  addiu      $v0, $zero, 0x5A
    /* FCAE8 8010C2E8 06006210 */  beq        $v1, $v0, .L8010C304
    /* FCAEC 8010C2EC 21106000 */   addu      $v0, $v1, $zero
    /* FCAF0 8010C2F0 04006010 */  beqz       $v1, .L8010C304
    /* FCAF4 8010C2F4 00000000 */   nop
    /* FCAF8 8010C2F8 02006104 */  bgez       $v1, .L8010C304
    /* FCAFC 8010C2FC F7FF0224 */   addiu     $v0, $zero, -0x9
    /* FCB00 8010C300 21106000 */  addu       $v0, $v1, $zero
  .L8010C304:
    /* FCB04 8010C304 1400BF8F */  lw         $ra, 0x14($sp)
    /* FCB08 8010C308 1000B08F */  lw         $s0, 0x10($sp)
    /* FCB0C 8010C30C 0800E003 */  jr         $ra
    /* FCB10 8010C310 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _padIntRecvHdr
