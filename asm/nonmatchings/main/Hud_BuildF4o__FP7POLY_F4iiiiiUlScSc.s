.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc, 0xD4

glabel Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc
    /* C2F94 800D2794 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* C2F98 800D2798 2400B5AF */  sw         $s5, 0x24($sp)
    /* C2F9C 800D279C 4800B58F */  lw         $s5, 0x48($sp)
    /* C2FA0 800D27A0 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* C2FA4 800D27A4 4C00B78F */  lw         $s7, 0x4C($sp)
    /* C2FA8 800D27A8 5000A28F */  lw         $v0, 0x50($sp)
    /* C2FAC 800D27AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2FB0 800D27B0 5400B08F */  lw         $s0, 0x54($sp)
    /* C2FB4 800D27B4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C2FB8 800D27B8 21988000 */  addu       $s3, $a0, $zero
    /* C2FBC 800D27BC 2800B6AF */  sw         $s6, 0x28($sp)
    /* C2FC0 800D27C0 21B0A000 */  addu       $s6, $a1, $zero
    /* C2FC4 800D27C4 2000B4AF */  sw         $s4, 0x20($sp)
    /* C2FC8 800D27C8 21A0C000 */  addu       $s4, $a2, $zero
    /* C2FCC 800D27CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* C2FD0 800D27D0 2190E000 */  addu       $s2, $a3, $zero
    /* C2FD4 800D27D4 1400B1AF */  sw         $s1, 0x14($sp)
    /* C2FD8 800D27D8 5800B18F */  lw         $s1, 0x58($sp)
    /* C2FDC 800D27DC 3000BFAF */  sw         $ra, 0x30($sp)
    /* C2FE0 800D27E0 84CD030C */  jal        SetPolyF4
    /* C2FE4 800D27E4 040062AE */   sw        $v0, 0x4($s3)
    /* C2FE8 800D27E8 21206002 */  addu       $a0, $s3, $zero
    /* C2FEC 800D27EC 3FCC030C */  jal        SetSemiTrans
    /* C2FF0 800D27F0 2128C002 */   addu      $a1, $s6, $zero
    /* C2FF4 800D27F4 00141200 */  sll        $v0, $s2, 16
    /* C2FF8 800D27F8 00861000 */  sll        $s0, $s0, 24
    /* C2FFC 800D27FC 03861000 */  sra        $s0, $s0, 24
    /* C3000 800D2800 21809002 */  addu       $s0, $s4, $s0
    /* C3004 800D2804 25805000 */  or         $s0, $v0, $s0
    /* C3008 800D2808 21A89502 */  addu       $s5, $s4, $s5
    /* C300C 800D280C 008E1100 */  sll        $s1, $s1, 24
    /* C3010 800D2810 038E1100 */  sra        $s1, $s1, 24
    /* C3014 800D2814 2188B102 */  addu       $s1, $s5, $s1
    /* C3018 800D2818 25105100 */  or         $v0, $v0, $s1
    /* C301C 800D281C 21905702 */  addu       $s2, $s2, $s7
    /* C3020 800D2820 00941200 */  sll        $s2, $s2, 16
    /* C3024 800D2824 25A05402 */  or         $s4, $s2, $s4
    /* C3028 800D2828 25905502 */  or         $s2, $s2, $s5
    /* C302C 800D282C 080070AE */  sw         $s0, 0x8($s3)
    /* C3030 800D2830 0C0062AE */  sw         $v0, 0xC($s3)
    /* C3034 800D2834 100074AE */  sw         $s4, 0x10($s3)
    /* C3038 800D2838 140072AE */  sw         $s2, 0x14($s3)
    /* C303C 800D283C 3000BF8F */  lw         $ra, 0x30($sp)
    /* C3040 800D2840 2C00B78F */  lw         $s7, 0x2C($sp)
    /* C3044 800D2844 2800B68F */  lw         $s6, 0x28($sp)
    /* C3048 800D2848 2400B58F */  lw         $s5, 0x24($sp)
    /* C304C 800D284C 2000B48F */  lw         $s4, 0x20($sp)
    /* C3050 800D2850 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C3054 800D2854 1800B28F */  lw         $s2, 0x18($sp)
    /* C3058 800D2858 1400B18F */  lw         $s1, 0x14($sp)
    /* C305C 800D285C 1000B08F */  lw         $s0, 0x10($sp)
    /* C3060 800D2860 0800E003 */  jr         $ra
    /* C3064 800D2864 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc
