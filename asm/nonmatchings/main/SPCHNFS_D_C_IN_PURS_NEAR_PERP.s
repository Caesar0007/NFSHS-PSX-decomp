.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_D_C_IN_PURS_NEAR_PERP, 0x48

glabel SPCHNFS_D_C_IN_PURS_NEAR_PERP
    /* 839F0 800931F0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 839F4 800931F4 4000BFAF */  sw         $ra, 0x40($sp)
    /* 839F8 800931F8 0B000324 */  addiu      $v1, $zero, 0xB
    /* 839FC 800931FC 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093200:
    /* 83A00 80093200 000040AC */  sw         $zero, 0x0($v0)
    /* 83A04 80093204 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83A08 80093208 FDFF6104 */  bgez       $v1, .L80093200
    /* 83A0C 8009320C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83A10 80093210 59010224 */  addiu      $v0, $zero, 0x159
    /* 83A14 80093214 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83A18 80093218 0000828C */  lw         $v0, 0x0($a0)
    /* 83A1C 8009321C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83A20 80093220 6E9C030C */  jal        SPCH_AddEvent
    /* 83A24 80093224 1400A2AF */   sw        $v0, 0x14($sp)
    /* 83A28 80093228 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83A2C 8009322C 00000000 */  nop
    /* 83A30 80093230 0800E003 */  jr         $ra
    /* 83A34 80093234 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_D_C_IN_PURS_NEAR_PERP
