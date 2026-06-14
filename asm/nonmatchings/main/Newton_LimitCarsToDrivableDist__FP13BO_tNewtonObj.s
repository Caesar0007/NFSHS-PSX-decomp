.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj, 0x44

glabel Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
    /* 915A4 800A0DA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 915A8 800A0DA8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 915AC 800A0DAC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 915B0 800A0DB0 2EA5020C */  jal        Physics_DoBarrierCheck__FP8Car_tObj
    /* 915B4 800A0DB4 21808000 */   addu      $s0, $a0, $zero
    /* 915B8 800A0DB8 07004010 */  beqz       $v0, .L800A0DD8
    /* 915BC 800A0DBC 00000000 */   nop
    /* 915C0 800A0DC0 21200002 */  addu       $a0, $s0, $zero
    /* 915C4 800A0DC4 900100AE */  sw         $zero, 0x190($s0)
    /* 915C8 800A0DC8 C17D020C */  jal        Newton_FindClosestQuad__FP13BO_tNewtonObj
    /* 915CC 800A0DCC 940100AE */   sw        $zero, 0x194($s0)
    /* 915D0 800A0DD0 E87D020C */  jal        Newton_UpdateRoadGeometry__FP13BO_tNewtonObj
    /* 915D4 800A0DD4 21200002 */   addu      $a0, $s0, $zero
  .L800A0DD8:
    /* 915D8 800A0DD8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 915DC 800A0DDC 1000B08F */  lw         $s0, 0x10($sp)
    /* 915E0 800A0DE0 0800E003 */  jr         $ra
    /* 915E4 800A0DE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj
