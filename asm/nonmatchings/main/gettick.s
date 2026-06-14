.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching gettick, 0x10

glabel gettick
    /* D8A20 800E8220 1480023C */  lui        $v0, %hi(ticks)
    /* D8A24 800E8224 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* D8A28 800E8228 0800E003 */  jr         $ra
    /* D8A2C 800E822C 00000000 */   nop
endlabel gettick
