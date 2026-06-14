.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM, 0x6C

glabel SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM
    /* 83B94 80093394 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83B98 80093398 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83B9C 8009339C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83BA0 800933A0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800933A4:
    /* 83BA4 800933A4 000040AC */  sw         $zero, 0x0($v0)
    /* 83BA8 800933A8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83BAC 800933AC FDFF6104 */  bgez       $v1, .L800933A4
    /* 83BB0 800933B0 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83BB4 800933B4 5F010224 */  addiu      $v0, $zero, 0x15F
    /* 83BB8 800933B8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83BBC 800933BC 0000828C */  lw         $v0, 0x0($a0)
    /* 83BC0 800933C0 1800A5AF */  sw         $a1, 0x18($sp)
    /* 83BC4 800933C4 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83BC8 800933C8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83BCC 800933CC 0000E28C */  lw         $v0, 0x0($a3)
    /* 83BD0 800933D0 00000000 */  nop
    /* 83BD4 800933D4 2000A2AF */  sw         $v0, 0x20($sp)
    /* 83BD8 800933D8 5800A28F */  lw         $v0, 0x58($sp)
    /* 83BDC 800933DC 00000000 */  nop
    /* 83BE0 800933E0 0000428C */  lw         $v0, 0x0($v0)
    /* 83BE4 800933E4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83BE8 800933E8 6E9C030C */  jal        SPCH_AddEvent
    /* 83BEC 800933EC 2400A2AF */   sw        $v0, 0x24($sp)
    /* 83BF0 800933F0 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83BF4 800933F4 00000000 */  nop
    /* 83BF8 800933F8 0800E003 */  jr         $ra
    /* 83BFC 800933FC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM
