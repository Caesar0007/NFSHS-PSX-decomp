.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__23tScreenControllerConfigRsT1PPcT3, 0x30

glabel GetShapeInfo__23tScreenControllerConfigRsT1PPcT3
    /* 35ECC 800456CC 1000A38F */  lw         $v1, 0x10($sp)
    /* 35ED0 800456D0 18000224 */  addiu      $v0, $zero, 0x18
    /* 35ED4 800456D4 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 35ED8 800456D8 0180023C */  lui        $v0, %hi(D_8001206C)
    /* 35EDC 800456DC 6C204224 */  addiu      $v0, $v0, %lo(D_8001206C)
    /* 35EE0 800456E0 0000E2AC */  sw         $v0, 0x0($a3)
    /* 35EE4 800456E4 42000224 */  addiu      $v0, $zero, 0x42
    /* 35EE8 800456E8 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 35EEC 800456EC 0180023C */  lui        $v0, %hi(D_80012064)
    /* 35EF0 800456F0 64204224 */  addiu      $v0, $v0, %lo(D_80012064)
    /* 35EF4 800456F4 0800E003 */  jr         $ra
    /* 35EF8 800456F8 000062AC */   sw        $v0, 0x0($v1)
endlabel GetShapeInfo__23tScreenControllerConfigRsT1PPcT3
