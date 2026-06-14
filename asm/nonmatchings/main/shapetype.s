.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching shapetype, 0x64

glabel shapetype
    /* ECA94 800FC294 FFFF8324 */  addiu      $v1, $a0, -0x1
    /* ECA98 800FC298 2000622C */  sltiu      $v0, $v1, 0x20
    /* ECA9C 800FC29C 14004010 */  beqz       $v0, .L800FC2F0
    /* ECAA0 800FC2A0 21280000 */   addu      $a1, $zero, $zero
    /* ECAA4 800FC2A4 0580023C */  lui        $v0, %hi(jtbl_80057538)
    /* ECAA8 800FC2A8 38754224 */  addiu      $v0, $v0, %lo(jtbl_80057538)
    /* ECAAC 800FC2AC 80180300 */  sll        $v1, $v1, 2
    /* ECAB0 800FC2B0 21186200 */  addu       $v1, $v1, $v0
    /* ECAB4 800FC2B4 0000628C */  lw         $v0, 0x0($v1)
    /* ECAB8 800FC2B8 00000000 */  nop
    /* ECABC 800FC2BC 08004000 */  jr         $v0
    /* ECAC0 800FC2C0 00000000 */   nop
  jlabel .L800FC2C4
    /* ECAC4 800FC2C4 BCF00308 */  j          .L800FC2F0
    /* ECAC8 800FC2C8 44000524 */   addiu     $a1, $zero, 0x44
  jlabel .L800FC2CC
    /* ECACC 800FC2CC BCF00308 */  j          .L800FC2F0
    /* ECAD0 800FC2D0 40000524 */   addiu     $a1, $zero, 0x40
  jlabel .L800FC2D4
    /* ECAD4 800FC2D4 BCF00308 */  j          .L800FC2F0
    /* ECAD8 800FC2D8 41000524 */   addiu     $a1, $zero, 0x41
  jlabel .L800FC2DC
    /* ECADC 800FC2DC BCF00308 */  j          .L800FC2F0
    /* ECAE0 800FC2E0 42000524 */   addiu     $a1, $zero, 0x42
  jlabel .L800FC2E4
    /* ECAE4 800FC2E4 BCF00308 */  j          .L800FC2F0
    /* ECAE8 800FC2E8 43000524 */   addiu     $a1, $zero, 0x43
  jlabel .L800FC2EC
    /* ECAEC 800FC2EC 21280000 */  addu       $a1, $zero, $zero
  jlabel .L800FC2F0
    /* ECAF0 800FC2F0 0800E003 */  jr         $ra
    /* ECAF4 800FC2F4 2110A000 */   addu      $v0, $a1, $zero
endlabel shapetype
