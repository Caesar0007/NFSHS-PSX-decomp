.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_CleanUp__Fv, 0x14

glabel SimQueue_CleanUp__Fv
    /* A7BB8 800B73B8 01000224 */  addiu      $v0, $zero, 0x1
    /* A7BBC 800B73BC EC0E82AF */  sw         $v0, %gp_rel(gSimQueue_BlockSelf)($gp)
    /* A7BC0 800B73C0 F00E82AF */  sw         $v0, %gp_rel(gSimQueue_BlockOther)($gp)
    /* A7BC4 800B73C4 0800E003 */  jr         $ra
    /* A7BC8 800B73C8 00000000 */   nop
endlabel SimQueue_CleanUp__Fv
