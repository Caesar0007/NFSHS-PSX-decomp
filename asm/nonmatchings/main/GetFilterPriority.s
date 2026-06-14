.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetFilterPriority, 0x18

glabel GetFilterPriority
    /* D77FC 800E6FFC 1580023C */  lui        $v0, %hi(gEventDats)
    /* D7800 800E7000 4880428C */  lw         $v0, %lo(gEventDats)($v0)
    /* D7804 800E7004 00000000 */  nop
    /* D7808 800E7008 0800428C */  lw         $v0, 0x8($v0)
    /* D780C 800E700C 0800E003 */  jr         $ra
    /* D7810 800E7010 00000000 */   nop
endlabel GetFilterPriority
