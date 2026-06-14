.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_A_CONFIRM, 0x48

glabel SPCHNFS_D_A_CONFIRM
    /* 84A58 80094258 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84A5C 8009425C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84A60 80094260 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84A64 80094264 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80094268:
    /* 84A68 80094268 000040AC */  sw         $zero, 0x0($v0)
    /* 84A6C 8009426C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84A70 80094270 FDFF6104 */  bgez       $v1, .L80094268
    /* 84A74 80094274 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84A78 80094278 B1010224 */  addiu      $v0, $zero, 0x1B1
    /* 84A7C 8009427C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84A80 80094280 0000828C */  lw         $v0, 0x0($a0)
    /* 84A84 80094284 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84A88 80094288 6E9C030C */  jal        SPCH_AddEvent
    /* 84A8C 8009428C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 84A90 80094290 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84A94 80094294 00000000 */  nop
    /* 84A98 80094298 0800E003 */  jr         $ra
    /* 84A9C 8009429C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_A_CONFIRM
