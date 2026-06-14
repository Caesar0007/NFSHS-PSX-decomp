.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t, 0x28

glabel AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
    /* 59E38 80069638 0200A228 */  slti       $v0, $a1, 0x2
    /* 59E3C 8006963C 03004010 */  beqz       $v0, .L8006964C
    /* 59E40 80069640 FEFFA224 */   addiu     $v0, $a1, -0x2
    /* 59E44 80069644 8EA50108 */  j          AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
    /* 59E48 80069648 02000524 */   addiu     $a1, $zero, 0x2
  .L8006964C:
    /* 59E4C 8006964C 80100200 */  sll        $v0, $v0, 2
    /* 59E50 80069650 21108200 */  addu       $v0, $a0, $v0
    /* 59E54 80069654 B405428C */  lw         $v0, 0x5B4($v0)
    /* 59E58 80069658 0800E003 */  jr         $ra
    /* 59E5C 8006965C 00000000 */   nop
endlabel AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t
