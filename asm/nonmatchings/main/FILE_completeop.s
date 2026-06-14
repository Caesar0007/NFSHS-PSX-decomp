.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_completeop, 0xBC

glabel FILE_completeop
    /* DCAB0 800EC2B0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DCAB4 800EC2B4 2000B0AF */  sw         $s0, 0x20($sp)
    /* DCAB8 800EC2B8 1480053C */  lui        $a1, %hi(D_8013EAA0)
    /* DCABC 800EC2BC 021E0400 */  srl        $v1, $a0, 24
    /* DCAC0 800EC2C0 40100300 */  sll        $v0, $v1, 1
    /* DCAC4 800EC2C4 21104300 */  addu       $v0, $v0, $v1
    /* DCAC8 800EC2C8 A0EAA38C */  lw         $v1, %lo(D_8013EAA0)($a1)
    /* DCACC 800EC2CC 00110200 */  sll        $v0, $v0, 4
    /* DCAD0 800EC2D0 2400BFAF */  sw         $ra, 0x24($sp)
    /* DCAD4 800EC2D4 21286200 */  addu       $a1, $v1, $v0
    /* DCAD8 800EC2D8 0800A28C */  lw         $v0, 0x8($a1)
    /* DCADC 800EC2DC 0800A38C */  lw         $v1, 0x8($a1)
    /* DCAE0 800EC2E0 01000224 */  addiu      $v0, $zero, 0x1
    /* DCAE4 800EC2E4 1A006214 */  bne        $v1, $v0, .L800EC350
    /* DCAE8 800EC2E8 21800000 */   addu      $s0, $zero, $zero
    /* DCAEC 800EC2EC 0000A28C */  lw         $v0, 0x0($a1)
    /* DCAF0 800EC2F0 00000000 */  nop
    /* DCAF4 800EC2F4 02150200 */  srl        $v0, $v0, 20
    /* DCAF8 800EC2F8 0F004230 */  andi       $v0, $v0, 0xF
    /* DCAFC 800EC2FC FEFF4324 */  addiu      $v1, $v0, -0x2
    /* DCB00 800EC300 0900622C */  sltiu      $v0, $v1, 0x9
    /* DCB04 800EC304 12004010 */  beqz       $v0, .L800EC350
    /* DCB08 800EC308 0580023C */   lui       $v0, %hi(jtbl_80056C6C)
    /* DCB0C 800EC30C 6C6C4224 */  addiu      $v0, $v0, %lo(jtbl_80056C6C)
    /* DCB10 800EC310 80180300 */  sll        $v1, $v1, 2
    /* DCB14 800EC314 21186200 */  addu       $v1, $v1, $v0
    /* DCB18 800EC318 0000628C */  lw         $v0, 0x0($v1)
    /* DCB1C 800EC31C 00000000 */  nop
    /* DCB20 800EC320 08004000 */  jr         $v0
    /* DCB24 800EC324 00000000 */   nop
  jlabel .L800EC328
    /* DCB28 800EC328 2400B08C */  lw         $s0, 0x24($a1)
    /* DCB2C 800EC32C D4B00308 */  j          .L800EC350
    /* DCB30 800EC330 00000000 */   nop
  jlabel .L800EC334
    /* DCB34 800EC334 0800B08C */  lw         $s0, 0x8($a1)
    /* DCB38 800EC338 D4B00308 */  j          .L800EC350
    /* DCB3C 800EC33C 00000000 */   nop
  jlabel .L800EC340
    /* DCB40 800EC340 1800B08C */  lw         $s0, 0x18($a1)
    /* DCB44 800EC344 D4B00308 */  j          .L800EC350
    /* DCB48 800EC348 00000000 */   nop
  jlabel .L800EC34C
    /* DCB4C 800EC34C 1C00B08C */  lw         $s0, 0x1C($a1)
  .L800EC350:
    /* DCB50 800EC350 7EB4030C */  jal        func_800ED1F8
    /* DCB54 800EC354 2120A000 */   addu      $a0, $a1, $zero
    /* DCB58 800EC358 21100002 */  addu       $v0, $s0, $zero
    /* DCB5C 800EC35C 2400BF8F */  lw         $ra, 0x24($sp)
    /* DCB60 800EC360 2000B08F */  lw         $s0, 0x20($sp)
    /* DCB64 800EC364 0800E003 */  jr         $ra
    /* DCB68 800EC368 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FILE_completeop
