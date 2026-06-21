.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__7tScreenRsT1PPcT3, 0x18

glabel GetShapeInfo__7tScreenRsT1PPcT3
    /* 16808 80026008 1000A28F */  lw         $v0, 0x10($sp)
    /* 1680C 8002600C 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 16810 80026010 0000A0A4 */  sh         $zero, 0x0($a1)
    /* 16814 80026014 000040AC */  sw         $zero, 0x0($v0)
    /* 16818 80026018 0800E003 */  jr         $ra
    /* 1681C 8002601C 0000E0AC */   sw        $zero, 0x0($a3)
endlabel GetShapeInfo__7tScreenRsT1PPcT3
