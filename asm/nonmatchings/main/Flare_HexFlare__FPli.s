.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_HexFlare__FPli, 0x1D4

glabel Flare_HexFlare__FPli
    /* BCE94 800CC694 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BCE98 800CC698 21688000 */  addu       $t5, $a0, $zero
    /* BCE9C 800CC69C 2170A000 */  addu       $t6, $a1, $zero
    /* BCEA0 800CC6A0 12800F3C */  lui        $t7, %hi(Flare_gHex)
    /* BCEA4 800CC6A4 E8FEEF25 */  addiu      $t7, $t7, %lo(Flare_gHex)
    /* BCEA8 800CC6A8 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCEAC 800CC6AC 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCEB0 800CC6B0 00000000 */  nop
    /* BCEB4 800CC6B4 00000000 */  nop
    /* BCEB8 800CC6B8 0100184A */  .word 0x4A180001  /* rtps */
    /* BCEBC 800CC6BC 0000AEEB */  swc2       $14, 0x0($sp)
    /* BCEC0 800CC6C0 12800F3C */  lui        $t7, %hi(D_8011FEF0)
    /* BCEC4 800CC6C4 F0FEEF25 */  addiu      $t7, $t7, %lo(D_8011FEF0)
    /* BCEC8 800CC6C8 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCECC 800CC6CC 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCED0 800CC6D0 00000000 */  nop
    /* BCED4 800CC6D4 00000000 */  nop
    /* BCED8 800CC6D8 0100184A */  .word 0x4A180001  /* rtps */
    /* BCEDC 800CC6DC 0400A227 */  addiu      $v0, $sp, 0x4
    /* BCEE0 800CC6E0 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCEE4 800CC6E4 12800F3C */  lui        $t7, %hi(D_8011FEF8)
    /* BCEE8 800CC6E8 F8FEEF25 */  addiu      $t7, $t7, %lo(D_8011FEF8)
    /* BCEEC 800CC6EC 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCEF0 800CC6F0 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCEF4 800CC6F4 00000000 */  nop
    /* BCEF8 800CC6F8 00000000 */  nop
    /* BCEFC 800CC6FC 0100184A */  .word 0x4A180001  /* rtps */
    /* BCF00 800CC700 0800A227 */  addiu      $v0, $sp, 0x8
    /* BCF04 800CC704 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCF08 800CC708 12800F3C */  lui        $t7, %hi(D_8011FF00)
    /* BCF0C 800CC70C 00FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF00)
    /* BCF10 800CC710 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCF14 800CC714 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCF18 800CC718 00000000 */  nop
    /* BCF1C 800CC71C 00000000 */  nop
    /* BCF20 800CC720 0100184A */  .word 0x4A180001  /* rtps */
    /* BCF24 800CC724 0C00A227 */  addiu      $v0, $sp, 0xC
    /* BCF28 800CC728 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCF2C 800CC72C 12800F3C */  lui        $t7, %hi(D_8011FF08)
    /* BCF30 800CC730 08FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF08)
    /* BCF34 800CC734 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCF38 800CC738 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCF3C 800CC73C 00000000 */  nop
    /* BCF40 800CC740 00000000 */  nop
    /* BCF44 800CC744 0100184A */  .word 0x4A180001  /* rtps */
    /* BCF48 800CC748 1000A227 */  addiu      $v0, $sp, 0x10
    /* BCF4C 800CC74C 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCF50 800CC750 12800F3C */  lui        $t7, %hi(D_8011FF10)
    /* BCF54 800CC754 10FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF10)
    /* BCF58 800CC758 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCF5C 800CC75C 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCF60 800CC760 00000000 */  nop
    /* BCF64 800CC764 00000000 */  nop
    /* BCF68 800CC768 0100184A */  .word 0x4A180001  /* rtps */
    /* BCF6C 800CC76C 1400A227 */  addiu      $v0, $sp, 0x14
    /* BCF70 800CC770 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCF74 800CC774 06000924 */  addiu      $t1, $zero, 0x6
    /* BCF78 800CC778 FFFF0C24 */  addiu      $t4, $zero, -0x1
    /* BCF7C 800CC77C 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BCF80 800CC780 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BCF84 800CC784 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BCF88 800CC788 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BCF8C 800CC78C 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* BCF90 800CC790 1280023C */  lui        $v0, %hi(gfHexPt1)
    /* BCF94 800CC794 30FE4224 */  addiu      $v0, $v0, %lo(gfHexPt1)
    /* BCF98 800CC798 0C004724 */  addiu      $a3, $v0, 0xC
    /* BCF9C 800CC79C 1280023C */  lui        $v0, %hi(gfHexPt2)
    /* BCFA0 800CC7A0 3CFE4224 */  addiu      $v0, $v0, %lo(gfHexPt2)
    /* BCFA4 800CC7A4 0C004624 */  addiu      $a2, $v0, 0xC
  .L800CC7A8:
    /* BCFA8 800CC7A8 FEFFE724 */  addiu      $a3, $a3, -0x2
    /* BCFAC 800CC7AC FFFF2925 */  addiu      $t1, $t1, -0x1
    /* BCFB0 800CC7B0 2B002C11 */  beq        $t1, $t4, .L800CC860
    /* BCFB4 800CC7B4 FEFFC624 */   addiu     $a2, $a2, -0x2
    /* BCFB8 800CC7B8 80280E00 */  sll        $a1, $t6, 2
    /* BCFBC 800CC7BC 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BCFC0 800CC7C0 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BCFC4 800CC7C4 0000448D */  lw         $a0, 0x0($t2)
    /* BCFC8 800CC7C8 2128A200 */  addu       $a1, $a1, $v0
    /* BCFCC 800CC7CC 0000838C */  lw         $v1, 0x0($a0)
    /* BCFD0 800CC7D0 0000A28C */  lw         $v0, 0x0($a1)
    /* BCFD4 800CC7D4 24186B00 */  and        $v1, $v1, $t3
    /* BCFD8 800CC7D8 24104800 */  and        $v0, $v0, $t0
    /* BCFDC 800CC7DC 25186200 */  or         $v1, $v1, $v0
    /* BCFE0 800CC7E0 000083AC */  sw         $v1, 0x0($a0)
    /* BCFE4 800CC7E4 0000A38C */  lw         $v1, 0x0($a1)
    /* BCFE8 800CC7E8 1C008224 */  addiu      $v0, $a0, 0x1C
    /* BCFEC 800CC7EC 000042AD */  sw         $v0, 0x0($t2)
    /* BCFF0 800CC7F0 24108800 */  and        $v0, $a0, $t0
    /* BCFF4 800CC7F4 24186B00 */  and        $v1, $v1, $t3
    /* BCFF8 800CC7F8 25186200 */  or         $v1, $v1, $v0
    /* BCFFC 800CC7FC 0032023C */  lui        $v0, (0x32000000 >> 16)
    /* BD000 800CC800 0000A3AC */  sw         $v1, 0x0($a1)
    /* BD004 800CC804 040082AC */  sw         $v0, 0x4($a0)
    /* BD008 800CC808 2013838F */  lw         $v1, %gp_rel(gfrgb)($gp)
    /* BD00C 800CC80C 06000224 */  addiu      $v0, $zero, 0x6
    /* BD010 800CC810 140080AC */  sw         $zero, 0x14($a0)
    /* BD014 800CC814 030082A0 */  sb         $v0, 0x3($a0)
    /* BD018 800CC818 0C0083AC */  sw         $v1, 0xC($a0)
    /* BD01C 800CC81C 0000C284 */  lh         $v0, 0x0($a2)
    /* BD020 800CC820 00000000 */  nop
    /* BD024 800CC824 80100200 */  sll        $v0, $v0, 2
    /* BD028 800CC828 2110A203 */  addu       $v0, $sp, $v0
    /* BD02C 800CC82C 0000428C */  lw         $v0, 0x0($v0)
    /* BD030 800CC830 00000000 */  nop
    /* BD034 800CC834 080082AC */  sw         $v0, 0x8($a0)
    /* BD038 800CC838 0000A28D */  lw         $v0, 0x0($t5)
    /* BD03C 800CC83C 00000000 */  nop
    /* BD040 800CC840 100082AC */  sw         $v0, 0x10($a0)
    /* BD044 800CC844 0000E284 */  lh         $v0, 0x0($a3)
    /* BD048 800CC848 00000000 */  nop
    /* BD04C 800CC84C 80100200 */  sll        $v0, $v0, 2
    /* BD050 800CC850 2110A203 */  addu       $v0, $sp, $v0
    /* BD054 800CC854 0000428C */  lw         $v0, 0x0($v0)
    /* BD058 800CC858 EA310308 */  j          .L800CC7A8
    /* BD05C 800CC85C 180082AC */   sw        $v0, 0x18($a0)
  .L800CC860:
    /* BD060 800CC860 0800E003 */  jr         $ra
    /* BD064 800CC864 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Flare_HexFlare__FPli
