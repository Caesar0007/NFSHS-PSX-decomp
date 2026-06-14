.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildSprite__FP4SPRTiiiUli, 0xAC

glabel Hud_BuildSprite__FP4SPRTiiiUli
    /* C2798 800D1F98 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C279C 800D1F9C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C27A0 800D1FA0 21988000 */  addu       $s3, $a0, $zero
    /* C27A4 800D1FA4 2000B4AF */  sw         $s4, 0x20($sp)
    /* C27A8 800D1FA8 21A0C000 */  addu       $s4, $a2, $zero
    /* C27AC 800D1FAC 1800B2AF */  sw         $s2, 0x18($sp)
    /* C27B0 800D1FB0 2190E000 */  addu       $s2, $a3, $zero
    /* C27B4 800D1FB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* C27B8 800D1FB8 80800500 */  sll        $s0, $a1, 2
    /* C27BC 800D1FBC 21800502 */  addu       $s0, $s0, $a1
    /* C27C0 800D1FC0 80801000 */  sll        $s0, $s0, 2
    /* C27C4 800D1FC4 1180023C */  lui        $v0, %hi(HudPmx_gShapes)
    /* C27C8 800D1FC8 980C4224 */  addiu      $v0, $v0, %lo(HudPmx_gShapes)
    /* C27CC 800D1FCC 3C00A58F */  lw         $a1, 0x3C($sp)
    /* C27D0 800D1FD0 1400B1AF */  sw         $s1, 0x14($sp)
    /* C27D4 800D1FD4 3800B18F */  lw         $s1, 0x38($sp)
    /* C27D8 800D1FD8 2400BFAF */  sw         $ra, 0x24($sp)
    /* C27DC 800D1FDC 3FCC030C */  jal        SetSemiTrans
    /* C27E0 800D1FE0 21800202 */   addu      $s0, $s0, $v0
    /* C27E4 800D1FE4 04000224 */  addiu      $v0, $zero, 0x4
    /* C27E8 800D1FE8 030062A2 */  sb         $v0, 0x3($s3)
    /* C27EC 800D1FEC 0066023C */  lui        $v0, (0x66000000 >> 16)
    /* C27F0 800D1FF0 25882202 */  or         $s1, $s1, $v0
    /* C27F4 800D1FF4 00941200 */  sll        $s2, $s2, 16
    /* C27F8 800D1FF8 25905402 */  or         $s2, $s2, $s4
    /* C27FC 800D1FFC 040071AE */  sw         $s1, 0x4($s3)
    /* C2800 800D2000 080072AE */  sw         $s2, 0x8($s3)
    /* C2804 800D2004 0000028E */  lw         $v0, 0x0($s0)
    /* C2808 800D2008 00000000 */  nop
    /* C280C 800D200C 0C0062AE */  sw         $v0, 0xC($s3)
    /* C2810 800D2010 12000286 */  lh         $v0, 0x12($s0)
    /* C2814 800D2014 10000386 */  lh         $v1, 0x10($s0)
    /* C2818 800D2018 00140200 */  sll        $v0, $v0, 16
    /* C281C 800D201C 25104300 */  or         $v0, $v0, $v1
    /* C2820 800D2020 100062AE */  sw         $v0, 0x10($s3)
    /* C2824 800D2024 2400BF8F */  lw         $ra, 0x24($sp)
    /* C2828 800D2028 2000B48F */  lw         $s4, 0x20($sp)
    /* C282C 800D202C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2830 800D2030 1800B28F */  lw         $s2, 0x18($sp)
    /* C2834 800D2034 1400B18F */  lw         $s1, 0x14($sp)
    /* C2838 800D2038 1000B08F */  lw         $s0, 0x10($sp)
    /* C283C 800D203C 0800E003 */  jr         $ra
    /* C2840 800D2040 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_BuildSprite__FP4SPRTiiiUli
