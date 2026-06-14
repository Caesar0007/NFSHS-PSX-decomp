.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_PERP_CRASH_GEN, 0x88

glabel SPCHNFS_C_D_PERP_CRASH_GEN
    /* 84260 80093A60 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84264 80093A64 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84268 80093A68 0B000824 */  addiu      $t0, $zero, 0xB
    /* 8426C 80093A6C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093A70:
    /* 84270 80093A70 000040AC */  sw         $zero, 0x0($v0)
    /* 84274 80093A74 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 84278 80093A78 FDFF0105 */  bgez       $t0, .L80093A70
    /* 8427C 80093A7C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84280 80093A80 81010224 */  addiu      $v0, $zero, 0x181
    /* 84284 80093A84 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84288 80093A88 0000828C */  lw         $v0, 0x0($a0)
    /* 8428C 80093A8C 00000000 */  nop
    /* 84290 80093A90 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84294 80093A94 0000A28C */  lw         $v0, 0x0($a1)
    /* 84298 80093A98 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 8429C 80093A9C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 842A0 80093AA0 5800A28F */  lw         $v0, 0x58($sp)
    /* 842A4 80093AA4 0000E38C */  lw         $v1, 0x0($a3)
    /* 842A8 80093AA8 2400A2AF */  sw         $v0, 0x24($sp)
    /* 842AC 80093AAC 5C00A28F */  lw         $v0, 0x5C($sp)
    /* 842B0 80093AB0 2000A3AF */  sw         $v1, 0x20($sp)
    /* 842B4 80093AB4 0000428C */  lw         $v0, 0x0($v0)
    /* 842B8 80093AB8 00000000 */  nop
    /* 842BC 80093ABC 2800A2AF */  sw         $v0, 0x28($sp)
    /* 842C0 80093AC0 6000A28F */  lw         $v0, 0x60($sp)
    /* 842C4 80093AC4 00000000 */  nop
    /* 842C8 80093AC8 0000428C */  lw         $v0, 0x0($v0)
    /* 842CC 80093ACC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 842D0 80093AD0 6E9C030C */  jal        SPCH_AddEvent
    /* 842D4 80093AD4 2C00A2AF */   sw        $v0, 0x2C($sp)
    /* 842D8 80093AD8 4000BF8F */  lw         $ra, 0x40($sp)
    /* 842DC 80093ADC 00000000 */  nop
    /* 842E0 80093AE0 0800E003 */  jr         $ra
    /* 842E4 80093AE4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_PERP_CRASH_GEN
