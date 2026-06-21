.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetCarViewable__11tCarManager10tCarModelsb, 0x1C

glabel SetCarViewable__11tCarManager10tCarModelsb
    /* 7674 80016E74 21208500 */  addu       $a0, $a0, $a1
    /* 7678 80016E78 0300C014 */  bnez       $a2, .L80016E88
    /* 767C 80016E7C 380286A0 */   sb        $a2, 0x238($a0)
    /* 7680 80016E80 01000224 */  addiu      $v0, $zero, 0x1
    /* 7684 80016E84 080282A0 */  sb         $v0, 0x208($a0)
  .L80016E88:
    /* 7688 80016E88 0800E003 */  jr         $ra
    /* 768C 80016E8C 00000000 */   nop
endlabel SetCarViewable__11tCarManager10tCarModelsb
