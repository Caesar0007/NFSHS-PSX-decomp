.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_Restart__Fv, 0x20

glabel BWorldSm_Restart__Fv
    /* 6F148 8007E948 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6F14C 8007E94C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6F150 8007E950 6B00020C */  jal        NormalCache_Init__Fv
    /* 6F154 8007E954 00000000 */   nop
    /* 6F158 8007E958 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6F15C 8007E95C 00000000 */  nop
    /* 6F160 8007E960 0800E003 */  jr         $ra
    /* 6F164 8007E964 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BWorldSm_Restart__Fv
