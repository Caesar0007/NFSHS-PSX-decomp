.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef, 0x78

glabel Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
    /* 64608 80073E08 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6460C 80073E0C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 64610 80073E10 08008384 */  lh         $v1, 0x8($a0)
    /* 64614 80073E14 0C008424 */  addiu      $a0, $a0, 0xC
    /* 64618 80073E18 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 6461C 80073E1C 80100300 */  sll        $v0, $v1, 2
    /* 64620 80073E20 21104300 */  addu       $v0, $v0, $v1
    /* 64624 80073E24 80100200 */  sll        $v0, $v0, 2
    /* 64628 80073E28 21104400 */  addu       $v0, $v0, $a0
    /* 6462C 80073E2C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 64630 80073E30 0F004788 */  lwl        $a3, 0xF($v0)
    /* 64634 80073E34 0C004798 */  lwr        $a3, 0xC($v0)
    /* 64638 80073E38 13004888 */  lwl        $t0, 0x13($v0)
    /* 6463C 80073E3C 10004898 */  lwr        $t0, 0x10($v0)
    /* 64640 80073E40 1300A7AB */  swl        $a3, 0x13($sp)
    /* 64644 80073E44 1000A7BB */  swr        $a3, 0x10($sp)
    /* 64648 80073E48 1700A8AB */  swl        $t0, 0x17($sp)
    /* 6464C 80073E4C 1400A8BB */  swr        $t0, 0x14($sp)
    /* 64650 80073E50 0000478C */  lw         $a3, 0x0($v0)
    /* 64654 80073E54 0400488C */  lw         $t0, 0x4($v0)
    /* 64658 80073E58 0800498C */  lw         $t1, 0x8($v0)
    /* 6465C 80073E5C 0000A7AC */  sw         $a3, 0x0($a1)
    /* 64660 80073E60 0400A8AC */  sw         $t0, 0x4($a1)
    /* 64664 80073E64 0800A9AC */  sw         $t1, 0x8($a1)
    /* 64668 80073E68 E0B5020C */  jal        Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* 6466C 80073E6C 2128C000 */   addu      $a1, $a2, $zero
    /* 64670 80073E70 1800BF8F */  lw         $ra, 0x18($sp)
    /* 64674 80073E74 00000000 */  nop
    /* 64678 80073E78 0800E003 */  jr         $ra
    /* 6467C 80073E7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef
