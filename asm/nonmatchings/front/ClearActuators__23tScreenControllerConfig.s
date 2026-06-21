.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearActuators__23tScreenControllerConfig, 0xC

glabel ClearActuators__23tScreenControllerConfig
    /* 33918 80043118 6A0080A0 */  sb         $zero, 0x6A($a0)
    /* 3391C 8004311C 0800E003 */  jr         $ra
    /* 33920 80043120 6B0080A0 */   sb        $zero, 0x6B($a0)
endlabel ClearActuators__23tScreenControllerConfig
