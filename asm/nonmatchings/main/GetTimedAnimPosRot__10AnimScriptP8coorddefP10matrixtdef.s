.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef, 0x2C

glabel GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef
    /* 64DF8 800745F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 64DFC 800745FC 2110A000 */  addu       $v0, $a1, $zero
    /* 64E00 80074600 2138C000 */  addu       $a3, $a2, $zero
    /* 64E04 80074604 21280000 */  addu       $a1, $zero, $zero
    /* 64E08 80074608 1000BFAF */  sw         $ra, 0x10($sp)
    /* 64E0C 8007460C 89D1010C */  jal        GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
    /* 64E10 80074610 21304000 */   addu      $a2, $v0, $zero
    /* 64E14 80074614 1000BF8F */  lw         $ra, 0x10($sp)
    /* 64E18 80074618 00000000 */  nop
    /* 64E1C 8007461C 0800E003 */  jr         $ra
    /* 64E20 80074620 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef
