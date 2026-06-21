.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetMissionToRace__15tMissionManagerPP12tMissionInfo, 0x44

glabel GetMissionToRace__15tMissionManagerPP12tMissionInfo
    /* 24A5C 8003425C 1180063C */  lui        $a2, %hi(frontEnd)
    /* 24A60 80034260 0046C624 */  addiu      $a2, $a2, %lo(frontEnd)
    /* 24A64 80034264 2B01C290 */  lbu        $v0, 0x12B($a2)
    /* 24A68 80034268 0400848C */  lw         $a0, 0x4($a0)
    /* 24A6C 8003426C 80100200 */  sll        $v0, $v0, 2
    /* 24A70 80034270 21108200 */  addu       $v0, $a0, $v0
    /* 24A74 80034274 02004390 */  lbu        $v1, 0x2($v0)
    /* 24A78 80034278 2C01C290 */  lbu        $v0, 0x12C($a2)
    /* 24A7C 8003427C 00000000 */  nop
    /* 24A80 80034280 21186200 */  addu       $v1, $v1, $v0
    /* 24A84 80034284 80100300 */  sll        $v0, $v1, 2
    /* 24A88 80034288 21104300 */  addu       $v0, $v0, $v1
    /* 24A8C 8003428C 80100200 */  sll        $v0, $v0, 2
    /* 24A90 80034290 20004224 */  addiu      $v0, $v0, 0x20
    /* 24A94 80034294 21208200 */  addu       $a0, $a0, $v0
    /* 24A98 80034298 0800E003 */  jr         $ra
    /* 24A9C 8003429C 0000A4AC */   sw        $a0, 0x0($a1)
endlabel GetMissionToRace__15tMissionManagerPP12tMissionInfo
