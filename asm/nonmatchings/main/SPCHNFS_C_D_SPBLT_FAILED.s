.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_SPBLT_FAILED, 0x58

glabel SPCHNFS_C_D_SPBLT_FAILED
    /* 848B4 800940B4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 848B8 800940B8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 848BC 800940BC 0B000324 */  addiu      $v1, $zero, 0xB
    /* 848C0 800940C0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800940C4:
    /* 848C4 800940C4 000040AC */  sw         $zero, 0x0($v0)
    /* 848C8 800940C8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 848CC 800940CC FDFF6104 */  bgez       $v1, .L800940C4
    /* 848D0 800940D0 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 848D4 800940D4 AA010224 */  addiu      $v0, $zero, 0x1AA
    /* 848D8 800940D8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 848DC 800940DC 0000828C */  lw         $v0, 0x0($a0)
    /* 848E0 800940E0 00000000 */  nop
    /* 848E4 800940E4 1400A2AF */  sw         $v0, 0x14($sp)
    /* 848E8 800940E8 0000A28C */  lw         $v0, 0x0($a1)
    /* 848EC 800940EC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 848F0 800940F0 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 848F4 800940F4 6E9C030C */  jal        SPCH_AddEvent
    /* 848F8 800940F8 1800A2AF */   sw        $v0, 0x18($sp)
    /* 848FC 800940FC 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84900 80094100 00000000 */  nop
    /* 84904 80094104 0800E003 */  jr         $ra
    /* 84908 80094108 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_SPBLT_FAILED
