.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_Pause__Fv, 0x40

glabel Force_Pause__Fv
    /* BB9B4 800CB1B4 1280023C */  lui        $v0, %hi(Force_g)
    /* BB9B8 800CB1B8 60FD4424 */  addiu      $a0, $v0, %lo(Force_g)
    /* BB9BC 800CB1BC 10008324 */  addiu      $v1, $a0, 0x10
    /* BB9C0 800CB1C0 2B108300 */  sltu       $v0, $a0, $v1
    /* BB9C4 800CB1C4 09004010 */  beqz       $v0, .L800CB1EC
    /* BB9C8 800CB1C8 21286000 */   addu      $a1, $v1, $zero
    /* BB9CC 800CB1CC 04008324 */  addiu      $v1, $a0, 0x4
  .L800CB1D0:
    /* BB9D0 800CB1D0 FDFF60A0 */  sb         $zero, -0x3($v1)
    /* BB9D4 800CB1D4 FEFF60A0 */  sb         $zero, -0x2($v1)
    /* BB9D8 800CB1D8 000060A0 */  sb         $zero, 0x0($v1)
    /* BB9DC 800CB1DC 08008424 */  addiu      $a0, $a0, 0x8
    /* BB9E0 800CB1E0 2B108500 */  sltu       $v0, $a0, $a1
    /* BB9E4 800CB1E4 FAFF4014 */  bnez       $v0, .L800CB1D0
    /* BB9E8 800CB1E8 08006324 */   addiu     $v1, $v1, 0x8
  .L800CB1EC:
    /* BB9EC 800CB1EC 0800E003 */  jr         $ra
    /* BB9F0 800CB1F0 00000000 */   nop
endlabel Force_Pause__Fv
