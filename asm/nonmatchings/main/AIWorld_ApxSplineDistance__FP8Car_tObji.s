.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_ApxSplineDistance__FP8Car_tObji, 0x6C

glabel AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 63928 80073128 08008284 */  lh         $v0, 0x8($a0)
    /* 6392C 8007312C 1480043C */  lui        $a0, %hi(gNumSlices)
    /* 63930 80073130 C8C7848C */  lw         $a0, %lo(gNumSlices)($a0)
    /* 63934 80073134 23184500 */  subu       $v1, $v0, $a1
    /* 63938 80073138 C2170400 */  srl        $v0, $a0, 31
    /* 6393C 8007313C 21108200 */  addu       $v0, $a0, $v0
    /* 63940 80073140 06006018 */  blez       $v1, .L8007315C
    /* 63944 80073144 43280200 */   sra       $a1, $v0, 1
    /* 63948 80073148 2A10A300 */  slt        $v0, $a1, $v1
    /* 6394C 8007314C 03004010 */  beqz       $v0, .L8007315C
    /* 63950 80073150 00000000 */   nop
    /* 63954 80073154 61CC0108 */  j          .L80073184
    /* 63958 80073158 23186400 */   subu      $v1, $v1, $a0
  .L8007315C:
    /* 6395C 8007315C 0A006104 */  bgez       $v1, .L80073188
    /* 63960 80073160 40100300 */   sll       $v0, $v1, 1
    /* 63964 80073164 23100500 */  negu       $v0, $a1
    /* 63968 80073168 2A106200 */  slt        $v0, $v1, $v0
    /* 6396C 8007316C 05004010 */  beqz       $v0, .L80073184
    /* 63970 80073170 00000000 */   nop
    /* 63974 80073174 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 63978 80073178 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 6397C 8007317C 00000000 */  nop
    /* 63980 80073180 21186200 */  addu       $v1, $v1, $v0
  .L80073184:
    /* 63984 80073184 40100300 */  sll        $v0, $v1, 1
  .L80073188:
    /* 63988 80073188 21104300 */  addu       $v0, $v0, $v1
    /* 6398C 8007318C 0800E003 */  jr         $ra
    /* 63990 80073190 40140200 */   sll       $v0, $v0, 17
endlabel AIWorld_ApxSplineDistance__FP8Car_tObji
