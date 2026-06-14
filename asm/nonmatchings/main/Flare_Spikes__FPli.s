.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_Spikes__FPli, 0x2DC

glabel Flare_Spikes__FPli
    /* BCBB8 800CC3B8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* BCBBC 800CC3BC 21688000 */  addu       $t5, $a0, $zero
    /* BCBC0 800CC3C0 2170A000 */  addu       $t6, $a1, $zero
    /* BCBC4 800CC3C4 12800F3C */  lui        $t7, %hi(Flare_gSpikes)
    /* BCBC8 800CC3C8 48FEEF25 */  addiu      $t7, $t7, %lo(Flare_gSpikes)
    /* BCBCC 800CC3CC 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCBD0 800CC3D0 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCBD4 800CC3D4 00000000 */  nop
    /* BCBD8 800CC3D8 00000000 */  nop
    /* BCBDC 800CC3DC 0100184A */  .word 0x4A180001  /* rtps */
    /* BCBE0 800CC3E0 0000AEEB */  swc2       $14, 0x0($sp)
    /* BCBE4 800CC3E4 12800F3C */  lui        $t7, %hi(D_8011FE50)
    /* BCBE8 800CC3E8 50FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE50)
    /* BCBEC 800CC3EC 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCBF0 800CC3F0 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCBF4 800CC3F4 00000000 */  nop
    /* BCBF8 800CC3F8 00000000 */  nop
    /* BCBFC 800CC3FC 0100184A */  .word 0x4A180001  /* rtps */
    /* BCC00 800CC400 0400A227 */  addiu      $v0, $sp, 0x4
    /* BCC04 800CC404 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCC08 800CC408 12800F3C */  lui        $t7, %hi(D_8011FE58)
    /* BCC0C 800CC40C 58FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE58)
    /* BCC10 800CC410 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCC14 800CC414 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCC18 800CC418 00000000 */  nop
    /* BCC1C 800CC41C 00000000 */  nop
    /* BCC20 800CC420 0100184A */  .word 0x4A180001  /* rtps */
    /* BCC24 800CC424 0800A227 */  addiu      $v0, $sp, 0x8
    /* BCC28 800CC428 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCC2C 800CC42C 12800F3C */  lui        $t7, %hi(D_8011FE60)
    /* BCC30 800CC430 60FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE60)
    /* BCC34 800CC434 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCC38 800CC438 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCC3C 800CC43C 00000000 */  nop
    /* BCC40 800CC440 00000000 */  nop
    /* BCC44 800CC444 0100184A */  .word 0x4A180001  /* rtps */
    /* BCC48 800CC448 0C00A227 */  addiu      $v0, $sp, 0xC
    /* BCC4C 800CC44C 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCC50 800CC450 12800F3C */  lui        $t7, %hi(Flare_gOct)
    /* BCC54 800CC454 68FEEF25 */  addiu      $t7, $t7, %lo(Flare_gOct)
    /* BCC58 800CC458 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCC5C 800CC45C 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCC60 800CC460 00000000 */  nop
    /* BCC64 800CC464 00000000 */  nop
    /* BCC68 800CC468 0100184A */  .word 0x4A180001  /* rtps */
    /* BCC6C 800CC46C 1000A227 */  addiu      $v0, $sp, 0x10
    /* BCC70 800CC470 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCC74 800CC474 12800F3C */  lui        $t7, %hi(D_8011FE70)
    /* BCC78 800CC478 70FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE70)
    /* BCC7C 800CC47C 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCC80 800CC480 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCC84 800CC484 00000000 */  nop
    /* BCC88 800CC488 00000000 */  nop
    /* BCC8C 800CC48C 0100184A */  .word 0x4A180001  /* rtps */
    /* BCC90 800CC490 1400A227 */  addiu      $v0, $sp, 0x14
    /* BCC94 800CC494 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCC98 800CC498 12800F3C */  lui        $t7, %hi(D_8011FE78)
    /* BCC9C 800CC49C 78FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE78)
    /* BCCA0 800CC4A0 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCCA4 800CC4A4 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCCA8 800CC4A8 00000000 */  nop
    /* BCCAC 800CC4AC 00000000 */  nop
    /* BCCB0 800CC4B0 0100184A */  .word 0x4A180001  /* rtps */
    /* BCCB4 800CC4B4 1800A227 */  addiu      $v0, $sp, 0x18
    /* BCCB8 800CC4B8 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCCBC 800CC4BC 12800F3C */  lui        $t7, %hi(D_8011FE80)
    /* BCCC0 800CC4C0 80FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE80)
    /* BCCC4 800CC4C4 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCCC8 800CC4C8 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCCCC 800CC4CC 00000000 */  nop
    /* BCCD0 800CC4D0 00000000 */  nop
    /* BCCD4 800CC4D4 0100184A */  .word 0x4A180001  /* rtps */
    /* BCCD8 800CC4D8 1C00A227 */  addiu      $v0, $sp, 0x1C
    /* BCCDC 800CC4DC 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCCE0 800CC4E0 12800F3C */  lui        $t7, %hi(D_8011FE88)
    /* BCCE4 800CC4E4 88FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE88)
    /* BCCE8 800CC4E8 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCCEC 800CC4EC 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCCF0 800CC4F0 00000000 */  nop
    /* BCCF4 800CC4F4 00000000 */  nop
    /* BCCF8 800CC4F8 0100184A */  .word 0x4A180001  /* rtps */
    /* BCCFC 800CC4FC 2000A227 */  addiu      $v0, $sp, 0x20
    /* BCD00 800CC500 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCD04 800CC504 12800F3C */  lui        $t7, %hi(D_8011FE90)
    /* BCD08 800CC508 90FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE90)
    /* BCD0C 800CC50C 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCD10 800CC510 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCD14 800CC514 00000000 */  nop
    /* BCD18 800CC518 00000000 */  nop
    /* BCD1C 800CC51C 0100184A */  .word 0x4A180001  /* rtps */
    /* BCD20 800CC520 2400A227 */  addiu      $v0, $sp, 0x24
    /* BCD24 800CC524 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCD28 800CC528 12800F3C */  lui        $t7, %hi(D_8011FE98)
    /* BCD2C 800CC52C 98FEEF25 */  addiu      $t7, $t7, %lo(D_8011FE98)
    /* BCD30 800CC530 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCD34 800CC534 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCD38 800CC538 00000000 */  nop
    /* BCD3C 800CC53C 00000000 */  nop
    /* BCD40 800CC540 0100184A */  .word 0x4A180001  /* rtps */
    /* BCD44 800CC544 2800A227 */  addiu      $v0, $sp, 0x28
    /* BCD48 800CC548 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCD4C 800CC54C 12800F3C */  lui        $t7, %hi(D_8011FEA0)
    /* BCD50 800CC550 A0FEEF25 */  addiu      $t7, $t7, %lo(D_8011FEA0)
    /* BCD54 800CC554 0000E0C9 */  lwc2       $0, 0x0($t7)
    /* BCD58 800CC558 0400E1C9 */  lwc2       $1, 0x4($t7)
    /* BCD5C 800CC55C 00000000 */  nop
    /* BCD60 800CC560 00000000 */  nop
    /* BCD64 800CC564 0100184A */  .word 0x4A180001  /* rtps */
    /* BCD68 800CC568 2C00A227 */  addiu      $v0, $sp, 0x2C
    /* BCD6C 800CC56C 00004EE8 */  swc2       $14, 0x0($v0)
    /* BCD70 800CC570 08000A24 */  addiu      $t2, $zero, 0x8
    /* BCD74 800CC574 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* BCD78 800CC578 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BCD7C 800CC57C FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BCD80 800CC580 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BCD84 800CC584 00FF0C3C */  lui        $t4, (0xFF000000 >> 16)
    /* BCD88 800CC588 1280023C */  lui        $v0, %hi(gfSpikePt1)
    /* BCD8C 800CC58C F0FD4224 */  addiu      $v0, $v0, %lo(gfSpikePt1)
    /* BCD90 800CC590 10004824 */  addiu      $t0, $v0, 0x10
    /* BCD94 800CC594 1280023C */  lui        $v0, %hi(gfSpikePt2)
    /* BCD98 800CC598 00FE4224 */  addiu      $v0, $v0, %lo(gfSpikePt2)
    /* BCD9C 800CC59C 10004724 */  addiu      $a3, $v0, 0x10
    /* BCDA0 800CC5A0 1280023C */  lui        $v0, %hi(gfSpikePt0)
    /* BCDA4 800CC5A4 E0FD4224 */  addiu      $v0, $v0, %lo(gfSpikePt0)
    /* BCDA8 800CC5A8 10004624 */  addiu      $a2, $v0, 0x10
  .L800CC5AC:
    /* BCDAC 800CC5AC FEFF0825 */  addiu      $t0, $t0, -0x2
    /* BCDB0 800CC5B0 FEFFE724 */  addiu      $a3, $a3, -0x2
    /* BCDB4 800CC5B4 FFFF4A25 */  addiu      $t2, $t2, -0x1
    /* BCDB8 800CC5B8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* BCDBC 800CC5BC 33004211 */  beq        $t2, $v0, .L800CC68C
    /* BCDC0 800CC5C0 FEFFC624 */   addiu     $a2, $a2, -0x2
    /* BCDC4 800CC5C4 80280E00 */  sll        $a1, $t6, 2
    /* BCDC8 800CC5C8 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BCDCC 800CC5CC 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BCDD0 800CC5D0 0000648D */  lw         $a0, 0x0($t3)
    /* BCDD4 800CC5D4 2128A200 */  addu       $a1, $a1, $v0
    /* BCDD8 800CC5D8 0000838C */  lw         $v1, 0x0($a0)
    /* BCDDC 800CC5DC 0000A28C */  lw         $v0, 0x0($a1)
    /* BCDE0 800CC5E0 24186C00 */  and        $v1, $v1, $t4
    /* BCDE4 800CC5E4 24104900 */  and        $v0, $v0, $t1
    /* BCDE8 800CC5E8 25186200 */  or         $v1, $v1, $v0
    /* BCDEC 800CC5EC 000083AC */  sw         $v1, 0x0($a0)
    /* BCDF0 800CC5F0 0000A38C */  lw         $v1, 0x0($a1)
    /* BCDF4 800CC5F4 24008224 */  addiu      $v0, $a0, 0x24
    /* BCDF8 800CC5F8 000062AD */  sw         $v0, 0x0($t3)
    /* BCDFC 800CC5FC 24108900 */  and        $v0, $a0, $t1
    /* BCE00 800CC600 24186C00 */  and        $v1, $v1, $t4
    /* BCE04 800CC604 25186200 */  or         $v1, $v1, $v0
    /* BCE08 800CC608 003A023C */  lui        $v0, (0x3A000000 >> 16)
    /* BCE0C 800CC60C 0000A3AC */  sw         $v1, 0x0($a1)
    /* BCE10 800CC610 040082AC */  sw         $v0, 0x4($a0)
    /* BCE14 800CC614 2413838F */  lw         $v1, %gp_rel(gfrgb2)($gp)
    /* BCE18 800CC618 08000224 */  addiu      $v0, $zero, 0x8
    /* BCE1C 800CC61C 140080AC */  sw         $zero, 0x14($a0)
    /* BCE20 800CC620 1C0080AC */  sw         $zero, 0x1C($a0)
    /* BCE24 800CC624 030082A0 */  sb         $v0, 0x3($a0)
    /* BCE28 800CC628 0C0083AC */  sw         $v1, 0xC($a0)
    /* BCE2C 800CC62C 0000C284 */  lh         $v0, 0x0($a2)
    /* BCE30 800CC630 00000000 */  nop
    /* BCE34 800CC634 80100200 */  sll        $v0, $v0, 2
    /* BCE38 800CC638 2110A203 */  addu       $v0, $sp, $v0
    /* BCE3C 800CC63C 0000428C */  lw         $v0, 0x0($v0)
    /* BCE40 800CC640 00000000 */  nop
    /* BCE44 800CC644 080082AC */  sw         $v0, 0x8($a0)
    /* BCE48 800CC648 0000A28D */  lw         $v0, 0x0($t5)
    /* BCE4C 800CC64C 00000000 */  nop
    /* BCE50 800CC650 100082AC */  sw         $v0, 0x10($a0)
    /* BCE54 800CC654 0000E284 */  lh         $v0, 0x0($a3)
    /* BCE58 800CC658 00000000 */  nop
    /* BCE5C 800CC65C 80100200 */  sll        $v0, $v0, 2
    /* BCE60 800CC660 2110A203 */  addu       $v0, $sp, $v0
    /* BCE64 800CC664 0000428C */  lw         $v0, 0x0($v0)
    /* BCE68 800CC668 00000000 */  nop
    /* BCE6C 800CC66C 180082AC */  sw         $v0, 0x18($a0)
    /* BCE70 800CC670 00000285 */  lh         $v0, 0x0($t0)
    /* BCE74 800CC674 00000000 */  nop
    /* BCE78 800CC678 80100200 */  sll        $v0, $v0, 2
    /* BCE7C 800CC67C 2110A203 */  addu       $v0, $sp, $v0
    /* BCE80 800CC680 0000428C */  lw         $v0, 0x0($v0)
    /* BCE84 800CC684 6B310308 */  j          .L800CC5AC
    /* BCE88 800CC688 200082AC */   sw        $v0, 0x20($a0)
  .L800CC68C:
    /* BCE8C 800CC68C 0800E003 */  jr         $ra
    /* BCE90 800CC690 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Flare_Spikes__FPli
