.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj, 0x84

glabel AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
    /* 58F04 80068704 1480023C */  lui        $v0, %hi(Cars_gNumLifeBasisCars)
    /* 58F08 80068708 10C8428C */  lw         $v0, %lo(Cars_gNumLifeBasisCars)($v0)
    /* 58F0C 8006870C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 58F10 80068710 1400B1AF */  sw         $s1, 0x14($sp)
    /* 58F14 80068714 21880000 */  addu       $s1, $zero, $zero
    /* 58F18 80068718 1800B2AF */  sw         $s2, 0x18($sp)
    /* 58F1C 8006871C A0009224 */  addiu      $s2, $a0, 0xA0
    /* 58F20 80068720 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 58F24 80068724 11004018 */  blez       $v0, .L8006876C
    /* 58F28 80068728 1000B0AF */   sw        $s0, 0x10($sp)
    /* 58F2C 8006872C 1180023C */  lui        $v0, %hi(Cars_gLifeBasisCarList)
    /* 58F30 80068730 D8FA5024 */  addiu      $s0, $v0, %lo(Cars_gLifeBasisCarList)
  .L80068734:
    /* 58F34 80068734 0000058E */  lw         $a1, 0x0($s0)
    /* 58F38 80068738 96A1010C */  jal        AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj
    /* 58F3C 8006873C 21204002 */   addu      $a0, $s2, $zero
    /* 58F40 80068740 04004010 */  beqz       $v0, .L80068754
    /* 58F44 80068744 01003126 */   addiu     $s1, $s1, 0x1
    /* 58F48 80068748 0000028E */  lw         $v0, 0x0($s0)
    /* 58F4C 8006874C DCA10108 */  j          .L80068770
    /* 58F50 80068750 00000000 */   nop
  .L80068754:
    /* 58F54 80068754 1480023C */  lui        $v0, %hi(Cars_gNumLifeBasisCars)
    /* 58F58 80068758 10C8428C */  lw         $v0, %lo(Cars_gNumLifeBasisCars)($v0)
    /* 58F5C 8006875C 00000000 */  nop
    /* 58F60 80068760 2A102202 */  slt        $v0, $s1, $v0
    /* 58F64 80068764 F3FF4014 */  bnez       $v0, .L80068734
    /* 58F68 80068768 04001026 */   addiu     $s0, $s0, 0x4
  .L8006876C:
    /* 58F6C 8006876C 21100000 */  addu       $v0, $zero, $zero
  .L80068770:
    /* 58F70 80068770 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 58F74 80068774 1800B28F */  lw         $s2, 0x18($sp)
    /* 58F78 80068778 1400B18F */  lw         $s1, 0x14($sp)
    /* 58F7C 8006877C 1000B08F */  lw         $s0, 0x10($sp)
    /* 58F80 80068780 0800E003 */  jr         $ra
    /* 58F84 80068784 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj
