.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_QuadRing__FPlP7CVECTORi, 0xB4

glabel Flare_QuadRing__FPlP7CVECTORi
    /* BED68 800CE568 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BED6C 800CE56C 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BED70 800CE570 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BED74 800CE574 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BED78 800CE578 80300600 */  sll        $a2, $a2, 2
    /* BED7C 800CE57C 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* BED80 800CE580 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BED84 800CE584 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BED88 800CE588 0000478D */  lw         $a3, 0x0($t2)
    /* BED8C 800CE58C 2130C200 */  addu       $a2, $a2, $v0
    /* BED90 800CE590 0000E38C */  lw         $v1, 0x0($a3)
    /* BED94 800CE594 0000C28C */  lw         $v0, 0x0($a2)
    /* BED98 800CE598 24186900 */  and        $v1, $v1, $t1
    /* BED9C 800CE59C 24104800 */  and        $v0, $v0, $t0
    /* BEDA0 800CE5A0 25186200 */  or         $v1, $v1, $v0
    /* BEDA4 800CE5A4 0000E3AC */  sw         $v1, 0x0($a3)
    /* BEDA8 800CE5A8 0000C28C */  lw         $v0, 0x0($a2)
    /* BEDAC 800CE5AC 2440E800 */  and        $t0, $a3, $t0
    /* BEDB0 800CE5B0 24104900 */  and        $v0, $v0, $t1
    /* BEDB4 800CE5B4 25104800 */  or         $v0, $v0, $t0
    /* BEDB8 800CE5B8 0000C2AC */  sw         $v0, 0x0($a2)
    /* BEDBC 800CE5BC 0000A38C */  lw         $v1, 0x0($a1)
    /* BEDC0 800CE5C0 2400E224 */  addiu      $v0, $a3, 0x24
    /* BEDC4 800CE5C4 000042AD */  sw         $v0, 0x0($t2)
    /* BEDC8 800CE5C8 0C00E0AC */  sw         $zero, 0xC($a3)
    /* BEDCC 800CE5CC 0400E3AC */  sw         $v1, 0x4($a3)
    /* BEDD0 800CE5D0 0000A38C */  lw         $v1, 0x0($a1)
    /* BEDD4 800CE5D4 08000224 */  addiu      $v0, $zero, 0x8
    /* BEDD8 800CE5D8 0300E2A0 */  sb         $v0, 0x3($a3)
    /* BEDDC 800CE5DC 3A000224 */  addiu      $v0, $zero, 0x3A
    /* BEDE0 800CE5E0 1C00E0AC */  sw         $zero, 0x1C($a3)
    /* BEDE4 800CE5E4 0700E2A0 */  sb         $v0, 0x7($a3)
    /* BEDE8 800CE5E8 1400E3AC */  sw         $v1, 0x14($a3)
    /* BEDEC 800CE5EC 0000828C */  lw         $v0, 0x0($a0)
    /* BEDF0 800CE5F0 00000000 */  nop
    /* BEDF4 800CE5F4 0800E2AC */  sw         $v0, 0x8($a3)
    /* BEDF8 800CE5F8 0400828C */  lw         $v0, 0x4($a0)
    /* BEDFC 800CE5FC 00000000 */  nop
    /* BEE00 800CE600 1000E2AC */  sw         $v0, 0x10($a3)
    /* BEE04 800CE604 0800828C */  lw         $v0, 0x8($a0)
    /* BEE08 800CE608 00000000 */  nop
    /* BEE0C 800CE60C 1800E2AC */  sw         $v0, 0x18($a3)
    /* BEE10 800CE610 0C00828C */  lw         $v0, 0xC($a0)
    /* BEE14 800CE614 0800E003 */  jr         $ra
    /* BEE18 800CE618 2000E2AC */   sw        $v0, 0x20($a3)
endlabel Flare_QuadRing__FPlP7CVECTORi
