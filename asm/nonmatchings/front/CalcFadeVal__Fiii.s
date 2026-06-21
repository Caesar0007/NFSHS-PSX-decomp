.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcFadeVal__Fiii, 0x90

glabel CalcFadeVal__Fiii
    /* 3BFF8 8004B7F8 80000324 */  addiu      $v1, $zero, 0x80
    /* 3BFFC 8004B7FC 23186600 */  subu       $v1, $v1, $a2
    /* 3C000 8004B800 FF008230 */  andi       $v0, $a0, 0xFF
    /* 3C004 8004B804 18006200 */  mult       $v1, $v0
    /* 3C008 8004B808 12500000 */  mflo       $t2
    /* 3C00C 8004B80C FF00A230 */  andi       $v0, $a1, 0xFF
    /* 3C010 8004B810 00000000 */  nop
    /* 3C014 8004B814 1800C200 */  mult       $a2, $v0
    /* 3C018 8004B818 12480000 */  mflo       $t1
    /* 3C01C 8004B81C 03120400 */  sra        $v0, $a0, 8
    /* 3C020 8004B820 FF004230 */  andi       $v0, $v0, 0xFF
    /* 3C024 8004B824 18006200 */  mult       $v1, $v0
    /* 3C028 8004B828 12400000 */  mflo       $t0
    /* 3C02C 8004B82C 03120500 */  sra        $v0, $a1, 8
    /* 3C030 8004B830 FF004230 */  andi       $v0, $v0, 0xFF
    /* 3C034 8004B834 1800C200 */  mult       $a2, $v0
    /* 3C038 8004B838 12380000 */  mflo       $a3
    /* 3C03C 8004B83C 03240400 */  sra        $a0, $a0, 16
    /* 3C040 8004B840 FF008430 */  andi       $a0, $a0, 0xFF
    /* 3C044 8004B844 18006400 */  mult       $v1, $a0
    /* 3C048 8004B848 12100000 */  mflo       $v0
    /* 3C04C 8004B84C 032C0500 */  sra        $a1, $a1, 16
    /* 3C050 8004B850 FF00A530 */  andi       $a1, $a1, 0xFF
    /* 3C054 8004B854 1800C500 */  mult       $a2, $a1
    /* 3C058 8004B858 21204901 */  addu       $a0, $t2, $t1
    /* 3C05C 8004B85C C3210400 */  sra        $a0, $a0, 7
    /* 3C060 8004B860 21180701 */  addu       $v1, $t0, $a3
    /* 3C064 8004B864 C3190300 */  sra        $v1, $v1, 7
    /* 3C068 8004B868 001A0300 */  sll        $v1, $v1, 8
    /* 3C06C 8004B86C 12600000 */  mflo       $t4
    /* 3C070 8004B870 21104C00 */  addu       $v0, $v0, $t4
    /* 3C074 8004B874 C3110200 */  sra        $v0, $v0, 7
    /* 3C078 8004B878 00140200 */  sll        $v0, $v0, 16
    /* 3C07C 8004B87C 25104300 */  or         $v0, $v0, $v1
    /* 3C080 8004B880 0800E003 */  jr         $ra
    /* 3C084 8004B884 25104400 */   or        $v0, $v0, $a0
endlabel CalcFadeVal__Fiii
