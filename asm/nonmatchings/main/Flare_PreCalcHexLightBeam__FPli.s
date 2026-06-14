.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_PreCalcHexLightBeam__FPli, 0xD4

glabel Flare_PreCalcHexLightBeam__FPli
    /* BEB4C 800CE34C F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* BEB50 800CE350 21400000 */  addu       $t0, $zero, $zero
    /* BEB54 800CE354 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* BEB58 800CE358 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* BEB5C 800CE35C 801F0C3C */  lui        $t4, (0x1F800000 >> 16)
    /* BEB60 800CE360 80580500 */  sll        $t3, $a1, 2
    /* BEB64 800CE364 FF00073C */  lui        $a3, (0xFFFFFF >> 16)
    /* BEB68 800CE368 FFFFE734 */  ori        $a3, $a3, (0xFFFFFF & 0xFFFF)
    /* BEB6C 800CE36C 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BEB70 800CE370 1280023C */  lui        $v0, %hi(Flare_gOct)
    /* BEB74 800CE374 0000838C */  lw         $v1, 0x0($a0)
    /* BEB78 800CE378 68FE4624 */  addiu      $a2, $v0, %lo(Flare_gOct)
    /* BEB7C 800CE37C 0000A3AF */  sw         $v1, 0x0($sp)
  .L800CE380:
    /* BEB80 800CE380 08000229 */  slti       $v0, $t0, 0x8
    /* BEB84 800CE384 24004010 */  beqz       $v0, .L800CE418
    /* BEB88 800CE388 00000000 */   nop
    /* BEB8C 800CE38C 0000C0C8 */  lwc2       $0, 0x0($a2)
    /* BEB90 800CE390 0400C1C8 */  lwc2       $1, 0x4($a2)
    /* BEB94 800CE394 0000858D */  lw         $a1, (0x1F800000 & 0xFFFF)($t4)
    /* BEB98 800CE398 0000248D */  lw         $a0, 0x0($t1)
    /* BEB9C 800CE39C 21286501 */  addu       $a1, $t3, $a1
    /* BEBA0 800CE3A0 0000838C */  lw         $v1, 0x0($a0)
    /* BEBA4 800CE3A4 0000A28C */  lw         $v0, 0x0($a1)
    /* BEBA8 800CE3A8 24186A00 */  and        $v1, $v1, $t2
    /* BEBAC 800CE3AC 24104700 */  and        $v0, $v0, $a3
    /* BEBB0 800CE3B0 25186200 */  or         $v1, $v1, $v0
    /* BEBB4 800CE3B4 000083AC */  sw         $v1, 0x0($a0)
    /* BEBB8 800CE3B8 0000A38C */  lw         $v1, 0x0($a1)
    /* BEBBC 800CE3BC 14008224 */  addiu      $v0, $a0, 0x14
    /* BEBC0 800CE3C0 000022AD */  sw         $v0, 0x0($t1)
    /* BEBC4 800CE3C4 24108700 */  and        $v0, $a0, $a3
    /* BEBC8 800CE3C8 24186A00 */  and        $v1, $v1, $t2
    /* BEBCC 800CE3CC 25186200 */  or         $v1, $v1, $v0
    /* BEBD0 800CE3D0 0000A3AC */  sw         $v1, 0x0($a1)
    /* BEBD4 800CE3D4 0100184A */  .word 0x4A180001  /* rtps */
    /* BEBD8 800CE3D8 2413838F */  lw         $v1, %gp_rel(gfrgb2)($gp)
    /* BEBDC 800CE3DC 04000224 */  addiu      $v0, $zero, 0x4
    /* BEBE0 800CE3E0 030082A0 */  sb         $v0, 0x3($a0)
    /* BEBE4 800CE3E4 52000224 */  addiu      $v0, $zero, 0x52
    /* BEBE8 800CE3E8 0C0080AC */  sw         $zero, 0xC($a0)
    /* BEBEC 800CE3EC 040083AC */  sw         $v1, 0x4($a0)
    /* BEBF0 800CE3F0 070082A0 */  sb         $v0, 0x7($a0)
    /* BEBF4 800CE3F4 0400A227 */  addiu      $v0, $sp, 0x4
    /* BEBF8 800CE3F8 00004EE8 */  swc2       $14, 0x0($v0)
    /* BEBFC 800CE3FC 0000A28F */  lw         $v0, 0x0($sp)
    /* BEC00 800CE400 0800C624 */  addiu      $a2, $a2, 0x8
    /* BEC04 800CE404 080082AC */  sw         $v0, 0x8($a0)
    /* BEC08 800CE408 0400A28F */  lw         $v0, 0x4($sp)
    /* BEC0C 800CE40C 01000825 */  addiu      $t0, $t0, 0x1
    /* BEC10 800CE410 E0380308 */  j          .L800CE380
    /* BEC14 800CE414 100082AC */   sw        $v0, 0x10($a0)
  .L800CE418:
    /* BEC18 800CE418 0800E003 */  jr         $ra
    /* BEC1C 800CE41C 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel Flare_PreCalcHexLightBeam__FPli
