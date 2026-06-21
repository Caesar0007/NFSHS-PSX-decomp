.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__21tListIteratorCarColor7tPlayer, 0x80

glabel Decrement__21tListIteratorCarColor7tPlayer
    /* 8E48 80018648 1000828C */  lw         $v0, 0x10($a0)
    /* 8E4C 8001864C 00000000 */  nop
    /* 8E50 80018650 00004590 */  lbu        $a1, 0x0($v0)
    /* 8E54 80018654 1400828C */  lw         $v0, 0x14($a0)
    /* 8E58 80018658 1800838C */  lw         $v1, 0x18($a0)
    /* 8E5C 8001865C 21104500 */  addu       $v0, $v0, $a1
    /* 8E60 80018660 1800A300 */  mult       $a1, $v1
    /* 8E64 80018664 00004390 */  lbu        $v1, 0x0($v0)
    /* 8E68 80018668 1C00858C */  lw         $a1, 0x1C($a0)
    /* 8E6C 8001866C 40100300 */  sll        $v0, $v1, 1
    /* 8E70 80018670 21104300 */  addu       $v0, $v0, $v1
    /* 8E74 80018674 00190200 */  sll        $v1, $v0, 4
    /* 8E78 80018678 21104300 */  addu       $v0, $v0, $v1
    /* 8E7C 8001867C 0400A38C */  lw         $v1, 0x4($a1)
    /* 8E80 80018680 80100200 */  sll        $v0, $v0, 2
    /* 8E84 80018684 21286200 */  addu       $a1, $v1, $v0
    /* 8E88 80018688 0000A280 */  lb         $v0, 0x0($a1)
    /* 8E8C 8001868C 0400838C */  lw         $v1, 0x4($a0)
    /* 8E90 80018690 12300000 */  mflo       $a2
    /* 8E94 80018694 2110C200 */  addu       $v0, $a2, $v0
    /* 8E98 80018698 21206200 */  addu       $a0, $v1, $v0
    /* 8E9C 8001869C 00008290 */  lbu        $v0, 0x0($a0)
    /* 8EA0 800186A0 00000000 */  nop
    /* 8EA4 800186A4 06004014 */  bnez       $v0, .L800186C0
    /* 8EA8 800186A8 FFFF4224 */   addiu     $v0, $v0, -0x1
    /* 8EAC 800186AC AC00A290 */  lbu        $v0, 0xAC($a1)
    /* 8EB0 800186B0 AD00A390 */  lbu        $v1, 0xAD($a1)
    /* 8EB4 800186B4 00000000 */  nop
    /* 8EB8 800186B8 21104300 */  addu       $v0, $v0, $v1
    /* 8EBC 800186BC FFFF4224 */  addiu      $v0, $v0, -0x1
  .L800186C0:
    /* 8EC0 800186C0 0800E003 */  jr         $ra
    /* 8EC4 800186C4 000082A0 */   sb        $v0, 0x0($a0)
endlabel Decrement__21tListIteratorCarColor7tPlayer
