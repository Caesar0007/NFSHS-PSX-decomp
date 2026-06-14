.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_PERP_SIGHTED, 0x8C

glabel SPCHNFS_C_D_PERP_SIGHTED
    /* 83F94 80093794 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83F98 80093798 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83F9C 8009379C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83FA0 800937A0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800937A4:
    /* 83FA4 800937A4 000040AC */  sw         $zero, 0x0($v0)
    /* 83FA8 800937A8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83FAC 800937AC FDFF6104 */  bgez       $v1, .L800937A4
    /* 83FB0 800937B0 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83FB4 800937B4 78010224 */  addiu      $v0, $zero, 0x178
    /* 83FB8 800937B8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83FBC 800937BC 0000828C */  lw         $v0, 0x0($a0)
    /* 83FC0 800937C0 00000000 */  nop
    /* 83FC4 800937C4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83FC8 800937C8 0000A28C */  lw         $v0, 0x0($a1)
    /* 83FCC 800937CC 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83FD0 800937D0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 83FD4 800937D4 0000E28C */  lw         $v0, 0x0($a3)
    /* 83FD8 800937D8 00000000 */  nop
    /* 83FDC 800937DC 2000A2AF */  sw         $v0, 0x20($sp)
    /* 83FE0 800937E0 5800A28F */  lw         $v0, 0x58($sp)
    /* 83FE4 800937E4 00000000 */  nop
    /* 83FE8 800937E8 0000438C */  lw         $v1, 0x0($v0)
    /* 83FEC 800937EC 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 83FF0 800937F0 00000000 */  nop
    /* 83FF4 800937F4 2800A2AF */  sw         $v0, 0x28($sp)
    /* 83FF8 800937F8 6000A28F */  lw         $v0, 0x60($sp)
    /* 83FFC 800937FC 2400A3AF */  sw         $v1, 0x24($sp)
    /* 84000 80093800 0000428C */  lw         $v0, 0x0($v0)
    /* 84004 80093804 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84008 80093808 6E9C030C */  jal        SPCH_AddEvent
    /* 8400C 8009380C 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* 84010 80093810 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84014 80093814 00000000 */  nop
    /* 84018 80093818 0800E003 */  jr         $ra
    /* 8401C 8009381C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_PERP_SIGHTED
