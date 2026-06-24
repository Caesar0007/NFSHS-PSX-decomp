.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching qsort, 0x150

glabel qsort
    /* D658C 800E5D8C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D6590 800E5D90 2400B5AF */  sw         $s5, 0x24($sp)
    /* D6594 800E5D94 21A8A000 */  addu       $s5, $a1, $zero
    /* D6598 800E5D98 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D659C 800E5D9C 2198C000 */  addu       $s3, $a2, $zero
    /* D65A0 800E5DA0 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* D65A4 800E5DA4 21B8E000 */  addu       $s7, $a3, $zero
    /* D65A8 800E5DA8 2000B4AF */  sw         $s4, 0x20($sp)
    /* D65AC 800E5DAC 21A08000 */  addu       $s4, $a0, $zero
    /* D65B0 800E5DB0 1800B2AF */  sw         $s2, 0x18($sp)
    /* D65B4 800E5DB4 21909302 */  addu       $s2, $s4, $s3
    /* D65B8 800E5DB8 2800B6AF */  sw         $s6, 0x28($sp)
    /* D65BC 800E5DBC 21B00000 */  addu       $s6, $zero, $zero
    /* D65C0 800E5DC0 0200A22E */  sltiu      $v0, $s5, 0x2
    /* D65C4 800E5DC4 3000BFAF */  sw         $ra, 0x30($sp)
    /* D65C8 800E5DC8 1400B1AF */  sw         $s1, 0x14($sp)
    /* D65CC 800E5DCC 38004014 */  bnez       $v0, .L800E5EB0
    /* D65D0 800E5DD0 1000B0AF */   sw        $s0, 0x10($sp)
    /* D65D4 800E5DD4 02000224 */  addiu      $v0, $zero, 0x2
    /* D65D8 800E5DD8 0A00A216 */  bne        $s5, $v0, .L800E5E04
    /* D65DC 800E5DDC 42101500 */   srl       $v0, $s5, 1
    /* D65E0 800E5DE0 09F8E002 */  jalr       $s7
    /* D65E4 800E5DE4 21284002 */   addu      $a1, $s2, $zero
    /* D65E8 800E5DE8 31004018 */  blez       $v0, .L800E5EB0
    /* D65EC 800E5DEC 21208002 */   addu      $a0, $s4, $zero
    /* D65F0 800E5DF0 21284002 */  addu       $a1, $s2, $zero
    /* D65F4 800E5DF4 B797030C */  jal        _swap
    /* D65F8 800E5DF8 21306002 */   addu      $a2, $s3, $zero
    /* D65FC 800E5DFC AC970308 */  j          .L800E5EB0
    /* D6600 800E5E00 00000000 */   nop
  .L800E5E04:
    /* D6604 800E5E04 18005300 */  mult       $v0, $s3
    /* D6608 800E5E08 21208002 */  addu       $a0, $s4, $zero
    /* D660C 800E5E0C 21306002 */  addu       $a2, $s3, $zero
    /* D6610 800E5E10 21888002 */  addu       $s1, $s4, $zero
    /* D6614 800E5E14 01001024 */  addiu      $s0, $zero, 0x1
    /* D6618 800E5E18 12180000 */  mflo       $v1
    /* D661C 800E5E1C B797030C */  jal        _swap
    /* D6620 800E5E20 21288302 */   addu      $a1, $s4, $v1
    /* D6624 800E5E24 2B101502 */  sltu       $v0, $s0, $s5
    /* D6628 800E5E28 11004010 */  beqz       $v0, .L800E5E70
    /* D662C 800E5E2C 00000000 */   nop
  .L800E5E30:
    /* D6630 800E5E30 21204002 */  addu       $a0, $s2, $zero
    /* D6634 800E5E34 09F8E002 */  jalr       $s7
    /* D6638 800E5E38 21288002 */   addu      $a1, $s4, $zero
    /* D663C 800E5E3C 08004104 */  bgez       $v0, .L800E5E60
    /* D6640 800E5E40 00000000 */   nop
    /* D6644 800E5E44 21883302 */  addu       $s1, $s1, $s3
    /* D6648 800E5E48 05005112 */  beq        $s2, $s1, .L800E5E60
    /* D664C 800E5E4C 0100D626 */   addiu     $s6, $s6, 0x1
    /* D6650 800E5E50 21204002 */  addu       $a0, $s2, $zero
    /* D6654 800E5E54 21282002 */  addu       $a1, $s1, $zero
    /* D6658 800E5E58 B797030C */  jal        _swap
    /* D665C 800E5E5C 21306002 */   addu      $a2, $s3, $zero
  .L800E5E60:
    /* D6660 800E5E60 01001026 */  addiu      $s0, $s0, 0x1
    /* D6664 800E5E64 2B101502 */  sltu       $v0, $s0, $s5
    /* D6668 800E5E68 F1FF4014 */  bnez       $v0, .L800E5E30
    /* D666C 800E5E6C 21905302 */   addu      $s2, $s2, $s3
  .L800E5E70:
    /* D6670 800E5E70 04003412 */  beq        $s1, $s4, .L800E5E84
    /* D6674 800E5E74 21208002 */   addu      $a0, $s4, $zero
    /* D6678 800E5E78 21282002 */  addu       $a1, $s1, $zero
    /* D667C 800E5E7C B797030C */  jal        _swap
    /* D6680 800E5E80 21306002 */   addu      $a2, $s3, $zero
  .L800E5E84:
    /* D6684 800E5E84 21208002 */  addu       $a0, $s4, $zero
    /* D6688 800E5E88 2128C002 */  addu       $a1, $s6, $zero
    /* D668C 800E5E8C 21306002 */  addu       $a2, $s3, $zero
    /* D6690 800E5E90 6397030C */  jal        qsort
    /* D6694 800E5E94 2138E002 */   addu      $a3, $s7, $zero
    /* D6698 800E5E98 21203302 */  addu       $a0, $s1, $s3
    /* D669C 800E5E9C 2328B602 */  subu       $a1, $s5, $s6
    /* D66A0 800E5EA0 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* D66A4 800E5EA4 21306002 */  addu       $a2, $s3, $zero
    /* D66A8 800E5EA8 6397030C */  jal        qsort
    /* D66AC 800E5EAC 2138E002 */   addu      $a3, $s7, $zero
  .L800E5EB0:
    /* D66B0 800E5EB0 3000BF8F */  lw         $ra, 0x30($sp)
    /* D66B4 800E5EB4 2C00B78F */  lw         $s7, 0x2C($sp)
    /* D66B8 800E5EB8 2800B68F */  lw         $s6, 0x28($sp)
    /* D66BC 800E5EBC 2400B58F */  lw         $s5, 0x24($sp)
    /* D66C0 800E5EC0 2000B48F */  lw         $s4, 0x20($sp)
    /* D66C4 800E5EC4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D66C8 800E5EC8 1800B28F */  lw         $s2, 0x18($sp)
    /* D66CC 800E5ECC 1400B18F */  lw         $s1, 0x14($sp)
    /* D66D0 800E5ED0 1000B08F */  lw         $s0, 0x10($sp)
    /* D66D4 800E5ED4 0800E003 */  jr         $ra
    /* D66D8 800E5ED8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel qsort
