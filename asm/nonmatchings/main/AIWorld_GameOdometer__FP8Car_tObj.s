.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_GameOdometer__FP8Car_tObj, 0x18

glabel AIWorld_GameOdometer__FP8Car_tObj
    /* 63AD8 800732D8 06008394 */  lhu        $v1, 0x6($a0)
    /* 63ADC 800732DC 00000000 */  nop
    /* 63AE0 800732E0 40100300 */  sll        $v0, $v1, 1
    /* 63AE4 800732E4 21104300 */  addu       $v0, $v0, $v1
    /* 63AE8 800732E8 0800E003 */  jr         $ra
    /* 63AEC 800732EC 40140200 */   sll       $v0, $v0, 17
endlabel AIWorld_GameOdometer__FP8Car_tObj
