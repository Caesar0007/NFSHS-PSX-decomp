.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t, 0x28

glabel AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
    /* 59E60 80069660 0200A228 */  slti       $v0, $a1, 0x2
    /* 59E64 80069664 03004010 */  beqz       $v0, .L80069674
    /* 59E68 80069668 FEFFA224 */   addiu     $v0, $a1, -0x2
    /* 59E6C 8006966C 98A50108 */  j          AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
    /* 59E70 80069670 02000524 */   addiu     $a1, $zero, 0x2
  .L80069674:
    /* 59E74 80069674 80100200 */  sll        $v0, $v0, 2
    /* 59E78 80069678 21108200 */  addu       $v0, $a0, $v0
    /* 59E7C 8006967C 9805428C */  lw         $v0, 0x598($v0)
    /* 59E80 80069680 0800E003 */  jr         $ra
    /* 59E84 80069684 00000000 */   nop
endlabel AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t
