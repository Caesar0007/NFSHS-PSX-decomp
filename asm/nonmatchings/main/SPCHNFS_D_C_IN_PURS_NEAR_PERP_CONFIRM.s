.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM, 0x6C

glabel SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM
    /* 83AB4 800932B4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83AB8 800932B8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83ABC 800932BC 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83AC0 800932C0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800932C4:
    /* 83AC4 800932C4 000040AC */  sw         $zero, 0x0($v0)
    /* 83AC8 800932C8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83ACC 800932CC FDFF6104 */  bgez       $v1, .L800932C4
    /* 83AD0 800932D0 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83AD4 800932D4 5B010224 */  addiu      $v0, $zero, 0x15B
    /* 83AD8 800932D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83ADC 800932DC 0000828C */  lw         $v0, 0x0($a0)
    /* 83AE0 800932E0 1800A5AF */  sw         $a1, 0x18($sp)
    /* 83AE4 800932E4 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83AE8 800932E8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83AEC 800932EC 0000E28C */  lw         $v0, 0x0($a3)
    /* 83AF0 800932F0 00000000 */  nop
    /* 83AF4 800932F4 2000A2AF */  sw         $v0, 0x20($sp)
    /* 83AF8 800932F8 5800A28F */  lw         $v0, 0x58($sp)
    /* 83AFC 800932FC 00000000 */  nop
    /* 83B00 80093300 0000428C */  lw         $v0, 0x0($v0)
    /* 83B04 80093304 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83B08 80093308 6E9C030C */  jal        SPCH_AddEvent
    /* 83B0C 8009330C 2400A2AF */   sw        $v0, 0x24($sp)
    /* 83B10 80093310 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83B14 80093314 00000000 */  nop
    /* 83B18 80093318 0800E003 */  jr         $ra
    /* 83B1C 8009331C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM
