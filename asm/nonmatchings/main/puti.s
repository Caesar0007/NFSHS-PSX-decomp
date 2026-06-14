.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching puti, 0x28

glabel puti
    /* E38D4 800F30D4 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E38D8 800F30D8 0600C004 */  bltz       $a2, .L800F30F4
    /* E38DC 800F30DC 00000000 */   nop
  .L800F30E0:
    /* E38E0 800F30E0 000085A0 */  sb         $a1, 0x0($a0)
    /* E38E4 800F30E4 022A0500 */  srl        $a1, $a1, 8
    /* E38E8 800F30E8 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E38EC 800F30EC FCFFC104 */  bgez       $a2, .L800F30E0
    /* E38F0 800F30F0 01008424 */   addiu     $a0, $a0, 0x1
  .L800F30F4:
    /* E38F4 800F30F4 0800E003 */  jr         $ra
    /* E38F8 800F30F8 00000000 */   nop
endlabel puti
