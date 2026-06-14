.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_SetCurrentInput__Fi, 0xC0

glabel SimQueue_SetCurrentInput__Fi
    /* A7CE4 800B74E4 21180000 */  addu       $v1, $zero, $zero
    /* A7CE8 800B74E8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A7CEC 800B74EC EC314524 */  addiu      $a1, $v0, %lo(GameSetup_gData)
    /* A7CF0 800B74F0 C803A28C */  lw         $v0, 0x3C8($a1)
    /* A7CF4 800B74F4 00000000 */  nop
    /* A7CF8 800B74F8 13004018 */  blez       $v0, .L800B7548
    /* A7CFC 800B74FC 1F008430 */   andi      $a0, $a0, 0x1F
    /* A7D00 800B7500 1480023C */  lui        $v0, %hi(D_8013E0F4)
    /* A7D04 800B7504 F4E04824 */  addiu      $t0, $v0, %lo(D_8013E0F4)
    /* A7D08 800B7508 2138A000 */  addu       $a3, $a1, $zero
    /* A7D0C 800B750C 1480063C */  lui        $a2, %hi(D_8013DDC8)
    /* A7D10 800B7510 C8DDC624 */  addiu      $a2, $a2, %lo(D_8013DDC8)
    /* A7D14 800B7514 80280400 */  sll        $a1, $a0, 2
  .L800B7518:
    /* A7D18 800B7518 2110A800 */  addu       $v0, $a1, $t0
    /* A7D1C 800B751C 03004988 */  lwl        $t1, 0x3($v0)
    /* A7D20 800B7520 00004998 */  lwr        $t1, 0x0($v0)
    /* A7D24 800B7524 00000000 */  nop
    /* A7D28 800B7528 0300C9A8 */  swl        $t1, 0x3($a2)
    /* A7D2C 800B752C 0000C9B8 */  swr        $t1, 0x0($a2)
    /* A7D30 800B7530 0400C624 */  addiu      $a2, $a2, 0x4
    /* A7D34 800B7534 C803E28C */  lw         $v0, 0x3C8($a3)
    /* A7D38 800B7538 01006324 */  addiu      $v1, $v1, 0x1
    /* A7D3C 800B753C 2A106200 */  slt        $v0, $v1, $v0
    /* A7D40 800B7540 F5FF4014 */  bnez       $v0, .L800B7518
    /* A7D44 800B7544 8000A524 */   addiu     $a1, $a1, 0x80
  .L800B7548:
    /* A7D48 800B7548 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* A7D4C 800B754C EC314524 */  addiu      $a1, $v0, %lo(GameSetup_gData)
    /* A7D50 800B7550 C803A28C */  lw         $v0, 0x3C8($a1)
    /* A7D54 800B7554 00000000 */  nop
    /* A7D58 800B7558 0B004018 */  blez       $v0, .L800B7588
    /* A7D5C 800B755C 21180000 */   addu      $v1, $zero, $zero
    /* A7D60 800B7560 1480023C */  lui        $v0, %hi(D_8013E0F4)
    /* A7D64 800B7564 F4E04624 */  addiu      $a2, $v0, %lo(D_8013E0F4)
    /* A7D68 800B7568 80200400 */  sll        $a0, $a0, 2
  .L800B756C:
    /* A7D6C 800B756C 21108600 */  addu       $v0, $a0, $a2
    /* A7D70 800B7570 000140AC */  sw         $zero, 0x100($v0)
    /* A7D74 800B7574 C803A28C */  lw         $v0, 0x3C8($a1)
    /* A7D78 800B7578 01006324 */  addiu      $v1, $v1, 0x1
    /* A7D7C 800B757C 2A106200 */  slt        $v0, $v1, $v0
    /* A7D80 800B7580 FAFF4014 */  bnez       $v0, .L800B756C
    /* A7D84 800B7584 80008424 */   addiu     $a0, $a0, 0x80
  .L800B7588:
    /* A7D88 800B7588 1480033C */  lui        $v1, %hi(D_8013E0F4)
    /* A7D8C 800B758C F4E06324 */  addiu      $v1, $v1, %lo(D_8013E0F4)
    /* A7D90 800B7590 0002628C */  lw         $v0, 0x200($v1)
    /* A7D94 800B7594 00000000 */  nop
    /* A7D98 800B7598 01004224 */  addiu      $v0, $v0, 0x1
    /* A7D9C 800B759C 0800E003 */  jr         $ra
    /* A7DA0 800B75A0 000262AC */   sw        $v0, 0x200($v1)
endlabel SimQueue_SetCurrentInput__Fi
