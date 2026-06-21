.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__5tMenu, 0x94

glabel UpdateTransition__5tMenu
    /* 161A8 800259A8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 161AC 800259AC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 161B0 800259B0 21888000 */  addu       $s1, $a0, $zero
    /* 161B4 800259B4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 161B8 800259B8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 161BC 800259BC 1000228E */  lw         $v0, 0x10($s1)
    /* 161C0 800259C0 00000000 */  nop
    /* 161C4 800259C4 18004010 */  beqz       $v0, .L80025A28
    /* 161C8 800259C8 21800000 */   addu      $s0, $zero, $zero
  .L800259CC:
    /* 161CC 800259CC 001C1000 */  sll        $v1, $s0, 16
    /* 161D0 800259D0 031C0300 */  sra        $v1, $v1, 16
    /* 161D4 800259D4 80100300 */  sll        $v0, $v1, 2
    /* 161D8 800259D8 21102202 */  addu       $v0, $s1, $v0
    /* 161DC 800259DC 1000428C */  lw         $v0, 0x10($v0)
    /* 161E0 800259E0 00000000 */  nop
    /* 161E4 800259E4 1800468C */  lw         $a2, 0x18($v0)
    /* 161E8 800259E8 0800258E */  lw         $a1, 0x8($s1)
    /* 161EC 800259EC 5000C484 */  lh         $a0, 0x50($a2)
    /* 161F0 800259F0 2628A300 */  xor        $a1, $a1, $v1
    /* 161F4 800259F4 21204400 */  addu       $a0, $v0, $a0
    /* 161F8 800259F8 5400C28C */  lw         $v0, 0x54($a2)
    /* 161FC 800259FC 00000000 */  nop
    /* 16200 80025A00 09F84000 */  jalr       $v0
    /* 16204 80025A04 0100A52C */   sltiu     $a1, $a1, 0x1
    /* 16208 80025A08 01000326 */  addiu      $v1, $s0, 0x1
    /* 1620C 80025A0C 00140300 */  sll        $v0, $v1, 16
    /* 16210 80025A10 83130200 */  sra        $v0, $v0, 14
    /* 16214 80025A14 21102202 */  addu       $v0, $s1, $v0
    /* 16218 80025A18 1000428C */  lw         $v0, 0x10($v0)
    /* 1621C 80025A1C 00000000 */  nop
    /* 16220 80025A20 EAFF4014 */  bnez       $v0, .L800259CC
    /* 16224 80025A24 21806000 */   addu      $s0, $v1, $zero
  .L80025A28:
    /* 16228 80025A28 1800BF8F */  lw         $ra, 0x18($sp)
    /* 1622C 80025A2C 1400B18F */  lw         $s1, 0x14($sp)
    /* 16230 80025A30 1000B08F */  lw         $s0, 0x10($sp)
    /* 16234 80025A34 0800E003 */  jr         $ra
    /* 16238 80025A38 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__5tMenu
