.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXDrawTransGouraudSquare__Fiiiiiiiii, 0x104

glabel PSXDrawTransGouraudSquare__Fiiiiiiiii
    /* 3F5CC 8004EDCC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3F5D0 8004EDD0 2800AF8F */  lw         $t7, 0x28($sp)
    /* 3F5D4 8004EDD4 1000B4AF */  sw         $s4, 0x10($sp)
    /* 3F5D8 8004EDD8 2C00B48F */  lw         $s4, 0x2C($sp)
    /* 3F5DC 8004EDDC 0C00B3AF */  sw         $s3, 0xC($sp)
    /* 3F5E0 8004EDE0 3000B38F */  lw         $s3, 0x30($sp)
    /* 3F5E4 8004EDE4 0800B2AF */  sw         $s2, 0x8($sp)
    /* 3F5E8 8004EDE8 3400B28F */  lw         $s2, 0x34($sp)
    /* 3F5EC 8004EDEC 21688000 */  addu       $t5, $a0, $zero
    /* 3F5F0 8004EDF0 0400B1AF */  sw         $s1, 0x4($sp)
    /* 3F5F4 8004EDF4 3800B18F */  lw         $s1, 0x38($sp)
    /* 3F5F8 8004EDF8 21400000 */  addu       $t0, $zero, $zero
    /* 3F5FC 8004EDFC 2D00E019 */  blez       $t7, .L8004EEB4
    /* 3F600 8004EE00 0000B0AF */   sw        $s0, 0x0($sp)
    /* 3F604 8004EE04 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* 3F608 8004EE08 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* 3F60C 8004EE0C 801F103C */  lui        $s0, (0x1F800000 >> 16)
    /* 3F610 8004EE10 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* 3F614 8004EE14 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* 3F618 8004EE18 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* 3F61C 8004EE1C 39001924 */  addiu      $t9, $zero, 0x39
    /* 3F620 8004EE20 08001824 */  addiu      $t8, $zero, 0x8
    /* 3F624 8004EE24 005C0500 */  sll        $t3, $a1, 16
    /* 3F628 8004EE28 2118A601 */  addu       $v1, $t5, $a2
    /* 3F62C 8004EE2C 25706301 */  or         $t6, $t3, $v1
    /* 3F630 8004EE30 2110A700 */  addu       $v0, $a1, $a3
    /* 3F634 8004EE34 00340200 */  sll        $a2, $v0, 16
    /* 3F638 8004EE38 2538C300 */  or         $a3, $a2, $v1
  .L8004EE3C:
    /* 3F63C 8004EE3C 01000825 */  addiu      $t0, $t0, 0x1
    /* 3F640 8004EE40 0000448D */  lw         $a0, 0x0($t2)
    /* 3F644 8004EE44 0000058E */  lw         $a1, (0x1F800000 & 0xFFFF)($s0)
    /* 3F648 8004EE48 0000838C */  lw         $v1, 0x0($a0)
    /* 3F64C 8004EE4C 0000A28C */  lw         $v0, 0x0($a1)
    /* 3F650 8004EE50 24186C00 */  and        $v1, $v1, $t4
    /* 3F654 8004EE54 24104900 */  and        $v0, $v0, $t1
    /* 3F658 8004EE58 25186200 */  or         $v1, $v1, $v0
    /* 3F65C 8004EE5C 000083AC */  sw         $v1, 0x0($a0)
    /* 3F660 8004EE60 0000A38C */  lw         $v1, 0x0($a1)
    /* 3F664 8004EE64 24008224 */  addiu      $v0, $a0, 0x24
    /* 3F668 8004EE68 000042AD */  sw         $v0, 0x0($t2)
    /* 3F66C 8004EE6C 24108900 */  and        $v0, $a0, $t1
    /* 3F670 8004EE70 24186C00 */  and        $v1, $v1, $t4
    /* 3F674 8004EE74 25186200 */  or         $v1, $v1, $v0
    /* 3F678 8004EE78 25106D01 */  or         $v0, $t3, $t5
    /* 3F67C 8004EE7C 0000A3AC */  sw         $v1, 0x0($a1)
    /* 3F680 8004EE80 080082AC */  sw         $v0, 0x8($a0)
    /* 3F684 8004EE84 2510CD00 */  or         $v0, $a2, $t5
    /* 3F688 8004EE88 180082AC */  sw         $v0, 0x18($a0)
    /* 3F68C 8004EE8C 2A100F01 */  slt        $v0, $t0, $t7
    /* 3F690 8004EE90 040094AC */  sw         $s4, 0x4($a0)
    /* 3F694 8004EE94 0C0093AC */  sw         $s3, 0xC($a0)
    /* 3F698 8004EE98 140092AC */  sw         $s2, 0x14($a0)
    /* 3F69C 8004EE9C 1C0091AC */  sw         $s1, 0x1C($a0)
    /* 3F6A0 8004EEA0 070099A0 */  sb         $t9, 0x7($a0)
    /* 3F6A4 8004EEA4 030098A0 */  sb         $t8, 0x3($a0)
    /* 3F6A8 8004EEA8 10008EAC */  sw         $t6, 0x10($a0)
    /* 3F6AC 8004EEAC E3FF4014 */  bnez       $v0, .L8004EE3C
    /* 3F6B0 8004EEB0 200087AC */   sw        $a3, 0x20($a0)
  .L8004EEB4:
    /* 3F6B4 8004EEB4 1000B48F */  lw         $s4, 0x10($sp)
    /* 3F6B8 8004EEB8 0C00B38F */  lw         $s3, 0xC($sp)
    /* 3F6BC 8004EEBC 0800B28F */  lw         $s2, 0x8($sp)
    /* 3F6C0 8004EEC0 0400B18F */  lw         $s1, 0x4($sp)
    /* 3F6C4 8004EEC4 0000B08F */  lw         $s0, 0x0($sp)
    /* 3F6C8 8004EEC8 0800E003 */  jr         $ra
    /* 3F6CC 8004EECC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PSXDrawTransGouraudSquare__Fiiiiiiiii
