.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_Volume__Fi, 0x1BC

glabel AudioMus_Volume__Fi
    /* 6BAB0 8007B2B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6BAB4 8007B2B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6BAB8 8007B2B8 21888000 */  addu       $s1, $a0, $zero
    /* 6BABC 8007B2BC D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6BAC0 8007B2C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 6BAC4 8007B2C4 64008010 */  beqz       $a0, .L8007B458
    /* 6BAC8 8007B2C8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6BACC 8007B2CC 0000828C */  lw         $v0, 0x0($a0)
    /* 6BAD0 8007B2D0 00000000 */  nop
    /* 6BAD4 8007B2D4 60005110 */  beq        $v0, $s1, .L8007B458
    /* 6BAD8 8007B2D8 00000000 */   nop
    /* 6BADC 8007B2DC 06002016 */  bnez       $s1, .L8007B2F8
    /* 6BAE0 8007B2E0 21800000 */   addu      $s0, $zero, $zero
    /* 6BAE4 8007B2E4 000080AC */  sw         $zero, 0x0($a0)
    /* 6BAE8 8007B2E8 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 6BAEC 8007B2EC 21200002 */   addu      $a0, $s0, $zero
    /* 6BAF0 8007B2F0 16ED0108 */  j          .L8007B458
    /* 6BAF4 8007B2F4 00000000 */   nop
  .L8007B2F8:
    /* 6BAF8 8007B2F8 2400828C */  lw         $v0, 0x24($a0)
    /* 6BAFC 8007B2FC 00000000 */  nop
    /* 6BB00 8007B300 21004010 */  beqz       $v0, .L8007B388
    /* 6BB04 8007B304 00000000 */   nop
    /* 6BB08 8007B308 7400848C */  lw         $a0, 0x74($a0)
    /* 6BB0C 8007B30C 00000000 */  nop
    /* 6BB10 8007B310 1D008004 */  bltz       $a0, .L8007B388
    /* 6BB14 8007B314 00000000 */   nop
    /* 6BB18 8007B318 FBA0030C */  jal        SNDSTRM_getvol
    /* 6BB1C 8007B31C 00000000 */   nop
    /* 6BB20 8007B320 21204000 */  addu       $a0, $v0, $zero
    /* 6BB24 8007B324 18008018 */  blez       $a0, .L8007B388
    /* 6BB28 8007B328 00000000 */   nop
    /* 6BB2C 8007B32C D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BB30 8007B330 00000000 */  nop
    /* 6BB34 8007B334 0000438C */  lw         $v1, 0x0($v0)
    /* 6BB38 8007B338 00000000 */  nop
    /* 6BB3C 8007B33C 12006018 */  blez       $v1, .L8007B388
    /* 6BB40 8007B340 00000000 */   nop
    /* 6BB44 8007B344 2400428C */  lw         $v0, 0x24($v0)
    /* 6BB48 8007B348 00000000 */  nop
    /* 6BB4C 8007B34C 18004400 */  mult       $v0, $a0
    /* 6BB50 8007B350 12400000 */  mflo       $t0
    /* 6BB54 8007B354 00000000 */  nop
    /* 6BB58 8007B358 00000000 */  nop
    /* 6BB5C 8007B35C 1A000301 */  div        $zero, $t0, $v1
    /* 6BB60 8007B360 02006014 */  bnez       $v1, .L8007B36C
    /* 6BB64 8007B364 00000000 */   nop
    /* 6BB68 8007B368 0D000700 */  break      7
  .L8007B36C:
    /* 6BB6C 8007B36C FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6BB70 8007B370 04006114 */  bne        $v1, $at, .L8007B384
    /* 6BB74 8007B374 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6BB78 8007B378 02000115 */  bne        $t0, $at, .L8007B384
    /* 6BB7C 8007B37C 00000000 */   nop
    /* 6BB80 8007B380 0D000600 */  break      6
  .L8007B384:
    /* 6BB84 8007B384 12800000 */  mflo       $s0
  .L8007B388:
    /* 6BB88 8007B388 00000000 */  nop
    /* 6BB8C 8007B38C 1A000012 */  beqz       $s0, .L8007B3F8
    /* 6BB90 8007B390 18003002 */   mult      $s1, $s0
    /* 6BB94 8007B394 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BB98 8007B398 12180000 */  mflo       $v1
    /* 6BB9C 8007B39C 2400458C */  lw         $a1, 0x24($v0)
    /* 6BBA0 8007B3A0 00000000 */  nop
    /* 6BBA4 8007B3A4 1A006500 */  div        $zero, $v1, $a1
    /* 6BBA8 8007B3A8 0200A014 */  bnez       $a1, .L8007B3B4
    /* 6BBAC 8007B3AC 00000000 */   nop
    /* 6BBB0 8007B3B0 0D000700 */  break      7
  .L8007B3B4:
    /* 6BBB4 8007B3B4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 6BBB8 8007B3B8 0400A114 */  bne        $a1, $at, .L8007B3CC
    /* 6BBBC 8007B3BC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 6BBC0 8007B3C0 02006114 */  bne        $v1, $at, .L8007B3CC
    /* 6BBC4 8007B3C4 00000000 */   nop
    /* 6BBC8 8007B3C8 0D000600 */  break      6
  .L8007B3CC:
    /* 6BBCC 8007B3CC 12280000 */  mflo       $a1
    /* 6BBD0 8007B3D0 7400448C */  lw         $a0, 0x74($v0)
    /* 6BBD4 8007B3D4 36A8030C */  jal        SNDSTRM_vol
    /* 6BBD8 8007B3D8 00000000 */   nop
    /* 6BBDC 8007B3DC D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BBE0 8007B3E0 21280002 */  addu       $a1, $s0, $zero
    /* 6BBE4 8007B3E4 7400448C */  lw         $a0, 0x74($v0)
    /* 6BBE8 8007B3E8 7AA7030C */  jal        SNDSTRM_autovol
    /* 6BBEC 8007B3EC 21300000 */   addu      $a2, $zero, $zero
    /* 6BBF0 8007B3F0 0AED0108 */  j          .L8007B428
    /* 6BBF4 8007B3F4 00000000 */   nop
  .L8007B3F8:
    /* 6BBF8 8007B3F8 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6BBFC 8007B3FC 00000000 */  nop
    /* 6BC00 8007B400 7400448C */  lw         $a0, 0x74($v0)
    /* 6BC04 8007B404 00000000 */  nop
    /* 6BC08 8007B408 07008004 */  bltz       $a0, .L8007B428
    /* 6BC0C 8007B40C 00000000 */   nop
    /* 6BC10 8007B410 1400438C */  lw         $v1, 0x14($v0)
    /* 6BC14 8007B414 02000224 */  addiu      $v0, $zero, 0x2
    /* 6BC18 8007B418 03006210 */  beq        $v1, $v0, .L8007B428
    /* 6BC1C 8007B41C 00000000 */   nop
    /* 6BC20 8007B420 36A8030C */  jal        SNDSTRM_vol
    /* 6BC24 8007B424 21282002 */   addu      $a1, $s1, $zero
  .L8007B428:
    /* 6BC28 8007B428 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6BC2C 8007B42C 00000000 */  nop
    /* 6BC30 8007B430 0000628C */  lw         $v0, 0x0($v1)
    /* 6BC34 8007B434 00000000 */  nop
    /* 6BC38 8007B438 06004014 */  bnez       $v0, .L8007B454
    /* 6BC3C 8007B43C 00000000 */   nop
    /* 6BC40 8007B440 000071AC */  sw         $s1, 0x0($v1)
    /* 6BC44 8007B444 0CEC010C */  jal        AudioMus_PlaySong__FPc
    /* 6BC48 8007B448 21200000 */   addu      $a0, $zero, $zero
    /* 6BC4C 8007B44C 16ED0108 */  j          .L8007B458
    /* 6BC50 8007B450 00000000 */   nop
  .L8007B454:
    /* 6BC54 8007B454 000071AC */  sw         $s1, 0x0($v1)
  .L8007B458:
    /* 6BC58 8007B458 1800BF8F */  lw         $ra, 0x18($sp)
    /* 6BC5C 8007B45C 1400B18F */  lw         $s1, 0x14($sp)
    /* 6BC60 8007B460 1000B08F */  lw         $s0, 0x10($sp)
    /* 6BC64 8007B464 0800E003 */  jr         $ra
    /* 6BC68 8007B468 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioMus_Volume__Fi
