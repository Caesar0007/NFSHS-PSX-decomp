.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_SetTrackNumber__Fi, 0x10

glabel Track_SetTrackNumber__Fi
    /* A9AF8 800B92F8 0F008430 */  andi       $a0, $a0, 0xF
    /* A9AFC 800B92FC 900F84AF */  sw         $a0, %gp_rel(gtrackNumber)($gp)
    /* A9B00 800B9300 0800E003 */  jr         $ra
    /* A9B04 800B9304 00000000 */   nop
endlabel Track_SetTrackNumber__Fi
