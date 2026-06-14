.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysics_UseCoolPhysics__FP8Car_tObj, 0x44

glabel AIPhysics_UseCoolPhysics__FP8Car_tObj
    /* 5A6EC 80069EEC 6002838C */  lw         $v1, 0x260($a0)
    /* 5A6F0 80069EF0 00000000 */  nop
    /* 5A6F4 80069EF4 00086230 */  andi       $v0, $v1, 0x800
    /* 5A6F8 80069EF8 09004014 */  bnez       $v0, .L80069F20
    /* 5A6FC 80069EFC 00000000 */   nop
    /* 5A700 80069F00 90008490 */  lbu        $a0, 0x90($a0)
    /* 5A704 80069F04 00000000 */  nop
    /* 5A708 80069F08 05008010 */  beqz       $a0, .L80069F20
    /* 5A70C 80069F0C 20006230 */   andi      $v0, $v1, 0x20
    /* 5A710 80069F10 05004010 */  beqz       $v0, .L80069F28
    /* 5A714 80069F14 0200822C */   sltiu     $v0, $a0, 0x2
    /* 5A718 80069F18 03004010 */  beqz       $v0, .L80069F28
    /* 5A71C 80069F1C 00000000 */   nop
  .L80069F20:
    /* 5A720 80069F20 0800E003 */  jr         $ra
    /* 5A724 80069F24 01000224 */   addiu     $v0, $zero, 0x1
  .L80069F28:
    /* 5A728 80069F28 0800E003 */  jr         $ra
    /* 5A72C 80069F2C 21100000 */   addu      $v0, $zero, $zero
endlabel AIPhysics_UseCoolPhysics__FP8Car_tObj
