.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__12tMenuOptions, 0x24

glabel TransitionIsFinished__12tMenuOptions
    /* C698 8001BE98 1480023C */  lui        $v0, %hi(ticks)
    /* C69C 8001BE9C ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C6A0 8001BEA0 7C00838C */  lw         $v1, 0x7C($a0)
    /* C6A4 8001BEA4 00000000 */  nop
    /* C6A8 8001BEA8 23104300 */  subu       $v0, $v0, $v1
    /* C6AC 8001BEAC 2000422C */  sltiu      $v0, $v0, 0x20
    /* C6B0 8001BEB0 700082AC */  sw         $v0, 0x70($a0)
    /* C6B4 8001BEB4 0800E003 */  jr         $ra
    /* C6B8 8001BEB8 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__12tMenuOptions
