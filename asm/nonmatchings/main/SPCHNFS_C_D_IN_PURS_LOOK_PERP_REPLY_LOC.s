.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC, 0x7C

glabel SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC
    /* 84698 80093E98 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 8469C 80093E9C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 846A0 80093EA0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 846A4 80093EA4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093EA8:
    /* 846A8 80093EA8 000040AC */  sw         $zero, 0x0($v0)
    /* 846AC 80093EAC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 846B0 80093EB0 FDFF6104 */  bgez       $v1, .L80093EA8
    /* 846B4 80093EB4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 846B8 80093EB8 A2010224 */  addiu      $v0, $zero, 0x1A2
    /* 846BC 80093EBC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 846C0 80093EC0 0000828C */  lw         $v0, 0x0($a0)
    /* 846C4 80093EC4 00000000 */  nop
    /* 846C8 80093EC8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 846CC 80093ECC 0000A28C */  lw         $v0, 0x0($a1)
    /* 846D0 80093ED0 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 846D4 80093ED4 1800A2AF */  sw         $v0, 0x18($sp)
    /* 846D8 80093ED8 0000E28C */  lw         $v0, 0x0($a3)
    /* 846DC 80093EDC 00000000 */  nop
    /* 846E0 80093EE0 2000A2AF */  sw         $v0, 0x20($sp)
    /* 846E4 80093EE4 5800A28F */  lw         $v0, 0x58($sp)
    /* 846E8 80093EE8 00000000 */  nop
    /* 846EC 80093EEC 0000438C */  lw         $v1, 0x0($v0)
    /* 846F0 80093EF0 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 846F4 80093EF4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 846F8 80093EF8 2800A2AF */  sw         $v0, 0x28($sp)
    /* 846FC 80093EFC 6E9C030C */  jal        SPCH_AddEvent
    /* 84700 80093F00 2400A3AF */   sw        $v1, 0x24($sp)
    /* 84704 80093F04 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84708 80093F08 00000000 */  nop
    /* 8470C 80093F0C 0800E003 */  jr         $ra
    /* 84710 80093F10 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC
