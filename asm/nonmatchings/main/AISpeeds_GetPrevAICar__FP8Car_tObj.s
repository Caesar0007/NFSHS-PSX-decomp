.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetPrevAICar__FP8Car_tObj, 0x6C

glabel AISpeeds_GetPrevAICar__FP8Car_tObj
    /* 5EA64 8006E264 21380000 */  addu       $a3, $zero, $zero
    /* 5EA68 8006E268 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 5EA6C 8006E26C F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 5EA70 8006E270 00000000 */  nop
    /* 5EA74 8006E274 12004018 */  blez       $v0, .L8006E2C0
    /* 5EA78 8006E278 2128E000 */   addu      $a1, $a3, $zero
    /* 5EA7C 8006E27C 21404000 */  addu       $t0, $v0, $zero
    /* 5EA80 8006E280 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 5EA84 8006E284 20FB4624 */  addiu      $a2, $v0, %lo(Cars_gTotalSortedList)
  .L8006E288:
    /* 5EA88 8006E288 0000C38C */  lw         $v1, 0x0($a2)
    /* 5EA8C 8006E28C 00000000 */  nop
    /* 5EA90 8006E290 0D008310 */  beq        $a0, $v1, .L8006E2C8
    /* 5EA94 8006E294 2110E000 */   addu      $v0, $a3, $zero
    /* 5EA98 8006E298 6002628C */  lw         $v0, 0x260($v1)
    /* 5EA9C 8006E29C 00000000 */  nop
    /* 5EAA0 8006E2A0 08004230 */  andi       $v0, $v0, 0x8
    /* 5EAA4 8006E2A4 02004010 */  beqz       $v0, .L8006E2B0
    /* 5EAA8 8006E2A8 00000000 */   nop
    /* 5EAAC 8006E2AC 21386000 */  addu       $a3, $v1, $zero
  .L8006E2B0:
    /* 5EAB0 8006E2B0 0100A524 */  addiu      $a1, $a1, 0x1
    /* 5EAB4 8006E2B4 2A10A800 */  slt        $v0, $a1, $t0
    /* 5EAB8 8006E2B8 F3FF4014 */  bnez       $v0, .L8006E288
    /* 5EABC 8006E2BC 0400C624 */   addiu     $a2, $a2, 0x4
  .L8006E2C0:
    /* 5EAC0 8006E2C0 0800E003 */  jr         $ra
    /* 5EAC4 8006E2C4 21100000 */   addu      $v0, $zero, $zero
  .L8006E2C8:
    /* 5EAC8 8006E2C8 0800E003 */  jr         $ra
    /* 5EACC 8006E2CC 00000000 */   nop
endlabel AISpeeds_GetPrevAICar__FP8Car_tObj
