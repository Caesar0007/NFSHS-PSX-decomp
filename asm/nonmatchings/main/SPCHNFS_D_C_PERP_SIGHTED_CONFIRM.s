.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_PERP_SIGHTED_CONFIRM, 0x4C

glabel SPCHNFS_D_C_PERP_SIGHTED_CONFIRM
    /* 84020 80093820 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84024 80093824 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84028 80093828 0B000324 */  addiu      $v1, $zero, 0xB
    /* 8402C 8009382C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093830:
    /* 84030 80093830 000040AC */  sw         $zero, 0x0($v0)
    /* 84034 80093834 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84038 80093838 FDFF6104 */  bgez       $v1, .L80093830
    /* 8403C 8009383C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84040 80093840 79010224 */  addiu      $v0, $zero, 0x179
    /* 84044 80093844 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84048 80093848 0000828C */  lw         $v0, 0x0($a0)
    /* 8404C 8009384C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84050 80093850 1800A5AF */  sw         $a1, 0x18($sp)
    /* 84054 80093854 6E9C030C */  jal        SPCH_AddEvent
    /* 84058 80093858 1400A2AF */   sw        $v0, 0x14($sp)
    /* 8405C 8009385C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84060 80093860 00000000 */  nop
    /* 84064 80093864 0800E003 */  jr         $ra
    /* 84068 80093868 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_PERP_SIGHTED_CONFIRM
