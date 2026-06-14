.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextSys_LoadWords__Fi, 0x28

glabel TextSys_LoadWords__Fi
    /* A9A28 800B9228 1180023C */  lui        $v0, %hi(D_801164F0)
    /* A9A2C 800B922C F064458C */  lw         $a1, %lo(D_801164F0)($v0)
    /* A9A30 800B9230 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A9A34 800B9234 1000BFAF */  sw         $ra, 0x10($sp)
    /* A9A38 800B9238 56E4020C */  jal        TextSys_LoadWordsGeneric__FiPc
    /* A9A3C 800B923C 00000000 */   nop
    /* A9A40 800B9240 1000BF8F */  lw         $ra, 0x10($sp)
    /* A9A44 800B9244 00000000 */  nop
    /* A9A48 800B9248 0800E003 */  jr         $ra
    /* A9A4C 800B924C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel TextSys_LoadWords__Fi
