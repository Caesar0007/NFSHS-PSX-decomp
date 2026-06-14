.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DoSlowNitrous__13AIState_Chase, 0x1C

glabel DoSlowNitrous__13AIState_Chase
    /* 607F4 8006FFF4 0000838C */  lw         $v1, 0x0($a0)
    /* 607F8 8006FFF8 00800234 */  ori        $v0, $zero, 0x8000
    /* 607FC 8006FFFC 3C0762AC */  sw         $v0, 0x73C($v1)
    /* 60800 80070000 0000838C */  lw         $v1, 0x0($a0)
    /* 60804 80070004 00C00234 */  ori        $v0, $zero, 0xC000
    /* 60808 80070008 0800E003 */  jr         $ra
    /* 6080C 8007000C 400762AC */   sw        $v0, 0x740($v1)
endlabel DoSlowNitrous__13AIState_Chase
