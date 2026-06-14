.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIScript_ClearLastReactionIndex__FP10AIScript_t, 0x24

glabel AIScript_ClearLastReactionIndex__FP10AIScript_t
    /* 5FF00 8006F700 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 5FF04 8006F704 06000224 */  addiu      $v0, $zero, 0x6
    /* 5FF08 8006F708 18008424 */  addiu      $a0, $a0, 0x18
  .L8006F70C:
    /* 5FF0C 8006F70C 200083AC */  sw         $v1, 0x20($a0)
    /* 5FF10 8006F710 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 5FF14 8006F714 FDFF4104 */  bgez       $v0, .L8006F70C
    /* 5FF18 8006F718 FCFF8424 */   addiu     $a0, $a0, -0x4
    /* 5FF1C 8006F71C 0800E003 */  jr         $ra
    /* 5FF20 8006F720 00000000 */   nop
endlabel AIScript_ClearLastReactionIndex__FP10AIScript_t
