.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Open, 0x108

glabel CD_Open
    /* EAD54 800FA554 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* EAD58 800FA558 2800B0AF */  sw         $s0, 0x28($sp)
    /* EAD5C 800FA55C 21808000 */  addu       $s0, $a0, $zero
    /* EAD60 800FA560 3400B3AF */  sw         $s3, 0x34($sp)
    /* EAD64 800FA564 2198C000 */  addu       $s3, $a2, $zero
    /* EAD68 800FA568 3000B2AF */  sw         $s2, 0x30($sp)
    /* EAD6C 800FA56C 1800B227 */  addiu      $s2, $sp, 0x18
    /* EAD70 800FA570 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EAD74 800FA574 C46C4224 */  addiu      $v0, $v0, %lo(Cdinfo)
    /* EAD78 800FA578 3800BFAF */  sw         $ra, 0x38($sp)
    /* EAD7C 800FA57C 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* EAD80 800FA580 0400438C */  lw         $v1, 0x4($v0)
    /* EAD84 800FA584 00000000 */  nop
    /* EAD88 800FA588 0C006018 */  blez       $v1, .L800FA5BC
    /* EAD8C 800FA58C 21880000 */   addu      $s1, $zero, $zero
    /* EAD90 800FA590 21206000 */  addu       $a0, $v1, $zero
    /* EAD94 800FA594 3400438C */  lw         $v1, 0x34($v0)
  .L800FA598:
    /* EAD98 800FA598 00000000 */  nop
    /* EAD9C 800FA59C 0000628C */  lw         $v0, 0x0($v1)
    /* EADA0 800FA5A0 00000000 */  nop
    /* EADA4 800FA5A4 05004010 */  beqz       $v0, .L800FA5BC
    /* EADA8 800FA5A8 00000000 */   nop
    /* EADAC 800FA5AC 01003126 */  addiu      $s1, $s1, 0x1
    /* EADB0 800FA5B0 2A102402 */  slt        $v0, $s1, $a0
    /* EADB4 800FA5B4 F8FF4014 */  bnez       $v0, .L800FA598
    /* EADB8 800FA5B8 04006324 */   addiu     $v1, $v1, 0x4
  .L800FA5BC:
    /* EADBC 800FA5BC 00000492 */  lbu        $a0, 0x0($s0)
    /* EADC0 800FA5C0 1F24040C */  jal        toupper
    /* EADC4 800FA5C4 01001026 */   addiu     $s0, $s0, 0x1
    /* EADC8 800FA5C8 000042A2 */  sb         $v0, 0x0($s2)
    /* EADCC 800FA5CC FF004230 */  andi       $v0, $v0, 0xFF
    /* EADD0 800FA5D0 FAFF4014 */  bnez       $v0, .L800FA5BC
    /* EADD4 800FA5D4 01005226 */   addiu     $s2, $s2, 0x1
    /* EADD8 800FA5D8 1800A427 */  addiu      $a0, $sp, 0x18
    /* EADDC 800FA5DC 1080023C */  lui        $v0, %hi(dircompare)
    /* EADE0 800FA5E0 44A34224 */  addiu      $v0, $v0, %lo(dircompare)
    /* EADE4 800FA5E4 1480103C */  lui        $s0, %hi(Cdinfo)
    /* EADE8 800FA5E8 C46C1026 */  addiu      $s0, $s0, %lo(Cdinfo)
    /* EADEC 800FA5EC 1000A2AF */  sw         $v0, 0x10($sp)
    /* EADF0 800FA5F0 3800058E */  lw         $a1, 0x38($s0)
    /* EADF4 800FA5F4 0800068E */  lw         $a2, 0x8($s0)
    /* EADF8 800FA5F8 7724040C */  jal        bsearch
    /* EADFC 800FA5FC 14000724 */   addiu     $a3, $zero, 0x14
    /* EAE00 800FA600 3400038E */  lw         $v1, 0x34($s0)
    /* EAE04 800FA604 80201100 */  sll        $a0, $s1, 2
    /* EAE08 800FA608 21188300 */  addu       $v1, $a0, $v1
    /* EAE0C 800FA60C 000062AC */  sw         $v0, 0x0($v1)
    /* EAE10 800FA610 3400028E */  lw         $v0, 0x34($s0)
    /* EAE14 800FA614 00000000 */  nop
    /* EAE18 800FA618 21208200 */  addu       $a0, $a0, $v0
    /* EAE1C 800FA61C 0000828C */  lw         $v0, 0x0($a0)
    /* EAE20 800FA620 00000000 */  nop
    /* EAE24 800FA624 04004010 */  beqz       $v0, .L800FA638
    /* EAE28 800FA628 01002226 */   addiu     $v0, $s1, 0x1
    /* EAE2C 800FA62C 000062AE */  sw         $v0, 0x0($s3)
    /* EAE30 800FA630 90E90308 */  j          .L800FA640
    /* EAE34 800FA634 01000224 */   addiu     $v0, $zero, 0x1
  .L800FA638:
    /* EAE38 800FA638 000060AE */  sw         $zero, 0x0($s3)
    /* EAE3C 800FA63C 21100000 */  addu       $v0, $zero, $zero
  .L800FA640:
    /* EAE40 800FA640 3800BF8F */  lw         $ra, 0x38($sp)
    /* EAE44 800FA644 3400B38F */  lw         $s3, 0x34($sp)
    /* EAE48 800FA648 3000B28F */  lw         $s2, 0x30($sp)
    /* EAE4C 800FA64C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* EAE50 800FA650 2800B08F */  lw         $s0, 0x28($sp)
    /* EAE54 800FA654 0800E003 */  jr         $ra
    /* EAE58 800FA658 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CD_Open
