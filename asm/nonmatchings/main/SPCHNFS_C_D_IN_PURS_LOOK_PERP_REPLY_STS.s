.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS, 0x60

glabel SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS
    /* 83C00 80093400 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 83C04 80093404 4000BFAF */  sw         $ra, 0x40($sp)
    /* 83C08 80093408 0B000324 */  addiu      $v1, $zero, 0xB
    /* 83C0C 8009340C 3C00A227 */  addiu      $v0, $sp, 0x3C
  .L80093410:
    /* 83C10 80093410 000040AC */  sw         $zero, 0x0($v0)
    /* 83C14 80093414 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 83C18 80093418 FDFF6104 */  bgez       $v1, .L80093410
    /* 83C1C 8009341C FCFF4224 */   addiu     $v0, $v0, -0x4
    /* 83C20 80093420 62010224 */  addiu      $v0, $zero, 0x162
    /* 83C24 80093424 1000A2AF */  sw         $v0, 0x10($sp)
    /* 83C28 80093428 0000828C */  lw         $v0, 0x0($a0)
    /* 83C2C 8009342C 00000000 */  nop
    /* 83C30 80093430 1400A2AF */  sw         $v0, 0x14($sp)
    /* 83C34 80093434 0000A28C */  lw         $v0, 0x0($a1)
    /* 83C38 80093438 1C00A6AF */  sw         $a2, 0x1C($sp)
    /* 83C3C 8009343C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 83C40 80093440 0000E28C */  lw         $v0, 0x0($a3)
    /* 83C44 80093444 1000A427 */  addiu      $a0, $sp, 0x10
    /* 83C48 80093448 6E9C030C */  jal        SPCH_AddEvent
    /* 83C4C 8009344C 2000A2AF */   sw        $v0, 0x20($sp)
    /* 83C50 80093450 4000BF8F */  lw         $ra, 0x40($sp)
    /* 83C54 80093454 00000000 */  nop
    /* 83C58 80093458 0800E003 */  jr         $ra
    /* 83C5C 8009345C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS
