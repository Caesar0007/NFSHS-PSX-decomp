.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MoveAngleWind__FP17Souffle_tISouffle, 0x40

glabel MoveAngleWind__FP17Souffle_tISouffle
    /* A7ECC 800B76CC 0400838C */  lw         $v1, 0x4($a0)
    /* A7ED0 800B76D0 0800828C */  lw         $v0, 0x8($a0)
    /* A7ED4 800B76D4 21286000 */  addu       $a1, $v1, $zero
    /* A7ED8 800B76D8 21104300 */  addu       $v0, $v0, $v1
    /* A7EDC 800B76DC 080082AC */  sw         $v0, 0x8($a0)
    /* A7EE0 800B76E0 F8FFA228 */  slti       $v0, $a1, -0x8
    /* A7EE4 800B76E4 04004010 */  beqz       $v0, .L800B76F8
    /* A7EE8 800B76E8 0900A228 */   slti      $v0, $a1, 0x9
    /* A7EEC 800B76EC 0100A224 */  addiu      $v0, $a1, 0x1
    /* A7EF0 800B76F0 0800E003 */  jr         $ra
    /* A7EF4 800B76F4 040082AC */   sw        $v0, 0x4($a0)
  .L800B76F8:
    /* A7EF8 800B76F8 02004014 */  bnez       $v0, .L800B7704
    /* A7EFC 800B76FC FFFFA224 */   addiu     $v0, $a1, -0x1
    /* A7F00 800B7700 040082AC */  sw         $v0, 0x4($a0)
  .L800B7704:
    /* A7F04 800B7704 0800E003 */  jr         $ra
    /* A7F08 800B7708 00000000 */   nop
endlabel MoveAngleWind__FP17Souffle_tISouffle
