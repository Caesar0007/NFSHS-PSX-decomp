.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching deltimer, 0x38

glabel deltimer
    /* DB848 800EB048 21280000 */  addu       $a1, $zero, $zero
    /* DB84C 800EB04C 1280023C */  lui        $v0, %hi(tmrsub)
    /* DB850 800EB050 0C364324 */  addiu      $v1, $v0, %lo(tmrsub)
  .L800EB054:
    /* DB854 800EB054 0000628C */  lw         $v0, 0x0($v1)
    /* DB858 800EB058 00000000 */  nop
    /* DB85C 800EB05C 03004414 */  bne        $v0, $a0, .L800EB06C
    /* DB860 800EB060 0100A524 */   addiu     $a1, $a1, 0x1
    /* DB864 800EB064 0800E003 */  jr         $ra
    /* DB868 800EB068 000060AC */   sw        $zero, 0x0($v1)
  .L800EB06C:
    /* DB86C 800EB06C 0800A228 */  slti       $v0, $a1, 0x8
    /* DB870 800EB070 F8FF4014 */  bnez       $v0, .L800EB054
    /* DB874 800EB074 04006324 */   addiu     $v1, $v1, 0x4
    /* DB878 800EB078 0800E003 */  jr         $ra
    /* DB87C 800EB07C 00000000 */   nop
endlabel deltimer
