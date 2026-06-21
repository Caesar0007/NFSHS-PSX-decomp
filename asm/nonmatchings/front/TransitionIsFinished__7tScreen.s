.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__7tScreen, 0x18

glabel TransitionIsFinished__7tScreen
    /* 170C0 800268C0 5800828C */  lw         $v0, 0x58($a0)
    /* 170C4 800268C4 00000000 */  nop
    /* 170C8 800268C8 18004224 */  addiu      $v0, $v0, 0x18
    /* 170CC 800268CC A700422C */  sltiu      $v0, $v0, 0xA7
    /* 170D0 800268D0 0800E003 */  jr         $ra
    /* 170D4 800268D4 01004238 */   xori      $v0, $v0, 0x1
endlabel TransitionIsFinished__7tScreen
