.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_UpdateRoadInfo__FP13BO_tNewtonObj, 0x8C

glabel Newton_UpdateRoadInfo__FP13BO_tNewtonObj
    /* 91D68 800A1568 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 91D6C 800A156C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 91D70 800A1570 21808000 */  addu       $s0, $a0, $zero
    /* 91D74 800A1574 1400BFAF */  sw         $ra, 0x14($sp)
    /* 91D78 800A1578 91000292 */  lbu        $v0, 0x91($s0)
    /* 91D7C 800A157C 00000000 */  nop
    /* 91D80 800A1580 18004010 */  beqz       $v0, .L800A15E4
    /* 91D84 800A1584 00000000 */   nop
    /* 91D88 800A1588 9284020C */  jal        Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj
    /* 91D8C 800A158C 00000000 */   nop
    /* 91D90 800A1590 C17D020C */  jal        Newton_FindClosestQuad__FP13BO_tNewtonObj
    /* 91D94 800A1594 21200002 */   addu      $a0, $s0, $zero
    /* 91D98 800A1598 61000282 */  lb         $v0, 0x61($s0)
    /* 91D9C 800A159C 00000000 */  nop
    /* 91DA0 800A15A0 03004010 */  beqz       $v0, .L800A15B0
    /* 91DA4 800A15A4 00000000 */   nop
    /* 91DA8 800A15A8 E87D020C */  jal        Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
    /* 91DAC 800A15AC 21200002 */   addu      $a0, $s0, $zero
  .L800A15B0:
    /* 91DB0 800A15B0 90000292 */  lbu        $v0, 0x90($s0)
    /* 91DB4 800A15B4 00000000 */  nop
    /* 91DB8 800A15B8 0A004014 */  bnez       $v0, .L800A15E4
    /* 91DBC 800A15BC 00000000 */   nop
    /* 91DC0 800A15C0 8000038E */  lw         $v1, 0x80($s0)
    /* 91DC4 800A15C4 00000000 */  nop
    /* 91DC8 800A15C8 02006010 */  beqz       $v1, .L800A15D4
    /* 91DCC 800A15CC 0E000224 */   addiu     $v0, $zero, 0xE
    /* 91DD0 800A15D0 00006290 */  lbu        $v0, 0x0($v1)
  .L800A15D4:
    /* 91DD4 800A15D4 00000000 */  nop
    /* 91DD8 800A15D8 BC0102AE */  sw         $v0, 0x1BC($s0)
    /* 91DDC 800A15DC 0F004230 */  andi       $v0, $v0, 0xF
    /* 91DE0 800A15E0 C00102AE */  sw         $v0, 0x1C0($s0)
  .L800A15E4:
    /* 91DE4 800A15E4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 91DE8 800A15E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 91DEC 800A15EC 0800E003 */  jr         $ra
    /* 91DF0 800A15F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Newton_UpdateRoadInfo__FP13BO_tNewtonObj
