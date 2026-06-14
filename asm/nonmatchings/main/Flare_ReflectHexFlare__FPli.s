.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_ReflectHexFlare__FPli, 0x1D4

glabel Flare_ReflectHexFlare__FPli
    /* BD068 800CC868 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BD06C 800CC86C 21688000 */  addu       $t5, $a0, $zero
    /* BD070 800CC870 2170A000 */  addu       $t6, $a1, $zero
    /* BD074 800CC874 12800F3C */  lui        $t7, %hi(Flare_gReflectHex)
    /* BD078 800CC878 18FFEF25 */  addiu      $t7, $t7, %lo(Flare_gReflectHex)
    /* BD07C 800CC87C 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BD080 800CC880 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BD084 800CC884 00000000 */  nop
    /* BD088 800CC888 00000000 */  nop
    /* BD08C 800CC88C 0100184A */  .word 0x4A180001  /* rtps */
    /* BD090 800CC890 0000AEEB */  swc2       $14, 0x0($sp)
    /* BD094 800CC894 12800F3C */  lui        $t7, %hi(D_8011FF20)
    /* BD098 800CC898 20FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF20)
    /* BD09C 800CC89C 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BD0A0 800CC8A0 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BD0A4 800CC8A4 00000000 */  nop
    /* BD0A8 800CC8A8 00000000 */  nop
    /* BD0AC 800CC8AC 0100184A */  .word 0x4A180001  /* rtps */
    /* BD0B0 800CC8B0 0400A227 */  addiu      $v0, $sp, 0x4
    /* BD0B4 800CC8B4 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD0B8 800CC8B8 12800F3C */  lui        $t7, %hi(D_8011FF28)
    /* BD0BC 800CC8BC 28FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF28)
    /* BD0C0 800CC8C0 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BD0C4 800CC8C4 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BD0C8 800CC8C8 00000000 */  nop
    /* BD0CC 800CC8CC 00000000 */  nop
    /* BD0D0 800CC8D0 0100184A */  .word 0x4A180001  /* rtps */
    /* BD0D4 800CC8D4 0800A227 */  addiu      $v0, $sp, 0x8
    /* BD0D8 800CC8D8 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD0DC 800CC8DC 12800F3C */  lui        $t7, %hi(D_8011FF30)
    /* BD0E0 800CC8E0 30FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF30)
    /* BD0E4 800CC8E4 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BD0E8 800CC8E8 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BD0EC 800CC8EC 00000000 */  nop
    /* BD0F0 800CC8F0 00000000 */  nop
    /* BD0F4 800CC8F4 0100184A */  .word 0x4A180001  /* rtps */
    /* BD0F8 800CC8F8 0C00A227 */  addiu      $v0, $sp, 0xC
    /* BD0FC 800CC8FC 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD100 800CC900 12800F3C */  lui        $t7, %hi(D_8011FF38)
    /* BD104 800CC904 38FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF38)
    /* BD108 800CC908 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BD10C 800CC90C 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BD110 800CC910 00000000 */  nop
    /* BD114 800CC914 00000000 */  nop
    /* BD118 800CC918 0100184A */  .word 0x4A180001  /* rtps */
    /* BD11C 800CC91C 1000A227 */  addiu      $v0, $sp, 0x10
    /* BD120 800CC920 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD124 800CC924 12800F3C */  lui        $t7, %hi(D_8011FF40)
    /* BD128 800CC928 40FFEF25 */  addiu      $t7, $t7, %lo(D_8011FF40)
    /* BD12C 800CC92C 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BD130 800CC930 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BD134 800CC934 00000000 */  nop
    /* BD138 800CC938 00000000 */  nop
    /* BD13C 800CC93C 0100184A */  .word 0x4A180001  /* rtps */
    /* BD140 800CC940 1400A227 */  addiu      $v0, $sp, 0x14
    /* BD144 800CC944 00004EE8 */  swc2       $14, 0x0($v0)
    /* BD148 800CC948 06000924 */  addiu      $t1, $zero, 0x6
    /* BD14C 800CC94C FFFF0C24 */  addiu      $t4, $zero, -0x1
    /* BD150 800CC950 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BD154 800CC954 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BD158 800CC958 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BD15C 800CC95C FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BD160 800CC960 00FF0B3C */  lui        $t3, (0xFF000000 >> 16)
    /* BD164 800CC964 1280023C */  lui        $v0, %hi(gfHexPt1)
    /* BD168 800CC968 30FE4224 */  addiu      $v0, $v0, %lo(gfHexPt1)
    /* BD16C 800CC96C 0C004724 */  addiu      $a3, $v0, 0xC
    /* BD170 800CC970 1280023C */  lui        $v0, %hi(gfHexPt2)
    /* BD174 800CC974 3CFE4224 */  addiu      $v0, $v0, %lo(gfHexPt2)
    /* BD178 800CC978 0C004624 */  addiu      $a2, $v0, 0xC
  .L800CC97C:
    /* BD17C 800CC97C FEFFE724 */  addiu      $a3, $a3, -0x2
    /* BD180 800CC980 FFFF2925 */  addiu      $t1, $t1, -0x1
    /* BD184 800CC984 2B002C11 */  beq        $t1, $t4, .L800CCA34
    /* BD188 800CC988 FEFFC624 */   addiu     $a2, $a2, -0x2
    /* BD18C 800CC98C 80280E00 */  sll        $a1, $t6, 2
    /* BD190 800CC990 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BD194 800CC994 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BD198 800CC998 0000448D */  lw         $a0, 0x0($t2)
    /* BD19C 800CC99C 2128A200 */  addu       $a1, $a1, $v0
    /* BD1A0 800CC9A0 0000838C */  lw         $v1, 0x0($a0)
    /* BD1A4 800CC9A4 0000A28C */  lw         $v0, 0x0($a1)
    /* BD1A8 800CC9A8 24186B00 */  and        $v1, $v1, $t3
    /* BD1AC 800CC9AC 24104800 */  and        $v0, $v0, $t0
    /* BD1B0 800CC9B0 25186200 */  or         $v1, $v1, $v0
    /* BD1B4 800CC9B4 000083AC */  sw         $v1, 0x0($a0)
    /* BD1B8 800CC9B8 0000A38C */  lw         $v1, 0x0($a1)
    /* BD1BC 800CC9BC 1C008224 */  addiu      $v0, $a0, 0x1C
    /* BD1C0 800CC9C0 000042AD */  sw         $v0, 0x0($t2)
    /* BD1C4 800CC9C4 24108800 */  and        $v0, $a0, $t0
    /* BD1C8 800CC9C8 24186B00 */  and        $v1, $v1, $t3
    /* BD1CC 800CC9CC 25186200 */  or         $v1, $v1, $v0
    /* BD1D0 800CC9D0 0032023C */  lui        $v0, (0x32000000 >> 16)
    /* BD1D4 800CC9D4 0000A3AC */  sw         $v1, 0x0($a1)
    /* BD1D8 800CC9D8 040082AC */  sw         $v0, 0x4($a0)
    /* BD1DC 800CC9DC 2013838F */  lw         $v1, %gp_rel(gfrgb)($gp)
    /* BD1E0 800CC9E0 06000224 */  addiu      $v0, $zero, 0x6
    /* BD1E4 800CC9E4 140080AC */  sw         $zero, 0x14($a0)
    /* BD1E8 800CC9E8 030082A0 */  sb         $v0, 0x3($a0)
    /* BD1EC 800CC9EC 0C0083AC */  sw         $v1, 0xC($a0)
    /* BD1F0 800CC9F0 0000C284 */  lh         $v0, 0x0($a2)
    /* BD1F4 800CC9F4 00000000 */  nop
    /* BD1F8 800CC9F8 80100200 */  sll        $v0, $v0, 2
    /* BD1FC 800CC9FC 2110A203 */  addu       $v0, $sp, $v0
    /* BD200 800CCA00 0000428C */  lw         $v0, 0x0($v0)
    /* BD204 800CCA04 00000000 */  nop
    /* BD208 800CCA08 080082AC */  sw         $v0, 0x8($a0)
    /* BD20C 800CCA0C 0000A28D */  lw         $v0, 0x0($t5)
    /* BD210 800CCA10 00000000 */  nop
    /* BD214 800CCA14 100082AC */  sw         $v0, 0x10($a0)
    /* BD218 800CCA18 0000E284 */  lh         $v0, 0x0($a3)
    /* BD21C 800CCA1C 00000000 */  nop
    /* BD220 800CCA20 80100200 */  sll        $v0, $v0, 2
    /* BD224 800CCA24 2110A203 */  addu       $v0, $sp, $v0
    /* BD228 800CCA28 0000428C */  lw         $v0, 0x0($v0)
    /* BD22C 800CCA2C 5F320308 */  j          .L800CC97C
    /* BD230 800CCA30 180082AC */   sw        $v0, 0x18($a0)
  .L800CCA34:
    /* BD234 800CCA34 0800E003 */  jr         $ra
    /* BD238 800CCA38 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Flare_ReflectHexFlare__FPli
