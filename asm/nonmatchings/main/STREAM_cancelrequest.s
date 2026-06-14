.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching STREAM_cancelrequest, 0x2B4

glabel STREAM_cancelrequest
    /* EDD54 800FD554 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* EDD58 800FD558 1800B0AF */  sw         $s0, 0x18($sp)
    /* EDD5C 800FD55C 2180A000 */  addu       $s0, $a1, $zero
    /* EDD60 800FD560 1000A527 */  addiu      $a1, $sp, 0x10
    /* EDD64 800FD564 1400A627 */  addiu      $a2, $sp, 0x14
    /* EDD68 800FD568 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* EDD6C 800FD56C 3800BEAF */  sw         $fp, 0x38($sp)
    /* EDD70 800FD570 3400B7AF */  sw         $s7, 0x34($sp)
    /* EDD74 800FD574 3000B6AF */  sw         $s6, 0x30($sp)
    /* EDD78 800FD578 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* EDD7C 800FD57C 2800B4AF */  sw         $s4, 0x28($sp)
    /* EDD80 800FD580 2400B3AF */  sw         $s3, 0x24($sp)
    /* EDD84 800FD584 2000B2AF */  sw         $s2, 0x20($sp)
    /* EDD88 800FD588 BEF0030C */  jal        func_800FC2F8
    /* EDD8C 800FD58C 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* EDD90 800FD590 91004014 */  bnez       $v0, .L800FD7D8
    /* EDD94 800FD594 00000000 */   nop
    /* EDD98 800FD598 00601240 */  mfc0       $s2, $12 /* handwritten instruction */
    /* EDD9C 800FD59C 00000000 */  nop
    /* EDDA0 800FD5A0 FEFB0124 */  addiu      $at, $zero, -0x402
    /* EDDA4 800FD5A4 24404102 */  and        $t0, $s2, $at
    /* EDDA8 800FD5A8 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* EDDAC 800FD5AC 00000000 */  nop
    /* EDDB0 800FD5B0 00000000 */  nop
    /* EDDB4 800FD5B4 00000000 */  nop
    /* EDDB8 800FD5B8 1000A48F */  lw         $a0, 0x10($sp)
    /* EDDBC 800FD5BC 39F1030C */  jal        func_800FC4E4
    /* EDDC0 800FD5C0 21280002 */   addu      $a1, $s0, $zero
    /* EDDC4 800FD5C4 21284000 */  addu       $a1, $v0, $zero
    /* EDDC8 800FD5C8 0A00A010 */  beqz       $a1, .L800FD5F4
    /* EDDCC 800FD5CC 04000424 */   addiu     $a0, $zero, 0x4
    /* EDDD0 800FD5D0 0400A28C */  lw         $v0, 0x4($a1)
    /* EDDD4 800FD5D4 00000000 */  nop
    /* EDDD8 800FD5D8 06004410 */  beq        $v0, $a0, .L800FD5F4
    /* EDDDC 800FD5DC 01000624 */   addiu     $a2, $zero, 0x1
    /* EDDE0 800FD5E0 06004614 */  bne        $v0, $a2, .L800FD5FC
    /* EDDE4 800FD5E4 00000000 */   nop
    /* EDDE8 800FD5E8 1000A48F */  lw         $a0, 0x10($sp)
    /* EDDEC 800FD5EC 52F1030C */  jal        func_800FC548
    /* EDDF0 800FD5F0 00000000 */   nop
  .L800FD5F4:
    /* EDDF4 800FD5F4 93F50308 */  j          .L800FD64C
    /* EDDF8 800FD5F8 01000224 */   addiu     $v0, $zero, 0x1
  .L800FD5FC:
    /* EDDFC 800FD5FC 1000A38F */  lw         $v1, 0x10($sp)
    /* EDE00 800FD600 0400A4AC */  sw         $a0, 0x4($a1)
    /* EDE04 800FD604 4000778C */  lw         $s7, 0x40($v1)
    /* EDE08 800FD608 4C00628C */  lw         $v0, 0x4C($v1)
    /* EDE0C 800FD60C 00000000 */  nop
    /* EDE10 800FD610 0200A210 */  beq        $a1, $v0, .L800FD61C
    /* EDE14 800FD614 21A0E002 */   addu      $s4, $s7, $zero
    /* EDE18 800FD618 6000B48C */  lw         $s4, 0x60($a1)
  .L800FD61C:
    /* EDE1C 800FD61C 0C00A58C */  lw         $a1, 0xC($a1)
    /* EDE20 800FD620 00000000 */  nop
    /* EDE24 800FD624 0500A010 */  beqz       $a1, .L800FD63C
    /* EDE28 800FD628 00000000 */   nop
    /* EDE2C 800FD62C 0400A28C */  lw         $v0, 0x4($a1)
    /* EDE30 800FD630 00000000 */  nop
    /* EDE34 800FD634 04004614 */  bne        $v0, $a2, .L800FD648
    /* EDE38 800FD638 21100000 */   addu      $v0, $zero, $zero
  .L800FD63C:
    /* EDE3C 800FD63C 4400768C */  lw         $s6, 0x44($v1)
    /* EDE40 800FD640 93F50308 */  j          .L800FD64C
    /* EDE44 800FD644 21100000 */   addu      $v0, $zero, $zero
  .L800FD648:
    /* EDE48 800FD648 6000B68C */  lw         $s6, 0x60($a1)
  .L800FD64C:
    /* EDE4C 800FD64C 00609240 */  mtc0       $s2, $12 /* handwritten instruction */
    /* EDE50 800FD650 61004014 */  bnez       $v0, .L800FD7D8
    /* EDE54 800FD654 00000000 */   nop
    /* EDE58 800FD658 1000A38F */  lw         $v1, 0x10($sp)
    /* EDE5C 800FD65C 00000000 */  nop
    /* EDE60 800FD660 1C00628C */  lw         $v0, 0x1C($v1)
    /* EDE64 800FD664 00000000 */  nop
    /* EDE68 800FD668 5B004018 */  blez       $v0, .L800FD7D8
    /* EDE6C 800FD66C 21980000 */   addu      $s3, $zero, $zero
    /* EDE70 800FD670 FFFF1E24 */  addiu      $fp, $zero, -0x1
  .L800FD674:
    /* EDE74 800FD674 1800628C */  lw         $v0, 0x18($v1)
    /* EDE78 800FD678 00191300 */  sll        $v1, $s3, 4
    /* EDE7C 800FD67C 21184300 */  addu       $v1, $v0, $v1
    /* EDE80 800FD680 0800628C */  lw         $v0, 0x8($v1)
    /* EDE84 800FD684 00000000 */  nop
    /* EDE88 800FD688 4C004018 */  blez       $v0, .L800FD7BC
    /* EDE8C 800FD68C 1400A3AF */   sw        $v1, 0x14($sp)
    /* EDE90 800FD690 2120E002 */  addu       $a0, $s7, $zero
    /* EDE94 800FD694 0C00668C */  lw         $a2, 0xC($v1)
    /* EDE98 800FD698 CDF0030C */  jal        func_800FC334
    /* EDE9C 800FD69C 21288002 */   addu      $a1, $s4, $zero
    /* EDEA0 800FD6A0 30004010 */  beqz       $v0, .L800FD764
    /* EDEA4 800FD6A4 21808002 */   addu      $s0, $s4, $zero
    /* EDEA8 800FD6A8 1400A28F */  lw         $v0, 0x14($sp)
    /* EDEAC 800FD6AC 00000000 */  nop
    /* EDEB0 800FD6B0 0400428C */  lw         $v0, 0x4($v0)
    /* EDEB4 800FD6B4 41009612 */  beq        $s4, $s6, .L800FD7BC
    /* EDEB8 800FD6B8 00AE0200 */   sll       $s5, $v0, 24
  .L800FD6BC:
    /* EDEBC 800FD6BC 0000028E */  lw         $v0, 0x0($s0)
    /* EDEC0 800FD6C0 00000000 */  nop
    /* EDEC4 800FD6C4 06005E14 */  bne        $v0, $fp, .L800FD6E0
    /* EDEC8 800FD6C8 FF00023C */   lui       $v0, (0xFFFFFF >> 16)
    /* EDECC 800FD6CC 1000A28F */  lw         $v0, 0x10($sp)
    /* EDED0 800FD6D0 00000000 */  nop
    /* EDED4 800FD6D4 2000508C */  lw         $s0, 0x20($v0)
    /* EDED8 800FD6D8 D5F50308 */  j          .L800FD754
    /* EDEDC 800FD6DC 00000000 */   nop
  .L800FD6E0:
    /* EDEE0 800FD6E0 0400038E */  lw         $v1, 0x4($s0)
    /* EDEE4 800FD6E4 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* EDEE8 800FD6E8 24886200 */  and        $s1, $v1, $v0
    /* EDEEC 800FD6EC 00FF023C */  lui        $v0, (0xFF000000 >> 16)
    /* EDEF0 800FD6F0 24186200 */  and        $v1, $v1, $v0
    /* EDEF4 800FD6F4 16007514 */  bne        $v1, $s5, .L800FD750
    /* EDEF8 800FD6F8 00000000 */   nop
    /* EDEFC 800FD6FC 00601240 */  mfc0       $s2, $12 /* handwritten instruction */
    /* EDF00 800FD700 00000000 */  nop
    /* EDF04 800FD704 FEFB0124 */  addiu      $at, $zero, -0x402
    /* EDF08 800FD708 24404102 */  and        $t0, $s2, $at
    /* EDF0C 800FD70C 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* EDF10 800FD710 00000000 */  nop
    /* EDF14 800FD714 00000000 */  nop
    /* EDF18 800FD718 00000000 */  nop
    /* EDF1C 800FD71C 1400A28F */  lw         $v0, 0x14($sp)
    /* EDF20 800FD720 00000000 */  nop
    /* EDF24 800FD724 0800438C */  lw         $v1, 0x8($v0)
    /* EDF28 800FD728 00000000 */  nop
    /* EDF2C 800FD72C 23187100 */  subu       $v1, $v1, $s1
    /* EDF30 800FD730 080043AC */  sw         $v1, 0x8($v0)
    /* EDF34 800FD734 00609240 */  mtc0       $s2, $12 /* handwritten instruction */
    /* EDF38 800FD738 1000A48F */  lw         $a0, 0x10($sp)
    /* EDF3C 800FD73C DDF0030C */  jal        func_800FC374
    /* EDF40 800FD740 21282002 */   addu      $a1, $s1, $zero
    /* EDF44 800FD744 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* EDF48 800FD748 000002AE */  sw         $v0, 0x0($s0)
    /* EDF4C 800FD74C 040011AE */  sw         $s1, 0x4($s0)
  .L800FD750:
    /* EDF50 800FD750 21801102 */  addu       $s0, $s0, $s1
  .L800FD754:
    /* EDF54 800FD754 D9FF1616 */  bne        $s0, $s6, .L800FD6BC
    /* EDF58 800FD758 00000000 */   nop
    /* EDF5C 800FD75C EFF50308 */  j          .L800FD7BC
    /* EDF60 800FD760 00000000 */   nop
  .L800FD764:
    /* EDF64 800FD764 1400A28F */  lw         $v0, 0x14($sp)
    /* EDF68 800FD768 00000000 */  nop
    /* EDF6C 800FD76C 0C00468C */  lw         $a2, 0xC($v0)
    /* EDF70 800FD770 EBF50308 */  j          .L800FD7AC
    /* EDF74 800FD774 21208002 */   addu      $a0, $s4, $zero
  .L800FD778:
    /* EDF78 800FD778 1400A48F */  lw         $a0, 0x14($sp)
    /* EDF7C 800FD77C 6BF6030C */  jal        STREAM_get
    /* EDF80 800FD780 00000000 */   nop
    /* EDF84 800FD784 1400A48F */  lw         $a0, 0x14($sp)
    /* EDF88 800FD788 B4F6030C */  jal        STREAM_release
    /* EDF8C 800FD78C 21284000 */   addu      $a1, $v0, $zero
    /* EDF90 800FD790 1400A38F */  lw         $v1, 0x14($sp)
    /* EDF94 800FD794 00000000 */  nop
    /* EDF98 800FD798 0800628C */  lw         $v0, 0x8($v1)
    /* EDF9C 800FD79C 00000000 */  nop
    /* EDFA0 800FD7A0 06004018 */  blez       $v0, .L800FD7BC
    /* EDFA4 800FD7A4 21208002 */   addu      $a0, $s4, $zero
    /* EDFA8 800FD7A8 0C00668C */  lw         $a2, 0xC($v1)
  .L800FD7AC:
    /* EDFAC 800FD7AC CDF0030C */  jal        func_800FC334
    /* EDFB0 800FD7B0 2128C002 */   addu      $a1, $s6, $zero
    /* EDFB4 800FD7B4 F0FF4014 */  bnez       $v0, .L800FD778
    /* EDFB8 800FD7B8 00000000 */   nop
  .L800FD7BC:
    /* EDFBC 800FD7BC 1000A38F */  lw         $v1, 0x10($sp)
    /* EDFC0 800FD7C0 00000000 */  nop
    /* EDFC4 800FD7C4 1C00628C */  lw         $v0, 0x1C($v1)
    /* EDFC8 800FD7C8 01007326 */  addiu      $s3, $s3, 0x1
    /* EDFCC 800FD7CC 2A106202 */  slt        $v0, $s3, $v0
    /* EDFD0 800FD7D0 A8FF4014 */  bnez       $v0, .L800FD674
    /* EDFD4 800FD7D4 00000000 */   nop
  .L800FD7D8:
    /* EDFD8 800FD7D8 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* EDFDC 800FD7DC 3800BE8F */  lw         $fp, 0x38($sp)
    /* EDFE0 800FD7E0 3400B78F */  lw         $s7, 0x34($sp)
    /* EDFE4 800FD7E4 3000B68F */  lw         $s6, 0x30($sp)
    /* EDFE8 800FD7E8 2C00B58F */  lw         $s5, 0x2C($sp)
    /* EDFEC 800FD7EC 2800B48F */  lw         $s4, 0x28($sp)
    /* EDFF0 800FD7F0 2400B38F */  lw         $s3, 0x24($sp)
    /* EDFF4 800FD7F4 2000B28F */  lw         $s2, 0x20($sp)
    /* EDFF8 800FD7F8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EDFFC 800FD7FC 1800B08F */  lw         $s0, 0x18($sp)
    /* EE000 800FD800 0800E003 */  jr         $ra
    /* EE004 800FD804 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel STREAM_cancelrequest
