.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CleanupBlockaders__13AIHigh_Playeri, 0x118

glabel CleanupBlockaders__13AIHigh_Playeri
    /* 53464 80062C64 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 53468 80062C68 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5346C 80062C6C 21988000 */  addu       $s3, $a0, $zero
    /* 53470 80062C70 2400BFAF */  sw         $ra, 0x24($sp)
    /* 53474 80062C74 2000B4AF */  sw         $s4, 0x20($sp)
    /* 53478 80062C78 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5347C 80062C7C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 53480 80062C80 1000B0AF */  sw         $s0, 0x10($sp)
    /* 53484 80062C84 0000638E */  lw         $v1, 0x0($s3)
    /* 53488 80062C88 00000000 */  nop
    /* 5348C 80062C8C A803628C */  lw         $v0, 0x3A8($v1)
    /* 53490 80062C90 00000000 */  nop
    /* 53494 80062C94 0800401C */  bgtz       $v0, .L80062CB8
    /* 53498 80062C98 21900000 */   addu      $s2, $zero, $zero
    /* 5349C 80062C9C 9003628C */  lw         $v0, 0x390($v1)
    /* 534A0 80062CA0 00000000 */  nop
    /* 534A4 80062CA4 02004228 */  slti       $v0, $v0, 0x2
    /* 534A8 80062CA8 03004010 */  beqz       $v0, .L80062CB8
    /* 534AC 80062CAC 00000000 */   nop
    /* 534B0 80062CB0 0300A010 */  beqz       $a1, .L80062CC0
    /* 534B4 80062CB4 21880000 */   addu      $s1, $zero, $zero
  .L80062CB8:
    /* 534B8 80062CB8 01001224 */  addiu      $s2, $zero, 0x1
    /* 534BC 80062CBC 21880000 */  addu       $s1, $zero, $zero
  .L80062CC0:
    /* 534C0 80062CC0 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 534C4 80062CC4 38CD5424 */  addiu      $s4, $v0, %lo(highLevelAIObjs)
    /* 534C8 80062CC8 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 534CC 80062CCC B4FA5024 */  addiu      $s0, $v0, %lo(Cars_gCopCarList)
  .L80062CD0:
    /* 534D0 80062CD0 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 534D4 80062CD4 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 534D8 80062CD8 00000000 */  nop
    /* 534DC 80062CDC 2A102202 */  slt        $v0, $s1, $v0
    /* 534E0 80062CE0 1E004010 */  beqz       $v0, .L80062D5C
    /* 534E4 80062CE4 00000000 */   nop
    /* 534E8 80062CE8 0000028E */  lw         $v0, 0x0($s0)
    /* 534EC 80062CEC 00000000 */  nop
    /* 534F0 80062CF0 5402428C */  lw         $v0, 0x254($v0)
    /* 534F4 80062CF4 00000000 */  nop
    /* 534F8 80062CF8 80100200 */  sll        $v0, $v0, 2
    /* 534FC 80062CFC 21105400 */  addu       $v0, $v0, $s4
    /* 53500 80062D00 0000448C */  lw         $a0, 0x0($v0)
    /* 53504 80062D04 01000224 */  addiu      $v0, $zero, 0x1
    /* 53508 80062D08 2000838C */  lw         $v1, 0x20($a0)
    /* 5350C 80062D0C 00000000 */  nop
    /* 53510 80062D10 08006210 */  beq        $v1, $v0, .L80062D34
    /* 53514 80062D14 20008524 */   addiu     $a1, $a0, 0x20
    /* 53518 80062D18 04000224 */  addiu      $v0, $zero, 0x4
    /* 5351C 80062D1C 05006210 */  beq        $v1, $v0, .L80062D34
    /* 53520 80062D20 02000224 */   addiu     $v0, $zero, 0x2
    /* 53524 80062D24 0A006214 */  bne        $v1, $v0, .L80062D50
    /* 53528 80062D28 00000000 */   nop
    /* 5352C 80062D2C 08004012 */  beqz       $s2, .L80062D50
    /* 53530 80062D30 00000000 */   nop
  .L80062D34:
    /* 53534 80062D34 0400A28C */  lw         $v0, 0x4($a1)
    /* 53538 80062D38 00000000 */  nop
    /* 5353C 80062D3C 04005314 */  bne        $v0, $s3, .L80062D50
    /* 53540 80062D40 00000000 */   nop
    /* 53544 80062D44 0000A0AC */  sw         $zero, 0x0($a1)
    /* 53548 80062D48 0296010C */  jal        AssignToPlayer__10AIHigh_CopP13AIHigh_Player
    /* 5354C 80062D4C 21280000 */   addu      $a1, $zero, $zero
  .L80062D50:
    /* 53550 80062D50 04001026 */  addiu      $s0, $s0, 0x4
    /* 53554 80062D54 348B0108 */  j          .L80062CD0
    /* 53558 80062D58 01003126 */   addiu     $s1, $s1, 0x1
  .L80062D5C:
    /* 5355C 80062D5C 2400BF8F */  lw         $ra, 0x24($sp)
    /* 53560 80062D60 2000B48F */  lw         $s4, 0x20($sp)
    /* 53564 80062D64 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 53568 80062D68 1800B28F */  lw         $s2, 0x18($sp)
    /* 5356C 80062D6C 1400B18F */  lw         $s1, 0x14($sp)
    /* 53570 80062D70 1000B08F */  lw         $s0, 0x10($sp)
    /* 53574 80062D74 0800E003 */  jr         $ra
    /* 53578 80062D78 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CleanupBlockaders__13AIHigh_Playeri
