.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_Quad__FPlP7CVECTORi, 0xA4

glabel Flare_Quad__FPlP7CVECTORi
    /* BEC20 800CE420 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BEC24 800CE424 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BEC28 800CE428 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BEC2C 800CE42C FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BEC30 800CE430 80300600 */  sll        $a2, $a2, 2
    /* BEC34 800CE434 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* BEC38 800CE438 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BEC3C 800CE43C 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BEC40 800CE440 0000478D */  lw         $a3, 0x0($t2)
    /* BEC44 800CE444 2130C200 */  addu       $a2, $a2, $v0
    /* BEC48 800CE448 0000E38C */  lw         $v1, 0x0($a3)
    /* BEC4C 800CE44C 0000C28C */  lw         $v0, 0x0($a2)
    /* BEC50 800CE450 24186900 */  and        $v1, $v1, $t1
    /* BEC54 800CE454 24104800 */  and        $v0, $v0, $t0
    /* BEC58 800CE458 25186200 */  or         $v1, $v1, $v0
    /* BEC5C 800CE45C 0000E3AC */  sw         $v1, 0x0($a3)
    /* BEC60 800CE460 1800E324 */  addiu      $v1, $a3, 0x18
    /* BEC64 800CE464 0000C28C */  lw         $v0, 0x0($a2)
    /* BEC68 800CE468 2440E800 */  and        $t0, $a3, $t0
    /* BEC6C 800CE46C 000043AD */  sw         $v1, 0x0($t2)
    /* BEC70 800CE470 24104900 */  and        $v0, $v0, $t1
    /* BEC74 800CE474 25104800 */  or         $v0, $v0, $t0
    /* BEC78 800CE478 0000C2AC */  sw         $v0, 0x0($a2)
    /* BEC7C 800CE47C 0000A38C */  lw         $v1, 0x0($a1)
    /* BEC80 800CE480 05000224 */  addiu      $v0, $zero, 0x5
    /* BEC84 800CE484 0300E2A0 */  sb         $v0, 0x3($a3)
    /* BEC88 800CE488 2A000224 */  addiu      $v0, $zero, 0x2A
    /* BEC8C 800CE48C 0400E3AC */  sw         $v1, 0x4($a3)
    /* BEC90 800CE490 0700E2A0 */  sb         $v0, 0x7($a3)
    /* BEC94 800CE494 0000828C */  lw         $v0, 0x0($a0)
    /* BEC98 800CE498 00000000 */  nop
    /* BEC9C 800CE49C 0800E2AC */  sw         $v0, 0x8($a3)
    /* BECA0 800CE4A0 0400828C */  lw         $v0, 0x4($a0)
    /* BECA4 800CE4A4 00000000 */  nop
    /* BECA8 800CE4A8 0C00E2AC */  sw         $v0, 0xC($a3)
    /* BECAC 800CE4AC 0800828C */  lw         $v0, 0x8($a0)
    /* BECB0 800CE4B0 00000000 */  nop
    /* BECB4 800CE4B4 1000E2AC */  sw         $v0, 0x10($a3)
    /* BECB8 800CE4B8 0C00828C */  lw         $v0, 0xC($a0)
    /* BECBC 800CE4BC 0800E003 */  jr         $ra
    /* BECC0 800CE4C0 1400E2AC */   sw        $v0, 0x14($a3)
endlabel Flare_Quad__FPlP7CVECTORi
