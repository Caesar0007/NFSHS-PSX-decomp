.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__17tUserNameMenuItem, 0xC

glabel TransitionOff__17tUserNameMenuItem
    /* 10D74 80020574 1E000224 */  addiu      $v0, $zero, 0x1E
    /* 10D78 80020578 0800E003 */  jr         $ra
    /* 10D7C 8002057C 840082A4 */   sh        $v0, 0x84($a0)
endlabel TransitionOff__17tUserNameMenuItem
