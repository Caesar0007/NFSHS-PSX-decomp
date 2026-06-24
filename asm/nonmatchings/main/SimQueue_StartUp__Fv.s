.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SimQueue_StartUp__Fv, 0x2C

glabel SimQueue_StartUp__Fv
    /* A7AEC 800B72EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A7AF0 800B72F0 01000224 */  addiu      $v0, $zero, 0x1
    /* A7AF4 800B72F4 1000BFAF */  sw         $ra, 0x10($sp)
    /* A7AF8 800B72F8 EC0E82AF */  sw         $v0, %gp_rel(gSimQueue_BlockSelf)($gp)
    /* A7AFC 800B72FC F00E82AF */  sw         $v0, %gp_rel(gSimQueue_BlockOther)($gp)
    /* A7B00 800B7300 73DD020C */  jal        SimQueue_SetLag__Fv
    /* A7B04 800B7304 00000000 */   nop
    /* A7B08 800B7308 1000BF8F */  lw         $ra, 0x10($sp)
    /* A7B0C 800B730C 00000000 */  nop
    /* A7B10 800B7310 0800E003 */  jr         $ra
    /* A7B14 800B7314 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SimQueue_StartUp__Fv
