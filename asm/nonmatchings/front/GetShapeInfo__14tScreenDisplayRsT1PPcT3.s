.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__14tScreenDisplayRsT1PPcT3, 0x28

glabel GetShapeInfo__14tScreenDisplayRsT1PPcT3
    /* 361DC 800459DC 1000A28F */  lw         $v0, 0x10($sp)
    /* 361E0 800459E0 00000000 */  nop
    /* 361E4 800459E4 000040AC */  sw         $zero, 0x0($v0)
    /* 361E8 800459E8 2B000224 */  addiu      $v0, $zero, 0x2B
    /* 361EC 800459EC 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 361F0 800459F0 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 361F4 800459F4 0180023C */  lui        $v0, %hi(D_800120C8)
    /* 361F8 800459F8 C8204224 */  addiu      $v0, $v0, %lo(D_800120C8)
    /* 361FC 800459FC 0800E003 */  jr         $ra
    /* 36200 80045A00 0000E2AC */   sw        $v0, 0x0($a3)
endlabel GetShapeInfo__14tScreenDisplayRsT1PPcT3
