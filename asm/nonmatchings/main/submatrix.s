.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching submatrix, 0x38

glabel submatrix
    /* E0A34 800F0234 21400000 */  addu       $t0, $zero, $zero
    /* E0A38 800F0238 2138C000 */  addu       $a3, $a2, $zero
  .L800F023C:
    /* E0A3C 800F023C 0000A38C */  lw         $v1, 0x0($a1)
    /* E0A40 800F0240 0400A524 */  addiu      $a1, $a1, 0x4
    /* E0A44 800F0244 0000828C */  lw         $v0, 0x0($a0)
    /* E0A48 800F0248 04008424 */  addiu      $a0, $a0, 0x4
    /* E0A4C 800F024C 01000825 */  addiu      $t0, $t0, 0x1
    /* E0A50 800F0250 23104300 */  subu       $v0, $v0, $v1
    /* E0A54 800F0254 0000E2AC */  sw         $v0, 0x0($a3)
    /* E0A58 800F0258 09000229 */  slti       $v0, $t0, 0x9
    /* E0A5C 800F025C F7FF4014 */  bnez       $v0, .L800F023C
    /* E0A60 800F0260 0400E724 */   addiu     $a3, $a3, 0x4
    /* E0A64 800F0264 0800E003 */  jr         $ra
    /* E0A68 800F0268 2110C000 */   addu      $v0, $a2, $zero
endlabel submatrix
