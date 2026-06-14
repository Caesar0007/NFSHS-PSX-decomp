.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching cSNDbankremove, 0x1A0

glabel cSNDbankremove
    /* D6E94 800E6694 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D6E98 800E6698 1480023C */  lui        $v0, %hi(sndgs)
    /* D6E9C 800E669C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D6EA0 800E66A0 60785124 */  addiu      $s1, $v0, %lo(sndgs)
    /* D6EA4 800E66A4 2400BFAF */  sw         $ra, 0x24($sp)
    /* D6EA8 800E66A8 2000B4AF */  sw         $s4, 0x20($sp)
    /* D6EAC 800E66AC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D6EB0 800E66B0 1800B2AF */  sw         $s2, 0x18($sp)
    /* D6EB4 800E66B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* D6EB8 800E66B8 3C002282 */  lb         $v0, 0x3C($s1)
    /* D6EBC 800E66BC 00000000 */  nop
    /* D6EC0 800E66C0 03004014 */  bnez       $v0, .L800E66D0
    /* D6EC4 800E66C4 21988000 */   addu      $s3, $a0, $zero
    /* D6EC8 800E66C8 059A0308 */  j          .L800E6814
    /* D6ECC 800E66CC F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E66D0:
    /* D6ED0 800E66D0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* D6ED4 800E66D4 0F006216 */  bne        $s3, $v0, .L800E6714
    /* D6ED8 800E66D8 00000000 */   nop
    /* D6EDC 800E66DC 0C002296 */  lhu        $v0, 0xC($s1)
    /* D6EE0 800E66E0 00000000 */  nop
    /* D6EE4 800E66E4 09004010 */  beqz       $v0, .L800E670C
    /* D6EE8 800E66E8 21800000 */   addu      $s0, $zero, $zero
    /* D6EEC 800E66EC 21200002 */  addu       $a0, $s0, $zero
  .L800E66F0:
    /* D6EF0 800E66F0 A599030C */  jal        cSNDbankremove
    /* D6EF4 800E66F4 21280000 */   addu      $a1, $zero, $zero
    /* D6EF8 800E66F8 0C002296 */  lhu        $v0, 0xC($s1)
    /* D6EFC 800E66FC 01001026 */  addiu      $s0, $s0, 0x1
    /* D6F00 800E6700 2A100202 */  slt        $v0, $s0, $v0
    /* D6F04 800E6704 FAFF4014 */  bnez       $v0, .L800E66F0
    /* D6F08 800E6708 21200002 */   addu      $a0, $s0, $zero
  .L800E670C:
    /* D6F0C 800E670C 059A0308 */  j          .L800E6814
    /* D6F10 800E6710 21100000 */   addu      $v0, $zero, $zero
  .L800E6714:
    /* D6F14 800E6714 AFF9030C */  jal        iSNDvalidbank
    /* D6F18 800E6718 21206002 */   addu      $a0, $s3, $zero
    /* D6F1C 800E671C 3D004014 */  bnez       $v0, .L800E6814
    /* D6F20 800E6720 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* D6F24 800E6724 40101300 */  sll        $v0, $s3, 1
    /* D6F28 800E6728 21105300 */  addu       $v0, $v0, $s3
    /* D6F2C 800E672C 9800238E */  lw         $v1, 0x98($s1)
    /* D6F30 800E6730 80100200 */  sll        $v0, $v0, 2
    /* D6F34 800E6734 21104300 */  addu       $v0, $v0, $v1
    /* D6F38 800E6738 11002392 */  lbu        $v1, 0x11($s1)
    /* D6F3C 800E673C 0000548C */  lw         $s4, 0x0($v0)
    /* D6F40 800E6740 12006010 */  beqz       $v1, .L800E678C
    /* D6F44 800E6744 21800000 */   addu      $s0, $zero, $zero
    /* D6F48 800E6748 21902002 */  addu       $s2, $s1, $zero
    /* D6F4C 800E674C 21880002 */  addu       $s1, $s0, $zero
  .L800E6750:
    /* D6F50 800E6750 9400428E */  lw         $v0, 0x94($s2)
    /* D6F54 800E6754 00000000 */  nop
    /* D6F58 800E6758 21205100 */  addu       $a0, $v0, $s1
    /* D6F5C 800E675C 0A008280 */  lb         $v0, 0xA($a0)
    /* D6F60 800E6760 00000000 */  nop
    /* D6F64 800E6764 04005314 */  bne        $v0, $s3, .L800E6778
    /* D6F68 800E6768 00000000 */   nop
    /* D6F6C 800E676C 0000848C */  lw         $a0, 0x0($a0)
    /* D6F70 800E6770 A09F030C */  jal        SNDstop
    /* D6F74 800E6774 00000000 */   nop
  .L800E6778:
    /* D6F78 800E6778 11004292 */  lbu        $v0, 0x11($s2)
    /* D6F7C 800E677C 01001026 */  addiu      $s0, $s0, 0x1
    /* D6F80 800E6780 2A100202 */  slt        $v0, $s0, $v0
    /* D6F84 800E6784 F2FF4014 */  bnez       $v0, .L800E6750
    /* D6F88 800E6788 64003126 */   addiu     $s1, $s1, 0x64
  .L800E678C:
    /* D6F8C 800E678C 1480023C */  lui        $v0, %hi(sndgs)
    /* D6F90 800E6790 60785124 */  addiu      $s1, $v0, %lo(sndgs)
    /* D6F94 800E6794 40101300 */  sll        $v0, $s3, 1
    /* D6F98 800E6798 21105300 */  addu       $v0, $v0, $s3
    /* D6F9C 800E679C 9800238E */  lw         $v1, 0x98($s1)
    /* D6FA0 800E67A0 80800200 */  sll        $s0, $v0, 2
    /* D6FA4 800E67A4 21180302 */  addu       $v1, $s0, $v1
    /* D6FA8 800E67A8 09006280 */  lb         $v0, 0x9($v1)
    /* D6FAC 800E67AC 00000000 */  nop
    /* D6FB0 800E67B0 09004010 */  beqz       $v0, .L800E67D8
    /* D6FB4 800E67B4 00000000 */   nop
    /* D6FB8 800E67B8 0400648C */  lw         $a0, 0x4($v1)
    /* D6FBC 800E67BC 65F9030C */  jal        iSNDplatformfree
    /* D6FC0 800E67C0 00000000 */   nop
    /* D6FC4 800E67C4 9800228E */  lw         $v0, 0x98($s1)
    /* D6FC8 800E67C8 00000000 */  nop
    /* D6FCC 800E67CC 21100202 */  addu       $v0, $s0, $v0
    /* D6FD0 800E67D0 F9990308 */  j          .L800E67E4
    /* D6FD4 800E67D4 090040A0 */   sb        $zero, 0x9($v0)
  .L800E67D8:
    /* D6FD8 800E67D8 06008596 */  lhu        $a1, 0x6($s4)
    /* D6FDC 800E67DC 7E99030C */  jal        iSNDremovepatches
    /* D6FE0 800E67E0 21206002 */   addu      $a0, $s3, $zero
  .L800E67E4:
    /* D6FE4 800E67E4 1480043C */  lui        $a0, %hi(sndgs)
    /* D6FE8 800E67E8 60788424 */  addiu      $a0, $a0, %lo(sndgs)
    /* D6FEC 800E67EC 40181300 */  sll        $v1, $s3, 1
    /* D6FF0 800E67F0 21187300 */  addu       $v1, $v1, $s3
    /* D6FF4 800E67F4 9800828C */  lw         $v0, 0x98($a0)
    /* D6FF8 800E67F8 80180300 */  sll        $v1, $v1, 2
    /* D6FFC 800E67FC 21106200 */  addu       $v0, $v1, $v0
    /* D7000 800E6800 000040AC */  sw         $zero, 0x0($v0)
    /* D7004 800E6804 9800848C */  lw         $a0, 0x98($a0)
    /* D7008 800E6808 21100000 */  addu       $v0, $zero, $zero
    /* D700C 800E680C 21186400 */  addu       $v1, $v1, $a0
    /* D7010 800E6810 080060A0 */  sb         $zero, 0x8($v1)
  .L800E6814:
    /* D7014 800E6814 2400BF8F */  lw         $ra, 0x24($sp)
    /* D7018 800E6818 2000B48F */  lw         $s4, 0x20($sp)
    /* D701C 800E681C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D7020 800E6820 1800B28F */  lw         $s2, 0x18($sp)
    /* D7024 800E6824 1400B18F */  lw         $s1, 0x14($sp)
    /* D7028 800E6828 1000B08F */  lw         $s0, 0x10($sp)
    /* D702C 800E682C 0800E003 */  jr         $ra
    /* D7030 800E6830 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel cSNDbankremove
