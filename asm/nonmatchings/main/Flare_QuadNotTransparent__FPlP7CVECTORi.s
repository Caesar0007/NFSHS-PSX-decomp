.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_QuadNotTransparent__FPlP7CVECTORi, 0xA4

glabel Flare_QuadNotTransparent__FPlP7CVECTORi
    /* BECC4 800CE4C4 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BECC8 800CE4C8 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BECCC 800CE4CC FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BECD0 800CE4D0 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BECD4 800CE4D4 80300600 */  sll        $a2, $a2, 2
    /* BECD8 800CE4D8 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* BECDC 800CE4DC 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BECE0 800CE4E0 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BECE4 800CE4E4 0000478D */  lw         $a3, 0x0($t2)
    /* BECE8 800CE4E8 2130C200 */  addu       $a2, $a2, $v0
    /* BECEC 800CE4EC 0000E38C */  lw         $v1, 0x0($a3)
    /* BECF0 800CE4F0 0000C28C */  lw         $v0, 0x0($a2)
    /* BECF4 800CE4F4 24186900 */  and        $v1, $v1, $t1
    /* BECF8 800CE4F8 24104800 */  and        $v0, $v0, $t0
    /* BECFC 800CE4FC 25186200 */  or         $v1, $v1, $v0
    /* BED00 800CE500 0000E3AC */  sw         $v1, 0x0($a3)
    /* BED04 800CE504 1800E324 */  addiu      $v1, $a3, 0x18
    /* BED08 800CE508 0000C28C */  lw         $v0, 0x0($a2)
    /* BED0C 800CE50C 2440E800 */  and        $t0, $a3, $t0
    /* BED10 800CE510 000043AD */  sw         $v1, 0x0($t2)
    /* BED14 800CE514 24104900 */  and        $v0, $v0, $t1
    /* BED18 800CE518 25104800 */  or         $v0, $v0, $t0
    /* BED1C 800CE51C 0000C2AC */  sw         $v0, 0x0($a2)
    /* BED20 800CE520 0000A38C */  lw         $v1, 0x0($a1)
    /* BED24 800CE524 05000224 */  addiu      $v0, $zero, 0x5
    /* BED28 800CE528 0300E2A0 */  sb         $v0, 0x3($a3)
    /* BED2C 800CE52C 28000224 */  addiu      $v0, $zero, 0x28
    /* BED30 800CE530 0400E3AC */  sw         $v1, 0x4($a3)
    /* BED34 800CE534 0700E2A0 */  sb         $v0, 0x7($a3)
    /* BED38 800CE538 0000828C */  lw         $v0, 0x0($a0)
    /* BED3C 800CE53C 00000000 */  nop
    /* BED40 800CE540 0800E2AC */  sw         $v0, 0x8($a3)
    /* BED44 800CE544 0400828C */  lw         $v0, 0x4($a0)
    /* BED48 800CE548 00000000 */  nop
    /* BED4C 800CE54C 0C00E2AC */  sw         $v0, 0xC($a3)
    /* BED50 800CE550 0800828C */  lw         $v0, 0x8($a0)
    /* BED54 800CE554 00000000 */  nop
    /* BED58 800CE558 1000E2AC */  sw         $v0, 0x10($a3)
    /* BED5C 800CE55C 0C00828C */  lw         $v0, 0xC($a0)
    /* BED60 800CE560 0800E003 */  jr         $ra
    /* BED64 800CE564 1400E2AC */   sw        $v0, 0x14($a3)
endlabel Flare_QuadNotTransparent__FPlP7CVECTORi
