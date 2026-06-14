.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddPrim, 0x3C

glabel AddPrim
    /* F7840 80107040 FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* F7844 80107044 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* F7848 80107048 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* F784C 8010704C 0000A38C */  lw         $v1, 0x0($a1)
    /* F7850 80107050 0000828C */  lw         $v0, 0x0($a0)
    /* F7854 80107054 24186700 */  and        $v1, $v1, $a3
    /* F7858 80107058 24104600 */  and        $v0, $v0, $a2
    /* F785C 8010705C 25186200 */  or         $v1, $v1, $v0
    /* F7860 80107060 0000A3AC */  sw         $v1, 0x0($a1)
    /* F7864 80107064 0000828C */  lw         $v0, 0x0($a0)
    /* F7868 80107068 2428A600 */  and        $a1, $a1, $a2
    /* F786C 8010706C 24104700 */  and        $v0, $v0, $a3
    /* F7870 80107070 25104500 */  or         $v0, $v0, $a1
    /* F7874 80107074 0800E003 */  jr         $ra
    /* F7878 80107078 000082AC */   sw        $v0, 0x0($a0)
endlabel AddPrim
    /* F787C 8010707C 00000000 */  nop
