.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_GetNumIMassObjects__Fv, 0xC

glabel Object_GetNumIMassObjects__Fv
    /* 96804 800A6004 900D828F */  lw         $v0, %gp_rel(gNumIMassObjects)($gp)
    /* 96808 800A6008 0800E003 */  jr         $ra
    /* 9680C 800A600C 00000000 */   nop
endlabel Object_GetNumIMassObjects__Fv
