.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS, 0x48

glabel SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS
    /* 83C60 80093460 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83C64 80093464 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83C68 80093468 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83C6C 8009346C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093470:
    /* 83C70 80093470 000040AC */  sw         $zero, 0x0($v0)
    /* 83C74 80093474 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83C78 80093478 FDFF6104 */  bgez       $v1, .L80093470
    /* 83C7C 8009347C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83C80 80093480 65010224 */  addiu      $v0, $zero, 0x165
    /* 83C84 80093484 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83C88 80093488 0000828C */  lw         $v0, 0x0($a0)
    /* 83C8C 8009348C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83C90 80093490 6E9C030C */  jal        SPCH_AddEvent
    /* 83C94 80093494 1400A2AF */   sw        $v0, 0x14($sp)
    /* 83C98 80093498 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83C9C 8009349C 00000000 */  nop
    /* 83CA0 800934A0 0800E003 */  jr         $ra
    /* 83CA4 800934A4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS
