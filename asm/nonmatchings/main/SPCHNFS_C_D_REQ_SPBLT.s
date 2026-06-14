.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_REQ_SPBLT, 0x48

glabel SPCHNFS_C_D_REQ_SPBLT
    /* 8486C 8009406C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84870 80094070 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84874 80094074 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84878 80094078 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L8009407C:
    /* 8487C 8009407C 000040AC */  sw         $zero, 0x0($v0)
    /* 84880 80094080 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84884 80094084 FDFF6104 */  bgez       $v1, .L8009407C
    /* 84888 80094088 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8488C 8009408C A9010224 */  addiu      $v0, $zero, 0x1A9
    /* 84890 80094090 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84894 80094094 0000828C */  lw         $v0, 0x0($a0)
    /* 84898 80094098 1000A427 */  addiu      $a0, $sp, 0x10
    /* 8489C 8009409C 6E9C030C */  jal        SPCH_AddEvent
    /* 848A0 800940A0 1400A2AF */   sw        $v0, 0x14($sp)
    /* 848A4 800940A4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 848A8 800940A8 00000000 */  nop
    /* 848AC 800940AC 0800E003 */  jr         $ra
    /* 848B0 800940B0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_REQ_SPBLT
