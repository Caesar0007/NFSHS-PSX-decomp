.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__12tScreenAudioRsT1PPcT3, 0x24

glabel GetShapeInfo__12tScreenAudioRsT1PPcT3
    /* 36940 80046140 1000A28F */  lw         $v0, 0x10($sp)
    /* 36944 80046144 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 36948 80046148 000040AC */  sw         $zero, 0x0($v0)
    /* 3694C 8004614C 34000224 */  addiu      $v0, $zero, 0x34
    /* 36950 80046150 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 36954 80046154 0180023C */  lui        $v0, %hi(D_8001214C)
    /* 36958 80046158 4C214224 */  addiu      $v0, $v0, %lo(D_8001214C)
    /* 3695C 8004615C 0800E003 */  jr         $ra
    /* 36960 80046160 0000E2AC */   sw        $v0, 0x0($a3)
endlabel GetShapeInfo__12tScreenAudioRsT1PPcT3
