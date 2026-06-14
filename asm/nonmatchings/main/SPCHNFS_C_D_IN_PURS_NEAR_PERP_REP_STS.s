.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS, 0x7C

glabel SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS
    /* 83A38 80093238 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83A3C 8009323C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83A40 80093240 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83A44 80093244 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093248:
    /* 83A48 80093248 000040AC */  sw         $zero, 0x0($v0)
    /* 83A4C 8009324C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83A50 80093250 FDFF6104 */  bgez       $v1, .L80093248
    /* 83A54 80093254 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83A58 80093258 5A010224 */  addiu      $v0, $zero, 0x15A
    /* 83A5C 8009325C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83A60 80093260 0000828C */  lw         $v0, 0x0($a0)
    /* 83A64 80093264 00000000 */  nop
    /* 83A68 80093268 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83A6C 8009326C 0000A28C */  lw         $v0, 0x0($a1)
    /* 83A70 80093270 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83A74 80093274 1800A2AF */  sw         $v0, 0x18($sp)
    /* 83A78 80093278 0000E28C */  lw         $v0, 0x0($a3)
    /* 83A7C 8009327C 00000000 */  nop
    /* 83A80 80093280 2000A2AF */  sw         $v0, 0x20($sp)
    /* 83A84 80093284 5800A28F */  lw         $v0, 0x58($sp)
    /* 83A88 80093288 00000000 */  nop
    /* 83A8C 8009328C 0000438C */  lw         $v1, 0x0($v0)
    /* 83A90 80093290 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 83A94 80093294 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83A98 80093298 2800A2AF */  sw         $v0, 0x28($sp)
    /* 83A9C 8009329C 6E9C030C */  jal        SPCH_AddEvent
    /* 83AA0 800932A0 2400A3AF */   sw        $v1, 0x24($sp)
    /* 83AA4 800932A4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83AA8 800932A8 00000000 */  nop
    /* 83AAC 800932AC 0800E003 */  jr         $ra
    /* 83AB0 800932B0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS
