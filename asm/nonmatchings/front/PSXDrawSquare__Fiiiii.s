.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXDrawSquare__Fiiiii, 0x98

glabel PSXDrawSquare__Fiiiii
    /* 3F444 8004EC44 801F0C3C */  lui        $t4, (0x1F800004 >> 16)
    /* 3F448 8004EC48 04008C35 */  ori        $t4, $t4, (0x1F800004 & 0xFFFF)
    /* 3F44C 8004EC4C FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* 3F450 8004EC50 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* 3F454 8004EC54 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* 3F458 8004EC58 2138A700 */  addu       $a3, $a1, $a3
    /* 3F45C 8004EC5C 0000888D */  lw         $t0, 0x0($t4)
    /* 3F460 8004EC60 801F0A3C */  lui        $t2, (0x1F800000 >> 16)
    /* 3F464 8004EC64 00004A8D */  lw         $t2, (0x1F800000 & 0xFFFF)($t2)
    /* 3F468 8004EC68 0000038D */  lw         $v1, 0x0($t0)
    /* 3F46C 8004EC6C 0000428D */  lw         $v0, 0x0($t2)
    /* 3F470 8004EC70 24186B00 */  and        $v1, $v1, $t3
    /* 3F474 8004EC74 24104900 */  and        $v0, $v0, $t1
    /* 3F478 8004EC78 25186200 */  or         $v1, $v1, $v0
    /* 3F47C 8004EC7C 000003AD */  sw         $v1, 0x0($t0)
    /* 3F480 8004EC80 18000325 */  addiu      $v1, $t0, 0x18
    /* 3F484 8004EC84 1000AD8F */  lw         $t5, 0x10($sp)
    /* 3F488 8004EC88 0000428D */  lw         $v0, 0x0($t2)
    /* 3F48C 8004EC8C 24480901 */  and        $t1, $t0, $t1
    /* 3F490 8004EC90 000083AD */  sw         $v1, 0x0($t4)
    /* 3F494 8004EC94 24104B00 */  and        $v0, $v0, $t3
    /* 3F498 8004EC98 25104900 */  or         $v0, $v0, $t1
    /* 3F49C 8004EC9C 000042AD */  sw         $v0, 0x0($t2)
    /* 3F4A0 8004ECA0 28000224 */  addiu      $v0, $zero, 0x28
    /* 3F4A4 8004ECA4 040004AD */  sw         $a0, 0x4($t0)
    /* 3F4A8 8004ECA8 070002A1 */  sb         $v0, 0x7($t0)
    /* 3F4AC 8004ECAC 05000224 */  addiu      $v0, $zero, 0x5
    /* 3F4B0 8004ECB0 0A0006A5 */  sh         $a2, 0xA($t0)
    /* 3F4B4 8004ECB4 0E0006A5 */  sh         $a2, 0xE($t0)
    /* 3F4B8 8004ECB8 2130CD00 */  addu       $a2, $a2, $t5
    /* 3F4BC 8004ECBC 030002A1 */  sb         $v0, 0x3($t0)
    /* 3F4C0 8004ECC0 080005A5 */  sh         $a1, 0x8($t0)
    /* 3F4C4 8004ECC4 0C0007A5 */  sh         $a3, 0xC($t0)
    /* 3F4C8 8004ECC8 100005A5 */  sh         $a1, 0x10($t0)
    /* 3F4CC 8004ECCC 120006A5 */  sh         $a2, 0x12($t0)
    /* 3F4D0 8004ECD0 140007A5 */  sh         $a3, 0x14($t0)
    /* 3F4D4 8004ECD4 0800E003 */  jr         $ra
    /* 3F4D8 8004ECD8 160006A5 */   sh        $a2, 0x16($t0)
endlabel PSXDrawSquare__Fiiiii
