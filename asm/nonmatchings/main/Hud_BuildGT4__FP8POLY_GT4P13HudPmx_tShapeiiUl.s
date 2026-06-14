.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl, 0xAC

glabel Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C2A88 800D2288 0C000224 */  addiu      $v0, $zero, 0xC
    /* C2A8C 800D228C 1000A38F */  lw         $v1, 0x10($sp)
    /* C2A90 800D2290 00440700 */  sll        $t0, $a3, 16
    /* C2A94 800D2294 030082A0 */  sb         $v0, 0x3($a0)
    /* C2A98 800D2298 25100601 */  or         $v0, $t0, $a2
    /* C2A9C 800D229C 080082AC */  sw         $v0, 0x8($a0)
    /* C2AA0 800D22A0 003E023C */  lui        $v0, (0x3E000000 >> 16)
    /* C2AA4 800D22A4 25106200 */  or         $v0, $v1, $v0
    /* C2AA8 800D22A8 040082AC */  sw         $v0, 0x4($a0)
    /* C2AAC 800D22AC 100083AC */  sw         $v1, 0x10($a0)
    /* C2AB0 800D22B0 1C0083AC */  sw         $v1, 0x1C($a0)
    /* C2AB4 800D22B4 280083AC */  sw         $v1, 0x28($a0)
    /* C2AB8 800D22B8 0000A28C */  lw         $v0, 0x0($a1)
    /* C2ABC 800D22BC 00000000 */  nop
    /* C2AC0 800D22C0 0C0082AC */  sw         $v0, 0xC($a0)
    /* C2AC4 800D22C4 1000A284 */  lh         $v0, 0x10($a1)
    /* C2AC8 800D22C8 00000000 */  nop
    /* C2ACC 800D22CC 2110C200 */  addu       $v0, $a2, $v0
    /* C2AD0 800D22D0 25400201 */  or         $t0, $t0, $v0
    /* C2AD4 800D22D4 140088AC */  sw         $t0, 0x14($a0)
    /* C2AD8 800D22D8 0400A28C */  lw         $v0, 0x4($a1)
    /* C2ADC 800D22DC 00000000 */  nop
    /* C2AE0 800D22E0 180082AC */  sw         $v0, 0x18($a0)
    /* C2AE4 800D22E4 1200A284 */  lh         $v0, 0x12($a1)
    /* C2AE8 800D22E8 00000000 */  nop
    /* C2AEC 800D22EC 2110E200 */  addu       $v0, $a3, $v0
    /* C2AF0 800D22F0 00140200 */  sll        $v0, $v0, 16
    /* C2AF4 800D22F4 25104600 */  or         $v0, $v0, $a2
    /* C2AF8 800D22F8 200082AC */  sw         $v0, 0x20($a0)
    /* C2AFC 800D22FC 0800A28C */  lw         $v0, 0x8($a1)
    /* C2B00 800D2300 00000000 */  nop
    /* C2B04 800D2304 240082AC */  sw         $v0, 0x24($a0)
    /* C2B08 800D2308 1200A284 */  lh         $v0, 0x12($a1)
    /* C2B0C 800D230C 00000000 */  nop
    /* C2B10 800D2310 2138E200 */  addu       $a3, $a3, $v0
    /* C2B14 800D2314 1000A284 */  lh         $v0, 0x10($a1)
    /* C2B18 800D2318 003C0700 */  sll        $a3, $a3, 16
    /* C2B1C 800D231C 2130C200 */  addu       $a2, $a2, $v0
    /* C2B20 800D2320 2538E600 */  or         $a3, $a3, $a2
    /* C2B24 800D2324 2C0087AC */  sw         $a3, 0x2C($a0)
    /* C2B28 800D2328 0C00A28C */  lw         $v0, 0xC($a1)
    /* C2B2C 800D232C 0800E003 */  jr         $ra
    /* C2B30 800D2330 300082AC */   sw        $v0, 0x30($a0)
endlabel Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
