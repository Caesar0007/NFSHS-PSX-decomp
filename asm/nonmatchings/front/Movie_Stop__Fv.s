.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_Stop__Fv, 0x10

glabel Movie_Stop__Fv
    /* 3D474 8004CC74 0580033C */  lui        $v1, %hi(D_80052D18)
    /* 3D478 8004CC78 01000224 */  addiu      $v0, $zero, 0x1
    /* 3D47C 8004CC7C 0800E003 */  jr         $ra
    /* 3D480 8004CC80 182D62AC */   sw        $v0, %lo(D_80052D18)($v1)
endlabel Movie_Stop__Fv
