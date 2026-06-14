.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_SPBLT_CONFIRMED, 0x68

glabel SPCHNFS_D_C_SPBLT_CONFIRMED
    /* 84804 80094004 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84808 80094008 4000BFAF */  sw         $ra, 0x40($sp)
    /* 8480C 8009400C 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84810 80094010 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80094014:
    /* 84814 80094014 000040AC */  sw         $zero, 0x0($v0)
    /* 84818 80094018 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 8481C 8009401C FDFF6104 */  bgez       $v1, .L80094014
    /* 84820 80094020 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84824 80094024 A8010224 */  addiu      $v0, $zero, 0x1A8
    /* 84828 80094028 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8482C 8009402C 0000828C */  lw         $v0, 0x0($a0)
    /* 84830 80094030 1800A5AF */  sw         $a1, 0x18($sp)
    /* 84834 80094034 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84838 80094038 0000C28C */  lw         $v0, 0x0($a2)
    /* 8483C 8009403C 00000000 */  nop
    /* 84840 80094040 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 84844 80094044 5800A28F */  lw         $v0, 0x58($sp)
    /* 84848 80094048 2000A7AF */  sw         $a3, 0x20($sp)
    /* 8484C 8009404C 0000428C */  lw         $v0, 0x0($v0)
    /* 84850 80094050 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84854 80094054 6E9C030C */  jal        SPCH_AddEvent
    /* 84858 80094058 2400A2AF */   sw        $v0, 0x24($sp)
    /* 8485C 8009405C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84860 80094060 00000000 */  nop
    /* 84864 80094064 0800E003 */  jr         $ra
    /* 84868 80094068 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_SPBLT_CONFIRMED
