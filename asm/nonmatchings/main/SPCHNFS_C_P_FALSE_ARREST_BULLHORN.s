.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_P_FALSE_ARREST_BULLHORN, 0x48

glabel SPCHNFS_C_P_FALSE_ARREST_BULLHORN
    /* 843E4 80093BE4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 843E8 80093BE8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 843EC 80093BEC 0B000324 */  addiu      $v1, $zero, 0xB
    /* 843F0 80093BF0 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093BF4:
    /* 843F4 80093BF4 000040AC */  sw         $zero, 0x0($v0)
    /* 843F8 80093BF8 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 843FC 80093BFC FDFF6104 */  bgez       $v1, .L80093BF4
    /* 84400 80093C00 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 84404 80093C04 8A010224 */  addiu      $v0, $zero, 0x18A
    /* 84408 80093C08 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8440C 80093C0C 0000828C */  lw         $v0, 0x0($a0)
    /* 84410 80093C10 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84414 80093C14 6E9C030C */  jal        SPCH_AddEvent
    /* 84418 80093C18 1400A2AF */   sw        $v0, 0x14($sp)
    /* 8441C 80093C1C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84420 80093C20 00000000 */  nop
    /* 84424 80093C24 0800E003 */  jr         $ra
    /* 84428 80093C28 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_P_FALSE_ARREST_BULLHORN
