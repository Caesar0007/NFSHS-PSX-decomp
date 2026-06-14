.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __builtin_new, 0x28

glabel __builtin_new
    /* 9455C 800A3D5C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 94560 800A3D60 21288000 */  addu       $a1, $a0, $zero
    /* 94564 800A3D64 21200000 */  addu       $a0, $zero, $zero
    /* 94568 800A3D68 1000BFAF */  sw         $ra, 0x10($sp)
    /* 9456C 800A3D6C CF94030C */  jal        reservememadr
    /* 94570 800A3D70 21308000 */   addu      $a2, $a0, $zero
    /* 94574 800A3D74 1000BF8F */  lw         $ra, 0x10($sp)
    /* 94578 800A3D78 00000000 */  nop
    /* 9457C 800A3D7C 0800E003 */  jr         $ra
    /* 94580 800A3D80 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __builtin_new
