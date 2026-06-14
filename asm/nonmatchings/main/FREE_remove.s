.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FREE_remove, 0x28

glabel FREE_remove
    /* D5704 800E4F04 1400A38C */  lw         $v1, 0x14($a1)
    /* D5708 800E4F08 1000A28C */  lw         $v0, 0x10($a1)
    /* D570C 800E4F0C 00000000 */  nop
    /* D5710 800E4F10 100062AC */  sw         $v0, 0x10($v1)
    /* D5714 800E4F14 140043AC */  sw         $v1, 0x14($v0)
    /* D5718 800E4F18 0200A294 */  lhu        $v0, 0x2($a1)
    /* D571C 800E4F1C 0000A0A4 */  sh         $zero, 0x0($a1)
    /* D5720 800E4F20 FFBF4230 */  andi       $v0, $v0, 0xBFFF
    /* D5724 800E4F24 0800E003 */  jr         $ra
    /* D5728 800E4F28 0200A2A4 */   sh        $v0, 0x2($a1)
endlabel FREE_remove
