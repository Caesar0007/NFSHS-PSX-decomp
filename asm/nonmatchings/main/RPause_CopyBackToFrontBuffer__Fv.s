.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RPause_CopyBackToFrontBuffer__Fv, 0xC0

glabel RPause_CopyBackToFrontBuffer__Fv
    /* CD6C4 800DCEC4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CD6C8 800DCEC8 1480043C */  lui        $a0, %hi(Draw_gPlayer1View)
    /* CD6CC 800DCECC CCD3848C */  lw         $a0, %lo(Draw_gPlayer1View)($a0)
    /* CD6D0 800DCED0 1800BFAF */  sw         $ra, 0x18($sp)
    /* CD6D4 800DCED4 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* CD6D8 800DCED8 01000524 */   addiu     $a1, $zero, 0x1
    /* CD6DC 800DCEDC 03004888 */  lwl        $t0, 0x3($v0)
    /* CD6E0 800DCEE0 00004898 */  lwr        $t0, 0x0($v0)
    /* CD6E4 800DCEE4 07004988 */  lwl        $t1, 0x7($v0)
    /* CD6E8 800DCEE8 04004998 */  lwr        $t1, 0x4($v0)
    /* CD6EC 800DCEEC 1300A8AB */  swl        $t0, 0x13($sp)
    /* CD6F0 800DCEF0 1000A8BB */  swr        $t0, 0x10($sp)
    /* CD6F4 800DCEF4 1700A9AB */  swl        $t1, 0x17($sp)
    /* CD6F8 800DCEF8 1400A9BB */  swr        $t1, 0x14($sp)
    /* CD6FC 800DCEFC 1000A297 */  lhu        $v0, 0x10($sp)
    /* CD700 800DCF00 1480033C */  lui        $v1, %hi(gPauseMenuRect)
    /* CD704 800DCF04 D4D36394 */  lhu        $v1, %lo(gPauseMenuRect)($v1)
    /* CD708 800DCF08 1480043C */  lui        $a0, %hi(Draw_gPlayer1View)
    /* CD70C 800DCF0C CCD3848C */  lw         $a0, %lo(Draw_gPlayer1View)($a0)
    /* CD710 800DCF10 1480063C */  lui        $a2, %hi(D_8013D3D8)
    /* CD714 800DCF14 D8D3C694 */  lhu        $a2, %lo(D_8013D3D8)($a2)
    /* CD718 800DCF18 1480073C */  lui        $a3, %hi(D_8013D3DA)
    /* CD71C 800DCF1C DAD3E794 */  lhu        $a3, %lo(D_8013D3DA)($a3)
    /* CD720 800DCF20 21104300 */  addu       $v0, $v0, $v1
    /* CD724 800DCF24 1000A2A7 */  sh         $v0, 0x10($sp)
    /* CD728 800DCF28 1200A297 */  lhu        $v0, 0x12($sp)
    /* CD72C 800DCF2C 1480033C */  lui        $v1, %hi(D_8013D3D6)
    /* CD730 800DCF30 D6D36394 */  lhu        $v1, %lo(D_8013D3D6)($v1)
    /* CD734 800DCF34 21280000 */  addu       $a1, $zero, $zero
    /* CD738 800DCF38 1400A6A7 */  sh         $a2, 0x14($sp)
    /* CD73C 800DCF3C 1600A7A7 */  sh         $a3, 0x16($sp)
    /* CD740 800DCF40 21104300 */  addu       $v0, $v0, $v1
    /* CD744 800DCF44 67F7020C */  jal        Draw_GetDRAWENV__Fii
    /* CD748 800DCF48 1200A2A7 */   sh        $v0, 0x12($sp)
    /* CD74C 800DCF4C 1000A427 */  addiu      $a0, $sp, 0x10
    /* CD750 800DCF50 00004384 */  lh         $v1, 0x0($v0)
    /* CD754 800DCF54 1480053C */  lui        $a1, %hi(gPauseMenuRect)
    /* CD758 800DCF58 D4D3A584 */  lh         $a1, %lo(gPauseMenuRect)($a1)
    /* CD75C 800DCF5C 02004284 */  lh         $v0, 0x2($v0)
    /* CD760 800DCF60 1480063C */  lui        $a2, %hi(D_8013D3D6)
    /* CD764 800DCF64 D6D3C684 */  lh         $a2, %lo(D_8013D3D6)($a2)
    /* CD768 800DCF68 21286500 */  addu       $a1, $v1, $a1
    /* CD76C 800DCF6C D4B6030C */  jal        MoveImage
    /* CD770 800DCF70 21304600 */   addu      $a2, $v0, $a2
    /* CD774 800DCF74 1800BF8F */  lw         $ra, 0x18($sp)
    /* CD778 800DCF78 00000000 */  nop
    /* CD77C 800DCF7C 0800E003 */  jr         $ra
    /* CD780 800DCF80 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel RPause_CopyBackToFrontBuffer__Fv
