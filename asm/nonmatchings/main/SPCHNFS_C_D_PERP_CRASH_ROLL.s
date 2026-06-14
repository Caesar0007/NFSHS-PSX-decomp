.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_PERP_CRASH_ROLL, 0x74

glabel SPCHNFS_C_D_PERP_CRASH_ROLL
    /* 849E4 800941E4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 849E8 800941E8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 849EC 800941EC 0B000324 */  addiu      $v1, $zero, 0xB
    /* 849F0 800941F0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800941F4:
    /* 849F4 800941F4 000040AC */  sw         $zero, 0x0($v0)
    /* 849F8 800941F8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 849FC 800941FC FDFF6104 */  bgez       $v1, .L800941F4
    /* 84A00 80094200 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84A04 80094204 AE010224 */  addiu      $v0, $zero, 0x1AE
    /* 84A08 80094208 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84A0C 8009420C 0000828C */  lw         $v0, 0x0($a0)
    /* 84A10 80094210 00000000 */  nop
    /* 84A14 80094214 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84A18 80094218 0000A28C */  lw         $v0, 0x0($a1)
    /* 84A1C 8009421C 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 84A20 80094220 1800A2AF */  sw         $v0, 0x18($sp)
    /* 84A24 80094224 0000E28C */  lw         $v0, 0x0($a3)
    /* 84A28 80094228 00000000 */  nop
    /* 84A2C 8009422C 2000A2AF */  sw         $v0, 0x20($sp)
    /* 84A30 80094230 5800A28F */  lw         $v0, 0x58($sp)
    /* 84A34 80094234 00000000 */  nop
    /* 84A38 80094238 0000428C */  lw         $v0, 0x0($v0)
    /* 84A3C 8009423C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84A40 80094240 6E9C030C */  jal        SPCH_AddEvent
    /* 84A44 80094244 2400A2AF */   sw        $v0, 0x24($sp)
    /* 84A48 80094248 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84A4C 8009424C 00000000 */  nop
    /* 84A50 80094250 0800E003 */  jr         $ra
    /* 84A54 80094254 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_PERP_CRASH_ROLL
