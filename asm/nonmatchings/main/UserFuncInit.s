.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UserFuncInit, 0x10

glabel UserFuncInit
    /* FA400 80109C00 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* FA404 80109C04 1480013C */  lui        $at, %hi(D_8013C2E0)
    /* FA408 80109C08 0800E003 */  jr         $ra
    /* FA40C 80109C0C E0C222AC */   sw        $v0, %lo(D_8013C2E0)($at)
endlabel UserFuncInit
