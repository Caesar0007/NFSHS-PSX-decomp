.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXFront_FreeDrawMemory__Fv, 0x20

glabel PSXFront_FreeDrawMemory__Fv
    /* 3E030 8004D830 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3E034 8004D834 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3E038 8004D838 E7F7020C */  jal        ClearPrimitivesBuffer__Fv
    /* 3E03C 8004D83C 00000000 */   nop
    /* 3E040 8004D840 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3E044 8004D844 00000000 */  nop
    /* 3E048 8004D848 0800E003 */  jr         $ra
    /* 3E04C 8004D84C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PSXFront_FreeDrawMemory__Fv
