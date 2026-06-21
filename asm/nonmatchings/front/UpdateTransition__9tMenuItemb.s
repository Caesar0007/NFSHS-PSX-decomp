.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__9tMenuItemb, 0x20

glabel UpdateTransition__9tMenuItemb
    /* 14FA8 800247A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14FAC 800247AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14FB0 800247B0 F491000C */  jal        UpdateSelFade__9tMenuItemb
    /* 14FB4 800247B4 00000000 */   nop
    /* 14FB8 800247B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 14FBC 800247BC 00000000 */  nop
    /* 14FC0 800247C0 0800E003 */  jr         $ra
    /* 14FC4 800247C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateTransition__9tMenuItemb
