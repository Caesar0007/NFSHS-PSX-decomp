.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_UNormal__FP12BWorldSm_Pos, 0x28

glabel BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 70D20 80080520 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 70D24 80080524 1000B0AF */  sw         $s0, 0x10($sp)
    /* 70D28 80080528 1400BFAF */  sw         $ra, 0x14($sp)
    /* 70D2C 8008052C 7A00020C */  jal        Check_Rot__FP12BWorldSm_Pos
    /* 70D30 80080530 21808000 */   addu      $s0, $a0, $zero
    /* 70D34 80080534 5C000226 */  addiu      $v0, $s0, 0x5C
    /* 70D38 80080538 1400BF8F */  lw         $ra, 0x14($sp)
    /* 70D3C 8008053C 1000B08F */  lw         $s0, 0x10($sp)
    /* 70D40 80080540 0800E003 */  jr         $ra
    /* 70D44 80080544 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorldSm_UNormal__FP12BWorldSm_Pos
