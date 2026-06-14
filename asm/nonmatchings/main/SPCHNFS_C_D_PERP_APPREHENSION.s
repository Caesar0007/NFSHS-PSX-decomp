.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_PERP_APPREHENSION, 0x54

glabel SPCHNFS_C_D_PERP_APPREHENSION
    /* 841B4 800939B4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 841B8 800939B8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 841BC 800939BC 0B000324 */  addiu      $v1, $zero, 0xB
    /* 841C0 800939C0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800939C4:
    /* 841C4 800939C4 000040AC */  sw         $zero, 0x0($v0)
    /* 841C8 800939C8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 841CC 800939CC FDFF6104 */  bgez       $v1, .L800939C4
    /* 841D0 800939D0 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 841D4 800939D4 7F010224 */  addiu      $v0, $zero, 0x17F
    /* 841D8 800939D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 841DC 800939DC 0000828C */  lw         $v0, 0x0($a0)
    /* 841E0 800939E0 00000000 */  nop
    /* 841E4 800939E4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 841E8 800939E8 0000A28C */  lw         $v0, 0x0($a1)
    /* 841EC 800939EC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 841F0 800939F0 6E9C030C */  jal        SPCH_AddEvent
    /* 841F4 800939F4 1800A2AF */   sw        $v0, 0x18($sp)
    /* 841F8 800939F8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 841FC 800939FC 00000000 */  nop
    /* 84200 80093A00 0800E003 */  jr         $ra
    /* 84204 80093A04 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_PERP_APPREHENSION
