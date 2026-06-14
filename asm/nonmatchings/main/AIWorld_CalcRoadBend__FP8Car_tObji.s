.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CalcRoadBend__FP8Car_tObji, 0xDC

glabel AIWorld_CalcRoadBend__FP8Car_tObji
    /* 63EE0 800736E0 08008684 */  lh         $a2, 0x8($a0)
    /* 63EE4 800736E4 0900A004 */  bltz       $a1, .L8007370C
    /* 63EE8 800736E8 00000000 */   nop
    /* 63EEC 800736EC 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 63EF0 800736F0 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 63EF4 800736F4 2128C500 */  addu       $a1, $a2, $a1
    /* 63EF8 800736F8 2A10A300 */  slt        $v0, $a1, $v1
    /* 63EFC 800736FC 0A004014 */  bnez       $v0, .L80073728
    /* 63F00 80073700 00000000 */   nop
    /* 63F04 80073704 CACD0108 */  j          .L80073728
    /* 63F08 80073708 2328A300 */   subu      $a1, $a1, $v1
  .L8007370C:
    /* 63F0C 8007370C 2128C500 */  addu       $a1, $a2, $a1
    /* 63F10 80073710 0500A104 */  bgez       $a1, .L80073728
    /* 63F14 80073714 00000000 */   nop
    /* 63F18 80073718 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 63F1C 8007371C C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 63F20 80073720 00000000 */  nop
    /* 63F24 80073724 2128A200 */  addu       $a1, $a1, $v0
  .L80073728:
    /* 63F28 80073728 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 63F2C 8007372C C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 63F30 80073730 40110500 */  sll        $v0, $a1, 5
    /* 63F34 80073734 21384300 */  addu       $a3, $v0, $v1
    /* 63F38 80073738 0F00E280 */  lb         $v0, 0xF($a3)
    /* 63F3C 8007373C 00000000 */  nop
    /* 63F40 80073740 40220200 */  sll        $a0, $v0, 9
    /* 63F44 80073744 02008104 */  bgez       $a0, .L80073750
    /* 63F48 80073748 40110600 */   sll       $v0, $a2, 5
    /* 63F4C 8007374C FF008424 */  addiu      $a0, $a0, 0xFF
  .L80073750:
    /* 63F50 80073750 21304300 */  addu       $a2, $v0, $v1
    /* 63F54 80073754 1200C280 */  lb         $v0, 0x12($a2)
    /* 63F58 80073758 00000000 */  nop
    /* 63F5C 8007375C 401A0200 */  sll        $v1, $v0, 9
    /* 63F60 80073760 02006104 */  bgez       $v1, .L8007376C
    /* 63F64 80073764 032A0400 */   sra       $a1, $a0, 8
    /* 63F68 80073768 FF006324 */  addiu      $v1, $v1, 0xFF
  .L8007376C:
    /* 63F6C 8007376C 1100E280 */  lb         $v0, 0x11($a3)
    /* 63F70 80073770 00000000 */  nop
    /* 63F74 80073774 40220200 */  sll        $a0, $v0, 9
    /* 63F78 80073778 03120300 */  sra        $v0, $v1, 8
    /* 63F7C 8007377C 1800A200 */  mult       $a1, $v0
    /* 63F80 80073780 12280000 */  mflo       $a1
    /* 63F84 80073784 02008104 */  bgez       $a0, .L80073790
    /* 63F88 80073788 00000000 */   nop
    /* 63F8C 8007378C FF008424 */  addiu      $a0, $a0, 0xFF
  .L80073790:
    /* 63F90 80073790 1400C280 */  lb         $v0, 0x14($a2)
    /* 63F94 80073794 00000000 */  nop
    /* 63F98 80073798 40120200 */  sll        $v0, $v0, 9
    /* 63F9C 8007379C 02004104 */  bgez       $v0, .L800737A8
    /* 63FA0 800737A0 031A0400 */   sra       $v1, $a0, 8
    /* 63FA4 800737A4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800737A8:
    /* 63FA8 800737A8 03120200 */  sra        $v0, $v0, 8
    /* 63FAC 800737AC 18006200 */  mult       $v1, $v0
    /* 63FB0 800737B0 12400000 */  mflo       $t0
    /* 63FB4 800737B4 0800E003 */  jr         $ra
    /* 63FB8 800737B8 2110A800 */   addu      $v0, $a1, $t0
endlabel AIWorld_CalcRoadBend__FP8Car_tObji
