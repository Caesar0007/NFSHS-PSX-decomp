.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_OctFlareSpikes__FPli, 0x384

glabel Flare_OctFlareSpikes__FPli
    /* BC834 800CC034 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* BC838 800CC038 4400B3AF */  sw         $s3, 0x44($sp)
    /* BC83C 800CC03C 1280133C */  lui        $s3, %hi(Flare_gSpikes)
    /* BC840 800CC040 48FE7326 */  addiu      $s3, $s3, %lo(Flare_gSpikes)
    /* BC844 800CC044 4000B2AF */  sw         $s2, 0x40($sp)
    /* BC848 800CC048 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* BC84C 800CC04C 3800B0AF */  sw         $s0, 0x38($sp)
    /* BC850 800CC050 000060CA */  lwc2       $0, 0x0($s3)
    /* BC854 800CC054 040061CA */  lwc2       $1, 0x4($s3)
    /* BC858 800CC058 00000000 */  nop
    /* BC85C 800CC05C 00000000 */  nop
    /* BC860 800CC060 0100184A */  .word 0x4A180001  /* rtps */
    /* BC864 800CC064 0000AEEB */  swc2       $14, 0x0($sp)
    /* BC868 800CC068 1280133C */  lui        $s3, %hi(D_8011FE50)
    /* BC86C 800CC06C 50FE7326 */  addiu      $s3, $s3, %lo(D_8011FE50)
    /* BC870 800CC070 000060CA */  lwc2       $0, 0x0($s3)
    /* BC874 800CC074 040061CA */  lwc2       $1, 0x4($s3)
    /* BC878 800CC078 00000000 */  nop
    /* BC87C 800CC07C 00000000 */  nop
    /* BC880 800CC080 0100184A */  .word 0x4A180001  /* rtps */
    /* BC884 800CC084 0400A227 */  addiu      $v0, $sp, 0x4
    /* BC888 800CC088 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC88C 800CC08C 1280133C */  lui        $s3, %hi(D_8011FE58)
    /* BC890 800CC090 58FE7326 */  addiu      $s3, $s3, %lo(D_8011FE58)
    /* BC894 800CC094 000060CA */  lwc2       $0, 0x0($s3)
    /* BC898 800CC098 040061CA */  lwc2       $1, 0x4($s3)
    /* BC89C 800CC09C 00000000 */  nop
    /* BC8A0 800CC0A0 00000000 */  nop
    /* BC8A4 800CC0A4 0100184A */  .word 0x4A180001  /* rtps */
    /* BC8A8 800CC0A8 0800A227 */  addiu      $v0, $sp, 0x8
    /* BC8AC 800CC0AC 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC8B0 800CC0B0 1280133C */  lui        $s3, %hi(D_8011FE60)
    /* BC8B4 800CC0B4 60FE7326 */  addiu      $s3, $s3, %lo(D_8011FE60)
    /* BC8B8 800CC0B8 000060CA */  lwc2       $0, 0x0($s3)
    /* BC8BC 800CC0BC 040061CA */  lwc2       $1, 0x4($s3)
    /* BC8C0 800CC0C0 00000000 */  nop
    /* BC8C4 800CC0C4 00000000 */  nop
    /* BC8C8 800CC0C8 0100184A */  .word 0x4A180001  /* rtps */
    /* BC8CC 800CC0CC 0C00A227 */  addiu      $v0, $sp, 0xC
    /* BC8D0 800CC0D0 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC8D4 800CC0D4 1280133C */  lui        $s3, %hi(Flare_gOct)
    /* BC8D8 800CC0D8 68FE7326 */  addiu      $s3, $s3, %lo(Flare_gOct)
    /* BC8DC 800CC0DC 000060CA */  lwc2       $0, 0x0($s3)
    /* BC8E0 800CC0E0 040061CA */  lwc2       $1, 0x4($s3)
    /* BC8E4 800CC0E4 00000000 */  nop
    /* BC8E8 800CC0E8 00000000 */  nop
    /* BC8EC 800CC0EC 0100184A */  .word 0x4A180001  /* rtps */
    /* BC8F0 800CC0F0 1000A227 */  addiu      $v0, $sp, 0x10
    /* BC8F4 800CC0F4 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC8F8 800CC0F8 1280133C */  lui        $s3, %hi(D_8011FE70)
    /* BC8FC 800CC0FC 70FE7326 */  addiu      $s3, $s3, %lo(D_8011FE70)
    /* BC900 800CC100 000060CA */  lwc2       $0, 0x0($s3)
    /* BC904 800CC104 040061CA */  lwc2       $1, 0x4($s3)
    /* BC908 800CC108 00000000 */  nop
    /* BC90C 800CC10C 00000000 */  nop
    /* BC910 800CC110 0100184A */  .word 0x4A180001  /* rtps */
    /* BC914 800CC114 1400A227 */  addiu      $v0, $sp, 0x14
    /* BC918 800CC118 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC91C 800CC11C 1280133C */  lui        $s3, %hi(D_8011FE78)
    /* BC920 800CC120 78FE7326 */  addiu      $s3, $s3, %lo(D_8011FE78)
    /* BC924 800CC124 000060CA */  lwc2       $0, 0x0($s3)
    /* BC928 800CC128 040061CA */  lwc2       $1, 0x4($s3)
    /* BC92C 800CC12C 00000000 */  nop
    /* BC930 800CC130 00000000 */  nop
    /* BC934 800CC134 0100184A */  .word 0x4A180001  /* rtps */
    /* BC938 800CC138 1800A227 */  addiu      $v0, $sp, 0x18
    /* BC93C 800CC13C 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC940 800CC140 1280133C */  lui        $s3, %hi(D_8011FE80)
    /* BC944 800CC144 80FE7326 */  addiu      $s3, $s3, %lo(D_8011FE80)
    /* BC948 800CC148 000060CA */  lwc2       $0, 0x0($s3)
    /* BC94C 800CC14C 040061CA */  lwc2       $1, 0x4($s3)
    /* BC950 800CC150 00000000 */  nop
    /* BC954 800CC154 00000000 */  nop
    /* BC958 800CC158 0100184A */  .word 0x4A180001  /* rtps */
    /* BC95C 800CC15C 1C00A227 */  addiu      $v0, $sp, 0x1C
    /* BC960 800CC160 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC964 800CC164 1280133C */  lui        $s3, %hi(D_8011FE88)
    /* BC968 800CC168 88FE7326 */  addiu      $s3, $s3, %lo(D_8011FE88)
    /* BC96C 800CC16C 000060CA */  lwc2       $0, 0x0($s3)
    /* BC970 800CC170 040061CA */  lwc2       $1, 0x4($s3)
    /* BC974 800CC174 00000000 */  nop
    /* BC978 800CC178 00000000 */  nop
    /* BC97C 800CC17C 0100184A */  .word 0x4A180001  /* rtps */
    /* BC980 800CC180 2000A227 */  addiu      $v0, $sp, 0x20
    /* BC984 800CC184 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC988 800CC188 1280133C */  lui        $s3, %hi(D_8011FE90)
    /* BC98C 800CC18C 90FE7326 */  addiu      $s3, $s3, %lo(D_8011FE90)
    /* BC990 800CC190 000060CA */  lwc2       $0, 0x0($s3)
    /* BC994 800CC194 040061CA */  lwc2       $1, 0x4($s3)
    /* BC998 800CC198 00000000 */  nop
    /* BC99C 800CC19C 00000000 */  nop
    /* BC9A0 800CC1A0 0100184A */  .word 0x4A180001  /* rtps */
    /* BC9A4 800CC1A4 2400A227 */  addiu      $v0, $sp, 0x24
    /* BC9A8 800CC1A8 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC9AC 800CC1AC 1280133C */  lui        $s3, %hi(D_8011FE98)
    /* BC9B0 800CC1B0 98FE7326 */  addiu      $s3, $s3, %lo(D_8011FE98)
    /* BC9B4 800CC1B4 000060CA */  lwc2       $0, 0x0($s3)
    /* BC9B8 800CC1B8 040061CA */  lwc2       $1, 0x4($s3)
    /* BC9BC 800CC1BC 00000000 */  nop
    /* BC9C0 800CC1C0 00000000 */  nop
    /* BC9C4 800CC1C4 0100184A */  .word 0x4A180001  /* rtps */
    /* BC9C8 800CC1C8 2800A227 */  addiu      $v0, $sp, 0x28
    /* BC9CC 800CC1CC 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC9D0 800CC1D0 1280133C */  lui        $s3, %hi(D_8011FEA0)
    /* BC9D4 800CC1D4 A0FE7326 */  addiu      $s3, $s3, %lo(D_8011FEA0)
    /* BC9D8 800CC1D8 000060CA */  lwc2       $0, 0x0($s3)
    /* BC9DC 800CC1DC 040061CA */  lwc2       $1, 0x4($s3)
    /* BC9E0 800CC1E0 00000000 */  nop
    /* BC9E4 800CC1E4 00000000 */  nop
    /* BC9E8 800CC1E8 0100184A */  .word 0x4A180001  /* rtps */
    /* BC9EC 800CC1EC 2C00A227 */  addiu      $v0, $sp, 0x2C
    /* BC9F0 800CC1F0 00004EE8 */  swc2       $14, 0x0($v0)
    /* BC9F4 800CC1F4 08000B24 */  addiu      $t3, $zero, 0x8
    /* BC9F8 800CC1F8 801F0A3C */  lui        $t2, (0x1F800004 >> 16)
    /* BC9FC 800CC1FC 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* BCA00 800CC200 801F103C */  lui        $s0, (0x1F800000 >> 16)
    /* BCA04 800CC204 80C80500 */  sll        $t9, $a1, 2
    /* BCA08 800CC208 FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* BCA0C 800CC20C FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* BCA10 800CC210 00FF0F3C */  lui        $t7, (0xFF000000 >> 16)
    /* BCA14 800CC214 1280023C */  lui        $v0, %hi(gfSpikePt2)
    /* BCA18 800CC218 00FE4224 */  addiu      $v0, $v0, %lo(gfSpikePt2)
    /* BCA1C 800CC21C 10004E24 */  addiu      $t6, $v0, 0x10
    /* BCA20 800CC220 1280023C */  lui        $v0, %hi(gfSpikePt1)
    /* BCA24 800CC224 F0FD4224 */  addiu      $v0, $v0, %lo(gfSpikePt1)
    /* BCA28 800CC228 10004D24 */  addiu      $t5, $v0, 0x10
    /* BCA2C 800CC22C 1280023C */  lui        $v0, %hi(gfSpikePt0)
    /* BCA30 800CC230 E0FD4224 */  addiu      $v0, $v0, %lo(gfSpikePt0)
    /* BCA34 800CC234 10004C24 */  addiu      $t4, $v0, 0x10
    /* BCA38 800CC238 2013928F */  lw         $s2, %gp_rel(gfrgb)($gp)
    /* BCA3C 800CC23C 2413918F */  lw         $s1, %gp_rel(gfrgb2)($gp)
    /* BCA40 800CC240 0000988C */  lw         $t8, 0x0($a0)
  .L800CC244:
    /* BCA44 800CC244 FEFFCE25 */  addiu      $t6, $t6, -0x2
    /* BCA48 800CC248 FEFFAD25 */  addiu      $t5, $t5, -0x2
    /* BCA4C 800CC24C FFFF6B25 */  addiu      $t3, $t3, -0x1
    /* BCA50 800CC250 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* BCA54 800CC254 52006211 */  beq        $t3, $v0, .L800CC3A0
    /* BCA58 800CC258 FEFF8C25 */   addiu     $t4, $t4, -0x2
    /* BCA5C 800CC25C 00008785 */  lh         $a3, 0x0($t4)
    /* BCA60 800CC260 0000A985 */  lh         $t1, 0x0($t5)
    /* BCA64 800CC264 0000058E */  lw         $a1, (0x1F800000 & 0xFFFF)($s0)
    /* BCA68 800CC268 0000448D */  lw         $a0, 0x0($t2)
    /* BCA6C 800CC26C 0000C685 */  lh         $a2, 0x0($t6)
    /* BCA70 800CC270 21282503 */  addu       $a1, $t9, $a1
    /* BCA74 800CC274 0000828C */  lw         $v0, 0x0($a0)
    /* BCA78 800CC278 0000A38C */  lw         $v1, 0x0($a1)
    /* BCA7C 800CC27C 24104F00 */  and        $v0, $v0, $t7
    /* BCA80 800CC280 24186800 */  and        $v1, $v1, $t0
    /* BCA84 800CC284 25104300 */  or         $v0, $v0, $v1
    /* BCA88 800CC288 000082AC */  sw         $v0, 0x0($a0)
    /* BCA8C 800CC28C 0000A38C */  lw         $v1, 0x0($a1)
    /* BCA90 800CC290 24008224 */  addiu      $v0, $a0, 0x24
    /* BCA94 800CC294 000042AD */  sw         $v0, 0x0($t2)
    /* BCA98 800CC298 24108800 */  and        $v0, $a0, $t0
    /* BCA9C 800CC29C 24186F00 */  and        $v1, $v1, $t7
    /* BCAA0 800CC2A0 25186200 */  or         $v1, $v1, $v0
    /* BCAA4 800CC2A4 003A023C */  lui        $v0, (0x3A000000 >> 16)
    /* BCAA8 800CC2A8 0000A3AC */  sw         $v1, 0x0($a1)
    /* BCAAC 800CC2AC 040082AC */  sw         $v0, 0x4($a0)
    /* BCAB0 800CC2B0 08000224 */  addiu      $v0, $zero, 0x8
    /* BCAB4 800CC2B4 030082A0 */  sb         $v0, 0x3($a0)
    /* BCAB8 800CC2B8 80100700 */  sll        $v0, $a3, 2
    /* BCABC 800CC2BC 2110A203 */  addu       $v0, $sp, $v0
    /* BCAC0 800CC2C0 0C0091AC */  sw         $s1, 0xC($a0)
    /* BCAC4 800CC2C4 140080AC */  sw         $zero, 0x14($a0)
    /* BCAC8 800CC2C8 1C0080AC */  sw         $zero, 0x1C($a0)
    /* BCACC 800CC2CC 0000428C */  lw         $v0, 0x0($v0)
    /* BCAD0 800CC2D0 80300600 */  sll        $a2, $a2, 2
    /* BCAD4 800CC2D4 100098AC */  sw         $t8, 0x10($a0)
    /* BCAD8 800CC2D8 080082AC */  sw         $v0, 0x8($a0)
    /* BCADC 800CC2DC 2110A603 */  addu       $v0, $sp, $a2
    /* BCAE0 800CC2E0 0000428C */  lw         $v0, 0x0($v0)
    /* BCAE4 800CC2E4 00000000 */  nop
    /* BCAE8 800CC2E8 180082AC */  sw         $v0, 0x18($a0)
    /* BCAEC 800CC2EC 80100900 */  sll        $v0, $t1, 2
    /* BCAF0 800CC2F0 2110A203 */  addu       $v0, $sp, $v0
    /* BCAF4 800CC2F4 0000428C */  lw         $v0, 0x0($v0)
    /* BCAF8 800CC2F8 40180B00 */  sll        $v1, $t3, 1
    /* BCAFC 800CC2FC 200082AC */  sw         $v0, 0x20($a0)
    /* BCB00 800CC300 1280023C */  lui        $v0, %hi(gfOctPt1)
    /* BCB04 800CC304 10FE4224 */  addiu      $v0, $v0, %lo(gfOctPt1)
    /* BCB08 800CC308 21106200 */  addu       $v0, $v1, $v0
    /* BCB0C 800CC30C 00004784 */  lh         $a3, 0x0($v0)
    /* BCB10 800CC310 1280023C */  lui        $v0, %hi(gfOctPt2)
    /* BCB14 800CC314 20FE4224 */  addiu      $v0, $v0, %lo(gfOctPt2)
    /* BCB18 800CC318 21186200 */  addu       $v1, $v1, $v0
    /* BCB1C 800CC31C 00006984 */  lh         $t1, 0x0($v1)
    /* BCB20 800CC320 0000058E */  lw         $a1, (0x1F800000 & 0xFFFF)($s0)
    /* BCB24 800CC324 0000448D */  lw         $a0, 0x0($t2)
    /* BCB28 800CC328 21282503 */  addu       $a1, $t9, $a1
    /* BCB2C 800CC32C 0000838C */  lw         $v1, 0x0($a0)
    /* BCB30 800CC330 0000A28C */  lw         $v0, 0x0($a1)
    /* BCB34 800CC334 24186F00 */  and        $v1, $v1, $t7
    /* BCB38 800CC338 24104800 */  and        $v0, $v0, $t0
    /* BCB3C 800CC33C 25186200 */  or         $v1, $v1, $v0
    /* BCB40 800CC340 000083AC */  sw         $v1, 0x0($a0)
    /* BCB44 800CC344 0000A38C */  lw         $v1, 0x0($a1)
    /* BCB48 800CC348 1C008224 */  addiu      $v0, $a0, 0x1C
    /* BCB4C 800CC34C 000042AD */  sw         $v0, 0x0($t2)
    /* BCB50 800CC350 24108800 */  and        $v0, $a0, $t0
    /* BCB54 800CC354 24186F00 */  and        $v1, $v1, $t7
    /* BCB58 800CC358 25186200 */  or         $v1, $v1, $v0
    /* BCB5C 800CC35C 0032023C */  lui        $v0, (0x32000000 >> 16)
    /* BCB60 800CC360 0000A3AC */  sw         $v1, 0x0($a1)
    /* BCB64 800CC364 040082AC */  sw         $v0, 0x4($a0)
    /* BCB68 800CC368 06000224 */  addiu      $v0, $zero, 0x6
    /* BCB6C 800CC36C 030082A0 */  sb         $v0, 0x3($a0)
    /* BCB70 800CC370 80100700 */  sll        $v0, $a3, 2
    /* BCB74 800CC374 2110A203 */  addu       $v0, $sp, $v0
    /* BCB78 800CC378 0C0092AC */  sw         $s2, 0xC($a0)
    /* BCB7C 800CC37C 140080AC */  sw         $zero, 0x14($a0)
    /* BCB80 800CC380 0000428C */  lw         $v0, 0x0($v0)
    /* BCB84 800CC384 100098AC */  sw         $t8, 0x10($a0)
    /* BCB88 800CC388 080082AC */  sw         $v0, 0x8($a0)
    /* BCB8C 800CC38C 80100900 */  sll        $v0, $t1, 2
    /* BCB90 800CC390 2110A203 */  addu       $v0, $sp, $v0
    /* BCB94 800CC394 0000428C */  lw         $v0, 0x0($v0)
    /* BCB98 800CC398 91300308 */  j          .L800CC244
    /* BCB9C 800CC39C 180082AC */   sw        $v0, 0x18($a0)
  .L800CC3A0:
    /* BCBA0 800CC3A0 4400B38F */  lw         $s3, 0x44($sp)
    /* BCBA4 800CC3A4 4000B28F */  lw         $s2, 0x40($sp)
    /* BCBA8 800CC3A8 3C00B18F */  lw         $s1, 0x3C($sp)
    /* BCBAC 800CC3AC 3800B08F */  lw         $s0, 0x38($sp)
    /* BCBB0 800CC3B0 0800E003 */  jr         $ra
    /* BCBB4 800CC3B4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Flare_OctFlareSpikes__FPli
