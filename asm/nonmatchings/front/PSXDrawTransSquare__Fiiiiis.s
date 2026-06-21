.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PSXDrawTransSquare__Fiiiiis, 0xE4

glabel PSXDrawTransSquare__Fiiiiis
    /* 3F6D0 8004EED0 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* 3F6D4 8004EED4 0400B1AF */  sw         $s1, 0x4($sp)
    /* 3F6D8 8004EED8 21888000 */  addu       $s1, $a0, $zero
    /* 3F6DC 8004EEDC 2168A000 */  addu       $t5, $a1, $zero
    /* 3F6E0 8004EEE0 2170C000 */  addu       $t6, $a2, $zero
    /* 3F6E4 8004EEE4 1C00A387 */  lh         $v1, 0x1C($sp)
    /* 3F6E8 8004EEE8 21580000 */  addu       $t3, $zero, $zero
    /* 3F6EC 8004EEEC 2D006018 */  blez       $v1, .L8004EFA4
    /* 3F6F0 8004EEF0 0000B0AF */   sw        $s0, 0x0($sp)
    /* 3F6F4 8004EEF4 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* 3F6F8 8004EEF8 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* 3F6FC 8004EEFC 801F103C */  lui        $s0, (0x1F800000 >> 16)
    /* 3F700 8004EF00 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* 3F704 8004EF04 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* 3F708 8004EF08 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* 3F70C 8004EF0C 2A001924 */  addiu      $t9, $zero, 0x2A
    /* 3F710 8004EF10 05001824 */  addiu      $t8, $zero, 0x5
    /* 3F714 8004EF14 2138A701 */  addu       $a3, $t5, $a3
    /* 3F718 8004EF18 1800A28F */  lw         $v0, 0x18($sp)
    /* 3F71C 8004EF1C 21786000 */  addu       $t7, $v1, $zero
    /* 3F720 8004EF20 2148C201 */  addu       $t1, $t6, $v0
  .L8004EF24:
    /* 3F724 8004EF24 01006525 */  addiu      $a1, $t3, 0x1
    /* 3F728 8004EF28 2158A000 */  addu       $t3, $a1, $zero
    /* 3F72C 8004EF2C 002C0500 */  sll        $a1, $a1, 16
    /* 3F730 8004EF30 032C0500 */  sra        $a1, $a1, 16
    /* 3F734 8004EF34 2A28AF00 */  slt        $a1, $a1, $t7
    /* 3F738 8004EF38 0000448D */  lw         $a0, 0x0($t2)
    /* 3F73C 8004EF3C 0000068E */  lw         $a2, (0x1F800000 & 0xFFFF)($s0)
    /* 3F740 8004EF40 0000838C */  lw         $v1, 0x0($a0)
    /* 3F744 8004EF44 0000C28C */  lw         $v0, 0x0($a2)
    /* 3F748 8004EF48 24186C00 */  and        $v1, $v1, $t4
    /* 3F74C 8004EF4C 24104800 */  and        $v0, $v0, $t0
    /* 3F750 8004EF50 25186200 */  or         $v1, $v1, $v0
    /* 3F754 8004EF54 000083AC */  sw         $v1, 0x0($a0)
    /* 3F758 8004EF58 0000C38C */  lw         $v1, 0x0($a2)
    /* 3F75C 8004EF5C 18008224 */  addiu      $v0, $a0, 0x18
    /* 3F760 8004EF60 000042AD */  sw         $v0, 0x0($t2)
    /* 3F764 8004EF64 24108800 */  and        $v0, $a0, $t0
    /* 3F768 8004EF68 24186C00 */  and        $v1, $v1, $t4
    /* 3F76C 8004EF6C 25186200 */  or         $v1, $v1, $v0
    /* 3F770 8004EF70 0000C3AC */  sw         $v1, 0x0($a2)
    /* 3F774 8004EF74 040091AC */  sw         $s1, 0x4($a0)
    /* 3F778 8004EF78 070099A0 */  sb         $t9, 0x7($a0)
    /* 3F77C 8004EF7C 030098A0 */  sb         $t8, 0x3($a0)
    /* 3F780 8004EF80 08008DA4 */  sh         $t5, 0x8($a0)
    /* 3F784 8004EF84 0A008EA4 */  sh         $t6, 0xA($a0)
    /* 3F788 8004EF88 0C0087A4 */  sh         $a3, 0xC($a0)
    /* 3F78C 8004EF8C 0E008EA4 */  sh         $t6, 0xE($a0)
    /* 3F790 8004EF90 10008DA4 */  sh         $t5, 0x10($a0)
    /* 3F794 8004EF94 120089A4 */  sh         $t1, 0x12($a0)
    /* 3F798 8004EF98 140087A4 */  sh         $a3, 0x14($a0)
    /* 3F79C 8004EF9C E1FFA014 */  bnez       $a1, .L8004EF24
    /* 3F7A0 8004EFA0 160089A4 */   sh        $t1, 0x16($a0)
  .L8004EFA4:
    /* 3F7A4 8004EFA4 0400B18F */  lw         $s1, 0x4($sp)
    /* 3F7A8 8004EFA8 0000B08F */  lw         $s0, 0x0($sp)
    /* 3F7AC 8004EFAC 0800E003 */  jr         $ra
    /* 3F7B0 8004EFB0 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel PSXDrawTransSquare__Fiiiiis
