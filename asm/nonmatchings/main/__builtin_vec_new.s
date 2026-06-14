.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __builtin_vec_new, 0x28

glabel __builtin_vec_new
    /* 94584 800A3D84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 94588 800A3D88 21288000 */  addu       $a1, $a0, $zero
    /* 9458C 800A3D8C 21200000 */  addu       $a0, $zero, $zero
    /* 94590 800A3D90 1000BFAF */  sw         $ra, 0x10($sp)
    /* 94594 800A3D94 CF94030C */  jal        reservememadr
    /* 94598 800A3D98 21308000 */   addu      $a2, $a0, $zero
    /* 9459C 800A3D9C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 945A0 800A3DA0 00000000 */  nop
    /* 945A4 800A3DA4 0800E003 */  jr         $ra
    /* 945A8 800A3DA8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __builtin_vec_new
