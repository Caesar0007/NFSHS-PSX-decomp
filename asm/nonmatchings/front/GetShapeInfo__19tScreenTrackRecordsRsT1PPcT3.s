.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3, 0x24

glabel GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3
    /* 32E48 80042648 1000A38F */  lw         $v1, 0x10($sp)
    /* 32E4C 8004264C 28000224 */  addiu      $v0, $zero, 0x28
    /* 32E50 80042650 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 32E54 80042654 0180023C */  lui        $v0, %hi(D_80011FD4)
    /* 32E58 80042658 D41F4224 */  addiu      $v0, $v0, %lo(D_80011FD4)
    /* 32E5C 8004265C 0000C0A4 */  sh         $zero, 0x0($a2)
    /* 32E60 80042660 0000E2AC */  sw         $v0, 0x0($a3)
    /* 32E64 80042664 0800E003 */  jr         $ra
    /* 32E68 80042668 000060AC */   sw        $zero, 0x0($v1)
endlabel GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3
