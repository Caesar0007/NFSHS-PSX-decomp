.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache, 0x1F8

glabel Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
    /* CDD98 800DD598 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CDD9C 800DD59C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* CDDA0 800DD5A0 3800B18F */  lw         $s1, 0x38($sp)
    /* CDDA4 800DD5A4 2000BFAF */  sw         $ra, 0x20($sp)
    /* CDDA8 800DD5A8 1800B0AF */  sw         $s0, 0x18($sp)
    /* CDDAC 800DD5AC 0400228E */  lw         $v0, 0x4($s1)
    /* CDDB0 800DD5B0 0800238E */  lw         $v1, 0x8($s1)
    /* CDDB4 800DD5B4 00000000 */  nop
    /* CDDB8 800DD5B8 2B104300 */  sltu       $v0, $v0, $v1
    /* CDDBC 800DD5BC 6F004010 */  beqz       $v0, .L800DD77C
    /* CDDC0 800DD5C0 21408000 */   addu      $t0, $a0, $zero
    /* CDDC4 800DD5C4 0000A0C8 */  lwc2       $0, 0x0($a1)
    /* CDDC8 800DD5C8 0400A1C8 */  lwc2       $1, 0x4($a1)
    /* CDDCC 800DD5CC 00000000 */  nop
    /* CDDD0 800DD5D0 00000000 */  nop
    /* CDDD4 800DD5D4 0100184A */  .word 0x4A180001  /* rtps */
    /* CDDD8 800DD5D8 801F103C */  lui        $s0, (0x1F800004 >> 16)
    /* CDDDC 800DD5DC 0400108E */  lw         $s0, (0x1F800004 & 0xFFFF)($s0)
    /* CDDE0 800DD5E0 00000000 */  nop
    /* CDDE4 800DD5E4 08000226 */  addiu      $v0, $s0, 0x8
    /* CDDE8 800DD5E8 00004EE8 */  swc2       $14, 0x0($v0)
    /* CDDEC 800DD5EC 0800A424 */  addiu      $a0, $a1, 0x8
    /* CDDF0 800DD5F0 1000A324 */  addiu      $v1, $a1, 0x10
    /* CDDF4 800DD5F4 1800A224 */  addiu      $v0, $a1, 0x18
    /* CDDF8 800DD5F8 000080C8 */  lwc2       $0, 0x0($a0)
    /* CDDFC 800DD5FC 040081C8 */  lwc2       $1, 0x4($a0)
    /* CDE00 800DD600 000062C8 */  lwc2       $2, 0x0($v1)
    /* CDE04 800DD604 040063C8 */  lwc2       $3, 0x4($v1)
    /* CDE08 800DD608 000044C8 */  lwc2       $4, 0x0($v0)
    /* CDE0C 800DD60C 040045C8 */  lwc2       $5, 0x4($v0)
    /* CDE10 800DD610 00000000 */  nop
    /* CDE14 800DD614 00000000 */  nop
    /* CDE18 800DD618 3000284A */  .word 0x4A280030  /* rtpt */
    /* CDE1C 800DD61C 0200C230 */  andi       $v0, $a2, 0x2
    /* CDE20 800DD620 03004010 */  beqz       $v0, .L800DD630
    /* CDE24 800DD624 582E023C */   lui       $v0, (0x2E5898B8 >> 16)
    /* CDE28 800DD628 95750308 */  j          .L800DD654
    /* CDE2C 800DD62C B8984234 */   ori       $v0, $v0, (0x2E5898B8 & 0xFFFF)
  .L800DD630:
    /* CDE30 800DD630 1180023C */  lui        $v0, %hi(D_80113240)
    /* CDE34 800DD634 4032428C */  lw         $v0, %lo(D_80113240)($v0)
    /* CDE38 800DD638 00000000 */  nop
    /* CDE3C 800DD63C 03004014 */  bnez       $v0, .L800DD64C
    /* CDE40 800DD640 182E023C */   lui       $v0, (0x2E181818 >> 16)
    /* CDE44 800DD644 95750308 */  j          .L800DD654
    /* CDE48 800DD648 18184234 */   ori       $v0, $v0, (0x2E181818 & 0xFFFF)
  .L800DD64C:
    /* CDE4C 800DD64C 082E023C */  lui        $v0, (0x2E080808 >> 16)
    /* CDE50 800DD650 08084234 */  ori        $v0, $v0, (0x2E080808 & 0xFFFF)
  .L800DD654:
    /* CDE54 800DD654 040002AE */  sw         $v0, 0x4($s0)
    /* CDE58 800DD658 10000426 */  addiu      $a0, $s0, 0x10
    /* CDE5C 800DD65C 20000326 */  addiu      $v1, $s0, 0x20
    /* CDE60 800DD660 18000226 */  addiu      $v0, $s0, 0x18
    /* CDE64 800DD664 00008CE8 */  swc2       $12, 0x0($a0)
    /* CDE68 800DD668 00006DE8 */  swc2       $13, 0x0($v1)
    /* CDE6C 800DD66C 00004EE8 */  swc2       $14, 0x0($v0)
    /* CDE70 800DD670 00000000 */  nop
    /* CDE74 800DD674 00000000 */  nop
    /* CDE78 800DD678 2E00684B */  .word 0x4B68002E  /* avsz4 */
    /* CDE7C 800DD67C 14002226 */  addiu      $v0, $s1, 0x14
    /* CDE80 800DD680 000047E8 */  swc2       $7, 0x0($v0)
    /* CDE84 800DD684 1400228E */  lw         $v0, 0x14($s1)
    /* CDE88 800DD688 00000000 */  nop
    /* CDE8C 800DD68C 43100200 */  sra        $v0, $v0, 1
    /* CDE90 800DD690 21384700 */  addu       $a3, $v0, $a3
    /* CDE94 800DD694 3900E004 */  bltz       $a3, .L800DD77C
    /* CDE98 800DD698 140027AE */   sw        $a3, 0x14($s1)
    /* CDE9C 800DD69C 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* CDEA0 800DD6A0 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* CDEA4 800DD6A4 00000000 */  nop
    /* CDEA8 800DD6A8 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* CDEAC 800DD6AC 2A104700 */  slt        $v0, $v0, $a3
    /* CDEB0 800DD6B0 32004014 */  bnez       $v0, .L800DD77C
    /* CDEB4 800DD6B4 09000224 */   addiu     $v0, $zero, 0x9
    /* CDEB8 800DD6B8 030002A2 */  sb         $v0, 0x3($s0)
    /* CDEBC 800DD6BC 0000028D */  lw         $v0, 0x0($t0)
    /* CDEC0 800DD6C0 0400038D */  lw         $v1, 0x4($t0)
    /* CDEC4 800DD6C4 0800048D */  lw         $a0, 0x8($t0)
    /* CDEC8 800DD6C8 0C00058D */  lw         $a1, 0xC($t0)
    /* CDECC 800DD6CC 0C0002AE */  sw         $v0, 0xC($s0)
    /* CDED0 800DD6D0 140003AE */  sw         $v1, 0x14($s0)
    /* CDED4 800DD6D4 1C0004AE */  sw         $a0, 0x1C($s0)
    /* CDED8 800DD6D8 240005AE */  sw         $a1, 0x24($s0)
    /* CDEDC 800DD6DC 06000295 */  lhu        $v0, 0x6($t0)
    /* CDEE0 800DD6E0 00000000 */  nop
    /* CDEE4 800DD6E4 1000A2A7 */  sh         $v0, 0x10($sp)
    /* CDEE8 800DD6E8 0100C230 */  andi       $v0, $a2, 0x1
    /* CDEEC 800DD6EC 03004010 */  beqz       $v0, .L800DD6FC
    /* CDEF0 800DD6F0 1000A427 */   addiu     $a0, $sp, 0x10
    /* CDEF4 800DD6F4 C0750308 */  j          .L800DD700
    /* CDEF8 800DD6F8 02000524 */   addiu     $a1, $zero, 0x2
  .L800DD6FC:
    /* CDEFC 800DD6FC 01000524 */  addiu      $a1, $zero, 0x1
  .L800DD700:
    /* CDF00 800DD700 B4F9020C */  jal        ChangeTPage__FPUsi
    /* CDF04 800DD704 00000000 */   nop
    /* CDF08 800DD708 801F083C */  lui        $t0, (0x1F800004 >> 16)
    /* CDF0C 800DD70C 04000835 */  ori        $t0, $t0, (0x1F800004 & 0xFFFF)
    /* CDF10 800DD710 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* CDF14 800DD714 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* CDF18 800DD718 1000A297 */  lhu        $v0, 0x10($sp)
    /* CDF1C 800DD71C 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* CDF20 800DD720 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* CDF24 800DD724 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* CDF28 800DD728 160002A6 */  sh         $v0, 0x16($s0)
    /* CDF2C 800DD72C 1400228E */  lw         $v0, 0x14($s1)
    /* CDF30 800DD730 0000108D */  lw         $s0, 0x0($t0)
    /* CDF34 800DD734 80100200 */  sll        $v0, $v0, 2
    /* CDF38 800DD738 21104600 */  addu       $v0, $v0, $a2
    /* CDF3C 800DD73C 0000038E */  lw         $v1, 0x0($s0)
    /* CDF40 800DD740 0000428C */  lw         $v0, 0x0($v0)
    /* CDF44 800DD744 24186700 */  and        $v1, $v1, $a3
    /* CDF48 800DD748 24104500 */  and        $v0, $v0, $a1
    /* CDF4C 800DD74C 25186200 */  or         $v1, $v1, $v0
    /* CDF50 800DD750 000003AE */  sw         $v1, 0x0($s0)
    /* CDF54 800DD754 1400248E */  lw         $a0, 0x14($s1)
    /* CDF58 800DD758 28000326 */  addiu      $v1, $s0, 0x28
    /* CDF5C 800DD75C 80200400 */  sll        $a0, $a0, 2
    /* CDF60 800DD760 21208600 */  addu       $a0, $a0, $a2
    /* CDF64 800DD764 0000828C */  lw         $v0, 0x0($a0)
    /* CDF68 800DD768 24280502 */  and        $a1, $s0, $a1
    /* CDF6C 800DD76C 000003AD */  sw         $v1, 0x0($t0)
    /* CDF70 800DD770 24104700 */  and        $v0, $v0, $a3
    /* CDF74 800DD774 25104500 */  or         $v0, $v0, $a1
    /* CDF78 800DD778 000082AC */  sw         $v0, 0x0($a0)
  .L800DD77C:
    /* CDF7C 800DD77C 2000BF8F */  lw         $ra, 0x20($sp)
    /* CDF80 800DD780 1C00B18F */  lw         $s1, 0x1C($sp)
    /* CDF84 800DD784 1800B08F */  lw         $s0, 0x18($sp)
    /* CDF88 800DD788 0800E003 */  jr         $ra
    /* CDF8C 800DD78C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache
