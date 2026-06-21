.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXDrawGouraudSquare__Fiiiiiiii, 0xF0

glabel PSXDrawGouraudSquare__Fiiiiiiii
    /* 3F4DC 8004ECDC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 3F4E0 8004ECE0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 3F4E4 8004ECE4 21988000 */  addu       $s3, $a0, $zero
    /* 3F4E8 8004ECE8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3F4EC 8004ECEC 2188A000 */  addu       $s1, $a1, $zero
    /* 3F4F0 8004ECF0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 3F4F4 8004ECF4 2190C000 */  addu       $s2, $a2, $zero
    /* 3F4F8 8004ECF8 2000B4AF */  sw         $s4, 0x20($sp)
    /* 3F4FC 8004ECFC 21A0E000 */  addu       $s4, $a3, $zero
    /* 3F500 8004ED00 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* 3F504 8004ED04 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* 3F508 8004ED08 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* 3F50C 8004ED0C FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* 3F510 8004ED10 00FF063C */  lui        $a2, (0xFF000000 >> 16)
    /* 3F514 8004ED14 2400BFAF */  sw         $ra, 0x24($sp)
    /* 3F518 8004ED18 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3F51C 8004ED1C 0000708D */  lw         $s0, 0x0($t3)
    /* 3F520 8004ED20 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* 3F524 8004ED24 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* 3F528 8004ED28 0000038E */  lw         $v1, 0x0($s0)
    /* 3F52C 8004ED2C 0000A28C */  lw         $v0, 0x0($a1)
    /* 3F530 8004ED30 24186600 */  and        $v1, $v1, $a2
    /* 3F534 8004ED34 24104400 */  and        $v0, $v0, $a0
    /* 3F538 8004ED38 25186200 */  or         $v1, $v1, $v0
    /* 3F53C 8004ED3C 000003AE */  sw         $v1, 0x0($s0)
    /* 3F540 8004ED40 24000326 */  addiu      $v1, $s0, 0x24
    /* 3F544 8004ED44 3800A78F */  lw         $a3, 0x38($sp)
    /* 3F548 8004ED48 3C00A88F */  lw         $t0, 0x3C($sp)
    /* 3F54C 8004ED4C 4000A98F */  lw         $t1, 0x40($sp)
    /* 3F550 8004ED50 4400AA8F */  lw         $t2, 0x44($sp)
    /* 3F554 8004ED54 0000A28C */  lw         $v0, 0x0($a1)
    /* 3F558 8004ED58 24200402 */  and        $a0, $s0, $a0
    /* 3F55C 8004ED5C 000063AD */  sw         $v1, 0x0($t3)
    /* 3F560 8004ED60 24104600 */  and        $v0, $v0, $a2
    /* 3F564 8004ED64 25104400 */  or         $v0, $v0, $a0
    /* 3F568 8004ED68 21200002 */  addu       $a0, $s0, $zero
    /* 3F56C 8004ED6C 0000A2AC */  sw         $v0, 0x0($a1)
    /* 3F570 8004ED70 040007AE */  sw         $a3, 0x4($s0)
    /* 3F574 8004ED74 0C0008AE */  sw         $t0, 0xC($s0)
    /* 3F578 8004ED78 140009AE */  sw         $t1, 0x14($s0)
    /* 3F57C 8004ED7C 8CCD030C */  jal        SetPolyG4
    /* 3F580 8004ED80 1C000AAE */   sw        $t2, 0x1C($s0)
    /* 3F584 8004ED84 21907202 */  addu       $s2, $s3, $s2
    /* 3F588 8004ED88 0A0011A6 */  sh         $s1, 0xA($s0)
    /* 3F58C 8004ED8C 120011A6 */  sh         $s1, 0x12($s0)
    /* 3F590 8004ED90 21883402 */  addu       $s1, $s1, $s4
    /* 3F594 8004ED94 080013A6 */  sh         $s3, 0x8($s0)
    /* 3F598 8004ED98 100012A6 */  sh         $s2, 0x10($s0)
    /* 3F59C 8004ED9C 180013A6 */  sh         $s3, 0x18($s0)
    /* 3F5A0 8004EDA0 1A0011A6 */  sh         $s1, 0x1A($s0)
    /* 3F5A4 8004EDA4 200012A6 */  sh         $s2, 0x20($s0)
    /* 3F5A8 8004EDA8 220011A6 */  sh         $s1, 0x22($s0)
    /* 3F5AC 8004EDAC 2400BF8F */  lw         $ra, 0x24($sp)
    /* 3F5B0 8004EDB0 2000B48F */  lw         $s4, 0x20($sp)
    /* 3F5B4 8004EDB4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 3F5B8 8004EDB8 1800B28F */  lw         $s2, 0x18($sp)
    /* 3F5BC 8004EDBC 1400B18F */  lw         $s1, 0x14($sp)
    /* 3F5C0 8004EDC0 1000B08F */  lw         $s0, 0x10($sp)
    /* 3F5C4 8004EDC4 0800E003 */  jr         $ra
    /* 3F5C8 8004EDC8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel PSXDrawGouraudSquare__Fiiiiiiii
