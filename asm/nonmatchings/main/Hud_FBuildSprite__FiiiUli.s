.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_FBuildSprite__FiiiUli, 0x94

glabel Hud_FBuildSprite__FiiiUli
    /* C2870 800D2070 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C2874 800D2074 21588000 */  addu       $t3, $a0, $zero
    /* C2878 800D2078 2160A000 */  addu       $t4, $a1, $zero
    /* C287C 800D207C 2168C000 */  addu       $t5, $a2, $zero
    /* C2880 800D2080 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* C2884 800D2084 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* C2888 800D2088 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C288C 800D208C FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C2890 800D2090 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C2894 800D2094 1800BFAF */  sw         $ra, 0x18($sp)
    /* C2898 800D2098 0000448D */  lw         $a0, 0x0($t2)
    /* C289C 800D209C 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C28A0 800D20A0 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C28A4 800D20A4 0000838C */  lw         $v1, 0x0($a0)
    /* C28A8 800D20A8 0000C28C */  lw         $v0, 0x0($a2)
    /* C28AC 800D20AC 24186800 */  and        $v1, $v1, $t0
    /* C28B0 800D20B0 24104500 */  and        $v0, $v0, $a1
    /* C28B4 800D20B4 25186200 */  or         $v1, $v1, $v0
    /* C28B8 800D20B8 000083AC */  sw         $v1, 0x0($a0)
    /* C28BC 800D20BC 14008324 */  addiu      $v1, $a0, 0x14
    /* C28C0 800D20C0 3000A98F */  lw         $t1, 0x30($sp)
    /* C28C4 800D20C4 0000C28C */  lw         $v0, 0x0($a2)
    /* C28C8 800D20C8 24288500 */  and        $a1, $a0, $a1
    /* C28CC 800D20CC 000043AD */  sw         $v1, 0x0($t2)
    /* C28D0 800D20D0 24104800 */  and        $v0, $v0, $t0
    /* C28D4 800D20D4 25104500 */  or         $v0, $v0, $a1
    /* C28D8 800D20D8 21286001 */  addu       $a1, $t3, $zero
    /* C28DC 800D20DC 0000C2AC */  sw         $v0, 0x0($a2)
    /* C28E0 800D20E0 21308001 */  addu       $a2, $t4, $zero
    /* C28E4 800D20E4 1000A7AF */  sw         $a3, 0x10($sp)
    /* C28E8 800D20E8 2138A001 */  addu       $a3, $t5, $zero
    /* C28EC 800D20EC E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C28F0 800D20F0 1400A9AF */   sw        $t1, 0x14($sp)
    /* C28F4 800D20F4 1800BF8F */  lw         $ra, 0x18($sp)
    /* C28F8 800D20F8 00000000 */  nop
    /* C28FC 800D20FC 0800E003 */  jr         $ra
    /* C2900 800D2100 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_FBuildSprite__FiiiUli
