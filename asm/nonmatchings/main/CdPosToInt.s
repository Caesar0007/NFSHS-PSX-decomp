.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdPosToInt, 0x80

glabel CdPosToInt
    /* E85F8 800F7DF8 00008390 */  lbu        $v1, 0x0($a0)
    /* E85FC 800F7DFC 01008690 */  lbu        $a2, 0x1($a0)
    /* E8600 800F7E00 02290300 */  srl        $a1, $v1, 4
    /* E8604 800F7E04 80100500 */  sll        $v0, $a1, 2
    /* E8608 800F7E08 21104500 */  addu       $v0, $v0, $a1
    /* E860C 800F7E0C 40100200 */  sll        $v0, $v0, 1
    /* E8610 800F7E10 0F006330 */  andi       $v1, $v1, 0xF
    /* E8614 800F7E14 21104300 */  addu       $v0, $v0, $v1
    /* E8618 800F7E18 00290200 */  sll        $a1, $v0, 4
    /* E861C 800F7E1C 2328A200 */  subu       $a1, $a1, $v0
    /* E8620 800F7E20 80280500 */  sll        $a1, $a1, 2
    /* E8624 800F7E24 02190600 */  srl        $v1, $a2, 4
    /* E8628 800F7E28 80100300 */  sll        $v0, $v1, 2
    /* E862C 800F7E2C 21104300 */  addu       $v0, $v0, $v1
    /* E8630 800F7E30 40100200 */  sll        $v0, $v0, 1
    /* E8634 800F7E34 0F00C630 */  andi       $a2, $a2, 0xF
    /* E8638 800F7E38 21104600 */  addu       $v0, $v0, $a2
    /* E863C 800F7E3C 2128A200 */  addu       $a1, $a1, $v0
    /* E8640 800F7E40 80180500 */  sll        $v1, $a1, 2
    /* E8644 800F7E44 21186500 */  addu       $v1, $v1, $a1
    /* E8648 800F7E48 00110300 */  sll        $v0, $v1, 4
    /* E864C 800F7E4C 02008590 */  lbu        $a1, 0x2($a0)
    /* E8650 800F7E50 23104300 */  subu       $v0, $v0, $v1
    /* E8654 800F7E54 02210500 */  srl        $a0, $a1, 4
    /* E8658 800F7E58 80180400 */  sll        $v1, $a0, 2
    /* E865C 800F7E5C 21186400 */  addu       $v1, $v1, $a0
    /* E8660 800F7E60 40180300 */  sll        $v1, $v1, 1
    /* E8664 800F7E64 0F00A530 */  andi       $a1, $a1, 0xF
    /* E8668 800F7E68 21186500 */  addu       $v1, $v1, $a1
    /* E866C 800F7E6C 21104300 */  addu       $v0, $v0, $v1
    /* E8670 800F7E70 0800E003 */  jr         $ra
    /* E8674 800F7E74 6AFF4224 */   addiu     $v0, $v0, -0x96
endlabel CdPosToInt
