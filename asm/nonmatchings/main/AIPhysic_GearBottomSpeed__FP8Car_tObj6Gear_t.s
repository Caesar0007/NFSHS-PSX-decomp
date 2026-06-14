.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t, 0x28

glabel AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
    /* 59E88 80069688 0300A228 */  slti       $v0, $a1, 0x3
    /* 59E8C 8006968C 06004014 */  bnez       $v0, .L800696A8
    /* 59E90 80069690 FDFFA224 */   addiu     $v0, $a1, -0x3
    /* 59E94 80069694 80100200 */  sll        $v0, $v0, 2
    /* 59E98 80069698 21108200 */  addu       $v0, $a0, $v0
    /* 59E9C 8006969C 9805428C */  lw         $v0, 0x598($v0)
    /* 59EA0 800696A0 0800E003 */  jr         $ra
    /* 59EA4 800696A4 00000000 */   nop
  .L800696A8:
    /* 59EA8 800696A8 0800E003 */  jr         $ra
    /* 59EAC 800696AC 21100000 */   addu      $v0, $zero, $zero
endlabel AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t
