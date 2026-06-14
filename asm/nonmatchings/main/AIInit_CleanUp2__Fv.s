.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_CleanUp2__Fv, 0xC8

glabel AIInit_CleanUp2__Fv
    /* 57644 80066E44 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 57648 80066E48 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 5764C 80066E4C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 57650 80066E50 1400B1AF */  sw         $s1, 0x14($sp)
    /* 57654 80066E54 21880000 */  addu       $s1, $zero, $zero
    /* 57658 80066E58 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5765C 80066E5C 0F004018 */  blez       $v0, .L80066E9C
    /* 57660 80066E60 1000B0AF */   sw        $s0, 0x10($sp)
    /* 57664 80066E64 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 57668 80066E68 DCF95024 */  addiu      $s0, $v0, %lo(Cars_gList)
  .L80066E6C:
    /* 5766C 80066E6C 0000048E */  lw         $a0, 0x0($s0)
    /* 57670 80066E70 749D010C */  jal        AIInit_DeInitAICar2__FP8Car_tObj
    /* 57674 80066E74 01003126 */   addiu     $s1, $s1, 0x1
    /* 57678 80066E78 0000048E */  lw         $a0, 0x0($s0)
    /* 5767C 80066E7C 75B3010C */  jal        AIPhysic_DeInitCar__FP8Car_tObj
    /* 57680 80066E80 04001026 */   addiu     $s0, $s0, 0x4
    /* 57684 80066E84 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 57688 80066E88 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 5768C 80066E8C 00000000 */  nop
    /* 57690 80066E90 2A102202 */  slt        $v0, $s1, $v0
    /* 57694 80066E94 F5FF4014 */  bnez       $v0, .L80066E6C
    /* 57698 80066E98 00000000 */   nop
  .L80066E9C:
    /* 5769C 80066E9C E2CB010C */  jal        AITune_CleanUp2__Fv
    /* 576A0 80066EA0 21800000 */   addu      $s0, $zero, $zero
    /* 576A4 80066EA4 11B3010C */  jal        AIPhysic_CleanUp__Fv
    /* 576A8 80066EA8 00000000 */   nop
    /* 576AC 80066EAC 21B4010C */  jal        CleanUp2__14AIDataRecord_t
    /* 576B0 80066EB0 00000000 */   nop
    /* 576B4 80066EB4 8CA4010C */  jal        AIPerson_Cleanup__Fv
    /* 576B8 80066EB8 00000000 */   nop
    /* 576BC 80066EBC 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 576C0 80066EC0 F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 576C4 80066EC4 00000000 */  nop
    /* 576C8 80066EC8 09004018 */  blez       $v0, .L80066EF0
    /* 576CC 80066ECC 00000000 */   nop
  .L80066ED0:
    /* 576D0 80066ED0 D8BD010C */  jal        AIScript_Cleanup__Fv
    /* 576D4 80066ED4 01001026 */   addiu     $s0, $s0, 0x1
    /* 576D8 80066ED8 1480023C */  lui        $v0, %hi(Cars_gNumCars)
    /* 576DC 80066EDC F4C7428C */  lw         $v0, %lo(Cars_gNumCars)($v0)
    /* 576E0 80066EE0 00000000 */  nop
    /* 576E4 80066EE4 2A100202 */  slt        $v0, $s0, $v0
    /* 576E8 80066EE8 F9FF4014 */  bnez       $v0, .L80066ED0
    /* 576EC 80066EEC 00000000 */   nop
  .L80066EF0:
    /* 576F0 80066EF0 1CB6010C */  jal        AISpeeds_CleanUp__Fv
    /* 576F4 80066EF4 00000000 */   nop
    /* 576F8 80066EF8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 576FC 80066EFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 57700 80066F00 1000B08F */  lw         $s0, 0x10($sp)
    /* 57704 80066F04 0800E003 */  jr         $ra
    /* 57708 80066F08 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIInit_CleanUp2__Fv
