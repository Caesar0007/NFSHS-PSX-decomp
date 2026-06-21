.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___16tScreenCarSelect, 0x28

glabel ___16tScreenCarSelect
    /* 2B490 8003AC90 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B494 8003AC94 0180023C */  lui        $v0, %hi(_vt_16tScreenCarSelect)
    /* 2B498 8003AC98 081D4224 */  addiu      $v0, $v0, %lo(_vt_16tScreenCarSelect)
    /* 2B49C 8003AC9C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 2B4A0 8003ACA0 1E98000C */  jal        ___7tScreen
    /* 2B4A4 8003ACA4 600082AC */   sw        $v0, 0x60($a0)
    /* 2B4A8 8003ACA8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 2B4AC 8003ACAC 00000000 */  nop
    /* 2B4B0 8003ACB0 0800E003 */  jr         $ra
    /* 2B4B4 8003ACB4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___16tScreenCarSelect
