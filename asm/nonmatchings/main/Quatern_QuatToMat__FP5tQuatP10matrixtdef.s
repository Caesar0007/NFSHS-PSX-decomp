.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Quatern_QuatToMat__FP5tQuatP10matrixtdef, 0x110

glabel Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* 9DF80 800AD780 00008684 */  lh         $a2, 0x0($a0)
    /* 9DF84 800AD784 06008A84 */  lh         $t2, 0x6($a0)
    /* 9DF88 800AD788 40100600 */  sll        $v0, $a2, 1
    /* 9DF8C 800AD78C 18004201 */  mult       $t2, $v0
    /* 9DF90 800AD790 02008784 */  lh         $a3, 0x2($a0)
    /* 9DF94 800AD794 12680000 */  mflo       $t5
    /* 9DF98 800AD798 40580700 */  sll        $t3, $a3, 1
    /* 9DF9C 800AD79C 00000000 */  nop
    /* 9DFA0 800AD7A0 18004B01 */  mult       $t2, $t3
    /* 9DFA4 800AD7A4 04008384 */  lh         $v1, 0x4($a0)
    /* 9DFA8 800AD7A8 12600000 */  mflo       $t4
    /* 9DFAC 800AD7AC 40480300 */  sll        $t1, $v1, 1
    /* 9DFB0 800AD7B0 00000000 */  nop
    /* 9DFB4 800AD7B4 18004901 */  mult       $t2, $t1
    /* 9DFB8 800AD7B8 12500000 */  mflo       $t2
    /* 9DFBC 800AD7BC 00000000 */  nop
    /* 9DFC0 800AD7C0 00000000 */  nop
    /* 9DFC4 800AD7C4 1800C200 */  mult       $a2, $v0
    /* 9DFC8 800AD7C8 12780000 */  mflo       $t7
    /* 9DFCC 800AD7CC 00000000 */  nop
    /* 9DFD0 800AD7D0 00000000 */  nop
    /* 9DFD4 800AD7D4 1800CB00 */  mult       $a2, $t3
    /* 9DFD8 800AD7D8 12400000 */  mflo       $t0
    /* 9DFDC 800AD7DC 00000000 */  nop
    /* 9DFE0 800AD7E0 00000000 */  nop
    /* 9DFE4 800AD7E4 1800EB00 */  mult       $a3, $t3
    /* 9DFE8 800AD7E8 12580000 */  mflo       $t3
    /* 9DFEC 800AD7EC 00000000 */  nop
    /* 9DFF0 800AD7F0 00000000 */  nop
    /* 9DFF4 800AD7F4 18006900 */  mult       $v1, $t1
    /* 9DFF8 800AD7F8 12180000 */  mflo       $v1
    /* 9DFFC 800AD7FC 00000000 */  nop
    /* 9E000 800AD800 00000000 */  nop
    /* 9E004 800AD804 1800C900 */  mult       $a2, $t1
    /* 9E008 800AD808 0010043C */  lui        $a0, (0x10000000 >> 16)
    /* 9E00C 800AD80C 23108B00 */  subu       $v0, $a0, $t3
    /* 9E010 800AD810 23208F00 */  subu       $a0, $a0, $t7
    /* 9E014 800AD814 23104300 */  subu       $v0, $v0, $v1
    /* 9E018 800AD818 03130200 */  sra        $v0, $v0, 12
    /* 9E01C 800AD81C 0000A2AC */  sw         $v0, 0x0($a1)
    /* 9E020 800AD820 21100A01 */  addu       $v0, $t0, $t2
    /* 9E024 800AD824 03130200 */  sra        $v0, $v0, 12
    /* 9E028 800AD828 23400A01 */  subu       $t0, $t0, $t2
    /* 9E02C 800AD82C 03430800 */  sra        $t0, $t0, 12
    /* 9E030 800AD830 23188300 */  subu       $v1, $a0, $v1
    /* 9E034 800AD834 12300000 */  mflo       $a2
    /* 9E038 800AD838 031B0300 */  sra        $v1, $v1, 12
    /* 9E03C 800AD83C 23208B00 */  subu       $a0, $a0, $t3
    /* 9E040 800AD840 1800E900 */  mult       $a3, $t1
    /* 9E044 800AD844 03230400 */  sra        $a0, $a0, 12
    /* 9E048 800AD848 0400A2AC */  sw         $v0, 0x4($a1)
    /* 9E04C 800AD84C 0C00A8AC */  sw         $t0, 0xC($a1)
    /* 9E050 800AD850 1000A3AC */  sw         $v1, 0x10($a1)
    /* 9E054 800AD854 2000A4AC */  sw         $a0, 0x20($a1)
    /* 9E058 800AD858 2310CC00 */  subu       $v0, $a2, $t4
    /* 9E05C 800AD85C 03130200 */  sra        $v0, $v0, 12
    /* 9E060 800AD860 2130CC00 */  addu       $a2, $a2, $t4
    /* 9E064 800AD864 03330600 */  sra        $a2, $a2, 12
    /* 9E068 800AD868 0800A2AC */  sw         $v0, 0x8($a1)
    /* 9E06C 800AD86C 1800A6AC */  sw         $a2, 0x18($a1)
    /* 9E070 800AD870 12380000 */  mflo       $a3
    /* 9E074 800AD874 2110ED00 */  addu       $v0, $a3, $t5
    /* 9E078 800AD878 03130200 */  sra        $v0, $v0, 12
    /* 9E07C 800AD87C 2338ED00 */  subu       $a3, $a3, $t5
    /* 9E080 800AD880 033B0700 */  sra        $a3, $a3, 12
    /* 9E084 800AD884 1400A2AC */  sw         $v0, 0x14($a1)
    /* 9E088 800AD888 0800E003 */  jr         $ra
    /* 9E08C 800AD88C 1C00A7AC */   sw        $a3, 0x1C($a1)
endlabel Quatern_QuatToMat__FP5tQuatP10matrixtdef
