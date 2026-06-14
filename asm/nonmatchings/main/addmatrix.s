.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching addmatrix, 0x38

glabel addmatrix
    /* E09FC 800F01FC 21400000 */  addu       $t0, $zero, $zero
    /* E0A00 800F0200 2138C000 */  addu       $a3, $a2, $zero
  .L800F0204:
    /* E0A04 800F0204 0000A38C */  lw         $v1, 0x0($a1)
    /* E0A08 800F0208 0400A524 */  addiu      $a1, $a1, 0x4
    /* E0A0C 800F020C 0000828C */  lw         $v0, 0x0($a0)
    /* E0A10 800F0210 04008424 */  addiu      $a0, $a0, 0x4
    /* E0A14 800F0214 01000825 */  addiu      $t0, $t0, 0x1
    /* E0A18 800F0218 21104300 */  addu       $v0, $v0, $v1
    /* E0A1C 800F021C 0000E2AC */  sw         $v0, 0x0($a3)
    /* E0A20 800F0220 09000229 */  slti       $v0, $t0, 0x9
    /* E0A24 800F0224 F7FF4014 */  bnez       $v0, .L800F0204
    /* E0A28 800F0228 0400E724 */   addiu     $a3, $a3, 0x4
    /* E0A2C 800F022C 0800E003 */  jr         $ra
    /* E0A30 800F0230 2110C000 */   addu      $v0, $a2, $zero
endlabel addmatrix
