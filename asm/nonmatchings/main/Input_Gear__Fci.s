.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Input_Gear__Fci, 0x5C

glabel Input_Gear__Fci
    /* 8DABC 8009D2BC E30C8293 */  lbu        $v0, %gp_rel(D_8013D22F)($gp)
    /* 8DAC0 8009D2C0 00000000 */  nop
    /* 8DAC4 8009D2C4 C2380200 */  srl        $a3, $v0, 3
    /* 8DAC8 8009D2C8 01000224 */  addiu      $v0, $zero, 0x1
    /* 8DACC 8009D2CC 0900E214 */  bne        $a3, $v0, .L8009D2F4
    /* 8DAD0 8009D2D0 21308000 */   addu      $a2, $a0, $zero
    /* 8DAD4 8009D2D4 FF00C230 */  andi       $v0, $a2, 0xFF
    /* 8DAD8 8009D2D8 FFFFA324 */  addiu      $v1, $a1, -0x1
    /* 8DADC 8009D2DC 2A104300 */  slt        $v0, $v0, $v1
    /* 8DAE0 8009D2E0 02004010 */  beqz       $v0, .L8009D2EC
    /* 8DAE4 8009D2E4 00000000 */   nop
    /* 8DAE8 8009D2E8 01008624 */  addiu      $a2, $a0, 0x1
  .L8009D2EC:
    /* 8DAEC 8009D2EC 0800E003 */  jr         $ra
    /* 8DAF0 8009D2F0 FF00C230 */   andi      $v0, $a2, 0xFF
  .L8009D2F4:
    /* 8DAF4 8009D2F4 02000224 */  addiu      $v0, $zero, 0x2
    /* 8DAF8 8009D2F8 0500E214 */  bne        $a3, $v0, .L8009D310
    /* 8DAFC 8009D2FC FF00C230 */   andi      $v0, $a2, 0xFF
    /* 8DB00 8009D300 FAFF4010 */  beqz       $v0, .L8009D2EC
    /* 8DB04 8009D304 00000000 */   nop
    /* 8DB08 8009D308 BB740208 */  j          .L8009D2EC
    /* 8DB0C 8009D30C FFFF8624 */   addiu     $a2, $a0, -0x1
  .L8009D310:
    /* 8DB10 8009D310 0800E003 */  jr         $ra
    /* 8DB14 8009D314 00000000 */   nop
endlabel Input_Gear__Fci
