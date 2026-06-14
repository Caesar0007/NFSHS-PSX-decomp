.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TestForRelease__21AIState_RovingTraffic, 0x18

glabel TestForRelease__21AIState_RovingTraffic
    /* 62EC4 800726C4 1000828C */  lw         $v0, 0x10($a0)
    /* 62EC8 800726C8 0C00838C */  lw         $v1, 0xC($a0)
    /* 62ECC 800726CC 00000000 */  nop
    /* 62ED0 800726D0 2A104300 */  slt        $v0, $v0, $v1
    /* 62ED4 800726D4 0800E003 */  jr         $ra
    /* 62ED8 800726D8 01004238 */   xori      $v0, $v0, 0x1
endlabel TestForRelease__21AIState_RovingTraffic
