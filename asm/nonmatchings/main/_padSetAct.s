.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padSetAct, 0xC

glabel _padSetAct
    /* F5DF0 801055F0 280085AC */  sw         $a1, 0x28($a0)
    /* F5DF4 801055F4 0800E003 */  jr         $ra
    /* F5DF8 801055F8 340086A0 */   sb        $a2, 0x34($a0)
endlabel _padSetAct
