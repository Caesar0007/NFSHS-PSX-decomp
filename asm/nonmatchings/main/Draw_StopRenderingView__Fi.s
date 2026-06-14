.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_StopRenderingView__Fi, 0x118

glabel Draw_StopRenderingView__Fi
    /* AE918 800BE118 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* AE91C 800BE11C 1000A727 */  addiu      $a3, $sp, 0x10
    /* AE920 800BE120 40100400 */  sll        $v0, $a0, 1
    /* AE924 800BE124 21104400 */  addu       $v0, $v0, $a0
    /* AE928 800BE128 C0100200 */  sll        $v0, $v0, 3
    /* AE92C 800BE12C 21104400 */  addu       $v0, $v0, $a0
    /* AE930 800BE130 C0100200 */  sll        $v0, $v0, 3
    /* AE934 800BE134 1280033C */  lui        $v1, %hi(Draw_gView)
    /* AE938 800BE138 54EC6324 */  addiu      $v1, $v1, %lo(Draw_gView)
    /* AE93C 800BE13C 6812848F */  lw         $a0, %gp_rel(gFlip)($gp)
    /* AE940 800BE140 21284300 */  addu       $a1, $v0, $v1
    /* AE944 800BE144 7000BFAF */  sw         $ra, 0x70($sp)
    /* AE948 800BE148 40100400 */  sll        $v0, $a0, 1
    /* AE94C 800BE14C 21104400 */  addu       $v0, $v0, $a0
    /* AE950 800BE150 C0100200 */  sll        $v0, $v0, 3
    /* AE954 800BE154 23104400 */  subu       $v0, $v0, $a0
    /* AE958 800BE158 80100200 */  sll        $v0, $v0, 2
    /* AE95C 800BE15C 2110A200 */  addu       $v0, $a1, $v0
    /* AE960 800BE160 08004324 */  addiu      $v1, $v0, 0x8
    /* AE964 800BE164 58004224 */  addiu      $v0, $v0, 0x58
  .L800BE168:
    /* AE968 800BE168 00006A8C */  lw         $t2, 0x0($v1)
    /* AE96C 800BE16C 04006B8C */  lw         $t3, 0x4($v1)
    /* AE970 800BE170 08006C8C */  lw         $t4, 0x8($v1)
    /* AE974 800BE174 0C006D8C */  lw         $t5, 0xC($v1)
    /* AE978 800BE178 0000EAAC */  sw         $t2, 0x0($a3)
    /* AE97C 800BE17C 0400EBAC */  sw         $t3, 0x4($a3)
    /* AE980 800BE180 0800ECAC */  sw         $t4, 0x8($a3)
    /* AE984 800BE184 0C00EDAC */  sw         $t5, 0xC($a3)
    /* AE988 800BE188 10006324 */  addiu      $v1, $v1, 0x10
    /* AE98C 800BE18C F6FF6214 */  bne        $v1, $v0, .L800BE168
    /* AE990 800BE190 1000E724 */   addiu     $a3, $a3, 0x10
    /* AE994 800BE194 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* AE998 800BE198 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* AE99C 800BE19C FF00063C */  lui        $a2, (0xFFFFFF >> 16)
    /* AE9A0 800BE1A0 FFFFC634 */  ori        $a2, $a2, (0xFFFFFF & 0xFFFF)
    /* AE9A4 800BE1A4 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* AE9A8 800BE1A8 00006A8C */  lw         $t2, 0x0($v1)
    /* AE9AC 800BE1AC 04006B8C */  lw         $t3, 0x4($v1)
    /* AE9B0 800BE1B0 08006C8C */  lw         $t4, 0x8($v1)
    /* AE9B4 800BE1B4 0000EAAC */  sw         $t2, 0x0($a3)
    /* AE9B8 800BE1B8 0400EBAC */  sw         $t3, 0x4($a3)
    /* AE9BC 800BE1BC 0800ECAC */  sw         $t4, 0x8($a3)
    /* AE9C0 800BE1C0 0000A28C */  lw         $v0, 0x0($a1)
    /* AE9C4 800BE1C4 801F073C */  lui        $a3, (0x1F800000 >> 16)
    /* AE9C8 800BE1C8 0000E78C */  lw         $a3, (0x1F800000 & 0xFFFF)($a3)
    /* AE9CC 800BE1CC 0000248D */  lw         $a0, 0x0($t1)
    /* AE9D0 800BE1D0 80100200 */  sll        $v0, $v0, 2
    /* AE9D4 800BE1D4 21104700 */  addu       $v0, $v0, $a3
    /* AE9D8 800BE1D8 0000838C */  lw         $v1, 0x0($a0)
    /* AE9DC 800BE1DC FCFF428C */  lw         $v0, -0x4($v0)
    /* AE9E0 800BE1E0 24186800 */  and        $v1, $v1, $t0
    /* AE9E4 800BE1E4 24104600 */  and        $v0, $v0, $a2
    /* AE9E8 800BE1E8 25186200 */  or         $v1, $v1, $v0
    /* AE9EC 800BE1EC 000083AC */  sw         $v1, 0x0($a0)
    /* AE9F0 800BE1F0 0000A58C */  lw         $a1, 0x0($a1)
    /* AE9F4 800BE1F4 40008324 */  addiu      $v1, $a0, 0x40
    /* AE9F8 800BE1F8 80280500 */  sll        $a1, $a1, 2
    /* AE9FC 800BE1FC 2128A700 */  addu       $a1, $a1, $a3
    /* AEA00 800BE200 FCFFA28C */  lw         $v0, -0x4($a1)
    /* AEA04 800BE204 24308600 */  and        $a2, $a0, $a2
    /* AEA08 800BE208 000023AD */  sw         $v1, 0x0($t1)
    /* AEA0C 800BE20C 24104800 */  and        $v0, $v0, $t0
    /* AEA10 800BE210 25104600 */  or         $v0, $v0, $a2
    /* AEA14 800BE214 FCFFA2AC */  sw         $v0, -0x4($a1)
    /* AEA18 800BE218 04B9030C */  jal        SetDrawEnv
    /* AEA1C 800BE21C 1000A527 */   addiu     $a1, $sp, 0x10
    /* AEA20 800BE220 7000BF8F */  lw         $ra, 0x70($sp)
    /* AEA24 800BE224 00000000 */  nop
    /* AEA28 800BE228 0800E003 */  jr         $ra
    /* AEA2C 800BE22C 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel Draw_StopRenderingView__Fi
