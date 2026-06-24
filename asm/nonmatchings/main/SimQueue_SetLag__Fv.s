.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_SetLag__Fv, 0x2C

glabel SimQueue_SetLag__Fv
    /* A7DCC 800B75CC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* A7DD0 800B75D0 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* A7DD4 800B75D4 00000000 */  nop
    /* A7DD8 800B75D8 03006010 */  beqz       $v1, .L800B75E8
    /* A7DDC 800B75DC 01000224 */   addiu     $v0, $zero, 0x1
    /* A7DE0 800B75E0 03006214 */  bne        $v1, $v0, .L800B75F0
    /* A7DE4 800B75E4 00000000 */   nop
  .L800B75E8:
    /* A7DE8 800B75E8 04000224 */  addiu      $v0, $zero, 0x4
    /* A7DEC 800B75EC 841882AF */  sw         $v0, %gp_rel(D_8013DDD0)($gp)
  .L800B75F0:
    /* A7DF0 800B75F0 0800E003 */  jr         $ra
    /* A7DF4 800B75F4 00000000 */   nop
endlabel SimQueue_SetLag__Fv
