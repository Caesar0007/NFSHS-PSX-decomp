.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_PERP_APPREHENSION_REPLY, 0x58

glabel SPCHNFS_D_C_PERP_APPREHENSION_REPLY
    /* 84208 80093A08 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 8420C 80093A0C 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84210 80093A10 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84214 80093A14 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093A18:
    /* 84218 80093A18 000040AC */  sw         $zero, 0x0($v0)
    /* 8421C 80093A1C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84220 80093A20 FDFF6104 */  bgez       $v1, .L80093A18
    /* 84224 80093A24 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84228 80093A28 80010224 */  addiu      $v0, $zero, 0x180
    /* 8422C 80093A2C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84230 80093A30 1400A4AF */  sw         $a0, 0x14($sp)
    /* 84234 80093A34 0000A28C */  lw         $v0, 0x0($a1)
    /* 84238 80093A38 00000000 */  nop
    /* 8423C 80093A3C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 84240 80093A40 0000C28C */  lw         $v0, 0x0($a2)
    /* 84244 80093A44 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84248 80093A48 6E9C030C */  jal        SPCH_AddEvent
    /* 8424C 80093A4C 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* 84250 80093A50 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84254 80093A54 00000000 */  nop
    /* 84258 80093A58 0800E003 */  jr         $ra
    /* 8425C 80093A5C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_PERP_APPREHENSION_REPLY
