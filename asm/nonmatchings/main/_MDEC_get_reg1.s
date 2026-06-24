.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _MDEC_get_reg1, 0x18

glabel _MDEC_get_reg1
    /* E962C 800F8E2C 1380023C */  lui        $v0, %hi(D_80136C3C)
    /* E9630 800F8E30 3C6C428C */  lw         $v0, %lo(D_80136C3C)($v0)
    /* E9634 800F8E34 00000000 */  nop
    /* E9638 800F8E38 0000428C */  lw         $v0, 0x0($v0)
    /* E963C 800F8E3C 0800E003 */  jr         $ra
    /* E9640 800F8E40 00000000 */   nop
endlabel _MDEC_get_reg1
