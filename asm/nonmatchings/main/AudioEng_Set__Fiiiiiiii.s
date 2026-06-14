.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_Set__Fiiiiiiii, 0x27C

glabel AudioEng_Set__Fiiiiiiii
    /* 6BDA8 8007B5A8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 6BDAC 8007B5AC 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 6BDB0 8007B5B0 21B8A000 */  addu       $s7, $a1, $zero
    /* 6BDB4 8007B5B4 2400B5AF */  sw         $s5, 0x24($sp)
    /* 6BDB8 8007B5B8 4800B58F */  lw         $s5, 0x48($sp)
    /* 6BDBC 8007B5BC 4C00A58F */  lw         $a1, 0x4C($sp)
    /* 6BDC0 8007B5C0 2800B6AF */  sw         $s6, 0x28($sp)
    /* 6BDC4 8007B5C4 5000B68F */  lw         $s6, 0x50($sp)
    /* 6BDC8 8007B5C8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 6BDCC 8007B5CC 2198E000 */  addu       $s3, $a3, $zero
    /* 6BDD0 8007B5D0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 6BDD4 8007B5D4 5400B48F */  lw         $s4, 0x54($sp)
    /* 6BDD8 8007B5D8 0200822C */  sltiu      $v0, $a0, 0x2
    /* 6BDDC 8007B5DC 3000BFAF */  sw         $ra, 0x30($sp)
    /* 6BDE0 8007B5E0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6BDE4 8007B5E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6BDE8 8007B5E8 83004010 */  beqz       $v0, .L8007B7F8
    /* 6BDEC 8007B5EC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6BDF0 8007B5F0 80200400 */  sll        $a0, $a0, 2
    /* 6BDF4 8007B5F4 1480023C */  lui        $v0, %hi(AudioEng_g)
    /* 6BDF8 8007B5F8 34C74224 */  addiu      $v0, $v0, %lo(AudioEng_g)
    /* 6BDFC 8007B5FC 21108200 */  addu       $v0, $a0, $v0
    /* 6BE00 8007B600 0000518C */  lw         $s1, 0x0($v0)
    /* 6BE04 8007B604 00000000 */  nop
    /* 6BE08 8007B608 7B002012 */  beqz       $s1, .L8007B7F8
    /* 6BE0C 8007B60C 0F000224 */   addiu     $v0, $zero, 0xF
    /* 6BE10 8007B610 1B012392 */  lbu        $v1, 0x11B($s1)
    /* 6BE14 8007B614 00000000 */  nop
    /* 6BE18 8007B618 07006214 */  bne        $v1, $v0, .L8007B638
    /* 6BE1C 8007B61C 21902002 */   addu      $s2, $s1, $zero
    /* 6BE20 8007B620 1A012292 */  lbu        $v0, 0x11A($s1)
    /* 6BE24 8007B624 00000000 */  nop
    /* 6BE28 8007B628 01004224 */  addiu      $v0, $v0, 0x1
    /* 6BE2C 8007B62C 01004230 */  andi       $v0, $v0, 0x1
    /* 6BE30 8007B630 71004014 */  bnez       $v0, .L8007B7F8
    /* 6BE34 8007B634 00000000 */   nop
  .L8007B638:
    /* 6BE38 8007B638 07002292 */  lbu        $v0, 0x7($s1)
    /* 6BE3C 8007B63C 00000000 */  nop
    /* 6BE40 8007B640 18004600 */  mult       $v0, $a2
    /* 6BE44 8007B644 1A012392 */  lbu        $v1, 0x11A($s1)
    /* 6BE48 8007B648 00000000 */  nop
    /* 6BE4C 8007B64C 40100300 */  sll        $v0, $v1, 1
    /* 6BE50 8007B650 21104300 */  addu       $v0, $v0, $v1
    /* 6BE54 8007B654 80100200 */  sll        $v0, $v0, 2
    /* 6BE58 8007B658 5A004224 */  addiu      $v0, $v0, 0x5A
    /* 6BE5C 8007B65C 21802202 */  addu       $s0, $s1, $v0
    /* 6BE60 8007B660 12400000 */  mflo       $t0
    /* 6BE64 8007B664 831B0800 */  sra        $v1, $t0, 14
    /* 6BE68 8007B668 00026228 */  slti       $v0, $v1, 0x200
    /* 6BE6C 8007B66C 02004010 */  beqz       $v0, .L8007B678
    /* 6BE70 8007B670 FF010724 */   addiu     $a3, $zero, 0x1FF
    /* 6BE74 8007B674 21386000 */  addu       $a3, $v1, $zero
  .L8007B678:
    /* 6BE78 8007B678 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 6BE7C 8007B67C DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 6BE80 8007B680 21108200 */  addu       $v0, $a0, $v0
    /* 6BE84 8007B684 080007A6 */  sh         $a3, 0x8($s0)
    /* 6BE88 8007B688 0000428C */  lw         $v0, 0x0($v0)
    /* 6BE8C 8007B68C 00000000 */  nop
    /* 6BE90 8007B690 8802428C */  lw         $v0, 0x288($v0)
    /* 6BE94 8007B694 00000000 */  nop
    /* 6BE98 8007B698 0000438C */  lw         $v1, 0x0($v0)
    /* 6BE9C 8007B69C 1C000224 */  addiu      $v0, $zero, 0x1C
    /* 6BEA0 8007B6A0 04006214 */  bne        $v1, $v0, .L8007B6B4
    /* 6BEA4 8007B6A4 83100600 */   sra       $v0, $a2, 2
    /* 6BEA8 8007B6A8 00C00434 */  ori        $a0, $zero, 0xC000
    /* 6BEAC 8007B6AC AEED0108 */  j          .L8007B6B8
    /* 6BEB0 8007B6B0 21204400 */   addu      $a0, $v0, $a0
  .L8007B6B4:
    /* 6BEB4 8007B6B4 3333C424 */  addiu      $a0, $a2, 0x3333
  .L8007B6B8:
    /* 6BEB8 8007B6B8 CA90030C */  jal        fixedmult
    /* 6BEBC 8007B6BC 00000000 */   nop
    /* 6BEC0 8007B6C0 06002392 */  lbu        $v1, 0x6($s1)
    /* 6BEC4 8007B6C4 00000000 */  nop
    /* 6BEC8 8007B6C8 18006200 */  mult       $v1, $v0
    /* 6BECC 8007B6CC 12400000 */  mflo       $t0
    /* 6BED0 8007B6D0 83120800 */  sra        $v0, $t0, 10
    /* 6BED4 8007B6D4 020002A6 */  sh         $v0, 0x2($s0)
    /* 6BED8 8007B6D8 43111300 */  sra        $v0, $s3, 5
    /* 6BEDC 8007B6DC 21106202 */  addu       $v0, $s3, $v0
    /* 6BEE0 8007B6E0 83191300 */  sra        $v1, $s3, 6
    /* 6BEE4 8007B6E4 21184300 */  addu       $v1, $v0, $v1
    /* 6BEE8 8007B6E8 81006228 */  slti       $v0, $v1, 0x81
    /* 6BEEC 8007B6EC 03004010 */  beqz       $v0, .L8007B6FC
    /* 6BEF0 8007B6F0 80000224 */   addiu     $v0, $zero, 0x80
    /* 6BEF4 8007B6F4 C0ED0108 */  j          .L8007B700
    /* 6BEF8 8007B6F8 0B0003A2 */   sb        $v1, 0xB($s0)
  .L8007B6FC:
    /* 6BEFC 8007B6FC 0B0002A2 */  sb         $v0, 0xB($s0)
  .L8007B700:
    /* 6BF00 8007B700 1100A016 */  bnez       $s5, .L8007B748
    /* 6BF04 8007B704 00000000 */   nop
    /* 6BF08 8007B708 01004292 */  lbu        $v0, 0x1($s2)
    /* 6BF0C 8007B70C 00000000 */  nop
    /* 6BF10 8007B710 0A0002A2 */  sb         $v0, 0xA($s0)
    /* 6BF14 8007B714 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 6BF18 8007B718 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 6BF1C 8007B71C 01000224 */  addiu      $v0, $zero, 0x1
    /* 6BF20 8007B720 04006214 */  bne        $v1, $v0, .L8007B734
    /* 6BF24 8007B724 FF3F0224 */   addiu     $v0, $zero, 0x3FFF
    /* 6BF28 8007B728 060000A6 */  sh         $zero, 0x6($s0)
    /* 6BF2C 8007B72C CFED0108 */  j          .L8007B73C
    /* 6BF30 8007B730 040016A6 */   sh        $s6, 0x4($s0)
  .L8007B734:
    /* 6BF34 8007B734 040000A6 */  sh         $zero, 0x4($s0)
    /* 6BF38 8007B738 060002A6 */  sh         $v0, 0x6($s0)
  .L8007B73C:
    /* 6BF3C 8007B73C 00004292 */  lbu        $v0, 0x0($s2)
    /* 6BF40 8007B740 F2ED0108 */  j          .L8007B7C8
    /* 6BF44 8007B744 1800E202 */   mult      $s7, $v0
  .L8007B748:
    /* 6BF48 8007B748 02004292 */  lbu        $v0, 0x2($s2)
    /* 6BF4C 8007B74C 08008106 */  bgez       $s4, .L8007B770
    /* 6BF50 8007B750 0A0002A2 */   sb        $v0, 0xA($s0)
    /* 6BF54 8007B754 03004292 */  lbu        $v0, 0x3($s2)
    /* 6BF58 8007B758 00000000 */  nop
    /* 6BF5C 8007B75C 18008202 */  mult       $s4, $v0
    /* 6BF60 8007B760 12400000 */  mflo       $t0
    /* 6BF64 8007B764 0A000492 */  lbu        $a0, 0xA($s0)
    /* 6BF68 8007B768 E4ED0108 */  j          .L8007B790
    /* 6BF6C 8007B76C 18000401 */   mult      $t0, $a0
  .L8007B770:
    /* 6BF70 8007B770 04004292 */  lbu        $v0, 0x4($s2)
    /* 6BF74 8007B774 00000000 */  nop
    /* 6BF78 8007B778 18008202 */  mult       $s4, $v0
    /* 6BF7C 8007B77C 0A000492 */  lbu        $a0, 0xA($s0)
    /* 6BF80 8007B780 12400000 */  mflo       $t0
    /* 6BF84 8007B784 80000224 */  addiu      $v0, $zero, 0x80
    /* 6BF88 8007B788 23104400 */  subu       $v0, $v0, $a0
    /* 6BF8C 8007B78C 18000201 */  mult       $t0, $v0
  .L8007B790:
    /* 6BF90 8007B790 12400000 */  mflo       $t0
    /* 6BF94 8007B794 C3190800 */  sra        $v1, $t0, 7
    /* 6BF98 8007B798 04006104 */  bgez       $v1, .L8007B7AC
    /* 6BF9C 8007B79C 03140300 */   sra       $v0, $v1, 16
    /* 6BFA0 8007B7A0 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 6BFA4 8007B7A4 21186200 */  addu       $v1, $v1, $v0
    /* 6BFA8 8007B7A8 03140300 */  sra        $v0, $v1, 16
  .L8007B7AC:
    /* 6BFAC 8007B7AC 21108200 */  addu       $v0, $a0, $v0
    /* 6BFB0 8007B7B0 0A0002A2 */  sb         $v0, 0xA($s0)
    /* 6BFB4 8007B7B4 040016A6 */  sh         $s6, 0x4($s0)
    /* 6BFB8 8007B7B8 060000A6 */  sh         $zero, 0x6($s0)
    /* 6BFBC 8007B7BC 05004292 */  lbu        $v0, 0x5($s2)
    /* 6BFC0 8007B7C0 00000000 */  nop
    /* 6BFC4 8007B7C4 1800E202 */  mult       $s7, $v0
  .L8007B7C8:
    /* 6BFC8 8007B7C8 12400000 */  mflo       $t0
    /* 6BFCC 8007B7CC 83290800 */  sra        $a1, $t0, 6
    /* 6BFD0 8007B7D0 0008A228 */  slti       $v0, $a1, 0x800
    /* 6BFD4 8007B7D4 02004010 */  beqz       $v0, .L8007B7E0
    /* 6BFD8 8007B7D8 FF070324 */   addiu     $v1, $zero, 0x7FF
    /* 6BFDC 8007B7DC 2118A000 */  addu       $v1, $a1, $zero
  .L8007B7E0:
    /* 6BFE0 8007B7E0 000003A6 */  sh         $v1, 0x0($s0)
    /* 6BFE4 8007B7E4 1A012292 */  lbu        $v0, 0x11A($s1)
    /* 6BFE8 8007B7E8 00000000 */  nop
    /* 6BFEC 8007B7EC 01004224 */  addiu      $v0, $v0, 0x1
    /* 6BFF0 8007B7F0 0F004230 */  andi       $v0, $v0, 0xF
    /* 6BFF4 8007B7F4 1A0122A2 */  sb         $v0, 0x11A($s1)
  .L8007B7F8:
    /* 6BFF8 8007B7F8 3000BF8F */  lw         $ra, 0x30($sp)
    /* 6BFFC 8007B7FC 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 6C000 8007B800 2800B68F */  lw         $s6, 0x28($sp)
    /* 6C004 8007B804 2400B58F */  lw         $s5, 0x24($sp)
    /* 6C008 8007B808 2000B48F */  lw         $s4, 0x20($sp)
    /* 6C00C 8007B80C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 6C010 8007B810 1800B28F */  lw         $s2, 0x18($sp)
    /* 6C014 8007B814 1400B18F */  lw         $s1, 0x14($sp)
    /* 6C018 8007B818 1000B08F */  lw         $s0, 0x10($sp)
    /* 6C01C 8007B81C 0800E003 */  jr         $ra
    /* 6C020 8007B820 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AudioEng_Set__Fiiiiiiii
