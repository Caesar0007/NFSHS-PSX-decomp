.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_REQ_RDBLK, 0x48

glabel SPCHNFS_C_D_REQ_RDBLK
    /* 83CA8 800934A8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83CAC 800934AC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83CB0 800934B0 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83CB4 800934B4 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L800934B8:
    /* 83CB8 800934B8 000040AC */  sw         $zero, 0x0($v0)
    /* 83CBC 800934BC FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83CC0 800934C0 FDFF6104 */  bgez       $v1, .L800934B8
    /* 83CC4 800934C4 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83CC8 800934C8 67010224 */  addiu      $v0, $zero, 0x167
    /* 83CCC 800934CC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83CD0 800934D0 0000828C */  lw         $v0, 0x0($a0)
    /* 83CD4 800934D4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83CD8 800934D8 6E9C030C */  jal        SPCH_AddEvent
    /* 83CDC 800934DC 1400A2AF */   sw        $v0, 0x14($sp)
    /* 83CE0 800934E0 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83CE4 800934E4 00000000 */  nop
    /* 83CE8 800934E8 0800E003 */  jr         $ra
    /* 83CEC 800934EC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_REQ_RDBLK
