.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSYS_setopts, 0xFC

glabel SNDSYS_setopts
    /* E2614 800F1E14 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E2618 800F1E18 1480023C */  lui        $v0, %hi(sndgs)
    /* E261C 800F1E1C 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* E2620 800F1E20 0C004524 */  addiu      $a1, $v0, 0xC
    /* E2624 800F1E24 0C008324 */  addiu      $v1, $a0, 0xC
    /* E2628 800F1E28 25106500 */  or         $v0, $v1, $a1
    /* E262C 800F1E2C 03004230 */  andi       $v0, $v0, 0x3
    /* E2630 800F1E30 17004010 */  beqz       $v0, .L800F1E90
    /* E2634 800F1E34 1000BFAF */   sw        $ra, 0x10($sp)
    /* E2638 800F1E38 2C008224 */  addiu      $v0, $a0, 0x2C
  .L800F1E3C:
    /* E263C 800F1E3C 03006688 */  lwl        $a2, 0x3($v1)
    /* E2640 800F1E40 00006698 */  lwr        $a2, 0x0($v1)
    /* E2644 800F1E44 07006788 */  lwl        $a3, 0x7($v1)
    /* E2648 800F1E48 04006798 */  lwr        $a3, 0x4($v1)
    /* E264C 800F1E4C 0B006888 */  lwl        $t0, 0xB($v1)
    /* E2650 800F1E50 08006898 */  lwr        $t0, 0x8($v1)
    /* E2654 800F1E54 0F006988 */  lwl        $t1, 0xF($v1)
    /* E2658 800F1E58 0C006998 */  lwr        $t1, 0xC($v1)
    /* E265C 800F1E5C 0300A6A8 */  swl        $a2, 0x3($a1)
    /* E2660 800F1E60 0000A6B8 */  swr        $a2, 0x0($a1)
    /* E2664 800F1E64 0700A7A8 */  swl        $a3, 0x7($a1)
    /* E2668 800F1E68 0400A7B8 */  swr        $a3, 0x4($a1)
    /* E266C 800F1E6C 0B00A8A8 */  swl        $t0, 0xB($a1)
    /* E2670 800F1E70 0800A8B8 */  swr        $t0, 0x8($a1)
    /* E2674 800F1E74 0F00A9A8 */  swl        $t1, 0xF($a1)
    /* E2678 800F1E78 0C00A9B8 */  swr        $t1, 0xC($a1)
    /* E267C 800F1E7C 10006324 */  addiu      $v1, $v1, 0x10
    /* E2680 800F1E80 EEFF6214 */  bne        $v1, $v0, .L800F1E3C
    /* E2684 800F1E84 1000A524 */   addiu     $a1, $a1, 0x10
    /* E2688 800F1E88 B0C70308 */  j          .L800F1EC0
    /* E268C 800F1E8C 00000000 */   nop
  .L800F1E90:
    /* E2690 800F1E90 2C008224 */  addiu      $v0, $a0, 0x2C
  .L800F1E94:
    /* E2694 800F1E94 0000668C */  lw         $a2, 0x0($v1)
    /* E2698 800F1E98 0400678C */  lw         $a3, 0x4($v1)
    /* E269C 800F1E9C 0800688C */  lw         $t0, 0x8($v1)
    /* E26A0 800F1EA0 0C00698C */  lw         $t1, 0xC($v1)
    /* E26A4 800F1EA4 0000A6AC */  sw         $a2, 0x0($a1)
    /* E26A8 800F1EA8 0400A7AC */  sw         $a3, 0x4($a1)
    /* E26AC 800F1EAC 0800A8AC */  sw         $t0, 0x8($a1)
    /* E26B0 800F1EB0 0C00A9AC */  sw         $t1, 0xC($a1)
    /* E26B4 800F1EB4 10006324 */  addiu      $v1, $v1, 0x10
    /* E26B8 800F1EB8 F6FF6214 */  bne        $v1, $v0, .L800F1E94
    /* E26BC 800F1EBC 1000A524 */   addiu     $a1, $a1, 0x10
  .L800F1EC0:
    /* E26C0 800F1EC0 03006688 */  lwl        $a2, 0x3($v1)
    /* E26C4 800F1EC4 00006698 */  lwr        $a2, 0x0($v1)
    /* E26C8 800F1EC8 07006788 */  lwl        $a3, 0x7($v1)
    /* E26CC 800F1ECC 04006798 */  lwr        $a3, 0x4($v1)
    /* E26D0 800F1ED0 0B006888 */  lwl        $t0, 0xB($v1)
    /* E26D4 800F1ED4 08006898 */  lwr        $t0, 0x8($v1)
    /* E26D8 800F1ED8 0300A6A8 */  swl        $a2, 0x3($a1)
    /* E26DC 800F1EDC 0000A6B8 */  swr        $a2, 0x0($a1)
    /* E26E0 800F1EE0 0700A7A8 */  swl        $a3, 0x7($a1)
    /* E26E4 800F1EE4 0400A7B8 */  swr        $a3, 0x4($a1)
    /* E26E8 800F1EE8 0B00A8A8 */  swl        $t0, 0xB($a1)
    /* E26EC 800F1EEC 0800A8B8 */  swr        $t0, 0x8($a1)
    /* E26F0 800F1EF0 3800838C */  lw         $v1, 0x38($a0)
    /* E26F4 800F1EF4 1480023C */  lui        $v0, %hi(D_80147898)
    /* E26F8 800F1EF8 80FD030C */  jal        iSNDplatformoutputset
    /* E26FC 800F1EFC 987843AC */   sw        $v1, %lo(D_80147898)($v0)
    /* E2700 800F1F00 1000BF8F */  lw         $ra, 0x10($sp)
    /* E2704 800F1F04 21100000 */  addu       $v0, $zero, $zero
    /* E2708 800F1F08 0800E003 */  jr         $ra
    /* E270C 800F1F0C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSYS_setopts
