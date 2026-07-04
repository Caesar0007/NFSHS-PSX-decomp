.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache, 0x96C

glabel Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
    /* BDD30 800CD530 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* BDD34 800CD534 C800B0AF */  sw         $s0, 0xC8($sp)
    /* BDD38 800CD538 2180A000 */  addu       $s0, $a1, $zero
    /* BDD3C 800CD53C D000B2AF */  sw         $s2, 0xD0($sp)
    /* BDD40 800CD540 2190C000 */  addu       $s2, $a2, $zero
    /* BDD44 800CD544 DC00B5AF */  sw         $s5, 0xDC($sp)
    /* BDD48 800CD548 CC00B1AF */  sw         $s1, 0xCC($sp)
    /* BDD4C 800CD54C FF005132 */  andi       $s1, $s2, 0xFF
    /* BDD50 800CD550 1280023C */  lui        $v0, %hi(Flare_gType)
    /* BDD54 800CD554 68FF4224 */  addiu      $v0, $v0, %lo(Flare_gType)
    /* BDD58 800CD558 00191100 */  sll        $v1, $s1, 4
    /* BDD5C 800CD55C 0001A68F */  lw         $a2, 0x100($sp)
    /* BDD60 800CD560 21186200 */  addu       $v1, $v1, $v0
    /* BDD64 800CD564 E800BFAF */  sw         $ra, 0xE8($sp)
    /* BDD68 800CD568 E400B7AF */  sw         $s7, 0xE4($sp)
    /* BDD6C 800CD56C E000B6AF */  sw         $s6, 0xE0($sp)
    /* BDD70 800CD570 D800B4AF */  sw         $s4, 0xD8($sp)
    /* BDD74 800CD574 D400B3AF */  sw         $s3, 0xD4($sp)
    /* BDD78 800CD578 0C00738C */  lw         $s3, 0xC($v1)
    /* BDD7C 800CD57C 0300C014 */  bnez       $a2, .L800CD58C
    /* BDD80 800CD580 21A80000 */   addu      $s5, $zero, $zero
    /* BDD84 800CD584 FAFF0224 */  addiu      $v0, $zero, -0x6
    /* BDD88 800CD588 24986202 */  and        $s3, $s3, $v0
  .L800CD58C:
    /* BDD8C 800CD58C 08008224 */  addiu      $v0, $a0, 0x8
    /* BDD90 800CD590 0000E38C */  lw         $v1, 0x0($a3)
    /* BDD94 800CD594 0400E58C */  lw         $a1, 0x4($a3)
    /* BDD98 800CD598 0800898C */  lw         $t1, 0x8($a0)
    /* BDD9C 800CD59C 0800E78C */  lw         $a3, 0x8($a3)
    /* BDDA0 800CD5A0 0400448C */  lw         $a0, 0x4($v0)
    /* BDDA4 800CD5A4 0800488C */  lw         $t0, 0x8($v0)
    /* BDDA8 800CD5A8 23186900 */  subu       $v1, $v1, $t1
    /* BDDAC 800CD5AC 2328A400 */  subu       $a1, $a1, $a0
    /* BDDB0 800CD5B0 2338E800 */  subu       $a3, $a3, $t0
    /* BDDB4 800CD5B4 83120300 */  sra        $v0, $v1, 10
    /* BDDB8 800CD5B8 2800A2A7 */  sh         $v0, 0x28($sp)
    /* BDDBC 800CD5BC 83120500 */  sra        $v0, $a1, 10
    /* BDDC0 800CD5C0 2A00A2A7 */  sh         $v0, 0x2A($sp)
    /* BDDC4 800CD5C4 83120700 */  sra        $v0, $a3, 10
    /* BDDC8 800CD5C8 2C00A2A7 */  sh         $v0, 0x2C($sp)
    /* BDDCC 800CD5CC 05006232 */  andi       $v0, $s3, 0x5
    /* BDDD0 800CD5D0 0E004010 */  beqz       $v0, .L800CD60C
    /* BDDD4 800CD5D4 10006232 */   andi      $v0, $s3, 0x10
    /* BDDD8 800CD5D8 0000C38C */  lw         $v1, 0x0($a2)
    /* BDDDC 800CD5DC 0400C58C */  lw         $a1, 0x4($a2)
    /* BDDE0 800CD5E0 0800C78C */  lw         $a3, 0x8($a2)
    /* BDDE4 800CD5E4 23186900 */  subu       $v1, $v1, $t1
    /* BDDE8 800CD5E8 2328A400 */  subu       $a1, $a1, $a0
    /* BDDEC 800CD5EC 2338E800 */  subu       $a3, $a3, $t0
    /* BDDF0 800CD5F0 83120300 */  sra        $v0, $v1, 10
    /* BDDF4 800CD5F4 3000A2A7 */  sh         $v0, 0x30($sp)
    /* BDDF8 800CD5F8 83120500 */  sra        $v0, $a1, 10
    /* BDDFC 800CD5FC 3200A2A7 */  sh         $v0, 0x32($sp)
    /* BDE00 800CD600 83120700 */  sra        $v0, $a3, 10
    /* BDE04 800CD604 3400A2A7 */  sh         $v0, 0x34($sp)
    /* BDE08 800CD608 10006232 */  andi       $v0, $s3, 0x10
  .L800CD60C:
    /* BDE0C 800CD60C 04004010 */  beqz       $v0, .L800CD620
    /* BDE10 800CD610 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* BDE14 800CD614 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* BDE18 800CD618 8F350308 */  j          .L800CD63C
    /* BDE1C 800CD61C 83110200 */   sra       $v0, $v0, 6
  .L800CD620:
    /* BDE20 800CD620 20006232 */  andi       $v0, $s3, 0x20
    /* BDE24 800CD624 08004010 */  beqz       $v0, .L800CD648
    /* BDE28 800CD628 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* BDE2C 800CD62C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* BDE30 800CD630 00000000 */  nop
    /* BDE34 800CD634 1B004224 */  addiu      $v0, $v0, 0x1B
    /* BDE38 800CD638 43110200 */  sra        $v0, $v0, 5
  .L800CD63C:
    /* BDE3C 800CD63C 01004230 */  andi       $v0, $v0, 0x1
    /* BDE40 800CD640 0B024014 */  bnez       $v0, .L800CDE70
    /* BDE44 800CD644 00000000 */   nop
  .L800CD648:
    /* BDE48 800CD648 1180043C */  lui        $a0, %hi(gWorldMat)
    /* BDE4C 800CD64C 532F030C */  jal        Flare_SetMatrix__FP10matrixtdef
    /* BDE50 800CD650 40EE8424 */   addiu     $a0, $a0, %lo(gWorldMat)
    /* BDE54 800CD654 2800A227 */  addiu      $v0, $sp, 0x28
    /* BDE58 800CD658 000040C8 */  lwc2       $0, 0x0($v0)
    /* BDE5C 800CD65C 040041C8 */  lwc2       $1, 0x4($v0)
    /* BDE60 800CD660 00000000 */  nop
    /* BDE64 800CD664 00000000 */  nop
    /* BDE68 800CD668 0100184A */  .word 0x4A180001  /* rtps */
    /* BDE6C 800CD66C 1280023C */  lui        $v0, %hi(Flare_gType)
    /* BDE70 800CD670 68FF4224 */  addiu      $v0, $v0, %lo(Flare_gType)
    /* BDE74 800CD674 00191100 */  sll        $v1, $s1, 4
    /* BDE78 800CD678 21186200 */  addu       $v1, $v1, $v0
    /* BDE7C 800CD67C 0000628C */  lw         $v0, 0x0($v1)
    /* BDE80 800CD680 00000000 */  nop
    /* BDE84 800CD684 3800A2AF */  sw         $v0, 0x38($sp)
    /* BDE88 800CD688 0400628C */  lw         $v0, 0x4($v1)
    /* BDE8C 800CD68C 00000000 */  nop
    /* BDE90 800CD690 3C00A2AF */  sw         $v0, 0x3C($sp)
    /* BDE94 800CD694 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* BDE98 800CD698 02000216 */  bne        $s0, $v0, .L800CD6A4
    /* BDE9C 800CD69C 1800B627 */   addiu     $s6, $sp, 0x18
    /* BDEA0 800CD6A0 0800708C */  lw         $s0, 0x8($v1)
  .L800CD6A4:
    /* BDEA4 800CD6A4 0000D9EA */  swc2       $25, 0x0($s6)
    /* BDEA8 800CD6A8 0400DAEA */  swc2       $26, 0x4($s6) /* handwritten instruction */
    /* BDEAC 800CD6AC 0800DBEA */  swc2       $27, 0x8($s6) /* handwritten instruction */
    /* BDEB0 800CD6B0 1800A48F */  lw         $a0, 0x18($sp)
    /* BDEB4 800CD6B4 2000A38F */  lw         $v1, 0x20($sp)
    /* BDEB8 800CD6B8 00000000 */  nop
    /* BDEBC 800CD6BC 2A106400 */  slt        $v0, $v1, $a0
    /* BDEC0 800CD6C0 EB014014 */  bnez       $v0, .L800CDE70
    /* BDEC4 800CD6C4 23100400 */   negu      $v0, $a0
    /* BDEC8 800CD6C8 2A106200 */  slt        $v0, $v1, $v0
    /* BDECC 800CD6CC E8014014 */  bnez       $v0, .L800CDE70
    /* BDED0 800CD6D0 80006228 */   slti      $v0, $v1, 0x80
    /* BDED4 800CD6D4 E6014014 */  bnez       $v0, .L800CDE70
    /* BDED8 800CD6D8 4000A227 */   addiu     $v0, $sp, 0x40
    /* BDEDC 800CD6DC 00004EE8 */  swc2       $14, 0x0($v0)
    /* BDEE0 800CD6E0 C000A227 */  addiu      $v0, $sp, 0xC0
    /* BDEE4 800CD6E4 00980C48 */  mfc2       $t4, $19 /* handwritten instruction */
    /* BDEE8 800CD6E8 00000000 */  nop
    /* BDEEC 800CD6EC 83600C00 */  sra        $t4, $t4, 2
    /* BDEF0 800CD6F0 00004CAC */  sw         $t4, 0x0($v0)
    /* BDEF4 800CD6F4 C000A28F */  lw         $v0, 0xC0($sp)
    /* BDEF8 800CD6F8 00000000 */  nop
    /* BDEFC 800CD6FC 43180200 */  sra        $v1, $v0, 1
    /* BDF00 800CD700 DB016004 */  bltz       $v1, .L800CDE70
    /* BDF04 800CD704 C000A3AF */   sw        $v1, 0xC0($sp)
    /* BDF08 800CD708 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* BDF0C 800CD70C B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* BDF10 800CD710 00000000 */  nop
    /* BDF14 800CD714 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* BDF18 800CD718 2A104300 */  slt        $v0, $v0, $v1
    /* BDF1C 800CD71C D4014014 */  bnez       $v0, .L800CDE70
    /* BDF20 800CD720 80006232 */   andi      $v0, $s3, 0x80
    /* BDF24 800CD724 21004010 */  beqz       $v0, .L800CD7AC
    /* BDF28 800CD728 08006232 */   andi      $v0, $s3, 0x8
    /* BDF2C 800CD72C EA9D030C */  jal        random
    /* BDF30 800CD730 00000000 */   nop
    /* BDF34 800CD734 CCCC033C */  lui        $v1, (0xCCCCCCCD >> 16)
    /* BDF38 800CD738 CDCC6334 */  ori        $v1, $v1, (0xCCCCCCCD & 0xFFFF)
    /* BDF3C 800CD73C 19004300 */  multu      $v0, $v1
    /* BDF40 800CD740 10780000 */  mfhi       $t7
    /* BDF44 800CD744 02210F00 */  srl        $a0, $t7, 4
    /* BDF48 800CD748 80180400 */  sll        $v1, $a0, 2
    /* BDF4C 800CD74C 21186400 */  addu       $v1, $v1, $a0
    /* BDF50 800CD750 80180300 */  sll        $v1, $v1, 2
    /* BDF54 800CD754 23204300 */  subu       $a0, $v0, $v1
    /* BDF58 800CD758 80100400 */  sll        $v0, $a0, 2
    /* BDF5C 800CD75C 21800202 */  addu       $s0, $s0, $v0
    /* BDF60 800CD760 3800A293 */  lbu        $v0, 0x38($sp)
    /* BDF64 800CD764 3900A393 */  lbu        $v1, 0x39($sp)
    /* BDF68 800CD768 21104400 */  addu       $v0, $v0, $a0
    /* BDF6C 800CD76C 3800A2A3 */  sb         $v0, 0x38($sp)
    /* BDF70 800CD770 3A00A293 */  lbu        $v0, 0x3A($sp)
    /* BDF74 800CD774 21186400 */  addu       $v1, $v1, $a0
    /* BDF78 800CD778 3900A3A3 */  sb         $v1, 0x39($sp)
    /* BDF7C 800CD77C 3C00A393 */  lbu        $v1, 0x3C($sp)
    /* BDF80 800CD780 21104400 */  addu       $v0, $v0, $a0
    /* BDF84 800CD784 3A00A2A3 */  sb         $v0, 0x3A($sp)
    /* BDF88 800CD788 3D00A293 */  lbu        $v0, 0x3D($sp)
    /* BDF8C 800CD78C 21186400 */  addu       $v1, $v1, $a0
    /* BDF90 800CD790 3C00A3A3 */  sb         $v1, 0x3C($sp)
    /* BDF94 800CD794 3E00A393 */  lbu        $v1, 0x3E($sp)
    /* BDF98 800CD798 21104400 */  addu       $v0, $v0, $a0
    /* BDF9C 800CD79C 21186400 */  addu       $v1, $v1, $a0
    /* BDFA0 800CD7A0 3D00A2A3 */  sb         $v0, 0x3D($sp)
    /* BDFA4 800CD7A4 3E00A3A3 */  sb         $v1, 0x3E($sp)
    /* BDFA8 800CD7A8 08006232 */  andi       $v0, $s3, 0x8
  .L800CD7AC:
    /* BDFAC 800CD7AC 07004010 */  beqz       $v0, .L800CD7CC
    /* BDFB0 800CD7B0 40006232 */   andi      $v0, $s3, 0x40
    /* BDFB4 800CD7B4 4000A287 */  lh         $v0, 0x40($sp)
    /* BDFB8 800CD7B8 4200A387 */  lh         $v1, 0x42($sp)
    /* BDFBC 800CD7BC 00000000 */  nop
    /* BDFC0 800CD7C0 21104300 */  addu       $v0, $v0, $v1
    /* BDFC4 800CD7C4 80A80200 */  sll        $s5, $v0, 2
    /* BDFC8 800CD7C8 40006232 */  andi       $v0, $s3, 0x40
  .L800CD7CC:
    /* BDFCC 800CD7CC 14800F3C */  lui        $t7, %hi(gfrgb)
    /* BDFD0 800CD7D0 6CD8EF25 */  addiu      $t7, $t7, %lo(gfrgb)
    /* BDFD4 800CD7D4 3B00B78B */  lwl        $s7, 0x3B($sp)
    /* BDFD8 800CD7D8 3800B79B */  lwr        $s7, 0x38($sp)
    /* BDFDC 800CD7DC 00000000 */  nop
    /* BDFE0 800CD7E0 0300F7A9 */  swl        $s7, 0x3($t7)
    /* BDFE4 800CD7E4 0000F7B9 */  swr        $s7, 0x0($t7)
    /* BDFE8 800CD7E8 14800F3C */  lui        $t7, %hi(gfrgb2)
    /* BDFEC 800CD7EC 70D8EF25 */  addiu      $t7, $t7, %lo(gfrgb2)
    /* BDFF0 800CD7F0 3F00B78B */  lwl        $s7, 0x3F($sp)
    /* BDFF4 800CD7F4 3C00B79B */  lwr        $s7, 0x3C($sp)
    /* BDFF8 800CD7F8 00000000 */  nop
    /* BDFFC 800CD7FC 0300F7A9 */  swl        $s7, 0x3($t7)
    /* BE000 800CD800 0000F7B9 */  swr        $s7, 0x0($t7)
    /* BE004 800CD804 281390AF */  sw         $s0, %gp_rel(gscale)($gp)
    /* BE008 800CD808 1D004010 */  beqz       $v0, .L800CD880
    /* BE00C 800CD80C 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* BE010 800CD810 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BE014 800CD814 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BE018 800CD818 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BE01C 800CD81C 21280000 */  addu       $a1, $zero, $zero
    /* BE020 800CD820 2130A000 */  addu       $a2, $a1, $zero
    /* BE024 800CD824 20010724 */  addiu      $a3, $zero, 0x120
    /* BE028 800CD828 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BE02C 800CD82C 0000648D */  lw         $a0, 0x0($t3)
    /* BE030 800CD830 C000A88F */  lw         $t0, 0xC0($sp)
    /* BE034 800CD834 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BE038 800CD838 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BE03C 800CD83C 80400800 */  sll        $t0, $t0, 2
    /* BE040 800CD840 21400201 */  addu       $t0, $t0, $v0
    /* BE044 800CD844 0000838C */  lw         $v1, 0x0($a0)
    /* BE048 800CD848 0000028D */  lw         $v0, 0x0($t0)
    /* BE04C 800CD84C 24186A00 */  and        $v1, $v1, $t2
    /* BE050 800CD850 24104900 */  and        $v0, $v0, $t1
    /* BE054 800CD854 25186200 */  or         $v1, $v1, $v0
    /* BE058 800CD858 000083AC */  sw         $v1, 0x0($a0)
    /* BE05C 800CD85C 0000028D */  lw         $v0, 0x0($t0)
    /* BE060 800CD860 0C008324 */  addiu      $v1, $a0, 0xC
    /* BE064 800CD864 000063AD */  sw         $v1, 0x0($t3)
    /* BE068 800CD868 24188900 */  and        $v1, $a0, $t1
    /* BE06C 800CD86C 24104A00 */  and        $v0, $v0, $t2
    /* BE070 800CD870 25104300 */  or         $v0, $v0, $v1
    /* BE074 800CD874 000002AD */  sw         $v0, 0x0($t0)
    /* BE078 800CD878 EFB8030C */  jal        SetDrawMode
    /* BE07C 800CD87C 1000A0AF */   sw        $zero, 0x10($sp)
  .L800CD880:
    /* BE080 800CD880 2000B48F */  lw         $s4, 0x20($sp)
    /* BE084 800CD884 05006232 */  andi       $v0, $s3, 0x5
    /* BE088 800CD888 0C004010 */  beqz       $v0, .L800CD8BC
    /* BE08C 800CD88C 3000A227 */   addiu     $v0, $sp, 0x30
    /* BE090 800CD890 000040C8 */  lwc2       $0, 0x0($v0)
    /* BE094 800CD894 040041C8 */  lwc2       $1, 0x4($v0)
    /* BE098 800CD898 00000000 */  nop
    /* BE09C 800CD89C 00000000 */  nop
    /* BE0A0 800CD8A0 0100184A */  .word 0x4A180001  /* rtps */
    /* BE0A4 800CD8A4 4800A227 */  addiu      $v0, $sp, 0x48
    /* BE0A8 800CD8A8 000059E8 */  swc2       $25, 0x0($v0)
    /* BE0AC 800CD8AC 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BE0B0 800CD8B0 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BE0B4 800CD8B4 5800A227 */  addiu      $v0, $sp, 0x58
    /* BE0B8 800CD8B8 00004EE8 */  swc2       $14, 0x0($v0)
  .L800CD8BC:
    /* BE0BC 800CD8BC 04006232 */  andi       $v0, $s3, 0x4
    /* BE0C0 800CD8C0 B0004010 */  beqz       $v0, .L800CDB84
    /* BE0C4 800CD8C4 01006232 */   andi      $v0, $s3, 0x1
    /* BE0C8 800CD8C8 5A00B187 */  lh         $s1, 0x5A($sp)
    /* BE0CC 800CD8CC 4200A287 */  lh         $v0, 0x42($sp)
    /* BE0D0 800CD8D0 5800B087 */  lh         $s0, 0x58($sp)
    /* BE0D4 800CD8D4 23882202 */  subu       $s1, $s1, $v0
    /* BE0D8 800CD8D8 4000A287 */  lh         $v0, 0x40($sp)
    /* BE0DC 800CD8DC 21202002 */  addu       $a0, $s1, $zero
    /* BE0E0 800CD8E0 23800202 */  subu       $s0, $s0, $v0
    /* BE0E4 800CD8E4 4AB5030C */  jal        fixedatan
    /* BE0E8 800CD8E8 21280002 */   addu      $a1, $s0, $zero
    /* BE0EC 800CD8EC 18001002 */  mult       $s0, $s0
    /* BE0F0 800CD8F0 12180000 */  mflo       $v1
    /* BE0F4 800CD8F4 00000000 */  nop
    /* BE0F8 800CD8F8 00000000 */  nop
    /* BE0FC 800CD8FC 18003102 */  mult       $s1, $s1
    /* BE100 800CD900 03910200 */  sra        $s2, $v0, 4
    /* BE104 800CD904 12400000 */  mflo       $t0
    /* BE108 800CD908 B3CC030C */  jal        isqrt
    /* BE10C 800CD90C 21206800 */   addu      $a0, $v1, $t0
    /* BE110 800CD910 2000A38F */  lw         $v1, 0x20($sp)
    /* BE114 800CD914 00000000 */  nop
    /* BE118 800CD918 18004300 */  mult       $v0, $v1
    /* BE11C 800CD91C 6000B127 */  addiu      $s1, $sp, 0x60
    /* BE120 800CD920 2813838F */  lw         $v1, %gp_rel(gscale)($gp)
    /* BE124 800CD924 21202002 */  addu       $a0, $s1, $zero
    /* BE128 800CD928 B000A0AF */  sw         $zero, 0xB0($sp)
    /* BE12C 800CD92C A400A0AF */  sw         $zero, 0xA4($sp)
    /* BE130 800CD930 AC00A0AF */  sw         $zero, 0xAC($sp)
    /* BE134 800CD934 A800A3AF */  sw         $v1, 0xA8($sp)
    /* BE138 800CD938 12400000 */  mflo       $t0
    /* BE13C 800CD93C 03110800 */  sra        $v0, $t0, 4
    /* BE140 800CD940 21186200 */  addu       $v1, $v1, $v0
    /* BE144 800CD944 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BE148 800CD948 A000A3AF */   sw        $v1, 0xA0($sp)
    /* BE14C 800CD94C 8000B027 */  addiu      $s0, $sp, 0x80
    /* BE150 800CD950 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BE154 800CD954 21200002 */   addu      $a0, $s0, $zero
    /* BE158 800CD958 0000CC8E */  lw         $t4, 0x0($s6)
    /* BE15C 800CD95C 0400CD8E */  lw         $t5, 0x4($s6)
    /* BE160 800CD960 0800CE8E */  lw         $t6, 0x8($s6)
    /* BE164 800CD964 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BE168 800CD968 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BE16C 800CD96C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BE170 800CD970 2120A002 */  addu       $a0, $s5, $zero
    /* BE174 800CD974 4BCC030C */  jal        RotMatrixZ
    /* BE178 800CD978 21282002 */   addu      $a1, $s1, $zero
    /* BE17C 800CD97C 21204002 */  addu       $a0, $s2, $zero
    /* BE180 800CD980 4BCC030C */  jal        RotMatrixZ
    /* BE184 800CD984 21280002 */   addu      $a1, $s0, $zero
    /* BE188 800CD988 00000C8E */  lw         $t4, 0x0($s0)
    /* BE18C 800CD98C 04000D8E */  lw         $t5, 0x4($s0)
    /* BE190 800CD990 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BE194 800CD994 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BE198 800CD998 08000C8E */  lw         $t4, 0x8($s0)
    /* BE19C 800CD99C 0C000D8E */  lw         $t5, 0xC($s0)
    /* BE1A0 800CD9A0 10000E8E */  lw         $t6, 0x10($s0)
    /* BE1A4 800CD9A4 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BE1A8 800CD9A8 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BE1AC 800CD9AC 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BE1B0 800CD9B0 A000A327 */  addiu      $v1, $sp, 0xA0
    /* BE1B4 800CD9B4 00006C94 */  lhu        $t4, 0x0($v1)
    /* BE1B8 800CD9B8 06006D94 */  lhu        $t5, 0x6($v1)
    /* BE1BC 800CD9BC 0C006E94 */  lhu        $t6, 0xC($v1)
    /* BE1C0 800CD9C0 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE1C4 800CD9C4 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE1C8 800CD9C8 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE1CC 800CD9CC 00000000 */  nop
    /* BE1D0 800CD9D0 00000000 */  nop
    /* BE1D4 800CD9D4 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE1D8 800CD9D8 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE1DC 800CD9DC 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE1E0 800CD9E0 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE1E4 800CD9E4 00006CA4 */  sh         $t4, 0x0($v1)
    /* BE1E8 800CD9E8 06006DA4 */  sh         $t5, 0x6($v1)
    /* BE1EC 800CD9EC 0C006EA4 */  sh         $t6, 0xC($v1)
    /* BE1F0 800CD9F0 A200A227 */  addiu      $v0, $sp, 0xA2
    /* BE1F4 800CD9F4 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE1F8 800CD9F8 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE1FC 800CD9FC 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE200 800CDA00 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE204 800CDA04 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE208 800CDA08 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE20C 800CDA0C 00000000 */  nop
    /* BE210 800CDA10 00000000 */  nop
    /* BE214 800CDA14 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE218 800CDA18 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE21C 800CDA1C 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE220 800CDA20 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE224 800CDA24 00004CA4 */  sh         $t4, 0x0($v0)
    /* BE228 800CDA28 06004DA4 */  sh         $t5, 0x6($v0)
    /* BE22C 800CDA2C 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BE230 800CDA30 A400A227 */  addiu      $v0, $sp, 0xA4
    /* BE234 800CDA34 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE238 800CDA38 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE23C 800CDA3C 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE240 800CDA40 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE244 800CDA44 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE248 800CDA48 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE24C 800CDA4C 00000000 */  nop
    /* BE250 800CDA50 00000000 */  nop
    /* BE254 800CDA54 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE258 800CDA58 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE25C 800CDA5C 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE260 800CDA60 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE264 800CDA64 00004CA4 */  sh         $t4, 0x0($v0)
    /* BE268 800CDA68 06004DA4 */  sh         $t5, 0x6($v0)
    /* BE26C 800CDA6C 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BE270 800CDA70 00006C8C */  lw         $t4, 0x0($v1)
    /* BE274 800CDA74 04006D8C */  lw         $t5, 0x4($v1)
    /* BE278 800CDA78 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BE27C 800CDA7C 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BE280 800CDA80 08006C8C */  lw         $t4, 0x8($v1)
    /* BE284 800CDA84 0C006D8C */  lw         $t5, 0xC($v1)
    /* BE288 800CDA88 10006E8C */  lw         $t6, 0x10($v1)
    /* BE28C 800CDA8C 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BE290 800CDA90 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BE294 800CDA94 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BE298 800CDA98 00002C96 */  lhu        $t4, 0x0($s1)
    /* BE29C 800CDA9C 06002D96 */  lhu        $t5, 0x6($s1)
    /* BE2A0 800CDAA0 0C002E96 */  lhu        $t6, 0xC($s1)
    /* BE2A4 800CDAA4 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE2A8 800CDAA8 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE2AC 800CDAAC 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE2B0 800CDAB0 00000000 */  nop
    /* BE2B4 800CDAB4 00000000 */  nop
    /* BE2B8 800CDAB8 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE2BC 800CDABC 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE2C0 800CDAC0 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE2C4 800CDAC4 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE2C8 800CDAC8 00002CA6 */  sh         $t4, 0x0($s1)
    /* BE2CC 800CDACC 06002DA6 */  sh         $t5, 0x6($s1)
    /* BE2D0 800CDAD0 0C002EA6 */  sh         $t6, 0xC($s1)
    /* BE2D4 800CDAD4 6200A227 */  addiu      $v0, $sp, 0x62
    /* BE2D8 800CDAD8 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE2DC 800CDADC 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE2E0 800CDAE0 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE2E4 800CDAE4 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE2E8 800CDAE8 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE2EC 800CDAEC 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE2F0 800CDAF0 00000000 */  nop
    /* BE2F4 800CDAF4 00000000 */  nop
    /* BE2F8 800CDAF8 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE2FC 800CDAFC 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE300 800CDB00 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE304 800CDB04 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE308 800CDB08 00004CA4 */  sh         $t4, 0x0($v0)
    /* BE30C 800CDB0C 06004DA4 */  sh         $t5, 0x6($v0)
    /* BE310 800CDB10 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BE314 800CDB14 6400A227 */  addiu      $v0, $sp, 0x64
    /* BE318 800CDB18 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE31C 800CDB1C 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE320 800CDB20 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE324 800CDB24 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE328 800CDB28 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE32C 800CDB2C 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE330 800CDB30 00000000 */  nop
    /* BE334 800CDB34 00000000 */  nop
    /* BE338 800CDB38 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE33C 800CDB3C 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE340 800CDB40 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE344 800CDB44 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE348 800CDB48 00004CA4 */  sh         $t4, 0x0($v0)
    /* BE34C 800CDB4C 06004DA4 */  sh         $t5, 0x6($v0)
    /* BE350 800CDB50 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BE354 800CDB54 00002C8E */  lw         $t4, 0x0($s1)
    /* BE358 800CDB58 04002D8E */  lw         $t5, 0x4($s1)
    /* BE35C 800CDB5C 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BE360 800CDB60 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BE364 800CDB64 08002C8E */  lw         $t4, 0x8($s1)
    /* BE368 800CDB68 0C002D8E */  lw         $t5, 0xC($s1)
    /* BE36C 800CDB6C 10002E8E */  lw         $t6, 0x10($s1)
    /* BE370 800CDB70 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BE374 800CDB74 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BE378 800CDB78 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BE37C 800CDB7C 6A370308 */  j          .L800CDDA8
    /* BE380 800CDB80 800C822A */   slti      $v0, $s4, 0xC80
  .L800CDB84:
    /* BE384 800CDB84 2E004010 */  beqz       $v0, .L800CDC40
    /* BE388 800CDB88 6000A427 */   addiu     $a0, $sp, 0x60
    /* BE38C 800CDB8C 7000A527 */  addiu      $a1, $sp, 0x70
    /* BE390 800CDB90 1800A28F */  lw         $v0, 0x18($sp)
    /* BE394 800CDB94 4800A38F */  lw         $v1, 0x48($sp)
    /* BE398 800CDB98 4C00A68F */  lw         $a2, 0x4C($sp)
    /* BE39C 800CDB9C 5000A78F */  lw         $a3, 0x50($sp)
    /* BE3A0 800CDBA0 23104300 */  subu       $v0, $v0, $v1
    /* BE3A4 800CDBA4 6000A2AF */  sw         $v0, 0x60($sp)
    /* BE3A8 800CDBA8 1C00A28F */  lw         $v0, 0x1C($sp)
    /* BE3AC 800CDBAC 2000A38F */  lw         $v1, 0x20($sp)
    /* BE3B0 800CDBB0 23104600 */  subu       $v0, $v0, $a2
    /* BE3B4 800CDBB4 23186700 */  subu       $v1, $v1, $a3
    /* BE3B8 800CDBB8 6400A2AF */  sw         $v0, 0x64($sp)
    /* BE3BC 800CDBBC B7C6030C */  jal        VectorNormal
    /* BE3C0 800CDBC0 6800A3AF */   sw        $v1, 0x68($sp)
    /* BE3C4 800CDBC4 02006232 */  andi       $v0, $s3, 0x2
    /* BE3C8 800CDBC8 08004010 */  beqz       $v0, .L800CDBEC
    /* BE3CC 800CDBCC 00000000 */   nop
    /* BE3D0 800CDBD0 7800A38F */  lw         $v1, 0x78($sp)
    /* BE3D4 800CDBD4 00000000 */  nop
    /* BE3D8 800CDBD8 CDF06324 */  addiu      $v1, $v1, -0xF33
    /* BE3DC 800CDBDC 80100300 */  sll        $v0, $v1, 2
    /* BE3E0 800CDBE0 21104300 */  addu       $v0, $v0, $v1
    /* BE3E4 800CDBE4 80100200 */  sll        $v0, $v0, 2
    /* BE3E8 800CDBE8 7800A2AF */  sw         $v0, 0x78($sp)
  .L800CDBEC:
    /* BE3EC 800CDBEC 7800A28F */  lw         $v0, 0x78($sp)
    /* BE3F0 800CDBF0 00000000 */  nop
    /* BE3F4 800CDBF4 A8FD4324 */  addiu      $v1, $v0, -0x258
    /* BE3F8 800CDBF8 02006104 */  bgez       $v1, .L800CDC04
    /* BE3FC 800CDBFC 00000000 */   nop
    /* BE400 800CDC00 21180000 */  addu       $v1, $zero, $zero
  .L800CDC04:
    /* BE404 800CDC04 9A006010 */  beqz       $v1, .L800CDE70
    /* BE408 800CDC08 7800A3AF */   sw        $v1, 0x78($sp)
    /* BE40C 800CDC0C 2813828F */  lw         $v0, %gp_rel(gscale)($gp)
    /* BE410 800CDC10 00000000 */  nop
    /* BE414 800CDC14 18004300 */  mult       $v0, $v1
    /* BE418 800CDC18 12780000 */  mflo       $t7
    /* BE41C 800CDC1C C3120F00 */  sra        $v0, $t7, 11
    /* BE420 800CDC20 281382AF */  sw         $v0, %gp_rel(gscale)($gp)
    /* BE424 800CDC24 1E000224 */  addiu      $v0, $zero, 0x1E
    /* BE428 800CDC28 06004216 */  bne        $s2, $v0, .L800CDC44
    /* BE42C 800CDC2C 6000B027 */   addiu     $s0, $sp, 0x60
    /* BE430 800CDC30 02008106 */  bgez       $s4, .L800CDC3C
    /* BE434 800CDC34 21108002 */   addu      $v0, $s4, $zero
    /* BE438 800CDC38 03008226 */  addiu      $v0, $s4, 0x3
  .L800CDC3C:
    /* BE43C 800CDC3C 83A00200 */  sra        $s4, $v0, 2
  .L800CDC40:
    /* BE440 800CDC40 6000B027 */  addiu      $s0, $sp, 0x60
  .L800CDC44:
    /* BE444 800CDC44 2813828F */  lw         $v0, %gp_rel(gscale)($gp)
    /* BE448 800CDC48 21200002 */  addu       $a0, $s0, $zero
    /* BE44C 800CDC4C 9000A0AF */  sw         $zero, 0x90($sp)
    /* BE450 800CDC50 8400A0AF */  sw         $zero, 0x84($sp)
    /* BE454 800CDC54 8C00A0AF */  sw         $zero, 0x8C($sp)
    /* BE458 800CDC58 8000A2AF */  sw         $v0, 0x80($sp)
    /* BE45C 800CDC5C 7E2F030C */  jal        Flare_IdentMatrix__FP6MATRIX
    /* BE460 800CDC60 8800A2AF */   sw        $v0, 0x88($sp)
    /* BE464 800CDC64 1800A227 */  addiu      $v0, $sp, 0x18
    /* BE468 800CDC68 00004C8C */  lw         $t4, 0x0($v0)
    /* BE46C 800CDC6C 04004D8C */  lw         $t5, 0x4($v0)
    /* BE470 800CDC70 08004E8C */  lw         $t6, 0x8($v0)
    /* BE474 800CDC74 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BE478 800CDC78 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BE47C 800CDC7C 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BE480 800CDC80 2120A002 */  addu       $a0, $s5, $zero
    /* BE484 800CDC84 4BCC030C */  jal        RotMatrixZ
    /* BE488 800CDC88 21280002 */   addu      $a1, $s0, $zero
    /* BE48C 800CDC8C 00000C8E */  lw         $t4, 0x0($s0)
    /* BE490 800CDC90 04000D8E */  lw         $t5, 0x4($s0)
    /* BE494 800CDC94 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BE498 800CDC98 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BE49C 800CDC9C 08000C8E */  lw         $t4, 0x8($s0)
    /* BE4A0 800CDCA0 0C000D8E */  lw         $t5, 0xC($s0)
    /* BE4A4 800CDCA4 10000E8E */  lw         $t6, 0x10($s0)
    /* BE4A8 800CDCA8 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BE4AC 800CDCAC 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BE4B0 800CDCB0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BE4B4 800CDCB4 8000A227 */  addiu      $v0, $sp, 0x80
    /* BE4B8 800CDCB8 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE4BC 800CDCBC 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE4C0 800CDCC0 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE4C4 800CDCC4 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE4C8 800CDCC8 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE4CC 800CDCCC 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE4D0 800CDCD0 00000000 */  nop
    /* BE4D4 800CDCD4 00000000 */  nop
    /* BE4D8 800CDCD8 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE4DC 800CDCDC 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE4E0 800CDCE0 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE4E4 800CDCE4 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE4E8 800CDCE8 00000CA6 */  sh         $t4, 0x0($s0)
    /* BE4EC 800CDCEC 06000DA6 */  sh         $t5, 0x6($s0)
    /* BE4F0 800CDCF0 0C000EA6 */  sh         $t6, 0xC($s0)
    /* BE4F4 800CDCF4 8200A227 */  addiu      $v0, $sp, 0x82
    /* BE4F8 800CDCF8 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE4FC 800CDCFC 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE500 800CDD00 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE504 800CDD04 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE508 800CDD08 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE50C 800CDD0C 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE510 800CDD10 00000000 */  nop
    /* BE514 800CDD14 00000000 */  nop
    /* BE518 800CDD18 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE51C 800CDD1C 6200A227 */  addiu      $v0, $sp, 0x62
    /* BE520 800CDD20 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE524 800CDD24 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE528 800CDD28 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE52C 800CDD2C 00004CA4 */  sh         $t4, 0x0($v0)
    /* BE530 800CDD30 06004DA4 */  sh         $t5, 0x6($v0)
    /* BE534 800CDD34 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BE538 800CDD38 8400A227 */  addiu      $v0, $sp, 0x84
    /* BE53C 800CDD3C 00004C94 */  lhu        $t4, 0x0($v0)
    /* BE540 800CDD40 06004D94 */  lhu        $t5, 0x6($v0)
    /* BE544 800CDD44 0C004E94 */  lhu        $t6, 0xC($v0)
    /* BE548 800CDD48 00488C48 */  mtc2       $t4, $9 /* handwritten instruction */
    /* BE54C 800CDD4C 00508D48 */  mtc2       $t5, $10 /* handwritten instruction */
    /* BE550 800CDD50 00588E48 */  mtc2       $t6, $11 /* handwritten instruction */
    /* BE554 800CDD54 00000000 */  nop
    /* BE558 800CDD58 00000000 */  nop
    /* BE55C 800CDD5C 12E0494A */  .word 0x4A49E012  /* mvmva      1, 0, 3, 3, 0 */
    /* BE560 800CDD60 6400A227 */  addiu      $v0, $sp, 0x64
    /* BE564 800CDD64 00480C48 */  mfc2       $t4, $9 /* handwritten instruction */
    /* BE568 800CDD68 00500D48 */  mfc2       $t5, $10 /* handwritten instruction */
    /* BE56C 800CDD6C 00580E48 */  mfc2       $t6, $11 /* handwritten instruction */
    /* BE570 800CDD70 00004CA4 */  sh         $t4, 0x0($v0)
    /* BE574 800CDD74 06004DA4 */  sh         $t5, 0x6($v0)
    /* BE578 800CDD78 0C004EA4 */  sh         $t6, 0xC($v0)
    /* BE57C 800CDD7C 00000C8E */  lw         $t4, 0x0($s0)
    /* BE580 800CDD80 04000D8E */  lw         $t5, 0x4($s0)
    /* BE584 800CDD84 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BE588 800CDD88 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BE58C 800CDD8C 08000C8E */  lw         $t4, 0x8($s0)
    /* BE590 800CDD90 0C000D8E */  lw         $t5, 0xC($s0)
    /* BE594 800CDD94 10000E8E */  lw         $t6, 0x10($s0)
    /* BE598 800CDD98 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BE59C 800CDD9C 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BE5A0 800CDDA0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BE5A4 800CDDA4 800C822A */  slti       $v0, $s4, 0xC80
  .L800CDDA8:
    /* BE5A8 800CDDA8 06004010 */  beqz       $v0, .L800CDDC4
    /* BE5AC 800CDDAC 801B822A */   slti      $v0, $s4, 0x1B80
    /* BE5B0 800CDDB0 C000A58F */  lw         $a1, 0xC0($sp)
    /* BE5B4 800CDDB4 0D30030C */  jal        Flare_OctFlareSpikes__FPli
    /* BE5B8 800CDDB8 4000A427 */   addiu     $a0, $sp, 0x40
    /* BE5BC 800CDDBC 7F370308 */  j          .L800CDDFC
    /* BE5C0 800CDDC0 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
  .L800CDDC4:
    /* BE5C4 800CDDC4 09004010 */  beqz       $v0, .L800CDDEC
    /* BE5C8 800CDDC8 4000B027 */   addiu     $s0, $sp, 0x40
    /* BE5CC 800CDDCC C000A58F */  lw         $a1, 0xC0($sp)
    /* BE5D0 800CDDD0 A531030C */  jal        Flare_HexFlare__FPli
    /* BE5D4 800CDDD4 21200002 */   addu      $a0, $s0, $zero
    /* BE5D8 800CDDD8 C000A58F */  lw         $a1, 0xC0($sp)
    /* BE5DC 800CDDDC D338030C */  jal        Flare_PreCalcHexLightBeam__FPli
    /* BE5E0 800CDDE0 21200002 */   addu      $a0, $s0, $zero
    /* BE5E4 800CDDE4 7F370308 */  j          .L800CDDFC
    /* BE5E8 800CDDE8 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
  .L800CDDEC:
    /* BE5EC 800CDDEC C000A58F */  lw         $a1, 0xC0($sp)
    /* BE5F0 800CDDF0 8F32030C */  jal        Flare_QuadFlare__FPli
    /* BE5F4 800CDDF4 4000A427 */   addiu     $a0, $sp, 0x40
    /* BE5F8 800CDDF8 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
  .L800CDDFC:
    /* BE5FC 800CDDFC 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BE600 800CDE00 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BE604 800CDE04 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BE608 800CDE08 21280000 */  addu       $a1, $zero, $zero
    /* BE60C 800CDE0C 40006632 */  andi       $a2, $s3, 0x40
    /* BE610 800CDE10 2B300600 */  sltu       $a2, $zero, $a2
    /* BE614 800CDE14 20010724 */  addiu      $a3, $zero, 0x120
    /* BE618 800CDE18 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BE61C 800CDE1C 0000648D */  lw         $a0, 0x0($t3)
    /* BE620 800CDE20 C000A88F */  lw         $t0, 0xC0($sp)
    /* BE624 800CDE24 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BE628 800CDE28 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BE62C 800CDE2C 80400800 */  sll        $t0, $t0, 2
    /* BE630 800CDE30 21400201 */  addu       $t0, $t0, $v0
    /* BE634 800CDE34 0000838C */  lw         $v1, 0x0($a0)
    /* BE638 800CDE38 0000028D */  lw         $v0, 0x0($t0)
    /* BE63C 800CDE3C 24186A00 */  and        $v1, $v1, $t2
    /* BE640 800CDE40 24104900 */  and        $v0, $v0, $t1
    /* BE644 800CDE44 25186200 */  or         $v1, $v1, $v0
    /* BE648 800CDE48 000083AC */  sw         $v1, 0x0($a0)
    /* BE64C 800CDE4C 0000028D */  lw         $v0, 0x0($t0)
    /* BE650 800CDE50 0C008324 */  addiu      $v1, $a0, 0xC
    /* BE654 800CDE54 000063AD */  sw         $v1, 0x0($t3)
    /* BE658 800CDE58 24188900 */  and        $v1, $a0, $t1
    /* BE65C 800CDE5C 24104A00 */  and        $v0, $v0, $t2
    /* BE660 800CDE60 25104300 */  or         $v0, $v0, $v1
    /* BE664 800CDE64 000002AD */  sw         $v0, 0x0($t0)
    /* BE668 800CDE68 EFB8030C */  jal        SetDrawMode
    /* BE66C 800CDE6C 1000A0AF */   sw        $zero, 0x10($sp)
  .L800CDE70:
    /* BE670 800CDE70 E800BF8F */  lw         $ra, 0xE8($sp)
    /* BE674 800CDE74 E400B78F */  lw         $s7, 0xE4($sp)
    /* BE678 800CDE78 E000B68F */  lw         $s6, 0xE0($sp)
    /* BE67C 800CDE7C DC00B58F */  lw         $s5, 0xDC($sp)
    /* BE680 800CDE80 D800B48F */  lw         $s4, 0xD8($sp)
    /* BE684 800CDE84 D400B38F */  lw         $s3, 0xD4($sp)
    /* BE688 800CDE88 D000B28F */  lw         $s2, 0xD0($sp)
    /* BE68C 800CDE8C CC00B18F */  lw         $s1, 0xCC($sp)
    /* BE690 800CDE90 C800B08F */  lw         $s0, 0xC8($sp)
    /* BE694 800CDE94 0800E003 */  jr         $ra
    /* BE698 800CDE98 F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
