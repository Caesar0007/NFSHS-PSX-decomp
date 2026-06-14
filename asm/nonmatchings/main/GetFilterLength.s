.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetFilterLength, 0x18

glabel GetFilterLength
    /* D77E4 800E6FE4 1580023C */  lui        $v0, %hi(gEventDats)
    /* D77E8 800E6FE8 4880428C */  lw         $v0, %lo(gEventDats)($v0)
    /* D77EC 800E6FEC 00000000 */  nop
    /* D77F0 800E6FF0 0400428C */  lw         $v0, 0x4($v0)
    /* D77F4 800E6FF4 0800E003 */  jr         $ra
    /* D77F8 800E6FF8 00000000 */   nop
endlabel GetFilterLength
