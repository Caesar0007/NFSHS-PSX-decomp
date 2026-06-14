.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_StartUp__Fv, 0x38

glabel AISpeeds_StartUp__Fv
    /* 5DDB4 8006D5B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5DDB8 8006D5B8 1480043C */  lui        $a0, %hi(D_8013C5D0)
    /* 5DDBC 8006D5BC D0C58424 */  addiu      $a0, $a0, %lo(D_8013C5D0)
    /* 5DDC0 8006D5C0 04010524 */  addiu      $a1, $zero, 0x104
    /* 5DDC4 8006D5C4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 5DDC8 8006D5C8 CF94030C */  jal        reservememadr
    /* 5DDCC 8006D5CC 21300000 */   addu      $a2, $zero, $zero
    /* 5DDD0 8006D5D0 640082AF */  sw         $v0, %gp_rel(D_8013C5B0)($gp)
    /* 5DDD4 8006D5D4 7BB5010C */  jal        AISpeeds_ReadTuningInfo__Fv
    /* 5DDD8 8006D5D8 00000000 */   nop
    /* 5DDDC 8006D5DC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5DDE0 8006D5E0 00000000 */  nop
    /* 5DDE4 8006D5E4 0800E003 */  jr         $ra
    /* 5DDE8 8006D5E8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AISpeeds_StartUp__Fv
