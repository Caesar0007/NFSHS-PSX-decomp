.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIScript_GetReactionTicksLeft__FP10AIScript_t, 0x1C

glabel AIScript_GetReactionTicksLeft__FP10AIScript_t
    /* 60188 8006F988 0800838C */  lw         $v1, 0x8($a0)
    /* 6018C 8006F98C 07000224 */  addiu      $v0, $zero, 0x7
    /* 60190 8006F990 02006210 */  beq        $v1, $v0, .L8006F99C
    /* 60194 8006F994 21100000 */   addu      $v0, $zero, $zero
    /* 60198 8006F998 1800828C */  lw         $v0, 0x18($a0)
  .L8006F99C:
    /* 6019C 8006F99C 0800E003 */  jr         $ra
    /* 601A0 8006F9A0 00000000 */   nop
endlabel AIScript_GetReactionTicksLeft__FP10AIScript_t
