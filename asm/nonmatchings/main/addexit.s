.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching addexit, 0x60

glabel addexit
    /* E24F8 800F1CF8 21280000 */  addu       $a1, $zero, $zero
    /* E24FC 800F1CFC 1380023C */  lui        $v0, %hi(D_801349E8)
    /* E2500 800F1D00 E8494324 */  addiu      $v1, $v0, %lo(D_801349E8)
  .L800F1D04:
    /* E2504 800F1D04 0000628C */  lw         $v0, 0x0($v1)
    /* E2508 800F1D08 00000000 */  nop
    /* E250C 800F1D0C 10004410 */  beq        $v0, $a0, .L800F1D50
    /* E2510 800F1D10 0100A524 */   addiu     $a1, $a1, 0x1
    /* E2514 800F1D14 2000A228 */  slti       $v0, $a1, 0x20
    /* E2518 800F1D18 FAFF4014 */  bnez       $v0, .L800F1D04
    /* E251C 800F1D1C 04006324 */   addiu     $v1, $v1, 0x4
    /* E2520 800F1D20 21280000 */  addu       $a1, $zero, $zero
    /* E2524 800F1D24 1380023C */  lui        $v0, %hi(D_801349E8)
    /* E2528 800F1D28 E8494324 */  addiu      $v1, $v0, %lo(D_801349E8)
  .L800F1D2C:
    /* E252C 800F1D2C 0000628C */  lw         $v0, 0x0($v1)
    /* E2530 800F1D30 00000000 */  nop
    /* E2534 800F1D34 03004014 */  bnez       $v0, .L800F1D44
    /* E2538 800F1D38 0100A524 */   addiu     $a1, $a1, 0x1
    /* E253C 800F1D3C 0800E003 */  jr         $ra
    /* E2540 800F1D40 000064AC */   sw        $a0, 0x0($v1)
  .L800F1D44:
    /* E2544 800F1D44 2000A228 */  slti       $v0, $a1, 0x20
    /* E2548 800F1D48 F8FF4014 */  bnez       $v0, .L800F1D2C
    /* E254C 800F1D4C 04006324 */   addiu     $v1, $v1, 0x4
  .L800F1D50:
    /* E2550 800F1D50 0800E003 */  jr         $ra
    /* E2554 800F1D54 00000000 */   nop
endlabel addexit
