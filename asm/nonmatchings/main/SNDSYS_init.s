.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSYS_init, 0x13C

glabel SNDSYS_init
    /* E2710 800F1F10 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E2714 800F1F14 1480023C */  lui        $v0, %hi(sndgs)
    /* E2718 800F1F18 1400B1AF */  sw         $s1, 0x14($sp)
    /* E271C 800F1F1C 60785124 */  addiu      $s1, $v0, %lo(sndgs)
    /* E2720 800F1F20 1800BFAF */  sw         $ra, 0x18($sp)
    /* E2724 800F1F24 1000B0AF */  sw         $s0, 0x10($sp)
    /* E2728 800F1F28 3C002282 */  lb         $v0, 0x3C($s1)
    /* E272C 800F1F2C 00000000 */  nop
    /* E2730 800F1F30 41004014 */  bnez       $v0, .L800F2038
    /* E2734 800F1F34 21100000 */   addu      $v0, $zero, $zero
    /* E2738 800F1F38 7518040C */  jal        iSNDmeminit
    /* E273C 800F1F3C 00000000 */   nop
    /* E2740 800F1F40 11002292 */  lbu        $v0, 0x11($s1)
    /* E2744 800F1F44 00000000 */  nop
    /* E2748 800F1F48 06004014 */  bnez       $v0, .L800F1F64
    /* E274C 800F1F4C 00000000 */   nop
    /* E2750 800F1F50 56C7030C */  jal        SNDSYS_getopts
    /* E2754 800F1F54 21202002 */   addu      $a0, $s1, $zero
    /* E2758 800F1F58 85C7030C */  jal        SNDSYS_setopts
    /* E275C 800F1F5C 21202002 */   addu      $a0, $s1, $zero
    /* E2760 800F1F60 11002292 */  lbu        $v0, 0x11($s1)
  .L800F1F64:
    /* E2764 800F1F64 00000000 */  nop
    /* E2768 800F1F68 40200200 */  sll        $a0, $v0, 1
    /* E276C 800F1F6C 21208200 */  addu       $a0, $a0, $v0
    /* E2770 800F1F70 C0200400 */  sll        $a0, $a0, 3
    /* E2774 800F1F74 21208200 */  addu       $a0, $a0, $v0
    /* E2778 800F1F78 8E18040C */  jal        iSNDmalloc
    /* E277C 800F1F7C 80200400 */   sll       $a0, $a0, 2
    /* E2780 800F1F80 21204000 */  addu       $a0, $v0, $zero
    /* E2784 800F1F84 11002292 */  lbu        $v0, 0x11($s1)
    /* E2788 800F1F88 21280000 */  addu       $a1, $zero, $zero
    /* E278C 800F1F8C 940024AE */  sw         $a0, 0x94($s1)
    /* E2790 800F1F90 40300200 */  sll        $a2, $v0, 1
    /* E2794 800F1F94 2130C200 */  addu       $a2, $a2, $v0
    /* E2798 800F1F98 C0300600 */  sll        $a2, $a2, 3
    /* E279C 800F1F9C 2130C200 */  addu       $a2, $a2, $v0
    /* E27A0 800F1FA0 C690030C */  jal        memset
    /* E27A4 800F1FA4 80300600 */   sll       $a2, $a2, 2
    /* E27A8 800F1FA8 0C002296 */  lhu        $v0, 0xC($s1)
    /* E27AC 800F1FAC 00000000 */  nop
    /* E27B0 800F1FB0 40200200 */  sll        $a0, $v0, 1
    /* E27B4 800F1FB4 21208200 */  addu       $a0, $a0, $v0
    /* E27B8 800F1FB8 8E18040C */  jal        iSNDmalloc
    /* E27BC 800F1FBC 80200400 */   sll       $a0, $a0, 2
    /* E27C0 800F1FC0 21204000 */  addu       $a0, $v0, $zero
    /* E27C4 800F1FC4 0C002296 */  lhu        $v0, 0xC($s1)
    /* E27C8 800F1FC8 21280000 */  addu       $a1, $zero, $zero
    /* E27CC 800F1FCC 980024AE */  sw         $a0, 0x98($s1)
    /* E27D0 800F1FD0 40300200 */  sll        $a2, $v0, 1
    /* E27D4 800F1FD4 2130C200 */  addu       $a2, $a2, $v0
    /* E27D8 800F1FD8 C690030C */  jal        memset
    /* E27DC 800F1FDC 80300600 */   sll       $a2, $a2, 2
    /* E27E0 800F1FE0 4800228E */  lw         $v0, 0x48($s1)
    /* E27E4 800F1FE4 00000000 */  nop
    /* E27E8 800F1FE8 03004014 */  bnez       $v0, .L800F1FF8
    /* E27EC 800F1FEC 0F80023C */   lui       $v0, %hi(iSND100hzserver)
    /* E27F0 800F1FF0 54A24224 */  addiu      $v0, $v0, %lo(iSND100hzserver)
    /* E27F4 800F1FF4 480022AE */  sw         $v0, 0x48($s1)
  .L800F1FF8:
    /* E27F8 800F1FF8 7B00040C */  jal        SNDI_mutexalloc
    /* E27FC 800F1FFC 00000000 */   nop
    /* E2800 800F2000 7F000224 */  addiu      $v0, $zero, 0x7F
    /* E2804 800F2004 440020AE */  sw         $zero, 0x44($s1)
    /* E2808 800F2008 AC0020AE */  sw         $zero, 0xAC($s1)
    /* E280C 800F200C C0FD030C */  jal        iSNDinit
    /* E2810 800F2010 3D0022A2 */   sb        $v0, 0x3D($s1)
    /* E2814 800F2014 21804000 */  addu       $s0, $v0, $zero
    /* E2818 800F2018 04000006 */  bltz       $s0, .L800F202C
    /* E281C 800F201C 01000224 */   addiu     $v0, $zero, 0x1
    /* E2820 800F2020 3C0022A2 */  sb         $v0, 0x3C($s1)
    /* E2824 800F2024 0EC80308 */  j          .L800F2038
    /* E2828 800F2028 21100000 */   addu      $v0, $zero, $zero
  .L800F202C:
    /* E282C 800F202C 68FE030C */  jal        iSNDrestore
    /* E2830 800F2030 00000000 */   nop
    /* E2834 800F2034 21100002 */  addu       $v0, $s0, $zero
  .L800F2038:
    /* E2838 800F2038 1800BF8F */  lw         $ra, 0x18($sp)
    /* E283C 800F203C 1400B18F */  lw         $s1, 0x14($sp)
    /* E2840 800F2040 1000B08F */  lw         $s0, 0x10($sp)
    /* E2844 800F2044 0800E003 */  jr         $ra
    /* E2848 800F2048 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSYS_init
