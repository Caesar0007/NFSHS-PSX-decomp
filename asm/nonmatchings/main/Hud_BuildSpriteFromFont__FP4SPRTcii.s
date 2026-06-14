.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildSpriteFromFont__FP4SPRTcii, 0xC0

glabel Hud_BuildSpriteFromFont__FP4SPRTcii
    /* C2904 800D2104 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* C2908 800D2108 3400B1AF */  sw         $s1, 0x34($sp)
    /* C290C 800D210C 21888000 */  addu       $s1, $a0, $zero
    /* C2910 800D2110 2400A227 */  addiu      $v0, $sp, 0x24
    /* C2914 800D2114 1000A2AF */  sw         $v0, 0x10($sp)
    /* C2918 800D2118 2800A227 */  addiu      $v0, $sp, 0x28
    /* C291C 800D211C 3800B2AF */  sw         $s2, 0x38($sp)
    /* C2920 800D2120 2190C000 */  addu       $s2, $a2, $zero
    /* C2924 800D2124 3000B0AF */  sw         $s0, 0x30($sp)
    /* C2928 800D2128 2180E000 */  addu       $s0, $a3, $zero
    /* C292C 800D212C FF00A430 */  andi       $a0, $a1, 0xFF
    /* C2930 800D2130 1800A527 */  addiu      $a1, $sp, 0x18
    /* C2934 800D2134 1C00A627 */  addiu      $a2, $sp, 0x1C
    /* C2938 800D2138 2000A727 */  addiu      $a3, $sp, 0x20
    /* C293C 800D213C 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* C2940 800D2140 FA2E030C */  jal        Font_GetUVWH__FcPiN41
    /* C2944 800D2144 1400A2AF */   sw        $v0, 0x14($sp)
    /* C2948 800D2148 04000224 */  addiu      $v0, $zero, 0x4
    /* C294C 800D214C 030022A2 */  sb         $v0, 0x3($s1)
    /* C2950 800D2150 C818828F */  lw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C2954 800D2154 0066033C */  lui        $v1, (0x66000000 >> 16)
    /* C2958 800D2158 25104300 */  or         $v0, $v0, $v1
    /* C295C 800D215C 040022AE */  sw         $v0, 0x4($s1)
    /* C2960 800D2160 2800A28F */  lw         $v0, 0x28($sp)
    /* C2964 800D2164 00000000 */  nop
    /* C2968 800D2168 21800202 */  addu       $s0, $s0, $v0
    /* C296C 800D216C 00841000 */  sll        $s0, $s0, 16
    /* C2970 800D2170 25801202 */  or         $s0, $s0, $s2
    /* C2974 800D2174 080030AE */  sw         $s0, 0x8($s1)
    /* C2978 800D2178 1800A293 */  lbu        $v0, 0x18($sp)
    /* C297C 800D217C 00000000 */  nop
    /* C2980 800D2180 0C0022A2 */  sb         $v0, 0xC($s1)
    /* C2984 800D2184 1C00A293 */  lbu        $v0, 0x1C($sp)
    /* C2988 800D2188 00000000 */  nop
    /* C298C 800D218C 0D0022A2 */  sb         $v0, 0xD($s1)
    /* C2990 800D2190 1480023C */  lui        $v0, %hi(gFontClut)
    /* C2994 800D2194 64D84294 */  lhu        $v0, %lo(gFontClut)($v0)
    /* C2998 800D2198 2000A397 */  lhu        $v1, 0x20($sp)
    /* C299C 800D219C 2400A497 */  lhu        $a0, 0x24($sp)
    /* C29A0 800D21A0 0E0022A6 */  sh         $v0, 0xE($s1)
    /* C29A4 800D21A4 100023A6 */  sh         $v1, 0x10($s1)
    /* C29A8 800D21A8 120024A6 */  sh         $a0, 0x12($s1)
    /* C29AC 800D21AC 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* C29B0 800D21B0 3800B28F */  lw         $s2, 0x38($sp)
    /* C29B4 800D21B4 3400B18F */  lw         $s1, 0x34($sp)
    /* C29B8 800D21B8 3000B08F */  lw         $s0, 0x30($sp)
    /* C29BC 800D21BC 0800E003 */  jr         $ra
    /* C29C0 800D21C0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Hud_BuildSpriteFromFont__FP4SPRTcii
