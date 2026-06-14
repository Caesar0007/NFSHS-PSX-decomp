.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_UForward__FP12BWorldSm_Pos, 0x28

glabel BWorldSm_UForward__FP12BWorldSm_Pos
    /* 70D48 80080548 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 70D4C 8008054C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 70D50 80080550 1400BFAF */  sw         $ra, 0x14($sp)
    /* 70D54 80080554 7A00020C */  jal        Check_Rot__FP12BWorldSm_Pos
    /* 70D58 80080558 21808000 */   addu      $s0, $a0, $zero
    /* 70D5C 8008055C 68000226 */  addiu      $v0, $s0, 0x68
    /* 70D60 80080560 1400BF8F */  lw         $ra, 0x14($sp)
    /* 70D64 80080564 1000B08F */  lw         $s0, 0x10($sp)
    /* 70D68 80080568 0800E003 */  jr         $ra
    /* 70D6C 8008056C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorldSm_UForward__FP12BWorldSm_Pos
