.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDgettag, 0x130

glabel iSNDgettag
    /* FC550 8010BD50 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* FC554 8010BD54 1400B1AF */  sw         $s1, 0x14($sp)
    /* FC558 8010BD58 21888000 */  addu       $s1, $a0, $zero
    /* FC55C 8010BD5C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FC560 8010BD60 2198C000 */  addu       $s3, $a2, $zero
    /* FC564 8010BD64 2000BFAF */  sw         $ra, 0x20($sp)
    /* FC568 8010BD68 1800B2AF */  sw         $s2, 0x18($sp)
    /* FC56C 8010BD6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* FC570 8010BD70 0000248E */  lw         $a0, 0x0($s1)
    /* FC574 8010BD74 00000000 */  nop
    /* FC578 8010BD78 00008390 */  lbu        $v1, 0x0($a0)
    /* FC57C 8010BD7C FC000224 */  addiu      $v0, $zero, 0xFC
    /* FC580 8010BD80 09006214 */  bne        $v1, $v0, .L8010BDA8
    /* FC584 8010BD84 2190E000 */   addu      $s2, $a3, $zero
    /* FC588 8010BD88 21304000 */  addu       $a2, $v0, $zero
  .L8010BD8C:
    /* FC58C 8010BD8C 01008224 */  addiu      $v0, $a0, 0x1
    /* FC590 8010BD90 21188000 */  addu       $v1, $a0, $zero
    /* FC594 8010BD94 000022AE */  sw         $v0, 0x0($s1)
    /* FC598 8010BD98 01006390 */  lbu        $v1, 0x1($v1)
    /* FC59C 8010BD9C 00000000 */  nop
    /* FC5A0 8010BDA0 FAFF6610 */  beq        $v1, $a2, .L8010BD8C
    /* FC5A4 8010BDA4 21204000 */   addu      $a0, $v0, $zero
  .L8010BDA8:
    /* FC5A8 8010BDA8 0000228E */  lw         $v0, 0x0($s1)
    /* FC5AC 8010BDAC 00000000 */  nop
    /* FC5B0 8010BDB0 00004290 */  lbu        $v0, 0x0($v0)
    /* FC5B4 8010BDB4 FF000324 */  addiu      $v1, $zero, 0xFF
    /* FC5B8 8010BDB8 03004314 */  bne        $v0, $v1, .L8010BDC8
    /* FC5BC 8010BDBC 0000A2AC */   sw        $v0, 0x0($a1)
    /* FC5C0 8010BDC0 992F0408 */  j          .L8010BE64
    /* FC5C4 8010BDC4 21100000 */   addu      $v0, $zero, $zero
  .L8010BDC8:
    /* FC5C8 8010BDC8 0000248E */  lw         $a0, 0x0($s1)
    /* FC5CC 8010BDCC 00000000 */  nop
    /* FC5D0 8010BDD0 01008224 */  addiu      $v0, $a0, 0x1
    /* FC5D4 8010BDD4 000022AE */  sw         $v0, 0x0($s1)
    /* FC5D8 8010BDD8 0000A58C */  lw         $a1, 0x0($a1)
    /* FC5DC 8010BDDC FD000224 */  addiu      $v0, $zero, 0xFD
    /* FC5E0 8010BDE0 0300A210 */  beq        $a1, $v0, .L8010BDF0
    /* FC5E4 8010BDE4 FE000224 */   addiu     $v0, $zero, 0xFE
    /* FC5E8 8010BDE8 0300A214 */  bne        $a1, $v0, .L8010BDF8
    /* FC5EC 8010BDEC 00000000 */   nop
  .L8010BDF0:
    /* FC5F0 8010BDF0 992F0408 */  j          .L8010BE64
    /* FC5F4 8010BDF4 01000224 */   addiu     $v0, $zero, 0x1
  .L8010BDF8:
    /* FC5F8 8010BDF8 01009090 */  lbu        $s0, 0x1($a0)
    /* FC5FC 8010BDFC 00000000 */  nop
    /* FC600 8010BE00 08000316 */  bne        $s0, $v1, .L8010BE24
    /* FC604 8010BE04 02008424 */   addiu     $a0, $a0, 0x2
    /* FC608 8010BE08 04000524 */  addiu      $a1, $zero, 0x4
    /* FC60C 8010BE0C 4A32040C */  jal        iSNDgetdata
    /* FC610 8010BE10 000024AE */   sw        $a0, 0x0($s1)
    /* FC614 8010BE14 0000238E */  lw         $v1, 0x0($s1)
    /* FC618 8010BE18 21804000 */  addu       $s0, $v0, $zero
    /* FC61C 8010BE1C 03006324 */  addiu      $v1, $v1, 0x3
    /* FC620 8010BE20 000023AE */  sw         $v1, 0x0($s1)
  .L8010BE24:
    /* FC624 8010BE24 0000228E */  lw         $v0, 0x0($s1)
    /* FC628 8010BE28 00000000 */  nop
    /* FC62C 8010BE2C 01004224 */  addiu      $v0, $v0, 0x1
    /* FC630 8010BE30 000022AE */  sw         $v0, 0x0($s1)
    /* FC634 8010BE34 000042AE */  sw         $v0, 0x0($s2)
    /* FC638 8010BE38 0500022E */  sltiu      $v0, $s0, 0x5
    /* FC63C 8010BE3C 05004010 */  beqz       $v0, .L8010BE54
    /* FC640 8010BE40 00000000 */   nop
    /* FC644 8010BE44 0000248E */  lw         $a0, 0x0($s1)
    /* FC648 8010BE48 4A32040C */  jal        iSNDgetdata
    /* FC64C 8010BE4C 21280002 */   addu      $a1, $s0, $zero
    /* FC650 8010BE50 000062AE */  sw         $v0, 0x0($s3)
  .L8010BE54:
    /* FC654 8010BE54 0000238E */  lw         $v1, 0x0($s1)
    /* FC658 8010BE58 01000224 */  addiu      $v0, $zero, 0x1
    /* FC65C 8010BE5C 21187000 */  addu       $v1, $v1, $s0
    /* FC660 8010BE60 000023AE */  sw         $v1, 0x0($s1)
  .L8010BE64:
    /* FC664 8010BE64 2000BF8F */  lw         $ra, 0x20($sp)
    /* FC668 8010BE68 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FC66C 8010BE6C 1800B28F */  lw         $s2, 0x18($sp)
    /* FC670 8010BE70 1400B18F */  lw         $s1, 0x14($sp)
    /* FC674 8010BE74 1000B08F */  lw         $s0, 0x10($sp)
    /* FC678 8010BE78 0800E003 */  jr         $ra
    /* FC67C 8010BE7C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSNDgettag
