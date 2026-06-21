.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__14tScreenMemcardRsT1PPcT3, 0x24

glabel GetShapeInfo__14tScreenMemcardRsT1PPcT3
    /* 36B20 80046320 1000A28F */  lw         $v0, 0x10($sp)
    /* 36B24 80046324 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 36B28 80046328 000040AC */  sw         $zero, 0x0($v0)
    /* 36B2C 8004632C 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 36B30 80046330 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 36B34 80046334 0180023C */  lui        $v0, %hi(D_800121B4)
    /* 36B38 80046338 B4214224 */  addiu      $v0, $v0, %lo(D_800121B4)
    /* 36B3C 8004633C 0800E003 */  jr         $ra
    /* 36B40 80046340 0000E2AC */   sw        $v0, 0x0($a3)
endlabel GetShapeInfo__14tScreenMemcardRsT1PPcT3
