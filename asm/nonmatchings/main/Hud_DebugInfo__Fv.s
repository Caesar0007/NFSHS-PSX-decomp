.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_DebugInfo__Fv, 0x194

glabel Hud_DebugInfo__Fv
    /* C25FC 800D1DFC B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C2600 800D1E00 2000A427 */  addiu      $a0, $sp, 0x20
    /* C2604 800D1E04 1480053C */  lui        $a1, %hi(D_8013D8C4)
    /* C2608 800D1E08 1180023C */  lui        $v0, %hi(Cars_gList)
    /* C260C 800D1E0C DCF9428C */  lw         $v0, %lo(Cars_gList)($v0)
    /* C2610 800D1E10 C4D8A524 */  addiu      $a1, $a1, %lo(D_8013D8C4)
    /* C2614 800D1E14 4000B2AF */  sw         $s2, 0x40($sp)
    /* C2618 800D1E18 0500123C */  lui        $s2, (0x50505 >> 16)
    /* C261C 800D1E1C 4400BFAF */  sw         $ra, 0x44($sp)
    /* C2620 800D1E20 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* C2624 800D1E24 3800B0AF */  sw         $s0, 0x38($sp)
    /* C2628 800D1E28 08004684 */  lh         $a2, 0x8($v0)
    /* C262C 800D1E2C 2F91030C */  jal        sprintf
    /* C2630 800D1E30 05055236 */   ori       $s2, $s2, (0x50505 & 0xFFFF)
    /* C2634 800D1E34 2000A427 */  addiu      $a0, $sp, 0x20
    /* C2638 800D1E38 E6000524 */  addiu      $a1, $zero, 0xE6
    /* C263C 800D1E3C A42E030C */  jal        Font_TextXY__FPcii
    /* C2640 800D1E40 2D000624 */   addiu     $a2, $zero, 0x2D
    /* C2644 800D1E44 888F030C */  jal        textpixels
    /* C2648 800D1E48 2000A427 */   addiu     $a0, $sp, 0x20
    /* C264C 800D1E4C 01000424 */  addiu      $a0, $zero, 0x1
    /* C2650 800D1E50 E6000524 */  addiu      $a1, $zero, 0xE6
    /* C2654 800D1E54 30000624 */  addiu      $a2, $zero, 0x30
    /* C2658 800D1E58 05004724 */  addiu      $a3, $v0, 0x5
    /* C265C 800D1E5C 0A001124 */  addiu      $s1, $zero, 0xA
    /* C2660 800D1E60 1000B1AF */  sw         $s1, 0x10($sp)
    /* C2664 800D1E64 1400B2AF */  sw         $s2, 0x14($sp)
    /* C2668 800D1E68 1800A0AF */  sw         $zero, 0x18($sp)
    /* C266C 800D1E6C 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C2670 800D1E70 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C2674 800D1E74 F7E7010C */  jal        AudioMus_Buffered__Fv
    /* C2678 800D1E78 00000000 */   nop
    /* C267C 800D1E7C D6E7010C */  jal        AudioMus_Threshold__Fv
    /* C2680 800D1E80 21804000 */   addu      $s0, $v0, $zero
    /* C2684 800D1E84 6210033C */  lui        $v1, (0x10624DD3 >> 16)
    /* C2688 800D1E88 D34D6334 */  ori        $v1, $v1, (0x10624DD3 & 0xFFFF)
    /* C268C 800D1E8C 18000302 */  mult       $s0, $v1
    /* C2690 800D1E90 10400000 */  mfhi       $t0
    /* C2694 800D1E94 00000000 */  nop
    /* C2698 800D1E98 00000000 */  nop
    /* C269C 800D1E9C 18004300 */  mult       $v0, $v1
    /* C26A0 800D1EA0 EB51043C */  lui        $a0, (0x51EB851F >> 16)
    /* C26A4 800D1EA4 1F858434 */  ori        $a0, $a0, (0x51EB851F & 0xFFFF)
    /* C26A8 800D1EA8 83310800 */  sra        $a2, $t0, 6
    /* C26AC 800D1EAC C31F1000 */  sra        $v1, $s0, 31
    /* C26B0 800D1EB0 2330C300 */  subu       $a2, $a2, $v1
    /* C26B4 800D1EB4 40190600 */  sll        $v1, $a2, 5
    /* C26B8 800D1EB8 23186600 */  subu       $v1, $v1, $a2
    /* C26BC 800D1EBC 80180300 */  sll        $v1, $v1, 2
    /* C26C0 800D1EC0 21186600 */  addu       $v1, $v1, $a2
    /* C26C4 800D1EC4 10280000 */  mfhi       $a1
    /* C26C8 800D1EC8 C0180300 */  sll        $v1, $v1, 3
    /* C26CC 800D1ECC 23800302 */  subu       $s0, $s0, $v1
    /* C26D0 800D1ED0 18000402 */  mult       $s0, $a0
    /* C26D4 800D1ED4 C31F0200 */  sra        $v1, $v0, 31
    /* C26D8 800D1ED8 83390500 */  sra        $a3, $a1, 6
    /* C26DC 800D1EDC 2338E300 */  subu       $a3, $a3, $v1
    /* C26E0 800D1EE0 40190700 */  sll        $v1, $a3, 5
    /* C26E4 800D1EE4 23186700 */  subu       $v1, $v1, $a3
    /* C26E8 800D1EE8 80180300 */  sll        $v1, $v1, 2
    /* C26EC 800D1EEC 21186700 */  addu       $v1, $v1, $a3
    /* C26F0 800D1EF0 10400000 */  mfhi       $t0
    /* C26F4 800D1EF4 C0180300 */  sll        $v1, $v1, 3
    /* C26F8 800D1EF8 23104300 */  subu       $v0, $v0, $v1
    /* C26FC 800D1EFC 18004400 */  mult       $v0, $a0
    /* C2700 800D1F00 0580053C */  lui        $a1, %hi(D_800568DC)
    /* C2704 800D1F04 DC68A524 */  addiu      $a1, $a1, %lo(D_800568DC)
    /* C2708 800D1F08 C3871000 */  sra        $s0, $s0, 31
    /* C270C 800D1F0C 1000A7AF */  sw         $a3, 0x10($sp)
    /* C2710 800D1F10 2000A427 */  addiu      $a0, $sp, 0x20
    /* C2714 800D1F14 43390800 */  sra        $a3, $t0, 5
    /* C2718 800D1F18 2338F000 */  subu       $a3, $a3, $s0
    /* C271C 800D1F1C C3170200 */  sra        $v0, $v0, 31
    /* C2720 800D1F20 10180000 */  mfhi       $v1
    /* C2724 800D1F24 43190300 */  sra        $v1, $v1, 5
    /* C2728 800D1F28 23186200 */  subu       $v1, $v1, $v0
    /* C272C 800D1F2C 2F91030C */  jal        sprintf
    /* C2730 800D1F30 1400A3AF */   sw        $v1, 0x14($sp)
    /* C2734 800D1F34 2000A427 */  addiu      $a0, $sp, 0x20
    /* C2738 800D1F38 E6000524 */  addiu      $a1, $zero, 0xE6
    /* C273C 800D1F3C A42E030C */  jal        Font_TextXY__FPcii
    /* C2740 800D1F40 23000624 */   addiu     $a2, $zero, 0x23
    /* C2744 800D1F44 888F030C */  jal        textpixels
    /* C2748 800D1F48 2000A427 */   addiu     $a0, $sp, 0x20
    /* C274C 800D1F4C 01000424 */  addiu      $a0, $zero, 0x1
    /* C2750 800D1F50 E6000524 */  addiu      $a1, $zero, 0xE6
    /* C2754 800D1F54 26000624 */  addiu      $a2, $zero, 0x26
    /* C2758 800D1F58 05004724 */  addiu      $a3, $v0, 0x5
    /* C275C 800D1F5C 1000B1AF */  sw         $s1, 0x10($sp)
    /* C2760 800D1F60 1400B2AF */  sw         $s2, 0x14($sp)
    /* C2764 800D1F64 1800A0AF */  sw         $zero, 0x18($sp)
    /* C2768 800D1F68 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C276C 800D1F6C 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C2770 800D1F70 A76B020C */  jal        CopSpeak_Debug__Fv
    /* C2774 800D1F74 00000000 */   nop
    /* C2778 800D1F78 4400BF8F */  lw         $ra, 0x44($sp)
    /* C277C 800D1F7C 4000B28F */  lw         $s2, 0x40($sp)
    /* C2780 800D1F80 3C00B18F */  lw         $s1, 0x3C($sp)
    /* C2784 800D1F84 3800B08F */  lw         $s0, 0x38($sp)
    /* C2788 800D1F88 0800E003 */  jr         $ra
    /* C278C 800D1F8C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hud_DebugInfo__Fv
