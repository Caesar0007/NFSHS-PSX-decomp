.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __12AIState_BaseP8Car_tObj, 0x18

glabel __12AIState_BaseP8Car_tObj
    /* 60274 8006FA74 21108000 */  addu       $v0, $a0, $zero
    /* 60278 8006FA78 0580033C */  lui        $v1, %hi(D_80055640)
    /* 6027C 8006FA7C 40566324 */  addiu      $v1, $v1, %lo(D_80055640)
    /* 60280 8006FA80 040043AC */  sw         $v1, 0x4($v0)
    /* 60284 8006FA84 0800E003 */  jr         $ra
    /* 60288 8006FA88 000045AC */   sw        $a1, 0x0($v0)
endlabel __12AIState_BaseP8Car_tObj
