.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_SetDitheringPrim__Fii, 0x88

glabel Hrz_SetDitheringPrim__Fii
    /* C11B0 800D09B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C11B4 800D09B4 21308000 */  addu       $a2, $a0, $zero
    /* C11B8 800D09B8 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* C11BC 800D09BC 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* C11C0 800D09C0 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* C11C4 800D09C4 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* C11C8 800D09C8 80280500 */  sll        $a1, $a1, 2
    /* C11CC 800D09CC 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* C11D0 800D09D0 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* C11D4 800D09D4 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C11D8 800D09D8 1800BFAF */  sw         $ra, 0x18($sp)
    /* C11DC 800D09DC 0000248D */  lw         $a0, 0x0($t1)
    /* C11E0 800D09E0 2128A200 */  addu       $a1, $a1, $v0
    /* C11E4 800D09E4 0000838C */  lw         $v1, 0x0($a0)
    /* C11E8 800D09E8 0000A28C */  lw         $v0, 0x0($a1)
    /* C11EC 800D09EC 24186800 */  and        $v1, $v1, $t0
    /* C11F0 800D09F0 24104700 */  and        $v0, $v0, $a3
    /* C11F4 800D09F4 25186200 */  or         $v1, $v1, $v0
    /* C11F8 800D09F8 000083AC */  sw         $v1, 0x0($a0)
    /* C11FC 800D09FC 0C008324 */  addiu      $v1, $a0, 0xC
    /* C1200 800D0A00 0000A28C */  lw         $v0, 0x0($a1)
    /* C1204 800D0A04 24388700 */  and        $a3, $a0, $a3
    /* C1208 800D0A08 000023AD */  sw         $v1, 0x0($t1)
    /* C120C 800D0A0C 24104800 */  and        $v0, $v0, $t0
    /* C1210 800D0A10 25104700 */  or         $v0, $v0, $a3
    /* C1214 800D0A14 0000A2AC */  sw         $v0, 0x0($a1)
    /* C1218 800D0A18 21280000 */  addu       $a1, $zero, $zero
    /* C121C 800D0A1C 00010724 */  addiu      $a3, $zero, 0x100
    /* C1220 800D0A20 EFB8030C */  jal        SetDrawMode
    /* C1224 800D0A24 1000A0AF */   sw        $zero, 0x10($sp)
    /* C1228 800D0A28 1800BF8F */  lw         $ra, 0x18($sp)
    /* C122C 800D0A2C 00000000 */  nop
    /* C1230 800D0A30 0800E003 */  jr         $ra
    /* C1234 800D0A34 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hrz_SetDitheringPrim__Fii
