.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_W_D_RDBLK_PLC, 0x60

glabel SPCHNFS_W_D_RDBLK_PLC
    /* 8490C 8009410C B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 84910 80094110 4000BFAF */  sw         $ra, 0x40($sp)
    /* 84914 80094114 0B000324 */  addiu      $v1, $zero, 0xB
    /* 84918 80094118 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L8009411C:
    /* 8491C 8009411C 000040AC */  sw         $zero, 0x0($v0)
    /* 84920 80094120 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 84924 80094124 FDFF6104 */  bgez       $v1, .L8009411C
    /* 84928 80094128 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 8492C 8009412C AB010224 */  addiu      $v0, $zero, 0x1AB
    /* 84930 80094130 1000A2AF */  sw         $v0, 0x10($sp)
    /* 84934 80094134 0000828C */  lw         $v0, 0x0($a0)
    /* 84938 80094138 00000000 */  nop
    /* 8493C 8009413C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 84940 80094140 0000A28C */  lw         $v0, 0x0($a1)
    /* 84944 80094144 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 84948 80094148 1800A2AF */  sw         $v0, 0x18($sp)
    /* 8494C 8009414C 0000E28C */  lw         $v0, 0x0($a3)
    /* 84950 80094150 1000A427 */  addiu      $a0, $sp, 0x10
    /* 84954 80094154 6E9C030C */  jal        SPCH_AddEvent
    /* 84958 80094158 2000A2AF */   sw        $v0, 0x20($sp)
    /* 8495C 8009415C 4000BF8F */  lw         $ra, 0x40($sp)
    /* 84960 80094160 00000000 */  nop
    /* 84964 80094164 0800E003 */  jr         $ra
    /* 84968 80094168 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_W_D_RDBLK_PLC
