.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching shapepointer, 0x28

glabel shapepointer
    /* E12B8 800F0AB8 0800888C */  lw         $t0, 0x8($a0)
    /* E12BC 800F0ABC C0500500 */  sll        $t2, $a1, 3
    /* E12C0 800F0AC0 2B08A800 */  sltu       $at, $a1, $t0
    /* E12C4 800F0AC4 04002010 */  beqz       $at, .L800F0AD8
    /* E12C8 800F0AC8 21508A00 */   addu      $t2, $a0, $t2
    /* E12CC 800F0ACC 1400428D */  lw         $v0, 0x14($t2)
    /* E12D0 800F0AD0 0800E003 */  jr         $ra
    /* E12D4 800F0AD4 21108200 */   addu      $v0, $a0, $v0
  .L800F0AD8:
    /* E12D8 800F0AD8 0800E003 */  jr         $ra
    /* E12DC 800F0ADC 00000224 */   addiu     $v0, $zero, 0x0
endlabel shapepointer
