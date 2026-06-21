.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__20tMenuItemSlidingMenub, 0x3C

glabel Draw__20tMenuItemSlidingMenub
    /* DBE0 8001D3E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DBE4 8001D3E4 1000BFAF */  sw         $ra, 0x10($sp)
    /* DBE8 8001D3E8 1800838C */  lw         $v1, 0x18($a0)
    /* DBEC 8001D3EC 2138A000 */  addu       $a3, $a1, $zero
    /* DBF0 8001D3F0 28006284 */  lh         $v0, 0x28($v1)
    /* DBF4 8001D3F4 21280000 */  addu       $a1, $zero, $zero
    /* DBF8 8001D3F8 21208200 */  addu       $a0, $a0, $v0
    /* DBFC 8001D3FC 2C00628C */  lw         $v0, 0x2C($v1)
    /* DC00 8001D400 00000000 */  nop
    /* DC04 8001D404 09F84000 */  jalr       $v0
    /* DC08 8001D408 2130A000 */   addu      $a2, $a1, $zero
    /* DC0C 8001D40C 1000BF8F */  lw         $ra, 0x10($sp)
    /* DC10 8001D410 00000000 */  nop
    /* DC14 8001D414 0800E003 */  jr         $ra
    /* DC18 8001D418 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Draw__20tMenuItemSlidingMenub
