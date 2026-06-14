.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_OctFlare__FPli, 0x220

glabel Flare_OctFlare__FPli
    /* BC614 800CBE14 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* BC618 800CBE18 21708000 */  addu       $t6, $a0, $zero
    /* BC61C 800CBE1C 2178A000 */  addu       $t7, $a1, $zero
    /* BC620 800CBE20 20138C8F */  lw         $t4, %gp_rel(gfrgb)($gp)
    /* BC624 800CBE24 1280183C */  lui        $t8, %hi(Flare_gOct)
    /* BC628 800CBE28 68FE1827 */  addiu      $t8, $t8, %lo(Flare_gOct)
    /* BC62C 800CBE2C 000000CB */  lwc2       $0, 0x0($t8)
    /* BC630 800CBE30 040001CB */  lwc2       $1, 0x4($t8)
    /* BC634 800CBE34 00000000 */  nop
    /* BC638 800CBE38 00000000 */  nop
    /* BC63C 800CBE3C 0100184A */  .word 0x4A180001  /* rtps */
    /* BC640 800CBE40 1000A227 */  addiu      $v0, $sp, 0x10
    /* BC644 800CBE44 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC648 800CBE48 1280183C */  lui        $t8, %hi(D_8011FE70)
    /* BC64C 800CBE4C 70FE1827 */  addiu      $t8, $t8, %lo(D_8011FE70)
    /* BC650 800CBE50 000000CB */  lwc2       $0, 0x0($t8)
    /* BC654 800CBE54 040001CB */  lwc2       $1, 0x4($t8)
    /* BC658 800CBE58 00000000 */  nop
    /* BC65C 800CBE5C 00000000 */  nop
    /* BC660 800CBE60 0100184A */  .word 0x4A180001  /* rtps */
    /* BC664 800CBE64 1400A227 */  addiu      $v0, $sp, 0x14
    /* BC668 800CBE68 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC66C 800CBE6C 1280183C */  lui        $t8, %hi(D_8011FE78)
    /* BC670 800CBE70 78FE1827 */  addiu      $t8, $t8, %lo(D_8011FE78)
    /* BC674 800CBE74 000000CB */  lwc2       $0, 0x0($t8)
    /* BC678 800CBE78 040001CB */  lwc2       $1, 0x4($t8)
    /* BC67C 800CBE7C 00000000 */  nop
    /* BC680 800CBE80 00000000 */  nop
    /* BC684 800CBE84 0100184A */  .word 0x4A180001  /* rtps */
    /* BC688 800CBE88 1800A227 */  addiu      $v0, $sp, 0x18
    /* BC68C 800CBE8C 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC690 800CBE90 1280183C */  lui        $t8, %hi(D_8011FE80)
    /* BC694 800CBE94 80FE1827 */  addiu      $t8, $t8, %lo(D_8011FE80)
    /* BC698 800CBE98 000000CB */  lwc2       $0, 0x0($t8)
    /* BC69C 800CBE9C 040001CB */  lwc2       $1, 0x4($t8)
    /* BC6A0 800CBEA0 00000000 */  nop
    /* BC6A4 800CBEA4 00000000 */  nop
    /* BC6A8 800CBEA8 0100184A */  .word 0x4A180001  /* rtps */
    /* BC6AC 800CBEAC 1C00A227 */  addiu      $v0, $sp, 0x1C
    /* BC6B0 800CBEB0 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC6B4 800CBEB4 1280183C */  lui        $t8, %hi(D_8011FE88)
    /* BC6B8 800CBEB8 88FE1827 */  addiu      $t8, $t8, %lo(D_8011FE88)
    /* BC6BC 800CBEBC 000000CB */  lwc2       $0, 0x0($t8)
    /* BC6C0 800CBEC0 040001CB */  lwc2       $1, 0x4($t8)
    /* BC6C4 800CBEC4 00000000 */  nop
    /* BC6C8 800CBEC8 00000000 */  nop
    /* BC6CC 800CBECC 0100184A */  .word 0x4A180001  /* rtps */
    /* BC6D0 800CBED0 2000A227 */  addiu      $v0, $sp, 0x20
    /* BC6D4 800CBED4 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC6D8 800CBED8 1280183C */  lui        $t8, %hi(D_8011FE90)
    /* BC6DC 800CBEDC 90FE1827 */  addiu      $t8, $t8, %lo(D_8011FE90)
    /* BC6E0 800CBEE0 000000CB */  lwc2       $0, 0x0($t8)
    /* BC6E4 800CBEE4 040001CB */  lwc2       $1, 0x4($t8)
    /* BC6E8 800CBEE8 00000000 */  nop
    /* BC6EC 800CBEEC 00000000 */  nop
    /* BC6F0 800CBEF0 0100184A */  .word 0x4A180001  /* rtps */
    /* BC6F4 800CBEF4 2400A227 */  addiu      $v0, $sp, 0x24
    /* BC6F8 800CBEF8 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC6FC 800CBEFC 1280183C */  lui        $t8, %hi(D_8011FE98)
    /* BC700 800CBF00 98FE1827 */  addiu      $t8, $t8, %lo(D_8011FE98)
    /* BC704 800CBF04 000000CB */  lwc2       $0, 0x0($t8)
    /* BC708 800CBF08 040001CB */  lwc2       $1, 0x4($t8)
    /* BC70C 800CBF0C 00000000 */  nop
    /* BC710 800CBF10 00000000 */  nop
    /* BC714 800CBF14 0100184A */  .word 0x4A180001  /* rtps */
    /* BC718 800CBF18 2800A227 */  addiu      $v0, $sp, 0x28
    /* BC71C 800CBF1C 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC720 800CBF20 1280183C */  lui        $t8, %hi(D_8011FEA0)
    /* BC724 800CBF24 A0FE1827 */  addiu      $t8, $t8, %lo(D_8011FEA0)
    /* BC728 800CBF28 000000CB */  lwc2       $0, 0x0($t8)
    /* BC72C 800CBF2C 040001CB */  lwc2       $1, 0x4($t8)
    /* BC730 800CBF30 00000000 */  nop
    /* BC734 800CBF34 00000000 */  nop
    /* BC738 800CBF38 0100184A */  .word 0x4A180001  /* rtps */
    /* BC73C 800CBF3C 2C00A227 */  addiu      $v0, $sp, 0x2C
    /* BC740 800CBF40 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC744 800CBF44 08000924 */  addiu      $t1, $zero, 0x8
    /* BC748 800CBF48 FFFF0D24 */  addiu      $t5, $zero, -0x1
    /* BC74C 800CBF4C 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BC750 800CBF50 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BC754 800CBF54 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BC758 800CBF58 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BC75C 800CBF5C 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* BC760 800CBF60 1280023C */  lui        $v0, %hi(gfOctPt1)
    /* BC764 800CBF64 10FE4224 */  addiu      $v0, $v0, %lo(gfOctPt1)
    /* BC768 800CBF68 10004724 */  addiu      $a3, $v0, 0x10
    /* BC76C 800CBF6C 1280023C */  lui        $v0, %hi(gfOctPt2)
    /* BC770 800CBF70 20FE4224 */  addiu      $v0, $v0, %lo(gfOctPt2)
    /* BC774 800CBF74 10004624 */  addiu      $a2, $v0, 0x10
  .L800CBF78:
    /* BC778 800CBF78 FEFFE724 */  addiu      $a3, $a3, -0x2
    /* BC77C 800CBF7C FFFF2925 */  addiu      $t1, $t1, -0x1
    /* BC780 800CBF80 2A002D11 */  beq        $t1, $t5, .L800CC02C
    /* BC784 800CBF84 FEFFC624 */   addiu     $a2, $a2, -0x2
    /* BC788 800CBF88 80280F00 */  sll        $a1, $t7, 2
    /* BC78C 800CBF8C 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BC790 800CBF90 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BC794 800CBF94 0000448D */  lw         $a0, 0x0($t2)
    /* BC798 800CBF98 2128A200 */  addu       $a1, $a1, $v0
    /* BC79C 800CBF9C 0000838C */  lw         $v1, 0x0($a0)
    /* BC7A0 800CBFA0 0000A28C */  lw         $v0, 0x0($a1)
    /* BC7A4 800CBFA4 24186B00 */  and        $v1, $v1, $t3
    /* BC7A8 800CBFA8 24104800 */  and        $v0, $v0, $t0
    /* BC7AC 800CBFAC 25186200 */  or         $v1, $v1, $v0
    /* BC7B0 800CBFB0 000083AC */  sw         $v1, 0x0($a0)
    /* BC7B4 800CBFB4 0000A38C */  lw         $v1, 0x0($a1)
    /* BC7B8 800CBFB8 1C008224 */  addiu      $v0, $a0, 0x1C
    /* BC7BC 800CBFBC 000042AD */  sw         $v0, 0x0($t2)
    /* BC7C0 800CBFC0 24108800 */  and        $v0, $a0, $t0
    /* BC7C4 800CBFC4 24186B00 */  and        $v1, $v1, $t3
    /* BC7C8 800CBFC8 25186200 */  or         $v1, $v1, $v0
    /* BC7CC 800CBFCC 0032023C */  lui        $v0, (0x32000000 >> 16)
    /* BC7D0 800CBFD0 0000A3AC */  sw         $v1, 0x0($a1)
    /* BC7D4 800CBFD4 040082AC */  sw         $v0, 0x4($a0)
    /* BC7D8 800CBFD8 06000224 */  addiu      $v0, $zero, 0x6
    /* BC7DC 800CBFDC 0C008CAC */  sw         $t4, 0xC($a0)
    /* BC7E0 800CBFE0 140080AC */  sw         $zero, 0x14($a0)
    /* BC7E4 800CBFE4 030082A0 */  sb         $v0, 0x3($a0)
    /* BC7E8 800CBFE8 0000C284 */  lh         $v0, 0x0($a2)
    /* BC7EC 800CBFEC 00000000 */  nop
    /* BC7F0 800CBFF0 80100200 */  sll        $v0, $v0, 2
    /* BC7F4 800CBFF4 2110A203 */  addu       $v0, $sp, $v0
    /* BC7F8 800CBFF8 0000428C */  lw         $v0, 0x0($v0)
    /* BC7FC 800CBFFC 00000000 */  nop
    /* BC800 800CC000 080082AC */  sw         $v0, 0x8($a0)
    /* BC804 800CC004 0000C28D */  lw         $v0, 0x0($t6)
    /* BC808 800CC008 00000000 */  nop
    /* BC80C 800CC00C 100082AC */  sw         $v0, 0x10($a0)
    /* BC810 800CC010 0000E284 */  lh         $v0, 0x0($a3)
    /* BC814 800CC014 00000000 */  nop
    /* BC818 800CC018 80100200 */  sll        $v0, $v0, 2
    /* BC81C 800CC01C 2110A203 */  addu       $v0, $sp, $v0
    /* BC820 800CC020 0000428C */  lw         $v0, 0x0($v0)
    /* BC824 800CC024 DE2F0308 */  j          .L800CBF78
    /* BC828 800CC028 180082AC */   sw        $v0, 0x18($a0)
  .L800CC02C:
    /* BC82C 800CC02C 0800E003 */  jr         $ra
    /* BC830 800CC030 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Flare_OctFlare__FPli
