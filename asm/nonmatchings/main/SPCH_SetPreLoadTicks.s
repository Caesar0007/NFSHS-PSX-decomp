.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_SetPreLoadTicks, 0xC

glabel SPCH_SetPreLoadTicks
    /* F20F4 801018F4 1580023C */  lui        $v0, %hi(gPreLoadTicks)
    /* F20F8 801018F8 0800E003 */  jr         $ra
    /* F20FC 801018FC 448044AC */   sw        $a0, %lo(gPreLoadTicks)($v0)
endlabel SPCH_SetPreLoadTicks
