.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__15tMissionManager, 0x1C

glabel Initialize__15tMissionManager
    /* 24860 80034060 1180023C */  lui        $v0, %hi(frontEnd)
    /* 24864 80034064 00464224 */  addiu      $v0, $v0, %lo(frontEnd)
    /* 24868 80034068 000080A0 */  sb         $zero, 0x0($a0)
    /* 2486C 8003406C 040080AC */  sw         $zero, 0x4($a0)
    /* 24870 80034070 2B0140A0 */  sb         $zero, 0x12B($v0)
    /* 24874 80034074 0800E003 */  jr         $ra
    /* 24878 80034078 2C0140A0 */   sb        $zero, 0x12C($v0)
endlabel Initialize__15tMissionManager
