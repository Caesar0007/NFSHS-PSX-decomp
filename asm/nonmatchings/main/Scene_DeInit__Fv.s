.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Scene_DeInit__Fv, 0x20

glabel Scene_DeInit__Fv
    /* A6790 800B5F90 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6794 800B5F94 1000BFAF */  sw         $ra, 0x10($sp)
    /* A6798 800B5F98 ECD7020C */  jal        Scene_PurgeScene__Fv
    /* A679C 800B5F9C 00000000 */   nop
    /* A67A0 800B5FA0 1000BF8F */  lw         $ra, 0x10($sp)
    /* A67A4 800B5FA4 00000000 */  nop
    /* A67A8 800B5FA8 0800E003 */  jr         $ra
    /* A67AC 800B5FAC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Scene_DeInit__Fv
