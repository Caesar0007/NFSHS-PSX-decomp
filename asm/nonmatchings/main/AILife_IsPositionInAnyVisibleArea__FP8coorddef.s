.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsPositionInAnyVisibleArea__FP8coorddef, 0x84

glabel AILife_IsPositionInAnyVisibleArea__FP8coorddef
    /* 5914C 8006894C 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 59150 80068950 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 59154 80068954 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 59158 80068958 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5915C 8006895C 21908000 */  addu       $s2, $a0, $zero
    /* 59160 80068960 1400B1AF */  sw         $s1, 0x14($sp)
    /* 59164 80068964 21880000 */  addu       $s1, $zero, $zero
    /* 59168 80068968 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 5916C 8006896C 11004018 */  blez       $v0, .L800689B4
    /* 59170 80068970 1000B0AF */   sw        $s0, 0x10($sp)
    /* 59174 80068974 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 59178 80068978 48FA5024 */  addiu      $s0, $v0, %lo(Cars_gHumanRaceCarList)
  .L8006897C:
    /* 5917C 8006897C 0000058E */  lw         $a1, 0x0($s0)
    /* 59180 80068980 E2A1010C */  jal        AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
    /* 59184 80068984 21204002 */   addu      $a0, $s2, $zero
    /* 59188 80068988 04004010 */  beqz       $v0, .L8006899C
    /* 5918C 8006898C 01003126 */   addiu     $s1, $s1, 0x1
    /* 59190 80068990 0000028E */  lw         $v0, 0x0($s0)
    /* 59194 80068994 6EA20108 */  j          .L800689B8
    /* 59198 80068998 00000000 */   nop
  .L8006899C:
    /* 5919C 8006899C 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 591A0 800689A0 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 591A4 800689A4 00000000 */  nop
    /* 591A8 800689A8 2A102202 */  slt        $v0, $s1, $v0
    /* 591AC 800689AC F3FF4014 */  bnez       $v0, .L8006897C
    /* 591B0 800689B0 04001026 */   addiu     $s0, $s0, 0x4
  .L800689B4:
    /* 591B4 800689B4 21100000 */  addu       $v0, $zero, $zero
  .L800689B8:
    /* 591B8 800689B8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 591BC 800689BC 1800B28F */  lw         $s2, 0x18($sp)
    /* 591C0 800689C0 1400B18F */  lw         $s1, 0x14($sp)
    /* 591C4 800689C4 1000B08F */  lw         $s0, 0x10($sp)
    /* 591C8 800689C8 0800E003 */  jr         $ra
    /* 591CC 800689CC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AILife_IsPositionInAnyVisibleArea__FP8coorddef
