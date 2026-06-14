.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching putm, 0x28

glabel putm
    /* E38AC 800F30AC FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E38B0 800F30B0 0600C004 */  bltz       $a2, .L800F30CC
    /* E38B4 800F30B4 21208600 */   addu      $a0, $a0, $a2
  .L800F30B8:
    /* E38B8 800F30B8 000085A0 */  sb         $a1, 0x0($a0)
    /* E38BC 800F30BC 022A0500 */  srl        $a1, $a1, 8
    /* E38C0 800F30C0 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E38C4 800F30C4 FCFFC104 */  bgez       $a2, .L800F30B8
    /* E38C8 800F30C8 FFFF8424 */   addiu     $a0, $a0, -0x1
  .L800F30CC:
    /* E38CC 800F30CC 0800E003 */  jr         $ra
    /* E38D0 800F30D0 00000000 */   nop
endlabel putm
