.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_SetSimSlice__FP12BWorldSm_Pos, 0x60

glabel BWorld_SetSimSlice__FP12BWorldSm_Pos
    /* 6F834 8007F034 00008284 */  lh         $v0, 0x0($a0)
    /* 6F838 8007F038 7402838F */  lw         $v1, %gp_rel(BWorldSm_slices)($gp)
    /* 6F83C 8007F03C 40110200 */  sll        $v0, $v0, 5
    /* 6F840 8007F040 21104300 */  addu       $v0, $v0, $v1
    /* 6F844 8007F044 1C004290 */  lbu        $v0, 0x1C($v0)
    /* 6F848 8007F048 00000000 */  nop
    /* 6F84C 8007F04C 750082A0 */  sb         $v0, 0x75($a0)
    /* 6F850 8007F050 FF004330 */  andi       $v1, $v0, 0xFF
    /* 6F854 8007F054 C0100300 */  sll        $v0, $v1, 3
    /* 6F858 8007F058 23104300 */  subu       $v0, $v0, $v1
    /* 6F85C 8007F05C 1480033C */  lui        $v1, %hi(Track_chunkList)
    /* 6F860 8007F060 B8D4638C */  lw         $v1, %lo(Track_chunkList)($v1)
    /* 6F864 8007F064 00110200 */  sll        $v0, $v0, 4
    /* 6F868 8007F068 21104300 */  addu       $v0, $v0, $v1
    /* 6F86C 8007F06C 4800458C */  lw         $a1, 0x48($v0)
    /* 6F870 8007F070 00008384 */  lh         $v1, 0x0($a0)
    /* 6F874 8007F074 68004284 */  lh         $v0, 0x68($v0)
    /* 6F878 8007F078 0400A524 */  addiu      $a1, $a1, 0x4
    /* 6F87C 8007F07C 23186200 */  subu       $v1, $v1, $v0
    /* 6F880 8007F080 80100300 */  sll        $v0, $v1, 2
    /* 6F884 8007F084 21104300 */  addu       $v0, $v0, $v1
    /* 6F888 8007F088 2128A200 */  addu       $a1, $a1, $v0
    /* 6F88C 8007F08C 0800E003 */  jr         $ra
    /* 6F890 8007F090 800085AC */   sw        $a1, 0x80($a0)
endlabel BWorld_SetSimSlice__FP12BWorldSm_Pos
