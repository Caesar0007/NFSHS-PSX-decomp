.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDdmqueuesplit, 0xD8

glabel iSNDdmqueuesplit
    /* FB594 8010AD94 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* FB598 8010AD98 2000B2AF */  sw         $s2, 0x20($sp)
    /* FB59C 8010AD9C 21908000 */  addu       $s2, $a0, $zero
    /* FB5A0 8010ADA0 2400B3AF */  sw         $s3, 0x24($sp)
    /* FB5A4 8010ADA4 2198A000 */  addu       $s3, $a1, $zero
    /* FB5A8 8010ADA8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* FB5AC 8010ADAC 2188C000 */  addu       $s1, $a2, $zero
    /* FB5B0 8010ADB0 3000B6AF */  sw         $s6, 0x30($sp)
    /* FB5B4 8010ADB4 21B0E000 */  addu       $s6, $a3, $zero
    /* FB5B8 8010ADB8 21100000 */  addu       $v0, $zero, $zero
    /* FB5BC 8010ADBC 3400BFAF */  sw         $ra, 0x34($sp)
    /* FB5C0 8010ADC0 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* FB5C4 8010ADC4 2800B4AF */  sw         $s4, 0x28($sp)
    /* FB5C8 8010ADC8 1E00201A */  blez       $s1, .L8010AE44
    /* FB5CC 8010ADCC 1800B0AF */   sw        $s0, 0x18($sp)
    /* FB5D0 8010ADD0 1480023C */  lui        $v0, %hi(sndpd)
    /* FB5D4 8010ADD4 18795524 */  addiu      $s5, $v0, %lo(sndpd)
    /* FB5D8 8010ADD8 0A001424 */  addiu      $s4, $zero, 0xA
  .L8010ADDC:
    /* FB5DC 8010ADDC 00101024 */  addiu      $s0, $zero, 0x1000
    /* FB5E0 8010ADE0 2A103002 */  slt        $v0, $s1, $s0
    /* FB5E4 8010ADE4 02004010 */  beqz       $v0, .L8010ADF0
    /* FB5E8 8010ADE8 00000000 */   nop
    /* FB5EC 8010ADEC 21802002 */  addu       $s0, $s1, $zero
  .L8010ADF0:
    /* FB5F0 8010ADF0 0C00A292 */  lbu        $v0, 0xC($s5)
    /* FB5F4 8010ADF4 00000000 */  nop
    /* FB5F8 8010ADF8 00160200 */  sll        $v0, $v0, 24
    /* FB5FC 8010ADFC 03160200 */  sra        $v0, $v0, 24
    /* FB600 8010AE00 23108202 */  subu       $v0, $s4, $v0
    /* FB604 8010AE04 07004228 */  slti       $v0, $v0, 0x7
    /* FB608 8010AE08 05004010 */  beqz       $v0, .L8010AE20
    /* FB60C 8010AE0C 21204002 */   addu      $a0, $s2, $zero
    /* FB610 8010AE10 082B040C */  jal        iSNDdmservice
    /* FB614 8010AE14 00000000 */   nop
    /* FB618 8010AE18 7C2B0408 */  j          .L8010ADF0
    /* FB61C 8010AE1C 00000000 */   nop
  .L8010AE20:
    /* FB620 8010AE20 1000A0AF */  sw         $zero, 0x10($sp)
    /* FB624 8010AE24 21286002 */  addu       $a1, $s3, $zero
    /* FB628 8010AE28 21300002 */  addu       $a2, $s0, $zero
    /* FB62C 8010AE2C 282B040C */  jal        iSNDdmqueue
    /* FB630 8010AE30 2138C002 */   addu      $a3, $s6, $zero
    /* FB634 8010AE34 21905002 */  addu       $s2, $s2, $s0
    /* FB638 8010AE38 23883002 */  subu       $s1, $s1, $s0
    /* FB63C 8010AE3C E7FF201E */  bgtz       $s1, .L8010ADDC
    /* FB640 8010AE40 21987002 */   addu      $s3, $s3, $s0
  .L8010AE44:
    /* FB644 8010AE44 3400BF8F */  lw         $ra, 0x34($sp)
    /* FB648 8010AE48 3000B68F */  lw         $s6, 0x30($sp)
    /* FB64C 8010AE4C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* FB650 8010AE50 2800B48F */  lw         $s4, 0x28($sp)
    /* FB654 8010AE54 2400B38F */  lw         $s3, 0x24($sp)
    /* FB658 8010AE58 2000B28F */  lw         $s2, 0x20($sp)
    /* FB65C 8010AE5C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* FB660 8010AE60 1800B08F */  lw         $s0, 0x18($sp)
    /* FB664 8010AE64 0800E003 */  jr         $ra
    /* FB668 8010AE68 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSNDdmqueuesplit
