.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TurnOffShakers__23tScreenControllerConfig, 0x8

glabel TurnOffShakers__23tScreenControllerConfig
    /* 339AC 800431AC 0800E003 */  jr         $ra
    /* 339B0 800431B0 640080A0 */   sb        $zero, 0x64($a0)
endlabel TurnOffShakers__23tScreenControllerConfig
