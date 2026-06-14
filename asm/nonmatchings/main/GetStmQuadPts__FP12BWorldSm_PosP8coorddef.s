.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetStmQuadPts__FP12BWorldSm_PosP8coorddef, 0x128

glabel GetStmQuadPts__FP12BWorldSm_PosP8coorddef
    /* 6F5B8 8007EDB8 0000AB8C */  lw         $t3, 0x0($a1)
    /* 6F5BC 8007EDBC 0400AA8C */  lw         $t2, 0x4($a1)
    /* 6F5C0 8007EDC0 0800A98C */  lw         $t1, 0x8($a1)
    /* 6F5C4 8007EDC4 08008524 */  addiu      $a1, $a0, 0x8
    /* 6F5C8 8007EDC8 7C00828C */  lw         $v0, 0x7C($a0)
    /* 6F5CC 8007EDCC 75008390 */  lbu        $v1, 0x75($a0)
    /* 6F5D0 8007EDD0 02008C84 */  lh         $t4, 0x2($a0)
    /* 6F5D4 8007EDD4 00004690 */  lbu        $a2, 0x0($v0)
    /* 6F5D8 8007EDD8 01004790 */  lbu        $a3, 0x1($v0)
    /* 6F5DC 8007EDDC C0100300 */  sll        $v0, $v1, 3
    /* 6F5E0 8007EDE0 23104300 */  subu       $v0, $v0, $v1
    /* 6F5E4 8007EDE4 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 6F5E8 8007EDE8 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 6F5EC 8007EDEC 00110200 */  sll        $v0, $v0, 4
    /* 6F5F0 8007EDF0 21104300 */  addu       $v0, $v0, $v1
    /* 6F5F4 8007EDF4 2130CC00 */  addu       $a2, $a2, $t4
    /* 6F5F8 8007EDF8 C0300600 */  sll        $a2, $a2, 3
    /* 6F5FC 8007EDFC 6C00488C */  lw         $t0, 0x6C($v0)
    /* 6F600 8007EE00 2138EC00 */  addu       $a3, $a3, $t4
    /* 6F604 8007EE04 04000825 */  addiu      $t0, $t0, 0x4
    /* 6F608 8007EE08 2130C800 */  addu       $a2, $a2, $t0
    /* 6F60C 8007EE0C 0800C284 */  lh         $v0, 0x8($a2)
    /* 6F610 8007EE10 0800C324 */  addiu      $v1, $a2, 0x8
    /* 6F614 8007EE14 80120200 */  sll        $v0, $v0, 10
    /* 6F618 8007EE18 21706201 */  addu       $t6, $t3, $v0
    /* 6F61C 8007EE1C 02006284 */  lh         $v0, 0x2($v1)
    /* 6F620 8007EE20 C0380700 */  sll        $a3, $a3, 3
    /* 6F624 8007EE24 80120200 */  sll        $v0, $v0, 10
    /* 6F628 8007EE28 21684201 */  addu       $t5, $t2, $v0
    /* 6F62C 8007EE2C 04006284 */  lh         $v0, 0x4($v1)
    /* 6F630 8007EE30 2138E800 */  addu       $a3, $a3, $t0
    /* 6F634 8007EE34 0C00AEAC */  sw         $t6, 0xC($a1)
    /* 6F638 8007EE38 1000ADAC */  sw         $t5, 0x10($a1)
    /* 6F63C 8007EE3C 80120200 */  sll        $v0, $v0, 10
    /* 6F640 8007EE40 21102201 */  addu       $v0, $t1, $v0
    /* 6F644 8007EE44 1400A2AC */  sw         $v0, 0x14($a1)
    /* 6F648 8007EE48 0000C284 */  lh         $v0, 0x0($a2)
    /* 6F64C 8007EE4C 0200C384 */  lh         $v1, 0x2($a2)
    /* 6F650 8007EE50 80120200 */  sll        $v0, $v0, 10
    /* 6F654 8007EE54 21706201 */  addu       $t6, $t3, $v0
    /* 6F658 8007EE58 801A0300 */  sll        $v1, $v1, 10
    /* 6F65C 8007EE5C 0400C284 */  lh         $v0, 0x4($a2)
    /* 6F660 8007EE60 21684301 */  addu       $t5, $t2, $v1
    /* 6F664 8007EE64 1800AEAC */  sw         $t6, 0x18($a1)
    /* 6F668 8007EE68 1C00ADAC */  sw         $t5, 0x1C($a1)
    /* 6F66C 8007EE6C 80120200 */  sll        $v0, $v0, 10
    /* 6F670 8007EE70 21102201 */  addu       $v0, $t1, $v0
    /* 6F674 8007EE74 2000A2AC */  sw         $v0, 0x20($a1)
    /* 6F678 8007EE78 0000E284 */  lh         $v0, 0x0($a3)
    /* 6F67C 8007EE7C 0200E384 */  lh         $v1, 0x2($a3)
    /* 6F680 8007EE80 80120200 */  sll        $v0, $v0, 10
    /* 6F684 8007EE84 21706201 */  addu       $t6, $t3, $v0
    /* 6F688 8007EE88 801A0300 */  sll        $v1, $v1, 10
    /* 6F68C 8007EE8C 0400E284 */  lh         $v0, 0x4($a3)
    /* 6F690 8007EE90 21684301 */  addu       $t5, $t2, $v1
    /* 6F694 8007EE94 2400AEAC */  sw         $t6, 0x24($a1)
    /* 6F698 8007EE98 2800ADAC */  sw         $t5, 0x28($a1)
    /* 6F69C 8007EE9C 80120200 */  sll        $v0, $v0, 10
    /* 6F6A0 8007EEA0 21102201 */  addu       $v0, $t1, $v0
    /* 6F6A4 8007EEA4 2C00A2AC */  sw         $v0, 0x2C($a1)
    /* 6F6A8 8007EEA8 0800E284 */  lh         $v0, 0x8($a3)
    /* 6F6AC 8007EEAC 0800E724 */  addiu      $a3, $a3, 0x8
    /* 6F6B0 8007EEB0 0200E384 */  lh         $v1, 0x2($a3)
    /* 6F6B4 8007EEB4 80120200 */  sll        $v0, $v0, 10
    /* 6F6B8 8007EEB8 21706201 */  addu       $t6, $t3, $v0
    /* 6F6BC 8007EEBC 801A0300 */  sll        $v1, $v1, 10
    /* 6F6C0 8007EEC0 0400E284 */  lh         $v0, 0x4($a3)
    /* 6F6C4 8007EEC4 21684301 */  addu       $t5, $t2, $v1
    /* 6F6C8 8007EEC8 08008EAC */  sw         $t6, 0x8($a0)
    /* 6F6CC 8007EECC 0400ADAC */  sw         $t5, 0x4($a1)
    /* 6F6D0 8007EED0 80120200 */  sll        $v0, $v0, 10
    /* 6F6D4 8007EED4 21102201 */  addu       $v0, $t1, $v0
    /* 6F6D8 8007EED8 0800E003 */  jr         $ra
    /* 6F6DC 8007EEDC 0800A2AC */   sw        $v0, 0x8($a1)
endlabel GetStmQuadPts__FP12BWorldSm_PosP8coorddef
