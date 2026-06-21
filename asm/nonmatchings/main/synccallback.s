.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching synccallback, 0x11C

glabel synccallback
    /* DAECC 800EA6CC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DAED0 800EA6D0 1800B0AF */  sw         $s0, 0x18($sp)
    /* DAED4 800EA6D4 2180A000 */  addu       $s0, $a1, $zero
    /* DAED8 800EA6D8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* DAEDC 800EA6DC 2188C000 */  addu       $s1, $a2, $zero
    /* DAEE0 800EA6E0 2400BFAF */  sw         $ra, 0x24($sp)
    /* DAEE4 800EA6E4 ACB0030C */  jal        FILE_completeop
    /* DAEE8 800EA6E8 2000B2AF */   sw        $s2, 0x20($sp)
    /* DAEEC 800EA6EC 21902002 */  addu       $s2, $s1, $zero
    /* DAEF0 800EA6F0 21204000 */  addu       $a0, $v0, $zero
    /* DAEF4 800EA6F4 01000224 */  addiu      $v0, $zero, 0x1
    /* DAEF8 800EA6F8 34000216 */  bne        $s0, $v0, .L800EA7CC
    /* DAEFC 800EA6FC 200020AE */   sw        $zero, 0x20($s1)
    /* DAF00 800EA700 0800228E */  lw         $v0, 0x8($s1)
    /* DAF04 800EA704 00000000 */  nop
    /* DAF08 800EA708 21104400 */  addu       $v0, $v0, $a0
    /* DAF0C 800EA70C 080022AE */  sw         $v0, 0x8($s1)
    /* DAF10 800EA710 1000228E */  lw         $v0, 0x10($s1)
    /* DAF14 800EA714 00000000 */  nop
    /* DAF18 800EA718 21104400 */  addu       $v0, $v0, $a0
    /* DAF1C 800EA71C 100022AE */  sw         $v0, 0x10($s1)
    /* DAF20 800EA720 1800228E */  lw         $v0, 0x18($s1)
    /* DAF24 800EA724 1400238E */  lw         $v1, 0x14($s1)
    /* DAF28 800EA728 21104400 */  addu       $v0, $v0, $a0
    /* DAF2C 800EA72C 2A188300 */  slt        $v1, $a0, $v1
    /* DAF30 800EA730 04006010 */  beqz       $v1, .L800EA744
    /* DAF34 800EA734 180022AE */   sw        $v0, 0x18($s1)
    /* DAF38 800EA738 0C0020AE */  sw         $zero, 0xC($s1)
    /* DAF3C 800EA73C D5A90308 */  j          .L800EA754
    /* DAF40 800EA740 00000000 */   nop
  .L800EA744:
    /* DAF44 800EA744 0C00228E */  lw         $v0, 0xC($s1)
    /* DAF48 800EA748 00000000 */  nop
    /* DAF4C 800EA74C 23104400 */  subu       $v0, $v0, $a0
    /* DAF50 800EA750 0C0022AE */  sw         $v0, 0xC($s1)
  .L800EA754:
    /* DAF54 800EA754 0C00428E */  lw         $v0, 0xC($s2)
    /* DAF58 800EA758 00000000 */  nop
    /* DAF5C 800EA75C 1C004018 */  blez       $v0, .L800EA7D0
    /* DAF60 800EA760 00000000 */   nop
    /* DAF64 800EA764 0C00428E */  lw         $v0, 0xC($s2)
    /* DAF68 800EA768 00000000 */  nop
    /* DAF6C 800EA76C 01204228 */  slti       $v0, $v0, 0x2001
    /* DAF70 800EA770 02004010 */  beqz       $v0, .L800EA77C
    /* DAF74 800EA774 00200224 */   addiu     $v0, $zero, 0x2000
    /* DAF78 800EA778 0C00428E */  lw         $v0, 0xC($s2)
  .L800EA77C:
    /* DAF7C 800EA77C 00000000 */  nop
    /* DAF80 800EA780 140042AE */  sw         $v0, 0x14($s2)
    /* DAF84 800EA784 0000428E */  lw         $v0, 0x0($s2)
    /* DAF88 800EA788 1400B2AF */  sw         $s2, 0x14($sp)
    /* DAF8C 800EA78C 1000A2AF */  sw         $v0, 0x10($sp)
    /* DAF90 800EA790 0400448E */  lw         $a0, 0x4($s2)
    /* DAF94 800EA794 0800458E */  lw         $a1, 0x8($s2)
    /* DAF98 800EA798 1C00428E */  lw         $v0, 0x1C($s2)
    /* DAF9C 800EA79C 1800468E */  lw         $a2, 0x18($s2)
    /* DAFA0 800EA7A0 1400478E */  lw         $a3, 0x14($s2)
    /* DAFA4 800EA7A4 09F84000 */  jalr       $v0
    /* DAFA8 800EA7A8 00000000 */   nop
    /* DAFAC 800EA7AC 07004010 */  beqz       $v0, .L800EA7CC
    /* DAFB0 800EA7B0 200042AE */   sw        $v0, 0x20($s2)
    /* DAFB4 800EA7B4 21204000 */  addu       $a0, $v0, $zero
    /* DAFB8 800EA7B8 0F80053C */  lui        $a1, %hi(synccallback)
    /* DAFBC 800EA7BC 93AF030C */  jal        FILE_callbackop
    /* DAFC0 800EA7C0 CCA6A524 */   addiu     $a1, $a1, %lo(synccallback)
    /* DAFC4 800EA7C4 F4A90308 */  j          .L800EA7D0
    /* DAFC8 800EA7C8 00000000 */   nop
  .L800EA7CC:
    /* DAFCC 800EA7CC 0C0040AE */  sw         $zero, 0xC($s2)
  .L800EA7D0:
    /* DAFD0 800EA7D0 2400BF8F */  lw         $ra, 0x24($sp)
    /* DAFD4 800EA7D4 2000B28F */  lw         $s2, 0x20($sp)
    /* DAFD8 800EA7D8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* DAFDC 800EA7DC 1800B08F */  lw         $s0, 0x18($sp)
    /* DAFE0 800EA7E0 0800E003 */  jr         $ra
    /* DAFE4 800EA7E4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel synccallback
